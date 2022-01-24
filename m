Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24D2C4980B7
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 14:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240074AbiAXNOY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 08:14:24 -0500
Received: from h04mx16.reliablemail.org ([185.76.67.209]:45098 "EHLO
        h04mx16.reliablemail.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229833AbiAXNOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 08:14:19 -0500
X-Halon-Out: 884e704f-7d17-11ec-a232-556aad082471
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=grimler.se;
        s=default; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=mm2pUntQ1RReK8eDtE3PYZHVckYe32J9ioqItg/b08Q=; b=ai8y772DSqaDQIEBOrGxDf+V85
        8d5MSrrhAN7xfPwpOEsYw/qQjJTxkiTjb7U5Bq+opeisaqXwfT3h0P9phdHisRMjBEeXVw7cj5YbU
        VEAkQHmM2+pmsyoHW2DIAILWecY0vzLIKYdFdmfazDl5ySqKcN8ZNX0weaRTzuMxyqIwWL/jowehI
        OIJuvfTUWgOrtD0gkbOeyoZrOTl0HIjtFXKqxK0OzOuPq5NqxZ5X5rrCLLTYrtL/BxDkSxA/WLXVO
        +8ZlQzpMHvUfExZuXdBDbKM6pQGZSKT1KGWu7UFeyB3ADhunPaN6ggV0vAFHl8G9Qzh+ixe+oVXRL
        WLC/n8Eg==;
From:   Henrik Grimler <henrik@grimler.se>
To:     krzysztof.kozlowski@canonical.com, semen.protsenko@linaro.org,
        virag.david003@gmail.com, cw00.choi@samsung.com,
        m.szyprowski@samsung.com, alim.akhtar@samsung.com,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
Cc:     Henrik Grimler <henrik@grimler.se>
Subject: [PATCH 2/2] ARM: dts: exynos: Add support for Samsung Klimt WiFi
Date:   Mon, 24 Jan 2022 14:12:41 +0100
Message-Id: <20220124131241.29946-3-henrik@grimler.se>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124131241.29946-1-henrik@grimler.se>
References: <20220124131241.29946-1-henrik@grimler.se>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpsrv07.misshosting.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - grimler.se
X-Get-Message-Sender-Via: cpsrv07.misshosting.com: authenticated_id: henrik@grimler.se
X-Authenticated-Sender: cpsrv07.misshosting.com: henrik@grimler.se
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Klimt WiFi has the product name Samsung Galaxy Tab S 8.4".  Board is
based on Exynos 5420, and has similar hardware to Chagall WiFi, but
with a smaller battery, smaller screen and another touchscreen
controller.

The device tree added here contains support for:

- UART access through a micro-usb cable with 619 kOhm between ID & GND
- Accessing the internal eMMC storage
- Accessing an external SD card
- USB, after configuration it is possible to ssh into the device
  through a usb cable

Signed-off-by: Henrik Grimler <henrik@grimler.se>
---
 arch/arm/boot/dts/Makefile                  |  1 +
 arch/arm/boot/dts/exynos5420-klimt-wifi.dts | 75 +++++++++++++++++++++
 2 files changed, 76 insertions(+)
 create mode 100644 arch/arm/boot/dts/exynos5420-klimt-wifi.dts

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 28fbfda94cb9..21c4a3ad068a 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -222,6 +222,7 @@ dtb-$(CONFIG_ARCH_EXYNOS5) += \
 	exynos5420-peach-pit.dtb \
 	exynos5420-smdk5420.dtb \
 	exynos5420-chagall-wifi.dtb \
+	exynos5420-klimt-wifi.dtb \
 	exynos5422-odroidhc1.dtb \
 	exynos5422-odroidxu3.dtb \
 	exynos5422-odroidxu3-lite.dtb \
diff --git a/arch/arm/boot/dts/exynos5420-klimt-wifi.dts b/arch/arm/boot/dts/exynos5420-klimt-wifi.dts
new file mode 100644
index 000000000000..011787b1bbf0
--- /dev/null
+++ b/arch/arm/boot/dts/exynos5420-klimt-wifi.dts
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Samsung's Exynos5420 Klimt WiFi board device tree source
+ *
+ * Copyright (c) 2012-2013 Samsung Electronics Co., Ltd.
+ *		http://www.samsung.com
+ * Copyright (c) 2022 Henrik Grimler
+ */
+
+/dts-v1/;
+#include "exynos5420-galaxy-tab-common.dtsi"
+
+/ {
+	model = "Samsung Klimt WiFi based on Exynos5420";
+	compatible = "samsung,klimt-wifi", "samsung,exynos5420", \
+		     "samsung,exynos5";
+};
+
+&ldo15_reg {
+	/* Unused */
+	regulator-name = "VDD_LDO15";
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+};
+
+&ldo17_reg {
+	regulator-name = "VDD_VCI_3V0";
+	regulator-min-microvolt = <3000000>;
+	regulator-max-microvolt = <3000000>;
+
+	regulator-state-mem {
+		regulator-off-in-suspend;
+	};
+};
+
+&ldo28_reg {
+	regulator-name = "VDD3_1V8";
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+
+	regulator-state-mem {
+		regulator-off-in-suspend;
+	};
+};
+
+&ldo29_reg {
+	regulator-name = "VDDR_1V6";
+	regulator-min-microvolt = <1600000>;
+	regulator-max-microvolt = <1600000>;
+
+	regulator-state-mem {
+		regulator-off-in-suspend;
+	};
+};
+
+&ldo31_reg {
+	/* Unused */
+	regulator-name = "VDD_LDO31";
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+};
+
+&ldo32_reg {
+	regulator-name = "VDD_TSP_1V8";
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
+
+	regulator-state-mem {
+		regulator-off-in-suspend;
+	};
+};
+
+&mmc_2 {
+	sd-uhs-sdr104;
+};
-- 
2.34.1

