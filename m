Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8F14FCC31
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 04:08:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244302AbiDLCJx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 22:09:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244392AbiDLCJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 22:09:43 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E9133A38
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 19:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649729244; x=1681265244;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6kiwW3/nUQ5dHrFHY7pnkV2uT9+KRnLaqlbep6xwdc8=;
  b=ModvDwpkP0+rhHpkVPlBEFw4739XzeaddNk3q9iOdvfPYNNg/2iLp8+r
   1KfKXAmclYI0Q46tvw7AhRiCgHionPvnb3QzjQdh2+DG19N/rCeqSIywV
   Ot9Pl0woaCZPP+GMl66tXgwFk8aQqcmTUOFU0dZCf0g4Rv4pFBIgKSkF5
   AdzKe5BoPFz+4EAlqz67t5XypA28nvMInAhzsb7LI2gv1thFhRMopIsp+
   rE5WQFl/cNiaD5f6FLDKb/lp57tVQBr5X/GC7TU+dRve5vH3yR7FBkYgP
   8zm0VMoH+HFUr0Zr61HMu86lpM5I1O8+4YZRk6cHmQOe40a5ysbQBqjsX
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="259853341"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="259853341"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 19:07:23 -0700
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="551486957"
Received: from joliu-mobl2.ccr.corp.intel.com ([10.254.214.243])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 19:07:18 -0700
Message-ID: <557be6cc7ecdee357391df3fe94e5573f9e1746d.camel@intel.com>
Subject: Re: [PATCH 1/4] mm/migration: reduce the rcu lock duration
From:   "ying.huang@intel.com" <ying.huang@intel.com>
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     mike.kravetz@oracle.com, shy828301@gmail.com, willy@infradead.org,
        ziy@nvidia.com, minchan@kernel.org, apopple@nvidia.com,
        dave.hansen@linux.intel.com, o451686892@gmail.com,
        jhubbard@nvidia.com, peterx@redhat.com, naoya.horiguchi@nec.com,
        mhocko@suse.com, riel@redhat.com, osalvador@suse.de,
        david@redhat.com, sfr@canb.auug.org.au, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Date:   Tue, 12 Apr 2022 10:07:15 +0800
In-Reply-To: <20220409073846.22286-2-linmiaohe@huawei.com>
References: <20220409073846.22286-1-linmiaohe@huawei.com>
         <20220409073846.22286-2-linmiaohe@huawei.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-04-09 at 15:38 +0800, Miaohe Lin wrote:
> rcu_read_lock is required by grabbing the task refcount but it's not
> needed for ptrace_may_access. So we could release the rcu lock after
> task refcount is successfully grabbed to reduce the rcu holding time.
> 
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  mm/migrate.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/mm/migrate.c b/mm/migrate.c
> index a3d8c2be2631..d8aae6c75990 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1907,17 +1907,16 @@ static struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes)
>  		return ERR_PTR(-ESRCH);
>  	}
>  	get_task_struct(task);
> +	rcu_read_unlock();
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
>  	mm = ERR_PTR(security_task_movememory(task));
>  	if (IS_ERR(mm))

Why do you ignore our discussion for the previous version?

https://lore.kernel.org/linux-mm/8735ju7as9.fsf@yhuang6-desk2.ccr.corp.intel.com/

Best Regards,
Huang, Ying


