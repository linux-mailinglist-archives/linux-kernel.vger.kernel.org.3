Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B874E4448
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 17:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239123AbiCVQiJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 12:38:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234290AbiCVQiI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 12:38:08 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F0620F5F
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 09:36:40 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id EB8CD1F387;
        Tue, 22 Mar 2022 16:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1647966998; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KwM8KlEt8kSDrXZ+QkYns1W8OFULNsUqleTjXxjLXmw=;
        b=Fcgw4dbIOLtFOLqZlJ4MTEmbm0T4OQrxzS5onoS/VxFZuQ7YnGM0hKICBZXk/R3KDpRCRn
        4rrlAMoYz/S/Zv+mqdUx0qxe8zQYTTOxOWMKJsx+Cj9sC3GbFvrqfaACyMkP8hTZ5dNUqk
        c0sL+mbxgqkjQj9GXCl9MKUdWjyVZI8=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 78C6EA3B88;
        Tue, 22 Mar 2022 16:36:38 +0000 (UTC)
Date:   Tue, 22 Mar 2022 17:36:37 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Nico Pache <npache@redhat.com>, linux-mm@kvack.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andre Almeida <andrealmeid@collabora.com>,
        David Rientjes <rientjes@google.com>
Subject: Re: [PATCH v5] mm/oom_kill.c: futex: Close a race between do_exit
 and the oom_reaper
Message-ID: <Yjn7FXoXtgGT977T@dhcp22.suse.cz>
References: <20220318033621.626006-1-npache@redhat.com>
 <Yjg9ncgep58gFLiN@dhcp22.suse.cz>
 <20220322004231.rwmnbjpq4ms6fnbi@offworld>
 <c8bb0b6d-981c-8591-d5b6-17414c934758@redhat.com>
 <20220322025724.j3japdo5qocwgchz@offworld>
 <YjmITBkkwsa2O4bg@dhcp22.suse.cz>
 <87bkxyaufi.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87bkxyaufi.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 22-03-22 16:17:05, Thomas Gleixner wrote:
> On Tue, Mar 22 2022 at 09:26, Michal Hocko wrote:
> > On Mon 21-03-22 19:57:24, Davidlohr Bueso wrote:
> >> On Mon, 21 Mar 2022, Nico Pache wrote:
> >> 
> >> > We could proceed with the V3 approach; however if we are able to find a complete
> >> > solution that keeps both functionalities (Concurrent OOM Reaping & Robust Futex)
> >> > working, I dont see why we wouldnt go for it.
> 
> See below.
> 
> >> Because semantically killing the process is, imo, the wrong thing to do.
> >
> > I am not sure I follow. The task has been killed by the oom killer. All
> > we are discussing here is how to preserve the robust list metadata
> > stored in the memory which is normally unmapped by the oom_reaper to
> > guarantee a further progress. 
> >
> > I can see we have 4 potential solutions:
> > 1) do not oom_reap oom victims with robust futex metadata in anonymous
> >    memory. Easy enough but it could lead to excessive oom killing in
> >    case the victim gets stuck in the kernel and cannot terminate.
> > 2) clean up robust list from the oom_reaper context. Seems tricky due to
> >    #PF handling from the oom_reaper context which would need to be
> >    non-blocking
> > 3) filter vmas which contain robust list. Simple check for the vma
> >    range
> > 4) internally mark vmas which have to preserve the state during
> >    oom_reaping. Futex code would somehow have to mark those mappings.
> >    While more generic solution. I am not sure this is a practical
> >    approach. 
> 
> And all of that is based on wishful thinking, really. Let me explain.
> 
> The task::robust_list pointer is set unconditionally by NPTL for every
> thread of a process. It points to the 'list head' which is in the
> TLS. But this does not tell whether the task holds a robust futex or
> not. That's evaluated in the futex exit handling code.
> 
> So solution #1 will prevent oom reaping completely simply because the
> pointer is set on every user space task.

This is really what I was worried about.

> Solutions #2 and #3 are incomplete and just awful hacks which cure one
> particular case: A single threaded process. Why?
> 
> The chosen oom reaper victim is a process, so what does it help to check
> or cleanup the robust list for _ONE_ thread? Nothing because the other
> threads can hold robust futexes and then run into the same problem.
> 
> Aside of that you seem to believe that the robust list head in the TLS
> is the only part which is relevant. That's wrong. The list head is
> either NULL or points to the innermost pthread_mutex which is held by a
> task. Now look at this example:
> 
>   TLS:robust_list -> mutex2 -> mutex1
> 
> mutex1 is the shared one which needs to be released so that other
> processes can make progress. mutex2 is a process private one which
> resides in a different VMA. So now if you filter the robust list and
> refuse to reap the TLS VMA, what prevents the other VMA from being
> reaped? If that's reaped then mutex1 is not reachable.
> 
> Now vs. cleaning up the robust list from the oom reaper context. That
> should be doable with a lot of care, but the proposed patch is not even
> close to a solution. It's simply broken.

My knowledge about robust futexes and how they are implemented is close
to zero. My thinking has been that the primary reason for the lockup
reported initially is that the oom_reaper will corrupt the memory which
is backing the list of locks to be woken up. So if we rule out the
oom_reaper for that memory then the exit path can do its proper cleanup.
Is that assumption completely off?

I cannot really comment on the futex specific parts of your response but
the deadlock on the mmap_lock has been already pointed out, thanks for
confirming that.

[...]

> But the real questions here are:
> 
>    Why are we doing this remote reaping at all?

Does aac453635549 ("mm, oom: introduce oom reaper") help? In short this
is to guarantee that the system is able to make a forward progress under
OOM. Sending SIGKILL to the oom victim is not sufficient, really. Tasks
can be blocked inside kernel for indefinite amount of time. E.g. being
blocked waiting on memory transitively over locks. Reclaiming the
anonymous memory from the killed process will allow to free up some
memory while the oom victim is blocked and allow to move forward and
eventually die and do the proper cleanup. We are focusing on the
anonymous memory because under assumption that such a memory is private
to the process and the process is dead so the a freed memory is not
really visible any more.

>    What is the condition that a task which is killed with a fatal signal
>    does not reach do_exit() and cleans up itself?
> 
> If the answer is "because", then we should rather make sure that this
> gets fixed.

While some places can be handled by changing uninterruptible waiting to
killable there are places which are not really fixable, e.g. lock
chain dependency which leads to memory allocation.

> If there is a legitimate reason why a task cannot handle a fatal signal,
> then yes the oom reaper might be necessary, but unleashing the oom
> reaper unconditionally is simply a bad idea and results in the problem
> which this is trying to paper over.
> 
> The oom reaper should be the last resort IMO and not racing against the
> killed task in the first place. IOW, give the task some time to clean
> itself up and if that fails and it is truly stuck and unable to do so,
> then reap the mm. But that should be the rare case and then the stuck
> futex should be the least of our worries.

Yes, the oom_reaper is the last resort indeed. It is true that it can
fire later but I do not see how this would solve this particular
problem. It is fundamentally wrong to reap the memory which the exit
path really need to do a proper clean up.

And just to be clear, this is clearly a bug in the oom_reaper per se.
Originally I thought that relaxing the locking (using trylock and
retry/bail out on failure) would help but as I've learned earlier this
day this is not really possible because of #PF at least. The most self
contained solution would be to skip over vmas which are backing the
robust list which would allow the regular exit path to do the proper
cleanup.

Thanks!
-- 
Michal Hocko
SUSE Labs
