Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5E2B538A1C
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 05:12:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238988AbiEaDM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 23:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbiEaDMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 23:12:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C7367369DB
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 20:12:21 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7FD9F23A;
        Mon, 30 May 2022 20:12:21 -0700 (PDT)
Received: from [10.162.41.9] (unknown [10.162.41.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07A1B3F66F;
        Mon, 30 May 2022 20:12:17 -0700 (PDT)
Message-ID: <2455da92-6522-6842-6c9c-c153e97d6e27@arm.com>
Date:   Tue, 31 May 2022 08:42:15 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mm: page_isolation: use compound_nr() correctly in
 isolate_single_pageblock()
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org, Qian Cai <quic_qiancai@quicinc.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20220531024450.2498431-1-zi.yan@sent.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220531024450.2498431-1-zi.yan@sent.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/31/22 08:14, Zi Yan wrote:
> From: Zi Yan <ziy@nvidia.com>
> 
> When compound_nr(page) was used, page was not guaranteed to be the head
> of the compound page and it could cause an infinite loop. Fix it by calling
> it on the head page.
> 
> Fixes: b2c9e2fbba32 ("mm: make alloc_contig_range work at pageblock granularity")
> Reported-by: Anshuman Khandual <anshuman.khandual@arm.com>
> Link: https://lore.kernel.org/linux-mm/20220530115027.123341-1-anshuman.khandual@arm.com/
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  mm/page_isolation.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 6021f8444b5a..d200d41ad0d3 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -385,9 +385,9 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
>  		 * above do the rest. If migration is not possible, just fail.
>  		 */
>  		if (PageCompound(page)) {
> -			unsigned long nr_pages = compound_nr(page);
>  			struct page *head = compound_head(page);
>  			unsigned long head_pfn = page_to_pfn(head);
> +			unsigned long nr_pages = compound_nr(head);
>  
>  			if (head_pfn + nr_pages <= boundary_pfn) {
>  				pfn = head_pfn + nr_pages;
