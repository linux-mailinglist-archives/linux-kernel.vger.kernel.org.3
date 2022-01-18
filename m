Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A2F492956
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 16:03:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345760AbiARPC1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 10:02:27 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:52251 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344337AbiARPBW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 10:01:22 -0500
Received: from epcas5p2.samsung.com (unknown [182.195.41.40])
        by mailout3.samsung.com (KnoxPortal) with ESMTP id 20220118150120epoutp038e295973bf4de8a108448ae734a67ceb~LZX32t7102377123771epoutp03N
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 15:01:20 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20220118150120epoutp038e295973bf4de8a108448ae734a67ceb~LZX32t7102377123771epoutp03N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642518080;
        bh=cFglFcscCWE+020B++Ruw/fvkQKIuXEhLC01z6Pd9BU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JmgfCPXWZUThx7bLy72JdBoKlrSaCJyw4tD+zCCtwf3xiPuXWxfWN3yM0fjMlOkPI
         Ud4oY6BdtTCBRsQnUx8cR1Jh9S1pwR3DebeZu5FyNzLzEkKQDs4HRCt7n5S4Q2X8MF
         9CPXF+Dnu7zsXjVElj+qIgz5wxqfTtECp6Rwq37w=
Received: from epsnrtp4.localdomain (unknown [182.195.42.165]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTP id
        20220118150120epcas5p3fe4f040e63c7f8e55dbe6b3a44528e3d~LZX3TOd_I2302623026epcas5p3B;
        Tue, 18 Jan 2022 15:01:20 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.175]) by
        epsnrtp4.localdomain (Postfix) with ESMTP id 4JdX610QMyz4x9Q7; Tue, 18 Jan
        2022 15:01:13 +0000 (GMT)
Received: from epcas5p3.samsung.com ( [182.195.41.41]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        36.BE.46822.ED5D6E16; Tue, 18 Jan 2022 23:59:42 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220118150112epcas5p4b63030d9bf136b4a91468b0d02e75cae~LZXwG0cK90382903829epcas5p43;
        Tue, 18 Jan 2022 15:01:12 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220118150112epsmtrp197a52c43374e93f7d468a9215bf76b3d~LZXwF5rZR2079320793epsmtrp18;
        Tue, 18 Jan 2022 15:01:12 +0000 (GMT)
X-AuditID: b6c32a4a-de5ff7000000b6e6-59-61e6d5de2328
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        F4.B1.29871.836D6E16; Wed, 19 Jan 2022 00:01:12 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220118150109epsmtip146663a6a065c861bdc7fc74a1bab247a~LZXtoVI940520405204epsmtip1Y;
        Tue, 18 Jan 2022 15:01:09 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, Alim Akhtar <alim.akhtar@samsung.com>,
        linux-fsd@tesla.com, Shashank Prashar <s.prashar@samsung.com>,
        Aswani Reddy <aswani.reddy@samsung.com>
Subject: [PATCH v2 15/16] arm64: dts: fsd: Add initial pinctrl support
Date:   Tue, 18 Jan 2022 20:18:50 +0530
Message-Id: <20220118144851.69537-16-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118144851.69537-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrAJsWRmVeSWpSXmKPExsWy7bCmpu69q88SDZY2KVo8mLeNzeLvpGPs
        Foc2b2W3eL+sh9Fi/pFzrBYb3/5gspjyZzmTxabH11gtPvbcY7V4+Crc4vKuOWwWM87vY7I4
        df0zm8WirV/YLVr3HmG3OPymndVi3o65jBaPr/9hcxDyWDNvDaPH71+TGD1mNfSyeWxa1cnm
        cefaHjaPzUvqPa6caGL16NuyitHjX9Ncdo/Pm+QCuKKybTJSE1NSixRS85LzUzLz0m2VvIPj
        neNNzQwMdQ0tLcyVFPISc1NtlVx8AnTdMnOAnlJSKEvMKQUKBSQWFyvp29kU5ZeWpCpk5BeX
        2CqlFqTkFJgU6BUn5haX5qXr5aWWWBkaGBiZAhUmZGcs2vearaDHpWLfrMmsDYzLzboYOTkk
        BEwkZl3+ztrFyMUhJLCbUWL/iZvsEM4nRomVN+6xQDjfGCXu7+1l6mLkAGv5uFMYIr6XUeLv
        xN9sEE4Lk8S264dYQOayCWhL3J2+hQnEFhFwk7jR2MEEUsQscIhZ4uS5w+wgCWGgxM623awg
        NouAqsSeSzfYQGxeAVuJ/3+uM0McKC+xesMBMJsTKD61YSrYNgmBAxwS648eYIM4yUXi9mc2
        iHphiVfHt7BD2FISL/vb2CFKsiV6dhlDhGskls47xgJh20scuDKHBaSEWUBTYv0ufZAwswCf
        RO/vJ1D/8kp0tAlBVKtKNL+7CtUpLTGxu5sVwvaQ+H18NyMkGCYwSqzZ+5ZtAqPsLISpCxgZ
        VzFKphYU56anFpsWGOWllsPjKTk/dxMjOKlqee1gfPjgg94hRiYOxkOMEhzMSiK8UvXPEoV4
        UxIrq1KL8uOLSnNSiw8xmgJDbCKzlGhyPjCt55XEG5pYGpiYmZmZWBqbGSqJ855O35AoJJCe
        WJKanZpakFoE08fEwSnVwMSzlcH51A5u70XCDrp9RsqCkxmrTtnpT9ksxV/YUD95q7pJ0XmJ
        uErOUNP8n7OS7zLeOZwbWpARYCZferTI0ixOc33YzRxhuy+FEYlPL7kdy9SZMuFuoLCeg1f6
        l/NsbdP/5pmwp7l+7s1/9ERL/vWJ7s8TDN3lZh1uN4/6Y8QzWydhgsxGXWv2H0GXTl/ZpH+b
        Z8OVux9cDihJ1TxaufaCopmfyN9C44Nbt2xh0D55IXipxye7HdUOmzj2+bQ+uMfdyjG3b+Ly
        /xc3MzzmUzh/QG+7ef3ZR68ZOueF77VYU1b080aP2PIE85d8Pzu0dnUIie577jn/1Z51HKIS
        W9S7vN/NOm32lavmdXyPpBJLcUaioRZzUXEiAA0C/pkzBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrKLMWRmVeSWpSXmKPExsWy7bCSnK7FtWeJBnN3iFo8mLeNzeLvpGPs
        Foc2b2W3eL+sh9Fi/pFzrBYb3/5gspjyZzmTxabH11gtPvbcY7V4+Crc4vKuOWwWM87vY7I4
        df0zm8WirV/YLVr3HmG3OPymndVi3o65jBaPr/9hcxDyWDNvDaPH71+TGD1mNfSyeWxa1cnm
        cefaHjaPzUvqPa6caGL16NuyitHjX9Ncdo/Pm+QCuKK4bFJSczLLUov07RK4Mhbte81W0ONS
        sW/WZNYGxuVmXYwcHBICJhIfdwp3MXJxCAnsZpRo2fuEuYuREyguLXF94wR2CFtYYuW/5+wQ
        RU1MEv177rCCJNgEtCXuTt/CBGKLCHhItP27xwxSxCxwhVni5/sPLCAJYQE3iZ1tu8EaWARU
        JfZcusEGYvMK2Er8/3Mdapu8xOoNB8BsTqD41IapYDVCAjYSF1dOY57AyLeAkWEVo2RqQXFu
        em6xYYFhXmq5XnFibnFpXrpecn7uJkZwTGhp7mDcvuqD3iFGJg7GQ4wSHMxKIrxS9c8ShXhT
        EiurUovy44tKc1KLDzFKc7AoifNe6DoZLySQnliSmp2aWpBaBJNl4uCUamAqOlB2a6PWH0bT
        CrXCx4y79rcaxOw/vOcc7+x3jbvn9i+SYMl4czg7XvBIwd6cezxvb4W1fV0bvKGeceldnluN
        f54xnBdj/XxrjpX9tGflvounnJColJtUVRF8zyvsWP32yH8Sr95OuX8hV29i5epe5nd3Oy22
        hKuaZmueNM3bFB/3u1k7Xe7d+0AdvyeZUobq86yc5grK3OGQKPGduE4jvaSTO05qw6apzjmW
        929b2ksVO3VLcm48a7rwB/v9084PEjWeRhnHO7bP6Z9Tk24SyFKeFOvWX3B7Tswy7QnMjqG/
        z35tm70qVMDuzw6Zh0yn85Nv3s5kjGR9pLFfcVJVuuOz27cNN9l8bd13fqISS3FGoqEWc1Fx
        IgCrUUx++AIAAA==
X-CMS-MailID: 20220118150112epcas5p4b63030d9bf136b4a91468b0d02e75cae
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220118150112epcas5p4b63030d9bf136b4a91468b0d02e75cae
References: <20220118144851.69537-1-alim.akhtar@samsung.com>
        <CGME20220118150112epcas5p4b63030d9bf136b4a91468b0d02e75cae@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial pin configuration nodes for FSD SoC.

Cc: linux-fsd@tesla.com
Signed-off-by: Shashank Prashar <s.prashar@samsung.com>
Signed-off-by: Aswani Reddy <aswani.reddy@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi | 335 +++++++++++++++++++++
 arch/arm64/boot/dts/tesla/fsd.dtsi         |  22 ++
 2 files changed, 357 insertions(+)
 create mode 100644 arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi

diff --git a/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
new file mode 100644
index 000000000000..371344e446f3
--- /dev/null
+++ b/arch/arm64/boot/dts/tesla/fsd-pinctrl.dtsi
@@ -0,0 +1,335 @@
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
+	gpq0: gpq0 {
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
index 9a2b88f58c13..bab63c9f79dc 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -26,6 +26,9 @@ aliases {
 		i2c5 = &hsi2c_5;
 		i2c6 = &hsi2c_6;
 		i2c7 = &hsi2c_7;
+		pinctrl0 = &pinctrl_fsys0;
+		pinctrl1 = &pinctrl_peric;
+		pinctrl2 = &pinctrl_pmu;
 	};
 
 	cpus {
@@ -647,5 +650,24 @@ hsi2c_7: hsi2c@14270000 {
 			clock-names = "hsi2c";
 			status = "disabled";
 		};
+
+		pinctrl_pmu: pinctrl@114f0000 {
+			compatible = "tesla,fsd-pinctrl";
+			reg = <0x0 0x114f0000 0x0 0x1000>;
+		};
+
+		pinctrl_peric: pinctrl@141f0000 {
+			compatible = "tesla,fsd-pinctrl";
+			reg = <0x0 0x141f0000 0x0 0x1000>;
+			interrupts = <GIC_SPI 189 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
+		pinctrl_fsys0: pinctrl@15020000 {
+			compatible = "tesla,fsd-pinctrl";
+			reg = <0x0 0x15020000 0x0 0x1000>;
+			interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 };
+
+#include "fsd-pinctrl.dtsi"
-- 
2.25.1

