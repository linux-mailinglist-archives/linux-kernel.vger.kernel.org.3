Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76A748CC88
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 20:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357525AbiALTw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 14:52:57 -0500
Received: from mail.z3ntu.xyz ([128.199.32.197]:33210 "EHLO mail.z3ntu.xyz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350153AbiALTve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 14:51:34 -0500
Received: from localhost.localdomain (ip-213-127-106-2.ip.prioritytelecom.net [213.127.106.2])
        by mail.z3ntu.xyz (Postfix) with ESMTPSA id 07046CDFEC;
        Wed, 12 Jan 2022 19:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=z3ntu.xyz; s=z3ntu;
        t=1642016562; bh=mAkIgCtH123WwHB7ZatGCTMq2iy3omdjIieW2Vv57OI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hYjutwhgm60lgTLkmrmA/iOpgBPezyaqnJ82jcjoHRFKH2oivjy4t5SJdsLteBn55
         MZ6wNt8fHJAeziS8jwbf5CqlcByAgQRnHge/IGLku+S4NT6dAg0DZ0o4LL1mmDUKXb
         A9k/WL2bihSs4bivrRblRss/9cvtUlObXWWVjJXE=
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
Subject: [PATCH 13/15] arm64: dts: qcom: Add MSM8953+PM8953 device tree
Date:   Wed, 12 Jan 2022 20:41:02 +0100
Message-Id: <20220112194118.178026-14-luca@z3ntu.xyz>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112194118.178026-1-luca@z3ntu.xyz>
References: <20220112194118.178026-1-luca@z3ntu.xyz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vladimir Lypak <vladimir.lypak@gmail.com>

The combination MSM8953 + PM8953 is commonly used, so add a
device tree where common power supplies etc. can be configured.

Signed-off-by: Vladimir Lypak <vladimir.lypak@gmail.com>
Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/msm8953-pm8953.dtsi | 50 ++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/msm8953-pm8953.dtsi

diff --git a/arch/arm64/boot/dts/qcom/msm8953-pm8953.dtsi b/arch/arm64/boot/dts/qcom/msm8953-pm8953.dtsi
new file mode 100644
index 000000000000..b5f20fc9488e
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/msm8953-pm8953.dtsi
@@ -0,0 +1,50 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/* Copyright (c) 2022, The Linux Foundation. All rights reserved. */
+
+#include "msm8953.dtsi"
+#include "pm8953.dtsi"
+
+&hsusb_phy {
+	vdd-supply = <&pm8953_l3>;
+	vdda-pll-supply = <&pm8953_l7>;
+	vdda-phy-dpdm-supply = <&pm8953_l13>;
+};
+
+&sdhc_1 {
+	vmmc-supply = <&pm8953_l8>;
+	vqmmc-supply = <&pm8953_l5>;
+};
+
+&sdhc_2 {
+	vmmc-supply = <&pm8953_l11>;
+	vqmmc-supply = <&pm8953_l12>;
+};
+
+&rpm_requests {
+	smd_rpm_regulators: pm8953-regulators {
+		compatible = "qcom,rpm-pm8953-regulators";
+
+		pm8953_s1: s1 {};
+		pm8953_s3: s3 {};
+		pm8953_s4: s4 {};
+
+		pm8953_l1: l1 {};
+		pm8953_l2: l2 {};
+		pm8953_l3: l3 {};
+		pm8953_l5: l5 {};
+		pm8953_l6: l6 {};
+		pm8953_l7: l7 {};
+		pm8953_l8: l8 {};
+		pm8953_l9: l9 {};
+		pm8953_l10: l10 {};
+		pm8953_l11: l11 {};
+		pm8953_l12: l12 {};
+		pm8953_l13: l13 {};
+		pm8953_l15: l15 {};
+		pm8953_l16: l16 {};
+		pm8953_l17: l17 {};
+		pm8953_l19: l19 {};
+		pm8953_l22: l22 {};
+		pm8953_l23: l23 {};
+	};
+};
-- 
2.34.1

