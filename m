Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92F9756AC1B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 21:49:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236586AbiGGTq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 15:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236470AbiGGTqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:46:48 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C0AD4D149;
        Thu,  7 Jul 2022 12:46:47 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id sb34so34153406ejc.11;
        Thu, 07 Jul 2022 12:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=15R8fRtnipOyDZjBwDRNBD+rUnFt8ovWDJg/qvPn+8w=;
        b=eHPt7vqwXh1wCGADEJNAowKT4uYpPhdJCl2JI/BVjbITn1J6xk0YTHFOLRz2bBVMf6
         iHLttoama6OrqnbmwCIZLUndzjK9dqq9pS6rjXFfThBI4IDN38Zzqonh/DySOh5BZCp8
         oGDRgN8dVSes1DfDPXQc+0d0grg5TqfRpl1oplyx7ju1QJgxJ9QOZM9uqk9w6jnaUZ4X
         bgjrMsOeUrZ2d6W1cBJUaX6gsi69h9iTFQ6IE8Xw0TUOwi5ldLPGnwBXbdWCQ/vXCBm2
         ZSEKnl6wTO2Q5GbdnYMRpmjssovgDxmyVnfpgOqCTrg1NM4FdVhcA+6rqDXYzrAwwhDq
         jRuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=15R8fRtnipOyDZjBwDRNBD+rUnFt8ovWDJg/qvPn+8w=;
        b=0SgxWhSQCF4nKPS6K5LIArNTLR0OfVnFL7wnjpYtW7xJs66imgNk13GbcwX9BRosfh
         mOPS/itYSyzDWBJqGwOQyD4K1e+i1rJPRRz8Ng3TXTdg1IS7Rr60sLJjiDS2QkCDfZ3S
         VH5FKnTB8mCHmgfP2fJPapXHJREKydQWtKiEojq39IFua4szmVlpVC7ZWlwwVByZoUYj
         Hkgaazble3A/9uY2EzfE2XC11JJVopR6/7A3+BzNSdbHemMvoNjUsksgMcT72O5AjYwp
         X1v1er0NJ1e+9tDl26G5K9fuwALJJrPAMMJ3FiYPmIhwOS5U8bwuda+jwnqLDOS3OEMA
         mFrw==
X-Gm-Message-State: AJIora8Fpkf7UpL0gjX4Y27LB0hfFCWkDbjDEbKg09pgGhKDKlcGTvgL
        D/LBbQJTT+y31WdTLJFm7/U=
X-Google-Smtp-Source: AGRyM1vVBv4eichqt1pd+vj1n08RTifhwRB37lBYx7JArzeALYd899GQ5F2fkeIxJc0Jrz/wJBHNRg==
X-Received: by 2002:a17:907:1dc6:b0:72a:5e9a:91be with SMTP id og6-20020a1709071dc600b0072a5e9a91bemr41769203ejc.730.1657223207214;
        Thu, 07 Jul 2022 12:46:47 -0700 (PDT)
Received: from localhost (92.40.202.166.threembb.co.uk. [92.40.202.166])
        by smtp.gmail.com with ESMTPSA id d8-20020a056402000800b0043a71c376a2sm8283494edu.33.2022.07.07.12.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 12:46:46 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/11] ASoC: jz4740-i2s: Use FIELD_PREP() macros in hw_params callback
Date:   Thu,  7 Jul 2022 20:46:49 +0100
Message-Id: <20220707194655.312892-6-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220707194655.312892-1-aidanmacdonald.0x0@gmail.com>
References: <20220707194655.312892-1-aidanmacdonald.0x0@gmail.com>
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

