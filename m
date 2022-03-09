Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9974F4D25CB
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 02:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbiCIBOS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 20:14:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbiCIBNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 20:13:08 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F05169218
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 17:02:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646787772; x=1678323772;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=WqYjw0riMyrcnpYGzd3LwwF0KxaWZQvCdtVqi7q+5xA=;
  b=GgJtk2hZrmj1cZwgI3jFXwY0P10qfGVucqzbI/VaO2Cvb0QNsoY9IB/V
   9PXcnWzvjICSQaMce59SR/VFL7FpW/+SYuQ+atcZ6IFIx9pLB5trsUwbl
   24Zjjvzc+FUUn5L0xh1zU/NReNtd9bDG27w2R5JqzueygMLcBzwb4k6PO
   8veErQmxMqiUYtXyTBCgdKlnc0qC1/67ECCjL+sr7IAZauErrhUWOyWbU
   cV2VXxUwSfYwTVZq5OTj2dZocGXSlWyiYQaKA/pe+ElDrQZsGxD8TCrKZ
   rx7yUHbvpAtJSx2EpS5YdJuxlW6XEoZT76NHbCRhLcaZdPFG2MeAcDFU6
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10280"; a="242298570"
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="242298570"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 17:02:52 -0800
X-IronPort-AV: E=Sophos;i="5.90,165,1643702400"; 
   d="scan'208";a="513330922"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.239.13.94])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2022 17:02:47 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <shy828301@gmail.com>, <willy@infradead.org>, <ziy@nvidia.com>,
        <minchan@kernel.org>, <apopple@nvidia.com>,
        <ave.hansen@linux.intel.com>, <o451686892@gmail.com>,
        <almasrymina@google.com>, <jhubbard@nvidia.com>,
        <rcampbell@nvidia.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <mhocko@suse.com>, <riel@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Christoph Lameter <cl@linux.com>,
        "David Howells" <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 04/16] mm/migration: reduce the rcu lock duration
References: <20220304093409.25829-1-linmiaohe@huawei.com>
        <20220304093409.25829-5-linmiaohe@huawei.com>
        <8735ju7as9.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <2eb3fc34-3c81-394f-3bca-8eb00027afcf@huawei.com>
Date:   Wed, 09 Mar 2022 09:02:45 +0800
In-Reply-To: <2eb3fc34-3c81-394f-3bca-8eb00027afcf@huawei.com> (Miaohe Lin's
        message of "Tue, 8 Mar 2022 20:09:15 +0800")
Message-ID: <87y21key4q.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miaohe Lin <linmiaohe@huawei.com> writes:

> On 2022/3/7 10:32, Huang, Ying wrote:
>> Miaohe Lin <linmiaohe@huawei.com> writes:
>> 
>>> rcu_read_lock is required by grabbing the task refcount but it's not
>>> needed for ptrace_may_access. So we could release the rcu lock after
>>> task refcount is successfully grabbed to reduce the rcu holding time.
>>>
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> ---
>>>  mm/migrate.c | 3 +--
>>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>>
>>> diff --git a/mm/migrate.c b/mm/migrate.c
>>> index da5a81052468..26943bd819e8 100644
>>> --- a/mm/migrate.c
>>> +++ b/mm/migrate.c
>>> @@ -1907,17 +1907,16 @@ static struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes)
>>>  		return ERR_PTR(-ESRCH);
>>>  	}
>>>  	get_task_struct(task);
>>> +	rcu_read_unlock();
>>>  
>>>  	/*
>>>  	 * Check if this process has the right to modify the specified
>>>  	 * process. Use the regular "ptrace_may_access()" checks.
>>>  	 */
>>>  	if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
>>> -		rcu_read_unlock();
>>>  		mm = ERR_PTR(-EPERM);
>>>  		goto out;
>>>  	}
>>> -	rcu_read_unlock();
>>>  
>>>  	mm = ERR_PTR(security_task_movememory(task));
>>>  	if (IS_ERR(mm))
>> 
>> Digged some history via `git blame`, found that the RCU read lock is
>> extended in the following commit,
>> 
>> "
>> 3268c63eded4612a3d07b56d1e02ce7731e6608e
>> Author:     Christoph Lameter <cl@linux.com>
>> AuthorDate: Wed Mar 21 16:34:06 2012 -0700
>> Commit:     Linus Torvalds <torvalds@linux-foundation.org>
>> CommitDate: Wed Mar 21 17:54:58 2012 -0700
>> 
>> mm: fix move/migrate_pages() race on task struct
>> 
>> Migration functions perform the rcu_read_unlock too early.  As a result
>> the task pointed to may change from under us.  This can result in an oops,
>> as reported by Dave Hansen in https://lkml.org/lkml/2012/2/23/302.
>> 
>> The following patch extend the period of the rcu_read_lock until after the
>> permissions checks are done.  We also take a refcount so that the task
>> reference is stable when calling security check functions and performing
>> cpuset node validation (which takes a mutex).
>> 
>> The refcount is dropped before actual page migration occurs so there is no
>> change to the refcounts held during page migration.
>> 
>> Also move the determination of the mm of the task struct to immediately
>> before the do_migrate*() calls so that it is clear that we switch from
>> handling the task during permission checks to the mm for the actual
>> migration.  Since the determination is only done once and we then no
>> longer use the task_struct we can be sure that we operate on a specific
>> address space that will not change from under us.
>> "
>> 
>> After that, the permission checking has been changed from __task_cred()
>> to ptrace_may_access().  So the situation may change somewhat.  Cced
>
> In ptrace_may_access, __task_cred is access while holding the rcu read lock.
> It seems this is ensured by the ptrace_may_access itself.

Please read the patch above.  Before extending rcu_read_lock protected
region, __task_cred() is protected by rcu_read_lock already.  The patch
above combines 2 regions into 1.

Best Regards,
Huang, Ying

>> some names found in git history to verify.
>
> Thanks for your carefulness.
>
>> 
>> Best Regards,
>> Huang, Ying
>> .
>> 
