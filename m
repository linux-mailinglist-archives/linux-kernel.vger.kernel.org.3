Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE064B8FB4
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 18:52:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237345AbiBPRw6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 12:52:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237266AbiBPRw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 12:52:56 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5176E17C124
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 09:52:43 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id u16so4557393ljk.2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 09:52:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BpmsRqZ38kgxy8qCzl8SSWs6AgylYRQgLC0As9lclAI=;
        b=G8wSsxorPDom69zH2wRTt7GILRIWsWVDFZ8U+ljuoSys8hvmZCXPreQXjdQ36o7gvD
         bPjp85S01eT748CHa0BBnk5Yb2hCf7JoKSPsszKNYGmeF6eA3r7o09DjY8CoPpyoxI3y
         K7ZdAZDHQUUZt69sF7wZ4qFhMQspKoBPg1nJcWdrjb3ffLoq4Slgsk1S6dKMugSfgmIZ
         Bli+8/75HBBHLQ7W5pDBDFDcjxRHXVkFLEvJzVWQ4vFcY5INVnlT2nhlluXDGXWBdXgB
         cRhNDmNun6widb3SUJAFZ5i2IjunVSAaoCnQCJP9eix3L/SWcleMxU/WQgLU2SrKAHc1
         7l6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BpmsRqZ38kgxy8qCzl8SSWs6AgylYRQgLC0As9lclAI=;
        b=hMNBXmn0coC+poBSzs7M2ESvxO9iPMlbfU4jkVd2aje30nZvXsyZDbtp+WqyeJqpS6
         Kro9O656j5nI/FzaAQzgh5XIIX0NlzJ7s217+t5E5kvbhKXfbw5YeLDlyhWOGHyBr8+7
         CupnDgtCmH2l/DYILrrZ91wAE/0oZfnk0av6lMEvkvnxqI/rPdJTphrsw3KpB5Seaje8
         GXYBqeKiFkOYDuwG81H/ayrv2i1YAMQknmDN6ntnYgqvFgJBT5Mw2JSDqbfg0IYL7g2n
         TkreNGz+mQZf700/J2IXbcM0rbbEp8fl39Kn471aYcf988YJK6LiB6PTtwAC62vTuRp8
         xzeg==
X-Gm-Message-State: AOAM532MXPwQYKxV7kOf8Y2m82bvx/9dSs3uyOz/KV7tEcNcL10NOThn
        Xx8gUIAMJJIvHJLpA2kSkyLGCrEZfmyfRy+7uqHbS7edtjuC8A==
X-Google-Smtp-Source: ABdhPJyVv+t9vmIJQE/u00gjSUVpwpbz1F0JLyk14F2rUJqd6Atn9YD1zHJA/NbAbtK3k1nv9YXoXtqJJFAtfK1DVU8=
X-Received: by 2002:a05:651c:986:b0:246:98f:9333 with SMTP id
 b6-20020a05651c098600b00246098f9333mr2862454ljq.381.1645033961453; Wed, 16
 Feb 2022 09:52:41 -0800 (PST)
MIME-Version: 1.0
References: <8c4a69eca4d0591f30c112df59c5098c24923bd3.1644543449.git.darren@os.amperecomputing.com>
 <ec9be4eb7a0548178191edd51ddd309f@hisilicon.com> <20220215163858.GA8458@willie-the-truck>
 <YgvYZy5xv1g+u5wp@fedora> <20220215164639.GC8458@willie-the-truck>
 <CAKfTPtAFsL+uqQiGcuh+JJZB=rPrez0=kotq76CVRcBQhcPefg@mail.gmail.com>
 <YgvjtsOZuxzbgBBl@fedora> <CAKfTPtCHrZCp1Uth4odyT721wE8zoNVY3Mh+DSyuTkqPafm0Hg@mail.gmail.com>
 <YgwHhxy/uGafQsak@fedora> <CAKfTPtAR2+bY8QpyaCCJfezsVkB62n8XZjL9c5_mPO3iyDnp4w@mail.gmail.com>
 <Yg0lULy5TmHKIHFv@fedora>
In-Reply-To: <Yg0lULy5TmHKIHFv@fedora>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 16 Feb 2022 18:52:29 +0100
Message-ID: <CAKfTPtB1Vt75ciX_V=8T3e5fgW-X7ybRk6VZvy4uXzjazjx9ZA@mail.gmail.com>
Subject: Re: [PATCH] arm64: smp: Skip MC domain for SoCs without shared cache
To:     Darren Hart <darren@os.amperecomputing.com>
Cc:     Will Deacon <will@kernel.org>,
        "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Arm <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <Catalin.Marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        "D . Scott Phillips" <scott@os.amperecomputing.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Feb 2022 at 17:24, Darren Hart <darren@os.amperecomputing.com> wrote:
>
> On Wed, Feb 16, 2022 at 09:30:49AM +0100, Vincent Guittot wrote:
> > On Tue, 15 Feb 2022 at 21:05, Darren Hart <darren@os.amperecomputing.com> wrote:
> > >
> > > On Tue, Feb 15, 2022 at 07:19:45PM +0100, Vincent Guittot wrote:
> > > > On Tue, 15 Feb 2022 at 18:32, Darren Hart <darren@os.amperecomputing.com> wrote:
> > > > >
> > > > > On Tue, Feb 15, 2022 at 06:09:08PM +0100, Vincent Guittot wrote:
> > > > > > On Tue, 15 Feb 2022 at 17:46, Will Deacon <will@kernel.org> wrote:
> > > > > > >
> > > > > > > On Tue, Feb 15, 2022 at 08:44:23AM -0800, Darren Hart wrote:
> > > > > > > > On Tue, Feb 15, 2022 at 04:38:59PM +0000, Will Decon wrote:
> > > > > > > > > On Fri, Feb 11, 2022 at 03:20:51AM +0000, Song Bao Hua (Barry Song) wrote:
> > > > > > > > > >
> > > > > > > > > >
> > > > > > > > > > > -----Original Message-----
> > > > > > > > > > > From: Darren Hart [mailto:darren@os.amperecomputing.com]
> > > > > > > > > > > Sent: Friday, February 11, 2022 2:43 PM
> > > > > > > > > > > To: LKML <linux-kernel@vger.kernel.org>; Linux Arm
> > > > > > > > > > > <linux-arm-kernel@lists.infradead.org>
> > > > > > > > > > > Cc: Catalin Marinas <catalin.marinas@arm.com>; Will Deacon <will@kernel.org>;
> > > > > > > > > > > Peter Zijlstra <peterz@infradead.org>; Vincent Guittot
> > > > > > > > > > > <vincent.guittot@linaro.org>; Song Bao Hua (Barry Song)
> > > > > > > > > > > <song.bao.hua@hisilicon.com>; Valentin Schneider
> > > > > > > > > > > <valentin.schneider@arm.com>; D . Scott Phillips
> > > > > > > > > > > <scott@os.amperecomputing.com>; Ilkka Koskinen
> > > > > > > > > > > <ilkka@os.amperecomputing.com>; stable@vger.kernel.org
> > > > > > > > > > > Subject: [PATCH] arm64: smp: Skip MC domain for SoCs without shared cache
> > > > > > > > > > >
> > > > > > > > > > > SoCs such as the Ampere Altra define clusters but have no shared
> > > > > > > > > > > processor-side cache. As of v5.16 with CONFIG_SCHED_CLUSTER and
> > > > > > > > > > > CONFIG_SCHED_MC, build_sched_domain() will BUG() with:
> > > > > > > > > > >
> > > > > > > > > > > BUG: arch topology borken
> > > > > > > > > > >      the CLS domain not a subset of the MC domain
> > > > > > > > > > >
> > > > > > > > > > > for each CPU (160 times for a 2 socket 80 core Altra system). The MC
> > > > > > > > > > > level cpu mask is then extended to that of the CLS child, and is later
> > > > > > > > > > > removed entirely as redundant.
> > > > > > > > > > >
> > > > > > > > > > > This change detects when all cpu_coregroup_mask weights=1 and uses an
> > > > > > > > > > > alternative sched_domain_topology equivalent to the default if
> > > > > > > > > > > CONFIG_SCHED_MC were disabled.
> > > > > > > > > > >
> > > > > > > > > > > The final resulting sched domain topology is unchanged with or without
> > > > > > > > > > > CONFIG_SCHED_CLUSTER, and the BUG is avoided:
> > > > > > > > > > >
> > > > > > > > > > > For CPU0:
> > > > > > > > > > >
> > > > > > > > > > > With CLS:
> > > > > > > > > > > CLS  [0-1]
> > > > > > > > > > > DIE  [0-79]
> > > > > > > > > > > NUMA [0-159]
> > > > > > > > > > >
> > > > > > > > > > > Without CLS:
> > > > > > > > > > > DIE  [0-79]
> > > > > > > > > > > NUMA [0-159]
> > > > > > > > > > >
> > > > > > > > > > > Cc: Catalin Marinas <catalin.marinas@arm.com>
> > > > > > > > > > > Cc: Will Deacon <will@kernel.org>
> > > > > > > > > > > Cc: Peter Zijlstra <peterz@infradead.org>
> > > > > > > > > > > Cc: Vincent Guittot <vincent.guittot@linaro.org>
> > > > > > > > > > > Cc: Barry Song <song.bao.hua@hisilicon.com>
> > > > > > > > > > > Cc: Valentin Schneider <valentin.schneider@arm.com>
> > > > > > > > > > > Cc: D. Scott Phillips <scott@os.amperecomputing.com>
> > > > > > > > > > > Cc: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> > > > > > > > > > > Cc: <stable@vger.kernel.org> # 5.16.x
> > > > > > > > > > > Signed-off-by: Darren Hart <darren@os.amperecomputing.com>
> > > > > > > > > >
> > > > > > > > > > Hi Darrent,
> > > > > > > > > > What kind of resources are clusters sharing on Ampere Altra?
> > > > > > > > > > So on Altra, cpus are not sharing LLC? Each LLC is separate
> > > > > > > > > > for each cpu?
> > > > > > > > > >
> > > > > > > > > > > ---
> > > > > > > > > > >  arch/arm64/kernel/smp.c | 32 ++++++++++++++++++++++++++++++++
> > > > > > > > > > >  1 file changed, 32 insertions(+)
> > > > > > > > > > >
> > > > > > > > > > > diff --git a/arch/arm64/kernel/smp.c b/arch/arm64/kernel/smp.c
> > > > > > > > > > > index 27df5c1e6baa..0a78ac5c8830 100644
> > > > > > > > > > > --- a/arch/arm64/kernel/smp.c
> > > > > > > > > > > +++ b/arch/arm64/kernel/smp.c
> > > > > > > > > > > @@ -715,9 +715,22 @@ void __init smp_init_cpus(void)
> > > > > > > > > > >         }
> > > > > > > > > > >  }
> > > > > > > > > > >
> > > > > > > > > > > +static struct sched_domain_topology_level arm64_no_mc_topology[] = {
> > > > > > > > > > > +#ifdef CONFIG_SCHED_SMT
> > > > > > > > > > > +       { cpu_smt_mask, cpu_smt_flags, SD_INIT_NAME(SMT) },
> > > > > > > > > > > +#endif
> > > > > > > > > > > +
> > > > > > > > > > > +#ifdef CONFIG_SCHED_CLUSTER
> > > > > > > > > > > +       { cpu_clustergroup_mask, cpu_cluster_flags, SD_INIT_NAME(CLS) },
> > > > > > > > > > > +#endif
> > > > > > > > > > > +       { cpu_cpu_mask, SD_INIT_NAME(DIE) },
> > > > > > > > > > > +       { NULL, },
> > > > > > > > > > > +};
> > > > > > > > > > > +
> > > > > > > > > > >  void __init smp_prepare_cpus(unsigned int max_cpus)
> > > > > > > > > > >  {
> > > > > > > > > > >         const struct cpu_operations *ops;
> > > > > > > > > > > +       bool use_no_mc_topology = true;
> > > > > > > > > > >         int err;
> > > > > > > > > > >         unsigned int cpu;
> > > > > > > > > > >         unsigned int this_cpu;
> > > > > > > > > > > @@ -758,6 +771,25 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
> > > > > > > > > > >
> > > > > > > > > > >                 set_cpu_present(cpu, true);
> > > > > > > > > > >                 numa_store_cpu_info(cpu);
> > > > > > > > > > > +
> > > > > > > > > > > +               /*
> > > > > > > > > > > +                * Only use no_mc topology if all cpu_coregroup_mask weights=1
> > > > > > > > > > > +                */
> > > > > > > > > > > +               if (cpumask_weight(cpu_coregroup_mask(cpu)) > 1)
> > > > > > > > > > > +                       use_no_mc_topology = false;
> > > > > > > > > >
> > > > > > > > > > This seems to be wrong? If you have 5 cpus,
> > > > > > > > > > Cpu0 has cpu_coregroup_mask(cpu)== 1, cpu1-4
> > > > > > > > > > has cpu_coregroup_mask(cpu)== 4, for cpu0, you still
> > > > > > > > > > need to remove MC, but for cpu1-4, you will need
> > > > > > > > > > CLS and MC both?
> > > > > > > > >
> > > > > > > > > What is the *current* behaviour on such a system?
> > > > > > > > >
> > > > > > > >
> > > > > > > > As I understand it, any system that uses the default topology which has
> > > > > > > > a cpus_coregroup weight of 1 and a child (cluster, smt, ...) weight > 1
> > > > > > > > will behave as described above by printing the following for each CPU
> > > > > > > > matching this criteria:
> > > > > > > >
> > > > > > > >   BUG: arch topology borken
> > > > > > > >         the [CLS,SMT,...] domain not a subset of the MC domain
> > > > > > > >
> > > > > > > > And then extend the MC domain cpumask to match that of the child and continue
> > > > > > > > on.
> > > > > > > >
> > > > > > > > That would still be the behavior for this type of system after this
> > > > > > > > patch is applied.
> > > > > > >
> > > > > > > That's what I thought, but in that case applying your patch is a net
> > > > > > > improvement: systems either get current or better behaviour.
> > > > > >
> > > > > > CLUSTER level is normally defined as a intermediate group of the MC
> > > > > > level and both levels have the scheduler flag SD_SHARE_PKG_RESOURCES
> > > > > > flag
> > > > > >
> > > > > > In the case of Ampere altra, they consider that CPUA have a CLUSTER
> > > > > > level which SD_SHARE_PKG_RESOURCES with another CPUB but the next and
> > > > > > larger MC level then says that CPUA doesn't SD_SHARE_PKG_RESOURCES
> > > > > > with CPUB which seems to be odd because the SD_SHARE_PKG_RESOURCES has
> > > > > > not disappeared Looks like there is a mismatch in topology description
> > > > >
> > > > > Hi Vincent,
> > > > >
> > > > > Agree. Where do you think this mismatch exists?
> > > >
> > > > I think that the problem comes from that the default topology order is
> > > > assumed to be :
> > > > SMT
> > > > CLUSTER shares pkg resources i.e. cache
> > > > MC
> > > > DIE
> > > > NUMA
> > > >
> > > > but in your case, you want a topology order like :
> > > > SMT
> > > > MC
> > > > CLUSTER shares SCU
> > > > DIE
> > > > NUMA
> > >
> > > Given the fairly loose definition of some of these domains and the
> > > freedom to adjust flags with custom topologies, I think it's difficult
> > > to say it needs to be this or that. As you point out, this stems from an
> > > assumption in the default topology, so eliding the MC level within the
> > > current set of abstractions for a very targeted topology still seems
> > > reasonable to address the BUG in the very near term in a contained way.
> >
> > But if another SoC comes with a valid MC then a CLUSTER, this proposal
> > will not work.
> >
> > Keep in mind that the MC level will be removed/degenerate when
> > building because it is useless in your case so the scheduler topology
> > will still be the same at the end but it will support more case. That
> > why I think you should keep MC level
>
> Hi Vincent,
>
> Thanks for reiterating, I don't think I quite understood what you were
> suggesting before. Is the following in line with what you were thinking?
>
> I am testing a version of this patch which uses a topology like this instead:
>
> MC
> CLS
> DIE
> NUMA
>
> (I tested without an SMT domain since the trigger is still MC weight==1, so
> there is no valid topology that includes an SMT level under these conditions).
>
> Which results in no BUG output and a final topology on Altra of:
>
> CLS
> DIE
> NUMA
>
> Which so far seems right (I still need to do some testing and review the sched
> debug data).
>
> If we take this approach, I think to address your concern about other systems
> with valid MCs, we would need a different trigger that MC weight == 1 to use
> this alternate topology. Do you have a suggestion on what to trigger this on?

AFAICT, this CLUSTER level is only supported by ACPI. In
parse_acpi_topology() you should be able to know if cluster level is
above or below the level returned by acpi_find_last_cache_level() and
set the correct topology table accordingly

>
> Thanks,
>
> --
> Darren Hart
> Ampere Computing / OS and Kernel
