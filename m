Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34B684824DE
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 17:20:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231361AbhLaQUa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 11:20:30 -0500
Received: from smtp-relay-internal-0.canonical.com ([185.125.188.122]:54966
        "EHLO smtp-relay-internal-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231315AbhLaQUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 11:20:23 -0500
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com [209.85.208.199])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 5BE9B3FFDE
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 16:20:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1640967622;
        bh=TH0oF15Kc0CqVuAFXtLabbq4xKOXn0YXSWaECUHYifY=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=YZVm5g6pme1n2hLN7VX+sfwmwgaO2ZSnXHBZ7kJX9czFXc8S/k98BjoqAzrsfsfCs
         eMfHu0WqJxPidma3hgEPqhG3NoUOzECEiKfA0HHppRj2XuRA8P1DB6v3j8c8kOV+Er
         fSK7zmayKhdxpHPeXc4UfmPX7GkljROV5nsfIyBHMxn4A99inERhM/nYv04ti6H1ID
         XJ7oAid/i/Ek7PhToN3hg6mX8qEVVy+6MEdKvXLyQW7iiSDQqJew/YhkfgbjDwQ49h
         42Ovslwb5wNzGI1GuhwcLi12BCZt8azCIDax1KyotqenYns+lftu4B++063EFDyu+F
         usdigZWctboYA==
Received: by mail-lj1-f199.google.com with SMTP id s11-20020a05651c048b00b0022d8722e7b5so3896143ljc.23
        for <linux-kernel@vger.kernel.org>; Fri, 31 Dec 2021 08:20:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TH0oF15Kc0CqVuAFXtLabbq4xKOXn0YXSWaECUHYifY=;
        b=rUyeFBp5z73St9PNecI8e0+y0UApSywE3U52NbtfzmyWryNwVDioKYIbZW+rFKhdaL
         Q5iMknoljJ3A6BET6It3bqTapCkDLgx61hX6r+O5zOSmSgQ3joXbJF9sNr5eYnh9Ng5S
         lknO03Tdd4kLntuQXTulgvhJlErjC1wk6Tksrwdxkq2/zRp0c+fN4zGkqP3Ec67zZ8+T
         PD9AuCh8zHaV8tj2myR57GxOCk2VcHF7m7kS5tR+NYaNMypGRv9FmsEzzmw6IavaI0rZ
         6imnywa7xRi3RGcr950+VSln9OSSDhF0JBxNIt7UVgnDeN2T2Z5ynia9kesomF5u56Pk
         wpxA==
X-Gm-Message-State: AOAM533UH1BGaFlg2x9vbNluy6pekZLKvnWgqXj82Cd13ckb2fA8NBWE
        nS3+14hQT/xVaXnahOZhyvQFGUWrlI3VgOZOR2O9z+oJ4QZPtX9JFUpCkKqUj9ZPcgYjtGfght9
        rifv+4/JvgeSnGx+RdwRT+LlGjEM2HpgvvetJE4hHow==
X-Received: by 2002:a05:6512:50c:: with SMTP id o12mr31325051lfb.41.1640967620200;
        Fri, 31 Dec 2021 08:20:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxMqE/akwbQRGAl1EyK9nwLMn8n/FHmUvm7r3qWQZB4T8laq8h6qcWctul6RIR1PWEOXiId6w==
X-Received: by 2002:a05:6512:50c:: with SMTP id o12mr31325047lfb.41.1640967620036;
        Fri, 31 Dec 2021 08:20:20 -0800 (PST)
Received: from krzk-bin.lan (89-77-68-124.dynamic.chello.pl. [89.77.68.124])
        by smtp.gmail.com with ESMTPSA id bx10sm2817607ljb.3.2021.12.31.08.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Dec 2021 08:20:19 -0800 (PST)
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
Subject: [PATCH 05/24] ARM: dts: exynos: override pins by label in Peach Pit
Date:   Fri, 31 Dec 2021 17:19:11 +0100
Message-Id: <20211231161930.256733-6-krzysztof.kozlowski@canonical.com>
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
 arch/arm/boot/dts/exynos5420-peach-pit.dts | 44 +++++++++++-----------
 1 file changed, 22 insertions(+), 22 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420-peach-pit.dts b/arch/arm/boot/dts/exynos5420-peach-pit.dts
index e76fb104db19..1ae5528e9ebf 100644
--- a/arch/arm/boot/dts/exynos5420-peach-pit.dts
+++ b/arch/arm/boot/dts/exynos5420-peach-pit.dts
@@ -868,27 +868,26 @@ pmic_dvs_1: pmic-dvs-1 {
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
@@ -907,12 +906,13 @@ pmic_dvs_3: pmic-dvs-3 {
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

