Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA2E8495B81
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 09:00:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379368AbiAUIAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 03:00:51 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:26917 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379360AbiAUIAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 03:00:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642752037; x=1674288037;
  h=from:to:cc:subject:date:message-id;
  bh=abbX6k9WSffHvKTCpCIkdMCrlIZ93cMC92Al2dGkxzY=;
  b=FgkRuHTpfprCdITPVotr9x2qNS/67hIfLiYvLdKQdpxx0MK2in5MP5Ai
   XtAWZJBifSVycKK3UQWrnE7ykDPdgP6nqy7Y4gxaoKTwz5wvFC22KmNGC
   WPFi3RGasadtqtzMn+fSoiRKNxwxzR57zqymjs7IUihewOwdQ4u6XEKlD
   w=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 21 Jan 2022 00:00:36 -0800
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 21 Jan 2022 00:00:34 -0800
X-QCInternal: smtphost
Received: from pillair-linux.qualcomm.com ([10.204.116.193])
  by ironmsg01-blr.qualcomm.com with ESMTP; 21 Jan 2022 13:30:17 +0530
Received: by pillair-linux.qualcomm.com (Postfix, from userid 452944)
        id C2FF65334; Fri, 21 Jan 2022 13:30:16 +0530 (IST)
From:   Rakesh Pillai <quic_pillair@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        swboyd@chromium.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_sibis@quicinc.com,
        quic_mpubbise@quicinc.com, kuabhs@chromium.org,
        Rakesh Pillai <quic_pillair@quicinc.com>
Subject: [PATCH v8] arm64: dts: qcom: sc7280: Add WPSS remoteproc node
Date:   Fri, 21 Jan 2022 13:30:07 +0530
Message-Id: <1642752007-19923-1-git-send-email-quic_pillair@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the WPSS remoteproc node in dts for
PIL loading.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Signed-off-by: Rakesh Pillai <quic_pillair@quicinc.com>
---
Changes from v7:
- Remove wpss_mem from reserved memory. Its part of board dtsi.

Changes from v6:
- Swap the oder of two properties in wpss_mem reserved memory

Changes from v5:
- Update the clock names
---
 arch/arm64/boot/dts/qcom/sc7280-idp.dts |  4 +++
 arch/arm64/boot/dts/qcom/sc7280.dtsi    | 51 +++++++++++++++++++++++++++++++++
 2 files changed, 55 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-idp.dts b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
index 9b991ba..ddab150 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-idp.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-idp.dts
@@ -80,3 +80,7 @@
 		qcom,pre-scaling = <1 1>;
 	};
 };
+
+&remoteproc_wpss {
+	status = "okay";
+};
diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 937c2e0..e7c0745 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2603,6 +2603,57 @@
 			status = "disabled";
 		};
 
+		remoteproc_wpss: remoteproc@8a00000 {
+			compatible = "qcom,sc7280-wpss-pil";
+			reg = <0 0x08a00000 0 0x10000>;
+
+			interrupts-extended = <&intc GIC_SPI 587 IRQ_TYPE_EDGE_RISING>,
+					      <&wpss_smp2p_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&wpss_smp2p_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&wpss_smp2p_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&wpss_smp2p_in 3 IRQ_TYPE_EDGE_RISING>,
+					      <&wpss_smp2p_in 7 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready", "handover",
+					  "stop-ack", "shutdown-ack";
+
+			clocks = <&gcc GCC_WPSS_AHB_BDG_MST_CLK>,
+				 <&gcc GCC_WPSS_AHB_CLK>,
+				 <&gcc GCC_WPSS_RSCP_CLK>,
+				 <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "ahb_bdg", "ahb",
+				      "rscp", "xo";
+
+			power-domains = <&rpmhpd SC7280_CX>,
+					<&rpmhpd SC7280_MX>;
+			power-domain-names = "cx", "mx";
+
+			memory-region = <&wpss_mem>;
+
+			qcom,qmp = <&aoss_qmp>;
+
+			qcom,smem-states = <&wpss_smp2p_out 0>;
+			qcom,smem-state-names = "stop";
+
+			resets = <&aoss_reset AOSS_CC_WCSS_RESTART>,
+				 <&pdc_reset PDC_WPSS_SYNC_RESET>;
+			reset-names = "restart", "pdc_sync";
+
+			qcom,halt-regs = <&tcsr_mutex 0x37000>;
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts-extended = <&ipcc IPCC_CLIENT_WPSS
+							     IPCC_MPROC_SIGNAL_GLINK_QMP
+							     IRQ_TYPE_EDGE_RISING>;
+				mboxes = <&ipcc IPCC_CLIENT_WPSS
+						IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+				label = "wpss";
+				qcom,remote-pid = <13>;
+			};
+		};
+
 		dc_noc: interconnect@90e0000 {
 			reg = <0 0x090e0000 0 0x5080>;
 			compatible = "qcom,sc7280-dc-noc";
-- 
2.7.4

