Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6804C6EBD
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 14:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235012AbiB1N7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 08:59:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236879AbiB1N5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 08:57:53 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7708E7DA81;
        Mon, 28 Feb 2022 05:57:14 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id n185so10323213qke.5;
        Mon, 28 Feb 2022 05:57:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AsODl7JvaXRh2+ut0mxSGhJunK1lBm2DvnylI8wtuII=;
        b=nwMzOMDPX1uSqS4uzoY1wLkCNhKuCXOb6L0j6ZeNgGlLtL8AKAjnQIHbsSNExBKYJT
         4ilHiuGq8rP/uRaNL+h8aoW82w68U529sfqtbKDRaskSEqeqRHPTBP2p95xa2lVlPt9g
         1Y0lrS6mm5j08kN+wQB4nUj4igOOpU9jfnwLMa28OfA/7kPYgPY9LaaYcUZ6iSKK1/An
         xasdcoylogS3Y/gfLnn8n99U6fB0LMsavmoDQsnf5jaypwkAmxitJ+86AkRPmNatPb2q
         WtrNu/dgWjNLeqDJdunySRQ6v5sbZlEMI78b+LEG+wvF75ybpyg/TqMaBU+ah/RS2bOV
         XIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AsODl7JvaXRh2+ut0mxSGhJunK1lBm2DvnylI8wtuII=;
        b=sJIAQe9WWBiJx/qod3goHoemRKfXAQOLzGvuGrc5cVKHD1orI6d/KeQJhd0DpcnkiW
         QvcuX81gaejovSd0wQQvU38T1VUMpznkQqnPVyMKCgOLHuFHdkzi5XVUn+YyCSlcGtdV
         TWLEJNoUEzhuFavR/w51eCynkY8doRoeDDyceTZEuq7e/NAzfWJLiMhRhctJ3RgA9g6J
         8L/8lvIKw72p79D2z3dWkiSKohzS+WhNMktfckH/sMIr0emg9Gxp8alsKlvFgiZltgtD
         /QAEgQha+476lqAZevRcyMfqQTVcq3AsKF2Jvaa9rfhcH2ZB94tRxCE818Go+unvKr09
         yTLg==
X-Gm-Message-State: AOAM533wgBO3DaHuK9vO0tancgrvzMe5knBgdY1MO5wmWcUSNIt+slz5
        UwZbZREdTwBjvGcoF1sLpDs=
X-Google-Smtp-Source: ABdhPJzPrFKZiEYpe9kQCnsOEbJsrl3nbbO6rhnysx54i1jEd/BwaKumcIqB1GeU5ck3q+/1iFEtwg==
X-Received: by 2002:a05:620a:165b:b0:648:e786:a251 with SMTP id c27-20020a05620a165b00b00648e786a251mr10955896qko.461.1646056633516;
        Mon, 28 Feb 2022 05:57:13 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id b8-20020a05620a088800b00648bfd00a41sm4932244qka.80.2022.02.28.05.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 05:57:13 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, michael.riesch@wolfvision.net,
        jbx6244@gmail.com, Peter Geis <pgwipeout@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 6/8] arm64: dts: rockchip: add rk356x dwc3 usb3 nodes
Date:   Mon, 28 Feb 2022 08:56:57 -0500
Message-Id: <20220228135700.1089526-7-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220228135700.1089526-1-pgwipeout@gmail.com>
References: <20220228135700.1089526-1-pgwipeout@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the dwc3 device nodes to the rk356x device trees.
The rk3566 has one usb2 capable dwc3 otg controller and one usb3 capable
dwc3 host controller.
The rk3568 has one usb3 capable dwc3 otg controller and one usb3 capable
dwc3 host controller.

Signed-off-by: Peter Geis <pgwipeout@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3566.dtsi | 11 ++++++++
 arch/arm64/boot/dts/rockchip/rk3568.dtsi |  9 ++++++
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 35 +++++++++++++++++++++++-
 3 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3566.dtsi b/arch/arm64/boot/dts/rockchip/rk3566.dtsi
index 3839eef5e4f7..0b957068ff89 100644
--- a/arch/arm64/boot/dts/rockchip/rk3566.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3566.dtsi
@@ -6,6 +6,10 @@ / {
 	compatible = "rockchip,rk3566";
 };
 
+&pipegrf {
+	compatible = "rockchip,rk3566-pipe-grf", "syscon";
+};
+
 &power {
 	power-domain@RK3568_PD_PIPE {
 		reg = <RK3568_PD_PIPE>;
@@ -18,3 +22,10 @@ power-domain@RK3568_PD_PIPE {
 		#power-domain-cells = <0>;
 	};
 };
+
+&usb_host0_xhci {
+	phys = <&usb2phy0_otg>;
+	phy-names = "usb2-phy";
+	extcon = <&usb2phy0>;
+	maximum-speed = "high-speed";
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk3568.dtsi b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
index 5b0f528d6818..8ba9334f9753 100644
--- a/arch/arm64/boot/dts/rockchip/rk3568.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3568.dtsi
@@ -99,6 +99,10 @@ opp-1992000000 {
 	};
 };
 
+&pipegrf {
+	compatible = "rockchip,rk3568-pipe-grf", "syscon";
+};
+
 &power {
 	power-domain@RK3568_PD_PIPE {
 		reg = <RK3568_PD_PIPE>;
@@ -114,3 +118,8 @@ power-domain@RK3568_PD_PIPE {
 		#power-domain-cells = <0>;
 	};
 };
+
+&usb_host0_xhci {
+	phys = <&usb2phy0_otg>, <&combphy0 PHY_TYPE_USB3>;
+	phy-names = "usb2-phy", "usb3-phy";
+};
diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 7cdef800cb3c..ca20d7b91fe5 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -230,6 +230,40 @@ scmi_shmem: sram@0 {
 		};
 	};
 
+	usb_host0_xhci: usb@fcc00000 {
+		compatible = "rockchip,rk3568-dwc3", "snps,dwc3";
+		reg = <0x0 0xfcc00000 0x0 0x400000>;
+		interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru CLK_USB3OTG0_REF>, <&cru CLK_USB3OTG0_SUSPEND>,
+			 <&cru ACLK_USB3OTG0>;
+		clock-names = "ref_clk", "suspend_clk",
+			      "bus_clk";
+		dr_mode = "host";
+		phy_type = "utmi_wide";
+		power-domains = <&power RK3568_PD_PIPE>;
+		resets = <&cru SRST_USB3OTG0>;
+		snps,dis_u2_susphy_quirk;
+		status = "disabled";
+	};
+
+	usb_host1_xhci: usb@fd000000 {
+		compatible = "rockchip,rk3568-dwc3", "snps,dwc3";
+		reg = <0x0 0xfd000000 0x0 0x400000>;
+		interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru CLK_USB3OTG1_REF>, <&cru CLK_USB3OTG1_SUSPEND>,
+			 <&cru ACLK_USB3OTG1>;
+		clock-names = "ref_clk", "suspend_clk",
+			      "bus_clk";
+		dr_mode = "host";
+		phys = <&usb2phy0_host>, <&combphy1 PHY_TYPE_USB3>;
+		phy-names = "usb2-phy", "usb3-phy";
+		phy_type = "utmi_wide";
+		power-domains = <&power RK3568_PD_PIPE>;
+		resets = <&cru SRST_USB3OTG1>;
+		snps,dis_u2_susphy_quirk;
+		status = "disabled";
+	};
+
 	gic: interrupt-controller@fd400000 {
 		compatible = "arm,gic-v3";
 		reg = <0x0 0xfd400000 0 0x10000>, /* GICD */
@@ -297,7 +331,6 @@ pmu_io_domains: io-domains {
 	};
 
 	pipegrf: syscon@fdc50000 {
-		compatible = "rockchip,rk3568-pipe-grf", "syscon";
 		reg = <0x0 0xfdc50000 0x0 0x1000>;
 	};
 
-- 
2.25.1

