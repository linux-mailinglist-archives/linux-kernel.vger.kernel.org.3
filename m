Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C31B0489454
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 09:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242107AbiAJIx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 03:53:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242356AbiAJIvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 03:51:21 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F74C03327F;
        Mon, 10 Jan 2022 00:51:15 -0800 (PST)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id DA002A50;
        Mon, 10 Jan 2022 09:51:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1641804673;
        bh=rGzc5rUjmJsejms3ZrLe/Z/dM1/lyxsEdelYlzXgkHk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d5zgFufXtugVGnjHyea6+l4u5wlRlVRICIpz1U/q0qpcUQ9mOxbo68YrwxVvSh+Di
         O37xM5XFMRE6m0/jx+a+ozPRN5N/enZqoI5kzgexkjgNchtFqy0n4adNMbtiqAGYYC
         vcvW9xIptnNrLiNJ1+/IvP7DGb3ykzXl7dVZRgpY=
Date:   Mon, 10 Jan 2022 10:51:04 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/3] arm64: dts: renesas: r8a77961: Add lvds0 device node
Message-ID: <YdvzeJ09N6Zqa+EJ@pendragon.ideasonboard.com>
References: <20211224052309.1997096-1-nikita.yoush@cogentembedded.com>
 <20211224052309.1997096-3-nikita.yoush@cogentembedded.com>
 <YcyTV4fJqMHIeyYB@pendragon.ideasonboard.com>
 <CAMuHMdVqUcjRQHD898Ja4R0X3QpXvTODE8=pG7UjJ-NtHTFSDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMuHMdVqUcjRQHD898Ja4R0X3QpXvTODE8=pG7UjJ-NtHTFSDA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Mon, Jan 10, 2022 at 09:43:58AM +0100, Geert Uytterhoeven wrote:
> On Wed, Dec 29, 2021 at 5:56 PM Laurent Pinchart wrote:
> > On Fri, Dec 24, 2021 at 08:23:08AM +0300, Nikita Yushchenko wrote:
> > > Add the missing lvds0 node for the R-Car M3-W+ SoC.
> > >
> > > Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
> > > ---
> > >  arch/arm64/boot/dts/renesas/r8a77961.dtsi | 27 +++++++++++++++++++++++
> > >  1 file changed, 27 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/renesas/r8a77961.dtsi b/arch/arm64/boot/dts/renesas/r8a77961.dtsi
> > > index 86d59e7e1a87..a34d5b1d6431 100644
> > > --- a/arch/arm64/boot/dts/renesas/r8a77961.dtsi
> > > +++ b/arch/arm64/boot/dts/renesas/r8a77961.dtsi
> > > @@ -2718,6 +2718,33 @@ du_out_hdmi0: endpoint {
> > >                               port@2 {
> > >                                       reg = <2>;
> > >                                       du_out_lvds0: endpoint {
> > > +                                             remote-endpoint = <&lvds0_in>;
> > > +                                     };
> > > +                             };
> > > +                     };
> > > +             };
> > > +
> > > +             lvds0: lvds@feb90000 {
> > > +                     compatible = "renesas,r8a77961-lvds";
> > > +                     reg = <0 0xfeb90000 0 0x14>;
> > > +                     clocks = <&cpg CPG_MOD 727>;
> > > +                     power-domains = <&sysc R8A77961_PD_ALWAYS_ON>;
> > > +                     resets = <&cpg 727>;
> > > +                     status = "disabled";
> > > +
> > > +                     ports {
> > > +                             #address-cells = <1>;
> > > +                             #size-cells = <0>;
> > > +
> > > +                             port@0 {
> > > +                                     reg = <0>;
> > > +                                     lvds0_in: endpoint {
> > > +                                             remote-endpoint = <&du_out_lvds0>;
> > > +                                     };
> > > +                             };
> > > +                             port@1 {
> > > +                                     reg = <1>;
> > > +                                     lvds0_out: endpoint {
> > >                                       };
> >
> > Endpoints must have a remote-endpoint property. Let's drop the endpoint
> > here and keep the port only, the endpoint can be declared in board
> > files.
> >
> > If you're fine with this change I can make it when applying the patch.
> 
> Isn't this patch for me to apply to renesas-devel?

Even better indeed :-)

> > Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

-- 
Regards,

Laurent Pinchart
