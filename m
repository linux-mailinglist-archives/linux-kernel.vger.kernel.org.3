Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C049C494C7F
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 12:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbiATLIE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 06:08:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiATLID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:08:03 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 408E9C061574;
        Thu, 20 Jan 2022 03:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KCq0JzQnS5ZYw2B7tpX4PZGYRq7eIxGkoXXZAjqJTxo=; b=ePFB6IGhW5UvyJvFXUAd+jzk0v
        6FxavVUfmVDmm6bT85fKD+JMSWyWVN1AXhiJVRrriM349oxHza4NhhmbF+kycb8PNc5nNoQkpB6K7
        1n1jRsx/kbrmFgBzsU9yX+blReQyCiKDXPIEVoDnsGmf7F7pBVxDmbm9WTHRD74FpwDO2W+rVFwQP
        0JwWXbg2Zpi+qAq7cQL3v4eibBdwrCqA7MTch0ljjZyCGiT7l6y3OyJ1KJcXsd6WlzgHAoY0aySuE
        /xeXlGebPbbr3bj2ucjP0vcgijubTyA20vVrRR7kQjaQfRjbbT7VzieyrvtciylI5fZdw5JODovb2
        RQVp1DXA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAVI8-00EAvd-Qt; Thu, 20 Jan 2022 11:07:45 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9B28B3002F1;
        Thu, 20 Jan 2022 12:07:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 7DDAD21417388; Thu, 20 Jan 2022 12:07:44 +0100 (CET)
Date:   Thu, 20 Jan 2022 12:07:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@google.com>
Cc:     Peter Oskolkov <posk@posk.io>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-api@vger.kernel.org, Paul Turner <pjt@google.com>,
        Ben Segall <bsegall@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: Re: [PATCH v0.9.1 3/6] sched/umcg: implement UMCG syscalls
Message-ID: <YelCgKeprVDNoal7@hirez.programming.kicks-ass.net>
References: <20211122211327.5931-1-posk@google.com>
 <20211122211327.5931-4-posk@google.com>
 <20211124200822.GF721624@worktop.programming.kicks-ass.net>
 <CAFTs51Uka8VRCHuGidw7mRwATufp87U6S8SWUVod_kU-h6T3ew@mail.gmail.com>
 <YaEUts3RbOLyvAjl@hirez.programming.kicks-ass.net>
 <CAFTs51XnN+N74i1XHvRUAUWd04-Fs9uV6ouXo=CQSQs8MaEM5A@mail.gmail.com>
 <YaUCoe07Wl9Stlch@hirez.programming.kicks-ass.net>
 <CAFTs51UzR=m6+vcjTCNOGwGu3ZwB5GMrg+cSQy2ecvCWxhZvEQ@mail.gmail.com>
 <Ya34S2JCQg+81h4t@hirez.programming.kicks-ass.net>
 <CAPNVh5eYinGEK2Ece45fLYzU8hMWiqAzVdVbdFxd-P5fPXuFSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPNVh5eYinGEK2Ece45fLYzU8hMWiqAzVdVbdFxd-P5fPXuFSA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 19, 2022 at 09:26:41AM -0800, Peter Oskolkov wrote:
> On Mon, Dec 6, 2021 at 3:47 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Nov 29, 2021 at 09:34:49AM -0800, Peter Oskolkov wrote:
> > > On Mon, Nov 29, 2021 at 8:41 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > > > Also, timeout on sys_umcg_wait() gets you the exact same situation (or
> > > > worse, multiple running workers).
> > >
> > > It should not. Timed out workers should be added to the runnable list
> > > and not become running unless a server chooses so. So sys_umcg_wait()
> > > with a timeout should behave similarly to a normal sleep, in that the
> > > server is woken upon the worker blocking, and upon the worker wakeup
> > > the worker is added to the woken workers list and waits for a server
> > > to run it. The only difference is that in a sleep the worker becomes
> > > BLOCKED, while in sys_umcg_wait() the worker is RUNNABLE the whole
> > > time.
> > >
> > > Why then have sys_umcg_wait() with a timeout at all, instead of
> > > calling nanosleep()? Because the worker in sys_umcg_wait() can be
> > > context-switched into by another worker, or made running by a server;
> > > if the worker is in nanosleep(), it just sleeps.
> >
> > I've been trying to figure out the semantics of that timeout thing, and
> > I can't seem to make sense of it.
> >
> > Consider two workers:
> >
> >         S0 running A                            S1 running B
> >
> > therefore:
> >
> >         S0::state == RUNNABLE                   S1::state == RUNNABLE
> >         A::server_tid == S0.tid                 B::server_tid = S1.tid
> >         A::state == RUNNING                     B::state == RUNNING
> >
> > Doing:
> >
> >         self->state = RUNNABLE;                 self->state = RUNNABLE;
> >         sys_umcg_wait(0);                       sys_umcg_wait(10);
> >           umcg_enqueue_runnable()                 umcg_enqueue_runnable()
> 
> sys_umcg_wait() should not enqueue the worker as runnable; workers are
> enqueued to indicate wakeup events.

Oooh... I see.

> So worker timeouts in sys_umcg_wait are treated as wakeup events, with
> the difference that when the worker is eventually scheduled by a
> server, sys_umcg_wait returns with ETIMEDOUT.

Right.. OK, let me go fold and polish what I have now before I go change
things again though.
