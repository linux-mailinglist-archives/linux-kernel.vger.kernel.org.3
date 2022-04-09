Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B4524FA8BF
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241377AbiDINyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:54:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234964AbiDINyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:54:03 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 744E7B89
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 06:51:54 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id md4so2787468pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 06:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=yYZcZirjMip0iTmkwKaXUWpGJ81xcYzsq/Y5PNpLe7E=;
        b=Gz3qCLcrJqJxJi5mn5kx8GanrD1dD9EZkoWXLZmG/EgnXAZ0Av81c28bs7NId7XLBZ
         KM8fqMC4NpehYIoCdfSFXTJ6sQgBFflokTKprzkV+PpqJgmeYfsHtgok0zEOW5UMjvQK
         sRx1Z/hP0gwDSoelt3eLOmJ9nWWl8uiLN5SvXV0gtGT4uFU/DIaoCkVeMKMmjvlDD/0y
         vZGgOAvygDwSidiYbJDHKZtwlJREfKAFVhJ+nccjcEhd+XpQxmCW5aBNhXpAOq2zExZi
         Oh6d2Rj46on9xeZt5gZZbzRxyM7s/DY/shfSZqenWzPxlqiBIcrdWxZ7BiEcYVTqmkUh
         j4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=yYZcZirjMip0iTmkwKaXUWpGJ81xcYzsq/Y5PNpLe7E=;
        b=IOPUjxIUcvHo57RZZ3M0qxbB836AOeS8Np6oCOVgnDF/NAY/Y0a5/lwvviBtZkoeRX
         R/DoCsODlc67CZfFsrBVf5qr8HAK0+qNw4cKff8NRACm18dNykSTEWmaXLD43KHPZQSv
         pVQATvHsoK3sGgDyJKNoNwXNfn5EWn95YTsS4vodMt7hJwu6gaGQd4XQiJDedp0t9dd3
         qK1scYG9Nv4pAljc75wexn50SRuZb/9iZPM5IEGhETLuVx09F9YqO/dDdjzNoEzI7iVU
         Jq4nanMkiu1Ipe7VglFvvaxwcMd5NiJatKBKajID493LCnmdIXQVQaqvqZvrP4XCVs+R
         ybLg==
X-Gm-Message-State: AOAM533g9YDOaU9k76C3lmURVVYv2XXtksb/7wCKd5SCW1vquXAC/m3M
        4ElvGNMiOAK4cyAt+kIsTsswVA==
X-Google-Smtp-Source: ABdhPJzRaryhpMdjO6sX51Z7r8JMHG/RfKnOgCAK2LSdNzMjExFA/rzAWAcdolxXtFy6n1ydMtG/iA==
X-Received: by 2002:a17:903:22cc:b0:158:3bea:5862 with SMTP id y12-20020a17090322cc00b001583bea5862mr2377121plg.48.1649512313675;
        Sat, 09 Apr 2022 06:51:53 -0700 (PDT)
Received: from n227-010-195.byted.org ([121.30.179.44])
        by smtp.gmail.com with ESMTPSA id f19-20020a056a00229300b004fb157f136asm30303357pfe.153.2022.04.09.06.51.51
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Apr 2022 06:51:53 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     joshdon@google.com, linux-kernel@vger.kernel.org,
        Abel Wu <wuyun.abel@bytedance.com>
Subject: [RFC v2 0/2] introduece sched-idle balance
Date:   Sat,  9 Apr 2022 21:51:02 +0800
Message-Id: <20220409135104.3733193-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.11.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Overloaded runqueues are those who have more than one pullable non-idle tasks
on them (given the sched-idle cpus are treated as idle cpus). The idle tasks,
which are either assigned SCHED_IDLE policy or in idle cpu cgroup, are tracked
through rq->cfs.idle_h_nr_running.

It would bring benefit if the unoccupied cpus (sched-idle/idle cpus) can start
serving as soon as the non-idle tasks are available. Lots of effort has already
been put into this:

  - Task wakeup: the scheduler tries to find such cpus to make full
    use of cpu capacity. But due to scalability issues, the search
    depth is bounded to a reasonable limit. IOW it's possible that
    a task is woken up on a busy cpu while unoccupied cpus are still
    out there. Fortunately, these imbalance can be fixed by load
    balancers.

  - Load balancing: periodic (normal/idle) and newly-idle balancing.
    The former is regulated by intervals on each sched-domain and
    the intervals can prevent the sched-idle cpus from pulling the
    non-idle tasks. While the latter is triggered only when the cpus
    become really idle, and the sched-idle cpus are not the case.
    The balancing can also be stopped by other constrains.

So the unoccupied cpus could still get a chance to co-exist with overloaded
ones, and in this case the sched-idle balancing will try to fast fix the
imbalance between them at some extent. That is:

  - Record the overloaded cpus so we can know where to pull from.
    This is done in tick to regulate manipulation on shared data.

  - Filter out the overloaded cpus in SIS to improve the idle cpu
    searching efficiency. The more overloaded the system is, the
    less cpus we will search.

  - Quit early in periodic load balancing if the cpu becomes busy.
    This is similar to what we do in newly-idle case in which we
    stop balancing once we got some work to do.

  - The newly-idle balancing will try harder to pull the non-idle
    tasks if overloaded cpus exist.

So the whole thing can be treated as an extension to the existing load balance
mechanisms on sched-idle cpus.

Benchmark
=========

Tests are done in an Intel(R) Xeon(R) Platinum 8260 CPU @ 2.40GHz machine with
2 NUMA nodes each of which has 24 cores with SMT2 enabled, so 96 CPUs in total.
Tests are separated into two parts:

  - quiet: benchmarks running inside a normal cpu cgroup in a clean
    environment

  - noisy: benchmarks running inside a normal cpu cgroup, and noise
    from an idle cpu cgroup, the two cgroups are at same level. The
    noise is produced by perf messaging benchmark which occupies ~20%
    cpu capacity in my server.

	perf bench sched messaging -g 1 -l 2000000000

All of the benchmarks are done by mmtests with "--no-monitor --performance"
parameters, and with cpu turbo disabled.

As Mel required, the SIS filter part is also benchmarded separately, and the
additional SIS statistics comes from his patch [1].

Results
=======

vanilla:  tip sched/core 6255b48aebfd (v5.17-rc5)
filter:   vanilla + patch1
balancer: filter + patch2

a) hackbench-process-pipes

[quiet]
                             vanilla                 filter               balancer
Amean     1        0.3077 (   0.00%)      0.3340 (  -8.56%)      0.2523 (  17.98%)
Amean     4        0.7703 (   0.00%)      0.7360 (   4.46%)      0.7220 *   6.27%*
Amean     7        0.9253 (   0.00%)      0.9320 (  -0.72%)      0.9153 (   1.08%)
Amean     12       1.2397 (   0.00%)      1.1197 *   9.68%*      1.0867 *  12.34%*
Amean     21       2.8003 (   0.00%)      2.4663 *  11.93%*      2.4490 *  12.55%*
Amean     30       5.2430 (   0.00%)      4.1620 *  20.62%*      4.2220 *  19.47%*
Amean     48       7.9023 (   0.00%)      6.7040 *  15.16%*      7.0897 *  10.28%*
Amean     79       9.6197 (   0.00%)      8.6310 *  10.28%*      8.6590 *   9.99%*
Amean     110      9.8170 (   0.00%)      9.3533 (   4.72%)      9.2813 (   5.46%)
Amean     141     11.8070 (   0.00%)     11.3003 *   4.29%*     11.4297 *   3.20%*
Amean     172     14.1017 (   0.00%)     13.3063 *   5.64%*     13.2740 *   5.87%*
Amean     203     15.9723 (   0.00%)     16.0813 (  -0.68%)     15.2627 *   4.44%*
Amean     234     18.6590 (   0.00%)     18.2387 (   2.25%)     17.4267 *   6.60%*
Amean     265     20.8473 (   0.00%)     20.4460 (   1.93%)     19.8227 *   4.92%*
Amean     296     22.5817 (   0.00%)     22.5307 (   0.23%)     21.6657 *   4.06%*

Ops SIS Search Efficiency            16.51          27.35          27.37
Ops SIS Domain Search Eff            16.35          27.08          27.05
Ops SIS Fast Success Rate             1.19           1.32           1.58
Ops SIS Success Rate                  1.96           2.60           3.06

[noisy]
                             vanilla                 filter               balancer
Amean     1        0.3627 (   0.00%)      0.2850 (  21.42%)      0.2830 (  21.97%)
Amean     4        0.7290 (   0.00%)      0.7313 (  -0.32%)      0.7467 (  -2.42%)
Amean     7        0.9353 (   0.00%)      0.9443 (  -0.96%)      0.9107 *   2.64%*
Amean     12       1.1973 (   0.00%)      1.2283 (  -2.59%)      1.1013 *   8.02%*
Amean     21       2.5100 (   0.00%)      2.4190 (   3.63%)      2.3003 *   8.35%*
Amean     30       4.7437 (   0.00%)      3.9367 *  17.01%*      3.7473 *  21.00%*
Amean     48       7.4943 (   0.00%)      6.9470 *   7.30%*      7.0430 (   6.02%)
Amean     79       9.4737 (   0.00%)      8.6923 *   8.25%*      8.8930 *   6.13%*
Amean     110     10.7420 (   0.00%)      9.5363 *  11.22%*      9.2847 *  13.57%*
Amean     141     12.2293 (   0.00%)     11.0513 *   9.63%*     10.9750 *  10.26%*
Amean     172     14.0277 (   0.00%)     13.7407 (   2.05%)     12.9350 *   7.79%*
Amean     203     16.6930 (   0.00%)     15.6677 *   6.14%*     15.1910 *   9.00%*
Amean     234     18.3360 (   0.00%)     17.6750 (   3.60%)     17.1403 *   6.52%*
Amean     265     20.8383 (   0.00%)     19.9793 (   4.12%)     19.4780 *   6.53%*
Amean     296     23.3080 (   0.00%)     21.7693 *   6.60%*     21.3567 *   8.37%*

Ops SIS Search Efficiency            16.53          27.23          27.53
Ops SIS Domain Search Eff            16.27          26.81          27.07
Ops SIS Fast Success Rate             1.87           2.10           2.29
Ops SIS Success Rate                  2.93           3.81           4.01

b) hackbench-process-sockets

[quiet]
                             vanilla                 filter               balancer
Amean     1        0.5213 (   0.00%)      0.5283 (  -1.34%)      0.5210 (   0.06%)
Amean     4        1.4733 (   0.00%)      1.4757 (  -0.16%)      1.4577 *   1.06%*
Amean     7        2.4620 (   0.00%)      2.5083 *  -1.88%*      2.5113 *  -2.00%*
Amean     12       4.1283 (   0.00%)      4.2143 *  -2.08%*      4.1967 *  -1.66%*
Amean     21       7.0153 (   0.00%)      7.1620 *  -2.09%*      7.0977 *  -1.17%*
Amean     30       9.8900 (   0.00%)     10.0380 *  -1.50%*      9.9303 *  -0.41%*
Amean     48      15.6753 (   0.00%)     16.0283 *  -2.25%*     15.8213 *  -0.93%*
Amean     79      26.3443 (   0.00%)     26.7147 *  -1.41%*     26.3397 (   0.02%)
Amean     110     36.5437 (   0.00%)     37.3277 *  -2.15%*     36.6197 *  -0.21%*
Amean     141     46.5327 (   0.00%)     47.4803 *  -2.04%*     46.8620 *  -0.71%*
Amean     172     56.5907 (   0.00%)     58.0840 *  -2.64%*     56.9503 *  -0.64%*
Amean     203     66.8573 (   0.00%)     68.3780 *  -2.27%*     67.2330 *  -0.56%*
Amean     234     77.2470 (   0.00%)     78.8317 *  -2.05%*     77.6773 *  -0.56%*
Amean     265     87.5577 (   0.00%)     89.3343 *  -2.03%*     87.3617 *   0.22%*
Amean     296     97.6160 (   0.00%)     99.6320 *  -2.07%*     97.6450 (  -0.03%)

Ops SIS Search Efficiency            16.50          27.17          27.19
Ops SIS Domain Search Eff            16.32          26.88          26.84
Ops SIS Fast Success Rate             1.32           1.44           1.75
Ops SIS Success Rate                  2.06           2.74           3.34

[noisy]
                             vanilla                 filter               balancer
Amean     1        0.6120 (   0.00%)      0.6760 * -10.46%*      0.6037 (   1.36%)
Amean     4        1.5867 (   0.00%)      1.6540 *  -4.24%*      1.5120 *   4.71%*
Amean     7        2.5940 (   0.00%)      2.6820 *  -3.39%*      2.5047 *   3.44%*
Amean     12       4.3407 (   0.00%)      4.4680 *  -2.93%*      4.1513 *   4.36%*
Amean     21       7.3083 (   0.00%)      7.5073 *  -2.72%*      6.8467 *   6.32%*
Amean     30       9.9750 (   0.00%)     10.4920 *  -5.18%*      9.7220 *   2.54%*
Amean     48      15.9123 (   0.00%)     16.5143 *  -3.78%*     15.2683 *   4.05%*
Amean     79      26.2180 (   0.00%)     27.2497 *  -3.93%*     25.1087 *   4.23%*
Amean     110     36.8237 (   0.00%)     38.8303 *  -5.45%*     35.8823 *   2.56%*
Amean     141     47.3357 (   0.00%)     49.6817 *  -4.96%*     45.5723 *   3.73%*
Amean     172     57.4477 (   0.00%)     60.8553 *  -5.93%*     55.5380 *   3.32%*
Amean     203     67.6290 (   0.00%)     71.8117 *  -6.18%*     65.6033 *   3.00%*
Amean     234     77.8347 (   0.00%)     82.9577 *  -6.58%*     75.8713 *   2.52%*
Amean     265     88.4680 (   0.00%)     94.2737 *  -6.56%*     85.8547 *   2.95%*
Amean     296     99.2210 (   0.00%)    105.9357 *  -6.77%*     95.8777 *   3.37%*

Ops SIS Search Efficiency            16.51          27.21          27.62
Ops SIS Domain Search Eff            16.22          26.74          27.07
Ops SIS Fast Success Rate             2.13           2.38           2.73
Ops SIS Success Rate                  3.21           4.20           4.66

c) hackbench-thread-pipes

[quiet]
                             vanilla                 filter               balancer
Amean     1        0.2770 (   0.00%)      0.2783 (  -0.48%)      0.2777 (  -0.24%)
Amean     4        0.7707 (   0.00%)      0.7770 (  -0.82%)      0.7687 (   0.26%)
Amean     7        0.9400 (   0.00%)      0.9500 (  -1.06%)      0.9230 (   1.81%)
Amean     12       1.4740 (   0.00%)      1.4447 (   1.99%)      1.4213 (   3.57%)
Amean     21       3.8517 (   0.00%)      3.5223 *   8.55%*      3.3837 *  12.15%*
Amean     30       6.7057 (   0.00%)      5.9243 *  11.65%*      5.8200 *  13.21%*
Amean     48       8.9877 (   0.00%)      8.3357 *   7.25%*      8.0573 *  10.35%*
Amean     79      10.3807 (   0.00%)      9.6767 *   6.78%*      9.6947 *   6.61%*
Amean     110     11.1830 (   0.00%)     10.5263 *   5.87%*     10.5247 (   5.89%)
Amean     141     12.9987 (   0.00%)     12.6463 (   2.71%)     12.6697 (   2.53%)
Amean     172     15.2327 (   0.00%)     15.6350 (  -2.64%)     14.6007 (   4.15%)
Amean     203     17.7090 (   0.00%)     17.4287 (   1.58%)     16.9330 (   4.38%)
Amean     234     19.4380 (   0.00%)     19.6747 (  -1.22%)     19.5393 (  -0.52%)
Amean     265     24.2407 (   0.00%)     22.7170 (   6.29%)     21.4700 *  11.43%*
Amean     296     26.5937 (   0.00%)     26.4057 (   0.71%)     24.2627 *   8.77%*

Ops SIS Search Efficiency            16.54          27.49          27.60
Ops SIS Domain Search Eff            16.34          27.18          27.23
Ops SIS Fast Success Rate             1.41           1.52           1.84
Ops SIS Success Rate                  2.21           2.87           3.46

[noisy]
                             vanilla                 filter               balancer
Amean     1        0.3097 (   0.00%)      0.3373 *  -8.93%*      0.3140 (  -1.40%)
Amean     4        0.7730 (   0.00%)      0.7870 (  -1.81%)      0.7500 *   2.98%*
Amean     7        0.9580 (   0.00%)      0.9520 (   0.63%)      0.9270 (   3.24%)
Amean     12       1.4840 (   0.00%)      1.4103 (   4.96%)      1.3970 *   5.86%*
Amean     21       3.4623 (   0.00%)      3.1507 *   9.00%*      3.1517 *   8.97%*
Amean     30       6.1033 (   0.00%)      5.6037 (   8.19%)      5.7150 (   6.36%)
Amean     48       8.9833 (   0.00%)      8.6097 *   4.16%*      8.5367 *   4.97%*
Amean     79      11.0237 (   0.00%)      9.5840 *  13.06%*      9.7860 *  11.23%*
Amean     110     12.4213 (   0.00%)     10.9570 *  11.79%*     10.5110 *  15.38%*
Amean     141     13.4703 (   0.00%)     12.5320 *   6.97%*     12.4137 (   7.84%)
Amean     172     17.0973 (   0.00%)     15.6843 *   8.26%*     14.6183 *  14.50%*
Amean     203     18.8867 (   0.00%)     17.3487 *   8.14%*     17.8260 *   5.62%*
Amean     234     22.0430 (   0.00%)     19.8977 *   9.73%*     19.6240 *  10.97%*
Amean     265     23.9877 (   0.00%)     21.9163 *   8.63%*     22.5933 (   5.81%)
Amean     296     27.1667 (   0.00%)     25.2857 (   6.92%)     23.8423 *  12.24%*

Ops SIS Search Efficiency            16.57          27.57          28.04
Ops SIS Domain Search Eff            16.29          27.11          27.50
Ops SIS Fast Success Rate             2.06           2.29           2.67
Ops SIS Success Rate                  3.11           4.04           4.47

d) hackbench-thread-sockets

[quiet]
                             vanilla                 filter               balancer
Amean     1        0.5773 (   0.00%)      0.5767 (   0.12%)      0.5723 (   0.87%)
Amean     4        1.5083 (   0.00%)      1.5117 (  -0.22%)      1.5027 (   0.38%)
Amean     7        2.5453 (   0.00%)      2.5890 *  -1.72%*      2.5823 *  -1.45%*
Amean     12       4.2763 (   0.00%)      4.3357 *  -1.39%*      4.3203 *  -1.03%*
Amean     21       7.2050 (   0.00%)      7.3777 *  -2.40%*      7.2923 *  -1.21%*
Amean     30      10.1203 (   0.00%)     10.3367 *  -2.14%*     10.2107 *  -0.89%*
Amean     48      16.0403 (   0.00%)     16.3427 *  -1.88%*     16.1080 (  -0.42%)
Amean     79      27.0260 (   0.00%)     27.2193 (  -0.72%)     26.7280 *   1.10%*
Amean     110     37.4073 (   0.00%)     38.1427 *  -1.97%*     37.7580 *  -0.94%*
Amean     141     47.7927 (   0.00%)     48.7607 *  -2.03%*     48.5797 *  -1.65%*
Amean     172     58.1860 (   0.00%)     59.5697 *  -2.38%*     58.7377 *  -0.95%*
Amean     203     68.6033 (   0.00%)     70.6163 *  -2.93%*     69.0957 *  -0.72%*
Amean     234     79.2923 (   0.00%)     81.1143 *  -2.30%*     79.9310 *  -0.81%*
Amean     265     89.6240 (   0.00%)     91.8750 *  -2.51%*     90.4663 *  -0.94%*
Amean     296    100.2680 (   0.00%)    102.9560 *  -2.68%*    101.0817 *  -0.81%*

Ops SIS Search Efficiency            16.58          25.34          24.62
Ops SIS Domain Search Eff            16.12          24.59          23.81
Ops SIS Fast Success Rate             3.30           3.91           4.33
Ops SIS Success Rate                  3.99           5.77           7.09

[noisy]
                             vanilla                 filter               balancer
Amean     1        0.6607 (   0.00%)      0.7033 *  -6.46%*      0.6727 (  -1.82%)
Amean     4        1.6270 (   0.00%)      1.6507 *  -1.45%*      1.5457 *   5.00%*
Amean     7        2.6850 (   0.00%)      2.7483 *  -2.36%*      2.5850 *   3.72%*
Amean     12       4.5273 (   0.00%)      4.6250 *  -2.16%*      4.2457 *   6.22%*
Amean     21       7.5403 (   0.00%)      7.6453 (  -1.39%)      7.1340 *   5.39%*
Amean     30      10.4227 (   0.00%)     10.7350 *  -3.00%*      9.9497 *   4.54%*
Amean     48      16.2257 (   0.00%)     16.9840 *  -4.67%*     15.7340 *   3.03%*
Amean     79      27.2820 (   0.00%)     27.9947 *  -2.61%*     25.9023 *   5.06%*
Amean     110     37.9413 (   0.00%)     40.0053 *  -5.44%*     36.9113 *   2.71%*
Amean     141     48.3913 (   0.00%)     51.3303 *  -6.07%*     47.0660 *   2.74%*
Amean     172     58.9597 (   0.00%)     62.8973 *  -6.68%*     57.1193 *   3.12%*
Amean     203     70.1857 (   0.00%)     74.3620 *  -5.95%*     68.0957 *   2.98%*
Amean     234     80.2250 (   0.00%)     86.1143 *  -7.34%*     78.4873 *   2.17%*
Amean     265     91.2950 (   0.00%)     97.7753 *  -7.10%*     88.9163 *   2.61%*
Amean     296    102.1407 (   0.00%)    109.6700 *  -7.37%*    100.2663 *   1.84%*

Ops SIS Search Efficiency            16.57          24.79          25.86
Ops SIS Domain Search Eff            15.80          23.54          24.40
Ops SIS Fast Success Rate             5.55           6.59           7.48
Ops SIS Success Rate                  7.20          10.39          11.38

e) schbench

[quiet]
                                   vanilla                 filter               balancer
Lat 50.0th-qrtle-1         5.00 (   0.00%)        5.00 (   0.00%)        5.00 (   0.00%)
Lat 75.0th-qrtle-1         5.00 (   0.00%)        5.00 (   0.00%)        5.00 (   0.00%)
Lat 90.0th-qrtle-1         5.00 (   0.00%)        5.00 (   0.00%)        5.00 (   0.00%)
Lat 95.0th-qrtle-1         6.00 (   0.00%)        6.00 (   0.00%)        5.00 (  16.67%)
Lat 99.0th-qrtle-1         6.00 (   0.00%)        7.00 ( -16.67%)        6.00 (   0.00%)
Lat 99.5th-qrtle-1         7.00 (   0.00%)        8.00 ( -14.29%)        6.00 (  14.29%)
Lat 99.9th-qrtle-1         8.00 (   0.00%)       12.00 ( -50.00%)        6.00 (  25.00%)
Lat 50.0th-qrtle-2         6.00 (   0.00%)        6.00 (   0.00%)        6.00 (   0.00%)
Lat 75.0th-qrtle-2         6.00 (   0.00%)        6.00 (   0.00%)        7.00 ( -16.67%)
Lat 90.0th-qrtle-2         7.00 (   0.00%)        7.00 (   0.00%)        7.00 (   0.00%)
Lat 95.0th-qrtle-2         7.00 (   0.00%)        7.00 (   0.00%)        7.00 (   0.00%)
Lat 99.0th-qrtle-2         8.00 (   0.00%)        8.00 (   0.00%)        8.00 (   0.00%)
Lat 99.5th-qrtle-2         9.00 (   0.00%)        8.00 (  11.11%)        9.00 (   0.00%)
Lat 99.9th-qrtle-2         9.00 (   0.00%)        9.00 (   0.00%)        9.00 (   0.00%)
Lat 50.0th-qrtle-4         9.00 (   0.00%)        8.00 (  11.11%)        8.00 (  11.11%)
Lat 75.0th-qrtle-4        10.00 (   0.00%)       10.00 (   0.00%)       10.00 (   0.00%)
Lat 90.0th-qrtle-4        11.00 (   0.00%)       11.00 (   0.00%)       11.00 (   0.00%)
Lat 95.0th-qrtle-4        12.00 (   0.00%)       12.00 (   0.00%)       11.00 (   8.33%)
Lat 99.0th-qrtle-4        13.00 (   0.00%)       13.00 (   0.00%)       13.00 (   0.00%)
Lat 99.5th-qrtle-4        14.00 (   0.00%)       14.00 (   0.00%)       14.00 (   0.00%)
Lat 99.9th-qrtle-4        16.00 (   0.00%)       16.00 (   0.00%)       16.00 (   0.00%)
Lat 50.0th-qrtle-8        13.00 (   0.00%)       12.00 (   7.69%)       12.00 (   7.69%)
Lat 75.0th-qrtle-8        16.00 (   0.00%)       15.00 (   6.25%)       16.00 (   0.00%)
Lat 90.0th-qrtle-8        18.00 (   0.00%)       17.00 (   5.56%)       18.00 (   0.00%)
Lat 95.0th-qrtle-8        19.00 (   0.00%)       18.00 (   5.26%)       18.00 (   5.26%)
Lat 99.0th-qrtle-8        23.00 (   0.00%)       21.00 (   8.70%)       20.00 (  13.04%)
Lat 99.5th-qrtle-8        24.00 (   0.00%)       23.00 (   4.17%)       22.00 (   8.33%)
Lat 99.9th-qrtle-8        29.00 (   0.00%)       25.00 (  13.79%)       26.00 (  10.34%)
Lat 50.0th-qrtle-16       20.00 (   0.00%)       21.00 (  -5.00%)       20.00 (   0.00%)
Lat 75.0th-qrtle-16       27.00 (   0.00%)       28.00 (  -3.70%)       27.00 (   0.00%)
Lat 90.0th-qrtle-16       32.00 (   0.00%)       33.00 (  -3.12%)       31.00 (   3.12%)
Lat 95.0th-qrtle-16       33.00 (   0.00%)       35.00 (  -6.06%)       33.00 (   0.00%)
Lat 99.0th-qrtle-16       38.00 (   0.00%)       40.00 (  -5.26%)       38.00 (   0.00%)
Lat 99.5th-qrtle-16       40.00 (   0.00%)       42.00 (  -5.00%)       41.00 (  -2.50%)
Lat 99.9th-qrtle-16       43.00 (   0.00%)       49.00 ( -13.95%)       50.00 ( -16.28%)
Lat 50.0th-qrtle-32       38.00 (   0.00%)       37.00 (   2.63%)       36.00 (   5.26%)
Lat 75.0th-qrtle-32       55.00 (   0.00%)       54.00 (   1.82%)       53.00 (   3.64%)
Lat 90.0th-qrtle-32       65.00 (   0.00%)       64.00 (   1.54%)       62.00 (   4.62%)
Lat 95.0th-qrtle-32       69.00 (   0.00%)       68.00 (   1.45%)       67.00 (   2.90%)
Lat 99.0th-qrtle-32       80.00 (   0.00%)       80.00 (   0.00%)       76.00 (   5.00%)
Lat 99.5th-qrtle-32       85.00 (   0.00%)       90.00 (  -5.88%)       82.00 (   3.53%)
Lat 99.9th-qrtle-32       93.00 (   0.00%)      135.00 ( -45.16%)       90.00 (   3.23%)
Lat 50.0th-qrtle-47       55.00 (   0.00%)       55.00 (   0.00%)       53.00 (   3.64%)
Lat 75.0th-qrtle-47       81.00 (   0.00%)       81.00 (   0.00%)       77.00 (   4.94%)
Lat 90.0th-qrtle-47       97.00 (   0.00%)       97.00 (   0.00%)       92.00 (   5.15%)
Lat 95.0th-qrtle-47      104.00 (   0.00%)      103.00 (   0.96%)       99.00 (   4.81%)
Lat 99.0th-qrtle-47      120.00 (   0.00%)      120.00 (   0.00%)      119.00 (   0.83%)
Lat 99.5th-qrtle-47      131.00 (   0.00%)      133.00 (  -1.53%)      127.00 (   3.05%)
Lat 99.9th-qrtle-47      161.00 (   0.00%)      163.00 (  -1.24%)      165.00 (  -2.48%)

Ops SIS Search Efficiency            83.44          77.01          84.31
Ops SIS Domain Search Eff             4.56           4.11           4.47
Ops SIS Fast Success Rate            99.05          98.72          99.13
Ops SIS Success Rate                 99.65          99.54          99.77

[noisy]
                                   vanilla                 filter               balancer
Lat 50.0th-qrtle-1         7.00 (   0.00%)        8.00 ( -14.29%)        9.00 ( -28.57%)
Lat 75.0th-qrtle-1         8.00 (   0.00%)        9.00 ( -12.50%)       10.00 ( -25.00%)
Lat 90.0th-qrtle-1         9.00 (   0.00%)       10.00 ( -11.11%)       11.00 ( -22.22%)
Lat 95.0th-qrtle-1         9.00 (   0.00%)       11.00 ( -22.22%)       12.00 ( -33.33%)
Lat 99.0th-qrtle-1        11.00 (   0.00%)       13.00 ( -18.18%)       15.00 ( -36.36%)
Lat 99.5th-qrtle-1        13.00 (   0.00%)       14.00 (  -7.69%)       18.00 ( -38.46%)
Lat 99.9th-qrtle-1        13.00 (   0.00%)       14.00 (  -7.69%)       18.00 ( -38.46%)
Lat 50.0th-qrtle-2         9.00 (   0.00%)        9.00 (   0.00%)        9.00 (   0.00%)
Lat 75.0th-qrtle-2        11.00 (   0.00%)       10.00 (   9.09%)       11.00 (   0.00%)
Lat 90.0th-qrtle-2        12.00 (   0.00%)       11.00 (   8.33%)       12.00 (   0.00%)
Lat 95.0th-qrtle-2        13.00 (   0.00%)       12.00 (   7.69%)       14.00 (  -7.69%)
Lat 99.0th-qrtle-2        15.00 (   0.00%)       15.00 (   0.00%)       15.00 (   0.00%)
Lat 99.5th-qrtle-2        15.00 (   0.00%)       17.00 ( -13.33%)       16.00 (  -6.67%)
Lat 99.9th-qrtle-2        17.00 (   0.00%)       19.00 ( -11.76%)       21.00 ( -23.53%)
Lat 50.0th-qrtle-4        12.00 (   0.00%)       12.00 (   0.00%)       12.00 (   0.00%)
Lat 75.0th-qrtle-4        14.00 (   0.00%)       15.00 (  -7.14%)       14.00 (   0.00%)
Lat 90.0th-qrtle-4        16.00 (   0.00%)       17.00 (  -6.25%)       16.00 (   0.00%)
Lat 95.0th-qrtle-4        17.00 (   0.00%)       18.00 (  -5.88%)       16.00 (   5.88%)
Lat 99.0th-qrtle-4        20.00 (   0.00%)       20.00 (   0.00%)       19.00 (   5.00%)
Lat 99.5th-qrtle-4        21.00 (   0.00%)       20.00 (   4.76%)       21.00 (   0.00%)
Lat 99.9th-qrtle-4        26.00 (   0.00%)       21.00 (  19.23%)       22.00 (  15.38%)
Lat 50.0th-qrtle-8        17.00 (   0.00%)       16.00 (   5.88%)       17.00 (   0.00%)
Lat 75.0th-qrtle-8        22.00 (   0.00%)       21.00 (   4.55%)       21.00 (   4.55%)
Lat 90.0th-qrtle-8        26.00 (   0.00%)       24.00 (   7.69%)       25.00 (   3.85%)
Lat 95.0th-qrtle-8        28.00 (   0.00%)       25.00 (  10.71%)       26.00 (   7.14%)
Lat 99.0th-qrtle-8        32.00 (   0.00%)       29.00 (   9.38%)       29.00 (   9.38%)
Lat 99.5th-qrtle-8        34.00 (   0.00%)       31.00 (   8.82%)       31.00 (   8.82%)
Lat 99.9th-qrtle-8        42.00 (   0.00%)       34.00 (  19.05%)       35.00 (  16.67%)
Lat 50.0th-qrtle-16       29.00 (   0.00%)       30.00 (  -3.45%)       27.00 (   6.90%)
Lat 75.0th-qrtle-16       40.00 (   0.00%)       41.00 (  -2.50%)       37.00 (   7.50%)
Lat 90.0th-qrtle-16       46.00 (   0.00%)       49.00 (  -6.52%)       43.00 (   6.52%)
Lat 95.0th-qrtle-16       49.00 (   0.00%)       53.00 (  -8.16%)       46.00 (   6.12%)
Lat 99.0th-qrtle-16       55.00 (   0.00%)       59.00 (  -7.27%)       52.00 (   5.45%)
Lat 99.5th-qrtle-16       57.00 (   0.00%)       62.00 (  -8.77%)       55.00 (   3.51%)
Lat 99.9th-qrtle-16       63.00 (   0.00%)       84.00 ( -33.33%)       62.00 (   1.59%)
Lat 50.0th-qrtle-32       48.00 (   0.00%)       49.00 (  -2.08%)       49.00 (  -2.08%)
Lat 75.0th-qrtle-32       69.00 (   0.00%)       70.00 (  -1.45%)       70.00 (  -1.45%)
Lat 90.0th-qrtle-32       83.00 (   0.00%)       87.00 (  -4.82%)       85.00 (  -2.41%)
Lat 95.0th-qrtle-32       90.00 (   0.00%)       96.00 (  -6.67%)       91.00 (  -1.11%)
Lat 99.0th-qrtle-32      102.00 (   0.00%)      110.00 (  -7.84%)      104.00 (  -1.96%)
Lat 99.5th-qrtle-32      107.00 (   0.00%)      115.00 (  -7.48%)      109.00 (  -1.87%)
Lat 99.9th-qrtle-32      112.00 (   0.00%)      151.00 ( -34.82%)      118.00 (  -5.36%)
Lat 50.0th-qrtle-47       64.00 (   0.00%)       64.00 (   0.00%)       66.00 (  -3.12%)
Lat 75.0th-qrtle-47       93.00 (   0.00%)       92.00 (   1.08%)       96.00 (  -3.23%)
Lat 90.0th-qrtle-47      113.00 (   0.00%)      110.00 (   2.65%)      116.00 (  -2.65%)
Lat 95.0th-qrtle-47      126.00 (   0.00%)      122.00 (   3.17%)      126.00 (   0.00%)
Lat 99.0th-qrtle-47      159.00 (   0.00%)      137.00 (  13.84%)      143.00 (  10.06%)
Lat 99.5th-qrtle-47      231.00 (   0.00%)      144.00 (  37.66%)      152.00 (  34.20%)
Lat 99.9th-qrtle-47     9136.00 (   0.00%)      181.00 (  98.02%)     1190.00 (  86.97%)

Ops SIS Search Efficiency            94.62          94.47          94.79
Ops SIS Domain Search Eff            15.30          14.91          15.31
Ops SIS Fast Success Rate            98.97          98.97          99.01
Ops SIS Success Rate                 99.98          99.98          99.99

f) tbench4 Throughput

[quiet]
                             vanilla                 filter               balancer
Hmean     1        287.90 (   0.00%)      290.20 *   0.80%*      296.20 *   2.88%*
Hmean     2        582.58 (   0.00%)      586.96 *   0.75%*      599.12 *   2.84%*
Hmean     4       1151.83 (   0.00%)     1165.32 *   1.17%*     1181.72 *   2.60%*
Hmean     8       2317.84 (   0.00%)     2311.67 *  -0.27%*     2344.42 *   1.15%*
Hmean     16      4530.15 (   0.00%)     4555.04 *   0.55%*     4561.38 *   0.69%*
Hmean     32      7643.04 (   0.00%)     7644.20 (   0.02%)     7707.31 *   0.84%*
Hmean     64      9310.48 (   0.00%)     9664.41 *   3.80%*     9615.94 *   3.28%*
Hmean     128    21837.26 (   0.00%)    13628.90 * -37.59%*    15996.13 * -26.75%*
Hmean     256    20789.62 (   0.00%)    22550.77 *   8.47%*    22776.78 *   9.56%*
Hmean     384    19329.85 (   0.00%)    19786.13 *   2.36%*    17499.33 *  -9.47%*

Ops SIS Search Efficiency            22.09          23.39          23.54
Ops SIS Domain Search Eff            14.64          14.78          14.96
Ops SIS Fast Success Rate            39.51          43.21          42.87
Ops SIS Success Rate                 45.19          57.62          54.69

[noisy]
                             vanilla                 filter               balancer
Hmean     1        275.05 (   0.00%)      275.66 *   0.22%*      276.99 *   0.70%*
Hmean     2        543.31 (   0.00%)      548.55 *   0.97%*      549.71 *   1.18%*
Hmean     4       1077.41 (   0.00%)     1082.60 *   0.48%*     1090.07 *   1.18%*
Hmean     8       2119.68 (   0.00%)     2140.60 *   0.99%*     2133.47 *   0.65%*
Hmean     16      3914.25 (   0.00%)     3938.84 *   0.63%*     3914.42 (   0.00%)
Hmean     32      6574.06 (   0.00%)     6650.66 *   1.17%*     6622.36 *   0.73%*
Hmean     64      8757.89 (   0.00%)     9047.06 *   3.30%*     8987.00 *   2.62%*
Hmean     128    20533.22 (   0.00%)    15573.19 * -24.16%*    20746.83 *   1.04%*
Hmean     256    20194.51 (   0.00%)    18961.24 *  -6.11%*    20115.34 *  -0.39%*
Hmean     384    17552.64 (   0.00%)    17949.46 *   2.26%*    19796.18 *  12.78%*

Ops SIS Search Efficiency            22.30          25.21          28.33
Ops SIS Domain Search Eff            14.87          16.69          19.60
Ops SIS Fast Success Rate            39.15          40.58          38.35
Ops SIS Success Rate                 43.88          49.88          43.08

g) netperf-udp

[quiet]
                                    vanilla                 filter               balancer
Hmean     send-64         184.86 (   0.00%)      182.76 *  -1.14%*      185.78 (   0.50%)
Hmean     send-128        368.11 (   0.00%)      362.97 *  -1.40%*      371.56 (   0.94%)
Hmean     send-256        730.95 (   0.00%)      717.07 *  -1.90%*      728.71 (  -0.31%)
Hmean     send-1024      2804.94 (   0.00%)     2782.30 *  -0.81%*     2825.97 (   0.75%)
Hmean     send-2048      5355.49 (   0.00%)     5228.70 *  -2.37%*     5370.87 (   0.29%)
Hmean     send-3312      8235.83 (   0.00%)     8247.11 (   0.14%)     8298.53 (   0.76%)
Hmean     send-4096      9916.04 (   0.00%)    10012.30 *   0.97%*    10086.82 *   1.72%*
Hmean     send-8192     16743.15 (   0.00%)    16847.61 (   0.62%)    16856.65 (   0.68%)
Hmean     send-16384    26512.04 (   0.00%)    26512.69 (   0.00%)    26537.69 (   0.10%)
Hmean     recv-64         184.86 (   0.00%)      182.76 *  -1.14%*      185.78 (   0.50%)
Hmean     recv-128        368.11 (   0.00%)      362.97 *  -1.40%*      371.56 (   0.94%)
Hmean     recv-256        730.95 (   0.00%)      717.07 *  -1.90%*      728.71 (  -0.31%)
Hmean     recv-1024      2804.94 (   0.00%)     2782.30 *  -0.81%*     2825.97 (   0.75%)
Hmean     recv-2048      5355.49 (   0.00%)     5228.70 *  -2.37%*     5370.87 (   0.29%)
Hmean     recv-3312      8235.83 (   0.00%)     8247.11 (   0.14%)     8298.53 (   0.76%)
Hmean     recv-4096      9916.04 (   0.00%)    10012.30 *   0.97%*    10086.78 *   1.72%*
Hmean     recv-8192     16743.10 (   0.00%)    16847.59 (   0.62%)    16856.55 (   0.68%)
Hmean     recv-16384    26512.04 (   0.00%)    26512.68 (   0.00%)    26537.69 (   0.10%)

Ops SIS Search Efficiency           100.00         100.00         100.00
Ops SIS Domain Search Eff            20.00          23.09          24.32
Ops SIS Fast Success Rate           100.00         100.00         100.00
Ops SIS Success Rate                100.00         100.00         100.00

[noisy]
                                    vanilla                 filter               balancer
Hmean     send-64         180.48 (   0.00%)      181.99 (   0.84%)      182.52 (   1.13%)
Hmean     send-128        350.18 (   0.00%)      360.14 *   2.85%*      367.83 *   5.04%*
Hmean     send-256        708.12 (   0.00%)      707.57 (  -0.08%)      723.46 *   2.17%*
Hmean     send-1024      2752.72 (   0.00%)     2757.50 (   0.17%)     2781.04 (   1.03%)
Hmean     send-2048      5218.99 (   0.00%)     5127.64 (  -1.75%)     5332.42 *   2.17%*
Hmean     send-3312      8037.54 (   0.00%)     8054.75 (   0.21%)     8179.42 (   1.77%)
Hmean     send-4096      9834.51 (   0.00%)     9782.38 (  -0.53%)     9901.92 (   0.69%)
Hmean     send-8192     15947.03 (   0.00%)    16072.71 (   0.79%)    16700.60 *   4.73%*
Hmean     send-16384    25479.72 (   0.00%)    24922.78 (  -2.19%)    25751.27 (   1.07%)
Hmean     recv-64         180.45 (   0.00%)      181.97 (   0.84%)      182.49 (   1.13%)
Hmean     recv-128        350.10 (   0.00%)      360.06 *   2.84%*      367.78 *   5.05%*
Hmean     recv-256        707.73 (   0.00%)      707.27 (  -0.06%)      723.00 *   2.16%*
Hmean     recv-1024      2750.10 (   0.00%)     2755.09 (   0.18%)     2778.95 (   1.05%)
Hmean     recv-2048      5213.28 (   0.00%)     5121.07 (  -1.77%)     5326.50 *   2.17%*
Hmean     recv-3312      8026.50 (   0.00%)     8045.41 (   0.24%)     8172.19 (   1.82%)
Hmean     recv-4096      9821.89 (   0.00%)     9769.07 (  -0.54%)     9889.91 (   0.69%)
Hmean     recv-8192     15922.95 (   0.00%)    16052.20 (   0.81%)    16679.50 *   4.75%*
Hmean     recv-16384    25441.27 (   0.00%)    24876.79 (  -2.22%)    25706.80 (   1.04%)

Ops SIS Search Efficiency            98.46          98.50          98.41
Ops SIS Domain Search Eff            24.87          24.95          24.91
Ops SIS Fast Success Rate            99.48          99.50          99.46
Ops SIS Success Rate                100.00         100.00         100.00

h) netperf-tcp

[quiet]
                               vanilla                 filter               balancer
Hmean     64         839.51 (   0.00%)      831.51 (  -0.95%)      869.34 *   3.55%*
Hmean     128       1629.70 (   0.00%)     1635.25 (   0.34%)     1692.19 *   3.83%*
Hmean     256       3046.92 (   0.00%)     3019.34 *  -0.91%*     3106.67 *   1.96%*
Hmean     1024     10164.80 (   0.00%)    10023.82 (  -1.39%)    10317.10 *   1.50%*
Hmean     2048     16942.50 (   0.00%)    16519.73 *  -2.50%*    17435.42 *   2.91%*
Hmean     3312     21379.01 (   0.00%)    21065.52 *  -1.47%*    21642.12 *   1.23%*
Hmean     4096     23452.47 (   0.00%)    23539.17 (   0.37%)    23987.73 *   2.28%*
Hmean     8192     29084.04 (   0.00%)    28763.16 *  -1.10%*    29710.51 *   2.15%*
Hmean     16384    33512.05 (   0.00%)    33124.21 *  -1.16%*    34055.83 *   1.62%*

Ops SIS Search Efficiency           100.00         100.00         100.00
Ops SIS Domain Search Eff            18.08          21.82          25.44
Ops SIS Fast Success Rate           100.00         100.00         100.00
Ops SIS Success Rate                100.00         100.00         100.00

[noisy]
                             vanilla                 filter               balancer
Hmean     64         868.21 (   0.00%)      833.12 *  -4.04%*      805.06 *  -7.27%*
Hmean     128       1657.75 (   0.00%)     1608.11 *  -2.99%*     1554.89 *  -6.20%*
Hmean     256       3093.27 (   0.00%)     2953.87 *  -4.51%*     2950.83 *  -4.60%*
Hmean     1024     10168.94 (   0.00%)     9589.55 *  -5.70%*     9712.72 *  -4.49%*
Hmean     2048     16539.60 (   0.00%)    16031.40 *  -3.07%*    15902.98 *  -3.85%*
Hmean     3312     20710.95 (   0.00%)    20174.85 *  -2.59%*    20144.92 *  -2.73%*
Hmean     4096     22728.08 (   0.00%)    22633.01 (  -0.42%)    22419.51 (  -1.36%)
Hmean     8192     28017.31 (   0.00%)    27761.16 (  -0.91%)    27667.10 (  -1.25%)
Hmean     16384    32314.91 (   0.00%)    32084.40 (  -0.71%)    32090.03 (  -0.70%)

Ops SIS Search Efficiency            97.95          98.04          98.01
Ops SIS Domain Search Eff            24.72          24.73          24.71
Ops SIS Fast Success Rate            99.31          99.34          99.33
Ops SIS Success Rate                100.00         100.00         100.00


Conclusion
==========

The results didn't show a global win, but the balancer did outperform vanilla in
lots of the benchmarks both in quiet and noisy environment. The SIS filter makes
SIS more efficient as expected, and the balancer does even better by making the
overloaded cpu mask more accurate.

The only obvious regression is netperf-tcp in noisy environment, and I haven't
yet figured out why, and the more interesting thing is that the netperf/tbench
results on another machine (used in my patch v1) showed a suspicious 50%~90%
improvement by this patch series. It might be worthy of digging deeper.

Comments and tests are appreciated!

---

v2:
  - several optimizations on sched-idle balancing
  - ignore asym topos in can_migrate_task
  - add more benchmarks including SIS efficiency
  - re-organize patch as suggested by Mel

v1 can be found at [2].

[1] https://lore.kernel.org/lkml/20210726102247.21437-2-mgorman@techsingularity.net/
[2] https://lore.kernel.org/lkml/20220217154403.6497-5-wuyun.abel@bytedance.com/

Abel Wu (2):
  sched/fair: filter out overloaded cpus in SIS
  sched/fair: introduce sched-idle balance

 include/linux/sched/idle.h     |   1 +
 include/linux/sched/topology.h |  12 +++
 kernel/sched/core.c            |   2 +
 kernel/sched/fair.c            | 210 +++++++++++++++++++++++++++++++++++++++--
 kernel/sched/sched.h           |   8 ++
 kernel/sched/topology.c        |   4 +-
 6 files changed, 228 insertions(+), 9 deletions(-)

-- 
2.11.0

