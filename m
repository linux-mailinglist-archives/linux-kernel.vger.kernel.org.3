Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF735B2E51
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 07:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiIIFxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 01:53:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiIIFxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 01:53:21 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3989CB6D1A
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 22:53:19 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id v4so597627pgi.10
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 22:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=zw8CBII57YhTnzD6DSckM9A+jbg9YkXRhIlxlxnR0HQ=;
        b=hLorwWIpBhFNs3svKhrQNPDaUy3fTPkKZya71qcRjSaTWm2QSAoDvEb8X+Kw54+s4s
         oDKbqzmEzan3c3xPzlpBtZrTDG8jIH4rv7u0HNlqPzRtdwhMOPha5lKzGnwQ85PCuon6
         CdaKmPCXX18KO8v22zHBbNGhjlDrf6H20MAXPNq52Lo3nB5cOGO2BrqAZ4dKYnxwNzOv
         jOP4SWvSGP147OwaaE+2gtDf1uzoWECXDgzq2XXqgz9OmgdWBR387b7+MzXBFenOpOn1
         y/EKSt6Ie2gHTHWZx5csXDlinRsjox/yVAKqkei7mduQocaY/b427XGk0VL2wbAXMoGA
         EJxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=zw8CBII57YhTnzD6DSckM9A+jbg9YkXRhIlxlxnR0HQ=;
        b=I8aAxfUR24u77XA+K2n7g4zpYz6q+33ueLu9RdgrS/Xw/BQKxvCZG4K6MYX2v+tcl7
         kF+GtbbKdK/sBcDNOeIhUZ+ZfkT8bmXeY5faEmZyDz92KzeL8mmvxuLMs4mjRdGhvz5H
         fJqd9mdMQPokWM0hRx8ShM/hJBVHQcEzPhbKqy/VzLBFoEOzf1RvLGduqhjbh8Iousza
         Cd21Jyo5S5ItVerQtg0yuQLKJBiE5cPCVTZMrY4+bB5AITB+okMasP/mj52FhbG6OYbT
         kjBCRkENciuwCrfuEw3ygve7elO3ctBQMO7S+btoriMRK7YezPvi/tXvjl6ppBibjT/k
         Ly0g==
X-Gm-Message-State: ACgBeo3lMGD489nB29idx9k3hcmXoCyAQn8GrTt9pQjd8rCGM5/+I9iT
        rt/VESjxkG7+e3KKPIiuWzl9Ow==
X-Google-Smtp-Source: AA6agR6OykdXOTpqW00962z2ZZ6rq6MItA87s6EFSjHUtddDPQ9bXPEy6iFVp5jHhIBQS0ERn4F9cQ==
X-Received: by 2002:a05:6a00:1410:b0:528:5a5a:d846 with SMTP id l16-20020a056a00141000b005285a5ad846mr13007089pfu.9.1662702798563;
        Thu, 08 Sep 2022 22:53:18 -0700 (PDT)
Received: from localhost.localdomain ([139.177.225.249])
        by smtp.gmail.com with ESMTPSA id y66-20020a636445000000b00421841943dfsm464380pgb.12.2022.09.08.22.53.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Sep 2022 22:53:18 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v5 0/5] sched/fair: Improve scan efficiency of SIS
Date:   Fri,  9 Sep 2022 13:52:59 +0800
Message-Id: <20220909055304.25171-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
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

The wakeup fastpath for fair tasks, select_idle_sibling() aka SIS,
plays an important role in maximizing the usage of cpu resources and
can greatly affect overall performance of the system.

The SIS tries to find an idle cpu inside the targeting LLC to place
the woken-up task. The cache hot cpus are preferred, but if none of
them is idle, just fallback to the other cpus of that LLC by firing
a domain scan.  The domain scan works well under light pressure by
simply traversing the cpus of the LLC due to lots of idle cpus can
be available.

But things change. The LLCs are getting bigger in modern and future
machines, and the cloud service providers are consistently trying to
reduce TCO by pushing more load squeezing all kinds of resources.
So the fashion of simply traversing doesn't fit well to the future
requirement.

There are already features like SIS_{UTIL,PROP} exist to cope with
the scalability issue by limiting the scan depth, and it would be
better if we can improve the way of how it scans as well. And this
is exactly what the SIS_FILTER is born for.

So this patchset will focus on improving the efficiency of the SIS
domain scan:

 - Patch 1~2, give a chance to scan for idle cores if has_idle_core
   is true even when the LLC is overloaded (nr_idle_scan == 0). This
   helps exploiting the cpu resources by more actively kicking idle
   cores working.

 - Patch 3, add check on whether there are any tasks pending right
   at the beginning of __update_idle_core(), so the has_idle_cores
   hint won't be mistakenly updated if the cpu isn't idle any more.

 - Patch 4, skip SIS domain scan if the target LLC is fully busy.
   So the cpu resources can be used more wisely rather than wasting
   time trying to find an idle cpu that probably not exist.

 - Patch 5, introduce the SIS_FILTER feature to optimize the way of
   scanning LLC, helping SIS_{UTIL,PROP} to work more efficiently.

Benchmark
=========

Tests are done in a dual socket (2 x 24C/48T) machine modeled Intel
Xeon(R) Platinum 8260, with SNC configuration:

	SNC on:  4 NUMA nodes each of which has 12C/24T
	SNC off: 2 NUMA nodes each of which has 24C/48T

All of the benchmarks are done inside a normal cpu cgroup in a clean
environment with cpu turbo disabled.

Based on tip sched/core 0fba527e959d (v5.19.0).

Results
=======

hackbench-process-pipes
                         vanilla		patched
(SNC on)
Amean     1        0.4480 (   0.00%)      0.4500 (  -0.45%)
Amean     4        0.6137 (   0.00%)      0.5990 (   2.39%)
Amean     7        0.7530 (   0.00%)      0.7377 (   2.04%)
Amean     12       1.1230 (   0.00%)      1.0490 *   6.59%*
Amean     21       2.0567 (   0.00%)      1.8680 *   9.17%*
Amean     30       3.0847 (   0.00%)      2.7710 *  10.17%*
Amean     48       5.9043 (   0.00%)      4.5393 *  23.12%*
Amean     79       9.3477 (   0.00%)      7.6610 *  18.04%*
Amean     110     11.0647 (   0.00%)     10.5560 (   4.60%)
Amean     141     13.3297 (   0.00%)     12.6137 *   5.37%*
Amean     172     15.2210 (   0.00%)     14.6547 (   3.72%)
Amean     203     17.8510 (   0.00%)     16.9000 *   5.33%*
Amean     234     19.9263 (   0.00%)     18.7687 *   5.81%*
Amean     265     21.9117 (   0.00%)     21.4060 (   2.31%)
Amean     296     23.7683 (   0.00%)     23.0990 *   2.82%*
(SNC off)
Amean     1        0.2963 (   0.00%)      0.2933 (   1.01%)
Amean     4        0.6093 (   0.00%)      0.5883 (   3.45%)
Amean     7        0.7837 (   0.00%)      0.7570 (   3.40%)
Amean     12       1.2703 (   0.00%)      1.0780 (  15.14%)
Amean     21       2.6260 (   0.00%)      1.8903 *  28.01%*
Amean     30       4.3483 (   0.00%)      2.7903 *  35.83%*
Amean     48       7.9753 (   0.00%)      4.8920 *  38.66%*
Amean     79       9.6540 (   0.00%)      8.0127 *  17.00%*
Amean     110     11.2597 (   0.00%)     10.1557 *   9.80%*
Amean     141     13.8077 (   0.00%)     12.7387 *   7.74%*
Amean     172     16.3513 (   0.00%)     14.5860 *  10.80%*
Amean     203     19.0880 (   0.00%)     17.1950 *   9.92%*
Amean     234     21.7660 (   0.00%)     19.6763 *   9.60%*
Amean     265     23.0447 (   0.00%)     22.5557 (   2.12%)
Amean     296     25.4660 (   0.00%)     24.4273 (   4.08%)

hackbench-process-sockets
                         vanilla		patched
(SNC on)
Amean     1        0.6503 (   0.00%)      0.6430 (   1.13%)
Amean     4        1.6320 (   0.00%)      1.6247 (   0.45%)
Amean     7        2.4810 (   0.00%)      2.4927 (  -0.47%)
Amean     12       4.0943 (   0.00%)      4.0743 (   0.49%)
Amean     21       6.8833 (   0.00%)      6.9220 (  -0.56%)
Amean     30       9.7560 (   0.00%)      9.7107 *   0.46%*
Amean     48      15.5020 (   0.00%)     15.5013 (   0.00%)
Amean     79      25.7690 (   0.00%)     25.7860 (  -0.07%)
Amean     110     35.7700 (   0.00%)     35.9203 (  -0.42%)
Amean     141     45.8710 (   0.00%)     46.0040 (  -0.29%)
Amean     172     55.7460 (   0.00%)     56.1457 *  -0.72%*
Amean     203     65.9393 (   0.00%)     65.8903 (   0.07%)
Amean     234     75.7340 (   0.00%)     76.0653 *  -0.44%*
Amean     265     85.8940 (   0.00%)     85.9670 (  -0.08%)
Amean     296     96.0660 (   0.00%)     96.3823 (  -0.33%)
(SNC off)
Amean     1        0.4050 (   0.00%)      0.4267 (  -5.35%)
Amean     4        1.4517 (   0.00%)      1.4260 *   1.77%*
Amean     7        2.4617 (   0.00%)      2.4583 (   0.14%)
Amean     12       4.0730 (   0.00%)      4.0900 (  -0.42%)
Amean     21       6.9217 (   0.00%)      6.9297 (  -0.12%)
Amean     30       9.7527 (   0.00%)      9.7483 (   0.04%)
Amean     48      15.5490 (   0.00%)     15.5040 (   0.29%)
Amean     79      26.1670 (   0.00%)     26.2290 (  -0.24%)
Amean     110     36.3910 (   0.00%)     36.4073 (  -0.04%)
Amean     141     46.6660 (   0.00%)     46.1683 *   1.07%*
Amean     172     56.7627 (   0.00%)     55.9527 *   1.43%*
Amean     203     66.8097 (   0.00%)     66.4117 *   0.60%*
Amean     234     77.3577 (   0.00%)     76.3683 (   1.28%)
Amean     265     87.5923 (   0.00%)     85.9367 *   1.89%*
Amean     296     97.2430 (   0.00%)     96.4750 *   0.79%*

hackbench-thread-pipes
                         vanilla		patched
(SNC on)
Amean     1        0.4470 (   0.00%)      0.4477 (  -0.15%)
Amean     4        0.6563 (   0.00%)      0.6803 (  -3.66%)
Amean     7        0.8303 (   0.00%)      0.7963 (   4.09%)
Amean     12       1.3983 (   0.00%)      1.2387 *  11.42%*
Amean     21       2.8490 (   0.00%)      2.3220 *  18.50%*
Amean     30       4.3807 (   0.00%)      3.2800 *  25.13%*
Amean     48       7.0663 (   0.00%)      5.4790 *  22.46%*
Amean     79      10.0643 (   0.00%)      8.4573 *  15.97%*
Amean     110     12.2953 (   0.00%)     11.2157 *   8.78%*
Amean     141     15.1210 (   0.00%)     14.2923 *   5.48%*
Amean     172     16.8823 (   0.00%)     16.3013 *   3.44%*
Amean     203     19.3927 (   0.00%)     18.9503 (   2.28%)
Amean     234     22.1817 (   0.00%)     21.1763 *   4.53%*
Amean     265     24.4327 (   0.00%)     24.1200 (   1.28%)
Amean     296     26.9480 (   0.00%)     26.3020 *   2.40%*
(SNC off)
Amean     1        0.2663 (   0.00%)      0.2583 (   3.00%)
Amean     4        0.6627 (   0.00%)      0.6147 *   7.24%*
Amean     7        0.8183 (   0.00%)      0.7757 (   5.21%)
Amean     12       1.3550 (   0.00%)      1.2430 (   8.27%)
Amean     21       3.4853 (   0.00%)      2.2950 *  34.15%*
Amean     30       7.1470 (   0.00%)      3.6847 *  48.44%*
Amean     48       9.6940 (   0.00%)      6.9593 *  28.21%*
Amean     79      10.3100 (   0.00%)      8.7727 *  14.91%*
Amean     110     11.9537 (   0.00%)     10.4757 *  12.36%*
Amean     141     14.2673 (   0.00%)     12.8350 *  10.04%*
Amean     172     16.6850 (   0.00%)     15.1883 *   8.97%*
Amean     203     19.5060 (   0.00%)     18.1390 *   7.01%*
Amean     234     21.6900 (   0.00%)     20.2783 *   6.51%*
Amean     265     24.9073 (   0.00%)     23.3440 *   6.28%*
Amean     296     26.9260 (   0.00%)     26.3007 (   2.32%)

hackbench-thread-sockets
                         vanilla		patched
(SNC on)
Amean     1        0.6700 (   0.00%)      0.6983 (  -4.23%)
Amean     4        1.6450 (   0.00%)      1.6530 (  -0.49%)
Amean     7        2.5587 (   0.00%)      2.5420 *   0.65%*
Amean     12       4.1793 (   0.00%)      4.1630 (   0.39%)
Amean     21       7.1000 (   0.00%)      7.1087 (  -0.12%)
Amean     30       9.9783 (   0.00%)      9.9740 (   0.04%)
Amean     48      15.8737 (   0.00%)     15.8643 (   0.06%)
Amean     79      26.3667 (   0.00%)     26.4097 (  -0.16%)
Amean     110     36.5910 (   0.00%)     36.7513 (  -0.44%)
Amean     141     46.8240 (   0.00%)     47.0613 *  -0.51%*
Amean     172     56.9787 (   0.00%)     57.3263 *  -0.61%*
Amean     203     67.4160 (   0.00%)     67.6133 (  -0.29%)
Amean     234     77.9683 (   0.00%)     78.1877 (  -0.28%)
Amean     265     88.1377 (   0.00%)     88.2207 (  -0.09%)
Amean     296     98.1933 (   0.00%)     98.4537 (  -0.27%)
(SNC off)
Amean     1        0.4280 (   0.00%)      0.4973 ( -16.20%)
Amean     4        1.4897 (   0.00%)      1.4593 *   2.04%*
Amean     7        2.5220 (   0.00%)      2.4803 *   1.65%*
Amean     12       4.1887 (   0.00%)      4.1693 (   0.46%)
Amean     21       7.1040 (   0.00%)      7.1267 (  -0.32%)
Amean     30      10.0300 (   0.00%)     10.0183 (   0.12%)
Amean     48      15.9953 (   0.00%)     15.9597 (   0.22%)
Amean     79      26.8963 (   0.00%)     26.6973 *   0.74%*
Amean     110     37.1493 (   0.00%)     37.0533 (   0.26%)
Amean     141     47.3680 (   0.00%)     47.1407 (   0.48%)
Amean     172     57.8660 (   0.00%)     57.5513 (   0.54%)
Amean     203     68.0573 (   0.00%)     68.3440 (  -0.42%)
Amean     234     78.5393 (   0.00%)     78.2117 (   0.42%)
Amean     265     89.1383 (   0.00%)     88.6450 (   0.55%)
Amean     296     99.8007 (   0.00%)     99.1537 *   0.65%*

tbench4 Throughput
                         vanilla		patched
(SNC on)
Hmean     1        300.70 (   0.00%)      302.52 *   0.61%*
Hmean     2        597.53 (   0.00%)      604.76 *   1.21%*
Hmean     4       1188.34 (   0.00%)     1204.79 *   1.38%*
Hmean     8       2336.22 (   0.00%)     2375.87 *   1.70%*
Hmean     16      4459.17 (   0.00%)     4681.25 *   4.98%*
Hmean     32      7606.69 (   0.00%)     7607.93 (   0.02%)
Hmean     64      9009.48 (   0.00%)     8956.00 *  -0.59%*
Hmean     128    19456.88 (   0.00%)    19258.30 *  -1.02%*
Hmean     256    19771.10 (   0.00%)    20783.82 *   5.12%*
Hmean     384    20118.74 (   0.00%)    20407.40 *   1.43%*
(SNC off)
Hmean     1        284.44 (   0.00%)      286.27 *   0.64%*
Hmean     2        564.10 (   0.00%)      574.82 *   1.90%*
Hmean     4       1120.93 (   0.00%)     1137.27 *   1.46%*
Hmean     8       2248.94 (   0.00%)     2261.98 *   0.58%*
Hmean     16      4360.10 (   0.00%)     4430.95 *   1.63%*
Hmean     32      7300.52 (   0.00%)     7341.70 *   0.56%*
Hmean     64      8912.37 (   0.00%)     8954.61 *   0.47%*
Hmean     128    19874.16 (   0.00%)    20198.82 *   1.63%*
Hmean     256    19759.42 (   0.00%)    19785.57 *   0.13%*
Hmean     384    19502.40 (   0.00%)    19956.96 *   2.33%*

netperf-udp
			     vanilla		   patched
(SNC on)
Hmean     send-64         209.06 (   0.00%)      210.32 (   0.60%)
Hmean     send-128        416.70 (   0.00%)      415.34 (  -0.33%)
Hmean     send-256        819.65 (   0.00%)      808.52 *  -1.36%*
Hmean     send-1024      3163.12 (   0.00%)     3132.35 *  -0.97%*
Hmean     send-2048      5958.21 (   0.00%)     5926.40 (  -0.53%)
Hmean     send-3312      9168.81 (   0.00%)     9194.53 (   0.28%)
Hmean     send-4096     11039.27 (   0.00%)    11159.21 *   1.09%*
Hmean     send-8192     17804.42 (   0.00%)    17840.95 (   0.21%)
Hmean     send-16384    28529.57 (   0.00%)    28389.97 (  -0.49%)
Hmean     recv-64         209.06 (   0.00%)      210.32 (   0.60%)
Hmean     recv-128        416.70 (   0.00%)      415.34 (  -0.33%)
Hmean     recv-256        819.65 (   0.00%)      808.52 *  -1.36%*
Hmean     recv-1024      3163.12 (   0.00%)     3132.35 *  -0.97%*
Hmean     recv-2048      5958.21 (   0.00%)     5926.40 (  -0.53%)
Hmean     recv-3312      9168.81 (   0.00%)     9194.53 (   0.28%)
Hmean     recv-4096     11039.27 (   0.00%)    11159.10 *   1.09%*
Hmean     recv-8192     17804.32 (   0.00%)    17840.92 (   0.21%)
Hmean     recv-16384    28529.38 (   0.00%)    28389.96 (  -0.49%)
(SNC off)
Hmean     send-64         211.39 (   0.00%)      210.60 (  -0.37%)
Hmean     send-128        415.25 (   0.00%)      420.91 *   1.36%*
Hmean     send-256        814.75 (   0.00%)      822.22 *   0.92%*
Hmean     send-1024      3171.61 (   0.00%)     3135.16 (  -1.15%)
Hmean     send-2048      6015.92 (   0.00%)     5943.85 *  -1.20%*
Hmean     send-3312      9210.17 (   0.00%)     9159.59 (  -0.55%)
Hmean     send-4096     11084.55 (   0.00%)    11098.02 (   0.12%)
Hmean     send-8192     17769.83 (   0.00%)    17804.44 (   0.19%)
Hmean     send-16384    27718.62 (   0.00%)    27828.89 (   0.40%)
Hmean     recv-64         211.39 (   0.00%)      210.60 (  -0.37%)
Hmean     recv-128        415.25 (   0.00%)      420.90 *   1.36%*
Hmean     recv-256        814.75 (   0.00%)      822.22 *   0.92%*
Hmean     recv-1024      3171.61 (   0.00%)     3135.16 (  -1.15%)
Hmean     recv-2048      6015.92 (   0.00%)     5943.85 *  -1.20%*
Hmean     recv-3312      9210.17 (   0.00%)     9159.59 (  -0.55%)
Hmean     recv-4096     11084.55 (   0.00%)    11098.02 (   0.12%)
Hmean     recv-8192     17769.76 (   0.00%)    17804.41 (   0.20%)
Hmean     recv-16384    27718.62 (   0.00%)    27828.79 (   0.40%)

netperf-tcp
                         vanilla		patched
(SNC on)
Hmean     64        1192.41 (   0.00%)     1219.91 *   2.31%*
Hmean     128       2354.50 (   0.00%)     2360.65 (   0.26%)
Hmean     256       4371.10 (   0.00%)     4393.92 (   0.52%)
Hmean     1024     13813.84 (   0.00%)    13712.10 (  -0.74%)
Hmean     2048     21518.91 (   0.00%)    21950.82 *   2.01%*
Hmean     3312     25585.77 (   0.00%)    26087.72 *   1.96%*
Hmean     4096     27402.77 (   0.00%)    27927.67 *   1.92%*
Hmean     8192     31766.67 (   0.00%)    31914.49 (   0.47%)
Hmean     16384    36227.30 (   0.00%)    36630.26 (   1.11%)
(SNC off)
Hmean     64        1182.09 (   0.00%)     1211.82 *   2.52%*
Hmean     128       2316.35 (   0.00%)     2356.54 *   1.74%*
Hmean     256       4231.05 (   0.00%)     4282.52 (   1.22%)
Hmean     1024     13461.44 (   0.00%)    13571.02 (   0.81%)
Hmean     2048     21016.51 (   0.00%)    21356.97 *   1.62%*
Hmean     3312     24834.03 (   0.00%)    25140.70 *   1.23%*
Hmean     4096     26700.53 (   0.00%)    26734.55 (   0.13%)
Hmean     8192     31094.10 (   0.00%)    31201.16 (   0.34%)
Hmean     16384    34953.23 (   0.00%)    34949.00 (  -0.01%)

Conclusion
==========

Substantial improvement can be seen in hackbench pipe tests, while
others are generally neutral. It is because if the workload has
already had a relatively high SIS success rate, e.g. tbench4~=50%
and netperf~=100% compared to hackbench~=3.5%, the cost of trying
to improve its efficiency will negate lots of benefit it brings.

But the real world is more complicated. Different workloads can be
co-located on the same machine to share resources, and their profiles
can vary quite much, so the SIS success rate is not predictable.

Please see more detailed analysis in individual patches.

v4 -> v5:
 - Add limited scan for idle cores when overloaded, suggested by Mel
 - Split out several patches since they are irrelevant to this scope
 - Add quick check on ttwu_pending before core update
 - Wrap the filter into SIS_FILTER feature, suggested by Chen Yu
 - Move the main filter logic to the idle path, because the newidle
   balance can bail out early if rq->avg_idle is small enough and
   lose chances to update the filter.

v3 -> v4:
 - Update filter in load_balance rather than in the tick
 - Now the filter contains unoccupied cpus rather than overloaded ones
 - Added mechanisms to deal with the false positive cases

v2 -> v3:
 - Removed sched-idle balance feature and focus on SIS
 - Take non-CFS tasks into consideration
 - Several fixes/improvement suggested by Josh Don

v1 -> v2:
 - Several optimizations on sched-idle balancing
 - Ignore asym topos in can_migrate_task
 - Add more benchmarks including SIS efficiency
 - Re-organize patch as suggested by Mel Gorman

v4: https://lore.kernel.org/lkml/20220619120451.95251-1-wuyun.abel@bytedance.com/
v3: https://lore.kernel.org/lkml/20220505122331.42696-1-wuyun.abel@bytedance.com/
v2: https://lore.kernel.org/lkml/20220409135104.3733193-1-wuyun.abel@bytedance.com/
v1: https://lore.kernel.org/lkml/20220217154403.6497-1-wuyun.abel@bytedance.com/

Abel Wu (5):
  sched/fair: Ignore SIS_UTIL when has idle core
  sched/fair: Limited scan for idle cores when overloaded
  sched/fair: Skip core update if task pending
  sched/fair: Skip SIS domain scan if fully busy
  sched/fair: Introduce SIS_FILTER

 include/linux/sched/topology.h |  53 +++++++++-
 kernel/sched/core.c            |   1 +
 kernel/sched/fair.c            | 171 +++++++++++++++++++++++++++++----
 kernel/sched/features.h        |   1 +
 kernel/sched/sched.h           |   3 +
 kernel/sched/topology.c        |   9 +-
 6 files changed, 218 insertions(+), 20 deletions(-)

-- 
2.37.3

