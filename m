Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42AFB4FE2F4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 15:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351066AbiDLNok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 09:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236249AbiDLNoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 09:44:37 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3884ECCE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 06:42:18 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kd6MV07y1zdZcX;
        Tue, 12 Apr 2022 21:41:42 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 12 Apr 2022 21:42:16 +0800
Subject: Re: [PATCH v2 2/9] mm/vmscan: remove unneeded can_split_huge_page
 check
To:     Oscar Salvador <osalvador@suse.de>
CC:     <akpm@linux-foundation.org>, <ying.huang@intel.com>,
        <songmuchun@bytedance.com>, <hch@infradead.org>,
        <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>
References: <20220409093500.10329-1-linmiaohe@huawei.com>
 <20220409093500.10329-3-linmiaohe@huawei.com>
 <YlU/h0fdE1L846Bd@localhost.localdomain>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <7455b680-3d89-5d3e-ba0e-6e4358b114a2@huawei.com>
Date:   Tue, 12 Apr 2022 21:42:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YlU/h0fdE1L846Bd@localhost.localdomain>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/12 16:59, Oscar Salvador wrote:
> On Sat, Apr 09, 2022 at 05:34:53PM +0800, Miaohe Lin wrote:
>> We don't need to check can_split_folio() because folio_maybe_dma_pinned()
>> is checked before. It will avoid the long term pinned pages to be swapped
>> out. And we can live with short term pinned pages. Without can_split_folio
>> checking we can simplify the code. Also activate_locked can be changed to
>> keep_locked as it's just short term pinning.
> 
> What do you mean by "we can live with short term pinned pages"?
> Does it mean that it was not pinned when we check
> folio_maybe_dma_pinned() but now it is?
> 
> To me it looks like the pinning is fluctuating and we rely on
> split_folio_to_list() to see whether we succeed or not, and if not
> we give it another spin in the next round?

Yes. Short term pinned pages is relative to long term pinned pages and these pages won't be
pinned for a noticeable time. So it's expected to split the folio successfully in the next
round as the pinning is really fluctuating. Or am I miss something?

Many thanks for your comment and reply!

> 
>> Suggested-by: Huang, Ying <ying.huang@intel.com>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/vmscan.c | 22 ++++++++--------------
>>  1 file changed, 8 insertions(+), 14 deletions(-)
>>
>> diff --git a/mm/vmscan.c b/mm/vmscan.c
>> index 4a76be47bed1..01f5db75a507 100644
>> --- a/mm/vmscan.c
>> +++ b/mm/vmscan.c
>> @@ -1711,20 +1711,14 @@ static unsigned int shrink_page_list(struct list_head *page_list,
>>  					goto keep_locked;
>>  				if (folio_maybe_dma_pinned(folio))
>>  					goto keep_locked;
>> -				if (PageTransHuge(page)) {
>> -					/* cannot split THP, skip it */
>> -					if (!can_split_folio(folio, NULL))
>> -						goto activate_locked;
>> -					/*
>> -					 * Split pages without a PMD map right
>> -					 * away. Chances are some or all of the
>> -					 * tail pages can be freed without IO.
>> -					 */
>> -					if (!folio_entire_mapcount(folio) &&
>> -					    split_folio_to_list(folio,
>> -								page_list))
>> -						goto activate_locked;
>> -				}
>> +				/*
>> +				 * Split pages without a PMD map right
>> +				 * away. Chances are some or all of the
>> +				 * tail pages can be freed without IO.
>> +				 */
>> +				if (PageTransHuge(page) && !folio_entire_mapcount(folio) &&
>> +				    split_folio_to_list(folio, page_list))
>> +					goto keep_locked;
>>  				if (!add_to_swap(page)) {
>>  					if (!PageTransHuge(page))
>>  						goto activate_locked_split;
>> -- 
>> 2.23.0
>>
>>
> 

