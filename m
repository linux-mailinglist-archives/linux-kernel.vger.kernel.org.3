Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF25248F083
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 20:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244121AbiANTfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 14:35:53 -0500
Received: from mail-qt1-f174.google.com ([209.85.160.174]:45979 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232351AbiANTfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 14:35:52 -0500
Received: by mail-qt1-f174.google.com with SMTP id x8so5723892qta.12;
        Fri, 14 Jan 2022 11:35:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qdn/VSBgWsg66OG0unhwyC/L4RktepqcOC0tWwqS/+g=;
        b=rTMIr/x019cswQjd01qjASHKx0vrs4bGIL342Qg3cZNMdd2mSGha50DlNMUjMDYpMt
         RYXhmAu9hV3BR49affhGjgyPqwXH2OWF6MZU9DQW3CrBEXez189LnXQn9EdhKOhQCCKX
         Iyx3G5yq8Ff8dlArlSMAUIextzmVqaIRwZ0eSC91v2tLF2wae6veuGgdcbbLyy43pVye
         k6E6VqHbHDUvMySEnot+J+QyJg66H1SAchU5XDlaYGbpNxQ9FCM0CUUzVptIaSO69Xaf
         rka0G4AImd1MT5Zx/5HM3mVOwoVQFrlm94YelPUKH6aP5GemK5dSujo2pn6ku72WCkKP
         tCwQ==
X-Gm-Message-State: AOAM533+43rQ4oT9HkWlGsjlLyHNXTib+Fo1EjBaShgMnlndB9l0QxZg
        iyeuOQ61EIR8WlqQM7ooMDhUoUhtCCLvgssd4/A=
X-Google-Smtp-Source: ABdhPJx4F3VCQjqRzVSs0ZBAYGlp5ZKEJ7hhcV6WHhmgeLLWntYC0ifmJr3Egfz3u9QElET9lX1gG0VmIZnc8yjN2EM=
X-Received: by 2002:ac8:5991:: with SMTP id e17mr9096424qte.344.1642188951451;
 Fri, 14 Jan 2022 11:35:51 -0800 (PST)
MIME-Version: 1.0
References: <20220106025059.25847-1-ricardo.neri-calderon@linux.intel.com>
 <20220106025059.25847-7-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0ioQ7UQt58NraPAG=M8k-joSy5pmszFjp=NcS6z==6RQg@mail.gmail.com> <7dde8e84961e09066c6bf02198e429d3a702a496.camel@linux.intel.com>
In-Reply-To: <7dde8e84961e09066c6bf02198e429d3a702a496.camel@linux.intel.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Fri, 14 Jan 2022 20:35:40 +0100
Message-ID: <CAJZ5v0iEkpGTCSho4vYUAzgo3tvGc0UArbpUebehNSt-39QgGw@mail.gmail.com>
Subject: Re: [PATCH v3 6/7] thermal: netlink: Add a new event to notify CPU
 capabilities change
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Len Brown <len.brown@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Lukasz Luba <lukasz.luba@arm.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 10:32 PM Srinivas Pandruvada
<srinivas.pandruvada@linux.intel.com> wrote:
>
> On Wed, 2022-01-12 at 20:25 +0100, Rafael J. Wysocki wrote:
> > On Thu, Jan 6, 2022 at 3:49 AM Ricardo Neri
> > <ricardo.neri-calderon@linux.intel.com> wrote:
> > > From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > >
> > > Add a new netlink event to notify change in CPU capabilities in
> > > terms of
> > > performance and efficiency.
> > >
> > > Firmware may change CPU capabilities as a result of thermal events
> > > in the
> > > system or to account for changes in the TDP (thermal design power)
> > > level.
> > >
> > > This notification type will allow user space to avoid running
> > > workloads
> > > on certain CPUs or proactively adjust power limits to avoid future
> > > events.
> > >
> > > The netlink message consists of a nested attribute
> > > (THERMAL_GENL_ATTR_CPU_CAPABILITY) with three attributes:
> > >
> > >  * THERMAL_GENL_ATTR_CPU_CAPABILITY_ID (type u32):
> > >    -- logical CPU number
> > >  * THERMAL_GENL_ATTR_CPU_CAPABILITY_PERFORMANCE (type u32):
> > >    -- Scaled performance from 0-1023
> > >  * THERMAL_GENL_ATTR_CPU_CAPABILITY_EFFICIENCY (type u32):
> > >    -- Scaled efficiency from 0-1023
> > >
> > > Cc: Andi Kleen <ak@linux.intel.com>
> > > Cc: Aubrey Li <aubrey.li@linux.intel.com>
> > > Cc: Lukasz Luba <lukasz.luba@arm.com>
> > > Cc: Tim Chen <tim.c.chen@linux.intel.com>
> > > Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> > > Reviewed-by: Len Brown <len.brown@intel.com>
> > > Signed-off-by: Srinivas Pandruvada <
> > > srinivas.pandruvada@linux.intel.com>
> >
> > Of course, I need to know if Daniel and Lukasz agree with this patch.
> >
> I pinged Daniel offline. I accommodated comments from Lukasz.
>
> > > ---
> > >
>
> [...]
>
> > > +static int thermal_genl_event_cpu_capability_change(struct param
> > > *p)
> > > +{
> > > +       struct cpu_capability *cpu_cap = p->cpu_capabilities;
> > > +       struct sk_buff *msg = p->msg;
> > > +       struct nlattr *start_cap;
> > > +       int i, ret;
> > > +
> > > +       start_cap = nla_nest_start(msg,
> > > THERMAL_GENL_ATTR_CPU_CAPABILITY);
> > > +       if (!start_cap)
> > > +               return -EMSGSIZE;
> > > +
> > > +       for (i = 0; i < p->cpu_capabilities_count; ++i) {
> > > +               if (nla_put_u32(msg,
> > > THERMAL_GENL_ATTR_CPU_CAPABILITY_ID,
> > > +                               cpu_cap->cpu)) {
> > > +                       ret = -EMSGSIZE;
> > > +                       goto out_cancel_nest;
> > > +               }
> > > +               if (nla_put_u32(msg,
> > > THERMAL_GENL_ATTR_CPU_CAPABILITY_PERFORMANCE,
> > > +                               cpu_cap->performance)) {
> > > +                       ret = -EMSGSIZE;
> > > +                       goto out_cancel_nest;
> > > +               }
> > > +               if (nla_put_u32(msg,
> > > THERMAL_GENL_ATTR_CPU_CAPABILITY_EFFICIENCY,
> > > +                               cpu_cap->efficiency)) {
> > > +                       ret = -EMSGSIZE;
> > > +                       goto out_cancel_nest;
> > > +               }
> > > +               ++cpu_cap;
> > > +       }
> > > +
> > > +       nla_nest_end(msg, start_cap);
> > > +
> > > +       return 0;
> > > +out_cancel_nest:
> > > +       nla_nest_cancel(msg, start_cap);
> > > +
> > > +       return ret;
> >
> > It looks like ret is never different from -EMSGSIZE here, so I'd just
> > return that error and drop the ret variable.
> >
> ret is initialized for every case when it will be returned.

Right, but it is redundant.

> But agree
> that we can just return -EMSGSIZE as there is no other return value
> here.
>
> > > +}
> > > +
> > >
>
> [...]
>
> > > +struct cpu_capability {
> >
> > I'm wondering if the struct name is not too generic as the purpose it
> > is used for is rather narrow and specific.
> >
> This was named something else before. What about cpu_energy_perf_cap?

Because it is only used in the thermal_genl_cpu_capability_event()
interface, it would be good to make the name reflect that IMO.
Something like thermal_genl_cpu_caps would work in this regard.
