Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D806559992
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 14:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiFXMSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 08:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiFXMSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 08:18:42 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A79910547
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 05:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656073121; x=1687609121;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=517H1yHK+nS4fYXm61DYKdd+jOnnRIOAzK1KRZWOQGA=;
  b=E+g5uVb8aXWRawUxyY+D8VKXqdWuB/Hfp05fs4SCYilSSjnmgmX8Q5vy
   jcj0dDt027MJ0pAvmyVKB8W+BiEa8+SgV3hCt/Y8ep9RDZ0ltdl8c2RA4
   Y5tcuSMBEcBqs9csU0OpwFccBJwClxYdh8pwzpx5eXQfM9/y6Zu1rxt09
   eTcEe66saxk0cEBDJPcYGUsqSrDzpnktLwan0Hd9ZFDqDMWg7bZGa6Oaa
   jOR/h7/kOiLjPv3ySJ75zv8qyI6UyXUiJk7Asyh1w/bxfjMrDiaw0uzyt
   2VzbQIJ/7m51e7g63Tvo/5/vcA7rG+33APY7GQZnVzidUE7s+XZ5RI3eR
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="281032213"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="281032213"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 05:18:41 -0700
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="645250458"
Received: from cma16-mobl1.ccr.corp.intel.com (HELO chenyu5-mobl1) ([10.255.29.162])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2022 05:18:35 -0700
Date:   Fri, 24 Jun 2022 20:18:31 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     K Prateek Nayak <kprateek.nayak@amd.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>, Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Barry Song <21cnbao@gmail.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Len Brown <len.brown@intel.com>,
        Ben Segall <bsegall@google.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Tim Chen <tim.c.chen@intel.com>, linux-kernel@vger.kernel.org,
        Yicong Yang <yangyicong@hisilicon.com>,
        Mohini Narkhede <mohini.narkhede@intel.com>
Subject: Re: [PATCH v4] sched/fair: Introduce SIS_UTIL to search idle CPU
 based on sum of util_avg
Message-ID: <20220624121831.GA5570@chenyu5-mobl1>
References: <20220612163428.849378-1-yu.c.chen@intel.com>
 <76c94a3b-6ca2-e0e2-c618-42b147d2737d@amd.com>
 <YrVn9t2kLHB21uG1@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YrVn9t2kLHB21uG1@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 09:29:58AM +0200, Peter Zijlstra wrote:
> On Wed, Jun 22, 2022 at 12:06:55PM +0530, K Prateek Nayak wrote:
> > Hello Chenyu,
> > 
> > I'm sorry for the delay. The testing took a while but below are
> > the results from testing on our system.
> > 
> > tl;dr
> > 
> > o We ran all the tests with with SIS_PROP disabled.
> > o tbench reaches close to saturation early with 256 clients.
> > o schbench shows improvements for low worker counts.
> > o All other benchmark results seem comparable to tip.
> >   We don't see any serious regressions with v4.
> > 
> > > @@ -61,6 +61,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
> > >   * When doing wakeups, attempt to limit superfluous scans of the LLC domain.
> > >   */
> > >  SCHED_FEAT(SIS_PROP, true)
> > 
> > SIS_PROP was disabled in our testing as follows:
> > 
> > --
> > -SCHED_FEAT(SIS_PROP, true)
> > +SCHED_FEAT(SIS_PROP, false)
> 
> So how about I make this change.
> 
> > With v4 on the current tip, I don't see any need for
> > a special case for systems with smaller LLCs with
> > SIS_PROP disabled and SIS_UITL enable. Even SIS Efficiency
> > seems to be better with SIS_UTIL for hackbench.
> > 
> > Tested-by: K Prateek Nayak <kprateek.nayak@amd.com> 
> 
> And apply this thing, lets see how it fares..

OK, thanks, Peter.


Best,
Chenyu
