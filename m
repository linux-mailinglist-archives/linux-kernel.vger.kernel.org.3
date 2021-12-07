Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E72646C865
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 00:48:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238420AbhLGXvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 18:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbhLGXvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 18:51:35 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F88C061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 15:48:04 -0800 (PST)
Received: from mail.kernel.org (unknown [198.145.29.99])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 09658B81EBA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 23:48:03 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5A9AA60E09;
        Tue,  7 Dec 2021 23:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1638920881;
        bh=NZI5E6OTeAr2lobR6Gt7GWhIGmD0oHASC6XKqv3HqqE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZHw/TP4mHfCUxYJrBbmiI6dsQ4uG9j3FaNwFJU6oduhWIODxQkhdkv3qL+14KaF3v
         2kY5VnUnJDmFLALpkxgzzfspPD/sgeZ76jf2qLphMUqvySdnMKlsyYvt8aXIpyMfQ0
         axl2zJYhPRpYT1PMQp4G2ZGzkTB0+iRJz4BdCI2g=
Date:   Tue, 7 Dec 2021 15:47:59 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Joel Savitz <jsavitz@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Waiman Long <longman@redhat.com>,
        linux-mm@kvack.org, Nico Pache <npache@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH] mm/oom_kill: wake futex waiters before annihilating
 victim shared mutex
Message-Id: <20211207154759.3f3fe272349c77e0c4aca36f@linux-foundation.org>
In-Reply-To: <20211207214902.772614-1-jsavitz@redhat.com>
References: <20211207214902.772614-1-jsavitz@redhat.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(cc's added)

On Tue,  7 Dec 2021 16:49:02 -0500 Joel Savitz <jsavitz@redhat.com> wrote:

> In the case that two or more processes share a futex located within
> a shared mmaped region, such as a process that shares a lock between
> itself and a number of child processes, we have observed that when
> a process holding the lock is oom killed, at least one waiter is never
> alerted to this new development and simply continues to wait.

Well dang.  Is there any way of killing off that waiting process, or do
we have a resource leak here?

> This is visible via pthreads by checking the __owner field of the
> pthread_mutex_t structure within a waiting process, perhaps with gdb.
> 
> We identify reproduction of this issue by checking a waiting process of
> a test program and viewing the contents of the pthread_mutex_t, taking note
> of the value in the owner field, and then checking dmesg to see if the
> owner has already been killed.
> 
> This issue can be tricky to reproduce, but with the modifications of
> this small patch, I have found it to be impossible to reproduce. There
> may be additional considerations that I have not taken into account in
> this patch and I welcome any comments and criticism.

> Co-developed-by: Nico Pache <npache@redhat.com>
> Signed-off-by: Nico Pache <npache@redhat.com>
> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> ---
>  mm/oom_kill.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> index 1ddabefcfb5a..fa58bd10a0df 100644
> --- a/mm/oom_kill.c
> +++ b/mm/oom_kill.c
> @@ -44,6 +44,7 @@
>  #include <linux/kthread.h>
>  #include <linux/init.h>
>  #include <linux/mmu_notifier.h>
> +#include <linux/futex.h>
>  
>  #include <asm/tlb.h>
>  #include "internal.h"
> @@ -890,6 +891,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
>  	 * in order to prevent the OOM victim from depleting the memory
>  	 * reserves from the user space under its control.
>  	 */
> +	futex_exit_release(victim);
>  	do_send_sig_info(SIGKILL, SEND_SIG_PRIV, victim, PIDTYPE_TGID);
>  	mark_oom_victim(victim);
>  	pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB, UID:%u pgtables:%lukB oom_score_adj:%hd\n",
> @@ -930,6 +932,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
>  		 */
>  		if (unlikely(p->flags & PF_KTHREAD))
>  			continue;
> +		futex_exit_release(p);
>  		do_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_TGID);
>  	}
>  	rcu_read_unlock();
> -- 
> 2.33.1
