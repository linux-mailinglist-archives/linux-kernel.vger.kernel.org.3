Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23927568A39
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 15:55:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbiGFNz2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 09:55:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbiGFNzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 09:55:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEAD167F3
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 06:55:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCD9461E0E
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 13:55:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8302C341C6;
        Wed,  6 Jul 2022 13:55:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657115719;
        bh=chjnoUBXSjl9JzqqfrrQq5p7sRD4jQ62lOkwa0E9GUE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sxMhdGf3B+hvmos8wNx5iTlr9a3BNfOUSpUfoyNrQ8yV/RBfmS1EzCXxLGxPHt35I
         Xq8Ism7l3Le+7xQTuSxyqEfakE/dhEF0+ADuEw8/P9Tgk9qTknU6ySJBo006jXB4JF
         ChWE56v7LdIRjX0EtODF1t2H3ipxBVG3R8W1R3m93sm12QvxpaGbl0MPlpIx6L2lGt
         iU+XSfLNEvLN1kS56KDQXUTXk8ZEOXff+XdAimaMMLIbhb9eM5AUAu6H5b+cNgM9xr
         VAtvQzy3CyQcY1ynzuM5/rJHSSGsakFelQfEI74csXh3I1CFNMLHqQEsheaLop972K
         S3q1BjHWxVyBA==
Date:   Wed, 6 Jul 2022 16:54:54 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        "guanghui.fgh" <guanghuifeng@linux.alibaba.com>,
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
Message-ID: <YsWULnvZZxoHtyRo@kernel.org>
References: <CAMj1kXEvY5QXOUrXZ7rBp9As=65uTTFRSSq+FPt-n4M2P-_VtQ@mail.gmail.com>
 <20220705095231.GB552@willie-the-truck>
 <5d044fdd-a61a-d60f-d294-89e17de37712@linux.alibaba.com>
 <20220705121115.GB1012@willie-the-truck>
 <YsRSajyMxahXe7ZS@kernel.org>
 <YsRZ8V8mQ+HM31D6@arm.com>
 <YsRfgX7FFZLxQU50@kernel.org>
 <YsRvPTORdvIwzShL@arm.com>
 <YsSi9HAOOzbPYN+w@kernel.org>
 <YsVeKPzaO0SJdwFW@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsVeKPzaO0SJdwFW@arm.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 06, 2022 at 11:04:24AM +0100, Catalin Marinas wrote:
> On Tue, Jul 05, 2022 at 11:45:40PM +0300, Mike Rapoport wrote:
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
> We can reserve the region just before unmapping to avoid new allocations
> for the page tables but we can't do much about pages already allocated
> prior to calling remap_crashkernel().

Right, this was bothering me too after I re-read you previous email.

One thing I can think of is to only remap the crash kernel memory if it is
a part of an allocation that exactly fits into one ore more PUDs.

Say, in reserve_crashkernel() we try the memblock_phys_alloc() with
PUD_SIZE as alignment and size rounded up to PUD_SIZE. If this allocation
succeeds, we remap the entire area that now contains only memory allocated
in reserve_crashkernel() and free the extra memory after remapping is done.
If the large allocation fails, we fall back to the original size and
alignment and don't allow unmapping crash kernel memory in
arch_kexec_protect_crashkres().
 
> -- 
> Catalin

-- 
Sincerely yours,
Mike.
