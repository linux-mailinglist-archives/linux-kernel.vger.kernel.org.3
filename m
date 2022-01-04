Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8187948415B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 13:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbiADMAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 07:00:03 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:3706 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230393AbiADL77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 06:59:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1641297599; x=1672833599;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=goHvDbPAMT8y7VmBNDYv4n/5GH3eYTMy8N290BUBoig=;
  b=jhoHEkdPkJDHo/DBRXpt2pTHF9sQZBTGmmxy0f4bwDuMV1jFFft4UYnq
   6nT/G1HdClNee18C5TZnzCgW3rzhPoztTt6wZ9qKshSJ/dKulKYq63AS8
   HQBmZWo26bUqLNt+9QYIlprweQn9f84O8FJjPdyKyg4DH9n9Gc9Epp1oH
   s=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 04 Jan 2022 03:59:59 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2022 03:59:59 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 4 Jan 2022 03:59:58 -0800
Received: from blr-ubuntu-525.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 4 Jan 2022 03:59:54 -0800
From:   Souradeep Chowdhury <quic_schowdhu@quicinc.com>
To:     <linux-arm-msm@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <pure.logic@nexus-software.ie>,
        <bjorn.andersson@linaro.org>, <greg@kroah.com>
CC:     <linux-kernel@vger.kernel.org>, <tsoni@codeaurora.org>,
        <psodagud@codeaurora.org>, <satyap@codeaurora.org>,
        <pheragu@codeaurora.org>, <rnayak@codeaurora.org>,
        <sibis@codeaurora.org>, <saiprakash.ranjan@codeaurora.org>,
        <quic_schowdhu@quicinc.com>
Subject: [PATCH V3 5/7] arm64: dts: qcom: sc7280: Add EUD dt node and dwc3 connector
Date:   Tue, 4 Jan 2022 17:28:18 +0530
Message-ID: <baf41480be71bd4472fe09c2993e43a780554d94.1641288286.git.quic_schowdhu@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1641288286.git.quic_schowdhu@quicinc.com>
References: <cover.1641288286.git.quic_schowdhu@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Embedded USB Debugger(EUD) device tree node. The
node contains EUD base register region and EUD mode
manager register regions along with the interrupt entry.
Also add the connector to EUD which is mapped as the child
of dwc3. The connector is attached to EUD via port. Also add
the role-switch property to dwc3 node.

Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 53a21d0..2d14e5c 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -1315,6 +1315,18 @@
 				phys = <&usb_2_hsphy>;
 				phy-names = "usb2-phy";
 				maximum-speed = "high-speed";
+				usb-role-switch;
+				usb_con: eud_usb_connector {
+					compatible = "qcom,usb-connector-eud",
+						     "usb-c-connector";
+					ports {
+						port@0 {
+							usb2_role_switch: endpoint {
+								remote-endpoint = <&eud_ep>;
+							};
+						};
+					};
+				};
 			};
 		};
 
@@ -1339,6 +1351,19 @@
 			interrupts = <GIC_SPI 582 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		eud:  eud@88e0000 {
+			compatible = "qcom,sc7280-eud","qcom,eud";
+			reg = <0 0x88e0000 0 0x2000>,
+			      <0 0x88e2000 0 0x1000>;
+			interrupt-parent = <&pdc>;
+			interrupts = <11 IRQ_TYPE_LEVEL_HIGH>;
+			port {
+				eud_ep: endpoint {
+					remote-endpoint = <&usb2_role_switch>;
+				};
+			};
+		};
+
 		nsp_noc: interconnect@a0c0000 {
 			reg = <0 0x0a0c0000 0 0x10000>;
 			compatible = "qcom,sc7280-nsp-noc";
-- 
2.7.4

