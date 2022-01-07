Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE34348747F
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 10:07:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346365AbiAGJHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 04:07:30 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:54228 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236732AbiAGJH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 04:07:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8ABE0B80B29;
        Fri,  7 Jan 2022 09:07:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 530BFC36AE9;
        Fri,  7 Jan 2022 09:07:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1641546447;
        bh=9or8fB9iBDNbMqJttMSfPtpdXzf4lfTf59Ta4KlYzdU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O+i3cNUSjQ7b4FCqjkeZ6roH5O1voKZvt8L5WpP8J3UZOYXxsZQaPqpcLy9b+v5OD
         f8Hl9UYQkJYS7CijYpMpfaRrgDnpmccRiaX3vVkEzr9iXEwNL7vuRGFSi77OalnI68
         vxAR9cohuNWDAjlF/28VJlO3tCjTDqlKb87DIvpAAmjbkVniGtJogcBqd7k7nUew7h
         Bgmm0WuOrGrY1qgqThJH/mXQ8nh1esBQRH/8g3kxI0x1o+06hDSpsnGsCX5JwzOUZB
         +w2IJraHgSUWPwT1GnPmpXE3HN37VjneBYfcIbf7pQChxA1gNWga/taQa4LY3N9Mi2
         zky6MbNVt4sfg==
Date:   Fri, 7 Jan 2022 11:07:18 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Quentin Perret <qperret@google.com>,
        Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH v3] of/fdt: Don't worry about non-memory region overlap
 for no-map
Message-ID: <YdgCxuY0Fa99nK3I@kernel.org>
References: <20211215195354.634746-1-swboyd@chromium.org>
 <Ybt2FlgxnuNdZV68@kernel.org>
 <CAE-0n512KdseK72bf0HgV4SP7+szydap1X2jWzE1eNYP0dCBgw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n512KdseK72bf0HgV4SP7+szydap1X2jWzE1eNYP0dCBgw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06, 2022 at 02:41:50PM -0800, Stephen Boyd wrote:
> Quoting Mike Rapoport (2021-12-16 09:23:34)
> > On Wed, Dec 15, 2021 at 11:53:54AM -0800, Stephen Boyd wrote:
> > > In commit 8a5a75e5e9e5 ("of/fdt: Make sure no-map does not remove
> > > already reserved regions") we returned -EBUSY when trying to mark
> > > regions as no-map when they're in the reserved memory node. This if
> > > condition will still trigger though if the DT has a /memreserve/ that
> > > completely subsumes the no-map memory carveouts in the reserved memory
> > > node. Let's only consider this to be a problem if we're trying to mark a
> > > region as no-map and it is actually memory. If it isn't memory,
> > > presumably it was removed from the memory map via /memreserve/ and thus
> > > can't be mapped anyway.
> >
> > I don't see /memreserve/ removing memory from anywhere. What do you
> > mean here?
> 
> I mean that memory in /memreserve/ is marked as reserved via
> early_init_fdt_scan_reserved_mem() calling
> early_init_dt_reserve_memory_arch(). I failed to mention that this
> region isn't part of the memory the DT tells us exists in the /memory
> node. That's the real problem. My bootloader is trying to be helpful and
> removing a range of memory that shouldn't be mapped from the /memory
> node.

That piece is what I was missing. 
 
>  localhost ~ # hexdump /sys/firmware/devicetree/base/memory/reg
>  0000000 0000 0000 0080 0000 0000 0000 8000 0000
>  0000010 0000 0000 c080 0000 0000 0000 207f 0000
>  0000020 0000 0100 0000 0000 0000 0100 0080 0000
> 
> Another solution would be to remove 'no-map' from the reserved memory
> nodes that overlap with the /memreserve/ ranges. I'd rather not do that
> though in case the bootloader that injects the /memreserve/ and fills in
> the 'reg' property of the /memory node decides to stop doing that. It
> also doesn't really make sense that no-map would care if the region
> isn't memory to start with because the property is telling us to skip
> mapping that region of memory into the kernel's direct mapping. By
> definition if it isn't in /memory it won't be mapped anyway.
> 
> Let me reword this to be more precise. How about this?

Works for me, thanks!

Acked-by: Mike Rapoport <rppt@linux.ibm.com>
 
> ----8<----
> 
> In commit 8a5a75e5e9e5 ("of/fdt: Make sure no-map does not remove
> already reserved regions") we returned -EBUSY when trying to mark
> regions as no-map when they intersect with reserved memory. The goal was
> to find bad no-map reserved memory DT nodes that would unmap the kernel
> text/data sections.
> 
> The problem is the reserved memory check will still trigger if the DT
> has a /memreserve/ that completely subsumes the no-map memory carveouts
> in the reserved memory node _and_ that region is also not part of the
> memory reg property. For example in sc7180.dtsi we have the following
> reserved-memory and memory node:
> 
>       memory@80000000 {
>           /* We expect the bootloader to fill in the size */
>           reg = <0 0x80000000 0 0>;
>       };
> 
>       smem_mem: memory@80900000 {
>               reg = <0x0 0x80900000 0x0 0x200000>;
>               no-map;
>       };
> 
> and the memreserve filled in by the bootloader is
> 
>       /memreserve/ 0x80800000 0x400000;
> 
> while the /memory node is transformed into
> 
>       memory@80000000 {
>           /* The bootloader fills in the size, and adds another region */
>           reg = <0 0x80000000 0 0x00800000>,
> 	        <0 0x80c00000 0 0x7f200000>;
>       };
> 
> The smem region is doubly reserved via /memreserve/ and by not being
> part of the /memory reg property. This leads to the following warning
> printed at boot.
> 
>  OF: fdt: Reserved memory: failed to reserve memory for node
> 'memory@80900000': base 0x0000000080900000, size 2 MiB
> 
> Otherwise nothing really goes wrong because the smem region is not going
> to be mapped by the kernel's direct linear mapping given that it isn't
> part of the memory node. Therefore, let's only consider this to be a
> problem if we're trying to mark a region as no-map and it is actually
> memory that we're intending to keep out of the kernel's direct mapping
> but it's already been reserved.
> 
> ---8<----
> 
> > >
> > > Changes from v2 (https://lore.kernel.org/r/20211215072011.496998-1-swboyd@chromium.org):
> > >  * More details in commit text
> > >
> > > Changes from v1 (https://lore.kernel.org/r/20210520012731.3731314-1-swboyd@chromium.org):
> > >  * Use memblock_overlaps_region instead of memblock_is_region_memory()
> > >  * Add more details to commit text
> > >
> > >  drivers/of/fdt.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> > > index bdca35284ceb..c736e5bcc2f6 100644
> > > --- a/drivers/of/fdt.c
> > > +++ b/drivers/of/fdt.c
> > > @@ -482,9 +482,11 @@ static int __init early_init_dt_reserve_memory_arch(phys_addr_t base,
> > >       if (nomap) {
> > >               /*
> > >                * If the memory is already reserved (by another region), we
> > > -              * should not allow it to be marked nomap.
> > > +              * should not allow it to be marked nomap, but don't worry
> > > +              * if the region isn't memory as it won't be mapped.
> > >                */
> > > -             if (memblock_is_region_reserved(base, size))
> > > +             if (memblock_overlaps_region(&memblock.memory, base, size) &&
> > > +                 memblock_is_region_reserved(base, size))
> >
> > Apparently I'm missing something, but sc7180.dtsi has memory @80000000 and I
> > cannot find anything that calls memblock_remove() in DT processing.
> >
> > How is that memory@80900000 does not overlap with memblock.memory?
> >
> 
> There's no size filled in for the sc7180.dtsi file.

-- 
Sincerely yours,
Mike.
