Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0A465270C5
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 12:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231281AbiENK6H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 06:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbiENKz7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 06:55:59 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC40A25D7
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 03:55:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652525757; x=1684061757;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Fh3jbsN6+d2NuAagIK+PSegA40s1Lj/BKMbhZvKFGXw=;
  b=NJomaH824Sv/dzSabY4VRY54pF4lQNE8bnbv5ALFSMx/9+LGdD4/xX/z
   DWpGkP9iLM8dStqPEepnHdHpVY1n6cyowkd3vhwSplpVncQkfNQpq7INq
   bVngABAR7xFPikeAfvHosDoQNP0T5zTDGVPInfbKP2TRGkLAGdQTeShgp
   dRUnM+CWqqoWRvkklb3bpHw7Y+zoCobLFr9ikO/gyfL2oJFZxHtHQ9caV
   Jw4NdsUH8w7jZrQd3x2IxyOQxQJ8FpqSV9TJci/GeMQErt17QYEZLy23C
   WZz14vIc6OpDv4uh/XnA95oi1nf+GroNYWqkql0WNzECdC2SL+imRVtFM
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="250403535"
X-IronPort-AV: E=Sophos;i="5.91,226,1647327600"; 
   d="scan'208";a="250403535"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2022 03:55:57 -0700
X-IronPort-AV: E=Sophos;i="5.91,226,1647327600"; 
   d="scan'208";a="595652181"
Received: from huifangj-mobl1.ccr.corp.intel.com (HELO chenyu5-mobl1) ([10.255.28.193])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2022 03:55:49 -0700
Date:   Sat, 14 May 2022 18:55:44 +0800
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
Message-ID: <20220514105544.GA20541@chenyu5-mobl1>
References: <20220428182442.659294-1-yu.c.chen@intel.com>
 <ed985eb5-abc7-34f4-7a10-e3a08800b324@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ed985eb5-abc7-34f4-7a10-e3a08800b324@amd.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prateek,
On Fri, May 13, 2022 at 12:07:00PM +0530, K Prateek Nayak wrote:
> Hello Chenyu,
> 
> Sorry for the delay with analysis.
>
Thanks very much for the test and analysis in detail.
> 
> Following are the results from dual socket Zen3 platform (2 x 64C/128T) running with
> various NPS configuration:
May I know if in all NPS mode, all LLC domains have 16 CPUs?
> 
> Following is the NUMA configuration for each NPS mode on the system:
> 
> NPS1: Each socket is a NUMA node.
>     Total 2 NUMA nodes in the dual socket machine.
> 
>     Node 0: 0-63,   128-191
>     Node 1: 64-127, 192-255
> 
> NPS2: Each socket is further logically divided into 2 NUMA regions.
>     Total 4 NUMA nodes exist over 2 socket.
>    
>     Node 0: 0-31,   128-159
>     Node 1: 32-63,  160-191
>     Node 2: 64-95,  192-223
>     Node 3: 96-127, 223-255
> 
> NPS4: Each socket is logically divided into 4 NUMA regions.
>     Total 8 NUMA nodes exist over 2 socket.
>    
>     Node 0: 0-15,    128-143
>     Node 1: 16-31,   144-159
>     Node 2: 32-47,   160-175
>     Node 3: 48-63,   176-191
>     Node 4: 64-79,   192-207
>     Node 5: 80-95,   208-223
>     Node 6: 96-111,  223-231
>     Node 7: 112-127, 232-255
> 
> Kernel versions:
> - tip:      5.18-rc1 tip sched/core
> - SIS_UTIL:    5.18-rc1 tip sched/core + this patch
> 
> When we began testing, tip was at:
> 
> commit: a658353167bf "sched/fair: Revise comment about lb decision matrix"
> 
> Following are the results from the benchmark:
> 
> * - Data points of concern
> 
> ~~~~~~~~~
> hackbench
> ~~~~~~~~~
> 
> NPS1
> 
> Test:                   tip                     SIS_UTIL
>  1-groups:         4.64 (0.00 pct)         4.70 (-1.29 pct)
>  2-groups:         5.38 (0.00 pct)         5.45 (-1.30 pct)
>  4-groups:         6.15 (0.00 pct)         6.10 (0.81 pct)
>  8-groups:         7.42 (0.00 pct)         7.42 (0.00 pct)
> 16-groups:        10.70 (0.00 pct)        11.69 (-9.25 pct)  *
> 
> NPS2
> 
> Test:                   tip                     SIS_UTIL
>  1-groups:         4.70 (0.00 pct)         4.70 (0.00 pct)
>  2-groups:         5.45 (0.00 pct)         5.46 (-0.18 pct)
>  4-groups:         6.13 (0.00 pct)         6.05 (1.30 pct)
>  8-groups:         7.30 (0.00 pct)         7.05 (3.42 pct)
> 16-groups:        10.30 (0.00 pct)        10.12 (1.74 pct)
> 
> NPS4
> 
> Test:                   tip                     SIS_UTIL
>  1-groups:         4.60 (0.00 pct)         4.75 (-3.26 pct)  *
>  2-groups:         5.41 (0.00 pct)         5.42 (-0.18 pct)
>  4-groups:         6.12 (0.00 pct)         6.00 (1.96 pct)
>  8-groups:         7.22 (0.00 pct)         7.10 (1.66 pct)
> 16-groups:        10.24 (0.00 pct)        10.11 (1.26 pct)
> 
> ~~~~~~~~
> schbench
> ~~~~~~~~
> 
> NPS 1
> 
> #workers:   tip                     SIS_UTIL
>   1:      29.00 (0.00 pct)        21.00 (27.58 pct)
>   2:      28.00 (0.00 pct)        28.00 (0.00 pct)
>   4:      31.50 (0.00 pct)        31.00 (1.58 pct)
>   8:      42.00 (0.00 pct)        39.00 (7.14 pct)
>  16:      56.50 (0.00 pct)        54.50 (3.53 pct)
>  32:      94.50 (0.00 pct)        94.00 (0.52 pct)
>  64:     176.00 (0.00 pct)       175.00 (0.56 pct)
> 128:     404.00 (0.00 pct)       394.00 (2.47 pct)
> 256:     869.00 (0.00 pct)       863.00 (0.69 pct)
> 512:     58432.00 (0.00 pct)     55424.00 (5.14 pct)
> 
> NPS2
> 
> #workers:      tip                     SIS_UTIL
>   1:      26.50 (0.00 pct)        25.00 (5.66 pct)
>   2:      26.50 (0.00 pct)        25.50 (3.77 pct)
>   4:      34.50 (0.00 pct)        34.00 (1.44 pct)
>   8:      45.00 (0.00 pct)        46.00 (-2.22 pct)
>  16:      56.50 (0.00 pct)        60.50 (-7.07 pct)        *
>  32:      95.50 (0.00 pct)        93.00 (2.61 pct)
>  64:     179.00 (0.00 pct)       179.00 (0.00 pct)
> 128:     369.00 (0.00 pct)       376.00 (-1.89 pct)
> 256:     898.00 (0.00 pct)       903.00 (-0.55 pct)
> 512:     56256.00 (0.00 pct)     57088.00 (-1.47 pct)
> 
> NPS4
> 
> #workers:    tip                     SIS_UTIL
>   1:      25.00 (0.00 pct)        21.00 (16.00 pct)
>   2:      28.00 (0.00 pct)        24.00 (14.28 pct)
>   4:      29.50 (0.00 pct)        29.50 (0.00 pct)
>   8:      41.00 (0.00 pct)        37.50 (8.53 pct)
>  16:      65.50 (0.00 pct)        64.00 (2.29 pct)
>  32:      93.00 (0.00 pct)        94.50 (-1.61 pct)
>  64:     170.50 (0.00 pct)       175.50 (-2.93 pct)
> 128:     377.00 (0.00 pct)       368.50 (2.25 pct)
> 256:     867.00 (0.00 pct)       902.00 (-4.03 pct)
> 512:     58048.00 (0.00 pct)     55488.00 (4.41 pct)
> 
> ~~~~~~
> tbench
> ~~~~~~
> 
> NPS 1
> 
> Clients:     tip                     SIS_UTIL
>     1    443.31 (0.00 pct)       456.19 (2.90 pct)
>     2    877.32 (0.00 pct)       875.24 (-0.23 pct)
>     4    1665.11 (0.00 pct)      1647.31 (-1.06 pct)
>     8    3016.68 (0.00 pct)      2993.23 (-0.77 pct)
>    16    5374.30 (0.00 pct)      5246.93 (-2.36 pct)
>    32    8763.86 (0.00 pct)      7878.18 (-10.10 pct)     *
>    64    15786.93 (0.00 pct)     12958.47 (-17.91 pct)    *
>   128    26826.08 (0.00 pct)     26741.14 (-0.31 pct)
>   256    24207.35 (0.00 pct)     52041.89 (114.98 pct)
>   512    51740.58 (0.00 pct)     52084.44 (0.66 pct)
>  1024    51177.82 (0.00 pct)     53126.29 (3.80 pct)
> 
> NPS 2
> 
> Clients:     tip                     SIS_UTIL
>     1    449.49 (0.00 pct)       447.96 (-0.34 pct)
>     2    867.28 (0.00 pct)       869.52 (0.25 pct)
>     4    1643.60 (0.00 pct)      1625.91 (-1.07 pct)
>     8    3047.35 (0.00 pct)      2952.82 (-3.10 pct)
>    16    5340.77 (0.00 pct)      5251.41 (-1.67 pct)
>    32    10536.85 (0.00 pct)     8843.49 (-16.07 pct)     *
>    64    16543.23 (0.00 pct)     14265.35 (-13.76 pct)    *
>   128    26400.40 (0.00 pct)     25595.42 (-3.04 pct)
>   256    23436.75 (0.00 pct)     47090.03 (100.92 pct)
>   512    50902.60 (0.00 pct)     50036.58 (-1.70 pct)
>  1024    50216.10 (0.00 pct)     50639.74 (0.84 pct)
> 
> NPS 4
> 
> Clients:     tip                     SIS_UTIL
>     1    443.82 (0.00 pct)       459.93 (3.62 pct)
>     2    849.14 (0.00 pct)       882.17 (3.88 pct)
>     4    1603.26 (0.00 pct)      1629.64 (1.64 pct)
>     8    2972.37 (0.00 pct)      3003.09 (1.03 pct)
>    16    5277.13 (0.00 pct)      5234.07 (-0.81 pct)
>    32    9744.73 (0.00 pct)      9347.90 (-4.07 pct)      *
>    64    15854.80 (0.00 pct)     14180.27 (-10.56 pct)    *
>   128    26116.97 (0.00 pct)     24597.45 (-5.81 pct)     *
>   256    22403.25 (0.00 pct)     47385.09 (111.50 pct)
>   512    48317.20 (0.00 pct)     49781.02 (3.02 pct)
>  1024    50445.41 (0.00 pct)     51607.53 (2.30 pct)
> 
> ~~~~~~
> Stream
> ~~~~~~
> 
> - 10 runs
> 
> NPS1
> 
>               tip                     SIS_UTIL
>  Copy:   189113.11 (0.00 pct)    188490.27 (-0.32 pct)
> Scale:   201190.61 (0.00 pct)    204526.15 (1.65 pct)
>   Add:   232654.21 (0.00 pct)    234948.01 (0.98 pct)
> Triad:   226583.57 (0.00 pct)    228844.43 (0.99 pct)
> 
> NPS2
> 
> Test:         tip                     SIS_UTIL
>  Copy:   155347.14 (0.00 pct)    169386.29 (9.03 pct)
> Scale:   191701.53 (0.00 pct)    196110.51 (2.29 pct)
>   Add:   210013.97 (0.00 pct)    221088.45 (5.27 pct)
> Triad:   207602.00 (0.00 pct)    218072.52 (5.04 pct)
> 
> NPS4
> 
> Test:         tip                     SIS_UTIL
>  Copy:   136421.15 (0.00 pct)    140894.11 (3.27 pct)
> Scale:   191217.59 (0.00 pct)    190554.17 (-0.34 pct)
>   Add:   189229.52 (0.00 pct)    190871.88 (0.86 pct)
> Triad:   188052.99 (0.00 pct)    188417.63 (0.19 pct)
> 
> - 100 runs
> 
> NPS1
> 
> Test:       tip                     SIS_UTIL
>  Copy:   244693.32 (0.00 pct)    232328.05 (-5.05 pct)
> Scale:   221874.99 (0.00 pct)    216858.39 (-2.26 pct)
>   Add:   268363.89 (0.00 pct)    265449.16 (-1.08 pct)
> Triad:   260945.24 (0.00 pct)    252240.56 (-3.33 pct)
> 
> NPS2
> 
> Test:       tip                     SIS_UTIL
>  Copy:   211262.00 (0.00 pct)    225240.03 (6.61 pct)
> Scale:   222493.34 (0.00 pct)    219094.65 (-1.52 pct)
>   Add:   280277.17 (0.00 pct)    275677.73 (-1.64 pct)
> Triad:   265860.49 (0.00 pct)    262584.22 (-1.23 pct)
> 
> NPS4
> 
> Test:       tip                     SIS_UTIL
>  Copy:   250171.40 (0.00 pct)    230983.60 (-7.66 pct)
> Scale:   222293.56 (0.00 pct)    215984.34 (-2.83 pct)
>   Add:   279222.16 (0.00 pct)    270402.64 (-3.15 pct)
> Triad:   262013.92 (0.00 pct)    254820.60 (-2.74 pct)
> 
> ~~~~~~~~~~~~
> ycsb-mongodb
> ~~~~~~~~~~~~
> 
> NPS1
> 
> sched-tip:      303718.33 (var: 1.31)
> SIS_UTIL:       303529.33 (var: 0.67)    (-0.06%)
> 
> NPS2
> 
> sched-tip:      304536.33 (var: 2.46)
> SIS_UTIL:       303730.33 (var: 1.57)    (-0.26%)
> 
> NPS4
> 
> sched-tip:      301192.33 (var: 1.81)
> SIS_UTIL:       300101.33 (var: 0.35)   (-0.36%)
> 
> ~~~~~~~~~~~~~~~~~~
> 
> Notes:
> 
> - There seems to be some noticeable regression for hackbench
>   with 16 groups in NPS1 mode.
Did the hackbench use the default fd number(20) in every group? If
this is the case, then there are 16 * 20 * 2 = 640 threads in the
system. I thought this should be overloaded, either in SIS_PROP or
SIS_UTIL, the search depth might be 4 and 0 respectively. And it
is also very likely the SIS_PROP will not find an idle CPU after
searching for 4 CPUs. So in theory there should be not much performance
difference with vs without the patch applied. But if the fd number is set
to a smaller one, the regression could be explained as you mentioned,
SIS_PROP search more aggressively.
> - There seems to be regression in tbench for case with number
>   of workers in range 32-128 (12.5% loaded to 50% loaded)
> - tbench reaches saturation early when system is fully loaded
> 
> This probably show that the strategy in the initial v1 RFC
> seems to work better with our LLC where number of CPUs per LLC
> is low compared to systems with unified LLC. Given this is
> showing great results for unified LLC, maybe SIS_PROP and SIS_UTIL
> can be enabled based on the the size of LLC.
> 
Yes, SIS_PROP searches more aggressively, but we attempts to replace
SIS_PROP with a more accurate policy.
> > [..snip..]
> >
> > [3]
> > Prateek mentioned that we should scan aggressively in an LLC domain
> > with 16 CPUs. Because the cost to search for an idle one among 16 CPUs is
> > negligible. The current patch aims to propose a generic solution and only
> > considers the util_avg. A follow-up change could enhance the scan policy
> > to adjust the scan_percent according to the CPU number in LLC.
> 
> Following are some additional numbers I would like to share comparing SIS_PROP and
> SIS_UTIL:
> 
Nice analysis.
> o Hackbench with 1 group
> 
> With 1 group, following are the chances of SIS_PROP
> and SIS_UTIL finding an idle CPU when an idle CPU
> exists in LLC:
> 
> +-----------------+---------------------------+---------------------------+--------+
> | Idle CPU in LLC | SIS_PROP able to find CPU | SIS_UTIL able to find CPU | Count  |
> +-----------------+---------------------------+---------------------------+--------+
> |        1        |             0             |             0             | 66444  |
> |        1        |             0             |             1             | 34153  |
> |        1        |             1             |             0             | 57204  |
> |        1        |             1             |             1             | 119263 |
> +-----------------+---------------------------+---------------------------+--------+
> 
So SIS_PROP searches more, and get higher chance to find an idle CPU in a LLC with
16 CPUs.
> SIS_PROP vs no SIS_PROP CPU search stats:
> 
> Total time without SIS_PROP: 90653653
> Total time with SIS_PROP: 53558942 (-40.92 pct)
> Total time saved: 37094711
> 
What does no SIS_PROP mean? Is it with SIS_PROP disabled and
SIS_UTIL enabled? Or with both SIS_PROP and SIS_UTIL disabled?
If it is the latter, is there any performance difference between
the two?
> Following are number of CPUs SIS_UTIL will search when SIS_PROP limit >= 16 (LLC size):
> 
> +--------------+-------+
> | CPU Searched | Count |
> +--------------+-------+
> |      0       | 10520 |
> |      1       |  7770 |
> |      2       | 11976 |
> |      3       | 17554 |
> |      4       | 13932 |
> |      5       | 15051 |
> |      6       |  8398 |
> |      7       |  4544 |
> |      8       |  3712 |
> |      9       |  2337 |
> |      10      |  4541 |
> |      11      |  1947 |
> |      12      |  3846 |
> |      13      |  3645 |
> |      14      |  2686 |
> |      15      |  8390 |
> |      16      | 26157 |
> +--------------+-------+
> 
> - SIS_UTIL might be bailing out too early in some of these cases.
>
Right. 
> o Hackbench with 16 group
> 
> the success rate looks as follows:
> 
> +-----------------+---------------------------+---------------------------+---------+
> | Idle CPU in LLC | SIS_PROP able to find CPU | SIS_UTIL able to find CPU |  Count  |
> +-----------------+---------------------------+---------------------------+---------+
> |        1        |             0             |             0             | 1313745 |
> |        1        |             0             |             1             |  694132 |
> |        1        |             1             |             0             | 2888450 |
> |        1        |             1             |             1             | 5343065 |
> +-----------------+---------------------------+---------------------------+---------+
> 
> SIS_PROP vs no SIS_PROP CPU search stats:
> 
> Total time without SIS_PROP: 5227299388
> Total time with SIS_PROP: 3866575188 (-26.03 pct)
> Total time saved: 1360724200
> 
> Following are number of CPUs SIS_UTIL will search when SIS_PROP limit >= 16 (LLC size):
> 
> +--------------+---------+
> | CPU Searched |  Count  |
> +--------------+---------+
> |      0       |  150351 |
> |      1       |  105116 |
> |      2       |  214291 |
> |      3       |  440053 |
> |      4       |  914116 |
> |      5       | 1757984 |
> |      6       | 2410484 |
> |      7       | 1867668 |
> |      8       |  379888 |
> |      9       |  84055  |
> |      10      |  55389  |
> |      11      |  26795  |
> |      12      |  43113  |
> |      13      |  24579  |
> |      14      |  32896  |
> |      15      |  70059  |
> |      16      |  150858 |
> +--------------+---------+
> 
> - SIS_UTIL might be bailing out too early in most of these cases
> 
It might be interesting to see what the current sum of util_avg is, and this suggested that,
even if util_avg is a little high, it might be still be worthwhile to search more CPUs.
> o tbench with 256 workers
> 
> For tbench with 256 threads, SIS_UTIL works great as we have drastically cut down the number
> of CPUs to search.
> 
> SIS_PROP vs no SIS_PROP CPU search stats:
> 
> Total time without SIS_PROP: 64004752959
> Total time with SIS_PROP: 34695004390 (-45.79 pct)
> Total time saved: 29309748569
> 
> Following are number of CPUs SIS_UTIL will search when SIS_PROP limit >= 16 (LLC size):
> 
> +--------------+----------+
> | CPU Searched |  Count   |
> +--------------+----------+
> |      0       |  500077  |
> |      1       |  543865  |
> |      2       | 4257684  |
> |      3       | 27457498 |
> |      4       | 40208673 |
> |      5       | 3264358  |
> |      6       |  191631  |
> |      7       |  24658   |
> |      8       |   2469   |
> |      9       |   1374   |
> |      10      |   2008   |
> |      11      |   1300   |
> |      12      |   1226   |
> |      13      |   1179   |
> |      14      |   1631   |
> |      15      |  11678   |
> |      16      |   7793   |
> +--------------+----------+
> 
> - This is where SIS_UTIL shines for tbench case with 256 workers as it is effective
>   at restricting search space well.
> 
> o Observations
> 
> SIS_PROP seems to have a higher chance of finding an idle CPU compared to SIS_UTIL
> in case of hackbench with 16-group. The gap between SIS_PROP and SIS_UTIL is wider
> with 16 groups compared to than with 1 group.
> Also SIS_PROP is more aggressive at saving time for 1-group compared to the
> case with 16-groups.
> 
> The bailout from SIS_UTIL is fruitful for tbench with 256 workers leading to massive
> performance gain in a fully loaded system.
> 
> Note: There might be some inaccuracies for the numbers presented for metrics that
> directly compare SIS_PROP and SIS_UTIL as both SIS_PROP and SIS_UTIL were enabled
> when gathering these data points and the results from SIS_PROP were returned from
> search_idle_cpu().
Do you mean the 'CPU Searched' calculated by SIS_PROP was collected with both SIS_UTIL
and SIS_PROP enabled?
> All the numbers for the above analysis were gathered in NPS1 mode.
> 
I'm thinking of taking nr_llc number into consideration to adjust the search depth,
something like:
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index dd52fc5a034b..39b914599dce 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9302,6 +9302,9 @@ static inline void update_idle_cpu_scan(struct lb_env *env,
        llc_util_pct = (sum_util * 100) / (nr_llc * SCHED_CAPACITY_SCALE);
        nr_scan = (100 - (llc_util_pct * llc_util_pct / 72)) * nr_llc / 100;
        nr_scan = max(nr_scan, 0);
+       if (nr_llc <= 16 && nr_scan)
+               nr_scan = nr_llc;
+
        WRITE_ONCE(sd_share->nr_idle_scan, nr_scan);
 }

I'll offline the CPUs to make it 16 CPUs per LLC, and check what hackbench behaves.

thanks,
Chenyu
