Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28264EBBF6
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 09:43:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243939AbiC3Hm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 03:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243914AbiC3HmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 03:42:20 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7AC527DD
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 00:40:30 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id a17so23361977edm.9
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 00:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K0TapJUDp+25n96S2Rvm1oOBLQpsFgFgNuoC0qnYJ0k=;
        b=JOXwr8XrMosjbmTi4wZCsHgLWaDheNwC3HmHs+E80tQrcyaRJmRgJCaJOe+242laQd
         itruntcOH4kFLNAY1CbTgyQo2lnhnW4LccmPucGgzkoWOc6DteS2ffVqgyqHb+9GHV5Z
         WW1uSiEnQYKO39V4lwHmwr0XIiWngz2YM3L/2mha2vMoy4Q+MiZli3w733aPOOYuPmje
         8/bAbPqii5DihVOrQa/SDDTWwu3C0Dq2sKVjBOoKNS5NVFG97R5tJwhLfnV8LecwjTD7
         jIxvwCCQuW+42SPB8/Geq8ap0xfLzhr4btnjLm99EDOUuGE0xLEXUuqVFPNkcXZgnqQt
         plPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K0TapJUDp+25n96S2Rvm1oOBLQpsFgFgNuoC0qnYJ0k=;
        b=X8jhztrioxhmfq8mdVeCjiZbVi2dDZKohEHA1ElQR/RZtrkJ2iaazlzKBgvcP+zcWP
         sCFikqZjyDaS+LNQ4Zyi2meJ3YiTUm03MCQZiwXAhx1ZyAwBO7rpwWdM2e8Z/Sn1LwOg
         soXFRTY13Jl83pxmn9+iO84F26KbUIHB1S5iYXrgnk9XL51PieZo64G9QmT+2jihZ5qA
         0+5/k4llqqfmZLRy9CH2K5OQ5bOgW8HFmADuITQYGtaN9bvMKIoj12Z6uIaPTcqsCyXw
         XFHCbEv+yS94gkAH6bLSyWXYxnCiDsBciUdTkAHBNRQBNDjhW+LCSE6d3/v5mpsg4Yx+
         MNdw==
X-Gm-Message-State: AOAM5303LQNMh/uTUVNw0Prqd/uP4Yl+8n6EPc4DWu/peSYpAh3gE4M9
        KNNVEOw2BsFkYPMx8Js6EsH7gw==
X-Google-Smtp-Source: ABdhPJxX2a77lTbmJsmGT6vz+aiaUF7cvGkI4zGY0wGiSBBFUAqLdCq7yx8ylYgRn3CuDhwO8jrWUA==
X-Received: by 2002:a05:6402:4491:b0:419:4aeb:a648 with SMTP id er17-20020a056402449100b004194aeba648mr9149037edb.411.1648626028831;
        Wed, 30 Mar 2022 00:40:28 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id s20-20020a056402015400b00418f9574a36sm9536640edu.73.2022.03.30.00.40.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Mar 2022 00:40:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nfc@lists.01.org,
        netdev@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Olof Johansson <olof@lixom.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/2] MAINTAINERS: update Krzysztof Kozlowski's email to Linaro
Date:   Wed, 30 Mar 2022 09:40:16 +0200
Message-Id: <20220330074016.12896-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220330074016.12896-1-krzysztof.kozlowski@linaro.org>
References: <20220330074016.12896-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Krzysztof Kozlowski <krzk@kernel.org>

Use Krzysztof Kozlowski's @linaro.org account in maintainer entries.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 MAINTAINERS | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 39930351885a..1508ee5887a4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2634,7 +2634,7 @@ F:	sound/soc/rockchip/
 N:	rockchip
 
 ARM/SAMSUNG S3C, S5P AND EXYNOS ARM ARCHITECTURES
-M:	Krzysztof Kozlowski <krzk@kernel.org>
+M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 R:	Alim Akhtar <alim.akhtar@samsung.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-samsung-soc@vger.kernel.org
@@ -11888,7 +11888,7 @@ F:	drivers/iio/proximity/mb1232.c
 
 MAXIM MAX17040 FAMILY FUEL GAUGE DRIVERS
 R:	Iskren Chernev <iskren.chernev@gmail.com>
-R:	Krzysztof Kozlowski <krzk@kernel.org>
+R:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 R:	Marek Szyprowski <m.szyprowski@samsung.com>
 R:	Matheus Castello <matheus@castello.eng.br>
 L:	linux-pm@vger.kernel.org
@@ -11898,7 +11898,7 @@ F:	drivers/power/supply/max17040_battery.c
 
 MAXIM MAX17042 FAMILY FUEL GAUGE DRIVERS
 R:	Hans de Goede <hdegoede@redhat.com>
-R:	Krzysztof Kozlowski <krzk@kernel.org>
+R:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 R:	Marek Szyprowski <m.szyprowski@samsung.com>
 R:	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>
 R:	Purism Kernel Team <kernel@puri.sm>
@@ -11950,7 +11950,7 @@ F:	Documentation/devicetree/bindings/power/supply/maxim,max77976.yaml
 F:	drivers/power/supply/max77976_charger.c
 
 MAXIM MUIC CHARGER DRIVERS FOR EXYNOS BASED BOARDS
-M:	Krzysztof Kozlowski <krzk@kernel.org>
+M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
 L:	linux-pm@vger.kernel.org
 S:	Supported
@@ -11961,7 +11961,7 @@ F:	drivers/power/supply/max77693_charger.c
 
 MAXIM PMIC AND MUIC DRIVERS FOR EXYNOS BASED BOARDS
 M:	Chanwoo Choi <cw00.choi@samsung.com>
-M:	Krzysztof Kozlowski <krzk@kernel.org>
+M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
 L:	linux-kernel@vger.kernel.org
 S:	Supported
@@ -12655,7 +12655,7 @@ F:	mm/memblock.c
 F:	tools/testing/memblock/
 
 MEMORY CONTROLLER DRIVERS
-M:	Krzysztof Kozlowski <krzk@kernel.org>
+M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git
@@ -13798,7 +13798,7 @@ F:	include/uapi/linux/nexthop.h
 F:	net/ipv4/nexthop.c
 
 NFC SUBSYSTEM
-M:	Krzysztof Kozlowski <krzk@kernel.org>
+M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 L:	linux-nfc@lists.01.org (subscribers-only)
 L:	netdev@vger.kernel.org
 S:	Maintained
@@ -14112,7 +14112,7 @@ F:	Documentation/devicetree/bindings/regulator/nxp,pf8x00-regulator.yaml
 F:	drivers/regulator/pf8x00-regulator.c
 
 NXP PTN5150A CC LOGIC AND EXTCON DRIVER
-M:	Krzysztof Kozlowski <krzk@kernel.org>
+M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/extcon/extcon-ptn5150.yaml
@@ -14660,7 +14660,7 @@ F:	scripts/dtc/
 
 OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS
 M:	Rob Herring <robh+dt@kernel.org>
-M:	Krzysztof Kozlowski <krzk+dt@kernel.org>
+M:	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
 L:	devicetree@vger.kernel.org
 S:	Maintained
 C:	irc://irc.libera.chat/devicetree
@@ -15572,7 +15572,7 @@ F:	drivers/pinctrl/renesas/
 
 PIN CONTROLLER - SAMSUNG
 M:	Tomasz Figa <tomasz.figa@gmail.com>
-M:	Krzysztof Kozlowski <krzk@kernel.org>
+M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
 R:	Alim Akhtar <alim.akhtar@samsung.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
@@ -17251,7 +17251,7 @@ W:	http://www.ibm.com/developerworks/linux/linux390/
 F:	drivers/s390/scsi/zfcp_*
 
 S3C ADC BATTERY DRIVER
-M:	Krzysztof Kozlowski <krzk@kernel.org>
+M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 L:	linux-samsung-soc@vger.kernel.org
 S:	Odd Fixes
 F:	drivers/power/supply/s3c_adc_battery.c
@@ -17296,7 +17296,7 @@ F:	Documentation/admin-guide/LSM/SafeSetID.rst
 F:	security/safesetid/
 
 SAMSUNG AUDIO (ASoC) DRIVERS
-M:	Krzysztof Kozlowski <krzk@kernel.org>
+M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 M:	Sylwester Nawrocki <s.nawrocki@samsung.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 S:	Supported
@@ -17304,7 +17304,7 @@ F:	Documentation/devicetree/bindings/sound/samsung*
 F:	sound/soc/samsung/
 
 SAMSUNG EXYNOS PSEUDO RANDOM NUMBER GENERATOR (RNG) DRIVER
-M:	Krzysztof Kozlowski <krzk@kernel.org>
+M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 L:	linux-crypto@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
@@ -17339,7 +17339,7 @@ S:	Maintained
 F:	drivers/platform/x86/samsung-laptop.c
 
 SAMSUNG MULTIFUNCTION PMIC DEVICE DRIVERS
-M:	Krzysztof Kozlowski <krzk@kernel.org>
+M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
 L:	linux-kernel@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
@@ -17365,7 +17365,7 @@ F:	drivers/media/platform/samsung/s3c-camif/
 F:	include/media/drv-intf/s3c_camif.h
 
 SAMSUNG S3FWRN5 NFC DRIVER
-M:	Krzysztof Kozlowski <krzk@kernel.org>
+M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 M:	Krzysztof Opasiak <k.opasiak@samsung.com>
 L:	linux-nfc@lists.01.org (subscribers-only)
 S:	Maintained
@@ -17387,7 +17387,7 @@ S:	Supported
 F:	drivers/media/i2c/s5k5baf.c
 
 SAMSUNG S5P Security SubSystem (SSS) DRIVER
-M:	Krzysztof Kozlowski <krzk@kernel.org>
+M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 M:	Vladimir Zapolskiy <vz@mleia.com>
 L:	linux-crypto@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
@@ -17422,7 +17422,7 @@ F:	include/linux/clk/samsung.h
 F:	include/linux/platform_data/clk-s3c2410.h
 
 SAMSUNG SPI DRIVERS
-M:	Krzysztof Kozlowski <krzk@kernel.org>
+M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 M:	Andi Shyti <andi@etezian.org>
 L:	linux-spi@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
@@ -17440,7 +17440,7 @@ F:	drivers/net/ethernet/samsung/sxgbe/
 
 SAMSUNG THERMAL DRIVER
 M:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
-M:	Krzysztof Kozlowski <krzk@kernel.org>
+M:	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 L:	linux-pm@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
-- 
2.32.0

