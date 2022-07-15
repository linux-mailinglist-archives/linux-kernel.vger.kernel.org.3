Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF8765765DD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 19:25:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233419AbiGORTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 13:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231818AbiGORTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 13:19:10 -0400
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4DD27B2F;
        Fri, 15 Jul 2022 10:19:08 -0700 (PDT)
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-31cf1adbf92so53355287b3.4;
        Fri, 15 Jul 2022 10:19:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RV4CgMt4Uhdx+RPlbigIu5+LuSwk2m9JdabT6Izy3ss=;
        b=jpMiC0hKRVWeMFyemVgo+LMt9O+GJeCbV00wNsQChCPKVkFtsvV+NP+sEvcirfda2J
         qSq2JelO0W2E/tcsqU6FJmTOWC6AlVdlUBWW9e2z9LpTiI5ruEOtsAM977viYYxjl3a/
         FhbkS1zA7P9HbRkKGpoCBXA3faeBuD3HZuXfRCfR3ubtET01szgO0m7GNiKxKWYudDfD
         rOiTgnOOFgaHQHuu9qzftTN/MmSg7GtsYf8klYSFRHYC1nEjCx+FdNelBXM/zMbWLOjC
         GmsXH7qgj+mD4IpJWQUHmNFRQNQsSqj6tdFCw9MRNWDMZcr1xArFryg7697r0Sw5LDxE
         gEsg==
X-Gm-Message-State: AJIora/3/dFB7cABQqn0gHPgySYS0lQa9IeR+8PiOuL8pQMPn/Euj2zT
        RuEKZFr8Uf9Fa303xLYGqZ7KrVnuxms/ayiRVwY=
X-Google-Smtp-Source: AGRyM1taAq+iVG6nrCvqbpzS3ZVBPbzQldku4nRuJGDklibMRpmYSt09XTo2pnmCZnRhRQIuFgU+qvp3vDt6Vn3VASc=
X-Received: by 2002:a81:1b97:0:b0:2db:640f:49d8 with SMTP id
 b145-20020a811b97000000b002db640f49d8mr16470414ywb.326.1657905547640; Fri, 15
 Jul 2022 10:19:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220707071555.10085-1-lukasz.luba@arm.com> <41c333e1-2545-f6be-2db2-9061297d0b9a@arm.com>
 <c334d692-9787-7591-54d7-f152ecbd559e@arm.com>
In-Reply-To: <c334d692-9787-7591-54d7-f152ecbd559e@arm.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 15 Jul 2022 19:18:56 +0200
Message-ID: <CAJZ5v0iKT5nK56PYjnXJP__TrZs0v0B5h+Zi1=3ZNKCOF=ByxA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Energy Model power in micro-Watts and SCMI v3.1 alignment
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Zhang, Rui" <rui.zhang@intel.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 15, 2022 at 10:56 AM Lukasz Luba <lukasz.luba@arm.com> wrote:
>
> Hi Rafael,
>
> gentle ping.
>
> On 7/7/22 11:46, Lukasz Luba wrote:
> > Hi Rafael,
> >
> > On 7/7/22 08:15, Lukasz Luba wrote:
> >> Hi all,
> >>
> >> This is a patch set which changes Energy Model power values scale to
> >> micro-Watts. It also upgrades the SCMI performance layer + scmi-cpufreq
> >> driver to leverage the SCMI v3.1 spec and process micro-Watts power
> >> values
> >> coming from FW. The higher precision in EM power field solves an issue
> >> of a rounding error, which then can be misinterpreted as 'inefficient
> >> OPP'.
> >> An example rounding issue calculation is present in patch 1/4
> >> description.
> >>
> >> Changes:
> >> v2
> >> - simplified 32bit checks for max number of CPUs preventing energy
> >>    estimation overflow
> >> - added Reviewed-by and ACKs
> >> v1 [1]
> >>
> >> Regards,
> >> Lukasz Luba
> >>
> >> [1]
> >> https://lore.kernel.org/lkml/20220622145802.13032-1-lukasz.luba@arm.com/
> >>
> >> Lukasz Luba (4):
> >>    PM: EM: convert power field to micro-Watts precision and align drivers
> >>    Documentation: EM: Switch to micro-Watts scale
> >>    firmware: arm_scmi: Get detailed power scale from perf
> >>    cpufreq: scmi: Support the power scale in micro-Watts in SCMI v3.1
> >>
> >>   Documentation/power/energy-model.rst  | 14 +++----
> >>   drivers/cpufreq/mediatek-cpufreq-hw.c |  7 ++--
> >>   drivers/cpufreq/scmi-cpufreq.c        | 15 +++++++-
> >>   drivers/firmware/arm_scmi/perf.c      | 18 +++++----
> >>   drivers/opp/of.c                      | 15 ++++----
> >>   drivers/powercap/dtpm_cpu.c           |  5 +--
> >>   drivers/thermal/cpufreq_cooling.c     | 13 ++++++-
> >>   drivers/thermal/devfreq_cooling.c     | 19 ++++++++--
> >>   include/linux/energy_model.h          | 54 +++++++++++++++++++--------
> >>   include/linux/scmi_protocol.h         |  8 +++-
> >>   kernel/power/energy_model.c           | 24 ++++++++----
> >>   11 files changed, 132 insertions(+), 60 deletions(-)
> >>
> >
> > I got ACKs (and on Reviewed-by) for this patch set.
> > Could you take this via your PM tree, please?
>
> This patch set is on our roadmap and would be good if it could
> go as v5.20 material.
>
> There are Acks for these patch set. If you need some
> help with this (like rebasing, etc), just ping me.
>
> Could you take them, please?

All patches in the series applied as 5.20 material, thanks!
