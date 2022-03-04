Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20924CCDB3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 07:28:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238375AbiCDG3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 01:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232071AbiCDG3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 01:29:11 -0500
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85324A94FB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 22:28:21 -0800 (PST)
X-QQ-mid: bizesmtp88t1646375284t6hkac1h
Received: from localhost.localdomain ( [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 04 Mar 2022 14:28:00 +0800 (CST)
X-QQ-SSF: 0140000000200060D000B00A0000000
X-QQ-FEAT: ec8fk5hwdl7lFPnUj7yMxNNeEAsAECkd2tcce7oPDG2vXjcuuzYCmoQ8NWjmh
        EYRKQymFqS7+cnFjnOg3PUYObVMpPmFRnthu6ZVJ0WJQF5BA/1tfbAVDobHUa7pkB3zwLMx
        y5rII46OjZcVRx1ul4/nwRH3lWmAxNBg7fYoZunvvQ5l126mEknGP6JyMfHPX9CN9YN8Uk7
        UAi7UnzsjyXZ8CzcFMg1AZ6+4FHyeySvQqntH42nANjb9tYW6PDcEse6DdUORn8MNQ/rbaj
        Sia7cE0qQ4rJWMcYcrZh/neiHL9Jb3yziwgV2R4FbNt3nbimZgUnzLoJxdEEv4HYxv5mwcS
        +wzNDMy+fQ4H/2j5cMShzBQjsGhYw==
X-QQ-GoodBg: 2
From:   Zhen Ni <nizhen@uniontech.com>
To:     oder_chiou@realtek.com, broonie@kernel.org, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Zhen Ni <nizhen@uniontech.com>
Subject: [PATCH] ASoC: rt5665: Don't block workqueue if card is unbound
Date:   Fri,  4 Mar 2022 14:27:58 +0800
Message-Id: <20220304062758.9701-1-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign1
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current rt5665_jack_detect_handler() assumes the component
and card will always show up and implements an infinite usleep
loop waiting for them to show up.

This does not hold true if a codec interrupt (or other
event) occurs when the card is unbound. The codec driver's
remove  or shutdown functions cannot cancel the workqueue due
to the wait loop. As a result, code can either end up blocking
the workqueue, or hit a kernel oops when the card is freed.

Fix the issue by rescheduling the jack detect handler in
case the card is not ready. In case card never shows up,
the shutdown/remove/suspend calls can now cancel the detect
task.

Signed-off-by: Zhen Ni <nizhen@uniontech.com>
---
 sound/soc/codecs/rt5665.c | 20 +++++++-------------
 1 file changed, 7 insertions(+), 13 deletions(-)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 33e889802ff8..cdfd7085df2a 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -1293,19 +1293,13 @@ static void rt5665_jack_detect_handler(struct work_struct *work)
 		container_of(work, struct rt5665_priv, jack_detect_work.work);
 	int val, btn_type;
 
-	while (!rt5665->component) {
-		pr_debug("%s codec = null\n", __func__);
-		usleep_range(10000, 15000);
-	}
-
-	while (!rt5665->component->card->instantiated) {
-		pr_debug("%s\n", __func__);
-		usleep_range(10000, 15000);
-	}
-
-	while (!rt5665->calibration_done) {
-		pr_debug("%s calibration not ready\n", __func__);
-		usleep_range(10000, 15000);
+	if (!rt5665->component || !rt5665->component->card->instantiated ||
+			!rt5665->calibration_done) {
+		pr_debug("%s card not yet ready\n", __func__);
+		/* try later */
+		mod_delayed_work(system_power_efficient_wq,
+				&rt5665->jack_detect_work, msecs_to_jiffies(15));
+		return;
 	}
 
 	mutex_lock(&rt5665->calibrate_mutex);
-- 
2.20.1



