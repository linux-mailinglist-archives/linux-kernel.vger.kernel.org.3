Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA9050D691
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 03:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240169AbiDYBed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 21:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240159AbiDYBe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 21:34:26 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB248EB034
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 18:31:23 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id bq30so23659216lfb.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 18:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vs5yjC5aMxDQeowKyAD8x2QdpdAGTpph9BESKEnbR3c=;
        b=YT3hwAR7x9yuweoUhA350BV3T9MOhqj5Rx+mjg/VGYu1mC95jGPo3oUc1WA8rV0WEQ
         EGsj65G80DhefsKLDUwUydFzKGsVXSp+Qyij7sS3OKSsASVG747wYwRbgVvChcfzLDXT
         YmJLmlxGoiz6lud6oQ8C5JC4z59sfV3DiWLtjOIPdxwAWaJo84vB2NXwAqPwG/giwCrp
         UsDeHeVhoC0Sya91SFPkPAEcOzd/sriJ1MxCjEpS/cFRNttfiyHpRHCQNC6p/y67bx+6
         VJiAxzDn7D75DQkQ7FpqL2XSVnc2U5a6UFovkHPAIkfrUZ/NkEDv8lIRNEMZThJ3nC+D
         ZgkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vs5yjC5aMxDQeowKyAD8x2QdpdAGTpph9BESKEnbR3c=;
        b=t7GmOCIwbAGOTqPDSG4E5I6p+MPBLSTVdW1SZojJywi7xX2zaUqmsS+4T8VUmix99Z
         eVLKqzH2av5Y5eb4iEhWsBoXxr217huRHijxu79F9XrOYQJ9EB5Sscru1AVOUPCf6omY
         E5b8EVqTIhdjOxZEi0sUE+FSvv6hpjMHjk/PglXF+v5rguRI/eccfxIy3Mh1FqLtkTNh
         rz+uOBk7rBUCsIhkdoPdSOAiJkcxaqyxHQEqDF7xvAahlZmbAPi5mvry9Xgc66qKeqYz
         zNKN6QJvvdMGI7txuGvDYEIKIx4gNpeOW4Ha2dsbpfCMpTPeKv26dLp1VqpCEm45JSB2
         YiKg==
X-Gm-Message-State: AOAM532ynsSwODeXSCRllnewNHftceaO6bkrOdXjYySJ+eYB12eCveVt
        UhOYSSxmvCBvSD0FhON0iTABVHb76QaaYwyogoM=
X-Google-Smtp-Source: ABdhPJyS0acb22Ze+BmGM2xapv48dWL4D+SdC0YJuXonj+xx/n96q3/RHy5LqASW0bdwUl+dkShvfcc2WWxGcOmAHGs=
X-Received: by 2002:a05:6512:1382:b0:445:9536:903 with SMTP id
 p2-20020a056512138200b0044595360903mr11309198lfa.89.1650850282006; Sun, 24
 Apr 2022 18:31:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220407051932.4071-1-xuewen.yan@unisoc.com> <20220420135127.o7ttm5tddwvwrp2a@airbuntu>
 <CAB8ipk-tWjkeAbV=BDhNy04Yq6rdLf80x_7twuLV=HqT4nc1+w@mail.gmail.com> <20220421161509.asz25zmh25eurgrk@airbuntu>
In-Reply-To: <20220421161509.asz25zmh25eurgrk@airbuntu>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Mon, 25 Apr 2022 09:31:10 +0800
Message-ID: <CAB8ipk_rZnwDrMaY-zJxR3pByYWD1XOP2waCgU9DZzQNpCN2zA@mail.gmail.com>
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

On Fri, Apr 22, 2022 at 12:15 AM Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 04/21/22 16:07, Xuewen Yan wrote:
> > Hi Qais
> >
> > On Wed, Apr 20, 2022 at 9:51 PM Qais Yousef <qais.yousef@arm.com> wrote=
:
> > >
> > > Hi Xuewen
> > >
> > > Thanks for sending the patch. RT relationship with thermal pressure i=
s an
> > > interesting topic :)
> > >
> > > On 04/07/22 13:19, Xuewen Yan wrote:
> > > > There are cases when the cpu max capacity might be reduced due to t=
hermal.
> > > > Take into the thermal pressure into account when judge whether the =
rt task
> > > > fits the cpu. And when schedutil govnor get cpu util, the thermal p=
ressure
> > > > also should be considered.
> > >
> > > It would help to explain the mode of failure you're seeing here. What=
 are you
> > > seeing?
> >
> > I used in Android scenario, there are many RT processes in the
> > Android. I do not want to set the sched_uclamp_util_min_rt_default to
> > 1024, it would make the power consumption very high.
> > I used a compromise method, setting the value of
> > sysctl_sched_uclamp_util_min_rt_default to be bigger than the small
> > core capacity but not so that the frequency of the big core becomes
> > very high.
> > But when there are there clusters on the soc, the big core's capacity
> > often become smaller than the middle core, when this happens, I want
> > the RT can run on the middle cores instead of the on the big core
> > always.
> > When consider the thermal pressure, it could relieve this phenomenon.
>
> Thanks for the explanation. It's worth putting some of this in the change=
log in
> the next versions.
>
> So the problem is as I suspected, but capacity inversion is the major cau=
se of
> grief.
>
> Is it okay to share what the capacities of the littles, mediums and bigs =
on
> your system? And how they change under worst case scenario thermal pressu=
re?
> Only IF you have these numbers handy :-)

Okay, the little/mid/big cpu scale capacity is 350/930/1024, but the
cpu frequency point is discrete, the big core's high freq point may is
just a few more than the mid core's highest.
In this case, once the thermal decrease the scaling_max_freq, the
maximum frequency of the large core is easily lower than that of the
medium core.
Of course, the corner case is due to the frequency design of the soc
and  our thermal algorithm.

>
> Is it actually an indication of a potential other problem if you swing in=
to
> capacity inversion in the bigs that often? I've seen a lot of systems whe=
re the
> difference between the meds and bigs is small. But frequent inversion cou=
ld be
> suspicious still.
>
> Do the littles and the mediums experience any significant thermal pressur=
e too?

In our platform, it's not.

>
> > >
> > > >
> > > > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > > > ---
> > > >  kernel/sched/cpufreq_schedutil.c | 1 +
> > > >  kernel/sched/rt.c                | 1 +
> > > >  2 files changed, 2 insertions(+)
> > > >
> > > > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufre=
q_schedutil.c
> > > > index 3dbf351d12d5..285ad51caf0f 100644
> > > > --- a/kernel/sched/cpufreq_schedutil.c
> > > > +++ b/kernel/sched/cpufreq_schedutil.c
> > > > @@ -159,6 +159,7 @@ static void sugov_get_util(struct sugov_cpu *sg=
_cpu)
> > > >       struct rq *rq =3D cpu_rq(sg_cpu->cpu);
> > > >       unsigned long max =3D arch_scale_cpu_capacity(sg_cpu->cpu);
> > > >
> > > > +     max -=3D arch_scale_thermal_pressure(sg_cpu->cpu);
> > >
> > > Wouldn't this break the call to irq_scale_capacity() in effective_cpu=
_util()?
> > >
> > > >       sg_cpu->max =3D max;
> > > >       sg_cpu->bw_dl =3D cpu_bw_dl(rq);
> > > >       sg_cpu->util =3D effective_cpu_util(sg_cpu->cpu, cpu_util_cfs=
(sg_cpu->cpu), max,
> >
> > It would destory the irq_scale_capacity, but indeed the cpu max
> > capacity has changed, is it better to use the real cpu caopacity?
> >
> >                           max - irq
> >             U' =3D irq + --------- * U
> >                            max
> > I can't imagine how much of an impact this will have at the moment.
>
> It doesn't seem it'll cause a significant error, but still it seems to me=
 this
> function wants the original capacity passed to it.
>
> There are similar questions to be asked since you modify sg_cpu->max. Eve=
ry
> user needs to be audited if they're fine with this change or not.
>
> I'm not sure still what we are achieving here. You want to force scheduti=
l not
> to request higher frequencies if thermal pressure is high? Should schedut=
il
> actually care? Shouldn't the cpufreq driver reject this request and pick =
the
> next best thing if it can't satisfy it? I could be missing something, I h=
aven't
> looked that hard tbh :-)

I changed this just want to make it more responsive to the real
capacity of the cpu, if it will cause other problems, maybe it would
be better not to change it.:)

>
> >
> > > > diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > > > index a32c46889af8..d9982ebd4821 100644
> > > > --- a/kernel/sched/rt.c
> > > > +++ b/kernel/sched/rt.c
> > > > @@ -466,6 +466,7 @@ static inline bool rt_task_fits_capacity(struct=
 task_struct *p, int cpu)
> > > >       max_cap =3D uclamp_eff_value(p, UCLAMP_MAX);
> > > >
> > > >       cpu_cap =3D capacity_orig_of(cpu);
> > > > +     cpu_cap -=3D arch_scale_thermal_pressure(cpu);
> > >
> > > Hmm I'm not a fan of this. By default all RT tasks have uclamp_min =
=3D 1024 to
> > > keep the default behavior of the system running at max performance po=
int.
> > >
> > > With this change, any tiny thermal pressure means all RT tasks will f=
ail to fit
> > > on the biggest CPU. While this hint is not meant to be bullet proof, =
but it
> > > shouldn't break that easily either. The highest performance point wil=
l still be
> > > on this CPU. The only exception is capacity inversion where the bigs
> > > performance goes below the mediums' under severe thermal circumstance=
s. But
> > > then there are 2 issues.
> > >
> > >         1. This patch doesn't help with this case. It simply reverts =
to putting
> > >            tasks 'randomly' and  might still end up on this CPU. I ca=
n't see
> > >            how this is better.
> > >         2. If we are under such severe thermal pressure, then things =
must be
> > >            falling over badly anyway and I'm not sure we can still sa=
tisfy the
> > >            perf requirements these tasks want anyway. Unless you're t=
rying to
> > >            keep these CPUs less busy to alleviate thermal pressure? T=
his patch
> > >            will not help achieving that either. Or I'm unable to see =
it if it
> > >            does.
> >
> > Yes=EF=BC=8CIt is the problem that would lead to, maybe it need more
> > consideration just like select the cpus which have min overutil.
>
> It depends on the severity of the problem. The simplest thing I can sugge=
st is
> to check if the cpu is in capacity inversion state, and if it is, then ma=
ke
> rt_task_fits_capacity() return false always.
>
> If we need a generic solution to handle thermal pressure omitting OPPs, t=
hen
> the search needs to become more complex. The proposal in this patch is no=
t
> adequate because tasks that want to run at capacity_orig_of(cpu) will wro=
ngly
> omit some cpus because of any tiny thermal pressure. For example if the
> capacity_orig_of(medium_cpu) =3D 700, and uclamp_min for RT is set to 700=
, then
> any small thermal pressure on mediums will cause these tasks to run on bi=
g cpus
> only, which is not what we want. Especially if these big cpus can end up =
in
> capacity inversion later ;-)
>
> So if we want to handle this case, then we need to ensure the search retu=
rns
> false only if
>
>         1. Thermal pressure results in real OPP to be omitted.
>         2. Another CPU that can provide this performance level is availab=
le.
>
> Otherwise we should still fit it on this CPU because it'll give us the cl=
osest
> thing to what was requested.
>
> I can think of 2 ways to implement this, but none of them seem particular=
ly
> pretty :-/

Maybe as Lukasz Luba said:

https://lore.kernel.org/all/ae98a861-8945-e630-8d4c-8112723d1007@arm.com/

> Let's meet in the middle:
> 1) use the thermal PELT signal in RT:
> capacity =3D capacity_orig_of(cpu) - thermal_load_avg(cpu_rq(cpu))
> 2) introduce a more configurable thermal_pressure shifter instead
> 'sched_thermal_decay_shift', which would allow not only to make the
> decaying longer, but also shorter when the platform already might do
> that, to not cause too much traffic.

But even if this is changed, there will still be the same problem, I
look forward to Lukasz's patch:)

Thanks!
---
BR
xuewen

>
>
> Thanks
>
> --
> Qais Yousef
