Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 639194936BF
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 10:00:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352749AbiASJA2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 04:00:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237437AbiASJA1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 04:00:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D4CAC061574;
        Wed, 19 Jan 2022 01:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qnafBOfaGAHL+V+2V6xLHrQXEkPNWUyyHRjzOTQQks0=; b=X41mnegh42srhJgRjFzw2U39oF
        ik/ga3x206OM81Ma9yTWHodK6706mdjtlmS8QqItoSXc9Ue0Qqv8QHIAGwOSxIb0vENp+L5m5zVg/
        2Xvtm9bjVZtkIGC1TWptFA9/bRvlTSB/bTv/LtdEHijmaMKtLI2FzDXpjx7i+23GYUjNqFhScDqKN
        IrH8x+1khfrS73fXtt2zrSySG2T/cgWuIrttlTTbLNZjChilJEATxTpvPDok+nlBOR/+v6vIzpueR
        zoqHvMEfl6LTr8xeaHhDOKp5jGnYzXVa1vFNBWoRRMcgdWaaS1FxERozztzXfC0ZAhVH0A15cWnLD
        SUdsh4Wg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nA6ot-00AL9R-GZ; Wed, 19 Jan 2022 08:59:55 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 6B9AB300222;
        Wed, 19 Jan 2022 09:59:54 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2E49A200CA459; Wed, 19 Jan 2022 09:59:54 +0100 (CET)
Date:   Wed, 19 Jan 2022 09:59:54 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@google.com>
Cc:     Peter Oskolkov <posk@posk.io>, mingo@redhat.com,
        tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, avagin@google.com, jannh@google.com,
        tdelisle@uwaterloo.ca
Subject: Re: [RFC][PATCH 3/3] sched: User Mode Concurency Groups
Message-ID: <YefTCk4to5YzO8AB@hirez.programming.kicks-ass.net>
References: <20211214204445.665580974@infradead.org>
 <20211214205358.701701555@infradead.org>
 <20211221171900.GA580323@dev-hv>
 <YeGEM7TP3tekBVEh@hirez.programming.kicks-ass.net>
 <YeaRx9oDp08ABvyU@hirez.programming.kicks-ass.net>
 <CAPNVh5cdGiDqut90kUo-HXyya6Nbz_CjuUObYXfprgDhQHnUmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPNVh5cdGiDqut90kUo-HXyya6Nbz_CjuUObYXfprgDhQHnUmg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 18, 2022 at 10:19:21AM -0800, Peter Oskolkov wrote:

> =========== signals and the general approach
> 
> My version of the patchset has all of these things working. What it
> does not have,
> compared to the new approach we are discussing here, is runqueues per server
> and proper signal handling (and potential integration with proxy execution).
> 
> Runqueues per server, in the LAZY mode, are easy to emulate in my patchset:
> nothing prevents the userspace to partition workers among servers, and have
> servers that "own" their workers to be pointed at by idle_server_tid_ptr.
> 
> The only thing that is missing is proper treating of signals. But my patchset
> does ensure a single running worker per server, had pagefaults and preemptions
> sorted out, etc. Basically, everything works except signals. This patchet
> has issues with pagefaults, 

Already fixed pagefaults per:

  YeGvovSckivQnKX8@hirez.programming.kicks-ass.net

> worker timeouts

I still have no clear answer as to what you actually want there.

> , worker-to-worker context
> switches (do workers move runqueues when they context switch?), etc.

Not in kernel, if they need to be migrated, userspace needs to do that.

> And my patchset now actually looks smaller and simpler, on the kernel side,
> that what this patchset is shaping up to be.
> 
> What if I fix signals in my patchset? I think the way you deal with signals
> will work in my approach equally well; I'll also use umcg_kick() to preempt
> workers instead of sending them a signal.
> 
> What do you think? 

I still absolutely hate how long you do page pinning, it *will* wreck
things like CMA which are somewhat latency critical for silly things
like Android camera apps and who knows what else.

You've also forgotten about this:

  YcWutpu7BDeG+dQ2@hirez.programming.kicks-ass.net

That's not optional given how you're using page-pinning. Also, I think
we need at least one direct access to the page after getting the pin in
order to make it work.

That also very much limits it to Anon pages.
