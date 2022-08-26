Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8D8B5A3190
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 23:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344574AbiHZVy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 17:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbiHZVyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 17:54:52 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8453325D9;
        Fri, 26 Aug 2022 14:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=ZYOb94mj7PmrgZ8lf4hGillqW9ALQbpLDBnuQXLsL/Q=; b=de6bz6m8RXsGeButLQ0GZiYofc
        CeHk/fHUC4HlAP5P4dFY8S9LoE538UWtSdCPwW6Hx7rfr1dpuGoaXyhPeqgo+Rgaw/4a8CAA9Z8F+
        JUG9bkYNE+hGy97YclJtshfiP1+K4i2MX/3VTALQgUmQLNXvZuQfylY2ZFP23Qgz6l0S75Z9gdLcq
        2uiXhvdmCx/Fr3Nwbvm3xweKduR+qPlPRkLA+d32MyL8GKYAVth5Q4B1WXk0S95K1rw8Ejbck14ea
        +pGNlTzSzsBirRccGMr7uztSxR2igoUM/lJ+QzXX6NWCzSelgbpLtwWdul3vBkaZKzTudSdaPUTPf
        gOGjj7Fg==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oRhHT-006UVY-Cc; Fri, 26 Aug 2022 21:54:23 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id ED60798018A; Fri, 26 Aug 2022 23:54:21 +0200 (CEST)
Date:   Fri, 26 Aug 2022 23:54:21 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Oleg Nesterov <oleg@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Eric Biederman <ebiederm@xmission.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Will Deacon <will@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tejun Heo <tj@kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3 4/6] sched/completion: Add wait_for_completion_state()
Message-ID: <YwlBDWIah0fVYRXK@worktop.programming.kicks-ass.net>
References: <20220822111816.760285417@infradead.org>
 <20220822114648.922711674@infradead.org>
 <CAJZ5v0i=+jXz71DBx=Hr9_6bxOx7yFF_xZJc4tXB0j4kSW0Q_g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i=+jXz71DBx=Hr9_6bxOx7yFF_xZJc4tXB0j4kSW0Q_g@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022 at 07:32:33PM +0200, Rafael J. Wysocki wrote:
> On Mon, Aug 22, 2022 at 1:48 PM Peter Zijlstra <peterz@infradead.org> wrote:
> >
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
> >                                                    unsigned long timeout);
> >  extern unsigned long wait_for_completion_io_timeout(struct completion *x,
> > --- a/kernel/sched/completion.c
> > +++ b/kernel/sched/completion.c
> > @@ -247,6 +247,15 @@ int __sched wait_for_completion_killable
> >  }
> >  EXPORT_SYMBOL(wait_for_completion_killable);
> >
> > +int __sched wait_for_completion_state(struct completion *x, unsigned int state)
> > +{
> > +       long t = wait_for_common(x, MAX_SCHEDULE_TIMEOUT, state);
> > +       if (t == -ERESTARTSYS)
> > +               return t;
> > +       return 0;
> > +}
> > +EXPORT_SYMBOL(wait_for_completion_state);
> 
> Why not EXPORT_SYMBOL_GPL?  I guess to match the above?

Yeah; I'm torn between preference and consistency here :-)
