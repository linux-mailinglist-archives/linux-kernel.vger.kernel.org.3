Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49C805AC440
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 14:20:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbiIDMJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 08:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbiIDMJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 08:09:50 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB5AF592
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 05:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=/uFgWRNDnLHUwpze/D8mllh5qMDvnOPZ8+IocrKGwvU=; b=sebh3XlKBzWabhS3whA4EZAPGY
        2WQk8/GA5A1ipyOjoelUeH23x8dskJBP862Ku3a86HHZDAJFeFp/9LPg8HmswRaMY4Yew7GjwjzRG
        1lzT6zmraB11AgKkrZuQMYx9kP166uWGzSmRMs+y3T/9cywXlrpVXb2rpFWSUa3OynEXirUXmvUfd
        k7DpYNebhj9USlep5MVh5K0EuBN0sMvec2CfPa8UtjbfoNjpnblUsKe3S9gdj7Vmmdn2G034hjNe6
        N85Qic/2bl4RYgQtAhjHlNuN/ZQMLYw25o6jqypnfAHZss9Goj9u+YKUx/QiA/MSPPMzTeVgglU2g
        Vr+oIMow==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34090)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1oUoRc-00018R-7r; Sun, 04 Sep 2022 13:09:44 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1oUoRa-0006Ke-HG; Sun, 04 Sep 2022 13:09:42 +0100
Date:   Sun, 4 Sep 2022 13:09:42 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Marc Zyngier <maz@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/4] ARM: footbridge: cleanups
Message-ID: <YxSVhsHVsqZiAUS0@shell.armlinux.org.uk>
References: <20220818211550.3272321-1-arnd@kernel.org>
 <87wnajuzyj.wl-maz@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnajuzyj.wl-maz@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2022 at 12:43:48PM +0100, Marc Zyngier wrote:
> On Thu, 18 Aug 2022 22:15:46 +0100,
> Arnd Bergmann <arnd@kernel.org> wrote:
> > 
> > From: Arnd Bergmann <arnd@arndb.de>
> > 
> > I had an older patch to remove the addin mode for footbridge,
> > which nobody is using any more, and I found a few other small
> > cleanups that are worth doing here.
> > 
> > Footbridge is now the only platform with a custom __virt_to_bus()
> > for ISA DMA, and a custom phys_to_dma() for PCI devices. Both
> > just add a fixed offset, so there is probably a better way
> > of doing the same without a custom helper function.
> > 
> >      Arnd
> > 
> > Arnd Bergmann (4):
> >   ARM: footbridge: remove addin mode
> >   ARM: footbridge: remove leftover from personal-server
> >   ARM: footbridge: move isa-dma support into footbridge
> >   ARM: footbridge: limit CONFIG_ISA to CATS
> > 
> >  arch/arm/Kconfig                              |  5 --
> >  arch/arm/include/asm/hardware/dec21285.h      | 13 ----
> >  arch/arm/kernel/Makefile                      |  1 -
> >  arch/arm/mach-footbridge/Kconfig              | 30 +-------
> >  arch/arm/mach-footbridge/Makefile             |  5 +-
> >  arch/arm/mach-footbridge/common.c             | 73 ++-----------------
> >  arch/arm/mach-footbridge/dc21285.c            | 61 +++++-----------
> >  .../arm/{kernel => mach-footbridge}/dma-isa.c |  7 +-
> >  arch/arm/mach-footbridge/dma.c                | 58 ---------------
> >  .../mach-footbridge/include/mach/isa-dma.h    | 14 +---
> >  .../arm/mach-footbridge/include/mach/memory.h | 22 ------
> >  arch/arm/mach-footbridge/isa.c                | 14 ++--
> >  drivers/tty/serial/21285.c                    |  3 -
> >  13 files changed, 42 insertions(+), 264 deletions(-)
> >  rename arch/arm/{kernel => mach-footbridge}/dma-isa.c (98%)
> >  delete mode 100644 arch/arm/mach-footbridge/dma.c
> > 
> > -- 
> > 2.29.2
> > 
> > Cc: Russell King <linux@armlinux.org.uk>
> > Cc: Christoph Hellwig <hch@lst.de>
> > Cc: Linus Walleij <linus.walleij@linaro.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> 
> I finally managed to give this a go on my netwinder using v2 of patch
> 5/4 (!), and the box booted nicely.
> 
> Note that apart from the serial console, everything I'm using on this
> box is PCI (I tried to enable sound and failed, probably because I
> can't select CONFIG_ISA anymore on this machine).

That tends to mean, therefore, that the statement "CONFIG_ISA is for
add-in cards" is wrong, because it's caused a user-visible regression
by killing sound support on Netwinders!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
