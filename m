Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE314625EC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234569AbhK2Woe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:44:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbhK2WoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:44:11 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB1FAC0E2EF9;
        Mon, 29 Nov 2021 13:29:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=mNNnNSgP+EBjbzupf8GX/TTblcO8OUlVrj78b2lxKRM=; b=q6c69S5F9T0dEuf9G/zyLkVOsq
        GE6UIpmwFVrmijiXV61pxE26LYHxxG/7gkk2iDI0SluinqDG4hRJE6B+kaw3oQVcvGQFmoHUfkzjV
        v6D9ZoZY4cMmBuPVHxSmf398pU32ECtOETmor58MP70gAFe4GxoTHG3EwxH0430X6WBlf0mRnoGFr
        PX+TVeTx/Fe9njw9urxkYJQnXpJN6I/lQUe5yzqx+E4d5ixwYFaX7qq+EPRZpBRaBFq75XUoE7ary
        Kr9tVZMdHFFmuRWL7VuSsNmsrRDNm/U9GIjo60wM4iH++B/sxc8ECctrg7pETJs1iijGd1JxReh13
        isIpEMow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mroDV-001JyW-S3; Mon, 29 Nov 2021 21:29:42 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 988E798675D; Mon, 29 Nov 2021 22:29:41 +0100 (CET)
Date:   Mon, 29 Nov 2021 22:29:41 +0100
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
Message-ID: <20211129212941.GD735260@worktop.programming.kicks-ass.net>
References: <20211122211327.5931-1-posk@google.com>
 <20211122211327.5931-4-posk@google.com>
 <20211124200822.GF721624@worktop.programming.kicks-ass.net>
 <CAFTs51Uka8VRCHuGidw7mRwATufp87U6S8SWUVod_kU-h6T3ew@mail.gmail.com>
 <YaEUts3RbOLyvAjl@hirez.programming.kicks-ass.net>
 <CAFTs51XnN+N74i1XHvRUAUWd04-Fs9uV6ouXo=CQSQs8MaEM5A@mail.gmail.com>
 <YaUCoe07Wl9Stlch@hirez.programming.kicks-ass.net>
 <CAFTs51UzR=m6+vcjTCNOGwGu3ZwB5GMrg+cSQy2ecvCWxhZvEQ@mail.gmail.com>
 <20211129210841.GO721624@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211129210841.GO721624@worktop.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 10:08:41PM +0100, Peter Zijlstra wrote:
> I'm not sure I'm following. For this to be true A and C must be running
> on a different server right?
> 
> So we have something like:
> 
> 	S0 running A			S1 running B
> 
> Therefore:
> 
> 	S0::state == RUNNABLE		S1::state == RUNNABLE
> 	A::server_tid == S0.tid		B::server_tid == S1.tid
> 	A::state == RUNNING		B::state == RUNNING
> 
> Now, you want A to switch to C, therefore C had better be with S0, eg we
> have:
> 
> 	C::server_tid == S0.tid
> 	C::state == RUNNABLE
> 
> So then A does:
> 
> 	A::next_tid = C.tid;
> 	sys_umcg_wait();
> 
> Which will:
> 
> 	pin(A);
> 	pin(S0);
> 
> 	cmpxchg(A::state, RUNNING, RUNNABLE);
> 
> 	next_tid = A::next_tid; // C
> 
> 	enqueue(S0::runnable, A);
> 
> At which point B steals S0's runnable queue, and tries to make A go.
> 
> 					runnable = xchg(S0::runnable_list_ptr, NULL); // == A
> 					A::server_tid = S1.tid;
> 					B::next_tid = A.tid;
> 					sys_umcg_wait();
> 
> 	wake(C)
> 	  cmpxchg(C::state, RUNNABLE, RUNNING); <-- *fault*
> 
> 
> Something like that, right?

And note that there's an XXX in the code about exactly this case; it has
a question whether we want to add pin(next) to umcg_pin_pages().

That would not in fact help here, because sys_umcg_wait() is faultable
and the only reason it'll return -EFAULT is because, as stated below, C
is garbage. But it does make a difference for when we do something like:

	self->next_tid = someone;
	sys_something_we_expect_to_block();
	// handle not blocking

Because in that case userspace must have taken 'someone' from the
runnable queue and made it 'next', but then we'll not wake next but the
server, which then needs to figure out something went sideways.

So I'm tempted to add that optional 3rd pin, simply to reduce the
failure cases.

> What currently happens is that S0 goes back to S0 and S1 ends up in A.
> That is, if, for any reason we fail to wake next_tid, we'll wake
> server_tid.
> 
> So then S0 wakes up and gets to re-evaluate life. If it has another
> worker it can go run that, otherwise it can try and steal a worker
> somewhere or just idle out.
> 
> Now arguably, the only reason A->C can fault is because C is garbage, at
> which point your program is malformed and it doesn't matter what
> happens one way or the other.
