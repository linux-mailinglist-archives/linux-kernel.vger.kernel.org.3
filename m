Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F4EC48D7B3
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbiAMMY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:24:57 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:59352 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234537AbiAMMY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:24:26 -0500
Received: from epcas5p3.samsung.com (unknown [182.195.41.41])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220113122425epoutp04c549595d6da1002de97ba6e3f10b5f8a~J1Abpi7QL2417524175epoutp04F
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:24:25 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220113122425epoutp04c549595d6da1002de97ba6e3f10b5f8a~J1Abpi7QL2417524175epoutp04F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642076665;
        bh=+Lv2u+Y0TlWIo8S2R/i6kuk6KZ1UXBx3Hqi+rQ4pBmA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uBvTUXTxqkD/3i0mVKkBwOpoN/MGsLUUY1y8rKtMtD9jGWCnQzNDeUJPhyfoWPoeW
         TiEgxBAKsN2biCrPoYKy9yNQMupqrCTU5ZgMqzjwTELz6K51sttHWd3E7dR3vUmyjI
         Oe4VlmBbrbQrQ1JIBUEW5edrX7JkCwYe1vJVApyI=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220113122424epcas5p3eca49dba6c4ef51e42d0ef733232eb64~J1AayfEAZ1006210062epcas5p3D;
        Thu, 13 Jan 2022 12:24:24 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JZNsK0wHNz4x9Q9; Thu, 13 Jan
        2022 12:24:21 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        D9.C6.06423.1F910E16; Thu, 13 Jan 2022 21:24:17 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220113122417epcas5p47398a5190cdf4c574c6f1762918b549f~J1AUg3LPF3143231432epcas5p4K;
        Thu, 13 Jan 2022 12:24:17 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220113122417epsmtrp1a0423814f8cb642f851514c078a4cefa~J1AUhkW8B1991219912epsmtrp1a;
        Thu, 13 Jan 2022 12:24:17 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-e7-61e019f14ae9
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.A9.08738.1F910E16; Thu, 13 Jan 2022 21:24:17 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220113122415epsmtip2cffd8df2dc31d7f828fa7c97d630def9~J1ASNhc1-1245412454epsmtip2d;
        Thu, 13 Jan 2022 12:24:15 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com, Shashank Prashar <s.prashar@samsung.com>,
        Aswani Reddy <aswani.reddy@samsung.com>
Subject: [PATCH 15/23] arm64: dts: fsd: Add initial pinctrl support
Date:   Thu, 13 Jan 2022 17:41:35 +0530
Message-Id: <20220113121143.22280-16-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220113121143.22280-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKJsWRmVeSWpSXmKPExsWy7bCmhu5HyQeJBg/2qlg8mLeNzeLQ5q3s
        Fu+X9TBazD9yjtVi49sfTBZT/ixnstj0+Bqrxceee6wWD1+FW1zeNYfNYsb5fUwWp65/ZrNY
        tPULu0Xr3iPsFofftLNazNsxl9Hi8fU/bA6CHmvmrWH0mNXQy+axaVUnm8eda3vYPDYvqfe4
        cqKJ1aNvyypGj39Nc9k9Pm+SC+CMyrbJSE1MSS1SSM1Lzk/JzEu3VfIOjneONzUzMNQ1tLQw
        V1LIS8xNtVVy8QnQdcvMAXpFSaEsMacUKBSQWFyspG9nU5RfWpKqkJFfXGKrlFqQklNgUqBX
        nJhbXJqXrpeXWmJlaGBgZApUmJCd0Xj1AXPBd+eKa1sOsDUwTjTrYuTgkBAwkVjzO6mLkYtD
        SGA3o8SJX9MZIZxPjBIzVi+Ccj4zSrz/exnI4QTr6J+1lRUisYtR4vm3m2wQTguTxLauW+wg
        VWwC2hJ3p29hArFFBNwkbjR2MIEUMQtsZpaYt3w1WEJYwFni8qNbjCCHsAioSpzq5QcJ8wrY
        SvxsXcQGsU1eYvWGA8wgJZxA8bur8kDGSAhs4ZBYsHEvK0SNi8TeHwug6oUlXh3fwg5hS0m8
        7G9jh/gzW6JnlzFEuEZi6bxjLBC2vcSBK3NYQEqYBTQl1u/SBwkzC/BJ9P5+wgTRySvR0SYE
        Ua0q0fzuKlSntMTE7m6oAzwk7q69ygwJhQmMEhu7dzFNYJSdhTB1ASPjKkbJ1ILi3PTUYtMC
        w7zUcng0JefnbmIEp08tzx2Mdx980DvEyMTBeIhRgoNZSYS3v+h+ohBvSmJlVWpRfnxRaU5q
        8SFGU2CATWSWEk3OBybwvJJ4QxNLAxMzMzMTS2MzQyVx3tPpGxKFBNITS1KzU1MLUotg+pg4
        OKUamBrFYtZ4113um2bwKXBN+HLvSaoaN/R4jHLYBT4b7Nk1mdGh/MrHGQU+WXPmtnTM/lBX
        YORwN8dv75KpR19ZVxbZB5iKHVhe7F5/j5n7YaH1iaVfg95uXmMgM79D95Sq8Aszkdg4hrSi
        G/bLJBqS/j/JflSwleHTOrdVx978CHeui+692Fl97EqQ+E2B/pwSlmzPpBYOsSvy585fNohb
        YqzNa8O1nfOqp/dzXrNN3iv85ojOeS0Q4PCnteCyRtjWbUyObafsLhlNL7tz0C5C+Hvblo3z
        Gj8VMik1110+9TJv1RKhRXsevLrZZ/l1+mXxV8YvLvb+Mv0ncvvDqWWTNy3YI8kq5x6yo8WB
        v6SuRomlOCPRUIu5qDgRALkWb6AoBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrFLMWRmVeSWpSXmKPExsWy7bCSvO5HyQeJBr0TOC0ezNvGZnFo81Z2
        i/fLehgt5h85x2qx8e0PJospf5YzWWx6fI3V4mPPPVaLh6/CLS7vmsNmMeP8PiaLU9c/s1ks
        2vqF3aJ17xF2i8Nv2lkt5u2Yy2jx+PofNgdBjzXz1jB6zGroZfPYtKqTzePOtT1sHpuX1Htc
        OdHE6tG3ZRWjx7+muewenzfJBXBGcdmkpOZklqUW6dslcGU0Xn3AXPDdueLalgNsDYwTzboY
        OTkkBEwk+mdtZe1i5OIQEtjBKLG37zkjREJa4vrGCewQtrDEyn/P2SGKmpgk1i+5zgaSYBPQ
        lrg7fQsTiC0i4CHR9u8eM0gRs8BhZolXz7azgCSEBZwlLj+6BTSVg4NFQFXiVC8/SJhXwFbi
        Z+siNogF8hKrNxxgBinhBIrfXZUHEhYSsJE492o92wRGvgWMDKsYJVMLinPTc4sNC4zyUsv1
        ihNzi0vz0vWS83M3MYKDX0trB+OeVR/0DjEycTAeYpTgYFYS4e0vup8oxJuSWFmVWpQfX1Sa
        k1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwTB6dUA1OqaZNs9v83x6c9+9lwr/D5iyl8
        GyfHngpc6SGmJnmIxVJJ9UK2r9flqjMKb3YuvpD/7cVXsSUdtrZ6j44on5+wxE9Op2Ut15Gv
        Jd1fIldV7bjb/4s55+NSvbb7zNIpjbMX/03zjnr5calgv49PyM1Ku7dMYna1Jjobz0y+8+Ru
        Vt2iqbptukaPDZvNarLCb7G+7nmqekf4Sp3N7dPP4hd65z96y/CR+ZPoPvYTgTktN518def+
        jorIt79wt1HY4ezKduuDyeaWPKqTPu2d8LTgnXzMPrk5ZYsE52j0LA+PPu1eam6g2qPAtkcp
        J++xB/OU6fYlRdaNvw5HKtl+2ZNov+Pf4WtuaiX9Fw3spyuxFGckGmoxFxUnAgByxDjH7QIA
        AA==
X-CMS-MailID: 20220113122417epcas5p47398a5190cdf4c574c6f1762918b549f
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122417epcas5p47398a5190cdf4c574c6f1762918b549f
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
        <CGME20220113122417epcas5p47398a5190cdf4c574c6f1762918b549f@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial pin configuration nodes for FSD SoC.

Cc: linux-fsd@tesla.com
Signed-off-by: Shashank Prashar <s.prashar@samsung.com>
Signed-off-by: Aswani Reddy <aswani.reddy@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi | 338 +++++++++++++++++++++
 arch/arm64/boot/dts/tesla/fsd.dtsi         |  22 ++
 2 files changed, 360 insertions(+)
 create mode 100644 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi

diff --git a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
new file mode 100644
index 000000000000..ec8d944af636
--- /dev/null
+++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
@@ -0,0 +1,338 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Tesla Full Self-Driving SoC device tree source
+ *
+ * Copyright (c) 2017-2021 Samsung Electronics Co., Ltd.
+ *		https://www.samsung.com
+ * Copyright (c) 2017-2021 Tesla, Inc.
+ *		https://www.tesla.com
+ */
+
+#include <dt-bindings/pinctrl/samsung.h>
+
+&pinctrl_fsys0 {
+
+	gpf0: gpf0 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpf1: gpf1 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpf6: gpf6 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpf4: gpf4 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpf5: gpf5 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+};
+
+&pinctrl_peric {
+
+	gpc8: gpc8 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpf2: gpf2 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpf3: gpf3 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpd0: gpd0 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpb0: gpb0 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpb1: gpb1 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpb4: gpb4 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpb5: gpb5 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpb6: gpb6 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpb7: gpb7 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpd1: gpd1 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpd2: gpd2 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpd3: gpd3 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpg0: gpg0 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpg1: gpg1 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpg2: gpg2 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpg3: gpg3 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpg4: gpg4 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpg5: gpg5 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpg6: gpg6 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpg7: gpg7 {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	pwm0_out: pwm0-out {
+		samsung,pins = "gpb6-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV2>;
+	};
+
+	pwm1_out: pwm1-out {
+		samsung,pins = "gpb6-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV2>;
+	};
+
+	hs_i2c0_bus: hs-i2c0-bus {
+		samsung,pins = "gpb0-0", "gpb0-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	hs_i2c1_bus: hs-i2c1-bus {
+		samsung,pins = "gpb0-2", "gpb0-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	hs_i2c2_bus: hs-i2c2-bus {
+		samsung,pins = "gpb0-4", "gpb0-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	hs_i2c3_bus: hs-i2c3-bus {
+		samsung,pins = "gpb0-6", "gpb0-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	hs_i2c4_bus: hs-i2c4-bus {
+		samsung,pins = "gpb1-0", "gpb1-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	hs_i2c5_bus: hs-i2c5-bus {
+		samsung,pins = "gpb1-2", "gpb1-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	hs_i2c6_bus: hs-i2c6-bus {
+		samsung,pins = "gpb1-4", "gpb1-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	hs_i2c7_bus: hs-i2c7-bus {
+		samsung,pins = "gpb1-6", "gpb1-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	uart0_data: uart0-data {
+		samsung,pins = "gpb7-0", "gpb7-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	uart1_data: uart1-data {
+		samsung,pins = "gpb7-4", "gpb7-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	spi0_bus: spi0-bus {
+		samsung,pins = "gpb4-0", "gpb4-2", "gpb4-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	spi1_bus: spi1-bus {
+		samsung,pins = "gpb4-4", "gpb4-6", "gpb4-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	spi2_bus: spi2-bus {
+		samsung,pins = "gpb5-0", "gpb5-2", "gpb5-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+};
+
+&pinctrl_pmu {
+
+	gpq0: gpq0 {
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
index 47cd9f20566e..811186e5ba4d 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -29,6 +29,9 @@
 		hsi2c5 = &hsi2c_5;
 		hsi2c6 = &hsi2c_6;
 		hsi2c7 = &hsi2c_7;
+		pinctrl0 = &pinctrl_fsys0;
+		pinctrl1 = &pinctrl_peric;
+		pinctrl2 = &pinctrl_pmu;
 	};
 
 	cpus {
@@ -711,5 +714,24 @@
 			clock-names = "hsi2c";
 			status = "disabled";
 		};
+
+		pinctrl_fsys0: pinctrl@15020000 {
+			compatible = "tesla,fsd-pinctrl";
+			reg = <0x0 0x15020000 0x0 0x1000>;
+			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pinctrl_peric: pinctrl@141F0000 {
+			compatible = "tesla,fsd-pinctrl";
+			reg = <0x0 0x141F0000 0x0 0x1000>;
+			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pinctrl_pmu: pinctrl@114F0000 {
+			compatible = "tesla,fsd-pinctrl";
+			reg = <0x0 0x114F0000 0x0 0x1000>;
+		};
 	};
 };
+
+#include "fsd-pinctrl.dtsi"
-- 
2.17.1

