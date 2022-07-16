Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE69576B33
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 03:33:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231311AbiGPBdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 21:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbiGPBc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 21:32:59 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7464746D99
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 18:32:57 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Ll9fs6PGszlVmw;
        Sat, 16 Jul 2022 09:31:17 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 16 Jul 2022 09:32:55 +0800
Subject: Re: [PATCH] mm/hugetlb: avoid corrupting page->mapping in
 hugetlb_mcopy_atomic_pte
To:     Axel Rasmussen <axelrasmussen@google.com>,
        Peter Xu <peterx@redhat.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220712130542.18836-1-linmiaohe@huawei.com>
 <20220713102357.8328614813db01b569650ffd@linux-foundation.org>
 <a47922cf-eb30-1ad9-fc96-1896254564ef@huawei.com>
 <YtA7svbn4MtuT7qJ@xz-m1.local>
 <402ae708-4c86-8feb-75c4-9339e1deac3b@huawei.com>
 <YtFfHU3fb/ncCG6O@xz-m1.local>
 <CAJHvVcgFY2uXM=CkxYmHc32Vqb5qmr8vFv0dpFk-2=Ef+Kssqw@mail.gmail.com>
 <YtGe2qIO038e627p@xz-m1.local>
 <CAJHvVcji14hUsqg=yrtevEqwMtZi7Xwyj4yUnLMaZi0DBqPTHA@mail.gmail.com>
 <YtGmPI41S4w9iwr9@xz-m1.local>
 <CAJHvVchMbJjOp4U+5K83YN0XHMRKfGzTLgCnzKd8mjYMQPRWaw@mail.gmail.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <6fecf875-260e-a9c5-df24-9b0d13970057@huawei.com>
Date:   Sat, 16 Jul 2022 09:32:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <CAJHvVchMbJjOp4U+5K83YN0XHMRKfGzTLgCnzKd8mjYMQPRWaw@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/7/16 1:51, Axel Rasmussen wrote:
> On Fri, Jul 15, 2022 at 10:39 AM Peter Xu <peterx@redhat.com> wrote:
>>
>> On Fri, Jul 15, 2022 at 10:28:44AM -0700, Axel Rasmussen wrote:
>>> On Fri, Jul 15, 2022 at 10:07 AM Peter Xu <peterx@redhat.com> wrote:
>>>>
>>>> On Fri, Jul 15, 2022 at 09:45:37AM -0700, Axel Rasmussen wrote:
>>>>> I agree we should either:
>>>>> - Update the UFFD selftest to exercise this case
>>>>> - Or, don't allow it, update vma_can_userfault() to also require VM_SHARED
>>>>> for VM_UFFD_MINOR registration.
>>>>>
>>>>> The first one is unfortunately not completely straightforward as Peter
>>>>> described. I would say it's probably not worth holding up this fix while we
>>>>> wait for it to happen?
>>>>
>>>> Agreed, Andrew has already queued it.  It actually is a real fix since we
>>>> never forbid the user running private mappings upon minor faults, so
>>>> it's literally a bug in kernel irrelevant of the kselftest.
>>>>
>>>>>
>>>>> I don't really have a strong preference between the two. The second option
>>>>> is what I originally proposed in the first version of the minor fault
>>>>> series, so going back to that isn't a problem at least from my perspective.
>>>>> If in the future we find a real use case for this, we could always easily
>>>>> re-enable it and add selftests for it at that point.
>>>>
>>>> I'd go for fixing the test case if possible.  Mike, would it be fine if we
>>>> go back to /dev/hugepages path based approach in the test case?
>>>
>>> One possible alternative, can we use memfd_create() with MFD_HUGE_*?
>>> This afaict lets us have an fd so we can create two mappings,
>>> without having to mount hugetlbfs, pass in a path to the test, ...
>>
>> Sounds good. :) We can also rework the shared hugetlb too.  Wanna post a
>> patch?  I can do that too, let me know otherwise.  Thanks!
> 
> Sure, I'll take a whack at it.

Many thanks for all of your hard work. :)

> 
>>
>> --
>> Peter Xu
>>
> .
> 

