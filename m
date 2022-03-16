Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8091F4DB5C5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 17:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352225AbiCPQRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 12:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240622AbiCPQRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 12:17:36 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3967BBC2F
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 09:16:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647447382; x=1678983382;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DEtLWo8Ecdeq9AIs99N5iWens02agHgLncfV1oWxOY0=;
  b=iFOKtCzEghX99cx6i0uj7dBDOlpCIHUAHh3sR+5yGWB51odT97K9dFji
   RCJRhbD0DsOuPPpedPoaSwM/FcqcZUWzkkusoYnGlpGX6kVbt69i81Fvw
   niZ6LJLESdb8Ih9dTStq5aFxtD3b7fA9EL7SCvIcg55GN4QJrKWl+W7n/
   NCBpw38yTt5GSX+FuXVskWQqji4HrVaE0P0rijLrqIa7AHxSK6LlBvi83
   HPP4ojiFArz5FjJgFPNXlakn9g/9ID9aTg/UxVsYxSyI3vIW42Xu7U6IH
   G7WGXFRZZMD/vMAPC8bcfcOiAJ+HodLG0zOOBPOxszyQg6riZ2LGv07r6
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10288"; a="256601188"
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="256601188"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 09:13:26 -0700
X-IronPort-AV: E=Sophos;i="5.90,187,1643702400"; 
   d="scan'208";a="557523347"
Received: from zhaoq-mobl1.ccr.corp.intel.com (HELO chenyu5-mobl1) ([10.255.29.55])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 09:13:16 -0700
Date:   Thu, 17 Mar 2022 00:13:11 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Tim Chen <tim.c.chen@linux.intel.com>
Cc:     Abel Wu <wuyun.abel@bytedance.com>, linux-kernel@vger.kernel.org,
        Tim Chen <tim.c.chen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Barry Song <21cnbao@gmail.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Len Brown <len.brown@intel.com>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Aubrey Li <aubrey.li@intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v2][RFC] sched/fair: Change SIS_PROP to search idle CPU
 based on sum of util_avg
Message-ID: <20220316161311.GA41632@chenyu5-mobl1>
References: <20220310005228.11737-1-yu.c.chen@intel.com>
 <444bfebb-ac1c-42b9-58f5-332780e749f7@bytedance.com>
 <20220314125657.GA30418@chenyu5-mobl1>
 <87541edf7b46c1475f73cf464a9edca932f65da5.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87541edf7b46c1475f73cf464a9edca932f65da5.camel@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 10:34:30AM -0700, Tim Chen wrote:
> On Mon, 2022-03-14 at 20:56 +0800, Chen Yu wrote:
> > 
> > > 
> > > So nr_scan will probably be updated at llc-domain-lb-interval, which
> > > is llc_size milliseconds. Since load can be varied a lot during such
> > > a period, would this brought accuracy issues?
> > > 
> > I agree there might be delay in reflecting the latest utilization.
> > The sum_util calculated by periodic load balance after 112ms would be
> > decay to about 0.5 * 0.5 * 0.5 * 0.7 = 8.75%.
> > But consider that this is a server platform, I have an impression that
> > the CPU utilization jitter during a small period of time is not a regular
> > scenario? It seems to be a trade-off. Checking the util_avg in newidle
> > load balance path would be more frequent, but it also brings overhead -
> > multiple CPUs write/read the per-LLC shared variable and introduces cache
> > false sharing. But to make this more robust, maybe we can add time interval
> > control in newidle load balance too.
> > 
> > 
> 
> Also the idea is we allow ourselves to be non-optimal in terms of
> scheduling for the short term variations.  But we want to make sure that if
> there's a long term trend in the load behavior, the scheduler should
> adjust for that.  I think if you see high utilization and CPUs are
> all close to fully busy for quite a while, that is a long term trend 
> that overwhelms any short load jitters.
>
Agree. From long term trend, the scheduler should approach an optimization
status.

thanks,
Chenyu 
> Tim
> 
