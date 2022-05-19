Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB8452DCA0
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:19:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243090AbiESSTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237697AbiESSTo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:19:44 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8EA8BD18
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652984383; x=1684520383;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fUFGhBMKkfbTh5xB0/i+oE1IXEQOrkqxSXR0nKzg2Go=;
  b=bgFVP6eSXLvcTUH2EJfYnD0bLeBJLLMg75XAMfc3KwKcNZeNwqXH/POU
   IxBUGWKCNNX5AlK6Fa8ny1slRHe5l0FuEsKRawOrIPMZzZmlYMHAECEw+
   ev7mQ1kUXW+nQtelUmxpestZaXA7wrjJ/rcJg96voL+7zAW/+vreBY1jU
   DTQIChtuS/cCPUqZvdzM++85SK0A15uhe3MrUNRTth/l8D4LqpIBSvHX7
   Ilnp0VTy4Nj0iXGVzbZwg/wNSjTdVJ2oItT3ZthNfxESg2a2QMxvq3L0I
   9Jx3zvhoVWpJ83rPt/Cyj7qrF6thM34Rkr24nm392ro5SNi6xFfS1g3OS
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="252207006"
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="252207006"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 11:19:43 -0700
X-IronPort-AV: E=Sophos;i="5.91,237,1647327600"; 
   d="scan'208";a="598720227"
Received: from hzhan51-mobl.ccr.corp.intel.com (HELO chenyu5-mobl1) ([10.255.30.125])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 11:19:36 -0700
Date:   Fri, 20 May 2022 02:19:31 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Mel Gorman <mgorman@suse.de>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Barry Song <21cnbao@gmail.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Len Brown <len.brown@intel.com>,
        Ben Segall <bsegall@google.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Zhang Rui <rui.zhang@intel.com>, linux-kernel@vger.kernel.org,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH v3] sched/fair: Introduce SIS_UTIL to search idle CPU
 based on sum of util_avg
Message-ID: <20220519181931.GA23577@chenyu5-mobl1>
References: <20220428182442.659294-1-yu.c.chen@intel.com>
 <ed985eb5-abc7-34f4-7a10-e3a08800b324@amd.com>
 <20220514105544.GA20541@chenyu5-mobl1>
 <adfb65ab-8621-b6c0-bb77-39c9be3486b7@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <adfb65ab-8621-b6c0-bb77-39c9be3486b7@amd.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 04:22:34PM +0530, K Prateek Nayak wrote:
[snip] 
> I've ran the benchmark in two sets of 3 runs rebooting
> in between on each kernel version:
> 
> - tip
> 
> Test:                   tip-r0                  tip-r1                  tip-r2
>  1-groups:         4.64 (0.00 pct)         4.90 (-5.60 pct)        4.99 (-7.54 pct)
>  2-groups:         5.54 (0.00 pct)         5.56 (-0.36 pct)        5.58 (-0.72 pct)
>  4-groups:         6.24 (0.00 pct)         6.18 (0.96 pct)         6.20 (0.64 pct)
>  8-groups:         7.54 (0.00 pct)         7.50 (0.53 pct)         7.54 (0.00 pct)
> 16-groups:        10.85 (0.00 pct)        11.17 (-2.94 pct)       10.91 (-0.55 pct)
> 
> Test:                   tip-r3                  tip-r4                  tip-r5
>  1-groups:         4.68 (0.00 pct)         4.97 (-6.19 pct)        4.98 (-6.41 pct)
>  2-groups:         5.60 (0.00 pct)         5.62 (-0.35 pct)        5.66 (-1.07 pct)
>  4-groups:         6.24 (0.00 pct)         6.23 (0.16 pct)         6.24 (0.00 pct)
>  8-groups:         7.54 (0.00 pct)         7.50 (0.53 pct)         7.46 (1.06 pct)
> 16-groups:        10.81 (0.00 pct)        10.84 (-0.27 pct)       10.81 (0.00 pct)
> 
> - SIS_UTIL
> 
> 
> Test:                SIS_UTIL-r0              SIS_UTIL-r1             SIS_UTIL-r2
>  1-groups:         4.68 (0.00 pct)         5.03 (-7.47 pct)        4.96 (-5.98 pct)
>  2-groups:         5.45 (0.00 pct)         5.48 (-0.55 pct)        5.50 (-0.91 pct)
>  4-groups:         6.10 (0.00 pct)         6.07 (0.49 pct)         6.14 (-0.65 pct)
>  8-groups:         7.52 (0.00 pct)         7.51 (0.13 pct)         7.52 (0.00 pct)
> 16-groups:        11.63 (0.00 pct)        11.48 (1.28 pct)        11.51 (1.03 pct)
> 
> Test:                SIS_UTIL-r3              SIS_UTIL-r4             SIS_UTIL-r5
>  1-groups:         4.80 (0.00 pct)         5.00 (-4.16 pct)        5.06 (-5.41 pct)
>  2-groups:         5.51 (0.00 pct)         5.58 (-1.27 pct)        5.58 (-1.27 pct)
>  4-groups:         6.14 (0.00 pct)         6.11 (0.48 pct)         6.06 (1.30 pct)
>  8-groups:         7.35 (0.00 pct)         7.38 (-0.40 pct)        7.40 (-0.68 pct)
> 16-groups:        11.03 (0.00 pct)        11.29 (-2.35 pct)       11.14 (-0.99 pct)
> 
> - Comparing the best and bad data points for 16-groups with each
> kernel version:
> 
> Test:                   tip-good             SIS_UTIL-good
>  1-groups:         4.68 (0.00 pct)         4.80 (-2.56 pct)
>  2-groups:         5.60 (0.00 pct)         5.51 (1.60 pct)
>  4-groups:         6.24 (0.00 pct)         6.14 (1.60 pct)
>  8-groups:         7.54 (0.00 pct)         7.35 (2.51 pct)
> 16-groups:        10.81 (0.00 pct)        11.03 (-2.03 pct)
> 
> Test:                   tip-good             SIS_UTIL-bad
>  1-groups:         4.68 (0.00 pct)         4.68 (0.00 pct)
>  2-groups:         5.60 (0.00 pct)         5.45 (2.67 pct)
>  4-groups:         6.24 (0.00 pct)         6.10 (2.24 pct)
>  8-groups:         7.54 (0.00 pct)         7.52 (0.26 pct)
> 16-groups:        10.81 (0.00 pct)        11.63 (-7.58 pct)
> 
> Test:                   tip-bad             SIS_UTIL-good
>  1-groups:         4.90 (0.00 pct)         4.80 (2.04 pct)
>  2-groups:         5.56 (0.00 pct)         5.51 (0.89 pct)
>  4-groups:         6.18 (0.00 pct)         6.14 (0.64 pct)
>  8-groups:         7.50 (0.00 pct)         7.35 (2.00 pct)
> 16-groups:        11.17 (0.00 pct)        11.03 (1.25 pct)
> 
> Test:                   tip-bad             SIS_UTIL-bad
>  1-groups:         4.90 (0.00 pct)         4.68 (4.48 pct)
>  2-groups:         5.56 (0.00 pct)         5.45 (1.97 pct)
>  4-groups:         6.18 (0.00 pct)         6.10 (1.29 pct)
>  8-groups:         7.50 (0.00 pct)         7.52 (-0.26 pct)
> 16-groups:        11.17 (0.00 pct)        11.63 (-4.11 pct)
> 
> Hackbench consistently reports > 11 for 16-group
> case with SIS_UTIL however only once with SIS_PROP
>
Mel has mentioned that, although it is 'overloaded', the nature of hackbench
would benefit from scanning for more CPUs because there is frequent context switch,
thus there is more chance to get idle.
> > I'm thinking of taking nr_llc number into consideration to adjust the search depth,
> > something like:
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index dd52fc5a034b..39b914599dce 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -9302,6 +9302,9 @@ static inline void update_idle_cpu_scan(struct lb_env *env,
> >         llc_util_pct = (sum_util * 100) / (nr_llc * SCHED_CAPACITY_SCALE);
> >         nr_scan = (100 - (llc_util_pct * llc_util_pct / 72)) * nr_llc / 100;
> >         nr_scan = max(nr_scan, 0);
> > +       if (nr_llc <= 16 && nr_scan)
> > +               nr_scan = nr_llc;
> > +
> This will behave closer to the initial RFC on systems with smaller LLC.
> I can do some preliminary testing with this and get back to you.
> >         WRITE_ONCE(sd_share->nr_idle_scan, nr_scan);
> >  }
> >
> > I'll offline the CPUs to make it 16 CPUs per LLC, and check what hackbench behaves.
> Thank you for looking into this.
>
OK, I've done some tests and recorded the number of CPUs SIS_PROP and SIS_UTIL
want to scan(the nr).

1. 16 CPUs online, 16 groups of hackbench (total 64 threads)
   Most of time SIS_PROP would scan for 4 CPUs, while SIS_UTIL scans for 2 CPUs.

2. 112 CPUs online, 16 groups of hackbench (total 448 threads)
   Most of time SIS_PROP would scan for 4 CPUs, but there is a small part of
   SIS_PROP would scan the entire LLC, which could be time costly. 
   The number of CPUs scanned by SIS_UTIL ranges in [2, 20] and it looks like a
   Normal Distribution.

(I'll send you the plot picture offline so you can have a view of how these data
look like)

This means, for 16 CPUs case, the extrem overloaded hackbench would benefit from
scanning for more CPUs. But for 112 CPUs platform, using SIS_UTIL seems to be more
reasonable because it does not have 'jitters' to scan for the whole LLC.

Let me revise the patch according to Peter and Mel's suggestion, and send
a v4 (then cook the complementary patch to deal with system having 16
CPUs per LLC domain).

thanks,
Chenyu
> --
> Thanks and Regards,
> Prateek
> 
