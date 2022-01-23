Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AC68497532
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 20:22:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239880AbiAWTVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 14:21:09 -0500
Received: from mailout4.samsung.com ([203.254.224.34]:45689 "EHLO
        mailout4.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240077AbiAWTUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 14:20:44 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220123192043epoutp04b2279f06c3c56506b163fc436bb55414~M-IwviK0P0329803298epoutp04V
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 19:20:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220123192043epoutp04b2279f06c3c56506b163fc436bb55414~M-IwviK0P0329803298epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642965643;
        bh=Wml6kH1OZvP1xUDCcCVf9VxbhskS/p2gQnebYNe7wbE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qRiVadTeLWuCgAdV5ivvBR6lKxmFPpkIqQ/hoo2oaVJ9df3KGRICKKThih1TlCr0+
         GhPbjVNryPZNcCALO2ZgOa+yHyY4cf2ibwba15/NDyTCeYsaBTWWifZGamH3oyPs7k
         7pbD2tvCFr2HCalfyXpDdieAgkG6fn8ndhQ5l59U=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220123192042epcas5p47a853dc2532b45eec9096e2339e93df7~M-Iv8R3R00240502405epcas5p4x;
        Sun, 23 Jan 2022 19:20:42 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.179]) by
        epsnrtp1.localdomain (Postfix) with ESMTP id 4Jhjd06WS6z4x9Pp; Sun, 23 Jan
        2022 19:20:36 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        19.47.06423.48AADE16; Mon, 24 Jan 2022 04:20:36 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas5p1.samsung.com (KnoxPortal) with ESMTPA id
        20220123192036epcas5p118f022cd52b7514bd1c27081bb18226a~M-IqVPyjt0431504315epcas5p10;
        Sun, 23 Jan 2022 19:20:36 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220123192036epsmtrp1ae112b76144ed283db712ac0b5aff475~M-IqUWriq3102531025epsmtrp1T;
        Sun, 23 Jan 2022 19:20:36 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-aa-61edaa8429c3
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.F7.29871.48AADE16; Mon, 24 Jan 2022 04:20:36 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220123192033epsmtip12636aa111b1c7d5b8b9b4709022e6128~M-In04d3o0799807998epsmtip1G;
        Sun, 23 Jan 2022 19:20:33 +0000 (GMT)
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
Subject: [PATCH v4 15/16] arm64: dts: fsd: Add initial pinctrl support
Date:   Mon, 24 Jan 2022 00:37:28 +0530
Message-Id: <20220123190729.1852-16-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220123190729.1852-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGJsWRmVeSWpSXmKPExsWy7bCmum7LqreJBvsv61g8mLeNzeLvpGPs
        Foc2b2W3eL+sh9Fi/pFzrBYb3/5gspjyZzmTxabH11gtPvbcY7V4+Crc4vKuOWwWM87vY7I4
        df0zm8WirV/YLVr3HmG3OPymndVi3o65jBb/rm1ksXh8/Q+bg7DHmnlrGD1+/5rE6DGroZfN
        Y9OqTjaPO9f2sHlsXlLvceVEE6tH35ZVjB7/muaye3zeJBfAFZVtk5GamJJapJCal5yfkpmX
        bqvkHRzvHG9qZmCoa2hpYa6kkJeYm2qr5OIToOuWmQP0mZJCWWJOKVAoILG4WEnfzqYov7Qk
        VSEjv7jEVim1ICWnwKRArzgxt7g0L10vL7XEytDAwMgUqDAhO+NKwzqWgsduFZtWXGZqYPxn
        0cXIySEhYCKxp/0YSxcjF4eQwG5GiSk9jUwQzidGicOrrjNDON8YJT709jHBtLw4MY8dxBYS
        2Msosfu5FkRRC5PEjV2vwRJsAtoSd6dvAWsQEXCTuNHYATaWWeAas8Tvyc3MIAlhoMTMtwvZ
        QGwWAVWJld29rCA2r4CNxIYFJ9ggtslLrN5wAKyeEyje++oDK8ggCYEjHBIHL9xngShykbi4
        6SMjhC0s8er4FnYIW0riZX8bkM0BZGdL9OwyhgjXSCyddwyq1V7iwJU5LCAlzAKaEut36YOE
        mQX4JHp/P2GC6OSV6GgTgqhWlWh+dxWqU1piYnc3K4TtIfHh32pWSDj0M0p8fLKUcQKj7CyE
        qQsYGVcxSqYWFOempxabFhjmpZbDIyo5P3cTIzjBannuYLz74IPeIUYmDsZDjBIczEoivAX5
        rxKFeFMSK6tSi/Lji0pzUosPMZoCg2wis5Rocj4wxeeVxBuaWBqYmJmZmVgamxkqifOeTt+Q
        KCSQnliSmp2aWpBaBNPHxMEp1cA0g3Hew7VFspuc/qXueLU9pmOLWMbjI9WNkq9ehxjs3XLq
        xaeEmutXOOveZalrzVrQo9q1oWX7Jl6JX/xHpGVFRPZ5mb3ZyRW+WDboarNX1vX+/c/++eft
        rNysOGNfxVN7xacqoQ2rZuZvjHMMD/2xKvUiT8iHrZ+u5j/beVpl1rqmUtG+vD2NL8oKk8/z
        /8pyv/B066a5yraclnff21kkzrIz2PrCc/PS/GcVC9wnrvNsOFmw4NOhwJX/0tYJit4zz5W2
        1fZ0jIi6/jV5+v35PxbLn7xTe8Emh9E15NUSc81ia7u/smxT/0tnneU7mzpjVjUTO++r6sub
        JHLzQ7YKLcvKWFbpdCb1yj4Vy+zjSizFGYmGWsxFxYkAG9kGaDkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSnG7LqreJBotXsVo8mLeNzeLvpGPs
        Foc2b2W3eL+sh9Fi/pFzrBYb3/5gspjyZzmTxabH11gtPvbcY7V4+Crc4vKuOWwWM87vY7I4
        df0zm8WirV/YLVr3HmG3OPymndVi3o65jBb/rm1ksXh8/Q+bg7DHmnlrGD1+/5rE6DGroZfN
        Y9OqTjaPO9f2sHlsXlLvceVEE6tH35ZVjB7/muaye3zeJBfAFcVlk5Kak1mWWqRvl8CVcaVh
        HUvBY7eKTSsuMzUw/rPoYuTkkBAwkXhxYh47iC0ksJtR4uLdUIi4tMT1jRPYIWxhiZX/ngPZ
        XEA1TUwS2x8cYAJJsAloS9ydvgXMFhHwkGj7d48ZpIhZ4AWzxIoXT8G6hQXcJGa+XcgGYrMI
        qEqs7O5lBbF5BWwkNiw4wQaxQV5i9YYDzCA2J1C899UHoBoOoG3WEhOOyk1g5FvAyLCKUTK1
        oDg3PbfYsMAwL7Vcrzgxt7g0L10vOT93EyM4NrQ0dzBuX/VB7xAjEwfjIUYJDmYlEd6C/FeJ
        QrwpiZVVqUX58UWlOanFhxilOViUxHkvdJ2MFxJITyxJzU5NLUgtgskycXBKNTCtVnDI/juD
        8UGMxOyGtXJPI8Wn/DC5173Gyu/MwXqjxJ8erTvnd3YusZwWlN0T7faHP/5AKrNp73MHg5wF
        jYbv9l6Xb8nhLnpS7Xiz88Wm68EKyrrnd3O8UVS2F21oXlkhpid97LEZ2/fGlhtJx5Rjpu59
        0b5+l/rCSbWzKw/1n3j07rqNVMAi9x1Tzj+N391tsvqtx9647bMiufL2NC/eZWry6FaJQ42I
        iNsi/6erhNN/hN3+0ftb7NLtBvlmpp2hqupsC/kYvq04zPElfN2bc0rLnAOMLzjO+GJcb3b1
        A1fyDWPbYycW32yw/PDNec2c3HvdM1fu/O5y8i7HjP4rxw+KcIZIX40R33n26CsnJZbijERD
        Leai4kQAbwhq0PwCAAA=
X-CMS-MailID: 20220123192036epcas5p118f022cd52b7514bd1c27081bb18226a
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220123192036epcas5p118f022cd52b7514bd1c27081bb18226a
References: <20220123190729.1852-1-alim.akhtar@samsung.com>
        <CGME20220123192036epcas5p118f022cd52b7514bd1c27081bb18226a@epcas5p1.samsung.com>
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
index 000000000000..d4d0cb005712
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
+	gpf0: gpf0-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpf1: gpf1-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpf6: gpf6-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpf4: gpf4-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpf5: gpf5-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+};
+
+&pinctrl_peric {
+	gpc8: gpc8-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpf2: gpf2-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpf3: gpf3-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpd0: gpd0-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpb0: gpb0-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpb1: gpb1-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpb4: gpb4-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpb5: gpb5-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpb6: gpb6-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpb7: gpb7-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpd1: gpd1-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpd2: gpd2-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpd3: gpd3-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpg0: gpg0-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpg1: gpg1-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpg2: gpg2-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpg3: gpg3-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpg4: gpg4-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpg5: gpg5-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpg6: gpg6-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+
+		interrupt-controller;
+		#interrupt-cells = <2>;
+	};
+
+	gpg7: gpg7-gpio-bank {
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
+	gpq0: gpq0-gpio-bank {
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+};
diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
index 815bd27efbe2..1210fe64d7c7 100644
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
@@ -647,5 +650,24 @@ hsi2c_7: i2c@14270000 {
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

