Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F02449F18D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 03:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345738AbiA1CzV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 21:55:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345683AbiA1Cy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 21:54:59 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75DCEC061748
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 18:54:59 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id b186so3609652oif.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 18:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f0839BG7VZciEgCdDw4i0L62SacP05qx4MZ9H1fCyts=;
        b=ybLwDYw4DLJtIQTFGtWiPYs+LQWb6y7iA5F9z0EcJv+3y9//THQTIVCY5th/ns4hil
         5/8cJZjqC+hwnR0jAwFXR+w2Q7GJehP949+u3VzI2BI6UYbbbNm7yGDcv7ATAmFgMOHA
         Tkx1u0QTVRk9aCfvkj+Krj+Oo43dtBGPuDnxBX6VJs9Qb1d8QGr+8LDcEpRq5YVY0KdX
         3z1vaq004bAWoBaho6XXrZHF0bUQ3NSKiHUH9iMILSnciSXpY4MQwo7ewv/EJ5hr7uGh
         3gC95jnfPlUUc3waAZl1AyNasDj5SIYxiaMjO1PKMhU6Td1PzMhx81GPeqbaLHCiZR+P
         eS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f0839BG7VZciEgCdDw4i0L62SacP05qx4MZ9H1fCyts=;
        b=xPp+Y8VSNu6n8zvy24hBVgDfYBUJ16pf/HKMNxJE1rjGB6aMY1JPq0ThrAjMqzjD3t
         hEWVTz7eXblQsrcTejaP2GtnuXiYy2hyayv9MHKfPI8WnOoXT+BNCoAH0gyekOj8jatU
         us7l3tc4BWFitC9THdvtmYdOIYKGQaW9nJDyFk22DxYnwxnMgOxjtSlAjffxs/HrvXwi
         +x1sqdS3UExsyDLojOcMOrC2JuDWf10T90CR3UBkzwe66KG0NBdH6a6vdm4sbsgJqqSA
         tO+oTG5CR+sQJmo0RpfLa83+cGojlKmgjjGZoPlzdsNzeNwV33Bpx64LmWFP5AGBDPBl
         7LAA==
X-Gm-Message-State: AOAM531F8UMDQRPV8CXQvksK6ZqEKlSHjPh3+KrJlALrsCJY7PJR714s
        rLXDjJfqKigj5yGgDdYpTdeGig==
X-Google-Smtp-Source: ABdhPJy6XZ5eTKT8uLCvGblLfVUGihiaK7H+EO6Ucg32M7Pu8Ch+KN7IfJYEBMNbRPLq6Oqss+s8ew==
X-Received: by 2002:a05:6808:1396:: with SMTP id c22mr9016703oiw.190.1643338498844;
        Thu, 27 Jan 2022 18:54:58 -0800 (PST)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id k6sm5677352oop.28.2022.01.27.18.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 18:54:58 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 12/13] arm64: dts: qcom: sm8450: Add remoteproc enablers and instances
Date:   Thu, 27 Jan 2022 18:55:12 -0800
Message-Id: <20220128025513.97188-13-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220128025513.97188-1-bjorn.andersson@linaro.org>
References: <20220128025513.97188-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Qualcomm SM8450 carries the familiar set of audio, compute, sensor
and modem remoteprocs. Add these and their dependencies.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 297 +++++++++++++++++++++++++++
 1 file changed, 297 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 10c25ad2d0c7..24fb3d3e667b 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -7,6 +7,7 @@
 #include <dt-bindings/clock/qcom,gcc-sm8450.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/mailbox/qcom-ipcc.h>
 #include <dt-bindings/power/qcom-rpmpd.h>
 #include <dt-bindings/soc/qcom,rpmh-rsc.h>
 
@@ -460,6 +461,15 @@ cvp_mem: memory@9ee00000 {
 			no-map;
 		};
 
+		rmtfs_mem: memory@9fd00000 {
+			compatible = "qcom,rmtfs-mem";
+			reg = <0x0 0x9fd00000 0x0 0x280000>;
+			no-map;
+
+			qcom,client-id = <1>;
+			qcom,vmid = <15>;
+		};
+
 		global_sync_mem: memory@a6f00000 {
 			reg = <0x0 0xa6f00000 0x0 0x100000>;
 			no-map;
@@ -540,6 +550,113 @@ trusted_apps_ext_mem: memory@ed900000 {
 		};
 	};
 
+	smp2p-adsp {
+		compatible = "qcom,smp2p";
+		qcom,smem = <443>, <429>;
+		interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
+					     IPCC_MPROC_SIGNAL_SMP2P
+					     IRQ_TYPE_EDGE_RISING>;
+		mboxes = <&ipcc IPCC_CLIENT_LPASS
+				IPCC_MPROC_SIGNAL_SMP2P>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <2>;
+
+		smp2p_adsp_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		smp2p_adsp_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-cdsp {
+		compatible = "qcom,smp2p";
+		qcom,smem = <94>, <432>;
+		interrupts-extended = <&ipcc IPCC_CLIENT_CDSP
+					     IPCC_MPROC_SIGNAL_SMP2P
+					     IRQ_TYPE_EDGE_RISING>;
+		mboxes = <&ipcc IPCC_CLIENT_CDSP
+				IPCC_MPROC_SIGNAL_SMP2P>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <5>;
+
+		smp2p_cdsp_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		smp2p_cdsp_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-modem {
+		compatible = "qcom,smp2p";
+		qcom,smem = <435>, <428>;
+		interrupts-extended = <&ipcc IPCC_CLIENT_MPSS
+					     IPCC_MPROC_SIGNAL_SMP2P
+					     IRQ_TYPE_EDGE_RISING>;
+		mboxes = <&ipcc IPCC_CLIENT_MPSS
+				IPCC_MPROC_SIGNAL_SMP2P>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <1>;
+
+		smp2p_modem_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		smp2p_modem_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+
+		ipa_smp2p_out: ipa-ap-to-modem {
+			qcom,entry-name = "ipa";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		ipa_smp2p_in: ipa-modem-to-ap {
+			qcom,entry-name = "ipa";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
+	smp2p-slpi {
+		compatible = "qcom,smp2p";
+		qcom,smem = <481>, <430>;
+		interrupts-extended = <&ipcc IPCC_CLIENT_SLPI
+					     IPCC_MPROC_SIGNAL_SMP2P
+					     IRQ_TYPE_EDGE_RISING>;
+		mboxes = <&ipcc IPCC_CLIENT_SLPI
+				IPCC_MPROC_SIGNAL_SMP2P>;
+
+		qcom,local-pid = <0>;
+		qcom,remote-pid = <3>;
+
+		smp2p_slpi_out: master-kernel {
+			qcom,entry-name = "master-kernel";
+			#qcom,smem-state-cells = <1>;
+		};
+
+		smp2p_slpi_in: slave-kernel {
+			qcom,entry-name = "slave-kernel";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+		};
+	};
+
 	soc: soc@0 {
 		#address-cells = <2>;
 		#size-cells = <2>;
@@ -672,6 +789,167 @@ usb_1_ssphy: phy@88e9200 {
 			};
 		};
 
+		remoteproc_slpi: remoteproc@2400000 {
+			compatible = "qcom,sm8350-slpi-pas";
+			reg = <0 0x02400000 0 0x4000>;
+
+			interrupts-extended = <&pdc 9 IRQ_TYPE_LEVEL_HIGH>,
+					      <&smp2p_slpi_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_slpi_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_slpi_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_slpi_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
+
+			power-domains = <&rpmhpd SM8450_LCX>,
+					<&rpmhpd SM8450_LMX>;
+			power-domain-names = "lcx", "lmx";
+
+			memory-region = <&slpi_mem>;
+
+			qcom,qmp = <&aoss_qmp>;
+
+			qcom,smem-states = <&smp2p_slpi_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts-extended = <&ipcc IPCC_CLIENT_SLPI
+							     IPCC_MPROC_SIGNAL_GLINK_QMP
+							     IRQ_TYPE_EDGE_RISING>;
+				mboxes = <&ipcc IPCC_CLIENT_SLPI
+						IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+				label = "slpi";
+				qcom,remote-pid = <3>;
+			};
+		};
+
+		remoteproc_adsp: remoteproc@30000000 {
+			compatible = "qcom,sm8450-adsp-pas";
+			reg = <0 0x030000000 0 0x100>;
+
+			interrupts-extended = <&pdc 6 IRQ_TYPE_LEVEL_HIGH>,
+					      <&smp2p_adsp_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_adsp_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
+
+			power-domains = <&rpmhpd SM8450_LCX>,
+					<&rpmhpd SM8450_LMX>;
+			power-domain-names = "lcx", "lmx";
+
+			memory-region = <&adsp_mem>;
+
+			qcom,qmp = <&aoss_qmp>;
+
+			qcom,smem-states = <&smp2p_adsp_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			remoteproc_adsp_glink: glink-edge {
+				interrupts-extended = <&ipcc IPCC_CLIENT_LPASS
+							     IPCC_MPROC_SIGNAL_GLINK_QMP
+							     IRQ_TYPE_EDGE_RISING>;
+				mboxes = <&ipcc IPCC_CLIENT_LPASS
+						IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+				label = "lpass";
+				qcom,remote-pid = <2>;
+			};
+		};
+
+		remoteproc_cdsp: remoteproc@32300000 {
+			compatible = "qcom,sm8450-cdsp-pas";
+			reg = <0 0x032300000 0 0x1400000>;
+
+			interrupts-extended = <&intc GIC_SPI 578 IRQ_TYPE_LEVEL_HIGH>,
+					      <&smp2p_cdsp_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_cdsp_in 3 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready",
+					  "handover", "stop-ack";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
+
+			power-domains = <&rpmhpd SM8450_CX>,
+					<&rpmhpd SM8450_MXC>;
+			power-domain-names = "cx", "mxc";
+
+			memory-region = <&cdsp_mem>;
+
+			qcom,qmp = <&aoss_qmp>;
+
+			qcom,smem-states = <&smp2p_cdsp_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts-extended = <&ipcc IPCC_CLIENT_CDSP
+							     IPCC_MPROC_SIGNAL_GLINK_QMP
+							     IRQ_TYPE_EDGE_RISING>;
+				mboxes = <&ipcc IPCC_CLIENT_CDSP
+						IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+				label = "cdsp";
+				qcom,remote-pid = <5>;
+			};
+		};
+
+		remoteproc_mpss: remoteproc@4080000 {
+			compatible = "qcom,sm8450-mpss-pas";
+			reg = <0x0 0x04080000 0x0 0x4040>;
+
+			interrupts-extended = <&intc GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>,
+					      <&smp2p_modem_in 0 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_modem_in 1 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_modem_in 2 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_modem_in 3 IRQ_TYPE_EDGE_RISING>,
+					      <&smp2p_modem_in 7 IRQ_TYPE_EDGE_RISING>;
+			interrupt-names = "wdog", "fatal", "ready", "handover",
+					  "stop-ack", "shutdown-ack";
+
+			clocks = <&rpmhcc RPMH_CXO_CLK>;
+			clock-names = "xo";
+
+			power-domains = <&rpmhpd 0>,
+					<&rpmhpd 12>;
+			power-domain-names = "cx", "mss";
+
+			memory-region = <&mpss_mem>;
+
+			qcom,qmp = <&aoss_qmp>;
+
+			qcom,smem-states = <&smp2p_modem_out 0>;
+			qcom,smem-state-names = "stop";
+
+			status = "disabled";
+
+			glink-edge {
+				interrupts-extended = <&ipcc IPCC_CLIENT_MPSS
+							     IPCC_MPROC_SIGNAL_GLINK_QMP
+							     IRQ_TYPE_EDGE_RISING>;
+				mboxes = <&ipcc IPCC_CLIENT_MPSS
+						IPCC_MPROC_SIGNAL_GLINK_QMP>;
+				interrupts = <GIC_SPI 449 IRQ_TYPE_EDGE_RISING>;
+				label = "modem";
+				qcom,remote-pid = <1>;
+			};
+		};
+
 		pdc: interrupt-controller@b220000 {
 			compatible = "qcom,sm8450-pdc", "qcom,pdc";
 			reg = <0 0x0b220000 0 0x30000>, <0 0x174000f0 0 0x64>;
@@ -682,6 +960,25 @@ pdc: interrupt-controller@b220000 {
 			interrupt-controller;
 		};
 
+		aoss_qmp: power-controller@c300000 {
+			compatible = "qcom,sm8450-aoss-qmp", "qcom,aoss-qmp";
+			reg = <0 0x0c300000 0 0x400>;
+			interrupts-extended = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP
+						     IRQ_TYPE_EDGE_RISING>;
+			mboxes = <&ipcc IPCC_CLIENT_AOP IPCC_MPROC_SIGNAL_GLINK_QMP>;
+
+			#clock-cells = <0>;
+		};
+
+		ipcc: mailbox@ed18000 {
+			compatible = "qcom,sm8450-ipcc", "qcom,ipcc";
+			reg = <0 0x0ed18000 0 0x1000>;
+			interrupts = <GIC_SPI 229 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+			#mbox-cells = <2>;
+		};
+
 		tlmm: pinctrl@f100000 {
 			compatible = "qcom,sm8450-tlmm";
 			reg = <0 0x0f100000 0 0x300000>;
-- 
2.33.1

