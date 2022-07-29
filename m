Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC4D7584F62
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 13:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235818AbiG2LK6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 07:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235625AbiG2LK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 07:10:56 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BC01A7AC0E;
        Fri, 29 Jul 2022 04:10:54 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0E1F21063;
        Fri, 29 Jul 2022 04:10:55 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6A3C13F73D;
        Fri, 29 Jul 2022 04:10:53 -0700 (PDT)
Date:   Fri, 29 Jul 2022 12:10:51 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mailbox: arm,mhu: Make secure interrupt
 optional
Message-ID: <20220729111051.5me4vklrzskvsj4w@bogus>
References: <20220728190810.1290857-1-robh@kernel.org>
 <CABb+yY2jV7c8oX7=F=nocfvGrOMHJAYov7zS2nT0=qFoNyoxJQ@mail.gmail.com>
 <CABb+yY0JzztBB+giBu+RCt-dzgwYWF32sCR3WKKP9U5K9UvhxA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABb+yY0JzztBB+giBu+RCt-dzgwYWF32sCR3WKKP9U5K9UvhxA@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 28, 2022 at 04:07:45PM -0500, Jassi Brar wrote:
> On Thu, Jul 28, 2022 at 3:17 PM Jassi Brar <jassisinghbrar@gmail.com> wrote:
> >
> > On Thu, Jul 28, 2022 at 2:08 PM Rob Herring <robh@kernel.org> wrote:
> > >
> > > The secure interrupt is only useful to secure world, therefore for NS
> > > users it shouldn't be required. Make it optional.
> > >
> > > This fixes a warning on Arm Juno board:
> > >
> > > mhu@2b1f0000: interrupts: [[0, 36, 4], [0, 35, 4]] is too short
> > >
> > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > ---
> > >  Documentation/devicetree/bindings/mailbox/arm,mhu.yaml | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
> > > index bd49c201477d..d9a4f4a02d7c 100644
> > > --- a/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
> > > +++ b/Documentation/devicetree/bindings/mailbox/arm,mhu.yaml
> > > @@ -57,6 +57,7 @@ properties:
> > >      maxItems: 1
> > >
> > >    interrupts:
> > > +    minItems: 2
> > >      items:
> > >        - description: low-priority non-secure
> > >        - description: high-priority non-secure
> > >
> > Do we also want to specify that only the secure-irq is optional
> > because irqs are directly mapped onto channels in the driver, and only
> > omitting the secure (last) irq will work.
> >
> I could learn why specifying secure irq isn't desirable?
> No non-secure client node would ask for that secure irq/channel, which
> will simply lay unused.
>

Did you mean would or wouldn't ?

Anyways I can insert a module that requests this channel and bring down
the system as accessing anything configure secure from non-secure side
on Juno results in system hang/error.

> The programming of the secure channel doesn't care if the mode is
> indeed secure. It all relies on providing accurate information in the
> device tree :- the controller provides secure and non-secure channels
> but only non-secure channels are _used_ in non-secure mode.
>

In general w.r.t the MHU IP may be yes. But if the secure side configures
it as secure only and claims the channel which is the case on Juno, any
attempt to access the same from non-secure side is fatal.

> index f6c55877fbd94..004b1566be74d 100644
> --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
> +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
> @@ -26,7 +26,8 @@ mailbox: mhu@2b1f0000 {
>         compatible = "arm,mhu", "arm,primecell";
>         reg = <0x0 0x2b1f0000 0x0 0x1000>;
>         interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
> -                <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> +                <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
> +                <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
>         interrupt-names = "mhu_lpri_rx",
>                   "mhu_hpri_rx";
>         #mbox-cells = <1>;
> 
> If this works for you, I could submit a proper patch.
>

No this doesn't work IMO. Yes standalone everything looks fine, but you can
insert a module requesting this channel and bring down the system. So I am
not for this change.

-- 
Regards,
Sudeep
