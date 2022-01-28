Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D371049F42C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:11:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346714AbiA1HLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:11:21 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:57545 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242771AbiA1HLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:11:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1643353879; x=1674889879;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7kckOmRKyq54j2yB6AzUrEcAKcHonOPFGbtH7xzTgzQ=;
  b=g/Yv0KBOgXoGo4e1HoIm2rn3i5uoQttzjMN/S7O1tz4hcw+jNVbf9531
   JGz8OpjF6GzVaPRpiJghBm34iKV34EEq/cjflDdlpdSsPOYjNhDIyE1Rc
   eL0P4tuj+Fo01tOoOD1kLmeDrPN0BD2nz5eMSS1ZAOKlMigIYSgWmbRqg
   Y=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 27 Jan 2022 23:11:18 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 23:11:17 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 27 Jan 2022 23:10:57 -0800
Received: from blr-ubuntu-253.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 27 Jan 2022 23:10:53 -0800
From:   Sai Prakash Ranjan <quic_saipraka@quicinc.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Vinod Koul <vkoul@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Sai Prakash Ranjan <quic_saipraka@quicinc.com>
Subject: [PATCH 9/9] arm64: dts: qcom: sm8450: Add LLCC/system-cache-controller node
Date:   Fri, 28 Jan 2022 12:39:33 +0530
Message-ID: <d99178f475900c9d8fa1e2081e5b3427a644f9a9.1643353154.git.quic_saipraka@quicinc.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1643353154.git.quic_saipraka@quicinc.com>
References: <cover.1643353154.git.quic_saipraka@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a DT node for Last level cache (aka. system cache) controller
which provides control over the last level cache present on SM8450
SoC.

Signed-off-by: Sai Prakash Ranjan <quic_saipraka@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sm8450.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm8450.dtsi b/arch/arm64/boot/dts/qcom/sm8450.dtsi
index 10c25ad2d0c7..5a3d050b94f7 100644
--- a/arch/arm64/boot/dts/qcom/sm8450.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm8450.dtsi
@@ -1102,6 +1102,13 @@ usb_1_dwc3: usb@a600000 {
 				phy-names = "usb2-phy", "usb3-phy";
 			};
 		};
+
+		system-cache-controller@19200000 {
+			compatible = "qcom,sm8450-llcc";
+			reg = <0 0x19200000 0 0x580000>, <0 0x19a00000 0 0x80000>;
+			reg-names = "llcc_base", "llcc_broadcast_base";
+			interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
+		};
 	};
 
 	timer {
-- 
2.33.1

