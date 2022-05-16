Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A1DC5282E2
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 13:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235645AbiEPLLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 07:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239007AbiEPLLm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 07:11:42 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4535AB4E;
        Mon, 16 May 2022 04:11:36 -0700 (PDT)
X-UUID: 320265e3c520413c8fd81ca39fa0cb6f-20220516
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:54658e7a-5966-439f-9a87-76030a7ca113,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,ACTI
        ON:release,TS:0
X-CID-META: VersionHash:2a19b09,CLOUDID:38872f94-563e-4fc2-8a0d-fda4821947ab,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil
        ,QS:0,BEC:nil
X-UUID: 320265e3c520413c8fd81ca39fa0cb6f-20220516
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <rex-bc.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 798951414; Mon, 16 May 2022 19:11:32 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 16 May 2022 19:11:32 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 16 May 2022 19:11:31 +0800
From:   Rex-BC Chen <rex-bc.chen@mediatek.com>
To:     <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <robh+dt@kernel.org>, <krzk+dt@kernel.org>,
        <matthias.bgg@gmail.com>
CC:     <jia-wei.chang@mediatek.com>, <roger.lu@mediatek.com>,
        <hsinyi@google.com>, <khilman@baylibre.com>,
        <angelogioacchino.delregno@collabora.com>,
        <linux-pm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        "Andrew-sh . Cheng" <andrew-sh.cheng@mediatek.com>
Subject: [PATCH v7 1/3] arm64: dts: mediatek: Add opp table and clock property for MT8183 cpufreq
Date:   Mon, 16 May 2022 19:11:28 +0800
Message-ID: <20220516111130.13325-2-rex-bc.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220516111130.13325-1-rex-bc.chen@mediatek.com>
References: <20220516111130.13325-1-rex-bc.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Add cpufreq opp table.
- Add MediaTek cci opp table.
- Add property of opp table and clock fro cpufreq.

Signed-off-by: Andrew-sh.Cheng <andrew-sh.cheng@mediatek.com>
Signed-off-by: Rex-BC Chen <rex-bc.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts |  32 +++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi    | 270 ++++++++++++++++++++
 2 files changed, 302 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
index f3fd3cca23e9..8953dbf84f3e 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
+++ b/arch/arm64/boot/dts/mediatek/mt8183-evb.dts
@@ -412,6 +412,38 @@
 
 };
 
+&cpu0 {
+	proc-supply = <&mt6358_vproc12_reg>;
+};
+
+&cpu1 {
+	proc-supply = <&mt6358_vproc12_reg>;
+};
+
+&cpu2 {
+	proc-supply = <&mt6358_vproc12_reg>;
+};
+
+&cpu3 {
+	proc-supply = <&mt6358_vproc12_reg>;
+};
+
+&cpu4 {
+	proc-supply = <&mt6358_vproc11_reg>;
+};
+
+&cpu5 {
+	proc-supply = <&mt6358_vproc11_reg>;
+};
+
+&cpu6 {
+	proc-supply = <&mt6358_vproc11_reg>;
+};
+
+&cpu7 {
+	proc-supply = <&mt6358_vproc11_reg>;
+};
+
 &uart0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
index 01e650251928..cecf96b628b7 100644
--- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
@@ -42,6 +42,244 @@
 		rdma1 = &rdma1;
 	};
 
+	cluster0_opp: opp-table-cluster0 {
+		compatible = "operating-points-v2";
+		opp-shared;
+		opp0-793000000 {
+			opp-hz = /bits/ 64 <793000000>;
+			opp-microvolt = <650000>;
+			required-opps = <&opp2_00>;
+		};
+		opp0-910000000 {
+			opp-hz = /bits/ 64 <910000000>;
+			opp-microvolt = <687500>;
+			required-opps = <&opp2_01>;
+		};
+		opp0-1014000000 {
+			opp-hz = /bits/ 64 <1014000000>;
+			opp-microvolt = <718750>;
+			required-opps = <&opp2_02>;
+		};
+		opp0-1131000000 {
+			opp-hz = /bits/ 64 <1131000000>;
+			opp-microvolt = <756250>;
+			required-opps = <&opp2_03>;
+		};
+		opp0-1248000000 {
+			opp-hz = /bits/ 64 <1248000000>;
+			opp-microvolt = <800000>;
+			required-opps = <&opp2_04>;
+		};
+		opp0-1326000000 {
+			opp-hz = /bits/ 64 <1326000000>;
+			opp-microvolt = <818750>;
+			required-opps = <&opp2_05>;
+		};
+		opp0-1417000000 {
+			opp-hz = /bits/ 64 <1417000000>;
+			opp-microvolt = <850000>;
+			required-opps = <&opp2_06>;
+		};
+		opp0-1508000000 {
+			opp-hz = /bits/ 64 <1508000000>;
+			opp-microvolt = <868750>;
+			required-opps = <&opp2_07>;
+		};
+		opp0-1586000000 {
+			opp-hz = /bits/ 64 <1586000000>;
+			opp-microvolt = <893750>;
+			required-opps = <&opp2_08>;
+		};
+		opp0-1625000000 {
+			opp-hz = /bits/ 64 <1625000000>;
+			opp-microvolt = <906250>;
+			required-opps = <&opp2_09>;
+		};
+		opp0-1677000000 {
+			opp-hz = /bits/ 64 <1677000000>;
+			opp-microvolt = <931250>;
+			required-opps = <&opp2_10>;
+		};
+		opp0-1716000000 {
+			opp-hz = /bits/ 64 <1716000000>;
+			opp-microvolt = <943750>;
+			required-opps = <&opp2_11>;
+		};
+		opp0-1781000000 {
+			opp-hz = /bits/ 64 <1781000000>;
+			opp-microvolt = <975000>;
+			required-opps = <&opp2_12>;
+		};
+		opp0-1846000000 {
+			opp-hz = /bits/ 64 <1846000000>;
+			opp-microvolt = <1000000>;
+			required-opps = <&opp2_13>;
+		};
+		opp0-1924000000 {
+			opp-hz = /bits/ 64 <1924000000>;
+			opp-microvolt = <1025000>;
+			required-opps = <&opp2_14>;
+		};
+		opp0-1989000000 {
+			opp-hz = /bits/ 64 <1989000000>;
+			opp-microvolt = <1050000>;
+			required-opps = <&opp2_15>;
+		};	};
+
+	cluster1_opp: opp-table-cluster1 {
+		compatible = "operating-points-v2";
+		opp-shared;
+		opp1-793000000 {
+			opp-hz = /bits/ 64 <793000000>;
+			opp-microvolt = <700000>;
+			required-opps = <&opp2_00>;
+		};
+		opp1-910000000 {
+			opp-hz = /bits/ 64 <910000000>;
+			opp-microvolt = <725000>;
+			required-opps = <&opp2_01>;
+		};
+		opp1-1014000000 {
+			opp-hz = /bits/ 64 <1014000000>;
+			opp-microvolt = <750000>;
+			required-opps = <&opp2_02>;
+		};
+		opp1-1131000000 {
+			opp-hz = /bits/ 64 <1131000000>;
+			opp-microvolt = <775000>;
+			required-opps = <&opp2_03>;
+		};
+		opp1-1248000000 {
+			opp-hz = /bits/ 64 <1248000000>;
+			opp-microvolt = <800000>;
+			required-opps = <&opp2_04>;
+		};
+		opp1-1326000000 {
+			opp-hz = /bits/ 64 <1326000000>;
+			opp-microvolt = <825000>;
+			required-opps = <&opp2_05>;
+		};
+		opp1-1417000000 {
+			opp-hz = /bits/ 64 <1417000000>;
+			opp-microvolt = <850000>;
+			required-opps = <&opp2_06>;
+		};
+		opp1-1508000000 {
+			opp-hz = /bits/ 64 <1508000000>;
+			opp-microvolt = <875000>;
+			required-opps = <&opp2_07>;
+		};
+		opp1-1586000000 {
+			opp-hz = /bits/ 64 <1586000000>;
+			opp-microvolt = <900000>;
+			required-opps = <&opp2_08>;
+		};
+		opp1-1625000000 {
+			opp-hz = /bits/ 64 <1625000000>;
+			opp-microvolt = <912500>;
+			required-opps = <&opp2_09>;
+		};
+		opp1-1677000000 {
+			opp-hz = /bits/ 64 <1677000000>;
+			opp-microvolt = <931250>;
+			required-opps = <&opp2_10>;
+		};
+		opp1-1716000000 {
+			opp-hz = /bits/ 64 <1716000000>;
+			opp-microvolt = <950000>;
+			required-opps = <&opp2_11>;
+		};
+		opp1-1781000000 {
+			opp-hz = /bits/ 64 <1781000000>;
+			opp-microvolt = <975000>;
+			required-opps = <&opp2_12>;
+		};
+		opp1-1846000000 {
+			opp-hz = /bits/ 64 <1846000000>;
+			opp-microvolt = <1000000>;
+			required-opps = <&opp2_13>;
+		};
+		opp1-1924000000 {
+			opp-hz = /bits/ 64 <1924000000>;
+			opp-microvolt = <1025000>;
+			required-opps = <&opp2_14>;
+		};
+		opp1-1989000000 {
+			opp-hz = /bits/ 64 <1989000000>;
+			opp-microvolt = <1050000>;
+			required-opps = <&opp2_15>;
+		};
+	};
+
+	cci_opp: opp-table-cci {
+		compatible = "operating-points-v2";
+		opp-shared;
+		opp2_00: opp-273000000 {
+			opp-hz = /bits/ 64 <273000000>;
+			opp-microvolt = <650000>;
+		};
+		opp2_01: opp-338000000 {
+			opp-hz = /bits/ 64 <338000000>;
+			opp-microvolt = <687500>;
+		};
+		opp2_02: opp-403000000 {
+			opp-hz = /bits/ 64 <403000000>;
+			opp-microvolt = <718750>;
+		};
+		opp2_03: opp-463000000 {
+			opp-hz = /bits/ 64 <463000000>;
+			opp-microvolt = <756250>;
+		};
+		opp2_04: opp-546000000 {
+			opp-hz = /bits/ 64 <546000000>;
+			opp-microvolt = <800000>;
+		};
+		opp2_05: opp-624000000 {
+			opp-hz = /bits/ 64 <624000000>;
+			opp-microvolt = <818750>;
+		};
+		opp2_06: opp-689000000 {
+			opp-hz = /bits/ 64 <689000000>;
+			opp-microvolt = <850000>;
+		};
+		opp2_07: opp-767000000 {
+			opp-hz = /bits/ 64 <767000000>;
+			opp-microvolt = <868750>;
+		};
+		opp2_08: opp-845000000 {
+			opp-hz = /bits/ 64 <845000000>;
+			opp-microvolt = <893750>;
+		};
+		opp2_09: opp-871000000 {
+			opp-hz = /bits/ 64 <871000000>;
+			opp-microvolt = <906250>;
+		};
+		opp2_10: opp-923000000 {
+			opp-hz = /bits/ 64 <923000000>;
+			opp-microvolt = <931250>;
+		};
+		opp2_11: opp-962000000 {
+			opp-hz = /bits/ 64 <962000000>;
+			opp-microvolt = <943750>;
+		};
+		opp2_12: opp-1027000000 {
+			opp-hz = /bits/ 64 <1027000000>;
+			opp-microvolt = <975000>;
+		};
+		opp2_13: opp-1092000000 {
+			opp-hz = /bits/ 64 <1092000000>;
+			opp-microvolt = <1000000>;
+		};
+		opp2_14: opp-1144000000 {
+			opp-hz = /bits/ 64 <1144000000>;
+			opp-microvolt = <1025000>;
+		};
+		opp2_15: opp-1196000000 {
+			opp-hz = /bits/ 64 <1196000000>;
+			opp-microvolt = <1050000>;
+		};
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -85,6 +323,10 @@
 			enable-method = "psci";
 			capacity-dmips-mhz = <741>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP0>;
+			clocks = <&mcucfg CLK_MCU_MP0_SEL>,
+				 <&topckgen CLK_TOP_ARMPLL_DIV_PLL1>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster0_opp>;
 			dynamic-power-coefficient = <84>;
 			#cooling-cells = <2>;
 		};
@@ -96,6 +338,10 @@
 			enable-method = "psci";
 			capacity-dmips-mhz = <741>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP0>;
+			clocks = <&mcucfg CLK_MCU_MP0_SEL>,
+				 <&topckgen CLK_TOP_ARMPLL_DIV_PLL1>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster0_opp>;
 			dynamic-power-coefficient = <84>;
 			#cooling-cells = <2>;
 		};
@@ -107,6 +353,10 @@
 			enable-method = "psci";
 			capacity-dmips-mhz = <741>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP0>;
+			clocks = <&mcucfg CLK_MCU_MP0_SEL>,
+				 <&topckgen CLK_TOP_ARMPLL_DIV_PLL1>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster0_opp>;
 			dynamic-power-coefficient = <84>;
 			#cooling-cells = <2>;
 		};
@@ -118,6 +368,10 @@
 			enable-method = "psci";
 			capacity-dmips-mhz = <741>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP0>;
+			clocks = <&mcucfg CLK_MCU_MP0_SEL>,
+				 <&topckgen CLK_TOP_ARMPLL_DIV_PLL1>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster0_opp>;
 			dynamic-power-coefficient = <84>;
 			#cooling-cells = <2>;
 		};
@@ -129,6 +383,10 @@
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP1>;
+			clocks = <&mcucfg CLK_MCU_MP2_SEL>,
+				 <&topckgen CLK_TOP_ARMPLL_DIV_PLL1>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster1_opp>;
 			dynamic-power-coefficient = <211>;
 			#cooling-cells = <2>;
 		};
@@ -140,6 +398,10 @@
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP1>;
+			clocks = <&mcucfg CLK_MCU_MP2_SEL>,
+				 <&topckgen CLK_TOP_ARMPLL_DIV_PLL1>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster1_opp>;
 			dynamic-power-coefficient = <211>;
 			#cooling-cells = <2>;
 		};
@@ -151,6 +413,10 @@
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP1>;
+			clocks = <&mcucfg CLK_MCU_MP2_SEL>,
+				 <&topckgen CLK_TOP_ARMPLL_DIV_PLL1>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster1_opp>;
 			dynamic-power-coefficient = <211>;
 			#cooling-cells = <2>;
 		};
@@ -162,6 +428,10 @@
 			enable-method = "psci";
 			capacity-dmips-mhz = <1024>;
 			cpu-idle-states = <&CPU_SLEEP &CLUSTER_SLEEP1>;
+			clocks = <&mcucfg CLK_MCU_MP2_SEL>,
+				 <&topckgen CLK_TOP_ARMPLL_DIV_PLL1>;
+			clock-names = "cpu", "intermediate";
+			operating-points-v2 = <&cluster1_opp>;
 			dynamic-power-coefficient = <211>;
 			#cooling-cells = <2>;
 		};
-- 
2.18.0

