Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25EE356BD53
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:08:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238804AbiGHQCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238982AbiGHQCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:02:21 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA49F747AB;
        Fri,  8 Jul 2022 09:02:20 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id r14so25373950wrg.1;
        Fri, 08 Jul 2022 09:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JrBZyUMKAO+r+T5351QHb8EDm0TdiafQ1X7zK7zqsrw=;
        b=JrVZj545gKjyjInXBmGFNi1/5u5LhTbQlTuuL88Dw62fc1OmsB4AgRf+fYH0/92I3A
         qfEDXSpGnXazLvb2CW6zQTq/n3xADlsATH04jUnxETqjGUemWQOLvywQYWvR8w4fxFUn
         CIWU19zjViU7dbGkYllCk+CQhszMzqyD/toOvOl08dosZcJ4DNTYCHtLerKKSaeReQjX
         wEhMv3D2JaNN2tdC7gPufz3X88ccUcR2dUrljtCovyl2kiwluOOicjicePZQh9E+nG/V
         PKJwOHmpAqvW0bho/5n4uIoKM876mvhrBsBCxnr7ETfU4fFqLWmddm77Ol04NNedIEen
         YGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JrBZyUMKAO+r+T5351QHb8EDm0TdiafQ1X7zK7zqsrw=;
        b=d1MAiS/ZLRBzoB4YA4QloqsUOe1v32vBZy7YROQCH8tSeq8t/aq0V2EAXPuToGeWFs
         bBgwZg7ppoejK9o5ALe2sd67KesyzCf4HpC63DSzlurpzDHOOmoxmWiJilhMCSo17rGO
         SwVzCex0oZ/Am4aUt0N1sPTfvdUzCwegyKdHWEi+2UE3cwzBGQzU99+r2OGtNWGwd/it
         NcH5/LLaauX+r6T3aBtb3J0n+AQHw33OWOsv00xWpyvQdQ6mwNBdHAPCW4mBfie9ImjR
         JybGrqj03oc3ZFtFDbQYF5ZFvcZrfJB2b2t2kZkD+8qdp/XRnTL5hzroVQ0Yw52gM/tW
         44Uw==
X-Gm-Message-State: AJIora+7avRLGGyIhXPfX3z1vZY+IqW3bdFnTK4X4zULq5PtAAgwFCm7
        6TGPMwm1x8n/VEju8SwK6b4=
X-Google-Smtp-Source: AGRyM1tjz8KRw+tJbCVQyjxrDMngBJEW69XO19U2dEQlOCPb7N85+rE+augPujbkk4XS8vXkx7okZQ==
X-Received: by 2002:a5d:59a5:0:b0:21d:205b:3c5b with SMTP id p5-20020a5d59a5000000b0021d205b3c5bmr4057242wrr.97.1657296139441;
        Fri, 08 Jul 2022 09:02:19 -0700 (PDT)
Received: from localhost (92.40.203.144.threembb.co.uk. [92.40.203.144])
        by smtp.gmail.com with ESMTPSA id b18-20020a05600c4e1200b003a2d47d3051sm2955204wmq.41.2022.07.08.09.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 09:02:18 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/11] ASoC: jz4740-i2s: Support S20_LE and S24_LE sample formats
Date:   Fri,  8 Jul 2022 17:02:41 +0100
Message-Id: <20220708160244.21933-9-aidanmacdonald.0x0@gmail.com>
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

