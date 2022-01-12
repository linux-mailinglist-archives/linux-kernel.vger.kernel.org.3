Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D3E648CDDF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 22:33:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233360AbiALVda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 16:33:30 -0500
Received: from mga17.intel.com ([192.55.52.151]:62940 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233150AbiALVcw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 16:32:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642023172; x=1673559172;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eN7exeTCR29Wy4LB7pYWXx9koMDYosg8aVNTC5CSc2g=;
  b=gjQ6sNdq39Ljpl3UeRMwqph6xlXrqz5mjjlh2BhsyzghvkY6ZYBsmFIf
   IOSid7+U8+E3kZuJ9IqqP5ObZCknYCgqKbWXBYkBbG+yKH8SkBvOJe+ys
   /oiW75z/SkTV+FFBGnWwLEMfUILZEnxDZmQLamnCu3KQQn3i7FMhz5kM1
   Zojk4YaEzr2cQ8gdB2eqlhTT0k9AwjTAaoYRY/aiK5BSrQdRAkpQqnzr2
   YWW411J5opupqIELQbPHPvnN/2HzBfaANyPv0K4yT8vjbD7t+bthDNowK
   qf82wD34hmqC0+I5fqZIbkX2fYcI24ESnaD/eaKXdOnj0EhlFTll5U0sl
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="224550308"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="224550308"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 13:32:51 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="475067451"
Received: from japete-mobl1.amr.corp.intel.com ([10.212.252.179])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 13:32:47 -0800
Message-ID: <7dde8e84961e09066c6bf02198e429d3a702a496.camel@linux.intel.com>
Subject: Re: [PATCH v3 6/7] thermal: netlink: Add a new event to notify CPU
 capabilities change
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
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
Date:   Wed, 12 Jan 2022 13:32:46 -0800
In-Reply-To: <CAJZ5v0ioQ7UQt58NraPAG=M8k-joSy5pmszFjp=NcS6z==6RQg@mail.gmail.com>
References: <20220106025059.25847-1-ricardo.neri-calderon@linux.intel.com>
         <20220106025059.25847-7-ricardo.neri-calderon@linux.intel.com>
         <CAJZ5v0ioQ7UQt58NraPAG=M8k-joSy5pmszFjp=NcS6z==6RQg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.5-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-01-12 at 20:25 +0100, Rafael J. Wysocki wrote:
> On Thu, Jan 6, 2022 at 3:49 AM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> > From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > 
> > Add a new netlink event to notify change in CPU capabilities in
> > terms of
> > performance and efficiency.
> > 
> > Firmware may change CPU capabilities as a result of thermal events
> > in the
> > system or to account for changes in the TDP (thermal design power)
> > level.
> > 
> > This notification type will allow user space to avoid running
> > workloads
> > on certain CPUs or proactively adjust power limits to avoid future
> > events.
> > 
> > The netlink message consists of a nested attribute
> > (THERMAL_GENL_ATTR_CPU_CAPABILITY) with three attributes:
> > 
> >  * THERMAL_GENL_ATTR_CPU_CAPABILITY_ID (type u32):
> >    -- logical CPU number
> >  * THERMAL_GENL_ATTR_CPU_CAPABILITY_PERFORMANCE (type u32):
> >    -- Scaled performance from 0-1023
> >  * THERMAL_GENL_ATTR_CPU_CAPABILITY_EFFICIENCY (type u32):
> >    -- Scaled efficiency from 0-1023
> > 
> > Cc: Andi Kleen <ak@linux.intel.com>
> > Cc: Aubrey Li <aubrey.li@linux.intel.com>
> > Cc: Lukasz Luba <lukasz.luba@arm.com>
> > Cc: Tim Chen <tim.c.chen@linux.intel.com>
> > Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
> > Reviewed-by: Len Brown <len.brown@intel.com>
> > Signed-off-by: Srinivas Pandruvada <
> > srinivas.pandruvada@linux.intel.com>
> 
> Of course, I need to know if Daniel and Lukasz agree with this patch.
> 
I pinged Daniel offline. I accommodated comments from Lukasz.

> > ---
> > 

[...]

> > +static int thermal_genl_event_cpu_capability_change(struct param
> > *p)
> > +{
> > +       struct cpu_capability *cpu_cap = p->cpu_capabilities;
> > +       struct sk_buff *msg = p->msg;
> > +       struct nlattr *start_cap;
> > +       int i, ret;
> > +
> > +       start_cap = nla_nest_start(msg,
> > THERMAL_GENL_ATTR_CPU_CAPABILITY);
> > +       if (!start_cap)
> > +               return -EMSGSIZE;
> > +
> > +       for (i = 0; i < p->cpu_capabilities_count; ++i) {
> > +               if (nla_put_u32(msg,
> > THERMAL_GENL_ATTR_CPU_CAPABILITY_ID,
> > +                               cpu_cap->cpu)) {
> > +                       ret = -EMSGSIZE;
> > +                       goto out_cancel_nest;
> > +               }
> > +               if (nla_put_u32(msg,
> > THERMAL_GENL_ATTR_CPU_CAPABILITY_PERFORMANCE,
> > +                               cpu_cap->performance)) {
> > +                       ret = -EMSGSIZE;
> > +                       goto out_cancel_nest;
> > +               }
> > +               if (nla_put_u32(msg,
> > THERMAL_GENL_ATTR_CPU_CAPABILITY_EFFICIENCY,
> > +                               cpu_cap->efficiency)) {
> > +                       ret = -EMSGSIZE;
> > +                       goto out_cancel_nest;
> > +               }
> > +               ++cpu_cap;
> > +       }
> > +
> > +       nla_nest_end(msg, start_cap);
> > +
> > +       return 0;
> > +out_cancel_nest:
> > +       nla_nest_cancel(msg, start_cap);
> > +
> > +       return ret;
> 
> It looks like ret is never different from -EMSGSIZE here, so I'd just
> return that error and drop the ret variable.
> 
ret is initialized for every case when it will be returned. But agree
that we can just return -EMSGSIZE as there is no other return value
here.

> > +}
> > +
> > 

[...]

> > +struct cpu_capability {
> 
> I'm wondering if the struct name is not too generic as the purpose it
> is used for is rather narrow and specific.
> 
This was named something else before. What about cpu_energy_perf_cap?


> > +       int cpu;
> > +       int performance;
> > +       int efficiency;
> > +};
> > +
> > 
Thanks,
Srinivas

