Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64C534A384E
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 20:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355436AbiA3TAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 14:00:37 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:46722 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbiA3TAf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 14:00:35 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2E644B829A6
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 19:00:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326F0C340E4;
        Sun, 30 Jan 2022 19:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643569232;
        bh=J5VGqQOy6MMXL8J5ar+eI2vqjBOz9iohKVb1BM9GqWk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LMoMrALaOnlYPLk7kPn8+j8QUdsjt0NDubYijeeh/x71chGgfwIB8tedapUb8YnDs
         TCrvsGAJuTHcUzkHEDwWcLRZ5keYw0ZaAnJZEZ7VcXpZ19aaFuITeGnF+UilU8kq1t
         fibdXm1SJpWMAqWukPgz7546YKFQbqE0EJjrwUzmDjoDWhfTARFrER8bP2a5f4FGEA
         Fja7j0iccIi7zvRztUsWE+EptEb9pnJn/CXr3VgfD7pPt5iqFP3HCnuVAlcAXHTJfE
         pfXZMmvt98W+DBLGvIPd/+sy7h/nJkRTbiIiz2cwHKpe9PpLuxRFxXOUWxglGPwO/W
         mVhW4c92Wv6ww==
Date:   Sun, 30 Jan 2022 21:00:22 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Karolina Drobnik <karolinadrobnik@gmail.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, mike.rapoport@gmail.com,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 07/16] tools/include: Add io.h stub
Message-ID: <YfbgRm8qq7E260UY@kernel.org>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
 <2d9aa000afe81b45157617664134b871207c2067.1643206612.git.karolinadrobnik@gmail.com>
 <YfKngOPLeI3rQOn3@casper.infradead.org>
 <48499a57afb3d27df26b39aa4255b4ba583c1148.camel@gmail.com>
 <Yfa4WMeauvmgkQ9H@kernel.org>
 <YfbQlMyohx31FhSW@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YfbQlMyohx31FhSW@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 30, 2022 at 05:53:24PM +0000, Matthew Wilcox wrote:
> On Sun, Jan 30, 2022 at 06:10:00PM +0200, Mike Rapoport wrote:
> > On Fri, Jan 28, 2022 at 12:21:59PM +0100, Karolina Drobnik wrote:
> > > On Thu, 2022-01-27 at 14:09 +0000, Matthew Wilcox wrote:
> > > > On Thu, Jan 27, 2022 at 02:21:25PM +0100, Karolina Drobnik wrote:
> > > > > Add a dummy io.h header.
> > > > 
> > > > Rather begs the question of what memblock.c needs from linux/io.h.
> > > > 
> > > > Wouldn't it be better to:
> > > > 
> > > > +++ b/mm/memblock.c
> > > > @@ -18,7 +18,6 @@
> > > >  #include <linux/memblock.h>
> > > > 
> > > >  #include <asm/sections.h>
> > > > -#include <linux/io.h>
> > > > 
> > > >  #include "internal.h"
> > > > 
> > > 
> > > That was something I considered in the very beginning, but didn't have
> > > a chance to verify it works for all architectures. I can take a look
> > > after I'm finished with other v2 changes.
> > > 
> > > > (allmodconfig on x86-64 builds fine with this; I have not done an
> > > > extended sweep of other arches / build options).
> > 
> > I did a sweep for defconfigs for all arches and all were fine.
> 
> Thanks for doing the sweep, Mike.
> 
> I think I found a deeper problem which is masked due to our maze of
> header files:
> 
> include/asm-generic/io.h:#ifndef virt_to_phys
> include/asm-generic/io.h:#define virt_to_phys virt_to_phys
> 
> so there's an assumption that <asm/io.h> defines virt_to_phys().
> You can see that in a number of architectures, eg:
> 
> arch/alpha/include/asm/io.h:static inline unsigned long virt_to_phys(volatile void *address)
> arch/ia64/include/asm/io.h:#define virt_to_phys virt_to_phys
> arch/mips/include/asm/io.h:#define virt_to_phys virt_to_phys
> arch/nios2/include/asm/io.h:#define virt_to_phys(vaddr) \
> arch/parisc/include/asm/io.h:#define virt_to_phys(a) ((unsigned long)__pa(a))
> arch/powerpc/include/asm/io.h:#define virt_to_phys virt_to_phys
> arch/sh/include/asm/io.h:#define virt_to_phys(address)  ((unsigned long)(address))
> arch/x86/include/asm/io.h:#define virt_to_phys virt_to_phys
> 
> That's clearly not the right place to define it.  Two architectures
> put it in asm/memory.h:
> 
> arch/arm/include/asm/memory.h:#define virt_to_phys virt_to_phys
> arch/arm64/include/asm/memory.h:#define virt_to_phys virt_to_phys
> 
> then:
> 
> arch/m68k/include/asm/virtconvert.h:#define virt_to_phys virt_to_phys
> arch/sparc/include/asm/page_32.h:#define virt_to_phys           __pa
> arch/sparc/include/asm/page_64.h:#define virt_to_phys __pa

I'd say sparc picked the most appropriate header for it. memory.h could
also work fine, but it's only present on some arches.
I'll take a deeper look, thanks for checking this.
 
> This needs to be properly sorted out, but I don't want to tell Karolina
> that's now her job as a prerequisite for merging this patchset; that
> would be unfair.
 
Totally agree.

> Cc'ing Arnd.  This is the kind of awful mess that he loves fixing ;-)

Heh, me too :)

-- 
Sincerely yours,
Mike.
