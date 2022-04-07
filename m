Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 077C54F77E2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 09:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242034AbiDGHnt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 03:43:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242037AbiDGHnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 03:43:42 -0400
Received: from out30-56.freemail.mail.aliyun.com (out30-56.freemail.mail.aliyun.com [115.124.30.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D348E289B0
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 00:41:42 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R671e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V9Pebyx_1649317293;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0V9Pebyx_1649317293)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 07 Apr 2022 15:41:39 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] ASoC: max98088: clean up some inconsistent indenting
Date:   Thu,  7 Apr 2022 15:41:31 +0800
Message-Id: <20220407074131.44217-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eliminate the follow smatch warning:

sound/soc/codecs/max98088.c:1112 max98088_dai_set_sysclk() warn:
inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 sound/soc/codecs/max98088.c | 56 ++++++++++++++++++-------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/sound/soc/codecs/max98088.c b/sound/soc/codecs/max98088.c
index 429717d4ac5a..bc03ecd749f9 100644
--- a/sound/soc/codecs/max98088.c
+++ b/sound/soc/codecs/max98088.c
@@ -1102,44 +1102,44 @@ static int max98088_dai2_hw_params(struct snd_pcm_substream *substream,
 static int max98088_dai_set_sysclk(struct snd_soc_dai *dai,
                                   int clk_id, unsigned int freq, int dir)
 {
-       struct snd_soc_component *component = dai->component;
-       struct max98088_priv *max98088 = snd_soc_component_get_drvdata(component);
+	struct snd_soc_component *component = dai->component;
+	struct max98088_priv *max98088 = snd_soc_component_get_drvdata(component);
 
-       /* Requested clock frequency is already setup */
-       if (freq == max98088->sysclk)
-               return 0;
+	/* Requested clock frequency is already setup */
+	if (freq == max98088->sysclk)
+		return 0;
 
 	if (!IS_ERR(max98088->mclk)) {
 		freq = clk_round_rate(max98088->mclk, freq);
 		clk_set_rate(max98088->mclk, freq);
 	}
 
-       /* Setup clocks for slave mode, and using the PLL
-        * PSCLK = 0x01 (when master clk is 10MHz to 20MHz)
-        *         0x02 (when master clk is 20MHz to 30MHz)..
-        */
-       if ((freq >= 10000000) && (freq < 20000000)) {
-               snd_soc_component_write(component, M98088_REG_10_SYS_CLK, 0x10);
-               max98088->mclk_prescaler = 1;
-       } else if ((freq >= 20000000) && (freq < 30000000)) {
-               snd_soc_component_write(component, M98088_REG_10_SYS_CLK, 0x20);
-               max98088->mclk_prescaler = 2;
-       } else {
-               dev_err(component->dev, "Invalid master clock frequency\n");
-               return -EINVAL;
-       }
+	/* Setup clocks for slave mode, and using the PLL
+	 * PSCLK = 0x01 (when master clk is 10MHz to 20MHz)
+	 *         0x02 (when master clk is 20MHz to 30MHz)..
+	 */
+	if ((freq >= 10000000) && (freq < 20000000)) {
+		snd_soc_component_write(component, M98088_REG_10_SYS_CLK, 0x10);
+		max98088->mclk_prescaler = 1;
+	} else if ((freq >= 20000000) && (freq < 30000000)) {
+		snd_soc_component_write(component, M98088_REG_10_SYS_CLK, 0x20);
+		max98088->mclk_prescaler = 2;
+	} else {
+		dev_err(component->dev, "Invalid master clock frequency\n");
+		return -EINVAL;
+	}
 
-       if (snd_soc_component_read(component, M98088_REG_51_PWR_SYS)  & M98088_SHDNRUN) {
-               snd_soc_component_update_bits(component, M98088_REG_51_PWR_SYS,
-                       M98088_SHDNRUN, 0);
-               snd_soc_component_update_bits(component, M98088_REG_51_PWR_SYS,
-                       M98088_SHDNRUN, M98088_SHDNRUN);
-       }
+	if (snd_soc_component_read(component, M98088_REG_51_PWR_SYS)  & M98088_SHDNRUN) {
+		snd_soc_component_update_bits(component, M98088_REG_51_PWR_SYS,
+					      M98088_SHDNRUN, 0);
+		snd_soc_component_update_bits(component, M98088_REG_51_PWR_SYS,
+					      M98088_SHDNRUN, M98088_SHDNRUN);
+	}
 
-       dev_dbg(dai->dev, "Clock source is %d at %uHz\n", clk_id, freq);
+	dev_dbg(dai->dev, "Clock source is %d at %uHz\n", clk_id, freq);
 
-       max98088->sysclk = freq;
-       return 0;
+	max98088->sysclk = freq;
+	return 0;
 }
 
 static int max98088_dai1_set_fmt(struct snd_soc_dai *codec_dai,
-- 
2.20.1.7.g153144c

