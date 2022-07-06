Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C136568060
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 09:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231913AbiGFHoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 03:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231922AbiGFHnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 03:43:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AD623156
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 00:43:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8C017B81B10
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 07:43:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3F2EC3411C;
        Wed,  6 Jul 2022 07:43:40 +0000 (UTC)
Date:   Wed, 6 Jul 2022 08:43:36 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     "guanghui.fgh" <guanghuifeng@linux.alibaba.com>
Cc:     Mike Rapoport <rppt@kernel.org>, Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        baolin.wang@linux.alibaba.com, akpm@linux-foundation.org,
        david@redhat.com, jianyong.wu@arm.com, james.morse@arm.com,
        quic_qiancai@quicinc.com, christophe.leroy@csgroup.eu,
        jonathan@marek.ca, mark.rutland@arm.com,
        thunder.leizhen@huawei.com, anshuman.khandual@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        geert+renesas@glider.be, linux-mm@kvack.org,
        yaohongbo@linux.alibaba.com, alikernel-developer@linux.alibaba.com
Subject: Re: [PATCH v4] arm64: mm: fix linear mem mapping access performance
 degradation
Message-ID: <YsU9KF5abYe/LHAA@arm.com>
References: <CAMj1kXEvY5QXOUrXZ7rBp9As=65uTTFRSSq+FPt-n4M2P-_VtQ@mail.gmail.com>
 <20220705095231.GB552@willie-the-truck>
 <5d044fdd-a61a-d60f-d294-89e17de37712@linux.alibaba.com>
 <20220705121115.GB1012@willie-the-truck>
 <YsRSajyMxahXe7ZS@kernel.org>
 <YsRZ8V8mQ+HM31D6@arm.com>
 <YsRfgX7FFZLxQU50@kernel.org>
 <YsRvPTORdvIwzShL@arm.com>
 <YsSi9HAOOzbPYN+w@kernel.org>
 <7bf7c5ea-16eb-b02f-8ef5-bb94c157236d@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7bf7c5ea-16eb-b02f-8ef5-bb94c157236d@linux.alibaba.com>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 10:49:43AM +0800, guanghui.fgh wrote:
> 在 2022/7/6 4:45, Mike Rapoport 写道:
> > On Tue, Jul 05, 2022 at 06:05:01PM +0100, Catalin Marinas wrote:
> > > On Tue, Jul 05, 2022 at 06:57:53PM +0300, Mike Rapoport wrote:
> > > > On Tue, Jul 05, 2022 at 04:34:09PM +0100, Catalin Marinas wrote:
> > > > > On Tue, Jul 05, 2022 at 06:02:02PM +0300, Mike Rapoport wrote:
> > > > > > +void __init remap_crashkernel(void)
> > > > > > +{
> > > > > > +#ifdef CONFIG_KEXEC_CORE
> > > > > > +	phys_addr_t start, end, size;
> > > > > > +	phys_addr_t aligned_start, aligned_end;
> > > > > > +
> > > > > > +	if (can_set_direct_map() || IS_ENABLED(CONFIG_KFENCE))
> > > > > > +	    return;
> > > > > > +
> > > > > > +	if (!crashk_res.end)
> > > > > > +	    return;
> > > > > > +
> > > > > > +	start = crashk_res.start & PAGE_MASK;
> > > > > > +	end = PAGE_ALIGN(crashk_res.end);
> > > > > > +
> > > > > > +	aligned_start = ALIGN_DOWN(crashk_res.start, PUD_SIZE);
> > > > > > +	aligned_end = ALIGN(end, PUD_SIZE);
> > > > > > +
> > > > > > +	/* Clear PUDs containing crash kernel memory */
> > > > > > +	unmap_hotplug_range(__phys_to_virt(aligned_start),
> > > > > > +			    __phys_to_virt(aligned_end), false, NULL);
> > > > > 
> > > > > What I don't understand is what happens if there's valid kernel data
> > > > > between aligned_start and crashk_res.start (or the other end of the
> > > > > range).
> > > > 
> > > > Data shouldn't go anywhere :)
> > > > 
> > > > There is
> > > > 
> > > > +	/* map area from PUD start to start of crash kernel with large pages */
> > > > +	size = start - aligned_start;
> > > > +	__create_pgd_mapping(swapper_pg_dir, aligned_start,
> > > > +			     __phys_to_virt(aligned_start),
> > > > +			     size, PAGE_KERNEL, early_pgtable_alloc, 0);
> > > > 
> > > > and
> > > > 
> > > > +	/* map area from end of crash kernel to PUD end with large pages */
> > > > +	size = aligned_end - end;
> > > > +	__create_pgd_mapping(swapper_pg_dir, end, __phys_to_virt(end),
> > > > +			     size, PAGE_KERNEL, early_pgtable_alloc, 0);
> > > > 
> > > > after the unmap, so after we tear down a part of a linear map we
> > > > immediately recreate it, just with a different page size.
> > > > 
> > > > This all happens before SMP, so there is no concurrency at that point.
> > > 
> > > That brief period of unmap worries me. The kernel text, data and stack
> > > are all in the vmalloc space but any other (memblock) allocation to this
> > > point may be in the unmapped range before and after the crashkernel
> > > reservation. The interrupts are off, so I think the only allocation and
> > > potential access that may go in this range is the page table itself. But
> > > it looks fragile to me.
> > 
> > I agree there are chances there will be an allocation from the unmapped
> > range.
> > 
> > We can make sure this won't happen, though. We can cap the memblock
> > allocations with memblock_set_current_limit(aligned_end) or
> > memblock_reserve(algined_start, aligned_end) until the mappings are
> > restored.
> 
> I think there is no need to worry about vmalloc mem.

That's not what I'm worried about. It's about memblock allocations that
are accessed through the linear map.

-- 
Catalin
