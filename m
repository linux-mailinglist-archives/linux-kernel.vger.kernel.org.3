Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5C650C1CA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 00:07:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231173AbiDVV6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 17:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiDVV56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 17:57:58 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7760403EAA
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 13:40:43 -0700 (PDT)
Received: from [192.168.1.109] (247.72-129-109.adsl-dyn.isp.belgacom.be [109.129.72.247])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id E12922CB5D4;
        Fri, 22 Apr 2022 22:40:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1650660041;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bua5EtbDNu2Of0nRcFOmTXS3IjMFZ5y6IySB6RxScok=;
        b=2kAEFqboh4xIWVhHxQd1oG9fmbhf/RU5Kpk7E6qT3nj7iiuI8644gjaQj+OdAJre8ZXXl9
        v8FyD69kG7U5NCxrBCEd/nMVgHzZx/yreqCYIq8VKtIC3GJ9sotcmyGt7LoOhCBR38Kkfc
        Swiyo5J3anobJyxuQ1OPLTIO3jAaG57iSdWXT0h0Y+moDFqdA3r5epKOniQdxW6jGxs2BQ
        UHtDrnsVgjhR4txmQvxNnunoP0F2xDqCUO0DPQfy42uu05nQVxBIUrzNvpwRDU0qaUK70N
        GmUQ3xryPyI8lfZK5oKtmaQSc0zEtileavwVKrSZEA0VIpNcZw5MI8H7YpcY4A==
Message-ID: <9ceab104f5189664648c219fb9d1e0d70d6bda9f.camel@svanheule.net>
Subject: Re: [PATCH v1 3/6] gpio: realtek-otto: Support per-cpu interrupts
From:   Sander Vanheule <sander@svanheule.net>
To:     Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Bert Vermeulen <bert@biot.com>, linux-kernel@vger.kernel.org
Date:   Fri, 22 Apr 2022 22:40:39 +0200
In-Reply-To: <b8b62753ad5235e065b4cb0856a7a7c33438dfbb.camel@svanheule.net>
References: <cover.1649533972.git.sander@svanheule.net>
         <8d4e0848f233c2c1b98aa141741c61d95cd3843f.1649533972.git.sander@svanheule.net>
         <CACRpkdbSdDAKiFAsHBosdVDpBhWW-Keoq+t8GJ5LsyWjOZwp_g@mail.gmail.com>
         <87h76mahsl.wl-maz@kernel.org>
         <b8b62753ad5235e065b4cb0856a7a7c33438dfbb.camel@svanheule.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-04-22 at 09:04 +0200, Sander Vanheule wrote:
> Hi Linus, Marc,
> 
> On Thu, 2022-04-21 at 10:48 +0100, Marc Zyngier wrote:
> > On Thu, 21 Apr 2022 00:04:16 +0100,
> > Linus Walleij <linus.walleij@linaro.org> wrote:
> > > 
> > > On Sat, Apr 9, 2022 at 9:56 PM Sander Vanheule <sander@svanheule.net> wrote:
> > > 
> > > > On SoCs with multiple cores, it is possible that the GPIO interrupt
> > > > controller supports assigning specific pins to one or more cores.
> > > > 
> > > > IRQ balancing can be performed on a line-by-line basis if the parent
> > > > interrupt is routed to all available cores, which is the default upon
> > > > initialisation.
> > > > 
> > > > Signed-off-by: Sander Vanheule <sander@svanheule.net>
> > > 
> > > That sounds complicated.
> > > 
> > > Sounds like something the IRQ maintainer (Marc Z) should
> > > have a quick look at.
> > 
> > This is pretty odd indeed. There seem to be a direct mapping between
> > the GPIOs and the CPU it interrupts (or at least that's what the code
> > seem to express). However, I don't see a direct relation between the
> > CPUs and the chained interrupt. It isn't even clear if this interrupt
> > itself is per-CPU.
> > 
> > So this begs a few questions:
> > 
> > - is the affinity actually affecting the target CPU? or is it
> >   affecting the target mux?
> > 
> > - how is the affinity of the mux interrupt actually enforced?
> 
> There are three interrupt controllers at play here:
>    1. MIPS CPU interrupt controller: drivers/irqchip/irq-mips-cpu.c
>       One interrupt controller per VPE, so in this case there are two. Provides
>       per-CPU interrupts.
>    2. SoC interrupt controller: drivers/irqchip/irq-realtek-rtl.c
>       Also one interrupt controller per VPE. I suppose these will also be per-
>       CPU, although this isn't implemented in the driver yet, and I don't think
>       I yet fully understand how should work in the kernel.
>    3. GPIO interrupt controller: drivers/gpio/gpio-realtek-otto.c
>       One interrupt controller for the entire GPIO bank, with optional
>       configurable affinity (this patch) for the different VPEs.
> 
> For the RTL839x series of SoCs, this results in the following:

Sorry for the messed up formattng, let me try that again.

GPIO LINES        SOC IRQ              MIPS
    +--------+    LINE +-----------+   HW IRQ +--------+
--->| GPIO   |         | SOC IRQ   |   LINES  | IRQ    |
--->| BANK   |-----o-->| VPE0 CTRL |=========>| VPE0   |
 .  |        |     |   +-----------+          +--------+
 .  +--------+     | 
 .                 |
                   |   +-----------+          +--------+
                   \-->| SOC IRQ   |          | IRQ    |
                       | VPE1 CTRL |=========>| VPE1   |
                       +-----------+          +--------+


> For RTL930x, where GPIO IRQ affinity is configurable:

GPIO LINES        SOC IRQ              MIPS
    +--------+    LINE +-----------+   HW IRQ +--------+
--->| GPIO   |-------->| SOC IRQ   |   LINES  | IRQ    |
--->| BANK   |         | VPE0 CTRL |=========>| VPE0   |
 .  |        |-----\   +-----------+          +--------+
 .  +--------+     | 
 .                 |
                   |   +-----------+          +--------+
                   \-->| SOC IRQ   |          | IRQ    |
                       | VPE1 CTRL |=========>| VPE1   |
                       +-----------+          +--------+

> The interrupt for the GPIO controller can be muxed to any of the MIPS HW
> interrupts on any (or all) of the VPEs, and these muxes (SoC IRQ controllers)
> can be configured independently per CPU. The SoC IRQ line index is fixed, and
> consistent for both VPEs.
> Only in the second diagram can individual GPIO interrupts be muxed to any of the
> VPEs, but there is still only one IRQ line per VPE for all selected GPIO lines.
> 
> I hopes this helps to clarify the situation. We don't have any real
> documentation, so this is basically derived from registers descriptions in SDK
> headers and testing the interrupt behaviour.
> 
> Best,
> Sander

