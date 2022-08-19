Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33274599242
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 03:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243365AbiHSBGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 21:06:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbiHSBGu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 21:06:50 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7370AB729E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 18:06:48 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4M83Qz4BF2z1N7RY;
        Fri, 19 Aug 2022 09:03:23 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 19 Aug 2022 09:06:46 +0800
Received: from [10.174.177.243] (10.174.177.243) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 19 Aug 2022 09:06:45 +0800
Message-ID: <af1ee19f-c4fe-ee80-ec4c-b3d3a859795b@huawei.com>
Date:   Fri, 19 Aug 2022 09:06:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH RFC] mm, proc: add PcpFree to meminfo
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-mm@kvack.org>, Aaron Lu <aaron.lu@intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        "Vlastimil Babka" <vbabka@suse.cz>, Kemi Wang <kemi.wang@intel.com>
CC:     <linux-kernel@vger.kernel.org>, Liu Shixin <liushixin2@huawei.com>
References: <20220816084426.135528-1-wangkefeng.wang@huawei.com>
 <99556483-9f22-4597-8270-b4414cc97e64@huawei.com>
 <19144f97-2b00-fed6-5395-0221bbc60802@intel.com>
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
In-Reply-To: <19144f97-2b00-fed6-5395-0221bbc60802@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.243]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022/8/19 5:07, Dave Hansen wrote:
> On 8/17/22 00:16, Kefeng Wang wrote:
>> On 2022/8/16 16:44, Kefeng Wang wrote:
>>> From: Liu Shixin <liushixin2@huawei.com>
>>>
>>> The page on pcplist could be used, but not counted into memory free or
>>> avaliable, and pcp_free is only showed by show_mem(). Since commit
>>> d8a759b57035 ("mm, page_alloc: double zone's batchsize"), there is a
>>> significant decrease in the display of free memory, with a large number
>>> of cpus and nodes, the number of pages in the percpu list can be very
>>> large, so it is better to let user to know the pcp count.
>> Add more experts according to commit d8a759b57035，
>> any advice would be much appreciated，thanks.
> Adding a new meminfo field seems like overkill.  I'd just make this a
> part of MemFree if anything.
I like this way too.
> Also, some actual data would be nice here.  Like:
>
> 	Before commit d8a759b57035, the maximum amount of pages in the
> 	pcp lists was theoretically $FOO MB.  After the patch, the lists
> 	can hold $BAR MB.  It has been observed to be $BAZ MB in
> 	practice.
>
> 	This was all on a system with $X memory NUMA nodes and $Y CPUs.
>
> .

Same question in [1],  will repost with update, thanks.

[1] 
https://lore.kernel.org/linux-mm/03f465ca-cf8e-bbd1-1083-099fd2ce026d@huawei.com/t/#m50cf15911d9d203bd97238512fa2ae9ba1bd9e1e

