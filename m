Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07DE949601B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 14:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380863AbiAUNzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 08:55:51 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:33615 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380858AbiAUNzs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 08:55:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642773349; x=1674309349;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=4Q1Rc8fddJm/fibdsPgLDcOCkru81bGIghSycndMFHA=;
  b=j/CsnRGL2zBR/URV03dyWQFc2VNDBbx5S9YPMoKROPrIiVSLcphelGta
   O9GslMB62KmQNQ+GLh+Pa9JKni/n9YIqFa1bUF4K1lVCe54ISQT0pm1qz
   VHxpIspM6ksW2P8QX79XEhzFkIuR4AZrXWXpt/rUaD1k3HQbPSomHm2Tj
   I=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 21 Jan 2022 05:55:48 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 05:55:48 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 21 Jan 2022 05:55:47 -0800
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 21 Jan 2022 05:55:42 -0800
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pure.logic@nexus-software.ie>,
        <bjorn.andersson@linaro.org>, <greg@kroah.com>, <robh@kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <quic_tsoni@quicinc.com>,
        <quic_psodagud@quicinc.com>, <quic_satyap@quicinc.com>,
        <quic_pheragu@quicinc.com>, <quic_rjendra@quicinc.com>,
        <quic_sibis@quicinc.com>, <quic_saipraka@quicinc.com>,
        <quic_schowdhu@quicinc.com>
Subject: [PATCH V4 4/6] arm64: dts: qcom: sc7280: Add EUD dt node and dwc3 connector
Date:   Fri, 21 Jan 2022 19:23:49 +0530
Message-ID: <3ca56ffa9e4aa73f3c3f36d0edad0827ee11d953.1642768837.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1642768837.git.quic_schowdhu@quicinc.com>
References: <cover.1642768837.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Embedded USB Debugger(EUD) device tree node. The
node contains EUD base register region and EUD mode
manager register regions along with the interrupt entry.
Also add the typec connector node for EUD which is attached to
EUD node via port. EUD is also attached to DWC3 node via port.
Also add the role-switch property to dwc3 node.

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 39 ++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 937c2e0..daac831 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -2583,6 +2583,14 @@
 				phys = <&usb_2_hsphy>;
 				phy-names = "usb2-phy";
 				maximum-speed = "high-speed";
+				usb-role-switch;
+				ports {
+					port@0 {
+						usb2_role_switch: endpoint {
+							remote-endpoint = <&eud_ep>;
+						};
+					};
+				};
 			};
 		};
 
@@ -2624,6 +2632,37 @@
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		eud: eud@88e0000 {
+			compatible = "qcom,sc7280-eud","qcom,eud";
+			reg = <0 0x88e0000 0 0x2000>,
+			      <0 0x88e2000 0 0x1000>;
+			interrupt-parent = <&pdc>;
+			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
+			ports {
+				port@0 {
+					eud_ep: endpoint {
+						remote-endpoint = <&usb2_role_switch>;
+					};
+				};
+				port@1 {
+					eud_con: endpoint {
+						remote-endpoint = <&con_eud>;
+					};
+				};
+			};
+		};
+
+		eud_typec: connector {
+			compatible = "usb-c-connector";
+			ports {
+				port@0 {
+					con_eud: endpoint {
+						remote-endpoint = <&eud_con>;
+					};
+				};
+			};
+		};
+
 		nsp_noc: interconnect@a0c0000 {
 			reg = <0 0x0a0c0000 0 0x10000>;
 			compatible = "qcom,sc7280-nsp-noc";
-- 
2.7.4

