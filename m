Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6B604BF0E6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 05:29:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiBVE2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 23:28:10 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiBVE2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 23:28:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66FC0954A1;
        Mon, 21 Feb 2022 20:20:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 237D3B81857;
        Tue, 22 Feb 2022 04:20:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B0DC340F1;
        Tue, 22 Feb 2022 04:20:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645503604;
        bh=Yk3t15d7qB57d1CQTA5Y98JTp4J0YhpdYKmqHnEHCVk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f5UWaTWsoY9/XBZ6tnCoHWexOLqcHHZGTVN5Q4ByX9ajLkoAhTPQTZawcwSOL5YTH
         njHEJhLK4dM7g5QsMWnXTSw5txmu7Q4rg9Fyu1i5QDFfM1mpXRnxxmVG13D7AMO1oz
         qrhEuQucspt6hAHIwiIo8lVNIARAszcXjgE83psiNxa/hDJFQegAYhPt47gQUHvEkI
         7iCFU9jGqJEb6f8Q+7FTsfd6b7JiRZWbd2bV3zBO2NCD0OA95KxroB/0Qy41T/NZEA
         pTz91v0JFjygEG4nH6vjzapR+fQo3EcDeeXyq7mHLaUdEU/SOX96gYK1WsACahU/nB
         T5xWTQHlIHWuw==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: qcom: sdm845: enable dma for spi
Date:   Tue, 22 Feb 2022 09:49:51 +0530
Message-Id: <20220222041951.1185186-2-vkoul@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220222041951.1185186-1-vkoul@kernel.org>
References: <20220222041951.1185186-1-vkoul@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add dmas property for spi@880000 and pinconf setting so that we can use
dma for this spi device. Also, add iommu properties for qup and spi.

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sdm845-db845c.dts |  4 ++++
 arch/arm64/boot/dts/qcom/sdm845.dtsi       | 11 +++++++++++
 2 files changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
index 13f80a0b6faa..119b15476a71 100644
--- a/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
+++ b/arch/arm64/boot/dts/qcom/sdm845-db845c.dts
@@ -425,6 +425,10 @@ &gmu {
 	status = "okay";
 };
 
+&gpi_dma0 {
+	status = "okay";
+};
+
 &gpu {
 	status = "okay";
 	zap-shader {
diff --git a/arch/arm64/boot/dts/qcom/sdm845.dtsi b/arch/arm64/boot/dts/qcom/sdm845.dtsi
index e8b50f3bf1bf..231f3020123b 100644
--- a/arch/arm64/boot/dts/qcom/sdm845.dtsi
+++ b/arch/arm64/boot/dts/qcom/sdm845.dtsi
@@ -12,6 +12,7 @@
 #include <dt-bindings/clock/qcom,lpass-sdm845.h>
 #include <dt-bindings/clock/qcom,rpmh.h>
 #include <dt-bindings/clock/qcom,videocc-sdm845.h>
+#include <dt-bindings/dma/qcom-gpi.h>
 #include <dt-bindings/gpio/gpio.h>
 #include <dt-bindings/interconnect/qcom,osm-l3.h>
 #include <dt-bindings/interconnect/qcom,sdm845.h>
@@ -1194,6 +1195,9 @@ spi0: spi@880000 {
 				interconnects = <&aggre1_noc MASTER_QUP_1 0 &config_noc SLAVE_BLSP_1 0>,
 						<&gladiator_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_BLSP_1 0>;
 				interconnect-names = "qup-core", "qup-config";
+				dmas = <&gpi_dma0 0 0 QCOM_GPI_SPI>,
+				       <&gpi_dma0 1 0 QCOM_GPI_SPI>;
+				dma-names = "tx", "rx";
 				status = "disabled";
 			};
 
@@ -2633,6 +2637,13 @@ pinmux {
 					       "gpio2", "gpio3";
 					function = "qup0";
 				};
+
+				config {
+					pins = "gpio0", "gpio1",
+					       "gpio2", "gpio3";
+					drive-strength = <6>;
+					bias-disable;
+				};
 			};
 
 			qup_spi1_default: qup-spi1-default {
-- 
2.34.1

