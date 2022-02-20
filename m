Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA314BD167
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 21:23:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243092AbiBTUUl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 15:20:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244832AbiBTUUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 15:20:11 -0500
Received: from mail.z3ntu.xyz (mail.z3ntu.xyz [128.199.32.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1004C43F;
        Sun, 20 Feb 2022 12:19:49 -0800 (PST)
Received: from localhost.localdomain (ip-213-127-118-180.ip.prioritytelecom.net [213.127.118.180])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 07A41C83E7;
        Sun, 20 Feb 2022 20:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1645388388; bh=Y/8pIVuMcaF6kKENuqzsinn1L40g1z3IaAVzLhjqkYM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=c9AUjvNxtgjGIcfYuQ7Fvn9x6BubRQ+wxVBpD/hvGJANpJI9/+gn99jI8+9f6f3Dp
         +HXnrsGVBlO/m2mbBms1zfDqtZuxmoFPL/nSoE5IoMLmWz+8XZiSSIMZkKgdbQNrTV
         kB55Hde4fWY/ANHK7aj6pKRrx/4oJd5gYg+U1LME=
From:   Luca Weiss <luca@z3ntu.xyz>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Gabriel David <ultracoolguy@disroot.org>,
        Luca Weiss <luca@z3ntu.xyz>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/10] arm64: dts: qcom: Add SDM632 device tree
Date:   Sun, 20 Feb 2022 21:19:01 +0100
Message-Id: <20220220201909.445468-9-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220220201909.445468-1-luca@z3ntu.xyz>
References: <20220220201909.445468-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Lypak <vladimir.lypak@gmail.com>

Snapdragon 632 is based on msm8953 with some minor differences, mostly
in the CPUs.

SDM632 is using Kryo 250 instead of ARM Cortex A53 and has some
differences in the thermal zones, mainly there being only one thermal
zones for the first 4 cores (efficiency cores) but keeps one thermal
zone per core for the remaining 4 cores (performance cores).

Co-developed-by: Gabriel David <ultracoolguy@disroot.org>
Signed-off-by: Gabriel David <ultracoolguy@disroot.org>
Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
---
Changes in v2:
- add missing thermal zone for cpu0-3 (and add details to commit msg)
- improve style of overriding other thermal zones
- override compatible for CPUs to qcom,kryo250

 arch/arm64/boot/dts/qcom/sdm632.dtsi | 81 ++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sdm632.dtsi

diff --git a/arch/arm64/boot/dts/qcom/sdm632.dtsi b/arch/arm64/boot/dts/qcom/sdm632.dtsi
new file mode 100644
index 000000000000..645b9f6a801f
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sdm632.dtsi
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/* Copyright (c) 2022, The Linux Foundation. All rights reserved. */
+
+#include "msm8953.dtsi"
+
+/ {
+	thermal-zones {
+		/delete-node/cpu1-thermal;
+		/delete-node/cpu2-thermal;
+		/delete-node/cpu3-thermal;
+
+		cpu0-thermal {
+			thermal-sensors = <&tsens0 13>;
+
+			cooling-maps {
+				map0 {
+					cooling-device = <&CPU0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU1 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU2 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>,
+							 <&CPU3 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
+				};
+			};
+		};
+
+		cpu4-thermal {
+			thermal-sensors = <&tsens0 5>;
+		};
+
+		cpu5-thermal {
+			thermal-sensors = <&tsens0 6>;
+		};
+
+		cpu6-thermal {
+			thermal-sensors = <&tsens0 7>;
+		};
+
+		cpu7-thermal {
+			thermal-sensors = <&tsens0 8>;
+		};
+	};
+};
+
+/*
+ * SDM632 uses Kryo 250 instead of Cortex A53
+ * CPU0-3 are efficiency cores, CPU4-7 are performance cores
+ */
+&CPU0 {
+	compatible = "qcom,kryo250";
+};
+
+&CPU1 {
+	compatible = "qcom,kryo250";
+};
+
+&CPU2 {
+	compatible = "qcom,kryo250";
+};
+
+&CPU3 {
+	compatible = "qcom,kryo250";
+};
+
+&CPU4 {
+	compatible = "qcom,kryo250";
+	capacity-dmips-mhz = <1980>;
+};
+
+&CPU5 {
+	compatible = "qcom,kryo250";
+	capacity-dmips-mhz = <1980>;
+};
+
+&CPU6 {
+	compatible = "qcom,kryo250";
+	capacity-dmips-mhz = <1980>;
+};
+
+&CPU7 {
+	compatible = "qcom,kryo250";
+	capacity-dmips-mhz = <1980>;
+};
-- 
2.35.1

