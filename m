Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFCB5AE54E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 12:25:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239556AbiIFKZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 06:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239367AbiIFKYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 06:24:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1536C4BA58;
        Tue,  6 Sep 2022 03:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wIwSSmuOSnhv770Hg1NuBfZZd+PF8Vh+C1a/gwYd7Aw=; b=njZeqqrbvtR0wh4b0ZEdDyjvGA
        cQeqOQe4OFwT1Am8+u9sTJ54LsrJ62Ua6FKPraS9RliBc7vTGgO/M+T73DF8vQzpqsotmMij/xseL
        K3PxkLU0wqQ9qxVIO9cvOumr3BkyhUme5ofRdKVIK6CwGN89ZVqIkVXXq4FJRn9U0apZrKgPMEnrd
        xJIxx6FuYvBHGuPbqg4iKK0y9UT7iLNkpBpiGTD08k5mMJF77SvxmzAe9q2rsNteHY+TSkRnuzBFC
        Y3mNBQhK0tzCzv/hJiF1Mf0nq76L3usLio3LH4O+ex4nA7RY4MWbShAYGKYEYJZA60wuSzL1NxDaw
        e+AB/fKw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVVkY-00AJIZ-VU; Tue, 06 Sep 2022 10:24:11 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 69A20300348;
        Tue,  6 Sep 2022 12:24:07 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 4943E2B66205D; Tue,  6 Sep 2022 12:24:07 +0200 (CEST)
Date:   Tue, 6 Sep 2022 12:24:07 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     rjw@rjwysocki.net, oleg@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 4/6] sched/completion: Add wait_for_completion_state()
Message-ID: <Yxcfx/NvzMm3wRTU@hirez.programming.kicks-ass.net>
References: <20220822111816.760285417@infradead.org>
 <20220822114648.922711674@infradead.org>
 <YxSB85+BamWFj5xw@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxSB85+BamWFj5xw@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 04, 2022 at 12:46:11PM +0200, Ingo Molnar wrote:
> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > Allows waiting with a custom @state.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  include/linux/completion.h |    1 +
> >  kernel/sched/completion.c  |    9 +++++++++
> >  2 files changed, 10 insertions(+)
> > 
> > --- a/include/linux/completion.h
> > +++ b/include/linux/completion.h
> > @@ -103,6 +103,7 @@ extern void wait_for_completion(struct c
> >  extern void wait_for_completion_io(struct completion *);
> >  extern int wait_for_completion_interruptible(struct completion *x);
> >  extern int wait_for_completion_killable(struct completion *x);
> > +extern int wait_for_completion_state(struct completion *x, unsigned int state);
> >  extern unsigned long wait_for_completion_timeout(struct completion *x,
> >  						   unsigned long timeout);
> >  extern unsigned long wait_for_completion_io_timeout(struct completion *x,
> > --- a/kernel/sched/completion.c
> > +++ b/kernel/sched/completion.c
> > @@ -247,6 +247,15 @@ int __sched wait_for_completion_killable
> >  }
> >  EXPORT_SYMBOL(wait_for_completion_killable);
> >  
> > +int __sched wait_for_completion_state(struct completion *x, unsigned int state)
> > +{
> > +	long t = wait_for_common(x, MAX_SCHEDULE_TIMEOUT, state);
> > +	if (t == -ERESTARTSYS)
> > +		return t;
> > +	return 0;
> 
> Nit: newline missing after local variable definition.

Yah, I know, but all the other similar functions there have the same
defect. I don't much like whitespace patches, so I figured I'd be
consistent and let it all be for now.
