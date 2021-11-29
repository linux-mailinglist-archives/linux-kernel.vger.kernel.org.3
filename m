Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D20554624E0
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 23:29:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbhK2Wcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 17:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbhK2WcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 17:32:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33CB0C08EB57;
        Mon, 29 Nov 2021 14:22:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=P+7rLpDmI0GB1uveawAKeTOyJh4WuhEPHuwGYT+nYA8=; b=TwmRukm9ui9hBITy8IFXrg6u+n
        pEYD+1yhOiTaaD/zRtr0G6JNDxz7aFt1dRouS3jONa0pV8lY369lo1UwDcuXjvWJwqOF8Ow5AwXrR
        vwqWZBre13UBT3muF3jwPbLaG5zmJa7J84p9xVISbAJxl+Q1Q7ic05yXJ1SKP67wdjXBB3IP+wiYd
        O8l8+Od6JPMkyTeGywiiTjGEjQmeYRCU5X40brTQi9cTBsff8ImI4ViGbcuv1kueyZ+UJU7+sw9U2
        B7fGvtXxRc5rXHPKgvCfFpM1fzT+8zPrgafOyIzBv5qZtrCZAAitFJyDCRGg9/w9wAku3ZzJ2Mkxd
        C2Cdyv8w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mrp2q-009SwH-6B; Mon, 29 Nov 2021 22:22:45 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1826D98675D; Mon, 29 Nov 2021 23:22:44 +0100 (CET)
Date:   Mon, 29 Nov 2021 23:22:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Oskolkov <posk@posk.io>, Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Paul Turner <pjt@google.com>, Ben Segall <bsegall@google.com>,
        Peter Oskolkov <posk@google.com>,
        Andrei Vagin <avagin@google.com>, Jann Horn <jannh@google.com>,
        Thierry Delisle <tdelisle@uwaterloo.ca>
Subject: Re: [PATCH v0.9.1 3/6] sched/umcg: implement UMCG syscalls
Message-ID: <20211129222243.GR721624@worktop.programming.kicks-ass.net>
References: <20211122211327.5931-1-posk@google.com>
 <20211122211327.5931-4-posk@google.com>
 <20211124211927.GG721624@worktop.programming.kicks-ass.net>
 <877dcuhbbe.ffs@tglx>
 <YaFXDYm7s7A6HDTG@hirez.programming.kicks-ass.net>
 <87r1ayd3as.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87r1ayd3as.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 29, 2021 at 11:07:07PM +0100, Thomas Gleixner wrote:
> On Fri, Nov 26 2021 at 22:52, Peter Zijlstra wrote:

> The size is the same, i.e. 1 bit per nanosecond :)

:-)

> > The only time that's relevant though is when you're going to mix these
> > timestamps with CLOCK_THREAD_CPUTIME_ID, which might just be
> > interesting.
> 
> Uuurg. If you want to go towards CLOCK_THREAD_CPUTIME_ID, that's going
> to be really nasty. Actually you can sleep on that clock, but that's a
> completely different universe. If anything like that is desired then we
> need to rewrite that posix CPU timer muck completely with all the bells
> and whistels and race conditions attached to it. *Shudder*

Oh, I wasn't thinking anything as terrible as that. Sleeping on that
clock is fundamentally daft since it doesn't run when thats is
sleeping, consider trying to sleep on your own runtime :-)

I was only considering combining THREAD_CPUTIME timestamps with the
UMCG timestamps to compute how much unmanaged time there was, or other
such things.

Anyway, lets forget I bought this up and assume that for practical
purposes all [ns] are of equal length.
