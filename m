Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADEC0461F99
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 19:50:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351136AbhK2Sxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 13:53:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379074AbhK2Svk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 13:51:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8E2C043CED;
        Mon, 29 Nov 2021 07:06:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cWeTh3Kjsmkogd+g2xT/H6uwopOz4RWKcLeCTh9XWLw=; b=UpyHob2nOzQlt3GLZwCXoCGNmH
        CW09OTiCAA/HVokLDKi3pRgrD4jw665wfDDThwS16JqjPB7aYSElZnfmJTEr87v1BvNXd/DhykjqQ
        IeW/hTFfRL8sKiUQUwnuVEOQosUkjvH4Tm5gUQ6/sLkT98ky3UBNe1cr3z70H/nUo1QLtZdxapsmZ
        NQ3sszydlEH27eXssHOQNK4NHIR0a2vE6SeKhPvOsIRHEdPSfs7UjFx3nGmux4H4gTfkSgKJLut3b
        3/IOYR79C8Ve7yyXMRNKF0ux/leoY8VgcUujiQeK54iV3WKgDgMBHdKUq8ShjVgAGV2q7idrSgCON
        CW7lyQeg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mriE5-0082wV-2f; Mon, 29 Nov 2021 15:05:53 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id BD222300235;
        Mon, 29 Nov 2021 16:05:52 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id A28E72B2FCB2A; Mon, 29 Nov 2021 16:05:52 +0100 (CET)
Date:   Mon, 29 Nov 2021 16:05:52 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Oskolkov <posk@posk.io>, Ingo Molnar <mingo@redhat.com>,
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
Message-ID: <YaTsUIprH6CKASW8@hirez.programming.kicks-ass.net>
References: <20211122211327.5931-1-posk@google.com>
 <20211122211327.5931-4-posk@google.com>
 <20211124200822.GF721624@worktop.programming.kicks-ass.net>
 <CAFTs51Uka8VRCHuGidw7mRwATufp87U6S8SWUVod_kU-h6T3ew@mail.gmail.com>
 <YaEUts3RbOLyvAjl@hirez.programming.kicks-ass.net>
 <87a6hqhbgh.ffs@tglx>
 <YaFY0KqfPhmZjK7n@hirez.programming.kicks-ass.net>
 <87tufyfmu7.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tufyfmu7.ffs@tglx>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 27, 2021 at 01:45:20AM +0100, Thomas Gleixner wrote:
> On Fri, Nov 26 2021 at 22:59, Peter Zijlstra wrote:
> > On Fri, Nov 26, 2021 at 10:08:14PM +0100, Thomas Gleixner wrote:
> >> > +		if (timo)
> >> > +			hrtimer_sleeper_start_expires(&timeout, HRTIMER_MODE_ABS);
> >> > +
> >> > +		freezable_schedule();
> >> 
> >> You can replace the whole hrtimer foo with
> >> 
> >>                 if (!schedule_hrtimeout_range_clock(timo ? &timo : NULL,
> >>                                                     tsk->timer_slack_ns,
> >>                                                     HRTIMER_MODE_ABS,
> >>                                                     tsk->umcg_clock)) {
> >>                 	ret = -ETIMEOUT;
> >>                         break;
> >>                 }
> >
> > That seems to loose the freezable crud.. then again, since we're
> > interruptible, that shouldn't matter. Lemme go do that.
> 
> We could add a freezable wrapper for that if necessary.

I should just finish rewriting that freezer crap and then we can delete
it all :-) But I don't think that's needed in this case, as long as
we're interruptible we'll pass through the signal path which has a
try_to_freezer() in it.
