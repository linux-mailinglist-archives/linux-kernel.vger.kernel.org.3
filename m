Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC50C5713CC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232335AbiGLIBX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbiGLIBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:01:19 -0400
Received: from elvis.franken.de (elvis.franken.de [193.175.24.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 27EAC24958;
        Tue, 12 Jul 2022 01:01:18 -0700 (PDT)
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1oBApZ-0000Vp-00; Tue, 12 Jul 2022 10:01:17 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 41528C035A; Tue, 12 Jul 2022 09:30:01 +0200 (CEST)
Date:   Tue, 12 Jul 2022 09:30:01 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Serge Semin <fancer.lancer@gmail.com>, linux-mips@vger.kernel.org,
        gerg@kernel.org, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Fixed __debug_virt_addr_valid()
Message-ID: <20220712073001.GA6980@alpha.franken.de>
References: <20220707215237.1730283-1-f.fainelli@gmail.com>
 <20220711083848.GE6084@alpha.franken.de>
 <20220711104052.ddefbgd34xbbjykg@mobilestation>
 <20220711112740.GA12918@alpha.franken.de>
 <20220711112953.j4dwany3i77df4xe@mobilestation>
 <7fb06e9c-6405-9bee-5eda-7dbd56511e2c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7fb06e9c-6405-9bee-5eda-7dbd56511e2c@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 11, 2022 at 05:02:51PM -0700, Florian Fainelli wrote:
> On 7/11/2022 4:29 AM, Serge Semin wrote:
> > On Mon, Jul 11, 2022 at 01:27:40PM +0200, Thomas Bogendoerfer wrote:
> > > On Mon, Jul 11, 2022 at 01:40:52PM +0300, Serge Semin wrote:
> > > > On Mon, Jul 11, 2022 at 10:38:48AM +0200, Thomas Bogendoerfer wrote:
> > > > > On Thu, Jul 07, 2022 at 02:52:36PM -0700, Florian Fainelli wrote:
> > > > > > It is permissible for kernel code to call virt_to_phys() against virtual
> > > > > > addresses that are in KSEG0 or KSEG1 and we need to be dealing with both
> > > > > > types. Add a final condition that ensures that the virtual address is
> > > > > > below KSEG2.
> > > > > > 
> > > > > > Fixes: dfad83cb7193 ("MIPS: Add support for CONFIG_DEBUG_VIRTUAL")
> > > > > > Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> > > > > > ---
> > > > > >   arch/mips/mm/physaddr.c | 3 ++-
> > > > > >   1 file changed, 2 insertions(+), 1 deletion(-)
> > > > > > 
> > > > > > diff --git a/arch/mips/mm/physaddr.c b/arch/mips/mm/physaddr.c
> > > > > > index a1ced5e44951..a82f8f57a652 100644
> > > > > > --- a/arch/mips/mm/physaddr.c
> > > > > > +++ b/arch/mips/mm/physaddr.c
> > > > > > @@ -5,6 +5,7 @@
> > > > > >   #include <linux/mmdebug.h>
> > > > > >   #include <linux/mm.h>
> > > > > > +#include <asm/addrspace.h>
> > > > > >   #include <asm/sections.h>
> > > > > >   #include <asm/io.h>
> > > > > >   #include <asm/page.h>
> > > > > > @@ -30,7 +31,7 @@ static inline bool __debug_virt_addr_valid(unsigned long x)
> > > > > >   	if (x == MAX_DMA_ADDRESS)
> > > > > >   		return true;
> > > > > > -	return false;
> > > > > > +	return KSEGX(x) < KSEG2;
> > > > > >   }
> > > > > >   phys_addr_t __virt_to_phys(volatile const void *x)
> > > > > > -- 
> > > > > > 2.25.1
> > > > > 
> > > > 
> > > > > applied to mips-next.
> > > > 
> > > > Are you sure it was ready to be applied?
> > > > Link: https://lore.kernel.org/linux-mips/20220708115851.ejsooiilxcopkoei@mobilestation/
> > > 
> > 
> > > your comment sounded like optimizing, which can be done later on, so
> > > I assumed it ready.
> > 
> > What about Malta and EVA?
> 
> Sergey's comment definitively need to be addressed, and I would not see the
> point in making an incremental change to a wrong fix. Can you drop that
> patch for now? Thanks!

dropped.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
