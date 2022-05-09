Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D07051F2AD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 04:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231174AbiEICeu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 22:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbiEICdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 22:33:55 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A4E6A405
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 19:30:03 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id bx33so4540359ljb.12
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 19:30:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=aOqAH8EMRjVpA1a72/5SVwGW2X9uIBefNDSxrS6QvxY=;
        b=RiQzn7HXpJor/Kk7f+IbvS8/Ia1NLRkgHesdvo/jp5iBbC0sfCsp9iuH/HDp1j4Vst
         XJlkwd6M2sRH/hjaAaqjFHB/o3KovIS54UD5eFH+OT9uCEECh+RDuTPXM7BaTYWDvT/H
         tjafyQsRMkQ1c5C2DC5w7sScceoKVpJSheburkZSxsKKDjOYNMyyb6llccQiyD8j/SG4
         5MzDXhW18brbiNuFaGPIbLB9Vl0/LeCN0WsFwlUtjT2z53vDXciULRg9h6ZN1e22gok0
         FNbtwf7o/wVtH2qqacIbh9HAHEONNyDfnwHcVgCYjRzWH13SizKx6rFBCr2CsTrui3qv
         yCUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=aOqAH8EMRjVpA1a72/5SVwGW2X9uIBefNDSxrS6QvxY=;
        b=U/b3FF5KVKAhJjv5kXKWCHvUWZngoqN6NJoGvkMXdA1vd5ULw589BqFnzKumd2uUv5
         rJb/pMBBwK4+8nIYc6XuXcN0vTsA/ZtkNNsouGA0Mtoco0Cg/0wui3MnxjiLuYDP4YpV
         p/g99JcfOb6Yo9ygJKHYKlDhQs4CmnKidw7Ev0Ox57REoEziElwNoPdjoDf5Xe4nIoWL
         YxZCSyrjiRicoYcGFh0QeNUNG8zRwtUCMTkpvNEmN/yLnyd80iqEBarw9SP5eJJmFWGI
         X/jZQ6F/Xn8PKfSQKzzYxJ+UxDi7n8GN9YHbCvO9yjWavg61VtNoL+O3AovP0lRr4ipI
         mRLg==
X-Gm-Message-State: AOAM532t8dNoDM2RlJAwqjeRQ0L8ETXDBg7dTKvar16Tv+ONCTBdVFsQ
        a1vzM4WeeilF+doghZQtbkbgpwUbksBtRstWl9M=
X-Google-Smtp-Source: ABdhPJytVI5YzfmMJuaCKlSgVixiRXRP61Qm8MWckRnAOGqK8p27WEzNUizDYexyOtCGNVixrKxzQ1NCBwHQfOZglrQ=
X-Received: by 2002:a2e:a0c9:0:b0:24f:2a8e:8002 with SMTP id
 f9-20020a2ea0c9000000b0024f2a8e8002mr9034257ljm.355.1652063401751; Sun, 08
 May 2022 19:30:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220420135127.o7ttm5tddwvwrp2a@airbuntu> <CAB8ipk-tWjkeAbV=BDhNy04Yq6rdLf80x_7twuLV=HqT4nc1+w@mail.gmail.com>
 <20220421161509.asz25zmh25eurgrk@airbuntu> <CAB8ipk_rZnwDrMaY-zJxR3pByYWD1XOP2waCgU9DZzQNpCN2zA@mail.gmail.com>
 <20220425161209.ydugtrs3b7gyy3kk@airbuntu> <CAB8ipk9hZXDcTV3hakRV+dE5dwKtg-Ka93WZ60ds0=4ErN1-0w@mail.gmail.com>
 <20220426092142.lppfj5eqgt3d24nb@airbuntu> <CAB8ipk_tM8WhZOLwURkqyi5XDSNJ=twOg1Zub=dsTB_b9N9BRg@mail.gmail.com>
 <20220427105844.otru4yohja4s23ye@wubuntu> <CAB8ipk-QAE2_J_kpUVRcq-4KJ0cSGc1JT2oQhdzvrjDu25HsRQ@mail.gmail.com>
 <20220503144352.lxduzhl6jq6xdhw2@airbuntu>
In-Reply-To: <20220503144352.lxduzhl6jq6xdhw2@airbuntu>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Mon, 9 May 2022 10:29:50 +0800
Message-ID: <CAB8ipk--Y8HxetcmUhBmtWq6Mmd726QmDbcbibGLERJw_PUqkQ@mail.gmail.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais

Sorry for the late reply.

On Tue, May 3, 2022 at 10:43 PM Qais Yousef <qais.yousef@arm.com> wrote:
>
> Hi Xuewen
>
> On 05/01/22 11:20, Xuewen Yan wrote:
> > Hi Qais
> > Thanks for the patient explanation.:)
> > And I have some other concerns.
> >
> > On Wed, Apr 27, 2022 at 6:58 PM Qais Yousef <qais.yousef@arm.com> wrote=
:
> > >
> > > On 04/27/22 09:38, Xuewen Yan wrote:
> > > > > > > The best (simplest) way forward IMHO is to introduce a new fu=
nction
> > > > > > >
> > > > > > >         bool cpu_in_capacity_inversion(int cpu);
> >
> > Maybe the implementation of this function, I have not thought of a
> > good solution.
> > (1)how to define the inversion, if the cpu has two
> > cluster(little/big)=EF=BC=8Cit is easy, but still need mark which is th=
e big
> > cpu...
>
> I'd define it as:
>
>         capacity_orig_of(cpu) - thermal_pressure(cpu) < capacity_orig_of(=
next_level_cpu)
ok.
>
> > (2)because the mainline kernel should be common, if the cpu has three
> > or more clusters, maybe the mid cpus also would be inversion;
>
> Yes. I pray this is highly unlikely though! We should cater for it still.
>
> > (3)what time update the cpu inversion state, if we judge the cpu
> > inversion whenever the thermal pressure changed, could we receive the
> > complexity? because may we should traverse all possible cpu.
>
> In my head, it would make sense to detect the inversion in
> update_cpu_capacity() OR in topology_update_thermal_pressure(). So at wha=
tever
> rate this happens at.
>
> Does this answer your question?
Yes, get.
>
> Basically I believe something like this should be enough (completely unte=
sted)
>
> --->8---
>
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a68482d66535..44c7c2598d87 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8399,16 +8399,37 @@ static unsigned long scale_rt_capacity(int cpu)
>
>  static void update_cpu_capacity(struct sched_domain *sd, int cpu)
>  {
> +       unsigned long capacity_orig =3D arch_scale_cpu_capacity(cpu);
>         unsigned long capacity =3D scale_rt_capacity(cpu);
>         struct sched_group *sdg =3D sd->groups;
> +       struct rq *rq =3D cpu_rq(cpu);
>
> -       cpu_rq(cpu)->cpu_capacity_orig =3D arch_scale_cpu_capacity(cpu);
> +       rq->cpu_capacity_orig =3D capacity_orig;
>
>         if (!capacity)
>                 capacity =3D 1;
>
> -       cpu_rq(cpu)->cpu_capacity =3D capacity;
> -       trace_sched_cpu_capacity_tp(cpu_rq(cpu));
> +       rq->cpu_capacity =3D capacity;
> +       trace_sched_cpu_capacity_tp(rq);
> +
> +       if (static_branch_unlikely(&sched_asym_cpucapacity)) {
> +               unsigned long inv_cap =3D capacity_orig - thermal_load_av=
g(rq);

Indeed, I prefer arch_thermal_pressure here, because the
thermal_load_avg would change over time,
but the inv_cap's update period may could not keep up with his changes.

> +
> +               rq->cpu_capacity_inverted =3D 0;
> +
> +               for_each_possible_cpu(cpu) {
> +                       unsigned long cap =3D arch_scale_cpu_capacity(cpu=
);
> +
> +                       if (capacity_orig <=3D cap)
> +                               continue;
> +
> +                       if (cap > inv_cap) {
> +                               rq->cpu_capacity_inverted =3D inv_cap;
> +                               break;
> +                       }
> +               }
> +
> +       }
>
>         sdg->sgc->capacity =3D capacity;
>         sdg->sgc->min_capacity =3D capacity;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 8dccb34eb190..bfe84c870bf9 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -992,6 +992,7 @@ struct rq {
>
>         unsigned long           cpu_capacity;
>         unsigned long           cpu_capacity_orig;
> +       unsigned long           cpu_capacity_inverted;
>
>         struct callback_head    *balance_callback;
>
> @@ -2807,6 +2808,11 @@ static inline unsigned long capacity_orig_of(int c=
pu)
>         return cpu_rq(cpu)->cpu_capacity_orig;
>  }
>
> +static inline unsigned long cpu_in_capacity_inversion(int cpu)
> +{
> +       return cpu_rq(cpu)->cpu_capacity_inverted;
> +}
> +
>  /**
>   * enum cpu_util_type - CPU utilization type
>   * @FREQUENCY_UTIL:    Utilization used to select frequency
>
>
> --->8---

The patch is amazing for me, and the complexity is not too high. Would
you please push the patch?
I think the idea is yours, I don't want to use it as my patch v2.

Thanks!

---
xuewen
