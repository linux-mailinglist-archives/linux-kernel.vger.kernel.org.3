Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7055B481656
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 20:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhL2Tcb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 14:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230305AbhL2Tca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 14:32:30 -0500
Received: from polaris.svanheule.net (polaris.svanheule.net [IPv6:2a00:c98:2060:a004:1::200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAF4FC061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 11:32:29 -0800 (PST)
Received: from [IPv6:2a02:a03f:eafe:c901:bb38:31d0:45d2:689b] (unknown [IPv6:2a02:a03f:eafe:c901:bb38:31d0:45d2:689b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sander@svanheule.net)
        by polaris.svanheule.net (Postfix) with ESMTPSA id 7C1AD289957;
        Wed, 29 Dec 2021 20:32:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
        s=mail1707; t=1640806347;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=A5C3PvcXgTqpf3mcI2kpWNaNMJ5Bkkk4oXWzEV1oR4U=;
        b=x57+yHPNVcWIO3Xa6Jk7t7wsyvoXUFVr0SyuoKvyO2VqOwDbpdzsEeO0vB6SnBMUz/qfti
        JHkivbHwzBUW7OkHa5Z0hs2usGh+4YG0T3IfTiEHc6dxiRjD55a/yZdvEfAEZsjYXmA8T2
        2agSFI93I2Gb78yAp0KoBvYP8HAUHV2GCVLXtmELfrzEHQZAQM3NH0dkDbyL9/+VenD097
        Rn+5X/+OxqXG9ZELBvOADGKlrs6vqBAQTC0DeE7xqFtIj15swDJKkuw9vNLzs4DrVS84yU
        L3JRAe2cVn/V2Sc5U0McEZvZXf7J5rm2v2aKRmfppt+mRVi2HE25E9p1+6JA+A==
Message-ID: <2274d5dea29dc1a1969985e193ce98fe1eeef6ca.camel@svanheule.net>
Subject: Re: [RFC PATCH v2 4/5] dt-bindings: interrupt-controller:
 realtek,rtl-intc: map output lines
From:   Sander Vanheule <sander@svanheule.net>
To:     Birger Koblitz <mail@birger-koblitz.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Bert Vermeulen <bert@biot.com>,
        John Crispin <john@phrozen.org>, linux-kernel@vger.kernel.org
Date:   Wed, 29 Dec 2021 20:32:25 +0100
In-Reply-To: <06c1662a-76ff-2ede-a308-ce87186a2311@birger-koblitz.de>
References: <cover.1640548009.git.sander@svanheule.net>
         <0a91967d40d486bb8cccd0dcf5a817df11317cf0.1640548009.git.sander@svanheule.net>
         <87r19yz47t.wl-maz@kernel.org>
         <7a02b3af9b68adeba787418eb042cd262ee335b7.camel@svanheule.net>
         <06c1662a-76ff-2ede-a308-ce87186a2311@birger-koblitz.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Birger,

On Tue, 2021-12-28 at 17:53 +0100, Birger Koblitz wrote:
> On 28/12/2021 17:21, Sander Vanheule wrote:
> > On Mon, 2021-12-27 at 11:17 +0000, Marc Zyngier wrote:
> > > On Sun, 26 Dec 2021 19:59:27 +0000,
> > > Sander Vanheule <sander@svanheule.net> wrote:  
> > > >     interrupts:
> > > > -    maxItems: 1
> > > > +    minItems: 1
> > > > +    maxItems: 15
> > > > +    description:
> > > > +      List of parent interrupts, in the order that they are connected to this
> > > > +      interrupt router's outputs.
> > > 
> > > Is that to support multiple SoCs? I'd expect a given SoC to have a
> > > fixed number of output interrupts.
> > 
> > It is, and they do AFAICT. But all values from 1 to 15 can be written to the routing
> > registers, so I wanted this definition to be as broad as possible.
> > 
> > The SoCs I'm working with only connect to the six CPU HW interrupts, but I don't know
> > what
> > the actual limit of this interrupt hardware is, or if the outputs always connect to
> > the
> > MIPS CPU HW interrupts.
> > 
>  From what I know, the IRQ controller is used solely by Realtek in the RTL838x, RTL839x
> and
> RTL930x SoC families, all of them MIPS 4KEc or 34Kc with the standard 7 CPU IRQ lines.
> In their final RTL931x series they abandoned their custom IRQ controller and went for
> an InterAptiv core with a standard MIPS GIC.

There is some code floating around [1] to support a few Wi-Fi SoCs (RTL8196E, RTL8197D,
and RTL8197F) which appear to use the same interrupt controller. Not that it's very likely
these will ever be supported property, because they contain Lexra MIPS cores.

That code claims these cores can have 16 CPU interrupts, althought the non-standard
interrupts are apparently not implemented in that driver. There is also mention of 64 SoC
interrupts, but it looks like this can be implemented by just instantiating this driver
once for each register range (given the code would be modified to get rid of some static
variables).

Anyway, a mostly theoretical problem. The SoCs we're targetting (RTL8380x, RTL839x, and
RTL930x) use the /6/ MIPS CPU HW interrupts (the two software interrupts are not used
AFAICT).

[1]
https://github.com/ggbruno/openwrt/blob/Realtek/target/linux/realtek/files-4.14/arch/mips/realtek/irq.c

Best,
Sander

