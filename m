Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B90475FEF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 18:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239113AbhLORzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 12:55:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233317AbhLORzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 12:55:11 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A468CC061574;
        Wed, 15 Dec 2021 09:55:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1F3FEXJ4yhSUpnk3DQ4jfn2zagG0lZEE4SF39YTnx6U=; b=DskP6IKXoJEVDhanbnDjWX84+B
        MZsZP04WhbVOnigzS8cgl/IeVq1EbAteGjKQq9t+z6nTd5VA3goGkpgWJxaP3igzrtOe63IQyrBTW
        A4ZU2bvC3JKPnFrS/RzkBVL1kRQq9YU7AYA2VAz3/zc+WyosgoaAdmBaQ+guUgt8dV34csrlsCmrD
        zKvMrLAKecYP5yvJwkmOXA7F0CDv90yROCla4cS80EMFxZ2CgLcOTjBXVMpiQcMd8BPCph4shIVWf
        qrcUgwXji8gTuht5Nz948+GcJ3QDmCgo1vhXMkQ1DIjo7k5VMJ8Va/oQF5V5xwv3oSXmIeLIWqM6s
        u6Fg3Rsw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxYUI-001XhH-D5; Wed, 15 Dec 2021 17:54:46 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id ED208300348;
        Wed, 15 Dec 2021 18:54:44 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id B10EA20A30BE4; Wed, 15 Dec 2021 18:54:44 +0100 (CET)
Date:   Wed, 15 Dec 2021 18:54:44 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Matthew Wilcox <willy@infradead.org>
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
Message-ID: <Ybor5FvS9i560Db4@hirez.programming.kicks-ass.net>
References: <20211214204445.665580974@infradead.org>
 <CAFTs51XRJj1pwF6q5hwdGP0jtXmY81QQmTzyuA26fHMH0zCymw@mail.gmail.com>
 <YbnHIRdv/8bjZxX/@hirez.programming.kicks-ass.net>
 <YbnyaCT4wh0II/Ew@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YbnyaCT4wh0II/Ew@casper.infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 01:49:28PM +0000, Matthew Wilcox wrote:
> On Wed, Dec 15, 2021 at 11:44:49AM +0100, Peter Zijlstra wrote:
> > On Tue, Dec 14, 2021 at 07:46:25PM -0800, Peter Oskolkov wrote:
> > 
> > > Anyway, I'll test your patchset over the next week or so and let you
> > > know if anything really needed is missing (other than waking an idle
> > > server if there is one on a worker wakeup; this piece is definitely
> > > needed).
> > 
> > Right, so the problem I'm having is that a single idle server ptr like
> > before can trivially miss waking annother idle server.
> > 
> > Suppose:
> > 
> > 	umcg::idle_server_tid_ptr
> > 
> > Then the enqueue_and_wake() thing from the last patch would:
> > 
> > 	idle_server_tid = xchg((pid_t __user *)self->idle_server_tid_ptr, 0);
> > 
> > to consume the tid, and then use that to enqueue and wake. But what if a
> > second wakeup happens right after that? There might be a second idle
> > server, but we'll never find it, because userspace hasn't had time to
> > update the field again.
> > 
> > Alternatively, we do a linked list of servers, but then every such
> > wakeup needs to iterate the whole list, looking for one that has
> > UMCG_TF_IDLE set, or something like that, but that lookup is bad for
> > performance.
> > 
> > So I'm really not sure what way to go yet.
> 
> 1. Linked lists are fugly and bad for the CPU.

Absolutely.. although a stack might work, except for that ABA issue (and
contention).

> 2. I'm not sure how big the 'N' in 'M:N' is supposed to be.  Might be
> one per hardware thread?  So it could be hundreds-to-thousands,
> depending on the scale of system.

Typically yes, one server task per hardware thread. Now, I'm also fairly
sure you don't want excessive cross-node traffic for this stuff, so that
puts a limit on things as well.

> 3. The interface between user-kernel could be an array of idle tids,
> maybe 16 entries long (16 * 4 = 64 bytes, just one cacheline).  As a
> server finishes work, it looks for a 0 tid in the batch and stores
> its tid in the slot (cmpxchg, I guess, since the array will be shared
> between processes).  If there are no free slots in the array, then we
> definitely have 16 threads already waiting for work, so it can park itself
> in whatever data structure userspace wants to use to manage idle servers.
> It's up to userspace to decide when to repopulate the array of available
> servers from its data structure of idle servers.

Right, a tid array might work. Could even have userspace specify the
length, then it can do the trade-offs all on it's own. Either a fixed
location for each server and a larger array, or clever things, whatever
they want.

I suppose I'll code up the variable length array, we have space for
that.
