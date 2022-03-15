Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F03E4D9D98
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 15:32:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349261AbiCOOb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 10:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349366AbiCOObR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:31:17 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 891AF56208
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 07:29:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647354594;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ADNlo6bGHQ4j+8AujHtuaZB6p6lzkwNTdQt/vcHlJdU=;
        b=iFmt3HaDxluMaJ4sB1cN6RUZ713qewlo0sApP6o9PvNcD/wfBugdB+tGcNLogINaaRt8uF
        ncl6t4XuM0TOglPq6pryHOcFIUL7vlTZ9q+uOkZK3+7mGyRXjf3DHaKGzm8xH+OBg5SNUV
        Xc1fWHOajivGmD5vQbllhDrjGS00VHg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-6-m_pggXz7Ple77Vyn9wmR3A-1; Tue, 15 Mar 2022 10:29:51 -0400
X-MC-Unique: m_pggXz7Ple77Vyn9wmR3A-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B1E38802809;
        Tue, 15 Mar 2022 14:29:50 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.104])
        by smtp.corp.redhat.com (Postfix) with SMTP id 04FB842784D;
        Tue, 15 Mar 2022 14:29:47 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 15 Mar 2022 15:29:49 +0100 (CET)
Date:   Tue, 15 Mar 2022 15:29:46 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH] ptrace: fix ptrace vs tasklist_lock race on PREEMPT_RT.
Message-ID: <20220315142944.GA22670@redhat.com>
References: <Yh/b19JikC+Vnm8i@linutronix.de>
 <20220314185429.GA30364@redhat.com>
 <YjBO8yzxdmjTGNiy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YjBO8yzxdmjTGNiy@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/15, Sebastian Andrzej Siewior wrote:
>
> On 2022-03-14 19:54:30 [+0100], Oleg Nesterov wrote:
> > I never really understood ->saved_state logic. Will read this patch
> > tomorrow, but at first glance this patch doesn't solve all problems.
>
> Let me explain the ->saved_state logic:

Ah, thanks, but this is clear.

> > > --- a/kernel/sched/core.c
> > > +++ b/kernel/sched/core.c
> > > @@ -3239,7 +3239,8 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
> > >  		 * is actually now running somewhere else!
> > >  		 */
> > >  		while (task_running(rq, p)) {
> > > -			if (match_state && unlikely(READ_ONCE(p->__state) != match_state))
> > > +			if (match_state &&
> > > +			    unlikely(!task_state_match_eq(p, match_state)))
> > >  				return 0;
> >
> > So wait_task_inactive() can return 0 but the task can run after that, right?
> > This is not what we want...
>
> Without checking both states you may never observe the requested state
> because it is set to TASK_RTLOCK_WAIT while waiting for a lock. Other
> than that, it may run briefly because it tries to acquire a lock or just
> acquired and this shouldn't be different from a task spinning on a lock.

I don't understand. wait_task_inactive() is used to ensure that this task
doesn't and can't run again, until debugger resumes these tracee.

Now. Unless I missed something, the tracee can leave CPU with saved_state
= TRACED (so task_state_match_eq() returns T) and wait_task_inactive() will
return. Then later the tracee will park in schedule again, yes.

But, for example, what if debugger clears TIF_BLOCKSTEP in between, while
the tracee is running? Can't this race with __switch_to_xtra() ?

Oleg.

