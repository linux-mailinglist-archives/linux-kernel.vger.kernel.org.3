Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7F655B1F9
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 14:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234439AbiFZMwu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 08:52:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234237AbiFZMwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 08:52:49 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0CE810FF2
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 05:52:45 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id lw20so13737815ejb.4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 05:52:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zJ6TZvYuGt7OIE19JQZWpsFPwOLX+jfeQl4k3h2uxjA=;
        b=D2YIYiSBnp/7WLWAgTyxUVHd4NSVRuzfNguC43XgaCmaoZnIhKpK7RiiDipZrpmFoA
         9lx9OktpTwPLxnFj+sLtiE1TRQRZ9+obItK/HAgP9YA3vaWP/iWKaEatPKE5/uTO20W8
         eXpufUprDXwNru2SxgGEzcv4w7nsbhdzNCj39MLVURRTIRSVM9egwzRhHBJRFBRdg7uI
         eS6TMMgmbjt4WxY/F+x+8CFEXTutwYBIWsUtIMbtnnFGxNW/Ltklcxr5443/qGuAdw4T
         Q5Fp6seAXBzRjFWr9C+m+eis1WKghNINP+MZNfh4oKPbrqsJY5mdu5YL63VthwVGVoHe
         FmEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zJ6TZvYuGt7OIE19JQZWpsFPwOLX+jfeQl4k3h2uxjA=;
        b=n8/pnWro+71qCglhgZSrQ7Yb8WNzmpoD32whSfQXLJsFeabT8i3Bq4tFhgyTXS03tQ
         Hfh3B1nCpfsgS73u/MCLOQbMpr5Xd8pzb52+o8/BAuj/0/hRW0DbzRypztNZ86Civsh8
         g0qCU6e0LYzrCPevfIg0WAaEo2LhwTWxYI5Nsk+pW5R/RsuCqcvnmxGYyXUCYCK+7WGB
         ShGQeGOkPLxLksgzLb0nKG5iIkqAQwSvvKTq6wzW1fpQH6FYflLQ5iY51dGn/YCc+36k
         6UuuUXY+qkx1nrn9To4SiRxq/kORgMf+1HSj+3gqjPJ3iaMjjL0Unq3EjTup1wCSy7M3
         JZow==
X-Gm-Message-State: AJIora+k2qEci6+DqshYGPG30YZRZ0673TA5KlBvf7c9UXmMfSnXJgzL
        TVLJbZOrWwNNdfBJYuoWm0ZbBw==
X-Google-Smtp-Source: AGRyM1szNp+X/wFXE6HPmQJn4Efd4VL9ZXYXcTmrFbqxJ68nNYvyyN8svq7Ch1OGsrEDrdA/6BKtOg==
X-Received: by 2002:a17:906:147:b0:712:1288:348f with SMTP id 7-20020a170906014700b007121288348fmr8089030ejh.324.1656247963997;
        Sun, 26 Jun 2022 05:52:43 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id u9-20020aa7d989000000b004355cb1e77esm5756757eds.91.2022.06.26.05.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jun 2022 05:52:43 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Georgi Djakov <djakov@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] dt-bindings: interconnect: samsung,exynos-bus: convert to dtschema
Date:   Sun, 26 Jun 2022 14:52:38 +0200
Message-Id: <20220626125238.57479-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Samsung Exynos SoC Bus and Interconnect bindings to DT
schema.

Vast parts of descritpion and example were copied, so keep license as
GPL-2.0-only.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/devfreq/exynos-bus.txt           | 488 ------------------
 .../interconnect/samsung,exynos-bus.yaml      | 290 +++++++++++
 MAINTAINERS                                   |   2 +-
 3 files changed, 291 insertions(+), 489 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/devfreq/exynos-bus.txt
 create mode 100644 Documentation/devicetree/bindings/interconnect/samsung,exynos-bus.yaml

diff --git a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt b/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
deleted file mode 100644
index bcaa2c08ac11..000000000000
--- a/Documentation/devicetree/bindings/devfreq/exynos-bus.txt
+++ /dev/null
@@ -1,488 +0,0 @@
-* Generic Exynos Bus frequency device
-
-The Samsung Exynos SoC has many buses for data transfer between DRAM
-and sub-blocks in SoC. Most Exynos SoCs share the common architecture
-for buses. Generally, each bus of Exynos SoC includes a source clock
-and a power line, which are able to change the clock frequency
-of the bus in runtime. To monitor the usage of each bus in runtime,
-the driver uses the PPMU (Platform Performance Monitoring Unit), which
-is able to measure the current load of sub-blocks.
-
-The Exynos SoC includes the various sub-blocks which have the each AXI bus.
-The each AXI bus has the owned source clock but, has not the only owned
-power line. The power line might be shared among one more sub-blocks.
-So, we can divide into two type of device as the role of each sub-block.
-There are two type of bus devices as following:
-- parent bus device
-- passive bus device
-
-Basically, parent and passive bus device share the same power line.
-The parent bus device can only change the voltage of shared power line
-and the rest bus devices (passive bus device) depend on the decision of
-the parent bus device. If there are three blocks which share the VDD_xxx
-power line, Only one block should be parent device and then the rest blocks
-should depend on the parent device as passive device.
-
-	VDD_xxx |--- A block (parent)
-		|--- B block (passive)
-		|--- C block (passive)
-
-There are a little different composition among Exynos SoC because each Exynos
-SoC has different sub-blocks. Therefore, such difference should be specified
-in devicetree file instead of each device driver. In result, this driver
-is able to support the bus frequency for all Exynos SoCs.
-
-Required properties for all bus devices:
-- compatible: Should be "samsung,exynos-bus".
-- clock-names : the name of clock used by the bus, "bus".
-- clocks : phandles for clock specified in "clock-names" property.
-- operating-points-v2: the OPP table including frequency/voltage information
-  to support DVFS (Dynamic Voltage/Frequency Scaling) feature.
-
-Required properties only for parent bus device:
-- vdd-supply: the regulator to provide the buses with the voltage.
-- devfreq-events: the devfreq-event device to monitor the current utilization
-  of buses.
-
-Required properties only for passive bus device:
-- devfreq: the parent bus device.
-
-Optional properties only for parent bus device:
-- exynos,saturation-ratio: the percentage value which is used to calibrate
-			the performance count against total cycle count.
-
-Optional properties for the interconnect functionality (QoS frequency
-constraints):
-- #interconnect-cells: should be 0.
-- interconnects: as documented in ../interconnect.txt, describes a path at the
-  higher level interconnects used by this interconnect provider.
-  If this interconnect provider is directly linked to a top level interconnect
-  provider the property contains only one phandle. The provider extends
-  the interconnect graph by linking its node to a node registered by provider
-  pointed to by first phandle in the 'interconnects' property.
-
-- samsung,data-clock-ratio: ratio of the data throughput in B/s to minimum data
-   clock frequency in Hz, default value is 8 when this property is missing.
-
-Detailed correlation between sub-blocks and power line according to Exynos SoC:
-- In case of Exynos3250, there are two power line as following:
-	VDD_MIF |--- DMC
-
-	VDD_INT |--- LEFTBUS (parent device)
-		|--- PERIL
-		|--- MFC
-		|--- G3D
-		|--- RIGHTBUS
-		|--- PERIR
-		|--- FSYS
-		|--- LCD0
-		|--- PERIR
-		|--- ISP
-		|--- CAM
-
-- In case of Exynos4210, there is one power line as following:
-	VDD_INT |--- DMC (parent device)
-		|--- LEFTBUS
-		|--- PERIL
-		|--- MFC(L)
-		|--- G3D
-		|--- TV
-		|--- LCD0
-		|--- RIGHTBUS
-		|--- PERIR
-		|--- MFC(R)
-		|--- CAM
-		|--- FSYS
-		|--- GPS
-		|--- LCD0
-		|--- LCD1
-
-- In case of Exynos4x12, there are two power line as following:
-	VDD_MIF |--- DMC
-
-	VDD_INT |--- LEFTBUS (parent device)
-		|--- PERIL
-		|--- MFC(L)
-		|--- G3D
-		|--- TV
-		|--- IMAGE
-		|--- RIGHTBUS
-		|--- PERIR
-		|--- MFC(R)
-		|--- CAM
-		|--- FSYS
-		|--- GPS
-		|--- LCD0
-		|--- ISP
-
-- In case of Exynos5422, there are two power line as following:
-	VDD_MIF |--- DREX 0 (parent device, DRAM EXpress controller)
-	        |--- DREX 1
-
-	VDD_INT |--- NoC_Core (parent device)
-		|--- G2D
-		|--- G3D
-		|--- DISP1
-		|--- NoC_WCORE
-		|--- GSCL
-		|--- MSCL
-		|--- ISP
-		|--- MFC
-		|--- GEN
-		|--- PERIS
-		|--- PERIC
-		|--- FSYS
-		|--- FSYS2
-
-- In case of Exynos5433, there is VDD_INT power line as following:
-	VDD_INT |--- G2D (parent device)
-		|--- MSCL
-		|--- GSCL
-		|--- JPEG
-		|--- MFC
-		|--- HEVC
-		|--- BUS0
-		|--- BUS1
-		|--- BUS2
-		|--- PERIS (Fixed clock rate)
-		|--- PERIC (Fixed clock rate)
-		|--- FSYS  (Fixed clock rate)
-
-Example 1:
-	Show the AXI buses of Exynos3250 SoC. Exynos3250 divides the buses to
-	power line (regulator). The MIF (Memory Interface) AXI bus is used to
-	transfer data between DRAM and CPU and uses the VDD_MIF regulator.
-
-	- MIF (Memory Interface) block
-	: VDD_MIF |--- DMC (Dynamic Memory Controller)
-
-	- INT (Internal) block
-	: VDD_INT |--- LEFTBUS (parent device)
-		  |--- PERIL
-		  |--- MFC
-		  |--- G3D
-		  |--- RIGHTBUS
-		  |--- FSYS
-		  |--- LCD0
-		  |--- PERIR
-		  |--- ISP
-		  |--- CAM
-
-	- MIF bus's frequency/voltage table
-	-----------------------
-	|Lv| Freq   | Voltage |
-	-----------------------
-	|L1| 50000  |800000   |
-	|L2| 100000 |800000   |
-	|L3| 134000 |800000   |
-	|L4| 200000 |825000   |
-	|L5| 400000 |875000   |
-	-----------------------
-
-	- INT bus's frequency/voltage table
-	----------------------------------------------------------
-	|Block|LEFTBUS|RIGHTBUS|MCUISP |ISP    |PERIL  ||VDD_INT |
-	| name|       |LCD0    |       |       |       ||        |
-	|     |       |FSYS    |       |       |       ||        |
-	|     |       |MFC     |       |       |       ||        |
-	----------------------------------------------------------
-	|Mode |*parent|passive |passive|passive|passive||        |
-	----------------------------------------------------------
-	|Lv   |Frequency                               ||Voltage |
-	----------------------------------------------------------
-	|L1   |50000  |50000   |50000  |50000  |50000  ||900000  |
-	|L2   |80000  |80000   |80000  |80000  |80000  ||900000  |
-	|L3   |100000 |100000  |100000 |100000 |100000 ||1000000 |
-	|L4   |134000 |134000  |200000 |200000 |       ||1000000 |
-	|L5   |200000 |200000  |400000 |300000 |       ||1000000 |
-	----------------------------------------------------------
-
-Example 2:
-	The bus of DMC (Dynamic Memory Controller) block in exynos3250.dtsi
-	is listed below:
-
-	bus_dmc: bus_dmc {
-		compatible = "samsung,exynos-bus";
-		clocks = <&cmu_dmc CLK_DIV_DMC>;
-		clock-names = "bus";
-		operating-points-v2 = <&bus_dmc_opp_table>;
-		status = "disabled";
-	};
-
-	bus_dmc_opp_table: opp_table1 {
-		compatible = "operating-points-v2";
-		opp-shared;
-
-		opp-50000000 {
-			opp-hz = /bits/ 64 <50000000>;
-			opp-microvolt = <800000>;
-		};
-		opp-100000000 {
-			opp-hz = /bits/ 64 <100000000>;
-			opp-microvolt = <800000>;
-		};
-		opp-134000000 {
-			opp-hz = /bits/ 64 <134000000>;
-			opp-microvolt = <800000>;
-		};
-		opp-200000000 {
-			opp-hz = /bits/ 64 <200000000>;
-			opp-microvolt = <825000>;
-		};
-		opp-400000000 {
-			opp-hz = /bits/ 64 <400000000>;
-			opp-microvolt = <875000>;
-		};
-	};
-
-	bus_leftbus: bus_leftbus {
-		compatible = "samsung,exynos-bus";
-		clocks = <&cmu CLK_DIV_GDL>;
-		clock-names = "bus";
-		operating-points-v2 = <&bus_leftbus_opp_table>;
-		status = "disabled";
-	};
-
-	bus_rightbus: bus_rightbus {
-		compatible = "samsung,exynos-bus";
-		clocks = <&cmu CLK_DIV_GDR>;
-		clock-names = "bus";
-		operating-points-v2 = <&bus_leftbus_opp_table>;
-		status = "disabled";
-	};
-
-	bus_lcd0: bus_lcd0 {
-		compatible = "samsung,exynos-bus";
-		clocks = <&cmu CLK_DIV_ACLK_160>;
-		clock-names = "bus";
-		operating-points-v2 = <&bus_leftbus_opp_table>;
-		status = "disabled";
-	};
-
-	bus_fsys: bus_fsys {
-		compatible = "samsung,exynos-bus";
-		clocks = <&cmu CLK_DIV_ACLK_200>;
-		clock-names = "bus";
-		operating-points-v2 = <&bus_leftbus_opp_table>;
-		status = "disabled";
-	};
-
-	bus_mcuisp: bus_mcuisp {
-		compatible = "samsung,exynos-bus";
-		clocks = <&cmu CLK_DIV_ACLK_400_MCUISP>;
-		clock-names = "bus";
-		operating-points-v2 = <&bus_mcuisp_opp_table>;
-		status = "disabled";
-	};
-
-	bus_isp: bus_isp {
-		compatible = "samsung,exynos-bus";
-		clocks = <&cmu CLK_DIV_ACLK_266>;
-		clock-names = "bus";
-		operating-points-v2 = <&bus_isp_opp_table>;
-		status = "disabled";
-	};
-
-	bus_peril: bus_peril {
-		compatible = "samsung,exynos-bus";
-		clocks = <&cmu CLK_DIV_ACLK_100>;
-		clock-names = "bus";
-		operating-points-v2 = <&bus_peril_opp_table>;
-		status = "disabled";
-	};
-
-	bus_mfc: bus_mfc {
-		compatible = "samsung,exynos-bus";
-		clocks = <&cmu CLK_SCLK_MFC>;
-		clock-names = "bus";
-		operating-points-v2 = <&bus_leftbus_opp_table>;
-		status = "disabled";
-	};
-
-	bus_leftbus_opp_table: opp_table1 {
-		compatible = "operating-points-v2";
-		opp-shared;
-
-		opp-50000000 {
-			opp-hz = /bits/ 64 <50000000>;
-			opp-microvolt = <900000>;
-		};
-		opp-80000000 {
-			opp-hz = /bits/ 64 <80000000>;
-			opp-microvolt = <900000>;
-		};
-		opp-100000000 {
-			opp-hz = /bits/ 64 <100000000>;
-			opp-microvolt = <1000000>;
-		};
-		opp-134000000 {
-			opp-hz = /bits/ 64 <134000000>;
-			opp-microvolt = <1000000>;
-		};
-		opp-200000000 {
-			opp-hz = /bits/ 64 <200000000>;
-			opp-microvolt = <1000000>;
-		};
-	};
-
-	bus_mcuisp_opp_table: opp_table2 {
-		compatible = "operating-points-v2";
-		opp-shared;
-
-		opp-50000000 {
-			opp-hz = /bits/ 64 <50000000>;
-		};
-		opp-80000000 {
-			opp-hz = /bits/ 64 <80000000>;
-		};
-		opp-100000000 {
-			opp-hz = /bits/ 64 <100000000>;
-		};
-		opp-200000000 {
-			opp-hz = /bits/ 64 <200000000>;
-		};
-		opp-400000000 {
-			opp-hz = /bits/ 64 <400000000>;
-		};
-	};
-
-	bus_isp_opp_table: opp_table3 {
-		compatible = "operating-points-v2";
-		opp-shared;
-
-		opp-50000000 {
-			opp-hz = /bits/ 64 <50000000>;
-		};
-		opp-80000000 {
-			opp-hz = /bits/ 64 <80000000>;
-		};
-		opp-100000000 {
-			opp-hz = /bits/ 64 <100000000>;
-		};
-		opp-200000000 {
-			opp-hz = /bits/ 64 <200000000>;
-		};
-		opp-300000000 {
-			opp-hz = /bits/ 64 <300000000>;
-		};
-	};
-
-	bus_peril_opp_table: opp_table4 {
-		compatible = "operating-points-v2";
-		opp-shared;
-
-		opp-50000000 {
-			opp-hz = /bits/ 64 <50000000>;
-		};
-		opp-80000000 {
-			opp-hz = /bits/ 64 <80000000>;
-		};
-		opp-100000000 {
-			opp-hz = /bits/ 64 <100000000>;
-		};
-	};
-
-
-	Usage case to handle the frequency and voltage of bus on runtime
-	in exynos3250-rinato.dts is listed below:
-
-	&bus_dmc {
-		devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
-		vdd-supply = <&buck1_reg>;	/* VDD_MIF */
-		status = "okay";
-	};
-
-	&bus_leftbus {
-		devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
-		vdd-supply = <&buck3_reg>;
-		status = "okay";
-	};
-
-	&bus_rightbus {
-		devfreq = <&bus_leftbus>;
-		status = "okay";
-	};
-
-	&bus_lcd0 {
-		devfreq = <&bus_leftbus>;
-		status = "okay";
-	};
-
-	&bus_fsys {
-		devfreq = <&bus_leftbus>;
-		status = "okay";
-	};
-
-	&bus_mcuisp {
-		devfreq = <&bus_leftbus>;
-		status = "okay";
-	};
-
-	&bus_isp {
-		devfreq = <&bus_leftbus>;
-		status = "okay";
-	};
-
-	&bus_peril {
-		devfreq = <&bus_leftbus>;
-		status = "okay";
-	};
-
-	&bus_mfc {
-		devfreq = <&bus_leftbus>;
-		status = "okay";
-	};
-
-Example 3:
-	An interconnect path "bus_display -- bus_leftbus -- bus_dmc" on
-	Exynos4412 SoC with video mixer as an interconnect consumer device.
-
-	soc {
-		bus_dmc: bus_dmc {
-			compatible = "samsung,exynos-bus";
-			clocks = <&clock CLK_DIV_DMC>;
-			clock-names = "bus";
-			operating-points-v2 = <&bus_dmc_opp_table>;
-			samsung,data-clock-ratio = <4>;
-			#interconnect-cells = <0>;
-		};
-
-		bus_leftbus: bus_leftbus {
-			compatible = "samsung,exynos-bus";
-			clocks = <&clock CLK_DIV_GDL>;
-			clock-names = "bus";
-			operating-points-v2 = <&bus_leftbus_opp_table>;
-			#interconnect-cells = <0>;
-			interconnects = <&bus_dmc>;
-		};
-
-		bus_display: bus_display {
-			compatible = "samsung,exynos-bus";
-			clocks = <&clock CLK_ACLK160>;
-			clock-names = "bus";
-			operating-points-v2 = <&bus_display_opp_table>;
-			#interconnect-cells = <0>;
-			interconnects = <&bus_leftbus &bus_dmc>;
-		};
-
-		bus_dmc_opp_table: opp_table1 {
-			compatible = "operating-points-v2";
-			/* ... */
-		}
-
-		bus_leftbus_opp_table: opp_table3 {
-			compatible = "operating-points-v2";
-			/* ... */
-		};
-
-		bus_display_opp_table: opp_table4 {
-			compatible = "operating-points-v2";
-			/* .. */
-		};
-
-		&mixer {
-			compatible = "samsung,exynos4212-mixer";
-			interconnects = <&bus_display &bus_dmc>;
-			/* ... */
-		};
-	};
diff --git a/Documentation/devicetree/bindings/interconnect/samsung,exynos-bus.yaml b/Documentation/devicetree/bindings/interconnect/samsung,exynos-bus.yaml
new file mode 100644
index 000000000000..ad9ed596dfef
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/samsung,exynos-bus.yaml
@@ -0,0 +1,290 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interconnect/samsung,exynos-bus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos SoC Bus and Interconnect
+
+maintainers:
+  - Chanwoo Choi <cw00.choi@samsung.com>
+  - Krzysztof Kozlowski <krzk@kernel.org>
+
+description: |
+  The Samsung Exynos SoC has many buses for data transfer between DRAM and
+  sub-blocks in SoC. Most Exynos SoCs share the common architecture for buses.
+  Generally, each bus of Exynos SoC includes a source clock and a power line,
+  which are able to change the clock frequency of the bus in runtime. To
+  monitor the usage of each bus in runtime, the driver uses the PPMU (Platform
+  Performance Monitoring Unit), which is able to measure the current load of
+  sub-blocks.
+
+  The Exynos SoC includes the various sub-blocks which have the each AXI bus.
+  The each AXI bus has the owned source clock but, has not the only owned power
+  line. The power line might be shared among one more sub-blocks.  So, we can
+  divide into two type of device as the role of each sub-block.  There are two
+  type of bus devices as following::
+   - parent bus device
+   - passive bus device
+
+  Basically, parent and passive bus device share the same power line.  The
+  parent bus device can only change the voltage of shared power line and the
+  rest bus devices (passive bus device) depend on the decision of the parent
+  bus device. If there are three blocks which share the VDD_xxx power line,
+  Only one block should be parent device and then the rest blocks should depend
+  on the parent device as passive device.
+
+    VDD_xxx |--- A block (parent)
+      |--- B block (passive)
+      |--- C block (passive)
+
+  There are a little different composition among Exynos SoC because each Exynos
+  SoC has different sub-blocks. Therefore, such difference should be specified
+  in devicetree file instead of each device driver. In result, this driver is
+  able to support the bus frequency for all Exynos SoCs.
+
+  Detailed correlation between sub-blocks and power line according
+  to Exynos SoC::
+   - In case of Exynos3250, there are two power line as following::
+     VDD_MIF |--- DMC (Dynamic Memory Controller)
+
+     VDD_INT |--- LEFTBUS (parent device)
+       |--- PERIL
+       |--- MFC
+       |--- G3D
+       |--- RIGHTBUS
+       |--- PERIR
+       |--- FSYS
+       |--- LCD0
+       |--- PERIR
+       |--- ISP
+       |--- CAM
+
+     - MIF bus's frequency/voltage table
+       -----------------------
+       |Lv| Freq   | Voltage |
+       -----------------------
+       |L1| 50000  |800000   |
+       |L2| 100000 |800000   |
+       |L3| 134000 |800000   |
+       |L4| 200000 |825000   |
+       |L5| 400000 |875000   |
+       -----------------------
+
+     - INT bus's frequency/voltage table
+       ----------------------------------------------------------
+       |Block|LEFTBUS|RIGHTBUS|MCUISP |ISP    |PERIL  ||VDD_INT |
+       | name|       |LCD0    |       |       |       ||        |
+       |     |       |FSYS    |       |       |       ||        |
+       |     |       |MFC     |       |       |       ||        |
+       ----------------------------------------------------------
+       |Mode |*parent|passive |passive|passive|passive||        |
+       ----------------------------------------------------------
+       |Lv   |Frequency                               ||Voltage |
+       ----------------------------------------------------------
+       |L1   |50000  |50000   |50000  |50000  |50000  ||900000  |
+       |L2   |80000  |80000   |80000  |80000  |80000  ||900000  |
+       |L3   |100000 |100000  |100000 |100000 |100000 ||1000000 |
+       |L4   |134000 |134000  |200000 |200000 |       ||1000000 |
+       |L5   |200000 |200000  |400000 |300000 |       ||1000000 |
+       ----------------------------------------------------------
+
+   - In case of Exynos4210, there is one power line as following::
+     VDD_INT |--- DMC (parent device, Dynamic Memory Controller)
+       |--- LEFTBUS
+       |--- PERIL
+       |--- MFC(L)
+       |--- G3D
+       |--- TV
+       |--- LCD0
+       |--- RIGHTBUS
+       |--- PERIR
+       |--- MFC(R)
+       |--- CAM
+       |--- FSYS
+       |--- GPS
+       |--- LCD0
+       |--- LCD1
+
+   - In case of Exynos4x12, there are two power line as following::
+     VDD_MIF |--- DMC (Dynamic Memory Controller)
+
+     VDD_INT |--- LEFTBUS (parent device)
+       |--- PERIL
+       |--- MFC(L)
+       |--- G3D
+       |--- TV
+       |--- IMAGE
+       |--- RIGHTBUS
+       |--- PERIR
+       |--- MFC(R)
+       |--- CAM
+       |--- FSYS
+       |--- GPS
+       |--- LCD0
+       |--- ISP
+
+   - In case of Exynos5422, there are two power line as following::
+     VDD_MIF |--- DREX 0 (parent device, DRAM EXpress controller)
+             |--- DREX 1
+
+     VDD_INT |--- NoC_Core (parent device)
+       |--- G2D
+       |--- G3D
+       |--- DISP1
+       |--- NoC_WCORE
+       |--- GSCL
+       |--- MSCL
+       |--- ISP
+       |--- MFC
+       |--- GEN
+       |--- PERIS
+       |--- PERIC
+       |--- FSYS
+       |--- FSYS2
+
+   - In case of Exynos5433, there is VDD_INT power line as following::
+     VDD_INT |--- G2D (parent device)
+       |--- MSCL
+       |--- GSCL
+       |--- JPEG
+       |--- MFC
+       |--- HEVC
+       |--- BUS0
+       |--- BUS1
+       |--- BUS2
+       |--- PERIS (Fixed clock rate)
+       |--- PERIC (Fixed clock rate)
+       |--- FSYS  (Fixed clock rate)
+
+properties:
+  compatible:
+    enum:
+      - samsung,exynos-bus
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: bus
+
+  devfreq:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Parent bus device. Valid and required only for the passive bus devices.
+
+  devfreq-events:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    minItems: 1
+    maxItems: 4
+    description:
+      Devfreq-event device to monitor the current utilization of buses. Valid
+      and required only for the parent bus devices.
+
+  exynos,saturation-ratio:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Percentage value which is used to calibrate the performance count against
+      total cycle count.  Valid only for the parent bus devices.
+
+  '#interconnect-cells':
+    const: 0
+
+  interconnects:
+    minItems: 1
+    maxItems: 2
+
+  operating-points-v2: true
+
+  samsung,data-clock-ratio:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    default: 8
+    description:
+      Ratio of the data throughput in B/s to minimum data clock frequency in
+      Hz.
+
+  vdd-supply:
+    description:
+      Main bus power rail. Valid and required only for the parent bus devices.
+
+required:
+  - compatible
+  - clocks
+  - clock-names
+  - operating-points-v2
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/exynos3250.h>
+
+    bus-dmc {
+        compatible = "samsung,exynos-bus";
+        clocks = <&cmu_dmc CLK_DIV_DMC>;
+        clock-names = "bus";
+        operating-points-v2 = <&bus_dmc_opp_table>;
+        devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
+        vdd-supply = <&buck1_reg>;
+    };
+
+    ppmu_dmc0: ppmu@106a0000 {
+        compatible = "samsung,exynos-ppmu";
+        reg = <0x106a0000 0x2000>;
+        events {
+            ppmu_dmc0_3: ppmu-event3-dmc0 {
+                event-name = "ppmu-event3-dmc0";
+            };
+        };
+    };
+
+    bus_leftbus: bus-leftbus {
+        compatible = "samsung,exynos-bus";
+        clocks = <&cmu CLK_DIV_GDL>;
+        clock-names = "bus";
+        operating-points-v2 = <&bus_leftbus_opp_table>;
+        devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
+        vdd-supply = <&buck3_reg>;
+    };
+
+    bus-rightbus {
+        compatible = "samsung,exynos-bus";
+        clocks = <&cmu CLK_DIV_GDR>;
+        clock-names = "bus";
+        operating-points-v2 = <&bus_leftbus_opp_table>;
+        devfreq = <&bus_leftbus>;
+    };
+
+  - |
+    dmc: bus-dmc {
+        compatible = "samsung,exynos-bus";
+        clocks = <&clock CLK_DIV_DMC>;
+        clock-names = "bus";
+        operating-points-v2 = <&bus_dmc_opp_table>;
+        samsung,data-clock-ratio = <4>;
+        #interconnect-cells = <0>;
+        devfreq-events = <&ppmu_dmc0_3>, <&ppmu_dmc1_3>;
+        vdd-supply = <&buck1_reg>;
+    };
+
+    leftbus: bus-leftbus {
+        compatible = "samsung,exynos-bus";
+        clocks = <&clock CLK_DIV_GDL>;
+        clock-names = "bus";
+        operating-points-v2 = <&bus_leftbus_opp_table>;
+        interconnects = <&dmc>;
+        #interconnect-cells = <0>;
+        devfreq-events = <&ppmu_leftbus_3>, <&ppmu_rightbus_3>;
+        vdd-supply = <&buck3_reg>;
+    };
+
+    display: bus-display {
+        compatible = "samsung,exynos-bus";
+        clocks = <&clock CLK_DIV_ACLK_266>;
+        clock-names = "bus";
+        operating-points-v2 = <&bus_display_opp_table>;
+        interconnects = <&leftbus &dmc>;
+        #interconnect-cells = <0>;
+        devfreq = <&leftbus>;
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 7c9187635801..19875f60ebb1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4328,7 +4328,7 @@ L:	linux-pm@vger.kernel.org
 L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/chanwoo/linux.git
-F:	Documentation/devicetree/bindings/devfreq/exynos-bus.txt
+F:	Documentation/devicetree/bindings/interconnect/samsung,exynos-bus.yaml
 F:	drivers/devfreq/exynos-bus.c
 
 BUSLOGIC SCSI DRIVER
-- 
2.34.1

