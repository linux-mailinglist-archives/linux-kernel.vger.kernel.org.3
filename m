Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07DB7538D65
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 11:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239121AbiEaJFq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 05:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230087AbiEaJFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 05:05:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A81B369C9
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 02:05:43 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LC5v46cZ8zjXD9;
        Tue, 31 May 2022 17:04:32 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 31 May 2022 17:05:40 +0800
Subject: Re: [PATCH] mm: page_isolation: use compound_nr() correctly in
 isolate_single_pageblock()
To:     Zi Yan <ziy@nvidia.com>
CC:     <linux-kernel@vger.kernel.org>,
        Qian Cai <quic_qiancai@quicinc.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, <linux-mm@kvack.org>
References: <20220531024450.2498431-1-zi.yan@sent.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <8cfbab19-8feb-796d-9951-a07fb4855433@huawei.com>
Date:   Tue, 31 May 2022 17:05:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <20220531024450.2498431-1-zi.yan@sent.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/31 10:44, Zi Yan wrote:
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

LGTM. Thanks!

Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>

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
> 

