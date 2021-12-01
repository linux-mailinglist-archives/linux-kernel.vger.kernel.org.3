Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CA66464B60
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 11:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348606AbhLAKPr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 05:15:47 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:23696 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348570AbhLAKPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 05:15:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638353540; x=1669889540;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=gjBVeyKaLkCO7bAeM3ck+O0c1L6Xud05nOQIuJCJfoM=;
  b=DpcEH4HvRpPvEaF0r7sG9k551vyOSKekc7JcwMi1jUs5UGivTxCX24u4
   kZv70RBERryUezm0x/laaWnnnEKTTL7Kqwlz4Lzfd+4iDX8ukscNmooBj
   2EqxATcvU/pEjdjhNXSH02He85n5zuJ4X6EtxRhBba5KnIsiebMipVVHy
   Q=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 01 Dec 2021 02:12:19 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 02:12:19 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 1 Dec 2021 02:12:18 -0800
Received: from blr-ubuntu-173.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 1 Dec 2021 02:12:15 -0800
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dianders@chromium.org>,
        <mka@chromium.org>, <kgodara@codeaurora.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Subject: [PATCH v3 4/4] arm64: dts: qcom: sc7280-crd: Add Touchscreen and touchpad support
Date:   Wed, 1 Dec 2021 15:41:42 +0530
Message-ID: <1638353502-23640-5-git-send-email-quic_rjendra@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638353502-23640-1-git-send-email-quic_rjendra@quicinc.com>
References: <1638353502-23640-1-git-send-email-quic_rjendra@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kshitiz Godara <kgodara@codeaurora.org>

Add Touchscreen and touchpad hid-over-i2c node for the sc7280 CRD board

Signed-off-by: Kshitiz Godara <kgodara@codeaurora.org>
Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/arm64/boot/dts/qcom/sc7280-crd.dts | 61 +++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
index 1e3e2f3..cd2755c 100644
--- a/arch/arm64/boot/dts/qcom/sc7280-crd.dts
+++ b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
@@ -23,6 +23,47 @@
 	};
 };
 
+ap_tp_i2c: &i2c0 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	trackpad: trackpad@15 {
+		compatible = "hid-over-i2c";
+		reg = <0x15>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&tp_int_odl>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <7 IRQ_TYPE_EDGE_FALLING>;
+
+		post-power-on-delay-ms = <20>;
+		hid-descr-addr = <0x0001>;
+		vdd-supply = <&vreg_l18b_1p8>;
+
+		wakeup-source;
+	};
+};
+
+ap_ts_pen_1v8: &i2c13 {
+	status = "okay";
+	clock-frequency = <400000>;
+
+	ap_ts: touchscreen@5c {
+		compatible = "hid-over-i2c";
+		reg = <0x5c>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&ts_int_l>, <&ts_reset_l>;
+
+		interrupt-parent = <&tlmm>;
+		interrupts = <55 IRQ_TYPE_LEVEL_LOW>;
+
+		post-power-on-delay-ms = <500>;
+		hid-descr-addr = <0x0000>;
+
+		vdd-supply = <&vreg_l19b_1p8>;
+	};
+};
+
 &nvme_3v3_regulator {
 	gpio = <&tlmm 51 GPIO_ACTIVE_HIGH>;
 };
@@ -30,3 +71,23 @@
 &nvme_pwren {
 	pins = "gpio51";
 };
+
+&tlmm {
+	tp_int_odl: tp-int-odl {
+		pins = "gpio7";
+		function = "gpio";
+		bias-disable;
+	};
+
+	ts_int_l: ts-int-l {
+		pins = "gpio55";
+		function = "gpio";
+		bias-pull-up;
+	};
+
+	ts_reset_l: ts-reset-l {
+		pins = "gpio54";
+		function = "gpio";
+		bias-disable;
+	};
+};
-- 
2.7.4

