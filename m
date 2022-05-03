Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251BB5187CE
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 17:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237758AbiECPHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 11:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbiECPHl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 11:07:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F71C3A1A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 08:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651590247;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jtQ9B5IdhnfCEt2aG9WPbx5ZitVQKl3Yo50OcP90VbM=;
        b=CvSgwHjrnoRN6dIV+2wFF12eqGkQxVelZhTwq9YeLuYKfcyIf6azqawWqz+jEn1OtRiTKq
        VIM3jmmRZEufd8H7nNntpg+PlRaAeRbooEysbFaZTuf/VQYyQucuTtEGZJIKOPEpVGtFgZ
        tjlaRgM1acR51cBLoTPE4z9YNB/WD8c=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-616-T_k4BQPuPx2pU21-jOK9CA-1; Tue, 03 May 2022 09:42:59 -0400
X-MC-Unique: T_k4BQPuPx2pU21-jOK9CA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9BCEF3D36FE7;
        Tue,  3 May 2022 13:41:58 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.194.243])
        by smtp.corp.redhat.com (Postfix) with SMTP id AD5E915376BB;
        Tue,  3 May 2022 13:41:53 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue,  3 May 2022 15:41:56 +0200 (CEST)
Date:   Tue, 3 May 2022 15:41:50 +0200
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
        linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
        Jann Horn <jannh@google.com>, linux-ia64@vger.kernel.org
Subject: Re: [PATCH v2 07/12] ptrace: Don't change __state
Message-ID: <20220503134149.GA22999@redhat.com>
References: <87k0b7v9yk.fsf_-_@email.froward.int.ebiederm.org>
 <20220429214837.386518-7-ebiederm@xmission.com>
 <20220502153934.GD17276@redhat.com>
 <87levjrixl.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87levjrixl.fsf@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/02, Eric W. Biederman wrote:
>
> Oleg Nesterov <oleg@redhat.com> writes:
>
> >>  #define TASK_KILLABLE			(TASK_WAKEKILL | TASK_UNINTERRUPTIBLE)
> >>  #define TASK_STOPPED			(TASK_WAKEKILL | __TASK_STOPPED)
> >> -#define TASK_TRACED			(TASK_WAKEKILL | __TASK_TRACED)
> >> +#define TASK_TRACED			__TASK_TRACED
> > ...
> >>  static inline void signal_wake_up(struct task_struct *t, bool resume)
> >>  {
> >> -	signal_wake_up_state(t, resume ? TASK_WAKEKILL : 0);
> >> +	unsigned int state = 0;
> >> +	if (resume) {
> >> +		state = TASK_WAKEKILL;
> >> +		if (!(t->jobctl & JOBCTL_PTRACE_FROZEN))
> >> +			state |= __TASK_TRACED;
> >> +	}
> >> +	signal_wake_up_state(t, state);
> >
> > Can't understand why is this better than the previous version which removed
> > TASK_WAKEKILL if resume... Looks a bit strange to me. But again, I didn't
> > look at the next patches yet.
>
> The goal is to replace the existing mechanism with an equivalent one,
> so that we don't have to be clever and deal with it being slightly
> different in one case.
>
> The difference is how does signal_pending_state affect how schedule will
> sleep in ptrace_stop.

But why is it bad if the tracee doesn't sleep in schedule ? If it races
with SIGKILL. I still can't understand this.

Yes, wait_task_inactive() can fail, so you need to remove WARN_ON_ONCE()
in 11/12.

Why is removing TASK_WAKEKILL from TASK_TRACED and complicating
*signal_wake_up() better?

And even if we need to ensure the tracee will always block after
ptrace_freeze_traced(), we can change signal_pending_state() to
return false if JOBCTL_PTRACE_FROZEN. Much simpler, imo. But still
looks unnecessary to me.



> Peter's plans to fix PREEMPT_RT or the freezer wait_task_inactive needs
> to cope with the final being changed by something else. (TASK_FROZEN in
> the freezer case).  I can only see that happening by removing the
> dependency on the final state in wait_task_inactive.  Which we can't do
> if we depend on wait_task_inactive failing if the process is in the
> wrong state.

OK, I guess this is what I do not understand. Could you spell please?

And speaking of RT, wait_task_inactive() still can fail because
cgroup_enter_frozen() takes css_set_lock? And it is called under
preempt_disable() ? I don't understand the plan :/

> At a practical level I think it also has an impact on patch:
> "10/12 ptrace: Only return signr from ptrace_stop if it was provided".

I didn't look at JOBCTL_PTRACE_SIGNR yet. But this looks minor to me,
I mean, I am not sure it worth the trouble.

Oleg.

