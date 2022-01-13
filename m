Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E33148D7C1
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 13:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234856AbiAMMZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 07:25:21 -0500
Received: from mailout1.samsung.com ([203.254.224.24]:34223 "EHLO
        mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234654AbiAMMYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 07:24:46 -0500
Received: from epcas5p4.samsung.com (unknown [182.195.41.42])
        by mailout1.samsung.com (KnoxPortal) with ESMTP id 20220113122445epoutp0103966a502e17be80ca4f9bfaa2b9fda4~J1Auc-KBc1893118931epoutp01u
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 12:24:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com 20220113122445epoutp0103966a502e17be80ca4f9bfaa2b9fda4~J1Auc-KBc1893118931epoutp01u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1642076685;
        bh=rA8FKpbjwOhzvHJNvOXPJoIfa1Bv7rQ6h1p206Q4D8k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IqOJeNshzOo309cjJz7RwjNAys7nMTmhQS/Y2j9dsG4lw2JDzBbncZJpPYjRa/Jfx
         gGAifCHZ1DNtJB1FhxHgNkbX2T6z4EmXAcsxbTD6QBNQeBqwrHzHikhX7Qlofza1sb
         jCHsu0x6yrRRA8X+djbVrwaYw2OI9ZWTIK0Qadi0=
Received: from epsnrtp2.localdomain (unknown [182.195.42.163]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTP id
        20220113122444epcas5p48521506b366338371b486ed16f5423c3~J1AtFmrlM1113011130epcas5p4u;
        Thu, 13 Jan 2022 12:24:44 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.178]) by
        epsnrtp2.localdomain (Postfix) with ESMTP id 4JZNsh5hFqz4x9Q4; Thu, 13 Jan
        2022 12:24:40 +0000 (GMT)
Received: from epcas5p1.samsung.com ( [182.195.41.39]) by
        epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9C.61.05590.80A10E16; Thu, 13 Jan 2022 21:24:40 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas5p4.samsung.com (KnoxPortal) with ESMTPA id
        20220113122440epcas5p4651d7cb2fc6d6a70fd5eaab5eadcf996~J1AppHQNK2464824648epcas5p4R;
        Thu, 13 Jan 2022 12:24:40 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220113122440epsmtrp2f8c57c4377f65de791f83e8408d1edb2~J1AprqT5v3235332353epsmtrp2U;
        Thu, 13 Jan 2022 12:24:40 +0000 (GMT)
X-AuditID: b6c32a4b-739ff700000015d6-33-61e01a085506
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        ED.A8.29871.70A10E16; Thu, 13 Jan 2022 21:24:39 +0900 (KST)
Received: from Jaguar.sa.corp.samsungelectronics.net (unknown
        [107.108.73.139]) by epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220113122437epsmtip233b09db131f4887133c69a08e6707f52~J1AmkAnhh1245812458epsmtip2u;
        Thu, 13 Jan 2022 12:24:36 +0000 (GMT)
From:   Alim Akhtar <alim.akhtar@samsung.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     soc@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, olof@lixom.net,
        linus.walleij@linaro.org, catalin.marinas@arm.com,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        s.nawrocki@samsung.com, linux-samsung-soc@vger.kernel.org,
        pankaj.dubey@samsung.com, Aswani Reddy <aswani.reddy@samsung.com>,
        linux-fsd@tesla.com, Alim Akhtar <alim.akhtar@samsung.com>
Subject: [PATCH 19/23] arm64: dts: fsd: Add SPI device nodes
Date:   Thu, 13 Jan 2022 17:41:39 +0530
Message-Id: <20220113121143.22280-20-alim.akhtar@samsung.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220113121143.22280-1-alim.akhtar@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIJsWRmVeSWpSXmKPExsWy7bCmui6H1INEg/89IhYP5m1jszi0eSu7
        xftlPYwW84+cY7XY+PYHk8WUP8uZLDY9vsZq8bHnHqvFw1fhFpd3zWGzmHF+H5PFqeuf2SwW
        bf3CbtG69wi7xeE37awWj6//YXMQ8Fgzbw2jx6yGXjaPTas62TzuXNvD5rF5Sb3HlRNNrB59
        W1Yxevxrmsvu8XmTXABnVLZNRmpiSmqRQmpecn5KZl66rZJ3cLxzvKmZgaGuoaWFuZJCXmJu
        qq2Si0+ArltmDtAXSgpliTmlQKGAxOJiJX07m6L80pJUhYz84hJbpdSClJwCkwK94sTc4tK8
        dL281BIrQwMDI1OgwoTsjDdP1jIWbBGvWHnsLUsD4w6hLkZODgkBE4mpp2aydTFycQgJ7GaU
        2LHrNCOE84lRYs+6newQzjdGiWuLV7LCtJx/9YIVIrGXUeLPvWVQVS1MEme7FoNVsQloS9yd
        voUJxBYRcJO40djBBFLELNDOLHFnwl6whLCAjUTHnwawBhYBVYnG+x/B4rwCthK9P78wQayT
        l1i94QBzFyMHBydQ/O6qPJA5EgILOSTeHe2FqnGROHmjhxnCFpZ4dXwLO4QtJfH53V42kF4J
        gWyJnl3GEOEaiaXzjrFA2PYSB67MYQEpYRbQlFi/Sx8kzCzAJ9H7+wkTRCevREcbNLhUJZrf
        XYXqlJaY2N3NClHiIXFkgxQkFCYwSuz8toxxAqPsLIShCxgZVzFKphYU56anFpsWGOellsPj
        KTk/dxMjOG1qee9gfPTgg94hRiYOxkOMEhzMSiK8/UX3E4V4UxIrq1KL8uOLSnNSiw8xmgID
        bCKzlGhyPjBx55XEG5pYGpiYmZmZWBqbGSqJ855K35AoJJCeWJKanZpakFoE08fEwSnVwFTS
        sW/jlB89P5oO9a6LmV/imBEyQ8on3Ddm20u+uj7G155zrgWzZ76912Nyhveo6j7xQ/PbPJc0
        p/lNumq8SedF9SPHiLxHr+wn7a1abzl3ed3m3LNS6mmJbK5MpjUFkz7kvev10VT58fw0s/np
        jLNbk31b+m5/zXcyXKbaMfFD8X2F6O29b28ti17usX33W8vcexf2B+SdX2F3kmvi1KRM2VOd
        wbJd7VtunCqVfWPtEX0nlKW51lzQU8cjTm/CyWd5Dw5t9v/hOufPLLPXiedmbzjwa/7H8Ce/
        +VN9w819Om9rCdy59vXnMreDV4RVL3DHHFP8fW3GAr+rWx68P1zEvuuInGrRxep/U99vrTZR
        YinOSDTUYi4qTgQAReeKIyQEAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrKLMWRmVeSWpSXmKPExsWy7bCSvC671INEgx0LLS0ezNvGZnFo81Z2
        i/fLehgt5h85x2qx8e0PJospf5YzWWx6fI3V4mPPPVaLh6/CLS7vmsNmMeP8PiaLU9c/s1ks
        2vqF3aJ17xF2i8Nv2lktHl//w+Yg4LFm3hpGj1kNvWwem1Z1snncubaHzWPzknqPKyeaWD36
        tqxi9PjXNJfd4/MmuQDOKC6blNSczLLUIn27BK6MN0/WMhZsEa9YeewtSwPjDqEuRk4OCQET
        ifOvXrB2MXJxCAnsZpT4vvcqE0RCWuL6xgnsELawxMp/z8FsIYEmJompy0RBbDYBbYm707eA
        1YsIeEi0/bvHDDKIWWA6s8SBbd9YQBLCAjYSHX8aWEFsFgFVicb7H8EaeAVsJXp/foFaJi+x
        esMBoGYODk6g+N1VeRC7bCTOvVrPNoGRbwEjwypGydSC4tz03GLDAsO81HK94sTc4tK8dL3k
        /NxNjOCQ19Lcwbh91Qe9Q4xMHIyHGCU4mJVEePuL7icK8aYkVlalFuXHF5XmpBYfYpTmYFES
        573QdTJeSCA9sSQ1OzW1ILUIJsvEwSnVwCT56IqDMo+hRunVtjV9b8qUArY48bxv2vKtc36w
        a+DJhpfK795fqQhn1Hr4PTPm/My5T+//1dH1bjOqmv2qK+mr2dZ/m1hq+lxX5Uc8af3uHSXC
        1iK1NLx4dbf576lJlvz73TunJz/08Koru3yoLeRMwLpPTYVHsi/0FfVmNcvzsHtvNbPVCfr/
        69aVkrTdR0+ZP9h4Sla0L2D73c65NSEODGWPzCKSL7AYLAu8prv55ZpboYzSL+sV/aqmT8rK
        fmw/uX9nv/jllaoGyp5SPssudZw7ua1Aj417zZ4Pvbmb/vfd6BNezhtYlVL9114jf1nzssdf
        b6SuNs2N/zUtl1/qVUzxvk7vaMO+t1lBSizFGYmGWsxFxYkA49qwZ+gCAAA=
X-CMS-MailID: 20220113122440epcas5p4651d7cb2fc6d6a70fd5eaab5eadcf996
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220113122440epcas5p4651d7cb2fc6d6a70fd5eaab5eadcf996
References: <20220113121143.22280-1-alim.akhtar@samsung.com>
        <CGME20220113122440epcas5p4651d7cb2fc6d6a70fd5eaab5eadcf996@epcas5p4.samsung.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aswani Reddy <aswani.reddy@samsung.com>

This patch add device tree node for SPI IPs and needed
GPIO pin configurations needed for SPI IP

Cc: linux-fsd@tesla.com
Signed-off-by: Aswani Reddy <aswani.reddy@samsung.com>
Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
---
 arch/arm64/boot/dts/tesla/fsd.dts  | 12 +++++++
 arch/arm64/boot/dts/tesla/fsd.dtsi | 57 ++++++++++++++++++++++++++++++
 2 files changed, 69 insertions(+)

diff --git a/arch/arm64/boot/dts/tesla/fsd.dts b/arch/arm64/boot/dts/tesla/fsd.dts
index e9bbd3284de9..7f3bb6212e50 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dts
+++ b/arch/arm64/boot/dts/tesla/fsd.dts
@@ -138,3 +138,15 @@
 &pdma1 {
 	status = "okay";
 };
+
+&spi_0 {
+	status = "okay";
+};
+
+&spi_1 {
+	status = "okay";
+};
+
+&spi_2 {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/tesla/fsd.dtsi b/arch/arm64/boot/dts/tesla/fsd.dtsi
index 811186e5ba4d..7e687c6f74f6 100644
--- a/arch/arm64/boot/dts/tesla/fsd.dtsi
+++ b/arch/arm64/boot/dts/tesla/fsd.dtsi
@@ -32,6 +32,9 @@
 		pinctrl0 = &pinctrl_fsys0;
 		pinctrl1 = &pinctrl_peric;
 		pinctrl2 = &pinctrl_pmu;
+		spi0 = &spi_0;
+		spi1 = &spi_1;
+		spi2 = &spi_2;
 	};
 
 	cpus {
@@ -731,6 +734,60 @@
 			compatible = "tesla,fsd-pinctrl";
 			reg = <0x0 0x114F0000 0x0 0x1000>;
 		};
+
+		spi_0: spi@14140000 {
+			compatible = "tesla,fsd-spi";
+			reg = <0x0 0x14140000 0x0 0x100>;
+			interrupts = <GIC_SPI 156 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&pdma1 4>, <&pdma1 5>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&clock_peric PERIC_PCLK_SPI0>,
+				<&clock_peric PERIC_SCLK_SPI0>;
+			clock-names = "spi", "spi_busclk0";
+			samsung,spi-src-clk = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi0_bus>;
+			num-cs = <1>;
+			status = "disabled";
+		};
+
+		spi_1: spi@14150000 {
+			compatible = "tesla,fsd-spi";
+			reg = <0x0 0x14150000 0x0 0x100>;
+			interrupts = <GIC_SPI 157 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&pdma1 6>, <&pdma1 7>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&clock_peric PERIC_PCLK_SPI1>,
+				<&clock_peric PERIC_SCLK_SPI1>;
+			clock-names = "spi", "spi_busclk0";
+			samsung,spi-src-clk = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi1_bus>;
+			num-cs = <1>;
+			status = "disabled";
+		};
+
+		spi_2: spi@14160000 {
+			compatible = "tesla,fsd-spi";
+			reg = <0x0 0x14160000 0x0 0x100>;
+			interrupts = <GIC_SPI 158 IRQ_TYPE_LEVEL_HIGH>;
+			dmas = <&pdma1 8>, <&pdma1 9>;
+			dma-names = "tx", "rx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			clocks = <&clock_peric PERIC_PCLK_SPI2>,
+				<&clock_peric PERIC_SCLK_SPI2>;
+			clock-names = "spi", "spi_busclk0";
+			samsung,spi-src-clk = <0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&spi2_bus>;
+			num-cs = <1>;
+			status = "disabled";
+		};
 	};
 };
 
-- 
2.17.1

