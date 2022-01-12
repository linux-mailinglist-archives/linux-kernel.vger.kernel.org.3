Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E30548CC5C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356998AbiALTuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:50:51 -0500
Received: from mail.z3ntu.xyz ([128.199.32.197]:33166 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346178AbiALTuo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:50:44 -0500
Received: from localhost.localdomain (ip-213-127-106-2.ip.prioritytelecom.net [213.127.106.2])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 11706CDFE9;
        Wed, 12 Jan 2022 19:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1642016557; bh=1nSXiLybrrmpnXAV/+hzjEcFhWyu10cN0+bBDqDoHdE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=pLNTnZsBGxFJP53sd7sLOGS8HWAn5KUgOhlG/DRns0gZqBO5+GpAGwhs9rhqaZaFy
         Im5B/5NGQT7Z7Sr4n7ZNuBwbaRKp6JUl5G013HGSPbhDVZcIDtszKXCO1AbY1Umd3q
         6UlkmTTbcwpYa7I7PzEtpXe07okn55+YnRizArE0=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Luca Weiss <luca@z3ntu.xyz>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 11/15] arm64: dts: qcom: Add PM8953 PMIC
Date:   Wed, 12 Jan 2022 20:41:00 +0100
Message-Id: <20220112194118.178026-12-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112194118.178026-1-luca@z3ntu.xyz>
References: <20220112194118.178026-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Lypak <vladimir.lypak@gmail.com>

Add a base DT for PM8953 PMIC, commonly used with MSM8953.

Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/pm8953.dtsi | 90 ++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/pm8953.dtsi

diff --git a/arch/arm64/boot/dts/qcom/pm8953.dtsi b/arch/arm64/boot/dts/qcom/pm8953.dtsi
new file mode 100644
index 000000000000..102555b3f313
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/pm8953.dtsi
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/* Copyright (c) 2022, The Linux Foundation. All rights reserved. */
+
+#include <dt-bindings/iio/qcom,spmi-vadc.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+#include <dt-bindings/input/linux-event-codes.h>
+#include <dt-bindings/spmi/spmi.h>
+
+&spmi_bus {
+	pmic@0 {
+		compatible = "qcom,pm8953", "qcom,spmi-pmic";
+		reg = <0 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		rtc@6000 {
+			compatible = "qcom,pm8941-rtc";
+			reg = <0x6000>, <0x6100>;
+			reg-names = "rtc", "alarm";
+			interrupts = <0x0 0x61 0x1 IRQ_TYPE_EDGE_RISING>;
+		};
+
+		pm8953_pon: pon@800 {
+			compatible = "qcom,pm8916-pon";
+			reg = <0x800>;
+			mode-bootloader = <0x2>;
+			mode-recovery = <0x1>;
+
+			pwrkey {
+				compatible = "qcom,pm8941-pwrkey";
+				interrupts = <0x00 0x08 0 IRQ_TYPE_EDGE_BOTH>;
+				debounce = <15625>;
+				bias-pull-up;
+				linux,code = <KEY_POWER>;
+			};
+
+			pm8953_resin: resin {
+				compatible = "qcom,pm8941-resin";
+				interrupts = <0x00 0x08 1 IRQ_TYPE_EDGE_BOTH>;
+				debounce = <15625>;
+				bias-pull-up;
+				status = "disabled";
+			};
+		};
+
+		temp-alarm@2400 {
+			compatible = "qcom,spmi-temp-alarm";
+			reg = <0x2400>;
+			interrupts = <0x0 0x24 0x0 IRQ_TYPE_EDGE_RISING>;
+			io-channels = <&pm8953_vadc 0x08>;
+			io-channel-names = "thermal";
+			#thermal-sensor-cells = <0x00>;
+		};
+
+		pm8953_vadc: vadc@3100 {
+			compatible = "qcom,spmi-vadc";
+			reg = <0x3100>;
+			interrupts = <0x00 0x31 0x00 0x01>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+			#io-channel-cells = <1>;
+
+			die_temp@8 {
+				reg = <VADC_DIE_TEMP>;
+			};
+			ref_625mv@9 {
+				reg = <VADC_REF_625MV>;
+			};
+			ref_1250v@a {
+				reg = <VADC_REF_1250MV>;
+			};
+			ref_buf_625mv@c {
+				reg = <VADC_SPARE1>;
+			};
+			ref_gnd@e {
+				reg = <VADC_GND_REF>;
+			};
+			ref_vdd@f {
+				reg = <VADC_VDD_VADC>;
+			};
+		};
+	};
+
+	pmic@1 {
+		compatible = "qcom,pm8953", "qcom,spmi-pmic";
+		reg = <1 SPMI_USID>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+	};
+};
-- 
2.34.1

