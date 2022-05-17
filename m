Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63EC6529614
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 02:33:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234002AbiEQAd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 20:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbiEQAdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 20:33:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7389924F33
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:33:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39FA6B816AA
        for <linux-kernel@vger.kernel.org>; Tue, 17 May 2022 00:33:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0A1FC385AA;
        Tue, 17 May 2022 00:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1652747602;
        bh=0pM6ajRonXAd36beDn0bSIZ5S34lHL+3SAO1ZfDWDBY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YJUHs/Tzpopnj0FkV/p0abeft/SHtGlPtnE3cUHAfI7TfoCxowJ8pQbbVtIbkUi0S
         lNmZCxe/TRSTUEg9ZN3CaJfh/0II+hvE0DulkxwHOFsRRoqdtUtlmgQ8lruX3eZixN
         KW2cJLcVEv4sej5IJf1xo5FAKcuwUVvSiYvyvtSk=
Date:   Mon, 16 May 2022 17:33:21 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Jaewon Kim <jaewon31.kim@samsung.com>
Cc:     vbabka@suse.cz, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        jaewon31.kim@gmail.com, Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Mike Rapoport <rppt@linux.ibm.com>
Subject: Re: [RFC PATCH] page_ext: create page extension for all memblock
 memory regions
Message-Id: <20220516173321.67402b7f09eacc43d4e476f4@linux-foundation.org>
In-Reply-To: <20220509074330.4822-1-jaewon31.kim@samsung.com>
References: <CGME20220509073953epcas1p127f2d36186316642068c92c5d9dee1c4@epcas1p1.samsung.com>
        <20220509074330.4822-1-jaewon31.kim@samsung.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  9 May 2022 16:43:30 +0900 Jaewon Kim <jaewon31.kim@samsung.com> wrote:

> The page extension can be prepared for each section. But if the first
> page is not valid, the page extension for the section was not
> initialized though there were many other valid pages within the section.
> 
> To support the page extension for all sections, refer to memblock memory
> regions. If the page is valid use the nid from pfn_to_nid, otherwise use
> the previous nid.
> 
> Also this pagech changed log to include total sections and a section
> size.
> 
> i.e.
> allocated 100663296 bytes of page_ext for 64 sections (1 section : 0x8000000)

Cc Joonsoo, who wrote this code.
Cc Mike, for memblock.

Thanks.

> 
> diff --git a/mm/page_ext.c b/mm/page_ext.c
> index 2e66d934d63f..506d58b36a1d 100644
> --- a/mm/page_ext.c
> +++ b/mm/page_ext.c
> @@ -381,41 +381,43 @@ static int __meminit page_ext_callback(struct notifier_block *self,
>  void __init page_ext_init(void)
>  {
>  	unsigned long pfn;
> -	int nid;
> +	int nid = 0;
> +	struct memblock_region *rgn;
> +	int nr_section = 0;
> +	unsigned long next_section_pfn = 0;
>  
>  	if (!invoke_need_callbacks())
>  		return;
>  
> -	for_each_node_state(nid, N_MEMORY) {
> +	/*
> +	 * iterate each memblock memory region and do not skip a section having
> +	 * !pfn_valid(pfn)
> +	 */
> +	for_each_mem_region(rgn) {
>  		unsigned long start_pfn, end_pfn;
>  
> -		start_pfn = node_start_pfn(nid);
> -		end_pfn = node_end_pfn(nid);
> -		/*
> -		 * start_pfn and end_pfn may not be aligned to SECTION and the
> -		 * page->flags of out of node pages are not initialized.  So we
> -		 * scan [start_pfn, the biggest section's pfn < end_pfn) here.
> -		 */
> +		start_pfn = (unsigned long)(rgn->base >> PAGE_SHIFT);
> +		end_pfn = start_pfn + (unsigned long)(rgn->size >> PAGE_SHIFT);
> +
> +		if (start_pfn < next_section_pfn)
> +			start_pfn = next_section_pfn;
> +
>  		for (pfn = start_pfn; pfn < end_pfn;
>  			pfn = ALIGN(pfn + 1, PAGES_PER_SECTION)) {
>  
> -			if (!pfn_valid(pfn))
> -				continue;
> -			/*
> -			 * Nodes's pfns can be overlapping.
> -			 * We know some arch can have a nodes layout such as
> -			 * -------------pfn-------------->
> -			 * N0 | N1 | N2 | N0 | N1 | N2|....
> -			 */
> -			if (pfn_to_nid(pfn) != nid)
> -				continue;
> +			if (pfn_valid(pfn))
> +				nid = pfn_to_nid(pfn);
> +			nr_section++;
>  			if (init_section_page_ext(pfn, nid))
>  				goto oom;
>  			cond_resched();
>  		}
> +		next_section_pfn = pfn;
>  	}
> +
>  	hotplug_memory_notifier(page_ext_callback, 0);
> -	pr_info("allocated %ld bytes of page_ext\n", total_usage);
> +	pr_info("allocated %ld bytes of page_ext for %d sections (1 section : 0x%x)\n",
> +		total_usage, nr_section, (1 << SECTION_SIZE_BITS));
>  	invoke_init_callbacks();
>  	return;
>  
> -- 
> 2.17.1
> 
