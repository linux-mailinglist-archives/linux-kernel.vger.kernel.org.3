Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C211946400D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 22:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344057AbhK3V1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 16:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344023AbhK3V0x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 16:26:53 -0500
Received: from relay02.th.seeweb.it (relay02.th.seeweb.it [IPv6:2001:4b7a:2000:18::163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0231AC0613E0;
        Tue, 30 Nov 2021 13:23:06 -0800 (PST)
Received: from localhost.localdomain (adsl-d210.84-47-0.t-com.sk [84.47.0.210])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 956D81F66F;
        Tue, 30 Nov 2021 22:23:04 +0100 (CET)
From:   Martin Botka <martin.botka@somainline.org>
To:     martin.botka1@gmail.com
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        konrad.dybcio@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        paul.bouchara@somainline.org,
        Martin Botka <martin.botka@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] arm64: dt: qcom: sm6125.dtsi: Add dispcc
Date:   Tue, 30 Nov 2021 22:21:34 +0100
Message-Id: <20211130212137.25303-3-martin.botka@somainline.org>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211130212137.25303-1-martin.botka@somainline.org>
References: <20211130212137.25303-1-martin.botka@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the dispcc node from the newly added DISPCC
driver for Qualcomm Technology Inc's SM6125 SoC.

Signed-off-by: Martin Botka <martin.botka@somainline.org>
---
 arch/arm64/boot/dts/qcom/sm6125.dtsi | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sm6125.dtsi b/arch/arm64/boot/dts/qcom/sm6125.dtsi
index 51286ddbdb10..78f4705e4117 100644
--- a/arch/arm64/boot/dts/qcom/sm6125.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6125.dtsi
@@ -3,6 +3,7 @@
  * Copyright (c) 2021, Martin Botka <martin.botka@somainline.org>
  */
 
+#include <dt-bindings/clock/qcom,dispcc-sm6125.h>
 #include <dt-bindings/clock/qcom,gcc-sm6125.h>
 #include <dt-bindings/clock/qcom,rpmcc.h>
 #include <dt-bindings/gpio/gpio.h>
@@ -317,6 +318,17 @@ soc {
 		ranges = <0x00 0x00 0x00 0xffffffff>;
 		compatible = "simple-bus";
 
+		dispcc: clock-controller@5f00000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "qcom,dispcc-sm6125";
+			reg = <0x5f00000 0x20000>;
+			clocks = <&gcc GCC_DISP_AHB_CLK>;
+			clock-names = "cfg_ahb_clk";
+			#clock-cells = <1>;
+			#power-domain-cells = <1>;
+		};
+
 		tcsr_mutex: hwlock@340000 {
 			compatible = "qcom,tcsr-mutex";
 			reg = <0x00340000 0x20000>;
-- 
2.34.0

