Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA25E53B455
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 09:29:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbiFBH30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 03:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbiFBH3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 03:29:24 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1BF235B2C
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 00:29:23 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LDHgK6XHczjXLQ;
        Thu,  2 Jun 2022 15:28:29 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 2 Jun 2022 15:29:20 +0800
Subject: Re: [PATCH 2/3] mm/swapfile: avoid confusing swap cache statistics
To:     David Hildenbrand <david@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220527092626.31883-1-linmiaohe@huawei.com>
 <20220527092626.31883-3-linmiaohe@huawei.com>
 <20220530160409.c9b17085adb6112d8580f37d@linux-foundation.org>
 <c7d6fec7-039d-2f54-c3b3-95deb7417a73@huawei.com>
 <33d6aec8-b4fc-aa37-27f4-f33984ea33d3@redhat.com>
 <c7d0d606-61ba-9cfc-3c2a-961a88b6c3e5@huawei.com>
 <f30cb41f-474c-91f2-4912-37387b8b3782@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <1d550b5c-1409-cb9e-5de6-476d515c9a94@huawei.com>
Date:   Thu, 2 Jun 2022 15:29:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <f30cb41f-474c-91f2-4912-37387b8b3782@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/1 15:53, David Hildenbrand wrote:
> On 01.06.22 04:11, Miaohe Lin wrote:
>> On 2022/5/31 20:58, David Hildenbrand wrote:
>>> On 31.05.22 04:55, Miaohe Lin wrote:
>>>> On 2022/5/31 7:04, Andrew Morton wrote:
>>>>> On Fri, 27 May 2022 17:26:25 +0800 Miaohe Lin <linmiaohe@huawei.com> wrote:
>>>>>
>>>>>> At swapoff time, we're going to swap in the pages continuously. So calling
>>>>>> lookup_swap_cache would confuse statistics. We should use find_get_page
>>>>>> directly here.
>>>>>
>>>>> Why is the existing behaviour wrong?  swapoff() has to swap stuff in to
>>>>> be able to release the swap device.  Why do you believe that this
>>>>> swapin activity should not be accounted?
>>>>
>>>> IMHO, statistics, e.g. swap_cache_info.find_success, are used to show the effectiveness
>>>> of the swap cache activity. So they should only reflect the memory accessing activity
>>>> of the user. I think swapoff can't reflect the effectiveness of the swap cache activity
>>>> because it just swaps in pages one by one. Or statistics should reflect all the activity
>>>> of the user including swapoff?
>>>
>>> I'm wondering who cares and why?
>>
>> I thought it's used to show the effectiveness of the swapcache readahead algorithm. If nobody
>> ever cares about it now, I'm fine to drop this patch. And could these statistics be removed
>> since nobody cares about it?
> 
> IIUC, they are printed (via show_swap_cache_info()), which is called via
> show_free_areas() -- primarily used via show_mem(). show_mem() is
> primarily used when OOM, when allocation fails and we warn, from the OOM
> killer, on panic().
> 
> I am not sure how useful for (OOM ?) debugging the find_success vs.
> find_total stats are at all. They are from ancient times. In
> bb63be0a091c ("tmpfs: move swap_state stats update") we removed other
> statistics that are "are relics of my 2.4.11 testing". Maybe
> find_success and find_total can be similarly removed.

Maybe add_total, del_total, find_success and find_total should be similarly removed altogether?
It seems those can't provide useful info when OOM occurs? And we can thus avoid touching the
swap_cache_info cacheline.

> 
> data_race() indicates to me that these stats are somewhat best-effort
> already.

At least, this patch seems unneeded.

Thanks!

> 
