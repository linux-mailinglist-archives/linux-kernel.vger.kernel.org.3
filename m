Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B73C56BA9D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 15:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237352AbiGHNZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 09:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbiGHNZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 09:25:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC312BB21
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 06:25:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1976FB82795
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 13:25:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA5D7C341C0;
        Fri,  8 Jul 2022 13:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657286746;
        bh=kiYtT9hLbePp8EtNY1UwK72n5vdCDWiZ8WtLVxJxT/M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=I9T9CVanXbnEkJJWhVJ9/oh217Xres+SPcuCsPe40J/JFlit80JgfOc/Hl4lSZPVE
         FSTR2G/7gstEa9PXYeABJD3HcXBI574rehwu4g89dWId7MNJq62cRnhEbuh3IG5BZH
         YL1LZQOpUIvJjbtIzxtrCUKdHQCbX85QS6mb80RcaKSHawqNlJ/RuWS82uU2OzPsE8
         iCu4Yh5IkbAzUcXzjgpvoL+MP4d3PJlrPVHocOjNZSbJABFdVqOu1hRKx6PrBbFX/m
         erqkv+EVm/eQos0EcMdvrCIiftsH6Kq2e8P76w/Tidut3Q6yqsoUbWiZX9nlhzzmwQ
         +nebJaIlE49dg==
Date:   Fri, 8 Jul 2022 14:25:40 +0100
From:   Will Deacon <will@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jann Horn <jannh@google.com>,
        Linus Torvalds <torvalds@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Dave Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>,
        Guo Ren <guoren@kernel.org>, David Miller <davem@davemloft.net>
Subject: Re: [PATCH 1/4] mmu_gather: Remove per arch tlb_{start,end}_vma()
Message-ID: <20220708132539.GA5989@willie-the-truck>
References: <20220708071802.751003711@infradead.org>
 <20220708071833.955178793@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220708071833.955178793@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 08, 2022 at 09:18:03AM +0200, Peter Zijlstra wrote:
> Scattered across the archs are 3 basic forms of tlb_{start,end}_vma().
> Provide two new MMU_GATHER_knobs to enumerate them and remove the per
> arch tlb_{start,end}_vma() implementations.
> 
>  - MMU_GATHER_NO_FLUSH_CACHE indicates the arch has flush_cache_range()
>    but does *NOT* want to call it for each VMA.
> 
>  - MMU_GATHER_MERGE_VMAS indicates the arch wants to merge the
>    invalidate across multiple VMAs if possible.
> 
> With these it is possible to capture the three forms:
> 
>   1) empty stubs;
>      select MMU_GATHER_NO_FLUSH_CACHE and MMU_GATHER_MERGE_VMAS
> 
>   2) start: flush_cache_range(), end: empty;
>      select MMU_GATHER_MERGE_VMAS
> 
>   3) start: flush_cache_range(), end: flush_tlb_range();
>      default
> 
> Obviously, if the architecture does not have flush_cache_range() then
> it also doesn't need to select MMU_GATHER_NO_FLUSH_CACHE.
> 
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/Kconfig                     |    7 +++++++
>  arch/csky/include/asm/tlb.h      |   13 -------------
>  arch/loongarch/Kconfig           |    1 +
>  arch/loongarch/include/asm/tlb.h |   10 ----------
>  arch/powerpc/Kconfig             |    1 +
>  arch/powerpc/include/asm/tlb.h   |    2 --
>  arch/s390/Kconfig                |    1 +
>  arch/s390/include/asm/tlb.h      |    3 ---
>  arch/sparc/Kconfig               |    2 ++
>  arch/sparc/include/asm/tlb_64.h  |    2 --
>  arch/x86/Kconfig                 |    1 +
>  arch/x86/include/asm/tlb.h       |    3 ---
>  include/asm-generic/tlb.h        |   21 +++++++++++++++++++--
>  13 files changed, 32 insertions(+), 35 deletions(-)
> 
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@ -438,6 +438,13 @@ config MMU_GATHER_PAGE_SIZE
>  
>  config MMU_GATHER_NO_RANGE
>  	bool
> +	select MMU_GATHER_MERGE_VMAS
> +
> +config MMU_GATHER_NO_FLUSH_CACHE
> +	bool

If this is really a sparc-special and we don't necessarily want it to
proliferate, then maybe:

	default y
	depends on SPARC

would keep it confined?

But I don't mind either way and the important bits of the patch look good:

Acked-by: Will Deacon <will@kernel.org>

Thanks,

Will
