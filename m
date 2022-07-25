Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802D55803A4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 19:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235037AbiGYRsN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 13:48:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229806AbiGYRsF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 13:48:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5115163E8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 10:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658771282;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=arrbJ3c/50wiIyR3eKmp88yp2dJXDJfJTiNLWSmbjPg=;
        b=ZmdJosyOAVKmGEZ+I7oS8OB5f9cgbC/wI92yO/DvBOiSJGca9oZ0eIPriIyJCprcJTpXoH
        15Jas5MN37Ges8n+w4/r8hC3oM8coe7W8fCWbFVCdtCNI5+4WuTj1z9Jnw8G1lDGu1imkM
        q0w3eZJ4DuEvg4XyC06IWo4UgwLM7Dw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-107-NnUFvkq7Mfq3mewBU0I8PA-1; Mon, 25 Jul 2022 13:48:01 -0400
X-MC-Unique: NnUFvkq7Mfq3mewBU0I8PA-1
Received: by mail-wm1-f72.google.com with SMTP id h189-20020a1c21c6000000b003a2fdf9bd2aso6470567wmh.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 10:48:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=arrbJ3c/50wiIyR3eKmp88yp2dJXDJfJTiNLWSmbjPg=;
        b=BhduM+o2JiMXKnxg7p458uDSU+0uQpKpQgcsJpgOLr8ifJiYY35QBFFnV3f6aCGATH
         y9PhZQlAwjh5B+hqat2fk5MKwA2P46pgGCZtjTFHzwDQStE9XJROy0DYS+kTlMRyqY6o
         eAjhIWIrG4m2z7FAKatdmE32cEewxKznRBpl4HVRXHEkPY+XlN6ptiRqiHQilX7xq2pY
         Y7WzFN0QZe0wqMIdAsnh9/GgQJcxOAY2TWzdB73khLSGtL05DYX3w7BCw7NU4V4AGmKj
         bEbdvUqK8tZxIJ8l7BprtklmcKZEY8Np4ADiB5+tzZz14V3/fyzxiGLHb9rr+d6iSQll
         wQDQ==
X-Gm-Message-State: AJIora8vtkgYnzFbMfNU2UZzHBV769qH6kX+NNlKy/4KdSoVzsNcsDGq
        GPUDQxLFHWq020vOUB8VX3fc98dION8cM0r1QL6mmRPOJVKruDvl8FPNNSv1LUYeEFal0YRWUe3
        SRGh8ye3RwlJXdJe8ulDyYX6N
X-Received: by 2002:a5d:69ca:0:b0:21d:640c:79f6 with SMTP id s10-20020a5d69ca000000b0021d640c79f6mr8115246wrw.309.1658771279970;
        Mon, 25 Jul 2022 10:47:59 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tFSAGIbgkd76ecTXWzgspFZijmg4iUFDSxNjOBpKR9S1Gy6RNPdozHWmU2bNQ9uhWVyZGPfA==
X-Received: by 2002:a5d:69ca:0:b0:21d:640c:79f6 with SMTP id s10-20020a5d69ca000000b0021d640c79f6mr8115228wrw.309.1658771279684;
        Mon, 25 Jul 2022 10:47:59 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id e29-20020a5d595d000000b0021e501519d3sm12448604wri.67.2022.07.25.10.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 10:47:59 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: Re: [PATCH 2/2] sched: Consider task_struct::saved_state in
 wait_task_inactive().
In-Reply-To: <20220720154435.232749-3-bigeasy@linutronix.de>
References: <20220720154435.232749-1-bigeasy@linutronix.de>
 <20220720154435.232749-3-bigeasy@linutronix.de>
Date:   Mon, 25 Jul 2022 18:47:58 +0100
Message-ID: <xhsmhy1whdqy9.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/07/22 17:44, Sebastian Andrzej Siewior wrote:
> Ptrace is using wait_task_inactive() to wait for the tracee to reach a
> certain task state. On PREEMPT_RT that state may be stored in
> task_struct::saved_state while the tracee blocks on a sleeping lock and
> task_struct::__state is set to TASK_RTLOCK_WAIT.
> It is not possible to check only for TASK_RTLOCK_WAIT to be sure that the task
> is blocked on a sleeping lock because during wake up (after the sleeping lock
> has been acquired) the task state is set TASK_RUNNING. After the task in on CPU
> and acquired the pi_lock it will reset the state accordingly but until then
> TASK_RUNNING will be observed (with the desired state saved in saved_state).
>
> Check also for task_struct::saved_state if the desired match was not found in
> task_struct::__state on PREEMPT_RT. If the state was found in saved_state, wait
> until the task is idle and state is visible in task_struct::__state.
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

I have a suggestion and a comment below, but other than that this looks OK.

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

> ---
>  kernel/sched/core.c |   46 +++++++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 41 insertions(+), 5 deletions(-)
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3257,6 +3257,40 @@ int migrate_swap(struct task_struct *cur
>  }
>  #endif /* CONFIG_NUMA_BALANCING */
>
> +#ifdef CONFIG_PREEMPT_RT

Would something like the below be useful?

/*
 * If p->saved_state is anything else than TASK_RUNNING, then p blocked on an
 * rtlock *before* voluntarily calling into schedule() after setting its state
 * to X. For things like ptrace (X=TASK_TRACED), the task could have more work
 * to do upon acquiring the lock before whoever called wait_task_inactive()
 * should return. IOW, we have to wait for:
 *
 *   p.saved_state = TASK_RUNNING
 *   p.__state     = X
 *
 * which implies the task isn't blocked on an RT lock and got to schedule() by
 * itself.
 *
 * Also see comments in ttwu_state_match().
 */

> +static __always_inline bool state_mismatch(struct task_struct *p, unsigned int match_state)
> +{
> +	unsigned long flags;
> +	bool mismatch;
> +
> +	raw_spin_lock_irqsave(&p->pi_lock, flags);
> +	mismatch = READ_ONCE(p->__state) != match_state &&
> +		READ_ONCE(p->saved_state) != match_state;
> +	raw_spin_unlock_irqrestore(&p->pi_lock, flags);
> +	return mismatch;
> +}
> +static __always_inline bool state_match(struct task_struct *p, unsigned int match_state,
> +					bool *wait)
> +{
> +	if (READ_ONCE(p->__state) == match_state)
> +		return true;
> +	if (READ_ONCE(p->saved_state) != match_state)
> +		return false;
> +	*wait = true;
> +	return true;
> +}
> +#else
> +static __always_inline bool state_mismatch(struct task_struct *p, unsigned int match_state)
> +{
> +	return READ_ONCE(p->__state) != match_state;
> +}
> +static __always_inline bool state_match(struct task_struct *p, unsigned int match_state,
> +					bool *wait)
> +{
> +	return READ_ONCE(p->__state) == match_state;
> +}
> +#endif
> +
>  /*
>   * wait_task_inactive - wait for a thread to unschedule.
>   *
> @@ -3346,7 +3382,7 @@ unsigned long wait_task_inactive(struct
>                * running right now), it's preempted, and we should
>                * yield - it could be a while.
>                */
> -		if (unlikely(queued)) {
> +		if (unlikely(wait)) {

We could be repeatedly doing this for as long as the task is blocked on the
rtlock, but IIUC that's the same story on !PREEMPT_RT if it's just a queued
task preempted by a higher prio task, it may take a while for it to
schedule() and dequeue...

>                       ktime_t to = NSEC_PER_SEC / HZ;
>
>                       set_current_state(TASK_UNINTERRUPTIBLE);

