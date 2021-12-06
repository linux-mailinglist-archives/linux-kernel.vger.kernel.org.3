Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89492469563
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242890AbhLFMIQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:08:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242859AbhLFMH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:07:59 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5113EC061746;
        Mon,  6 Dec 2021 04:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yy6AzzEJ5qiDQ0OD9hNQU4Y5alKRjewAktEGPtj8qZA=; b=U2IfE6D0qPRW9OE6gvO3yX3ikl
        CJtu4mdKLIQxoSuST7+ks5Q2yqJbuWzrJXkYWobot2Yid2v714jaybgz8K9TGd/XZfgRMc9fmEWsP
        yyzb29cTFuSP8El01qBHkiwv+qixATtj0zXZbd5iBx7M3BaZz8Xi2fk5qfqEHzLTS+UDP8n8uKIsd
        zgqAg88+cM/HR2qcHjt1zYcarLJd8bjEyL43n5FlVyNNpBrr+z4p0ihybSE2ln0d6zZKgur98HGMa
        UVpQ+fEYyN5XhZ55ZEGw+QB3y7tun4EuaFxYKdpEEPI+GU7KSMx0HUImqFwprz4YZAatwVkw95PlK
        BtZKPFdQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1muCjE-002YV6-Vw; Mon, 06 Dec 2021 12:04:21 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3DE103002C5;
        Mon,  6 Dec 2021 13:04:20 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 22E7E202CABA2; Mon,  6 Dec 2021 13:04:20 +0100 (CET)
Date:   Mon, 6 Dec 2021 13:04:20 +0100
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
Message-ID: <Ya38RAveh31aYH0k@hirez.programming.kicks-ass.net>
References: <20211122211327.5931-4-posk@google.com>
 <20211124200822.GF721624@worktop.programming.kicks-ass.net>
 <CAFTs51Uka8VRCHuGidw7mRwATufp87U6S8SWUVod_kU-h6T3ew@mail.gmail.com>
 <YaEUts3RbOLyvAjl@hirez.programming.kicks-ass.net>
 <CAFTs51XnN+N74i1XHvRUAUWd04-Fs9uV6ouXo=CQSQs8MaEM5A@mail.gmail.com>
 <YaUCoe07Wl9Stlch@hirez.programming.kicks-ass.net>
 <CAFTs51UzR=m6+vcjTCNOGwGu3ZwB5GMrg+cSQy2ecvCWxhZvEQ@mail.gmail.com>
 <20211129210841.GO721624@worktop.programming.kicks-ass.net>
 <CAFTs51XyGDNj89+FCn4HZqMHuenjQu2wqTOW8ow4hSUbdGrGhw@mail.gmail.com>
 <Ya30xsrQnwyT/R92@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ya30xsrQnwyT/R92@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 06, 2021 at 12:32:22PM +0100, Peter Zijlstra wrote:
> On Mon, Nov 29, 2021 at 03:38:38PM -0800, Peter Oskolkov wrote:
> > On Mon, Nov 29, 2021 at 1:08 PM Peter Zijlstra <peterz@infradead.org> wrote:

> Now, the above situation is actually simple to fix, but it gets more
> interesting when we're using sys_umcg_wait() to build wait primitives.
> Because in that case we get stuff like:
> 
> 	for (;;) {
> 		self->state = RUNNABLE;
> 		smp_mb();
> 		if (cond)
> 			break;
> 		sys_umcg_wait();
> 	}
> 	self->state = RUNNING;
> 
> And we really need to not block and also not do sys_umcg_wait() early.
> 
> So yes, I agree that we need a special case here that ensures
> umcg_notify_resume() doesn't block. Let me ponder naming and comments.
> Either a TF_COND_WAIT or a whole new state. I can't decide yet.

Hurmph... OTOH since self above hasn't actually done anything yet, it
isn't reported as runnable yet, and so for all intents and purposes the
userspace state thinks it's running (which is true) and nobody should be
trying a concurrent wakeup and there anre't any races.

Bah, now I'm confused again :-) Let me go think more.

