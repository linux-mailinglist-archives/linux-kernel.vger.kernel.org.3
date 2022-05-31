Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AD11538D5E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 11:01:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245039AbiEaJBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 05:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233830AbiEaJBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 05:01:14 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D54913D1F
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 02:01:12 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LC5lc5Yl6zRhXZ;
        Tue, 31 May 2022 16:58:04 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 31 May 2022 17:01:09 +0800
Subject: Re: [PATCH v4 1/4] mm: reduce the rcu lock duration
To:     Ying Huang <ying.huang@intel.com>
CC:     <peterx@redhat.com>, <apopple@nvidia.com>, <osalvador@suse.de>,
        <mike.kravetz@oracle.com>, <songmuchun@bytedance.com>,
        <hch@lst.de>, <dhowells@redhat.com>, <cl@linux.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        <akpm@linux-foundation.org>, <naoya.horiguchi@nec.com>
References: <20220530113016.16663-1-linmiaohe@huawei.com>
 <20220530113016.16663-2-linmiaohe@huawei.com>
 <bbc060ca6e967790423e0a3ca940d1e700447554.camel@intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <b2ddcd64-2779-ede9-3615-ad5bc90a3bc1@huawei.com>
Date:   Tue, 31 May 2022 17:01:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <bbc060ca6e967790423e0a3ca940d1e700447554.camel@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
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

On 2022/5/31 14:06, Ying Huang wrote:
> On Mon, 2022-05-30 at 19:30 +0800, Miaohe Lin wrote:
>> Commit 3268c63eded4 ("mm: fix move/migrate_pages() race on task struct")
>> extends the period of the rcu_read_lock until after the permissions checks
>> are done to prevent the task pointed to from changing from under us. But
>> the task_struct refcount is also taken at that time, the reference to task
>> is guaranteed to be stable. So it's unnecessary to extend the period of
>> the rcu_read_lock. Release the rcu lock after task refcount is successfully
>> grabbed to reduce the rcu holding time.
> 
> Sorry for late reply, I am busy on something else recently.

That's all right. Many thanks for your hard work. :)

> 
> I have just read the whole thread of the original patch discussion. 
> During discussion, in
> 
> https://lore.kernel.org/lkml/alpine.DEB.2.00.1202241131400.3726@router.home/
> 
> a patch that is same as your one is proposed.  Then in the following
> message, Eric think that the rcu read lock should be released until
> permission is checked,
> 
> https://lore.kernel.org/lkml/87sjhzun47.fsf@xmission.com/
> 
> "
> At the moment I suspect the permissions checks are not safe unless
> performed under both rcu_read_lock and task_lock to ensure that
> the task<->mm association does not change on us while we are
> working.  Even with that the cred can change under us but at least
> we know the cred will be valid until rcu_read_unlock happens.
> "
> 
> So the rcu lock duration is enlarged in the following message.
> 
> https://lore.kernel.org/lkml/alpine.DEB.2.00.1202271238450.32410@router.home/
> 
> But, after some thought, I don't think extended rcu read lock adds much
> value.  Because after permission checking the permission may still be
> changed.  There's no much difference.
> 
> So, I have no objection to the patch itself.  But you should add more
> information in patch description about why the RCU proected region is
> extended and why we can reduce it.

Does below patch description makes sense for you?

"
Commit 3268c63eded4 ("mm: fix move/migrate_pages() race on task struct")
extends the period of the rcu_read_lock until after the permissions checks
are done because it suspects the permissions checks are not safe unless
performed under both rcu_read_lock and task_lock to ensure the task<->mm
association does not change on us while we are working [1]. But extended
rcu read lock does not add much value. Because after permission checking
the permission may still be changed. There's no much difference. So it's
unnecessary to extend the period of the rcu_read_lock. Release the rcu
lock after task refcount is successfully grabbed to reduce the rcu holding
time.

[1] https://lore.kernel.org/lkml/87sjhzun47.fsf@xmission.com/
"

> 
> Best Regards,
> Huang, Ying

Thanks again!

> 
>> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>> Reviewed-by: Oscar Salvador <osalvador@suse.de>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> Cc: Huang Ying <ying.huang@intel.com>
>> Cc: David Howells <dhowells@redhat.com>
>> Cc: Christoph Lameter <cl@linux.com>
>> ---
>>  mm/mempolicy.c | 3 +--
>>  mm/migrate.c   | 3 +--
>>  2 files changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
>> index 0b4ba3ee810e..2dad094177bf 100644
>> --- a/mm/mempolicy.c
>> +++ b/mm/mempolicy.c
>> @@ -1609,6 +1609,7 @@ static int kernel_migrate_pages(pid_t pid, unsigned long maxnode,
>>  		goto out;
>>  	}
>>  	get_task_struct(task);
>> +	rcu_read_unlock();
>>  
>>
>>
>>
>>  	err = -EINVAL;
>>  
>>
>>
>>
>> @@ -1617,11 +1618,9 @@ static int kernel_migrate_pages(pid_t pid, unsigned long maxnode,
>>  	 * Use the regular "ptrace_may_access()" checks.
>>  	 */
>>  	if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
>> -		rcu_read_unlock();
>>  		err = -EPERM;
>>  		goto out_put;
>>  	}
>> -	rcu_read_unlock();
>>  
>>
>>
>>
>>  	task_nodes = cpuset_mems_allowed(task);
>>  	/* Is the user allowed to access the target nodes? */
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index e51588e95f57..e88ebb88fa6f 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1902,17 +1902,16 @@ static struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes)
>>  		return ERR_PTR(-ESRCH);
>>  	}
>>  	get_task_struct(task);
>> +	rcu_read_unlock();
>>  
>>
>>
>>
>>  	/*
>>  	 * Check if this process has the right to modify the specified
>>  	 * process. Use the regular "ptrace_may_access()" checks.
>>  	 */
>>  	if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
>> -		rcu_read_unlock();
>>  		mm = ERR_PTR(-EPERM);
>>  		goto out;
>>  	}
>> -	rcu_read_unlock();
>>  
>>
>>
>>
>>  	mm = ERR_PTR(security_task_movememory(task));
>>  	if (IS_ERR(mm))
> 
> 
> 
> .
> 

