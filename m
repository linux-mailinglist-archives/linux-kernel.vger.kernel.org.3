Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78214760AA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 19:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343764AbhLOSZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 13:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245460AbhLOSZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 13:25:30 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FED4C061574;
        Wed, 15 Dec 2021 10:25:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uE77z3J6ZV69h4+deFWZnKMlHZLBoYzkSsmW+InoK1k=; b=vZK61Q99j7721uKoBWpx6d4OUk
        gLX1J2af+N/q57W/SujcYDSIsvWG/iMFYBFNShD0zOAUyRQcczBiapN9R13qHgC4h3F0rZ1yntXVC
        xE2+ArtKMX8zFGXnuo+Ad29iz/Lmcog3eeSyaJl2xiFVcDSE3U/waBlN/Kqh1U0dk84+k6A2D5Q80
        2zIDuN1+GR+EokKZfbPrBtrOtANEzh4tZ/UKREWd6uyVfVfqKakugoVknRVBB/9jzkEgVb3Rpmm0O
        Wpq01OooCsl95AulbRnU8l6+dThDaGuNu5B01qs+XXUy28vs0fbHryS4sF+IxcN0zvZfuOSCKDXA6
        og8XD9DA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxYxh-00EuBG-JW; Wed, 15 Dec 2021 18:25:10 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 8EE4C3001C0;
        Wed, 15 Dec 2021 19:25:09 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4D154200C2286; Wed, 15 Dec 2021 19:25:09 +0100 (CET)
Date:   Wed, 15 Dec 2021 19:25:09 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@posk.io>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, juri.lelli@redhat.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, mgorman@suse.de,
        bristot@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-api@vger.kernel.org, x86@kernel.org,
        Paul Turner <pjt@google.com>, Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: Re: [RFC][PATCH 0/3] sched: User Managed Concurrency Groups
Message-ID: <YbozBSLk4PytGp0J@hirez.programming.kicks-ass.net>
References: <20211214204445.665580974@infradead.org>
 <CAFTs51XRJj1pwF6q5hwdGP0jtXmY81QQmTzyuA26fHMH0zCymw@mail.gmail.com>
 <Ybm+HJzkO/0BB4Va@hirez.programming.kicks-ass.net>
 <CAFTs51Xb6m=htpWsVk577n-h_pRCpqRcBg6-OhBav8OadikHkw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFTs51Xb6m=htpWsVk577n-h_pRCpqRcBg6-OhBav8OadikHkw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 09:56:06AM -0800, Peter Oskolkov wrote:
> On Wed, Dec 15, 2021 at 2:06 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >  /*
> > + * Enqueue tsk to it's server's runnable list and wake the server for pickup if
> > + * so desired. Notable LAZY workers will not wake the server and rely on the
> > + * server to do pickup whenever it naturally runs next.
> 
> No, I never suggested we needed per-server runnable queues: in all my
> patchsets I had a single list of idle (runnable) workers.

This is not about the idle servers..

So without the LAZY thing on, a previously blocked task hitting sys_exit
will enqueue itself on the runnable list and wake the server for pickup.

IIRC you didn't like the server waking while it was still running
another task, but instead preferred to have it pick up the newly
enqueued task when next it ran.

LAZY enables that.. *however* it does need to wake the server when it is
idle, otherwise they'll all sit there waiting for one another.
