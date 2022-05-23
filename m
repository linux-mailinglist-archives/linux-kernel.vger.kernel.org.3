Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475715307A6
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 04:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352371AbiEWCZz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 22:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343827AbiEWCZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 22:25:53 -0400
Received: from sender4-pp-o94.zoho.com (sender4-pp-o94.zoho.com [136.143.188.94])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7599C3668F;
        Sun, 22 May 2022 19:25:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1653272671; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=HR/UnGLsO+GJ69YGnMD33mEcpQid6QQhalWf1pijJUObpoX7rt63czmnolNnwCLeod8bN6Nb24SLfaYYSN9vF2/gNybMvpsp7kUd1ZCo1aC60DaHBUiKMrTM/WNqCUyTkYpkkKCboGrqZzvi/PqCxg+sr+S5dTtraj2tlXmUkTA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1653272671; h=Content-Type:Content-Transfer-Encoding:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=UlXrovz8Wqe8HXRNPOZSPGTS1/sjZPQNfVVq1dmIgNU=; 
        b=Fiz6sHHCIVVp0Raog4cPHL3zNsAEAC0IRyYPXo7ZiehDSdEanRe2JYmOVtmkay+oc9L/uN1Cov+2jWU7W1QlbTnNyM2Vg3q7wB6qFa0pNHaxr9WDaylqURrztJzr8baeZq2ezGiJN6CWqPvMekj4XznLL01gMzW7yMOzcTKqO7o=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=lchen.firstlove@zohomail.com;
        dmarc=pass header.from=<lchen.firstlove@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1653272671;
        s=zm2022; d=zohomail.com; i=lchen.firstlove@zohomail.com;
        h=Date:Date:From:From:To:To:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Feedback-ID:Message-Id:Reply-To:Cc;
        bh=UlXrovz8Wqe8HXRNPOZSPGTS1/sjZPQNfVVq1dmIgNU=;
        b=TBCEOaqqKnWVwXFkaoxg670nFnd4kVuSuERmDD4T63JOdOAbVcVQ07iiJ0NaOsAQ
        YsJzDt5XSfLAT4/0lLXDDJkHPW6Tdu3Qr35Qze99llYtg3KyFwCGFJ12qUPd5V/MQ1h
        aZYFBRpumlwc3wuMrBwBy0a1T3BwuXJwvc+glNxs=
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1653272669764142.37877634507936; Sun, 22 May 2022 19:24:29 -0700 (PDT)
Received: from  [45.12.140.94] by mail.zoho.com
        with HTTP;Sun, 22 May 2022 19:24:29 -0700 (PDT)
Date:   Sun, 22 May 2022 19:24:29 -0700
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
Message-ID: <180eebaee27.10f5d464060176.1253521336400783918@zohomail.com>
In-Reply-To: <180eeb93909.12110e2de60158.391061173597432851@zohomail.com>
References: <180e702a15f.e737e37e45859.3135149506136486394@zohomail.com> <180eeb93909.12110e2de60158.391061173597432851@zohomail.com>
Subject: [PATCH v2 2/4] ASoC: sunxi: Use
  {regmap/regmap_field}_{set/clear}_bits helpers
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
Feedback-ID: rr08011226e49bf0326dbf7364eee3e8640000000fe512d99bf907e0fe77290f4ba42b8e48689553598b43:zu080112271460852a56ffe9822b7bdb9800002a075369c9dfd1e79b485fce138ad19f7ababa22a77db08e30:rf0801122c952965961aad78804b9180ab0000054aa02551f3917f1f903cbaf8dce62f16aeb1c503c2fa69c0710fb02b67:ZohoMail
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


