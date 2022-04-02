Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA25F4F009D
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 12:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354332AbiDBKa6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 06:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239592AbiDBKaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 06:30:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060FE49266
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 03:29:03 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KVtWr1Z9nzgY97;
        Sat,  2 Apr 2022 18:27:20 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Sat, 2 Apr 2022 18:29:00 +0800
CC:     <yangyicong@hisilicon.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched: topology: make cache topology separate from cpu
 topology
To:     =?UTF-8?B?546L5pOO?= <wangqing@vivo.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <1646917125-20038-1-git-send-email-wangqing@vivo.com>
 <CAKfTPtAvbpUUaOqP3gmOT7fLk8-7v70LzBUiQ-vgDvc7ZZujag@mail.gmail.com>
 <SL2PR06MB30828CF9FF2879AFC9DC53D2BD0C9@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <CAKfTPtBM9WBEgP_PpRHNaATvp9FrBeV2NXhg_EAp4xYtBZYCWQ@mail.gmail.com>
 <SL2PR06MB30826C314139509EC4778C1BBD0C9@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <CAKfTPtA=dy4M2OK+GqvPDo9D8YBZAHbEpM-YPVZEyEUjEJKU5g@mail.gmail.com>
 <SL2PR06MB308268BDF646BFA0FC9A4590BD0C9@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <CAKfTPtCVV_cpBty7xH8Gea8HdjNzfiE3Kd882i7Pffvrv3p1zw@mail.gmail.com>
 <SL2PR06MB3082ED191BF8892367A3465EBD109@SL2PR06MB3082.apcprd06.prod.outlook.com>
 <CAKfTPtCn0As7Kbj7aHtmu++RDyo8proM6k9DLa1AMAc7iSSQXg@mail.gmail.com>
 <SL2PR06MB308281BAC7D7F7CBF136DCD3BDE39@SL2PR06MB3082.apcprd06.prod.outlook.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <c1e348d1-6b74-9ac9-b7c6-6508a0fd9690@huawei.com>
Date:   Sat, 2 Apr 2022 18:29:00 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <SL2PR06MB308281BAC7D7F7CBF136DCD3BDE39@SL2PR06MB3082.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
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

Hi Qing,

On 2022/4/2 17:34, 王擎 wrote:
> 
>>>
>>>
>>>>>
>>>>>
>>>>>>>
>>>>>>>
>>>>>>>>>
>>>>>>>>>
>>>>>>>>>> On Thu, 10 Mar 2022 at 13:59, Qing Wang <wangqing@vivo.com> wrote:
>>>>>>>>>>>
>>>>>>>>>>> From: Wang Qing <wangqing@vivo.com>
>>>>>>>>>>>
>>>>>>>>>>> Some architectures(e.g. ARM64), caches are implemented below:
>>>>>>>>>>> cluster:                     ****** cluster 0 *****      ****** cluster 1 *****
>>>>>>>>>>> core:                         0      1          2      3          4      5           6      7
>>>>>>>>> (add cache level 1)        c0    c1        c2    c3         c4    c5         c6    c7
>>>>>>>>>>> cache(Leveln):         **cache0**  **cache1**  **cache2**  **cache3**
>>>>>>>>> (add cache level 3)        *************share level 3 cache ***************
>>>>>>>>>>> sd_llc_id(current):     0      0          0      0          4      4           4      4
>>>>>>>>>>> sd_llc_id(should be): 0      0          2      2          4      4           6      6
>>>>>>>>>>>
>>>>>>>>> Here, n always be 2 in ARM64, but others are also possible.
>>>>>>>>> core[0,1] form a complex(ARMV9),  which share L2 cache, core[2,3] is the same.
>>>>>>>>>
>>>>>>>>>>> Caches and cpus have different topology, this causes cpus_share_cache()
>>>>>>>>>>> return the wrong value, which will affect the CPU load balance.
>>>>>>>>>>>
>>>>>>>>>> What does your current scheduler topology  look like?
>>>>>>>>>>
>>>>>>>>>> For CPU 0 to 3, do you have the below ?
>>>>>>>>>> DIE [0     -     3] [4-7]
>>>>>>>>>> MC  [0] [1] [2] [3]
>>>>>>>>>
>>>>>>>>> The current scheduler topology consistent with CPU topology:
>>>>>>>>> DIE  [0-7]
>>>>>>>>> MC  [0-3] [4-7]  (SD_SHARE_PKG_RESOURCES)
>>>>>>>>> Most Android phones have this topology.
>>>>>>>>>>
>>>>>>>>>> But you would like something like below for cpu 0-1 instead ?
>>>>>>>>>> DIE [0     -     3] [4-7]
>>>>>>>>>> CLS [0 - 1] [2 - 3]
>>>>>>>>>> MC  [0] [1]
>>>>>>>>>>
>>>>>>>>>> with SD_SHARE_PKG_RESOURCES only set to MC level ?
>>>>>>>>>
>>>>>>>>> We don't change the current scheduler topology, but the
>>>>>>>>> cache topology should be separated like below:
>>>>>>>>
>>>>>>>> The scheduler topology is not only cpu topology but a mixed of cpu and
>>>>>>>> cache/memory cache topology
>>>>>>>>
>>>>>>>>> [0-7]                          (shared level 3 cache )
>>>>>>>>> [0-1] [2-3][4-5][6-7]   (shared level 2 cache )
>>>>>>>>
>>>>>>>> So you don't  bother the intermediate cluster level which is even simpler.
>>>>>>>> you have to modify generic arch topology so that cpu_coregroup_mask
>>>>>>>> returns the correct cpu mask directly.
>>>>>>>>
>>>>>>>> You will notice a llc_sibling field that is currently used by acpi but
>>>>>>>> not DT to return llc cpu mask
>>>>>>>>
>>>>>>> cpu_topology[].llc_sibling describe the last level cache of whole system,
>>>>>>> not in the sched_domain.
>>>>>>>
>>>>>>> in the above cache topology, llc_sibling is 0xff([0-7]) , it describes
>>>>>>
>>>>>> If llc_sibling was 0xff([0-7] on your system, you would have only one level:
>>>>>> MC[0-7]
>>>>>
>>>>> Sorry, but I don't get it, why llc_sibling was 0xff([0-7] means MC[0-7]?
>>>>> In our system(Android), llc_sibling is indeed 0xff([0-7]) , because they
>>>>> shared the llc(L3), but we also have two level:
>>>>> DIE [0-7]
>>>>> MC [0-3][4-6]
>>>>> It makes sense, [0-3] are little cores, [4-7] are bit cores, se only up migrate
>>>>> when misfit. We won't change it.
>>>>>
>>>>>>
>>>>>>> the L3 cache sibling, but sd_llc_id describes the maximum shared cache
>>>>>>> in sd, which should be [0-1] instead of [0-3].
>>>>>>
>>>>>> sd_llc_id describes the last sched_domain with SD_SHARE_PKG_RESOURCES.
>>>>>> If you want llc to be [0-3] make sure that the
>>>>>> sched_domain_topology_level array returns the correct cpumask with
>>>>>> this flag
>>>>>
>>>>> Acturely, we want sd_llc to be [0-1] [2-3], but if the MC domain don't have
>>>>
>>>> sd_llc_id refers to a scheduler domain but your patch breaks this so
>>>> if you want a llc that reflects this topo:  [0-1] [2-3] you must
>>>> provide a sched_domain level with this topo
>>>
>>> Maybe we should add a shared-cache level(SC), like what CLS does:
>>>
>>> DIE  [0-7] (shared level 3 cache, SD_SHARE_PKG_RESOURCES)
>>> MC  [0-3] [4-7]  (not SD_SHARE_PKG_RESOURCES)
>>> CLS  (if necessary)
>>> SC    [0-1][2-3][4-5][6-7] (shared level 2 cache, SD_SHARE_PKG_RESOURCES)
>>> SMT (if necessary)
>>>
>>> SC means a couple of CPUs which are placed closely by sharing
>>> mid-level caches, but not enough to be a cluster.
>>
>> what you name SC above looks the same as CLS which should not be mixed
>> with Arm cluster terminology
> 
> Do you mean cluster is equal to shared cache instead of containing, SC just 
> means shared cache, but not form a cluster, a CLS can contain many SCs.
> 

The cluster is a topology level above the CPUs but under LLC. On Kunpeng 920 the cpus
in a CLS will share L3T and on Intel's Jacobsville cpus in a CLS will share L2[1].

Seems you're using a DT based system. I think the parsing of cluster level is not
supported on DT yet so you cannot see it. Otherwise with right cpu topology reported
you will have a CLS level in which the cpus share L2 cache, just like Jacobsville.

[1] https://lore.kernel.org/all/20210924085104.44806-4-21cnbao@gmail.com/

> If as you said, SC looks the same as CLS, should we rename CLS to SC to 
> avoid confusion?
> 
> Thanks,
> Wang
> 
