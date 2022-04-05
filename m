Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 536EA4F4856
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380644AbiDEVhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1572884AbiDERO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 13:14:27 -0400
Received: from 2.mo561.mail-out.ovh.net (2.mo561.mail-out.ovh.net [46.105.75.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD23432989
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 10:12:26 -0700 (PDT)
Received: from player762.ha.ovh.net (unknown [10.108.1.112])
        by mo561.mail-out.ovh.net (Postfix) with ESMTP id 10F4F23A6E
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 17:12:25 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player762.ha.ovh.net (Postfix) with ESMTPSA id 61C2F29206EEE;
        Tue,  5 Apr 2022 17:12:21 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-97G002ee460736-7180-41c2-ae20-0f3875438c60,
                    8AF55017BACD44284FC599BC4826E0280D36FCC4) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH] ASoC: rt1016: enable building
Date:   Tue,  5 Apr 2022 19:11:58 +0200
Message-Id: <20220405171158.2168762-1-steve@sk2.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 8680688283019937414
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvvddrudejgedguddtiecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepufhtvghphhgvnhcumfhithhtuceoshhtvghvvgesshhkvddrohhrgheqnecuggftrfgrthhtvghrnhepteegudfgleekieekteeggeetveefueefteeugfduieeitdfhhedtfeefkedvfeefnecukfhppedtrddtrddtrddtpdekvddrieehrddvhedrvddtudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhhouggvpehsmhhtphhouhhtpdhhvghlohepphhlrgihvghrjeeivddrhhgrrdhovhhhrdhnvghtpdhinhgvtheptddrtddrtddrtddpmhgrihhlfhhrohhmpehsthgvvhgvsehskhdvrdhorhhgpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The rt1016 driver wasn't listed in Kconfig and Makefile, which AFAICT
means it isn't ever built. This patch adds the appropriate entries to
Kconfig and Makefile.

Signed-off-by: Stephen Kitt <steve@sk2.org>
---
 sound/soc/codecs/Kconfig  | 5 +++++
 sound/soc/codecs/Makefile | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index f46a22660103..986aec12d5e4 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -168,6 +168,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_RT1011
 	imply SND_SOC_RT1015
 	imply SND_SOC_RT1015P
+	imply SND_SOC_RT1016
 	imply SND_SOC_RT1019
 	imply SND_SOC_RT1305
 	imply SND_SOC_RT1308
@@ -1215,6 +1216,10 @@ config SND_SOC_RT1015P
 	tristate
 	depends on GPIOLIB
 
+config SND_SOC_RT1016
+	tristate
+	depends on I2C
+
 config SND_SOC_RT1019
 	tristate
 	depends on I2C
diff --git a/sound/soc/codecs/Makefile b/sound/soc/codecs/Makefile
index 8637e9e869e3..a955cd5a8cff 100644
--- a/sound/soc/codecs/Makefile
+++ b/sound/soc/codecs/Makefile
@@ -181,6 +181,7 @@ snd-soc-rl6347a-objs := rl6347a.o
 snd-soc-rt1011-objs := rt1011.o
 snd-soc-rt1015-objs := rt1015.o
 snd-soc-rt1015p-objs := rt1015p.o
+snd-soc-rt1016-objs := rt1016.o
 snd-soc-rt1019-objs := rt1019.o
 snd-soc-rt1305-objs := rt1305.o
 snd-soc-rt1308-objs := rt1308.o
@@ -520,6 +521,7 @@ obj-$(CONFIG_SND_SOC_RL6347A)	+= snd-soc-rl6347a.o
 obj-$(CONFIG_SND_SOC_RT1011)	+= snd-soc-rt1011.o
 obj-$(CONFIG_SND_SOC_RT1015)	+= snd-soc-rt1015.o
 obj-$(CONFIG_SND_SOC_RT1015P)	+= snd-soc-rt1015p.o
+obj-$(CONFIG_SND_SOC_RT1016)	+= snd-soc-rt1016.o
 obj-$(CONFIG_SND_SOC_RT1019)	+= snd-soc-rt1019.o
 obj-$(CONFIG_SND_SOC_RT1305)	+= snd-soc-rt1305.o
 obj-$(CONFIG_SND_SOC_RT1308)	+= snd-soc-rt1308.o
-- 
2.27.0

