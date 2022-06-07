Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAF4653F97C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:20:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239346AbiFGJUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239364AbiFGJT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:19:58 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7C6E64E8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 02:19:56 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LHPsW1TyWzbfND;
        Tue,  7 Jun 2022 17:18:07 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 17:19:54 +0800
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
 <e10023d7-3d19-1edf-86af-4cb79071b78f@huawei.com>
 <87y1yga1r2.fsf@email.froward.int.ebiederm.org>
 <cb17bad6-dbfa-013c-f879-c1883575f72b@huawei.com>
 <87ilph90dx.fsf@email.froward.int.ebiederm.org>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <a836d04a-d26b-3eea-3e0e-27af0d2d9651@huawei.com>
Date:   Tue, 7 Jun 2022 17:19:53 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <87ilph90dx.fsf@email.froward.int.ebiederm.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/4 0:28, Eric W. Biederman wrote:
> Miaohe Lin <linmiaohe@huawei.com> writes:
> 
>> On 2022/6/1 22:37, Eric W. Biederman wrote:
>>> Miaohe Lin <linmiaohe@huawei.com> writes:
>>>
>>>> On 2022/6/1 0:09, Eric W. Biederman wrote:
>>>>> Miaohe Lin <linmiaohe@huawei.com> writes:
>>>> snip
>>>>>>
>>>>>> "
>>>>>> Commit 3268c63eded4 ("mm: fix move/migrate_pages() race on task struct")
>>>>>> extends the period of the rcu_read_lock until after the permissions checks
>>>>>> are done because it suspects the permissions checks are not safe unless
>>>>>> performed under both rcu_read_lock and task_lock to ensure the task<->mm
>>>>>> association does not change on us while we are working [1]. But extended
>>>>>> rcu read lock does not add much value. Because after permission checking
>>>>>> the permission may still be changed. There's no much difference. So it's
>>>>>> unnecessary to extend the period of the rcu_read_lock. Release the rcu
>>>>>> lock after task refcount is successfully grabbed to reduce the rcu holding
>>>>>> time.
>>>>>>
>>>>>> [1] https://lore.kernel.org/lkml/87sjhzun47.fsf@xmission.com/
>>>>>> "
>>>>>
>>>>> It doesn't make sense to me.
>>>>>
>>>>> I don't see any sleeping functions called from find_mm_struct or
>>>>> kernel_migrate_pages in the area kernel_migrate_pages in the area of the
>>>>> code protected by get_task_struct.  So at a very basic level I see a
>>>>> justification for dirtying a cache line twice with get_task_struct and
>>>>> put_task_struct to reduce rcu_read_lock hold times.
>>>>>
>>>>> I would contend that a reasonable cleanup based up on the current state
>>>>> of the code would be to extend the rcu_read_lock over get_task_mm so
>>>>
>>>> If so, security_task_movememory will be called inside rcu lock. It might
>>>> call sleeping functions, e.g. smack_log(). I think it's not a good
>>>> idea.
>>>
>>> In general the security functions are not allowed to sleep.
>>> The audit mechanism typically preallocates memory so it does
>>> not need to sleep.  From a quick skim through the code I don't
>>> see smack_log sleeping.
>>>
>>> Certainly the security hooks are not supposed to be inserted into the
>>> code that they prevent reasonable implementation decisions.
>>>
>>> Which is to say if there is a good (non-security hook reason) for
>>> supporting sleeping deal with it.  Otherwise the security hooks has a
>>> bug and needs to get fixed/removed.
>>
>> I see. Many thanks for explanation.
>>
>>>
>>>>> that a reference to task_struct does not need to be taken.  That has
>>>>> the potential to reduce contention and reduce lock hold times.
>>>>>
>>>>>
>>>>> The code is missing a big fat comment with the assertion that it is ok
>>>>> if the permission checks are racy because the race is small, and the
>>>>> worst case thing that happens is the page is migrated to another
>>>>> numa node.
>>>>>
>>>>>
>>>>> Given that the get_mm_task takes task_lock the cost of dirtying the
>>>>> cache line is already being paid.  Perhaps not extending task_lock hold
>>>>> times a little bit is justified, but I haven't seen that case made.
>>>>>
>>>>> This seems like code that is called little enough it would be better for
>>>>> it to be correct, and not need big fat comments explaining why it
>>>>> doesn't matter that they code is deliberately buggy.
>>>>>
>>>>
>>>> Agree. A big fat comments will make code hard to follow.
>>>
>>> No.
>>>
>>> The code is impossible to follow currently.
>>>
>>> The code either requires a comment pointing out that it is deliberately
>>> racy, or the code needs to be fixed.
>>>
>>> Clever and subtle code always requires a comment if for no other
>>> reason then to alert the reader that something a typical is going on.
>>
>> Yes, clever and subtle code requires a comment but others might not.
>>
>>>
>>>>> In short it does not make sense to me to justify a patch for performance
>>>>> reasons when it appears that extending the rcu_read_lock hold time and
>>>>> not touch the task reference count would stop dirtying a cache line and
>>>>> likely have more impact.
>>>>
>>>> IMHO, incremented task refcount should make code works correctly. And extending
>>>> the rcu_read_lock over get_task_mm will break the things because sleeping functions
>>>> might be called while holding rcu lock.
>>>
>>> Which sleeping functions?
>>>
>>> I can't find any.  In particular smack_task_movememory calls
>>> smk_curacc_on_task which is the same function called by
>>> security_task_getpgid.  security_task_getpgid is called
>>> under rcu_read_lock.  So smack won't sleep.
>>
>> Sorry, I didn't take a close look at smack_log code. So I thought it could sleep.
>>
>>>
>>>> Does the patch itself makes sense for you? Should I rephase the commit log further?
>>>> I'm afraid I didn't get your point correctly.
>>>
>>> The patch makes no sense to me because I don't see it doing anything
>>> worth doing.
>>>
>>> get/put_task_struct both dirty a cache line and are expensive especially
>>> when contended.  Dirtying a cache line that is contended is the pretty
>>> much the most expensive native cpu operation.  In pathological scenarios
>>> I have seen it take up to 1s.  Realistically in a cache cold scenario
>>> (which is not as bad as a contended scenario) you are looking at 100ns
>>> or more just to execute get_task_struct/put_task_struct.  That is the
>>> kind of cost it would be nice to avoid all together (even if the
>>> pathological case never comes up).
>>>
>>> So I see two pieces of code where we could use the cheap operation
>>> rcu_read_lock/rcu_read_unlock to remove the expensive operation
>>> get_task_struct/put_task_struct.  Instead I see people removing
>>> rcu_read_lock/rcu_read_unlock.
>>>
>>> That makes no sense.  Especially as your implied reason for making this
>>> change is to make the code have better performance.  Improving
>>> performance is the reason for making critical sections smaller isn't it?
>>>
>>
>> I think you're right. We should extend the rcu_read_lock over get_task_mm so we can
>> remove the expensive operation get_task_struct/put_task_struct and thus avoid possible
>> cacheline penalty. But is the extended rcu lock enough to ensure the task reference
>> is stable when calling security check functions and performing cpuset node validation?
>> Or this race is just OK and can be left alone with a comment?
> 
> The extending the rcu_read_lock is just about removing the expense of
> get_task_struct/put_task_struct.  It can be handled separately from
> other issues at play in this code.
> 
> 
> The rcu_read_lock guarantees that task does not go away.  The
> rcu_read_lock does not guarantee that task->mm does not change.
> 

It seems task_lock is needed in this case.

> 
> 
> A separate but related issue is should the task_lock in get_task_mm
> be extended to cover the security checks so that everything checks
> against the same mm.
> 
> Possibly the code could be refactored or reordered so that everything
> is guaranteed to check against the same mm.

IMHO, it might be overkill to do this.

> 
> 
> If the checks are not made to guarantee they are all checking against
> the same mm, the code needs a comment to say that there is a tiny race.
> The comment should say we don't care about the tiny race because
> the worst that can happen is that a page is migrated to a different
> numa node.  And so we don't care.
> 
> 

I tend to do this one. To make sure, is the below code change what you suggest?

diff --git a/mm/mempolicy.c b/mm/mempolicy.c
index 3c64f3cdac4b..943f58eff1fc 100644
--- a/mm/mempolicy.c
+++ b/mm/mempolicy.c
@@ -1612,42 +1612,43 @@ static int kernel_migrate_pages(pid_t pid, unsigned long maxnode,
        rcu_read_lock();
        task = pid ? find_task_by_vpid(pid) : current;
        if (!task) {
-               rcu_read_unlock();
                err = -ESRCH;
-               goto out;
+               goto out_unlock;
        }
-       get_task_struct(task);
-       rcu_read_unlock();

        err = -EINVAL;

        /*
         * Check if this process has the right to modify the specified process.
         * Use the regular "ptrace_may_access()" checks.
+        * The below checks are not made to guarantee they are all checking
+        * against the same mm. But we don't care about such tiny race because
+        * the worst that can happen is that a page is migrated to a different
+        * numa node. And so we don't care.
         */
        if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
                err = -EPERM;
-               goto out_put;
+               goto out_unlock;
        }

        task_nodes = cpuset_mems_allowed(task);
        /* Is the user allowed to access the target nodes? */
        if (!nodes_subset(*new, task_nodes) && !capable(CAP_SYS_NICE)) {
                err = -EPERM;
-               goto out_put;
+               goto out_unlock;
        }

        task_nodes = cpuset_mems_allowed(current);
        nodes_and(*new, *new, task_nodes);
        if (nodes_empty(*new))
-               goto out_put;
+               goto out_unlock;

        err = security_task_movememory(task);
        if (err)
-               goto out_put;
+               goto out_unlock;

        mm = get_task_mm(task);
-       put_task_struct(task);
+       rcu_read_unlock();

        if (!mm) {
                err = -EINVAL;
@@ -1663,8 +1664,8 @@ static int kernel_migrate_pages(pid_t pid, unsigned long maxnode,

        return err;

-out_put:
-       put_task_struct(task);
+out_unlock:
+       rcu_read_unlock();
        goto out;

 }

> Eric

Many thanks for your valuable suggestion!

> .
> 

