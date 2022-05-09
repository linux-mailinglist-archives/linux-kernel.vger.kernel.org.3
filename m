Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E848151F9D6
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 12:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbiEIK07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 06:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiEIK04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 06:26:56 -0400
X-Greylist: delayed 4582 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 May 2022 03:22:23 PDT
Received: from m12-17.163.com (m12-17.163.com [220.181.12.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BDD4F1E82D4;
        Mon,  9 May 2022 03:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=Db/iq
        a+253Uz6WJEAvaq4jwDE9d5l6k1aN989gVLNoc=; b=mFNgGO4UK1QxCfcbBK6Li
        7A+PwHlzV7pXmxWpGTAfKK9Q90Mcod3iKYaWfXg6lmKKjDBM0c+wj6UVHzrlOQqU
        o94FczeRntA+T9ydshi5urP8chudubmbrBMnyyp+PLClbizN66EO4+g7NZIbWx6/
        FFExzith2u6eVt8FhZBQs4=
Received: from DESKTOP-B1R4FVG.localdomain (unknown [218.201.129.19])
        by smtp13 (Coremail) with SMTP id EcCowAC3XVJ11XhiB7GXBg--.12552S2;
        Mon, 09 May 2022 16:48:54 +0800 (CST)
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
Subject: [PATCH v1] drivers: cpufreq: sun8i-r40: Add cpufreq support
Date:   Mon,  9 May 2022 16:48:53 +0800
Message-Id: <20220509084853.17068-1-qianfanguijin@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowAC3XVJ11XhiB7GXBg--.12552S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGF1kJr4DCr13tr1DZw1rCrg_yoW5XFWfpr
        4UKayFkF4rWr12vw1aqr40qF1rGa9Y9FW5Jr17C3yxKr90qF90qFyxtFyYkFyDWr17X3yS
        qrs8tryIkw1kA3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zN9aPUUUUUU=
X-Originating-IP: [218.201.129.19]
X-CM-SenderInfo: htld0w5dqj3xxmlqqiywtou0bp/xtbCqRT77V0DfTNCMQACsK
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: qianfan Zhao <qianfanguijin@163.com>

OPP table value is get from allwinner lichee 3.10 kernel.

Signed-off-by: qianfan Zhao <qianfanguijin@163.com>
---
 arch/arm/boot/dts/sun8i-r40.dtsi     | 47 ++++++++++++++++++++++++++++
 drivers/cpufreq/cpufreq-dt-platdev.c |  1 +
 2 files changed, 48 insertions(+)

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

