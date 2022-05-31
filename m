Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE6B538B2F
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 08:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244175AbiEaGGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 02:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238360AbiEaGGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 02:06:40 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378FB2E7
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 23:06:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653977198; x=1685513198;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eTcJ59lDbXzwiy/p35YXCSINz+6XPaJju471Z3f6x5w=;
  b=Gzrw4VLwFzU1y4+sy3XhjPNN54WvAeMu7prtXuR79TrHB4fIrDV0UaVc
   cOltpamkwNhCkxdG5QjLoNBi1ijY4tHfP/Urw0mN2DstbFjwixp2DtHN1
   YqNbq3cyv/SiiK7Z6H4+t4e0tlGr2DchRU9Ybmak7M/GNG7FvIJ7S6n6o
   eXBuqyLrLbyqeEKmQmrvOUSrNcU4HA2N2i00fWthNlUKUG37pw1bZ7fKZ
   JYg0lsWE7j6cBBG6VkS6FgiV+gv3Dt8l1o9rRHWjguamkHIO0B4uwT6aJ
   5Ka2HWk4pwfSdPrqA6R6+QB+mITZvry7YJzpP8jgUmXtRRqSeYxvu0X2I
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="275156766"
X-IronPort-AV: E=Sophos;i="5.91,264,1647327600"; 
   d="scan'208";a="275156766"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 23:06:37 -0700
X-IronPort-AV: E=Sophos;i="5.91,264,1647327600"; 
   d="scan'208";a="551626763"
Received: from quanliu1-mobl.ccr.corp.intel.com ([10.254.215.142])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2022 23:06:33 -0700
Message-ID: <bbc060ca6e967790423e0a3ca940d1e700447554.camel@intel.com>
Subject: Re: [PATCH v4 1/4] mm: reduce the rcu lock duration
From:   Ying Huang <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org,
        naoya.horiguchi@nec.com
Cc:     peterx@redhat.com, apopple@nvidia.com, osalvador@suse.de,
        mike.kravetz@oracle.com, songmuchun@bytedance.com, hch@lst.de,
        dhowells@redhat.com, cl@linux.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>
Date:   Tue, 31 May 2022 14:06:30 +0800
In-Reply-To: <20220530113016.16663-2-linmiaohe@huawei.com>
References: <20220530113016.16663-1-linmiaohe@huawei.com>
         <20220530113016.16663-2-linmiaohe@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-05-30 at 19:30 +0800, Miaohe Lin wrote:
> Commit 3268c63eded4 ("mm: fix move/migrate_pages() race on task struct")
> extends the period of the rcu_read_lock until after the permissions checks
> are done to prevent the task pointed to from changing from under us. But
> the task_struct refcount is also taken at that time, the reference to task
> is guaranteed to be stable. So it's unnecessary to extend the period of
> the rcu_read_lock. Release the rcu lock after task refcount is successfully
> grabbed to reduce the rcu holding time.

Sorry for late reply, I am busy on something else recently.

I have just read the whole thread of the original patch discussion. 
During discussion, in

https://lore.kernel.org/lkml/alpine.DEB.2.00.1202241131400.3726@router.home/

a patch that is same as your one is proposed.  Then in the following
message, Eric think that the rcu read lock should be released until
permission is checked,

https://lore.kernel.org/lkml/87sjhzun47.fsf@xmission.com/

"
At the moment I suspect the permissions checks are not safe unless
performed under both rcu_read_lock and task_lock to ensure that
the task<->mm association does not change on us while we are
working.  Even with that the cred can change under us but at least
we know the cred will be valid until rcu_read_unlock happens.
"

So the rcu lock duration is enlarged in the following message.

https://lore.kernel.org/lkml/alpine.DEB.2.00.1202271238450.32410@router.home/

But, after some thought, I don't think extended rcu read lock adds much
value.  Because after permission checking the permission may still be
changed.  There's no much difference.

So, I have no objection to the patch itself.  But you should add more
information in patch description about why the RCU proected region is
extended and why we can reduce it.

Best Regards,
Huang, Ying

> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Christoph Lameter <cl@linux.com>
> ---
>  mm/mempolicy.c | 3 +--
>  mm/migrate.c   | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 0b4ba3ee810e..2dad094177bf 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1609,6 +1609,7 @@ static int kernel_migrate_pages(pid_t pid, unsigned long maxnode,
>  		goto out;
>  	}
>  	get_task_struct(task);
> +	rcu_read_unlock();
>  
> 
> 
> 
>  	err = -EINVAL;
>  
> 
> 
> 
> @@ -1617,11 +1618,9 @@ static int kernel_migrate_pages(pid_t pid, unsigned long maxnode,
>  	 * Use the regular "ptrace_may_access()" checks.
>  	 */
>  	if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
> -		rcu_read_unlock();
>  		err = -EPERM;
>  		goto out_put;
>  	}
> -	rcu_read_unlock();
>  
> 
> 
> 
>  	task_nodes = cpuset_mems_allowed(task);
>  	/* Is the user allowed to access the target nodes? */
> diff --git a/mm/migrate.c b/mm/migrate.c
> index e51588e95f57..e88ebb88fa6f 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1902,17 +1902,16 @@ static struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes)
>  		return ERR_PTR(-ESRCH);
>  	}
>  	get_task_struct(task);
> +	rcu_read_unlock();
>  
> 
> 
> 
>  	/*
>  	 * Check if this process has the right to modify the specified
>  	 * process. Use the regular "ptrace_may_access()" checks.
>  	 */
>  	if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
> -		rcu_read_unlock();
>  		mm = ERR_PTR(-EPERM);
>  		goto out;
>  	}
> -	rcu_read_unlock();
>  
> 
> 
> 
>  	mm = ERR_PTR(security_task_movememory(task));
>  	if (IS_ERR(mm))


