Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1D84A4A50
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 16:18:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349408AbiAaPSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 10:18:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:57316 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236806AbiAaPSS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 10:18:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5063BB82B5A
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 15:18:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E71C340E8;
        Mon, 31 Jan 2022 15:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643642296;
        bh=jqh9uFeImzWbM0KbZKgOZo1Yc8l+UHBsUSdwaGCocK8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m+ZNvga9cydT7l+ggG8qDdIVEzv8FDMH88CJKJRG9hl5NKl9lFLx9cA2+3oPSXvJ+
         J2sq/Ovb9BBENmxjhYsNpXUdZQ166Maf6XM5FB8I2GQsl273avIwc2BlqMzmaJdaS0
         6HK3WENSKQtwfZCwPD2CcNfpqvsFSunD9US21+obJXYhi0C4mx/Cf8vW2Vu0EYI3KC
         Nyj4W9Y42rVTDjIH5gjOCI+6giT1TmKIZsoVvnwZSztIewBODGkA/zn4V+U/UrkEKq
         HpCG32c69jgnmNiPQzI03cZanLgdQxLrllW5XMwUMnzxzlGbFIM9YiQg/+ipeQb2HL
         IjgyUuy0YuUJw==
Date:   Mon, 31 Jan 2022 17:18:07 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Linux-MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <mike.rapoport@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH 07/16] tools/include: Add io.h stub
Message-ID: <Yff9r+NdshpNKRk8@kernel.org>
References: <cover.1643206612.git.karolinadrobnik@gmail.com>
 <2d9aa000afe81b45157617664134b871207c2067.1643206612.git.karolinadrobnik@gmail.com>
 <YfKngOPLeI3rQOn3@casper.infradead.org>
 <48499a57afb3d27df26b39aa4255b4ba583c1148.camel@gmail.com>
 <Yfa4WMeauvmgkQ9H@kernel.org>
 <YfbQlMyohx31FhSW@casper.infradead.org>
 <CAK8P3a1UcY7Lkm0U5igQCq2K5kpqpjVi-sW3R=JzpciS-+c-gQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a1UcY7Lkm0U5igQCq2K5kpqpjVi-sW3R=JzpciS-+c-gQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 02:30:32PM +0100, Arnd Bergmann wrote:
> On Sun, Jan 30, 2022 at 6:53 PM Matthew Wilcox <willy@infradead.org> wrote:
> 
> > Thanks for doing the sweep, Mike.
> >
> > I think I found a deeper problem which is masked due to our maze of
> > header files:
> >
> > include/asm-generic/io.h:#ifndef virt_to_phys
> > include/asm-generic/io.h:#define virt_to_phys virt_to_phys
> >
> > so there's an assumption that <asm/io.h> defines virt_to_phys().
> > You can see that in a number of architectures, eg:
> >
> > arch/alpha/include/asm/io.h:static inline unsigned long virt_to_phys(volatile void *address)
> > arch/ia64/include/asm/io.h:#define virt_to_phys virt_to_phys
> > arch/mips/include/asm/io.h:#define virt_to_phys virt_to_phys
> > arch/nios2/include/asm/io.h:#define virt_to_phys(vaddr) \
> > arch/parisc/include/asm/io.h:#define virt_to_phys(a) ((unsigned long)__pa(a))
> > arch/powerpc/include/asm/io.h:#define virt_to_phys virt_to_phys
> > arch/sh/include/asm/io.h:#define virt_to_phys(address)  ((unsigned long)(address))
> > arch/x86/include/asm/io.h:#define virt_to_phys virt_to_phys
> >
> > That's clearly not the right place to define it.  Two architectures
> > put it in asm/memory.h:
> >
> > arch/arm/include/asm/memory.h:#define virt_to_phys virt_to_phys
> > arch/arm64/include/asm/memory.h:#define virt_to_phys virt_to_phys
> >
> > then:
> >
> > arch/m68k/include/asm/virtconvert.h:#define virt_to_phys virt_to_phys
> > arch/sparc/include/asm/page_32.h:#define virt_to_phys           __pa
> > arch/sparc/include/asm/page_64.h:#define virt_to_phys __pa
> >
> > This needs to be properly sorted out, but I don't want to tell Karolina
> > that's now her job as a prerequisite for merging this patchset; that
> > would be unfair.
> >
> > Cc'ing Arnd.  This is the kind of awful mess that he loves fixing ;-)
> 
> Adding Ingo as well. I'm in the middle of getting his fast-headers tree
> to work well on a couple of other architectures, and the memory.h/page.h/io.h
> mess is one of the  tricky bits in there, both in his series and in my
> follow-ups.
> 
> What makes this bit even worse is that the architectures also not just
> inconsistent about where they put __va/__pa and
> virt_to_phys/phys_to_virt, they are also inconsistent about which of the
> two pairs is based on the other, so any way you touch it means you
> will break something, and changing it now will likely require a tricky
> rebase of Ingo's patches.

Hmm, whatever we'll do with these conversions, it will be tricky for Ingo's
tree...

> Ingo, do you happen to have patches already that could be isolated
> from your series to address this? Maybe we can add the
> linux/mm_page_address.h header first and require that each
> architecture puts these macros into asm/page_address.h.
> We need to isolate these anyway, because the page addresses
> are used in a lot of places that don't need to include any of the
> remaining headers (page.h, mm.h, memory.h, io.h) that pull in
> hundreds more.

I peeked at Ingo's tree and there is this:

commit 3426911a3f83 (headers/deps: io/arch: Move the address translation
APIs from <asm/io.h> to <asm/io_extra.h>)
(https://git.kernel.org/pub/scm/linux/kernel/git/mingo/tip.git/commit/?id=3426911a3f833930d92f3aebe349f09a513375d9)

It moves virt_to_phys and phys_to_virt on x86 to a new header.

I actually liked m68k's name for a header with virt_to_phys/phys_to_virt
definitions - virtconvert.h.

As an experiment I pulled out address translations from
arch/arm/include/memory.h to arch/arm/include/virtconvert.h, it wasn't that
bad:

 arch/arm/include/asm/dma-mapping.h |   2 +
 arch/arm/include/asm/io.h          |   1 +
 arch/arm/include/asm/memory.h      | 244 ----------------------------------
 arch/arm/include/asm/pgtable.h     |   1 +
 arch/arm/include/asm/virtconvert.h | 264 +++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/psci_smp.c         |   1 +
 6 files changed, 269 insertions(+), 244 deletions(-)

(https://git.kernel.org/rppt/linux/c/4c34ec16319fc85280aad89d7a74df845c1614fc)

>           Arnd

-- 
Sincerely yours,
Mike.
