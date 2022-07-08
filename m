Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1D656BDDB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 18:09:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238313AbiGHQCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 12:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238998AbiGHQCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 12:02:23 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 982F66D571;
        Fri,  8 Jul 2022 09:02:22 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id n10so5849810wrc.4;
        Fri, 08 Jul 2022 09:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G5dmS78zz1zwy89jfeWA97TI8jj2tS8e0cDJN/8sutk=;
        b=oO7fgm9eyOrsYEnp7lII/3SEHnt7odEcVUlFpDHfaflg14fCrV81pk8Y9E0odXWY1t
         c56FzzHYw+rOYdiZ2O2dGkPnvGzMaq4ZXzInxsYtSHMc55u/K7LtaW/frH7WmFvd3x1q
         7aIXyPEkQMeuAvDHD4hQ1lF0Aa+LU+xWs3Av7W+JEIqY5tVeYziuqc2juIyODqQDn3KN
         opMTI7WhTb/s3A7luoWOgJLqjN+Zm10p14Ifw2vaRR0Pb2fMcho6WMRO9ZsSILZZqJJV
         G0m9y2MeUjR8HQ7lnOWz6oRwVxsY9dqlNTXrqOpwbHD+lFrFsnQeZpY/VZ7+iSYIgQKZ
         fAsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G5dmS78zz1zwy89jfeWA97TI8jj2tS8e0cDJN/8sutk=;
        b=AA3mqECwIQesllV62T3O8QDHx5BaNd629TRkU0Qwc4X3NxUy7lUbKDAt+kHtizJipM
         yLyqv2bE2hmDPQE2C707/uBn9xHnA4y/Uu7vZRULOCDbBkitjK5D7WpF5twjJ1BHTUnD
         +QIGYJuoJXeEr49hLH1UR/32ENLBgWBr/rLqBaCNiVmsEO8tibzUt7Ev3RYdFBjnKE5G
         fqoGIZWUZ+Ut2UUmNyK9qd7zuLf9Rk34KyGQW71mxMv52y0rc86TJPmj6RR1YNjUqbso
         /jTqfbbCKdEypMwxKBVuIF2eUx8iO6zOa6hWIdMToYbsmZ6rKt+cNR0NEp7lBiSk8pj8
         /sPw==
X-Gm-Message-State: AJIora9ISY9wGRzrSIaFDIYMqEUA6mLn6ub6nEm7APW39N3jjE/iNLuo
        6SiQqBrU5d3q3bccrw1RY9o=
X-Google-Smtp-Source: AGRyM1sIVKhAH2NqKkrY/QEJBblVnvI2M+yCTtt2LnMsL42SB0xHvfPkgeu9SUMyCQUzmrBKWfCmzg==
X-Received: by 2002:adf:e30b:0:b0:21d:8f3e:a370 with SMTP id b11-20020adfe30b000000b0021d8f3ea370mr3961120wrj.124.1657296141163;
        Fri, 08 Jul 2022 09:02:21 -0700 (PDT)
Received: from localhost (92.40.203.144.threembb.co.uk. [92.40.203.144])
        by smtp.gmail.com with ESMTPSA id v17-20020a5d5911000000b0021bbdc3375fsm17499281wrd.68.2022.07.08.09.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 09:02:20 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 09/11] ASoC: jz4740-i2s: Support continuous sample rate
Date:   Fri,  8 Jul 2022 17:02:42 +0100
Message-Id: <20220708160244.21933-10-aidanmacdonald.0x0@gmail.com>
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

