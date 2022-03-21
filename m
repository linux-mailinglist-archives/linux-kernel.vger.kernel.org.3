Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7D354E261A
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 13:12:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347202AbiCUMNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 08:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347204AbiCUMN2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 08:13:28 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C1CD1637DC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 05:12:03 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id E5C121F37C;
        Mon, 21 Mar 2022 12:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647864721; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HXN2HJbm0BalOg6bKSVLRWcC3/+l/IIQZD7njTj+fkY=;
        b=Gp5wTZrlgDRMAvh0Z5GT/FdxVrOxd2/PEdp/s8VyoCs1Tf/frU9tKWVlD3b1Oj2K52kHGK
        Rn642mUFD/XZfjiChzHFzCQx/bFl7iKxanOCrwvKum5LAhQcETFpFH2JejFnsJko0vqj1v
        nkk2dvYKroeeiJLyuHJaIXDHNPTzhHM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A6407A3B81;
        Mon, 21 Mar 2022 12:12:00 +0000 (UTC)
Date:   Mon, 21 Mar 2022 13:12:00 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, kosaki.motohiro@jp.fujitsu.com,
        mgorman@suse.de, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mm/mempolicy: fix mpol_new leak in
 shared_policy_replace
Message-ID: <YjhrkDlvOnmqIP6n@dhcp22.suse.cz>
References: <20220322083456.16563-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322083456.16563-1-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-03-22 16:34:56, Miaohe Lin wrote:
> If mpol_new is allocated but not used in restart loop, mpol_new will be
> freed via mpol_put before returning to the caller.  But refcnt is not
> initialized yet, so mpol_put could not do the right things and might leak
> the unused mpol_new.

I would just add:

This would happen if mempolicy was updated on the shared shmem file
while the sp->lock has been dropped during the memory allocation.

> This issue could be triggered easily with the below
> code snippet if there're many processes doing the below work at the same
> time:
> 
>   shmid = shmget((key_t)5566, 1024 * PAGE_SIZE, 0666|IPC_CREAT);
>   shm = shmat(shmid, 0, 0);
>   loop many times {
>     mbind(shm, 1024 * PAGE_SIZE, MPOL_LOCAL, mask, maxnode, 0);
>     mbind(shm + 128 * PAGE_SIZE, 128 * PAGE_SIZE, MPOL_DEFAULT, mask,
>           maxnode, 0);
>   }
> 
> Fixes: 42288fe366c4 ("mm: mempolicy: Convert shared_policy mutex to spinlock")
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Cc: <stable@vger.kernel.org> # 3.8

Acked-by: Michal Hocko <mhocko@suse.com>

Thanks a lot!
> ---
> v1->v2:
>   Add reproducer snippet and Cc stable.
>   Thanks Michal Hocko for review and comment!
> ---
>  mm/mempolicy.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index a2516d31db6c..4cdd425b2752 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2733,6 +2733,7 @@ static int shared_policy_replace(struct shared_policy *sp, unsigned long start,
>  	mpol_new = kmem_cache_alloc(policy_cache, GFP_KERNEL);
>  	if (!mpol_new)
>  		goto err_out;
> +	refcount_set(&mpol_new->refcnt, 1);
>  	goto restart;
>  }
>  
> -- 
> 2.23.0

-- 
Michal Hocko
SUSE Labs
