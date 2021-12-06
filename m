Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781E846953A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 12:47:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242699AbhLFLvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 06:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237397AbhLFLvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 06:51:11 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE8BDC061746;
        Mon,  6 Dec 2021 03:47:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=BIruuCdmTRV7u236FmMymK/LvvK7SoVKqYX/tWqVHLY=; b=qkClHPsshzGqwFN3chZaQTVnPF
        8zNfB/Tei7qSQkKcJSsrcGOAJOrOoEXAtALI5FEpsMkr+Ei7QUUhSREmUC8bTVgzJi2FF7z1VwLAu
        fYA1mDkDmCVSfopOgJhP7FH97GeJ3W9YHrrK491GPiDPteoEFN6r4FrWQ+zgxOFdEYJKuBU+JrPcn
        4B4R9zCHa9W+u8Q8FFFuuPi0g4heGcgHtwJarHdBGffBcjzQZFe3KTFtoPbyxzKPxkPbjUHJ5XxvO
        hAOHzZx0nCBmNE0U2Nn1YeYiiQkPhvsEBngDzRBKFKuiAMwdYZgKBIRzvaZ2WLkb2DeG16wI5mlPx
        0StL5Nng==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muCSq-002YJP-Uk; Mon, 06 Dec 2021 11:47:25 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id AAB783002DB;
        Mon,  6 Dec 2021 12:47:23 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8D347202CABA2; Mon,  6 Dec 2021 12:47:23 +0100 (CET)
Date:   Mon, 6 Dec 2021 12:47:23 +0100
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
Message-ID: <Ya34S2JCQg+81h4t@hirez.programming.kicks-ass.net>
References: <20211122211327.5931-1-posk@google.com>
 <20211122211327.5931-4-posk@google.com>
 <20211124200822.GF721624@worktop.programming.kicks-ass.net>
 <CAFTs51Uka8VRCHuGidw7mRwATufp87U6S8SWUVod_kU-h6T3ew@mail.gmail.com>
 <YaEUts3RbOLyvAjl@hirez.programming.kicks-ass.net>
 <CAFTs51XnN+N74i1XHvRUAUWd04-Fs9uV6ouXo=CQSQs8MaEM5A@mail.gmail.com>
 <YaUCoe07Wl9Stlch@hirez.programming.kicks-ass.net>
 <CAFTs51UzR=m6+vcjTCNOGwGu3ZwB5GMrg+cSQy2ecvCWxhZvEQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFTs51UzR=m6+vcjTCNOGwGu3ZwB5GMrg+cSQy2ecvCWxhZvEQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 09:34:49AM -0800, Peter Oskolkov wrote:
> On Mon, Nov 29, 2021 at 8:41 AM Peter Zijlstra <peterz@infradead.org> wrote:

> > Also, timeout on sys_umcg_wait() gets you the exact same situation (or
> > worse, multiple running workers).
> 
> It should not. Timed out workers should be added to the runnable list
> and not become running unless a server chooses so. So sys_umcg_wait()
> with a timeout should behave similarly to a normal sleep, in that the
> server is woken upon the worker blocking, and upon the worker wakeup
> the worker is added to the woken workers list and waits for a server
> to run it. The only difference is that in a sleep the worker becomes
> BLOCKED, while in sys_umcg_wait() the worker is RUNNABLE the whole
> time.
> 
> Why then have sys_umcg_wait() with a timeout at all, instead of
> calling nanosleep()? Because the worker in sys_umcg_wait() can be
> context-switched into by another worker, or made running by a server;
> if the worker is in nanosleep(), it just sleeps.

I've been trying to figure out the semantics of that timeout thing, and
I can't seem to make sense of it.

Consider two workers:

	S0 running A				S1 running B

therefore:

	S0::state == RUNNABLE			S1::state == RUNNABLE
	A::server_tid == S0.tid			B::server_tid = S1.tid
	A::state == RUNNING			B::state == RUNNING

Doing:

	self->state = RUNNABLE;			self->state = RUNNABLE;
	sys_umcg_wait(0);			sys_umcg_wait(10);
	  umcg_enqueue_runnable()		  umcg_enqueue_runnable()
	  umcg_wake()				  umcg_wake()
	  umcg_wait()				  umcg_wait()
						    hrtimer_start()

In both cases we get the exact same outcome:

	A::state == RUNNABLE			B::state == RUNNABLE
	S0::state == RUNNING			S1::state == RUNNING
	S0::runnable_ptr == &A			S1::runnable_ptr = &B


Which is, AFAICT, the exact state you wanted to achieve, except B now
has an active timer, but what do you want it to do when that goes?

I'm tempted to say workers cannot have timeout, and servers can use it
to wake themselves.
