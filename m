Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5C12536854
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 23:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354686AbiE0VBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 17:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230491AbiE0VBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 17:01:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 499201EAEB
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 14:01:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D38F76027A
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 21:01:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5164C385A9;
        Fri, 27 May 2022 21:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653685290;
        bh=b1REJzW0O2tqVTt711WSZgo7eiYCCpX58Hv7sbbE0tw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oExo7SPI3jcDj+dU4oC3F5/k6QyytX+pQIzjuetvwOUlqQ3ZABt6GEieb82uXewIY
         RSwGyx1DW+jLmQp2kN2npOCaCyMzuOhTvAguW9DOV5/X5s1cn+DE5jX1wlhCoZ6k9F
         LbuwtHdUSj0IIjGzk0u+2vw/ycIZjlj5nfo7seiUS7+fcklWBByWq5QmI5mCxSZOfa
         qek1J+nvnNCNFFdTNNavebjSw1fhqUeWZ9cGvLe4U3vSJXNiUnwL6nC2Mo8eItmXKy
         BvzsG4gzDHIF4QbQKanLB+lYuuJGPj2Pq3gmZvNRkOQ2o+r8+kgMGWh+cY9arr6+//
         5DKv08hjwFyMw==
Date:   Fri, 27 May 2022 15:01:27 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Tony Battersby <tonyb@cybernetics.com>
Cc:     kernel-team@fb.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org
Subject: Re: [PATCH 0/2] dmapool performance enhancements
Message-ID: <YpE8Jx3cBwgXJnRc@kbusch-mbp.dhcp.thefacebook.com>
References: <20220428202714.17630-1-kbusch@kernel.org>
 <156da4ae-20de-a40f-5173-3b02c779b43c@cybernetics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <156da4ae-20de-a40f-5173-3b02c779b43c@cybernetics.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 27, 2022 at 03:35:47PM -0400, Tony Battersby wrote:
> I posted a similar patch series back in 2018:
> 
> https://lore.kernel.org/linux-mm/73ec1f52-d758-05df-fb6a-41d269e910d0@cybernetics.com/
> https://lore.kernel.org/linux-mm/15ff502d-d840-1003-6c45-bc17f0d81262@cybernetics.com/
> https://lore.kernel.org/linux-mm/1288e597-a67a-25b3-b7c6-db883ca67a25@cybernetics.com/
> 
> 
> I initially used a red-black tree keyed by the DMA address, but then for
> v2 of the patchset I put the dma pool info directly into struct page and
> used virt_to_page() to get at it.  But it turned out that was a bad idea
> because not all architectures have struct page backing
> dma_alloc_coherent():
> 
> https://lore.kernel.org/linux-kernel/20181206013054.GI6707@atomide.com/
> 
> I intended to go back and resubmit the red-black tree version, but I was
> too busy at the time and forgot about it.  A few days ago I finally
> decided to update the patches and submit them upstream.  I found your
> recent dmapool xarray patches by searching the mailing list archive to
> see if anyone else was working on something similar.
> 
> Using the following as a benchmark:
> 
> modprobe mpt3sas
> drivers/scsi/mpt3sas/mpt3sas_base.c
> _base_allocate_chain_dma_pool
> loop dma_pool_alloc(ioc->chain_dma_pool)
> 
> rmmod mpt3sas
> drivers/scsi/mpt3sas/mpt3sas_base.c
> _base_release_memory_pools()
> loop dma_pool_free(ioc->chain_dma_pool)
> 
> Here are the benchmark results showing the speedup from the patchsets:
> 
>         modprobe  rmmod
> orig          1x     1x
> xarray      5.2x   186x
> rbtree      9.3x   269x
> 
> It looks like my red-black tree version is faster than the v1 of the
> xarray patch on this benchmark at least, although the mpt3sas usage of
> dmapool is hardly typical.  I will try to get some testing done on my
> patchset and post it next week.

Thanks for the info.

Just comparing with xarray, I actually found that the list was still faster
until you get >100 pages in the pool, after which xarray becomes the clear
winner.

But it turns out I don't often see that many pages allocated for a lot of real
use cases, so I'm trying to take this in a different direction by replacing the
lookup structures with an intrusive stack. That is safe to do since pages are
never freed for the lifetime of the pool, and it's by far faster than anything
else. The downside is that I'd need to increase the size of the smallest
allowable pool block, but I think that's okay.

Anyway I was planning to post this new idea soon. My reasons for wanting a
faster dma pool are still in the works, though, so I'm just trying to sort out
those patches before returning to this one.
