Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 197EC509CB1
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 11:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387833AbiDUJto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 05:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351683AbiDUJtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 05:49:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0F98F240A5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 02:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650534411;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ofygN06nojWIqHPPmdPwjxA0TLyFM4WSMFDuW6hzHxM=;
        b=gJsf4Yoo9bUy62mSTqhKL6TGDt4DFyB729dH070SZeYEL7fbeezzk574eansgRpo3EdnZe
        2csCztgY5w2t0xhMaEdTYprgACXcfziWgoYqWOyJPTbvxoqChrkRv9bMXulysu7QRZT2X/
        niCv1YMa361EwUy8ZhnkMge3VI7kMw0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-UtYkaEFUNzGANDrTYTGXGA-1; Thu, 21 Apr 2022 05:46:46 -0400
X-MC-Unique: UtYkaEFUNzGANDrTYTGXGA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1A485833969;
        Thu, 21 Apr 2022 09:46:46 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.194.59])
        by smtp.corp.redhat.com (Postfix) with SMTP id 04DA3C33AE9;
        Thu, 21 Apr 2022 09:46:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 21 Apr 2022 11:46:45 +0200 (CEST)
Date:   Thu, 21 Apr 2022 11:46:41 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, rjw@rjwysocki.net,
        mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        bigeasy@linutronix.de, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, tj@kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [RFC][PATCH] ptrace: Don't change __state
Message-ID: <20220421094640.GA18344@redhat.com>
References: <20220414115410.GA32752@redhat.com>
 <20220414183433.GC32752@redhat.com>
 <YlikBjA3kL3XEQP5@hirez.programming.kicks-ass.net>
 <20220415101644.GA10421@redhat.com>
 <20220415105755.GA15217@redhat.com>
 <Yllep6B8eva2VURJ@hirez.programming.kicks-ass.net>
 <20220418170104.GA16199@redhat.com>
 <20220420131731.GF2731@worktop.programming.kicks-ass.net>
 <20220420180323.GA14947@redhat.com>
 <875yn3zdag.fsf_-_@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yn3zdag.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/20, Eric W. Biederman wrote:
>
> I was thinking about this and I have an approach from a different
> direction.  In particular it removes the need for ptrace_freeze_attach
> and ptrace_unfreeze_attach to change __state.  Instead a jobctl
> bit is used to suppress waking up a process with TASK_WAKEKILL.

I think this can work, but we still need something like 1/5 + 2/5?

> I think this would be a good technique to completely decouple
> PREEMPT_RT from the work that ptrace_freeze_attach does.

If CONFIG_RT=y we can't rely on the ->__state check in task_is_traced(),
and wait_task_inactive() can wrongly fail if the tracee sleeps waiting
for tasklist_lock.

A couple of comments after a quick glance,

>  static void ptrace_unfreeze_traced(struct task_struct *task)
>  {
> -	if (READ_ONCE(task->__state) != __TASK_TRACED)
> +	if (!task_is_traced(task))
>  		return;
>
>  	WARN_ON(!task->ptrace || task->parent != current);
> @@ -216,13 +217,11 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
>  	 * PTRACE_LISTEN can allow ptrace_trap_notify to wake us up remotely.
>  	 * Recheck state under the lock to close this race.
>  	 */
> -	spin_lock_irq(&task->sighand->siglock);
> -	if (READ_ONCE(task->__state) == __TASK_TRACED) {
> -		if (__fatal_signal_pending(task))
> -			wake_up_state(task, __TASK_TRACED);
> -		else
> -			WRITE_ONCE(task->__state, TASK_TRACED);
> -	}
> +	spin_unlock_irq(&task->sighand->siglock);
> +	WARN_ON(!(task->jobctl & JOBCTL_DELAY_WAKEKILL));
> +	task->jobctl &= ~JOBCTL_DELAY_WAKEKILL;

We can't rely on the lockless task_is_traced() check above... probably this
is fine, but I need to re-chesk. But at least you need to remove the comment
about PTRACE_LISTEN above.

Another problem is that WARN_ON(!(task->jobctl & JOBCTL_DELAY_WAKEKILL))
doesn't look right if ignore_state in ptrace_check_attach() was true, the
tracee could stop before ptrace_unfreeze_traced().

> @@ -892,7 +891,6 @@ static int ptrace_resume(struct task_struct *child, long request,
>  	 * status and clears the code too; this can't race with the tracee, it
>  	 * takes siglock after resume.
>  	 */
> -	need_siglock = data && !thread_group_empty(current);
>  	if (need_siglock)
>  		spin_lock_irq(&child->sighand->siglock);

Hmm?

Oleg.

