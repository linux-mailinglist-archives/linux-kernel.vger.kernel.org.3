Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974CC4E2298
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 09:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345504AbiCUI5b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 04:57:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345487AbiCUI5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 04:57:25 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80A9574B6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 01:56:00 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 21E0E1F37C;
        Mon, 21 Mar 2022 08:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647852959; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4lXn8H7X0Cxzr80o+IrzVtUQtim0twN1s6sfwci9lLw=;
        b=nfdEZ03cTSQUD18tX1cLxj3cH0gtcr2EperTXe2rkHlZ8do31B1BYzocA15T1xZRXd/CrM
        DtMwTsQJkldSHRP5Oq/Ntu6eju6gCJiYENn728M8KLbf/aQG8+VMzkNk8CQXHbfSHNNmGU
        XpmdlKGWI4+EU6At+MTHoG5ejhNaloI=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7E205A3B8A;
        Mon, 21 Mar 2022 08:55:58 +0000 (UTC)
Date:   Mon, 21 Mar 2022 09:55:57 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Nico Pache <npache@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Andre Almeida <andrealmeid@collabora.com>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Savitz <jsavitz@redhat.com>
Subject: Re: [PATCH v5] mm/oom_kill.c: futex: Close a race between do_exit
 and the oom_reaper
Message-ID: <Yjg9ncgep58gFLiN@dhcp22.suse.cz>
References: <20220318033621.626006-1-npache@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318033621.626006-1-npache@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17-03-22 21:36:21, Nico Pache wrote:
> The pthread struct is allocated on PRIVATE|ANONYMOUS memory [1] which can
> be targeted by the oom reaper. This mapping is used to store the futex
> robust list; the kernel does not keep a copy of the robust list and instead
> references a userspace address to maintain the robustness during a process
> death. A race can occur between exit_mm and the oom reaper that allows
> the oom reaper to free the memory of the futex robust list before the
> exit path has handled the futex death:
> 
>     CPU1                               CPU2
> ------------------------------------------------------------------------
>     page_fault
>     out_of_memory
>     do_exit "signal"
>     wake_oom_reaper
> 					oom_reaper
>                         		oom_reap_task_mm (invalidates mm)
>     exit_mm
>     exit_mm_release
>     futex_exit_release
>     futex_cleanup
>     exit_robust_list
>     get_user (EFAULT- can't access memory)

I still think it is useful to be explicit about the consequences of the
EFAULT here. Did you want to mention that a failing get_user in this
path would result in a hang because nobody is woken up when the current
holder of the lock terminates.

> While in the oom reaper thread, we must handle the futex cleanup without
> sleeping. To achieve this, add the boolean `try` to futex_exit_begin().
> This will control weather or not we use a trylock. Also introduce
> try_futex_exit_release() which will utilize the trylock version of the
> futex_cleanup_begin(). Also call kthread_use_mm in this context to assure
> the get_user call in futex_cleanup() does not return with EFAULT.

This alone is not sufficient. get_user can sleep in the #PF handler path
(e.g. by waiting for swap in). Or is there any guarantee that the page
is never swapped out? If we cannot rule out #PF then this is not a
viable way to address the problem I am afraid.

[...]
> @@ -587,6 +588,18 @@ static bool oom_reap_task_mm(struct task_struct *tsk, struct mm_struct *mm)
>  		goto out_unlock;
>  	}
>  
> +	/* We can't reap a process holding a robust_list; the pthread
> +	 * struct is allocated in userspace using PRIVATE | ANONYMOUS
> +	 * memory which when reaped before futex_cleanup() can leave
> +	 * the waiting process stuck. Try to perform the futex_cleanup,
> +	 * and if unsuccessful, skip the OOM reaping.
> +	 */
> +	if (task_has_robust_list(tsk) && !try_futex_exit_release(tsk)) {
> +		trace_skip_task_reaping(tsk->pid);
> +		pr_info("oom_reaper: skipping task as it contains a robust list");
> +		goto out_finish;
> +	}
> +
>  	trace_start_task_reaping(tsk->pid);
>  
>  	/* failed to reap part of the address space. Try again later */

Please also note that this all is done after mmap_lock has been already
taken so a page fault could deadlock on the mmap_lock.

The more I am thinking about this the more I am getting convinced that
we should rather approach this differently and skip over vmas which can
be holding the list. Have you considered this option?
-- 
Michal Hocko
SUSE Labs
