Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9ED04AA589
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 03:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378327AbiBECIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 21:08:12 -0500
Received: from mail-oi1-f174.google.com ([209.85.167.174]:45925 "EHLO
        mail-oi1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356172AbiBECIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 21:08:11 -0500
Received: by mail-oi1-f174.google.com with SMTP id m9so10563838oia.12;
        Fri, 04 Feb 2022 18:08:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=LZOFLqhHtR5h9oapumee7dNSizR1BTIG4SnBYp0E1Kg=;
        b=X6m7vcmDs3emMw4gmATCpPtTNHZGOEPtIAi+6QMvAndwHo7K8/5UbcQXrnomFnPIP8
         mBFmHOcQrbFp5XBQ/Z5ZkL+GsbbFEzz9LGmXtnSWYEcAHNZMLEy08d6iIePGz7PAPESB
         WskGiyK5iPJD0zvlvj1Ps7yxbBUGbLci0U7XZyZlbcn0GSbxnmC+dEA1MR0T+wNZfr/S
         RjieAQ3aFX5RJRAqswkfzepLqbqcJwgPKgglh/ysWC5255YZatghmGsyq77NSRfFeBbh
         w2vtCOnxdkIpGpK0uQFwh1pNN8EhzeUlk0U/PIomtnPiuKIpBR72QP0ZFaoaXrNzBcMY
         7U4w==
X-Gm-Message-State: AOAM531UUj0GxNCP8vmskoCdJsZerDQymkk2Xaf5Zpol6N9i/gGe1kge
        vnLcC4JEP+kLjWnrfSw6WuIe9JpGig==
X-Google-Smtp-Source: ABdhPJzVIsTenOl5I1EkcrKrY13pbWu7/F15bcAxL598BT6P6olMExLBZKQXONdQRYOEEFJrlshoXw==
X-Received: by 2002:a05:6808:d4f:: with SMTP id w15mr885950oik.42.1644026891171;
        Fri, 04 Feb 2022 18:08:11 -0800 (PST)
Received: from robh.at.kernel.org (66-90-148-213.dyn.grandenetworks.net. [66.90.148.213])
        by smtp.gmail.com with ESMTPSA id d21sm1386738otq.68.2022.02.04.18.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 18:08:10 -0800 (PST)
Received: (nullmailer pid 3608625 invoked by uid 1000);
        Sat, 05 Feb 2022 02:08:09 -0000
Date:   Fri, 4 Feb 2022 20:08:09 -0600
From:   Rob Herring <robh@kernel.org>
To:     Sander Vanheule <sander@svanheule.net>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Birger Koblitz <mail@birger-koblitz.de>,
        Bert Vermeulen <bert@biot.com>, John Crispin <john@phrozen.org>
Subject: Re: [PATCH v3 4/6] dt-bindings: interrupt-controller:
 realtek,rtl-intc: require parents
Message-ID: <Yf3cCTB5Qbz44nc/@robh.at.kernel.org>
References: <cover.1641739718.git.sander@svanheule.net>
 <e043a9faa4a8f71efdf8b7849ec7911f16207fb0.1641739718.git.sander@svanheule.net>
 <Yes6NFgUmcIcc5mm@robh.at.kernel.org>
 <d291855a36f200b178aa9e7fb6e41ff438773e38.camel@svanheule.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d291855a36f200b178aa9e7fb6e41ff438773e38.camel@svanheule.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 22, 2022 at 01:49:44PM +0100, Sander Vanheule wrote:
> Hi Rob,
> 
> On Fri, 2022-01-21 at 16:56 -0600, Rob Herring wrote:
> > On Sun, Jan 09, 2022 at 03:54:35PM +0100, Sander Vanheule wrote:
> > > The interrupt router has 32 inputs and up to 15 outputs, and the way
> > > these are mapped to each other is runtime configurable. The outputs of
> > > this interrupt router on the other hand, are connected to a fixed set of
> > > parent interrupts. This means that "interrupt-map" is inappropriate, and
> > > rather a list of parent interrupts should be specified.
> > 
> > I'm not sure why interrupt-map is not appropriate. It is not appropriate 
> > if you have to touch the interrupt router h/w in servicing the 
> > interrupts. If you just need one time configuration of the mapping, then 
> > it should be fine to use I think.
> 
> If interrupt-map is used, then AFAICT there are no hooks to inform the driver that a
> translation has occurred. How should the interrupt controller driver then know how to set
> up the routing? Commit de4adddcbcc2 ("of/irq: Add a quirk for controllers with their own
> definition of interrupt-map") added a quirk for the original binding/driver, but that
> requires open-coding an interrupt-map parser in the driver.

The issue was not open-coding parsing, but was the need for something in 
the middle to service the interrupt. As 'interrupt-map' should be a 
transparent remapping or routing.

> 
> What this binding doesn't mention (I can add it), is that there are also two IRQ status
> registers to:
>   - unmask/mask SoC interrupts
>   - read the current status of the SoC interrupts

That would not be transparent.

> In theory, if the routing is set up correctly (and the IRQ permanently unmasked), I think
> one could treat interrupt-map as intended, and connect SoC peripheral IRQ handlers
> directly to the parent interrupts. But then the interrupt subsystem would need to check
> all attached handlers. This interrupt router/controller allows to check which peripheral
> is triggering the parent IRQ, which should be more efficient.
>
> These interrupt controllers are also used on multi-threaded systems, where each hardware
> thread has its own IRQ controller. I'm still experimenting with the implementation, but 
> there the routing registers would be used to set the CPU affinity of SoC interrupts.
> 
> I have to say that I'm not very familiar with the kernel code that handles all this
> though, so maybe I'm just missing something?

Okay, seems 'interrupt-map' is indeed not appropriate here.

Rob
