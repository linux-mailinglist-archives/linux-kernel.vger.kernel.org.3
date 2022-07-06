Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81CBE569400
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 23:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234662AbiGFVNO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 17:13:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbiGFVM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 17:12:57 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC6E75FD3;
        Wed,  6 Jul 2022 14:12:55 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id ay16so29188584ejb.6;
        Wed, 06 Jul 2022 14:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XAfqs/8JoYVOURGYaByruwTWNVivg3YFx+gXMAB1ZgI=;
        b=gXXFVnarcaND4v/W/V/r074iFLqKVhZouMi1RM0jKkZAF33Yun+1aZyrmyr8+IIe8T
         Hl51zZjY6U8FEfDVYyqbdQIngwdN/gYZOZ7lrU3gOu1IZbDtqVLS/OSKa8Jqvo2xtefr
         BFezmvdV4IpWVBX1DQu4bzCUCLZU7uE7CN4Xv5xEjTzSvXLiLbH66aqc88zSemZadc+M
         /rgMcE16ynRMCcDIMe9riP6YEA5Na56H+TsKo0py4d986VDivaAIxnDrF1XWwK1tRVJf
         5qaw1MhY9th6PAX3yivXpfq5pQcenI5Hl5LWR2vck7PkhmdYY4FogzFkEgqJB3/DNC0N
         VOgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XAfqs/8JoYVOURGYaByruwTWNVivg3YFx+gXMAB1ZgI=;
        b=t4DNsFAMoFfpPvmpb4iKHP2eDqiYCnO/bWvCGCUUmhBa7WUaRqh82Qaw9DXDRwqgk7
         aSeIp2oOYOf+t7daL7IsXVxsnLDU2NP0FAT8jaNNJH9JNiVLxF0edLIJr4/bcHkSbyYl
         DT5hjQ4zG/71oZuvOrLU5L6Q2pYhy6AsQtJLuithoxrpX1lMBCZ5egV/xFqmZAOFlVJ1
         0XmV26Gxzhne5o27upNBhliD8UZfVt8Td/6OpBeyRDgmDiBPDgYf7S1KwW4JZHAwph/Y
         z7l49gTdjfwTzk5kvCAcvoNpG8LsKb/z7aFZvu+ie6mYJksokYw2PGrorcmVgghyV3Ir
         GdWg==
X-Gm-Message-State: AJIora8FLos409K9sKcIRwz3ftA/jfR4XD8IJ17LCCokSKnct6LyA+1p
        yLeUv26t8nwOYIvwRJPxWHgECURpE0M=
X-Google-Smtp-Source: AGRyM1tvfi9p6iVcY5U+EZv4ogz4yhivruSEX08JC0QJ+OKOY6pfg1JD+ubvgDueYiSZ5amHUfCy7g==
X-Received: by 2002:a17:907:3f0a:b0:726:324c:5bc2 with SMTP id hq10-20020a1709073f0a00b00726324c5bc2mr43645247ejc.32.1657141975370;
        Wed, 06 Jul 2022 14:12:55 -0700 (PDT)
Received: from localhost (92.40.202.8.threembb.co.uk. [92.40.202.8])
        by smtp.gmail.com with ESMTPSA id i21-20020a17090639d500b006fe98fb9523sm17980408eje.129.2022.07.06.14.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 14:12:54 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/11] ASoC: jz4740-i2s: Support continuous sample rate
Date:   Wed,  6 Jul 2022 22:13:30 +0100
Message-Id: <20220706211330.120198-12-aidanmacdonald.0x0@gmail.com>
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

The I2S controller on JZ47xx SoCs doesn't impose restrictions on
sample rate and the driver doesn't make any assumptions about it,
so the DAI should advertise a continuous sample rate range.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index ee99c5e781ec..053697c7f19e 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -378,13 +378,13 @@ static struct snd_soc_dai_driver jz4740_i2s_dai = {
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_48000,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
 		.formats = JZ4740_I2S_FMTS,
 	},
 	.capture = {
 		.channels_min = 2,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_48000,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
 		.formats = JZ4740_I2S_FMTS,
 	},
 	.symmetric_rate = 1,
@@ -415,13 +415,13 @@ static struct snd_soc_dai_driver jz4770_i2s_dai = {
 	.playback = {
 		.channels_min = 1,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_48000,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
 		.formats = JZ4740_I2S_FMTS,
 	},
 	.capture = {
 		.channels_min = 2,
 		.channels_max = 2,
-		.rates = SNDRV_PCM_RATE_8000_48000,
+		.rates = SNDRV_PCM_RATE_CONTINUOUS,
 		.formats = JZ4740_I2S_FMTS,
 	},
 	.ops = &jz4740_i2s_dai_ops,
-- 
2.35.1

