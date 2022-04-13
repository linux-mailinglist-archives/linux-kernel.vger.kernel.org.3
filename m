Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 787474FECCD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 04:17:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231564AbiDMCTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 22:19:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbiDMCT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 22:19:29 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CC4324BFD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 19:17:09 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KdR6R34CFzfYnW;
        Wed, 13 Apr 2022 10:16:31 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 10:17:06 +0800
Subject: Re: [PATCH v2 2/9] mm/vmscan: remove unneeded can_split_huge_page
 check
To:     "ying.huang@intel.com" <ying.huang@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>
CC:     <akpm@linux-foundation.org>, <songmuchun@bytedance.com>,
        <hch@infradead.org>, <willy@infradead.org>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, Yu Zhao <yuzhao@google.com>
References: <20220409093500.10329-1-linmiaohe@huawei.com>
 <20220409093500.10329-3-linmiaohe@huawei.com>
 <YlU/h0fdE1L846Bd@localhost.localdomain>
 <7455b680-3d89-5d3e-ba0e-6e4358b114a2@huawei.com>
 <b153b758-ce11-364a-2699-753b21250508@redhat.com>
 <a90dc108e54e19cf3aa3fd21f6321afa8f194adc.camel@intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <6d66b6dd-90e0-dc21-11f8-4061a5f271ff@huawei.com>
Date:   Wed, 13 Apr 2022 10:17:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <a90dc108e54e19cf3aa3fd21f6321afa8f194adc.camel@intel.com>
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

On 2022/4/13 9:26, ying.huang@intel.com wrote:
> On Tue, 2022-04-12 at 16:59 +0200, David Hildenbrand wrote:
>> On 12.04.22 15:42, Miaohe Lin wrote:
>>> On 2022/4/12 16:59, Oscar Salvador wrote:
>>>> On Sat, Apr 09, 2022 at 05:34:53PM +0800, Miaohe Lin wrote:
>>>>> We don't need to check can_split_folio() because folio_maybe_dma_pinned()
>>>>> is checked before. It will avoid the long term pinned pages to be swapped
>>>>> out. And we can live with short term pinned pages. Without can_split_folio
>>>>> checking we can simplify the code. Also activate_locked can be changed to
>>>>> keep_locked as it's just short term pinning.
>>>>
>>>> What do you mean by "we can live with short term pinned pages"?
>>>> Does it mean that it was not pinned when we check
>>>> folio_maybe_dma_pinned() but now it is?
>>>>
>>>> To me it looks like the pinning is fluctuating and we rely on
>>>> split_folio_to_list() to see whether we succeed or not, and if not
>>>> we give it another spin in the next round?
>>>
>>> Yes. Short term pinned pages is relative to long term pinned pages and these pages won't be
>>> pinned for a noticeable time. So it's expected to split the folio successfully in the next
>>> round as the pinning is really fluctuating. Or am I miss something?
>>>
>>
>> Just so we're on the same page. folio_maybe_dma_pinned() only capture
>> FOLL_PIN, but not FOLL_GET. You can have long-term FOLL_GET right now
>> via vmsplice().
> 
> Per my original understanding, folio_maybe_dma_pinned() can be used to
> detect long-term pinned pages.  And it seems reasonable to skip the
> long-term pinned pages and try short-term pinned pages during page
> reclaiming.  But as you pointed out, vmsplice() doesn't use FOLL_PIN. 
> So if vmsplice() is expected to pin pages for long time, and we have no
> way to detect it, then we should keep can_split_folio() in the original
> code.

IIUC, even if we have no way to detect it, can_split_folio should be removed
due to:

"""
can_split_huge_page is introduced via commit b8f593cd0896 ("mm, THP, swap:
check whether THP can be split firstly") to avoid deleting the THP from
the swap cache and freeing the swap cluster when the THP cannot be split.
But since commit bd4c82c22c36 ("mm, THP, swap: delay splitting THP after
swapped out"), splitting THP is delayed until THP is swapped out. There's
no need to delete the THP from the swap cache and free the swap cluster
anymore. Thus we can remove this unneeded can_split_huge_page check now to
simplify the code logic.
"""

THP might not need to be splitted and could be freed directly after swapout.
So can_split_huge_page check here is unneeded. Or am I miss something?

Thanks!

> 
> Copying more people who have worked on long-term pinning for comments.
> 
> Best Regards,
> Huang, Ying 
> 
>> can_split_folio() is more precise then folio_maybe_dma_pinned(), but
>> both are racy as long as the page is still mapped.
>>
>>
> 
> 
> .
> 

