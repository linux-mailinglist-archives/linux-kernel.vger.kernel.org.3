Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 669024D16E0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 13:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241870AbiCHMKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 07:10:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234183AbiCHMKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 07:10:17 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10888338BB
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 04:09:20 -0800 (PST)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KCYsT5fmxzbcCZ;
        Tue,  8 Mar 2022 20:04:29 +0800 (CST)
Received: from [10.174.177.76] (10.174.177.76) by
 canpemm500002.china.huawei.com (7.192.104.244) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 8 Mar 2022 20:09:16 +0800
Subject: Re: [PATCH 04/16] mm/migration: reduce the rcu lock duration
To:     "Huang, Ying" <ying.huang@intel.com>
CC:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <shy828301@gmail.com>, <willy@infradead.org>, <ziy@nvidia.com>,
        <minchan@kernel.org>, <apopple@nvidia.com>,
        <ave.hansen@linux.intel.com>, <o451686892@gmail.com>,
        <almasrymina@google.com>, <jhubbard@nvidia.com>,
        <rcampbell@nvidia.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <mhocko@suse.com>, <riel@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Christoph Lameter <cl@linux.com>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20220304093409.25829-1-linmiaohe@huawei.com>
 <20220304093409.25829-5-linmiaohe@huawei.com>
 <8735ju7as9.fsf@yhuang6-desk2.ccr.corp.intel.com>
From:   Miaohe Lin <linmiaohe@huawei.com>
Message-ID: <2eb3fc34-3c81-394f-3bca-8eb00027afcf@huawei.com>
Date:   Tue, 8 Mar 2022 20:09:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <8735ju7as9.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset="windows-1252"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.76]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

On 2022/3/7 10:32, Huang, Ying wrote:
> Miaohe Lin <linmiaohe@huawei.com> writes:
> 
>> rcu_read_lock is required by grabbing the task refcount but it's not
>> needed for ptrace_may_access. So we could release the rcu lock after
>> task refcount is successfully grabbed to reduce the rcu holding time.
>>
>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>> ---
>>  mm/migrate.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/mm/migrate.c b/mm/migrate.c
>> index da5a81052468..26943bd819e8 100644
>> --- a/mm/migrate.c
>> +++ b/mm/migrate.c
>> @@ -1907,17 +1907,16 @@ static struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes)
>>  		return ERR_PTR(-ESRCH);
>>  	}
>>  	get_task_struct(task);
>> +	rcu_read_unlock();
>>  
>>  	/*
>>  	 * Check if this process has the right to modify the specified
>>  	 * process. Use the regular "ptrace_may_access()" checks.
>>  	 */
>>  	if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
>> -		rcu_read_unlock();
>>  		mm = ERR_PTR(-EPERM);
>>  		goto out;
>>  	}
>> -	rcu_read_unlock();
>>  
>>  	mm = ERR_PTR(security_task_movememory(task));
>>  	if (IS_ERR(mm))
> 
> Digged some history via `git blame`, found that the RCU read lock is
> extended in the following commit,
> 
> "
> 3268c63eded4612a3d07b56d1e02ce7731e6608e
> Author:     Christoph Lameter <cl@linux.com>
> AuthorDate: Wed Mar 21 16:34:06 2012 -0700
> Commit:     Linus Torvalds <torvalds@linux-foundation.org>
> CommitDate: Wed Mar 21 17:54:58 2012 -0700
> 
> mm: fix move/migrate_pages() race on task struct
> 
> Migration functions perform the rcu_read_unlock too early.  As a result
> the task pointed to may change from under us.  This can result in an oops,
> as reported by Dave Hansen in https://lkml.org/lkml/2012/2/23/302.
> 
> The following patch extend the period of the rcu_read_lock until after the
> permissions checks are done.  We also take a refcount so that the task
> reference is stable when calling security check functions and performing
> cpuset node validation (which takes a mutex).
> 
> The refcount is dropped before actual page migration occurs so there is no
> change to the refcounts held during page migration.
> 
> Also move the determination of the mm of the task struct to immediately
> before the do_migrate*() calls so that it is clear that we switch from
> handling the task during permission checks to the mm for the actual
> migration.  Since the determination is only done once and we then no
> longer use the task_struct we can be sure that we operate on a specific
> address space that will not change from under us.
> "
> 
> After that, the permission checking has been changed from __task_cred()
> to ptrace_may_access().  So the situation may change somewhat.  Cced

In ptrace_may_access, __task_cred is access while holding the rcu read lock.
It seems this is ensured by the ptrace_may_access itself.

> some names found in git history to verify.

Thanks for your carefulness.

> 
> Best Regards,
> Huang, Ying
> .
> 

