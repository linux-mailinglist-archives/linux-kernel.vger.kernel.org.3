Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD73503395
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229980AbiDPCgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 22:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbiDPCgh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 22:36:37 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378C064BC6
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 19:34:05 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KgHJS5QV8zFprd;
        Sat, 16 Apr 2022 10:31:36 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 16 Apr 2022 10:34:03 +0800
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
 <4b47e6317aca3deeabf610a7f4839563ff2b25a1.camel@intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <70b64476-6efc-c8ad-9cf3-b101c3b92db1@huawei.com>
Date:   Sat, 16 Apr 2022 10:34:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <4b47e6317aca3deeabf610a7f4839563ff2b25a1.camel@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/4/15 11:07, ying.huang@intel.com wrote:
> On Wed, 2022-04-13 at 09:26 +0800, ying.huang@intel.com wrote:
>> On Tue, 2022-04-12 at 16:59 +0200, David Hildenbrand wrote:
>>> On 12.04.22 15:42, Miaohe Lin wrote:
>>>> On 2022/4/12 16:59, Oscar Salvador wrote:
>>>>> On Sat, Apr 09, 2022 at 05:34:53PM +0800, Miaohe Lin wrote:
>>>>>> We don't need to check can_split_folio() because folio_maybe_dma_pinned()
>>>>>> is checked before. It will avoid the long term pinned pages to be swapped
>>>>>> out. And we can live with short term pinned pages. Without can_split_folio
>>>>>> checking we can simplify the code. Also activate_locked can be changed to
>>>>>> keep_locked as it's just short term pinning.
>>>>>
>>>>> What do you mean by "we can live with short term pinned pages"?
>>>>> Does it mean that it was not pinned when we check
>>>>> folio_maybe_dma_pinned() but now it is?
>>>>>
>>>>> To me it looks like the pinning is fluctuating and we rely on
>>>>> split_folio_to_list() to see whether we succeed or not, and if not
>>>>> we give it another spin in the next round?
>>>>
>>>> Yes. Short term pinned pages is relative to long term pinned pages and these pages won't be
>>>> pinned for a noticeable time. So it's expected to split the folio successfully in the next
>>>> round as the pinning is really fluctuating. Or am I miss something?
>>>>
>>>
>>> Just so we're on the same page. folio_maybe_dma_pinned() only capture
>>> FOLL_PIN, but not FOLL_GET. You can have long-term FOLL_GET right now
>>> via vmsplice().
>>
>> Per my original understanding, folio_maybe_dma_pinned() can be used to
>> detect long-term pinned pages.  And it seems reasonable to skip the
>> long-term pinned pages and try short-term pinned pages during page
>> reclaiming.  But as you pointed out, vmsplice() doesn't use FOLL_PIN. 
>> So if vmsplice() is expected to pin pages for long time, and we have no
>> way to detect it, then we should keep can_split_folio() in the original
>> code.
>>
>> Copying more people who have worked on long-term pinning for comments.
> 
> Checked the discussion in the following thread,
> 
> https://lore.kernel.org/lkml/CA+CK2bBffHBxjmb9jmSKacm0fJMinyt3Nhk8Nx6iudcQSj80_w@mail.gmail.com/
> 
> It seems that from the practical point of view, folio_maybe_dma_pinned()
> can identify most long-term pinned pages that may block memory hot-
> remove or CMA allocation.  Although as David pointed out, some pages may
> still be GUPed for long time (e.g. via vmsplice) even if
> !folio_maybe_dma_pinned().
> 
> But from another point of view, can_split_huge_page() is cheap and THP
> swapout is expensive (swap space, disk IO, and hard to be recovered), so
> it may be better to keep can_split_huge_page() in shink_page_list().

Many thanks for your explanation. Looks convincing for me. Is it worth a comment about the above
stuff? Anyway, will drop this patch. Thanks!

> 
> Best Regards,
> Huang, Ying
> 
>>
>>> can_split_folio() is more precise then folio_maybe_dma_pinned(), but
>>> both are racy as long as the page is still mapped.
>>>
>>>
>>
> 
> 
> .
> 

