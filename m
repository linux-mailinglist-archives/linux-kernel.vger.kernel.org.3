Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC715389E5
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 04:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243567AbiEaCWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 22:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243563AbiEaCWV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 22:22:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 075309345C
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 19:22:19 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F95A23A;
        Mon, 30 May 2022 19:22:19 -0700 (PDT)
Received: from [10.162.41.9] (unknown [10.162.41.9])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0DEAE3F66F;
        Mon, 30 May 2022 19:22:17 -0700 (PDT)
Message-ID: <c5f061b3-880c-3639-28dc-f478fe2dabb9@arm.com>
Date:   Tue, 31 May 2022 07:52:14 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC] mm/page_isolation: Fix an infinite loop in
 isolate_single_pageblock()
Content-Language: en-US
To:     Zi Yan <ziy@nvidia.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20220530115027.123341-1-anshuman.khandual@arm.com>
 <A4E55027-14D4-48ED-9986-3739CEDD7327@nvidia.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <A4E55027-14D4-48ED-9986-3739CEDD7327@nvidia.com>
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



On 5/30/22 19:23, Zi Yan wrote:
> On 30 May 2022, at 7:50, Anshuman Khandual wrote:
> 
>> HugeTLB allocation (32MB pages on 4K base page) via sysfs on arm64 platform
>> is getting stuck in isolate_single_pageblock(), because of an infinite loop
>> Because head_pfn always evaluate the same, so does pfn, and the outer loop
>> never exits. Dropping the relevant code block, which seems redundant, makes
>> the problem go away.
> 
> Thanks for the report.
> 
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Fixes: b2c9e2fbba32 ("mm: make alloc_contig_range work at pageblock granularity")
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> I am not sure about this fix, and also did not find much time today to
>> debug any further. There are much code changes around this function in
>> recent days. This problem is present on latest mainline kernel.
>>
>> - Anshuman
>>
>>  mm/page_isolation.c | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
>> index 6021f8444b5a..b0922fee75c1 100644
>> --- a/mm/page_isolation.c
>> +++ b/mm/page_isolation.c
>> @@ -389,10 +389,6 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
>>  			struct page *head = compound_head(page);
>>  			unsigned long head_pfn = page_to_pfn(head);
>>
>> -			if (head_pfn + nr_pages <= boundary_pfn) {
>> -				pfn = head_pfn + nr_pages;
>> -				continue;
>> -			}
>>  #if defined CONFIG_COMPACTION || defined CONFIG_CMA
>>  			/*
>>  			 * hugetlb, lru compound (THP), and movable compound pages
>> -- 
>> 2.20.1
> 
> Can you try the patch below to see if it fixes the issue? Thanks.
> 
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index 6021f8444b5a..d200d41ad0d3 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -385,9 +385,9 @@ static int isolate_single_pageblock(unsigned long boundary_pfn, int flags,
>                  * above do the rest. If migration is not possible, just fail.
>                  */
>                 if (PageCompound(page)) {
> -                       unsigned long nr_pages = compound_nr(page);
>                         struct page *head = compound_head(page);
>                         unsigned long head_pfn = page_to_pfn(head);
> +                       unsigned long nr_pages = compound_nr(head);
> 
>                         if (head_pfn + nr_pages <= boundary_pfn) {
>                                 pfn = head_pfn + nr_pages;
> 
> 

Yes, this does solve the problem. I guess nr_pages should have been derived
from the compound head itself for it be meaningful (i.e > 1). I assume you
will send a fix patch with appropriate write up that describes this problem.

- Anshuman
