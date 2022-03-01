Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9385D4C8C85
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 14:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234568AbiCANW4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 08:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229773AbiCANWz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 08:22:55 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBDCB9BBA5
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 05:22:13 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4K7HrG5W8CzKmGs;
        Tue,  1 Mar 2022 21:18:38 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Mar 2022 21:22:11 +0800
Subject: Re: [PATCH RFC] mm/memory-failure.c: fix memory failure race with
 memory offline
To:     David Hildenbrand <david@redhat.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>,
        <osalvador@suse.de>
References: <20220226094034.23938-1-linmiaohe@huawei.com>
 <4307e915-ac24-58bc-23ad-7e94e2b37170@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b36f92bd-e0ec-89db-c830-5cf21d3b61a1@huawei.com>
Date:   Tue, 1 Mar 2022 21:22:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <4307e915-ac24-58bc-23ad-7e94e2b37170@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

This should be really race. The memory failure itself shouldn't be common
otherwise we have other problems.

> 
> It's all semi-broken either way. Assume you just offlined a memory block
> with a hwpoisoned page. The memmap is stale and the information about
> hwpoison is lost. You can happily re-online that memory block and use
> *all* memory, including previously hwpoisoned memory. Note that this

Agree. This is how it works now. But it seems the hwpoisoned memory might can
be used again as normal memory after offline+online.

> used to be different in the past, when the memmap was initialized when
> adding memory, not when onlining that memory.
> 
> 
> IMHO, we should stop special casing hwpoison. Either fail offlining
> completely if we stumble over a hwpoisoned page, or allow offlining only
> if the refcount==0 -- just as any other page.
> 

I'm not sure whether this "rare" race condition worth fixing. But the problem
is there and we might come across it. Failing offlining completely sounds not
that good but it looks hard to reliably detect the "offline-safe" hwpoisoned page.
I can't come out a solution...

Many thanks for reply and comment. :)

> 
