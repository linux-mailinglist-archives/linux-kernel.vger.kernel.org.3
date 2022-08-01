Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A434A586751
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 12:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiHAKXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 06:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230042AbiHAKXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 06:23:16 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E0F914031;
        Mon,  1 Aug 2022 03:23:13 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0D514139F;
        Mon,  1 Aug 2022 03:23:14 -0700 (PDT)
Received: from bogus (unknown [10.57.11.114])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2AFA53F67D;
        Mon,  1 Aug 2022 03:23:12 -0700 (PDT)
Date:   Mon, 1 Aug 2022 11:23:09 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: mailbox: arm,mhu: Make secure interrupt
 optional
Message-ID: <20220801102309.efvmde2ackh3vyg4@bogus>
References: <20220728190810.1290857-1-robh@kernel.org>
 <CABb+yY2jV7c8oX7=F=nocfvGrOMHJAYov7zS2nT0=qFoNyoxJQ@mail.gmail.com>
 <CABb+yY0JzztBB+giBu+RCt-dzgwYWF32sCR3WKKP9U5K9UvhxA@mail.gmail.com>
 <20220729111051.5me4vklrzskvsj4w@bogus>
 <CABb+yY1=cppy9QAN=cLWmhvmYrQ5QpY5adE+nRev1rVrtp-QUw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABb+yY1=cppy9QAN=cLWmhvmYrQ5QpY5adE+nRev1rVrtp-QUw@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 29, 2022 at 10:18:04AM -0500, Jassi Brar wrote:
> On Fri, Jul 29, 2022 at 6:10 AM Sudeep Holla <sudeep.holla@arm.com> wrote:
> > On Thu, Jul 28, 2022 at 04:07:45PM -0500, Jassi Brar wrote:
> 
> > > >
> > > I could learn why specifying secure irq isn't desirable?
> > > No non-secure client node would ask for that secure irq/channel, which
> > > will simply lay unused.
> >
> > Did you mean would or wouldn't ?
> >
> I mean what's written.
>

Sorry for asking to be explicit. How can one ensure that doesn't happen
if someone wants to exploit the secure side firmware. That is my concern
and I understand we must block any users of it in the device tree. But
that doesn't prevent people who can run any non-secure side software to
exploit the secure side.

> > Anyways I can insert a module that requests this channel and bring down
> > the system as accessing anything configure secure from non-secure side
> > on Juno results in system hang/error.
> >
> Why go to those lengths? These are already simpler options available  ;-)
> 1)   while (1) ;      // preferably in some atomic context
> 2)   *((int *) 0) = 0;   // you might want to iterate over offset for
> guaranteed results
> 3) Slightly more work, but you also have the opportunity to erase your
> storage device
>

I know these simple methods but can I hinder secure side services with
these ?

> > > index f6c55877fbd94..004b1566be74d 100644
> > > --- a/arch/arm64/boot/dts/arm/juno-base.dtsi
> > > +++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
> > > @@ -26,7 +26,8 @@ mailbox: mhu@2b1f0000 {
> > >         compatible = "arm,mhu", "arm,primecell";
> > >         reg = <0x0 0x2b1f0000 0x0 0x1000>;
> > >         interrupts = <GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>,
> > > -                <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>;
> > > +                <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
> > > +                <GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>;
> > >         interrupt-names = "mhu_lpri_rx",
> > >                   "mhu_hpri_rx";
> > >         #mbox-cells = <1>;
> > >
> > > If this works for you, I could submit a proper patch.
> >
> > No this doesn't work IMO.
> >
> If you _really_ tested and faced an error, please share it.
>

Yes, I did try. But as I hacked the DT to use it(or I can even hack the
kernel if DT is not so easily upgradable). The main point is as the secure
side uses this channel to communicate with SCP for some of the CPU idle
management which is enable by default in the kernel, by just sending the
command using the same secure channel from the Linux I can randomly
ensure the messages sent by secure side is mangled and CPU may either
fail to resume back from suspend or even fail to suspend.

The end result is I just see it just hangs in the non-secure side. While
you could argue it is expected that we should not have used the secure
channel, but I would go further and ask if that needs to be exposed as
there is no way to mark is as disabled or already in use by secure side.

But yes, I see you point as well. Not sure which is better.

> > Yes standalone everything looks fine, but you can
> > insert a module requesting this channel and bring down the system.
> >
> If anyone other than a super-user is able to do that, then you have a
> serious security problem at hand. If you do that as a super-user, have fun.
>

Yes I assuming super user itself. It may not help much to exploit on Juno
much, but will such a mechanism help to exploit and understand the secure
side communication from non-secure side was my general concern as we have
seen and heard of such exploits quite a lot these days. That is the only
reason I was suggesting to not expose any secure mailbox details to the
non-secure world. Juno is probably not a good example platform to make
my point.

I wish there was a way to tell non-secure side that it is disabled for it's
use as it is used by the secure side 🙁.

As Juno platform maintainer, I am not comfortable adding this in case other
platforms copy for it.

--
Regards,
Sudeep
