Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0A4C46FDB6
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 10:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236262AbhLJJ37 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 04:29:59 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:58880 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236300AbhLJJ3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 04:29:55 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id DC5881F387;
        Fri, 10 Dec 2021 09:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1639128378; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OD+kBuQDOOzzVBWfZjCqChKEAkc0ex9ahLKuU1LARsk=;
        b=r5Y/+F2KwJT8oI46KotaQuXRFCkiUvz0+MqfnXBTG88vQ4OziCH6BPYx7jwF0oUCE7gOy0
        H8YUh+KHem+z44xOQ4EFh8B+iOxBdr8Wy0FEebidVK1VXOVntgQISACreyCI7e2LpztJIN
        jNdj3tJu/0Bhl+MpIF51YO+Ne8PQlwQ=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id C65C1A3B93;
        Fri, 10 Dec 2021 09:26:18 +0000 (UTC)
Date:   Fri, 10 Dec 2021 10:26:17 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     linux-kernel@vger.kernel.org
Cc:     jsavitz@redhat.com, longman@redhat.com, mm-commits@vger.kernel.org,
        npache@redhat.com, peterz@infradead.org
Subject: Re: +
 mm-oom_kill-wake-futex-waiters-before-annihilating-victim-shared-mutex.patch
 added to -mm tree
Message-ID: <YbMdOXqMayGSguFQ@dhcp22.suse.cz>
References: <20211207234924.gtknfVfZB%akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207234924.gtknfVfZB%akpm@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Btw. I do not think this patch should be in MM until we hear from Futex
maintainers and also learn more about the underlying issue.

Thanks.

On Tue 07-12-21 15:49:24, Andrew Morton wrote:
> From: Joel Savitz <jsavitz@redhat.com>
> Subject: mm/oom_kill: wake futex waiters before annihilating victim shared mutex
> 
> In the case that two or more processes share a futex located within a
> shared mmaped region, such as a process that shares a lock between itself
> and a number of child processes, we have observed that when a process
> holding the lock is oom killed, at least one waiter is never alerted to
> this new development and simply continues to wait.
> 
> This is visible via pthreads by checking the __owner field of the
> pthread_mutex_t structure within a waiting process, perhaps with gdb.
> 
> We identify reproduction of this issue by checking a waiting process of a
> test program and viewing the contents of the pthread_mutex_t, taking note
> of the value in the owner field, and then checking dmesg to see if the
> owner has already been killed.
> 
> This issue can be tricky to reproduce, but with the modifications of this
> small patch, I have found it to be impossible to reproduce.  There may be
> additional considerations that I have not taken into account in this patch
> and I welcome any comments and criticism.
> 
> Link: https://lkml.kernel.org/r/20211207214902.772614-1-jsavitz@redhat.com
> Signed-off-by: Nico Pache <npache@redhat.com>
> Co-developed-by: Nico Pache <npache@redhat.com>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> Cc: Waiman Long <longman@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
> 
>  mm/oom_kill.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> --- a/mm/oom_kill.c~mm-oom_kill-wake-futex-waiters-before-annihilating-victim-shared-mutex
> +++ a/mm/oom_kill.c
> @@ -44,6 +44,7 @@
>  #include <linux/kthread.h>
>  #include <linux/init.h>
>  #include <linux/mmu_notifier.h>
> +#include <linux/futex.h>
>  
>  #include <asm/tlb.h>
>  #include "internal.h"
> @@ -890,6 +891,7 @@ static void __oom_kill_process(struct ta
>  	 * in order to prevent the OOM victim from depleting the memory
>  	 * reserves from the user space under its control.
>  	 */
> +	futex_exit_release(victim);
>  	do_send_sig_info(SIGKILL, SEND_SIG_PRIV, victim, PIDTYPE_TGID);
>  	mark_oom_victim(victim);
>  	pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB, UID:%u pgtables:%lukB oom_score_adj:%hd\n",
> @@ -930,6 +932,7 @@ static void __oom_kill_process(struct ta
>  		 */
>  		if (unlikely(p->flags & PF_KTHREAD))
>  			continue;
> +		futex_exit_release(p);
>  		do_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_TGID);
>  	}
>  	rcu_read_unlock();
> _
> 
> Patches currently in -mm which might be from jsavitz@redhat.com are
> 
> mm-oom_kill-wake-futex-waiters-before-annihilating-victim-shared-mutex.patch

-- 
Michal Hocko
SUSE Labs
