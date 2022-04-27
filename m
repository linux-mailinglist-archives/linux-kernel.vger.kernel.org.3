Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18DF511ED7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238901AbiD0PEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238888AbiD0PE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:04:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C46E627D178
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651071675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Egehvqg27Nr6FMLxE+ww4T3/EHzKsHjYMiC2xu74Aa0=;
        b=LVaAvq3pUdzDDz4KdkbPEz2iAxUDvXcsUqC+oKrsPAkbeJWD19W+xU35PK+1Uz0M2EkxqT
        cxuBWTXcmzX1wHogjTb3Wxqv7NhwfoGFcOYhvTmHKqOFPrpezLbu7ZuRFV1dqQJLYg7AWS
        HweuLIL2lFEa0PQI+Z3r3tUjj6VT5Cw=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-220-bpgZATshNN-iftRBC2UfHA-1; Wed, 27 Apr 2022 11:01:12 -0400
X-MC-Unique: bpgZATshNN-iftRBC2UfHA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 13E673839772;
        Wed, 27 Apr 2022 15:01:00 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.128])
        by smtp.corp.redhat.com (Postfix) with SMTP id 83842C4C7A1;
        Wed, 27 Apr 2022 15:00:55 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 27 Apr 2022 17:00:59 +0200 (CEST)
Date:   Wed, 27 Apr 2022 17:00:54 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     linux-kernel@vger.kernel.org, rjw@rjwysocki.net, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, tj@kernel.org,
        linux-pm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Chris Zankel <chris@zankel.net>,
        Max Filippov <jcmvbkbc@gmail.com>,
        inux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH 6/9] signal: Always call do_notify_parent_cldstop with
 siglock held
Message-ID: <20220427150053.GD17421@redhat.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-6-ebiederm@xmission.com>
 <20220427145646.GC17421@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427145646.GC17421@redhat.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/27, Oleg Nesterov wrote:
>
> On 04/26, Eric W. Biederman wrote:
> >
> > @@ -2209,6 +2213,34 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
> >  		spin_lock_irq(&current->sighand->siglock);
> >  	}
> >
> > +	/* Don't stop if current is not ptraced */
> > +	if (unlikely(!current->ptrace))
> > +		return (clear_code) ? 0 : exit_code;
> > +
> > +	/*
> > +	 * If @why is CLD_STOPPED, we're trapping to participate in a group
> > +	 * stop.  Do the bookkeeping.  Note that if SIGCONT was delievered
> > +	 * across siglock relocks since INTERRUPT was scheduled, PENDING
> > +	 * could be clear now.  We act as if SIGCONT is received after
> > +	 * TASK_TRACED is entered - ignore it.
> > +	 */
> > +	if (why == CLD_STOPPED && (current->jobctl & JOBCTL_STOP_PENDING))
> > +		gstop_done = task_participate_group_stop(current);
> > +
> > +	/*
> > +	 * Notify parents of the stop.
> > +	 *
> > +	 * While ptraced, there are two parents - the ptracer and
> > +	 * the real_parent of the group_leader.  The ptracer should
> > +	 * know about every stop while the real parent is only
> > +	 * interested in the completion of group stop.  The states
> > +	 * for the two don't interact with each other.  Notify
> > +	 * separately unless they're gonna be duplicates.
> > +	 */
> > +	do_notify_parent_cldstop(current, true, why);
> > +	if (gstop_done && ptrace_reparented(current))
> > +		do_notify_parent_cldstop(current, false, why);
>
> This doesn't look right too. The parent should be notified only after
> we set __state = TASK_TRACED and ->exit code.
>
> Suppose that debugger sleeps in do_wait(). do_notify_parent_cldstop()
> wakes it up, debugger calls wait_task_stopped() and then it will sleep
> again, task_stopped_code() returns 0.
>
> This can be probably fixed if you remove the lockless (fast path)
> task_stopped_code() check in wait_task_stopped(), but this is not
> nice performance-wise...

On the other hand, I don't understand why did you move the callsite
of do_notify_parent_cldstop() up... just don't do this?

Oleg.

