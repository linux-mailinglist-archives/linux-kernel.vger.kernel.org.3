Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2CD04D8ADC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 18:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243426AbiCNRfq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 13:35:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234321AbiCNRfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 13:35:42 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BDD64CC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 10:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647279271; x=1678815271;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=12lARnYOdXgROXbSS+MaZkOzon+mKD5Cl18LhAsiZuk=;
  b=jNah4waudrkzUajrLcN3tOYWew4h4kksKfLO3fds9QW+ex0tiNjr1Y3T
   9k3RrwBwe3HMhr2DxnkjmONMK9XWwCgRspPBBMbpe5VeUT6AkZQaJzUrD
   VP8lFIEXhPvY8QakqavZ0Scslbze1Ap3uNyR9UXGEKVT/pHby/FgWNBqw
   xooLb/R7OgSAIqIRjypoNHkkIf2QUmrpO0aKcReiXCjFtAwsltxG+pOO7
   OJuDe51rJMK7pp4bKvxJIbajiO5THlPAFzEm1NRT8hFwumwFq3bYiWnnV
   kRitiSIe6ermPTcDgFClAHTe6anY2abv+cLlJ3HMg7uFvJPzffdkhwhaF
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10285"; a="316816632"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="316816632"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 10:34:31 -0700
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="497700406"
Received: from schen9-mobl.amr.corp.intel.com ([10.251.31.89])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 10:34:30 -0700
Message-ID: <87541edf7b46c1475f73cf464a9edca932f65da5.camel@linux.intel.com>
Subject: Re: [PATCH v2][RFC] sched/fair: Change SIS_PROP to search idle CPU
 based on sum of util_avg
From:   Tim Chen <tim.c.chen@linux.intel.com>
To:     Chen Yu <yu.c.chen@intel.com>, Abel Wu <wuyun.abel@bytedance.com>
Cc:     linux-kernel@vger.kernel.org, Tim Chen <tim.c.chen@intel.com>,
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
Date:   Mon, 14 Mar 2022 10:34:30 -0700
In-Reply-To: <20220314125657.GA30418@chenyu5-mobl1>
References: <20220310005228.11737-1-yu.c.chen@intel.com>
         <444bfebb-ac1c-42b9-58f5-332780e749f7@bytedance.com>
         <20220314125657.GA30418@chenyu5-mobl1>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-03-14 at 20:56 +0800, Chen Yu wrote:
> 
> > 
> > So nr_scan will probably be updated at llc-domain-lb-interval, which
> > is llc_size milliseconds. Since load can be varied a lot during such
> > a period, would this brought accuracy issues?
> > 
> I agree there might be delay in reflecting the latest utilization.
> The sum_util calculated by periodic load balance after 112ms would be
> decay to about 0.5 * 0.5 * 0.5 * 0.7 = 8.75%.
> But consider that this is a server platform, I have an impression that
> the CPU utilization jitter during a small period of time is not a regular
> scenario? It seems to be a trade-off. Checking the util_avg in newidle
> load balance path would be more frequent, but it also brings overhead -
> multiple CPUs write/read the per-LLC shared variable and introduces cache
> false sharing. But to make this more robust, maybe we can add time interval
> control in newidle load balance too.
> 
> 

Also the idea is we allow ourselves to be non-optimal in terms of
scheduling for the short term variations.  But we want to make sure that if
there's a long term trend in the load behavior, the scheduler should
adjust for that.  I think if you see high utilization and CPUs are
all close to fully busy for quite a while, that is a long term trend 
that overwhelms any short load jitters.

Tim

