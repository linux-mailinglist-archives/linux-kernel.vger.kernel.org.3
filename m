Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A85506355
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 06:35:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348413AbiDSEgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 00:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348380AbiDSEgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 00:36:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 825402FE75;
        Mon, 18 Apr 2022 21:33:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B75C2611F9;
        Tue, 19 Apr 2022 04:33:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2E68C385AA;
        Tue, 19 Apr 2022 04:33:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650342838;
        bh=fkvuDq2Bso3cdL/9iihXfEdOfFkWrTLOzW5BCQj/Fsw=;
        h=From:To:Cc:Subject:Date:From;
        b=Ivh84uhNobyb19JWAX2/jbMJRX/q9gqR0mpBib34AL7bnh/QsjuZ8ACJ9/Np5vV8E
         pDhDib39epcc6ucLADSnV+iYe5shsC1HkykIiB7gYojF9CBKA7yUz1EiEZiPCLsn7E
         ajxgoNnuK5q0TS+0fVYfKcMIN94b1Yb4/PtoEaKXhse/4JjY8F0jlTtWNCNTmNC4ty
         Xa2TyvJuHS0LRI/eRf25NaPglaCiBzEpE+MOwz0VNJKtg+0BZHlsKQ6Lga0aam1TeP
         P+IHFi/poof5le/0woigrPTXmyZZQpGyBk71PRL9BdHkeRZioF+lRJZmGO1fBpithV
         SosNn650OjOQA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v2] arm64: dts: qcom: db845c: Add support for MCP2517FD
Date:   Tue, 19 Apr 2022 10:03:48 +0530
Message-Id: <20220419043348.1483625-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for onboard MCP2517FD SPI CAN transceiver attached to
SPI0 of RB3.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
Changes in v2:
 - add cs and pinctrl config
 - remove misleading comment

 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 33 ++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 28fe45c5d516..4f4d45be93e3 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -28,6 +28,13 @@ chosen {
 		stdout-path = "serial0:115200n8";
 	};
 
+	/* Fixed crystal oscillator dedicated to MCP2517FD */
+	clk40M: can_clock {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <40000000>;
+	};
+
 	dc12v: dc12v-regulator {
 		compatible = "regulator-fixed";
 		regulator-name = "DC12V";
@@ -746,6 +753,24 @@ codec {
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
+		status = "okay";
+	};
+};
+
 &spi2 {
 	/* On Low speed expansion */
 	label = "LS-SPI0";
@@ -1219,3 +1244,11 @@ ov7251_ep: endpoint {
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

