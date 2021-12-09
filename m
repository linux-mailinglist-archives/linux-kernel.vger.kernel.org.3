Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E60746E6D4
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 11:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232859AbhLIKoQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Dec 2021 05:44:16 -0500
Received: from relay1-d.mail.gandi.net ([217.70.183.193]:33219 "EHLO
        relay1-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhLIKoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 05:44:15 -0500
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by relay1-d.mail.gandi.net (Postfix) with ESMTPSA id 9BB56240010;
        Thu,  9 Dec 2021 10:40:39 +0000 (UTC)
Date:   Thu, 9 Dec 2021 11:40:38 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     Rob Herring <robh@kernel.org>, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tony Lindgren <tony@atomide.com>, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mtd: ti,gpmc-nand: Add missing 'rb-gpios'
Message-ID: <20211209114038.710139a8@xps13>
In-Reply-To: <bebef734-d0d3-e78e-e07a-9160ead1f673@kernel.org>
References: <20211206174209.2297565-1-robh@kernel.org>
        <20211209104224.41d42cca@xps13>
        <bebef734-d0d3-e78e-e07a-9160ead1f673@kernel.org>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.7 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Roger,

rogerq@kernel.org wrote on Thu, 9 Dec 2021 12:08:07 +0200:

> Hi Miquel,
> 
> On 09/12/2021 11:42, Miquel Raynal wrote:
> > Hi Rob,
> > 
> > robh@kernel.org wrote on Mon,  6 Dec 2021 11:42:09 -0600:
> >   
> >> With 'unevaluatedProperties' support implemented, the TI GPMC example
> >> has a warning:
> >>
> >> Documentation/devicetree/bindings/memory-controllers/ti,gpmc.example.dt.yaml: nand@0,0: Unevaluated properties are not allowed ('rb-gpios' was unexpected)
> >>
> >> Add the missing definition for 'rb-gpios'.  
> > 
> > rb-gpios is already defined in nand-controller.yaml. I seems like the
> > real problem is that this file does not refer to it. Can you update the
> > fix?  
> 
> I don't think we can refer to nand-controller.yaml right now as we are not
> fully compatible with it yet. Please see examples below.

This is a *very* wrong way of defining a NAND setup. I will take the
patch to silence the warning, but please convert this representation to
the 'new' one. I believe on the driver side it should not be too
complicated to support having a few of these properties moved to a NAND
chip subnode and still support the below binding. Just be very clear
that if the legacy bindings are used, only a single chip is supported.

> ti,gpmc-nand example:
> 
>       nand@0,0 {
>         compatible = "ti,omap2-nand";
>         reg = <0 0 4>;          /* device IO registers */
>         interrupt-parent = <&gpmc>;
>         interrupts = <0 IRQ_TYPE_NONE>, /* fifoevent */
>                      <1 IRQ_TYPE_NONE>; /* termcount */
>         ti,nand-xfer-type = "prefetch-dma";
>         ti,nand-ecc-opt = "bch16";
>         ti,elm-id = <&elm>;
>         #address-cells = <1>;
>         #size-cells = <1>;
> 
>         /* NAND generic properties */
>         nand-bus-width = <8>;
>         rb-gpios = <&gpmc 0 GPIO_ACTIVE_HIGH>;  /* gpmc_wait0 */
> 
>         /* GPMC properties*/
>         gpmc,device-width = <1>;
> 
>         partition@0 {
>           label = "NAND.SPL";
>           reg = <0x00000000 0x00040000>;
>         };
>         partition@1 {
>           label = "NAND.SPL.backup1";
>           reg = <0x00040000 0x00040000>;
>         };
>       };
> 
> 
> nand-controller example:
> 
>     nand-controller {
>       #address-cells = <1>;
>       #size-cells = <0>;
>       cs-gpios = <0>, <&gpioA 1>; /* A single native CS is available */
> 
>       /* controller specific properties */
> 
>       nand@0 {
>         reg = <0>; /* Native CS */
>         nand-use-soft-ecc-engine;
>         nand-ecc-algo = "bch";
> 
>         /* controller specific properties */
>       };
> 
>       nand@1 {
>         reg = <1>; /* GPIO CS */
>       };
>     };
> 
> 
> > 
> > While at it you might also want to drop the rb-gpios property from
> > ingenic,nand.yaml, which also defines it a second time.
> >   
> >> Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> >> Cc: Richard Weinberger <richard@nod.at>
> >> Cc: Vignesh Raghavendra <vigneshr@ti.com>
> >> Cc: Tony Lindgren <tony@atomide.com>
> >> Cc: Roger Quadros <rogerq@kernel.org>
> >> Cc: linux-mtd@lists.infradead.org
> >> Signed-off-by: Rob Herring <robh@kernel.org>
> >> ---
> >>  Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml | 5 +++++
> >>  1 file changed, 5 insertions(+)
> >>
> >> diff --git a/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml b/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml
> >> index beb26b9bcfb2..1c280f52baa0 100644
> >> --- a/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml
> >> +++ b/Documentation/devicetree/bindings/mtd/ti,gpmc-nand.yaml
> >> @@ -53,6 +53,11 @@ properties:
> >>      enum: [8, 16]
> >>      default: 8
> >>  
> >> +  rb-gpios:
> >> +    description:
> >> +      GPIO connection to R/B signal from NAND chip
> >> +    maxItems: 1
> >> +
> >>  patternProperties:
> >>    "@[0-9a-f]+$":
> >>      $ref: "/schemas/mtd/partitions/partition.yaml"  
> > 
> > Thanks,
> > Miquèl
> >   
> 
> cheers,
> -roger
> 

Thanks,
Miquèl
