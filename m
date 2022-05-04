Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2067C51B150
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 23:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378895AbiEDVsO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 17:48:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378877AbiEDVsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 17:48:07 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9970532E7
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 14:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=nnLXKYzsn4Ff0H53e/iYWG4pt2fEuSs3Y0Owjo05quQ=; b=rAsWAKrg/BnsEj+sAFL9zDKNzj
        hycwa5qwZygumLrMwKD/S+OiNu7+Yz+Dbt4bx4+NKHGc0rOdAq/RFrexskpjkW5T9/7nsTBCwZfEM
        9EvPXDvEPG0s4fDupLglTDTRiqXhukfN7f/+gDEzMNuL+roIbSVkKAHBxTBXOYCqb8yQzKulD+fF8
        EDWCM4CfZ5ykkEQJOwGRWQ7He2cAmCpJJK4gUFET9kjHEGoH8Gv+gIETUY51zeuDloTrVh4ADB4VU
        16/8ig2MuowRWAingduT4D+ZrOsle3Aa9WwOKxjWn9BR01RCcv3lKSIAZymkP4MRSTZpH2WIUa2l6
        Hs1Q7/Pg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nmMn6-00GyNr-6H; Wed, 04 May 2022 21:44:12 +0000
Date:   Wed, 4 May 2022 22:44:12 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Wait for mutex to become unlocked
Message-ID: <YnLzrGlBNCmCPLmS@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paul, Liam and I were talking about some code we intend to write soon
and realised there's a missing function in the mutex & rwsem API.
We're intending to use it for an rwsem, but I think it applies equally
to mutexes.

The customer has a low priority task which wants to read /proc/pid/smaps
of a higher priority task.  Today, everything is awful; smaps acquires
mmap_sem read-only, is preempted, then the high-pri task calls mmap()
and the down_write(mmap_sem) blocks on the low-pri task.  Then all the
other threads in the high-pri task block on the mmap_sem as they take
page faults because we don't want writers to starve.

The approach we're looking at is to allow RCU lookup of VMAs, and then
take a per-VMA rwsem for read.  Because we're under RCU protection,
that looks a bit like this:

	rcu_read_lock();
	vma = vma_lookup();
	if (down_read_trylock(&vma->sem)) {
		rcu_read_unlock();
	} else {
		rcu_read_unlock();
		down_read(&mm->mmap_sem);
		vma = vma_lookup();
		down_read(&vma->sem);
		up_read(&mm->mmap_sem);
	}

(for clarity, I've skipped the !vma checks; don't take this too literally)

So this is Good.  For the vast majority of cases, we avoid taking the
mmap read lock and the problem will appear much less often.  But we can
do Better with a new API.  You see, for this case, we don't actually
want to acquire the mmap_sem; we're happy to spin a bit, but there's no
point in spinning waiting for the writer to finish when we can sleep.
I'd like to write this code:

again:
	rcu_read_lock();
	vma = vma_lookup();
	if (down_read_trylock(&vma->sem)) {
		rcu_read_unlock();
	} else {
		rcu_read_unlock();
		rwsem_wait_read(&mm->mmap_sem);
		goto again;
	}

That is, rwsem_wait_read() puts the thread on the rwsem's wait queue,
and wakes it up without giving it the lock.  Now this thread will never
be able to block any thread that tries to acquire mmap_sem for write.

Similarly, it may make sense to add rwsem_wait_write() and mutex_wait().
Perhaps also mutex_wait_killable() and mutex_wait_interruptible()
(the combinatoric explosion is a bit messy; I don't know that it makes
sense to do the _nested, _io variants).

Does any of this make sense?
