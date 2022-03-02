Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B564C9EFD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240029AbiCBIQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:16:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiCBIQM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:16:12 -0500
Received: from smtpproxy21.qq.com (smtpbg701.qq.com [203.205.195.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A480B716E
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 00:15:29 -0800 (PST)
X-QQ-mid: bizesmtp77t1646208909tozdlr7p
Received: from localhost.localdomain (unknown [58.240.82.166])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 02 Mar 2022 16:15:04 +0800 (CST)
X-QQ-SSF: 0140000000200060D000B00A0000000
X-QQ-FEAT: 5MyhjOca6cU9yUHIx9no9FannyNiVghnXH98EgzPBbBOKRtYKGMkPzrxP6ZcP
        SfPZp5NObV+KqN/0JwIfl/Shg3ay3rpsjTqRMbdyT1839CS/uvOzRyZJI9wHHhPvFPWrBPL
        U31gkgtSJUxKsHEWOFuBgxtXzpCXay5/qIB0oSbTrxoZj8FDKGaJOO7iU5N3M0WUJEihT0+
        /sOpEzyeCJHI6PV2NKWwCmWm74aU5RgYWBOzr94xzWt6oQKA2RdkkGLvPNI4VXQrkMlEKFy
        xSpL+MRvgKiP1lFAYX1xXCcpNdPBdqWOlnM2Rgs8+17MW6hdcU97KK/RTRqBfIa0q4sLc47
        VvXuG5M1B5nOHOMHqCJeTYXduLYsS/fzbfmY9lY
X-QQ-GoodBg: 2
From:   Zhen Ni <nizhen@uniontech.com>
To:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Zhen Ni <nizhen@uniontech.com>
Subject: [PATCH] ASoC: amd: use asoc_substream_to_rtd()
Date:   Wed,  2 Mar 2022 16:15:02 +0800
Message-Id: <20220302081502.25367-1-nizhen@uniontech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybgforeign:qybgforeign6
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Uses asoc_substream_to_rtd() helper.

Signed-off-by: Zhen Ni <nizhen@uniontech.com>
---
 sound/soc/amd/vangogh/acp5x-mach.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/amd/vangogh/acp5x-mach.c b/sound/soc/amd/vangogh/acp5x-mach.c
index 14cf325e4b23..f2c32e5ed24f 100644
--- a/sound/soc/amd/vangogh/acp5x-mach.c
+++ b/sound/soc/amd/vangogh/acp5x-mach.c
@@ -101,7 +101,7 @@ static const struct snd_pcm_hw_constraint_list constraints_channels = {
 static int acp5x_8821_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct snd_soc_card *card = rtd->card;
 	struct acp5x_platform_info *machine = snd_soc_card_get_drvdata(card);
 
@@ -119,7 +119,7 @@ static int acp5x_8821_startup(struct snd_pcm_substream *substream)
 static int acp5x_nau8821_hw_params(struct snd_pcm_substream *substream,
 				   struct snd_pcm_hw_params *params)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct snd_soc_card *card = rtd->card;
 	struct snd_soc_dai *codec_dai =
 			snd_soc_card_get_codec_dai(card,
@@ -141,7 +141,7 @@ static int acp5x_nau8821_hw_params(struct snd_pcm_substream *substream,
 static int acp5x_cs35l41_startup(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct snd_soc_card *card = rtd->card;
 	struct acp5x_platform_info *machine = snd_soc_card_get_drvdata(card);
 
@@ -158,7 +158,7 @@ static int acp5x_cs35l41_startup(struct snd_pcm_substream *substream)
 static int acp5x_cs35l41_hw_params(struct snd_pcm_substream *substream,
 				   struct snd_pcm_hw_params *params)
 {
-	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
 	struct snd_soc_card *card = rtd->card;
 	struct snd_soc_dai *codec_dai;
 	int ret, i;
-- 
2.20.1



