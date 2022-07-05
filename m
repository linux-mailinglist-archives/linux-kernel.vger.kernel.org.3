Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFA905669FE
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbiGELlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiGELlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:41:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5384113F7C;
        Tue,  5 Jul 2022 04:41:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CCA9AB817B0;
        Tue,  5 Jul 2022 11:40:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D112AC341EC;
        Tue,  5 Jul 2022 11:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657021256;
        bh=Z3N2ndHEJ7o1znNL+Ut1e9hKVwDiO1GHRHJ5NRREKZc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uXYGPxve0LbKui0+dONvQoi2rp2Pv8TayEMG0R928ccYFtwiQ8xUxq9mHT515uZZQ
         QqDBdPgFdHe9AhA1iIZNH+OhcapMS9IXBXBBkmJerbVJXd38fRi679lLJ8NTQPef3N
         i0hSLTfkRsUguyugECdpE2CMmIOJ9gHBITPqWh0vwq/Z9OYshMFpoUMDmf6T5505PK
         W1GDczKPpcQ9Tm+5VqOR0GZ+dE8Qa2hGKSXGkMzdpJxbAqqEXZIw3mf1POXOUuZ8ox
         AYUAddPxuj8iJA/AVtfX+9ns2iQT+OBeyrb5oXJsjoPp6X+2lJ8kmuVtAPoUYTIYgQ
         QKnW9mxrICuzA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1o8gvK-0005xy-41; Tue, 05 Jul 2022 13:40:58 +0200
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 12/14] arm64: dts: qcom: msm8996: add missing PCIe PHY clock-cells
Date:   Tue,  5 Jul 2022 13:40:30 +0200
Message-Id: <20220705114032.22787-13-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220705114032.22787-1-johan+linaro@kernel.org>
References: <20220705114032.22787-1-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The QMP PCIe PHY provides a single clock so drop the redundant clock
index from the first PCIe PHY and add the missing '#clock-cells'
properties to the second and third PHY nodes.

Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
---
 arch/arm64/boot/dts/qcom/msm8996.dtsi | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8996.dtsi b/arch/arm64/boot/dts/qcom/msm8996.dtsi
index 34fd0c68b6e8..b670d0412760 100644
--- a/arch/arm64/boot/dts/qcom/msm8996.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8996.dtsi
@@ -609,7 +609,7 @@ pciephy_0: phy@35000 {
 				      <0x00035400 0x1dc>;
 				#phy-cells = <0>;
 
-				#clock-cells = <1>;
+				#clock-cells = <0>;
 				clock-output-names = "pcie_0_pipe_clk_src";
 				clocks = <&gcc GCC_PCIE_0_PIPE_CLK>;
 				clock-names = "pipe0";
@@ -623,6 +623,7 @@ pciephy_1: phy@36000 {
 				      <0x00036400 0x1dc>;
 				#phy-cells = <0>;
 
+				#clock-cells = <0>;
 				clock-output-names = "pcie_1_pipe_clk_src";
 				clocks = <&gcc GCC_PCIE_1_PIPE_CLK>;
 				clock-names = "pipe1";
@@ -636,6 +637,7 @@ pciephy_2: phy@37000 {
 				      <0x00037400 0x1dc>;
 				#phy-cells = <0>;
 
+				#clock-cells = <0>;
 				clock-output-names = "pcie_2_pipe_clk_src";
 				clocks = <&gcc GCC_PCIE_2_PIPE_CLK>;
 				clock-names = "pipe2";
-- 
2.35.1

