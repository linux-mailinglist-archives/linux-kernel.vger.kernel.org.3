Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8418B498262
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239874AbiAXOan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:30:43 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:42354 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240045AbiAXOaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:30:08 -0500
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220124143006epoutp02c836b5384ac28711f5c76677376b03c4~NO0T_bo660050500505epoutp02R
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 14:30:06 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220124143006epoutp02c836b5384ac28711f5c76677376b03c4~NO0T_bo660050500505epoutp02R
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1643034606;
        bh=v7mQ6aYRK43ea1pobwQRnvVcIQNZhQmXtu5rsJ1RD6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eoQGqbHKP1gWdZfF1PHPC9GYhNK9+wJ6d8Y2CD3OcNi5S0CSJpr+szuttNsTs7fc5
         utQ+EVMAFcFJkyh/WuEqNHgcvAidWXBZwqJeSSThkevD2+BpLYwYjQ1+wLCzIG/C3N
         D1MtUjdAIRJjRwVX3qR7jjok0gKE+yO2in4RLHl8=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas5p2.samsung.com (KnoxPortal) with ESMTP id
        20220124143005epcas5p2c5dad27b13665bb53dcbf7fe565b4329~NO0TWFveg0974109741epcas5p2Y;
        Mon, 24 Jan 2022 14:30:05 +0000 (GMT)
Received: from epsmges5p1new.samsung.com (unknown [182.195.38.180]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4JjC7G3QbGz4x9Pt; Mon, 24 Jan
        2022 14:30:02 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        52.AE.06423.AE7BEE16; Mon, 24 Jan 2022 23:30:02 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220124143001epcas5p4c0aab0902709a24bbedadaa223fe7910~NO0Pig6XN0847108471epcas5p4p;
        Mon, 24 Jan 2022 14:30:01 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220124143001epsmtrp2c7ac05353ebb1753e6e110f5a6a94fe0~NO0PZ-d4Q1656816568epsmtrp2e;
        Mon, 24 Jan 2022 14:30:01 +0000 (GMT)
X-AuditID: b6c32a49-b01ff70000001917-d2-61eeb7ea7451
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        2F.EA.29871.9E7BEE16; Mon, 24 Jan 2022 23:30:01 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20220124142958epsmtip174bbdca71b74896f39b553cf7d821877~NO0Mdbz-S1678816788epsmtip1-;
        Mon, 24 Jan 2022 14:29:58 +0000 (GMT)
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
Subject: [PATCH v5 15/16] arm64: dts: fsd: Add initial pinctrl support
Date:   Mon, 24 Jan 2022 19:46:43 +0530
Message-Id: <20220124141644.71052-16-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220124141644.71052-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGJsWRmVeSWpSXmKPExsWy7bCmuu6r7e8SDfadEbN4MG8bm8XfScfY
        LQ5t3spu8X5ZD6PF/CPnWC02vv3BZDHlz3Imi02Pr7FafOy5x2rx8FW4xeVdc9gsZpzfx2Rx
        6vpnNotFW7+wW7TuPcJucfhNO6vFvB1zGS3+XdvIYvH4+h82B2GPNfPWMHr8/jWJ0WNWQy+b
        x6ZVnWwed67tYfPYvKTe48qJJlaPvi2rGD3+Nc1l9/i8SS6AKyrbJiM1MSW1SCE1Lzk/JTMv
        3VbJOzjeOd7UzMBQ19DSwlxJIS8xN9VWycUnQNctMwfoMyWFssScUqBQQGJxsZK+nU1RfmlJ
        qkJGfnGJrVJqQUpOgUmBXnFibnFpXrpeXmqJlaGBgZEpUGFCdkb7ZLeCx24VhzdfYGlg/GfR
        xcjJISFgIrF/1RyWLkYuDiGB3YwS+36vYoVwPjFKTLn3lB3C+cYo0bJwHwtMy8oJ/6ESexkl
        djw8B9XSwiQxs/0VWBWbgLbE3elbmEBsEQE3iRuNHUwgRcwC15glfk9uZgZJCAMl2m8tZAWx
        WQRUJVomrGcHsXkFbCXu/zjBDLFOXmL1hgNgNidQfN7Cb2CDJAQOcEh8bOtigihykbh0eTqU
        LSzx6vgWdghbSuLzu71sXYwcQHa2RM8uY4hwjcTSeceg3rGXOHAFFAIcQMdpSqzfpQ8SZhbg
        k+j9/YQJopNXoqNNCKJaVaL53VWoTmmJid3drBC2h8THD4uZIOEwgVHi7Z2NLBMYZWchTF3A
        yLiKUTK1oDg3PbXYtMAwL7UcHlHJ+bmbGMEJVstzB+PdBx/0DjEycTAeYpTgYFYS4a1KeZco
        xJuSWFmVWpQfX1Sak1p8iNEUGGQTmaVEk/OBKT6vJN7QxNLAxMzMzMTS2MxQSZz3dPqGRCGB
        9MSS1OzU1ILUIpg+Jg5OqQamhXGvWZzPvP/ZpvTrXN5P4Y/asT5Ckc8USmuDZ1wTVAiUiwn6
        Zsp0deuP5XlVUcf3TeIp43I8c7fY7tfkoCeZja9eTy+/FGo4/7kW0yur6r1XmrvtFnDcXN/s
        Me20QUfSAqPWk4d3ZotOajtgNolHsyL2WeyFbuvNt9r79O8zyT22Lowz26qbtGK2hr/M9XNH
        dffNPbt9ve7cC6sSFulZTv4oJnH7ofqh6UkC++4dk5VXkOwLZ6y7X6WpuGlXufa928oXWGR/
        bigK5Om9dSf7gmtb1LKF27xsAvP9zzTKb8r0PnvCecIxg3/NJWv/+UiUyb2cOu1HfE9l9NLO
        ZeEiURpeX2OCf9f+///seia7EktxRqKhFnNRcSIARAKY8TkEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrJLMWRmVeSWpSXmKPExsWy7bCSnO7L7e8SDR7cV7Z4MG8bm8XfScfY
        LQ5t3spu8X5ZD6PF/CPnWC02vv3BZDHlz3Imi02Pr7FafOy5x2rx8FW4xeVdc9gsZpzfx2Rx
        6vpnNotFW7+wW7TuPcJucfhNO6vFvB1zGS3+XdvIYvH4+h82B2GPNfPWMHr8/jWJ0WNWQy+b
        x6ZVnWwed67tYfPYvKTe48qJJlaPvi2rGD3+Nc1l9/i8SS6AK4rLJiU1J7MstUjfLoEro32y
        W8Fjt4rDmy+wNDD+s+hi5OSQEDCRWDnhP3sXIxeHkMBuRol3V2eyQSSkJa5vnMAOYQtLrPz3
        HKqoiUnixKPTTCAJNgFtibvTt4DZIgIeEm3/7jGDFDELvGCWWPHiKVi3sICbRPuthawgNouA
        qkTLhPVgcV4BW4n7P04wQ2yQl1i94QCYzQkUn7fwG9BQDqBtNhLnfqtMYORbwMiwilEytaA4
        Nz232LDAMC+1XK84Mbe4NC9dLzk/dxMjODa0NHcwbl/1Qe8QIxMH4yFGCQ5mJRHeqpR3iUK8
        KYmVValF+fFFpTmpxYcYpTlYlMR5L3SdjBcSSE8sSc1OTS1ILYLJMnFwSjUwmc8XrDYtKYi4
        wPh37WnBZKvz3kaVJybylC38EHJL7MDLVTVd5neMgxVK7cxCy+ftX9qVkltou+BH3fxp2TsW
        6uRFZAc+CNod9fPx8/uT3vLcOryi5VVMbVHas41fJkcqcGSe/PDkq3zZ7OW1244LBMbeqflf
        /mVR1C+fiS6SYY2fu/y+RK91/PP+3hbOlgfWd1Plgp4FifiuYlD+17zQKy9ow6pNrexh0jIP
        n+4qWXc78La9uY24wHsthsJja0sn1uilaH1dtYqRz7XXcLHvincCZhbJv6yPXfxka7f4U/3u
        o0xL/m0pf3HsotmUpMWPJpheeMLgOyNCPKN2V7X0Nc0stV9r7hSH29w8WSkpqcRSnJFoqMVc
        VJwIAL5nNPj8AgAA
X-CMS-MailID: 20220124143001epcas5p4c0aab0902709a24bbedadaa223fe7910
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220124143001epcas5p4c0aab0902709a24bbedadaa223fe7910
References: <20220124141644.71052-1-alim.akhtar@samsung.com>
        <CGME20220124143001epcas5p4c0aab0902709a24bbedadaa223fe7910@epcas5p4.samsung.com>
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
index 25b480147541..b7f05f78c601 100644
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
@@ -648,5 +651,24 @@ hsi2c_7: i2c@14270000 {
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

