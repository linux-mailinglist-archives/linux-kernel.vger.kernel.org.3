Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96EFF59F718
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 12:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236425AbiHXKGV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 06:06:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236577AbiHXKGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 06:06:18 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0353452FE3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 03:06:16 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MCM8439qbzXf1Y;
        Wed, 24 Aug 2022 18:01:56 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 18:05:59 +0800
Received: from [10.174.179.24] (10.174.179.24) by
 dggpemm100009.china.huawei.com (7.185.36.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 24 Aug 2022 18:05:58 +0800
Subject: Re: [PATCH -next v2] mm, proc: collect percpu free pages into the
 free pages
To:     Michal Hocko <mhocko@suse.com>
References: <20220822023311.909316-1-liushixin2@huawei.com>
 <20220822033354.952849-1-liushixin2@huawei.com>
 <20220822141207.24ff7252913a62f80ea55e90@linux-foundation.org>
 <YwSGqtEICW5AlhWr@dhcp22.suse.cz>
 <6b2977fc-1e4a-f3d4-db24-7c4699e0773f@huawei.com>
 <YwTYMGtcS4/F/xQO@dhcp22.suse.cz>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        huang ying <huang.ying.caritas@gmail.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        "Jesper Dangaard Brouer" <brouer@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kemi Wang" <kemi.wang@intel.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>
From:   Liu Shixin <liushixin2@huawei.com>
Message-ID: <cd84777e-b7d9-7e7e-2121-9d75eeb950cb@huawei.com>
Date:   Wed, 24 Aug 2022 18:05:58 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <YwTYMGtcS4/F/xQO@dhcp22.suse.cz>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.24]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/8/23 21:37, Michal Hocko wrote:
> On Tue 23-08-22 20:46:43, Liu Shixin wrote:
>> On 2022/8/23 15:50, Michal Hocko wrote:
>>> On Mon 22-08-22 14:12:07, Andrew Morton wrote:
>>>> On Mon, 22 Aug 2022 11:33:54 +0800 Liu Shixin <liushixin2@huawei.com> wrote:
>>>>
>>>>> The page on pcplist could be used, but not counted into memory free or
>>>>> avaliable, and pcp_free is only showed by show_mem() for now. Since commit
>>>>> d8a759b57035 ("mm, page_alloc: double zone's batchsize"), there is a
>>>>> significant decrease in the display of free memory, with a large number
>>>>> of cpus and zones, the number of pages in the percpu list can be very
>>>>> large, so it is better to let user to know the pcp count.
>>>>>
>>>>> On a machine with 3 zones and 72 CPUs. Before commit d8a759b57035, the
>>>>> maximum amount of pages in the pcp lists was theoretically 162MB(3*72*768KB).
>>>>> After the patch, the lists can hold 324MB. It has been observed to be 114MB
>>>>> in the idle state after system startup in practice(increased 80 MB).
>>>>>
>>>> Seems reasonable.
>>> I have asked in the previous incarnation of the patch but haven't really
>>> received any answer[1]. Is this a _real_ problem? The absolute amount of
>>> memory could be perceived as a lot but is this really noticeable wrt
>>> overall memory on those systems?
>> This may not obvious when the memory is sufficient. However, as products monitor the
>> memory to plan it. The change has caused warning.
> Is it possible that the said monitor is over sensitive and looking at
> wrong numbers? Overall free memory doesn't really tell much TBH.
> MemAvailable is a very rough estimation as well.
>
> In reality what really matters much more is whether the memory is
> readily available when it is required and none of MemFree/MemAvailable
> gives you that information in general case.
>
>> We have also considered using /proc/zoneinfo to calculate the total
>> number of pcplists. However, we think it is more appropriate to add
>> the total number of pcplists to free and available pages. After all,
>> this part is also free pages.
> Those free pages are not generally available as exaplained. They are
> available to a specific CPU, drained under memory pressure and other
> events but still there is no guarantee a specific process can harvest
> that memory because the pcp caches are replenished all the time.
> So in a sense it is a semi-hidden memory.
>
> That being said, I am still not convinced this is actually going to help
> all that much. You will see a slightly different numbers which do not
> tell much one way or another and if the sole reason for tweaking these
> numbers is that some monitor is complaining because X became X-epsilon
> then this sounds like a weak justification to me. That epsilon happens
> all the time because there are quite some hidden caches that are
> released under memory pressure. I am not sure it is maintainable to
> consider each one of them and pretend that MemFree/MemAvailable is
> somehow precise. It has never been and likely never will be.
Thanks for your explanation. As you said, it seems that merge these memory into
MemFree/MemAvailable directly may affect the performance under memory pressure.
That sounds reasonable.
 
But since these memory is also free memory that can be uesd and is large, I think we
should still provide a statistic for the user. Perhaps add a new statistic is better?

Thanks,


