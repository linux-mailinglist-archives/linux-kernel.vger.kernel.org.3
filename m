Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B83AE4EE4A8
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 01:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243052AbiCaXY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 19:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243028AbiCaXYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 19:24:49 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 509CC182AD3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 16:23:01 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id i16so2312410ejk.12
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 16:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5URM4SgaQnFXJASSglNI2e7JG/GOahWryKG5touFc5Y=;
        b=P0jMVNufouVhHkTaHwKUQN7c82OY+ci75sjKDuE3ebKbAPy8ywqirg+NrE8I+yrhkd
         m6cWoPTA1Eh+9/w7TU47iAMvFDu9KCsaJzhMoQEo8XXBxbaqJAJY8PCHBZGDCduNcz4m
         UtLAC07lN6A6j5ZkpfbtTO6IgOUGIdYuTC9Kn4X2usL47yPljgyPwKeiH4dtzJ+EPauG
         +GvYq/eLxST+5d/Tq27hF3tfBqpq5fDrl1V2Ht6YjTVsDRUiJ58BVxszxenZBYvMBO+b
         4KL/H1olIbgsvBMTvjZV1pduo72kF97O3Lu1yksI2cg/JtJJc1hJssN2xW3EMQh5V5MM
         gCaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=5URM4SgaQnFXJASSglNI2e7JG/GOahWryKG5touFc5Y=;
        b=xaVvHLJr8YJYXNick5KDmzHLPmiVwynWgSWRw/4JI2DZQEPM011XIoDHXx2htTmOGn
         CDbLfWLhZ1WzUAGO1lFH3Ylz3zuqhdOwahcV6qsEChMw7mlexz+MtFz0bsYgVHGeKJSA
         2kDCpX8Sg3QQlE8ZeN0AANfmKgyd9nTZDSk9FLwdbeYpsb0spYIEN3FB2Iz0Lp7xYGKv
         XHKWtVIaqvuLH8dibbCH/CRo6S7J3Jvsb+6Sygts+vVe1b9BdpDUPi51LUgbBqmHCVDC
         TYceO12f2ycvOT50Y/tRNjxbrhsNulEAyKAYsHnD1Y4D8Glz28BwKht2fJ+RbD9I4h5j
         GHaw==
X-Gm-Message-State: AOAM5321yJWoSsp3MvIXZtX/8+GM6uyTCAvWBv2UeVKWVaXm2qFMPyLe
        Tw6kRYAv6MJZlfXfPMRZoxU=
X-Google-Smtp-Source: ABdhPJwO+DwSepwoAY0mIWNyJ626iQgt1IXDw62oLLBJ6s6Lnd++nN0hWbngqfUT7UNjZL237ODjDg==
X-Received: by 2002:a17:906:c14b:b0:6da:b30d:76a0 with SMTP id dp11-20020a170906c14b00b006dab30d76a0mr6683267ejc.279.1648768979858;
        Thu, 31 Mar 2022 16:22:59 -0700 (PDT)
Received: from smtpclient.apple (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.gmail.com with ESMTPSA id gl2-20020a170906e0c200b006a767d52373sm305511ejb.182.2022.03.31.16.22.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Mar 2022 16:22:59 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH] ftrace: remove check of list iterator against head past
 the loop body
From:   Jakob Koschel <jakobkoschel@gmail.com>
In-Reply-To: <20220331191005.2954969f@gandalf.local.home>
Date:   Fri, 1 Apr 2022 01:22:58 +0200
Cc:     Ingo Molnar <mingo@redhat.com>, linux-kernel@vger.kernel.org,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Transfer-Encoding: quoted-printable
Message-Id: <212AE797-912E-47D1-9DC4-03B5351AFC57@gmail.com>
References: <20220331223752.902726-1-jakobkoschel@gmail.com>
 <20220331191005.2954969f@gandalf.local.home>
To:     Steven Rostedt <rostedt@goodmis.org>
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 1. Apr 2022, at 01:10, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Fri, 1 Apr 2022 00:37:52 +0200
> Jakob Koschel <jakobkoschel@gmail.com> wrote:
>=20
> Hi Jakob,
>=20
> The patch looks fine, I have some small nits though.
>=20
> First, the subject should actually be:
>=20
> Subject: [PATCH] tracing: Remove check of list iterator against head =
past the loop body
>=20
> Changes that only deal specifically with the function probes are =
labeled as
> "ftrace:", but the more generic changes that touches files outside of
> ftrace.c and fgraph.c should be "tracing:". Also, Linus prefers to =
have the
> next part of the subject start with a capital letter: "Remove" instead =
of
> "remove".

Thanks for the input. I've just seen that I have a few more changes that
I classified as 'tracing: *' so I'll bundle these up and resent =
altogether.

Also thanks for the advice on using a capital letter, I'll incorporate =
that.

>=20
>> When list_for_each_entry() completes the iteration over the whole =
list
>> without breaking the loop, the iterator value will be a bogus pointer
>> computed based on the head element.
>>=20
>> While it is safe to use the pointer to determine if it was computed
>> based on the head element, either with list_entry_is_head() or
>> &pos->member =3D=3D head, using the iterator variable after the loop =
should
>> be avoided.
>>=20
>> In preparation to limit the scope of a list iterator to the list
>> traversal loop, use a dedicated pointer to point to the found element =
[1].
>>=20
>> Link: =
https://lore.kernel.org/all/CAHk-=3DwgRr_D8CB-D9Kg-c=3DEHreAsk5SqXPwr9Y7k9=
sA6cWXJ6w@mail.gmail.com/ [1]
>> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
>> ---
>> kernel/trace/ftrace.c | 20 ++++++++++++--------
>> kernel/trace/trace_eprobe.c | 14 ++++++++------
>> kernel/trace/trace_events.c | 12 ++++++------
>> 3 files changed, 26 insertions(+), 20 deletions(-)
>>=20
>> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
>> index 4f1d2f5e7263..096f5a83358d 100644
>> --- a/kernel/trace/ftrace.c
>> +++ b/kernel/trace/ftrace.c
>> @@ -4560,8 +4560,8 @@ register_ftrace_function_probe(char *glob, =
struct trace_array *tr,
>> 			 struct ftrace_probe_ops *probe_ops,
>> 			 void *data)
>> {
>> +	struct ftrace_func_probe *probe =3D NULL, *iter;
>> 	struct ftrace_func_entry *entry;
>> -	struct ftrace_func_probe *probe;
>> 	struct ftrace_hash **orig_hash;
>> 	struct ftrace_hash *old_hash;
>> 	struct ftrace_hash *hash;
>> @@ -4580,11 +4580,13 @@ register_ftrace_function_probe(char *glob, =
struct trace_array *tr,
>>=20
>> 	mutex_lock(&ftrace_lock);
>> 	/* Check if the probe_ops is already registered */
>> -	list_for_each_entry(probe, &tr->func_probes, list) {
>> -		if (probe->probe_ops =3D=3D probe_ops)
>> +	list_for_each_entry(iter, &tr->func_probes, list) {
>> +		if (iter->probe_ops =3D=3D probe_ops) {
>> +			probe =3D iter;
>> 			break;
>> +		}
>> 	}
>> -	if (&probe->list =3D=3D &tr->func_probes) {
>> +	if (!probe) {
>> 		probe =3D kzalloc(sizeof(*probe), GFP_KERNEL);
>> 		if (!probe) {
>> 			mutex_unlock(&ftrace_lock);
>> @@ -4704,7 +4706,7 @@ unregister_ftrace_function_probe_func(char =
*glob, struct trace_array *tr,
>> {
>> 	struct ftrace_ops_hash old_hash_ops;
>> 	struct ftrace_func_entry *entry;
>> -	struct ftrace_func_probe *probe;
>> +	struct ftrace_func_probe *probe =3D NULL, *iter;
>=20
> Can you move this to the first declaration to keep the nice =
"upside-down
> x-mas tree" look.

Thanks, I'll fix that up. It seems like this is not applied on the =
entire kernel
making treewide changes a bit more difficult. Is it documented =
somewhere, which
parts of the kernel enforce this? Just looking two lines down from here =
it
seems to be 'broken' already so just from looking at existing code it's =
often
hard to judge.

>=20
>> 	struct ftrace_glob func_g;
>> 	struct ftrace_hash **orig_hash;
>> 	struct ftrace_hash *old_hash;
>> @@ -4732,11 +4734,13 @@ unregister_ftrace_function_probe_func(char =
*glob, struct trace_array *tr,
>>=20
>> 	mutex_lock(&ftrace_lock);
>> 	/* Check if the probe_ops is already registered */
>> -	list_for_each_entry(probe, &tr->func_probes, list) {
>> -		if (probe->probe_ops =3D=3D probe_ops)
>> +	list_for_each_entry(iter, &tr->func_probes, list) {
>> +		if (iter->probe_ops =3D=3D probe_ops) {
>> +			probe =3D iter;
>> 			break;
>> +		}
>> 	}
>> -	if (&probe->list =3D=3D &tr->func_probes)
>> +	if (!probe)
>> 		goto err_unlock_ftrace;
>>=20
>> 	ret =3D -EINVAL;
>> diff --git a/kernel/trace/trace_eprobe.c =
b/kernel/trace/trace_eprobe.c
>> index 541aa13581b9..63e901a28425 100644
>> --- a/kernel/trace/trace_eprobe.c
>> +++ b/kernel/trace/trace_eprobe.c
>> @@ -650,7 +650,7 @@ static struct trace_event_functions eprobe_funcs =
=3D {
>> static int disable_eprobe(struct trace_eprobe *ep,
>> 			 struct trace_array *tr)
>> {
>> -	struct event_trigger_data *trigger;
>> +	struct event_trigger_data *trigger =3D NULL, *iter;
>> 	struct trace_event_file *file;
>> 	struct eprobe_data *edata;
>>=20
>> @@ -658,14 +658,16 @@ static int disable_eprobe(struct trace_eprobe =
*ep,
>> 	if (!file)
>> 		return -ENOENT;
>>=20
>> -	list_for_each_entry(trigger, &file->triggers, list) {
>> -		if (!(trigger->flags & EVENT_TRIGGER_FL_PROBE))
>> +	list_for_each_entry(iter, &file->triggers, list) {
>> +		if (!(iter->flags & EVENT_TRIGGER_FL_PROBE))
>> 			continue;
>> -		edata =3D trigger->private_data;
>> -		if (edata->ep =3D=3D ep)
>> +		edata =3D iter->private_data;
>> +		if (edata->ep =3D=3D ep) {
>> +			trigger =3D iter;
>> 			break;
>> +		}
>> 	}
>> -	if (list_entry_is_head(trigger, &file->triggers, list))
>> +	if (!trigger)
>> 		return -ENODEV;
>>=20
>> 	list_del_rcu(&trigger->list);
>> diff --git a/kernel/trace/trace_events.c =
b/kernel/trace/trace_events.c
>> index e11e167b7809..fe3dc157e635 100644
>> --- a/kernel/trace/trace_events.c
>> +++ b/kernel/trace/trace_events.c
>> @@ -2281,7 +2281,7 @@ event_subsystem_dir(struct trace_array *tr, =
const char *name,
>> 		 struct trace_event_file *file, struct dentry *parent)
>> {
>> 	struct trace_subsystem_dir *dir;
>> -	struct event_subsystem *system;
>> +	struct event_subsystem *system, *iter;
>=20
> And move this above dir as well, for the same reason.
>=20
> Thanks,
>=20
> -- Steve
>=20
>=20
>> 	struct dentry *entry;
>>=20
>> 	/* First see if we did not already create this dir */
>> @@ -2295,13 +2295,13 @@ event_subsystem_dir(struct trace_array *tr, =
const char *name,
>> 	}
>>=20
>> 	/* Now see if the system itself exists. */
>> -	list_for_each_entry(system, &event_subsystems, list) {
>> -		if (strcmp(system->name, name) =3D=3D 0)
>> +	system =3D NULL;
>> +	list_for_each_entry(iter, &event_subsystems, list) {
>> +		if (strcmp(iter->name, name) =3D=3D 0) {
>> +			system =3D iter;
>> 			break;
>> +		}
>> 	}
>> -	/* Reset system variable when not found */
>> -	if (&system->list =3D=3D &event_subsystems)
>> -		system =3D NULL;
>>=20
>> 	dir =3D kmalloc(sizeof(*dir), GFP_KERNEL);
>> 	if (!dir)
>>=20
>> base-commit: f82da161ea75dc4db21b2499e4b1facd36dab275


	Jakob

