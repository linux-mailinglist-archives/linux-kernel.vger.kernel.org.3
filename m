Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F798500163
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 23:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234399AbiDMVv5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 17:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234101AbiDMVvx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 17:51:53 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F0FF9
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:49:29 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n40-20020a05600c3ba800b0038ff1939b16so806642wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 14:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=/hsEZqr6YQGeu5xer12yjd2MgUgzjRzEMC0qti0zf30=;
        b=effCe33Fp4nKRJobTpZerHvLjrntDrG6wmHKJBqDVrGLlB1Yl2In2N0oIgX8mFI3ST
         fMvHppvgNnzw97NolQS3wlEVDA5wXcogaW4SUQdnc5uqMK2FcnSUlU+GsWAZ766egOPN
         yua78yGo78N2oar81MDXVe3e5aG9+PCYJ/z3VXEve9FqR31JeqIjhy3fMS8BgZDEB+UT
         3cJQk+SzmM5m2OeGr3HY+Kb4TEXn1dUo7o4Fi05NOUlpx1OkQ19E05Mv+ecIMT6nruPE
         bnDC+pY9DtHi0iSrdxGDuf2YSgQC8zfdvHyAoiqVzkjwzWf0YdKlXewa7tFZ/BTVg9az
         Jl8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/hsEZqr6YQGeu5xer12yjd2MgUgzjRzEMC0qti0zf30=;
        b=3LG+wPtuMnnnrl5h7qKBp/nHfVkKjEkHNnxL8btoFbjpLam3OPBrHqw0PWbB+4kWXi
         hBnnOZMw2VJz9OwX7176PQQL7Fk9bcZ5GqyUvGT2XJ6/KagSukj4VuT4DEjM0EPxMzMI
         z/o+VWT8t3FitLwGa6+xYlPgFnb5gE93MphVHj+yAvyqVgFq5ezBSaPzBiY/tPRVIkW3
         3kKXNMmhRLnuVpJCjXiv70bZY2GyKbgw3UBHHZhqlYL6ZPcO4XUfLkALfBol0Bu0MBs0
         uvJCi7cJiXruH7IBJzJMLMB2GU1YFrYfMgtOCtzYX2+uyt/mbvXFWi2N4cHsbRLy8EwE
         rM1g==
X-Gm-Message-State: AOAM530FTm7z8m/KHUZ0EAR77xOyJ1bWnnkGvcOi/8AwwTfvh7fH9L8G
        5doqW1hiL2va+j8o/MjVya1a5w==
X-Google-Smtp-Source: ABdhPJwslG7R90FlgwBMXb3h1CABOH5BqkBWp6TimWqbKB7bItn7NuhlM+vFknGM+Af2OE9wkOll7w==
X-Received: by 2002:a05:600c:a46:b0:38e:c914:af8c with SMTP id c6-20020a05600c0a4600b0038ec914af8cmr124803wmq.163.1649886567729;
        Wed, 13 Apr 2022 14:49:27 -0700 (PDT)
Received: from linaro.org ([2a00:23c5:6809:2201:e4bb:355f:cdcf:ea80])
        by smtp.gmail.com with ESMTPSA id p12-20020a5d68cc000000b00207a6461ecdsm158328wrw.93.2022.04.13.14.49.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 14:49:27 -0700 (PDT)
From:   Mike Leach <mike.leach@linaro.org>
To:     liviu.dudau@arm.com, sudeep.holla@arm.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        lorenzo.pieralisi@arm.com, robh+dt@kernel.org,
        robin.murphy@arm.com, Mike Leach <mike.leach@linaro.org>
Subject: [PATCH] arm64: dts: juno: add CTI entries to device tree
Date:   Wed, 13 Apr 2022 22:49:25 +0100
Message-Id: <20220413214925.30359-1-mike.leach@linaro.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add in CTI entries for Juno r0, r1 and r2 to device tree entries.

Tested on Linux 5.18-rc2

Signed-off-by: Mike Leach <mike.leach@linaro.org>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi    | 162 +++++++++++++++++++++-
 arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi |  37 ++++-
 arch/arm64/boot/dts/arm/juno-r1-scmi.dts  |   4 +
 arch/arm64/boot/dts/arm/juno-r1.dts       |  25 ++++
 arch/arm64/boot/dts/arm/juno-r2-scmi.dts  |   4 +
 arch/arm64/boot/dts/arm/juno-r2.dts       |  25 ++++
 arch/arm64/boot/dts/arm/juno-scmi.dtsi    |  25 ++++
 arch/arm64/boot/dts/arm/juno.dts          |  25 ++++
 8 files changed, 302 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index 446c8f476eec..4f40a5c8f565 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -117,7 +117,7 @@
 	 * The actual size is just 4K though 64K is reserved. Access to the
 	 * unmapped reserved region results in a DECERR response.
 	 */
-	etf@20010000 { /* etf0 */
+	etf_sys0: etf@20010000 { /* etf0 */
 		compatible = "arm,coresight-tmc", "arm,primecell";
 		reg = <0 0x20010000 0 0x1000>;
 
@@ -141,7 +141,7 @@
 		};
 	};
 
-	tpiu@20030000 {
+	tpiu_sys: tpiu@20030000 {
 		compatible = "arm,coresight-tpiu", "arm,primecell";
 		reg = <0 0x20030000 0 0x1000>;
 
@@ -194,7 +194,7 @@
 		};
 	};
 
-	etr@20070000 {
+	etr_sys: etr@20070000 {
 		compatible = "arm,coresight-tmc", "arm,primecell";
 		reg = <0 0x20070000 0 0x1000>;
 		iommus = <&smmu_etr 0>;
@@ -212,7 +212,7 @@
 		};
 	};
 
-	stm@20100000 {
+	stm_sys: stm@20100000 {
 		compatible = "arm,coresight-stm", "arm,primecell";
 		reg = <0 0x20100000 0 0x1000>,
 		      <0 0x28000000 0 0x1000000>;
@@ -289,6 +289,18 @@
 		};
 	};
 
+	cti0: cti@22020000 {
+		compatible = "arm,coresight-cti-v8-arch", "arm,coresight-cti",
+			     "arm,primecell";
+		reg = <0 0x22020000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+
+		arm,cs-dev-assoc = <&etm0>;
+	};
+
 	funnel@220c0000 { /* cluster0 funnel */
 		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 		reg = <0 0x220c0000 0 0x1000>;
@@ -349,6 +361,18 @@
 		};
 	};
 
+	cti1: cti@22120000 {
+		compatible = "arm,coresight-cti-v8-arch", "arm,coresight-cti",
+			     "arm,primecell";
+		reg = <0 0x22120000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+
+		arm,cs-dev-assoc = <&etm1>;
+	};
+
 	cpu_debug2: cpu-debug@23010000 {
 		compatible = "arm,coresight-cpu-debug", "arm,primecell";
 		reg = <0x0 0x23010000 0x0 0x1000>;
@@ -374,6 +398,18 @@
 		};
 	};
 
+	cti2: cti@23020000 {
+		compatible = "arm,coresight-cti-v8-arch", "arm,coresight-cti",
+			     "arm,primecell";
+		reg = <0 0x23020000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+
+		arm,cs-dev-assoc = <&etm2>;
+	};
+
 	funnel@230c0000 { /* cluster1 funnel */
 		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
 		reg = <0 0x230c0000 0 0x1000>;
@@ -446,6 +482,18 @@
 		};
 	};
 
+	cti3: cti@23120000 {
+		compatible = "arm,coresight-cti-v8-arch", "arm,coresight-cti",
+			     "arm,primecell";
+		reg = <0 0x23120000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+
+		arm,cs-dev-assoc = <&etm3>;
+	};
+
 	cpu_debug4: cpu-debug@23210000 {
 		compatible = "arm,coresight-cpu-debug", "arm,primecell";
 		reg = <0x0 0x23210000 0x0 0x1000>;
@@ -471,6 +519,18 @@
 		};
 	};
 
+	cti4: cti@23220000 {
+		compatible = "arm,coresight-cti-v8-arch", "arm,coresight-cti",
+			     "arm,primecell";
+		reg = <0 0x23220000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+
+		arm,cs-dev-assoc = <&etm4>;
+	};
+
 	cpu_debug5: cpu-debug@23310000 {
 		compatible = "arm,coresight-cpu-debug", "arm,primecell";
 		reg = <0x0 0x23310000 0x0 0x1000>;
@@ -496,6 +556,100 @@
 		};
 	};
 
+	cti5: cti@23320000 {
+		compatible = "arm,coresight-cti-v8-arch", "arm,coresight-cti",
+			     "arm,primecell";
+		reg = <0 0x23320000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+
+		arm,cs-dev-assoc = <&etm5>;
+	};
+
+	cti_sys0: cti@20020000 { /* sys_cti_0 */
+		compatible = "arm,coresight-cti", "arm,primecell";
+		reg = <0 0x20020000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		trig-conns@0 {
+			reg = <0>;
+			arm,trig-in-sigs=<2 3>;
+			arm,trig-in-types=<SNK_FULL SNK_ACQCOMP>;
+			arm,trig-out-sigs=<0 1>;
+			arm,trig-out-types=<SNK_FLUSHIN SNK_TRIGIN>;
+			arm,cs-dev-assoc = <&etr_sys>;
+		};
+
+		trig-conns@1 {
+			reg = <1>;
+			arm,trig-in-sigs=<0 1>;
+			arm,trig-in-types=<SNK_FULL SNK_ACQCOMP>;
+			arm,trig-out-sigs=<7 6>;
+			arm,trig-out-types=<SNK_FLUSHIN SNK_TRIGIN>;
+			arm,cs-dev-assoc = <&etf_sys0>;
+		};
+
+		trig-conns@2 {
+			reg = <2>;
+			arm,trig-in-sigs=<4 5 6 7>;
+			arm,trig-in-types=<STM_TOUT_SPTE STM_TOUT_SW
+					   STM_TOUT_HETE STM_ASYNCOUT>;
+			arm,trig-out-sigs=<4 5>;
+			arm,trig-out-types=<STM_HWEVENT STM_HWEVENT>;
+			arm,cs-dev-assoc = <&stm_sys>;
+		};
+
+		trig-conns@3 {
+			reg = <3>;
+			arm,trig-out-sigs=<2 3>;
+			arm,trig-out-types=<SNK_FLUSHIN SNK_TRIGIN>;
+			arm,cs-dev-assoc = <&tpiu_sys>;
+		};
+	};
+
+	cti_sys1: cti@20110000 { /* sys_cti_1 */
+		compatible = "arm,coresight-cti", "arm,primecell";
+		reg = <0 0x20110000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		trig-conns@0 {
+			reg = <0>;
+			arm,trig-in-sigs=<0>;
+			arm,trig-in-types=<GEN_INTREQ>;
+			arm,trig-out-sigs=<0>;
+			arm,trig-out-types=<GEN_HALTREQ>;
+			arm,trig-conn-name = "sys_profiler";
+		};
+
+		trig-conns@1 {
+			reg = <1>;
+			arm,trig-out-sigs=<2 3>;
+			arm,trig-out-types=<GEN_HALTREQ GEN_RESTARTREQ>;
+			arm,trig-conn-name = "watchdog";
+		};
+
+		trig-conns@2 {
+			reg = <2>;
+			arm,trig-out-sigs=<1 6>;
+			arm,trig-out-types=<GEN_HALTREQ GEN_RESTARTREQ>;
+			arm,trig-conn-name = "g_counter";
+		};
+	};
+
 	gpu: gpu@2d000000 {
 		compatible = "arm,juno-mali", "arm,mali-t624";
 		reg = <0 0x2d000000 0 0x10000>;
diff --git a/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
index eda3d9e18af6..2e43f4531308 100644
--- a/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
@@ -23,7 +23,7 @@
 		};
 	};
 
-	etf@20140000 { /* etf1 */
+	etf_sys1: etf@20140000 { /* etf1 */
 		compatible = "arm,coresight-tmc", "arm,primecell";
 		reg = <0 0x20140000 0 0x1000>;
 
@@ -82,4 +82,39 @@
 
 		};
 	};
+
+	cti_sys2: cti@20160000 { /* sys_cti_2 */
+		compatible = "arm,coresight-cti", "arm,primecell";
+		reg = <0 0x20160000 0 0x1000>;
+
+		clocks = <&soc_smc50mhz>;
+		clock-names = "apb_pclk";
+		power-domains = <&scpi_devpd 0>;
+
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		trig-conns@0 {
+			reg = <0>;
+			arm,trig-in-sigs=<0 1>;
+			arm,trig-in-types=<SNK_FULL SNK_ACQCOMP>;
+			arm,trig-out-sigs=<0 1>;
+			arm,trig-out-types=<SNK_FLUSHIN SNK_TRIGIN>;
+			arm,cs-dev-assoc = <&etf_sys1>;
+		};
+
+		trig-conns@1 {
+			reg = <1>;
+			arm,trig-in-sigs=<2 3 4>;
+			arm,trig-in-types=<ELA_DBGREQ ELA_TSTART ELA_TSTOP>;
+			arm,trig-conn-name = "ela_clus_0";
+		};
+
+		trig-conns@2 {
+			reg = <2>;
+			arm,trig-in-sigs=<5 6 7>;
+			arm,trig-in-types=<ELA_DBGREQ ELA_TSTART ELA_TSTOP>;
+			arm,trig-conn-name = "ela_clus_1";
+		};
+	};
 };
diff --git a/arch/arm64/boot/dts/arm/juno-r1-scmi.dts b/arch/arm64/boot/dts/arm/juno-r1-scmi.dts
index fd1f0d26d751..dd9ea69f086f 100644
--- a/arch/arm64/boot/dts/arm/juno-r1-scmi.dts
+++ b/arch/arm64/boot/dts/arm/juno-r1-scmi.dts
@@ -15,6 +15,10 @@
 	};
 };
 
+&cti_sys2 {
+	power-domains = <&scmi_devpd 8>;
+};
+
 &A57_0 {
 	clocks = <&scmi_dvfs 0>;
 };
diff --git a/arch/arm64/boot/dts/arm/juno-r1.dts b/arch/arm64/boot/dts/arm/juno-r1.dts
index 0e24e29eb9b1..f099fb611d4e 100644
--- a/arch/arm64/boot/dts/arm/juno-r1.dts
+++ b/arch/arm64/boot/dts/arm/juno-r1.dts
@@ -9,6 +9,7 @@
 /dts-v1/;
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/arm/coresight-cti-dt.h>
 #include "juno-base.dtsi"
 #include "juno-cs-r1r2.dtsi"
 
@@ -313,3 +314,27 @@
 &cpu_debug5 {
 	cpu = <&A53_3>;
 };
+
+&cti0 {
+	cpu = <&A57_0>;
+};
+
+&cti1 {
+	cpu = <&A57_1>;
+};
+
+&cti2 {
+	cpu = <&A53_0>;
+};
+
+&cti3 {
+	cpu = <&A53_1>;
+};
+
+&cti4 {
+	cpu = <&A53_2>;
+};
+
+&cti5 {
+	cpu = <&A53_3>;
+};
diff --git a/arch/arm64/boot/dts/arm/juno-r2-scmi.dts b/arch/arm64/boot/dts/arm/juno-r2-scmi.dts
index 35e6d4762c46..de2cbac1d1c3 100644
--- a/arch/arm64/boot/dts/arm/juno-r2-scmi.dts
+++ b/arch/arm64/boot/dts/arm/juno-r2-scmi.dts
@@ -15,6 +15,10 @@
 	};
 };
 
+&cti_sys2 {
+	power-domains = <&scmi_devpd 8>;
+};
+
 &A72_0 {
 	clocks = <&scmi_dvfs 0>;
 };
diff --git a/arch/arm64/boot/dts/arm/juno-r2.dts b/arch/arm64/boot/dts/arm/juno-r2.dts
index e609420ce3e4..709389582ae3 100644
--- a/arch/arm64/boot/dts/arm/juno-r2.dts
+++ b/arch/arm64/boot/dts/arm/juno-r2.dts
@@ -9,6 +9,7 @@
 /dts-v1/;
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/arm/coresight-cti-dt.h>
 #include "juno-base.dtsi"
 #include "juno-cs-r1r2.dtsi"
 
@@ -319,3 +320,27 @@
 &cpu_debug5 {
 	cpu = <&A53_3>;
 };
+
+&cti0 {
+	cpu = <&A72_0>;
+};
+
+&cti1 {
+	cpu = <&A72_1>;
+};
+
+&cti2 {
+	cpu = <&A53_0>;
+};
+
+&cti3 {
+	cpu = <&A53_1>;
+};
+
+&cti4 {
+	cpu = <&A53_2>;
+};
+
+&cti5 {
+	cpu = <&A53_3>;
+};
diff --git a/arch/arm64/boot/dts/arm/juno-scmi.dtsi b/arch/arm64/boot/dts/arm/juno-scmi.dtsi
index d72dcff9bf06..4135d62e44a2 100644
--- a/arch/arm64/boot/dts/arm/juno-scmi.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-scmi.dtsi
@@ -154,6 +154,31 @@
 	power-domains = <&scmi_devpd 8>;
 };
 
+&cti0 {
+	power-domains = <&scmi_devpd 8>;
+};
+&cti1 {
+	power-domains = <&scmi_devpd 8>;
+};
+&cti2 {
+	power-domains = <&scmi_devpd 8>;
+};
+&cti3 {
+	power-domains = <&scmi_devpd 8>;
+};
+&cti4 {
+	power-domains = <&scmi_devpd 8>;
+};
+&cti5 {
+	power-domains = <&scmi_devpd 8>;
+};
+&cti_sys0 {
+	power-domains = <&scmi_devpd 8>;
+};
+&cti_sys1 {
+	power-domains = <&scmi_devpd 8>;
+};
+
 &gpu {
 	clocks = <&scmi_dvfs 2>;
 	power-domains = <&scmi_devpd 9>;
diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index f00cffbd032c..dbc22e70b62c 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -9,6 +9,7 @@
 /dts-v1/;
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/arm/coresight-cti-dt.h>
 #include "juno-base.dtsi"
 
 / {
@@ -295,3 +296,27 @@
 &cpu_debug5 {
 	cpu = <&A53_3>;
 };
+
+&cti0 {
+	cpu = <&A57_0>;
+};
+
+&cti1 {
+	cpu = <&A57_1>;
+};
+
+&cti2 {
+	cpu = <&A53_0>;
+};
+
+&cti3 {
+	cpu = <&A53_1>;
+};
+
+&cti4 {
+	cpu = <&A53_2>;
+};
+
+&cti5 {
+	cpu = <&A53_3>;
+};
-- 
2.17.1

