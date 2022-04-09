Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BD844FA198
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 04:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235777AbiDICTa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 22:19:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231728AbiDICT2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 22:19:28 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD7D317075
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 19:17:22 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id h16so6652196wmd.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 19:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JnilLONCkkPdY7wyxJ3cw+mv3c8JKQewTRQGkUKHu1E=;
        b=O6t9ibJtiCtuAC3HN9U0Wnbcn107kUZkJ5yJy8uAVPM047wcWPq0Bgs6F0Bmimv7rW
         PEJdkT9S8lKIhk/XyQrZzkF1utNH8hJpoYmfS+HVGVFPf++wcaXNltCrs8rGdugxbDSE
         5MY6OUEIDceGjJya/OJEtNse2Urd4OtDlBpF/CrzB+y9kGs3Zg/k1DP0jM/NxiQfoqUd
         11TPQILYXtQngO7OgIXMUDKy0yt08N8YCsSqyqg6F1MZpNj4DwLfswK3zINMh8vr9uC3
         thKbZt7c0JdbUutcbhTG2aDKf97nd/+P+QTi5HIZliC93ND0oSaoBPGDxVKirvvcMhNM
         bTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JnilLONCkkPdY7wyxJ3cw+mv3c8JKQewTRQGkUKHu1E=;
        b=l/XIaWt0dKN4JTv199ta0UuZR2qNycfkKZXfuw5tL2CfTCzpe28bGHDN9bYyZRX7ZP
         uVPiw5bXamF0BlDymufF4aDuLFRIUPs0xaDmDoizSSVNrHbImzWCaGLYpQygdTNc2BSI
         wlfsNDcKjT/sPRAnLQJa7P1X7BajcImhpBtjp7z7XXMGfyYxzsZg5/66sCJKxVjpq+4E
         qyEDMJTh5Qih/N1gzhNWnWiBr4qsKwv6nn+zQ8abA4Y1o/lMtWsltNypSE+AwrCs0z51
         iB3Wp60XUzZL3ldYBcfNZIdZXtShZQLP9VM4W8vI+2J8NTZqWuH14otEjrelwBhgipsF
         A9cw==
X-Gm-Message-State: AOAM531MonA9Q08bX4QQJ6gUJPelP0q/G8VdlUMTGNc/6A4qRTX+Mn0V
        GLoXZdYFWBV78t9jmslIpFmaXEhhyket/EOH5XZsvJCKPuY=
X-Google-Smtp-Source: ABdhPJyJ6ZaVY3jpDCQnvjsra2FWX71dygUZcdzr7b+KuMAorhg1cC/DGN/5jd8v198tf5k/kb7N6OSH/zTVIE77a/s=
X-Received: by 2002:a05:600c:3593:b0:38e:a8a2:abe3 with SMTP id
 p19-20020a05600c359300b0038ea8a2abe3mr4676073wmq.149.1649470641379; Fri, 08
 Apr 2022 19:17:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220329163931.710555-1-xiehuan09@gmail.com> <20220329163931.710555-4-xiehuan09@gmail.com>
 <20220408171808.762c5c8b@gandalf.local.home>
In-Reply-To: <20220408171808.762c5c8b@gandalf.local.home>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Sat, 9 Apr 2022 10:17:09 +0800
Message-ID: <CAEr6+ECoFHPp6FE8gAhwDPtnc=UG8QFgF7NhuoFjX0gzZrD0wA@mail.gmail.com>
Subject: Re: [PATCH 3/3] tracing: make tp_printk work on syscall tracepoints
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mingo@redhat.com, Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi steve,

On Sat, Apr 9, 2022 at 5:18 AM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Wed, 30 Mar 2022 00:39:31 +0800
> Jeff Xie <xiehuan09@gmail.com> wrote:
>
> First, patch 1 and 2 can be folded into this patch. Making something
> "available for future use" is not a reason to break up patches. It will not
> help in bisecting, and its not something to be backported.
>
> Next, the tracing subsystem follows the "Capitalize first letter" for
> subjects:
>
>  "tracing: Make tp_printk work on syscall tracepoints"
>
> > Adding printk for syscall tracepoints for the tp_printk work.
>
> Need to add much more content to the above. Your cover letter would work.
>
>     Currently the tp_printk option has no effect on syscall tracepoint.
>     When adding the kernel option parameter tp_printk, then:
>
>     echo 1 > /sys/kernel/debug/tracing/events/syscalls/enable
>
>     When running any application, no trace information is printed on the
>     terminal.
>
>     Now added printk for syscall tracepoints.
>
> As commit logs should be self explanatory per commit. The cover letter was,
> but this patch was lacking.

Thanks a lot for these detailed suggestions.

>
> >
> > Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
> > ---
> >  kernel/trace/trace_syscalls.c | 25 +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> >
> > diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
> > index f755bde42fd0..9798122166d3 100644
> > --- a/kernel/trace/trace_syscalls.c
> > +++ b/kernel/trace/trace_syscalls.c
> > @@ -290,6 +290,25 @@ static int __init syscall_enter_define_fields(struct trace_event_call *call)
> >       return ret;
> >  }
> >
> > +static void syscall_output_printk(struct trace_entry *ent,
> > +             struct trace_event_file *trace_file, struct trace_array *tr)
> > +{
> > +     unsigned long flags;
> > +     struct trace_iterator *iter = tracepoint_print_iter;
> > +     struct trace_event *event = &trace_file->event_call->event;
> > +
> > +     spin_lock_irqsave(&tracepoint_iter_lock, flags);
> > +
> > +     trace_seq_init(&iter->seq);
> > +     iter->ent = ent;
> > +     iter->tr = tr;
> > +     event->funcs->trace(iter, 0, event);
> > +     trace_seq_putc(&iter->seq, 0);
> > +     pr_info("%s", iter->seq.buffer);
> > +
> > +     spin_unlock_irqrestore(&tracepoint_iter_lock, flags);
> > +}
> > +
> >  static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
> >  {
> >       struct trace_array *tr = data;
> > @@ -333,6 +352,9 @@ static void ftrace_syscall_enter(void *data, struct pt_regs *regs, long id)
> >       syscall_get_arguments(current, regs, args);
> >       memcpy(entry->args, args, sizeof(unsigned long) * sys_data->nb_args);
> >
> > +     if (static_key_false(&tracepoint_printk_key.key))
> > +             syscall_output_printk(&entry->ent, trace_file, tr);
> > +
> >       event_trigger_unlock_commit(trace_file, buffer, event, entry,
> >                                   trace_ctx);
>
>
> >  }
> > @@ -376,6 +398,9 @@ static void ftrace_syscall_exit(void *data, struct pt_regs *regs, long ret)
> >       entry->nr = syscall_nr;
> >       entry->ret = syscall_get_return_value(current, regs);
> >
> > +     if (static_key_false(&tracepoint_printk_key.key))
> > +             syscall_output_printk(&entry->ent, trace_file, tr);
> > +
>
> Instead of reimplementing the logic, just convert the syscall code to use,
> trace_event_buffer_reserve() and trace_event_buffer_commit(), and then you
> not only get tp_printk() for syscalls, but also other features as well.

Thanks, I will prepare the V2.

> -- Steve
>
>
> >       event_trigger_unlock_commit(trace_file, buffer, event, entry,
> >                                   trace_ctx);
> >  }
>
---
JeffXie
