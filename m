Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C95E550B4C6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:14:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446303AbiDVKQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233775AbiDVKQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:16:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 37B4354682
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650622432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7MgzPcUlCPnp4N5A0D0xPGjDw/K0z6eF9GXIJdoTy8s=;
        b=EvxzrkK/QM7ENlWhm57GGHw4BlpBHtWYF3P3m43UYkW7uDY7xDUYeM8oi+Iyy+KCoZ90RP
        aB0mNkMr7YxkJCt1qkpz9jiagdQeb/pWZjEOqbAW9RMMURd3sGuHJMb9La49vQISgvwuJl
        KAaLRiHTg4ytBpD9ICXTM9V/A4L4pa4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-6OoEtlCuN5iQtuT7K48Wfg-1; Fri, 22 Apr 2022 06:13:49 -0400
X-MC-Unique: 6OoEtlCuN5iQtuT7K48Wfg-1
Received: by mail-wr1-f69.google.com with SMTP id u26-20020adfb21a000000b0020ac48a9aa4so736239wra.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:13:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=7MgzPcUlCPnp4N5A0D0xPGjDw/K0z6eF9GXIJdoTy8s=;
        b=GvRR9ginsMoSU5CWL8Dj2HM7TIRFPmUHgFXpY0ixLhTK6tEGKawMJv9F/H5OUvHGvP
         HtyVgo2SVfKwaZKbt2ujKYu5qng9DTOLA2oLYbFI7xaXgmYUgtuMldGu6QYU+uFrj7x1
         Qrdmi05vRc28rPIrLYC+zl4pD0b0qag4mq8oGvKSnjPWx3aWv+Tz2Mk4ON/QSxK3ANOS
         sCiu61WB7JGtd27rrG0Fq90baMxIBAeQMEDHgmTZsTyx4f4bWQRzbMquv5JMbnvmovMQ
         atoqzh2QhjLY+LwebpXhRSUuANv1MT0JMqQCHQBj5iXrm0lvhNfcZHTB7qhBKpUhz4Bl
         Cbwg==
X-Gm-Message-State: AOAM530KCbz4FDn+Ix/eZ6wtF9niL9SzayIPFMZCHljFSwJjtqPCCYnH
        YOME2m/S+TlPGNwamQl0Py1H+oaVexRs9R4TsFXq7Aog8cTNXRSY9jnLpEhspM0hZlqiiMpfyla
        RiPGqrJaRia6pMcH9ESqJopCV
X-Received: by 2002:a05:600c:5114:b0:38e:bd9c:9cb0 with SMTP id o20-20020a05600c511400b0038ebd9c9cb0mr12342928wms.153.1650622427880;
        Fri, 22 Apr 2022 03:13:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx6Pc9bGTcMpsnBDdCb2BMJUurNxGa+rnc1hF2THEXlK92mJmnZQhCD1GaWaPgfbvinpbBK0w==
X-Received: by 2002:a05:600c:5114:b0:38e:bd9c:9cb0 with SMTP id o20-20020a05600c511400b0038ebd9c9cb0mr12342897wms.153.1650622427597;
        Fri, 22 Apr 2022 03:13:47 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id e4-20020adfa444000000b0020ac74da5c5sm1357593wra.87.2022.04.22.03.13.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 03:13:47 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Delyan Kratunov <delyank@fb.com>,
        "valentin.schneider@arm.com" <valentin.schneider@arm.com>
Cc:     "bigeasy@linutronix.de" <bigeasy@linutronix.de>,
        "dietmar.eggemann@arm.com" <dietmar.eggemann@arm.com>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "andrii@kernel.org" <andrii@kernel.org>,
        "vincent.guittot@linaro.org" <vincent.guittot@linaro.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "rdunlap@infradead.org" <rdunlap@infradead.org>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "Kenta.Tada@sony.com" <Kenta.Tada@sony.com>,
        "adharmap@quicinc.com" <adharmap@quicinc.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bristot@redhat.com" <bristot@redhat.com>,
        "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "ast@kernel.org" <ast@kernel.org>,
        "legion@kernel.org" <legion@kernel.org>,
        "ed.tsai@mediatek.com" <ed.tsai@mediatek.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "juri.lelli@redhat.com" <juri.lelli@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH] sched/tracing: append prev_state to tp args instead
In-Reply-To: <93a20759600c05b6d9e4359a1517c88e06b44834.camel@fb.com>
References: <20220120162520.570782-1-valentin.schneider@arm.com>
 <93a20759600c05b6d9e4359a1517c88e06b44834.camel@fb.com>
Date:   Fri, 22 Apr 2022 11:13:46 +0100
Message-ID: <xhsmh7d7hjuhx.mognet@vschneid.remote.csb>
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

On 21/04/22 22:12, Delyan Kratunov wrote:
> Hi folks,
>
> While working on bpf tooling, we noticed that the sched_switch tracepoint
> signature recently changed in an incompatible manner. This affects the
> runqslower tools in the kernel tree, as well as multiple libbpf tools in iovisor/bcc.
>

Hmph, unfortunate. What should I have run to catch this in the first place?
This doesn't trigger a single warning for me:

  $ cd tools/bpf && make runqslower

I'm guessing this is just packaging the tool and the breakage only happens
when the actual bpf syscall happens?

> It would be a fair amount of churn to fix all these tools, not to mention any
> non-public tools people may be using. If you are open to it, here's a
> description and a patch that moves the new argument to the end,
> so existing tools can continue working without change (the new argument
> just won't be extracted in existing programs):
>
> Commit fa2c3254d7cf (sched/tracing: Don't re-read p->state when emitting
> sched_switch event, 2022-01-20) added a new prev_state argument to the
> sched_switch tracepoint, before the prev task_struct pointer.
>
> This reordering of arguments broke BPF programs that use the raw
> tracepoint (e.g. tp_btf programs). The type of the second argument has
> changed and existing programs that assume a task_struct* argument
> (e.g. for bpf_task_storage or member access) will now fail to verify.
>
> If we instead append the new argument to the end, all existing programs
> will continue to work and can conditionally extract the prev_state
> argument on supported kernel versions.
>

Providing this didn't miss any new user of the sched_switch TP (I didn't
find any with rg '\bregister_[A-z,0-9,-,_]+sched_switch'), I'm okay with it
(well, I think this falls into breaking change category, so I don't have
much choice do I :-))

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

> Fixes: fa2c3254d7cf (sched/tracing: Don't re-read p->state when emitting sched_switch event, 2022-01-20)
> Signed-off-by: Delyan Kratunov <delyank@fb.com>
> ---
>  include/trace/events/sched.h      | 6 +++---
>  kernel/sched/core.c               | 2 +-
>  kernel/trace/fgraph.c             | 4 ++--
>  kernel/trace/ftrace.c             | 4 ++--
>  kernel/trace/trace_events.c       | 8 ++++----
>  kernel/trace/trace_osnoise.c      | 4 ++--
>  kernel/trace/trace_sched_switch.c | 4 ++--
>  kernel/trace/trace_sched_wakeup.c | 4 ++--
>  8 files changed, 18 insertions(+), 18 deletions(-)
>
> diff --git a/include/trace/events/sched.h b/include/trace/events/sched.h
> index 65e786756321..fbb99a61f714 100644
> --- a/include/trace/events/sched.h
> +++ b/include/trace/events/sched.h
> @@ -222,11 +222,11 @@ static inline long __trace_sched_switch_state(bool preempt,
>  TRACE_EVENT(sched_switch,
>
>       TP_PROTO(bool preempt,
> -		 unsigned int prev_state,
>                struct task_struct *prev,
> -		 struct task_struct *next),
> +		 struct task_struct *next,
> +		 unsigned int prev_state),
>
> -	TP_ARGS(preempt, prev_state, prev, next),
> +	TP_ARGS(preempt, prev, next, prev_state),
>
>       TP_STRUCT__entry(
>               __array(	char,	prev_comm,	TASK_COMM_LEN	)
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 51efaabac3e4..d58c0389eb23 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6382,7 +6382,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
>               migrate_disable_switch(rq, prev);
>               psi_sched_switch(prev, next, !task_on_rq_queued(prev));
>
> -		trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev_state, prev, next);
> +		trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev, next, prev_state);
>
>               /* Also unlocks the rq: */
>               rq = context_switch(rq, prev, next, &rf);
> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index 8f4fb328133a..a7e84c8543cb 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c
> @@ -404,9 +404,9 @@ static int alloc_retstack_tasklist(struct ftrace_ret_stack **ret_stack_list)
>
>  static void
>  ftrace_graph_probe_sched_switch(void *ignore, bool preempt,
> -				unsigned int prev_state,
>                               struct task_struct *prev,
> -				struct task_struct *next)
> +				struct task_struct *next,
> +				unsigned int prev_state)
>  {
>       unsigned long long timestamp;
>       int index;
> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index 4f1d2f5e7263..af899b058c8d 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c
> @@ -7420,9 +7420,9 @@ ftrace_func_t ftrace_ops_get_func(struct ftrace_ops *ops)
>
>  static void
>  ftrace_filter_pid_sched_switch_probe(void *data, bool preempt,
> -				     unsigned int prev_state,
>                                    struct task_struct *prev,
> -				     struct task_struct *next)
> +				     struct task_struct *next,
> +				     unsigned int prev_state)
>  {
>       struct trace_array *tr = data;
>       struct trace_pid_list *pid_list;
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index e11e167b7809..f97de82d1342 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -773,9 +773,9 @@ void trace_event_follow_fork(struct trace_array *tr, bool enable)
>
>  static void
>  event_filter_pid_sched_switch_probe_pre(void *data, bool preempt,
> -					unsigned int prev_state,
>                                       struct task_struct *prev,
> -					struct task_struct *next)
> +					struct task_struct *next,
> +					unsigned int prev_state)
>  {
>       struct trace_array *tr = data;
>       struct trace_pid_list *no_pid_list;
> @@ -799,9 +799,9 @@ event_filter_pid_sched_switch_probe_pre(void *data, bool preempt,
>
>  static void
>  event_filter_pid_sched_switch_probe_post(void *data, bool preempt,
> -					 unsigned int prev_state,
>                                        struct task_struct *prev,
> -					 struct task_struct *next)
> +					 struct task_struct *next,
> +					 unsigned int prev_state)
>  {
>       struct trace_array *tr = data;
>       struct trace_pid_list *no_pid_list;
> diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
> index e9ae1f33a7f0..afb92e2f0aea 100644
> --- a/kernel/trace/trace_osnoise.c
> +++ b/kernel/trace/trace_osnoise.c
> @@ -1168,9 +1168,9 @@ thread_exit(struct osnoise_variables *osn_var, struct task_struct *t)
>   */
>  static void
>  trace_sched_switch_callback(void *data, bool preempt,
> -			    unsigned int prev_state,
>                           struct task_struct *p,
> -			    struct task_struct *n)
> +			    struct task_struct *n,
> +			    unsigned int prev_state)
>  {
>       struct osnoise_variables *osn_var = this_cpu_osn_var();
>
> diff --git a/kernel/trace/trace_sched_switch.c b/kernel/trace/trace_sched_switch.c
> index 45796d8bd4b2..c9ffdcfe622e 100644
> --- a/kernel/trace/trace_sched_switch.c
> +++ b/kernel/trace/trace_sched_switch.c
> @@ -22,8 +22,8 @@ static DEFINE_MUTEX(sched_register_mutex);
>
>  static void
>  probe_sched_switch(void *ignore, bool preempt,
> -		   unsigned int prev_state,
> -		   struct task_struct *prev, struct task_struct *next)
> +		   struct task_struct *prev, struct task_struct *next,
> +		   unsigned int prev_state)
>  {
>       int flags;
>
> diff --git a/kernel/trace/trace_sched_wakeup.c b/kernel/trace/trace_sched_wakeup.c
> index 46429f9a96fa..330aee1c1a49 100644
> --- a/kernel/trace/trace_sched_wakeup.c
> +++ b/kernel/trace/trace_sched_wakeup.c
> @@ -426,8 +426,8 @@ tracing_sched_wakeup_trace(struct trace_array *tr,
>
>  static void notrace
>  probe_wakeup_sched_switch(void *ignore, bool preempt,
> -			  unsigned int prev_state,
> -			  struct task_struct *prev, struct task_struct *next)
> +			  struct task_struct *prev, struct task_struct *next,
> +			  unsigned int prev_state)
>  {
>       struct trace_array_cpu *data;
>       u64 T0, T1, delta;
> --
> 2.35.1

