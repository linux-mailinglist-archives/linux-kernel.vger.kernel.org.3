Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C0456B77C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 12:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237895AbiGHKmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 06:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237798AbiGHKm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:42:28 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F19C82395;
        Fri,  8 Jul 2022 03:42:27 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id a5so15289246wrx.12;
        Fri, 08 Jul 2022 03:42:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VXKGG9javDrFOkKmb7ryKLnUNvKA3TX1Nnby1SaWrZk=;
        b=d0CT5v9GVPujeVt5PUq/xQYx3qqrk6D4bEfkOEXl2+Md06XbgbpnHLHzgDgk3nZdff
         NjsGXkOwHaWyd7ZJxFyHfFOFWFZ66BYElyTMtqQga4SLFOddCLfWYgJWt/MhvqdPXDbD
         x6eXNkhYuYsUqLYKdSfxQuFynDTEGz/8PGEhl95SEHGCjBywRGZGgCIAc6aHPS+8zFIr
         VuGT6Fc67O8HV9zj8ZL+PW4yP5ofn6rqa3NtyajnPpcQmj3tgVmpZLHsbqSFi32l26lQ
         H0VClyAO8kWFPiGYn+GS4xgKM9lWMiEx9TrMMIFDAesw7qnOKPLHgWxtAZMRXlud8VTs
         S7Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VXKGG9javDrFOkKmb7ryKLnUNvKA3TX1Nnby1SaWrZk=;
        b=PU7S848+qYLdmCtfMxjGd7u3QlalwM+oB+Xpzy9oAhKkAGyxzfDQ+GPYf/KZP0rN/+
         T0knMgXbb8HFa+jtHR03+RKTujni5if71a7TYR2uwGgSzRvE83+RUTdFH5j5ugiW0u9m
         ZrqC1I54H9v4NiTe2aAo9HWyFHyNush7lGszME7zvHw8iP2a3tSvHBTGftOcENRcSgIK
         KcEYcLBC456wB3lFDl8J/ljwhJMsTAKCXgjugNvDrXE46KK/kd4y9+NSeER8bG59orKa
         RMHY0lea3OR4uSjLb18uwBeAx7Y2MBQxiz5k0n5P8gFouGy6sv9x3CvXGVTdRR2f4RA+
         YwJw==
X-Gm-Message-State: AJIora+vx+cM2h3H52NcU1FgEvGNqrPZ3dJCCpcrFC3azN4ZhSTbKbum
        qCkz+/X/tHuDPr0WSJM8STKySiRHKgg=
X-Google-Smtp-Source: AGRyM1uExfuSG9lo/9syog0G3veln7Cn5ZFTwN/VpalC5tcDH0uvjAQ4vKGMG/n9g9TnbnUhWjFKuA==
X-Received: by 2002:a05:6000:1f02:b0:21d:7760:d0ca with SMTP id bv2-20020a0560001f0200b0021d7760d0camr2647096wrb.694.1657276946002;
        Fri, 08 Jul 2022 03:42:26 -0700 (PDT)
Received: from localhost (92.40.203.220.threembb.co.uk. [92.40.203.220])
        by smtp.gmail.com with ESMTPSA id y5-20020a056000108500b002167efdd549sm12806848wrw.38.2022.07.08.03.42.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 03:42:25 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 04/11] ASoC: jz4740-i2s: Handle independent FIFO flush bits
Date:   Fri,  8 Jul 2022 11:42:57 +0100
Message-Id: <20220708104304.51415-5-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220708104304.51415-1-aidanmacdonald.0x0@gmail.com>
References: <20220708104304.51415-1-aidanmacdonald.0x0@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On the JZ4740, there is a single bit that flushes (empties) both
the transmit and receive FIFO. Later SoCs have independent flush
bits for each FIFO, which allows us to flush the right FIFO when
starting up a stream.

This also fixes a bug: since we were only setting the JZ4740's
flush bit, which corresponds to the TX FIFO flush bit on other
SoCs, other SoCs were not having their RX FIFO flushed at all.

Fixes: 967beb2e8777 ("ASoC: jz4740: Add jz4780 support")
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index bd73427b837e..043f100a9cfa 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -58,6 +58,9 @@
 #define JZ_AIC_CTRL_ENABLE_PLAYBACK BIT(1)
 #define JZ_AIC_CTRL_ENABLE_CAPTURE BIT(0)
 
+#define JZ4760_AIC_CTRL_TFLUSH BIT(8)
+#define JZ4760_AIC_CTRL_RFLUSH BIT(7)
+
 #define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_OFFSET 19
 #define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_OFFSET  16
 
@@ -75,6 +78,8 @@ struct i2s_soc_info {
 	struct reg_field field_tx_fifo_thresh;
 	struct reg_field field_i2sdiv_capture;
 	struct reg_field field_i2sdiv_playback;
+
+	bool shared_fifo_flush;
 };
 
 struct jz4740_i2s {
@@ -100,10 +105,26 @@ static int jz4740_i2s_startup(struct snd_pcm_substream *substream,
 	struct jz4740_i2s *i2s = snd_soc_dai_get_drvdata(dai);
 	int ret;
 
+	/*
+	 * When we can flush FIFOs independently, only flush the
+	 * FIFO that is starting up.
+	 */
+	if (!i2s->soc_info->shared_fifo_flush) {
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			regmap_set_bits(i2s->regmap, JZ_REG_AIC_CTRL, JZ4760_AIC_CTRL_TFLUSH);
+		else
+			regmap_set_bits(i2s->regmap, JZ_REG_AIC_CTRL, JZ4760_AIC_CTRL_RFLUSH);
+	}
+
 	if (snd_soc_dai_active(dai))
 		return 0;
 
-	regmap_set_bits(i2s->regmap, JZ_REG_AIC_CTRL, JZ_AIC_CTRL_FLUSH);
+	/*
+	 * When there is a shared flush bit for both FIFOs we can
+	 * only flush the FIFOs if no other stream has started.
+	 */
+	if (i2s->soc_info->shared_fifo_flush)
+		regmap_set_bits(i2s->regmap, JZ_REG_AIC_CTRL, JZ_AIC_CTRL_FLUSH);
 
 	ret = clk_prepare_enable(i2s->clk_i2s);
 	if (ret)
@@ -382,6 +403,7 @@ static const struct i2s_soc_info jz4740_i2s_soc_info = {
 	.field_tx_fifo_thresh	= REG_FIELD(JZ_REG_AIC_CONF, 8, 11),
 	.field_i2sdiv_capture	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
 	.field_i2sdiv_playback	= REG_FIELD(JZ_REG_AIC_CLK_DIV, 0, 3),
+	.shared_fifo_flush	= true,
 };
 
 static const struct i2s_soc_info jz4760_i2s_soc_info = {
-- 
2.35.1

