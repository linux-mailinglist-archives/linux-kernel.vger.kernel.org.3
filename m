Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DEBC469511
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 12:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242576AbhLFLge (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 06:36:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242494AbhLFLgL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:36:11 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7253CC061359;
        Mon,  6 Dec 2021 03:32:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=bbPon1x1Cb+zVlWyG5Z9rwl6b0rpya4JWPKDzhX3GGU=; b=slQSxZZ0VZCUUEAGC0vtDR2sDH
        U+NTHEXwuB+ok1uaEzNUl3w52lNSWZCB1uQhfYnK/RuUHzvOiqDxEW1TnGsVEk/88b5qXl3yANpEs
        BWIK+ZnfRY/xehsgUWEpuSYF2qtj7vuI0ld/9IXEGANRvm/lALukgKS4IKUj7bAels1mXx2R28gi0
        fmsoqlYhgmVCq7UNfT+R7pZdGZKTepKyKmte8oiYifBFLBFg+oFe11FLtFtAzcaKFVMX6Gu4JPI/0
        R4c4VIubeVXOiQGIOyFsb0U6PSF/uM7GH6tlipCscYbok8t9VTglxIdkNpnEWfxxYlE04NZKfRh9A
        Ck/GVhLQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muCEJ-004GN4-0N; Mon, 06 Dec 2021 11:32:23 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 508133002DB;
        Mon,  6 Dec 2021 12:32:22 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 35C57202CABA2; Mon,  6 Dec 2021 12:32:22 +0100 (CET)
Date:   Mon, 6 Dec 2021 12:32:22 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@posk.io>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Paul Turner <pjt@google.com>,
        Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: Re: [PATCH v0.9.1 3/6] sched/umcg: implement UMCG syscalls
Message-ID: <Ya30xsrQnwyT/R92@hirez.programming.kicks-ass.net>
References: <20211122211327.5931-1-posk@google.com>
 <20211122211327.5931-4-posk@google.com>
 <20211124200822.GF721624@worktop.programming.kicks-ass.net>
 <CAFTs51Uka8VRCHuGidw7mRwATufp87U6S8SWUVod_kU-h6T3ew@mail.gmail.com>
 <YaEUts3RbOLyvAjl@hirez.programming.kicks-ass.net>
 <CAFTs51XnN+N74i1XHvRUAUWd04-Fs9uV6ouXo=CQSQs8MaEM5A@mail.gmail.com>
 <YaUCoe07Wl9Stlch@hirez.programming.kicks-ass.net>
 <CAFTs51UzR=m6+vcjTCNOGwGu3ZwB5GMrg+cSQy2ecvCWxhZvEQ@mail.gmail.com>
 <20211129210841.GO721624@worktop.programming.kicks-ass.net>
 <CAFTs51XyGDNj89+FCn4HZqMHuenjQu2wqTOW8ow4hSUbdGrGhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFTs51XyGDNj89+FCn4HZqMHuenjQu2wqTOW8ow4hSUbdGrGhw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Sorry, I haven't been feeling too well and as such procastinated on this
because thinking is required :/ Trying to pick up the bits.

On Mon, Nov 29, 2021 at 03:38:38PM -0800, Peter Oskolkov wrote:
> On Mon, Nov 29, 2021 at 1:08 PM Peter Zijlstra <peterz@infradead.org> wrote:
> [...]
> > > > > Another big concern I have is that you removed UMCG_TF_LOCKED. I
> > > >
> > > > OOh yes, I forgot to mention that. I couldn't figure out what it was
> > > > supposed to do.
> [...]
> >
> > So then A does:
> >
> >         A::next_tid = C.tid;
> >         sys_umcg_wait();
> >
> > Which will:
> >
> >         pin(A);
> >         pin(S0);
> >
> >         cmpxchg(A::state, RUNNING, RUNNABLE);
> 
> Hmm.... That's another difference between your patch and mine: my
> approach was "the side that initiates the change updates the state".
> So in my code the userspace changes the current task's state RUNNING
> => RUNNABLE and the next task's state,

I couldn't make that work for wakeups; when a thread blocks in a
random syscall there is no userspace to wake the next thread. And since
it seems required in this case, it's easier and more consistent to
always do it.

> or the server's state, RUNNABLE
> => RUNNING before calling sys_umcg_wait().

Yes, this is indeed required; I've found the same when trying to build
the userspace server loop. And yes, I'm starting to see where you're
coming from.

> I'm still not sure we can live without UMCG_TF_LOCKED. What if worker
> A transfers its server to worker B that A intends to context switch

	S0 running A

Therefore:

	S0::state == RUNNABLE
	A::server_tid = S0.tid
	A::state == RUNNING

you want A to switch to B, therefore:

	B::state == RUNNABLE

if B is not yet on S0 then:

	B::server_tid = S0.tid;

finally:

0:
	A::next_tid = B.tid;
1:
	A::state = RUNNABLE:
2:
	sys_umcg_wait();
3:

> into, and then worker A pagefaults or gets interrupted before calling
> sys_umcg_wait()?

So the problem is tripping umcg_notify_resume() on the labels 1 and 2,
right? tripping it on 0 and 3 is trivially correct.

If we trip it on 1 and !(A::state & TG_PREEMPT), then nothing, since
::state == RUNNING we'll just continue onwards and all is well. That is,
nothing has happened yet.

However, if we trip it on 2: we're screwed. Because at that point
::state is scribbled.

> The server will be woken up and will see that it is
> assigned to worker B; now what? If worker A is "locked" before the
> whole thing starts, the pagefault/interrupt will not trigger
> block/wake detection, worker A will keep RUNNING for all intended
> purposes, and eventually will call sys_umcg_wait() as it had
> intended...

No, the failure case is different; umcg_notify_resume() will simply
block A until someone sets A::state == RUNNING and kicks it, which will
be no-one.

Now, the above situation is actually simple to fix, but it gets more
interesting when we're using sys_umcg_wait() to build wait primitives.
Because in that case we get stuff like:

	for (;;) {
		self->state = RUNNABLE;
		smp_mb();
		if (cond)
			break;
		sys_umcg_wait();
	}
	self->state = RUNNING;

And we really need to not block and also not do sys_umcg_wait() early.

So yes, I agree that we need a special case here that ensures
umcg_notify_resume() doesn't block. Let me ponder naming and comments.
Either a TF_COND_WAIT or a whole new state. I can't decide yet.

Now, obviously if you do a random syscall anywhere around here, you get
to keep the pieces :-)



I've also added ::next_tid to the whole umcg_pin_pages() thing, and made
it so that ::next_tid gets cleared when it's been used. That way things
like:

	self->next_tid = pick_from_runqueue();
	sys_that_is_expected_to_sleep();
	if (self->next_tid) {
		return_to_runqueue(self->next_tid);
		self->next_tid = 0;
	}

Are much simpler to manage. Either it did sleep and ::next_tid is
consumed, or it didn't sleep and it needs to be returned to the
runqueue.

