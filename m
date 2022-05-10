Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57956520A6B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 02:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbiEJA46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 20:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232541AbiEJA4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 20:56:55 -0400
Received: from m12-15.163.com (m12-15.163.com [220.181.12.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9D9127B328;
        Mon,  9 May 2022 17:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=WqmJd
        515m1PJTK0nq4GDI1QjAybjj0z9nr72C7+YdFk=; b=qEMnIt5En+Lp2rUDeRV1N
        uD+cCktAsYhJe+phFhsY3IRQCT/nKbr8daGR05VDy4Cl8CLAWNZF8DXZ4M9cGLIT
        q76QsILybAawv1BQ/CquxKzzbjeB8ZopTtrRWC+jBNj/9pnbusas0sG7WCXKZ8IX
        dcATHn+rPjzauh/lqdoU9Q=
Received: from DESKTOP-B1R4FVG.localdomain (unknown [218.201.129.19])
        by smtp11 (Coremail) with SMTP id D8CowABntf58s3liulW+Bg--.40118S2;
        Tue, 10 May 2022 08:36:13 +0800 (CST)
From:   qianfanguijin@163.com
To:     linux-sunxi@lists.linux.dev
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        qianfan Zhao <qianfanguijin@163.com>
Subject: [PATCH v2] drivers: cpufreq: sun8i-r40: Add cpufreq support
Date:   Tue, 10 May 2022 08:36:11 +0800
Message-Id: <20220510003611.1812-1-qianfanguijin@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: D8CowABntf58s3liulW+Bg--.40118S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWrWxWF47WF4UWrWfuF43GFg_yoWrtry5pr
        17CFWkGrs3Wr1Yqw12qrW8tF18Caykuay5tF1UC34fJr1kXFyDXryftr9akrZ8Xr13X3yS
        vrnYqr92vw4DXaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zN9aPUUUUUU=
X-Originating-IP: [218.201.129.19]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/1tbiXB387VXl2wCLHQAAst
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: qianfan Zhao <qianfanguijin@163.com>

OPP table value is get from allwinner lichee 3.10 kernel.
And completed 'cpu-supply' on sun8i based board.

Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
---
 .../boot/dts/sun8i-r40-bananapi-m2-ultra.dts  |  4 ++
 arch/arm/boot/dts/sun8i-r40-feta40i.dtsi      |  4 ++
 arch/arm/boot/dts/sun8i-r40.dtsi              | 47 +++++++++++++++++++
 arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts      |  4 ++
 .../boot/dts/sun8i-v40-bananapi-m2-berry.dts  |  4 ++
 drivers/cpufreq/cpufreq-dt-platdev.c          |  1 +
 6 files changed, 64 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
index a6a1087a0c9b..4f30018ec4a2 100644
--- a/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
+++ b/arch/arm/boot/dts/sun8i-r40-bananapi-m2-ultra.dts
@@ -113,6 +113,10 @@ &ahci {
 	status = "okay";
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
 &de {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun8i-r40-feta40i.dtsi b/arch/arm/boot/dts/sun8i-r40-feta40i.dtsi
index 265e0fa57a32..b872b51a346d 100644
--- a/arch/arm/boot/dts/sun8i-r40-feta40i.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40-feta40i.dtsi
@@ -6,6 +6,10 @@
 
 #include "sun8i-r40.dtsi"
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
 &i2c0 {
 	status = "okay";
 
diff --git a/arch/arm/boot/dts/sun8i-r40.dtsi b/arch/arm/boot/dts/sun8i-r40.dtsi
index 291f4784e86c..90de119095fa 100644
--- a/arch/arm/boot/dts/sun8i-r40.dtsi
+++ b/arch/arm/boot/dts/sun8i-r40.dtsi
@@ -54,6 +54,41 @@ / {
 	#size-cells = <1>;
 	interrupt-parent = <&gic>;
 
+	cpu0_opp_table: opp_table0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+
+		opp-720000000 {
+			opp-hz = /bits/ 64 <720000000>;
+			opp-microvolt = <1000000 1000000 1300000>;
+			clock-latency-ns = <2000000>;
+		};
+
+		opp-912000000 {
+			opp-hz = /bits/ 64 <912000000>;
+			opp-microvolt = <1100000 1100000 1300000>;
+			clock-latency-ns = <2000000>;
+		};
+
+		opp-1008000000 {
+			opp-hz = /bits/ 64 <1008000000>;
+			opp-microvolt = <1160000 1160000 1300000>;
+			clock-latency-ns = <2000000>;
+		};
+
+		opp-1104000000 {
+			opp-hz = /bits/ 64 <1104000000>;
+			opp-microvolt = <1240000 1240000 1300000>;
+			clock-latency-ns = <2000000>;
+		};
+
+		opp-1200000000 {
+			opp-hz = /bits/ 64 <1200000000>;
+			opp-microvolt = <1300000 1300000 1300000>;
+			clock-latency-ns = <2000000>;
+		};
+	};
+
 	clocks {
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -84,24 +119,36 @@ cpu0: cpu@0 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <0>;
+			clocks = <&ccu CLK_CPU>;
+			clock-names = "cpu";
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
 		cpu1: cpu@1 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <1>;
+			clocks = <&ccu CLK_CPU>;
+			clock-names = "cpu";
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
 		cpu2: cpu@2 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <2>;
+			clocks = <&ccu CLK_CPU>;
+			clock-names = "cpu";
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 
 		cpu3: cpu@3 {
 			compatible = "arm,cortex-a7";
 			device_type = "cpu";
 			reg = <3>;
+			clocks = <&ccu CLK_CPU>;
+			clock-names = "cpu";
+			operating-points-v2 = <&cpu0_opp_table>;
 		};
 	};
 
diff --git a/arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts b/arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts
index 6931aaab2382..0eb1990742ff 100644
--- a/arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts
+++ b/arch/arm/boot/dts/sun8i-t3-cqa3t-bv3.dts
@@ -88,6 +88,10 @@ &ahci {
 	status = "okay";
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
 &de {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
index 47954551f573..fdf8bd12faaa 100644
--- a/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
+++ b/arch/arm/boot/dts/sun8i-v40-bananapi-m2-berry.dts
@@ -107,6 +107,10 @@ &ahci {
 	status = "okay";
 };
 
+&cpu0 {
+	cpu-supply = <&reg_dcdc2>;
+};
+
 &de {
 	status = "okay";
 };
diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index ca1d103ec449..971a99219d4d 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -26,6 +26,7 @@ static const struct of_device_id allowlist[] __initconst = {
 	{ .compatible = "allwinner,sun8i-a23", },
 	{ .compatible = "allwinner,sun8i-a83t", },
 	{ .compatible = "allwinner,sun8i-h3", },
+	{ .compatible = "allwinner,sun8i-r40", },
 
 	{ .compatible = "apm,xgene-shadowcat", },
 
-- 
2.25.1

