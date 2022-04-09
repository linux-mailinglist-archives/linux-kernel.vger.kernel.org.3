Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D79B4FA5A4
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 09:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236860AbiDIHyV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 03:54:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230105AbiDIHyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 03:54:19 -0400
Received: from mxout2.routing.net (mxout2.routing.net [IPv6:2a03:2900:1:a::b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8514146B50;
        Sat,  9 Apr 2022 00:52:12 -0700 (PDT)
Received: from mxbox1.masterlogin.de (unknown [192.168.10.88])
        by mxout2.routing.net (Postfix) with ESMTP id 6D2A95FDFA;
        Sat,  9 Apr 2022 07:52:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailerdienst.de;
        s=20200217; t=1649490730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Woadcv1V4mB8TNR0hX8FoYo4UZy8QqujR0u1IsxgXzk=;
        b=LotVTLABBbxNHxFz/KdC+RuwH+FBndhUE2ckpJVvYC0M9Oy61s1OBFE1BZcgR16eaav06b
        yEl/OZLRzjecQhNJVU/QnyAUAjeTKaheVVVTLGLtzXADW6o3mSF5KOWUklazdgfPEnO9WD
        sw1XELdCQbyO0Buo2hG2SmbFRLwP4wE=
Received: from localhost.localdomain (fttx-pool-217.61.154.105.bambit.de [217.61.154.105])
        by mxbox1.masterlogin.de (Postfix) with ESMTPSA id 848854021D;
        Sat,  9 Apr 2022 07:52:09 +0000 (UTC)
From:   Frank Wunderlich <linux@fw-web.de>
To:     linux-rockchip@lists.infradead.org
Cc:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Fix clocks for rk356x usb
Date:   Sat,  9 Apr 2022 09:51:47 +0200
Message-Id: <20220409075147.136187-1-linux@fw-web.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mail-ID: b784876b-6e21-42de-8301-4411050e2401
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frank Wunderlich <frank-w@public-files.de>

after these 2 commit different clock names are needed compared to 5.17

commit 5114c3ee2487 ("usb: dwc3: Calculate REFCLKPER based on reference clock")
commit 33fb697ec7e5 ("usb: dwc3: Get clocks individually")

change them in new rk356x usb support

Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
---
this is a fix for this series not yet applied
https://patchwork.kernel.org/project/linux-rockchip/list/?series=630470
@peter
after testing you can squash it into your series and add a co-developed or similar
---
 arch/arm64/boot/dts/rockchip/rk356x.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk356x.dtsi b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
index 55e6dcb948cc..6dfe54e53be1 100644
--- a/arch/arm64/boot/dts/rockchip/rk356x.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk356x.dtsi
@@ -264,8 +264,8 @@ usb_host0_xhci: usb@fcc00000 {
 		interrupts = <GIC_SPI 169 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru CLK_USB3OTG0_REF>, <&cru CLK_USB3OTG0_SUSPEND>,
 			 <&cru ACLK_USB3OTG0>;
-		clock-names = "ref_clk", "suspend_clk",
-			      "bus_clk";
+		clock-names = "ref", "suspend_clk",
+			      "bus_early";
 		dr_mode = "host";
 		phy_type = "utmi_wide";
 		power-domains = <&power RK3568_PD_PIPE>;
@@ -280,8 +280,8 @@ usb_host1_xhci: usb@fd000000 {
 		interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
 		clocks = <&cru CLK_USB3OTG1_REF>, <&cru CLK_USB3OTG1_SUSPEND>,
 			 <&cru ACLK_USB3OTG1>;
-		clock-names = "ref_clk", "suspend_clk",
-			      "bus_clk";
+		clock-names = "ref", "suspend_clk",
+			      "bus_early";
 		dr_mode = "host";
 		phys = <&usb2phy0_host>, <&combphy1 PHY_TYPE_USB3>;
 		phy-names = "usb2-phy", "usb3-phy";
-- 
2.25.1

