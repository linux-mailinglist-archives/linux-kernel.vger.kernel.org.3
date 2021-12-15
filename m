Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15EFE4759ED
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 14:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242991AbhLONty (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 08:49:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237523AbhLONtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 08:49:51 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21969C061574;
        Wed, 15 Dec 2021 05:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=iuaYJqma/ERiefenupmDJPzfD80YKiUtXtqKwSolbeo=; b=hTExRdHTxiLn75Zknoq0y9o5H4
        0zxG/+VZG7PMMXpqiyFOmW2MRru8Q92pkg5yQN4hi0PINVrOPRM7va6jxuocFrvlgOo+R2nZZVRoE
        wwgCQ5qNOSg7SlU7AcpdvnqZtAgpapgMzF8fsgA6tNkYUEUv2OXadB7P/S/33fiByodoVVEg4Jipu
        McjTELM2qMPw0e29FDbPq4YcoXpmVG9/0e6YCci1lSCeWsxxHZLgw7eVjIadOZ/QiOZlki/sl8Fxc
        vEg5T8WitZbroosREJ24YG2W6Vyhz3f7U6wMbbTVPtRNoiQp8XRJSxw1DY06m8Hoc0tm4reezKvX5
        ViIrurtg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxUeu-00Eh0z-GE; Wed, 15 Dec 2021 13:49:28 +0000
Date:   Wed, 15 Dec 2021 13:49:28 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Peter Oskolkov <posk@posk.io>, Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <YbnyaCT4wh0II/Ew@casper.infradead.org>
References: <20211214204445.665580974@infradead.org>
 <CAFTs51XRJj1pwF6q5hwdGP0jtXmY81QQmTzyuA26fHMH0zCymw@mail.gmail.com>
 <YbnHIRdv/8bjZxX/@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbnHIRdv/8bjZxX/@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 11:44:49AM +0100, Peter Zijlstra wrote:
> On Tue, Dec 14, 2021 at 07:46:25PM -0800, Peter Oskolkov wrote:
> 
> > Anyway, I'll test your patchset over the next week or so and let you
> > know if anything really needed is missing (other than waking an idle
> > server if there is one on a worker wakeup; this piece is definitely
> > needed).
> 
> Right, so the problem I'm having is that a single idle server ptr like
> before can trivially miss waking annother idle server.
> 
> Suppose:
> 
> 	umcg::idle_server_tid_ptr
> 
> Then the enqueue_and_wake() thing from the last patch would:
> 
> 	idle_server_tid = xchg((pid_t __user *)self->idle_server_tid_ptr, 0);
> 
> to consume the tid, and then use that to enqueue and wake. But what if a
> second wakeup happens right after that? There might be a second idle
> server, but we'll never find it, because userspace hasn't had time to
> update the field again.
> 
> Alternatively, we do a linked list of servers, but then every such
> wakeup needs to iterate the whole list, looking for one that has
> UMCG_TF_IDLE set, or something like that, but that lookup is bad for
> performance.
> 
> So I'm really not sure what way to go yet.

1. Linked lists are fugly and bad for the CPU.

2. I'm not sure how big the 'N' in 'M:N' is supposed to be.  Might be
one per hardware thread?  So it could be hundreds-to-thousands,
depending on the scale of system.

3. The interface between user-kernel could be an array of idle tids,
maybe 16 entries long (16 * 4 = 64 bytes, just one cacheline).  As a
server finishes work, it looks for a 0 tid in the batch and stores
its tid in the slot (cmpxchg, I guess, since the array will be shared
between processes).  If there are no free slots in the array, then we
definitely have 16 threads already waiting for work, so it can park itself
in whatever data structure userspace wants to use to manage idle servers.
It's up to userspace to decide when to repopulate the array of available
servers from its data structure of idle servers.
