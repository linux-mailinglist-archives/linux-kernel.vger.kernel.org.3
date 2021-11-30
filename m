Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32D544630E7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 11:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232118AbhK3KXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 05:23:45 -0500
Received: from mga12.intel.com ([192.55.52.136]:27165 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231216AbhK3KXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 05:23:44 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10183"; a="216202399"
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="216202399"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 02:20:25 -0800
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="676773337"
Received: from svalluri-mobl.gar.corp.intel.com ([10.213.116.31])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 02:20:20 -0800
Message-ID: <49299b089f553ef2878aaa7eaf60f8c3600b939d.camel@linux.intel.com>
Subject: Re: [PATCH 1/7] x86/Documentation: Describe the Intel Hardware
 Feedback Interface
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org
Cc:     x86@kernel.org, linux-doc@vger.kernel.org,
        Len Brown <len.brown@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 30 Nov 2021 02:20:16 -0800
In-Reply-To: <81bca26d-eac8-31ed-e5ec-81812664d671@linaro.org>
References: <20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com>
         <20211106013312.26698-2-ricardo.neri-calderon@linux.intel.com>
         <81bca26d-eac8-31ed-e5ec-81812664d671@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

On Tue, 2021-11-30 at 10:24 +0100, Daniel Lezcano wrote:
> Hi Ricardo,
> > 

[...]

> > +The Hardware Feedback Interface
> > +-------------------------------
> > +
> > +The Hardware Feedback Interface provides to the operating system
> > information
> > +about the performance and energy efficiency of each CPU in the
> > system. Each
> > +capability is given as a unit-less quantity in the range [0-255].
> > Higher values
> > +indicate higher capability. Energy efficiency and performance are
> > reported in
> > +separate capabilities.
> 
> Are they linked together (eg. higher energy efficiency => lower
> performance)?

Generally true.
But for some workload and condition higher energy efficient point
doesn't mean lower performance.

> 
> > +These capabilities may change at runtime as a result of changes in
> > the
> > +operating conditions of the system or the action of external
> > factors.
> 
> Is it possible to give examples?
For example a server farm decide to save power by reduce cooling cost,
by lowering TDP. This can be done remotely. This will result in
notification of a lower performance value or even perf=eff=0 on some
CPUs via HFI. Intel CPU has capability to change TDP level runtime.

Or if the system is over heating the firmware can indicate lower
performance, so OSPM can take action. 

> 
> > The rate
> > +at which these capabilities are updated is specific to each
> > processor model. On
> > +some models, capabilities are set at boot time and never change.
> > On others,
> > +capabilities may change every tens of milliseconds.
> > +
> > +The kernel or a userspace policy daemon can use these capabilities
> > to modify
> > +task placement decisions. For instance, if either the performance
> > or energy
> > +capabilities of a given logical processor becomes zero, it is an
> > indication that
> > +the hardware recommends to the operating system to not schedule
> > any tasks on
> > +that processor for performance or energy efficiency reasons,
> > respectively.
> 
> How the userspace can be involved in these decisions? If the
> performance
> is impacted then that should be reflected in the CPU capacity. The
> scheduler will prevent to put task on CPU with a low capacity, no?
> 
> I'm also worried about the overhead of the userspace notifications.
> 
> That sounds like similar to the thermal pressure? Wouldn't make sense
> to
> create a generic component where HFI, cpufreq cooling, LMh, etc ...
> are
> the backend?

The problem is treatment of perf/eff == 0 of a CPU, which we can
indicate as capacity  = 0 to scheduler. But this doesn't prevent
scheduler for using that CPU on a overloaded system. We can offline
that CPU in kernel, which will be intrusive without notifying user
space or may fail for CPU0. Tried cpu idle injection, remove from cpu
sets. But doesn't work when interrupt are affined to that CPU, soft
irqs or timer scheduled there.

Here the notification are in order of several ms in order ( In reality
they are in seconds for current use cases). These are not emergency
events. Same as other thermal notifications, if something urgent FW can
already force to lowest performance without even notifying user space.


Thanks,
Srinivas

> 
> 
> 
> > +Implementation details for Linux
> > +--------------------------------
> > +
> > +The infrastructure to handle thermal event interrupts has two
> > parts. In the
> > +Local Vector Table of a CPU's local APIC, there exists a register
> > for the
> > +Thermal Monitor Register. This register controls how interrupts
> > are delivered
> > +to a CPU when the thermal monitor generates and interrupt. Further
> > details
> > +can be found in the Intel SDM Vol. 3 Section 10.5 [1]_.
> > +
> > +The thermal monitor may generate interrupts per CPU or per
> > package. The HFI
> > +generates package-level interrupts. This monitor is configured and
> > initialized
> > +via a set of machine-specific registers. Specifically, the HFI
> > interrupt and
> > +status are controlled via designated bits in the
> > IA32_PACKAGE_THERM_INTERRUPT
> > +and IA32_PACKAGE_THERM_STATUS registers, respectively. There
> > exists one HFI
> > +table per package. Further details can be found in the Intel SDM
> > Vol. 3
> > +Section 14.9 [1]_.
> > +
> > +The hardware issues an HFI interrupt after updating the HFI table
> > and is ready
> > +for the operating system to consume it. CPUs receive such
> > interrupt via the
> > +thermal entry in the Local APIC's Local Vector Table.
> > +
> > +When servicing such interrupt, the HFI driver parses the updated
> > table and
> > +relays the update to userspace using the thermal notification
> > framework. Given
> > +that there may be many HFI updates every second, the updates
> > relayed to
> > +userspace are throttled at a rate of CONFIG_HZ jiffies.
> > +
> > +References
> > +----------
> > +
> > +.. [1] https://www.intel.com/sdm
> > 
> 
> 


