Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31A174FA6C6
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 12:23:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241404AbiDIKZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 06:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbiDIKZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 06:25:54 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 925FEAAB7D;
        Sat,  9 Apr 2022 03:23:44 -0700 (PDT)
Received: from p508fd313.dip0.t-ipconnect.de ([80.143.211.19] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nd8Fg-0000g7-0v; Sat, 09 Apr 2022 12:23:32 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Frank Wunderlich <linux@fw-web.de>,
        Frank Wunderlich <frank-w@public-files.de>
Cc:     linux-rockchip@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: Aw: [PATCH] arm64: dts: rockchip: Fix clocks for rk356x usb
Date:   Sat, 09 Apr 2022 12:23:31 +0200
Message-ID: <9183927.T7Z3S40VBb@phil>
In-Reply-To: <trinity-71c38625-1a00-47d7-8e23-4f33f25a997a-1649499268581@3c-app-gmx-bap35>
References: <20220409075147.136187-1-linux@fw-web.de> <trinity-71c38625-1a00-47d7-8e23-4f33f25a997a-1649499268581@3c-app-gmx-bap35>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 9. April 2022, 12:14:28 CEST schrieb Frank Wunderlich:
> Hi,
> 
> > Gesendet: Samstag, 09. April 2022 um 09:51 Uhr
> > Von: "Frank Wunderlich" <linux@fw-web.de>
> 
> > -		clock-names = "ref_clk", "suspend_clk",
> > -			      "bus_clk";
> > +		clock-names = "ref", "suspend_clk",
> > +			      "bus_early";
> >  		dr_mode = "host";
> >  		phy_type = "utmi_wide";
> >  		power-domains = <&power RK3568_PD_PIPE>;
> > @@ -280,8 +280,8 @@ usb_host1_xhci: usb@fd000000 {
> >  		interrupts = <GIC_SPI 170 IRQ_TYPE_LEVEL_HIGH>;
> >  		clocks = <&cru CLK_USB3OTG1_REF>, <&cru CLK_USB3OTG1_SUSPEND>,
> >  			 <&cru ACLK_USB3OTG1>;
> > -		clock-names = "ref_clk", "suspend_clk",
> > -			      "bus_clk";
> > +		clock-names = "ref", "suspend_clk",
> > +			      "bus_early";
> >  		dr_mode = "host";
> 
> this is the patch breaking it:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=33fb697ec7e58c4f9b6a68d2786441189cd2df92
> 
> suspend clock needs to be renamed too from "suspend_clk" to "suspend"
> 
> else i get this error on poweroff
> 
> xhci-hcd xhci-hcd.1.auto: Host halt failed, -110
> 
> regards Frank

ok, so do you want to send a v2 including that change?
Alternatively I can also add this change when applying.

Also for educational purposes, the format for referencing a commit
you're fixing would be

Fixes: 33fb697ec7e5 ("usb: dwc3: Get clocks individually")
Signed-off-by: ....


Heiko


