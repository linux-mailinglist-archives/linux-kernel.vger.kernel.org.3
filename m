Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78B1C5AFA67
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 05:07:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiIGDHa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 23:07:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiIGDH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 23:07:26 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCE687690;
        Tue,  6 Sep 2022 20:07:23 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4MMnBn21v4zkYTT;
        Wed,  7 Sep 2022 11:03:29 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 7 Sep 2022 11:07:16 +0800
Subject: Re: [PATCH 4/8] hugetlb: handle truncate racing with page faults
To:     Mike Kravetz <mike.kravetz@oracle.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>,
        David Hildenbrand <david@redhat.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        <linux-s390@vger.kernel.org>, <hca@linux.ibm.com>,
        <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220824175757.20590-1-mike.kravetz@oracle.com>
 <20220824175757.20590-5-mike.kravetz@oracle.com>
 <yt9dr10ok3lm.fsf@linux.ibm.com> <Yxd5z0c8NlKVlVqk@monkey>
 <YxeL7ZMoyNmPAvY0@monkey> <YxfTA53/5pkpC7xZ@monkey>
 <367db2b5-5242-9be6-1d5f-d13e35f84167@huawei.com> <YxgD7qXPgkJ9VgJn@monkey>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <25ffa1bf-0025-3421-53cb-79f986468cb6@huawei.com>
Date:   Wed, 7 Sep 2022 11:07:16 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <YxgD7qXPgkJ9VgJn@monkey>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/9/7 10:37, Mike Kravetz wrote:
> On 09/07/22 10:11, Miaohe Lin wrote:
>> On 2022/9/7 7:08, Mike Kravetz wrote:
>>> On 09/06/22 11:05, Mike Kravetz wrote:
>>>> On 09/06/22 09:48, Mike Kravetz wrote:
>>>>> On 09/06/22 15:57, Sven Schnelle wrote:
>>>>>> Hi Mike,
>>>>>>
>>>>>> Mike Kravetz <mike.kravetz@oracle.com> writes:
>>>>>>
>>>>>>> When page fault code needs to allocate and instantiate a new hugetlb
>>>>>>> page (huegtlb_no_page), it checks early to determine if the fault is
>>>>>>> beyond i_size.  When discovered early, it is easy to abort the fault and
>>>>>>> return an error.  However, it becomes much more difficult to handle when
>>>>>>> discovered later after allocating the page and consuming reservations
>>>>>>> and adding to the page cache.  Backing out changes in such instances
>>>>>>> becomes difficult and error prone.
>>>>>>>
>>>>>>> Instead of trying to catch and backout all such races, use the hugetlb
>>>>>>> fault mutex to handle truncate racing with page faults.  The most
>>>>>>> significant change is modification of the routine remove_inode_hugepages
>>>>>>> such that it will take the fault mutex for EVERY index in the truncated
>>>>>>> range (or hole in the case of hole punch).  Since remove_inode_hugepages
>>>>>>> is called in the truncate path after updating i_size, we can experience
>>>>>>> races as follows.
>>>>>>> - truncate code updates i_size and takes fault mutex before a racing
>>>>>>>   fault.  After fault code takes mutex, it will notice fault beyond
>>>>>>>   i_size and abort early.
>>>>>>> - fault code obtains mutex, and truncate updates i_size after early
>>>>>>>   checks in fault code.  fault code will add page beyond i_size.
>>>>>>>   When truncate code takes mutex for page/index, it will remove the
>>>>>>>   page.
>>>>>>> - truncate updates i_size, but fault code obtains mutex first.  If
>>>>>>>   fault code sees updated i_size it will abort early.  If fault code
>>>>>>>   does not see updated i_size, it will add page beyond i_size and
>>>>>>>   truncate code will remove page when it obtains fault mutex.
>>>>>>>
>>>>>>> Note, for performance reasons remove_inode_hugepages will still use
>>>>>>> filemap_get_folios for bulk folio lookups.  For indicies not returned in
>>>>>>> the bulk lookup, it will need to lookup individual folios to check for
>>>>>>> races with page fault.
>>>>>>>
>>>>>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>>>>>>> ---
>>>>>>>  fs/hugetlbfs/inode.c | 184 +++++++++++++++++++++++++++++++------------
>>>>>>>  mm/hugetlb.c         |  41 +++++-----
>>>>>>>  2 files changed, 152 insertions(+), 73 deletions(-)
>>>>>>
>>>>>> With linux next starting from next-20220831 i see hangs with this
>>>>>> patch applied while running the glibc test suite. The patch doesn't
>>>>>> revert cleanly on top, so i checked out one commit before that one and
>>>>>> with that revision everything works.
>>>>>>
>>>>>> It looks like the malloc test suite in glibc triggers this. I cannot
>>>>>> identify a single test causing it, but instead the combination of
>>>>>> multiple tests. Running the test suite on a single CPU works. Given the
>>>>>> subject of the patch that's likely not a surprise.
>>>>>>
>>>>>> This is on s390, and the warning i get from RCU is:
>>>>>>
>>>>>> [ 1951.906997] rcu: INFO: rcu_sched self-detected stall on CPU
>>>>>> [ 1951.907009] rcu:     60-....: (6000 ticks this GP) idle=968c/1/0x4000000000000000 softirq=43971/43972 fqs=2765
>>>>>> [ 1951.907018]  (t=6000 jiffies g=116125 q=1008072 ncpus=64)
>>>>>> [ 1951.907024] CPU: 60 PID: 1236661 Comm: ld64.so.1 Not tainted 6.0.0-rc3-next-20220901 #340
>>>>>> [ 1951.907027] Hardware name: IBM 3906 M04 704 (z/VM 7.1.0)
>>>>>> [ 1951.907029] Krnl PSW : 0704e00180000000 00000000003d9042 (hugetlb_fault_mutex_hash+0x2a/0xd8)
>>>>>> [ 1951.907044]            R:0 T:1 IO:1 EX:1 Key:0 M:1 W:0 P:0 AS:3 CC:2 PM:0 RI:0 EA:3
>>>>>> [ 1951.907095] Call Trace:
>>>>>> [ 1951.907098]  [<00000000003d9042>] hugetlb_fault_mutex_hash+0x2a/0xd8
>>>>>> [ 1951.907101] ([<00000000005845a6>] fault_lock_inode_indicies+0x8e/0x128)
>>>>>> [ 1951.907107]  [<0000000000584876>] remove_inode_hugepages+0x236/0x280
>>>>>> [ 1951.907109]  [<0000000000584a7c>] hugetlbfs_evict_inode+0x3c/0x60
>>>>>> [ 1951.907111]  [<000000000044fe96>] evict+0xe6/0x1c0
>>>>>> [ 1951.907116]  [<000000000044a608>] __dentry_kill+0x108/0x1e0
>>>>>> [ 1951.907119]  [<000000000044ac64>] dentry_kill+0x6c/0x290
>>>>>> [ 1951.907121]  [<000000000044afec>] dput+0x164/0x1c0
>>>>>> [ 1951.907123]  [<000000000042a4d6>] __fput+0xee/0x290
>>>>>> [ 1951.907127]  [<00000000001794a8>] task_work_run+0x88/0xe0
>>>>>> [ 1951.907133]  [<00000000001f77a0>] exit_to_user_mode_prepare+0x1a0/0x1a8
>>>>>> [ 1951.907137]  [<0000000000d0e42e>] __do_syscall+0x11e/0x200
>>>>>> [ 1951.907142]  [<0000000000d1d392>] system_call+0x82/0xb0
>>>>>> [ 1951.907145] Last Breaking-Event-Address:
>>>>>> [ 1951.907146]  [<0000038001d839c0>] 0x38001d839c0
>>>>>>
>>>>>> One of the hanging test cases is usually malloc/tst-malloc-too-large-malloc-hugetlb2.
>>>>>>
>>>>>> Any thoughts?
>>>>>
>>>>> Thanks for the report, I will take a look.
>>>>>
>>>>> My first thought is that this fix may not be applied,
>>>>> https://lore.kernel.org/linux-mm/Ywepr7C2X20ZvLdn@monkey/
>>>>> However, I see that that is in next-20220831.
>>>>>
>>>>> Hopefully, this will recreate on x86.
>>>>
>>>> One additional thought ...
>>>>
>>>> With this patch, we will take the hugetlb fault mutex for EVERY index in the
>>>> range being truncated or hole punched.  In the case of a very large file, that
>>>> is no different than code today where we take the mutex when removing pages
>>>> from the file.  What is different is taking the mutex for indices that are
>>>> part of holes in the file.  Consider a very large file with only one page at
>>>> the very large offset.  We would then take the mutex for each index in that
>>>> very large hole.  Depending on the size of the hole, this could appear as a
>>>> hang.
>>>>
>>>> For the above locking scheme to work, we need to take the mutex for indices
>>>> in holes in case there would happen to be a racing page fault.  However, there
>>>> are only a limited number of fault mutexes (it is a table).  So, we only really
>>>> need to take at a maximum num_fault_mutexes mutexes.  We could keep track of
>>>> these with a bitmap.
>>>>
>>>> I am not sure this is the issue you are seeing, but a test named
>>>> tst-malloc-too-large-malloc-hugetlb2 may be doing this.
>>>>
>>>> In any case, I think this issue needs to be addressed before this series can
>>>> move forward.
>>>
>>> Well, even if we address the issue of taking the same mutex multiple times,
>>
>> Can we change to take all the hugetlb fault mutex at the same time to ensure every possible
>> future hugetlb page fault will see a truncated i_size? Then we could just drop all the hugetlb
>> fault mutex before doing any heavy stuff? It seems hugetlb fault mutex could be dropped when
>> new i_size is guaranteed to be visible for any future hugetlb page fault users?
>> But I might miss something...
> 
> Yes, that is the general direction and would work well for truncation.  However,
> the same routine remove_inode_hugepages is used for hole punch, and I am pretty
> sure we want to take the fault mutex there as it can race with page faults.

Oh, sorry. I missed that case.

> 
>>
>>> this new synchronization scheme requires a folio lookup for EVERY index in
>>> the truncated or hole punched range.  This can easily 'stall' a CPU if there
>>
>> If above thought holds, we could do batch folio lookup instead. Hopes my thought will help. ;)
>>
> 
> Yes, I have some promising POC code with two batch lookups in case of holes.
> Hope to send something soon.

That will be really nice. ;)

Thanks,
Miaohe Lin

