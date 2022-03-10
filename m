Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BD84D47A1
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 14:04:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242267AbiCJNF3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 08:05:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237582AbiCJNF2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 08:05:28 -0500
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2BFF9569
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 05:04:26 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KDq062GhNz1GCDj;
        Thu, 10 Mar 2022 20:59:34 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 10 Mar 2022 21:04:24 +0800
Subject: Re: [PATCH RFC] mm/memory-failure.c: fix memory failure race with
 memory offline
To:     David Hildenbrand <david@redhat.com>, <naoya.horiguchi@nec.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Oscar Salvador <osalvador@suse.de>
References: <20220226094034.23938-1-linmiaohe@huawei.com>
 <4307e915-ac24-58bc-23ad-7e94e2b37170@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <dee60691-3873-ac7b-021e-d4eb73d494cc@huawei.com>
Date:   Thu, 10 Mar 2022 21:04:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <4307e915-ac24-58bc-23ad-7e94e2b37170@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/1 17:53, David Hildenbrand wrote:
> On 26.02.22 10:40, Miaohe Lin wrote:
>> There is a theoretical race window between memory failure and memory
>> offline. Think about the below scene:
>>
>>   CPU A					  CPU B
>> memory_failure				offline_pages
>>   mutex_lock(&mf_mutex);
>>   TestSetPageHWPoison(p)
>> 					  start_isolate_page_range
>> 					    has_unmovable_pages
>> 					      --PageHWPoison is movable
>> 					  do {
>> 					    scan_movable_pages
>> 					    do_migrate_range
>> 					      --PageHWPoison isn't migrated
>> 					  }
>> 					  test_pages_isolated
>> 					    --PageHWPoison is isolated
>> 					remove_memory
>>   access page... bang
>>   ...
> 
> I think the motivation for the offlining code was to not block memory
> hotunplug (especially on ZONE_MOVABLE) just because there is a
> HWpoisoned page. But how often does that happen?
> 
> It's all semi-broken either way. Assume you just offlined a memory block
> with a hwpoisoned page. The memmap is stale and the information about
> hwpoison is lost. You can happily re-online that memory block and use
> *all* memory, including previously hwpoisoned memory. Note that this
> used to be different in the past, when the memmap was initialized when
> adding memory, not when onlining that memory.
> 
> 
> IMHO, we should stop special casing hwpoison. Either fail offlining
> completely if we stumble over a hwpoisoned page, or allow offlining only
> if the refcount==0 -- just as any other page.
> 
> 

IIUC, there is no easy way to found out whether a hwpoinsoned page could be
safely offlined. If memory_failure succeeds, page refcnt should be 1. But if
failed, page refcnt is unknown. So it seems failing offlining completely if
we stumble over a hwpoisoned page is most suitable way to close the race. But
is this too overkill for such rare cases? Any suggestions?

Many thanks!
