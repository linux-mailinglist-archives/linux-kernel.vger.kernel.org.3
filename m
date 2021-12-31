Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310A24824E4
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 17:22:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229747AbhLaQWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 11:22:13 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:46736
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229575AbhLaQWM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 11:22:12 -0500
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com [209.85.208.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 441B63FFD0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 16:22:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640967731;
        bh=vwFJRx2gAmVsM2SjiJl4digFkX/7ORkgzXaTv+w0Ivo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=hpxgekz8NkXlGlghY0JTiGLu63GmvGZBt+Uj01P0AuEcFDINVXN6ORuoNa/vCmX76
         VdXEo9+Iu8jbLNHEyygRATY/KvBQWVCuImFb6nruQYoh9VXTh8JkJSELNOI5AIH8sX
         K3hc+DNbnm3W66MUMqQZdZhf0NjnySrjr1NZxtJq18erl7YV8PV4U0X4nQiNwhz+nG
         TEbmrXSXRRUl4k257jiDi2KzlYCa72u1kgk9mx86e64Gn4MrBCimZHmXjovIxw8Nqv
         6/e1hwhlbhQ7XPuBb7Hchjq/Izc/hbL30AUnzYtIMhudMwdqg6AuFkcYG/PjeZDqkk
         YDMcHHPKNTEBg==
Received: by mail-lj1-f200.google.com with SMTP id k11-20020a05651c0a0b00b0022dc4d55f14so6495792ljq.22
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 08:22:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vwFJRx2gAmVsM2SjiJl4digFkX/7ORkgzXaTv+w0Ivo=;
        b=aW6SLCV7/8/PkKWvP/JB/IDPOf5eAB1XBj7tDqftvjtEwmXjcZuWm9/Z3v4WLDPE52
         dQbPjDfeGuMbVj+sNh6lzs5wq+l5H07kTcCI6P9Twwmq89ID0N9S+JtZQc1bOjPpR8wH
         tyFNFFCfgUYZ+jwwzB1kLSbOOK1+UUQC12f0dXhH0xoM73kkUQFbpn1nAM8Onf2ebY5d
         g2W79Vs+cFrEy0jo5GjRcMxRzh1dZchMNZWJebVMBzShbyE8v5N1JBzS8/r6eFjydMIV
         lpst9A4ix8X5WfMKQJiFxKi88frtkGxBaIydMnypZEW3IcPYhp8WT4XxO74bdmJVDwYA
         JwNQ==
X-Gm-Message-State: AOAM531liL+2BjlclSMnMnmU9PPQnVOALahoGLKadBSLmIW6/pQJEJqJ
        12wd4J0iV4Rqt2fej5g0JFgi+jZPTlRPJ0h9HoLaKoGMXt/DHTYLFObQe8X/KEyNNW9mrypuxFA
        itVw1eYRI9rhn+s3G3LvOBQje1zmKzLcxzqweKk+A4w==
X-Received: by 2002:a2e:a406:: with SMTP id p6mr24918857ljn.13.1640967730327;
        Fri, 31 Dec 2021 08:22:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzRePFA1r4rMy5Stjb0m7lcPfHvozVux5rIote82Iw0v7IO7g4e2eHmUiX9FdO04m0djEyVQQ==
X-Received: by 2002:a2e:a406:: with SMTP id p6mr24918843ljn.13.1640967730180;
        Fri, 31 Dec 2021 08:22:10 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id y36sm2796514lfa.75.2021.12.31.08.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Dec 2021 08:22:09 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <snawrocki@kernel.org>,
        Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>
Subject: [PATCH 07/24] ARM: dts: exynos: override pins by label in Peach Pi
Date:   Fri, 31 Dec 2021 17:21:50 +0100
Message-Id: <20211231162207.257478-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211231161930.256733-1-krzysztof.kozlowski@canonical.com>
References: <20211231161930.256733-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using node paths to extend or override a device tree node is error
prone.  If there was a typo error, a new node will be created instead of
extending the existing node.  This will lead to run-time errors that
could be hard to detect.

A mistyped label on the other hand, will cause a dtc compile error
(during build time).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 arch/arm/boot/dts/exynos5800-peach-pi.dts | 33 +++++++++++------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 77013ee586f8..6bf3fd37fb2b 100644
--- a/arch/arm/boot/dts/exynos5800-peach-pi.dts
+++ b/arch/arm/boot/dts/exynos5800-peach-pi.dts
@@ -850,27 +850,26 @@ pmic_dvs_1: pmic-dvs-1 {
 	};
 };
 
-&pinctrl_1 {
-	/* Adjust WiFi drive strengths lower for EMI */
-	sd1_clk: sd1-clk {
-		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
-	};
+/* pinctrl_1 */
+/* Adjust WiFi drive strengths lower for EMI */
+&sd1_bus1 {
+	samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
+};
 
-	sd1_cmd: sd1-cmd {
-		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
-	};
+&sd1_bus4 {
+	samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
+};
 
-	sd1_bus1: sd1-bus-width1 {
-		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
-	};
+&sd1_bus8 {
+	samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
+};
 
-	sd1_bus4: sd1-bus-width4 {
-		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
-	};
+&sd1_clk {
+	samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
+};
 
-	sd1_bus8: sd1-bus-width8 {
-		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
-	};
+&sd1_cmd {
+	samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
 };
 
 &pinctrl_2 {
-- 
2.32.0

