Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBF84DD73B
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 10:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbiCRJmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 05:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232036AbiCRJmN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 05:42:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A1A32C3DEB
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 02:40:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B18B4B81E99
        for <linux-kernel@vger.kernel.org>; Fri, 18 Mar 2022 09:40:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD05C340E8;
        Fri, 18 Mar 2022 09:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647596452;
        bh=TzuiYSkk5oQ4xdAL+oQUIxsxcrtKWoIhuyDwqlsLKRA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:From;
        b=t5WrTJdrnp+61YR9AgCex1kzkNWoGkbFeBJsXH5Jy5FdiCHOO5841PZLDNykwl/iA
         YFu+sZf3HQvH4NSBBDXaxHhk+mGTJTvd4vCYP8tru2i5D+Ku7Ojqi+Hf/xZOl4MYH9
         Sdsce8zrk6G49l3qcCNOMUpee8R21miygD1oQuD34wkThkgsItSjf3C1+ZVkk2elgc
         +NQQCgLm5kb8SsrkAjEpHi6y6h4fz3YD/Huy27jvC/zwBWDqYzHpTeOEKa29WZjJvn
         ZDjrzlKVOuIgJ24HyigmcB229NJhwh7sXarJEY+v4IoiT5+D7goBAIMl+pfJ7FsFFZ
         Tyx36go8ni8Yw==
From:   sj@kernel.org
To:     Baolin Wang <baolin.wang@linux.alibaba.com>
Cc:     sj@kernel.org, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: Make the sampling more accurate
Date:   Fri, 18 Mar 2022 09:40:41 +0000
Message-Id: <20220318094041.26315-1-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <1647595393-103185-1-git-send-email-baolin.wang@linux.alibaba.com>
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Baolin,

On Fri, 18 Mar 2022 17:23:13 +0800 Baolin Wang <baolin.wang@linux.alibaba.com> wrote:

> When I try to sample the physical address with DAMON to migrate pages
> on tiered memory system, I found it will demote some cold regions mistakenly.
> Now we will choose an physical address in the region randomly, but if
> its corresponding page is not an online LRU page, we will ignore the
> accessing status in this cycle of sampling, and actually will be treated
> as a non-accessed region. Suppose a region including some non-LRU pages,
> it will be treated as a cold region with a high probability, and may be
> merged with adjacent cold regions, but there are some pages may be
> accessed we missed.
> 
> So instead of ignoring the access status of this region if we did not find
> a valid page according to current sampling address, we can use last valid
> sampling address to help to make the sampling more accurate, then we can do
> a better decision.

Well...  Offlined pages are also a valid part of the memory region, so treating
those as not accessed and making the memory region containing the offlined
pages looks colder seems legal to me.  IOW, this approach could make memory
regions containing many non-online-LRU pages as hot.

If I'm missing some points, please let me know.


Thanks,
SJ

> 
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---
>  include/linux/damon.h |  2 ++
>  mm/damon/core.c       |  2 ++
>  mm/damon/paddr.c      | 15 ++++++++++++---
>  3 files changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index f23cbfa..3311e15 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -38,6 +38,7 @@ struct damon_addr_range {
>   * struct damon_region - Represents a monitoring target region.
>   * @ar:			The address range of the region.
>   * @sampling_addr:	Address of the sample for the next access check.
> + * @last_sampling_addr:	Last valid address of the sampling.
>   * @nr_accesses:	Access frequency of this region.
>   * @list:		List head for siblings.
>   * @age:		Age of this region.
> @@ -50,6 +51,7 @@ struct damon_addr_range {
>  struct damon_region {
>  	struct damon_addr_range ar;
>  	unsigned long sampling_addr;
> +	unsigned long last_sampling_addr;
>  	unsigned int nr_accesses;
>  	struct list_head list;
>  
> diff --git a/mm/damon/core.c b/mm/damon/core.c
> index c1e0fed..957704f 100644
> --- a/mm/damon/core.c
> +++ b/mm/damon/core.c
> @@ -108,6 +108,7 @@ struct damon_region *damon_new_region(unsigned long start, unsigned long end)
>  	region->ar.start = start;
>  	region->ar.end = end;
>  	region->nr_accesses = 0;
> +	region->last_sampling_addr = 0;
>  	INIT_LIST_HEAD(&region->list);
>  
>  	region->age = 0;
> @@ -848,6 +849,7 @@ static void damon_split_region_at(struct damon_ctx *ctx,
>  		return;
>  
>  	r->ar.end = new->ar.start;
> +	r->last_sampling_addr = 0;
>  
>  	new->age = r->age;
>  	new->last_nr_accesses = r->last_nr_accesses;
> diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
> index 21474ae..5f15068 100644
> --- a/mm/damon/paddr.c
> +++ b/mm/damon/paddr.c
> @@ -31,10 +31,9 @@ static bool __damon_pa_mkold(struct folio *folio, struct vm_area_struct *vma,
>  	return true;
>  }
>  
> -static void damon_pa_mkold(unsigned long paddr)
> +static void damon_pa_mkold(struct page *page)
>  {
>  	struct folio *folio;
> -	struct page *page = damon_get_page(PHYS_PFN(paddr));
>  	struct rmap_walk_control rwc = {
>  		.rmap_one = __damon_pa_mkold,
>  		.anon_lock = folio_lock_anon_vma_read,
> @@ -66,9 +65,19 @@ static void damon_pa_mkold(unsigned long paddr)
>  static void __damon_pa_prepare_access_check(struct damon_ctx *ctx,
>  					    struct damon_region *r)
>  {
> +	struct page *page;
> +
>  	r->sampling_addr = damon_rand(r->ar.start, r->ar.end);
>  
> -	damon_pa_mkold(r->sampling_addr);
> +	page = damon_get_page(PHYS_PFN(r->sampling_addr));
> +	if (page) {
> +		r->last_sampling_addr = r->sampling_addr;
> +	} else if (r->last_sampling_addr) {
> +		r->sampling_addr = r->last_sampling_addr;
> +		page = damon_get_page(PHYS_PFN(r->last_sampling_addr));
> +	}
> +
> +	damon_pa_mkold(page);
>  }
>  
>  static void damon_pa_prepare_access_checks(struct damon_ctx *ctx)
> -- 
> 1.8.3.1
