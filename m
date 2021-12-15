Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FAF84758D5
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 13:26:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242487AbhLOMZy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 07:25:54 -0500
Received: from outbound-smtp41.blacknight.com ([46.22.139.224]:54017 "EHLO
        outbound-smtp41.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242416AbhLOMZx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 07:25:53 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp41.blacknight.com (Postfix) with ESMTPS id 3D7F01BF7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 12:25:52 +0000 (GMT)
Received: (qmail 14671 invoked from network); 15 Dec 2021 12:25:51 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.197.169])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 15 Dec 2021 12:25:51 -0000
Date:   Wed, 15 Dec 2021 12:25:50 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched/fair: Adjust the allowed NUMA imbalance when
 SD_NUMA spans multiple LLCs
Message-ID: <20211215122550.GR3366@techsingularity.net>
References: <20211210093307.31701-1-mgorman@techsingularity.net>
 <20211210093307.31701-3-mgorman@techsingularity.net>
 <YbcEE/mgIAhWuS+A@BLR-5CG11610CF.amd.com>
 <20211213130131.GQ3366@techsingularity.net>
 <YbddCcGJUpcPc8nS@BLR-5CG11610CF.amd.com>
 <YbnW/vLgE8MmQopN@BLR-5CG11610CF.amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <YbnW/vLgE8MmQopN@BLR-5CG11610CF.amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 05:22:30PM +0530, Gautham R. Shenoy wrote:
> Hello Mel,
> 
> 
> On Mon, Dec 13, 2021 at 08:17:37PM +0530, Gautham R. Shenoy wrote:
> 
> > 
> > Thanks for the patch. I will queue this one for tonight.
> >
> 
> Getting the numbers took a bit longer than I expected.
> 

No worries.

> > > <SNIP>
> > > +				/*
> > > +				 * Set span based on top domain that places
> > > +				 * tasks in sibling domains.
> > > +				 */
> > > +				top = sd;
> > > +				top_p = top->parent;
> > > +				while (top_p && (top_p->flags & SD_PREFER_SIBLING)) {
> > > +					top = top->parent;
> > > +					top_p = top->parent;
> > > +				}
> > > +				imb_span = top_p ? top_p->span_weight : sd->span_weight;
> > >  			} else {
> > > -				sd->imb_numa_nr = imb * (sd->span_weight / imb_span);
> > > +				int factor = max(1U, (sd->span_weight / imb_span));
> > > +
> 
> 
> So for the first NUMA domain, the sd->imb_numa_nr will be imb, which
> turns out to be 2 for Zen2 and Zen3 processors across all Nodes Per Socket Settings.
> 
> On a 2 Socket Zen3:
> 
> NPS=1
>    child=MC, llc_weight=16, sd=DIE. sd->span_weight=128 imb=max(2U, (16*16/128) / 4)=2
>    top_p = NUMA, imb_span = 256.
> 
>    NUMA: sd->span_weight =256; sd->imb_numa_nr = 2 * (256/256) = 2
> 
> NPS=2
>    child=MC, llc_weight=16, sd=NODE. sd->span_weight=64 imb=max(2U, (16*16/64) / 4) = 2
>    top_p = NUMA, imb_span = 128.
> 
>    NUMA: sd->span_weight =128; sd->imb_numa_nr = 2 * (128/128) = 2
>    NUMA: sd->span_weight =256; sd->imb_numa_nr = 2 * (256/128) = 4
> 
> NPS=4:
>    child=MC, llc_weight=16, sd=NODE. sd->span_weight=32 imb=max(2U, (16*16/32) / 4) = 2
>    top_p = NUMA, imb_span = 128.
> 
>    NUMA: sd->span_weight =128; sd->imb_numa_nr = 2 * (128/128) = 2
>    NUMA: sd->span_weight =256; sd->imb_numa_nr = 2 * (256/128) = 4
> 
> Again, we will be more aggressively load balancing across the two
> sockets in NPS=1 mode compared to NPS=2/4.
> 

Yes, but I felt it was reasonable behaviour because we have to strike
some sort of balance between allowing a NUMA imbalance up to a point
to prevent communicating tasks being pulled apart and v3 broke that
completely. There will always be a tradeoff between tasks that want to
remain local to each other and others that prefer to spread as wide as
possible as quickly as possible.

> <SNIP>
> If we retain the (2,4) thresholds from v4.1 but use them in
> allow_numa_imbalance() as in v3 we get
> 
> NPS=4
> Test:	 mel-v4.2
>  Copy:	 225860.12 (498.11%)
> Scale:	 227869.07 (572.58%)
>   Add:	 278365.58 (624.93%)
> Triad:	 264315.44 (596.62%)
> 

The potential problem with this is that it probably will work for
netperf when it's a single communicating pair but may not work as well
when there are multiple communicating pairs or a number of communicating
tasks that exceed numa_imb_nr.

> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> NPS=1
> ======
> Clients: tip-core   mel-v3    mel-v4    mel-v4.1
>     1	 633.19     619.16    632.94    619.27
>     	 (0.00%)    (-2.21%)  (-0.03%)	(-2.19%)
> 	 
>     2	 1152.48    1189.88   1184.82   1189.19
>     	 (0.00%)    (3.24%)   (2.80%)	(3.18%)
> 	 
>     4	 1946.46    2177.40   1979.56	2196.09
>     	 (0.00%)    (11.86%)  (1.70%)	(12.82%)
> 	 
>     8	 3553.29    3564.50   3678.07	3668.77
>     	 (0.00%)    (0.31%)   (3.51%)	(3.24%)
> 	 
>    16	 6217.03    6484.58   6249.29	6534.73
>    	 (0.00%)    (4.30%)   (0.51%)	(5.11%)
> 	 
>    32	 11702.59   12185.77  12005.99	11917.57
>    	 (0.00%)    (4.12%)   (2.59%)	(1.83%)
> 	 
>    64	 18394.56   19535.11  19080.19	19500.55
>    	 (0.00%)    (6.20%)   (3.72%)	(6.01%)
> 	 
>   128	 27231.02   31759.92  27200.52	30358.99
>   	 (0.00%)    (16.63%)  (-0.11%)	(11.48%)
> 	 
>   256	 33166.10   24474.30  31639.98	24788.12
>   	 (0.00%)    (-26.20%) (-4.60%)	(-25.26%)
> 	 
>   512	 41605.44   54823.57  46684.48	54559.02
>   	 (0.00%)    (31.77%)  (12.20%)	(31.13%)
> 	 
>  1024	 53650.54   56329.39  44422.99	56320.66
>  	 (0.00%)    (4.99%)   (-17.19%)	(4.97%) 
> 
> 
> We see that the v4.1 performs better than v4 in most cases except when
> the number of clients=256 where the spread strategy seems to be
> hurting as we see degradation in both v3 and v4.1. This is true even
> for NPS=2 and NPS=4 cases (see below).
> 

The 256 client case is a bit of a crapshoot. At that point, the NUMA
imbalancing is disabled and the machine is overloaded.

> NPS=2
> =====
> Clients: tip-core   mel-v3    mel-v4    mel-v4.1
>     1	 629.76	    620.91    629.11	631.95
>     	 (0.00%)    (-1.40%)  (-0.10%)	(0.34%)
> 	 
>     2	 1176.96    1203.12   1169.09	1186.74
>     	 (0.00%)    (2.22%)   (-0.66%)	(0.83%)
> 	 
>     4	 1990.97    2228.04   1888.19	1995.21
>     	 (0.00%)    (11.90%)  (-5.16%)	(0.21%)
> 	 
>     8	 3534.57    3617.16   3660.30	3548.09
>     	 (0.00%)    (2.33%)   (3.55%)	(0.38%)
> 	 
>    16	 6294.71    6547.80   6504.13	6470.34
>    	 (0.00%)    (4.02%)   (3.32%)	(2.79%)
> 	 
>    32	 12035.73   12143.03  11396.26	11860.91
>    	 (0.00%)    (0.89%)   (-5.31%)	(-1.45%)
> 	 
>    64	 18583.39   19439.12  17126.47	18799.54
>    	 (0.00%)    (4.60%)   (-7.83%)	(1.16%)
> 	 
>   128	 27811.89   30562.84  28090.29	27468.94
>   	 (0.00%)    (9.89%)   (1.00%)	(-1.23%)
> 	 
>   256	 28148.95   26488.57  29117.13	23628.29
>   	 (0.00%)    (-5.89%)  (3.43%)	(-16.05%)
> 	 
>   512	 43934.15   52796.38  42603.49	41725.75
>   	 (0.00%)    (20.17%)  (-3.02%)	(-5.02%)
> 	 
>  1024	 54391.65   53891.83  48419.09	43913.40
>  	 (0.00%)    (-0.91%)  (-10.98%)	(-19.26%)
> 
> In this case, v4.1 performs as good as v4 upto 64 clients. But after
> that we see degradation. The degradation is significant in 1024
> clients case.
> 

Kinda the same, it's more likely to be run-to-run variance because the
machine is overloaded.

> NPS=4
> =====
> Clients: tip-core   mel-v3    mel-v4    mel-v4.1    mel-v4.2
>     1	 622.65	    617.83    667.34	644.76	    617.58
>     	 (0.00%)    (-0.77%)  (7.17%)	(3.55%)	    (-0.81%)
> 	 
>     2	 1160.62    1182.30   1294.08	1193.88	    1182.55
>     	 (0.00%)    (1.86%)   (11.49%)	(2.86%)	    (1.88%)
> 	 
>     4	 1961.14    2171.91   2477.71	1929.56	    2116.01
>     	 (0.00%)    (10.74%)  (26.34%)	(-1.61%)    (7.89%)
> 	 
>     8	 3662.94    3447.98   4067.40	3627.43	    3580.32
>     	 (0.00%)    (-5.86%)  (11.04%)	(-0.96%)    (-2.25%)
> 	 
>    16	 6490.92    5871.93   6924.32	6660.13	    6413.34
>    	 (0.00%)    (-9.53%)  (6.67%)	(2.60%)	    (-1.19%)
> 	 
>    32	 11831.81   12004.30  12709.06	12187.78    11767.46
>    	 (0.00%)    (1.45%)   (7.41%)	(3.00%)	    (-0.54%)
> 	 
>    64	 17717.36   18406.79  18785.41	18820.33    18197.86
>    	 (0.00%)    (3.89%)   (6.02%)	(6.22%)	    (2.71%)
> 	 
>   128	 27723.35   27777.34  27939.63	27399.64    24310.93
>   	 (0.00%)    (0.19%)   (0.78%)	(-1.16%)    (-12.30%)
> 	 
>   256	 30919.69   23937.03  35412.26	26780.37    24642.24
>   	 (0.00%)    (-22.58%) (14.52%)	(-13.38%)   (-20.30%)
> 	 
>   512	 43366.03   49570.65  43830.84	43654.42    41031.90
>   	 (0.00%)    (14.30%)  (1.07%)	(0.66%)	    (-5.38%)
> 	 
>  1024	 46960.83   53576.16  50557.19	43743.07    40884.98
>  	 (0.00%)    (14.08%)  (7.65%)	(-6.85%)    (-12.93%)
> 
> 
> In the NPS=4 case, clearly v4 provides the best results.
> 
> v4.1 does better v4.2 since it is able to hold off spreading for a
> longer period compared to v4.2.
> 

Most likely because v4.2 is disabling the allowed NUMA imbalance too
soon. This is the trade-off between favouring communicating tasks over
embararassingly parallel problems.

-- 
Mel Gorman
SUSE Labs
