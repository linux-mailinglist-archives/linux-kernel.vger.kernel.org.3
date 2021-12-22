Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9784D47CCF4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 07:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242746AbhLVGY2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 01:24:28 -0500
Received: from muru.com ([72.249.23.125]:41156 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233176AbhLVGYZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 01:24:25 -0500
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id D33BB8107;
        Wed, 22 Dec 2021 06:25:07 +0000 (UTC)
Date:   Wed, 22 Dec 2021 08:24:22 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        Tero Kristo <kristo@kernel.org>
Subject: Re: [PATCH] dt-bindings: clock: Add binding for TI clksel
Message-ID: <YcLElm04V47kP0Z9@atomide.com>
References: <20211217113640.59840-1-tony@atomide.com>
 <YcIZNfTn37uNbj0F@robh.at.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YcIZNfTn37uNbj0F@robh.at.kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Rob Herring <robh@kernel.org> [211221 18:13]:
> On Fri, Dec 17, 2021 at 01:36:40PM +0200, Tony Lindgren wrote:
> > +additionalProperties: true
> 
> Like what properties?
> 
> true is only used for common, incomplete schemas referenced by device 
> schemas.

There is a collection of the current component clock child nodes for each
clksel instance. I got warnings with "additionalProperties: false", but
maybe the child clock nodes need to be somehow specified in the binding?

For example, below is a sample patch for am335x CLKSEL_GFX_FCLK using a
clksel parent node with the child nodes moved to fix warnings for
unique_unit_address. It also has clock-output-names property added to
avoid the node naming warnings. For the other clksel instances, they can
be a collection of dividers, multipliers, gates and muxes.

Regards,

Tony

8< --------
diff --git a/arch/arm/boot/dts/am33xx-clocks.dtsi b/arch/arm/boot/dts/am33xx-clocks.dtsi
--- a/arch/arm/boot/dts/am33xx-clocks.dtsi
+++ b/arch/arm/boot/dts/am33xx-clocks.dtsi
@@ -494,20 +494,27 @@ mmc_clk: mmc_clk {
 		clock-div = <2>;
 	};
 
-	gfx_fclk_clksel_ck: gfx_fclk_clksel_ck@52c {
-		#clock-cells = <0>;
-		compatible = "ti,mux-clock";
-		clocks = <&dpll_core_m4_ck>, <&dpll_per_m2_ck>;
-		ti,bit-shift = <1>;
-		reg = <0x052c>;
-	};
+	clock@52c {
+		compatible = "ti,clksel";
+		reg = <0x52c>;
+		#clock-cells = <1>;
+		#address-cells = <0>;
+
+		gfx_fclk_clksel_ck: clock-gfx-fclk-clksel {
+			#clock-cells = <0>;
+			compatible = "ti,mux-clock";
+			clock-output-names = "gfx_fclk_clksel_ck";
+			clocks = <&dpll_core_m4_ck>, <&dpll_per_m2_ck>;
+			ti,bit-shift = <1>;
+		};
 
-	gfx_fck_div_ck: gfx_fck_div_ck@52c {
-		#clock-cells = <0>;
-		compatible = "ti,divider-clock";
-		clocks = <&gfx_fclk_clksel_ck>;
-		reg = <0x052c>;
-		ti,max-div = <2>;
+		gfx_fck_div_ck: clock-gfx-fck-div {
+			#clock-cells = <0>;
+			compatible = "ti,divider-clock";
+			clock-output-names = "gfx_fck_div_ck";
+			clocks = <&gfx_fclk_clksel_ck>;
+			ti,max-div = <2>;
+		};
 	};
 
 	sysclkout_pre_ck: sysclkout_pre_ck@700 {
