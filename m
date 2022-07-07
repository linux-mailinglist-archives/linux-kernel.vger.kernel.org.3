Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C49656AC26
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 21:49:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236790AbiGGTrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 15:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236631AbiGGTrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:47:03 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E67FE59244;
        Thu,  7 Jul 2022 12:46:54 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id v12so11818366edc.10;
        Thu, 07 Jul 2022 12:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G5dmS78zz1zwy89jfeWA97TI8jj2tS8e0cDJN/8sutk=;
        b=QN0fskPgk1K9lhN3aO2dm5FSQxJQ/Yi9ty3yx86aq8RWe0W2ujYIfeNZ54HzCh+KZf
         H/4GBrWRcKSIn1cdwUfBFLh85Koj9MduC44GtMF5GQ1W3ykhQAU9BMdMTTF8AVAByfxW
         ovcl56s64uqWxO0zpKfCTVSc1r1rmroGVVEyCEoDW125R12eyJOdDpHpOMyUc/szWkqK
         VKmITqT1taSJRAA4GyLxR8znJIm2P1bq5M9m8zx/QBdeWsjQtowrvbc5ofqZTi1l/vRM
         RZWusfTtL+FNIFlZcLdKbCrYxarWmwRa1FWnG9KpLvzcH5yZlik9nE5/ccp9bz3/Aiar
         7kgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G5dmS78zz1zwy89jfeWA97TI8jj2tS8e0cDJN/8sutk=;
        b=oeHBXuaLCYdVr6yipXWTlHDCwiQISbRW7fc0GwTPOmudMdGOXxycWDShkg7Vq3ssXN
         XfsbfeWwVwmgd1xeX4ChEr4QKD5KdhtG5A+0v1X5fxycnwZKkmvpXLWd5wTPwFJaOHQk
         kSRk2j1N30WFJC7zYKSGgbjTJNK4EUCQiC/Rb8hb7+cetykYdFC+RMBKVI3zRFLay500
         rvwnlcDiEA48njFcX4QLaFcglwC2LDEihi1Wzx+vXHFzce+AsN7Wit94rD41Y2yCvlXC
         6f0KrLG+f9DhqwEpPXxxuaiMTk7MfSailPNgm41o68XijawyFvMuYHr22P6+9hgPvPSL
         UKpA==
X-Gm-Message-State: AJIora8wcLNQEc39Lv7uKScV/8gvLyhLIMsMX3UDRwiPpE8rjIfWlmeo
        oaouGB8mqpbdW1NTXl1fYf1D2keXgXU=
X-Google-Smtp-Source: AGRyM1tazEHDxc6kwjfkZuNdpd1A3Q2t59CObFU0/AXY62YGlqvsdleAQ1yghbC2dS996dH6A7LnrA==
X-Received: by 2002:a05:6402:1d53:b0:43a:9ba7:315b with SMTP id dz19-20020a0564021d5300b0043a9ba7315bmr6425080edb.350.1657223213482;
        Thu, 07 Jul 2022 12:46:53 -0700 (PDT)
Received: from localhost (92.40.202.166.threembb.co.uk. [92.40.202.166])
        by smtp.gmail.com with ESMTPSA id g3-20020a1709061c8300b0070759e37183sm19311041ejh.59.2022.07.07.12.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 12:46:53 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 09/11] ASoC: jz4740-i2s: Support continuous sample rate
Date:   Thu,  7 Jul 2022 20:46:53 +0100
Message-Id: <20220707194655.312892-10-aidanmacdonald.0x0@gmail.com>
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

The I2S controller on JZ47xx SoCs doesn't impose restrictions on
sample rate and the driver doesn't make any assumptions about it,
so the DAI should advertise a continuous sample rate range.

Acked-by: Paul Cercueil <paul@crapouillou.net>
Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index 9be2f3f1b376..70b9d28a40ce 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -391,13 +391,13 @@ static struct snd_soc_dai_driver jz4740_i2s_dai = {
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
@@ -429,13 +429,13 @@ static struct snd_soc_dai_driver jz4770_i2s_dai = {
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

