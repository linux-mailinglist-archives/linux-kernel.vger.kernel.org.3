Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9A446E6B7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbhLIKjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 05:39:14 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:54092 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbhLIKjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:39:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id CEB02CE255A;
        Thu,  9 Dec 2021 10:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F8CAC341CB;
        Thu,  9 Dec 2021 10:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639046130;
        bh=DGpQ8UKzXmA+Q7W3IPx/yZ3lmK5W0GRPJKpshQ3J9+s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pf70D29kLOn5N9K6sbpCokjPzxP3KdrDmH/uo2cU++Cb/nBZK/bQ9ikGnRc4oKBRr
         TINeRlJEIcNWb3NZ7yCS8qflyH+858/iJibTvjsWU5gErH87vmQny0JF/nVFOlPbqq
         rEj8MCFLT3q++/TN78w7mahXcFoaArtja6u+Ej/8dFfYvSax1LvDqqrY7VLNnklG9e
         jWs/3KN57ieBOytMdv0BZPXoMhKnA7Nww0O4jD1Alse0j6jZYCa7rjGse78RTwPJB4
         5P4/v0/lhER+AYu3GXYUQTla7RRQmgK0P0GipF4iYkFre9jHmzuCt/Ds7e2pJXL9+f
         XW3gR+jXC1e+w==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/13] arm64: dts: qcom: Add base SM8450 QRD DTS
Date:   Thu,  9 Dec 2021 16:04:57 +0530
Message-Id: <20211209103505.197453-6-vkoul@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211209103505.197453-1-vkoul@kernel.org>
References: <20211209103505.197453-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DTS for Qualcomm QRD platform which uses SM8450 SoC. This also
includes the pmic files and marks the tlmm reserved pins

Signed-off-by: Vinod Koul <vkoul@kernel.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 arch/arm64/boot/dts/qcom/Makefile       |  1 +
 arch/arm64/boot/dts/qcom/sm8450-qrd.dts | 36 +++++++++++++++++++++++++
 2 files changed, 37 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sm8450-qrd.dts

diff --git a/arch/arm64/boot/dts/qcom/Makefile b/arch/arm64/boot/dts/qcom/Makefile
index 6b816eb33309..9b37261484cf 100644
--- a/arch/arm64/boot/dts/qcom/Makefile
+++ b/arch/arm64/boot/dts/qcom/Makefile
@@ -107,3 +107,4 @@ dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-sony-xperia-edo-pdx203.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8250-sony-xperia-edo-pdx206.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-hdk.dtb
 dtb-$(CONFIG_ARCH_QCOM)	+= sm8350-mtp.dtb
+dtb-$(CONFIG_ARCH_QCOM)	+= sm8450-qrd.dtb
diff --git a/arch/arm64/boot/dts/qcom/sm8450-qrd.dts b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
new file mode 100644
index 000000000000..caa8408b7cd1
--- /dev/null
+++ b/arch/arm64/boot/dts/qcom/sm8450-qrd.dts
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: BSD-3-Clause
+/*
+ * Copyright (c) 2021, Linaro Limited
+ */
+
+/dts-v1/;
+
+#include "sm8450.dtsi"
+#include "pm8350.dtsi"
+#include "pm8350b.dtsi"
+#include "pmr735b.dtsi"
+
+/ {
+	model = "Qualcomm Technologies, Inc. SM8450 QRD";
+	compatible = "qcom,sm8450-qrd", "qcom,sm8450";
+
+	aliases {
+		serial0 = &uart7;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+};
+
+&qupv3_id_0 {
+	status = "okay";
+};
+
+&tlmm {
+	gpio-reserved-ranges = <28 4>, <36 4>;
+};
+
+&uart7 {
+	status = "okay";
+};
-- 
2.31.1

