Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CAB509F15
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 13:55:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241229AbiDUL63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 07:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230044AbiDUL61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 07:58:27 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F822317A;
        Thu, 21 Apr 2022 04:55:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08CCCB823A5;
        Thu, 21 Apr 2022 11:55:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1701DC385A1;
        Thu, 21 Apr 2022 11:55:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650542135;
        bh=PuqGZunpyyiWzzX8ODWt+Mql3d5o7hixevyuNaxcyGU=;
        h=From:To:Cc:Subject:Date:From;
        b=XRZp0BD1xCoNdNZ31afyMvfQOHP4rJBP0sJYbkiIeEItJNwH9pJdpRE9y/kCkzA7G
         zXWUxdZLKOl6pCym18ubq5LehbvFERZ7kQxBjJBhtZGE1fg+3D5lEXD8uj+D7bkfIh
         wc8oPxrF6od9um3HMB8M2MuXZAH+Rjt4szRolt74u/D0uVGdmzz67SRLbYb5aUMRdI
         xzCMK4r2CZ9ERBWIiqCMOUJqr/of5RtsebbcBFTSFMnJM38wqrCIP1JXf19ghTwRgN
         YtxnoF0NHM4EXzXv/+uZflaAwvvQbojWwwKg5hJqJsEqieihKnXhx7mzeDMzrhk0iQ
         GLHj1yY5MJ8+w==
From:   Vinod Koul <vkoul@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64: dts: qcom: sc7280: Add GPI DMAengines
Date:   Thu, 21 Apr 2022 17:25:24 +0530
Message-Id: <20220421115526.1828659-1-vkoul@kernel.org>
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

The Qualcomm SC7280 has two GPI DMAengines, add definitions for these.

Co-developed-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Signed-off-by: Vijaya Krishna Nivarthi <quic_vnivarth@quicinc.com>
Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 arch/arm64/boot/dts/qcom/sc7280.dtsi | 44 ++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index f0b64be63c21..20dd0f7ab322 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -901,6 +901,28 @@ opp-384000000 {
 
 		};
 
+		gpi_dma0: dma-controller@900000 {
+			#dma-cells = <3>;
+			compatible = "qcom,sc7280-gpi-dma";
+			reg = <0 0x00900000 0 0x60000>;
+			interrupts = <GIC_SPI 244 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 245 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 246 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 247 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 248 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 249 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 250 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 251 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 252 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 253 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 254 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 255 IRQ_TYPE_LEVEL_HIGH>;
+			dma-channels = <12>;
+			dma-channel-mask = <0x7f>;
+			iommus = <&apps_smmu 0x0136 0x0>;
+			status = "disabled";
+		};
+
 		qupv3_id_0: geniqup@9c0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0 0x009c0000 0 0x2000>;
@@ -1330,6 +1352,28 @@ uart7: serial@99c000 {
 			};
 		};
 
+		gpi_dma1: dma-controller@a00000 {
+			#dma-cells = <3>;
+			compatible = "qcom,sc7280-gpi-dma";
+			reg = <0 0x00a00000 0 0x60000>;
+			interrupts = <GIC_SPI 279 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 280 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 281 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 282 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 283 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 284 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 293 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 294 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 295 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 296 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 297 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH>;
+			dma-channels = <12>;
+			dma-channel-mask = <0x1e>;
+			iommus = <&apps_smmu 0x56 0x0>;
+			status = "disabled";
+		};
+
 		qupv3_id_1: geniqup@ac0000 {
 			compatible = "qcom,geni-se-qup";
 			reg = <0 0x00ac0000 0 0x2000>;
-- 
2.34.1

