Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B31446F243
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 18:40:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243144AbhLIRni (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 12:43:38 -0500
Received: from mga07.intel.com ([134.134.136.100]:26441 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243127AbhLIRng (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 12:43:36 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10193"; a="301546983"
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="301546983"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 09:40:02 -0800
X-IronPort-AV: E=Sophos;i="5.88,193,1635231600"; 
   d="scan'208";a="516405372"
Received: from braj-mobl.gar.corp.intel.com ([10.251.50.179])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2021 09:39:57 -0800
Message-ID: <10f257b0546690983a1ca7d3c3e8842c9fd98308.camel@linux.intel.com>
Subject: Re: [PATCH 6/7] thermal: netlink: Add a new event to notify CPU
 capabilities change
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        linux-pm@vger.kernel.org, x86@kernel.org,
        linux-doc@vger.kernel.org, Len Brown <len.brown@intel.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        linux-kernel@vger.kernel.org
Date:   Thu, 09 Dec 2021 09:39:53 -0800
In-Reply-To: <f31278f5-7d23-b213-0b5b-321a0d7a048a@linaro.org>
References: <20211106013312.26698-1-ricardo.neri-calderon@linux.intel.com>
         <20211106013312.26698-7-ricardo.neri-calderon@linux.intel.com>
         <b51c9b2a-40d2-6575-7746-3059eec53519@linaro.org>
         <20211209160346.GA7692@ranerica-svr.sc.intel.com>
         <f31278f5-7d23-b213-0b5b-321a0d7a048a@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-12-09 at 17:57 +0100, Daniel Lezcano wrote:
> On 09/12/2021 17:03, Ricardo Neri wrote:
> > On Tue, Nov 30, 2021 at 10:29:46AM +0100, Daniel Lezcano wrote:
> > > On 06/11/2021 02:33, Ricardo Neri wrote:
> > > > From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> > > > 
> > > > Add a new netlink event to notify change in CPU capabilities in
> > > > terms of
> > > > performance and efficiency.
> > > > 
> > > > Firmware may change CPU capabilities as a result of thermal
> > > > events in the
> > > > system or to account for changes in the TDP (thermal design
> > > > power) level.
> > > > 
> > > > This notification type will allow user space to avoid running
> > > > workloads
> > > > on certain CPUs or proactively adjust power limits to avoid
> > > > future events.
> > > > 
> > > 
> > > [ ... ]
> > > 
> > > > +       [THERMAL_GENL_ATTR_CPU_CAPABILITY_ID]   = { .type =
> > > > NLA_U32 },
> > > > +       [THERMAL_GENL_ATTR_CPU_CAPABILITY_PERF] = { .type =
> > > > NLA_U32 },
> > > > +       [THERMAL_GENL_ATTR_CPU_CAPABILITY_EFF]  = { .type =
> > > > NLA_U32 },
> > > >  };
> > > 
> > > AFAIU, 0 <= perf < 256 and 0 <= eff < 256, right?
> > > 
> > > Is the following true?
> > > 
> > >         0 <= perf + eff < 256
> > 
> > No, they are not. They are set independently.
> 
> I understand they can be set independently but is the constraint
> above
> correct? For example, can the system send perf=255 and eff=255 or
> perf=0
> and eff=0 ?
perf = 0 and eff = 0 is already the case in the current processors.
Both FF is not the case as the current generation use real performance
which can't be FF. Also it is unlikely that at max performance you have
max efficiency.

Thanks,
Srinivas

> 
> May be I misunderstood but I was expecting at least some kind of
> connection between perf and eff (when eff is high, perf is low and
> the
> opposite).
> 
> 


