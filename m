Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313AA56680B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 12:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231450AbiGEKdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 06:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231395AbiGEKdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 06:33:01 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF031572A;
        Tue,  5 Jul 2022 03:32:59 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id lw20so20873195ejb.4;
        Tue, 05 Jul 2022 03:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=jY5FjsixWEcU8zWWnoT9i17TwQs6gwoN4AcRetl459A=;
        b=CLXsjGhps7gMkknzEejhsqeXGH97V6MUc8+1rvRng+RCUolyNyxRSjRnpe0IclsK5e
         YYRN5JHrfj7XOXa9vWKxCbw7mEDKJSaR/ywYKw0jIEGtRY8S/LayzRbvfvKX3csZR36f
         Br6uh63jmTgncimGaDumlZAhkZBWplIsKCz7Toi32BLIGHz8hIvBJEDHnxkCFp5+Zp6f
         ZKzVQfSoAW0rPlVYOSeRthMhkh3iLJBPHoWVRtBYp/0KBi5BQQR3fjWNnieqXOjFWGZt
         e7UwHoDELvPxzOhhiWbA4dHPGA4rguCmnAkZEJnjk3iHcvg0yfW6jYTuy1u1HyuOMVrW
         FeeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=jY5FjsixWEcU8zWWnoT9i17TwQs6gwoN4AcRetl459A=;
        b=PEdcYYkbcVXrs2A4Q89egtU8i6k4FOv4R4Ar0RysERRLe+wMpTyMktanuJcCHrWNS1
         Ac3w/GJXdNnmnfvI0rG29ppBLD3Rt0c6y8WX0oP56o8X05KHDml99ehzoTChXr4yybcp
         WZ1s30nZfS3TgJEjSIjprPDb5igdkkWngA++Lk4urpFer0Ogt62uWr/BUA4R4crbmmz6
         0iSKL7ZgIfcQqniF8hw7ZKoEsbVdoDU1d/UKZ2tpM0WfHJFGTroI6OPOsPZSEg42BYeO
         8baYUxW2euSPVchYtSMIUxNWKC5UrpOIZwvuktcMpGwZBbXyXwdaMRjESRSxQ1KyhZ/Y
         iMBw==
X-Gm-Message-State: AJIora/w4r5V2LjCXr4cKiiWgL5envH70OSEO8q/3zdk84c4eCc5U3Z/
        7EeYct1wtsC5h0tgo05r5bI=
X-Google-Smtp-Source: AGRyM1vbRqvZJ1bJMfKQceJ+JeD7Wl2liAwNwopQ2x8qJrxF1kBDubDhMTHNKcVUtXWF2qb02ic21A==
X-Received: by 2002:a17:907:271b:b0:72a:72bb:6f47 with SMTP id w27-20020a170907271b00b0072a72bb6f47mr26019412ejk.634.1657017177777;
        Tue, 05 Jul 2022 03:32:57 -0700 (PDT)
Received: from felia.fritz.box (200116b82698ad00a9019cf0f015ae6b.dip.versatel-1u1.de. [2001:16b8:2698:ad00:a901:9cf0:f015:ae6b])
        by smtp.gmail.com with ESMTPSA id p19-20020aa7cc93000000b0042bdb6a3602sm22540880edt.69.2022.07.05.03.32.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 03:32:57 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     =?UTF-8?q?Amadeusz=20S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] ASoC: Intel: avs: correct config reference for I2S test board
Date:   Tue,  5 Jul 2022 12:32:38 +0200
Message-Id: <20220705103238.7484-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit e39acc4cfd92 ("ASoC: Intel: avs: Add I2S-test machine board") adds
the config "SND_SOC_INTEL_AVS_MACH_I2S_TEST", but in the Makefile refers
to  config "SND_SOC_INTEL_AVS_MACH_i2s_TEST" (notice the uppercase and
lowercase difference).

Adjust the Makefile to refer to the actual existing config.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
Amadeusz, Cezary, please ack.

Mark, please pick this minor build config fix.

 sound/soc/intel/avs/boards/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/intel/avs/boards/Makefile b/sound/soc/intel/avs/boards/Makefile
index 25e8c4bb07db..bc75376d58c2 100644
--- a/sound/soc/intel/avs/boards/Makefile
+++ b/sound/soc/intel/avs/boards/Makefile
@@ -16,7 +16,7 @@ snd-soc-avs-ssm4567-objs := ssm4567.o
 obj-$(CONFIG_SND_SOC_INTEL_AVS_MACH_DA7219) += snd-soc-avs-da7219.o
 obj-$(CONFIG_SND_SOC_INTEL_AVS_MACH_DMIC) += snd-soc-avs-dmic.o
 obj-$(CONFIG_SND_SOC_INTEL_AVS_MACH_HDAUDIO) += snd-soc-avs-hdaudio.o
-obj-$(CONFIG_SND_SOC_INTEL_AVS_MACH_i2s_TEST) += snd-soc-avs-i2s-test.o
+obj-$(CONFIG_SND_SOC_INTEL_AVS_MACH_I2S_TEST) += snd-soc-avs-i2s-test.o
 obj-$(CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98357A) += snd-soc-avs-max98357a.o
 obj-$(CONFIG_SND_SOC_INTEL_AVS_MACH_MAX98373) += snd-soc-avs-max98373.o
 obj-$(CONFIG_SND_SOC_INTEL_AVS_MACH_NAU8825) += snd-soc-avs-nau8825.o
-- 
2.17.1

