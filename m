Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F89550A996
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 21:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392139AbiDUT7K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 15:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345242AbiDUT7G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 15:59:06 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50124D62B;
        Thu, 21 Apr 2022 12:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=WnJUKQS9rnfQBphCjVgXQWgPS6QNuqoUsrcFhgsGrz0=; b=C6nns9rrHj1sofSE0Fl3WJyY6j
        9CZluglXrgmoKTlTUi+Ya+O2XeJkO0ophZpTostP3Mq5uPHlJXSOzoQgn2lkkrWtX4fTbs419syUy
        +EmM17tc/7luKPdbpGlzVtTVaUDVH3te7Y7Rbkkss7CF32KMCH3+iv8bGJpb4pvmlMCu3f/5Jj/K5
        tDFxZ0hVj7Ky54XR6CBKXpNTC7fJLQ6NgzIm7T6pvGBKYRFSGUJbkFp7Ha+AXw0lS6khSMEMZsRLQ
        WiA1a9IG0HHH/Ia+F3loV7NsUdcGwjWuaFYaBAsqrxmG7ORpPZeFZJdC5v0e/juoHwXz3VHNUn7yq
        7G5bRXwg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nhcuA-007Vba-1k; Thu, 21 Apr 2022 19:55:54 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id AD3679861C1; Thu, 21 Apr 2022 21:55:51 +0200 (CEST)
Date:   Thu, 21 Apr 2022 21:55:51 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     rjw@rjwysocki.net, oleg@redhat.com, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 5/5] freezer,sched: Rewrite core freezer logic
Message-ID: <20220421195551.GO2731@worktop.programming.kicks-ass.net>
References: <20220421150248.667412396@infradead.org>
 <20220421150655.001952823@infradead.org>
 <878rrys5yj.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878rrys5yj.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 12:26:44PM -0500, Eric W. Biederman wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> 
> > --- a/kernel/ptrace.c
> > +++ b/kernel/ptrace.c
> > @@ -288,7 +288,7 @@ static int ptrace_check_attach(struct ta
> >  	}
> >  	__set_current_state(TASK_RUNNING);
> >  
> > -	if (!wait_task_inactive(child, TASK_TRACED) ||
> > +	if (!wait_task_inactive(child, TASK_TRACED|TASK_FREEZABLE) ||
> >  	    !ptrace_freeze_traced(child))
> >  		return -ESRCH;
> 
> Do we mind that this is going to fail if the child is frozen
> during ptrace_check_attach?

Why should this fail? wait_task_inactive() will in fact succeed if it is
frozen due to the added TASK_FREEZABLE and some wait_task_inactive()
changes elsewhere in this patch.

And I don't see why ptrace_freeze_traced() should fail. It'll warn
though, I should extend/remove that WARN_ON_ONCE() looking at __state,
but it should work.
