Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED7D2495B7E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 09:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379342AbiAUIAR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 03:00:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379221AbiAUIAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 03:00:11 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D73C061574;
        Fri, 21 Jan 2022 00:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=lM96gxE5Zvd4KW4P3zg/HRQmsMNlTVeN2Nd1koQYNu0=; b=YmPjgbo+hz7cUwXro8Ro7FtcZk
        7OcXA3deT6tbo/KjioKqugUMGejB/qwRcuUZ+kzw1bQsrNt2GcQzylzIS0ym0bonp5WFfBihTC0PD
        wFo2EPBnVbIY7jn/BfL5m947SGp9OQ50nUhsMk2OpsH0Ce1XlZtnvj02wLBdDYXw6+fA6H96kjF+u
        ldftHUnIVWas7ZrkXmaPMBz5SRgsALt8ggiLPJdQ6xP2GmbiQ4hcF13YE4iCxfvGhIVfU3mCcoW+Y
        /QUk0qvEwVjhU1NNmLLUQiQfTqEdVxupynRs8+QBlVkJhjJr2WwyMMOQw6xZMcAp7QopZTZ0uUrUI
        CCRvrzWQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAopk-002XY0-7a; Fri, 21 Jan 2022 07:59:44 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 51F19984B76; Fri, 21 Jan 2022 08:59:43 +0100 (CET)
Date:   Fri, 21 Jan 2022 08:59:43 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Nadav Amit <nadav.amit@gmail.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        Steven Rostedt <rostedt@goodmis.org>, bsegall@google.com,
        Mel Gorman <mgorman@suse.de>, bristot@redhat.com,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        X86 ML <x86@kernel.org>, pjt@google.com, posk@google.com,
        avagin@google.com, Jann Horn <jannh@google.com>,
        tdelisle@uwaterloo.ca, mark.rutland@arm.com, posk@posk.io
Subject: Re: [RFC][PATCH v2 1/5] mm: Avoid unmapping pinned pages
Message-ID: <20220121075943.GB20638@worktop.programming.kicks-ass.net>
References: <20220120155517.066795336@infradead.org>
 <20220120160822.666778608@infradead.org>
 <E63F4045-E624-47FE-A417-5D2FF7923179@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E63F4045-E624-47FE-A417-5D2FF7923179@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 10:03:44AM -0800, Nadav Amit wrote:

> > --- a/mm/mprotect.c
> > +++ b/mm/mprotect.c
> > @@ -106,6 +106,12 @@ static unsigned long change_pte_range(st
> > 					continue;
> > 
> > 				/*
> > +				 * Can't migrate pinned pages, avoid touching them.
> > +				 */
> > +				if (page_maybe_dma_pinned(page))
> > +					continue;
> > +
> > +				/*
> > 
> 
> I have a similar problem with userfaultfd changing protection for
> DMA-pinned pages. For userfaultfd it is important to know how many
> pages were actually modified.
> 
> I am working on a vectored UFFDIO_WRITEPROTECTV that aborts once
> a pinned page is encountered, but also returns the number of pages
> that were properly protected. I still need to do some work to
> send patches for that as it requires further changes (to return
> the number of pages that were handled).
> 
> But for the matter of your patch, is it possible to make this
> test generic (not migration specific) and rely on a new flag in
> cp_flags? I can of course make this change later if you prefer it
> this way.

I have no objection to making it apply more widely, but I'm currently
only interested in the rmap users. If userspace does mprotect() on it's
own pages, it gets to keep whatever pieces are the result of that.
