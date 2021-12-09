Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163DD46E9CE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238577AbhLIOUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 09:20:52 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:5132 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238589AbhLIOUs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 09:20:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1639059435; x=1670595435;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=369F7lu4jbOF/4T/FyKKXom9U7gmm+cutDEJGRv9TWQ=;
  b=s9nKOx3LJwkq9LazHrjDfniymC+akAIi50lwRCCkm9Bb3kJ3bHIDbITR
   fMzzx2XBSvTeS+5RVIVeriyIIHtR8QrUZTA0oGO+49hfcit/HN7cBKBeP
   yFyV9pRfkq3YccgQeU8+iUDqa5Cmp735OYD9t+hNhYVRd/pQAv+sfAgyL
   k=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 09 Dec 2021 06:17:14 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 06:17:14 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 9 Dec 2021 06:17:14 -0800
Received: from jinlmao-gv.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 9 Dec 2021 06:17:10 -0800
From:   Mao Jinlong <quic_jinlmao@quicinc.com>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>
CC:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <coresight@lists.linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v2 9/9] ARM: dts: msm: Add coresight components for SM8250
Date:   Thu, 9 Dec 2021 22:15:43 +0800
Message-ID: <20211209141543.21314-10-quic_jinlmao@quicinc.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209141543.21314-1-quic_jinlmao@quicinc.com>
References: <20211209141543.21314-1-quic_jinlmao@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add coresight device tree for sm8250. STM/ETM/TPDM are added.

Signed-off-by: Tao Zhang <quic_taozha@quicinc.com>
Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
---
 MAINTAINERS                                   |   1 +
 .../arm64/boot/dts/qcom/sm8250-coresight.dtsi | 688 ++++++++++++++++++
 arch/arm64/boot/dts/qcom/sm8250.dtsi          |   2 +
 3 files changed, 691 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm8250-coresight.dtsi

diff --git a/MAINTAINERS b/MAINTAINERS
index d3b7ce75ba9d..e1db5a839f2f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15566,6 +15566,7 @@ M:	Jinlong Mao <quic_jinlmao@quicinc.com>
 M:	Mathieu Poirier <mathieu.poirier@linaro.org>
 M:	Suzuki K Poulose <suzuki.poulose@arm.com>
 S:	Maintained
+F:	arch/arm64/boot/dts/qcom/*-coresight.dtsi
 F:	Documentation/ABI/testing/sysfs-bus-coresight-devices-tpdm
 F:	Documentation/devicetree/bindings/arm/coresight-tpda.yaml
 F:	Documentation/devicetree/bindings/arm/coresight-tpdm.yaml
diff --git a/arch/arm64/boot/dts/qcom/sm8250-coresight.dtsi b/arch/arm64/boot/dts/qcom/sm8250-coresight.dtsi
new file mode 100644
index 000000000000..e9d65c6acbd1
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8250-coresight.dtsi
@@ -0,0 +1,688 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2021 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+&soc {
+
+	stm@6002000 {
+		compatible = "arm,coresight-stm", "arm,primecell";
+		reg = <0 0x06002000 0 0x1000>,
+		      <0 0x16280000 0 0x180000>;
+		reg-names = "stm-base", "stm-stimulus-base";
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+
+		out-ports {
+			port {
+				stm_out: endpoint {
+					remote-endpoint =
+					  <&funnel0_in7>;
+				};
+			};
+		};
+	};
+
+	tpda@6004000 {
+		compatible = "arm,primecell";
+		reg = <0 0x6004000 0 0x1000>;
+		reg-names = "tpda-base";
+
+		qcom,tpda-atid = <65>;
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+
+		out-ports {
+			port {
+				tpda_out_funnel_qatb: endpoint {
+					remote-endpoint =
+						<&funnel_qatb_in_tpda>;
+				};
+			};
+		};
+
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@9 {
+				reg = <9>;
+				tpda_9_in_tpdm_mm: endpoint {
+					remote-endpoint =
+						<&tpdm_mm_out_tpda9>;
+				};
+			};
+		};
+	};
+
+	funnel@6005000 {
+		compatible = "arm,primecell";
+
+		reg = <0 0x6005000 0 0x1000>;
+		reg-names = "funnel-base";
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+
+		out-ports {
+			port {
+				funnel_qatb_out_funnel_in0: endpoint {
+					remote-endpoint =
+						<&funnel_in0_in_funnel_qatb>;
+				};
+			};
+		};
+
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				funnel_qatb_in_tpda: endpoint {
+					remote-endpoint =
+						<&tpda_out_funnel_qatb>;
+				};
+			};
+		};
+	};
+
+	funnel@6041000 {
+		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+		reg = <0 0x06041000 0 0x1000>;
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+
+		out-ports {
+			port {
+				funnel0_out: endpoint {
+					remote-endpoint =
+					  <&merge_funnel_in0>;
+				};
+			};
+		};
+
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@6 {
+				reg = <6>;
+				funnel_in0_in_funnel_qatb: endpoint {
+					remote-endpoint =
+						<&funnel_qatb_out_funnel_in0>;
+				};
+			};
+
+			port@7 {
+				reg = <7>;
+				funnel0_in7: endpoint {
+					remote-endpoint = <&stm_out>;
+				};
+			};
+		};
+	};
+
+	funnel@6042000 {
+		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+		reg = <0 0x06042000 0 0x1000>;
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+
+		out-ports {
+			port {
+				funnel2_out: endpoint {
+					remote-endpoint =
+					  <&merge_funnel_in1>;
+				};
+			};
+		};
+
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@4 {
+				reg = <4>;
+				funnel2_in4: endpoint {
+					remote-endpoint =
+					  <&apss_merge_funnel_out>;
+				};
+			};
+		};
+	};
+
+	funnel@6045000 {
+		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+		reg = <0 0x06045000 0 0x1000>;
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+
+		out-ports {
+			port {
+				funnel_merg_out_funnel_swao: endpoint {
+					remote-endpoint = <&funnel_swao_in_funnel_merg>;
+				};
+			};
+		};
+
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				merge_funnel_in0: endpoint {
+					remote-endpoint =
+					  <&funnel0_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				merge_funnel_in1: endpoint {
+					remote-endpoint =
+					  <&funnel2_out>;
+				};
+			};
+		};
+	};
+
+	replicator@6046000 {
+		compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
+		reg = <0 0x06046000 0 0x1000>;
+
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+
+		out-ports {
+			port {
+				replicator_out: endpoint {
+					remote-endpoint = <&etr_in>;
+				};
+			};
+		};
+
+		in-ports {
+			port {
+				replicator_cx_in_swao_out: endpoint {
+					remote-endpoint = <&replicator_swao_out_cx_in>;
+				};
+			};
+		};
+	};
+
+	etr@6048000 {
+		compatible = "arm,coresight-tmc", "arm,primecell";
+		reg = <0 0x06048000 0 0x1000>;
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+		arm,scatter-gather;
+
+		in-ports {
+			port {
+				etr_in: endpoint {
+					remote-endpoint =
+					  <&replicator_out>;
+				};
+			};
+		};
+	};
+
+	funnel@6b04000 {
+		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+		arm,primecell-periphid = <0x000bb908>;
+
+		reg = <0 0x6b04000 0 0x1000>;
+		reg-names = "funnel-base";
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+
+		out-ports {
+			port {
+				merge_funnel_out: endpoint {
+					remote-endpoint =
+						<&etf_in>;
+				};
+			};
+		};
+
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@7 {
+				reg = <7>;
+				funnel_swao_in_funnel_merg: endpoint {
+					remote-endpoint=
+						<&funnel_merg_out_funnel_swao>;
+				};
+			};
+		};
+
+	};
+
+	etf@6b05000 {
+		compatible = "arm,coresight-tmc", "arm,primecell";
+		reg = <0 0x6b05000 0 0x1000>;
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+
+		out-ports {
+			port {
+				etf_out: endpoint {
+					remote-endpoint =
+					  <&replicator_in>;
+				};
+			};
+		};
+
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				etf_in: endpoint {
+					remote-endpoint =
+					  <&merge_funnel_out>;
+				};
+			};
+		};
+	};
+
+	replicator@6b06000 {
+		compatible = "arm,coresight-dynamic-replicator", "arm,primecell";
+		reg = <0 0x06b06000 0 0x1000>;
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+
+		out-ports {
+			port {
+				replicator_swao_out_cx_in: endpoint {
+					remote-endpoint = <&replicator_cx_in_swao_out>;
+				};
+			};
+		};
+
+		in-ports {
+			port {
+				replicator_in: endpoint {
+					remote-endpoint = <&etf_out>;
+				};
+			};
+		};
+	};
+
+
+	tpdm_mm: mm.tpdm@6c08000 {
+		compatible = "arm,primecell";
+		reg = <0 0x6c08000 0 0x1000>;
+		reg-names = "tpdm-base";
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+
+		qcom,msr-fix-req;
+
+		out-ports {
+			port {
+				tpdm_mm_out_funnel_dl_mm: endpoint {
+					remote-endpoint =
+						<&funnel_dl_mm_in_tpdm_mm>;
+				};
+			};
+		};
+	};
+
+	funnel@6c0b000 {
+		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+
+		reg = <0 0x6c0b000 0 0x1000>;
+		reg-names = "funnel-base";
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+
+		out-ports {
+			port {
+				funnel_dl_mm_out_funnel_dl_center: endpoint {
+					remote-endpoint =
+					  <&funnel_dl_center_in_funnel_dl_mm>;
+				};
+			};
+		};
+
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@3 {
+				reg = <3>;
+				funnel_dl_mm_in_tpdm_mm: endpoint {
+					remote-endpoint =
+					    <&tpdm_mm_out_funnel_dl_mm>;
+				};
+			};
+		};
+	};
+
+	funnel@6c2d000 {
+		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+
+		reg = <0 0x6c2d000 0 0x1000>;
+		reg-names = "funnel-base";
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+
+		out-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			port {
+				tpdm_mm_out_tpda9: endpoint {
+					remote-endpoint =
+					    <&tpda_9_in_tpdm_mm>;
+				};
+			};
+		};
+
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@2 {
+				reg = <2>;
+				funnel_dl_center_in_funnel_dl_mm: endpoint {
+					remote-endpoint =
+					<&funnel_dl_mm_out_funnel_dl_center>;
+				};
+			};
+		};
+	};
+
+	etm@7040000 {
+		compatible = "arm,coresight-etm4x", "arm,primecell";
+		reg = <0 0x07040000 0 0x1000>;
+
+		cpu = <&CPU0>;
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+		arm,coresight-loses-context-with-cpu;
+
+		out-ports {
+			port {
+				etm0_out: endpoint {
+					remote-endpoint =
+					  <&apss_funnel_in0>;
+				};
+			};
+		};
+	};
+
+	etm@7140000 {
+		compatible = "arm,coresight-etm4x", "arm,primecell";
+		reg = <0 0x07140000 0 0x1000>;
+
+		cpu = <&CPU1>;
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+		arm,coresight-loses-context-with-cpu;
+
+		out-ports {
+			port {
+				etm1_out: endpoint {
+					remote-endpoint =
+					  <&apss_funnel_in1>;
+				};
+			};
+		};
+	};
+
+	etm@7240000 {
+		compatible = "arm,coresight-etm4x", "arm,primecell";
+		reg = <0 0x07240000 0 0x1000>;
+
+		cpu = <&CPU2>;
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+		arm,coresight-loses-context-with-cpu;
+
+		out-ports {
+			port {
+				etm2_out: endpoint {
+					remote-endpoint =
+					  <&apss_funnel_in2>;
+				};
+			};
+		};
+	};
+
+	etm@7340000 {
+		compatible = "arm,coresight-etm4x", "arm,primecell";
+		reg = <0 0x07340000 0 0x1000>;
+
+		cpu = <&CPU3>;
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+		arm,coresight-loses-context-with-cpu;
+
+		out-ports {
+			port {
+				etm3_out: endpoint {
+					remote-endpoint =
+					  <&apss_funnel_in3>;
+				};
+			};
+		};
+	};
+
+	etm@7440000 {
+		compatible = "arm,coresight-etm4x", "arm,primecell";
+		reg = <0 0x07440000 0 0x1000>;
+
+		cpu = <&CPU4>;
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+		arm,coresight-loses-context-with-cpu;
+
+		out-ports {
+			port {
+				etm4_out: endpoint {
+					remote-endpoint =
+					  <&apss_funnel_in4>;
+				};
+			};
+		};
+	};
+
+	etm@7540000 {
+		compatible = "arm,coresight-etm4x", "arm,primecell";
+		reg = <0 0x07540000 0 0x1000>;
+
+		cpu = <&CPU5>;
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+		arm,coresight-loses-context-with-cpu;
+
+		out-ports {
+			port {
+				etm5_out: endpoint {
+					remote-endpoint =
+					  <&apss_funnel_in5>;
+				};
+			};
+		};
+	};
+
+	etm@7640000 {
+		compatible = "arm,coresight-etm4x", "arm,primecell";
+		reg = <0 0x07640000 0 0x1000>;
+
+		cpu = <&CPU6>;
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+		arm,coresight-loses-context-with-cpu;
+
+		out-ports {
+			port {
+				etm6_out: endpoint {
+					remote-endpoint =
+					  <&apss_funnel_in6>;
+				};
+			};
+		};
+	};
+
+	etm@7740000 {
+		compatible = "arm,coresight-etm4x", "arm,primecell";
+		reg = <0 0x07740000 0 0x1000>;
+
+		cpu = <&CPU7>;
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+		arm,coresight-loses-context-with-cpu;
+
+		out-ports {
+			port {
+				etm7_out: endpoint {
+					remote-endpoint =
+					  <&apss_funnel_in7>;
+				};
+			};
+		};
+	};
+
+	funnel@7800000 {
+		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+		reg = <0 0x07800000 0 0x1000>;
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+
+		out-ports {
+			port {
+				apss_funnel_out: endpoint {
+					remote-endpoint =
+					  <&apss_merge_funnel_in>;
+				};
+			};
+		};
+
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port@0 {
+				reg = <0>;
+				apss_funnel_in0: endpoint {
+					remote-endpoint =
+					  <&etm0_out>;
+				};
+			};
+
+			port@1 {
+				reg = <1>;
+				apss_funnel_in1: endpoint {
+					remote-endpoint =
+					  <&etm1_out>;
+				};
+			};
+
+			port@2 {
+				reg = <2>;
+				apss_funnel_in2: endpoint {
+					remote-endpoint =
+					  <&etm2_out>;
+				};
+			};
+
+			port@3 {
+				reg = <3>;
+				apss_funnel_in3: endpoint {
+					remote-endpoint =
+					  <&etm3_out>;
+				};
+			};
+
+			port@4 {
+				reg = <4>;
+				apss_funnel_in4: endpoint {
+					remote-endpoint =
+					  <&etm4_out>;
+				};
+			};
+
+			port@5 {
+				reg = <5>;
+				apss_funnel_in5: endpoint {
+					remote-endpoint =
+					  <&etm5_out>;
+				};
+			};
+
+			port@6 {
+				reg = <6>;
+				apss_funnel_in6: endpoint {
+					remote-endpoint =
+					  <&etm6_out>;
+				};
+			};
+
+			port@7 {
+				reg = <7>;
+				apss_funnel_in7: endpoint {
+					remote-endpoint =
+					  <&etm7_out>;
+				};
+			};
+		};
+	};
+
+	funnel@7810000 {
+		compatible = "arm,coresight-dynamic-funnel", "arm,primecell";
+		reg = <0 0x07810000 0 0x1000>;
+
+		clocks = <&aoss_qmp>;
+		clock-names = "apb_pclk";
+
+		out-ports {
+			port {
+				apss_merge_funnel_out: endpoint {
+					remote-endpoint =
+					  <&funnel2_in4>;
+				};
+			};
+		};
+
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			port@0 {
+				reg = <0>;
+				apss_merge_funnel_in: endpoint {
+					remote-endpoint =
+					  <&apss_funnel_out>;
+				};
+			};
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/qcom/sm8250.dtsi b/arch/arm64/boot/dts/qcom/sm8250.dtsi
index 6f6129b39c9c..0390919cc4f1 100644
--- a/arch/arm64/boot/dts/qcom/sm8250.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8250.dtsi
@@ -4853,3 +4853,5 @@
 		};
 	};
 };
+
+#include "sm8250-coresight.dtsi"
-- 
2.17.1

