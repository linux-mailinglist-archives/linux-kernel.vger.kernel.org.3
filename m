Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC08554923
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 14:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357782AbiFVLiY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 07:38:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356610AbiFVLhx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 07:37:53 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DCB3CA41;
        Wed, 22 Jun 2022 04:37:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=8VhFQH5Q1ygwgbFioaFYlr73TBFA4fN7hoa82H2H+kA=; b=IVe/I5PeKxnbUCBTm/SfRqe5SC
        Z9g3RgoNHOXx0aylvdv4wdEt8RxvGq3zqViF+yFNAqYgcnkdwT3rYkNj9g5CuqR+wlJ7pztv4Neac
        KUOSB+JBrrp8RPKt/tS8h2tet/JJ4M5buqg0xUc9RusHSBVnIpX7EL5eKYpyJAlJtJNasZyx4qb7J
        F61PJy9dgOp+R9CMkubCfLztE1LioU+/hNbfqQkPVxhS7sivE5gcj3YeYboVKJT0kZW0mkTb+q8uL
        nuvza5JQCzHAD/TWM6iZokua6vLPvQQVZYUfVZqV/oLucy0tD/DTdTLVONRFZdL8r7zjn7FKF+znN
        41aNAOcA==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1o3yg3-0001Xl-G9; Wed, 22 Jun 2022 14:37:42 +0300
From:   Mikko Perttunen <cyndis@kapsi.fi>
To:     thierry.reding@gmail.com, jonathanh@nvidia.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, digetx@gmail.com
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v2 03/13] arm64: tegra: Add Host1x and VIC on Tegra234
Date:   Wed, 22 Jun 2022 14:37:23 +0300
Message-Id: <20220622113733.1710471-4-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622113733.1710471-1-cyndis@kapsi.fi>
References: <20220622113733.1710471-1-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

Add device tree nodes for Host1x and VIC on Tegra234.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra234.dtsi | 46 ++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra234.dtsi b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
index cb3af539e477..cae68e59580c 100644
--- a/arch/arm64/boot/dts/nvidia/tegra234.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra234.dtsi
@@ -454,6 +454,52 @@ misc@100000 {
 			status = "okay";
 		};
 
+		host1x@13e00000 {
+			compatible = "nvidia,tegra234-host1x";
+			reg = <0x13e00000 0x10000>,
+			      <0x13e10000 0x10000>,
+			      <0x13e40000 0x10000>;
+			reg-names = "common", "hypervisor", "vm";
+			interrupts = <GIC_SPI 448 IRQ_TYPE_LEVEL_HIGH>,
+			             <GIC_SPI 449 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 450 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 451 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 452 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 453 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 454 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 455 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 263 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "syncpt0", "syncpt1", "syncpt2", "syncpt3", "syncpt4",
+			                  "syncpt5", "syncpt6", "syncpt7", "host1x";
+			clocks = <&bpmp TEGRA234_CLK_HOST1X>;
+			clock-names = "host1x";
+
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			ranges = <0x15000000 0x15000000 0x01000000>;
+			interconnects = <&mc TEGRA234_MEMORY_CLIENT_HOST1XDMAR &emc>;
+			interconnect-names = "dma-mem";
+			iommus = <&smmu_niso1 TEGRA234_SID_HOST1X>;
+
+			vic@15340000 {
+				compatible = "nvidia,tegra234-vic";
+				reg = <0x15340000 0x00040000>;
+				interrupts = <GIC_SPI 206 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&bpmp TEGRA234_CLK_VIC>;
+				clock-names = "vic";
+				resets = <&bpmp TEGRA234_RESET_VIC>;
+				reset-names = "vic";
+
+				power-domains = <&bpmp TEGRA234_POWER_DOMAIN_VIC>;
+				interconnects = <&mc TEGRA234_MEMORY_CLIENT_VICSRD &emc>,
+						<&mc TEGRA234_MEMORY_CLIENT_VICSWR &emc>;
+				interconnect-names = "dma-mem", "write";
+				iommus = <&smmu_niso1 TEGRA234_SID_VIC>;
+				dma-coherent;
+			};
+		};
+
 		gpio: gpio@2200000 {
 			compatible = "nvidia,tegra234-gpio";
 			reg-names = "security", "gpio";
-- 
2.36.1

