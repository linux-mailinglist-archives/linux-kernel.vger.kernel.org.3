Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 437A649E4A7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242383AbiA0Ob7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237777AbiA0Ob6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:31:58 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B84AC061714;
        Thu, 27 Jan 2022 06:31:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D570061CF5;
        Thu, 27 Jan 2022 14:31:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F33C340EB;
        Thu, 27 Jan 2022 14:31:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643293917;
        bh=KG0sJJ6svB6Q4dVDStVvr5ZY/p0y/TT6kssCsLP37kI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=L9qelgPQCtgC73eHNwlqcEoqCbhQnXfe/D0+BCtb40l0j8YTDJwnoSXAXF6HQeTj2
         WioVAU1eU+H0qHjTIh4AYDDnsiXVsKyVZjacvPHVK3qyZEvbiMsdoOvXJOmoP879lQ
         7nH9Zg2HTrmp0sgjdODKZqYuTNKczKttl6j9Lc3ppx50MY5DwNQ7/AyHrxQxOAv/E2
         /2kz2qfAHu5sGoIygfyo1kKpowLCpbEtrAeet/+XJVoRAARBbpWuvKzoegPFvDSnci
         57S+/n0DzPo+EFon1Z5XmgHGdsX9LX+mnTDHklCAZCN/HiS7sZe4ejvzgQBkWy1Nf9
         vh9eJcnRs15Mg==
Received: by mail-qt1-f180.google.com with SMTP id g12so2555891qto.13;
        Thu, 27 Jan 2022 06:31:57 -0800 (PST)
X-Gm-Message-State: AOAM530U7O8SidNO6vVzUrvIwCcTK5LYVf2KiS9nxx8wUgdV2EN7fUZJ
        +s5Z86knXX3dARBR9/Dv0ipCUNbwdTSdg1Mzwg==
X-Google-Smtp-Source: ABdhPJxyglgGrDLep5DRhLAJE92a8tCwOyGYP4E/18NDmZa7waQhMxyT8SHlKlk1KnISG642ASa68rEQsuM/hU4/RUE=
X-Received: by 2002:ac8:3d41:: with SMTP id u1mr2887893qtf.478.1643293916325;
 Thu, 27 Jan 2022 06:31:56 -0800 (PST)
MIME-Version: 1.0
References: <1642998653-21377-1-git-send-email-anshuman.khandual@arm.com>
 <1642998653-21377-7-git-send-email-anshuman.khandual@arm.com>
 <YfF/zBS3kL/+eC1k@robh.at.kernel.org> <9e56509a-2772-a333-ccc3-ad49a2028616@arm.com>
In-Reply-To: <9e56509a-2772-a333-ccc3-ad49a2028616@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 27 Jan 2022 08:31:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqJXQqV3P=T8GXxDY2wReeYnLcBqge139fUUXLtcQJe=6w@mail.gmail.com>
Message-ID: <CAL_JsqJXQqV3P=T8GXxDY2wReeYnLcBqge139fUUXLtcQJe=6w@mail.gmail.com>
Subject: Re: [RFC V1 06/11] arm64/perf: Drive BRBE from perf event states
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 6:20 AM Anshuman Khandual
<anshuman.khandual@arm.com> wrote:
>
>
> On 1/26/22 10:37 PM, Rob Herring wrote:
> > On Mon, Jan 24, 2022 at 10:00:48AM +0530, Anshuman Khandual wrote:
> >> Branch stack sampling rides along the normal perf event and all the branch
> >> records get captured during the PMU interrupt. This just changes perf event
> >> handling on the arm64 platform to accommodate required BRBE operations that
> >> will enable branch stack sampling support.
> >>
> >> Cc: Peter Zijlstra <peterz@infradead.org>
> >> Cc: Ingo Molnar <mingo@redhat.com>
> >> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> >> Cc: Mark Rutland <mark.rutland@arm.com>
> >> Cc: Will Deacon <will@kernel.org>
> >> Cc: Catalin Marinas <catalin.marinas@arm.com>
> >> Cc: linux-perf-users@vger.kernel.org
> >> Cc: linux-kernel@vger.kernel.org
> >> Cc: linux-arm-kernel@lists.infradead.org
> >> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> >> ---
> >>  arch/arm64/kernel/perf_event.c |  6 +++++
> >>  drivers/perf/arm_pmu.c         | 40 ++++++++++++++++++++++++++++++++++
> >>  2 files changed, 46 insertions(+)
> >>
> >> diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
> >> index f6a47036b0b4..11c82c8f2eec 100644
> >> --- a/arch/arm64/kernel/perf_event.c
> >> +++ b/arch/arm64/kernel/perf_event.c
> >> @@ -864,6 +864,12 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
> >>              if (!armpmu_event_set_period(event))
> >>                      continue;
> >>
> >> +            if (has_branch_stack(event)) {
> >> +                    cpu_pmu->brbe_read(cpuc, event);
> >
> > Is has_branch_stack() guaranteed to be false on arm32? If not, this will
> > be a NULL function ptr.
>
> armpmu_event_init() blocks a perf event from being created with branch
> stack sampling request without CONFIG_ARM_BRBE_PMU option being enabled
> first, which has dependency on CONFIG_ARM64. So has_branch_stack() is
> guaranteed to be false on arm32.

Then the stub functions in patch 3 are also not needed. The fact that
you create dummy functions makes it look like you can't have NULL
function ptrs, but you don't. This is what I mean about the structure
of the series being hard to review.

> static int armpmu_event_init(struct perf_event *event)
> {
>         ....
>         if (has_branch_stack(event)) {
>                 /*
>                  * BRBE support is absent. Select CONFIG_ARM_BRBE_PMU
>                  * in the config, before branch stack sampling events
>                  * can be requested.
>                  */
>                 if (!IS_ENABLED(CONFIG_ARM_BRBE_PMU)) {
>                         pr_warn_once("BRBE is disabled, select CONFIG_ARM_BRBE_PMU\n");
>                         return -EOPNOTSUPP;
>                 }
>
>
> config ARM_BRBE_PMU
>         tristate "Enable support for Branch Record Buffer Extension (BRBE)"
>         depends on ARM64 && ARM_PMU
>         default y
>         help
>           Enable perf support for Branch Record Buffer Extension (BRBE) which
>           records all branches taken in an execution path. This supports some
>           branch types and privilege based filtering. It captured additional
>           relevant information such as cycle count, misprediction and branch
>           type, branch privilege level etc.
>
> >
> > To add to my other comments, this patch is where I would add
> > brbe_read(), etc. to arm_pmu.
>
> Because all new arm_pmu helpers get added and get used in the perf driver
> in the same patch, although the actual helper implementation would still
> come by bit later via the driver. This also uses updates to pmu_hw_events
> struct as well, then that patch needs to be folded here as well.
>
> There is no problem as such, kind of bit subjective. I just feel inclined
> to keep the independent infrastructure changes separate making it easy to
> review while also creating a flow.

Everything about kernel development is subjective until it's a
requirement by the maintainer. I'm not here, so it's just advice.

Rob
