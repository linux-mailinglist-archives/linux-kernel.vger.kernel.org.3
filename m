Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943695A5D83
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 09:59:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230459AbiH3H7J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 03:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229955AbiH3H7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 03:59:01 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1462D124F
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:58:59 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id z29so5838707lfb.13
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 00:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=JyJg814s8VNKfznL3jPP/bagNFT2CFpVK/YKwkc4pmY=;
        b=hNnVqtnbES08UFG8eGi60EgJlNBj5fsNqtjk9dBwtUbdps1C1ZEv2RtnaP0ZCA3HOk
         9mTGLOgYD4Ia0vYwdd9g9JLecbEIANKroQutHXrXjtyS12suuT671yUGtkuTWSWKcwkN
         qG92MGVKfHNxGXX/edquEVl+6ebeeu7B95tpTb8um2lr2ovmF/yn1JLx2EWlIZaA5TJd
         W1o3//HEt61Y/BxwiyDoiAdm8mUfGaKEseYD8sfyfaRHTGmI2ZGqwqPAsu9OA1q3pByu
         ZOhAnESs9pGSwv5jPdkq1CvE1b7oKqupoyI0E6NkhcTNK6ciXdB9f4mmwdv9FvASVrp5
         suVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=JyJg814s8VNKfznL3jPP/bagNFT2CFpVK/YKwkc4pmY=;
        b=QjGKQUdki2Z7Yf/p2snp+LvMbbcGLqyjdH0jNF44NaQ4NrfwMvJCB4ZiVU6uhdKPO8
         xagtu60JAtcOY1nfwpe1QIZHTSaWEFAtlsg/333WnyFvx0bJBTr1JhL7y4gZJ7/CjZDU
         8UUt73fS6zXHk/KMSyoYPxupg9L1mywCmaPcua79V77nTyCzFVecTufDGQgbAkbkhmll
         1fMCTewvAvC7xPd9wcUNpUYcmMr4zq8nI6MXBr+uJvhpVHOuoeCvDcXAhwSId7oB9GF2
         iPe7oU9MP7owfbo6sgTuHvhjpV8fCXQICbKWekmsKjwxgR8bXAGB1sp+eAjiYGDxD/77
         /s+w==
X-Gm-Message-State: ACgBeo3f1sdXiakfxZ55o3lVz4zkSw/3FnwpbHz28t5dsTY1UiFFeVfC
        0cwyX32fF9RGIF3UM6XtgnBFYQ==
X-Google-Smtp-Source: AA6agR6WgXrloUT0qepCq/hwy+s6NVisiGm9eKqQl4uG0m4zYRath4sRXPDFwrotfJCXgR8G769NBQ==
X-Received: by 2002:a05:6512:12c5:b0:48c:df54:a41a with SMTP id p5-20020a05651212c500b0048cdf54a41amr6994063lfg.464.1661846338193;
        Tue, 30 Aug 2022 00:58:58 -0700 (PDT)
Received: from krzk-bin.. (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id p9-20020a05651212c900b0048aa9d67483sm948946lfg.160.2022.08.30.00.58.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 00:58:57 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>
Subject: [PATCH] ASoC: codecs: rk817: fix missing I2C dependency in compile test
Date:   Tue, 30 Aug 2022 10:58:55 +0300
Message-Id: <20220830075855.278046-1-krzysztof.kozlowski@linaro.org>
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

SND_SOC_RK817 uses I2C regmap so compile testing without parent MFD_RK808, requires I2C:

  WARNING: unmet direct dependencies detected for REGMAP_I2C
    Depends on [n]: I2C [=n]
    Selected by [y]:
    - SND_SOC_RK817 [=y] && SOUND [=y] && !UML && SND [=y] && SND_SOC [=y] && (MFD_RK808 [=n] || COMPILE_TEST [=y])

Reported-by: kernel test robot <lkp@intel.com>
Fixes: 5b7f4e5de61b ("ASoC: codecs: allow compile testing without MFD drivers")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Commit SHA from linux-next (recent).
---
 sound/soc/codecs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 94b7bb85d236..968d0701f2e8 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1197,7 +1197,7 @@ config SND_SOC_RK3328
 
 config SND_SOC_RK817
 	tristate "Rockchip RK817 audio CODEC"
-	depends on MFD_RK808 || COMPILE_TEST
+	depends on MFD_RK808 || COMPILE_TEST && I2C
 	select REGMAP_I2C
 
 config SND_SOC_RL6231
-- 
2.34.1

