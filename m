Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA7B5AECDC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:30:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241877AbiIFORC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:17:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241755AbiIFOOK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:14:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E12276451;
        Tue,  6 Sep 2022 06:48:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B5A44B818E6;
        Tue,  6 Sep 2022 13:48:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A78C4347C;
        Tue,  6 Sep 2022 13:48:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662472125;
        bh=FHIjPd5BKv4MAOhHDsMeMElZ74o0YnibTtXT8vM+uC0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U4IHEsibZt7JfZryGJ5FvnwYZQBsKUIhaDjZrrlR8JQvYJDtT5vyoS12+wJKvJDWO
         ELZRC6tiznTrqj5QlhxqDFmPC/o6YWfzU9dQDOJLdG9hsdqJRueDemFCqe64XXo7A9
         DHfctYYEC/YeEKZ6HlA3hUR/WwaByg6h8wcagnnOzcZ9yTqP5WAUVyexru9oaKfjh4
         iZvwBwSAv4Uyw7BBIxWypCPVNHslYi9RZoCRBV3sFL1Fcsqc/dMNbmY8217rdRMvhA
         L2GPyQOzjwdZt5yk1D3jOLgWo7UdYATVU508nNRGIZKVXw4cyxj6qLj0dmT7XQJbeA
         uMibWg81feaig==
Received: by mail-vk1-f176.google.com with SMTP id m11so3198806vkk.4;
        Tue, 06 Sep 2022 06:48:45 -0700 (PDT)
X-Gm-Message-State: ACgBeo2VOIIpsNbm7+hwMq6JhOY+dtbqmb+1KdCZ4W0LRdoqs9b2UAcu
        OAE4WS4zoYFloR5tkfy2UsDUDLKLT906GLgX/Q==
X-Google-Smtp-Source: AA6agR5X2JZ8oDDucDNnvPGZOR3MD/7hDV56lV516kviHTMiP04D3om8kHuOA+lJH1c4/UF1/iY4qW5CFC/vqRzWvfc=
X-Received: by 2002:a1f:1d4d:0:b0:382:59cd:596c with SMTP id
 d74-20020a1f1d4d000000b0038259cd596cmr15566215vkd.35.1662472124307; Tue, 06
 Sep 2022 06:48:44 -0700 (PDT)
MIME-Version: 1.0
References: <20220825-arm-spe-v8-7-v1-0-c75b8d92e692@kernel.org>
 <20220825-arm-spe-v8-7-v1-3-c75b8d92e692@kernel.org> <b357cc19-8b3f-ef97-efb1-8e7a8f5b2b8b@arm.com>
In-Reply-To: <b357cc19-8b3f-ef97-efb1-8e7a8f5b2b8b@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 6 Sep 2022 08:48:33 -0500
X-Gmail-Original-Message-ID: <CAL_Jsq+BCrBe-qPaHA7LuhqSCO1PZo2uRHjC-CT_xgyVX4868w@mail.gmail.com>
Message-ID: <CAL_Jsq+BCrBe-qPaHA7LuhqSCO1PZo2uRHjC-CT_xgyVX4868w@mail.gmail.com>
Subject: Re: [PATCH RFC v1 3/3] perf: arm_spe: Add support for SPEv1.2
 inverted event filtering
To:     James Clark <james.clark@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 5, 2022 at 9:55 AM James Clark <james.clark@arm.com> wrote:
>
>
>
> On 25/08/2022 19:08, Rob Herring wrote:
> > Arm SPEv1.2 (Arm v8.7/v9.2) adds a new feature called Inverted Event
> > Filter which excludes samples matching the event filter. The feature
> > mirrors the existing event filter in PMSEVFR_EL1 adding a new register,
> > PMSNEVFR_EL1, which has the same event bit assignments.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> >
> > diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> > index 57904c11aece..9744da888818 100644
> > --- a/arch/arm64/include/asm/sysreg.h
> > +++ b/arch/arm64/include/asm/sysreg.h
> > @@ -258,6 +258,7 @@
> >  #define SYS_PMSIDR_EL1_ARCHINST_SHIFT        3
> >  #define SYS_PMSIDR_EL1_LDS_SHIFT     4
> >  #define SYS_PMSIDR_EL1_ERND_SHIFT    5
> > +#define SYS_PMSIDR_EL1_FNE_SHIFT     6
> >  #define SYS_PMSIDR_EL1_INTERVAL_SHIFT        8
> >  #define SYS_PMSIDR_EL1_INTERVAL_MASK 0xfUL
> >  #define SYS_PMSIDR_EL1_MAXSIZE_SHIFT 12
> > @@ -302,6 +303,7 @@
> >  #define SYS_PMSFCR_EL1_FE_SHIFT              0
> >  #define SYS_PMSFCR_EL1_FT_SHIFT              1
> >  #define SYS_PMSFCR_EL1_FL_SHIFT              2
> > +#define SYS_PMSFCR_EL1_FNE_SHIFT     3
> >  #define SYS_PMSFCR_EL1_B_SHIFT               16
> >  #define SYS_PMSFCR_EL1_LD_SHIFT              17
> >  #define SYS_PMSFCR_EL1_ST_SHIFT              18
> > diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
> > index a75b03b5c8f9..724409a88423 100644
> > --- a/drivers/perf/arm_spe_pmu.c
> > +++ b/drivers/perf/arm_spe_pmu.c
> > @@ -82,6 +82,7 @@ struct arm_spe_pmu {
> >  #define SPE_PMU_FEAT_ARCH_INST                       (1UL << 3)
> >  #define SPE_PMU_FEAT_LDS                     (1UL << 4)
> >  #define SPE_PMU_FEAT_ERND                    (1UL << 5)
> > +#define SPE_PMU_FEAT_INV_FILT_EVT            (1UL << 6)
> >  #define SPE_PMU_FEAT_DEV_PROBED                      (1UL << 63)
> >       u64                                     features;
> >
> > @@ -199,6 +200,10 @@ static const struct attribute_group arm_spe_pmu_cap_group = {
> >  #define ATTR_CFG_FLD_min_latency_LO          0
> >  #define ATTR_CFG_FLD_min_latency_HI          11
> >
> > +#define ATTR_CFG_FLD_inv_event_filter_CFG    config3 /* PMSNEVFR_EL1 */
> > +#define ATTR_CFG_FLD_inv_event_filter_LO     0
> > +#define ATTR_CFG_FLD_inv_event_filter_HI     63
> > +
> >  /* Why does everything I do descend into this? */
> >  #define __GEN_PMU_FORMAT_ATTR(cfg, lo, hi)                           \
> >       (lo) == (hi) ? #cfg ":" #lo "\n" : #cfg ":" #lo "-" #hi
> > @@ -229,6 +234,7 @@ GEN_PMU_FORMAT_ATTR(branch_filter);
> >  GEN_PMU_FORMAT_ATTR(load_filter);
> >  GEN_PMU_FORMAT_ATTR(store_filter);
> >  GEN_PMU_FORMAT_ATTR(event_filter);
> > +GEN_PMU_FORMAT_ATTR(inv_event_filter);
> >  GEN_PMU_FORMAT_ATTR(min_latency);
> >
> >  static struct attribute *arm_spe_pmu_formats_attr[] = {
> > @@ -240,12 +246,27 @@ static struct attribute *arm_spe_pmu_formats_attr[] = {
> >       &format_attr_load_filter.attr,
> >       &format_attr_store_filter.attr,
> >       &format_attr_event_filter.attr,
> > +     &format_attr_inv_event_filter.attr,
> >       &format_attr_min_latency.attr,
> >       NULL,
> >  };
> >
> > +static umode_t arm_spe_pmu_format_attr_is_visible(struct kobject *kobj,
> > +                                               struct attribute *attr,
> > +                                               int unused)
> > +     {
> > +     struct device *dev = kobj_to_dev(kobj);
> > +     struct arm_spe_pmu *spe_pmu = dev_get_drvdata(dev);
> > +
> > +     if (attr == &format_attr_inv_event_filter.attr && !(spe_pmu->features & SPE_PMU_FEAT_INV_FILT_EVT))
> > +             return 0;
> > +
> > +     return attr->mode;
> > +}
> > +
> >  static const struct attribute_group arm_spe_pmu_format_group = {
> >       .name   = "format",
> > +     .is_visible = arm_spe_pmu_format_attr_is_visible,
> >       .attrs  = arm_spe_pmu_formats_attr,
> >  };
> >
> > @@ -341,6 +362,9 @@ static u64 arm_spe_event_to_pmsfcr(struct perf_event *event)
> >       if (ATTR_CFG_GET_FLD(attr, event_filter))
> >               reg |= BIT(SYS_PMSFCR_EL1_FE_SHIFT);
> >
> > +     if (ATTR_CFG_GET_FLD(attr, inv_event_filter))
> > +             reg |= BIT(SYS_PMSFCR_EL1_FNE_SHIFT);
> > +
> >       if (ATTR_CFG_GET_FLD(attr, min_latency))
> >               reg |= BIT(SYS_PMSFCR_EL1_FL_SHIFT);
> >
> > @@ -353,6 +377,12 @@ static u64 arm_spe_event_to_pmsevfr(struct perf_event *event)
> >       return ATTR_CFG_GET_FLD(attr, event_filter);
> >  }
> >
> > +static u64 arm_spe_event_to_pmsnevfr(struct perf_event *event)
> > +{
> > +     struct perf_event_attr *attr = &event->attr;
> > +     return ATTR_CFG_GET_FLD(attr, inv_event_filter);
> > +}
> > +
> >  static u64 arm_spe_event_to_pmslatfr(struct perf_event *event)
> >  {
> >       struct perf_event_attr *attr = &event->attr;
> > @@ -703,6 +733,9 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
> >       if (arm_spe_event_to_pmsevfr(event) & arm_spe_pmsevfr_res0(spe_pmu->pmsver))
> >               return -EOPNOTSUPP;
> >
> > +     if (arm_spe_event_to_pmsnevfr(event) & arm_spe_pmsevfr_res0(spe_pmu->pmsver))
> > +             return -EOPNOTSUPP;
> > +
> >       if (attr->exclude_idle)
> >               return -EOPNOTSUPP;
> >
> > @@ -721,6 +754,10 @@ static int arm_spe_pmu_event_init(struct perf_event *event)
> >           !(spe_pmu->features & SPE_PMU_FEAT_FILT_EVT))
> >               return -EOPNOTSUPP;
> >
> > +     if ((reg & BIT(SYS_PMSFCR_EL1_FNE_SHIFT)) &&
> > +         !(spe_pmu->features & SPE_PMU_FEAT_INV_FILT_EVT))
> > +             return -EOPNOTSUPP;
> > +
> >       if ((reg & BIT(SYS_PMSFCR_EL1_FT_SHIFT)) &&
> >           !(spe_pmu->features & SPE_PMU_FEAT_FILT_TYP))
> >               return -EOPNOTSUPP;
> > @@ -757,6 +794,9 @@ static void arm_spe_pmu_start(struct perf_event *event, int flags)
> >       reg = arm_spe_event_to_pmsevfr(event);
> >       write_sysreg_s(reg, SYS_PMSEVFR_EL1);
> >
> > +     reg = arm_spe_event_to_pmsnevfr(event);
> > +     write_sysreg_s(reg, SYS_PMSNEVFR_EL1);
> > +
>
> I think this needs to check if the feature is present before writing
> otherwise you get a crash, pasted below. Otherwise it looks ok to me.

Yes, that's the 1 fix I've needed in my testing.

Rob
