Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251AE56B785
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 12:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237953AbiGHKmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 06:42:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237873AbiGHKmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 06:42:36 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C43C814A9;
        Fri,  8 Jul 2022 03:42:35 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id g39-20020a05600c4ca700b003a03ac7d540so902743wmp.3;
        Fri, 08 Jul 2022 03:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G5dmS78zz1zwy89jfeWA97TI8jj2tS8e0cDJN/8sutk=;
        b=e5u9BfKdTH0e9Yr1UQs/E6TkGAQoWdB4Q2og2eVbiciEviKhMW+wfTpOUocZQsfYZr
         CcMolD759bJi9Ugem7Vn0CaYRhskmFXYDGD5o4Hha8P3iATrn1Mr3taUlKOktRSzjKZ9
         q4UOeeZ3FMQM18FZRkVeN/Yr7Y3BGBgqNB3lKi+08YZu9qvQxE4TEE+G014/WvC17Fsg
         A1+NBddTF0yNg0A3TJ+l4HyuT6K9N7NdGboUi+aogPas+TFYgUYu1ByLotMYsacN6eDt
         GIgZAB4maR+6mleWniowHlN2+wtsLAMm+Fygn3pI2VJqUVSYvzceLD0UrVEXxeusMg93
         hI8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G5dmS78zz1zwy89jfeWA97TI8jj2tS8e0cDJN/8sutk=;
        b=zNQD53LFKg/ujgLWf0T40ObT45Kb5SkdVWUi6XkjCQHwXdmH8S1jOK7AzXe3r7aXsP
         4nMvn3f+Yglzvtxf+DW6Yj3eQqsYkQjLN9SWbrPeLevIkGXv1OXzUTRqAK7ameGCxTww
         IBIObIUk7F2bO+k4EB1acEJXIwZfsUCFAA2COgHnUlAMKO41YLNFrnDlAzs86cvEOvlI
         ZJzsRKcX93MA3Me4LGIfrqy7icX0ZCmI9zaF9a6BCk9weoDuZ0EjlMqkAuBwO7IkV4hV
         ga85Gwpih3MODQNhJc2+AgiXUjx1FKNTAIfZ3Xx8OijpWExDtH+2L/EupiM42YOtc87L
         t54A==
X-Gm-Message-State: AJIora82lJgq83+lzD9ArE782RBXMFua2FzSUtfnIOiN29kF+mEBYI+L
        eU1gQruj+YTifyBNhz3514o=
X-Google-Smtp-Source: AGRyM1uUIIhrHjXA3atkwDHxUcfUonFLE00wtHCyQbfSsbMbHHuHTxrblm9sUuPVgJmPcKRzTC2/4Q==
X-Received: by 2002:a05:600c:3593:b0:3a1:8909:b5b2 with SMTP id p19-20020a05600c359300b003a18909b5b2mr9878772wmq.77.1657276954141;
        Fri, 08 Jul 2022 03:42:34 -0700 (PDT)
Received: from localhost (92.40.203.220.threembb.co.uk. [92.40.203.220])
        by smtp.gmail.com with ESMTPSA id p9-20020a05600c064900b003a0323463absm1622817wmm.45.2022.07.08.03.42.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 03:42:33 -0700 (PDT)
From:   Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
To:     paul@crapouillou.net, lgirdwood@gmail.com, broonie@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     linux-mips@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 09/11] ASoC: jz4740-i2s: Support continuous sample rate
Date:   Fri,  8 Jul 2022 11:43:02 +0100
Message-Id: <20220708104304.51415-10-aidanmacdonald.0x0@gmail.com>
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

