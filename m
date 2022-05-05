Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACBF51B4C3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 02:38:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbiEEAmH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 20:42:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbiEEAmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 20:42:06 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2AD13F6F
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 17:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0a3n6g08uy4NgSGyUNbaprX3YM0H5Vez2eDs3lJUsJk=; b=gcueIgMyoPiA5Wg4SzO+ZlJxCE
        5LnXK3zcy4lIkYzLGXoCV2bekzWV+XJJ7KdDze1t9Zr7yFd/R+8HhxtXdhVJibYMUGKAMes2rVFI1
        JpGjwyWOQsoRGxdlq2nTrl7tZF1a57IQbOXBVsn4oB5mzaCRSqPGIGCK5HrlHdlODjfWYLp63skyQ
        0nl86JveqK1dipA1LI5puoz7X3TMAq5PEjQhXa2hKwYSNZnzbAXwoqttXNFWnWSdLK8h4Hg16iVIc
        x8RQO4e4WhBy27GV+TgtwqhZBu1y5PQD18uF0gV04v9MjaCTzPO1GYoddhPIfnbXeqkXCrhYwKmSU
        5Ox8Jjbg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmPVW-00H7um-TB; Thu, 05 May 2022 00:38:15 +0000
Date:   Thu, 5 May 2022 01:38:14 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Wait for mutex to become unlocked
Message-ID: <YnMcdmx9ZwHcxTYe@casper.infradead.org>
References: <YnLzrGlBNCmCPLmS@casper.infradead.org>
 <87pmksj0ah.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pmksj0ah.ffs@tglx>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 05, 2022 at 02:22:30AM +0200, Thomas Gleixner wrote:
> > So this is Good.  For the vast majority of cases, we avoid taking the
> > mmap read lock and the problem will appear much less often.  But we can
> > do Better with a new API.  You see, for this case, we don't actually
> > want to acquire the mmap_sem; we're happy to spin a bit, but there's no
> > point in spinning waiting for the writer to finish when we can sleep.
> > I'd like to write this code:
> >
> > again:
> > 	rcu_read_lock();
> > 	vma = vma_lookup();
> > 	if (down_read_trylock(&vma->sem)) {
> > 		rcu_read_unlock();
> > 	} else {
> > 		rcu_read_unlock();
> > 		rwsem_wait_read(&mm->mmap_sem);
> > 		goto again;
> > 	}
> >
> > That is, rwsem_wait_read() puts the thread on the rwsem's wait queue,
> > and wakes it up without giving it the lock.  Now this thread will never
> > be able to block any thread that tries to acquire mmap_sem for write.
> 
> Never?
> 
>  	if (down_read_trylock(&vma->sem)) {
> 
> ---> preemption by writer

Ah!  This is a different semaphore.  Yes, it can be preempted while
holding the VMA rwsem and block a thread which is trying to modify the
VMA which will then block all threads from faulting _on that VMA_,
but it won't affect page faults on any other VMA.  It's only Better,
not Best (the Best approach was proposed on Monday afternoon, and
the other MM developers asked us to only go as far as Better and
see if that was good enough).

> The information gathered from /proc/pid/smaps is unreliable at the point
> where the lock is dropped already today. So it does not make a
> difference whether the VMAs have a 'read me if you really think it's
> useful' sideband information which gets updated when the VMA changes and
> allows to do:

Mmm.  I'm not sure that we want to maintain the smaps information on
the off chance that somebody wants to query it.

> But looking at the stuff which gets recomputed and reevaluated in that
> proc/smaps code this makes a lot of sense, because most if not all of
> this information is already known at the point where the VMA is modified
> while holding mmap_sem for useful reasons, no?

I suspect the only way to know is to try to implement it, and then
benchmark it.
