Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD52557CF54
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 17:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231938AbiGUPg3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 11:36:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232134AbiGUPgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 11:36:09 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EA1E37
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 08:35:57 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v5so1278335wmj.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 08:35:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gDBJvFECTm7Pq0C9lMhNGhK5Ebl1v9EZPxP9t1ZpvwA=;
        b=sGunr33dt6mX3jqDWKkLep+kA83yczxElAtS14nQZ2Vfu6DTWEcJUj3a2SwFQF7NlK
         ICpXXVaaB0UkZ5ddtVY4rub5bljSbOCSlp3enDvZhNEFUaWpgiWdo0xSZBhJS9SCmM8V
         SyK5uRcUtwsVQj1JXBbTzJBonqTvH/09+WyGPWwtKWiLsdkN/Au74V+ydLRv3FNkbTRF
         /lxF8Op8JhqpRZw27Ld71b7mke+o7/qhVC2gg1ls4Xl+IsLiunL2/YqJibtNhLW25SNt
         P4SYnjkcjpSGAn/GB8bZ8GbLT4KX4MQSzMJPfhx2V307hfiDErz2vC8j0hfVYSVD/1vu
         2BpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gDBJvFECTm7Pq0C9lMhNGhK5Ebl1v9EZPxP9t1ZpvwA=;
        b=EyIpXXMpFyCDQToapxNYw26JppKgXMBZDZoLnbIlygAJdyDhnRPaynONfBnkF/C+k0
         mQpvRN5ewI99JhfY/k1R0aY/A2xGh+uDcMjP7DaMB3I59T+dKOGjNUFJ3A/rNiKDHp1M
         81FCl1ysKW0Or2Lv3tiSDXTjokOkSilx7Y+bz5YWRnL/8FahCwnJoYY8DGhdd76fF3Mc
         aDGdTdgt5sBzc63vZ4kDsza1GdV6jw/Mj4DwpEqARSfDaTNsaB/3ZIv1VucKuwvdmzBg
         11E3LKxA19cexeV8WwV2q6yhMeU1f4rMqn9jRl/JTSLA2XUEOuaF3KQTKEYnwUMAj93p
         05ag==
X-Gm-Message-State: AJIora/9c+tfTZmSQcO41hnthXXQXKRFJwi9rWwygAJWmMoR5YE8hnsG
        Ed3PejS4/5Yo8Jqu6yOKaSvGLIkwiF8mrwFiFJ9G8w==
X-Google-Smtp-Source: AGRyM1tP93XG4GyFGMmlNGqL2//7Nm5AvTy0LETAggQ8g6455bgaHFfidkzefjUu26ZycBY8KBYeE0czOkrQgtO0wZE=
X-Received: by 2002:a05:600c:4f8e:b0:3a3:30b7:4901 with SMTP id
 n14-20020a05600c4f8e00b003a330b74901mr3126400wmq.17.1658417756135; Thu, 21
 Jul 2022 08:35:56 -0700 (PDT)
MIME-Version: 1.0
References: <20220621055035.31766-1-bwicaksono@nvidia.com> <20220621055035.31766-2-bwicaksono@nvidia.com>
 <73dafe08-d1f1-90b6-995e-7d38e9e1dce7@arm.com> <SJ0PR12MB567600F730B47F3A1007775AA0829@SJ0PR12MB5676.namprd12.prod.outlook.com>
 <20220712163638.GA2945984@p14s> <632f5c80-2be3-ace5-6b0d-ee0c9e5560ff@arm.com>
 <SJ0PR12MB567612C18D20A0C0243F0D23A0889@SJ0PR12MB5676.namprd12.prod.outlook.com>
 <9d36f053-f929-204b-fb47-60c685b06717@arm.com>
In-Reply-To: <9d36f053-f929-204b-fb47-60c685b06717@arm.com>
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
Date:   Thu, 21 Jul 2022 09:35:44 -0600
Message-ID: <CANLsYkz6yAMU-PHpjjBr6WwpJ3tKvGew0+Y_sZHfQgwJDptskA@mail.gmail.com>
Subject: Re: [RESEND PATCH v3 1/2] perf: coresight_pmu: Add support for ARM
 CoreSight PMU driver
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Besar Wicaksono <bwicaksono@nvidia.com>,
        Robin Murphy <robin.murphy@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        "thanu.rangarajan@arm.com" <thanu.rangarajan@arm.com>,
        "Michael.Williams@arm.com" <Michael.Williams@arm.com>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Vikram Sethi <vsethi@nvidia.com>,
        "mike.leach@linaro.org" <mike.leach@linaro.org>,
        "leo.yan@linaro.org" <leo.yan@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Jul 2022 at 03:19, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> Hi
>
> On 14/07/2022 05:47, Besar Wicaksono wrote:
> >
> >
> >> -----Original Message-----
> >> From: Robin Murphy <robin.murphy@arm.com>
> >> Sent: Wednesday, July 13, 2022 3:13 AM
> >> To: Mathieu Poirier <mathieu.poirier@linaro.org>; Besar Wicaksono
> >> <bwicaksono@nvidia.com>
> >> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>; catalin.marinas@arm.com;
> >> will@kernel.org; mark.rutland@arm.com; linux-arm-
> >> kernel@lists.infradead.org; linux-kernel@vger.kernel.org; linux-
> >> tegra@vger.kernel.org; sudeep.holla@arm.com;
> >> thanu.rangarajan@arm.com; Michael.Williams@arm.com; Thierry Reding
> >> <treding@nvidia.com>; Jonathan Hunter <jonathanh@nvidia.com>; Vikram
> >> Sethi <vsethi@nvidia.com>; mike.leach@linaro.org; leo.yan@linaro.org
> >> Subject: Re: [RESEND PATCH v3 1/2] perf: coresight_pmu: Add support for
> >> ARM CoreSight PMU driver
> >>
> >> External email: Use caution opening links or attachments
> >>
> >>
> >> On 2022-07-12 17:36, Mathieu Poirier wrote:
> >> [...]
> >>>>> If we have decied to call this arm_system_pmu, (which I am perfectly
> >>>>> happy with), could we please stick to that name for functions that we
> >>>>> export ?
> >>>>>
> >>>>> e.g,
> >>>>>
> >> s/coresight_pmu_sysfs_event_show/arm_system_pmu_event_show()/
> >>>>>
> >>>>
> >>>> Just want to confirm, is it just the public functions or do we need to
> >> replace
> >>>> all that has "coresight" naming ? Including the static functions, structs,
> >> filename.
> >>>
> >>> I think all references to "coresight" should be changed to
> >> "arm_system_pmu",
> >>> including filenames.  That way there is no doubt this IP block is not
> >>> related, and does not interoperate, with the any of the "coresight" IP
> >> blocks
> >>> already supported[1] in the kernel.
> >>>
> >>> I have looked at the documentation[2] in the cover letter and I agree
> >>> with an earlier comment from Sudeep that this IP has very little to do with
> >> any
> >>> of the other CoreSight IP blocks found in the CoreSight framework[1].
> >> Using the
> >>> "coresight" naming convention in this driver would be _extremely_
> >> confusing,
> >>> especially when it comes to exported functions.
> >>
> >> But conversely, how is it not confusing to make up completely different
> >> names for things than what they're actually called? The CoreSight
> >> Performance Monitoring Unit is a part of the Arm CoreSight architecture,
> >> it says it right there on page 1. What if I instinctively associate the
> >> name Mathieu with someone more familiar to me, so to avoid confusion I'd
> >> prefer to call you Steve? Is that OK?
> >>
> >
> > What is the naming convention for modules under drivers/perf ?
> > In my observation, the names there correspond to the part monitored by
> > the PMU. The confusion on using "coresight_pmu" naming could be that
> > people may think the PMU monitors coresight system, i.e the trace system under hwtracing.
> > However, the driver in this patch is for a new PMU standard that monitors uncore
> > parts. Uncore was considered as terminology from Intel, so "system" was picked instead.
> > Please see this thread for reference:
> >    https://lore.kernel.org/linux-arm-kernel/20220510111318.GD27557@willie-the-truck/
>
> I think we all understand the state of affairs.
>
> - We have an architecutre specification for PMUs, Arm CoreSight PMU
> Architecutre, which has absolutely no relationship with :
>
>     either CoreSight Self-Hosted Tracing (handled by "coresight"
> subsystem in the kernel under drivers/hwtracing/coresight/, with a user
> visible pmu as "cs_etm")
>
>     or the CoreSight Architecture (except for the name). This is of less
> significance in general. But has a significant impact on the "name"
> users might expect for the driver/Kconfig etc.
>
> - We want to be able to make it easier for the users/developers to
> choose what they want without causing confusion.
>
> For an end-user: Having the PMU instance named after the "System IP"
> (as implememented in the driver solves the problem and falling back to
> arm_system_pmu is a good enough choice. So let us stick with that)
>
> Kconfig: May be we can choose
> CONFIG_ARM_CORESIGHT_PMU_ARCH_PMU
> or even
> CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU
>
> with appropriate help text to ensure there is enough stress about what
> this is and what this is not would be sufficient.
>
> Now the remaining contention is about the name of the "subsystem" and
> also the dir/files.  This may sound insignificant. But it is also
> important to get this right. e.g., helps the reviewers unambiguously
> identify the change or maintainers accepting pull requests (remember
> these two PMUs (cs_etm and this one) go via different trees.). Not
> everyone who deals with this in the community may be aware of how
> these are different.
>
> We could choose arm_cspmu_ or simply cspmu. Given that only the
> "normal" users care about the "association" with the "architecture"
> and more advanced users (e.g, developers) can easily map "Kconfig"
> to driver files, may be we could even stick to the "arm_syspmu"
> (from "arm system pmu") ?
>

+1 on "arm_syspmu"

> Suzuki
>
>
> >
> >> As it happens, Steve, I do actually agree with you that "coresight_" is
> >> a bad prefix here, but only for the reason that it's too general. TBH I
> >> think that's true of the existing Linux subsystem too, but that damage
> >> is already done, and I'd concur that there's little value in trying to
> >> unpick that now, despite the clear existence of products like CoreSight
> >> DAP and CoreSight ELA which don't have all that much to do with program
> >> trace either.
> >>
> >> However, hindsight and inertia are hardly good reasons to double down on
> >> poor decisions, so if I was going to vote for anything here it would be
> >> "cspmu_", which is about as
> >> obviously-related-to-the-thing-it-actually-is as we can get while also
> >> being pleasantly concise.
> >>
> >> [ And no, this isn't bikeshedding. Naming things right is *important* ]
> >>
> >
> > I agree having the correct name is important, especially at this early stage.
> > A direction of what the naming should describe would be very helpful here.
> >
> >> Cheers,
> >> Robin.
> >>
> >>>
> >>> Thanks,
> >>> Steve
> >>>
> >>> [1]. drivers/hwtracing/coresight/
> >>> [2]. https://developer.arm.com/documentation/ihi0091/latest
>
