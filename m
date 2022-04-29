Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51A08514EB1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238977AbiD2PL2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229958AbiD2PL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:11:26 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC88ED3AEF
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=mi2TSvZo2f8k0MBpdpxuDkCmKUSp6wslpH3OmUD8Npk=; b=RPRx8sqJAZRWMU7YVOMFNszmjQ
        y9R84HG9f1ZYO7Vk+JYtc5CcB7rzNE0ICJ3gvIhUeLBrrvdCPjzUE6zG5cnMMwAVAC/wyZC9XH0Jj
        EmRFZH2fzKBZaoTjyAWKS7shq3kkeaIIRivEEslTub00NBUnCdno3r7Ehednvg2iQWBWxchf+QMMz
        qAJfHaBBo6umVnZQt8UOB49KUSiRJ0jQAd7k0cXgUuoG7lLj/eVGc+H2mVk3tF4HE2/E+07RkHbWL
        uAsP5yH8E8QWJ5OTl+MB2t2X9eGhGMXVRRDq9vwX9qKnagI3kYbYM3FPkSE/yPmsgYgPJN3idHD8F
        o6ohEQ8w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:58438)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1nkSDt-0004A4-2p; Fri, 29 Apr 2022 16:07:56 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1nkSDp-00021e-0g; Fri, 29 Apr 2022 16:07:53 +0100
Date:   Fri, 29 Apr 2022 16:07:52 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH 2/2] ARM: Clamp MAX_DMA_ADDRESS to 32-bit
Message-ID: <Ymv/SIqErX3bm1bG@shell.armlinux.org.uk>
References: <20220324175417.1014562-1-f.fainelli@gmail.com>
 <20220324175417.1014562-3-f.fainelli@gmail.com>
 <CAMuHMdWyDLoOit-VYPzLXxLz6W300xpo_wrqj=Pr9sZSwk_OwQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdWyDLoOit-VYPzLXxLz6W300xpo_wrqj=Pr9sZSwk_OwQ@mail.gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 09:31:56PM +0100, Geert Uytterhoeven wrote:
> Hi Florian,
> 
> On Thu, Mar 24, 2022 at 6:54 PM Florian Fainelli <f.fainelli@gmail.com> wrote:
> > MAX_DMA_ADDRESS is a virtual address, therefore it needs to fit within a
> > 32-bit unsigned quantity. Platforms defining a DMA zone size in
> > their machine descriptor can easily overflow this quantity depending on
> > the DMA zone size and/or the PAGE_OFFSET setting.
> >
> > In most cases this is harmless, however in the case of a
> > CONFIG_DEBUG_VIRTUAL enabled, __virt_addr_valid() will be unable to
> > return that MAX_DMA_ADDRESS is valid because the value passed to that
> > function is an unsigned long which has already overflowed.
> >
> > Fixes: e377cd8221eb ("ARM: 8640/1: Add support for CONFIG_DEBUG_VIRTUAL")
> > Fixes: 2fb3ec5c9503 ("ARM: Replace platform definition of ISA_DMA_THRESHOLD/MAX_DMA_ADDRESS")
> > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> > --- a/arch/arm/include/asm/dma.h
> > +++ b/arch/arm/include/asm/dma.h
> > @@ -8,10 +8,12 @@
> >  #ifndef CONFIG_ZONE_DMA
> >  #define MAX_DMA_ADDRESS        0xffffffffUL
> >  #else
> > +#include <linux/minmax.h>
> >  #define MAX_DMA_ADDRESS        ({ \
> >         extern phys_addr_t arm_dma_zone_size; \
> >         arm_dma_zone_size && arm_dma_zone_size < (0x10000000 - PAGE_OFFSET) ? \
> 
> "arm_dma_zone_size < (0x10000000 - PAGE_OFFSET)" looks
> like an overflow-avoiding version of
> "PAGE_OFFSET + arm_dma_zone_size < 0x10000000".
> However, PAGE_OFFSET is always larger than 0x10000000,
> so "0x10000000 - PAGE_OFFSET" is a rather large number?

This, to me, looks like it should have been:

	arm_dma_zone_size && arm_dma_zone_size < (0x100000000 - PAGE_OFFSET) ? \

since that is the only thing that would make sense - it's the virtual
space remaining between PAGE_OFFSET and the top of addressable space.

However, 0x100000000 isn't correct - since the vectors live at
0xffff0000, and we have the vmalloc space etc.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
