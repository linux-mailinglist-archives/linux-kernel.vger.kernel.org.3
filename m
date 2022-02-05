Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2374AAA74
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 18:16:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380666AbiBERQi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 12:16:38 -0500
Received: from mga06.intel.com ([134.134.136.31]:54990 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1380656AbiBERQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 12:16:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644081396; x=1675617396;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3bioHvbnd8d7LeCkvwsSoHgNIMmlKm0ZRAuo5zZHHsI=;
  b=el+t0Z63Ls/d5u/NgTmMokCNIPe+lDIacS6voj4lpMPdkwP2Qpev1UXQ
   pt7tbrpxOyAgKcS9HpJCYPY/jPjqRwzvj94QkVltC642DLTMEbLXaxN8J
   QwluDIn19ySdCHNh3wiQ05ZjQfMXTM7yXXqFLx0x8ttHXvTDTR+aByjOB
   dq9KwcuQteCrv/DyRe75AICSpLcLWEcFbEJhiLkTQza2Uj4PRcZ01U12h
   skkZ87PWUWN0GH4oymPvrI1U6j6XKOF8cok6S7OMt9To913HsAjRFAmzN
   hZHXdnq7q8pEQ26bX8/BEEeFlEvxSuqzWGIzePFBWJUww84xOShzicz1A
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10248"; a="309270482"
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; 
   d="scan'208";a="309270482"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 09:16:36 -0800
X-IronPort-AV: E=Sophos;i="5.88,345,1635231600"; 
   d="scan'208";a="700001051"
Received: from chenyu-desktop.sh.intel.com (HELO chenyu-desktop) ([10.239.158.186])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2022 09:16:31 -0800
Date:   Sun, 6 Feb 2022 01:16:47 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Barry Song <21cnbao@gmail.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        prime.zeng@huawei.com,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        ego@linux.vnet.ibm.com, Linuxarm <linuxarm@huawei.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Guodong Xu <guodong.xu@linaro.org>
Subject: Re: [PATCH v2 2/2] sched/fair: Scan cluster before scanning LLC in
 wake-up path
Message-ID: <20220205171647.GA567616@chenyu-desktop>
References: <YfK9DSMFabjYm/MV@BLR-5CG11610CF.amd.com>
 <CAGsJ_4xL3tynB9P=rKMoX2otW4bMMU5Z-P9zSudMV3+fr2hpXw@mail.gmail.com>
 <20220128071337.GC618915@linux.vnet.ibm.com>
 <CAGsJ_4yoUONACY-j+9XxSNC0VgmdyRdHC=z87dWvZvVSASzXRQ@mail.gmail.com>
 <20220201093859.GE618915@linux.vnet.ibm.com>
 <CAGsJ_4z8cer7Y5si+J_=awQetFJZMVeaQ+RDSXQz9EGOPTGMQg@mail.gmail.com>
 <20220204073317.GG618915@linux.vnet.ibm.com>
 <CAGsJ_4xjgy3D0VzbTdmJihJ+nut_NeTEb4krh8jup4rbvTY_ww@mail.gmail.com>
 <CAGsJ_4zVEjFYoff=x=Y3i9xPxoi891x-gkfA6Lsdc+yT2ykRmQ@mail.gmail.com>
 <88e9287ef7a86f24999af00f90d6f122de024979.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88e9287ef7a86f24999af00f90d6f122de024979.camel@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 09:41:21AM -0800, Tim Chen wrote:
> On Fri, 2022-02-04 at 23:49 +1300, Barry Song wrote:
> > On Fri, Feb 4, 2022 at 11:28 PM Barry Song <21cnbao@gmail.com> wrote:
> > > On Fri, Feb 4, 2022 at 8:33 PM Srikar Dronamraju
> > > <srikar@linux.vnet.ibm.com> wrote:
> > > > * Barry Song <21cnbao@gmail.com> [2022-02-02 09:20:32]:
> > > > 
> > > > > On Tue, Feb 1, 2022 at 10:39 PM Srikar Dronamraju
> > > > > <srikar@linux.vnet.ibm.com> wrote:
> > > > > > * Barry Song <21cnbao@gmail.com> [2022-01-28 07:40:15]:
> > > > > > 
> > > > > > > On Fri, Jan 28, 2022 at 8:13 PM Srikar Dronamraju
> > > > > > > <srikar@linux.vnet.ibm.com> wrote:
> > > > > > > > * Barry Song <21cnbao@gmail.com> [2022-01-28 09:21:08]:
> > > > > > > > 
> > > > > > > > > On Fri, Jan 28, 2022 at 4:41 AM Gautham R. Shenoy
> > > > > > > > > <gautham.shenoy@amd.com> wrote:
> > > > > > > > > > On Wed, Jan 26, 2022 at 04:09:47PM +0800, Yicong Yang
> > > > > > > > > > wrote:
> > > > > > > > > > > From: Barry Song <song.bao.hua@hisilicon.com>
> > > > > > > > > > > 
> > > > > > > I am sorry I didn't get your question. Currently the code
> > > > > > > works as below:
> > > > > > > if task A wakes up task B, and task A is in LLC0 and task B
> > > > > > > is in LLC1.
> > > > > > > we will scan the cluster of A before scanning the whole
> > > > > > > LLC0, in this case,
> > > > > > > cluster of A is the closest sibling, so it is the better
> > > > > > > choice than other CPUs
> > > > > > > which are in LLC0 but not in the cluster of A.
> > > > > > 
> > > > > > Yes, this is right.
> > > > > > 
> > > > > > > But we do scan all cpus of LLC0
> > > > > > > afterwards if we fail to find an idle CPU in the cluster.
> > > > > > 
> > > > > > However my reading of the patch, before we can scan other
> > > > > > clusters within
> > > > > > the LLC (aka LLC0), we have a check in scan cluster which
> > > > > > says
> > > > > > 
> > > > > >         /* Don't ping-pong tasks in and out cluster
> > > > > > frequently */
> > > > > >         if (cpus_share_resources(target, prev_cpu))
> > > > > >            return target;
> > > > > > 
> > > > > > My reading of this is, ignore other clusters (at this point,
> > > > > > we know there
> > > > > > are no idle CPUs in this cluster. We don't know if there are
> > > > > > idle cpus in
> > > > > > them or not) if the previous CPU and target CPU happen to be
> > > > > > from the same
> > > > > > cluster. This effectively means we are given preference to
> > > > > > cache over idle
> > > > > > CPU.
> > > > > 
> > > > > Note we only ignore other cluster while prev_cpu and target are
> > > > > in same
> > > > > cluster. if the condition is false, we are not ignoring other
> > > > > cpus. typically,
> > > > > if waker is the target, and wakee is the prev_cpu, that means
> > > > > if they are
> > > > > already in one cluster, we don't stupidly spread them in
> > > > > select_idle_cpu() path
> > > > > as benchmark shows we are losing. so, yes, we are giving
> > > > > preference to
> > > > > cache over CPU.
> > > > 
> > > > We already figured out that there are no idle CPUs in this
> > > > cluster. So dont
> > > > we gain performance by picking a idle CPU/core in the
> > > > neighbouring cluster.
> > > > If there are no idle CPU/core in the neighbouring cluster, then
> > > > it does make
> > > > sense to fallback on the current cluster.
> > > 
> > > 
> 
> We may need to take into consideration the utilization and
> load average for the source and target cluster to make
> better decision of whether it is worth placing the
> task in the next cluster.  If the load of the target
> cluster is too high, it is not worth pushing the task there.
> 
> Those stats can be gathered during load balancing without adding
> overhead in the hot task wakeup path.
> 
> Chen Yu played around with cutting off the idle CPU search
> in a LLC based on such stats and he saw some good
> improvements over the default.
>
Yes, we used the sum of percpu util_avg to estimate if the LLC domain
is overloaded. If it is too busy, skip searching for an idle cpu/core in
that LLC domain. The util_avg is a metric of accumulated historic
activity, which might be more accurate than instantaneous metrics(such as
rq->nr_running) on calculating the probability of find an idle cpu.
So far this change has shown some benefits in several microbenchmarks and
OLTP benchmark when the system is quite busy. That change has introduced a
per-LLC-domain flag to indicate whether the LLC domain is oveloaded,
it seems that this flag could also be extended for cluster domain.
Maybe I could post the draft patch to see if it would be helpful for this
cluster patch serie.

thanks,
Chenyu
> Tim
> 
