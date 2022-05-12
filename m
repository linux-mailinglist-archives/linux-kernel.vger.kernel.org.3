Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E48AA524B2F
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 13:13:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353079AbiELLNk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 07:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353096AbiELLN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 07:13:26 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DD4BCEB1
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 04:13:19 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KzTb81HbJzGpg2;
        Thu, 12 May 2022 19:10:28 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 12 May 2022 19:13:17 +0800
Subject: Re: [RFC PATCH v1 0/4] mm, hwpoison: improve handling workload
 related to hugetlb and memory_hotplug
To:     David Hildenbrand <david@redhat.com>,
        =?UTF-8?B?SE9SSUdVQ0hJIE5BT1lBKOWggOWPoyDnm7TkuZ8p?= 
        <naoya.horiguchi@nec.com>, Oscar Salvador <osalvador@suse.de>
CC:     Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Yang Shi <shy828301@gmail.com>,
        Muchun Song <songmuchun@bytedance.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <54399815-10fe-9d43-7ada-7ddb55e798cb@redhat.com>
 <20220427122049.GA3918978@hori.linux.bs1.fc.nec.co.jp>
 <bb1caf48-7e9d-61bf-e0dc-72fcc0228f28@redhat.com>
 <20220509072902.GB123646@hori.linux.bs1.fc.nec.co.jp>
 <6a5d31a3-c27f-f6d9-78bb-d6bf69547887@huawei.com>
 <Ynjl4JmLXkA47U8T@localhost.localdomain>
 <465902dc-d3bf-7a93-da04-839faddcd699@huawei.com>
 <0389eac1-af68-56b5-696d-581bb56878b9@redhat.com>
 <20220511161052.GA224675@hori.linux.bs1.fc.nec.co.jp>
 <6986a8dd-7211-fb4d-1d66-5b203cad1aab@redhat.com>
 <20220512063558.GA249122@hori.linux.bs1.fc.nec.co.jp>
 <c424e8a2-a771-e738-396c-24ac907b557f@redhat.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <04781d15-9d87-1763-02fe-e353679c50d7@huawei.com>
Date:   Thu, 12 May 2022 19:13:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <c424e8a2-a771-e738-396c-24ac907b557f@redhat.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/12 15:28, David Hildenbrand wrote:
>>>>>
>>>>> Once the problematic DIMM would actually get unplugged, the memory block devices
>>>>> would get removed as well. So when hotplugging a new DIMM in the same
>>>>> location, we could online that memory again.
>>>>
>>>> What about PG_hwpoison flags?  struct pages are also freed and reallocated
>>>> in the actual DIMM replacement?
>>>
>>> Once memory is offline, the memmap is stale and is no longer
>>> trustworthy. It gets reinitialize during memory onlining -- so any
>>> previous PG_hwpoison is overridden at least there. In some setups, we
>>> even poison the whole memmap via page_init_poison() during memory offlining.
>>>
>>> Apart from that, we should be freeing the memmap in all relevant cases
>>> when removing memory. I remember there are a couple of corner cases, but
>>> we don't really have to care about that.
>>
>> OK, so there seems no need to manipulate struct pages for hwpoison in
>> all relevant cases.
> 
> Right. When offlining a memory block, all we have to do is remember if
> we stumbled over a hwpoisoned page and rememebr that inside the memory
> block. Rejecting to online is then easy.

BTW: How should we deal with the below race window:

CPU A			CPU B				CPU C
accessing page while hold page refcnt
			memory_failure happened on page
							offline_pages
							  page can be offlined due to page refcnt
							  is ignored when PG_hwpoison is set
can still access page struct...

Any in use page (with page refcnt incremented) might be offlined while its content, e.g. flags, private ..., can
still be accessed if the above race happened. Is this possible? Or am I miss something? Any suggestion to fix it?
I can't figure out a way yet. :(

Thanks a lot!

> 

