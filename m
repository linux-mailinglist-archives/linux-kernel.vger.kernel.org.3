Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D30B505850
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 15:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244374AbiDRN77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 09:59:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244265AbiDRNjK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 09:39:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC98C28E0A;
        Mon, 18 Apr 2022 05:58:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 14397B80E59;
        Mon, 18 Apr 2022 12:58:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF03C385A9;
        Mon, 18 Apr 2022 12:58:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650286730;
        bh=/y6aPwFRVj92zxx7fmjocLx4rsewxwFGQqqv1VcWFBg=;
        h=From:To:Cc:Subject:Date:From;
        b=G6wJ9AoUXGFupilLRiI8AiOPumLH4HP1T2wyvciBTwH4/94EOUpLYrwUvIzDXnmpI
         kd5ebXBK5qDBPD1X3LokSUYanSma7cCO/vk0dSFMYg3dhU/Q+p5E9nRSB2tQ56ztaC
         foHtDysLn9ijB2Bv9n0YRdgI0SYjcu/P3vz3W1HFN6LifO3sjy4J1OBir8Ug69I7GU
         1E3w/0rYzekmHPdJ2jGTs+OQeSXrAscGGdtOjIB/lmSE5+WR2SC2bbMZMK9g+cu1bh
         fmboFJ4q/HXmAAS/uoFISd5ilTTg8pdvuDGaySPAF+bxQVvxMVC9q3oHISrvcngi4h
         e8Iip/Tu4cFOA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH] arm64: dts: qcom: db845c: Add support for MCP2517FD
Date:   Mon, 18 Apr 2022 18:28:41 +0530
Message-Id: <20220418125841.1409738-1-vkoul@kernel.org>
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
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts | 23 ++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 28fe45c5d516..5179f8ddb060 100644
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
@@ -746,6 +753,22 @@ codec {
 	};
 };
 
+&spi0 {
+	/* On Low speed expansion */
+	status = "okay";
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
-- 
2.34.1

