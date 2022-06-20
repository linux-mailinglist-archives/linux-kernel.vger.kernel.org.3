Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD5A45518C2
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 14:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240716AbiFTMXq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 08:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237517AbiFTMXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 08:23:43 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E4C17594
        for <linux-kernel@vger.kernel.org>; Mon, 20 Jun 2022 05:23:42 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LRTHj6XgkzSgtk;
        Mon, 20 Jun 2022 20:20:17 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 20 Jun 2022 20:23:33 +0800
Subject: Re: [PATCH v2 2/3] mm/swapfile: fix possible data races of
 inuse_pages
To:     Muchun Song <songmuchun@bytedance.com>,
        "Huang, Ying" <ying.huang@intel.com>, <cai@lca.pw>
CC:     <akpm@linux-foundation.org>, <david@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
References: <20220608144031.829-1-linmiaohe@huawei.com>
 <20220608144031.829-3-linmiaohe@huawei.com>
 <87edzjrcq8.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <13414d6a-9e72-fb6c-f0a8-8b83ba0455de@huawei.com>
 <YrA8kxavqsDfH5R7@FVFYT0MHHV2J.usts.net>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <09ffac27-7fe9-0977-cb33-30433e78e662@huawei.com>
Date:   Mon, 20 Jun 2022 20:23:33 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YrA8kxavqsDfH5R7@FVFYT0MHHV2J.usts.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/20 17:23, Muchun Song wrote:
> On Mon, Jun 20, 2022 at 05:04:50PM +0800, Miaohe Lin wrote:
>> On 2022/6/20 15:54, Huang, Ying wrote:
>>> Miaohe Lin <linmiaohe@huawei.com> writes:
>>>
>>>> si->inuse_pages could still be accessed concurrently now. The plain reads
>>>> outside si->lock critical section, i.e. swap_show and si_swapinfo, which
>>>> results in data races. But these should be ok because they're just used
>>>> for showing swap info.
>>>>
>>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>>> Reviewed-by: David Hildenbrand <david@redhat.com>
>>>> ---
>>>>  mm/swapfile.c | 4 ++--
>>>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/mm/swapfile.c b/mm/swapfile.c
>>>> index d2bead7b8b70..3fa26f6971e9 100644
>>>> --- a/mm/swapfile.c
>>>> +++ b/mm/swapfile.c
>>>> @@ -2646,7 +2646,7 @@ static int swap_show(struct seq_file *swap, void *v)
>>>>  	}
>>>>  
>>>>  	bytes = si->pages << (PAGE_SHIFT - 10);
>>>> -	inuse = si->inuse_pages << (PAGE_SHIFT - 10);
>>>> +	inuse = READ_ONCE(si->inuse_pages) << (PAGE_SHIFT - 10);
>>>>  
>>>>  	file = si->swap_file;
>>>>  	len = seq_file_path(swap, file, " \t\n\\");
>>>> @@ -3265,7 +3265,7 @@ void si_swapinfo(struct sysinfo *val)
>>>>  		struct swap_info_struct *si = swap_info[type];
>>>>  
>>>>  		if ((si->flags & SWP_USED) && !(si->flags & SWP_WRITEOK))
>>>> -			nr_to_be_unused += si->inuse_pages;
>>>> +			nr_to_be_unused += READ_ONCE(si->inuse_pages);
>>>>  	}
>>>>  	val->freeswap = atomic_long_read(&nr_swap_pages) + nr_to_be_unused;
>>>>  	val->totalswap = total_swap_pages + nr_to_be_unused;
>>>
>>> READ_ONCE() should be paired with WRITE_ONCE().  So, change the writer
>>> side too?
>>
>> READ_ONCE() is used to fix the complaint of concurrent accessing to si->inuse_pages from KCSAN here.
>> The similar commit is 218209487c3d ("mm/swapfile: fix data races in try_to_unuse()"). IMHO, it's fine
> 
> I think the fix 218209487c3d is incomplete. The write side in swap_range_free() should
> also be fixed. Otherwise, IIUC, it cannot stop KCSAN complaining.

I tend to agree with you. READ_ONCE() should be paired with WRITE_ONCE() theoretically. But WRITTE_ONCE()
is ignored while the commit is introduced. Add Qian Cai for helping verify it. It's very kind of @Qian Cai
if he could tell us whether WRITTE_ONCE() is ignored deliberately.

Thanks all of you. :)

> 
>> to see a not-uptodate value of si->inuse_pages because it's just used for showing swap info. So
>> WRITE_ONCE() is not obligatory. Or am I miss something?
>>
>>>
>>> Best Regards,
>>> Huang, Ying
>>
>> Thanks!
>>
>>> .
>>>
>>
>>
> .
> 

