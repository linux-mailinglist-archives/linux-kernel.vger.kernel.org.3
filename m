Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D564756CA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 11:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbhLOKpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 05:45:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbhLOKpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 05:45:15 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5494CC061574;
        Wed, 15 Dec 2021 02:45:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ri+zdawudXgxAzscU1cRqkMc+UJ/ZceDl69E/eAootg=; b=bF1U3XaTIPTP8OzTZo/py3pL1n
        HeIi5p+wrTocF4lUzT4+WF7Uq5b49yYOANErk8pFisKWn0r1Y0PzUVZP1UWlzn5CKIlUfPNRyy/A5
        dFQG8x3mpfmuh8FCl2fO0mlZQwzLHD5nPoweoGFYryCLvxhf+hDUkz0CCiz4DoPEdxkwHeZbbjyOb
        PNu/hP9gyONi03R84gugzTBWGA5DpC6rY/n86zDWnjHhUrG/mrEarrCnj+S2jh3jccKmuW0kF0EuL
        pa75hefUOMCP/on2MW9l3iEjSbiyXfU57TwSITSmJH1ZWAVa9FXXuoe6FF/k+rYgOYRWbx0H3o9md
        5sYHl95g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxRmE-001URT-C3; Wed, 15 Dec 2021 10:44:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6497330003C;
        Wed, 15 Dec 2021 11:44:49 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0B9EC2B3206F8; Wed, 15 Dec 2021 11:44:49 +0100 (CET)
Date:   Wed, 15 Dec 2021 11:44:49 +0100
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
Message-ID: <YbnHIRdv/8bjZxX/@hirez.programming.kicks-ass.net>
References: <20211214204445.665580974@infradead.org>
 <CAFTs51XRJj1pwF6q5hwdGP0jtXmY81QQmTzyuA26fHMH0zCymw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFTs51XRJj1pwF6q5hwdGP0jtXmY81QQmTzyuA26fHMH0zCymw@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 07:46:25PM -0800, Peter Oskolkov wrote:

> Anyway, I'll test your patchset over the next week or so and let you
> know if anything really needed is missing (other than waking an idle
> server if there is one on a worker wakeup; this piece is definitely
> needed).

Right, so the problem I'm having is that a single idle server ptr like
before can trivially miss waking annother idle server.

Suppose:

	umcg::idle_server_tid_ptr

Then the enqueue_and_wake() thing from the last patch would:

	idle_server_tid = xchg((pid_t __user *)self->idle_server_tid_ptr, 0);

to consume the tid, and then use that to enqueue and wake. But what if a
second wakeup happens right after that? There might be a second idle
server, but we'll never find it, because userspace hasn't had time to
update the field again.

Alternatively, we do a linked list of servers, but then every such
wakeup needs to iterate the whole list, looking for one that has
UMCG_TF_IDLE set, or something like that, but that lookup is bad for
performance.

So I'm really not sure what way to go yet.
