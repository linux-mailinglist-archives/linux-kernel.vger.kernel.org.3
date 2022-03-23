Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66B754E5057
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 11:31:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243556AbiCWKc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 06:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243543AbiCWKcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 06:32:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55FD076E17
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 03:30:52 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1648031450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HdL8Env3+TPAQ/PsvX0YMRBlQGc+4wZ8kk8st8d59rg=;
        b=x2sYw6JpVrL8IgvHTMJWaTV68USZY+G6WBd9PoXCs2IKuzXZGlmqyyTK8CbEaz1Jxl3G8o
        D8+sisisnk9rQ79Zq7SjLyIguWxNil/e4uUOJ7Zlc5jJhwDM9ByLl7PTYY0ca2sCmAkHP7
        DoULdMwCXDdg4imdKsKbI4Co1wPEw0M00O/uBnAJOSLuHxvgzjTqAdo2AN4Jk3nX0ixJqe
        PE2SNL5i0p4tqiznjxavMj23W65Ae640zSvE8PBkFSeNKGt7ECLAufwZk7tgl21H1AQPfu
        Dd6VaUBEMtoNpuVSlPpmSv9i057xqmCIZtm1OafgdakQ3jhFKYFzD/BNsyaj1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1648031450;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HdL8Env3+TPAQ/PsvX0YMRBlQGc+4wZ8kk8st8d59rg=;
        b=ZZnBBXYRzjrPt3QpImDis/usgiBJzgnR0nshIvOcMS6pPyj+WwWNK8Zk9nVzDetubAUqjh
        +XoNz+ZJLZj1MYBQ==
To:     Michal Hocko <mhocko@suse.com>
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
In-Reply-To: <YjrlqAMyJg3GKZVs@dhcp22.suse.cz>
References: <20220318033621.626006-1-npache@redhat.com>
 <Yjg9ncgep58gFLiN@dhcp22.suse.cz>
 <20220322004231.rwmnbjpq4ms6fnbi@offworld>
 <c8bb0b6d-981c-8591-d5b6-17414c934758@redhat.com>
 <20220322025724.j3japdo5qocwgchz@offworld>
 <YjmITBkkwsa2O4bg@dhcp22.suse.cz> <87bkxyaufi.ffs@tglx>
 <Yjn7FXoXtgGT977T@dhcp22.suse.cz> <87zglha9rt.ffs@tglx>
 <YjrlqAMyJg3GKZVs@dhcp22.suse.cz>
Date:   Wed, 23 Mar 2022 11:30:49 +0100
Message-ID: <87ils59d0m.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal!

On Wed, Mar 23 2022 at 10:17, Michal Hocko wrote:
> Let me skip over futex part which I need to digest and only focus on the
> oom side of the things for clarification.

The most important thing to know about futexes is: They are cursed.

> On Tue 22-03-22 23:43:18, Thomas Gleixner wrote:
> [...]
>> > While some places can be handled by changing uninterruptible waiting to
>> > killable there are places which are not really fixable, e.g. lock
>> > chain dependency which leads to memory allocation.
>> 
>> I'm not following. Which lock chain dependency causes memory allocation?
>
> Consider an oom victim is blocked on a lock or waiting for an event to
> happen but the lock holder is stuck allocating or the wake up depends on
> an allocation. Many sleeping locks are doing GFP_KERNEL allocations.

Fair enough.
  
>> That will prevent the enforced race in most cases and allow the exiting
>> and/or killed processes to cleanup themself. Not pretty, but it should
>> reduce the chance of the reaper to win the race with the exiting and/or
>> killed process significantly.
>> 
>> It's not going to work when the problem is combined with a heavy VM
>> overload situation which keeps a guest (or one/some it's vCPUs) away
>> from being scheduled. See below for a discussion of guarantees.
>> 
>> If it failed to do so when the sleep returns, then you still can reap
>> it.
>
> Yes, this is certainly an option. Please note that the oom_reaper is not
> the only way to trigger this. process_mrelease syscall performs the same
> operation from the userspace. Arguably process_mrelease could be used
> sanely/correctly because the userspace oom killer can do pro-cleanup
> steps before going to final SIGKILL & process_mrelease. One way would be
> to send SIGTERM in the first step and allow the victim to perform its
> cleanup.

A potential staged approach would be:

  Send SIGTERM
  wait some time
  Send SIGKILL
  wait some time
  sys_process_mrelease()

Needs proper documentation though.

>> That said, the robust list is no guarantee. It's a best effort approach
>> which works well most of the time at least for the "normal" issues where
>> a task holding a futex dies unexpectedly. But there is no guarantee that
>> it works under all circumstances, e.g. OOM.
>
> OK, so this is an important note. I am all fine by documenting this
> restriction. It is not like oom victims couldn't cause other disruptions
> by leaving inconsistent/stale state behind.

Correct. Futexes are a small part of the overall damage.

>> Wrong. The whole point of robust lists is to handle the "normal" case
>> gracefully. A process being OOM killed is _NOT_ in the "normal"
>> category.
>> 
>> Neither is it "normal" that a VM is scheduled out long enough to miss a
>> 1 second deadline. That might be considered normal by cloud folks, but
>> that's absolute not normal from an OS POV. Again, that's not a OS
>> problem, that's an operator/admin problem.
>
> Thanks for this clarification. I would tend to agree. Following a
> previous example that oom victims can leave inconsistent state behind
> which can influence other processes. I am wondering what kind of
> expectations about the lock protected state can we make when the holder
> of the lock has been interrupted at any random place in the critical
> section.

Right. If a futex is released by the exit cleanup, it is marked with
FUTEX_OWNER_DIED. User space is supposed to handle this.

pthread_mutex_lock() returns EOWNERDEAD to the caller if the owner died
bit is set. It's the callers responsibility to deal with potentially
corrupted or inconsistent state.

>> So let me summarize what I think needs to be done in priority order:
>> 
>>  #1 Delay the oom reaper so the normal case of a process being able to
>>     exit is not subject to a pointless race to death.
>> 
>>  #2 If #1 does not result in the desired outcome, reap the mm (which is
>>     what we have now).
>> 
>>  #3 If it's expected that #2 will allow the stuck process to make
>>     progress on the way towards cleanup, then do not reap any VMA
>>     containing a robust list head of a thread which belongs to the
>>     exiting and/or killed process.
>> 
>> The remaining cases, i.e. the lock chain example I pointed out above or
>> the stuck forever task are going to be rare and fall under the
>> collateral damage and no guarantee rule.
>
> I do agree that delaying oom_reaper wake up is the simplest thing to do
> at this stage and it could catch up most of the failures. We still have
> process_mrelease syscall case but I guess we can document this as a
> caveat into the man page.

Yes. The user space oom killer should better know what it is doing :)

Thanks,

        tglx
