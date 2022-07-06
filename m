Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B4D5693FB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 23:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbiGFVM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 17:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234558AbiGFVMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 17:12:49 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF08D129;
        Wed,  6 Jul 2022 14:12:48 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id n4so9886515ejz.10;
        Wed, 06 Jul 2022 14:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lvGXj3ls7TV90GptpGG1jLpCJVEsDU4cCv/CoE+6bpM=;
        b=krbHqmBRYekWzAlAtpO7sBN1ST+0G/8miKAo7OHmnIWBpNlinUrotSvvT1yBHIz7YZ
         OyA0CScteMVUjoIYc46Nonj3i80xglBJ6e+iyHV6uvOdKNYDlOhNUl+WnjJiwGbFFCxh
         z4t6U2R1AecTXan3+SfE7tpGRpqIJm6FfEWSnhdOnKS3f03WV5e5Jz3aEjJ2r0ovXzO2
         HAT5CoieAPJbEzTrdWLBOAAre8VodDEtdXeYkqWMdq1SK01rx400RfpXfIGc1mZ4Vqua
         LRW3/AqfZgF0KSC7VpEQxfBIjTEQc3zjvjgWv7vkfjQt+UeSYixIPe26dxRUW2BKr60E
         VoAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lvGXj3ls7TV90GptpGG1jLpCJVEsDU4cCv/CoE+6bpM=;
        b=LNNuhQQ0BNRd1H+uEp3VetzH1Z9ecM4//8ae3V0nT4oCf3YEqveWJPsL1IA6zcti4/
         NOq/rnfMVkZfAWXPlEdbxtOOgKJMEZ6MwgP/qpNSjQasaqkkhOXPcKSgW4ic3sAE3PVJ
         2quxZH3X7bRXtJ1HlnGHS3lFOMW/KeHs8RU8x3+6/mIf2Nty6WIDa8/2a2iU010SuvOI
         sbWEta8EQ3ZmTTHlKAuA7CjP7jfVMH8whsRhstQ/cfZYbJmcHoGnA4lVktKO5zpn+6X7
         4xriuXqbZhdJWKnRXPdkhH2ujQD8YCWnoZgtVoxwGyAddp2XeO5U94dIBVUuGHkGKxEy
         zq/g==
X-Gm-Message-State: AJIora98E1swG5ttfDz1LG3uFlUh2QdM/6jFZj2f2FoXyFVY1vAYWu4y
        KmbiQ4uIEXreV+DjSbqFj8A=
X-Google-Smtp-Source: AGRyM1tENucyCQc6o1kqm7tKl+HfBOTrbZHO+IO7+Og4B6UEcwWEmeiPcizBD5QYh/RTI6pu23BzEQ==
X-Received: by 2002:a17:906:149b:b0:726:2968:e32a with SMTP id x27-20020a170906149b00b007262968e32amr42064953ejc.71.1657141967428;
        Wed, 06 Jul 2022 14:12:47 -0700 (PDT)
Received: from localhost (92.40.202.8.threembb.co.uk. [92.40.202.8])
        by smtp.gmail.com with ESMTPSA id q17-20020a17090676d100b007121b22b376sm2164813ejn.105.2022.07.06.14.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 14:12:46 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 06/11] ASoC: jz4740-i2s: Use FIELD_PREP() macros in hw_params callback
Date:   Wed,  6 Jul 2022 22:13:25 +0100
Message-Id: <20220706211330.120198-7-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220706211330.120198-1-aidanmacdonald.0x0@gmail.com>
References: <20220706211330.120198-1-aidanmacdonald.0x0@gmail.com>
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

Get rid of a couple of macros and improve readability by using
FIELD_PREP() and GENMASK() for the sample size setting.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 8bb9449d13d3..3c3cf78bf848 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -3,6 +3,7 @@
  *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
  */
 
+#include <linux/bitfield.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -49,8 +50,8 @@
 #define JZ4760_AIC_CONF_FIFO_RX_THRESHOLD_OFFSET 24
 #define JZ4760_AIC_CONF_FIFO_TX_THRESHOLD_OFFSET 16
 
-#define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_MASK (0x7 << 19)
-#define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_MASK (0x7 << 16)
+#define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE GENMASK(21, 19)
+#define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE GENMASK(18, 16)
 #define JZ_AIC_CTRL_ENABLE_RX_DMA BIT(15)
 #define JZ_AIC_CTRL_ENABLE_TX_DMA BIT(14)
 #define JZ_AIC_CTRL_MONO_TO_STEREO BIT(11)
@@ -65,9 +66,6 @@
 #define JZ_AIC_CTRL_ENABLE_PLAYBACK BIT(1)
 #define JZ_AIC_CTRL_ENABLE_CAPTURE BIT(0)
 
-#define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_OFFSET 19
-#define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_OFFSET  16
-
 #define JZ_AIC_I2S_FMT_DISABLE_BIT_CLK BIT(12)
 #define JZ_AIC_I2S_FMT_DISABLE_BIT_ICLK BIT(13)
 #define JZ_AIC_I2S_FMT_ENABLE_SYS_CLK BIT(4)
@@ -245,8 +243,9 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 	}
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		ctrl &= ~JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_MASK;
-		ctrl |= sample_size << JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_OFFSET;
+		ctrl &= ~JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE;
+		ctrl |= FIELD_PREP(JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE, sample_size);
+
 		if (params_channels(params) == 1)
 			ctrl |= JZ_AIC_CTRL_MONO_TO_STEREO;
 		else
@@ -254,8 +253,8 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 
 		div_field = i2s->field_i2sdiv_playback;
 	} else {
-		ctrl &= ~JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_MASK;
-		ctrl |= sample_size << JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_OFFSET;
+		ctrl &= ~JZ_AIC_CTRL_INPUT_SAMPLE_SIZE;
+		ctrl |= FIELD_PREP(JZ_AIC_CTRL_INPUT_SAMPLE_SIZE, sample_size);
 
 		div_field = i2s->field_i2sdiv_capture;
 	}
-- 
2.35.1

