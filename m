Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C89509931
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385820AbiDUHhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385791AbiDUHhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:37:41 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6483F1EA;
        Thu, 21 Apr 2022 00:34:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B74CB82297;
        Thu, 21 Apr 2022 07:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36852C385A1;
        Thu, 21 Apr 2022 07:34:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650526489;
        bh=Kin58/D9rBGPYeU7vdp0KoxJSMLdV86dYDxrjs2mWTs=;
        h=From:To:Cc:Subject:Date:From;
        b=D4oyNGqbn3hpT5aW7wal6OkmWXo2Cwua9G/+HCjZlCcBvelUwHHhq/FqsO6ts5+tY
         2qml5Q61vnK2VSCi2Ol3bRvbAMjUVN9nhg/7H++b+RL1TsYdLna7CirQ4hagpf8bq1
         OsVwAZQvMS9PQU00CNpZh5AK2RZ2VJvBbFVfTNtlP5fnoDES6pNx1oO/ENTALvafiz
         uP+pfoeNQuR0Evg5KZjc6rnb3KNGPaljiiETTSDe+OZTbT+B2d08J0XB/3K/9YgJBP
         1CB9WP9n92AvMrTr/z7tcmfPe97J/J93JnbmC2QSurKaG9Xfm6DEcALjW0tVeUFu1p
         IO5HCYFuUcQxw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v3] arm64: dts: qcom: db845c: Add support for MCP2517FD
Date:   Thu, 21 Apr 2022 13:04:38 +0530
Message-Id: <20220421073438.1824061-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for onboard MCP2517FD SPI CAN transceiver attached to
SPI0 of RB3.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
Change in v3:
 - change underscore(_) to dash (-) in can-clock node name
 - remove superfluous status = okay in can node

Changes in v2:
 - add cs and pinctrl config
 - remove misleading comment

 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 32 ++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 28fe45c5d516..d2ade684703d 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -28,6 +28,13 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	/* Fixed crystal oscillator dedicated to MCP2517FD */
+	clk40M: can-clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <40000000>;
+	};
+
 	dc12v: dc12v-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "DC12V";
@@ -746,6 +753,23 @@ codec {
 	};
 };
 
+&spi0 {
+	status = "okay";
+	pinctrl-names = "default";
+	pinctrl-0 = <&qup_spi0_default>;
+	cs-gpios = <&tlmm 3 GPIO_ACTIVE_LOW>;
+
+	can@0 {
+		compatible = "microchip,mcp2517fd";
+		reg = <0>;
+		clocks = <&clk40M>;
+		interrupts-extended = <&tlmm 104 IRQ_TYPE_LEVEL_LOW>;
+		spi-max-frequency = <10000000>;
+		vdd-supply = <&vdc_5v>;
+		xceiver-supply = <&vdc_5v>;
+	};
+};
+
 &spi2 {
 	/* On Low speed expansion */
 	label = "LS-SPI0";
@@ -1219,3 +1243,11 @@ ov7251_ep: endpoint {
 		};
 	};
 };
+
+/* PINCTRL - additions to nodes defined in sdm845.dtsi */
+&qup_spi0_default {
+	config {
+		drive-strength = <6>;
+		bias-disable;
+	};
+};
-- 
2.34.1

