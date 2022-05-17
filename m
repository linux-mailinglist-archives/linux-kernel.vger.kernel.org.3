Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 451205296FA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 03:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231899AbiEQBzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 21:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiEQBzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 21:55:47 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB726393
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 18:55:44 -0700 (PDT)
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1652752542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qWnQ9OrgLIwprkIDdC4PTPjMfgbKUDA+HIW5i6AMBQs=;
        b=XFjkeLjxacmUdB7EKOn88jPcXfZvszzOrlfUcJ1xFf8sydA1UyNR5Iybn7izIqLr87sEg2
        E44Ho8EHz1L65XcRz2v5NcDxdwYSPfSNgaXI9joXEi93L1A+DlTgQnylxU8P6GCFf49XIn
        Xnxw93uguKbimwLqmTHWRu7pVlvMFBU=
Date:   Tue, 17 May 2022 01:55:41 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   "Yajun Deng" <yajun.deng@linux.dev>
Message-ID: <fdfc0c8f6027c2071674d52f27f7d7da@linux.dev>
Subject: Re: [PATCH v2] sched/rt: fix the case where sched_rt_period_us is
 negative
To:     "Valentin Schneider" <vschneid@redhat.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org
In-Reply-To: <xhsmhmtfh1ptb.mognet@vschneid.remote.csb>
References: <xhsmhmtfh1ptb.mognet@vschneid.remote.csb>
 <20220512003945.610093-1-yajun.deng@linux.dev>
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

May 16, 2022 11:04 PM, "Valentin Schneider" <vschneid@redhat.com> wrote:=
=0A=0A> On 12/05/22 08:39, Yajun Deng wrote:=0A> =0A>> The proc_dointvec(=
) is for integer, but sysctl_sched_rt_period is a=0A>> unsigned integer, =
proc_dointvec() would convert negative number into=0A>> positive number. =
So both proc_dointvec() and sched_rt_global_validate()=0A>> aren't return=
 error even if we set a negative number.=0A>> =0A>> Use proc_dointvec_min=
max() instead of proc_dointvec() and use extra1=0A>> limit the minimum va=
lue for sched_rt_period_us/sched_rt_runtime_us.=0A>> =0A>> Fixes: 391e43d=
a797a ("sched: Move all scheduler bits into kernel/sched/")=0A> =0A> That=
's just the last apparent change of the incriminated variable. AFAICT=0A>=
 the issue stems from:=0A> =0A> - sysctl_sched_rt_period being unsigned i=
nt=0A> - the ctl entry using proc_dointvec()=0A> - the bounds check on sy=
sctl_sched_rt_period being just <=3D 0 which doesn't=0A> actually respect=
 the [1, INT_MAX] stated in=0A> Documentation/scheduler/sched-rt-group.rs=
t=0A> =0A> The <=3D thing was added by:=0A> =0A> ec5d498991e8 ("sched: fi=
x deadlock in setting scheduler parameter to zero")=0A> =0A> but AFAICT t=
he unsigned int vs proc_dointvec() thing dates back to:=0A> =0A> d0b27fa7=
7854 ("sched: rt-group: synchonised bandwidth period")=0A> =0A=0AI know t=
hat, but I didn't find out the source. Thank you for helping me find out =
it.=0A=0A>> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>=0A>> ---=0A>=
 =0A> In the absence of a cover letter (e.g. single-patch submission), th=
is is=0A> where you should write patch version changelogs (see=0A> Docume=
ntation/process).=0A> =0A=0AGot it, I will add it to the next version.=0A=
=0A>> kernel/sched/rt.c | 8 ++++----=0A>> 1 file changed, 4 insertions(+)=
, 4 deletions(-)=0A>> =0A>> diff --git a/kernel/sched/rt.c b/kernel/sched=
/rt.c=0A>> index b491a0f8c25d..3add32679885 100644=0A>> --- a/kernel/sche=
d/rt.c=0A>> +++ b/kernel/sched/rt.c=0A>> @@ -37,6 +37,7 @@ static struct =
ctl_table sched_rt_sysctls[] =3D {=0A>> .maxlen =3D sizeof(unsigned int),=
=0A>> .mode =3D 0644,=0A>> .proc_handler =3D sched_rt_handler,=0A>> + .ex=
tra1 =3D SYSCTL_ONE,=0A> =0A> Per earlier comment, the Documentation says=
 that this needs to be within=0A> [1, INT_MAX], which you do get by exclu=
ding negative values when casting to=0A> int...=0A> =0A> How about we mak=
e sysctl_sched_rt_period int on top of this, then all variables=0A> modif=
ied by the sched_rt_handler() proc_dointvec() are *actually* int, and=0A>=
 the upper bound requires less mental gymnastics to be figured out?=0A> =
=0A=0AYes, we can make sysctl_sched_rt_period int.=0A>> },=0A>> {=0A>> .p=
rocname =3D "sched_rt_runtime_us",=0A>> @@ -44,6 +45,8 @@ static struct c=
tl_table sched_rt_sysctls[] =3D {=0A>> .maxlen =3D sizeof(int),=0A>> .mod=
e =3D 0644,=0A>> .proc_handler =3D sched_rt_handler,=0A>> + .extra1 =3D S=
YSCTL_NEG_ONE,=0A>> + .extra2 =3D (void *)&sysctl_sched_rt_period,=0A> =
=0A> Per this, you could also remove the=0A> =0A> ((sysctl_sched_rt_runti=
me > sysctl_sched_rt_period) ||=0A> =0A> from sched_rt_global_validate(),=
 no?=0A>=0A=0ANo, the extra2 just limit the maximum value of sysctl_sched=
_rt_runtime is sysctl_sched_rt_period, but not limit the minimum value of=
 sysctl_sched_rt_period is sysctl_sched_rt_runtime. (sysctl_sched_rt_runt=
ime > sysctl_sched_rt_period) can do both. =0AIts purpose is to return er=
ror earlier. Perhaps I should remove extra2 to avoid ambiguity.=0A=0A>> }=
, =0A>> {=0A>> .procname =3D "sched_rr_timeslice_ms",=0A>> @@ -2959,9 +29=
62,6 @@ static int sched_rt_global_constraints(void)=0A>> #ifdef CONFIG_S=
YSCTL=0A>> static int sched_rt_global_validate(void)=0A>> {=0A>> - if (sy=
sctl_sched_rt_period <=3D 0)=0A>> - return -EINVAL;=0A>> -=0A>> if ((sysc=
tl_sched_rt_runtime !=3D RUNTIME_INF) &&=0A>> ((sysctl_sched_rt_runtime >=
 sysctl_sched_rt_period) ||=0A>> ((u64)sysctl_sched_rt_runtime *=0A>> @@ =
-2992,7 +2992,7 @@ static int sched_rt_handler(struct ctl_table *table, i=
nt write, void *buffer,=0A>> old_period =3D sysctl_sched_rt_period;=0A>> =
old_runtime =3D sysctl_sched_rt_runtime;=0A>> =0A>> - ret =3D proc_dointv=
ec(table, write, buffer, lenp, ppos);=0A>> + ret =3D proc_dointvec_minmax=
(table, write, buffer, lenp, ppos);=0A>> =0A>> if (!ret && write) {=0A>> =
ret =3D sched_rt_global_validate();=0A>> --=0A>> 2.25.1
