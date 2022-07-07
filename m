Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA1A256AC21
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 21:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235948AbiGGTrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 15:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236561AbiGGTqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:46:55 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66C144F644;
        Thu,  7 Jul 2022 12:46:53 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id l23so2415134ejr.5;
        Thu, 07 Jul 2022 12:46:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JrBZyUMKAO+r+T5351QHb8EDm0TdiafQ1X7zK7zqsrw=;
        b=EI57jaoukrphqp3TGEHy7fOkxzbStIw3JqSqI3EzDM5ls+Gi75CklycaO4AbIez7rB
         WGvz7jHwXGDDno/wwWcIHVbRrxsqug2JSPoV1T3jZE53YBJ2lHqDTBBFpbmK1qS3ibIZ
         1aE9ETohYdF3czui4p8owQJpmwabGBKA8rydiMnH4ErU62ztkjJoI6FdaSv5ez7fIraS
         TFrlRzul+ikdFTK7QTAsKZ7uKknH2lDGRPVKPgSSNVrOpDF6AUgx2zTmmblGpUfieRk4
         e6PMKkl6pJfXDf0HS2L5q6IulNjkyvvhfUVgfF8eIVFI8H0urRCjDSdv6uYttboPfTRN
         r2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JrBZyUMKAO+r+T5351QHb8EDm0TdiafQ1X7zK7zqsrw=;
        b=efkQAl05h67LDgFRLvckr4mcPz5g1SKp1SPDh4pUi+9swvDjAkhrS4q4D0zzAtsRsI
         teTnKm512I5ff6HcaN/+6yfsrR3oODjcbl5AsTXR+QWnu5C4wLO3u0vaWAO+307kXr3l
         4vZicQGOwWQZPo/6KR8pkxEpHSF4rpz8qrUZovwVR5LxvoK/D9gfn8eR4N7ipytrLmFM
         u233xVoNhcl1hF1MoFNf3ZGG5p275m4ltaMo37IvqTIziZyAKqUbLezjgjH/9NAEx2KT
         6694uWX/EQ+HAsH0wyF3NeV/z/+E7r4v590ZEiEWC7khblzZUuQPntLQa8iPq/FXW6sk
         y3zA==
X-Gm-Message-State: AJIora+tNcXab7YERLx3pOfaCKJS9I5vFtNdThNv6G0eKOxLhCli6Uj9
        UCFMAaL9R7iAYkFZIz1Rl60=
X-Google-Smtp-Source: AGRyM1vDCGR1VMWAd0Cbe+xX8sE4qvCVqEpC/UwMMZH0fOB21yq70892HxS4uckFeNtmivBNwjVnJw==
X-Received: by 2002:a17:907:961f:b0:726:9aee:f061 with SMTP id gb31-20020a170907961f00b007269aeef061mr45319537ejc.45.1657223212001;
        Thu, 07 Jul 2022 12:46:52 -0700 (PDT)
Received: from localhost (92.40.202.166.threembb.co.uk. [92.40.202.166])
        by smtp.gmail.com with ESMTPSA id u3-20020aa7db83000000b0043580ac5888sm28516552edt.82.2022.07.07.12.46.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 12:46:51 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/11] ASoC: jz4740-i2s: Support S20_LE and S24_LE sample formats
Date:   Thu,  7 Jul 2022 20:46:52 +0100
Message-Id: <20220707194655.312892-9-aidanmacdonald.0x0@gmail.com>
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

The audio controller on JZ47xx SoCs can transfer 20- and 24-bit
samples in the FIFO, so allow those formats to be used with the
I2S driver. Although the FIFO doesn't care about the in-memory
sample format, we only support 4-byte format variants because the
DMA controller on these SoCs cannot transfer in 3-byte multiples.

Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
---
 sound/soc/jz4740/jz4740-i2s.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/sound/soc/jz4740/jz4740-i2s.c b/sound/soc/jz4740/jz4740-i2s.c
index a41398c24d0e..9be2f3f1b376 100644
--- a/sound/soc/jz4740/jz4740-i2s.c
+++ b/sound/soc/jz4740/jz4740-i2s.c
@@ -238,9 +238,15 @@ static int jz4740_i2s_hw_params(struct snd_pcm_substream *substream,
 	case SNDRV_PCM_FORMAT_S8:
 		sample_size = 0;
 		break;
-	case SNDRV_PCM_FORMAT_S16:
+	case SNDRV_PCM_FORMAT_S16_LE:
 		sample_size = 1;
 		break;
+	case SNDRV_PCM_FORMAT_S20_LE:
+		sample_size = 3;
+		break;
+	case SNDRV_PCM_FORMAT_S24_LE:
+		sample_size = 4;
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -375,7 +381,9 @@ static const struct snd_soc_dai_ops jz4740_i2s_dai_ops = {
 };
 
 #define JZ4740_I2S_FMTS (SNDRV_PCM_FMTBIT_S8 | \
-		SNDRV_PCM_FMTBIT_S16_LE)
+			 SNDRV_PCM_FMTBIT_S16_LE | \
+			 SNDRV_PCM_FMTBIT_S20_LE | \
+			 SNDRV_PCM_FMTBIT_S24_LE)
 
 static struct snd_soc_dai_driver jz4740_i2s_dai = {
 	.probe = jz4740_i2s_dai_probe,
-- 
2.35.1

