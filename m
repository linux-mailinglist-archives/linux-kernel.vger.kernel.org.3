Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD8C4CADC8
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 19:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244468AbiCBSpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 13:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244691AbiCBSox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 13:44:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C8FD04B4
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 10:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=aB+E32SV8Widsy5hZm4SDjs3y2zV+hJliWd8+r+tQKc=; b=WlHj8/DcuQg8olNKD9pOlLvOcP
        EGN3ab2VLYSQocFmXfUHF72DLsPPNYkZ3b/ZN3nKLOPC90xJyqGR8QPdJbLlQ0rsvUnhBlcLkXqWL
        X8I5/cbUsC0wbrXpGGHo3atu0s/SxAdYjy7gYt4racnUp+KgGoqMXS6BPDq8lrMGQNXGX3y/qe28F
        4x4ogm/OLsxX/+Ls5WHetLay8R0eVsSuXbO0k5Az3UD+CJ7xrcdEzCKuqBRjxse19yt9891w+RX/1
        KM3jVC6UzpwCE78hgfeYP8Hv0FAHmd+0OlqcoWgrqTShXN+Vg1rsqbBqOKcfdDdSw7t5+qK/eGIfn
        wetp6sIQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPTx7-00AtAW-3b; Wed, 02 Mar 2022 18:43:57 +0000
Date:   Wed, 2 Mar 2022 18:43:57 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/19] Enable -Wshadow=local for kernel/sched
Message-ID: <Yh+67VF0/OFSp15y@casper.infradead.org>
References: <20220302043451.2441320-1-willy@infradead.org>
 <202203021030.EEEF58C2@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202203021030.EEEF58C2@keescook>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 02, 2022 at 10:32:23AM -0800, Kees Cook wrote:
> On Wed, Mar 02, 2022 at 04:34:32AM +0000, Matthew Wilcox (Oracle) wrote:
> > I thought I'd choose one of the more core parts of the kernel to
> > demonstrate the value of -Wshadow.  It found two places where there are
> > shadowed variables that are at least confusing.  For all I know they're
> > buggy and my resolution of these warnings is wrong.
> > 
> > The first 12 patches just untangle the unclean uses of __ret in wait.h
> > & friends.  Then 4 patches to fix problems in headers that are noticed
> > by kernel/sched.  Two patches fix the two places in kernel/sched/
> > with shadowed variables and the final patch adds -Wshadow=local to
> > the Makefile.
> 
> You are my hero. I was pulling my hair out trying to figure out how
> to deal with this a few months ago, and the use of UNIQUE_ID was the
> key. Yay!
> 
> > I'm quite certain this patch series isn't going in as-is.  But maybe
> > it'll inspire some patches that can go in.
> 
> I think it's pretty darn close. One thing that can be done to test the
> results for the first 12 patches is to do a binary comparison -- these
> changes _should_ have no impact on the final machine code. (It'll
> totally change the debug sections, etc, but the machine code should be
> the same.)

Peter pointed out that I got confused about which __ret was being
referred to:

<peterz> +#define __wait_event_freezable_timeout(wq_head, condition, timeout, __ret) \
<peterz> +       ___wait_event(wq_head, ___wait_cond_timeout(condition, __ret),  \
<peterz> +                     TASK_INTERRUPTIBLE, 0, timeout,                   \
<peterz> +                     __ret = freezable_schedule_timeout(__ret), UNIQUE_ID)
<peterz> so now that internal variable is UNIQUE_ID, whatever that is
<peterz> but the condition argument was supposed to look at that
<peterz> but you explicitly pulled that out

ie "__ret = freezable_schedule_timeout(__ret)" is supposed to refer to
the inner __ret, not the outer __ret.  Which was the opposite of what
I thought was supposed to happen.

We can fix this, of course.  Something like ...

#define ___wait_event_freezable_timeout(wq_head, condition, timeout, ret) \
	___wait_event(wq_head, ___wait_cond_timeout(condition, ret),      \
		TASK_INTERRUPTIBLE, 0, timeout,				  \
		ret = freezable_schedule_timeout(ret), ret)

#define __wait_event_freezable_timeout(wq_head, condition, timeout) \
	___wait_event_freezable_timeout(wq_head, condition, timeout, UNIQUE_ID)

... and now all the 'ret' refer to the thing that they look like they're
referring to.
