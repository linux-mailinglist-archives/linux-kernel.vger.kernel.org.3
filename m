Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9A9D589ABA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 13:02:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239494AbiHDLC2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 07:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239487AbiHDLCD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 07:02:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F2A767140
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 04:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659610899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bf5NFqYlWG+8M/s83QkTfWWc4XqYn4ElMlLfufV1apk=;
        b=DJAiTd9La53VZI0JUmTy0ZVebxZzXmzH8BwNdXLTp3JgNN9J2S1VaWcEUby4ZgbeJfkzWg
        EBAH7GFLf7B/pAQQtgneCyj6yQ29yWkGKYRwH169oz6mYMk2pRy+x+uiNrVDMahwbIgTOh
        rriUuOPhqy8t4JTvO05ZlIF28MRNf1s=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-153-FpjihNp7P5-ZcMiuHp2yLA-1; Thu, 04 Aug 2022 07:01:35 -0400
X-MC-Unique: FpjihNp7P5-ZcMiuHp2yLA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CB31D18E530C;
        Thu,  4 Aug 2022 11:01:34 +0000 (UTC)
Received: from localhost (ovpn-13-86.pek2.redhat.com [10.72.13.86])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7174B1121314;
        Thu,  4 Aug 2022 11:01:32 +0000 (UTC)
Date:   Thu, 4 Aug 2022 19:01:28 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Donnelly <john.p.donnelly@oracle.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma/pool: do not complain if DMA pool is not allocated
Message-ID: <YuunCO2lsLDWTGw+@MiWiFi-R3L-srv>
References: <20220325122559.14251-1-mhocko@kernel.org>
 <Yj28gjonUa9+0yae@dhcp22.suse.cz>
 <20220325164856.GA16800@lst.de>
 <Yj3zyLs4f+ba6UqF@dhcp22.suse.cz>
 <YupFSpXOrcfXJNya@dhcp22.suse.cz>
 <YuqNToCACD8kKBG+@MiWiFi-R3L-srv>
 <YuqOrJKcgfamdXkk@dhcp22.suse.cz>
 <YuqU87SDwP0zg+c7@MiWiFi-R3L-srv>
 <YuqX0OAItlMDfRUV@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YuqX0OAItlMDfRUV@dhcp22.suse.cz>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/03/22 at 05:44pm, Michal Hocko wrote:
> On Wed 03-08-22 23:32:03, Baoquan He wrote:
> > On 08/03/22 at 05:05pm, Michal Hocko wrote:
> > > On Wed 03-08-22 22:59:26, Baoquan He wrote:
> > > > On 08/03/22 at 11:52am, Michal Hocko wrote:
> > > > > On Fri 25-03-22 17:54:33, Michal Hocko wrote:
> > > > > > On Fri 25-03-22 17:48:56, Christoph Hellwig wrote:
> > > > > > > On Fri, Mar 25, 2022 at 01:58:42PM +0100, Michal Hocko wrote:
> > > > > > > > Dang, I have just realized that I have misread the boot log and it has
> > > > > > > > turned out that a674e48c5443 is covering my situation because the
> > > > > > > > allocation failure message says:
> > > > > > > >
> > > > > > > > Node 0 DMA free:0kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:636kB managed:0kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> > > > > > > 
> > > > > > > As in your report is from a kernel that does not have a674e48c5443
> > > > > > > yet?
> > > > > > 
> > > > > > yes. I just mixed up the early boot messages and thought that DMA zone
> > > > > > ended up with a single page. That message was saying something else
> > > > > > though.
> > > > > 
> > > > > OK, so I have another machine spewing this warning. Still on an older
> > > > > kernel but I do not think the current upstream would be any different in
> > > > > that regards. This time the DMA zone is populated and consumed from
> > > > > large part and the pool size request is just too large for it:
> > > > > 
> > > > > [   14.017417][    T1] swapper/0: page allocation failure: order:10, mode:0xcc1(GFP_KERNEL|GFP_DMA), nodemask=(null),cpuset=/,mems_allowed=0-7
> > > > > [   14.017429][    T1] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 5.14.21-150400.22-default #1 SLE15-SP4 0b6a6578ade2de5c4a0b916095dff44f76ef1704
> > > > > [   14.017434][    T1] Hardware name: XXXX
> > > > > [   14.017437][    T1] Call Trace:
> > > > > [   14.017444][    T1]  <TASK>
> > > > > [   14.017449][    T1]  dump_stack_lvl+0x45/0x57
> > > > > [   14.017469][    T1]  warn_alloc+0xfe/0x160
> > > > > [   14.017490][    T1]  __alloc_pages_slowpath.constprop.112+0xc27/0xc60
> > > > > [   14.017497][    T1]  ? rdinit_setup+0x2b/0x2b
> > > > > [   14.017509][    T1]  ? rdinit_setup+0x2b/0x2b
> > > > > [   14.017512][    T1]  __alloc_pages+0x2d5/0x320
> > > > > [   14.017517][    T1]  alloc_page_interleave+0xf/0x70
> > > > > [   14.017531][    T1]  atomic_pool_expand+0x4a/0x200
> > > > > [   14.017541][    T1]  ? rdinit_setup+0x2b/0x2b
> > > > > [   14.017544][    T1]  __dma_atomic_pool_init+0x44/0x90
> > > > > [   14.017556][    T1]  dma_atomic_pool_init+0xad/0x13f
> > > > > [   14.017560][    T1]  ? __dma_atomic_pool_init+0x90/0x90
> > > > > [   14.017562][    T1]  do_one_initcall+0x41/0x200
> > > > > [   14.017581][    T1]  kernel_init_freeable+0x236/0x298
> > > > > [   14.017589][    T1]  ? rest_init+0xd0/0xd0
> > > > > [   14.017596][    T1]  kernel_init+0x16/0x120
> > > > > [   14.017599][    T1]  ret_from_fork+0x22/0x30
> > > > > [   14.017604][    T1]  </TASK>
> > > > > [...]
> > > > > [   14.018026][    T1] Node 0 DMA free:160kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15996kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> > > > > [   14.018035][    T1] lowmem_reserve[]: 0 0 0 0 0
> > > > > [   14.018339][    T1] Node 0 DMA: 0*4kB 0*8kB 0*16kB 1*32kB (U) 0*64kB 1*128kB (U) 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 160kB
> > > > > 
> > > > > So the DMA zone has only 160kB free while the pool would like to use 4MB
> > > > > of it which obviously fails. I haven't tried to check who is consuming
> > > > > the DMA zone memory and why but this shouldn't be all that important
> > > > > because the pool clearly cannot allocate and there is not much the
> > > > > user/admin can do about that. Well, the pool could be explicitly
> > > > > requested smaller but is that really what we expect them to do?
> > > > >   
> > > > > > > > I thought there are only few pages in the managed by the DMA zone. This
> > > > > > > > is still theoretically possible so I think __GFP_NOWARN makes sense here
> > > > > > > > but it would require to change the patch description.
> > > > > > > > 
> > > > > > > > Is this really worth it?
> > > > > > > 
> > > > > > > In general I think for kernels where we need the pool and can't allocate
> > > > > > > it, a warning is very useful.  We just shouldn't spew it when there is
> > > > > > > no need for the pool to start with.
> > > > > > 
> > > > > > Well, do we have any way to find that out during early boot?
> > > > > 
> > > > > Thinking about it. We should get a warning when the actual allocation
> > > > > from the pool fails no? That would be more useful information than the
> > > > > pre-allocation failure when it is not really clear whether anybody is
> > > > > ever going to consume it.
> > > > 
> > > > Hi Michal,
> > > > 
> > > > You haven't told on which ARCH you met this issue, is it x86_64?
> > > 
> > > yes x86_64, so a small 16MB DMA zone.
> > 
> > Yeah, the 16M DMA zone is redicilous and exists only for hardly seen
> > ISA-style devices support. Haven't prepared the log well.
> 
> Agreed on that! I would essentially suggest to completely ignore pool
> pre-allocation failures for the small DMA zone. There is barely anything
> to be ever consuming it.

I would personally suggest to keep it. W/o that, we even don't know the
issue we are talking about now. I see below commit as a workaround, and
have been trying to fix it finally with a better solution.

commit c4dc63f0032c ("mm/page_alloc.c: do not warn allocation failure on zone DMA if no managed pages")

After attempts, I realize it's time to let one zone DMA or DMA32 cover
the whole low 4G memory on x86_64. That's the real fix. The tiny 16M DMA
on 64bit system is root cause.

> 
> Unfortunately generic kernels cannot really know there is any
> crippled device without some code to some checking early boot (and I am
> not even sure this would be sufficient).
> 
> > >From 0b32b4c441f9e28bbda06eefbd14c25d00924830 Mon Sep 17 00:00:00 2001
> > From: Baoquan He <bhe@redhat.com>
> > Date: Wed, 6 Jul 2022 15:26:15 +0800
> > Subject: [PATCH] x86, 64: let zone DMA cover low 4G if no ISA-style devices
> > Content-type: text/plain
> > 
> > It doesn't make sense to let the rare legacy ISA-style devies
> > drag x86_64 to have a tiny zone DMA of 16M which cause many
> > troubles.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > ---
> >  arch/x86/Kconfig   | 1 -
> >  arch/x86/mm/init.c | 5 ++++-
> >  2 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 5aa4c2ecf5c7..93af781f9445 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -2761,7 +2761,6 @@ config ISA_BUS
> >  # x86_64 have no ISA slots, but can have ISA-style DMA.
> >  config ISA_DMA_API
> >  	bool "ISA-style DMA support" if (X86_64 && EXPERT)
> > -	default y
> >  	help
> >  	  Enables ISA-style DMA support for devices requiring such controllers.
> >  	  If unsure, say Y.
> > diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> > index 82a042c03824..c9ffb38dcc6a 100644
> > --- a/arch/x86/mm/init.c
> > +++ b/arch/x86/mm/init.c
> > @@ -1024,9 +1024,12 @@ void __init zone_sizes_init(void)
> >  
> >  	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
> >  
> > -#ifdef CONFIG_ZONE_DMA
> > +#if defined(CONFIG_ZONE_DMA) && defined(CONFIG_ISA_DMA_API)
> >  	max_zone_pfns[ZONE_DMA]		= min(MAX_DMA_PFN, max_low_pfn);
> > +#else
> > +	max_zone_pfns[ZONE_DMA]		= min(MAX_DMA32_PFN, max_low_pfn);
> >  #endif
> > +
> >  #ifdef CONFIG_ZONE_DMA32
> >  	max_zone_pfns[ZONE_DMA32]	= min(MAX_DMA32_PFN, max_low_pfn);
> >  #endif
> 
> I would rather see the zone go away completley and free up the slot in
> page flags.  This seems like a hack to have two zones representing the
> same physical memory range.
> 
> This also mostly papers over this particular problem by allocating
> allocating two pools for the same range.

No, it doesn't paper over anything, and isn't a hack. Zone dma now covers
low 4G, just zone DMA32 is empty. Any allocation request with GFP_DMA will
be satisfied, while request with GFP_DMA32 will fall back to zone DMA.

See my summary about zone DMA/DMA32 on ARCHes. Currently only x86_64
always has this burdensome tiny DMA zone. Other ARCH has made adjustment
to avoid that conditionally. The way I took in above patch is similar
with arm64 handling.

The two pools for the same range has been there on arm64 and mips, we
can easily fix it by introducing has_managed_dma32() and checking it
before allocating atomic_pool_dma32 pool, just like I have done for
atomic_pool_dma there.

=============================
ARCH which has DMA32
        ZONE_DMA       ZONE_DMA32
arm64   0~X            empty or X~4G  (X is got from ACPI or DT. Otherwise it's 4G by default, DMA32 is empty)
ia64    None           0~4G
mips    empty or 0~16M X~4G  (zone DMA is empty on SGI_IP22 or SGI_IP28, otherwise 16M by default like i386)
riscv   None           0~4G
x86_64  16M            16M~4G
=============================


As for the only one DMA or DMA32 zone exist on x86_64 you suggested, I
made below draft change which only creates zone DMA32 to cover the whole
low 4G meomry, just like RISC-V and ia64 are doing. It works well on
one intel machine, no other change is required. However, I have one
concern, it possibly comes from my own misunderstanding, please help
point out where I got it wrong. If there's only DMA32 zone, and
CONFIG_ZONE_DMA is disabled, how does it handle GFP_DMA allocation
request? See gfp_zone(), it will return ZONE_NORMAL to user even though
user expects to get memory for DMA handling?

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index fb5900e2c29a..7ec4a7aec43c 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -34,6 +34,7 @@ config X86_64
 	select SWIOTLB
 	select ARCH_HAS_ELFCORE_COMPAT
 	select ZONE_DMA32
+	select ZONE_DMA if ISA_DMA_API
 
 config FORCE_DYNAMIC_FTRACE
 	def_bool y
@@ -2752,7 +2753,6 @@ config ISA_BUS
 # x86_64 have no ISA slots, but can have ISA-style DMA.
 config ISA_DMA_API
 	bool "ISA-style DMA support" if (X86_64 && EXPERT)
-	default y
 	help
 	  Enables ISA-style DMA support for devices requiring such controllers.
 	  If unsure, say Y.
diff --git a/mm/Kconfig b/mm/Kconfig
index 169e64192e48..50ad23abcb7e 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -962,7 +962,7 @@ config ARCH_HAS_ZONE_DMA_SET
 
 config ZONE_DMA
 	bool "Support DMA zone" if ARCH_HAS_ZONE_DMA_SET
-	default y if ARM64 || X86
+	default y if ARM64 || X86_32
 
 config ZONE_DMA32
 	bool "Support DMA32 zone" if ARCH_HAS_ZONE_DMA_SET

