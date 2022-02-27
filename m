Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42CFA4C5C93
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 16:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbiB0PbM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 10:31:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbiB0PbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 10:31:02 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC1A403E1;
        Sun, 27 Feb 2022 07:30:24 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id fc19so10561244qvb.7;
        Sun, 27 Feb 2022 07:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3eZl+223sl+0khRsd3wUqrr3mtzeFUiyhoAUr9E3jDI=;
        b=PygESFoK5ow14TVHuMhT0LLw9TBeCh5k8CfG2ey+b0L677CPvgCUqw5E9gPdveYO1s
         K/8RajahPgOPlmwWn1zvwjAhwE9/Se9vLjfyRrsYGixCc5xYYXrBBRB0JW0BAVcgVz7s
         FZLYZEfEcxJn1MAZaUO6BXOEhGuHqDEsGZ4+4bmz8/YgnR/kXBRBNdXqyCQPO9F5YBge
         L7DoRufiZ9AfJhCfdKsVLacusn6VkWppcMQOifuCuq8xk3tbv1xK7OygmewyQINkV5O5
         Ru1pFlML5wWi0lS7Zlm1k9dPBhKLOtomoRtB77Abn64vLaDKBmhV56Y7iV1MPPTozgnW
         pnbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3eZl+223sl+0khRsd3wUqrr3mtzeFUiyhoAUr9E3jDI=;
        b=pqNY7xD7qWjPQPso0UyzZcaRl+p1+jO72qSJQFSjydh64uVWRrYA27BihT/itq7xet
         d5ZWulzij3OdOPcCqywtzetiGZ8rh9eLCorSK1Zil5zHzBVTNCdsIdRHGQZb5+UOiRLn
         zQaf2BprKDstepBDc3Ba+POGqMXgbfQVe5ZK48ehTEGhu/XsXftkhd/xRY8MjvyRro9A
         hpgRp9c+oPWNm8kHUZQm/iGFhV74qF19yqP6TshEfkwFD+7QaMuudUmUMlfkgGYnkYq7
         TxXMWC+IWVIRVe8MfqSCW3MC5PGbEYZnshDDr/Ywy7UR23gv8RiBGZbsQ1evmNiXOHPd
         nsVQ==
X-Gm-Message-State: AOAM532HI2VlQDkiO5lUE9jyUlpsXi4qofskXDeFVxy9cuGwLiW+w0F1
        fGWj5kM6HwoUDlF3oMAjxWk=
X-Google-Smtp-Source: ABdhPJz/IRhGVKuwsLuChwFhxAsEe2SRtfnGcK0RPln660/qisd1WULt8QJJjRYagFIpW1lnousJzg==
X-Received: by 2002:a05:6214:1852:b0:432:dd08:56b1 with SMTP id d18-20020a056214185200b00432dd0856b1mr6379992qvy.3.1645975823982;
        Sun, 27 Feb 2022 07:30:23 -0800 (PST)
Received: from master-x64.sparksnet ([2601:153:980:85b1::10])
        by smtp.gmail.com with ESMTPSA id s10-20020a05620a080a00b0062ce6f3f5d7sm3845767qks.16.2022.02.27.07.30.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 07:30:23 -0800 (PST)
From:   Peter Geis <pgwipeout@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-rockchip@lists.infradead.org, michael.riesch@wolfvision.net,
        jbx6244@gmail.com, Peter Geis <pgwipeout@gmail.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/7] arm64: dts: rockchip: add rk356x dwc3 usb3 nodes
Date:   Sun, 27 Feb 2022 10:30:14 -0500
Message-Id: <20220227153016.950473-6-pgwipeout@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220227153016.950473-1-pgwipeout@gmail.com>
References: <20220227153016.950473-1-pgwipeout@gmail.com>
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
index 7cdef800cb3c..072bb9080cd6 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -230,6 +230,40 @@ scmi_shmem: sram@0 {
 		};
 	};
 
+	usb_host0_xhci: usb@fcc00000 {
+		compatible = "snps,dwc3";
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
+		compatible = "snps,dwc3";
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

