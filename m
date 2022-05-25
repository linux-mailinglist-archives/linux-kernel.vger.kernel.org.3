Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAAEC533887
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 10:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234649AbiEYIc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 04:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbiEYIct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 04:32:49 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8912355AD
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 01:32:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 477771F8F0;
        Wed, 25 May 2022 08:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1653467567; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pk+dd2y8fS3J24I3QMHCkhSgrc5nc+xtSy/Ob44ezc0=;
        b=jc6opkF5ItJgVXPTi9F0j+aaujkMIUL4mbOsyNv4Q0uYjYK8PDPtwC4M8niexkl2Gz1eui
        tJ7iASKcqkKsAAtpobalW41w/X3C8AH1EAzIuGxZNx6I7IeV48Me18ZVZ4pl0IwQ4XMZwe
        ts/ugyOu/jCufHit3sYu9hRwrhvlfwU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1653467567;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=pk+dd2y8fS3J24I3QMHCkhSgrc5nc+xtSy/Ob44ezc0=;
        b=XcS0O9FxCGxfIAwhK11cUm4XWwsDlPPMeQ2FyuxBDE9HSlwmRzGawapDum1F0ZyLDgY1VG
        PIxw34wc31TcrCCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D91C713ADF;
        Wed, 25 May 2022 08:32:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rz0tMq3pjWLONwAAMHmgww
        (envelope-from <osalvador@suse.de>); Wed, 25 May 2022 08:32:45 +0000
Date:   Wed, 25 May 2022 10:32:43 +0200
From:   Oscar Salvador <osalvador@suse.de>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, mike.kravetz@oracle.com,
        naoya.horiguchi@nec.com, peterx@redhat.com, apopple@nvidia.com,
        ying.huang@intel.com, david@redhat.com, songmuchun@bytedance.com,
        hch@lst.de, dhowells@redhat.com, cl@linux.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/4] mm: reduce the rcu lock duration
Message-ID: <Yo3pq6RngBH9iBOu@localhost.localdomain>
References: <20220525081822.53547-1-linmiaohe@huawei.com>
 <20220525081822.53547-2-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525081822.53547-2-linmiaohe@huawei.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 04:18:19PM +0800, Miaohe Lin wrote:
> Commit 3268c63eded4 ("mm: fix move/migrate_pages() race on task struct")
> extends the period of the rcu_read_lock until after the permissions checks
> are done to prevent the task pointed to from changing from under us. But
> the task_struct refcount is also taken at that time, the reference to task
> is guaranteed to be stable. So it's unnecessary to extend the period of
> the rcu_read_lock. Release the rcu lock after task refcount is successfully
> grabbed to reduce the rcu holding time.
> 
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> Cc: Huang Ying <ying.huang@intel.com>
> Cc: David Howells <dhowells@redhat.com>
> Cc: Christoph Lameter <cl@linux.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

> ---
>  mm/mempolicy.c | 3 +--
>  mm/migrate.c   | 3 +--
>  2 files changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index 0b4ba3ee810e..2dad094177bf 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -1609,6 +1609,7 @@ static int kernel_migrate_pages(pid_t pid, unsigned long maxnode,
>  		goto out;
>  	}
>  	get_task_struct(task);
> +	rcu_read_unlock();
>  
>  	err = -EINVAL;
>  
> @@ -1617,11 +1618,9 @@ static int kernel_migrate_pages(pid_t pid, unsigned long maxnode,
>  	 * Use the regular "ptrace_may_access()" checks.
>  	 */
>  	if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
> -		rcu_read_unlock();
>  		err = -EPERM;
>  		goto out_put;
>  	}
> -	rcu_read_unlock();
>  
>  	task_nodes = cpuset_mems_allowed(task);
>  	/* Is the user allowed to access the target nodes? */
> diff --git a/mm/migrate.c b/mm/migrate.c
> index e51588e95f57..e88ebb88fa6f 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -1902,17 +1902,16 @@ static struct mm_struct *find_mm_struct(pid_t pid, nodemask_t *mem_nodes)
>  		return ERR_PTR(-ESRCH);
>  	}
>  	get_task_struct(task);
> +	rcu_read_unlock();
>  
>  	/*
>  	 * Check if this process has the right to modify the specified
>  	 * process. Use the regular "ptrace_may_access()" checks.
>  	 */
>  	if (!ptrace_may_access(task, PTRACE_MODE_READ_REALCREDS)) {
> -		rcu_read_unlock();
>  		mm = ERR_PTR(-EPERM);
>  		goto out;
>  	}
> -	rcu_read_unlock();
>  
>  	mm = ERR_PTR(security_task_movememory(task));
>  	if (IS_ERR(mm))
> -- 
> 2.23.0
> 
> 

-- 
Oscar Salvador
SUSE Labs
