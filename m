Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A80B512FE9
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 11:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345120AbiD1JRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 05:17:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345089AbiD1JM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 05:12:58 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CCD153E19
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 02:09:41 -0700 (PDT)
Received: from kwepemi500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KpqW961bkzGpJ0;
        Thu, 28 Apr 2022 17:07:01 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (7.193.23.242) by
 kwepemi500002.china.huawei.com (7.221.188.171) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 17:09:39 +0800
Received: from [10.174.177.238] (10.174.177.238) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 28 Apr 2022 17:09:38 +0800
Message-ID: <6c8d75a6-284d-2bac-b015-f2f59ce02ae7@huawei.com>
Date:   Thu, 28 Apr 2022 17:09:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.2
Subject: Re: Questions about folio allocation.
To:     Matthew Wilcox <willy@infradead.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <houtao1@huawei.com>, <fangwei1@huawei.com>
References: <20220424113543.456342-1-guoxuenan@huawei.com>
 <YmU2izhF0HDlgbrW@casper.infradead.org>
 <77b76283-cec5-94a8-9bfe-34ea24c55b82@huawei.com>
 <YmmyabimiAo40XeS@casper.infradead.org>
From:   Guo Xuenan <guoxuenan@huawei.com>
In-Reply-To: <YmmyabimiAo40XeS@casper.infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.238]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600004.china.huawei.com (7.193.23.242)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthew,
On 2022/4/28 5:15, Matthew Wilcox wrote:
> On Sun, Apr 24, 2022 at 09:30:26PM +0800, Guo Xuenan wrote:
>> Hmm.. sorry my expression is not rigorous enough, but i think you have got
>> it partly.
>> Read the whole file but not only 100k * 4, in most case page order is 2,
>> which means
>> that in this way of reading,the order of folio with readahead flag is 0 in
>> most case.
>>
>> [root@localhost ]# echo 4096 > /sys/block/vdb/queue/read_ahead_kb
>> [root@localhost ]# echo 4096 > /sys/block/vdb/queue/max_sectors_kb
>> [root@localhost ]# bpftrace bpf.bt  > 100K
>> [root@localhost ]# cat 100K | awk '{print $11}' | sort | uniq -c
>>      884 0
>>     55945 2
>>       1 3
>>       14 4
>>       2 5
>>       5 6
>>
>> According to the readahead code, the inital order is from current folio with
>> readahead flag,
>> may the inital order based on size of readadhead window is better?
>> (eg: ra->size big enough and considering index alignment then set the
>> order?)
> Try this patch; it should fix the problem you're seeing.  At least, it
> does in my tests.
I have tried it. It looks much better now :). it seems that
"folio order can not reach MAX_PAGECACHE_ORDER" also be solved by your
new policy of read ahead flag setting.

I trid serveral different seq-read steps. I haven't seen any problems yet.
100K-step result after applied your patch:
[root@localhost ]# cat 100K-fix | awk '{print $11}' | sort | uniq -c
    8759 2
    2192 4
    552 6
     5 7
    140 8
    4787 9
> >From 89539907eb14b0723d457e77a18cc5af5e13db8f Mon Sep 17 00:00:00 2001
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
> Date: Wed, 27 Apr 2022 17:01:28 -0400
> Subject: [PATCH] mm/readahead: Fix readahead with large folios
>
> Reading 100KB chunks from a big file (eg dd bs=100K) leads to poor
> readahead behaviour.  Studying the traces in detail, I noticed two
> problems.
>
> The first is that we were setting the readahead flag on the folio which
> contains the last byte read from the block.  This is wrong because we
> will trigger readahead at the end of the read without waiting to see
> if a subsequent read is going to use the pages we just read.  Instead,
> we need to set the readahead flag on the first folio _after_ the one
> which contains the last byte that we're reading.
>
> The second is that we were looking for the index of the folio with the
> readahead flag set to exactly match the start + size - async_size.
> If we've rounded this, either down (as previously) or up (as now),
> we'll think we hit a folio marked as readahead by a different read,
> and try to read the wrong pages.  So round the expected index to the
> order of the folio we hit.
>
> Reported-by: Guo Xuenan <guoxuenan@huawei.com>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>   mm/readahead.c | 15 +++++++++------
>   1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/mm/readahead.c b/mm/readahead.c
> index 8e3775829513..4a60cdb64262 100644
> --- a/mm/readahead.c
> +++ b/mm/readahead.c
> @@ -474,7 +474,8 @@ static inline int ra_alloc_folio(struct readahead_control *ractl, pgoff_t index,
>   
>   	if (!folio)
>   		return -ENOMEM;
> -	if (mark - index < (1UL << order))
> +	mark = round_up(mark, 1UL << order);
> +	if (index == mark)
>   		folio_set_readahead(folio);
>   	err = filemap_add_folio(ractl->mapping, folio, index, gfp);
>   	if (err)
> @@ -555,8 +556,9 @@ static void ondemand_readahead(struct readahead_control *ractl,
>   	struct file_ra_state *ra = ractl->ra;
>   	unsigned long max_pages = ra->ra_pages;
>   	unsigned long add_pages;
> -	unsigned long index = readahead_index(ractl);
> -	pgoff_t prev_index;
> +	pgoff_t index = readahead_index(ractl);
> +	pgoff_t expected, prev_index;
> +	unsigned int order = folio ? folio_order(folio) : 0;
>   
>   	/*
>   	 * If the request exceeds the readahead window, allow the read to
> @@ -575,8 +577,9 @@ static void ondemand_readahead(struct readahead_control *ractl,
>   	 * It's the expected callback index, assume sequential access.
>   	 * Ramp up sizes, and push forward the readahead window.
>   	 */
> -	if ((index == (ra->start + ra->size - ra->async_size) ||
> -	     index == (ra->start + ra->size))) {
> +	expected = round_up(ra->start + ra->size - ra->async_size,
> +			1UL << order);
> +	if (index == expected || index == (ra->start + ra->size)) {
>   		ra->start += ra->size;
>   		ra->size = get_next_ra_size(ra, max_pages);
>   		ra->async_size = ra->size;
> @@ -662,7 +665,7 @@ static void ondemand_readahead(struct readahead_control *ractl,
>   	}
>   
>   	ractl->_index = ra->start;
> -	page_cache_ra_order(ractl, ra, folio ? folio_order(folio) : 0);
> +	page_cache_ra_order(ractl, ra, order);
>   }
>   
>   void page_cache_sync_ra(struct readahead_control *ractl,
Thanks.
Guo Xuenan
