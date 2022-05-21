Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F230B52FE8C
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 19:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344134AbiEUR0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 13:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351216AbiEUR0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 13:26:14 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A0819FA3
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 10:26:12 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id h14so15307441wrc.6
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 10:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2SKgIfj74iVJMvUx1IzNKdVAOmxIWFa5055WEMfu4fI=;
        b=jL5IYLDqXgv1R4/bPEmPkjrP12EL3URBvOx7WoOoGTdujHxXf5q3uC+72esRLFDmSW
         HzeQqROl+smAXZiNvfTVIdrAVrPk9faJgui7Rkn4aAmXVvyZw1j/Ym3w5dtFo/nfmRv/
         ZdRgKFAHpopCEFcsPQuxdr87Ci8TYmoBaJdj9RJEWgbGUm8EL8r/Aem7I0OtWKMn4fZW
         o1lnPXgSCkp7q1Ie0goya6655vFUCzcj/teWkrHToIhQVrzdDnUNGqXX+SECKQjM21+y
         N8X++9bKysKSRRCCeuiwO19jFsqCIkw62B5LMW7ZhFe1fbk1qs2QNXBNLV0pvnFNYO6B
         cAkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2SKgIfj74iVJMvUx1IzNKdVAOmxIWFa5055WEMfu4fI=;
        b=kLrOP17Af/mjG79NmbjSBPrWTUDddj7Yh+w7tcAguR5AYDJrCpddIBNG4CvNPTmFAC
         5mSsnyxL0KkVqtohJHYl9D5rxjxKunpo95GKv0ySQfM+6Mm4HBbxbQ2MraoEBnbsOEYY
         EM1Yre7CxpuWkyp1sAi7CNDqYC4yesE5okvtXol8rrjs07NCRZX+0x2HL5k33rw8AdxN
         8A3YPbCh9cfxvmdLSHSVJxmXWaKr1sMEy2NkqMnk0MlyVxdQ5OGrn6TYbaRNsASEd3CD
         +cmwAhogzvYW7/aWyMBLHTyT6P/Ew+2a89ML1E7G+3174vyJq0gPRu/TPeiMG0XFEPex
         m8iA==
X-Gm-Message-State: AOAM530RS2VvTN7HqcdRpv/KyrmmLm0NJWDIuT3gV0roj+bTGBS0cMSI
        CxI4QDt98ywSYQXNXvFS7+tp0tNOrgnUNMBtPkyP6v1Qx/k=
X-Google-Smtp-Source: ABdhPJy3sy+2A9ZD1wc1Kzr+6fhG3D+U+cxhCpIR+puggOQZjFanqmTMNKykSAzSBRiAiJ6o82y2nXuckf06PrZU78w=
X-Received: by 2002:a05:6000:10d0:b0:20d:7d3:9972 with SMTP id
 b16-20020a05600010d000b0020d07d39972mr12823052wrx.554.1653153971099; Sat, 21
 May 2022 10:26:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220512170008.1301613-1-xiehuan09@gmail.com> <20220512170008.1301613-2-xiehuan09@gmail.com>
 <20220522002541.85a32eecd48cfee550d9a47c@kernel.org>
In-Reply-To: <20220522002541.85a32eecd48cfee550d9a47c@kernel.org>
From:   Jeff Xie <xiehuan09@gmail.com>
Date:   Sun, 22 May 2022 01:25:58 +0800
Message-ID: <CAEr6+EDZo2i2etS50tQ1xUPYK3TPHtRQ_s-f13TVOpQXA6Pp+A@mail.gmail.com>
Subject: Re: [PATCH v10 1/4] trace: Add trace any kernel object
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Steven Rostedt <rostedt@goodmis.org>, mingo@redhat.com,
        Tom Zanussi <zanussi@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

Thanks  for your detailed review.

On Sat, May 21, 2022 at 11:25 PM Masami Hiramatsu <mhiramat@kernel.org> wro=
te:
>
> Hi Jeff,
>
> On Fri, 13 May 2022 01:00:05 +0800
> Jeff Xie <xiehuan09@gmail.com> wrote:
>
> > Introduce objtrace trigger to get the call flow by tracing any kernel
> > object in the function parameter.
> >
> > The objtrace trigger makes a list of the target object address from
> > the given event parameter, and records all kernel function calls
> > which has the object address in its parameter.
>
> Thank you for updating this. Please read my comments below
>
> [...]
> > +
> > +static bool object_exist(void *obj, struct trace_array *tr)
> > +{
> > +     int i, max;
> > +     struct objtrace_data *obj_data;
> > +
> > +     obj_data =3D get_obj_data(tr);
> > +     if (!obj_data)
> > +             return false;
> > +
> > +     max =3D atomic_read(&obj_data->num_traced_obj);
>
> max =3D READ_ONCE(&obj_data->num_traced_obj);
>  (see below)

Thanks, it is indeed more appropriate to use READ_ONCE in places like this =
;-)

>
> > +     smp_rmb();
> > +     for (i =3D 0; i < max; i++) {
> > +             if (obj_data->traced_obj[i].obj =3D=3D obj)
> > +                     return true;
> > +     }
> > +     return false;
> > +}
> > +
> > +static bool object_empty(struct trace_array *tr)
> > +{
> > +     struct objtrace_data *obj_data;
> > +
> > +     obj_data =3D get_obj_data(tr);
> > +     if (!obj_data)
> > +             return false;
> > +
> > +     return !atomic_read(&obj_data->num_traced_obj);
>
> return !READ_ONCE(&obj_data->num_traced_obj);
>  (see below)
>
> > +}
> > +
> > +static void set_trace_object(void *obj, struct trace_array *tr)
> > +{
> > +     unsigned long flags;
> > +     struct object_instance *obj_ins;
> > +     struct objtrace_data *obj_data;
> > +
> > +     if (in_nmi())
> > +             return;
> > +
> > +     if (!obj && object_exist(obj, tr))
> > +             return;
> > +
> > +     obj_data =3D get_obj_data(tr);
> > +     if (!obj_data)
> > +             return;
> > +
> > +     /* only this place has write operations */
> > +     raw_spin_lock_irqsave(&obj_data->obj_data_lock, flags);
> > +     if (atomic_read(&obj_data->num_traced_obj) =3D=3D MAX_TRACED_OBJE=
CT) {
>
> Since obj_data->num_traced_obj update is protected by obj_data->obj_data_=
lock,
> you don't need atomic operation. What you need is using READ_ONCE() to
> access the num_traced_obj outside of this protected area.

Thank you for your reminder, this atomic operation is indeed redundant.

> > +             trace_array_printk_buf(tr->array_buffer.buffer, _THIS_IP_=
,
> > +                             "object_pool is full, can't trace object:=
0x%px\n", obj);
> > +             goto out;
> > +     }
> > +     obj_ins =3D &obj_data->traced_obj[atomic_read(&obj_data->num_trac=
ed_obj)];
> > +     obj_ins->obj =3D obj;
> > +     obj_ins->tr =3D tr;
> > +     /* make sure the num_traced_obj update always appears after trace=
d_obj update */
> > +     smp_wmb();
> > +     atomic_inc(&obj_data->num_traced_obj);
> > +out:
> > +     raw_spin_unlock_irqrestore(&obj_data->obj_data_lock, flags);
> > +}
> > +
> [...]
> > +
> > +static int
> > +event_object_trigger_parse(struct event_command *cmd_ops,
> > +                    struct trace_event_file *file,
> > +                    char *glob, char *cmd, char *param_and_filter)
> > +{
> > +     struct event_trigger_data *trigger_data;
> > +     struct objtrace_trigger_data *obj_data;
> > +     struct ftrace_event_field *field;
> > +     char *objtrace_cmd, *arg;
> > +     char *param, *filter;
> > +     int ret;
> > +     bool remove;
> > +
> > +     remove =3D event_trigger_check_remove(glob);
> > +
> > +     /*
> > +      * separate the param and the filter:
> > +      * objtrace:add:OBJ[:COUNT] [if filter]
> > +      */
> > +     ret =3D event_trigger_separate_filter(param_and_filter, &param, &=
filter, true);
> > +     if (ret)
> > +             return ret;
> > +
> > +     objtrace_cmd =3D strsep(&param, ":");
> > +     if (!objtrace_cmd || strcmp(objtrace_cmd, "add")) {
> > +             pr_err("error objtrace command\n");
> > +             return -EINVAL;
> > +     }
> > +
> > +     arg =3D strsep(&param, ":");
> > +     if (!arg)
> > +             return -EINVAL;
> > +
> > +     field =3D trace_find_event_field(file->event_call, arg);
> > +     if (!field)
> > +             return -EINVAL;
> > +
> > +     if (field->size !=3D sizeof(void *)) {
> > +             pr_err("the size of the %s should be:%ld\n", field->name,=
 sizeof(void *));
> > +             return -EINVAL;
> > +     }
> > +
> > +     if (remove && !field_exist(file, cmd_ops, field->name))
> > +             return -EINVAL;
>
> This may return -ENOENT.

It would be better indeed to use -ENOENT ;-)

> > +
> > +     obj_data =3D kzalloc(sizeof(*obj_data), GFP_KERNEL);
> > +     if (!obj_data)
> > +             return -ENOMEM;
> > +
> > +     obj_data->field =3D field;
> > +     obj_data->tr =3D file->tr;
> > +     snprintf(obj_data->objtrace_cmd, OBJTRACE_CMD_LEN, objtrace_cmd);
>
> If objtrace_cmd is fixed command string, can you make this a flag, like
> OBJTRACE_CMD_ADD.

Yes I can use a  macro to define the "add" OBJTRACE_CMD:
#define OBJTRACE_CMD_ADD "add"

> > +
> > +     trigger_data =3D event_trigger_alloc(cmd_ops, cmd, param, obj_dat=
a);
> > +     if (!trigger_data) {
> > +             kfree(obj_data);
> > +             return -ENOMEM;
> > +     }
> > +     if (remove) {
> > +             event_trigger_unregister(cmd_ops, file, glob+1, trigger_d=
ata);
> > +             kfree(obj_data);
> > +             kfree(trigger_data);
> > +             return 0;
> > +     }
> > +
> > +     ret =3D event_trigger_parse_num(param, trigger_data);
> > +     if (ret)
> > +             goto out_free;
> > +
> > +     ret =3D event_trigger_set_filter(cmd_ops, file, filter, trigger_d=
ata);
> > +     if (ret < 0)
> > +             goto out_free;
> > +
> > +     ret =3D event_trigger_register(cmd_ops, file, glob, trigger_data)=
;
> > +     if (ret)
> > +             goto out_free;
> > +
> > +     return ret;
> > +
> > + out_free:
> > +     event_trigger_reset_filter(cmd_ops, trigger_data);
> > +     kfree(obj_data);
> > +     kfree(trigger_data);
> > +     return ret;
> > +}
> > +
> > +static struct event_command trigger_object_cmd =3D {
> > +     .name                   =3D "objtrace",
> > +     .trigger_type           =3D ETT_TRACE_OBJECT,
> > +     .flags                  =3D EVENT_CMD_FL_NEEDS_REC,
> > +     .parse                  =3D event_object_trigger_parse,
> > +     .reg                    =3D register_trigger,
> > +     .unreg                  =3D unregister_trigger,
> > +     .get_trigger_ops        =3D objecttrace_get_trigger_ops,
> > +     .set_filter             =3D set_trigger_filter,
> > +};
> > +
> > +__init int register_trigger_object_cmd(void)
> > +{
> > +     int ret;
> > +
> > +     ret =3D register_event_command(&trigger_object_cmd);
> > +     WARN_ON(ret < 0);
> > +
> > +     return ret;
> > +}
> > +
> > +int allocate_objtrace_data(struct trace_array *tr)
> > +{
> > +     struct objtrace_data *obj_data;
> > +     struct ftrace_ops *fops;
> > +
> > +     obj_data =3D kzalloc(sizeof(*obj_data), GFP_KERNEL);
> > +     if (!obj_data)
> > +             return -ENOMEM;
> > +
> > +     tr->obj_data =3D obj_data;
>
> I suggest to move this line after initializing all field in
> the obj_data.

Thanks ,Indeed it is better to move it after initializing all fields
in the obj_data ;-)

> > +     obj_data->tr =3D tr;
> > +     fops =3D &obj_data->fops;
> > +     fops->func =3D trace_object_events_call;
> > +     fops->flags =3D FTRACE_OPS_FL_SAVE_REGS;
> > +     fops->private =3D tr;
> > +
> > +     raw_spin_lock(&obj_data->obj_data_lock);
>
> You don't need to lock this spinlock becuase this data structure
> is not used yet. Also, you need to initialize the lock with
> __RAW_SPIN_LOCK_UNLOCKED() macro.

Thanks, I will remove the spinlock from here,
maybe it is better to use raw_spin_lock_init(&obj_data->obj_data_lock)
instead of
__RAW_SPIN_LOCK_UNLOCKED(obj_data->obj_data_lock)

The compiler will report warning if we use the __RAW_SPIN_LOCK_UNLOCKED

<compile warning>
kernel/trace/trace_object.c: In function =E2=80=98allocate_objtrace_data=E2=
=80=99:
./include/linux/spinlock_types_raw.h:69:2: warning: value computed is
not used [-Wunused-value]
   69 |  (raw_spinlock_t) __RAW_SPIN_LOCK_INITIALIZER(lockname)
      |  ^
kernel/trace/trace_object.c:422:2: note: in expansion of macro
=E2=80=98__RAW_SPIN_LOCK_UNLOCKED=E2=80=99
  422 |  __RAW_SPIN_LOCK_UNLOCKED(obj_data->obj_data_lock);
</compile warning>

> > +     list_add(&obj_data->head, &obj_data_head);
> > +     raw_spin_unlock(&obj_data->obj_data_lock);
> > +     return 0;
> > +}
>
>
> Thank you,
>
>
> --
> Masami Hiramatsu <mhiramat@kernel.org>

Thanks,
JeffXie
