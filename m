Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4B6651BF36
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 14:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350686AbiEEM1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 08:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbiEEM1U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 08:27:20 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0410E5520E
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 05:23:40 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id x52so3500207pfu.11
        for <linux-kernel@vger.kernel.org>; Thu, 05 May 2022 05:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N++7ymQYI5HMpz6OL0dWDQGYyNZZOtEk0cmIQKAOiDI=;
        b=NM7sWU88uiJGt7QTp/qCoBJuCif8qHYTufWAum0sLEvLN1sJ4DCLEeoyCOf0oTLw3V
         fiK0jMSh1M0glXGtrddjLeulmZe+fcYI/lOH/xtuajC9Y2HcOBb6Eomr/o//tRIDSg4r
         mv48OzRH6YEq8prQs7ZFs+19NIjiB68ZRbuwc6RcpHKKikHxW6wYX9OXTFTCfD+3YrrG
         eWC322H4vNCtDJ0DH2sfgkqmtvNdsbOefWG7LAjY1fh6CEZ20P2kvoZv9c4McgvPerAs
         2s65aHD2RGjjIOcmXvLWpyxOWthqZP4p0GG1FO9E5p7/1kLy3YGDhw/ZcsN2FH1cYG1g
         OB8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=N++7ymQYI5HMpz6OL0dWDQGYyNZZOtEk0cmIQKAOiDI=;
        b=M9on/f/xxTEFlr/nFZcZxCXP/grI76U/EJ3C88T3LqDZoc+O4NRlJPRoexG4VtgvP0
         IP+VJ744CNpqSa29muQUz805F1uY7oPZ9/VhoRfedIxqN4Iy8j3I7CNWNggPR32Lbsip
         9Oae43aIwVrDow4tzyrnD7Ri2JLCFr+Kkipwuglun3qUpVQHEwv5Ex97smvto9IKdZcg
         lxZsYRNdQ+JT5dBM7oKuFxRTgtsZwBXphikv0HLnRmaK9VWUW9aeNnvMiqNyhtvokUBi
         +EbDBQVcp+glUFNbEgHd/MV6W+8bRSGml25nZsH7KCuUyX5AAFLqlyoifuQ5uqc7PiHH
         c+4g==
X-Gm-Message-State: AOAM530Mbwh8XFU1aGBvEZfimjPsyzvq6Y4Rq9My/i0RcAw+2YYkYlKa
        FOr4SZqqd8b/WbbSx4YwhaDXcg==
X-Google-Smtp-Source: ABdhPJye0RfSF6KgpGkvPdwgZi5z48CYD0pz1aN1jTq5UuvKwnTfCtluPOvyBcS7qcvxQb4PZdw96Q==
X-Received: by 2002:a65:43cc:0:b0:3c2:6d65:f1f0 with SMTP id n12-20020a6543cc000000b003c26d65f1f0mr11524529pgp.0.1651753419354;
        Thu, 05 May 2022 05:23:39 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id u21-20020a170902a61500b0015e8d4eb1f9sm1435194plq.67.2022.05.05.05.23.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 May 2022 05:23:39 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>
Cc:     linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v3] sched/fair: filter out overloaded cpus in SIS
Date:   Thu,  5 May 2022 20:23:31 +0800
Message-Id: <20220505122331.42696-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try to improve searching efficiency of SIS by filtering out the
overloaded cpus, and as a result the more overloaded the system
is, the less cpus will be searched.

The overloaded cpus are tracked through LLC shared domain. To
regulate accesses to the shared data, the update happens mainly
at the tick. But in order to make it more accurate, we also take
the task migrations into consideration during load balancing which
can be quite frequent due to short running workload causing newly-
idle. Since an overloaded runqueue requires at least 2 non-idle
tasks runnable, we could have more faith on the "frequent newly-
idle" case.

Benchmark
=========

Tests are done in an Intel(R) Xeon(R) Platinum 8260 CPU@2.40GHz
machine with 2 NUMA nodes each of which has 24 cores with SMT2
enabled, so 96 CPUs in total.

All of the benchmarks are done inside a normal cpu cgroup in a
clean environment with cpu turbo disabled.

Based on tip sched/core 089c02ae2771 (v5.18-rc1).

Results
=======

hackbench-process-pipes
                             vanilla		     filter
Amean     1        0.2537 (   0.00%)      0.2330 (   8.15%)
Amean     4        0.7090 (   0.00%)      0.7440 *  -4.94%*
Amean     7        0.9153 (   0.00%)      0.9040 (   1.24%)
Amean     12       1.1473 (   0.00%)      1.0857 *   5.37%*
Amean     21       2.7210 (   0.00%)      2.2320 *  17.97%*
Amean     30       4.8263 (   0.00%)      3.6170 *  25.06%*
Amean     48       7.4107 (   0.00%)      6.1130 *  17.51%*
Amean     79       9.2120 (   0.00%)      8.2350 *  10.61%*
Amean     110     10.1647 (   0.00%)      8.8043 *  13.38%*
Amean     141     11.5713 (   0.00%)     10.5867 *   8.51%*
Amean     172     13.7963 (   0.00%)     12.8120 *   7.13%*
Amean     203     15.9283 (   0.00%)     14.8703 *   6.64%*
Amean     234     17.8737 (   0.00%)     17.1053 *   4.30%*
Amean     265     19.8443 (   0.00%)     18.7870 *   5.33%*
Amean     296     22.4147 (   0.00%)     21.3943 *   4.55%*

There is a regression in 4-groups test in which case lots of busy
cpus can be found in the system. The busy cpus are not recorded in
the overloaded cpu mask, so we trade overhead for nothing in SIS.
This is the worst case of this feature.

hackbench-process-sockets
                             vanilla		     filter
Amean     1        0.5343 (   0.00%)      0.5270 (   1.37%)
Amean     4        1.4500 (   0.00%)      1.4273 *   1.56%*
Amean     7        2.4813 (   0.00%)      2.4383 *   1.73%*
Amean     12       4.1357 (   0.00%)      4.0827 *   1.28%*
Amean     21       6.9707 (   0.00%)      6.9290 (   0.60%)
Amean     30       9.8373 (   0.00%)      9.6730 *   1.67%*
Amean     48      15.6233 (   0.00%)     15.3213 *   1.93%*
Amean     79      26.2763 (   0.00%)     25.3293 *   3.60%*
Amean     110     36.6170 (   0.00%)     35.8920 *   1.98%*
Amean     141     47.0720 (   0.00%)     45.8773 *   2.54%*
Amean     172     57.0580 (   0.00%)     56.1627 *   1.57%*
Amean     203     67.2040 (   0.00%)     66.4323 *   1.15%*
Amean     234     77.8897 (   0.00%)     76.6320 *   1.61%*
Amean     265     88.0437 (   0.00%)     87.1400 (   1.03%)
Amean     296     98.2387 (   0.00%)     96.8633 *   1.40%*

hackbench-thread-pipes
                             vanilla		     filter
Amean     1        0.2693 (   0.00%)      0.2800 *  -3.96%*
Amean     4        0.7843 (   0.00%)      0.7680 (   2.08%)
Amean     7        0.9287 (   0.00%)      0.9217 (   0.75%)
Amean     12       1.4443 (   0.00%)      1.3680 *   5.29%*
Amean     21       3.5150 (   0.00%)      3.1107 *  11.50%*
Amean     30       6.3997 (   0.00%)      5.2160 *  18.50%*
Amean     48       8.4183 (   0.00%)      7.8477 *   6.78%*
Amean     79      10.0713 (   0.00%)      9.2240 *   8.41%*
Amean     110     10.9940 (   0.00%)     10.1280 *   7.88%*
Amean     141     13.6347 (   0.00%)     11.9387 *  12.44%*
Amean     172     15.0523 (   0.00%)     14.4117 (   4.26%)
Amean     203     18.0710 (   0.00%)     17.3533 (   3.97%)
Amean     234     19.7413 (   0.00%)     19.8453 (  -0.53%)
Amean     265     23.1820 (   0.00%)     22.8223 (   1.55%)
Amean     296     25.3820 (   0.00%)     24.2397 (   4.50%)

hackbench-thread-sockets
                             vanilla		     filter
Amean     1        0.5893 (   0.00%)      0.5750 *   2.43%*
Amean     4        1.4853 (   0.00%)      1.4727 (   0.85%)
Amean     7        2.5353 (   0.00%)      2.5047 *   1.21%*
Amean     12       4.3003 (   0.00%)      4.1910 *   2.54%*
Amean     21       7.1930 (   0.00%)      7.1533 (   0.55%)
Amean     30      10.0983 (   0.00%)      9.9690 *   1.28%*
Amean     48      15.9853 (   0.00%)     15.6963 *   1.81%*
Amean     79      26.7537 (   0.00%)     25.9497 *   3.01%*
Amean     110     37.3850 (   0.00%)     36.6793 *   1.89%*
Amean     141     47.7730 (   0.00%)     47.0967 *   1.42%*
Amean     172     58.4280 (   0.00%)     57.5513 *   1.50%*
Amean     203     69.3093 (   0.00%)     67.7680 *   2.22%*
Amean     234     80.0190 (   0.00%)     78.2633 *   2.19%*
Amean     265     90.7237 (   0.00%)     89.1027 *   1.79%*
Amean     296    101.1153 (   0.00%)     99.2693 *   1.83%*

schbench
				   vanilla		   filter
Lat 50.0th-qrtle-1         5.00 (   0.00%)        5.00 (   0.00%)
Lat 75.0th-qrtle-1         5.00 (   0.00%)        5.00 (   0.00%)
Lat 90.0th-qrtle-1         5.00 (   0.00%)        5.00 (   0.00%)
Lat 95.0th-qrtle-1         5.00 (   0.00%)        5.00 (   0.00%)
Lat 99.0th-qrtle-1         6.00 (   0.00%)        6.00 (   0.00%)
Lat 99.5th-qrtle-1         7.00 (   0.00%)        6.00 (  14.29%)
Lat 99.9th-qrtle-1         7.00 (   0.00%)        7.00 (   0.00%)
Lat 50.0th-qrtle-2         6.00 (   0.00%)        6.00 (   0.00%)
Lat 75.0th-qrtle-2         7.00 (   0.00%)        7.00 (   0.00%)
Lat 90.0th-qrtle-2         7.00 (   0.00%)        7.00 (   0.00%)
Lat 95.0th-qrtle-2         7.00 (   0.00%)        7.00 (   0.00%)
Lat 99.0th-qrtle-2         9.00 (   0.00%)        8.00 (  11.11%)
Lat 99.5th-qrtle-2         9.00 (   0.00%)        9.00 (   0.00%)
Lat 99.9th-qrtle-2        12.00 (   0.00%)       11.00 (   8.33%)
Lat 50.0th-qrtle-4         8.00 (   0.00%)        8.00 (   0.00%)
Lat 75.0th-qrtle-4        10.00 (   0.00%)       10.00 (   0.00%)
Lat 90.0th-qrtle-4        10.00 (   0.00%)       11.00 ( -10.00%)
Lat 95.0th-qrtle-4        11.00 (   0.00%)       11.00 (   0.00%)
Lat 99.0th-qrtle-4        12.00 (   0.00%)       13.00 (  -8.33%)
Lat 99.5th-qrtle-4        16.00 (   0.00%)       14.00 (  12.50%)
Lat 99.9th-qrtle-4        17.00 (   0.00%)       15.00 (  11.76%)
Lat 50.0th-qrtle-8        13.00 (   0.00%)       13.00 (   0.00%)
Lat 75.0th-qrtle-8        16.00 (   0.00%)       16.00 (   0.00%)
Lat 90.0th-qrtle-8        18.00 (   0.00%)       18.00 (   0.00%)
Lat 95.0th-qrtle-8        19.00 (   0.00%)       18.00 (   5.26%)
Lat 99.0th-qrtle-8        24.00 (   0.00%)       21.00 (  12.50%)
Lat 99.5th-qrtle-8        28.00 (   0.00%)       26.00 (   7.14%)
Lat 99.9th-qrtle-8        33.00 (   0.00%)       32.00 (   3.03%)
Lat 50.0th-qrtle-16       20.00 (   0.00%)       20.00 (   0.00%)
Lat 75.0th-qrtle-16       28.00 (   0.00%)       28.00 (   0.00%)
Lat 90.0th-qrtle-16       32.00 (   0.00%)       32.00 (   0.00%)
Lat 95.0th-qrtle-16       34.00 (   0.00%)       34.00 (   0.00%)
Lat 99.0th-qrtle-16       40.00 (   0.00%)       40.00 (   0.00%)
Lat 99.5th-qrtle-16       44.00 (   0.00%)       44.00 (   0.00%)
Lat 99.9th-qrtle-16       53.00 (   0.00%)       67.00 ( -26.42%)
Lat 50.0th-qrtle-32       39.00 (   0.00%)       36.00 (   7.69%)
Lat 75.0th-qrtle-32       57.00 (   0.00%)       52.00 (   8.77%)
Lat 90.0th-qrtle-32       69.00 (   0.00%)       61.00 (  11.59%)
Lat 95.0th-qrtle-32       76.00 (   0.00%)       64.00 (  15.79%)
Lat 99.0th-qrtle-32       88.00 (   0.00%)       74.00 (  15.91%)
Lat 99.5th-qrtle-32       91.00 (   0.00%)       80.00 (  12.09%)
Lat 99.9th-qrtle-32      115.00 (   0.00%)      107.00 (   6.96%)
Lat 50.0th-qrtle-47       63.00 (   0.00%)       55.00 (  12.70%)
Lat 75.0th-qrtle-47       93.00 (   0.00%)       80.00 (  13.98%)
Lat 90.0th-qrtle-47      116.00 (   0.00%)       97.00 (  16.38%)
Lat 95.0th-qrtle-47      129.00 (   0.00%)      106.00 (  17.83%)
Lat 99.0th-qrtle-47      148.00 (   0.00%)      123.00 (  16.89%)
Lat 99.5th-qrtle-47      157.00 (   0.00%)      132.00 (  15.92%)
Lat 99.9th-qrtle-47      387.00 (   0.00%)      164.00 (  57.62%)

netperf-udp
				    vanilla		    filter
Hmean     send-64         183.09 (   0.00%)      182.28 (  -0.44%)
Hmean     send-128        364.68 (   0.00%)      363.12 (  -0.43%)
Hmean     send-256        715.38 (   0.00%)      716.57 (   0.17%)
Hmean     send-1024      2764.76 (   0.00%)     2779.17 (   0.52%)
Hmean     send-2048      5282.93 (   0.00%)     5220.41 *  -1.18%*
Hmean     send-3312      8282.26 (   0.00%)     8121.78 *  -1.94%*
Hmean     send-4096     10108.12 (   0.00%)    10042.98 (  -0.64%)
Hmean     send-8192     16868.49 (   0.00%)    16826.99 (  -0.25%)
Hmean     send-16384    26230.44 (   0.00%)    26271.85 (   0.16%)
Hmean     recv-64         183.09 (   0.00%)      182.28 (  -0.44%)
Hmean     recv-128        364.68 (   0.00%)      363.12 (  -0.43%)
Hmean     recv-256        715.38 (   0.00%)      716.57 (   0.17%)
Hmean     recv-1024      2764.76 (   0.00%)     2779.17 (   0.52%)
Hmean     recv-2048      5282.93 (   0.00%)     5220.39 *  -1.18%*
Hmean     recv-3312      8282.26 (   0.00%)     8121.78 *  -1.94%*
Hmean     recv-4096     10108.12 (   0.00%)    10042.97 (  -0.64%)
Hmean     recv-8192     16868.47 (   0.00%)    16826.93 (  -0.25%)
Hmean     recv-16384    26230.44 (   0.00%)    26271.75 (   0.16%)

The overhead this feature added to the scheduler can be unfriendly
to the fast context-switching workloads like netperf/tbench. But
the test result seems fine.

netperf-tcp
			       vanilla		       filter
Hmean     64         863.35 (   0.00%)     1176.11 *  36.23%*
Hmean     128       1674.32 (   0.00%)     2223.37 *  32.79%*
Hmean     256       3151.03 (   0.00%)     4109.64 *  30.42%*
Hmean     1024     10281.94 (   0.00%)    12799.28 *  24.48%*
Hmean     2048     16906.05 (   0.00%)    20129.91 *  19.07%*
Hmean     3312     21246.21 (   0.00%)    24747.24 *  16.48%*
Hmean     4096     23690.57 (   0.00%)    26596.35 *  12.27%*
Hmean     8192     28758.29 (   0.00%)    30423.10 *   5.79%*
Hmean     16384    33071.06 (   0.00%)    34262.39 *   3.60%*

The suspicious improvement (and regression in tbench4-128) needs
further digging..

tbench4 Throughput
			     vanilla		     filter
Hmean     1        293.71 (   0.00%)      298.89 *   1.76%*
Hmean     2        583.25 (   0.00%)      596.00 *   2.19%*
Hmean     4       1162.40 (   0.00%)     1176.73 *   1.23%*
Hmean     8       2309.28 (   0.00%)     2332.89 *   1.02%*
Hmean     16      4517.23 (   0.00%)     4587.60 *   1.56%*
Hmean     32      7458.54 (   0.00%)     7550.19 *   1.23%*
Hmean     64      9041.62 (   0.00%)     9192.69 *   1.67%*
Hmean     128    19983.62 (   0.00%)    12228.91 * -38.81%*
Hmean     256    20054.12 (   0.00%)    20997.33 *   4.70%*
Hmean     384    19137.11 (   0.00%)    20331.14 *   6.24%*

v3:
  - removed sched-idle balance feature and focus on SIS
  - take non-CFS tasks into consideration
  - several fixes/improvement suggested by Josh Don

v2:
  - several optimizations on sched-idle balancing
  - ignore asym topos in can_migrate_task
  - add more benchmarks including SIS efficiency
  - re-organize patch as suggested by Mel

v1: https://lore.kernel.org/lkml/20220217154403.6497-5-wuyun.abel@bytedance.com/
v2: https://lore.kernel.org/lkml/20220409135104.3733193-1-wuyun.abel@bytedance.com/

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 include/linux/sched/topology.h | 12 ++++++++++
 kernel/sched/core.c            | 38 ++++++++++++++++++++++++++++++
 kernel/sched/fair.c            | 43 +++++++++++++++++++++++++++-------
 kernel/sched/idle.c            |  1 +
 kernel/sched/sched.h           |  4 ++++
 kernel/sched/topology.c        |  4 +++-
 6 files changed, 92 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 56cffe42abbc..95c7ad1e05b5 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -81,8 +81,20 @@ struct sched_domain_shared {
 	atomic_t	ref;
 	atomic_t	nr_busy_cpus;
 	int		has_idle_cores;
+
+	/*
+	 * Tracking of the overloaded cpus can be heavy, so start
+	 * a new cacheline to avoid false sharing.
+	 */
+	atomic_t	nr_overloaded_cpus ____cacheline_aligned;
+	unsigned long	overloaded_cpus[]; /* Must be last */
 };
 
+static inline struct cpumask *sdo_mask(struct sched_domain_shared *sds)
+{
+	return to_cpumask(sds->overloaded_cpus);
+}
+
 struct sched_domain {
 	/* These fields must be setup */
 	struct sched_domain __rcu *parent;	/* top domain must be null terminated */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 51efaabac3e4..a29801c8b363 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5320,6 +5320,42 @@ __setup("resched_latency_warn_ms=", setup_resched_latency_warn_ms);
 static inline u64 cpu_resched_latency(struct rq *rq) { return 0; }
 #endif /* CONFIG_SCHED_DEBUG */
 
+#ifdef CONFIG_SMP
+static inline bool rq_overloaded(struct rq *rq)
+{
+	return rq->nr_running - rq->cfs.idle_h_nr_running > 1;
+}
+
+void update_overloaded_rq(struct rq *rq)
+{
+	struct sched_domain_shared *sds;
+	bool overloaded = rq_overloaded(rq);
+	int cpu = cpu_of(rq);
+
+	lockdep_assert_rq_held(rq);
+
+	if (rq->overloaded == overloaded)
+		return;
+
+	rcu_read_lock();
+	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
+	if (unlikely(!sds))
+		goto unlock;
+
+	if (overloaded) {
+		cpumask_set_cpu(cpu, sdo_mask(sds));
+		atomic_inc(&sds->nr_overloaded_cpus);
+	} else {
+		cpumask_clear_cpu(cpu, sdo_mask(sds));
+		atomic_dec(&sds->nr_overloaded_cpus);
+	}
+
+	rq->overloaded = overloaded;
+unlock:
+	rcu_read_unlock();
+}
+#endif
+
 /*
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
@@ -5346,6 +5382,7 @@ void scheduler_tick(void)
 		resched_latency = cpu_resched_latency(rq);
 	calc_global_load_tick(rq);
 	sched_core_tick(rq);
+	update_overloaded_rq(rq);
 
 	rq_unlock(rq, &rf);
 
@@ -9578,6 +9615,7 @@ void __init sched_init(void)
 		rq->wake_stamp = jiffies;
 		rq->wake_avg_idle = rq->avg_idle;
 		rq->max_idle_balance_cost = sysctl_sched_migration_cost;
+		rq->overloaded = 0;
 
 		INIT_LIST_HEAD(&rq->cfs_tasks);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index d4bd299d67ab..79b4ff24faee 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6323,7 +6323,9 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
 static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target)
 {
 	struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
-	int i, cpu, idle_cpu = -1, nr = INT_MAX;
+	struct sched_domain_shared *sds = sd->shared;
+	int nr, nro, weight = sd->span_weight;
+	int i, cpu, idle_cpu = -1;
 	struct rq *this_rq = this_rq();
 	int this = smp_processor_id();
 	struct sched_domain *this_sd;
@@ -6333,7 +6335,23 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 	if (!this_sd)
 		return -1;
 
+	nro = atomic_read(&sds->nr_overloaded_cpus);
+	if (nro == weight)
+		goto out;
+
+	nr = min_t(int, weight, p->nr_cpus_allowed);
+
+	/*
+	 * It's unlikely to find an idle cpu if the system is under
+	 * heavy pressure, so skip searching to save a few cycles
+	 * and relieve cache traffic.
+	 */
+	if (weight - nro < (nr >> 4) && !has_idle_core)
+		return -1;
+
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
+	if (nro > 1)
+		cpumask_andnot(cpus, cpus, sdo_mask(sds));
 
 	if (sched_feat(SIS_PROP) && !has_idle_core) {
 		u64 avg_cost, avg_idle, span_avg;
@@ -6354,7 +6372,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		avg_idle = this_rq->wake_avg_idle;
 		avg_cost = this_sd->avg_scan_cost + 1;
 
-		span_avg = sd->span_weight * avg_idle;
+		span_avg = weight * avg_idle;
 		if (span_avg > 4*avg_cost)
 			nr = div_u64(span_avg, avg_cost);
 		else
@@ -6378,9 +6396,6 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 		}
 	}
 
-	if (has_idle_core)
-		set_idle_cores(target, false);
-
 	if (sched_feat(SIS_PROP) && !has_idle_core) {
 		time = cpu_clock(this) - time;
 
@@ -6392,6 +6407,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 
 		update_avg(&this_sd->avg_scan_cost, time);
 	}
+out:
+	if (has_idle_core)
+		WRITE_ONCE(sds->has_idle_cores, 0);
 
 	return idle_cpu;
 }
@@ -7904,6 +7922,7 @@ static struct task_struct *detach_one_task(struct lb_env *env)
 			continue;
 
 		detach_task(p, env);
+		update_overloaded_rq(env->src_rq);
 
 		/*
 		 * Right now, this is only the second place where
@@ -8047,6 +8066,9 @@ static int detach_tasks(struct lb_env *env)
 		list_move(&p->se.group_node, tasks);
 	}
 
+	if (detached)
+		update_overloaded_rq(env->src_rq);
+
 	/*
 	 * Right now, this is one of only two places we collect this stat
 	 * so we can safely collect detach_one_task() stats here rather
@@ -8080,6 +8102,7 @@ static void attach_one_task(struct rq *rq, struct task_struct *p)
 	rq_lock(rq, &rf);
 	update_rq_clock(rq);
 	attach_task(rq, p);
+	update_overloaded_rq(rq);
 	rq_unlock(rq, &rf);
 }
 
@@ -8090,20 +8113,22 @@ static void attach_one_task(struct rq *rq, struct task_struct *p)
 static void attach_tasks(struct lb_env *env)
 {
 	struct list_head *tasks = &env->tasks;
+	struct rq *rq = env->dst_rq;
 	struct task_struct *p;
 	struct rq_flags rf;
 
-	rq_lock(env->dst_rq, &rf);
-	update_rq_clock(env->dst_rq);
+	rq_lock(rq, &rf);
+	update_rq_clock(rq);
 
 	while (!list_empty(tasks)) {
 		p = list_first_entry(tasks, struct task_struct, se.group_node);
 		list_del_init(&p->se.group_node);
 
-		attach_task(env->dst_rq, p);
+		attach_task(rq, p);
 	}
 
-	rq_unlock(env->dst_rq, &rf);
+	update_overloaded_rq(rq);
+	rq_unlock(rq, &rf);
 }
 
 #ifdef CONFIG_NO_HZ_COMMON
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index ecb0d7052877..7b65c9046a75 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -433,6 +433,7 @@ static void put_prev_task_idle(struct rq *rq, struct task_struct *prev)
 static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool first)
 {
 	update_idle_core(rq);
+	update_overloaded_rq(rq);
 	schedstat_inc(rq->sched_goidle);
 }
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8dccb34eb190..d2b6e65cc336 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -997,6 +997,7 @@ struct rq {
 
 	unsigned char		nohz_idle_balance;
 	unsigned char		idle_balance;
+	unsigned char		overloaded;
 
 	unsigned long		misfit_task_load;
 
@@ -1830,8 +1831,11 @@ extern int sched_update_scaling(void);
 
 extern void flush_smp_call_function_from_idle(void);
 
+extern void update_overloaded_rq(struct rq *rq);
+
 #else /* !CONFIG_SMP: */
 static inline void flush_smp_call_function_from_idle(void) { }
+static inline void update_overloaded_rq(struct rq *rq) { }
 #endif
 
 #include "stats.h"
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 810750e62118..6d5291875275 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1620,6 +1620,8 @@ sd_init(struct sched_domain_topology_level *tl,
 		sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
 		atomic_inc(&sd->shared->ref);
 		atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
+		atomic_set(&sd->shared->nr_overloaded_cpus, 0);
+		cpumask_clear(sdo_mask(sd->shared));
 	}
 
 	sd->private = sdd;
@@ -2085,7 +2087,7 @@ static int __sdt_alloc(const struct cpumask *cpu_map)
 
 			*per_cpu_ptr(sdd->sd, j) = sd;
 
-			sds = kzalloc_node(sizeof(struct sched_domain_shared),
+			sds = kzalloc_node(sizeof(struct sched_domain_shared) + cpumask_size(),
 					GFP_KERNEL, cpu_to_node(j));
 			if (!sds)
 				return -ENOMEM;
-- 
2.31.1

