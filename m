Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F3A496450
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 18:43:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349777AbiAURnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 12:43:13 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:22562 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351799AbiAURly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 12:41:54 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220121174132epoutp042e6e3c89a4a9ddf46f3d4e0f72b41fe9~MWfmSwawp3155731557epoutp04C
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 17:41:32 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220121174132epoutp042e6e3c89a4a9ddf46f3d4e0f72b41fe9~MWfmSwawp3155731557epoutp04C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642786892;
        bh=985kxxSSWol25Lsq22k35g6bDBdVQJpym2tkX6U27W4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gYVky7ygmyBvLs9PkU2NBMHpEpqKk3DUxPtf/LOxLX2h/PSYQhAEleq+iUfnKJv4F
         9C8AV7J2a326yrIba7onTHidAKFcWTqlcx336yDI4XmR93wcV0FKx9ps1OOq+b/8P5
         M6cVZ3IY4SPJDjy+Sxzz4LBGC0nXpWJxvHEzB9lo=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220121174131epcas5p41cd9651eee6c5b4196d54696018a1cdc~MWflIMdRA0297102971epcas5p48;
        Fri, 21 Jan 2022 17:41:31 +0000 (GMT)
Received: from epsmges5p2new.samsung.com (unknown [182.195.38.176]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JgRWR0rBdz4x9Pt; Fri, 21 Jan
        2022 17:41:23 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p2new.samsung.com (Symantec Messaging Gateway) with SMTP id
        33.9B.46822.16FEAE16; Sat, 22 Jan 2022 02:37:37 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p3.samsung.com (KnoxPortal) with ESMTPA id
        20220121174121epcas5p3f03348e9bd2d159dd00ce126506cf8ce~MWfcJVs4L2795427954epcas5p39;
        Fri, 21 Jan 2022 17:41:21 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220121174121epsmtrp2ffd4db0e0c9b5f7308df009f2c6b9a51~MWfcIGW9W1824918249epsmtrp2z;
        Fri, 21 Jan 2022 17:41:21 +0000 (GMT)
X-AuditID: b6c32a4a-dfbff7000000b6e6-60-61eaef61111d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        44.C7.08738.140FAE16; Sat, 22 Jan 2022 02:41:21 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220121174118epsmtip2c5f6ab9420d1a5034a4dd6aba0153adc~MWfZhTaPu1230312303epsmtip2j;
        Fri, 21 Jan 2022 17:41:18 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net, arnd@arndb.de,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, sboyd@kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>, linux-fsd@tesla.com,
        Shashank Prashar <s.prashar@samsung.com>,
        Aswani Reddy <aswani.reddy@samsung.com>
Subject: [PATCH v3 15/16] arm64: dts: fsd: Add initial pinctrl support
Date:   Fri, 21 Jan 2022 22:58:39 +0530
Message-Id: <20220121172840.12121-16-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220121172840.12121-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKJsWRmVeSWpSXmKPExsWy7bCmum7i+1eJBifmy1g8mLeNzeLvpGPs
        Foc2b2W3eL+sh9Fi/pFzrBYb3/5gspjyZzmTxabH11gtPvbcY7V4+Crc4vKuOWwWM87vY7I4
        df0zm8WirV/YLVr3HmG3OPymndVi3o65jBb/rm1ksXh8/Q+bg7DHmnlrGD1+/5rE6DGroZfN
        Y9OqTjaPO9f2sHlsXlLvceVEE6tH35ZVjB7/muaye3zeJBfAFZVtk5GamJJapJCal5yfkpmX
        bqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQP0mZJCWWJOKVAoILG4WEnfzqYov7Qk
        VSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO+PGwQ1sBdddKhomNDI3MH4y
        62Lk4JAQMJHYsiGoi5GTQ0hgN6PE2tfaXYxcQPYnRokJl++wQzifGSUWX7rDCFIF0vBq+xpm
        iMQuRonej8+YIJwWJoneA8fYQarYBLQl7k7fwgRiiwi4Sdxo7AArYha4xizxe3IzM0hCGChx
        /txCMJtFQFVi7YbVYM28ArYSZ1qOQK2Tl1i94QBYDSdQ/PXZeWCrJQSOcEicOD2HFaLIReL+
        wSVsELawxKvjW9ghbCmJz+/2skE8mi3Rs8sYIlwjsXTeMRYI217iwJU5LCAlzAKaEut36YOE
        mQX4JHp/P2GC6OSV6GgTgqhWlWh+dxWqU1piYnc31AEeEssP3WeBhMMEYDAen8E8gVF2FsLU
        BYyMqxglUwuKc9NTi00LjPJSy+HxlJyfu4kRnF61vHYwPnzwQe8QIxMH4yFGCQ5mJRHegvxX
        iUK8KYmVValF+fFFpTmpxYcYTYFBNpFZSjQ5H5jg80riDU0sDUzMzMxMLI3NDJXEeU+nb0gU
        EkhPLEnNTk0tSC2C6WPi4JRqYApy/fbD7yej8vrLCmwTzpnwVbbqMszS/aF0RTnmxa5w5Z+L
        opJdo5Wem1f8OynlGXtwb3IGs/meFwwTVN62bXy4IUnkDNsqpdad1Y9EG3Pi96/bvujW/jcn
        bnKxTTqaE3zdr+Y787OOa9lRrce9VbIfC+1TtCnqiQjWnal962ec2M3Ab6Is24I0uBxkFR7o
        9SysnaLdGbOqX+fEvcRvFtHFdqkX2+rN+oSjxNWsjFQNigR9tual3Lme36S4N91f6kz9RgZ+
        PdeUqdm7yteJ3VlX/tBeXfUAq6d5aseTheaF6vrPj8/9ZhEvIziPwUrhuz0bH0dQgfCiln/f
        E/uFFMMuL3qyglHvnZ1XZogSS3FGoqEWc1FxIgATU/ejOAQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrNLMWRmVeSWpSXmKPExsWy7bCSvK7jh1eJBt93y1o8mLeNzeLvpGPs
        Foc2b2W3eL+sh9Fi/pFzrBYb3/5gspjyZzmTxabH11gtPvbcY7V4+Crc4vKuOWwWM87vY7I4
        df0zm8WirV/YLVr3HmG3OPymndVi3o65jBb/rm1ksXh8/Q+bg7DHmnlrGD1+/5rE6DGroZfN
        Y9OqTjaPO9f2sHlsXlLvceVEE6tH35ZVjB7/muaye3zeJBfAFcVlk5Kak1mWWqRvl8CVcePg
        BraC6y4VDRMamRsYP5l1MXJySAiYSLzavoa5i5GLQ0hgB6PEt12PGSES0hLXN05gh7CFJVb+
        e84OUdTEJPFuwQ1mkASbgLbE3elbmEBsEQEPibZ/98AmMQu8YJZY8eIpWLewgJvE+XMLwRpY
        BFQl1m5YDRbnFbCVONNyBGqbvMTqDQfAajiB4q/PzgOzhQRsJJpnbWWawMi3gJFhFaNkakFx
        bnpusWGBUV5quV5xYm5xaV66XnJ+7iZGcHxoae1g3LPqg94hRiYOxkOMEhzMSiK8BfmvEoV4
        UxIrq1KL8uOLSnNSiw8xSnOwKInzXug6GS8kkJ5YkpqdmlqQWgSTZeLglGpgsprmv19A+46i
        OdOXZ03vjxYK38tXzQz71jBvR9BHxu+3UnddMT7Y8G5/tucz4TUanNzxNwPKFXQSeRgkNqrs
        WCbYqGjpsFmMfemXmf5O1nfZ3M2yQx5M3Nd0vrTn9vM9Ardub9QRO34xtFI2RCwr8yPLqgmz
        0lcdPBz2/Z/i6apHVzaKH85gkLqyK9/k7bv3PziLdJ1WKOyb/OZ3+Yxo4Q87Tv5foG1peWK1
        Fd/nc08bveKvPNgf8LupuSc1wUe6a9/humu76m68ddy26kyj+svOI5vu59wrfyg9ac3a+kmf
        mCo6p6s6LpAIipP+4zFfYM4KyYsrzzhf/LNtm6q/YWPZmjWablcmn2f32bqObaISS3FGoqEW
        c1FxIgDNGDrH/gIAAA==
X-CMS-MailID: 20220121174121epcas5p3f03348e9bd2d159dd00ce126506cf8ce
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220121174121epcas5p3f03348e9bd2d159dd00ce126506cf8ce
References: <20220121172840.12121-1-alim.akhtar@samsung.com>
        <CGME20220121174121epcas5p3f03348e9bd2d159dd00ce126506cf8ce@epcas5p3.samsung.com>
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
index 000000000000..8f2c61eacf61
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
+	pwm0_out: pwm0-out-pins {
+		samsung,pins = "gpb6-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV2>;
+	};
+
+	pwm1_out: pwm1-out-pins {
+		samsung,pins = "gpb6-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV2>;
+	};
+
+	hs_i2c0_bus: hs-i2c0-bus-pins {
+		samsung,pins = "gpb0-0", "gpb0-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	hs_i2c1_bus: hs-i2c1-bus-pins {
+		samsung,pins = "gpb0-2", "gpb0-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	hs_i2c2_bus: hs-i2c2-bus-pins {
+		samsung,pins = "gpb0-4", "gpb0-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	hs_i2c3_bus: hs-i2c3-bus-pins {
+		samsung,pins = "gpb0-6", "gpb0-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	hs_i2c4_bus: hs-i2c4-bus-pins {
+		samsung,pins = "gpb1-0", "gpb1-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	hs_i2c5_bus: hs-i2c5-bus-pins {
+		samsung,pins = "gpb1-2", "gpb1-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	hs_i2c6_bus: hs-i2c6-bus-pins {
+		samsung,pins = "gpb1-4", "gpb1-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	hs_i2c7_bus: hs-i2c7-bus-pins {
+		samsung,pins = "gpb1-6", "gpb1-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	uart0_data: uart0-data-pins {
+		samsung,pins = "gpb7-0", "gpb7-1";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	uart1_data: uart1-data-pins {
+		samsung,pins = "gpb7-4", "gpb7-5";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_NONE>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	spi0_bus: spi0-bus-pins {
+		samsung,pins = "gpb4-0", "gpb4-2", "gpb4-3";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	spi1_bus: spi1-bus-pins {
+		samsung,pins = "gpb4-4", "gpb4-6", "gpb4-7";
+		samsung,pin-function = <EXYNOS_PIN_FUNC_2>;
+		samsung,pin-pud = <EXYNOS_PIN_PULL_UP>;
+		samsung,pin-drv = <EXYNOS4_PIN_DRV_LV1>;
+	};
+
+	spi2_bus: spi2-bus-pins {
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

