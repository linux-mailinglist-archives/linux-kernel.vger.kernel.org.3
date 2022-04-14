Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28576500C79
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 13:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242849AbiDNL4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 07:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242837AbiDNL4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 07:56:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D98922601
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 04:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649937260;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OQBMvEl7TG/AErRLlCgZmZf9IXOWECBGWVuV+R4YE1k=;
        b=hE0kuTmheN0tAJeQ5pVFtsGVTXB42krmkhagxjUCz31modDRgl5hjLvjZPrRC8+Ba6DGZF
        BikHVcK9PPPHTVtGC/vJLb1TivLX8wOgEOu1eowAg1ZpMDtfGBCPyf5C5/kJsK9fzX/WQQ
        xhoZLvfIi39lCCMOVjHJUQnQ88xcSyU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-25F8uyOHM2SzyhDdigj-zA-1; Thu, 14 Apr 2022 07:54:17 -0400
X-MC-Unique: 25F8uyOHM2SzyhDdigj-zA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97063296A61C;
        Thu, 14 Apr 2022 11:54:16 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.193.235])
        by smtp.corp.redhat.com (Postfix) with SMTP id 9AF4040EC010;
        Thu, 14 Apr 2022 11:54:13 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 14 Apr 2022 13:54:15 +0200 (CEST)
Date:   Thu, 14 Apr 2022 13:54:12 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/5] sched,ptrace: Fix ptrace_check_attach() vs PREEMPT_RT
Message-ID: <20220414115410.GA32752@redhat.com>
References: <20220412114421.691372568@infradead.org>
 <20220412114853.842942162@infradead.org>
 <20220413132451.GA27281@redhat.com>
 <20220413185704.GA30360@redhat.com>
 <20220413185909.GB30360@redhat.com>
 <20220413192053.GY2731@worktop.programming.kicks-ass.net>
 <20220413195612.GC2762@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413195612.GC2762@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/13, Peter Zijlstra wrote:
>
> On Wed, Apr 13, 2022 at 09:20:53PM +0200, Peter Zijlstra wrote:
> > On Wed, Apr 13, 2022 at 08:59:10PM +0200, Oleg Nesterov wrote:
> >
> >
> > > +		// !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
> > > +		// wrong, needs siglock
> > > +		current->jobctl &= ~JOBCTL_TRACED_XXX;
> > > +		wake_up_bit(&current->jobctl, ~JOBCTL_TRACED_XXX_BIT);
> > 		  __wake_up_common_lock()
> > 		    spin_lock_irqsave()
> > 		      current_save_and_set_rtlock_wait_state();

OOPS, thanks.

> Something that might work; since there's only the one ptracer, is to
> instead do something like:
>
> 	current->jobctl &= ~JOBCTL_TRACED_XXX; // siglock
> 	if (current->ptrace)
> 		wake_up_process(current->parent);
> 	preempt_enable_no_resched();
> 	schedule();
>
>
> vs
>
> 	for (;;) {
> 		set_current_state(TASK_UNINTERRUPTIBLE);
> 		if (!(p->jobctl & JOBCTL_TRACED_XXX))
> 			break;
> 		schedule();

Yes, thanks... this is racy, see below, but probably fixeable.

> ptrace_detach() needs some additional magic as well I think, but this
> might just work.

I don't think so, JOBCTL_TRACED_XXX must be always cleared in ptrace_stop()
and ptrace_detach() implies ptrace_check_attach().


Lets forget about the proble above for the moment. There is another problem
with my patch,

	if (!(child->ptrace && child->parent == current))
		return ret;

this check is racy without tasklist, we can race with another task attaching
to our natural child (so that child->parent == current), ptrace_attach() sets
task->ptrace = flags first and changes child->parent after that.

In this case:

	if (ignore_state)
		return 0;

this is just wrong,

	if (wait_on_bit(&task->jobctl, JOBCTL_TRACED_XXX_BIT, TASK_KILLABLE))
		return -EINTR;

this is fine,

	if (!wait_task_inactive(child, __TASK_TRACED))

this not right too. wait_task_inactive() can loop "forever" doing schedule_hrtimeout()
if the actual debugger stops/resumes the tracee continuously. This is pure theoretical,
but still.

And this also means that the code above needs some changes too, we can rely on
wake_up_process(current->parent).

OK, let me think about it. Thanks!

Oleg.

