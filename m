Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89F3B480B3F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 17:21:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235732AbhL1QVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 11:21:12 -0500
Received: from polaris.svanheule.net ([84.16.241.116]:33634 "EHLO
        polaris.svanheule.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235734AbhL1QVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 11:21:11 -0500
Received: from [IPv6:2a02:a03f:eafe:c901:b7e1:d25f:71b8:19e7] (unknown [IPv6:2a02:a03f:eafe:c901:b7e1:d25f:71b8:19e7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id AD92F28904E;
        Tue, 28 Dec 2021 17:21:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1640708469;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IGLNztGri+9mG1S6FgJzUGogTHYsNY78pLWclCAM/2A=;
        b=apgs+1+UOd3qXinvNB11HreTiDBCNhe3R4ZVDN+eId9YY/TJfpUCLxDHDdpyNqm+rx7EGy
        NUhVH1J/Td+QR2F4Iim04uTC/9Sl4KK2BAfuC6E+fvgOgH1R6AwoRJaetXoqB3sAcMuK9d
        2P5N9kXIpzqQ67f6JtS6m7qdroaQRxESyo2jbAJPyRosFMXV6/bNSRyn9YsIuvSXtkBrPW
        4/bSZB27ukZtFsWjQLoCBpmj5XCv/VtsAR9PoKIr2IhHPJUJZD/2bYNXE0hQ6aRv7HxWO8
        vA1YqqtMOUCXhbdhcewHMRL6fs71p5Yk5JdW+y3ez1qciZElKvLT8gQbhcDvNw==
Message-ID: <7a02b3af9b68adeba787418eb042cd262ee335b7.camel@svanheule.net>
Subject: Re: [RFC PATCH v2 4/5] dt-bindings: interrupt-controller:
 realtek,rtl-intc: map output lines
From:   Sander Vanheule <sander@svanheule.net>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org
Date:   Tue, 28 Dec 2021 17:21:08 +0100
In-Reply-To: <87r19yz47t.wl-maz@kernel.org>
References: <cover.1640548009.git.sander@svanheule.net>
         <0a91967d40d486bb8cccd0dcf5a817df11317cf0.1640548009.git.sander@svanheule.net>
         <87r19yz47t.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-12-27 at 11:17 +0000, Marc Zyngier wrote:
> On Sun, 26 Dec 2021 19:59:27 +0000,
> Sander Vanheule <sander@svanheule.net> wrote:
> > 
> > Amend the binding to also require a list of parent interrupts, and an
> > optional mask to specify which parent is mapped to which output.
> > 
> > Without this information, any driver would have to make an assumption on
> > which parent interrupt is connected to which output.
> 
> Why should an endpoint driver care at all?

Interrupt inputs to interrupt outputs are SW configurable, but outputs to parent
interrupts are hard-wired and cannot be modified. "interrupt-map" defines an input to
parent interrupt mapping, so it seems a piece of information is missing. This is currently
provided as an assumption in the driver ("CPU IRQs (2..7) are connected to outputs
(1..6)").

Input-to-output is SW configurable, so that can be put in the driver. Output-to-parent is
hardware configuration, 


> > 
> > Additionally, extend (or add) the relevant descriptions to more clearly
> > describe the inputs and outputs of this router.
> > 
> > Signed-off-by: Sander Vanheule <sander@svanheule.net>
> > ---
> > Since it does not properly describe the hardware, I would still really
> > rather get rid of "interrupt-map", even though that would mean breaking
> > ABI for this binding. As we've argued before [1], that is our prefered
> > solution, and would enable us to not carry more (hacky) code because of
> > a mistake with the initial submission.
> 
> Again, this is too late. Broken bindings live forever.
> 
> > 
> > Vendors don't ship independent DT blobs for devices with this hardware,
> > so the independent devicetree/kernel upgrades issue is really rather
> > theoretical here. Realtek isn't driving the development of the bindings
> > and associated drivers for this platform. They have their SDK and seem
> > to care very little about proper kernel integration.
> 
> Any vendor can do whatever they want. You can do the same thing if you
> really want to.
> 
> > 
> > Furthermore, there are currently no device descriptions in the kernel
> > using this binding. There are in OpenWrt, but OpenWrt firmware images
> > for this platform always contain both the kernel and the appended DTB,
> > so there's also no breakage to worry about.
> 
> That's just one use case. Who knows who is using this stuff in a
> different context? Nobody can tell.
> 
> > 
> > [1] https://lore.kernel.org/all/9c169aad-3c7b-2ffb-90a2-1ca791a3f411@phrozen.org/
> > 
> > Differences with v1:
> > - Don't drop the "interrupt-map" property
> > - Add the "realtek,output-valid-mask" property
> > ---
> >  .../realtek,rtl-intc.yaml                     | 38 ++++++++++++++++---
> >  1 file changed, 33 insertions(+), 5 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-
> > intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-
> > intc.yaml
> > index 9e76fff20323..29014673c34e 100644
> > --- a/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
> > +++ b/Documentation/devicetree/bindings/interrupt-controller/realtek,rtl-intc.yaml
> > @@ -6,6 +6,10 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
> >  
> >  title: Realtek RTL SoC interrupt controller devicetree bindings
> >  
> > +description:
> > +  Interrupt router for Realtek MIPS SoCs, allowing up to 32 SoC interrupts to
> > +  be routed to one of up to 15 parent interrupts, or left disconnected.
> > +
> >  maintainers:
> >    - Birger Koblitz <mail@birger-koblitz.de>
> >    - Bert Vermeulen <bert@biot.com>
> > @@ -22,7 +26,11 @@ properties:
> >      maxItems: 1
> >  
> >    interrupts:
> > -    maxItems: 1
> > +    minItems: 1
> > +    maxItems: 15
> > +    description:
> > +      List of parent interrupts, in the order that they are connected to this
> > +      interrupt router's outputs.
> 
> Is that to support multiple SoCs? I'd expect a given SoC to have a
> fixed number of output interrupts.

It is, and they do AFAICT. But all values from 1 to 15 can be written to the routing
registers, so I wanted this definition to be as broad as possible.

The SoCs I'm working with only connect to the six CPU HW interrupts, but I don't know what
the actual limit of this interrupt hardware is, or if the outputs always connect to the
MIPS CPU HW interrupts.

> >  
> >    interrupt-controller: true
> >  
> > @@ -30,7 +38,21 @@ properties:
> >      const: 0
> >  
> >    interrupt-map:
> > -    description: Describes mapping from SoC interrupts to CPU interrupts
> > +    description:
> > +      List of <soc_int parent_phandle parent_args ...> tuples, where "soc_int"
> > +      is the interrupt input line number as provided by this controller.
> > +      "parent_phandle" and "parent_args" specify which parent interrupt this
> > +      line should be routed to. Note that interrupt specifiers should be
> > +      identical to the parents specified in the "interrupts" property.
> > +
> > +  realtek,output-valid-mask:
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    description:
> > +      Optional bit mask indicating which outputs are connected to the parent
> > +      interrupts. The lowest set bit indicates which output line the first
> > +      interrupt from "interrupts" is connected to, the second lowest set bit
> > +      for the second interrupt, etc. If not provided, parent interrupts will be
> > +      assigned sequentially to the outputs.
> >  
> >  required:
> >    - compatible
> > @@ -39,6 +61,7 @@ required:
> >    - interrupt-controller
> >    - "#address-cells"
> >    - interrupt-map
> > +  - interrupts
> > 
> >  additionalProperties: false
> >  
> > @@ -49,9 +72,14 @@ examples:
> >        #interrupt-cells = <1>;
> >        interrupt-controller;
> >        reg = <0x3000 0x20>;
> > +
> > +      interrupt-parent = <&cpuintc>;
> > +      interrupts = <1>, <2>, <5>;
> > +      realtek,output-valid-mask = <0x13>;
> 
> What additional information does this bring? From the description
> above, this is all SW configurable, so why should this be described in
> the DT?

The hardware I currently have, has a single contiguous range of outputs hard-wired to
parent interrupts, starting at the first output.

I wanted to provide maximum flexibility for output connections, which I think should
support sparse output connections. However, since this would be an optional property, and
is currently not needed for any hardware, I suppose it could be added later when needed.

Adding "interrupts" as a required property is also a no-go, I assume, since that would
invalidate currently-valid DT-s.

> > +
> >        #address-cells = <0>;
> >        interrupt-map =
> > -              <31 &cpuintc 2>,
> > -              <30 &cpuintc 1>,
> > -              <29 &cpuintc 5>;
> > +              <31 &cpuintc 2>, /* connect to cpuintc 2 via output 1 */
> > +              <30 &cpuintc 1>, /* connect to cpuintc 1 via output 0 */
> > +              <29 &cpuintc 5>; /* connect to cpuintc 5 via output 4 */
> >      };
> 
> My conclusion here is that, as I stated in my initial review of this
> series, you could completely ignore the 3rd field of the map, and let
> the driver decide on the mapping without any extra information.
> 
> We already have plenty of crossbar-type drivers in the tree that can
> mux a number of input to a number of outputs and route them
> accordingly to a set of parent interrupts. None of this requires to be
> described in DT.

I had another look and "fsl,imx-intmux" looks like what I had in mind.

If I understand correctly, changing "#interrupt-cells" (to add the routing info) and the
required properties (to add "interrupts"), would require a new set of compatibles, in
addition to some fall-back behaviour if only the original compatible is provided.

Let me give this another spin, see what I can come up with.

Best,
Sander
