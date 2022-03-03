Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EBB54CC562
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 19:44:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235803AbiCCSpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 13:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229943AbiCCSpO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 13:45:14 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29A4817AED6
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 10:44:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6A4BDB81E67
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 18:44:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66B57C004E1;
        Thu,  3 Mar 2022 18:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646333065;
        bh=3O+xj138CKdSRUjGT/Vt82Xrl+Z2mQQ8p+Q3rCPCPbQ=;
        h=From:To:Cc:Subject:Date:From;
        b=BfUHnONYl3vtbDnVUTjjryKV4FphJ1R8XnmmZNdDzDZm1R44ZTNl8qHI5z7iuBhX2
         5ievjiz0wLG+6qyX0aZLRlasloKj9nHdgdHSWvaPoDrVF2F905TQ3+bPJq89QAyw86
         +fjnbUpDpOKlqLi37JbZB4jYs+IGG/ydVxV8rE8VrJG4Qfdxk9X9jIBUP8JojXGFF/
         fuGZXY1x4gggZk4RkkGb2W38+kVZMT6JQ/XaiVmozAUqLaKpRD7HHmcaizvaeWZyzj
         dj+6xRAVZXFflJRnqXiZ5lnGvOmaCVVDuezxp7y0DGc91Kyb33U3/Aqxpp03nOSqfc
         F3voKhLEp+Esg==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, patches@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH -next] clocksource/drivers/imx-tpm: Move tpm_read_sched_clock() under CONFIG_ARM
Date:   Thu,  3 Mar 2022 11:42:12 -0700
Message-Id: <20220303184212.2356245-1-nathan@kernel.org>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building this driver for an architecture other than ARCH=arm:

  drivers/clocksource/timer-imx-tpm.c:78:20: error: unused function 'tpm_read_sched_clock' [-Werror,-Wunused-function]
  static u64 notrace tpm_read_sched_clock(void)
                     ^
  1 error generated.

Move the function definition under the existing CONFIG_ARM section so
there is no more warning.

Fixes: 10720e120e2b ("clocksource/drivers/imx-tpm: Exclude sched clock for ARM64")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 drivers/clocksource/timer-imx-tpm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-imx-tpm.c b/drivers/clocksource/timer-imx-tpm.c
index 60cefc247b71..bd64a8a8427f 100644
--- a/drivers/clocksource/timer-imx-tpm.c
+++ b/drivers/clocksource/timer-imx-tpm.c
@@ -73,12 +73,12 @@ static unsigned long tpm_read_current_timer(void)
 {
 	return tpm_read_counter();
 }
-#endif
 
 static u64 notrace tpm_read_sched_clock(void)
 {
 	return tpm_read_counter();
 }
+#endif
 
 static int tpm_set_next_event(unsigned long delta,
 				struct clock_event_device *evt)

base-commit: b22a1c270f533e30bc5d5d4cab6199a2cbb07b07
-- 
2.35.1

