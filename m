Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A344849D1F3
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 19:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232876AbiAZSnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 13:43:06 -0500
Received: from perceval.ideasonboard.com ([213.167.242.64]:59600 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232675AbiAZSnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 13:43:05 -0500
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 98174478;
        Wed, 26 Jan 2022 19:43:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1643222583;
        bh=OQdRRRosc11uNWOuLj5jqmGwXoA/tFPMxlELYBf15x8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lPr6nQhbEN9FuSAD0Bq21gKEl98hBluP29CjVbcvdVRKHFOkfj3sqD339dSvZi0Wz
         K95X6egke6JgCKxKpD5njaIi+vLbYftJ99b07XYd8oJ90yr85HoTcHlJHKJcGThvdd
         wuB4zJPLLzWemgGZRaubns85RRYuA08eOHvW9mYI=
Date:   Wed, 26 Jan 2022 20:42:44 +0200
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc:     Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>,
        devicetree@vger.kernel.org, kernel-list@raspberrypi.com,
        linux-arm-kernel@lists.infradead.org,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-rpi-kernel@lists.infradead.org, lukasz@jany.st,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Naushir Patuck <naush@raspberrypi.com>, robh@kernel.org,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [RFC PATCH v2 5/7] ARM: dts: bcm2711: Add unicam CSI nodes
Message-ID: <YfGWJCReevd752++@pendragon.ideasonboard.com>
References: <20220121081810.155500-1-jeanmichel.hautbois@ideasonboard.com>
 <20220121081810.155500-6-jeanmichel.hautbois@ideasonboard.com>
 <Yes3c1v+V1hMlWfW@pendragon.ideasonboard.com>
 <CAPY8ntDR5AsxGE5fh_KHMonoZait9evxQkpidu10F7EY9CPxZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPY8ntDR5AsxGE5fh_KHMonoZait9evxQkpidu10F7EY9CPxZA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dave,

On Mon, Jan 24, 2022 at 12:31:34PM +0000, Dave Stevenson wrote:
> On Fri, 21 Jan 2022 at 22:45, Laurent Pinchart wrote:
> > On Fri, Jan 21, 2022 at 09:18:08AM +0100, Jean-Michel Hautbois wrote:
> > > Add both MIPI CSI-2 nodes in the core bcm2711 tree. Use the 3-cells
> > > interrupt declaration, corresponding clocks and default as disabled.
> > >
> > > Signed-off-by: Jean-Michel Hautbois <jeanmichel.hautbois@ideasonboard.com>
> > > ---
> > >  arch/arm/boot/dts/bcm2711.dtsi | 31 +++++++++++++++++++++++++++++++
> > >  1 file changed, 31 insertions(+)
> > >
> > > diff --git a/arch/arm/boot/dts/bcm2711.dtsi b/arch/arm/boot/dts/bcm2711.dtsi
> > > index dff18fc9a906..077141df7024 100644
> > > --- a/arch/arm/boot/dts/bcm2711.dtsi
> > > +++ b/arch/arm/boot/dts/bcm2711.dtsi
> > > @@ -3,6 +3,7 @@
> > >
> > >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> > >  #include <dt-bindings/soc/bcm2835-pm.h>
> > > +#include <dt-bindings/power/raspberrypi-power.h>
> > >
> > >  / {
> > >       compatible = "brcm,bcm2711";
> > > @@ -293,6 +294,36 @@ hvs: hvs@7e400000 {
> > >                       interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
> > >               };
> > >
> > > +             csi0: csi1@7e800000 {
> >
> > The node name should be csi@7e800000, not csi1@7e800000. Now, this will
> > probably cause issues with the firmware that looks for csi1 (and csi0 ?)
> > to hand over control of the Unicam CSI-2 receiver to the kernel. I
> > wonder if this is something that could be handled by a firmware update,
> > to also recognize nodes named "csi" ?
> 
> It already looks for any node starting "csi". If you check the
> downstream DT [1], then the nodes are "csi0: csi@7e800000" and "csi1:
> csi@7e801000".

Oops, indeed. I think I was misled by
https://github.com/raspberrypi/linux/blob/rpi-5.10.y/Documentation/devicetree/bindings/media/bcm2835-unicam.txt
that mentions "csi0" and "csi1".

It's all good then. Jean-Michel, can you update the DT bindings in the
next iteration of the series to correct the DT node naming ?

> There is no actual action required to hand the peripheral over to the
> kernel, it just prevents the firmware from using it and causing
> problems (it masks out the interrupt, and that's checked as part of
> the firmware initialising the peripheral).
> 
> If using imx219 or one of the other sensors supported by the firmware,
> "vcgencmd get_camera" should report that the sensor isn't detected,
> and "sudo vcdbg log msg" should have a line similar to
> "020174.613: camsubs: Ignoring camera 0 as unicam device not available"
> 
>   Dave
> 
> [1] https://github.com/raspberrypi/linux/blob/rpi-5.10.y/arch/arm/boot/dts/bcm270x.dtsi#L88
> 
> > > +                     compatible = "brcm,bcm2835-unicam";
> > > +                     reg = <0x7e800000 0x800>,
> > > +                           <0x7e802000 0x4>;
> > > +                     interrupts = <GIC_SPI 102 IRQ_TYPE_LEVEL_HIGH>;
> > > +                     clocks = <&clocks BCM2835_CLOCK_CAM0>,
> > > +                              <&firmware_clocks 4>;
> > > +                     clock-names = "lp", "vpu";
> > > +                     power-domains = <&power RPI_POWER_DOMAIN_UNICAM0>;
> > > +                     #address-cells = <1>;
> > > +                     #size-cells = <0>;
> > > +                     #clock-cells = <1>;
> >
> > Why do you need #address-cells, #size-cells and #clock-cells ? They're
> > not mentioned in the binding.
> >
> > > +                     status="disabled";
> >
> > Missing spaces around the =.
> >
> > Same comment for the next node.
> >
> > > +             };
> > > +
> > > +             csi1: csi1@7e801000 {
> > > +                     compatible = "brcm,bcm2835-unicam";
> > > +                     reg = <0x7e801000 0x800>,
> > > +                           <0x7e802004 0x4>;
> > > +                     interrupts = <GIC_SPI 103 IRQ_TYPE_LEVEL_HIGH>;
> > > +                     clocks = <&clocks BCM2835_CLOCK_CAM1>,
> > > +                              <&firmware_clocks 4>;
> > > +                     clock-names = "lp", "vpu";
> > > +                     power-domains = <&power RPI_POWER_DOMAIN_UNICAM1>;
> > > +                     #address-cells = <1>;
> > > +                     #size-cells = <0>;
> > > +                     #clock-cells = <1>;
> > > +                     status="disabled";
> > > +             };
> > > +
> > >               pixelvalve3: pixelvalve@7ec12000 {
> > >                       compatible = "brcm,bcm2711-pixelvalve3";
> > >                       reg = <0x7ec12000 0x100>;

-- 
Regards,

Laurent Pinchart
