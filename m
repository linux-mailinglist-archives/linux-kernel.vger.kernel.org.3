Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E4B446CFA1
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 10:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbhLHJFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 04:05:17 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:47216 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbhLHJFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 04:05:16 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id F37CB212C3;
        Wed,  8 Dec 2021 09:01:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1638954104; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SPcplUKbn+26/lhn9RIJqQ7lmPcyVCiNERjtv5vh+2s=;
        b=jrphflUAN+2NwFR/Y6VoUtqVOwgDqdWgXqyP3F2oRbbH7+BUvHm8o6Q2clTqs8pb9ER3yz
        9HNpEwOHqe9CAbQARH8p3fGiyjEID5R8B3Wlps+HCRQfq+kGQSCPglQFp78HLFn26bxg82
        Z/QoETq/OjMURAY7S+TW/thXN4aj+WY=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8D7EAA3B91;
        Wed,  8 Dec 2021 09:01:43 +0000 (UTC)
Date:   Wed, 8 Dec 2021 10:01:43 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Joel Savitz <jsavitz@redhat.com>, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>, linux-mm@kvack.org,
        Nico Pache <npache@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?iso-8859-1?Q?Andr=E9?= Almeida <andrealmeid@collabora.com>
Subject: Re: [PATCH] mm/oom_kill: wake futex waiters before annihilating
 victim shared mutex
Message-ID: <YbB0d6T8RbHW48sZ@dhcp22.suse.cz>
References: <20211207214902.772614-1-jsavitz@redhat.com>
 <20211207154759.3f3fe272349c77e0c4aca36f@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211207154759.3f3fe272349c77e0c4aca36f@linux-foundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 07-12-21 15:47:59, Andrew Morton wrote:
> (cc's added)

Extend CC to have all futex maintainers on board.
 
> On Tue,  7 Dec 2021 16:49:02 -0500 Joel Savitz <jsavitz@redhat.com> wrote:
> 
> > In the case that two or more processes share a futex located within
> > a shared mmaped region, such as a process that shares a lock between
> > itself and a number of child processes, we have observed that when
> > a process holding the lock is oom killed, at least one waiter is never
> > alerted to this new development and simply continues to wait.
> 
> Well dang.  Is there any way of killing off that waiting process, or do
> we have a resource leak here?
> 
> > This is visible via pthreads by checking the __owner field of the
> > pthread_mutex_t structure within a waiting process, perhaps with gdb.
> > 
> > We identify reproduction of this issue by checking a waiting process of
> > a test program and viewing the contents of the pthread_mutex_t, taking note
> > of the value in the owner field, and then checking dmesg to see if the
> > owner has already been killed.
> > 
> > This issue can be tricky to reproduce, but with the modifications of
> > this small patch, I have found it to be impossible to reproduce. There
> > may be additional considerations that I have not taken into account in
> > this patch and I welcome any comments and criticism.

Why does OOM killer need a special handling. All the oom killer does is
to send a fatal signal to the victim. Why is this any different from
sending SIGKILL from the userspace?

> > Co-developed-by: Nico Pache <npache@redhat.com>
> > Signed-off-by: Nico Pache <npache@redhat.com>
> > Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> > ---
> >  mm/oom_kill.c | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index 1ddabefcfb5a..fa58bd10a0df 100644
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -44,6 +44,7 @@
> >  #include <linux/kthread.h>
> >  #include <linux/init.h>
> >  #include <linux/mmu_notifier.h>
> > +#include <linux/futex.h>
> >  
> >  #include <asm/tlb.h>
> >  #include "internal.h"
> > @@ -890,6 +891,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
> >  	 * in order to prevent the OOM victim from depleting the memory
> >  	 * reserves from the user space under its control.
> >  	 */
> > +	futex_exit_release(victim);
> >  	do_send_sig_info(SIGKILL, SEND_SIG_PRIV, victim, PIDTYPE_TGID);
> >  	mark_oom_victim(victim);
> >  	pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-rss:%lukB, shmem-rss:%lukB, UID:%u pgtables:%lukB oom_score_adj:%hd\n",
> > @@ -930,6 +932,7 @@ static void __oom_kill_process(struct task_struct *victim, const char *message)
> >  		 */
> >  		if (unlikely(p->flags & PF_KTHREAD))
> >  			continue;
> > +		futex_exit_release(p);
> >  		do_send_sig_info(SIGKILL, SEND_SIG_PRIV, p, PIDTYPE_TGID);
> >  	}
> >  	rcu_read_unlock();
> > -- 
> > 2.33.1

-- 
Michal Hocko
SUSE Labs
