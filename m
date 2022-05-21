Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2261F52FD48
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 16:28:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244454AbiEUO2y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 10:28:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235561AbiEUO2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 10:28:51 -0400
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7BA79808C;
        Sat, 21 May 2022 07:28:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1653143254; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=c+/tGylXTkKCH8VmgCs2I+V4lFhNnQvTv+s0puxSnmKb8I0Ie0Lu7BS20WXmM4OLfw/jyY8qDdWMaa/2O/0KG5RbLGW5QYl1t9iydBquq4yRTLa/Z/IvkN7/4LEMpc8hxdh3W1oU3P2Pf5iK3pEEXKiG6XD5oesREt0eRfZWCvY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1653143254; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=UlXrovz8Wqe8HXRNPOZSPGTS1/sjZPQNfVVq1dmIgNU=; 
        b=hywHRY+OcPizi/P3VuQ26m7YTkCFDSAayDnichehMwX0TXi85TJFPTiiINruza+aS6TE5DabCJ7OyYeyoMF50Mb2Ga018bTXLq9bMo6/TeWy+y8+m0eGcl+ml/CFW58xYjoLCdZMdDtg4EeyVkZtZirE0WPgiuIwN/7sRuaN6Zw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=lchen.firstlove@zohomail.com;
        dmarc=pass header.from=<lchen.firstlove@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1653143254;
        s=zm2022; d=zohomail.com; i=lchen.firstlove@zohomail.com;
        h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To:Cc;
        bh=UlXrovz8Wqe8HXRNPOZSPGTS1/sjZPQNfVVq1dmIgNU=;
        b=TNzibeeNfWwu4kEGBZkBMhbIIhE10jBHBeErdLKWxKqpq9wvBjhyAQ/qAX4nNzGR
        fmCpFMv0fXjNLx+ZvXyWCYu62KjzL4OKl5l7CYBodtC43+l+Q6ad5z6/6+E1kX4SWdX
        8uU9Ikm8TNgYO+Iifh5J8l8MD+RlryRTG1QmQ9Ak=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1653143253499869.7381347385351; Sat, 21 May 2022 07:27:33 -0700 (PDT)
Received: from  [45.12.140.94] by mail.zoho.com
        with HTTP;Sat, 21 May 2022 07:27:33 -0700 (PDT)
Date:   Sat, 21 May 2022 07:27:33 -0700
From:   Li Chen <lchen.firstlove@zohomail.com>
To:     "Mark Brown" <broonie@kernel.org>,
        "linux-kernel" <linux-kernel@vger.kernel.org>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-gpio" <linux-gpio@vger.kernel.org>,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "linux-arm-kernel" <linux-arm-kernel@lists.infradead.org>,
        "Patrice Chotard" <patrice.chotard@foss.st.com>,
        "linux-sunxi" <linux-sunxi@lists.linux.dev>,
        "Liam Girdwood" <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>,
        "Takashi Iwai" <tiwai@suse.com>, "Chen-Yu Tsai" <wens@csie.org>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        "Samuel Holland" <samuel@sholland.org>,
        "Philipp Zabel" <p.zabel@pengutronix.de>
Message-ID: <180e70431e2.e6d0d6a445873.707989504680364975@zohomail.com>
In-Reply-To: <180e702a15f.e737e37e45859.3135149506136486394@zohomail.com>
References: <180e702a15f.e737e37e45859.3135149506136486394@zohomail.com>
Subject: [PATCH 2/4] ASoC: sunxi: Use {regmap/regmap_field}_{set/clear}_bits
  helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr08011226fc4fb690dd5c15119599758d00000190ae69003a295b80119919281cb46f4b5244f61666e528:zu080112272922073d411fb8225a27fea900001e32b3b788a60cd605a8a30418c81f31b39b25aaaa67ef454f:rf0801122cf6f8dfec8995b3a466518fdc00009d1ce4269968f953bd45db03d0b1c28e264caa264f36f2c01711c30a2b54:ZohoMail
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Chen <lchen@ambarella.com>

Appropriately change calls to {regmap/regmap_field}_update_bits()
with {regmap/regmap_field}_set_bits()
and {regmap/regmap_field}_clear_bits() for improved readability.

Signed-off-by: Li Chen <lchen@ambarella.com>
---
 sound/soc/sunxi/sun4i-codec.c | 78 ++++++++++++++---------------------
 1 file changed, 30 insertions(+), 48 deletions(-)

diff --git a/sound/soc/sunxi/sun4i-codec.c b/sound/soc/sunxi/sun4i-codec.c
index 60712f24ade5..53e3f43816cc 100644
--- a/sound/soc/sunxi/sun4i-codec.c
+++ b/sound/soc/sunxi/sun4i-codec.c
@@ -250,37 +250,33 @@ struct sun4i_codec {
 static void sun4i_codec_start_playback(struct sun4i_codec *scodec)
 {
 	/* Flush TX FIFO */
-	regmap_update_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
-			   BIT(SUN4I_CODEC_DAC_FIFOC_FIFO_FLUSH),
-			   BIT(SUN4I_CODEC_DAC_FIFOC_FIFO_FLUSH));
+	regmap_set_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
+			BIT(SUN4I_CODEC_DAC_FIFOC_FIFO_FLUSH));
 
 	/* Enable DAC DRQ */
-	regmap_update_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
-			   BIT(SUN4I_CODEC_DAC_FIFOC_DAC_DRQ_EN),
-			   BIT(SUN4I_CODEC_DAC_FIFOC_DAC_DRQ_EN));
+	regmap_set_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
+			BIT(SUN4I_CODEC_DAC_FIFOC_DAC_DRQ_EN));
 }
 
 static void sun4i_codec_stop_playback(struct sun4i_codec *scodec)
 {
 	/* Disable DAC DRQ */
-	regmap_update_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
-			   BIT(SUN4I_CODEC_DAC_FIFOC_DAC_DRQ_EN),
-			   0);
+	regmap_clear_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
+			  BIT(SUN4I_CODEC_DAC_FIFOC_DAC_DRQ_EN));
 }
 
 static void sun4i_codec_start_capture(struct sun4i_codec *scodec)
 {
 	/* Enable ADC DRQ */
-	regmap_field_update_bits(scodec->reg_adc_fifoc,
-				 BIT(SUN4I_CODEC_ADC_FIFOC_ADC_DRQ_EN),
-				 BIT(SUN4I_CODEC_ADC_FIFOC_ADC_DRQ_EN));
+	regmap_field_set_bits(scodec->reg_adc_fifoc,
+			      BIT(SUN4I_CODEC_ADC_FIFOC_ADC_DRQ_EN));
 }
 
 static void sun4i_codec_stop_capture(struct sun4i_codec *scodec)
 {
 	/* Disable ADC DRQ */
-	regmap_field_update_bits(scodec->reg_adc_fifoc,
-				 BIT(SUN4I_CODEC_ADC_FIFOC_ADC_DRQ_EN), 0);
+	regmap_field_clear_bits(scodec->reg_adc_fifoc,
+				 BIT(SUN4I_CODEC_ADC_FIFOC_ADC_DRQ_EN));
 }
 
 static int sun4i_codec_trigger(struct snd_pcm_substream *substream, int cmd,
@@ -323,8 +319,7 @@ static int sun4i_codec_prepare_capture(struct snd_pcm_substream *substream,
 
 
 	/* Flush RX FIFO */
-	regmap_field_update_bits(scodec->reg_adc_fifoc,
-				 BIT(SUN4I_CODEC_ADC_FIFOC_FIFO_FLUSH),
+	regmap_field_set_bits(scodec->reg_adc_fifoc,
 				 BIT(SUN4I_CODEC_ADC_FIFOC_FIFO_FLUSH));
 
 
@@ -365,8 +360,7 @@ static int sun4i_codec_prepare_playback(struct snd_pcm_substream *substream,
 	u32 val;
 
 	/* Flush the TX FIFO */
-	regmap_update_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
-			   BIT(SUN4I_CODEC_DAC_FIFOC_FIFO_FLUSH),
+	regmap_set_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
 			   BIT(SUN4I_CODEC_DAC_FIFOC_FIFO_FLUSH));
 
 	/* Set TX FIFO Empty Trigger Level */
@@ -386,9 +380,8 @@ static int sun4i_codec_prepare_playback(struct snd_pcm_substream *substream,
 			   val);
 
 	/* Send zeros when we have an underrun */
-	regmap_update_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
-			   BIT(SUN4I_CODEC_DAC_FIFOC_SEND_LASAT),
-			   0);
+	regmap_clear_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
+			   BIT(SUN4I_CODEC_DAC_FIFOC_SEND_LASAT));
 
 	return 0;
 };
@@ -485,33 +478,27 @@ static int sun4i_codec_hw_params_capture(struct sun4i_codec *scodec,
 
 	/* Set the number of channels we want to use */
 	if (params_channels(params) == 1)
-		regmap_field_update_bits(scodec->reg_adc_fifoc,
-					 BIT(SUN4I_CODEC_ADC_FIFOC_MONO_EN),
+		regmap_field_set_bits(scodec->reg_adc_fifoc,
 					 BIT(SUN4I_CODEC_ADC_FIFOC_MONO_EN));
 	else
-		regmap_field_update_bits(scodec->reg_adc_fifoc,
-					 BIT(SUN4I_CODEC_ADC_FIFOC_MONO_EN),
-					 0);
+		regmap_field_clear_bits(scodec->reg_adc_fifoc,
+					 BIT(SUN4I_CODEC_ADC_FIFOC_MONO_EN));
 
 	/* Set the number of sample bits to either 16 or 24 bits */
 	if (hw_param_interval(params, SNDRV_PCM_HW_PARAM_SAMPLE_BITS)->min == 32) {
-		regmap_field_update_bits(scodec->reg_adc_fifoc,
-				   BIT(SUN4I_CODEC_ADC_FIFOC_RX_SAMPLE_BITS),
+		regmap_field_set_bits(scodec->reg_adc_fifoc,
 				   BIT(SUN4I_CODEC_ADC_FIFOC_RX_SAMPLE_BITS));
 
-		regmap_field_update_bits(scodec->reg_adc_fifoc,
-				   BIT(SUN4I_CODEC_ADC_FIFOC_RX_FIFO_MODE),
-				   0);
+		regmap_field_clear_bits(scodec->reg_adc_fifoc,
+				   BIT(SUN4I_CODEC_ADC_FIFOC_RX_FIFO_MODE));
 
 		scodec->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	} else {
-		regmap_field_update_bits(scodec->reg_adc_fifoc,
-				   BIT(SUN4I_CODEC_ADC_FIFOC_RX_SAMPLE_BITS),
-				   0);
+		regmap_field_clear_bits(scodec->reg_adc_fifoc,
+				   BIT(SUN4I_CODEC_ADC_FIFOC_RX_SAMPLE_BITS));
 
 		/* Fill most significant bits with valid data MSB */
-		regmap_field_update_bits(scodec->reg_adc_fifoc,
-				   BIT(SUN4I_CODEC_ADC_FIFOC_RX_FIFO_MODE),
+		regmap_field_set_bits(scodec->reg_adc_fifoc,
 				   BIT(SUN4I_CODEC_ADC_FIFOC_RX_FIFO_MODE));
 
 		scodec->capture_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
@@ -543,24 +530,20 @@ static int sun4i_codec_hw_params_playback(struct sun4i_codec *scodec,
 
 	/* Set the number of sample bits to either 16 or 24 bits */
 	if (hw_param_interval(params, SNDRV_PCM_HW_PARAM_SAMPLE_BITS)->min == 32) {
-		regmap_update_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
-				   BIT(SUN4I_CODEC_DAC_FIFOC_TX_SAMPLE_BITS),
+		regmap_set_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
 				   BIT(SUN4I_CODEC_DAC_FIFOC_TX_SAMPLE_BITS));
 
 		/* Set TX FIFO mode to padding the LSBs with 0 */
-		regmap_update_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
-				   BIT(SUN4I_CODEC_DAC_FIFOC_TX_FIFO_MODE),
-				   0);
+		regmap_clear_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
+				   BIT(SUN4I_CODEC_DAC_FIFOC_TX_FIFO_MODE));
 
 		scodec->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_4_BYTES;
 	} else {
-		regmap_update_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
-				   BIT(SUN4I_CODEC_DAC_FIFOC_TX_SAMPLE_BITS),
-				   0);
+		regmap_clear_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
+				   BIT(SUN4I_CODEC_DAC_FIFOC_TX_SAMPLE_BITS));
 
 		/* Set TX FIFO mode to repeat the MSB */
-		regmap_update_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
-				   BIT(SUN4I_CODEC_DAC_FIFOC_TX_FIFO_MODE),
+		regmap_set_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
 				   BIT(SUN4I_CODEC_DAC_FIFOC_TX_FIFO_MODE));
 
 		scodec->playback_dma_data.addr_width = DMA_SLAVE_BUSWIDTH_2_BYTES;
@@ -624,8 +607,7 @@ static int sun4i_codec_startup(struct snd_pcm_substream *substream,
 	 * Stop issuing DRQ when we have room for less than 16 samples
 	 * in our TX FIFO
 	 */
-	regmap_update_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
-			   3 << SUN4I_CODEC_DAC_FIFOC_DRQ_CLR_CNT,
+	regmap_set_bits(scodec->regmap, SUN4I_CODEC_DAC_FIFOC,
 			   3 << SUN4I_CODEC_DAC_FIFOC_DRQ_CLR_CNT);
 
 	return clk_prepare_enable(scodec->clk_module);
-- 
2.36.1


