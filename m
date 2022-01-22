Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCBC496C68
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 13:49:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232294AbiAVMtu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 07:49:50 -0500
Received: from polaris.svanheule.net ([84.16.241.116]:56014 "EHLO
        polaris.svanheule.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232171AbiAVMts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 07:49:48 -0500
Received: from [IPv6:2a02:a03f:eafe:c901:3b3e:e0dc:8977:dea9] (unknown [IPv6:2a02:a03f:eafe:c901:3b3e:e0dc:8977:dea9])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id E02842957CC;
        Sat, 22 Jan 2022 13:49:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1642855787;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QscYBHZxlHkC2HC1UmZnZl4VMPEmIVWTy6UCSMo7XgQ=;
        b=yVD02cxeEg+MBpVnagvus0FCjRNVKF7sT9Rhc/FW2stXlIAQVECAU/SwSG1A5N/Qvwh86w
        ykYxRvnr36m2c50ypVhymG0NdxeKeeQahf99VEa9+BF4/sS7+m16iO7V3I/hFkmR++U0gV
        MBWmEhaPkVG8WG1B7lFfftTTU23v/fd2uG5FH3V/o7fJ079MAxN04E7AILtjqUoDKs4AZl
        4fdJa1ltU2vPdSq6hUa96sticTiGAw/bEYW65EsaT+bmZQq6jWcxghobuA54X6MBm5GY3r
        ay9QqyHg1dpR2ARx2cvZYQ0MK+SvDSi9YaPBV6YDngw3Kj7Yp+25xMUslESuMw==
Message-ID: <d291855a36f200b178aa9e7fb6e41ff438773e38.camel@svanheule.net>
Subject: Re: [PATCH v3 4/6] dt-bindings: interrupt-controller:
 realtek,rtl-intc: require parents
From:   Sander Vanheule <sander@svanheule.net>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>, John Crispin <john@phrozen.org>
Date:   Sat, 22 Jan 2022 13:49:44 +0100
In-Reply-To: <Yes6NFgUmcIcc5mm@robh.at.kernel.org>
References: <cover.1641739718.git.sander@svanheule.net>
         <e043a9faa4a8f71efdf8b7849ec7911f16207fb0.1641739718.git.sander@svanheule.net>
         <Yes6NFgUmcIcc5mm@robh.at.kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob,

On Fri, 2022-01-21 at 16:56 -0600, Rob Herring wrote:
> On Sun, Jan 09, 2022 at 03:54:35PM +0100, Sander Vanheule wrote:
> > The interrupt router has 32 inputs and up to 15 outputs, and the way
> > these are mapped to each other is runtime configurable. The outputs of
> > this interrupt router on the other hand, are connected to a fixed set of
> > parent interrupts. This means that "interrupt-map" is inappropriate, and
> > rather a list of parent interrupts should be specified.
> 
> I'm not sure why interrupt-map is not appropriate. It is not appropriate 
> if you have to touch the interrupt router h/w in servicing the 
> interrupts. If you just need one time configuration of the mapping, then 
> it should be fine to use I think.

If interrupt-map is used, then AFAICT there are no hooks to inform the driver that a
translation has occurred. How should the interrupt controller driver then know how to set
up the routing? Commit de4adddcbcc2 ("of/irq: Add a quirk for controllers with their own
definition of interrupt-map") added a quirk for the original binding/driver, but that
requires open-coding an interrupt-map parser in the driver.

What this binding doesn't mention (I can add it), is that there are also two IRQ status
registers to:
  - unmask/mask SoC interrupts
  - read the current status of the SoC interrupts

In theory, if the routing is set up correctly (and the IRQ permanently unmasked), I think
one could treat interrupt-map as intended, and connect SoC peripheral IRQ handlers
directly to the parent interrupts. But then the interrupt subsystem would need to check
all attached handlers. This interrupt router/controller allows to check which peripheral
is triggering the parent IRQ, which should be more efficient.

These interrupt controllers are also used on multi-threaded systems, where each hardware
thread has its own IRQ controller. I'm still experimenting with the implementation, but 
there the routing registers would be used to set the CPU affinity of SoC interrupts.

I have to say that I'm not very familiar with the kernel code that handles all this
though, so maybe I'm just missing something?

> > Two-part compatibles are introduced to be able to require "interrupts"
> > for new devicetrees. The relevant descriptions are extended or added to
> > more clearly describe the inputs and outputs of this router.  The old
> > compatible, "interrupt-map" and "#address-cells", is deprecated.
> > Interrupt specifiers for new compatibles will require two cells, to
> > indicate the output selection.
> > 
> > To prevent spurious changes when more SoCs are added, "allOf" is used
> > with one "if", and the compatible enum only has one item.
> > 
> > The example is updated to provide a correct example for RTL8380 SoCs.
> > 
> > Signed-off-by: Sander Vanheule <sander@svanheule.net>
> > ---
> >  .../realtek,rtl-intc.yaml                     | 78 ++++++++++++++-----
> >  1 file changed, 58 insertions(+), 20 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-
> > intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-
> > intc.yaml
> > index 9e76fff20323..aab8d44010af 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
> > @@ -6,6 +6,10 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> >  
> >  title: Realtek RTL SoC interrupt controller devicetree bindings
> >  
> > +description:
> > +  Interrupt router for Realtek MIPS SoCs, allowing each SoC interrupt to be
> > +  routed to one parent interrupt, or left disconnected.
> > +
> >  maintainers:
> >    - Birger Koblitz <mail@birger-koblitz.de>
> >    - Bert Vermeulen <bert@biot.com>
> > @@ -13,45 +17,79 @@ maintainers:
> >  
> >  properties:
> >    compatible:
> > -    const: realtek,rtl-intc
> > +    oneOf:
> > +      - items:
> > +          - enum:
> > +              - realtek,rtl8380-intc
> > +          - const: realtek,rtl-intc
> > +      - const: realtek,rtl-intc
> > +        deprecated: true
> >  
> > -  "#interrupt-cells":
> > -    const: 1
> > +  "#interrupt-cells": true
> >  
> >    reg:
> >      maxItems: 1
> >  
> >    interrupts:
> > -    maxItems: 1
> > +    minItems: 1
> > +    maxItems: 15
> > +    description:
> > +      List of parent interrupts, in the order that they are connected to this
> > +      interrupt router's outputs.
> >  
> >    interrupt-controller: true
> >  
> > -  "#address-cells":
> > -    const: 0
> > -
> > -  interrupt-map:
> > -    description: Describes mapping from SoC interrupts to CPU interrupts
> > -
> >  required:
> >    - compatible
> >    - reg
> >    - "#interrupt-cells"
> >    - interrupt-controller
> > -  - "#address-cells"
> > -  - interrupt-map
> > +
> > +allOf:
> > +  - if:
> > +      properties:
> > +        compatible:
> > +          const: realtek,rtl-intc
> > +    then:
> > +      properties:
> > +        "#interrupt-cells":
> > +          const: 1
> > +
> > +        "#address-cells":
> > +          const: 0
> > +
> > +        interrupt-map: true
> > +      required:
> > +        - "#address-cells"
> > +        - interrupt-map
> > +    else:
> > +      properties:
> > +        "#interrupt-cells":
> > +          description:
> > +            Two cells to specify which line to connect to, and which output it should
> > +            be routed to. Both cells use a zero-based index.
> 
> Picking the index picks the priority? Which is higher priority?

Yes, picking an output will select the (implied) priority. If the parent interrupts are
the six MIPS CPU HW interrupts, then CPU IRQ7 has the highest priority, and IRQ2 has the
lowest priority. All known implementations connect output (0..5) to CPU IRQ(2..7), so 
lower output index then means lower priority.


Best,
Sander

> 
> 
> > +          const: 2
> > +      required:
> > +        - interrupts
> >  
> >  additionalProperties: false
> >  
> >  examples:
> >    - |
> >      intc: interrupt-controller@3000 {
> > -      compatible = "realtek,rtl-intc";
> > -      #interrupt-cells = <1>;
> > +      compatible = "realtek,rtl8380-intc", "realtek,rtl-intc";
> > +      #interrupt-cells = <2>;
> >        interrupt-controller;
> > -      reg = <0x3000 0x20>;
> > -      #address-cells = <0>;
> > -      interrupt-map =
> > -              <31 &cpuintc 2>,
> > -              <30 &cpuintc 1>,
> > -              <29 &cpuintc 5>;
> > +      reg = <0x3000 0x18>;
> > +
> > +      interrupt-parent = <&cpuintc>;
> > +      interrupts = <2>, <3>, <4>, <5>, <6>;
> > +    };
> > +
> > +    irq-consumer@0 {
> > +      reg = <0 4>;
> > +      interrupt-parent = <&intc>;
> > +      interrupts =
> > +        <19 3>, /* IRQ 19, routed to output 3 (cpuintc 5) */
> > +        <18 4>; /* IRQ 18, routed to output 4 (cpuintc 6) */
> >      };
> > -- 
> > 2.33.1
> > 
> > 

