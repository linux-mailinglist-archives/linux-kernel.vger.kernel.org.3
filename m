Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278A15A9406
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbiIAKPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbiIAKPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:15:04 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7A6326D3
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 03:15:03 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id p18so14036297ljc.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 03:15:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=mtzbQ813GefStQWt/8A6rNqlj+sApr5uo7WJJunn+4w=;
        b=E2vOWXystzy9srWI5OpgIsGxHVKb+2e0yhd6Mkwge/GrzSYj6S0d0sVvyfJjMgfNjl
         MwMEtnqZCk5cj+YZyIbI5YCv4c+cHZ1eBVfCGgatIIiPD1KqsUWBiaGNAVujsWEco/hJ
         JBodrZB1ON0wCXkGtd8Jxyk+QrcfSIYHEb8feT5/BTeFsIiNr9RtqOyM5S/UDhnFiSvf
         qvLE0f4rnPk6pg0eTQtGpNv2AacQbviNEiuyNpb3vRjRCX9VrvB8oCe80q5BlcuyO7Ge
         OlEye61oXuYVzENpNMwtIeCshBQw+h9bwAcZOmuIxvy17Kzsko/AxThwxJ7t54P2t6gD
         agrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=mtzbQ813GefStQWt/8A6rNqlj+sApr5uo7WJJunn+4w=;
        b=rM4sgfOOxllAYYvMuF0EjSW6/IO0TPvI3cIXcWlqyyzzmQs4G9wWldnXxLbJT2Zb+k
         EdZbeYzXZ3XoRqgV93ISht2GgU0FmghJBG3qa8Z5zzrka3xBuqlRKSGQC3ObeCBRNlTb
         Dqxjshqz84OZ6fYunirJ8NvARkM42dB9lDq12LIQTGov1YHcC8TmgyZ8OYbL9S+I6A6Q
         hHHItVoPA5qZDu3mrUL5D7m0dXRc4hWIMGeEXZ+0hQSufj5GOv92tE8pprCZupv5dyM0
         Qogj8vKI4atjU0NEWqw8A7AIGkOhUH+8Gt+dCnGfNuON5KVsimF+1kDonv4VQnD8v1K6
         xYBA==
X-Gm-Message-State: ACgBeo144RbGBrZ/KVcSqA0DzWyGDdLUM0QnvDCTfyj1MrMYCMBTA+uK
        PNDY2ZMg+6M2B+dW4e87oj9KPA==
X-Google-Smtp-Source: AA6agR4nyCOizMkZutH4KZGXO4VRzf8r56lGSNHj2Joxp+eGxPfb/WD8KLrvVHlPdm9fl/JtEZrOWg==
X-Received: by 2002:a2e:7205:0:b0:263:fec3:a700 with SMTP id n5-20020a2e7205000000b00263fec3a700mr5963996ljc.178.1662027301413;
        Thu, 01 Sep 2022 03:15:01 -0700 (PDT)
Received: from krzk-bin.. (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id 189-20020a2e05c6000000b00261ca0f940esm1266565ljf.62.2022.09.01.03.15.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 03:15:00 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>
Subject: [PATCH 1/2] ASoC: codecs: wcd934x: add Slimbus dependency
Date:   Thu,  1 Sep 2022 13:14:57 +0300
Message-Id: <20220901101458.365354-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The WCD934X codec is a Slimbus driver, so it must depend on SLIMBUS,
also for compile tests:

  ERROR: modpost: "slim_stream_prepare" [sound/soc/codecs/snd-soc-wcd934x.ko] undefined!

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 5b7f4e5de61b ("ASoC: codecs: allow compile testing without MFD drivers")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 968d0701f2e8..2fc37f4e061c 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1744,6 +1744,7 @@ config SND_SOC_WCD_MBHC
 config SND_SOC_WCD934X
 	tristate "WCD9340/WCD9341 Codec"
 	depends on COMMON_CLK
+	depends on SLIMBUS
 	select SND_SOC_WCD_MBHC
 	depends on MFD_WCD934X || COMPILE_TEST
 	help
-- 
2.34.1

