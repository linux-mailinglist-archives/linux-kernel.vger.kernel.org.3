Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10C92550A7C
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 14:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbiFSMFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 08:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233849AbiFSMFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 08:05:13 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F07A2101E3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 05:05:10 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 68so2482716pgb.10
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 05:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i4m6BkJbiMa7EwQgE+EmJHUizmXnwlIHaQU425tNMuk=;
        b=Opw3a7RnBPR3VlvbF5hE55hN709vn0Sy3Qim9wU19Vi0LxaRLs4ZGAfQjhz9l6pJvx
         qeyxLvvwSPnRC6Y4O5e16OyTyEWSaDQ2s6IErAHgiPdJHCX5gt3iFwYLzqJ/3NTke5wo
         Cdiv8zfKjB5GXYiQMTuP4cY2d09ERuVDgvgMVpGAB2uj7mwaMMz0ioCSwUmSpb4H+qKd
         SPXQh1WjdsLTd5EbIIUEsHEDMA1VnVHrqnftMNkcbs/sroQvmLo+kpLDZCK/kaA/HrzI
         nS084+nO4kss0HC+LjwgNk2FlE34kTSU/gUICS4FO3OoMxlLlHsLFwTTA199fchT3Z2u
         IVlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i4m6BkJbiMa7EwQgE+EmJHUizmXnwlIHaQU425tNMuk=;
        b=lBA+m+5mWsjg+pbaj1WzulAcKpl49vcAKQoeHK2eTe+1em2Oiw0RlAK3EcmrPU9+p9
         ktEe2FVIU2r4/x5zxotSHLwK8UdBxE6rli1Lx+h7QYONEhyIbFc0HHM66HoH5ffJbW3R
         evofsE7wLgOdvTjWhPtd8u4REJrNeTHKDp51ynOK0kukwCL6hK0Hcd30FD3EYDUtAhVU
         Vj4UzStIi4MMVp4SNj5W5NtdW9XXROG/hPQfDOJOj1amQQh5UYTKG2+wDjbK3AtuYW0p
         UfI5LxGCTtPaTO72eX6d3cX43EfhM1w0fnx5yhzKHu13qt3BzYAS7F2+mmhw77QMpQuU
         qPDQ==
X-Gm-Message-State: AJIora9UYsZj3qHmfZO5Sw/fFey1pDeULswNRq/YkXgjPPfRL2QE83BD
        iwmTPMDaL0fgwdm08FX4mAOYlw==
X-Google-Smtp-Source: AGRyM1s6g8Dtah2BPSF1c9q/i/gic899YEz6yugDgx2R3SaAWJjPfVWxpTnrlNB4wfWjUGCYtZAzgg==
X-Received: by 2002:a63:b955:0:b0:40c:8f56:e791 with SMTP id v21-20020a63b955000000b0040c8f56e791mr4988806pgo.270.1655640310188;
        Sun, 19 Jun 2022 05:05:10 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id cp16-20020a170902e79000b0015e8d4eb1d5sm1594038plb.31.2022.06.19.05.05.06
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jun 2022 05:05:09 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v4 0/7] sched/fair: improve scan efficiency of SIS
Date:   Sun, 19 Jun 2022 20:04:44 +0800
Message-Id: <20220619120451.95251-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The wakeup fastpath (select_idle_sibling or SIS) plays an important role
in maximizing the usage of cpu resources and can greatly affect overall
performance of the system.

The SIS tries to find an idle cpu inside that LLC to place the woken-up
task. The cache hot cpus will be checked first, then other cpus of that
LLC (domain scan) if the hot ones are not idle.

The domain scan works well under light workload by simply traversing
the cpus of the LLC due to lots of idle cpus can be available. But this
doesn’t scale well once the LLC gets bigger and the load increases, so
SIS_PROP was born to limit the scan cost. For now SIS_PROP just limits
the number of cpus to be scanned, but the way of how it scans is not
changed.

This patchset introduces the SIS filter to help improving scan efficiency
when scan depth is limited. The filter only contains the unoccupied cpus,
and is updated during SMT level load balancing. It is expected that the
more overloaded the system is, the less cpus will be scanned.

SIS_PROP
=======

The filter should be put under SIS_PROP which is not now, because this
sched-feature is under rework or been replaced (by SIS_UTIL [1]). Will
be adjusted once that work is ready.

[1] https://lore.kernel.org/all/20220612163428.849378-1-yu.c.chen@intel.com/

Entrance: Load balance vs. Tick
===============================

Now we update the filter during load balancing at SMT level, while it was
done at the tick (patch v1-v3). There are several reasons:

  - The periodic load balancing has the admission control that only the
    first idle cpu (if any) or the balance cpu can trigger balance, so
    the complexity is reduced by O(n) in the domain scope. While on the
    other hand, the complexity of per-cpu updating at the tick is not
    reduced, and can cause heavy traffic on the LLC cache.

  - In order to keep the filter relatively fresh, the cpu idle path needs
    to be taken into consideration as well. Since load_balance is the
    common path for the periodic and newly-idle balance, we can simplify
    and concentrate on load_balance itself. While the tick way both tick
    and idle path need to be modified.

  - The calculation of SMT state can re-use the intermediate results of
    the load balance, so it’s cheap without sacrifice.

But the tick way also has its advantages in the idle path that the cpus
set to filter are guaranteed to be idle compared to load_balance in which
the filter is updated before task migrations (so the idle dst_cpu can be
fed with tasks). This can be fixed by false positive correction at later
discussion.

Filter: Busy vs. Overloaded
===========================

In preious patch versions, rather than the busy or unoccupied cpus, only
the overloaded ones will be set into the filter because of its stableness.
For example, the state of the unoccupied cpus (non-idle tasks == 0) or the
busy cpus (== 1) can be easily changed by a short running workload. And
besides, wakup won’t pollute the filter since add tasks to the already
overloaded cpus can’t change their states.

But it’s different in this patchset in which the load balance cpu will be
responsible for updating its core state. The state will be set to has_icpus
if unoccupied cpus exist no matter what the other cpu states are. So the
overloaded state of a core is also unstable. Given this, the semantics of
busy is much preferred than overloaded due to its accuracy.

The only problem comes to cache, again. To avoid frequent update thanks
to the variance, the false positive bits in the filter are allowed to exist
for a while, which will be talked about later.

Incremental Propagation
=======================

By design, the unoccupied cpus will be set (or propagate) to the filter.
But it’s heavy to update the whole SMT state every time. What we actually
do is only to propagate one unoccupied cpu of this core to the filter at
a time, so called incremental propagation. It’s not just a tradeoff, it
also helps spreading load to different cores.

The cpu to be propagated needs to be selected carefully. If the load
balance cpu is chosen, the filter might be polluted because that cpu
could be fed with tasks soon. But it’s not wise either to wait to the
end of load balancing as we need to do it as early as possible to keep
the filter fresh. The solution is false positive correction too.

Accuracy: False Positive Correction
===================================

The filter is supposed to contain unoccupied cpus. There are two main
cases that will downgrade the filter:

  - False negtive: there are unoccupied cpus not represented in the
    filter. This is the case we should try to eliminate because these
    cpus will be out of reach in the wakeup leading to in-sufficient
    use of cpu resources. So in practical the unoccupied cpus will be
    aggressively propagated to the filter.

  - False positive: some of the cpus in the filter are not unoccupied
    any more. We allow these cpus to stay in the filter for some time
    to relieve cache pressure. It's a tradeoff.

A correction is needed when the false positive case is continuously
detected. See patch 7 for detailed info.

SMT 2/4/8
=========

The incremental propagation is relatively friendly to SMT2, but not for
the others. As the core grows bigger, the more false negtive cpus could
exist. It would be appreciated if anyone can help testing on SMT 4/8
machines.

Benchmark
=========

Tests are done in an Intel Xeon(R) Platinum 8260 CPU@2.40GHz machine
with 2 NUMA nodes each of which has 24 cores with SMT2 enabled, so 96
CPUs in total.

All of the benchmarks are done inside a normal cpu cgroup in a clean
environment with cpu turbo disabled.

Based on tip sched/core f3dd3f674555 (v5.19-rc2).

Results
=======

hackbench-process-pipes
                             vanilla		     filter
Amean     1        0.2357 (   0.00%)      0.2540 (  -7.78%)
Amean     4        0.6403 (   0.00%)      0.6363 (   0.62%)
Amean     7        0.7583 (   0.00%)      0.7367 (   2.86%)
Amean     12       1.0703 (   0.00%)      1.0520 (   1.71%)
Amean     21       2.0363 (   0.00%)      1.9610 *   3.70%*
Amean     30       3.2487 (   0.00%)      2.9083 *  10.48%*
Amean     48       6.3620 (   0.00%)      4.8543 *  23.70%*
Amean     79       8.3653 (   0.00%)      7.1077 *  15.03%*
Amean     110      9.8370 (   0.00%)      8.5740 *  12.84%*
Amean     141     11.4667 (   0.00%)     10.8750 *   5.16%*
Amean     172     13.4433 (   0.00%)     12.6443 *   5.94%*
Amean     203     15.8970 (   0.00%)     14.9143 *   6.18%*
Amean     234     17.9643 (   0.00%)     16.9123 *   5.86%*
Amean     265     20.3910 (   0.00%)     19.2040 *   5.82%*
Amean     296     22.5253 (   0.00%)     21.2547 *   5.64%*

hackbench-process-sockets
                             vanilla		     filter
Amean     1        0.4177 (   0.00%)      0.4133 (   1.04%)
Amean     4        1.4397 (   0.00%)      1.4240 *   1.09%*
Amean     7        2.4720 (   0.00%)      2.4310 *   1.66%*
Amean     12       4.1407 (   0.00%)      4.0683 *   1.75%*
Amean     21       7.0550 (   0.00%)      6.8830 *   2.44%*
Amean     30       9.9633 (   0.00%)      9.7750 *   1.89%*
Amean     48      15.9837 (   0.00%)     15.5313 *   2.83%*
Amean     79      26.7740 (   0.00%)     26.2703 *   1.88%*
Amean     110     37.2913 (   0.00%)     36.5433 *   2.01%*
Amean     141     47.8937 (   0.00%)     46.5300 *   2.85%*
Amean     172     58.0273 (   0.00%)     56.4530 *   2.71%*
Amean     203     68.2530 (   0.00%)     66.3320 *   2.81%*
Amean     234     78.8987 (   0.00%)     76.8497 *   2.60%*
Amean     265     89.1520 (   0.00%)     86.8213 *   2.61%*
Amean     296     99.6920 (   0.00%)     96.9707 *   2.73%*

hackbench-thread-pipes
                             vanilla		     filter
Amean     1        0.2647 (   0.00%)      0.2633 (   0.50%)
Amean     4        0.6290 (   0.00%)      0.6607 (  -5.03%)
Amean     7        0.7850 (   0.00%)      0.7870 (  -0.25%)
Amean     12       1.3347 (   0.00%)      1.2577 (   5.77%)
Amean     21       3.1233 (   0.00%)      2.4613 *  21.20%*
Amean     30       5.7120 (   0.00%)      3.6847 *  35.49%*
Amean     48       8.1947 (   0.00%)      6.2670 *  23.52%*
Amean     79       9.1750 (   0.00%)      8.0640 *  12.11%*
Amean     110     10.6300 (   0.00%)      9.5583 *  10.08%*
Amean     141     12.7490 (   0.00%)     12.0167 *   5.74%*
Amean     172     15.1567 (   0.00%)     14.1570 *   6.60%*
Amean     203     17.5160 (   0.00%)     16.7883 (   4.15%)
Amean     234     19.8710 (   0.00%)     19.5370 (   1.68%)
Amean     265     23.2700 (   0.00%)     21.4017 *   8.03%*
Amean     296     25.4093 (   0.00%)     23.9943 *   5.57%*

hackbench-thread-sockets
                             vanilla		     filter
Amean     1        0.4467 (   0.00%)      0.4347 (   2.69%)
Amean     4        1.4757 (   0.00%)      1.4533 *   1.51%*
Amean     7        2.5320 (   0.00%)      2.4993 *   1.29%*
Amean     12       4.2617 (   0.00%)      4.1780 *   1.96%*
Amean     21       7.2397 (   0.00%)      7.0660 *   2.40%*
Amean     30      10.2200 (   0.00%)      9.9810 *   2.34%*
Amean     48      16.2623 (   0.00%)     16.0483 *   1.32%*
Amean     79      27.4307 (   0.00%)     26.8410 *   2.15%*
Amean     110     37.8993 (   0.00%)     37.3223 *   1.52%*
Amean     141     48.3890 (   0.00%)     47.4823 *   1.87%*
Amean     172     58.9887 (   0.00%)     57.7753 *   2.06%*
Amean     203     69.5853 (   0.00%)     68.0563 *   2.20%*
Amean     234     80.0743 (   0.00%)     78.4857 *   1.98%*
Amean     265     90.5473 (   0.00%)     89.3363 *   1.34%*
Amean     296    101.3857 (   0.00%)     99.7717 *   1.59%*

schbench
				   vanilla		   filter
Lat 50.0th-qrtle-1         6.00 (   0.00%)        6.00 (   0.00%)
Lat 75.0th-qrtle-1         8.00 (   0.00%)        8.00 (   0.00%)
Lat 90.0th-qrtle-1         9.00 (   0.00%)        8.00 (  11.11%)
Lat 95.0th-qrtle-1         9.00 (   0.00%)        8.00 (  11.11%)
Lat 99.0th-qrtle-1        10.00 (   0.00%)        9.00 (  10.00%)
Lat 99.5th-qrtle-1        11.00 (   0.00%)        9.00 (  18.18%)
Lat 99.9th-qrtle-1        11.00 (   0.00%)        9.00 (  18.18%)
Lat 50.0th-qrtle-2         6.00 (   0.00%)        7.00 ( -16.67%)
Lat 75.0th-qrtle-2         7.00 (   0.00%)        8.00 ( -14.29%)
Lat 90.0th-qrtle-2         8.00 (   0.00%)        9.00 ( -12.50%)
Lat 95.0th-qrtle-2         8.00 (   0.00%)       10.00 ( -25.00%)
Lat 99.0th-qrtle-2         9.00 (   0.00%)       11.00 ( -22.22%)
Lat 99.5th-qrtle-2         9.00 (   0.00%)       11.00 ( -22.22%)
Lat 99.9th-qrtle-2         9.00 (   0.00%)       11.00 ( -22.22%)
Lat 50.0th-qrtle-4         9.00 (   0.00%)        8.00 (  11.11%)
Lat 75.0th-qrtle-4        10.00 (   0.00%)       10.00 (   0.00%)
Lat 90.0th-qrtle-4        11.00 (   0.00%)       11.00 (   0.00%)
Lat 95.0th-qrtle-4        12.00 (   0.00%)       11.00 (   8.33%)
Lat 99.0th-qrtle-4        13.00 (   0.00%)       13.00 (   0.00%)
Lat 99.5th-qrtle-4        13.00 (   0.00%)       16.00 ( -23.08%)
Lat 99.9th-qrtle-4        13.00 (   0.00%)       19.00 ( -46.15%)
Lat 50.0th-qrtle-8        11.00 (   0.00%)       11.00 (   0.00%)
Lat 75.0th-qrtle-8        14.00 (   0.00%)       14.00 (   0.00%)
Lat 90.0th-qrtle-8        16.00 (   0.00%)       16.00 (   0.00%)
Lat 95.0th-qrtle-8        17.00 (   0.00%)       17.00 (   0.00%)
Lat 99.0th-qrtle-8        22.00 (   0.00%)       19.00 (  13.64%)
Lat 99.5th-qrtle-8        28.00 (   0.00%)       23.00 (  17.86%)
Lat 99.9th-qrtle-8        31.00 (   0.00%)       42.00 ( -35.48%)
Lat 50.0th-qrtle-16       17.00 (   0.00%)       17.00 (   0.00%)
Lat 75.0th-qrtle-16       23.00 (   0.00%)       23.00 (   0.00%)
Lat 90.0th-qrtle-16       26.00 (   0.00%)       27.00 (  -3.85%)
Lat 95.0th-qrtle-16       28.00 (   0.00%)       29.00 (  -3.57%)
Lat 99.0th-qrtle-16       32.00 (   0.00%)       33.00 (  -3.12%)
Lat 99.5th-qrtle-16       37.00 (   0.00%)       35.00 (   5.41%)
Lat 99.9th-qrtle-16       54.00 (   0.00%)       46.00 (  14.81%)
Lat 50.0th-qrtle-32       30.00 (   0.00%)       29.00 (   3.33%)
Lat 75.0th-qrtle-32       43.00 (   0.00%)       42.00 (   2.33%)
Lat 90.0th-qrtle-32       51.00 (   0.00%)       49.00 (   3.92%)
Lat 95.0th-qrtle-32       54.00 (   0.00%)       51.00 (   5.56%)
Lat 99.0th-qrtle-32       61.00 (   0.00%)       57.00 (   6.56%)
Lat 99.5th-qrtle-32       64.00 (   0.00%)       60.00 (   6.25%)
Lat 99.9th-qrtle-32       72.00 (   0.00%)       82.00 ( -13.89%)
Lat 50.0th-qrtle-47       44.00 (   0.00%)       45.00 (  -2.27%)
Lat 75.0th-qrtle-47       64.00 (   0.00%)       65.00 (  -1.56%)
Lat 90.0th-qrtle-47       75.00 (   0.00%)       77.00 (  -2.67%)
Lat 95.0th-qrtle-47       81.00 (   0.00%)       82.00 (  -1.23%)
Lat 99.0th-qrtle-47       92.00 (   0.00%)       98.00 (  -6.52%)
Lat 99.5th-qrtle-47      101.00 (   0.00%)      114.00 ( -12.87%)
Lat 99.9th-qrtle-47      271.00 (   0.00%)      167.00 (  38.38%)

netperf-udp
				    vanilla		    filter
Hmean     send-64         199.12 (   0.00%)      201.32 (   1.11%)
Hmean     send-128        396.22 (   0.00%)      397.01 (   0.20%)
Hmean     send-256        777.80 (   0.00%)      783.96 (   0.79%)
Hmean     send-1024      2972.62 (   0.00%)     3011.87 *   1.32%*
Hmean     send-2048      5600.64 (   0.00%)     5730.50 *   2.32%*
Hmean     send-3312      8757.45 (   0.00%)     8703.62 (  -0.61%)
Hmean     send-4096     10578.90 (   0.00%)    10590.93 (   0.11%)
Hmean     send-8192     17051.22 (   0.00%)    17189.62 *   0.81%*
Hmean     send-16384    27915.16 (   0.00%)    27816.01 (  -0.36%)
Hmean     recv-64         199.12 (   0.00%)      201.32 (   1.11%)
Hmean     recv-128        396.22 (   0.00%)      397.01 (   0.20%)
Hmean     recv-256        777.80 (   0.00%)      783.96 (   0.79%)
Hmean     recv-1024      2972.62 (   0.00%)     3011.87 *   1.32%*
Hmean     recv-2048      5600.64 (   0.00%)     5730.49 *   2.32%*
Hmean     recv-3312      8757.45 (   0.00%)     8703.61 (  -0.61%)
Hmean     recv-4096     10578.90 (   0.00%)    10590.93 (   0.11%)
Hmean     recv-8192     17051.21 (   0.00%)    17189.57 *   0.81%*
Hmean     recv-16384    27915.08 (   0.00%)    27815.86 (  -0.36%)

netperf-tcp
			       vanilla		       filter
Hmean     64         811.07 (   0.00%)      835.46 *   3.01%*
Hmean     128       1614.86 (   0.00%)     1652.27 *   2.32%*
Hmean     256       3131.16 (   0.00%)     3119.01 (  -0.39%)
Hmean     1024     10286.12 (   0.00%)    10333.64 (   0.46%)
Hmean     2048     16231.88 (   0.00%)    17141.88 *   5.61%*
Hmean     3312     20705.91 (   0.00%)    21703.49 *   4.82%*
Hmean     4096     22650.75 (   0.00%)    23904.09 *   5.53%*
Hmean     8192     27984.06 (   0.00%)    29170.57 *   4.24%*
Hmean     16384    32816.85 (   0.00%)    33351.41 *   1.63%*

tbench4 Throughput
			     vanilla		     filter
Hmean     1        300.07 (   0.00%)      302.52 *   0.82%*
Hmean     2        617.72 (   0.00%)      598.45 *  -3.12%*
Hmean     4       1213.99 (   0.00%)     1206.36 *  -0.63%*
Hmean     8       2373.78 (   0.00%)     2372.28 *  -0.06%*
Hmean     16      4777.82 (   0.00%)     4711.44 *  -1.39%*
Hmean     32      7182.50 (   0.00%)     7718.15 *   7.46%*
Hmean     64      8611.44 (   0.00%)     9409.29 *   9.27%*
Hmean     128    18102.63 (   0.00%)    20650.23 *  14.07%*
Hmean     256    18029.28 (   0.00%)    20611.03 *  14.32%*
Hmean     384    17986.44 (   0.00%)    19361.29 *   7.64%*

Conclusion
==========

There seems like not much obvious regressions except the hackbench pipe
tests with minor groups like 1/4, and some of the benchmarks showed great
improvement.

As preious said, the domain scan works well under light workload by simply
traversing the cpus of the LLC due to lots of idle cpus can be available.
So in this case, the cost of maintaining the filter can hardly contribute
to the scan efficiency, but rather adds to the scheduling overhead slowing
down the system.

One reasonable way to fix it is to disable the filter when the system is
not loaded. Three possible solutions come to my mind:

  a. Disable the filter when the number of unoccupied cpus in the LLC
     is more than a threshold. This is straight but not easy to define a
     proper threshold for different topologies or workloads. So I gave up
     on this quickly.

  b. Enable the filter when average idle time reduces. This is what the
     SIS_PROP relies on. I did a test on enabling the filter when nr=4,
     but the result is not convincing..

  c. Enable the filter when scan efficiency drops to a threshold. Like a,
     the threshold is hard to define.

I am still working on this and open to discussion and suggestions.
Comments and tests are appreciated!

v3 -> v4:
  - update filter in load_balance rather than in the tick
  - now the filter contains unoccupied cpus rather than overloaded ones
  - added mechanisms to deal with the false positive cases

v2 -> v3:
  - removed sched-idle balance feature and focus on SIS
  - take non-CFS tasks into consideration
  - several fixes/improvement suggested by Josh Don

v1 -> v2:
  - several optimizations on sched-idle balancing
  - ignore asym topos in can_migrate_task
  - add more benchmarks including SIS efficiency
  - re-organize patch as suggested by Mel

v3: https://lore.kernel.org/lkml/53fcde27-7dd2-5150-633b-4e2acc37bb6f@bytedance.com/
v2: https://lore.kernel.org/lkml/20220409135104.3733193-1-wuyun.abel@bytedance.com/
v1: https://lore.kernel.org/lkml/20220217154403.6497-5-wuyun.abel@bytedance.com/

Abel Wu (7):
  sched/fair: default to false in test_idle_cores
  sched/fair: remove redundant check in select_idle_smt
  sched/fair: avoid double search on same cpu
  sched/fair: remove useless check in select_idle_core
  sched/fair: skip SIS domain search if fully busy
  sched/fair: skip busy cores in SIS search
  sched/fair: de-entropy for SIS filter

 include/linux/sched/topology.h |  62 ++++++++-
 kernel/sched/fair.c            | 233 +++++++++++++++++++++++++++++----
 kernel/sched/topology.c        |  12 +-
 3 files changed, 277 insertions(+), 30 deletions(-)

-- 
2.31.1

