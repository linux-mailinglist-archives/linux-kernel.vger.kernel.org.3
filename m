Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34CA4BFBE3
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233113AbiBVPFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232898AbiBVPFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:05:06 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5428210E06A
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:04:41 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id s1so20425839iob.9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HdNpOmeSgnI7mfqUNa90eQdVAGuPCOTlAwzEsXD4SxU=;
        b=J1rl5TbrK0atsPRYIWKXqbrB8lIOPQzmfhxp/qZxbpbSFuV/S7PAcTbaJOZPQ/8J5I
         0sqrwYsF0h9KIfqkM0e/m1onqYNkTtwxSUUJxdgKYZfQtTJosPl1/0Fhg4FaAVnbR3CQ
         1iqpSRahaIIYZN9wSQywVPNtqY/jNwSfd8e8Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HdNpOmeSgnI7mfqUNa90eQdVAGuPCOTlAwzEsXD4SxU=;
        b=7APDiK9VUoz4mG+i+BjJQ1Jx5Hjze47c6XR20ef2hJ99cVJ91qbxzS1ttoR39MHQWC
         TTwticypHO7u7Y+gFxpx1oRjfDXK9X04sM0tVrE4jm4fKYZhSM+LUF6u6pwDcRd0M6O5
         88ZhPAPBdQnLV5izBqyNO7ZhPi2RNAL9ArKtbBay21BA+IKIeoKgWttsiJaxP10ydIDU
         Gp991SxcbDyzudA3JTA0gY8wgrKg4dnYnOXN9wIKnjl5MEbbAYAc4jz3E/Nyf5L5im7R
         QoKjUVEi1uqDdNT4BQHbzyR0R/fAwfzAd4L7q+aLZE5YC/CvFHeQl8l/tFPCKj3Zv+Mi
         1iIQ==
X-Gm-Message-State: AOAM533xRKu1iF5eSlEqHlkg77eZoFrIIN8mXKrMFBguTaFCbQ2raqzG
        2HjyohFzGEyZnjRAPYsL0iZWDGsNa6lgRnpBywptcA==
X-Google-Smtp-Source: ABdhPJzd4f57jwjdG/UIoZCyFOzO3Wz0Jj2YKkBRPVZBd25F35AGayNJ/ixhIkUz2a1xWtd7dOmlycPutise6iC9W/E=
X-Received: by 2002:a05:6638:a8f:b0:313:f8d3:efe9 with SMTP id
 15-20020a0566380a8f00b00313f8d3efe9mr18986426jas.304.1645542280613; Tue, 22
 Feb 2022 07:04:40 -0800 (PST)
MIME-Version: 1.0
References: <20220218190057.2f5a19a8@gandalf.local.home>
In-Reply-To: <20220218190057.2f5a19a8@gandalf.local.home>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Tue, 22 Feb 2022 10:04:29 -0500
Message-ID: <CAEXW_YSGa7a1UgYdiE7wcMsvsYnYB-jW3mQ=KRHSoU95gruS7g@mail.gmail.com>
Subject: Re: [PATCH] eprobes: Remove redundant event type information
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 7:01 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> From 3163c1db8bbde856367b9d4e132d1bac9ec26704 Mon Sep 17 00:00:00 2001
> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> Date: Fri, 18 Feb 2022 18:52:38 -0500
> Subject: [PATCH] eprobes: Remove redundant event type information

Thanks!

Reviewed-by: Joel Fernandes <joel@joelfernandes.org>

Joel


>
> Currently, the event probes save the type of the event they are attached
> to when recording the event. For example:
>
>   # echo 'e:switch sched/sched_switch prev_state=$prev_state prev_prio=$prev_prio next_pid=$next_pid next_prio=$next_prio' > dynamic_events
>   # cat events/eprobes/switch/format
>
>  name: switch
>  ID: 1717
>  format:
>         field:unsigned short common_type;       offset:0;       size:2; signed:0;
>         field:unsigned char common_flags;       offset:2;       size:1; signed:0;
>         field:unsigned char common_preempt_count;       offset:3;       size:1; signed:0;
>         field:int common_pid;   offset:4;       size:4; signed:1;
>
>         field:unsigned int __probe_type;        offset:8;       size:4; signed:0;
>         field:u64 prev_state;   offset:12;      size:8; signed:0;
>         field:u64 prev_prio;    offset:20;      size:8; signed:0;
>         field:u64 next_pid;     offset:28;      size:8; signed:0;
>         field:u64 next_prio;    offset:36;      size:8; signed:0;
>
>  print fmt: "(%u) prev_state=0x%Lx prev_prio=0x%Lx next_pid=0x%Lx next_prio=0x%Lx", REC->__probe_type, REC->prev_state, REC->prev_prio, REC->next_pid, REC->next_prio
>
> The __probe_type adds 4 bytes to every event.
>
> One of the reasons for creating eprobes is to limit what is traced in an
> event to be able to limit what is written into the ring buffer. Having
> this redundant 4 bytes to every event takes away from this.
>
> The event that is recorded can be retrieved from the event probe itself,
> that is available when the trace is happening. For user space tools, it
> could simply read the dynamic_event file to find the event they are for.
> So there is really no reason to write this information into the ring
> buffer for every event.
>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace.h        |  1 -
>  kernel/trace/trace_eprobe.c | 15 +++++++--------
>  kernel/trace/trace_probe.c  | 10 +++++-----
>  kernel/trace/trace_probe.h  |  1 -
>  4 files changed, 12 insertions(+), 15 deletions(-)
>
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 0f5e22238cd2..07d990270e2a 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -136,7 +136,6 @@ struct kprobe_trace_entry_head {
>
>  struct eprobe_trace_entry_head {
>         struct trace_entry      ent;
> -       unsigned int            type;
>  };
>
>  struct kretprobe_trace_entry_head {
> diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
> index 191db32dec46..02838d47129f 100644
> --- a/kernel/trace/trace_eprobe.c
> +++ b/kernel/trace/trace_eprobe.c
> @@ -250,8 +250,6 @@ static int eprobe_event_define_fields(struct trace_event_call *event_call)
>         if (WARN_ON_ONCE(!tp))
>                 return -ENOENT;
>
> -       DEFINE_FIELD(unsigned int, type, FIELD_STRING_TYPE, 0);
> -
>         return traceprobe_define_arg_fields(event_call, sizeof(field), tp);
>  }
>
> @@ -270,7 +268,9 @@ print_eprobe_event(struct trace_iterator *iter, int flags,
>         struct trace_event_call *pevent;
>         struct trace_event *probed_event;
>         struct trace_seq *s = &iter->seq;
> +       struct trace_eprobe *ep;
>         struct trace_probe *tp;
> +       unsigned int type;
>
>         field = (struct eprobe_trace_entry_head *)iter->ent;
>         tp = trace_probe_primary_from_call(
> @@ -278,15 +278,18 @@ print_eprobe_event(struct trace_iterator *iter, int flags,
>         if (WARN_ON_ONCE(!tp))
>                 goto out;
>
> +       ep = container_of(tp, struct trace_eprobe, tp);
> +       type = ep->event->event.type;
> +
>         trace_seq_printf(s, "%s: (", trace_probe_name(tp));
>
> -       probed_event = ftrace_find_event(field->type);
> +       probed_event = ftrace_find_event(type);
>         if (probed_event) {
>                 pevent = container_of(probed_event, struct trace_event_call, event);
>                 trace_seq_printf(s, "%s.%s", pevent->class->system,
>                                  trace_event_name(pevent));
>         } else {
> -               trace_seq_printf(s, "%u", field->type);
> +               trace_seq_printf(s, "%u", type);
>         }
>
>         trace_seq_putc(s, ')');
> @@ -498,10 +501,6 @@ __eprobe_trace_func(struct eprobe_data *edata, void *rec)
>                 return;
>
>         entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
> -       if (edata->ep->event)
> -               entry->type = edata->ep->event->event.type;
> -       else
> -               entry->type = 0;
>         store_trace_args(&entry[1], &edata->ep->tp, rec, sizeof(*entry), dsize);
>
>         trace_event_buffer_commit(&fbuffer);
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index 73d90179b51b..80863c6508e5 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -871,15 +871,15 @@ static int __set_print_fmt(struct trace_probe *tp, char *buf, int len,
>         switch (ptype) {
>         case PROBE_PRINT_NORMAL:
>                 fmt = "(%lx)";
> -               arg = "REC->" FIELD_STRING_IP;
> +               arg = ", REC->" FIELD_STRING_IP;
>                 break;
>         case PROBE_PRINT_RETURN:
>                 fmt = "(%lx <- %lx)";
> -               arg = "REC->" FIELD_STRING_FUNC ", REC->" FIELD_STRING_RETIP;
> +               arg = ", REC->" FIELD_STRING_FUNC ", REC->" FIELD_STRING_RETIP;
>                 break;
>         case PROBE_PRINT_EVENT:
> -               fmt = "(%u)";
> -               arg = "REC->" FIELD_STRING_TYPE;
> +               fmt = "";
> +               arg = "";
>                 break;
>         default:
>                 WARN_ON_ONCE(1);
> @@ -903,7 +903,7 @@ static int __set_print_fmt(struct trace_probe *tp, char *buf, int len,
>                                         parg->type->fmt);
>         }
>
> -       pos += snprintf(buf + pos, LEN_OR_ZERO, "\", %s", arg);
> +       pos += snprintf(buf + pos, LEN_OR_ZERO, "\"%s", arg);
>
>         for (i = 0; i < tp->nr_args; i++) {
>                 parg = tp->args + i;
> diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
> index 99e7a5df025e..92cc149af0fd 100644
> --- a/kernel/trace/trace_probe.h
> +++ b/kernel/trace/trace_probe.h
> @@ -38,7 +38,6 @@
>  #define FIELD_STRING_IP                "__probe_ip"
>  #define FIELD_STRING_RETIP     "__probe_ret_ip"
>  #define FIELD_STRING_FUNC      "__probe_func"
> -#define FIELD_STRING_TYPE      "__probe_type"
>
>  #undef DEFINE_FIELD
>  #define DEFINE_FIELD(type, item, name, is_signed)                      \
> --
> 2.34.1
>
