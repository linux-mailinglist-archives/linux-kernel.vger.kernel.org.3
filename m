Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E885F56B776
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 12:47:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237973AbiGHKmv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 06:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237869AbiGHKmd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:42:33 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE7B5814BE;
        Fri,  8 Jul 2022 03:42:32 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id a5so15289590wrx.12;
        Fri, 08 Jul 2022 03:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JrBZyUMKAO+r+T5351QHb8EDm0TdiafQ1X7zK7zqsrw=;
        b=i6OWV/92LT28oKE/r10nP1hSnecmy52xHdwW7+PExPIeyIo60ViMK3o+LM3lhKdqfN
         y2usMEvqE66oVgFktWdbpIQsFHdBi/Xik+ttUc8D6SiIe2K1TkSQkMFBRXQNGMugEdzD
         FRHmC23XrGkT+kq7VYVU95Ufy893xx6K6GiGyUDISqTvBfmFURjM79iX2TPfQT8Xln1V
         s+yCFwpSxXBMFg5ieCO4RCvBT6DQbS9v4iyo13UGPiebLYOg8LCk/hIPtNnYZ4xQwlvl
         l9rnQaqTxAuP/hx70B3kMGMl0CxKfeF69tlbwABnze/iNEeD92nAFr3AhxlY6lFcF9Vg
         IEww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JrBZyUMKAO+r+T5351QHb8EDm0TdiafQ1X7zK7zqsrw=;
        b=3DheoIgimVEGZQm8qxy0qWKv2XhmBa2IqlD2AbXV/JYPGP7Whaij/cWSFlqdkhq7K8
         8jp+vSuR8mA/s/L1JxU/HKaXQLvNAxmHOcfQ4l2L2pMBxSP9EDA3XaGbfonH7XManjW5
         OjjC6OwEKtLlfVMNyYm30RgFFhDW2v+7QcyF9zVfyIubwrOscZQJVw03h5dEPcIpyCaP
         kSNyzeRK2KG4QMEkHglZTrSZ410HgvhLo7bE7q/BplznDWThLqaxFIVXHNkW4gXJFPi7
         maPojV3WNzMQHDovvn0TFFWsCLS50gvLsuqxmQNnRdhsfaznLoJptWjaqp7mcJ3x+2e+
         dg3Q==
X-Gm-Message-State: AJIora9MUHpaasUwr5UlEcReGz+a2GmyO0cUnAWUZ06s2Y2+3rEh8lxJ
        y1ONXUSR3Q5eKboZwVR7qMg=
X-Google-Smtp-Source: AGRyM1v+jJXeggIYc2T0HZS/ovtBNml8Jl40sPF0RkPGGSiCB0rtY4MSmn5EKfR/tsEF+h55bznkfg==
X-Received: by 2002:a05:6000:1a8d:b0:21d:9055:96a6 with SMTP id f13-20020a0560001a8d00b0021d905596a6mr2207409wry.245.1657276952542;
        Fri, 08 Jul 2022 03:42:32 -0700 (PDT)
Received: from localhost (92.40.203.220.threembb.co.uk. [92.40.203.220])
        by smtp.gmail.com with ESMTPSA id t10-20020adfe10a000000b00210320d9fbfsm48837106wrz.18.2022.07.08.03.42.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 03:42:32 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 08/11] ASoC: jz4740-i2s: Support S20_LE and S24_LE sample formats
Date:   Fri,  8 Jul 2022 11:43:01 +0100
Message-Id: <20220708104304.51415-9-aidanmacdonald.0x0@gmail.com>
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

