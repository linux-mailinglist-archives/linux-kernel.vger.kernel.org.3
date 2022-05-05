Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9CF51C31E
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 16:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380889AbiEEPBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 11:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236360AbiEEPBP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 11:01:15 -0400
Received: from us-smtp-delivery-74.mimecast.com (us-smtp-delivery-74.mimecast.com [170.10.129.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 089951C13C
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 07:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651762655;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=edMoOIi5W5h5BTuQ+OG7p8B5wBOMsVB1tjxMAlGSHpw=;
        b=g6G+akOnEwA2jwWAcYXHRjiVxCnWpkRt3KkYmWJqHI/bmhA4Vz5p/PT0YHTGvtEhaKGN/2
        ms8I6l7rmPYJCOcv4yB0O9l14G6AiwEc5IdqE2RVvnZKlNGbyj3IidSPPBbhC78V1QOC4u
        H4V+xQo0UyJoClfz8tCgnVH7cNnwprM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-187-7XIzuTHxPNix0eEXnTrTjw-1; Thu, 05 May 2022 10:57:31 -0400
X-MC-Unique: 7XIzuTHxPNix0eEXnTrTjw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A339C1E7DCD6;
        Thu,  5 May 2022 14:57:30 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.3])
        by smtp.corp.redhat.com (Postfix) with SMTP id E03E840CF8F5;
        Thu,  5 May 2022 14:57:24 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu,  5 May 2022 16:57:28 +0200 (CEST)
Date:   Thu, 5 May 2022 16:57:22 +0200
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
Subject: Re: [PATCH v3 08/11] ptrace: Admit ptrace_stop can generate spuriuos
 SIGTRAPs
Message-ID: <20220505145721.GA13929@redhat.com>
References: <87k0b0apne.fsf_-_@email.froward.int.ebiederm.org>
 <20220504224058.476193-8-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220504224058.476193-8-ebiederm@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/04, Eric W. Biederman wrote:
>
> -static int ptrace_stop(int exit_code, int why, int clear_code,
> -			unsigned long message, kernel_siginfo_t *info)
> +static int ptrace_stop(int exit_code, int why, unsigned long message,
> +		       kernel_siginfo_t *info)
>  	__releases(&current->sighand->siglock)
>  	__acquires(&current->sighand->siglock)
>  {
> @@ -2259,54 +2259,33 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
>  
>  	spin_unlock_irq(&current->sighand->siglock);
>  	read_lock(&tasklist_lock);
> -	if (likely(current->ptrace)) {
> -		/*
> -		 * Notify parents of the stop.
> -		 *
> -		 * While ptraced, there are two parents - the ptracer and
> -		 * the real_parent of the group_leader.  The ptracer should
> -		 * know about every stop while the real parent is only
> -		 * interested in the completion of group stop.  The states
> -		 * for the two don't interact with each other.  Notify
> -		 * separately unless they're gonna be duplicates.
> -		 */
> +	/*
> +	 * Notify parents of the stop.
> +	 *
> +	 * While ptraced, there are two parents - the ptracer and
> +	 * the real_parent of the group_leader.  The ptracer should
> +	 * know about every stop while the real parent is only
> +	 * interested in the completion of group stop.  The states
> +	 * for the two don't interact with each other.  Notify
> +	 * separately unless they're gonna be duplicates.
> +	 */
> +	if (current->ptrace)
>  		do_notify_parent_cldstop(current, true, why);
> -		if (gstop_done && ptrace_reparented(current))
> -			do_notify_parent_cldstop(current, false, why);
> +	if (gstop_done && (!current->ptrace || ptrace_reparented(current)))
> +		do_notify_parent_cldstop(current, false, why);
>  
> -		/*
> -		 * Don't want to allow preemption here, because
> -		 * sys_ptrace() needs this task to be inactive.
> -		 *
> -		 * XXX: implement read_unlock_no_resched().
> -		 */
> -		preempt_disable();
> -		read_unlock(&tasklist_lock);
> -		cgroup_enter_frozen();
> -		preempt_enable_no_resched();
> -		freezable_schedule();
> -		cgroup_leave_frozen(true);
> -	} else {
> -		/*
> -		 * By the time we got the lock, our tracer went away.
> -		 * Don't drop the lock yet, another tracer may come.
> -		 *
> -		 * If @gstop_done, the ptracer went away between group stop
> -		 * completion and here.  During detach, it would have set
> -		 * JOBCTL_STOP_PENDING on us and we'll re-enter
> -		 * TASK_STOPPED in do_signal_stop() on return, so notifying
> -		 * the real parent of the group stop completion is enough.
> -		 */
> -		if (gstop_done)
> -			do_notify_parent_cldstop(current, false, why);
> -
> -		/* tasklist protects us from ptrace_freeze_traced() */
> -		__set_current_state(TASK_RUNNING);
> -		read_code = false;
> -		if (clear_code)
> -			exit_code = 0;
> -		read_unlock(&tasklist_lock);
> -	}
> +	/*
> +	 * Don't want to allow preemption here, because
> +	 * sys_ptrace() needs this task to be inactive.
> +	 *
> +	 * XXX: implement read_unlock_no_resched().
> +	 */
> +	preempt_disable();
> +	read_unlock(&tasklist_lock);
> +	cgroup_enter_frozen();
> +	preempt_enable_no_resched();
> +	freezable_schedule();

I must have missed something.

So the tracee calls ptrace_notify() but debugger goes away before the
ptrace_notify() takes siglock. After that the no longer traced task
will sleep in TASK_TRACED ?

Looks like ptrace_stop() needs to check current->ptrace before it does
set_special_state(TASK_TRACED) with siglock held? Then we can rely on
ptrace_unlink() which will wake the tracee up even if debugger exits.

No?

Oleg.

