Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66FB65A9046
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234126AbiIAH1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbiIAH02 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:26:28 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 663ED3884
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 00:25:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 2B6A8CE24F2
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 07:25:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F13C433C1;
        Thu,  1 Sep 2022 07:25:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662017117;
        bh=wFBxgLE3ZKENwiyGQvZkmf0lQ+nkRd9E9wQrdKxQ/pw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nx+Vz2yadBlXqmB6mN0pWinuEwxeVrsKNBWvD2k0uXISs3cAMKJhrrCZmZEs6gu31
         hYnTLg8w3rxCg8EtPBH/PCVvX+tGAU8LPYyLD3GyyZp6vGjULev/k40TaOSbXWMr3Z
         jLUgV6aDdN4jifZ4BjpI0kHDwTQOUHe1GN1MznmfXdNVwXmk0U94fH6jjnj0MH5mPE
         uzB7AClQ26HdjHL8GdHq54asN0puEwicseuMkKbL0G7uW4KFJjk+oxddovX+FwBr4Z
         9MVTdOTJ/ATlVrqMU9Mh4fUemQ4kEtEFColcwKWqiVNxXMWxq9YhFjjdebynIygckr
         vG0iaJFB2ZrLg==
Date:   Thu, 1 Sep 2022 10:24:59 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        catalin.marinas@arm.com, ardb@kernel.org,
        guanghuifeng@linux.alibaba.com, mark.rutland@arm.com,
        will@kernel.org, linux-mm@kvack.org, thunder.leizhen@huawei.com,
        wangkefeng.wang@huawei.com, kexec@lists.infradead.org
Subject: Re: [PATCH 1/2] arm64, kdump: enforce to take 4G as the crashkernel
 low memory end
Message-ID: <YxBeS0G+F+fsBgod@kernel.org>
References: <20220828005545.94389-1-bhe@redhat.com>
 <20220828005545.94389-2-bhe@redhat.com>
 <Yw8PvF5d2uuWy6Cl@kernel.org>
 <Yw9wU/S8cP0ntR3g@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw9wU/S8cP0ntR3g@MiWiFi-R3L-srv>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 31, 2022 at 10:29:39PM +0800, Baoquan He wrote:
> On 08/31/22 at 10:37am, Mike Rapoport wrote:
> > On Sun, Aug 28, 2022 at 08:55:44AM +0800, Baoquan He wrote:
> > > 
> > > Solution:
> > > =========
> > > To fix the problem, we should always take 4G as the crashkernel low
> > > memory end in case CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 is enabled.
> > > With this, we don't need to defer the crashkernel reservation till
> > > bootmem_init() is called to set the arm64_dma_phys_limit. As long as
> > > memblock init is done, we can conclude what is the upper limit of low
> > > memory zone.
> > > 
> > > 1) both CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 are disabled or memblock_start_of_DRAM() > 4G
> > >   limit = PHYS_ADDR_MAX+1  (Corner cases)
> > 
> > Why these are corner cases? 
> > The case when CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 are disabled is the
> > simplest one because it does not require the whole dancing around
> > arm64_dma_phys_limit initialization.
> > 
> > And AFAIK, memblock_start_of_DRAM() > 4G is not uncommon on arm64, but it
> > does not matter for device DMA addressing.
> 
> Thanks for reviewing.
> 
> I could be wrong and have misunderstanding about corner case.
> 
> With my understanding, both ZONE_DMA and ZONE_DMA32 are enabled by
> default in kernel. And on distros, I believe they are on too. The both
> ZONE_DMA and ZONE_DMA32 disabled case should only exist on one specific
> product, and the memblock_start_of_DRAM() > 4G case too. At least, I
> haven't seen one in our LAB. What I thought the non generic as corner
> case could be wrong. I will change that phrasing.
> 
> mm/Kconfig:
> config ZONE_DMA
>         bool "Support DMA zone" if ARCH_HAS_ZONE_DMA_SET
>         default y if ARM64 || X86
> 
> config ZONE_DMA32
>         bool "Support DMA32 zone" if ARCH_HAS_ZONE_DMA_SET
>         depends on !X86_32
>         default y if ARM64

My point was that the cases with ZONE_DMA/DMA32 disabled or with RAM above
4G do not require detection of arm64_dma_phys_limit before reserving the
crash kernel, can use predefined constants and are simple to handle.
 
> > The actual corner cases are systems with ZONE_DMA/DMA32 and with <32 bits
> > limit for device DMA addressing (e.g RPi 4). I think the changelog should
> 
> Right, RPi4's 30bit DMA addressing device is corner case.
> 
> > mention that to use kdump on these devices user must specify
> > crashkernel=X@Y 
> 
> Makes sense. I will add words in log, and add sentences to
> mention that in code comment or some place of document.
> Thanks for advice.
> 
> > 
> > > 2) CONFIG_ZONE_DMA or CONFIG_ZONE_DMA32 are enabled:
> > >    limit = 4G  (generic case)
> > > 

...

> > > +static phys_addr_t __init crash_addr_low_max(void)
> > > +{
> > > +	phys_addr_t low_mem_mask = U32_MAX;
> > > +	phys_addr_t phys_start = memblock_start_of_DRAM();
> > > +
> > > +	if ((!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32)) ||
> > > +	     (phys_start > U32_MAX))
> > > +		low_mem_mask = PHYS_ADDR_MAX;
> > > +
> > > +	return min(low_mem_mask, memblock_end_of_DRAM() - 1) + 1;
> > 
> > Since RAM frequently starts on non-zero address the limit for systems with
> > ZONE_DMA/DMA32 should be memblock_start_of_DRAM() + 4G. There is no need to
> 
> It may not be right for memblock_start_of_DRAM(). On most of arm64
> servers I ever tested, their memblock usually starts from a higher
> address, but not zero which is like x86. E.g below memory ranges printed
> on an ampere-mtsnow-altra system, the starting addr is 0x83000000. With
> my understanding, DMA addressing bits correspond to the cpu logical
> address range devices can address. So memblock_start_of_DRAM() + 4G
> seems not right for normal system, and not right for system which
> starting physical address is above 4G. I refer to max_zone_phys() of
> arch/arm64/mm/init.c when implementing crash_addr_low_max(). Please
> correct me if I am wrong.

My understanding was that no matter where DRAM starts, the first 4G would
be accessible by 32-bit devices, but I maybe wrong as well :)

I haven't notice you used max_zone_phys() as a reference. Wouldn't it be
simpler to just call it from crash_addr_low_max():

static phys_addr_t __init crash_addr_low_max(void)
{
	return max_zone_phys(32);
}
 
-- 
Sincerely yours,
Mike.
