Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2666C476092
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 19:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343708AbhLOSTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 13:19:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343692AbhLOSTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 13:19:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73D4CC061574;
        Wed, 15 Dec 2021 10:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zmFY3Gs53FyRCPoRjth8UcDlb/32jRwmwTYyj2vOBUo=; b=LRIKOnjS723sZGnU7NLgsxvD1U
        4y4Xc1ywEcIKnMpZ2HnWPWW8h4WLF5TFDB5CmkQmN5YOiC60be9chJ+t4lvcbSZ949lwXZhJHK7N4
        rdQvnwNQJmze7vGC8ymwTTxhiMW1ZkP0MdSBcKuywW08pWSV/QOJN4T8+13Yvd8bAWAMjw33YDVDZ
        PNyme0HTyDKFO44pT8Heo9E34DnYK3q7MoP+j2eNGRaDzfaxtmq7Y8wM353OSK4+GyGSzdIWbCYjA
        SuQjvgM9s31JXx7cantn7hj4TbBZWP6PLyndtgf93g4rNWFJ43+MUtSqrQTmkmmh+GR9eAwFUFMXO
        AK5Srjow==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxYre-00Etns-4Q; Wed, 15 Dec 2021 18:18:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 29DA6300348;
        Wed, 15 Dec 2021 19:18:53 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0C1A2200C2286; Wed, 15 Dec 2021 19:18:53 +0100 (CET)
Date:   Wed, 15 Dec 2021 19:18:53 +0100
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
Message-ID: <YboxjUM+D9Kg52mO@hirez.programming.kicks-ass.net>
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

> > Right, so the problem I'm having is that a single idle server ptr like
> > before can trivially miss waking annother idle server.
> 
> I believe the approach I used in my patchset, suggested by Thierry
> Delisle, works.
> 
> In short, there is a single idle server ptr for the kernel to work
> with. The userspace maintains a list of idle servers. If the ptr is
> NULL, the list is empty. When the kernel wakes the idle server it
> sees, the server reaps the runnable worker list and wakes another idle
> server from the userspace list, if available. This newly woken idle
> server repoints the ptr to itself, checks the runnable worker list, to
> avoid missing a woken worker, then goes to sleep.
> 
> Why do you think this approach is not OK?

Suppose at least 4 servers, 2 idle, 2 working.

Now, the first of the working servers (lets call it S0) gets a wakeup
(say Ta), it finds the idle server (say S3) and consumes it, sticking Ta
on S3 and kicking it alive.

Concurrently and loosing the race the other working server (S1) gets a
wake-up from Tb, like said, it lost, no idle server, so Tb goes on the
queue of S1.

So then S3 wakes, finds Ta and they live happily ever after.

While S2 and Tb fail to meet one another and both linger in sadness.

