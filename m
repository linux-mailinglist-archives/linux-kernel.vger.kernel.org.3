Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70CA85A9407
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 12:16:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbiIAKPO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 06:15:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233572AbiIAKPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 06:15:06 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 496BD1D0D4
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 03:15:04 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id v26so13462169lfd.10
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 03:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc;
        bh=UfjJiZEAo19qjNND3CHqX4TJIKByuTN8Q8XFKaEmWz8=;
        b=TKrsf52Q9ddOKrIePHpowifFuaGXZwGr7nnqt5/5qxzHukoBbU1LFhbXr0TYtxU037
         ENlh5/9bMNjo6uoA8dravtDhpiWKCxQnF24CDyY1TnirQOEpWKPTRCJNjtdjWodSf0g8
         1pau6sAowWb/DJYJfEzXeLMcwvbRga7nxpC/Icl2TjeZt9wqm11NCmDNSn12B7pGF4hI
         XwSqVYXrVki9il3F221JSZnTBCOETdTPyjDqRGdEEaNx5yheEgoLzUSVqz/t3gfg6QSp
         zfDO4QLW52Yjqa3WBS0Xyg5+EVEyXSlCwFm83mAmzh2ht8ywHoLfD4by4mUmff3rBgcb
         gndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc;
        bh=UfjJiZEAo19qjNND3CHqX4TJIKByuTN8Q8XFKaEmWz8=;
        b=xTsyOeyOa4lyKECk5HrlA2EQq0FZenuDc26h2uoHLsl1E0CdzUT/Frh53xt/fl6EeJ
         W9SJgROeL7t+pT0pAMcZjec+VHo2RFZs5hYzggVZkVjTYDt/I0i8uaXqSseicZvlTDP2
         yxbrnplSR45FcsLiXFFlHh9BkRIkfjSMrGGP3yA5WowT48o5DhpY5V4b6G1h0HyTugev
         U7546cNoviupQ6hmY7j9HsYf0HqpoNTMgdNCFqlIxo1GKcjxHap1I400TX57nb84qhRU
         pObToCmWF+RYTeW0zsOtPZZGE84osEPymiGUX6maezyi74X4mb8al66ItybzZ0bumxq6
         ofXg==
X-Gm-Message-State: ACgBeo0Esm0fBcwKdkfdMzPO81JHKXmWfX+a+dxuAuR/OmLVb7oqemTv
        Du40aTO/42k5EOZ2tfwSEXT0ng==
X-Google-Smtp-Source: AA6agR5f7OH/NaeXRFpefaOH5s/hdNZXALvs+nG+rRPEVpI0nAU3tYg/eaf9gChB/xIQn9Mkzif8eg==
X-Received: by 2002:a05:6512:2255:b0:492:ebbb:5f0d with SMTP id i21-20020a056512225500b00492ebbb5f0dmr9923411lfu.304.1662027302632;
        Thu, 01 Sep 2022 03:15:02 -0700 (PDT)
Received: from krzk-bin.. (balticom-73-99-134.balticom.lv. [109.73.99.134])
        by smtp.gmail.com with ESMTPSA id 189-20020a2e05c6000000b00261ca0f940esm1266565ljf.62.2022.09.01.03.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 03:15:02 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ASoC: codecs: rk817: drop I2C dependencies
Date:   Thu,  1 Sep 2022 13:14:58 +0300
Message-Id: <20220901101458.365354-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220901101458.365354-1-krzysztof.kozlowski@linaro.org>
References: <20220901101458.365354-1-krzysztof.kozlowski@linaro.org>
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

The RK817 codec uses regmap API and not directly regmap I2C.  It is the
parent MFD who uses and selects regmap I2C.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/Kconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 2fc37f4e061c..c7d83fe999e9 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -1197,8 +1197,7 @@ config SND_SOC_RK3328
 
 config SND_SOC_RK817
 	tristate "Rockchip RK817 audio CODEC"
-	depends on MFD_RK808 || COMPILE_TEST && I2C
-	select REGMAP_I2C
+	depends on MFD_RK808 || COMPILE_TEST
 
 config SND_SOC_RL6231
 	tristate
-- 
2.34.1

