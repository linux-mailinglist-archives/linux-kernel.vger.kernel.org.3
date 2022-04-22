Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16CA750B10E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 09:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444650AbiDVHHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 03:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444645AbiDVHHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 03:07:17 -0400
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FB45130D
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 00:04:23 -0700 (PDT)
Received: from vanadium.ugent.be (vanadium.ugent.be [157.193.99.61])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id BAD6C2CB0E3;
        Fri, 22 Apr 2022 09:04:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1650611061;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wlADY8n35L2Ou7uvyeVSyLqPISR1e/igSs6VXk/afno=;
        b=2z/g+n7+dT+FurhJHIQnLUTHRWFUTSrGyIyTGcvtHHQJMYsJvn+SC/gkpvBeRX51lAm/L4
        yysFkL9Q+w1MRei//reAKfjwiV4SlPL+Tdjb2UleIxA1YdhYBc9MYMVRXWo6jvMIm31hnB
        unP4QlspRwi+PNwj605uXLIZFX10cJQZteWtGZq6Zh8hrBzSLofW0LgCwD4gct6xts7vjz
        BWtErvfLBtxcrUxhqZCQ6GxUpWPTil3neRuNDqwARyKH4GTVghSBpLJIp/RLDOq3X97jxf
        NLGZ8bjU9oouRusSoWjz5XSCGq20aSNYf9HgIeIFJ/Y0vv1apjCpAE8+xYHtrQ==
Message-ID: <b8b62753ad5235e065b4cb0856a7a7c33438dfbb.camel@svanheule.net>
Subject: Re: [PATCH v1 3/6] gpio: realtek-otto: Support per-cpu interrupts
From:   Sander Vanheule <sander@svanheule.net>
To:     Marc Zyngier <maz@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Bert Vermeulen <bert@biot.com>, linux-kernel@vger.kernel.org
Date:   Fri, 22 Apr 2022 09:04:20 +0200
In-Reply-To: <87h76mahsl.wl-maz@kernel.org>
References: <cover.1649533972.git.sander@svanheule.net>
         <8d4e0848f233c2c1b98aa141741c61d95cd3843f.1649533972.git.sander@svanheule.net>
         <CACRpkdbSdDAKiFAsHBosdVDpBhWW-Keoq+t8GJ5LsyWjOZwp_g@mail.gmail.com>
         <87h76mahsl.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus, Marc,

On Thu, 2022-04-21 at 10:48 +0100, Marc Zyngier wrote:
> On Thu, 21 Apr 2022 00:04:16 +0100,
> Linus Walleij <linus.walleij@linaro.org> wrote:
> > 
> > On Sat, Apr 9, 2022 at 9:56 PM Sander Vanheule <sander@svanheule.net> wrote:
> > 
> > > On SoCs with multiple cores, it is possible that the GPIO interrupt
> > > controller supports assigning specific pins to one or more cores.
> > > 
> > > IRQ balancing can be performed on a line-by-line basis if the parent
> > > interrupt is routed to all available cores, which is the default upon
> > > initialisation.
> > > 
> > > Signed-off-by: Sander Vanheule <sander@svanheule.net>
> > 
> > That sounds complicated.
> > 
> > Sounds like something the IRQ maintainer (Marc Z) should
> > have a quick look at.
> 
> This is pretty odd indeed. There seem to be a direct mapping between
> the GPIOs and the CPU it interrupts (or at least that's what the code
> seem to express). However, I don't see a direct relation between the
> CPUs and the chained interrupt. It isn't even clear if this interrupt
> itself is per-CPU.
> 
> So this begs a few questions:
> 
> - is the affinity actually affecting the target CPU? or is it
>   affecting the target mux?
> 
> - how is the affinity of the mux interrupt actually enforced?

There are three interrupt controllers at play here:
   1. MIPS CPU interrupt controller: drivers/irqchip/irq-mips-cpu.c
      One interrupt controller per VPE, so in this case there are two. Provides
      per-CPU interrupts.
   2. SoC interrupt controller: drivers/irqchip/irq-realtek-rtl.c
      Also one interrupt controller per VPE. I suppose these will also be per-
      CPU, although this isn't implemented in the driver yet, and I don't think
      I yet fully understand how should work in the kernel.
   3. GPIO interrupt controller: drivers/gpio/gpio-realtek-otto.c
      One interrupt controller for the entire GPIO bank, with optional
      configurable affinity (this patch) for the different VPEs.

For the RTL839x series of SoCs, this results in the following:

GPIO LINES SOC IRQ MIPS
+--------+ +-----------+ HW IRQ +--------+
--->| GPIO | | SOC IRQ | LINES | IRQ |
--->| BANK |-----o-->| VPE0 CTRL |=========>| VPE0 |
. | | | +-----------+ +--------+
. +--------+ | 
. |
| +-----------+ +--------+
\-->| SOC IRQ | | IRQ |
| VPE1 CTRL |=========>| VPE1 |
+-----------+ +--------+


For RTL930x, where GPIO IRQ affinity is configurable:

GPIO LINES SOC IRQ MIPS
+--------+ +-----------+ HW IRQ +--------+
--->| GPIO |-------->| SOC IRQ | LINES | IRQ |
--->| BANK | | VPE0 CTRL |=========>| VPE0 |
. | |-----\ +-----------+ +--------+
. +--------+ | 
. |
| +-----------+ +--------+
\-->| SOC IRQ | | IRQ |
| VPE1 CTRL |=========>| VPE1 |
+-----------+ +--------+

The interrupt for the GPIO controller can be muxed to any of the MIPS HW
interrupts on any (or all) of the VPEs, and these muxes (SoC IRQ controllers)
can be configured independently per CPU. The SoC IRQ line index is fixed, and
consistent for both VPEs.
Only in the second diagram can individual GPIO interrupts be muxed to any of the
VPEs, but there is still only one IRQ line per VPE for all selected GPIO lines.

I hopes this helps to clarify the situation. We don't have any real
documentation, so this is basically derived from registers descriptions in SDK
headers and testing the interrupt behaviour.

Best,
Sander
