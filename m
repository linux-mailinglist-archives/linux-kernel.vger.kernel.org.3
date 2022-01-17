Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8258490879
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 13:13:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239753AbiAQMN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 07:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbiAQMN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 07:13:57 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37863C061574;
        Mon, 17 Jan 2022 04:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=0xwjXHytdG9TW+eEv4h5HG046BJiyWLMcQrJvytddgc=; b=Pz8qepblptPdOh+nacvo2kZqQ4
        1ITos2gLO+OPiB77uK7PkjNvo7oL9fZrE+gVFXl/EZjE0fcMaiuNDDZR+/mhn1jDamMHBX68xBPZP
        P1QvUSgvqMdcGkx60U3GHqCbO8uOdwurN8/WsCs0sTIey18EU6B+ACuqHIPrhVnY87KG+cJNTAegQ
        1vO7/SjXM0Kv51kNUDzTMp5ysaC4X0YLehawm3MHYtqHk98oar1uNQWWLRst0Prx1WLzD0m2O1PLF
        mzkSome0hxLI/FCGZpTOZk2AJaqz0QPkKKgkCbgDGUnSbVfU2K+190bUlsEpAH+MLJ/u0BwG5WwhJ
        hBIqjnRQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n9Qsd-001dpx-C8; Mon, 17 Jan 2022 12:12:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 775EA3001FD;
        Mon, 17 Jan 2022 13:12:57 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 387852027C5EF; Mon, 17 Jan 2022 13:12:57 +0100 (CET)
Date:   Mon, 17 Jan 2022 13:12:57 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@posk.io>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, posk@google.com, avagin@google.com,
        jannh@google.com, tdelisle@uwaterloo.ca
Subject: Re: [RFC][PATCH 3/3] sched: User Mode Concurency Groups
Message-ID: <YeVdSYrkmMW2i8+N@hirez.programming.kicks-ass.net>
References: <20211214204445.665580974@infradead.org>
 <20211214205358.701701555@infradead.org>
 <20211221171900.GA580323@dev-hv>
 <YeGEM7TP3tekBVEh@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YeGEM7TP3tekBVEh@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 14, 2022 at 03:09:55PM +0100, Peter Zijlstra wrote:
> On Tue, Dec 21, 2021 at 05:19:00PM +0000, Peter Oskolkov wrote:

> > > +	/*
> > > +	 * Workers will still block in umcg_notify_resume() before they can
> > > +	 * consume their error, servers however need to get the error asap.
> > > +	 *
> > > +	 * Still, things might be unrecoverably screwy after this. Not our
> > > +	 * problem.
> > 
> > I think we should explicitly document the unrecoverable screwiness
> > of errors here, so that the userspace proactively kills itself
> > to avoid badness. The only reason that returning an error here is
> > mildly preferable to just killing the task (we already do that
> > in other places) is to give the userspace an opportunity to
> > log an error, with more state/info than we can do here.
> 
> Bah, I should've written a better comment, because I can't quite
> remember the case I had in mind. Also, again from the LAZY patch, I
> think we can actually do better in some of the cases here.
> 
> Specifically, currently we'll enqueue on ::runnable_workers_ptr and fail
> waking ::next_tid and leave it at that. While I think waking
> ::server_tid in that case makes sense.
> 
> I'll go prod at this.

Is anybody actually planning to use ::next_tid for workers?

My current thinking is that much of the problems here stem from that.

Let me ponder more..
