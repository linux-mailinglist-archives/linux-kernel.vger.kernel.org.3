Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20DD24613F9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 12:34:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236022AbhK2Lh7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 06:37:59 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:1655 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239066AbhK2Lfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:35:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638185543; x=1669721543;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=fxTxRM3veSCnfsaFH09wJonxoMqt1QSFqWZHjbJamtM=;
  b=OaW9GCp7Q+heEe2VejZLutRv/coFFzUzn8edH9qdpojAnw/idHJRRha+
   secPi86RCtngHWAhpuQnxbpEGMF/lWNV7Lem9HghsPUFtTnQa3DbE224H
   TTgUD8bWtSj9BrYKIAnRia1CCyHLRSFrVgoLSiZrhjhtF/i5FEl3AlL1B
   k=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 29 Nov 2021 03:32:23 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2021 03:32:23 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 29 Nov 2021 03:32:22 -0800
Received: from blr-ubuntu-173.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Mon, 29 Nov 2021 03:32:19 -0800
From:   Rajendra Nayak <quic_rjendra@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <robh+dt@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <dianders@chromium.org>,
        <mka@chromium.org>, <kgodara@codeaurora.org>,
        Kshitiz Godara <kgodara1@codeaurora.org>,
        "Rajendra Nayak" <quic_rjendra@quicinc.com>
Subject: [PATCH v2 4/4] arm64: dts: qcom: sc7280-crd: Add Touchscreen and touchpad support
Date:   Mon, 29 Nov 2021 17:01:37 +0530
Message-ID: <1638185497-26477-5-git-send-email-quic_rjendra@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638185497-26477-1-git-send-email-quic_rjendra@quicinc.com>
References: <1638185497-26477-1-git-send-email-quic_rjendra@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kshitiz Godara <kgodara1@codeaurora.org>

Add Touchscreen and touchpad hid-over-i2c node for the sc7280 CRD board

Signed-off-by: Kshitiz Godara <kgodara1@codeaurora.org>
Signed-off-by: Rajendra Nayak <quic_rjendra@quicinc.com>
---
 arch/arm64/boot/dts/qcom/sc7280-crd.dts | 61 +++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280-crd.dts b/arch/arm64/boot/dts/qcom/sc7280-crd.dts
index 1e3e2f3..fcfb14d 100644
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
+		reg = <0x5C>;
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

