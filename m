Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA834511DA2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 20:35:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240250AbiD0Ppn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 11:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240248AbiD0Ppk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 11:45:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C39613207F
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 08:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651074129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XndZS1mZ7mdo77V7NLJEWE894svwm8EA90BqtTnb844=;
        b=GcdGmNZpxb73bZTEf4qgZVEt3rM4iRxFnfFwswAk9pF/U8uwVRnGHltHcFmk7KAZpzlcdw
        v2GH/tQ52afz6GzAhHbCGuNbG9ra0S2haXwO4e7bILo6PBj3YicOyLI8ric5ePl4rHHruW
        XPQ2aasca0qncDGIy1vXxfV2Y/jEut8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-145-M6Noy9MqN1yZFZBX7BOnog-1; Wed, 27 Apr 2022 11:42:05 -0400
X-MC-Unique: M6Noy9MqN1yZFZBX7BOnog-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1DDDB8038E3;
        Wed, 27 Apr 2022 15:42:04 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.128])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1B5AB2166B4D;
        Wed, 27 Apr 2022 15:41:59 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Wed, 27 Apr 2022 17:42:03 +0200 (CEST)
Date:   Wed, 27 Apr 2022 17:41:59 +0200
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
Subject: Re: [PATCH 9/9] ptrace: Don't change __state
Message-ID: <20220427154158.GG17421@redhat.com>
References: <878rrrh32q.fsf_-_@email.froward.int.ebiederm.org>
 <20220426225211.308418-9-ebiederm@xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426225211.308418-9-ebiederm@xmission.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.6
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/26, Eric W. Biederman wrote:
>
>  static void ptrace_unfreeze_traced(struct task_struct *task)
>  {
> -	if (READ_ONCE(task->__state) != __TASK_TRACED)
> +	if (!(READ_ONCE(task->jobctl) & JOBCTL_DELAY_WAKEKILL))
>  		return;
>
>  	WARN_ON(!task->ptrace || task->parent != current);
> @@ -213,11 +213,10 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
>  	 * Recheck state under the lock to close this race.
>  	 */
>  	spin_lock_irq(&task->sighand->siglock);

Now that we do not check __state = __TASK_TRACED, we need lock_task_sighand().
The tracee can be already woken up by ptrace_resume(), but it is possible that
it didn't clear DELAY_WAKEKILL yet.

Now, before we take ->siglock, the tracee can exit and another thread can do
wait() and reap this task.

Also, I think the comment above should be updated. I agree, it makes sense to
re-check JOBCTL_DELAY_WAKEKILL under siglock just for clarity, but we no longer
need to do this to close the race; jobctl &= ~JOBCTL_DELAY_WAKEKILL and
wake_up_state() are safe even if JOBCTL_DELAY_WAKEKILL was already cleared.

> @@ -2307,6 +2307,7 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
>
>  	/* LISTENING can be set only during STOP traps, clear it */
>  	current->jobctl &= ~JOBCTL_LISTENING;
> +	current->jobctl &= ~JOBCTL_DELAY_WAKEKILL;

minor, but

	current->jobctl &= ~(JOBCTL_LISTENING | JOBCTL_DELAY_WAKEKILL);

looks better.

Oleg.

