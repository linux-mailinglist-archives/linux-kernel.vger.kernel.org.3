Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4609490466
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 09:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbiAQIwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 03:52:45 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:35840 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233155AbiAQIwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 03:52:44 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2D26B1F398;
        Mon, 17 Jan 2022 08:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1642409562; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=R0YyXulhlq9XIM/0MW8QTEvktxstU6HPJeFryqdGpXo=;
        b=NmWsFP+6QdOLbNp9JaRkPFGNmaLp2orD7iV+XErGlpqQ/xiYVqAebdpqKdxA30N2yel3fZ
        vmwJNO6ltD4rd+psLyjnCGtcbyff/68pgQHf+EIFgoePqVtnHjKCOLav0sWSXr+6teUOVf
        POpOTJxoSGWyzrfvjnDGBy3SEJ9FEQ8=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A581EA3B84;
        Mon, 17 Jan 2022 08:52:41 +0000 (UTC)
Date:   Mon, 17 Jan 2022 09:52:41 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Nico Pache <npache@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, jsavitz@redhat.com,
        peterz@infradead.org, tglx@linutronix.de, mingo@redhat.com,
        dvhart@infradead.org, dave@stgolabs.net, andrealmeid@collabora.com,
        longman@redhat.com
Subject: Re: [PATCH v3] mm/oom: do not oom reap task with an unresolved
 robust futex
Message-ID: <YeUuWcNArnDhOjFY@dhcp22.suse.cz>
References: <20220114180135.83308-1-npache@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220114180135.83308-1-npache@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 14-01-22 13:01:35, Nico Pache wrote:
> In the case that two or more processes share a futex located within
> a shared mmaped region, such as a process that shares a lock between
> itself and child processes, we have observed that when a process holding
> the lock is oom killed, at least one waiter is never alerted to this new
> development and simply continues to wait.
> 
> This is visible via pthreads by checking the __owner field of the
> pthread_mutex_t structure within a waiting process, perhaps with gdb.
> 
> We identify reproduction of this issue by checking a waiting process of
> a test program and viewing the contents of the pthread_mutex_t, taking note
> of the value in the owner field, and then checking dmesg to see if the
> owner has already been killed.

I believe we really need to find out why the original holder of the
futex is not woken up to release the lock when exiting.

> As mentioned by Michal in his patchset introducing the oom reaper,
> commit aac4536355496 ("mm, oom: introduce oom reaper"), the purpose of the
> oom reaper is to try and free memory more quickly; however, In the case
> that a robust futex is being used, we want to avoid utilizing the
> concurrent oom reaper. This is due to a race that can occur between the
> SIGKILL handling the robust futex, and the oom reaper freeing the memory
> needed to maintain the robust list.

OOM reaper is only unmapping private memory. It doesn't touch a shared
mappings. So how could it interfere?

> In the case that the oom victim is utilizing a robust futex, and the
> SIGKILL has not yet handled the futex death, the tsk->robust_list should
> be non-NULL. This issue can be tricky to reproduce, but with the
> modifications of this patch, we have found it to be impossible to
> reproduce.

We really need a deeper analysis of the udnerlying problem because right
now I do not really see why the oom reaper should interfere with shared
futex.

> Add a check for tsk->robust_list is non-NULL in wake_oom_reaper() to return
> early and prevent waking the oom reaper.
> 
> Reproducer: https://gitlab.com/jsavitz/oom_futex_reproducer
> 
> Co-developed-by: Joel Savitz <jsavitz@redhat.com>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> ---
>  mm/oom_kill.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 1ddabefcfb5a..3cdaac9c7de5 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -667,6 +667,21 @@ static void wake_oom_reaper(struct task_struct *tsk)
>  	if (test_and_set_bit(MMF_OOM_REAP_QUEUED, &tsk->signal->oom_mm->flags))
>  		return;
>  
> +#ifdef CONFIG_FUTEX
> +	/*
> +	 * If the ooming task's SIGKILL has not finished handling the
> +	 * robust futex it is not correct to reap the mm concurrently.
> +	 * Do not wake the oom reaper when the task still contains a
> +	 * robust list.
> +	 */
> +	if (tsk->robust_list)
> +		return;
> +#ifdef CONFIG_COMPAT
> +	if (tsk->compat_robust_list)
> +		return;
> +#endif
> +#endif

If this turns out to be really needed, which I do not really see at the
moment, then this is not the right way to handle this situation. The oom
victim could get stuck and the oom killer wouldn't be able to move
forward. If anything the victim would need to get MMF_OOM_SKIP set.

> +
>  	get_task_struct(tsk);
>  
>  	spin_lock(&oom_reaper_lock);
> -- 
> 2.33.1

-- 
Michal Hocko
SUSE Labs
