Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91BDA48B82C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 21:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243253AbiAKUSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 15:18:04 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:37956
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242670AbiAKUSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 15:18:01 -0500
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 547F43F207
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 20:18:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1641932280;
        bh=f1qMe2q4bQb9vAN5Va2rmaS1xtzTeEdfoCaKBOlA8Q8=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=vsxrW2IIUWyPx2ftWmuVSz9p5cim0iGvf7LBjz/9WTExU7TX2q2BlBd9Ml/ZfGeyX
         7WjO8vV166udcbDehFiEG2zABQr76N4lvX82XtFfWoi2bjhMTxTqPd4Tjo1OzY/q1G
         iNE0zEyrTBUV65XXg4qulASvfy4o79UPhUVKnQmXPjGZdiBzsX+FLuFThLW/V+YA9v
         4clEeqMCAgwvalWCxLukWLDf7aXIZ6uGZrK0geyhzItLCsj0SbpKUtaapA4KtF0ghx
         2e547Fi1XqscfHNkowWaAqy3KkcPd7J8JfuJgQtXCwhPdSKUoSrJl722SLLMphFXga
         tFqLEzJsbzOzw==
Received: by mail-ed1-f71.google.com with SMTP id v18-20020a056402349200b003f8d3b7ee8dso145728edc.23
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 12:18:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f1qMe2q4bQb9vAN5Va2rmaS1xtzTeEdfoCaKBOlA8Q8=;
        b=I1qN+SJCFFhIc+/8zomjpx2tulN+cFn3ZAZ/dwcOmL4KMstaB4xTDm5lxGjxys+P8k
         /A2uSN35/ToNWcKNmbEkwOhuJRyweG3IEZcK2sGCU6hXoco9ZRU+nets3MHNOs6lAGDe
         8UByFTXkkeLm33/Q7Qc2YMIpNioth6dpHX4o4mPpQneUR5fPq7wp+IQIs9mipaWfuv5t
         it6PgMK2m0BP4+FwpbtwpxWRID91a2fl3wCafZoCVgFBuBzVnNJzlp+Mflbg+jAcVyum
         Gw84srmXmi5qcZeugjE7KRRrpfG7RNFgXXGpFknoOIu6iHXk7EspytyIbpoa9jdzUX9H
         5y7w==
X-Gm-Message-State: AOAM533AwSCYG3v0D2RkADzgW0nynW7o9bJcD2KMLiqDqfkFTPrYE7Y7
        7XeqCojkkvV7v6m2Banjwq2cEqnMbNtCAXLyOWvNEt+jAOzjFpu+1OGQnsZKTqzl6PpIk2ylJau
        1aKnOri2NVhaUrIWVqogxQcuIjKrAGn5Cygu7JHrKkw==
X-Received: by 2002:aa7:d5c7:: with SMTP id d7mr5790037eds.280.1641932279833;
        Tue, 11 Jan 2022 12:17:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw8HfjCHSAc02A1Wovc4axvjEkvATdmIS2ObWKkbyhU8cwK6hwoJNYl/D1QeZ+kuoR7zi9+mw==
X-Received: by 2002:aa7:d5c7:: with SMTP id d7mr5790015eds.280.1641932279637;
        Tue, 11 Jan 2022 12:17:59 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id e4sm4030881ejs.13.2022.01.11.12.17.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 12:17:59 -0800 (PST)
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
        Sam Protsenko <semen.protsenko@linaro.org>,
        Chanho Park <chanho61.park@samsung.com>,
        Alim Akhtar <alim.akhtar@gmail.com>,
        Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH v2 07/28] ARM: dts: exynos: override pins by label in Peach Pi
Date:   Tue, 11 Jan 2022 21:17:01 +0100
Message-Id: <20220111201722.327219-1-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220111201426.326777-1-krzysztof.kozlowski@canonical.com>
References: <20220111201426.326777-1-krzysztof.kozlowski@canonical.com>
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
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm/boot/dts/exynos5800-peach-pi.dts | 44 +++++++++++------------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5800-peach-pi.dts b/arch/arm/boot/dts/exynos5800-peach-pi.dts
index 77013ee586f8..01f310f387d6 100644
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
@@ -889,12 +888,13 @@ pmic_dvs_3: pmic-dvs-3 {
 	};
 };
 
-&pinctrl_3 {
-	/* Drive SPI lines at x2 for better integrity */
-	spi2-bus {
-		samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
-	};
+/* pinctrl_3*/
+/* Drive SPI lines at x2 for better integrity */
+&spi2_bus {
+	samsung,pin-drv = <EXYNOS5420_PIN_DRV_LV3>;
+};
 
+&pinctrl_3 {
 	/* Drive SPI chip select at x2 for better integrity */
 	ec_spi_cs: ec-spi-cs {
 		samsung,pins = "gpb1-2";
-- 
2.32.0

