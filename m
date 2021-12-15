Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1D87475587
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 10:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241349AbhLOJxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 04:53:17 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:48576 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233733AbhLOJxP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 04:53:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36FFA6185A
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 09:53:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BF62C34606;
        Wed, 15 Dec 2021 09:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639561994;
        bh=D4LvfZzWZu3VF+5fIyLHVl81bOeczoeqY7I+BufGvCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sGrVJFK1A6SM9nDKh4Z7YVZz4Piksmihh+vM/3KzGLlS6BuMiHZyL8Bwuei4JilJW
         ksbvg68P+QoH1MBzi3V1H+rVmNuiFp0P8iKavG1Tp2S8hFzPCbOAdLyabaeCvuDPAN
         6b2EHrkzOsdD0kduyIBhqsd1FCVl6+/4vmyMDhdPWDXTC3ThRett6djrenGARE4yZo
         tquL+U1OYiXkKXkIg2GEB/DQaC4NQbJRkozqpNsNxVaLe75BQ777dXe8UB/oeyWomL
         eTtzxTINBo9GtppHs3SPK90tXHUDwldWlrqek/UTf6fftk7DDJxdBXK3y46C5muqtW
         sabm83W6NAq/Q==
Date:   Wed, 15 Dec 2021 11:53:05 +0200
From:   Mike Rapoport <rppt@kernel.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     Jan Kiszka <jan.kiszka@siemens.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH 2/2] arm64: mm: support bootparam max_addr
Message-ID: <Ybm7AcGJaanGVwkR@kernel.org>
References: <20211215064559.2843555-1-peng.fan@oss.nxp.com>
 <20211215064559.2843555-2-peng.fan@oss.nxp.com>
 <CAMj1kXE8AQaiyHQU9k18P7dK81xhuWRmh3BhpOSP_qPnsX+sRg@mail.gmail.com>
 <DU0PR04MB94179C41295FF369E5D755D488769@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <Ybm0MWDhzkkwAZoz@kernel.org>
 <DU0PR04MB9417A1DC98221DF4EF76CA7E88769@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417A1DC98221DF4EF76CA7E88769@DU0PR04MB9417.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 09:30:36AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH 2/2] arm64: mm: support bootparam max_addr
> > 
> > On Wed, Dec 15, 2021 at 07:59:45AM +0000, Peng Fan wrote:
> > > > Subject: Re: [PATCH 2/2] arm64: mm: support bootparam max_addr
> > > >
> > > > On Wed, 15 Dec 2021 at 07:56, Peng Fan (OSS) <peng.fan@oss.nxp.com>
> > > > wrote:
> > > > >
> > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > >
> > > > > There is a "mem=[x]" boot parameter, but when there is a whole
> > > > > reserved by secure TEE, the continuous DRAM area is split with two
> > > > memblocks.
> > > > >
> > > > > For example, DRAM area [0x40000000, 0xffffffff], when TEE uses
> > > > > [0x50000000, 0x51000000), the memblock will be split into
> > > > > [0x40000000,
> > > > > 0x50000000) and [0x51000000, 0xffffffff].
> > > > >
> > > > > If pass "mem=1024MB", the actually max addr will be 0x81000000.
> > > > > However if need the max addr be 0x80000000, mem=1008MB should be
> > > > used.
> > > > >
> > > > > There also might be multiple other holes that no visible to Linux,
> > > > > when we wanna to limit the max addr usable by Linux, using
> > > > > "max_addr=[X]" is much easier than "mem=[X]"
> > > > >
> > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > >
> > > > mem= is a hack already, please don't add another one. Limiting the
> > > > memory like this is far too tricky, given that the kernel itself and
> > > > the initrd could end up in memory that is excluded, and we have to
> > > > go and fix things up if that happens.
> > >
> > > We wanna to use the reserved memory with request_mem_region, but with
> > > commit 86588296acbfb1 ("fdt: Properly handle "no-map" field in the
> > > memory region ")
> > >
> > > request_mem_region will fail, because the reserved memory are now as
> > > kernel memory.
> > 
> > request_mem_region() is for MMIO.  Why do you want to use it for RAM?
> 
> + Jan, the jailhouse hypervisor owner.
> 
> There is an out of tree driver
> https://github.com/siemens/jailhouse/blob/master/driver/main.c#L466
> 
> The hypervisor jailhouse is loaded after linux boot up, and the hypervisor
> bin file needs to be loaded into DRAM that reserved in our device
> tree with node with no map property.
> 
> And the hypervisor use virtual pci for communication between VMs,
> The virtual pci use part of the reserved DRAM area as PCI MMIO space.
> 
> Maybe I should use /memreserve, but not node with no-map property.

So, my understanding is that you need a chunk of memory that Linux does not
use and does not map into the kernel page tables.
In that case /memreserve + nomap in the device tree could be a better
solution than mem=X.
 
> Thanks,
> Peng.
> 
> > 
> > > So we use "mem=X" to work around the issue, but "mem=X" is not user
> > > friendly compared with "max_addr=" when there are multiple holes used by
> > others.
> > >
> > > Thanks,
> > > Peng.
> > >
> > > >
> > > >
> > > > > ---
> > > > >  arch/arm64/mm/init.c | 21 +++++++++++++++++++++
> > > > >  1 file changed, 21 insertions(+)
> > > > >
> > > > > diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c index
> > > > > db63cc885771..3364b5e7a7fe 100644
> > > > > --- a/arch/arm64/mm/init.c
> > > > > +++ b/arch/arm64/mm/init.c
> > > > > @@ -173,6 +173,7 @@ int pfn_is_map_memory(unsigned long pfn)
> > > > > EXPORT_SYMBOL(pfn_is_map_memory);
> > > > >
> > > > >  static phys_addr_t memory_limit __ro_after_init = PHYS_ADDR_MAX;
> > > > > +static phys_addr_t max_addr __ro_after_init = PHYS_ADDR_MAX;
> > > > >
> > > > >  /*
> > > > >   * Limit the memory size that was specified via FDT.
> > > > > @@ -189,6 +190,18 @@ static int __init early_mem(char *p)  }
> > > > > early_param("mem", early_mem);
> > > > >
> > > > > +static int __init set_max_addr(char *p) {
> > > > > +       if (!p)
> > > > > +               return 1;
> > > > > +
> > > > > +       max_addr = memparse(p, &p) & PAGE_MASK;
> > > > > +       pr_notice("Memory max addr set to 0x%llx\n", max_addr);
> > > > > +
> > > > > +       return 0;
> > > > > +}
> > > > > +early_param("max_addr", set_max_addr);
> > > > > +
> > > > >  void __init arm64_memblock_init(void)  {
> > > > >         s64 linear_region_size = PAGE_END -
> > > > > _PAGE_OFFSET(vabits_actual); @@ -253,6 +266,9 @@ void __init
> > > > arm64_memblock_init(void)
> > > > >                 memblock_add(__pa_symbol(_text), (u64)(_end -
> > > > _text));
> > > > >         }
> > > > >
> > > > > +       if (max_addr != PHYS_ADDR_MAX)
> > > > > +               memblock_cap_memory_range(0, max_addr);
> > > > > +
> > > > >         if (IS_ENABLED(CONFIG_BLK_DEV_INITRD) &&
> > phys_initrd_size)
> > > > {
> > > > >                 /*
> > > > >                  * Add back the memory we just removed if it
> > > > > results in the @@ -427,4 +443,9 @@ void dump_mem_limit(void)
> > > > >         } else {
> > > > >                 pr_emerg("Memory Limit: none\n");
> > > > >         }
> > > > > +
> > > > > +       if (max_addr != PHYS_ADDR_MAX)
> > > > > +               pr_emerg("Max addr: 0x%llx\n", max_addr);
> > > > > +       else
> > > > > +               pr_emerg("Max addr: none\n");
> > > > >  }
> > > > > --
> > > > > 2.25.1
> > > > >
> > > > >
> > > > > _______________________________________________
> > > > > linux-arm-kernel mailing list
> > > > > linux-arm-kernel@lists.infradead.org
> > > > > https://eur01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fl
> > > > > ists
> > > > > .infradead.org%2Fmailman%2Flistinfo%2Flinux-arm-kernel&amp;data=0
> > 4
> > > > > %
> > > > 7C0
> > > > >
> > > >
> > 1%7Cpeng.fan%40nxp.com%7C3ad0ef697ad64542556208d9bf9d1e1f%7C68
> > > > 6ea1d3bc
> > > > >
> > > >
> > 2b4c6fa92cd99c5c301635%7C0%7C0%7C637751503805222488%7CUnknow
> > > > n%7CTWFpbG
> > > > >
> > > >
> > Zsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6
> > > > Mn0%
> > > > >
> > > >
> > 3D%7C3000&amp;sdata=iKVO4PUPnaRr%2B5gHcXxaaRxBt%2BK%2Fjytg8eQ
> > > > dCqgqh5o%
> > > > > 3D&amp;reserved=0
> > 
> > --
> > Sincerely yours,
> > Mike.

-- 
Sincerely yours,
Mike.
