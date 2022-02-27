Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F7B14C58FF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 04:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiB0DDM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 22:03:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229716AbiB0DDI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 22:03:08 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05B7431516
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 19:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645930951; x=1677466951;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RZtY4KfMrV6LxVmaxP+PC0sKaj8p5O2CLZ0tkqMstJ8=;
  b=oKv1qkh0LFYTcWjDiyvva14oUegVKq7SNcDimhpU1OFCVS8dfkbTe1XB
   OYYqCM+iHmmzHNbN+JLUSS4aCwXKZGSsYnP0uVlUlfhG2apQ+CnAJvI55
   sjUUmGS8KVZx31hmtKxQwVCZfdX/BGbSx4kzptrdZmoAkksA1Jkw0ZYFN
   ZcpU4vpABTgvCT8hIMaEl4SH7pVxBLbwBSpJMbYLUN+2k1c8gmsflKP6w
   RpoZ11jORjTR9AKwvs8a6c1JV4K8WVomS6DoXcG50VaoKPRz5M4a/78Kn
   L7au1+nC4tN2w44k/6d/wI26SeNx3/6MTj+s8a/jv5wsuCPEoiXsZGADz
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10270"; a="339136134"
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="339136134"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 19:02:31 -0800
X-IronPort-AV: E=Sophos;i="5.90,140,1643702400"; 
   d="scan'208";a="549782462"
Received: from chenyu-dev.sh.intel.com (HELO chenyu-dev) ([10.239.158.61])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2022 19:02:26 -0800
Date:   Sun, 27 Feb 2022 11:02:09 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     Tim Chen <tim.c.chen@intel.com>, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Barry Song <21cnbao@gmail.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Yicong Yang <yangyicong@hisilicon.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Aubrey Li <aubrey.li@intel.com>,
        Len Brown <len.brown@intel.com>,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH][RFC] sched: Stop searching for idle cpu if the LLC
 domain is overloaded
Message-ID: <20220227030209.GA90484@chenyu-dev>
References: <20220207034013.599214-1-yu.c.chen@intel.com>
 <4ca9ba48-20f0-84d5-6a38-11f9d4c7a028@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4ca9ba48-20f0-84d5-6a38-11f9d4c7a028@amd.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Prateek,
On Wed, Feb 23, 2022 at 03:35:35PM +0530, K Prateek Nayak wrote:
> Hello Chenyu,
> 
> On 2/7/2022 9:10 AM, Chen Yu wrote:
> > [Problem Statement]
> > Searching for an idle cpu/core in a LLC domain is time consuming
> > when the LLC domain is relatively busy. Even worse, it is possible
> > that after iterating the whole LLC domain, it might still
> > fail to find an idle cpu/core.
> 
> We tested the patch running some standard benchmark on a dual
> socket AMD Zen3 system (2 x 64C/128T). Following are the results
> comparing the results seen on tip/sched/core (sched-tip) and
> tip/sched/core + this patch (util-avg)
> 
> ~~~~~~~~~
> hackbench
> ~~~~~~~~~
> 
> NPS Mode - NPS1
> Test:                   sched-tip                util-avg
>  1-groups:         4.97 (0.00 pct)         5.06 (-1.81 pct)
>  2-groups:         5.71 (0.00 pct)         5.65 (1.05 pct)
>  4-groups:         6.33 (0.00 pct)         6.22 (1.73 pct)
>  8-groups:         7.93 (0.00 pct)         7.77 (2.01 pct)
> 16-groups:        12.35 (0.00 pct)        11.75 (4.85 pct)
> 
> NPS Mode - NPS2
> Test:                   sched-tip                util-avg
>  1-groups:         4.87 (0.00 pct)         4.97 (-2.05 pct)
>  2-groups:         5.43 (0.00 pct)         5.39 (0.73 pct)
>  4-groups:         6.07 (0.00 pct)         5.94 (2.14 pct)
>  8-groups:         7.46 (0.00 pct)         7.39 (0.93 pct)
> 16-groups:        10.27 (0.00 pct)        10.07 (1.94 pct)
> 
> NPS Mode - NPS4
> Test:                   sched-tip                util-avg
>  1-groups:         4.87 (0.00 pct)         4.89 (-0.41 pct)
>  2-groups:         5.40 (0.00 pct)         5.48 (-1.48 pct)
>  4-groups:         6.15 (0.00 pct)         6.17 (-0.32 pct)
>  8-groups:         7.63 (0.00 pct)         7.53 (1.31 pct)
> 16-groups:        10.24 (0.00 pct)         9.89 (3.41 pct)
> 
> ~~~~~~~~
> schbench
> ~~~~~~~~
> 
> NPS Mode - NPS1
> #workers:       sched-tip                util-avg
>   1:      13.00 (0.00 pct)        14.50 (-11.53 pct)
>   2:      31.50 (0.00 pct)        34.00 (-7.93 pct)
>   4:      43.50 (0.00 pct)        37.50 (13.79 pct)
>   8:      56.00 (0.00 pct)        50.50 (9.82 pct)
>  16:      69.50 (0.00 pct)        68.50 (1.43 pct)
>  32:     107.00 (0.00 pct)       106.50 (0.46 pct)
>  64:     191.00 (0.00 pct)       191.50 (-0.26 pct)
> 128:     413.50 (0.00 pct)       408.50 (1.20 pct)
> 256:     950.00 (0.00 pct)       947.00 (0.31 pct)
> 512:     60352.00 (0.00 pct)     60288.00 (0.10 pct)
> 
> NPS Mode - NPS2
> #workers:       sched-tip              util-avg
>   1:      11.50 (0.00 pct)        11.00 (4.34 pct)
>   2:      26.00 (0.00 pct)        30.00 (-15.38 pct)
>   4:      36.00 (0.00 pct)        39.00 (-8.33 pct)
>   8:      57.50 (0.00 pct)        49.50 (13.91 pct)
>  16:      68.50 (0.00 pct)        69.00 (-0.72 pct)
>  32:     105.50 (0.00 pct)       104.50 (0.94 pct)
>  64:     192.50 (0.00 pct)       189.50 (1.55 pct)
> 128:     403.50 (0.00 pct)       430.00 (-6.56 pct)
> 256:     945.00 (0.00 pct)       957.00 (-1.26 pct)
> 512:     60288.00 (0.00 pct)     60224.00 (0.10 pct)
> 
> NPS Mode - NPS4
> #workers:      sched-tip               util-avg
>   1:      12.50 (0.00 pct)        11.50 (8.00 pct)
>   2:      29.00 (0.00 pct)        23.00 (20.68 pct)
>   4:      28.50 (0.00 pct)        29.50 (-3.50 pct)
>   8:      45.00 (0.00 pct)        46.50 (-3.33 pct)
>  16:      74.00 (0.00 pct)        84.00 (-13.51 pct)
>  32:     110.50 (0.00 pct)       108.50 (1.80 pct)
>  64:     198.00 (0.00 pct)       191.50 (3.28 pct)
> 128:     434.00 (0.00 pct)       418.00 (3.68 pct)
> 256:     964.00 (0.00 pct)       952.00 (1.24 pct)
> 512:     60352.00 (0.00 pct)     60352.00 (0.00 pct)
> 
> ~~~~~~
> tbench
> ~~~~~~
> 
> NPS Mode - NPS1
> Clients:        sched-tip               util-avg
>     1    475.40 (0.00 pct)       480.46 (1.06 pct)
>     2    939.62 (0.00 pct)       929.13 (-1.11 pct)
>     4    1767.75 (0.00 pct)      1798.94 (1.76 pct)
>     8    3315.70 (0.00 pct)      3231.78 (-2.53 pct)
>    16    5887.79 (0.00 pct)      6037.36 (2.54 pct)
>    32    10202.20 (0.00 pct)     10223.65 (0.21 pct)
>    64    16816.42 (0.00 pct)     17122.40 (1.81 pct)
>   128    28423.90 (0.00 pct)     28680.46 (0.90 pct)
>   256    26726.29 (0.00 pct)     52502.83 (96.44 pct)
>   512    53082.43 (0.00 pct)     53635.54 (1.04 pct)
>  1024    52940.64 (0.00 pct)     53051.05 (0.20 pct)
> 
> NPS Mode - NPS2
> Clients:        sched-tip               util-avg
>     1    481.84 (0.00 pct)       479.67 (-0.45 pct)
>     2    941.13 (0.00 pct)       927.93 (-1.40 pct)
>     4    1797.61 (0.00 pct)      1770.86 (-1.48 pct)
>     8    3353.37 (0.00 pct)      3360.29 (0.20 pct)
>    16    5779.49 (0.00 pct)      5925.27 (2.52 pct)
>    32    10810.27 (0.00 pct)     10855.17 (0.41 pct)
>    64    17046.83 (0.00 pct)     17457.64 (2.40 pct)
>   128    28799.32 (0.00 pct)     28855.49 (0.19 pct)
>   256    27654.49 (0.00 pct)     47126.18 (70.41 pct)
>   512    51831.52 (0.00 pct)     51219.55 (-1.18 pct)
>  1024    52579.87 (0.00 pct)     50213.68 (-4.50 pct)
> 
> NPS Mode - NPS4
> Clients:        sched-tip               util-avg
>     1    474.08 (0.00 pct)       478.40 (0.91 pct)
>     2    928.23 (0.00 pct)       937.76 (1.02 pct)
>     4    1754.78 (0.00 pct)      1741.17 (-0.77 pct)
>     8    3219.31 (0.00 pct)      3318.00 (3.06 pct)
>    16    5791.53 (0.00 pct)      5687.78 (-1.79 pct)
>    32    9810.76 (0.00 pct)      10866.32 (10.75 pct)
>    64    17098.46 (0.00 pct)     17203.60 (0.61 pct)
>   128    28575.94 (0.00 pct)     28020.97 (-1.94 pct)
>   256    25997.38 (0.00 pct)     47735.83 (83.61 pct)
>   512    47698.94 (0.00 pct)     48220.54 (1.09 pct)
>  1024    51451.30 (0.00 pct)     50455.47 (-1.93 pct)
> 
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Stream with 16 threads.
> built with -DSTREAM_ARRAY_SIZE=128000000, -DNTIMES=10
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> NPS Mode - NPS1
> Test:           sched-tip                   util-avg
>  Copy:   175278.66 (0.00 pct)    147847.67 (-15.64 pct)
> Scale:   193235.46 (0.00 pct)    186582.76 (-3.44 pct)
>   Add:   220232.14 (0.00 pct)    208519.22 (-5.31 pct)
> Triad:   215526.78 (0.00 pct)    204975.14 (-4.89 pct)
> 
> NPS Mode - NPS2
> Test:           sched-tip                    util-avg
>  Copy:   166600.09 (0.00 pct)    146456.45 (-12.09 pct)
> Scale:   190820.84 (0.00 pct)    179603.16 (-5.87 pct)
>   Add:   214660.01 (0.00 pct)    198636.00 (-7.46 pct)
> Triad:   210879.10 (0.00 pct)    196132.74 (-6.99 pct)
> 
> NPS Mode - NPS4
> Test:           sched-tip                    util-avg
>  Copy:   173888.83 (0.00 pct)    180948.16 (4.05 pct)
> Scale:   193027.03 (0.00 pct)    199330.65 (3.26 pct)
>   Add:   218731.48 (0.00 pct)    221743.63 (1.37 pct)
> Triad:   214651.06 (0.00 pct)    218036.35 (1.57 pct)
> 
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Stream with 16 threads.
> built with -DSTREAM_ARRAY_SIZE=128000000, -DNTIMES=100
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> NPS Mode - NPS1
> Test:           sched-tip                    util-avg
>  Copy:   222954.79 (0.00 pct)    219066.70 (-1.74 pct)
> Scale:   208255.97 (0.00 pct)    215060.20 (3.26 pct)
>   Add:   247694.16 (0.00 pct)    262893.33 (6.13 pct)
> Triad:   236060.27 (0.00 pct)    250188.38 (5.98 pct)
> 
> NPS Mode - NPS2
> Test:           sched-tip                   util-avg
>  Copy:   226147.92 (0.00 pct)    228438.70 (1.01 pct)
> Scale:   214059.09 (0.00 pct)    215959.36 (0.88 pct)
>   Add:   264978.05 (0.00 pct)    270058.63 (1.91 pct)
> Triad:   253095.73 (0.00 pct)    257466.31 (1.72 pct)
> 
> NPS Mode - NPS4
> Test:           sched-tip                   util-avg
>  Copy:   223484.37 (0.00 pct)    266929.80 (19.44 pct)
> Scale:   224198.90 (0.00 pct)    235316.80 (4.95 pct)
>   Add:   272008.98 (0.00 pct)    294452.15 (8.25 pct)
> Triad:   258219.64 (0.00 pct)    285935.30 (10.73 pct)
> --
> 
> We see great results in case of tbench with 256 workers when the
> system is fully loaded which is exactly the kind of scenario this
> patch optimizes for. Hackbench too shows improvements, especially
> in the case of 16-groups.

Thanks for the testing. Currently we have enhanced this patch
according to Peter's suggestion, to make the number of idle cpu
search more gradual. And we have launched some benchmarks to
evaluate the effect. Once it is done, we will send the v2 patch
out and it would be appreciated that you can also help give a glance
at it.

Thanks,
Chenyu
> --
> Thanks and Regards,
> Prateek
