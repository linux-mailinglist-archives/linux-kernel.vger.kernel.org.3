Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A46B24A46B3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 13:17:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359796AbiAaMRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 07:17:13 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:36248 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237457AbiAaMRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 07:17:12 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id BEA3B1F381;
        Mon, 31 Jan 2022 12:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643631431; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l9D7GYyvR5xt6w/raIVy+Fkc4cws5THrU9c9JgpH+aU=;
        b=Jztq7cJOPqDCSCPVqJCS84wriFSWOhlYCkQPzK3eoScy8+FN1tgWNGw7j2opt+zleN19wW
        yLGhOcgRS2dVwukcDUPyMpAJT1mDD4lYAhFWporWqzw4GW2Nh+NxbcxjkjjrhAlj5y17QF
        rbKM+9SCqX7rVKnCLV3EcHELm+N5uiE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643631431;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l9D7GYyvR5xt6w/raIVy+Fkc4cws5THrU9c9JgpH+aU=;
        b=q3LX4DFunTDMllJzaV98FWitPjX3uh3vrpdIoq79p/ireL7EHT2MsZoqhjDVn03uPqLmoY
        riRS/44sNFWBt/Aw==
Received: from suse.de (unknown [10.163.43.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id DFF39A3B81;
        Mon, 31 Jan 2022 12:17:10 +0000 (UTC)
Date:   Mon, 31 Jan 2022 12:17:08 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Bharata B Rao <bharata@amd.com>
Cc:     linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, bristot@redhat.com,
        dishaa.talreja@amd.com
Subject: Re: [RFC PATCH v0 0/3] sched/numa: Process Adaptive autoNUMA
Message-ID: <20220131121707.GW3301@suse.de>
References: <20220128052851.17162-1-bharata@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220128052851.17162-1-bharata@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 10:58:48AM +0530, Bharata B Rao wrote:
> Hi,
> 
> This patchset implements an adaptive algorithm for calculating the autonuma
> scan period.

autonuma refers to the khugepaged-like approach to NUMA balancing that
was later superceded by NUMA Balancing (NUMAB) and is generally reflected
by the naming e.g. git grep -i autonuma and note how few references there
are to autonuma versus numab or "NUMA balancing". I know MMTests still
refers to AutoNUMA but mostly because at the time it was written,
autoNUMA was what was being evaluated and I never updated the naming.

> In the existing mechanism of scan period calculation,
> 
> - scan period is derived from the per-thread stats.
> - static threshold (NUMA_PERIOD_THRESHOLD) is used for changing the
>   scan rate.
> 
> In this new approach (Process Adaptive autoNUMA or PAN), we gather NUMA
> fault stats at per-process level which allows for capturing the application
> behaviour better. In addition, the algorithm learns and adjusts the scan
> rate based on remote fault rate. By not sticking to a static threshold, the
> algorithm can respond better to different workload behaviours.
> 

NUMA Balancing is concerned with threads (task) and an address space (mm)
so basing the naming on Address Space rather than process may be more
appropriate although I admit the acronym is not as snappy.

> Since the threads of a processes are already considered as a group,
> we add a bunch of metrics to the task's mm to track the various
> types of faults and derive the scan rate from them.
> 

Enumerate the types of faults and note how the per-thread and
per-address-space metrics are related.

> The new per-process fault stats contribute only to the per-process
> scan period calculation, while the existing per-thread stats continue
> to contribute towards the numa_group stats which eventually
> determine the thresholds for migrating memory and threads
> across nodes.
> 
> This patchset has been tested with a bunch of benchmarks on the
> following system:
> 

Please include the comparisons of both the headline metrics and notes on
the change in scan rates in the changelog of the patch. Not all people
are access to Google drive and it is not guaranteed to remain forever.
Similarly, the leader is not guaranteed to appear in the git history

> ------------------------------------------------------
> % gain of PAN vs default (Avg of 3 runs)
> ------------------------------------------------------
> NAS-BT		-0.17
> NAS-CG		+9.39
> NAS-MG		+8.19
> NAS-FT		+2.23
> Hashjoin	+0.58
> Graph500	+14.93
> Pagerank	+0.37



> ------------------------------------------------------
> 		Default		PAN		%diff
> ------------------------------------------------------
> 		NUMA hint faults(Total of 3 runs)
> ------------------------------------------------------
> NAS-BT		758282358	539850429	+29
> NAS-CG		2179458823	1180301361	+46
> NAS-MG		517641172	346066391	+33
> NAS-FT		297044964	230033861	+23
> Hashjoin	201684863	268436275	-33
> Graph500	261808733	154338827	+41
> Pagerank	217917818	211260310	+03
> ------------------------------------------------------
> 		Migrations(Total of 3 runs)
> ------------------------------------------------------
> NAS-BT		106888517	86482076	+19
> NAS-CG		81191368	12859924	+84
> NAS-MG		83927451	39651254	+53
> NAS-FT		61807715	38934618	+37
> Hashjoin	45406983	59828843	-32
> Graph500	22798837	21560714	+05
> Pagerank	59072135	44968673	+24
> ------------------------------------------------------
> 
> And here are some tests from a few microbenchmarks of mmtests suite.
> (The results are trimmed a bit here, the complete results can
> be viewed in the above mentioned link)
> 
> Hackbench
> ---------
> hackbench-process-pipes
>                            hackbench              hackbench
>                              default                    pan
> Min       256     23.5510 (   0.00%)     23.1900 (   1.53%)
> Amean     256     24.4604 (   0.00%)     24.0353 *   1.74%*
> Stddev    256      0.4420 (   0.00%)      0.7611 ( -72.18%)
> CoeffVar  256      1.8072 (   0.00%)      3.1666 ( -75.22%)
> Max       256     25.4930 (   0.00%)     30.5450 ( -19.82%)
> BAmean-50 256     24.1074 (   0.00%)     23.6616 (   1.85%)
> BAmean-95 256     24.4111 (   0.00%)     23.9308 (   1.97%)
> BAmean-99 256     24.4499 (   0.00%)     23.9696 (   1.96%)
> 
>                    hackbench   hackbench
>                      default         pan
> Duration User       25810.02    25158.93
> Duration System    276322.70   271729.32
> Duration Elapsed     2707.75     2671.33
> 

>                                       hackbench      hackbench
>                                         default            pan
> Ops NUMA alloc hit                1082415453.00  1088025994.00
> Ops NUMA alloc miss                        0.00           0.00
> Ops NUMA interleave hit                    0.00           0.00
> Ops NUMA alloc local              1082415441.00  1088025974.00
> Ops NUMA base-page range updates       33475.00      228900.00
> Ops NUMA PTE updates                   33475.00      228900.00
> Ops NUMA PMD updates                       0.00           0.00
> Ops NUMA hint faults                   15758.00      222100.00
> Ops NUMA hint local faults %           15371.00      214570.00
> Ops NUMA hint local percent               97.54          96.61
> Ops NUMA pages migrated                  235.00        4029.00
> Ops AutoNUMA cost                         79.03        1112.18
> 

Hackbench processes are generally short-lived enough that NUMA balancing
has a marginal impact. Interesting though that updates and hints were
increased by a lot relatively speaking.

> tbench
> ------
> tbench4
>                               tbench                 tbench
>                              default                    pan
> Hmean     1        436.89 (   0.00%)      432.73 *  -0.95%*
> Hmean     2        834.27 (   0.00%)      848.11 *   1.66%*
> Hmean     4       1629.50 (   0.00%)     1614.22 *  -0.94%*
> Hmean     8       2944.06 (   0.00%)     3031.66 *   2.98%*
> Hmean     16      5418.25 (   0.00%)     5674.74 *   4.73%*
> Hmean     32      9959.60 (   0.00%)     9009.82 *  -9.54%*
> Hmean     64     13999.14 (   0.00%)    12160.51 * -13.13%*
> Hmean     128    16797.09 (   0.00%)    16506.14 *  -1.73%*
> Hmean     256    25344.27 (   0.00%)    25683.66 *   1.34%*
> Hmean     512    25289.03 (   0.00%)    25513.77 *   0.89%*
> BHmean-50 1        437.13 (   0.00%)      433.01 (  -0.94%)
> BHmean-50 2        836.35 (   0.00%)      848.85 (   1.49%)
> BHmean-50 4       1631.39 (   0.00%)     1618.43 (  -0.79%)
> BHmean-50 8       2948.25 (   0.00%)     3037.86 (   3.04%)
> BHmean-50 16      5425.17 (   0.00%)     5684.25 (   4.78%)
> BHmean-50 32      9969.17 (   0.00%)     9034.06 (  -9.38%)
> BHmean-50 64     14013.93 (   0.00%)    12202.07 ( -12.93%)
> BHmean-50 128    16881.94 (   0.00%)    16571.27 (  -1.84%)
> BHmean-50 256    25379.59 (   0.00%)    25819.18 (   1.73%)
> BHmean-50 512    25435.41 (   0.00%)    25718.02 (   1.11%)
> BHmean-95 1        436.92 (   0.00%)      432.81 (  -0.94%)
> BHmean-95 2        834.59 (   0.00%)      848.23 (   1.63%)
> BHmean-95 4       1629.73 (   0.00%)     1614.83 (  -0.91%)
> BHmean-95 8       2945.02 (   0.00%)     3032.19 (   2.96%)
> BHmean-95 16      5418.86 (   0.00%)     5675.91 (   4.74%)
> BHmean-95 32      9962.57 (   0.00%)     9014.17 (  -9.52%)
> BHmean-95 64     14002.44 (   0.00%)    12164.32 ( -13.13%)
> BHmean-95 128    16820.56 (   0.00%)    16522.82 (  -1.77%)
> BHmean-95 256    25347.34 (   0.00%)    25692.56 (   1.36%)
> BHmean-95 512    25302.10 (   0.00%)    25528.52 (   0.89%)
> BHmean-99 1        436.90 (   0.00%)      432.75 (  -0.95%)
> BHmean-99 2        834.35 (   0.00%)      848.17 (   1.66%)
> BHmean-99 4       1629.57 (   0.00%)     1614.38 (  -0.93%)
> BHmean-99 8       2944.36 (   0.00%)     3031.77 (   2.97%)
> BHmean-99 16      5418.40 (   0.00%)     5675.01 (   4.74%)
> BHmean-99 32      9961.01 (   0.00%)     9011.43 (  -9.53%)
> BHmean-99 64     14000.68 (   0.00%)    12161.34 ( -13.14%)
> BHmean-99 128    16803.44 (   0.00%)    16511.94 (  -1.73%)
> BHmean-99 256    25344.93 (   0.00%)    25685.57 (   1.34%)
> BHmean-99 512    25291.87 (   0.00%)    25516.94 (   0.89%)
> 
>                       tbench      tbench
>                      default         pan
> Duration User        8482.50     8289.35
> Duration System     49462.63    49364.56
> Duration Elapsed     2217.10     2217.08
> 
>                                          tbench         tbench
>                                         default            pan
> Ops NUMA alloc hit                 388738400.00   378941469.00
> Ops NUMA alloc miss                        0.00           0.00
> Ops NUMA interleave hit                    0.00           0.00
> Ops NUMA alloc local               388738391.00   378941455.00
> Ops NUMA base-page range updates      266760.00      266275.00
> Ops NUMA PTE updates                  266760.00      266275.00
> Ops NUMA PMD updates                       0.00           0.00
> Ops NUMA hint faults                  241547.00      257790.00
> Ops NUMA hint local faults %          145814.00      126410.00
> Ops NUMA hint local percent               60.37          49.04
> Ops NUMA pages migrated                51535.00       66083.00
> Ops AutoNUMA cost                       1210.58        1292.07
> 

Not much change.

> dbench
> ------
> dbench4 Latency
>                                        dbench                 dbench
>                                       default                    pan
> Amean     latency-1           2.02 (   0.00%)        2.05 *  -1.52%*
> Amean     latency-2           2.60 (   0.00%)        2.55 *   1.64%*
> Amean     latency-4           3.52 (   0.00%)        3.56 *  -1.17%*
> Amean     latency-8          12.79 (   0.00%)       11.83 *   7.49%*
> Amean     latency-16         23.33 (   0.00%)       19.09 *  18.19%*
> Amean     latency-32         19.30 (   0.00%)       18.83 *   2.43%*
> Amean     latency-64         25.32 (   0.00%)       24.30 *   4.00%*
> Amean     latency-128        45.25 (   0.00%)       42.93 *   5.13%*
> Amean     latency-1024        0.00 (   0.00%)        0.00 *   0.00%*
> BAmean-50 latency-1           1.65 (   0.00%)        1.74 (  -5.16%)
> BAmean-50 latency-2           2.10 (   0.00%)        2.10 (  -0.13%)
> BAmean-50 latency-4           2.65 (   0.00%)        2.71 (  -2.28%)
> BAmean-50 latency-8           6.21 (   0.00%)        4.64 (  25.30%)
> BAmean-50 latency-16         17.64 (   0.00%)       14.08 (  20.16%)
> BAmean-50 latency-32         15.58 (   0.00%)       15.90 (  -2.07%)
> BAmean-50 latency-64         20.76 (   0.00%)       20.31 (   2.15%)
> BAmean-50 latency-128        36.22 (   0.00%)       34.85 (   3.80%)
> BAmean-50 latency-1024        0.00 (   0.00%)        0.00 (   0.00%)
> BAmean-95 latency-1           1.88 (   0.00%)        1.94 (  -3.17%)
> BAmean-95 latency-2           2.25 (   0.00%)        2.26 (  -0.26%)
> BAmean-95 latency-4           3.00 (   0.00%)        3.08 (  -2.71%)
> BAmean-95 latency-8          11.66 (   0.00%)       10.03 (  13.97%)
> BAmean-95 latency-16         22.30 (   0.00%)       17.68 (  20.73%)
> BAmean-95 latency-32         17.95 (   0.00%)       17.70 (   1.38%)
> BAmean-95 latency-64         23.57 (   0.00%)       22.72 (   3.62%)
> BAmean-95 latency-128        42.44 (   0.00%)       39.96 (   5.84%)
> BAmean-95 latency-1024        0.00 (   0.00%)        0.00 (   0.00%)
> BAmean-99 latency-1           1.90 (   0.00%)        1.96 (  -3.30%)
> BAmean-99 latency-2           2.38 (   0.00%)        2.37 (   0.48%)
> BAmean-99 latency-4           3.24 (   0.00%)        3.34 (  -3.26%)
> BAmean-99 latency-8          12.34 (   0.00%)       10.71 (  13.27%)
> BAmean-99 latency-16         22.79 (   0.00%)       18.27 (  19.82%)
> BAmean-99 latency-32         18.68 (   0.00%)       18.32 (   1.93%)
> BAmean-99 latency-64         24.69 (   0.00%)       23.69 (   4.06%)
> BAmean-99 latency-128        44.44 (   0.00%)       42.15 (   5.17%)
> BAmean-99 latency-1024        0.00 (   0.00%)        0.00 (   0.00%)
> 
> dbench4 Throughput (misleading but traditional)
>                                dbench                 dbench
>                               default                    pan
> Hmean     1         505.12 (   0.00%)      492.96 *  -2.41%*
> Hmean     2         824.14 (   0.00%)      824.06 *  -0.01%*
> Hmean     4        1174.61 (   0.00%)     1207.86 *   2.83%*
> Hmean     8        1665.10 (   0.00%)     1667.27 *   0.13%*
> Hmean     16       2215.59 (   0.00%)     2160.93 *  -2.47%*
> Hmean     32       2727.05 (   0.00%)     2633.26 *  -3.44%*
> Hmean     64       3128.64 (   0.00%)     3098.73 *  -0.96%*
> Hmean     128      3282.89 (   0.00%)     3340.26 *   1.75%*
> Hmean     1024     2551.02 (   0.00%)     2559.41 *   0.33%*
> BHmean-50 1         509.87 (   0.00%)      495.10 (  -2.90%)
> BHmean-50 2         829.35 (   0.00%)      828.14 (  -0.15%)
> BHmean-50 4        1182.38 (   0.00%)     1219.30 (   3.12%)
> BHmean-50 8        1678.49 (   0.00%)     1678.83 (   0.02%)
> BHmean-50 16       2251.01 (   0.00%)     2194.52 (  -2.51%)
> BHmean-50 32       2751.39 (   0.00%)     2678.45 (  -2.65%)
> BHmean-50 64       3189.69 (   0.00%)     3154.45 (  -1.10%)
> BHmean-50 128      3396.18 (   0.00%)     3451.59 (   1.63%)
> BHmean-50 1024     2836.80 (   0.00%)     2836.84 (   0.00%)
> BHmean-95 1         506.13 (   0.00%)      493.24 (  -2.55%)
> BHmean-95 2         824.84 (   0.00%)      824.30 (  -0.06%)
> BHmean-95 4        1175.91 (   0.00%)     1208.57 (   2.78%)
> BHmean-95 8        1666.46 (   0.00%)     1668.22 (   0.11%)
> BHmean-95 16       2219.59 (   0.00%)     2163.86 (  -2.51%)
> BHmean-95 32       2731.26 (   0.00%)     2640.34 (  -3.33%)
> BHmean-95 64       3144.73 (   0.00%)     3108.59 (  -1.15%)
> BHmean-95 128      3306.51 (   0.00%)     3363.33 (   1.72%)
> BHmean-95 1024     2658.37 (   0.00%)     2668.88 (   0.40%)
> BHmean-99 1         505.37 (   0.00%)      493.08 (  -2.43%)
> BHmean-99 2         824.31 (   0.00%)      824.12 (  -0.02%)
> BHmean-99 4        1174.94 (   0.00%)     1208.02 (   2.81%)
> BHmean-99 8        1665.40 (   0.00%)     1667.48 (   0.12%)
> BHmean-99 16       2216.51 (   0.00%)     2161.60 (  -2.48%)
> BHmean-99 32       2728.09 (   0.00%)     2635.09 (  -3.41%)
> BHmean-99 64       3135.81 (   0.00%)     3102.12 (  -1.07%)
> BHmean-99 128      3291.11 (   0.00%)     3349.16 (   1.76%)
> BHmean-99 1024     2645.54 (   0.00%)     2655.67 (   0.38%)
> 
> 
>                       dbench      dbench
>                      default         pan
> Duration User         822.55      827.85
> Duration System      8384.99     8164.83
> Duration Elapsed     1671.36     1670.74
> 
>                                          dbench         dbench
>                                         default            pan
> Ops NUMA alloc hit                 183324626.00   182350114.00
> Ops NUMA alloc miss                        0.00           0.00
> Ops NUMA interleave hit                    0.00           0.00
> Ops NUMA alloc local               183324508.00   182350004.00
> Ops NUMA base-page range updates      181531.00      515929.00
> Ops NUMA PTE updates                  181531.00      515929.00
> Ops NUMA PMD updates                       0.00           0.00
> Ops NUMA hint faults                  162742.00      510979.00
> Ops NUMA hint local faults %          120309.00      426848.00
> Ops NUMA hint local percent               73.93          83.54
> Ops NUMA pages migrated                37605.00       59519.00
> Ops AutoNUMA cost                        815.70        2559.64
> 

More hinting faults and migrations

> Netperf-RR
> ----------
> netperf-udp-rr
>                            netperf                netperf
>                         rr-default                 rr-pan
> Min       1   104915.69 (   0.00%)   104505.71 (  -0.39%)
> Hmean     1   105865.46 (   0.00%)   105899.22 *   0.03%*
> Stddev    1      528.45 (   0.00%)      881.92 ( -66.89%)
> CoeffVar  1        0.50 (   0.00%)        0.83 ( -66.83%)
> Max       1   106410.28 (   0.00%)   107196.52 (   0.74%)
> BHmean-50 1   106232.53 (   0.00%)   106568.26 (   0.32%)
> BHmean-95 1   105972.05 (   0.00%)   106056.35 (   0.08%)
> BHmean-99 1   105972.05 (   0.00%)   106056.35 (   0.08%)
> 
>                      netperf     netperf
>                   rr-default      rr-pan
> Duration User          11.20       10.74
> Duration System       202.40      201.32
> Duration Elapsed      303.09      303.08
> 
>                                         netperf        netperf
>                                      rr-default         rr-pan
> Ops NUMA alloc hit                    183999.00      183853.00
> Ops NUMA alloc miss                        0.00           0.00
> Ops NUMA interleave hit                    0.00           0.00
> Ops NUMA alloc local                  183999.00      183853.00
> Ops NUMA base-page range updates           0.00       24370.00
> Ops NUMA PTE updates                       0.00       24370.00
> Ops NUMA PMD updates                       0.00           0.00
> Ops NUMA hint faults                     539.00       24470.00
> Ops NUMA hint local faults %             539.00       24447.00
> Ops NUMA hint local percent              100.00          99.91
> Ops NUMA pages migrated                    0.00          23.00
> Ops AutoNUMA cost                          2.69         122.52
> 

Netperf these days usually runs on the same node so NUMA balancing
triggers very rarely.

> netperf-tcp-rr
>                            netperf                netperf
>                         rr-default                 rr-pan
> Min       1    96156.03 (   0.00%)    96556.87 (   0.42%)
> Hmean     1    96627.24 (   0.00%)    97551.38 *   0.96%*
> Stddev    1      284.71 (   0.00%)      637.74 (-123.99%)
> CoeffVar  1        0.29 (   0.00%)        0.65 (-121.87%)
> Max       1    96974.45 (   0.00%)    98554.94 (   1.63%)
> BHmean-50 1    96840.81 (   0.00%)    98067.19 (   1.27%)
> BHmean-95 1    96679.89 (   0.00%)    97663.14 (   1.02%)
> BHmean-99 1    96679.89 (   0.00%)    97663.14 (   1.02%)
> 
>                      netperf     netperf
>                   rr-default      rr-pan
> Duration User          10.21       10.26
> Duration System       207.90      208.28
> Duration Elapsed      302.99      303.02
> 
>                                         netperf        netperf
>                                      rr-default         rr-pan
> Ops NUMA alloc hit                    183669.00      183695.00
> Ops NUMA alloc miss                        0.00           0.00
> Ops NUMA interleave hit                    0.00           0.00
> Ops NUMA alloc local                  183657.00      183695.00
> Ops NUMA base-page range updates        3949.00       38561.00
> Ops NUMA PTE updates                    3949.00       38561.00
> Ops NUMA PMD updates                       0.00           0.00
> Ops NUMA hint faults                    4186.00       43328.00
> Ops NUMA hint local faults %            4100.00       43195.00
> Ops NUMA hint local percent               97.95          99.69
> Ops NUMA pages migrated                    9.00          73.00
> Ops AutoNUMA cost                         20.96         216.91
> 

Same.

> Autonumabench
> -------------
> autonumabench
>                                            autonumabench          autonumabench
>                                                  default                    pan
> Amean     syst-NUMA01                11664.40 (   0.00%)    11616.17 *   0.41%*
> Amean     syst-NUMA01_THREADLOCAL        0.24 (   0.00%)        0.22 *   7.78%*
> Amean     syst-NUMA02                    1.55 (   0.00%)        9.31 *-499.26%*
> Amean     syst-NUMA02_SMT                1.14 (   0.00%)        4.04 *-254.39%*
> Amean     elsp-NUMA01                  223.52 (   0.00%)      221.43 *   0.93%*
> Amean     elsp-NUMA01_THREADLOCAL        0.95 (   0.00%)        0.94 *   0.76%*
> Amean     elsp-NUMA02                    6.83 (   0.00%)        5.74 *  15.90%*
> Amean     elsp-NUMA02_SMT                6.65 (   0.00%)        6.25 *   5.97%*
> BAmean-50 syst-NUMA01                11455.44 (   0.00%)    10985.76 (   4.10%)
> BAmean-50 syst-NUMA01_THREADLOCAL        0.22 (   0.00%)        0.21 (   7.46%)
> BAmean-50 syst-NUMA02                    1.11 (   0.00%)        8.91 (-703.00%)
> BAmean-50 syst-NUMA02_SMT                0.94 (   0.00%)        3.42 (-262.19%)
> BAmean-50 elsp-NUMA01                  217.38 (   0.00%)      214.03 (   1.54%)
> BAmean-50 elsp-NUMA01_THREADLOCAL        0.94 (   0.00%)        0.94 (   0.35%)
> BAmean-50 elsp-NUMA02                    6.66 (   0.00%)        5.45 (  18.08%)
> BAmean-50 elsp-NUMA02_SMT                6.50 (   0.00%)        6.09 (   6.31%)
> BAmean-95 syst-NUMA01                11611.74 (   0.00%)    11448.30 (   1.41%)
> BAmean-95 syst-NUMA01_THREADLOCAL        0.23 (   0.00%)        0.22 (   7.14%)
> BAmean-95 syst-NUMA02                    1.27 (   0.00%)        9.21 (-624.93%)
> BAmean-95 syst-NUMA02_SMT                0.97 (   0.00%)        3.90 (-300.34%)
> BAmean-95 elsp-NUMA01                  221.75 (   0.00%)      218.53 (   1.45%)
> BAmean-95 elsp-NUMA01_THREADLOCAL        0.94 (   0.00%)        0.94 (   0.53%)
> BAmean-95 elsp-NUMA02                    6.75 (   0.00%)        5.68 (  15.81%)
> BAmean-95 elsp-NUMA02_SMT                6.61 (   0.00%)        6.23 (   5.82%)
> BAmean-99 syst-NUMA01                11611.74 (   0.00%)    11448.30 (   1.41%)
> BAmean-99 syst-NUMA01_THREADLOCAL        0.23 (   0.00%)        0.22 (   7.14%)
> BAmean-99 syst-NUMA02                    1.27 (   0.00%)        9.21 (-624.93%)
> BAmean-99 syst-NUMA02_SMT                0.97 (   0.00%)        3.90 (-300.34%)
> BAmean-99 elsp-NUMA01                  221.75 (   0.00%)      218.53 (   1.45%)
> BAmean-99 elsp-NUMA01_THREADLOCAL        0.94 (   0.00%)        0.94 (   0.53%)
> BAmean-99 elsp-NUMA02                    6.75 (   0.00%)        5.68 (  15.81%)
> BAmean-99 elsp-NUMA02_SMT                6.61 (   0.00%)        6.23 (   5.82%)
> 
>                 autonumabenchautonumabench
>                      default         pan
> Duration User       94363.43    94436.71
> Duration System     81671.72    81408.53
> Duration Elapsed     1676.81     1647.99
> 
>                                   autonumabench  autonumabench
>                                         default            pan
> Ops NUMA alloc hit                 539544115.00   539522029.00
> Ops NUMA alloc miss                        0.00           0.00
> Ops NUMA interleave hit                    0.00           0.00
> Ops NUMA alloc local               279025768.00   281735736.00
> Ops NUMA base-page range updates    69695169.00    84767502.00
> Ops NUMA PTE updates                69695169.00    84767502.00
> Ops NUMA PMD updates                       0.00           0.00
> Ops NUMA hint faults                69691818.00    87895044.00
> Ops NUMA hint local faults %        56565519.00    65819747.00
> Ops NUMA hint local percent               81.17          74.88
> Ops NUMA pages migrated              5950362.00     8310169.00
> Ops AutoNUMA cost                     349060.01      440226.49
> 

More hinting faults and migrations. Not clear which sub-test exactly but
most likely NUMA02.

-- 
Mel Gorman
SUSE Labs
