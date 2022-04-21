Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 516F3509A5F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 10:17:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386438AbiDUILA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 04:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234982AbiDUIK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:10:58 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADE111DA6A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:08:09 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id bu29so7338939lfb.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 01:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=rrUr8pCwMnZASFwlEU1kfIHgDb0S6l99gX5CPcZ1OQU=;
        b=aSEzcV3gWhDHup1OHoBLBr86XEk7ihbYfzPgLpia22REJ6B6wF6XfPYsiRCKplWyLT
         pQzNagzoJKaYxWLA9d0S/A+Ou4a0j3Ifk2p5EpKGxGzNrtW0+xwMDHpWtAnWOhYj+n14
         cjI/ztUbDm9WbGYAP0lMsNxinlyDmKXlXWvyV23mCtChQjUWxW/C1wekVek7fZgFYRPC
         ll2YmSMIauhKjge4lY8YCGsZ8z4a2fG9sdwyT7Aq3RiXTfvz5P7WW1jPA8F0ZBDGkhxu
         lzG5FLqu1jITPvfMwifW/O53ncXwDvZKvSBRMhDdiT+CAHZnOh59WKcYFhMrCkAYJWsm
         7dTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=rrUr8pCwMnZASFwlEU1kfIHgDb0S6l99gX5CPcZ1OQU=;
        b=AXmm1kyHitLx0/YkxvN18Cpbn53cc6tGSLoW9usI3VxaxlTJVtjNun8NB+F7QBsosa
         4tefmwehzNjfbRMhRx2dFHuGCw3lTtlCKWJJvnWP0Ot9gFwSjXDIpmLOdEdLbVgJ4PIG
         qpFeZe+IHsiBYh80JbHEigwO4dehdhzkDzwI5d1je7sd4iCgFV0aPaJ4xJSTIar1v4hA
         u5Kocp1IlbasouOw6QWzY/Bthf94xuNIbdDbnTxKJq3McnjYMPOWhF8G2wAbhtlhkdGZ
         h9Cq+MXVMifCvEXmLjqurdYcBebJX/O/5wgDc2jiyI7U+UZbonY83nJIdpfj7bYZQvAN
         6oyA==
X-Gm-Message-State: AOAM532VgT1d1hxdz/ZFt6bJ9J0bRlNBvMyW6ihdpHgnIzbrASK1XRkV
        2l8b2TOCOoGCHJ1aqQfHauesN/v2VSsM6QTcNCU=
X-Google-Smtp-Source: ABdhPJyNiCs3qq0KmxNAxXnpm+cnX6PU2r5BnYADWp+9TtQYbMAZRX/AP6VMNbF+utuFXJvHhzzg9tlhyzUGGXappis=
X-Received: by 2002:a05:6512:3193:b0:471:8eee:44d6 with SMTP id
 i19-20020a056512319300b004718eee44d6mr14199707lfe.439.1650528487067; Thu, 21
 Apr 2022 01:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220407051932.4071-1-xuewen.yan@unisoc.com> <20220420135127.o7ttm5tddwvwrp2a@airbuntu>
In-Reply-To: <20220420135127.o7ttm5tddwvwrp2a@airbuntu>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Thu, 21 Apr 2022 16:07:56 +0800
Message-ID: <CAB8ipk-tWjkeAbV=BDhNy04Yq6rdLf80x_7twuLV=HqT4nc1+w@mail.gmail.com>
Subject: Re: [PATCH] sched: Take thermal pressure into account when determine
 rt fits capacity
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>, dietmar.eggemann@arm.com,
        lukasz.luba@arm.com, rafael@kernel.org, viresh.kumar@linaro.org,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        di.shen@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais

On Wed, Apr 20, 2022 at 9:51 PM Qais Yousef <qais.yousef@arm.com> wrote:
>
> Hi Xuewen
>
> Thanks for sending the patch. RT relationship with thermal pressure is an
> interesting topic :)
>
> On 04/07/22 13:19, Xuewen Yan wrote:
> > There are cases when the cpu max capacity might be reduced due to therm=
al.
> > Take into the thermal pressure into account when judge whether the rt t=
ask
> > fits the cpu. And when schedutil govnor get cpu util, the thermal press=
ure
> > also should be considered.
>
> It would help to explain the mode of failure you're seeing here. What are=
 you
> seeing?

I used in Android scenario, there are many RT processes in the
Android. I do not want to set the sched_uclamp_util_min_rt_default to
1024, it would make the power consumption very high.
I used a compromise method, setting the value of
sysctl_sched_uclamp_util_min_rt_default to be bigger than the small
core capacity but not so that the frequency of the big core becomes
very high.
But when there are there clusters on the soc, the big core's capacity
often become smaller than the middle core, when this happens, I want
the RT can run on the middle cores instead of the on the big core
always.
When consider the thermal pressure, it could relieve this phenomenon.
>
> >
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 1 +
> >  kernel/sched/rt.c                | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_sc=
hedutil.c
> > index 3dbf351d12d5..285ad51caf0f 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -159,6 +159,7 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu=
)
> >       struct rq *rq =3D cpu_rq(sg_cpu->cpu);
> >       unsigned long max =3D arch_scale_cpu_capacity(sg_cpu->cpu);
> >
> > +     max -=3D arch_scale_thermal_pressure(sg_cpu->cpu);
>
> Wouldn't this break the call to irq_scale_capacity() in effective_cpu_uti=
l()?
>
> >       sg_cpu->max =3D max;
> >       sg_cpu->bw_dl =3D cpu_bw_dl(rq);
> >       sg_cpu->util =3D effective_cpu_util(sg_cpu->cpu, cpu_util_cfs(sg_=
cpu->cpu), max,

It would destory the irq_scale_capacity, but indeed the cpu max
capacity has changed, is it better to use the real cpu caopacity?

                          max - irq
            U' =3D irq + --------- * U
                           max
I can't imagine how much of an impact this will have at the moment.

> > diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > index a32c46889af8..d9982ebd4821 100644
> > --- a/kernel/sched/rt.c
> > +++ b/kernel/sched/rt.c
> > @@ -466,6 +466,7 @@ static inline bool rt_task_fits_capacity(struct tas=
k_struct *p, int cpu)
> >       max_cap =3D uclamp_eff_value(p, UCLAMP_MAX);
> >
> >       cpu_cap =3D capacity_orig_of(cpu);
> > +     cpu_cap -=3D arch_scale_thermal_pressure(cpu);
>
> Hmm I'm not a fan of this. By default all RT tasks have uclamp_min =3D 10=
24 to
> keep the default behavior of the system running at max performance point.
>
> With this change, any tiny thermal pressure means all RT tasks will fail =
to fit
> on the biggest CPU. While this hint is not meant to be bullet proof, but =
it
> shouldn't break that easily either. The highest performance point will st=
ill be
> on this CPU. The only exception is capacity inversion where the bigs
> performance goes below the mediums' under severe thermal circumstances. B=
ut
> then there are 2 issues.
>
>         1. This patch doesn't help with this case. It simply reverts to p=
utting
>            tasks 'randomly' and  might still end up on this CPU. I can't =
see
>            how this is better.
>         2. If we are under such severe thermal pressure, then things must=
 be
>            falling over badly anyway and I'm not sure we can still satisf=
y the
>            perf requirements these tasks want anyway. Unless you're tryin=
g to
>            keep these CPUs less busy to alleviate thermal pressure? This =
patch
>            will not help achieving that either. Or I'm unable to see it i=
f it
>            does.

Yes=EF=BC=8CIt is the problem that would lead to, maybe it need more
consideration just like select the cpus which have min overutil.

>
> It'd be good to explain the problem you're seeing and how this patch help=
ed
> you.
>
> The only thing I can think of is that you have uclamp_min set to the medi=
um
> CPUs capacity but due to thermal pressure they might fail to run at highe=
st
> frequency hence by forcing them NOT to fit on mediums you essentially mak=
e them
> run on the bigs where they get a better chance of getting the perf they w=
ant.

Yes, I have change the uclamp_min of RT. and used in android phone
which soc has three clusters(small/middle/big). The scenario is as I
described earlier.

>
>
> Thanks
>
> --
> Qais Yousef
>
>
> >
> >       return cpu_cap >=3D min(min_cap, max_cap);
> >  }
> > --
> > 2.25.1
> >

Thnaks!

BR
xuewen
