Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C815656BD73
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238217AbiGHQCg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:02:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238972AbiGHQCR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:02:17 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8847478B;
        Fri,  8 Jul 2022 09:02:15 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id g39-20020a05600c4ca700b003a03ac7d540so1407028wmp.3;
        Fri, 08 Jul 2022 09:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=15R8fRtnipOyDZjBwDRNBD+rUnFt8ovWDJg/qvPn+8w=;
        b=AU6fDPxUlSjzP6uJXV5tHBUw9pKc7/LhdFpHt+DMhFo9HD+Og4hsJb4xn8kJKpTAEb
         xaUVAFuWx0toFiGLCWyx9tkrItWlO7XNdVnO/nig9V+o5bTMk52mqX4RxFRJGbJJyk+Q
         OV8nlnIrxBuauL+cae4GpHBu/7RXjJiD9mIvsnZWNstqXIUrvFCfNJUYdOQZqmzz1cJr
         8Pec/XaeH1y00WJw2A8DHuK46JRuIcprKcPXSLA2QXBPav5p6BwHZtQCe5jxYeTse37+
         O4Y/8rg4Q6LRINqGPc93HX/6lLAyA4G4mcsskaUxj7yHkrdm0Q/OVwxqijL+4B8buD/l
         batw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=15R8fRtnipOyDZjBwDRNBD+rUnFt8ovWDJg/qvPn+8w=;
        b=2temSLKU7b1eh9ZaMljkqQNigTaPILeDQNptjZgslmc6ghdeGQUmAdHYeJbBvILAOC
         8ZQxEJIcpANjG8xd1XYik2GkEToWXz3JtzxpyFb2wllicDegcNUVYMI3Po0GNBvtiVMt
         XhvYsBF715rveTX5L77F83b5+uKcoIJrNHP1R7d8d6T74bG0PF5OvY4ALAaw8VT1TjUy
         unXx6zMygkjtwBdMEmohU7YBc29TnQnP8Zj2sgoPotR4pud66Fu9q5924bdipKvflwjj
         qw6yDd7qN3+TLJA8G5pwvmPdLRvEV0nz1MSJALZDV5DR41LTAWcqJxJ0GwAkklLZIfzs
         nx1w==
X-Gm-Message-State: AJIora/t1JTIygdIpcKH+2JTWc1A48IuRbqXjSWgLVGOigllJUYQveAk
        SvqSxtfcRpVVvAAAOA1t0gc=
X-Google-Smtp-Source: AGRyM1sg6ppNc81IlVkZNUxH62VQBa3FfWXj9Z2O++m0HokVrNioASoMy5He4Trm4JQMVd4/bVV2lQ==
X-Received: by 2002:a05:600c:1d03:b0:3a1:7ab1:8dbe with SMTP id l3-20020a05600c1d0300b003a17ab18dbemr548294wms.202.1657296134342;
        Fri, 08 Jul 2022 09:02:14 -0700 (PDT)
Received: from localhost (92.40.203.144.threembb.co.uk. [92.40.203.144])
        by smtp.gmail.com with ESMTPSA id by13-20020a056000098d00b0021b89f8662esm17612309wrb.13.2022.07.08.09.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 09:02:13 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 05/11] ASoC: jz4740-i2s: Use FIELD_PREP() macros in hw_params callback
Date:   Fri,  8 Jul 2022 17:02:38 +0100
Message-Id: <20220708160244.21933-6-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220708160244.21933-1-aidanmacdonald.0x0@gmail.com>
References: <20220708160244.21933-1-aidanmacdonald.0x0@gmail.com>
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

Acked-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 043f100a9cfa..d0791dfa9c7b 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -3,6 +3,7 @@
  *  Copyright (C) 2010, Lars-Peter Clausen <lars@metafoo.de>
  */
 
+#include <linux/bitfield.h>
 #include <linux/init.h>
 #include <linux/io.h>
 #include <linux/kernel.h>
@@ -42,8 +43,8 @@
 #define JZ_AIC_CONF_SYNC_CLK_MASTER BIT(1)
 #define JZ_AIC_CONF_ENABLE BIT(0)
 
-#define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_MASK (0x7 << 19)
-#define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_MASK (0x7 << 16)
+#define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE GENMASK(21, 19)
+#define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE GENMASK(18, 16)
 #define JZ_AIC_CTRL_ENABLE_RX_DMA BIT(15)
 #define JZ_AIC_CTRL_ENABLE_TX_DMA BIT(14)
 #define JZ_AIC_CTRL_MONO_TO_STEREO BIT(11)
@@ -61,9 +62,6 @@
 #define JZ4760_AIC_CTRL_TFLUSH BIT(8)
 #define JZ4760_AIC_CTRL_RFLUSH BIT(7)
 
-#define JZ_AIC_CTRL_OUTPUT_SAMPLE_SIZE_OFFSET 19
-#define JZ_AIC_CTRL_INPUT_SAMPLE_SIZE_OFFSET  16
-
 #define JZ_AIC_I2S_FMT_DISABLE_BIT_CLK BIT(12)
 #define JZ_AIC_I2S_FMT_DISABLE_BIT_ICLK BIT(13)
 #define JZ_AIC_I2S_FMT_ENABLE_SYS_CLK BIT(4)
@@ -248,8 +246,9 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
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
@@ -257,8 +256,8 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 
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

