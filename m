Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930474C6252
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 06:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiB1FDz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 00:03:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiB1FDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 00:03:50 -0500
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF97EDFDD
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 21:03:08 -0800 (PST)
X-QQ-mid: bizesmtp89t1646024581to4er8do
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 28 Feb 2022 13:02:54 +0800 (CST)
X-QQ-SSF: 01400000002000C0F000B00A0000000
X-QQ-FEAT: QyOv+T7lL607yB/RoMZHCyCDkKlK60Qk9XFhA859T+zC67fKLL3IRQ/qdRbFK
        BqjgscymxqgKNd0xK4Wu7TS2DFt0kHraYtYn9Ex9MClt6goyTV2NCD2peFCruhfsw67tfD7
        UIVOUvLpDGzh5hH0yPeufX9ThUJ95TDFumsCr4Sp1yZS9skaswi19ezZ/fvJ6MsbHtdRYB1
        PvAqKchIvgQytScx9NmhknPh6jgj2L7bBdCuQAbpWsLYeXTUx0NGAqC+ZNtD5hEXZfgwKCz
        dajCY1bROsEm4Z1Wnwfa1NN30aeewKKxZG/M26Di17BMEFjJgyBhNA5CZv3iyFLim0RWmTd
        h7XazZWQGEQFHs7MP1/wYix7+0JPqQc7YOU9Mu1th8YYau72LI=
X-QQ-GoodBg: 2
From:   Meng Tang <tangmeng@uniontech.com>
To:     perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Meng Tang <tangmeng@uniontech.com>,
        Joe Perches <joe@perches.com>
Subject: [PATCH v4 1/2] ALSA: core: remove initialise static variables to 0
Date:   Mon, 28 Feb 2022 13:02:52 +0800
Message-Id: <20220228050253.1649-1-tangmeng@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign5
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Initializing the static variable to 0 causes the following error
when exec checkpatch:

ERROR: do not initialise statics to 0
FILE: sound/sound_core.c:142:
static int preclaim_oss = 0;

In addition, considering the following way of writing
139: #ifdef config_sound_oss_core_preclaim
140: Static int preclaim_oss = 1;
141: #ELSE
142: Static int preclaim_oss = 0;
143: #ENDIF
We can optimize it by IS_ENABLED(CONFIG_SOUND_OSS_CORE_PRECLAIM),
so modified it to
static int preclaim_oss = IS_ENABLED(CONFIG_SOUND_OSS_CORE_PRECLAIM);

Signed-off-by: Meng Tang <tangmeng@uniontech.com>
Signed-off-by: Joe Perches <joe@perches.com>
---
 sound/sound_core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/sound_core.c b/sound/sound_core.c
index 90d118cd9164..aa4a57e488e5 100644
--- a/sound/sound_core.c
+++ b/sound/sound_core.c
@@ -136,11 +136,7 @@ struct sound_unit
  * All these clutters are scheduled to be removed along with
  * sound-slot/service-* module aliases.
  */
-#ifdef CONFIG_SOUND_OSS_CORE_PRECLAIM
-static int preclaim_oss = 1;
-#else
-static int preclaim_oss = 0;
-#endif
+static int preclaim_oss = IS_ENABLED(CONFIG_SOUND_OSS_CORE_PRECLAIM);
 
 module_param(preclaim_oss, int, 0444);
 
-- 
2.20.1



