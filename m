Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7CA4932EE
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 03:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348726AbiASC2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 21:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238636AbiASC2R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 21:28:17 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2091FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 18:28:17 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id p18so2040106wmg.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 18:28:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O1LsXbWam+BKI8xqcLlx4R6zRUKLsu3ZAy6sVWL3Hgw=;
        b=nkOeeRy5lCMH1X87zOGcCtfaK2+bqea8H1/Dv3PfBoA3UgouSINMv7uevyX2z0JIic
         xU84/zZjSbzHGhbZL9JYyZNFCLsF7EFbv4ohtt5DAs4iCotq/nbgB9cxCEVkjQwsMtyL
         5bPODaloqW9MrEbPBhOQt56DV+O6gpvVCy5HFe5GXgqrMiAyCnFKvd97Gj0JjPmhb4jM
         78m8r64hyj+HPwc7Mk9xv92MCytAwRrYU+8vB+dwS6iJMuNzPM7GXyShUONSPCBn52Ci
         BUid5gP7JZiujfD5qxAWtWXXI11Pr0M2fvjtg3iwo0GoLOPLrsSOyTDreDZTLl5PpsX7
         qd1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O1LsXbWam+BKI8xqcLlx4R6zRUKLsu3ZAy6sVWL3Hgw=;
        b=Rfz/aZCk9NEKaeb2bQi14vZnA0hivhjFFBm5Py/SOXhH0fAlw1wTVEezz1yaf7Dsds
         Ewl8U7/agML3bK2l0woBmlcKbMrlYpqX0i2g9dDssAlENblntCJbeANLChVFrH0U6sfW
         RUBuu8t18t4nhBdp0GJRGJBEqZRwivcWYv7azKjsyT4NVL93Kl6EdgGb1x9WdcmsqNVZ
         O1Fat9ZnKs35G/SfFxVI8drc9x7yGfj6dWiU/zibexvx4IDcYbPz846dKA/DMuYDEeM0
         3/aFKqkM1+auPD5HXv7FpeloKpaF45Kg17HREzRcwuKYZ5hbCeHqrSR1Gu0c6rEDs8E3
         dfig==
X-Gm-Message-State: AOAM532XS9fvf/jAUmH000/zialh7NYMb04ZWdvHubMlKFifqguNeE6O
        46YMO4TeedaKylDKYhDPvB25ufwuoo6ylniPM90=
X-Google-Smtp-Source: ABdhPJxz9l8UmO4FnNI1o/4ICln/SEENzWSFtFC0G4xB7tyznurTtwFN6HS74h6LPsR+iOUsNxCJ7boRoWSjqRiKfdc=
X-Received: by 2002:a5d:5909:: with SMTP id v9mr35605wrd.554.1642559295275;
 Tue, 18 Jan 2022 18:28:15 -0800 (PST)
MIME-Version: 1.0
References: <20220113013835.503285-1-xiehuan09@gmail.com> <20220113013835.503285-3-xiehuan09@gmail.com>
 <20220119001343.e9a07c7c0d8db586faeb5ae7@kernel.org>
In-Reply-To: <20220119001343.e9a07c7c0d8db586faeb5ae7@kernel.org>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Wed, 19 Jan 2022 10:28:03 +0800
Message-ID: <CAEr6+EA0vp3cTRqqSJvTEQtPCZ8p_6MxZWmQ5hPzQDWp=RusiQ@mail.gmail.com>
Subject: Re: [PATCH v7 2/4] trace/objtrace: get the value of the object
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Tue, Jan 18, 2022 at 11:13 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi Jeff,
>
> On Thu, 13 Jan 2022 09:38:33 +0800
> Jeff Xie <xiehuan09@gmail.com> wrote:
>
> > Using objtrace trigger to get the value of the object which from the kernel
> > function parameter.
> >
> > Syntax:
> >       objtrace:add:obj[,offset][:type][:count][if <filter>]
> >
> > Usage:
> >       # echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
> >       # gdb vmlinux
> >       (gdb) p &(((struct bio *)0)->bi_iter.bi_size)
> >       $1 = (unsigned int *) 0x28
> >       # echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/ \
> >                p_bio_add_page_0/trigger
> >       # cat /test.txt
> >
> > Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
> > ---
> >  kernel/trace/trace.c         |   2 +-
> >  kernel/trace/trace_entries.h |   5 +-
> >  kernel/trace/trace_object.c  | 190 +++++++++++++++++++++++++++++------
> >  kernel/trace/trace_output.c  |   6 +-
> >  4 files changed, 169 insertions(+), 34 deletions(-)
> >
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 0b627963e343..d5332ece4c67 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -5591,7 +5591,7 @@ static const char readme_msg[] =
> >       "\t            disable_hist:<system>:<event>\n"
> >  #endif
> >  #ifdef CONFIG_TRACE_OBJECT
> > -     "\t            objtrace:add:obj[:count][if <filter>]\n"
> > +     "\t            objtrace:add:obj[,offset][:type][:count][if <filter>]\n"
> >  #endif
> >  #ifdef CONFIG_STACKTRACE
> >       "\t\t    stacktrace\n"
> > diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
> > index bb120d9498a9..2407c45a568c 100644
> > --- a/kernel/trace/trace_entries.h
> > +++ b/kernel/trace/trace_entries.h
> > @@ -413,8 +413,9 @@ FTRACE_ENTRY(object, trace_object_entry,
> >               __field(        unsigned long,          ip              )
> >               __field(        unsigned long,          parent_ip       )
> >               __field(        unsigned long,          object          )
> > +             __field(        unsigned long,          value           )
> >       ),
> >
> > -     F_printk(" %ps <-- %ps object:%lx\n",
> > -              (void *)__entry->ip, (void *)__entry->parent_ip, __entry->object)
> > +     F_printk(" %ps <-- %ps object:%lx value:%lx\n", (void *)__entry->ip,
> > +            (void *)__entry->parent_ip, __entry->object, __entry->value)
> >  );
> > diff --git a/kernel/trace/trace_object.c b/kernel/trace/trace_object.c
> > index 4af1c117cbfa..774a9dff4d0a 100644
> > --- a/kernel/trace/trace_object.c
> > +++ b/kernel/trace/trace_object.c
> > @@ -11,7 +11,6 @@
> >  #define MAX_TRACED_OBJECT 5
> >  static DEFINE_RAW_SPINLOCK(trace_obj_lock);
> >  static struct trace_event_file event_trace_file;
> > -static const int max_args_num = 6;
> >  static atomic_t trace_object_ref;
> >  static atomic_t num_traced_obj;
> >  static int exit_trace_object(void);
> > @@ -19,8 +18,22 @@ static int init_trace_object(void);
> >
> >  static struct object_instance {
> >       void *obj;
> > +     int obj_type_size;
> >  } traced_obj[MAX_TRACED_OBJECT];
> >
> > +/* objtrace private data */
> > +struct objtrace_trigger_data {
> > +     struct ftrace_event_field *field;
> > +     int offset;
> > +     int obj_type_size;
> > +};
> > +
> > +/* get the type size for the special object */
> > +struct objtrace_fetch_type {
> > +     char *name;
> > +     int type_size;
> > +};
> > +
> >  static bool object_exist(void *obj)
> >  {
> >       int i, max;
> > @@ -39,7 +52,7 @@ static bool object_empty(void)
> >       return !atomic_read(&num_traced_obj);
> >  }
> >
> > -static void set_trace_object(void *obj)
> > +static void set_trace_object(void *obj, int obj_type_size)
> >  {
> >       unsigned long flags;
> >
> > @@ -59,6 +72,7 @@ static void set_trace_object(void *obj)
> >               goto out;
> >       }
> >       traced_obj[atomic_read(&num_traced_obj)].obj = obj;
> > +     traced_obj[atomic_read(&num_traced_obj)].obj_type_size = obj_type_size;
> >       /* make sure the num_traced_obj update always appears after traced_obj update */
> >       smp_wmb();
> >       atomic_inc(&num_traced_obj);
> > @@ -67,7 +81,7 @@ static void set_trace_object(void *obj)
> >  }
> >
> >  static void submit_trace_object(unsigned long ip, unsigned long parent_ip,
> > -                              unsigned long object)
> > +                              unsigned long object, unsigned long value)
> >  {
> >
> >       struct trace_buffer *buffer;
> > @@ -84,18 +98,66 @@ static void submit_trace_object(unsigned long ip, unsigned long parent_ip,
> >       entry->ip                       = ip;
> >       entry->parent_ip                = parent_ip;
> >       entry->object                   = object;
> > +     entry->value                    = value;
> >
> >       event_trigger_unlock_commit(&event_trace_file, buffer, event,
> >               entry, pc);
> >  }
> >
> > +static inline long get_object_value(unsigned long *val, void *obj, int type_size)
> > +{
> > +     long ret = 0;
> > +
> > +     switch (type_size) {
> > +     case 1: {
> > +             u8 tmp;
> > +
> > +             ret = copy_from_kernel_nofault(&tmp, obj, sizeof(tmp));
> > +             if (ret)
> > +                     goto out;
> > +             *val = tmp;
> > +             break;
> > +     }
> > +     case 2: {
> > +             u16 tmp;
> > +
> > +             ret = copy_from_kernel_nofault(&tmp, obj, sizeof(tmp));
> > +             if (ret)
> > +                     goto out;
> > +             *val = tmp;
> > +             break;
> > +     }
> > +     case 4: {
> > +             u32 tmp;
> > +
> > +             ret = copy_from_kernel_nofault(&tmp, obj, sizeof(tmp));
> > +             if (ret)
> > +                     goto out;
> > +             *val = tmp;
> > +             break;
> > +     }
> > +     case 8: {
> > +             u64 tmp;
> > +
> > +             ret = copy_from_kernel_nofault(&tmp, obj, sizeof(tmp));
> > +             if (ret)
> > +                     goto out;
> > +             *val = tmp;
> > +             break;
> > +     }
>
> Can't you move the copy_from_kernel_nofault() outside of the switch-case?
> e.g.
>
>         char tmp[sizeof(u64)];
>
>         ret = copy_from_kernel_nofault(tmp, obj, sizeof(tmp));
>         if (ret)
>                 return ret;
>
>         switch (type_size) {
>                 case 1:
>                         *val = (unsigned long)*(u8 *)tmp;
>                         break;
>                 ...
>         }
>         return 0;

Thanks, I will change it.

> Thank you,
>
>
> > +     default:
> > +             return -EINVAL;
> > +     }
> > +out:
> > +     return ret;
> > +}
> > +
> >  static void
> >  trace_object_events_call(unsigned long ip, unsigned long parent_ip,
> >               struct ftrace_ops *op, struct ftrace_regs *fregs)
> >  {
> > -     struct pt_regs *pt_regs = ftrace_get_regs(fregs);
> > -     unsigned long obj;
> > -     int bit, n;
> > +     unsigned long val = 0;
> > +     int bit, n, max;
> >
> >       bit = ftrace_test_recursion_trylock(ip, parent_ip);
> >       if (bit < 0)
> > @@ -104,11 +166,12 @@ trace_object_events_call(unsigned long ip, unsigned long parent_ip,
> >       if (object_empty())
> >               goto out;
> >
> > -     for (n = 0; n < max_args_num; n++) {
> > -             obj = regs_get_kernel_argument(pt_regs, n);
> > -             if (object_exist((void *)obj))
> > -                     submit_trace_object(ip, parent_ip, obj);
>
> This actually filtered the (function call) event which is related to the object.
>
> > -     /* The parameters of a function may match multiple objects */
> > +     max = atomic_read(&num_traced_obj);
> > +     smp_rmb();
> > +     for (n = 0; n < max; n++) {
> > +             if (get_object_value(&val, traced_obj[n].obj, traced_obj[n].obj_type_size))
> > +                     goto out;
> > +             submit_trace_object(ip, parent_ip, (unsigned long)traced_obj[n].obj, val);
>
> But you lost the filter here.
> This is because you saves the "object + offset" address below;

I misunderstood the previous discussion and thought that filter
do not apply when getting the value of the object. ;-)
I will add the filter.

>
> >       }
> >  out:
> >       ftrace_test_recursion_unlock(bit);
> > @@ -124,12 +187,15 @@ trace_object_trigger(struct event_trigger_data *data,
> >                  struct trace_buffer *buffer,  void *rec,
> >                  struct ring_buffer_event *event)
> >  {
> > +     struct objtrace_trigger_data *obj_data = data->private_data;
> > +     struct ftrace_event_field *field;
> > +     void *obj, *val = NULL;
> >
> > -     struct ftrace_event_field *field = data->private_data;
> > -     void *obj = NULL;
> > -
> > -     memcpy(&obj, rec + field->offset, sizeof(obj));
> > -     set_trace_object(obj);
> > +     field = obj_data->field;
> > +     memcpy(&val, rec + field->offset, sizeof(val));
> > +     /* get the final object */
> > +     obj = val + obj_data->offset;
>
> Here, you saved the object address including offset. This means
> you can not filter the actual function related to the object.
>
> Please recover the filter.
>
> > +     set_trace_object(obj, obj_data->obj_type_size);
>
> You can save the offset with type-size and object address itself.

Thanks, I will recover it.

> Thank you,
>
> >  }
> >
> >  static void
> > @@ -140,8 +206,10 @@ trace_object_trigger_free(struct event_trigger_ops *ops,
> >               return;
> >
> >       data->ref--;
> > -     if (!data->ref)
> > +     if (!data->ref) {
> > +             kfree(data->private_data);
> >               trigger_data_free(data);
> > +     }
> >  }
> >
> >  static void
> > @@ -276,6 +344,22 @@ static void unregister_object_trigger(char *glob, struct event_trigger_ops *ops,
> >       }
> >  }
> >
> > +static const struct objtrace_fetch_type objtrace_fetch_types[] = {
> > +     {"u8", 1},
> > +     {"s8", 1},
> > +     {"x8", 1},
> > +     {"u16", 2},
> > +     {"s16", 2},
> > +     {"x16", 2},
> > +     {"u32", 4},
> > +     {"s32", 4},
> > +     {"x32", 4},
> > +     {"u64", 8},
> > +     {"s64", 8},
> > +     {"x64", 8},
> > +     {}
> > +};
> > +
> >  static int
> >  event_object_trigger_callback(struct event_command *cmd_ops,
> >                      struct trace_event_file *file,
> > @@ -283,19 +367,22 @@ event_object_trigger_callback(struct event_command *cmd_ops,
> >  {
> >       struct event_trigger_data *trigger_data;
> >       struct event_trigger_ops *trigger_ops;
> > +     struct objtrace_trigger_data *obj_data;
> >       struct trace_event_call *call;
> >       struct ftrace_event_field *field;
> > -     char *objtrace_cmd;
> > -     char *trigger = NULL;
> > -     char *arg;
> > -     char *number;
> > -     int ret;
> > +     char *type, *tr, *obj, *tmp, *trigger = NULL;
> > +     char *number, *objtrace_cmd;
> > +     int ret, i, def_type_size, obj_type_size = 0;
> > +     long offset = 0;
> >
> >       ret = -EINVAL;
> >       if (!param)
> >               goto out;
> >
> > -     /* separate the trigger from the filter (c:a:n [if filter]) */
> > +     /*
> > +      * separate the trigger from the filter:
> > +      * objtrace:add:OBJ[,OFFS][:TYPE][:COUNT] [if filter]
> > +      */
> >       trigger = strsep(&param, " \t");
> >       if (!trigger)
> >               goto out;
> > @@ -309,33 +396,79 @@ event_object_trigger_callback(struct event_command *cmd_ops,
> >       if (!objtrace_cmd || strcmp(objtrace_cmd, "add"))
> >               goto out;
> >
> > -     arg = strsep(&trigger, ":");
> > -     if (!arg)
> > +     obj = strsep(&trigger, ":");
> > +     if (!obj)
> >               goto out;
> > +
> > +     tr = strchr(obj, ',');
> > +     if (!tr)
> > +             offset = 0;
> > +     else {
> > +             *tr++ = '\0';
> > +             ret = kstrtol(tr, 0, &offset);
> > +             if (ret)
> > +                     goto out;
> > +     }
> > +
> > +     ret = -EINVAL;
> >       call = file->event_call;
> > -     field = trace_find_event_field(call, arg);
> > +     field = trace_find_event_field(call, obj);
> >       if (!field)
> >               goto out;
> >
> >       if (field->size != sizeof(void *))
> >               goto out;
> > +     def_type_size = sizeof(void *);
> > +     if (!trigger) {
> > +             obj_type_size = def_type_size;
> > +             goto skip_get_type;
> > +     }
> >
> > +     tmp = trigger;
> > +     type = strsep(&trigger, ":");
> > +     if (!type)
> > +             obj_type_size = def_type_size;
> > +     else if (isdigit(type[0])) {
> > +             obj_type_size = def_type_size;
> > +             trigger = tmp;
> > +     } else {
> > +             for (i = 0; objtrace_fetch_types[i].name; i++) {
> > +                     if (strcmp(objtrace_fetch_types[i].name, type) == 0) {
> > +                             obj_type_size = objtrace_fetch_types[i].type_size;
> > +                             break;
> > +                     }
> > +             }
> > +     }
> > +     if (!obj_type_size)
> > +             goto out;
> > +skip_get_type:
> >       trigger_ops = cmd_ops->get_trigger_ops(cmd, trigger);
> >
> >       ret = -ENOMEM;
> > +     obj_data = kzalloc(sizeof(*obj_data), GFP_KERNEL);
> > +     if (!obj_data)
> > +             goto out;
> > +
> > +     obj_data->field = field;
> > +     obj_data->offset = offset;
> > +     obj_data->obj_type_size = obj_type_size;
> > +
> >       trigger_data = kzalloc(sizeof(*trigger_data), GFP_KERNEL);
> > -     if (!trigger_data)
> > +     if (!trigger_data) {
> > +             kfree(obj_data);
> >               goto out;
> > +     }
> >
> >       trigger_data->count = -1;
> >       trigger_data->ops = trigger_ops;
> >       trigger_data->cmd_ops = cmd_ops;
> > -     trigger_data->private_data = field;
> > +     trigger_data->private_data = obj_data;
> >       INIT_LIST_HEAD(&trigger_data->list);
> >       INIT_LIST_HEAD(&trigger_data->named_list);
> >
> >       if (glob[0] == '!') {
> >               cmd_ops->unreg(glob+1, trigger_ops, trigger_data, file);
> > +             kfree(obj_data);
> >               kfree(trigger_data);
> >               ret = 0;
> >               goto out;
> > @@ -390,6 +523,7 @@ event_object_trigger_callback(struct event_command *cmd_ops,
> >   out_free:
> >       if (cmd_ops->set_filter)
> >               cmd_ops->set_filter(NULL, trigger_data, NULL);
> > +     kfree(obj_data);
> >       kfree(trigger_data);
> >       goto out;
> >  }
> > diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
> > index d747aed27104..12a971927d8c 100644
> > --- a/kernel/trace/trace_output.c
> > +++ b/kernel/trace/trace_output.c
> > @@ -1553,6 +1553,7 @@ static enum print_line_t trace_object_print(struct trace_iterator *iter, int fla
> >       trace_assign_type(field, iter->ent);
> >       print_fn_trace(s, field->ip, field->parent_ip, flags);
> >       trace_seq_printf(s, " object:0x%lx", field->object);
> > +     trace_seq_printf(s, " value:0x%lx", field->value);
> >       trace_seq_putc(s, '\n');
> >
> >       return trace_handle_return(s);
> > @@ -1565,9 +1566,8 @@ static enum print_line_t trace_object_raw(struct trace_iterator *iter, int flags
> >
> >       trace_assign_type(field, iter->ent);
> >
> > -     trace_seq_printf(&iter->seq, "%lx %lx\n",
> > -                      field->ip,
> > -                      field->parent_ip);
> > +     trace_seq_printf(&iter->seq, "%lx %lx %lx %lx\n", field->ip,
> > +                     field->parent_ip, field->object, field->value);
> >
> >       return trace_handle_return(&iter->seq);
> >  }
> > --
> > 2.25.1
> >
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>
---
JeffXie
