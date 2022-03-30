Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 924944EBD7D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 11:19:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244717AbiC3JUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 05:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbiC3JUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 05:20:10 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F41A2AC5C
        for <linux-kernel@vger.kernel.org>; Wed, 30 Mar 2022 02:18:23 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A11C2210DB;
        Wed, 30 Mar 2022 09:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648631902; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=s3dYNUh5AxjBX/yiYSOWfD7ksRWWq/GngWTGNlJcxhI=;
        b=Mvew9YBEv/zDcFABus3iY6LxYrmlZALbjewnnCPibJBZFxCJzhCQyu5K2XdSWZivjSKJ0t
        UfP4//CUPt+/sv0yrT4knmFshytaaoJTesjJkUHja85JGcx5u0HCLkPgwLe/RKPaON5K+n
        kWfi0sGWlEu0Ua0KpjZ8Wwb3szO4+Qs=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A60D2A3B87;
        Wed, 30 Mar 2022 09:18:21 +0000 (UTC)
Date:   Wed, 30 Mar 2022 11:18:17 +0200
From:   Michal Hocko <mhocko@suse.com>
To:     Nico Pache <npache@redhat.com>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
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
Message-ID: <YkQgWcZ7w0zL1a7n@dhcp22.suse.cz>
References: <20220318033621.626006-1-npache@redhat.com>
 <Yjg9ncgep58gFLiN@dhcp22.suse.cz>
 <20220322004231.rwmnbjpq4ms6fnbi@offworld>
 <c8bb0b6d-981c-8591-d5b6-17414c934758@redhat.com>
 <20220322025724.j3japdo5qocwgchz@offworld>
 <YjmITBkkwsa2O4bg@dhcp22.suse.cz>
 <87bkxyaufi.ffs@tglx>
 <Yjn7FXoXtgGT977T@dhcp22.suse.cz>
 <87zglha9rt.ffs@tglx>
 <YjrlqAMyJg3GKZVs@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjrlqAMyJg3GKZVs@dhcp22.suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Nico,

On Wed 23-03-22 10:17:29, Michal Hocko wrote:
> Let me skip over futex part which I need to digest and only focus on the
> oom side of the things for clarification.
> 
> On Tue 22-03-22 23:43:18, Thomas Gleixner wrote:
[...]
> > You can easily validate that by doing:
> > 
> > wake_oom_reaper(task)
> >    task->reap_time = jiffies + HZ;
> >    queue_task(task);
> >    wakeup(reaper);
> > 
> > and then:
> > 
> > oom_reap_task(task)
> >     now = READ_ONCE(jiffies);
> >     if (time_before(now, task->reap_time)
> >         schedule_timeout_idle(task->reap_time - now);
> > 
> > before trying to actually reap the mm.
> > 
> > That will prevent the enforced race in most cases and allow the exiting
> > and/or killed processes to cleanup themself. Not pretty, but it should
> > reduce the chance of the reaper to win the race with the exiting and/or
> > killed process significantly.
> > 
> > It's not going to work when the problem is combined with a heavy VM
> > overload situation which keeps a guest (or one/some it's vCPUs) away
> > from being scheduled. See below for a discussion of guarantees.
> > 
> > If it failed to do so when the sleep returns, then you still can reap
> > it.
> 
> Yes, this is certainly an option. Please note that the oom_reaper is not
> the only way to trigger this. process_mrelease syscall performs the same
> operation from the userspace. Arguably process_mrelease could be used
> sanely/correctly because the userspace oom killer can do pro-cleanup
> steps before going to final SIGKILL & process_mrelease. One way would be
> to send SIGTERM in the first step and allow the victim to perform its
> cleanup.

are you working on another version of the fix/workaround based on the
discussion so far?

I guess the most reasonable way forward is to rework
oom_reaper processing to be delayed. This can be either done by a
delayed wake up or as Thomas suggests above by postponing the
processing. I think the delayed wakeup would be _slightly_ easier to
handle because the queue can contain many tasks to be reaped.

More specifically something like delayed work but we cannot rely on
the WQ here. I guess we do not have any delayed wait queue interface
but the same trick with the timer should be applicable here as well.
exit_mmap would then cancel the timer after __oom_reap_task_mm is done.
Actually the timer could be canceled after mmu_notifier_release already
but this shouldn't make much of a difference.
-- 
Michal Hocko
SUSE Labs
