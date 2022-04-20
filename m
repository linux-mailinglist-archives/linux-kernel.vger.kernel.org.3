Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2518E508647
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 12:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377788AbiDTKuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241398AbiDTKuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:50:04 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89D2113F42
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 03:47:18 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id g18so2625538ejc.10
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 03:47:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bcpYqRaU49XKqh0Z0sSXhDxB3o3VF6wDafoLfTVp4EQ=;
        b=TllbobzAtOeBEXWQjxWZwmHDv/7A+77wdjCWcGGlbLmwQnEk+Zd8uBxoUl8qMoYIvt
         GP6zRKxeVe+L2gaGMMHvIvIrU1SHOX/jNhZ6zrtqzUqhzFoM/yxmyUM0bMSHCDRMiJux
         Gf/26FTMxYbd+jdvyZcC/5pABqDpE6CKw16ps+kIPS8tkE0WcSA3rhBy7wzu3ixbt4Hp
         gXMk7EaNo+5uQkHTqZJEkFrh14utTtQ0fDC0Vqv+9JHXyDgQGfF2OfNK2SJy0gb37pDx
         AVruYFb2E/K95YlR0+UCI1vLc6tb+2usEeGEfigufEujzTpvXdAr8e9dyLKT90vLTSC6
         61tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=bcpYqRaU49XKqh0Z0sSXhDxB3o3VF6wDafoLfTVp4EQ=;
        b=rHiK52v8LmU0EDcHWUKhYYn/nZaQGAudk/OJHAd9LW/lnFQyupDR7WxoVWzE1KthLF
         91cUUZWo2lNU7HhYrAIG74Fn1oBcMBIGPRZfSPgZXmO63K34f2LWfUxsRsxSU0y68UMJ
         oWq6+i3JuHNJRHxN3QVjXCD5u7SBlAvXD3owSyKUFenoqjhDd2TMLinyyOlzljpbnr7U
         /eo2QxEqZ5GLaNl6Xu/l6NFhJ4r2ldyoCOk+pshJmdulchAJDxGtjLXWuu4oDFa+PM3M
         6Nj6Tuopy/pSGmH9eWLx+iumc8sYtRv23ejRvTxMIMyWtfvNTAMHh33wEGmxTVCZ2FdR
         yowg==
X-Gm-Message-State: AOAM533iL3E+34ACFRDS2D0eKV+57l3SFe3KYLJqvvY+dpL/XKqoQk58
        M6KasvSFhJDQFYXiH6VFZr5gpg==
X-Google-Smtp-Source: ABdhPJy9OVgwcawWRlYVZ5WxCEw/1/2nlUmelZjjBlqNclDd2qstERYLUEf0WaDM3tW8fI/yuSRHvA==
X-Received: by 2002:a17:906:6a1c:b0:6eb:d76c:e835 with SMTP id qw28-20020a1709066a1c00b006ebd76ce835mr18773642ejc.15.1650451637094;
        Wed, 20 Apr 2022 03:47:17 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090622ce00b006e898c912e5sm6583019eja.217.2022.04.20.03.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 03:47:16 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     arm@kernel.org, soc@kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] MAINTAINERS: add Bug entry for Samsung and memory controller drivers
Date:   Wed, 20 Apr 2022 12:47:08 +0200
Message-Id: <20220420104708.106738-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a Bug sections, indicating preferred mailing method for bug
reports, to Samsung SoC related entries and memory controller drivers.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4cfe5a9acf3f..2d746723306a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2645,6 +2645,7 @@ L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
 C:	irc://irc.libera.chat/linux-exynos
 Q:	https://patchwork.kernel.org/project/linux-samsung-soc/list/
+B:	mailto:linux-samsung-soc@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git
 F:	Documentation/arm/samsung/
 F:	Documentation/devicetree/bindings/arm/samsung/
@@ -11989,6 +11990,7 @@ M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
 L:	linux-pm@vger.kernel.org
 S:	Supported
+B:	mailto:linux-samsung-soc@vger.kernel.org
 F:	Documentation/devicetree/bindings/power/supply/maxim,max14577.yaml
 F:	Documentation/devicetree/bindings/power/supply/maxim,max77693.yaml
 F:	drivers/power/supply/max14577_charger.c
@@ -12000,6 +12002,7 @@ M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
+B:	mailto:linux-samsung-soc@vger.kernel.org
 F:	Documentation/devicetree/bindings/*/maxim,max14577.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77686.yaml
 F:	Documentation/devicetree/bindings/*/maxim,max77693.yaml
@@ -12693,6 +12696,7 @@ MEMORY CONTROLLER DRIVERS
 M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
+B:	mailto:krzysztof.kozlowski@linaro.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git
 F:	Documentation/devicetree/bindings/memory-controllers/
 F:	drivers/memory/
@@ -15624,6 +15628,7 @@ L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
 C:	irc://irc.libera.chat/linux-exynos
 Q:	https://patchwork.kernel.org/project/linux-samsung-soc/list/
+B:	mailto:linux-samsung-soc@vger.kernel.org
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung.git
 F:	Documentation/devicetree/bindings/pinctrl/samsung,pinctrl*yaml
 F:	drivers/pinctrl/samsung/
@@ -17357,6 +17362,7 @@ M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
+B:	mailto:linux-samsung-soc@vger.kernel.org
 F:	Documentation/devicetree/bindings/sound/samsung*
 F:	sound/soc/samsung/
 
@@ -17401,6 +17407,7 @@ M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
 L:	linux-kernel@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Supported
+B:	mailto:linux-samsung-soc@vger.kernel.org
 F:	Documentation/devicetree/bindings/clock/samsung,s2mps11.yaml
 F:	Documentation/devicetree/bindings/mfd/samsung,s2m*.yaml
 F:	Documentation/devicetree/bindings/mfd/samsung,s5m*.yaml
-- 
2.32.0

