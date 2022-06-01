Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66770539D44
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 08:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349873AbiFAGdJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 02:33:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241485AbiFAGdG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 02:33:06 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B14728738
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 23:33:05 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LCfQF2WqczRhTc;
        Wed,  1 Jun 2022 14:29:57 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 1 Jun 2022 14:33:02 +0800
Subject: Re: [PATCH v4 1/4] mm: reduce the rcu lock duration
To:     "Eric W. Biederman" <ebiederm@xmission.com>
CC:     Ying Huang <ying.huang@intel.com>, <peterx@redhat.com>,
        <apopple@nvidia.com>, <osalvador@suse.de>,
        <mike.kravetz@oracle.com>, <songmuchun@bytedance.com>,
        <hch@lst.de>, <dhowells@redhat.com>, <cl@linux.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
References: <20220530113016.16663-1-linmiaohe@huawei.com>
 <20220530113016.16663-2-linmiaohe@huawei.com>
 <bbc060ca6e967790423e0a3ca940d1e700447554.camel@intel.com>
 <b2ddcd64-2779-ede9-3615-ad5bc90a3bc1@huawei.com>
 <87bkvdfzvm.fsf@email.froward.int.ebiederm.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <e10023d7-3d19-1edf-86af-4cb79071b78f@huawei.com>
Date:   Wed, 1 Jun 2022 14:33:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87bkvdfzvm.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/1 0:09, Eric W. Biederman wrote:
> Miaohe Lin <linmiaohe@huawei.com> writes:
snip
>>
>> "
>> Commit 3268c63eded4 ("mm: fix move/migrate_pages() race on task struct")
>> extends the period of the rcu_read_lock until after the permissions checks
>> are done because it suspects the permissions checks are not safe unless
>> performed under both rcu_read_lock and task_lock to ensure the task<->mm
>> association does not change on us while we are working [1]. But extended
>> rcu read lock does not add much value. Because after permission checking
>> the permission may still be changed. There's no much difference. So it's
>> unnecessary to extend the period of the rcu_read_lock. Release the rcu
>> lock after task refcount is successfully grabbed to reduce the rcu holding
>> time.
>>
>> [1] https://lore.kernel.org/lkml/87sjhzun47.fsf@xmission.com/
>> "
> 
> It doesn't make sense to me.
> 
> I don't see any sleeping functions called from find_mm_struct or
> kernel_migrate_pages in the area kernel_migrate_pages in the area of the
> code protected by get_task_struct.  So at a very basic level I see a
> justification for dirtying a cache line twice with get_task_struct and
> put_task_struct to reduce rcu_read_lock hold times.
> 
> I would contend that a reasonable cleanup based up on the current state
> of the code would be to extend the rcu_read_lock over get_task_mm so

If so, security_task_movememory will be called inside rcu lock. It might
call sleeping functions, e.g. smack_log(). I think it's not a good idea.

> that a reference to task_struct does not need to be taken.  That has
> the potential to reduce contention and reduce lock hold times.
> 
> 
> The code is missing a big fat comment with the assertion that it is ok
> if the permission checks are racy because the race is small, and the
> worst case thing that happens is the page is migrated to another
> numa node.
> 
> 
> Given that the get_mm_task takes task_lock the cost of dirtying the
> cache line is already being paid.  Perhaps not extending task_lock hold
> times a little bit is justified, but I haven't seen that case made.
> 
> This seems like code that is called little enough it would be better for
> it to be correct, and not need big fat comments explaining why it
> doesn't matter that they code is deliberately buggy.
> 

Agree. A big fat comments will make code hard to follow.

> 
> In short it does not make sense to me to justify a patch for performance
> reasons when it appears that extending the rcu_read_lock hold time and
> not touch the task reference count would stop dirtying a cache line and
> likely have more impact.

IMHO, incremented task refcount should make code works correctly. And extending
the rcu_read_lock over get_task_mm will break the things because sleeping functions
might be called while holding rcu lock.

Does the patch itself makes sense for you? Should I rephase the commit log further?
I'm afraid I didn't get your point correctly.

> 
> Eric

Thanks!

> .
> 

