Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FC2D5354EB
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 22:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349030AbiEZUnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 16:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349073AbiEZUnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 16:43:22 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C19E039
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:43:09 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id y13so5180107eje.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 13:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1UwojV3tm9tauxjCIk2ZNOBAbSCU0kTej6xl5dVjulU=;
        b=oiJYVaUSAXvMNl5VSeH2CaQms+rPdBL6G1s1pwBpJqWlJ+yXlZCfgIj5bgjOmpot87
         jdlywfbVd2tc8KDqbf9p57LecfRSDqfOzHw9/ez3Qn+5xpQ4MK3W6N2jUAH5hOBOVF2z
         lV7kSkQ0e5ycjML9mBN5HG8quLbfGB0qlUIHjt33VgOGP8zFvHUis/x5IBDZfJ6Dk+Nj
         BxMfuzjZMVtuffaOEbFGHMmBWvt+ijFPYQeJUkqGjAklhNMy/0AiU08qlAZ7ReD6CeYm
         HtyBvmOTZqMdkTbC+4PDt48ZjqfS1X1vbUDWSr5toh6Z4hWfo4znnD76818pH498BruG
         EH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1UwojV3tm9tauxjCIk2ZNOBAbSCU0kTej6xl5dVjulU=;
        b=A4VlY06bxLZXsgwbRS1MeGtVbDw70Y0cGMseJx2u0AyPlTkMWiVe+8kUqjJuuV/2us
         nLUxgBwTLbw7i4pgxuud2OCtQ7NzEfaPgjO8MnK807UI6NBR9s7EGZyEKrWZJe3fZ8Bp
         O+1qeGuvKBxwoGdKiJLnoSOSzWY2gB4NEmRK/c4h/nFBj1Hvjs1MiNUbtbw8OnwCSRpo
         39Nsq9PB2020QeFXqAHUHvJZMXlP+S2QHbYP1yLRzpC7QK5lHsKKuaU1S+BvHpvFQ1Qm
         /gCGgBglAgRJ7+2l1cR93bNEiYJ6kNnrJw/EMARJoBXKfMwR2+hbptAaP7foHGU0+Bj4
         4N0A==
X-Gm-Message-State: AOAM532Jx6lrLSfRIsGQdYjOP4WB7x5FtW/gttHAvx7phr4RBdRBPKSu
        Xn6rYUriPwVsCsNaet1LllN2bg==
X-Google-Smtp-Source: ABdhPJyapqPNsUK2NPdUMEGVyY0oyu86UUWz32vDRVaRp7S3yJQeqRihOeBRPlCqHFfk4/fI7FI21g==
X-Received: by 2002:a17:906:7b82:b0:6f3:ee8d:b959 with SMTP id s2-20020a1709067b8200b006f3ee8db959mr36545892ejo.458.1653597788737;
        Thu, 26 May 2022 13:43:08 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id s25-20020a170906bc5900b006fed40e5564sm802097ejv.83.2022.05.26.13.43.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 13:43:08 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Arnd Bergmann <arnd@arndb.de>, Olof Johansson <olof@lixom.net>,
        arm@kernel.org, soc@kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] arm64: dts: fsl: adjust whitespace around '='
Date:   Thu, 26 May 2022 22:42:56 +0200
Message-Id: <20220526204258.832179-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix whitespace coding style: use single space instead of tabs or
multiple spaces around '=' sign in property assignment.  No functional
changes (same DTB).

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Output compared with dtx_diff and fdtdump.
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi   |  8 ++++----
 .../arm64/boot/dts/freescale/fsl-ls1028a-qds.dts |  2 +-
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi   | 16 ++++++++--------
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi   | 10 +++++-----
 arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi   | 10 +++++-----
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi   |  8 ++++----
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi   | 10 +++++-----
 .../arm64/boot/dts/freescale/fsl-lx2160a-qds.dts |  4 ++--
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi   |  8 ++++----
 .../arm64/boot/dts/freescale/fsl-lx2162a-qds.dts |  4 ++--
 arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi  | 10 +++++-----
 .../dts/freescale/imx8mm-beacon-baseboard.dtsi   |  4 ++--
 .../boot/dts/freescale/imx8mm-icore-mx8mm.dtsi   | 12 ++++++------
 .../boot/dts/freescale/imx8mm-venice-gw700x.dtsi | 16 ++++++++--------
 arch/arm64/boot/dts/freescale/imx8mm.dtsi        |  8 ++++----
 .../dts/freescale/imx8mn-beacon-baseboard.dtsi   |  4 ++--
 arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi    |  2 +-
 arch/arm64/boot/dts/freescale/imx8mn.dtsi        | 10 +++++-----
 arch/arm64/boot/dts/freescale/imx8mp.dtsi        |  8 ++++----
 .../arm64/boot/dts/freescale/imx8mq-nitrogen.dts |  4 ++--
 .../boot/dts/freescale/imx8mq-zii-ultra.dtsi     |  2 +-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi        |  4 ++--
 .../dts/freescale/imx8qxp-colibri-eval-v3.dtsi   |  6 +++---
 arch/arm64/boot/dts/freescale/imx8ulp.dtsi       |  6 +++---
 24 files changed, 88 insertions(+), 88 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index 50a72cda4727..e54910b163a5 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -204,7 +204,7 @@ sec_jr0: jr@10000 {
 				compatible = "fsl,sec-v5.4-job-ring",
 					     "fsl,sec-v5.0-job-ring",
 					     "fsl,sec-v4.0-job-ring";
-				reg	   = <0x10000 0x10000>;
+				reg = <0x10000 0x10000>;
 				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
@@ -212,7 +212,7 @@ sec_jr1: jr@20000 {
 				compatible = "fsl,sec-v5.4-job-ring",
 					     "fsl,sec-v5.0-job-ring",
 					     "fsl,sec-v4.0-job-ring";
-				reg	   = <0x20000 0x10000>;
+				reg = <0x20000 0x10000>;
 				interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
@@ -220,7 +220,7 @@ sec_jr2: jr@30000 {
 				compatible = "fsl,sec-v5.4-job-ring",
 					     "fsl,sec-v5.0-job-ring",
 					     "fsl,sec-v4.0-job-ring";
-				reg	   = <0x30000 0x10000>;
+				reg = <0x30000 0x10000>;
 				interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
@@ -228,7 +228,7 @@ sec_jr3: jr@40000 {
 				compatible = "fsl,sec-v5.4-job-ring",
 					     "fsl,sec-v5.0-job-ring",
 					     "fsl,sec-v4.0-job-ring";
-				reg	   = <0x40000 0x10000>;
+				reg = <0x40000 0x10000>;
 				interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
index 5baf060acf93..0bb2f28a0441 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a-qds.dts
@@ -93,7 +93,7 @@ mdio-mux {
 		compatible = "mdio-mux-multiplexer";
 		mux-controls = <&mux 0>;
 		mdio-parent-bus = <&enetc_mdio_pf3>;
-		#address-cells=<1>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 
 		/* on-board RGMII PHY */
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 92465f777603..3376eeab84ba 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -96,7 +96,7 @@ optee: optee  {
 	};
 
 	reboot {
-		compatible ="syscon-reboot";
+		compatible = "syscon-reboot";
 		regmap = <&rst>;
 		offset = <0>;
 		mask = <0x02>;
@@ -120,13 +120,13 @@ pmu {
 	};
 
 	gic: interrupt-controller@6000000 {
-		compatible= "arm,gic-v3";
+		compatible = "arm,gic-v3";
 		#address-cells = <2>;
 		#size-cells = <2>;
 		ranges;
-		reg= <0x0 0x06000000 0 0x10000>, /* GIC Dist */
+		reg = <0x0 0x06000000 0 0x10000>, /* GIC Dist */
 			<0x0 0x06040000 0 0x40000>; /* GIC Redistributor */
-		#interrupt-cells= <3>;
+		#interrupt-cells = <3>;
 		interrupt-controller;
 		interrupts = <GIC_PPI 9 (GIC_CPU_MASK_RAW(0xf) |
 					 IRQ_TYPE_LEVEL_LOW)>;
@@ -769,28 +769,28 @@ crypto: crypto@8000000 {
 			sec_jr0: jr@10000 {
 				compatible = "fsl,sec-v5.0-job-ring",
 					     "fsl,sec-v4.0-job-ring";
-				reg	= <0x10000 0x10000>;
+				reg = <0x10000 0x10000>;
 				interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			sec_jr1: jr@20000 {
 				compatible = "fsl,sec-v5.0-job-ring",
 					     "fsl,sec-v4.0-job-ring";
-				reg	= <0x20000 0x10000>;
+				reg = <0x20000 0x10000>;
 				interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			sec_jr2: jr@30000 {
 				compatible = "fsl,sec-v5.0-job-ring",
 					     "fsl,sec-v4.0-job-ring";
-				reg	= <0x30000 0x10000>;
+				reg = <0x30000 0x10000>;
 				interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			sec_jr3: jr@40000 {
 				compatible = "fsl,sec-v5.0-job-ring",
 					     "fsl,sec-v4.0-job-ring";
-				reg	= <0x40000 0x10000>;
+				reg = <0x40000 0x10000>;
 				interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 21200cbf7161..bb5708e141a5 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -144,7 +144,7 @@ sysclk: sysclk {
 	};
 
 	reboot {
-		compatible ="syscon-reboot";
+		compatible = "syscon-reboot";
 		regmap = <&dcfg>;
 		offset = <0xb0>;
 		mask = <0x02>;
@@ -354,7 +354,7 @@ sec_jr0: jr@10000 {
 				compatible = "fsl,sec-v5.4-job-ring",
 					     "fsl,sec-v5.0-job-ring",
 					     "fsl,sec-v4.0-job-ring";
-				reg	   = <0x10000 0x10000>;
+				reg = <0x10000 0x10000>;
 				interrupts = <0 71 0x4>;
 			};
 
@@ -362,7 +362,7 @@ sec_jr1: jr@20000 {
 				compatible = "fsl,sec-v5.4-job-ring",
 					     "fsl,sec-v5.0-job-ring",
 					     "fsl,sec-v4.0-job-ring";
-				reg	   = <0x20000 0x10000>;
+				reg = <0x20000 0x10000>;
 				interrupts = <0 72 0x4>;
 			};
 
@@ -370,7 +370,7 @@ sec_jr2: jr@30000 {
 				compatible = "fsl,sec-v5.4-job-ring",
 					     "fsl,sec-v5.0-job-ring",
 					     "fsl,sec-v4.0-job-ring";
-				reg	   = <0x30000 0x10000>;
+				reg = <0x30000 0x10000>;
 				interrupts = <0 73 0x4>;
 			};
 
@@ -378,7 +378,7 @@ sec_jr3: jr@40000 {
 				compatible = "fsl,sec-v5.4-job-ring",
 					     "fsl,sec-v5.0-job-ring",
 					     "fsl,sec-v4.0-job-ring";
-				reg	   = <0x40000 0x10000>;
+				reg = <0x40000 0x10000>;
 				interrupts = <0 74 0x4>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
index 0085e83adf65..3690bc1ce497 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1046a.dtsi
@@ -112,7 +112,7 @@ sysclk: sysclk {
 	};
 
 	reboot {
-		compatible ="syscon-reboot";
+		compatible = "syscon-reboot";
 		regmap = <&dcfg>;
 		offset = <0xb0>;
 		mask = <0x02>;
@@ -360,7 +360,7 @@ sec_jr0: jr@10000 {
 				compatible = "fsl,sec-v5.4-job-ring",
 					     "fsl,sec-v5.0-job-ring",
 					     "fsl,sec-v4.0-job-ring";
-				reg	   = <0x10000 0x10000>;
+				reg = <0x10000 0x10000>;
 				interrupts = <GIC_SPI 71 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
@@ -368,7 +368,7 @@ sec_jr1: jr@20000 {
 				compatible = "fsl,sec-v5.4-job-ring",
 					     "fsl,sec-v5.0-job-ring",
 					     "fsl,sec-v4.0-job-ring";
-				reg	   = <0x20000 0x10000>;
+				reg = <0x20000 0x10000>;
 				interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
@@ -376,7 +376,7 @@ sec_jr2: jr@30000 {
 				compatible = "fsl,sec-v5.4-job-ring",
 					     "fsl,sec-v5.0-job-ring",
 					     "fsl,sec-v4.0-job-ring";
-				reg	   = <0x30000 0x10000>;
+				reg = <0x30000 0x10000>;
 				interrupts = <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
@@ -384,7 +384,7 @@ sec_jr3: jr@40000 {
 				compatible = "fsl,sec-v5.4-job-ring",
 					     "fsl,sec-v5.0-job-ring",
 					     "fsl,sec-v4.0-job-ring";
-				reg	   = <0x40000 0x10000>;
+				reg = <0x40000 0x10000>;
 				interrupts = <GIC_SPI 74 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index f476b7d8b056..1456364ab795 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -526,28 +526,28 @@ crypto: crypto@8000000 {
 			sec_jr0: jr@10000 {
 				compatible = "fsl,sec-v5.0-job-ring",
 					     "fsl,sec-v4.0-job-ring";
-				reg	   = <0x10000 0x10000>;
+				reg = <0x10000 0x10000>;
 				interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			sec_jr1: jr@20000 {
 				compatible = "fsl,sec-v5.0-job-ring",
 					     "fsl,sec-v4.0-job-ring";
-				reg	   = <0x20000 0x10000>;
+				reg = <0x20000 0x10000>;
 				interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			sec_jr2: jr@30000 {
 				compatible = "fsl,sec-v5.0-job-ring",
 					     "fsl,sec-v4.0-job-ring";
-				reg	   = <0x30000 0x10000>;
+				reg = <0x30000 0x10000>;
 				interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			sec_jr3: jr@40000 {
 				compatible = "fsl,sec-v5.0-job-ring",
 					     "fsl,sec-v4.0-job-ring";
-				reg	   = <0x40000 0x10000>;
+				reg = <0x40000 0x10000>;
 				interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 4ba1e0499dfd..3692d4cf6fcf 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -73,7 +73,7 @@ rstcr: syscon@1e60000 {
 	};
 
 	reboot {
-		compatible ="syscon-reboot";
+		compatible = "syscon-reboot";
 		regmap = <&rstcr>;
 		offset = <0x0>;
 		mask = <0x2>;
@@ -479,28 +479,28 @@ crypto: crypto@8000000 {
 			sec_jr0: jr@10000 {
 				compatible = "fsl,sec-v5.0-job-ring",
 					     "fsl,sec-v4.0-job-ring";
-				reg	   = <0x10000 0x10000>;
+				reg = <0x10000 0x10000>;
 				interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			sec_jr1: jr@20000 {
 				compatible = "fsl,sec-v5.0-job-ring",
 					     "fsl,sec-v4.0-job-ring";
-				reg	   = <0x20000 0x10000>;
+				reg = <0x20000 0x10000>;
 				interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			sec_jr2: jr@30000 {
 				compatible = "fsl,sec-v5.0-job-ring",
 					     "fsl,sec-v4.0-job-ring";
-				reg	   = <0x30000 0x10000>;
+				reg = <0x30000 0x10000>;
 				interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			sec_jr3: jr@40000 {
 				compatible = "fsl,sec-v5.0-job-ring",
 					     "fsl,sec-v4.0-job-ring";
-				reg	   = <0x40000 0x10000>;
+				reg = <0x40000 0x10000>;
 				interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
index 2ecfa90f5e28..4d721197d837 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a-qds.dts
@@ -36,7 +36,7 @@ mdio-mux-1 {
 		compatible = "mdio-mux-multiplexer";
 		mux-controls = <&mux 0>;
 		mdio-parent-bus = <&emdio1>;
-		#address-cells=<1>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 
 		mdio@0 { /* On-board PHY #1 RGMI1*/
@@ -104,7 +104,7 @@ mdio-mux-2 {
 		compatible = "mdio-mux-multiplexer";
 		mux-controls = <&mux 1>;
 		mdio-parent-bus = <&emdio2>;
-		#address-cells=<1>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 
 		mdio@0 { /* Slot #1 (secondary EMI) */
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 47ea854720ce..2f834f688bbe 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -632,28 +632,28 @@ crypto: crypto@8000000 {
 			sec_jr0: jr@10000 {
 				compatible = "fsl,sec-v5.0-job-ring",
 					     "fsl,sec-v4.0-job-ring";
-				reg        = <0x10000 0x10000>;
+				reg = <0x10000 0x10000>;
 				interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			sec_jr1: jr@20000 {
 				compatible = "fsl,sec-v5.0-job-ring",
 					     "fsl,sec-v4.0-job-ring";
-				reg        = <0x20000 0x10000>;
+				reg = <0x20000 0x10000>;
 				interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			sec_jr2: jr@30000 {
 				compatible = "fsl,sec-v5.0-job-ring",
 					     "fsl,sec-v4.0-job-ring";
-				reg        = <0x30000 0x10000>;
+				reg = <0x30000 0x10000>;
 				interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
 			};
 
 			sec_jr3: jr@40000 {
 				compatible = "fsl,sec-v5.0-job-ring",
 					     "fsl,sec-v4.0-job-ring";
-				reg        = <0x40000 0x10000>;
+				reg = <0x40000 0x10000>;
 				interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts
index a1644ceed154..9f5ff1ffe7d5 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2162a-qds.dts
@@ -34,7 +34,7 @@ mdio-mux-1 {
 		compatible = "mdio-mux-multiplexer";
 		mux-controls = <&mux 0>;
 		mdio-parent-bus = <&emdio1>;
-		#address-cells=<1>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 
 		mdio@0 { /* On-board RTL8211F PHY #1 RGMII1 */
@@ -114,7 +114,7 @@ mdio-mux-2 {
 		compatible = "mdio-mux-multiplexer";
 		mux-controls = <&mux 1>;
 		mdio-parent-bus = <&emdio2>;
-		#address-cells=<1>;
+		#address-cells = <1>;
 		#size-cells = <0>;
 
 		mdio@0 { /* Slot #1 (secondary EMI) */
diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
index a79f42a9618e..82a1c4488378 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-conn.dtsi
@@ -54,7 +54,7 @@ usdhc2: mmc@5b020000 {
 		clock-names = "ipg", "per", "ahb";
 		power-domains = <&pd IMX_SC_R_SDHC_1>;
 		fsl,tuning-start-tap = <20>;
-		fsl,tuning-step= <2>;
+		fsl,tuning-step = <2>;
 		status = "disabled";
 	};
 
@@ -83,8 +83,8 @@ fec1: ethernet@5b040000 {
 		assigned-clocks = <&clk IMX_SC_R_ENET_0 IMX_SC_PM_CLK_PER>,
 				  <&clk IMX_SC_R_ENET_0 IMX_SC_C_CLKDIV>;
 		assigned-clock-rates = <250000000>, <125000000>;
-		fsl,num-tx-queues=<3>;
-		fsl,num-rx-queues=<3>;
+		fsl,num-tx-queues = <3>;
+		fsl,num-rx-queues = <3>;
 		power-domains = <&pd IMX_SC_R_ENET_0>;
 		status = "disabled";
 	};
@@ -103,8 +103,8 @@ fec2: ethernet@5b050000 {
 		assigned-clocks = <&clk IMX_SC_R_ENET_1 IMX_SC_PM_CLK_PER>,
 				  <&clk IMX_SC_R_ENET_1 IMX_SC_C_CLKDIV>;
 		assigned-clock-rates = <250000000>, <125000000>;
-		fsl,num-tx-queues=<3>;
-		fsl,num-rx-queues=<3>;
+		fsl,num-tx-queues = <3>;
+		fsl,num-rx-queues = <3>;
 		power-domains = <&pd IMX_SC_R_ENET_1>;
 		status = "disabled";
 	};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
index f338a886d811..03266bd90a06 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
@@ -285,14 +285,14 @@ &uart3 {
 &usbotg1 {
 	vbus-supply = <&reg_usbotg1>;
 	disable-over-current;
-	dr_mode="otg";
+	dr_mode = "otg";
 	status = "okay";
 };
 
 &usbotg2 {
 	pinctrl-names = "default";
 	disable-over-current;
-	dr_mode="host";
+	dr_mode = "host";
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm.dtsi
index b40148d728ea..9e6170d9394e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-icore-mx8mm.dtsi
@@ -84,42 +84,42 @@ reg_ldo4: ldo4 {
 			};
 
 			reg_buck1: buck1 {
-				regulator-min-microvolt =  <400000>;
+				regulator-min-microvolt = <400000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
 				regulator-boot-on;
 			};
 
 			reg_buck2: buck2 {
-				regulator-min-microvolt =  <400000>;
+				regulator-min-microvolt = <400000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
 				regulator-boot-on;
 			};
 
 			reg_buck3: buck3 {
-				regulator-min-microvolt =  <400000>;
+				regulator-min-microvolt = <400000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
 				regulator-boot-on;
 			};
 
 			reg_buck4: buck4 {
-				regulator-min-microvolt =  <400000>;
+				regulator-min-microvolt = <400000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
 				regulator-boot-on;
 			};
 
 			reg_buck5: buck5 {
-				regulator-min-microvolt =  <400000>;
+				regulator-min-microvolt = <400000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
 				regulator-boot-on;
 			};
 
 			reg_buck6: buck6 {
-				regulator-min-microvolt =  <400000>;
+				regulator-min-microvolt = <400000>;
 				regulator-max-microvolt = <1800000>;
 				regulator-always-on;
 				regulator-boot-on;
diff --git a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
index 00f86cada30d..8a496aa09072 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-venice-gw700x.dtsi
@@ -286,8 +286,8 @@ buck1 {
 				regulator-name = "buck1";
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <1000000>;
-				regulator-min-microamp  = <3800000>;
-				regulator-max-microamp  = <6800000>;
+				regulator-min-microamp = <3800000>;
+				regulator-max-microamp = <6800000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
@@ -297,8 +297,8 @@ buck2 {
 				regulator-name = "buck2";
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <900000>;
-				regulator-min-microamp  = <2200000>;
-				regulator-max-microamp  = <5200000>;
+				regulator-min-microamp = <2200000>;
+				regulator-max-microamp = <5200000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
@@ -308,8 +308,8 @@ buck3_reg: buck3 {
 				regulator-name = "buck3";
 				regulator-min-microvolt = <800000>;
 				regulator-max-microvolt = <1000000>;
-				regulator-min-microamp  = <3800000>;
-				regulator-max-microamp  = <6800000>;
+				regulator-min-microamp = <3800000>;
+				regulator-max-microamp = <6800000>;
 				regulator-always-on;
 			};
 
@@ -318,8 +318,8 @@ buck4 {
 				regulator-name = "buck4";
 				regulator-min-microvolt = <1800000>;
 				regulator-max-microvolt = <1800000>;
-				regulator-min-microamp  = <2200000>;
-				regulator-max-microamp  = <5200000>;
+				regulator-min-microamp = <2200000>;
+				regulator-max-microamp = <5200000>;
 				regulator-boot-on;
 				regulator-always-on;
 			};
diff --git a/arch/arm64/boot/dts/freescale/imx8mm.dtsi b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
index 1bf070473829..eb02244fa554 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm.dtsi
@@ -212,7 +212,7 @@ clk_ext3: clock-ext3 {
 	clk_ext4: clock-ext4 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-		clock-frequency= <133000000>;
+		clock-frequency = <133000000>;
 		clock-output-names = "clk_ext4";
 	};
 
@@ -995,7 +995,7 @@ usdhc1: mmc@30b40000 {
 					 <&clk IMX8MM_CLK_USDHC1_ROOT>;
 				clock-names = "ipg", "ahb", "per";
 				fsl,tuning-start-tap = <20>;
-				fsl,tuning-step= <2>;
+				fsl,tuning-step = <2>;
 				bus-width = <4>;
 				status = "disabled";
 			};
@@ -1009,7 +1009,7 @@ usdhc2: mmc@30b50000 {
 					 <&clk IMX8MM_CLK_USDHC2_ROOT>;
 				clock-names = "ipg", "ahb", "per";
 				fsl,tuning-start-tap = <20>;
-				fsl,tuning-step= <2>;
+				fsl,tuning-step = <2>;
 				bus-width = <4>;
 				status = "disabled";
 			};
@@ -1023,7 +1023,7 @@ usdhc3: mmc@30b60000 {
 					 <&clk IMX8MM_CLK_USDHC3_ROOT>;
 				clock-names = "ipg", "ahb", "per";
 				fsl,tuning-start-tap = <20>;
-				fsl,tuning-step= <2>;
+				fsl,tuning-step = <2>;
 				bus-width = <4>;
 				status = "disabled";
 			};
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
index 02f37dcda7ed..9e82069c941f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-beacon-baseboard.dtsi
@@ -146,7 +146,7 @@ wm8962: audio-codec@1a {
 };
 
 &easrc {
-	fsl,asrc-rate  = <48000>;
+	fsl,asrc-rate = <48000>;
 	status = "okay";
 };
 
@@ -182,7 +182,7 @@ &uart3 {
 &usbotg1 {
 	vbus-supply = <&reg_usb_otg_vbus>;
 	disable-over-current;
-	dr_mode="otg";
+	dr_mode = "otg";
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
index d1f6cccfa00d..8db9d1122ca0 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dtsi
@@ -78,7 +78,7 @@ sound-spdif {
 };
 
 &easrc {
-	fsl,asrc-rate  = <48000>;
+	fsl,asrc-rate = <48000>;
 	status = "okay";
 };
 
diff --git a/arch/arm64/boot/dts/freescale/imx8mn.dtsi b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
index e41e1d56f980..b773660c34a7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mn.dtsi
@@ -212,7 +212,7 @@ clk_ext3: clock-ext3 {
 	clk_ext4: clock-ext4 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-		clock-frequency= <133000000>;
+		clock-frequency = <133000000>;
 		clock-output-names = "clk_ext4";
 	};
 
@@ -422,7 +422,7 @@ easrc: easrc@300c0000 {
 						    "ctx2_rx", "ctx2_tx",
 						    "ctx3_rx", "ctx3_tx";
 					firmware-name = "imx/easrc/easrc-imx8mn.bin";
-					fsl,asrc-rate  = <8000>;
+					fsl,asrc-rate = <8000>;
 					fsl,asrc-format = <2>;
 					status = "disabled";
 				};
@@ -941,7 +941,7 @@ usdhc1: mmc@30b40000 {
 					 <&clk IMX8MN_CLK_USDHC1_ROOT>;
 				clock-names = "ipg", "ahb", "per";
 				fsl,tuning-start-tap = <20>;
-				fsl,tuning-step= <2>;
+				fsl,tuning-step = <2>;
 				bus-width = <4>;
 				status = "disabled";
 			};
@@ -955,7 +955,7 @@ usdhc2: mmc@30b50000 {
 					 <&clk IMX8MN_CLK_USDHC2_ROOT>;
 				clock-names = "ipg", "ahb", "per";
 				fsl,tuning-start-tap = <20>;
-				fsl,tuning-step= <2>;
+				fsl,tuning-step = <2>;
 				bus-width = <4>;
 				status = "disabled";
 			};
@@ -969,7 +969,7 @@ usdhc3: mmc@30b60000 {
 					 <&clk IMX8MN_CLK_USDHC3_ROOT>;
 				clock-names = "ipg", "ahb", "per";
 				fsl,tuning-start-tap = <20>;
-				fsl,tuning-step= <2>;
+				fsl,tuning-step = <2>;
 				bus-width = <4>;
 				status = "disabled";
 			};
diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index d9542dfff83f..b2f4a5f1f73c 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -195,7 +195,7 @@ clk_ext3: clock-ext3 {
 	clk_ext4: clock-ext4 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-		clock-frequency= <133000000>;
+		clock-frequency = <133000000>;
 		clock-output-names = "clk_ext4";
 	};
 
@@ -903,7 +903,7 @@ usdhc1: mmc@30b40000 {
 					 <&clk IMX8MP_CLK_USDHC1_ROOT>;
 				clock-names = "ipg", "ahb", "per";
 				fsl,tuning-start-tap = <20>;
-				fsl,tuning-step= <2>;
+				fsl,tuning-step = <2>;
 				bus-width = <4>;
 				status = "disabled";
 			};
@@ -917,7 +917,7 @@ usdhc2: mmc@30b50000 {
 					 <&clk IMX8MP_CLK_USDHC2_ROOT>;
 				clock-names = "ipg", "ahb", "per";
 				fsl,tuning-start-tap = <20>;
-				fsl,tuning-step= <2>;
+				fsl,tuning-step = <2>;
 				bus-width = <4>;
 				status = "disabled";
 			};
@@ -931,7 +931,7 @@ usdhc3: mmc@30b60000 {
 					 <&clk IMX8MP_CLK_USDHC3_ROOT>;
 				clock-names = "ipg", "ahb", "per";
 				fsl,tuning-start-tap = <20>;
-				fsl,tuning-step= <2>;
+				fsl,tuning-step = <2>;
 				bus-width = <4>;
 				status = "disabled";
 			};
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
index f70fb32b96b0..a89546b39095 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-nitrogen.dts
@@ -152,7 +152,7 @@ reg_arm_dram: regulator@60 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_reg_arm_dram>;
 				reg = <0x60>;
-				regulator-min-microvolt =  <900000>;
+				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <1000000>;
 				regulator-always-on;
 				vsel-gpios = <&gpio3 24 GPIO_ACTIVE_HIGH>;
@@ -186,7 +186,7 @@ reg_soc_gpu_vpu: regulator@60 {
 				pinctrl-names = "default";
 				pinctrl-0 = <&pinctrl_reg_soc_gpu_vpu>;
 				reg = <0x60>;
-				regulator-min-microvolt =  <900000>;
+				regulator-min-microvolt = <900000>;
 				regulator-max-microvolt = <1000000>;
 				regulator-always-on;
 				vsel-gpios = <&gpio2 20 GPIO_ACTIVE_HIGH>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
index 2222ef7b3eab..4e05120c62d4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-zii-ultra.dtsi
@@ -443,7 +443,7 @@ &i2c3 {
 	status = "okay";
 
 	usbhub: usbhub@2c {
-		compatible ="microchip,usb2513b";
+		compatible = "microchip,usb2513b";
 		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_usbhub>;
 		reg = <0x2c>;
diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index 49eadb081b19..8a1c69699053 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -94,7 +94,7 @@ clk_ext3: clock-ext3 {
 	clk_ext4: clock-ext4 {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
-		clock-frequency= <133000000>;
+		clock-frequency = <133000000>;
 		clock-output-names = "clk_ext4";
 	};
 
@@ -507,7 +507,7 @@ tmu: tmu@30260000 {
 						      <0x00030005 0x00000053>,
 						      <0x00030006 0x0000005f>,
 						      <0x00030007 0x00000071>;
-				#thermal-sensor-cells =  <1>;
+				#thermal-sensor-cells = <1>;
 			};
 
 			wdog1: watchdog@30280000 {
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dtsi
index 144fc9e82da7..e3f161a10448 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp-colibri-eval-v3.dtsi
@@ -38,17 +38,17 @@ rtc_i2c: rtc@68 {
 
 /* Colibri UART_B */
 &lpuart0 {
-	status= "okay";
+	status = "okay";
 };
 
 /* Colibri UART_C */
 &lpuart2 {
-	status= "okay";
+	status = "okay";
 };
 
 /* Colibri UART_A */
 &lpuart3 {
-	status= "okay";
+	status = "okay";
 };
 
 /* Colibri FastEthernet */
diff --git a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
index 09f7364dd1d0..ba281e689cf6 100644
--- a/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8ulp.dtsi
@@ -331,7 +331,7 @@ usdhc0: mmc@298d0000 {
 				clock-names = "ipg", "ahb", "per";
 				power-domains = <&scmi_devpd IMX8ULP_PD_USDHC0>;
 				fsl,tuning-start-tap = <20>;
-				fsl,tuning-step= <2>;
+				fsl,tuning-step = <2>;
 				bus-width = <4>;
 				status = "disabled";
 			};
@@ -346,7 +346,7 @@ usdhc1: mmc@298e0000 {
 				clock-names = "ipg", "ahb", "per";
 				power-domains = <&scmi_devpd IMX8ULP_PD_USDHC1>;
 				fsl,tuning-start-tap = <20>;
-				fsl,tuning-step= <2>;
+				fsl,tuning-step = <2>;
 				bus-width = <4>;
 				status = "disabled";
 			};
@@ -361,7 +361,7 @@ usdhc2: mmc@298f0000 {
 				clock-names = "ipg", "ahb", "per";
 				power-domains = <&scmi_devpd IMX8ULP_PD_USDHC2_USB1>;
 				fsl,tuning-start-tap = <20>;
-				fsl,tuning-step= <2>;
+				fsl,tuning-step = <2>;
 				bus-width = <4>;
 				status = "disabled";
 			};
-- 
2.34.1

