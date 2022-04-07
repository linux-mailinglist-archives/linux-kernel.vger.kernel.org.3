Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9440B4F7A5D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 10:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243435AbiDGIwd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 04:52:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbiDGIwa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 04:52:30 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D25119314B
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 01:50:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EF265B826B6
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 08:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2175C385A0;
        Thu,  7 Apr 2022 08:50:26 +0000 (UTC)
Date:   Thu, 7 Apr 2022 09:50:23 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 08/10] mm/slab: Allow dynamic kmalloc() minimum alignment
Message-ID: <Yk6lz0UYyKIv5ibI@arm.com>
References: <20220405135758.774016-1-catalin.marinas@arm.com>
 <20220405135758.774016-9-catalin.marinas@arm.com>
 <Yk5endPQFHc/pB1W@ip-172-31-19-208.ap-northeast-1.compute.internal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yk5endPQFHc/pB1W@ip-172-31-19-208.ap-northeast-1.compute.internal>
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 03:46:37AM +0000, Hyeonggon Yoo wrote:
> On Tue, Apr 05, 2022 at 02:57:56PM +0100, Catalin Marinas wrote:
> > --- a/mm/slab_common.c
> > +++ b/mm/slab_common.c
> > @@ -838,9 +838,18 @@ void __init setup_kmalloc_cache_index_table(void)
> >  	}
> >  }
> >  
> > -static void __init
> > +unsigned int __weak arch_kmalloc_minalign(void)
> > +{
> > +	return ARCH_KMALLOC_MINALIGN;
> > +}
> > +
> 
> As ARCH_KMALLOC_ALIGN and arch_kmalloc_minalign() may not be same after
> patch 10, I think s/ARCH_KMALLOC_ALIGN/arch_kmalloc_minalign/g
> for every user of it would be more correct?

Not if the code currently using ARCH_KMALLOC_MINALIGN needs a constant.
Yes, there probably are a few places where the code can cope with a
dynamic arch_kmalloc_minalign() but there are two other cases where a
constant is needed:

1. As a BUILD_BUG check because the code is storing some flags in the
   bottom bits of a pointer. A smaller ARCH_KMALLOC_MINALIGN works just
   fine here.

2. As a static alignment for DMA requirements. That's where the newly
   exposed ARCH_DMA_MINALIGN should be used.

Note that this series doesn't make the situation any worse than before
since ARCH_DMA_MINALIGN stays at 128 bytes for arm64. Current users can
evolve to use a dynamic alignment in future patches. My main aim with
this series is to be able to create kmalloc-64 caches on arm64.

> > @@ -851,10 +860,17 @@ new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
> >  		flags |= SLAB_ACCOUNT;
> >  	}
> >  
> > -	kmalloc_caches[type][idx] = create_kmalloc_cache(
> > -					kmalloc_info[idx].name[type],
> > -					kmalloc_info[idx].size, flags, 0,
> > -					kmalloc_info[idx].size);
> > +	if (minalign > ARCH_KMALLOC_MINALIGN) {
> > +		aligned_size = ALIGN(aligned_size, minalign);
> > +		aligned_idx = __kmalloc_index(aligned_size, false);
> > +	}
> > +
> > +	if (!kmalloc_caches[type][aligned_idx])
> > +		kmalloc_caches[type][aligned_idx] = create_kmalloc_cache(
> > +					kmalloc_info[aligned_idx].name[type],
> > +					aligned_size, flags, 0, aligned_size);
> > +	if (idx != aligned_idx)
> > +		kmalloc_caches[type][idx] = kmalloc_caches[type][aligned_idx];
> 
> I would prefer detecting minimum kmalloc size in create_kmalloc_caches()
> in runtime instead of changing behavior of new_kmalloc_cache().

That was my initial attempt but we have a couple of
create_kmalloc_cache() (not *_caches) calls directly, one of them in
mm/slab.c kmem_cache_init(). So I wanted all the minalign logic in a
single place, hence I replaced the explicit create_kmalloc_cache() call
with new_kmalloc_cache(). See this patch and patch 9 for some clean-up.

-- 
Catalin
