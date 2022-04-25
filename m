Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF95950E062
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 14:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbiDYMgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 08:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238226AbiDYMfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 08:35:38 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2E66A006;
        Mon, 25 Apr 2022 05:32:34 -0700 (PDT)
Received: from obbardc-laptop.home (unknown [IPv6:2a00:23c7:6883:e501:cf51:f3a2:10b5:accf])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: obbardc)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 96F101F43553;
        Mon, 25 Apr 2022 13:32:32 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650889952;
        bh=hSDAXRypJ/Z4HhJhylWfvqB1KkaymD9gTFsthsCapJw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W9/PsLcXtG01Bhrekqx6eBoE2aNTbSa/do5zzv6WiKHJ23ya8u1xJ5tJSXLyeqWEX
         xlP9nxXmiaIHq2/y2zkVxl9d5AoR/6mC6r4AsKYZBUJBx2N8q16LnN0JWmu13vG24e
         JhJt0DtwSIlLSfW4H/ZY40fBUVDiwbS8c0ZAAS48OzVtA2b0YSvmdk97cCzChpratl
         aXkuV1eUWMb07D/h2MpF4XZnD50qezVCxEKxbtP8RmlWzEB26842lBoqiS2BVb1nnY
         byk/CyFPGLgU089nacef9TjA6oxF1fIoIS7l9E2IZnoHmOXWOsYhf33kuEJgU3Cb0V
         Pf0Y8rgeZ5iLQ==
From:   Christopher Obbard <chris.obbard@collabora.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Johan Jonker <jbx6244@gmail.com>,
        Elaine Zhang <zhangqing@rock-chips.com>
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        Christopher Obbard <chris.obbard@collabora.com>
Subject: [PATCH v2 3/3] arm64: dts: rockchip: Add vdec support for RK3328
Date:   Mon, 25 Apr 2022 13:32:15 +0100
Message-Id: <20220425123215.1055251-4-chris.obbard@collabora.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220425123215.1055251-1-chris.obbard@collabora.com>
References: <20220425123215.1055251-1-chris.obbard@collabora.com>
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
Describe the vdec device, the required power-domains
and enable the iommu in the devicetree.

Signed-off-by: Christopher Obbard <chris.obbard@collabora.com>
---
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index f8ef149fedad..49ae15708a0b 100644
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
@@ -660,6 +664,20 @@ vpu_mmu: iommu@ff350800 {
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
+		iommus = <&vdec_mmu>;
+		power-domains = <&power RK3328_PD_VIDEO>;
+	};
+
 	vdec_mmu: iommu@ff360480 {
 		compatible = "rockchip,iommu";
 		reg = <0x0 0xff360480 0x0 0x40>, <0x0 0xff3604c0 0x0 0x40>;
@@ -667,7 +685,7 @@ vdec_mmu: iommu@ff360480 {
 		clocks = <&cru ACLK_RKVDEC>, <&cru HCLK_RKVDEC>;
 		clock-names = "aclk", "iface";
 		#iommu-cells = <0>;
-		status = "disabled";
+		power-domains = <&power RK3328_PD_VIDEO>;
 	};
 
 	vop: vop@ff370000 {
-- 
2.34.1

