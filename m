Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8022350B8BB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448109AbiDVNld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:41:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1448084AbiDVNlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:41:21 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E850358E47;
        Fri, 22 Apr 2022 06:38:27 -0700 (PDT)
Received: from obbardc-laptop.home (unknown [IPv6:2a00:23c7:6883:e501:cf51:f3a2:10b5:accf])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 9175D1F468BF;
        Fri, 22 Apr 2022 14:38:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650634706;
        bh=F/N33suZ77vOK1o4zWmW6EAlNmYs0vZALu+fdpoKBn8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FYM0+91MXQGSStUj5wF0DajRh/uP2ylbKZaBRh53X1FEO4cKQ9mcQvaLHx/fIN6pn
         NBkADb9AqxcVCwKSsrQoiyEFXc1pCfvX/SLaAHkb4GLSxA5DZXk6f3UnOUM3npE+/+
         yW9KVrSyKxP+gsBk8Nd/VFXCZtThlbZ+EXNXe3+7L4owQ9pKNqNC+HE1wtQcQMxDia
         i7ejhbKi9xOYxBNEJ/Dko/YDNZYr/SpVGN6w2uycwCmtyh/5g3bqu2Ogqz+6Dffhuh
         nZNmjpOpeCpNeziEEZV4Hz6WThFPA6W7NyB1oWAKfybMtzClPMRu+2OvGanaZHjE3i
         7Nu5vpsyUORuA==
From:   Christopher Obbard <chris.obbard@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Alex Bee <knaerzche@gmail.com>,
        Elaine Zhang <zhangqing@rock-chips.com>
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Christopher Obbard <chris.obbard@collabora.com>
Subject: [PATCH 3/3] arm64: dts: rockchip: Add vdec support for RK3328
Date:   Fri, 22 Apr 2022 14:38:03 +0100
Message-Id: <20220422133803.989256-4-chris.obbard@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220422133803.989256-1-chris.obbard@collabora.com>
References: <20220422133803.989256-1-chris.obbard@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RK3328 has an vdec device with dedicated iommu.
Describe the device and required power-domains in the
devicetree.

Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 25 +++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index f8ef149fedad..390e1e4a8fc9 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -306,6 +306,10 @@ power-domain@RK3328_PD_HEVC {
 			};
 			power-domain@RK3328_PD_VIDEO {
 				reg = <RK3328_PD_VIDEO>;
+				clocks = <&cru ACLK_RKVDEC>,
+					 <&cru HCLK_RKVDEC>,
+					 <&cru SCLK_VDEC_CABAC>,
+					 <&cru SCLK_VDEC_CORE>;
 				#power-domain-cells = <0>;
 			};
 			power-domain@RK3328_PD_VPU {
@@ -660,6 +664,25 @@ vpu_mmu: iommu@ff350800 {
 		power-domains = <&power RK3328_PD_VPU>;
 	};
 
+	vdec: video-codec@ff360000 {
+		compatible = "rockchip,rk3328-vdec", "rockchip,rk3399-vdec";
+		reg = <0x0 0xff360000 0x0 0x400>;
+		interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru ACLK_RKVDEC>, <&cru HCLK_RKVDEC>,
+			 <&cru SCLK_VDEC_CABAC>, <&cru SCLK_VDEC_CORE>;
+		clock-names = "axi", "ahb", "cabac", "core";
+		assigned-clocks = <&cru ACLK_RKVDEC>, <&cru SCLK_VDEC_CABAC>,
+				  <&cru SCLK_VDEC_CORE>;
+		assigned-clock-rates = <400000000>, <400000000>, <300000000>;
+		resets = <&cru SRST_VDEC_A>, <&cru SRST_VDEC_H>,
+			 <&cru SRST_VDEC_CABAC>, <&cru SRST_VDEC_CORE>,
+			 <&cru SRST_VDEC_NIU_A>, <&cru SRST_VDEC_NIU_H>;
+		reset-names = "video_a", "video_h", "video_cabac", "video_core",
+			"niu_a", "niu_h";
+		iommus = <&vdec_mmu>;
+		power-domains = <&power RK3328_PD_VIDEO>;
+	};
+
 	vdec_mmu: iommu@ff360480 {
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff360480 0x0 0x40>, <0x0 0xff3604c0 0x0 0x40>;
@@ -667,7 +690,7 @@ vdec_mmu: iommu@ff360480 {
 		clocks = <&cru ACLK_RKVDEC>, <&cru HCLK_RKVDEC>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
-		status = "disabled";
+		power-domains = <&power RK3328_PD_VIDEO>;
 	};
 
 	vop: vop@ff370000 {
-- 
2.34.1

