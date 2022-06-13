Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D867548F70
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 18:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359097AbiFMNJR convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 13 Jun 2022 09:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357404AbiFMM6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 08:58:43 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4D962BCF;
        Mon, 13 Jun 2022 04:17:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CD648D6E;
        Mon, 13 Jun 2022 04:17:35 -0700 (PDT)
Received: from donnerap.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 332CE3F73B;
        Mon, 13 Jun 2022 04:17:33 -0700 (PDT)
Date:   Mon, 13 Jun 2022 12:17:29 +0100
From:   Andre Przywara <andre.przywara@arm.com>
To:     Samuel Holland <samuel@sholland.org>
Cc:     Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Russell King <linux@armlinux.org.uk>,
        Bartosz Dudziak <bartosz.dudziak@snejp.pl>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Luca Weiss <luca@z3ntu.xyz>, Maxime Ripard <maxime@cerno.tech>,
        Rob Herring <robh+dt@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Thierry Reding <treding@nvidia.com>,
        Vinod Koul <vkoul@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 0/3] ARM: sunxi: Remove A31 and A23/A33 platform SMP
 code
Message-ID: <20220613121729.46233a75@donnerap.cambridge.arm.com>
In-Reply-To: <2833034.e9J7NaK4W3@kista>
References: <20220531045038.42230-1-samuel@sholland.org>
        <2833034.e9J7NaK4W3@kista>
Organization: ARM
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.32; aarch64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 12 Jun 2022 23:09:07 +0200
Jernej Škrabec <jernej.skrabec@gmail.com> wrote:

Hi Samuel,

> Dne torek, 31. maj 2022 ob 06:50:35 CEST je Samuel Holland napisal(a):
> > This series is preparation for converting the PRCM MFD and legacy clock
> > drivers to a CCU clock driver.

May I ask what the purpose of this exercise is? So if I understand
correctly, then it's about to convert the sun8i-a23-prcm MFD driver and
its children to a single "modern style" CCU clock driver, with its opaque
DT node?
If that changes the compatible strings or the references to the clock
providers (and I guess it would need to?), then this would mean an
incompatible change. Which also means we would need to keep the old code
around, to maintain compatibility with "old" DTs? So what is the win then?
Now we have *two* clock drivers, for the same device, which need
maintenance and testing.

So can you confirm that this will be a breaking change?

> The platform SMP code references the PRCM
> > node to map its MMIO space, which will break when the PRCM node is
> > removed/replaced.  
> 
> Why can't we just leave old platform code? If older dtb file is used, it would 
> still work. Actually, isn't trivial to support new CCU binding too, just by 
> including new CCU compatible string? IIUC new CCU node will have same address 
> as current PRCM node.

This aims for a similar direction, though in this case the alternative
(PSCI) predates the sunxi specific method in the kernel support. Can we
just deprecate this code, maybe issue a warning, with the hint to update
the bootloader (which might not be possible for some devices)?

Cheers,
Andre

> Best regards,
> Jernej
> 
> > 
> > Since PSCI has been available for 7+ years, instead of trying to deal
> > with the migration, I think it's safe to just delete this code.
> > 
> > 
> > Samuel Holland (3):
> >   ARM: sunxi: Remove A31 and A23/A33 platform SMP code
> >   ARM: dts: sunxi: Remove obsolete CPU enable methods
> >   dt-bindings: arm: Remove obsolete CPU enable methods
> > 
> >  .../devicetree/bindings/arm/cpus.yaml         |   2 -
> >  arch/arm/boot/dts/sun6i-a31.dtsi              |   1 -
> >  arch/arm/boot/dts/sun8i-a23-a33.dtsi          |   1 -
> >  arch/arm/mach-sunxi/Makefile                  |   1 -
> >  arch/arm/mach-sunxi/platsmp.c                 | 194 ------------------
> >  5 files changed, 199 deletions(-)
> >  delete mode 100644 arch/arm/mach-sunxi/platsmp.c
> > 
> > -- 
> > 2.35.1
> > 
> >   
> 
> 
> 

