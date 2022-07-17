Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D43577661
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 15:29:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbiGQN3X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Jul 2022 09:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232848AbiGQN3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Jul 2022 09:29:22 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693FD63DA;
        Sun, 17 Jul 2022 06:29:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 660BCB80DFF;
        Sun, 17 Jul 2022 13:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7C6C3411E;
        Sun, 17 Jul 2022 13:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658064556;
        bh=KKVtiQJKuqd8sZmMaZfLkyWlfFohoAoLQGorJyPrM6Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t0gOFW8M3fGBfdSuke65W34WHx5tPvGgZkAd2T8gQ4z/wUT+yavHqUhayEr/0NZhZ
         t1Tpozk0pAuP938v7t4qjklJTqe4daba7AaRe2shlOnZeU48oHrOTJQ+u0BxUJ6L1p
         +HWulqiF1PZt0LLldoPap3p6EKAU7Nb76y4kHqw0Z7DJVecx96rTQD3BkcNugSSrpl
         6xc/aCh3I0ppFffArxY2f1UuhbrHbnvIlVxmsAtvUkgntNNJXJIhPlHuQyMoa8KHhj
         /u3AyM5UIRY3GKzxx2dIVk93G8H+fKc6qNoMZM4n4yIiIfWj7GI3AvQ+svCekjw6pV
         7uKidGasmBQDw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 40D0940374; Sun, 17 Jul 2022 10:29:14 -0300 (-03)
Date:   Sun, 17 Jul 2022 10:29:14 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Yang Jihong <yangjihong1@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, pc@us.ibm.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC v3 00/17] perf: Add perf kwork
Message-ID: <YtQOqva1x2VIi9ah@kernel.org>
References: <20220709015033.38326-1-yangjihong1@huawei.com>
 <f14aec08-e0e5-ed1f-771d-88de7819d90c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f14aec08-e0e5-ed1f-771d-88de7819d90c@huawei.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sat, Jul 16, 2022 at 05:14:28PM +0800, Yang Jihong escreveu:
> Ping

I'm back from vacations, will get into this this coming week, thanks for
you work!

- Arnaldo
 
> Regards,
> Yang
> 
> On 2022/7/9 9:50, Yang Jihong wrote:
> > Sometimes, we need to analyze time properties of kernel work such as irq,
> > softirq, and workqueue, including delay and running time of specific interrupts.
> > Currently, these events have kernel tracepoints, but perf tool does not
> > directly analyze the delay of these events
> > 
> > The perf-kwork tool is used to trace time properties of kernel work
> > (such as irq, softirq, and workqueue), including runtime, latency,
> > and timehist, using the infrastructure in the perf tools to allow
> > tracing extra targets
> > 
> > We also use bpf trace to collect and filter data in kernel to solve
> > problem of large perf data volume and extra file system interruptions.
> > 
> > Example usage:
> > 
> > 1. Kwork record:
> > 
> >    # perf kwork record -- sleep 10
> >    [ perf record: Woken up 0 times to write data ]
> >    [ perf record: Captured and wrote 6.825 MB perf.data ]
> > 
> > 2. Kwork report:
> > 
> >    # perf kwork report -S
> > 
> >      Kwork Name                     | Cpu  | Total Runtime | Count     | Max runtime   | Max runtime start   | Max runtime end     |
> >     --------------------------------------------------------------------------------------------------------------------------------
> >      virtio0-requests:25            | 0000 |   1347.861 ms |     25049 |      1.417 ms |     121235.524083 s |     121235.525499 s |
> >      (s)TIMER:1                     | 0005 |    151.033 ms |      2545 |      0.153 ms |     121237.454591 s |     121237.454744 s |
> >      (s)RCU:9                       | 0005 |    117.254 ms |      2754 |      0.223 ms |     121239.461024 s |     121239.461246 s |
> >      (s)SCHED:7                     | 0005 |     58.714 ms |      1773 |      0.075 ms |     121237.702345 s |     121237.702419 s |
> >      (s)RCU:9                       | 0007 |     43.359 ms |       945 |      0.861 ms |     121237.702984 s |     121237.703845 s |
> >      (s)SCHED:7                     | 0000 |     33.389 ms |       549 |      4.121 ms |     121235.521379 s |     121235.525499 s |
> >      (s)RCU:9                       | 0002 |     21.419 ms |       484 |      0.281 ms |     121244.629001 s |     121244.629282 s |
> >      (w)mix_interrupt_randomness    | 0000 |     21.047 ms |       391 |      1.016 ms |     121237.934008 s |     121237.935024 s |
> >      (s)SCHED:7                     | 0007 |     19.903 ms |       570 |      0.065 ms |     121235.523360 s |     121235.523426 s |
> >      (s)RCU:9                       | 0000 |     19.017 ms |       472 |      0.507 ms |     121244.634002 s |     121244.634510 s |
> >      ... <SNIP> ...
> >      (s)SCHED:7                     | 0003 |      0.049 ms |         1 |      0.049 ms |     121240.018631 s |     121240.018680 s |
> >      (w)vmstat_update               | 0003 |      0.046 ms |         1 |      0.046 ms |     121240.916200 s |     121240.916246 s |
> >      (s)RCU:9                       | 0004 |      0.045 ms |         2 |      0.024 ms |     121235.522876 s |     121235.522900 s |
> >      (w)neigh_managed_work          | 0001 |      0.044 ms |         1 |      0.044 ms |     121235.513929 s |     121235.513973 s |
> >      (w)vmstat_update               | 0006 |      0.031 ms |         1 |      0.031 ms |     121245.673914 s |     121245.673945 s |
> >      (w)vmstat_update               | 0004 |      0.028 ms |         1 |      0.028 ms |     121235.522743 s |     121235.522770 s |
> >      (w)wb_update_bandwidth_workfn  | 0000 |      0.024 ms |         1 |      0.024 ms |     121244.842660 s |     121244.842683 s |
> >     --------------------------------------------------------------------------------------------------------------------------------
> >      Total count            :     36071
> >      Total runtime   (msec) :  1887.188 (0.185% load average)
> >      Total time span (msec) : 10185.012
> >     --------------------------------------------------------------------------------------------------------------------------------
> > 
> > 3. Kwork latency:
> > 
> >    # perf kwork latency
> > 
> >      Kwork Name                     | Cpu  | Avg delay     | Count     | Max delay     | Max delay start     | Max delay end       |
> >     --------------------------------------------------------------------------------------------------------------------------------
> >      (s)TIMER:1                     | 0004 |      3.903 ms |         1 |      3.903 ms |     121235.517068 s |     121235.520971 s |
> >      (s)RCU:9                       | 0004 |      3.252 ms |         2 |      5.809 ms |     121235.517068 s |     121235.522876 s |
> >      (s)RCU:9                       | 0001 |      3.238 ms |         2 |      5.832 ms |     121235.514494 s |     121235.520326 s |
> >      (w)vmstat_update               | 0004 |      1.738 ms |         1 |      1.738 ms |     121235.521005 s |     121235.522743 s |
> >      (s)SCHED:7                     | 0004 |      0.978 ms |         2 |      1.899 ms |     121235.520940 s |     121235.522840 s |
> >      (w)wb_update_bandwidth_workfn  | 0000 |      0.834 ms |         1 |      0.834 ms |     121244.841826 s |     121244.842660 s |
> >      (s)RCU:9                       | 0003 |      0.479 ms |         3 |      0.752 ms |     121240.027521 s |     121240.028273 s |
> >      (s)TIMER:1                     | 0001 |      0.465 ms |         1 |      0.465 ms |     121235.513107 s |     121235.513572 s |
> >      (w)vmstat_update               | 0000 |      0.391 ms |         5 |      1.275 ms |     121236.814938 s |     121236.816213 s |
> >      (w)mix_interrupt_randomness    | 0002 |      0.317 ms |         5 |      0.874 ms |     121244.628034 s |     121244.628908 s |
> >      (w)neigh_managed_work          | 0001 |      0.315 ms |         1 |      0.315 ms |     121235.513614 s |     121235.513929 s |
> >      ... <SNIP> ...
> >      (s)TIMER:1                     | 0005 |      0.061 ms |      2545 |      0.506 ms |     121237.136113 s |     121237.136619 s |
> >      (s)SCHED:7                     | 0001 |      0.052 ms |        21 |      0.437 ms |     121237.711014 s |     121237.711451 s |
> >      (s)SCHED:7                     | 0002 |      0.045 ms |       309 |      0.145 ms |     121237.137184 s |     121237.137329 s |
> >      (s)SCHED:7                     | 0003 |      0.045 ms |         1 |      0.045 ms |     121240.018586 s |     121240.018631 s |
> >      (s)SCHED:7                     | 0007 |      0.044 ms |       570 |      0.173 ms |     121238.161161 s |     121238.161334 s |
> >      (s)BLOCK:4                     | 0003 |      0.030 ms |         4 |      0.056 ms |     121240.028255 s |     121240.028311 s |
> >     --------------------------------------------------------------------------------------------------------------------------------
> >      INFO: 28.761% skipped events (27674 including 2607 raise, 25067 entry, 0 exit)
> > 
> > 4. Kwork timehist:
> > 
> >    # perf kwork timehist
> >     Runtime start      Runtime end        Cpu     Kwork name                      Runtime     Delaytime
> >                                                   (TYPE)NAME:NUM                  (msec)      (msec)
> >     -----------------  -----------------  ------  ------------------------------  ----------  ----------
> >         121235.513572      121235.513674  [0001]  (s)TIMER:1                           0.102       0.465
> >         121235.513688      121235.513738  [0001]  (s)SCHED:7                           0.050       0.172
> >         121235.513750      121235.513777  [0001]  (s)RCU:9                             0.027       0.643
> >         121235.513929      121235.513973  [0001]  (w)neigh_managed_work                0.044       0.315
> >         121235.520326      121235.520386  [0001]  (s)RCU:9                             0.060       5.832
> >         121235.520672      121235.520716  [0002]  (s)SCHED:7                           0.044       0.048
> >         121235.520729      121235.520753  [0002]  (s)RCU:9                             0.024       5.651
> >         121235.521213      121235.521249  [0005]  (s)TIMER:1                           0.036       0.064
> >         121235.520166      121235.521379  [0000]  (s)SCHED:7                           1.213       0.056
> >      ... <SNIP> ...
> >         121235.533256      121235.533296  [0000]  virtio0-requests:25                  0.040
> >         121235.533322      121235.533359  [0000]  (s)SCHED:7                           0.037       0.095
> >         121235.533018      121235.533452  [0006]  (s)RCU:9                             0.434       0.348
> >         121235.534653      121235.534698  [0000]  virtio0-requests:25                  0.046
> >         121235.535657      121235.535702  [0000]  virtio0-requests:25                  0.044
> >         121235.535857      121235.535916  [0005]  (s)TIMER:1                           0.059       0.055
> >         121235.535927      121235.535947  [0005]  (s)RCU:9                             0.020       0.113
> >         121235.536178      121235.536196  [0006]  (s)RCU:9                             0.018       0.410
> >         121235.537406      121235.537445  [0006]  (s)SCHED:7                           0.039       0.049
> >         121235.537457      121235.537481  [0006]  (s)RCU:9                             0.024       0.334
> >         121235.538199      121235.538254  [0007]  (s)RCU:9                             0.055       0.066
> > 
> > 5. Kwork report use bpf:
> > 
> >    # perf kwork report -b
> >    Starting trace, Hit <Ctrl+C> to stop and report
> >    ^C
> >      Kwork Name                     | Cpu  | Total Runtime | Count     | Max runtime   | Max runtime start   | Max runtime end     |
> >     --------------------------------------------------------------------------------------------------------------------------------
> >      (w)flush_to_ldisc              | 0000 |      2.279 ms |         2 |      2.219 ms |     121293.080933 s |     121293.083152 s |
> >      (s)SCHED:7                     | 0001 |      2.141 ms |         2 |      2.100 ms |     121293.082064 s |     121293.084164 s |
> >      (s)RCU:9                       | 0003 |      2.137 ms |         3 |      2.046 ms |     121293.081348 s |     121293.083394 s |
> >      (s)TIMER:1                     | 0007 |      1.882 ms |        12 |      0.249 ms |     121295.632211 s |     121295.632460 s |
> >      (w)e1000_watchdog              | 0002 |      1.136 ms |         3 |      0.428 ms |     121294.496559 s |     121294.496987 s |
> >      (s)SCHED:7                     | 0007 |      0.995 ms |        12 |      0.139 ms |     121295.632483 s |     121295.632621 s |
> >      (s)NET_RX:3                    | 0002 |      0.727 ms |         5 |      0.391 ms |     121299.044624 s |     121299.045016 s |
> >      (s)TIMER:1                     | 0002 |      0.696 ms |         5 |      0.164 ms |     121294.496172 s |     121294.496337 s |
> >      (s)SCHED:7                     | 0002 |      0.427 ms |         6 |      0.077 ms |     121295.840321 s |     121295.840398 s |
> >      (s)SCHED:7                     | 0000 |      0.366 ms |         3 |      0.156 ms |     121296.545389 s |     121296.545545 s |
> >      eth0:10                        | 0002 |      0.353 ms |         5 |      0.122 ms |     121293.084796 s |     121293.084919 s |
> >      (w)flush_to_ldisc              | 0000 |      0.298 ms |         1 |      0.298 ms |     121299.046236 s |     121299.046534 s |
> >      (w)mix_interrupt_randomness    | 0002 |      0.215 ms |         4 |      0.077 ms |     121293.086747 s |     121293.086823 s |
> >      (s)RCU:9                       | 0002 |      0.128 ms |         3 |      0.060 ms |     121293.087348 s |     121293.087409 s |
> >      (w)vmstat_shepherd             | 0000 |      0.098 ms |         1 |      0.098 ms |     121293.083901 s |     121293.083999 s |
> >      (s)TIMER:1                     | 0001 |      0.089 ms |         1 |      0.089 ms |     121293.085709 s |     121293.085798 s |
> >      (w)vmstat_update               | 0003 |      0.071 ms |         1 |      0.071 ms |     121293.085227 s |     121293.085298 s |
> >      (w)wq_barrier_func             | 0000 |      0.064 ms |         1 |      0.064 ms |     121293.083688 s |     121293.083752 s |
> >      (w)vmstat_update               | 0000 |      0.041 ms |         1 |      0.041 ms |     121293.083829 s |     121293.083869 s |
> >      (s)RCU:9                       | 0001 |      0.038 ms |         1 |      0.038 ms |     121293.085818 s |     121293.085856 s |
> >      (s)RCU:9                       | 0007 |      0.035 ms |         1 |      0.035 ms |     121293.112322 s |     121293.112357 s |
> >     --------------------------------------------------------------------------------------------------------------------------------
> > 
> > 6. Kwork latency use bpf:
> > 
> >    # perf kwork latency -b
> >    Starting trace, Hit <Ctrl+C> to stop and report
> >    ^C
> >      Kwork Name                     | Cpu  | Avg delay     | Count     | Max delay     | Max delay start     | Max delay end       |
> >     --------------------------------------------------------------------------------------------------------------------------------
> >      (w)vmstat_shepherd             | 0000 |      2.044 ms |         2 |      2.764 ms |     121314.942758 s |     121314.945522 s |
> >      (w)flush_to_ldisc              | 0000 |      1.008 ms |         1 |      1.008 ms |     121317.335508 s |     121317.336516 s |
> >      (w)vmstat_update               | 0002 |      0.879 ms |         1 |      0.879 ms |     121317.024405 s |     121317.025284 s |
> >      (w)mix_interrupt_randomness    | 0002 |      0.328 ms |         5 |      0.383 ms |     121308.832944 s |     121308.833327 s |
> >      (w)e1000_watchdog              | 0002 |      0.304 ms |         5 |      0.368 ms |     121317.024305 s |     121317.024673 s |
> >      (s)RCU:9                       | 0001 |      0.172 ms |        41 |      0.728 ms |     121308.308187 s |     121308.308915 s |
> >      (s)TIMER:1                     | 0000 |      0.149 ms |         3 |      0.195 ms |     121317.334255 s |     121317.334449 s |
> >      (s)NET_RX:3                    | 0001 |      0.143 ms |        40 |      1.213 ms |     121315.030992 s |     121315.032205 s |
> >      (s)RCU:9                       | 0002 |      0.139 ms |        27 |      0.187 ms |     121315.077388 s |     121315.077576 s |
> >      (s)NET_RX:3                    | 0002 |      0.130 ms |         7 |      0.283 ms |     121308.832917 s |     121308.833201 s |
> >      (s)SCHED:7                     | 0007 |      0.123 ms |        34 |      0.191 ms |     121308.736240 s |     121308.736431 s |
> >      (s)TIMER:1                     | 0007 |      0.116 ms |        18 |      0.145 ms |     121308.736168 s |     121308.736313 s |
> >      (s)RCU:9                       | 0007 |      0.111 ms |        68 |      0.318 ms |     121308.736194 s |     121308.736512 s |
> >      (s)SCHED:7                     | 0002 |      0.110 ms |        22 |      0.292 ms |     121308.832197 s |     121308.832489 s |
> >      (s)TIMER:1                     | 0001 |      0.107 ms |         1 |      0.107 ms |     121314.948230 s |     121314.948337 s |
> >      (w)neigh_managed_work          | 0001 |      0.103 ms |         1 |      0.103 ms |     121314.948381 s |     121314.948484 s |
> >      (s)RCU:9                       | 0000 |      0.099 ms |        49 |      0.289 ms |     121308.520167 s |     121308.520456 s |
> >      (s)NET_RX:3                    | 0007 |      0.096 ms |        40 |      1.227 ms |     121315.022994 s |     121315.024220 s |
> >      (s)RCU:9                       | 0003 |      0.093 ms |        37 |      0.261 ms |     121314.950651 s |     121314.950913 s |
> >      (w)flush_to_ldisc              | 0000 |      0.090 ms |         1 |      0.090 ms |     121317.336737 s |     121317.336827 s |
> >      (s)TIMER:1                     | 0002 |      0.078 ms |        36 |      0.115 ms |     121310.880172 s |     121310.880288 s |
> >      (s)SCHED:7                     | 0001 |      0.071 ms |        27 |      0.180 ms |     121314.953571 s |     121314.953751 s |
> >      (s)SCHED:7                     | 0000 |      0.066 ms |        28 |      0.344 ms |     121317.334345 s |     121317.334689 s |
> >      (s)SCHED:7                     | 0003 |      0.063 ms |        14 |      0.119 ms |     121314.978808 s |     121314.978927 s |
> >     --------------------------------------------------------------------------------------------------------------------------------
> > 
> > 7. Kwork report with filter:
> > 
> >    # perf kwork report -b -n RCU
> >    Starting trace, Hit <Ctrl+C> to stop and report
> >    ^C
> >      Kwork Name                     | Cpu  | Total Runtime | Count     | Max runtime   | Max runtime start   | Max runtime end     |
> >     --------------------------------------------------------------------------------------------------------------------------------
> >      (s)RCU:9                       | 0006 |      2.266 ms |         3 |      2.158 ms |     121335.008290 s |     121335.010449 s |
> >      (s)RCU:9                       | 0002 |      0.158 ms |         3 |      0.063 ms |     121335.011914 s |     121335.011977 s |
> >      (s)RCU:9                       | 0007 |      0.082 ms |         1 |      0.082 ms |     121335.448378 s |     121335.448460 s |
> >      (s)RCU:9                       | 0000 |      0.058 ms |         1 |      0.058 ms |     121335.011350 s |     121335.011408 s |
> >     --------------------------------------------------------------------------------------------------------------------------------
> > 
> > ---
> > Changes since v2:
> >    - Updage commit messages.
> > 
> > Changes since v1:
> >    - Add options and document when actually add the functionality later.
> >    - Replace "cluster" with "work".
> >    - Add workqueue symbolizing function support.
> >    - Replace "frequency" with "count" in report header.
> >    - Add bpf trace support.
> > 
> > Yang Jihong (17):
> >    perf kwork: New tool
> >    perf kwork: Add irq kwork record support
> >    perf kwork: Add softirq kwork record support
> >    perf kwork: Add workqueue kwork record support
> >    tools lib: Add list_last_entry_or_null
> >    perf kwork: Implement perf kwork report
> >    perf kwork: Add irq report support
> >    perf kwork: Add softirq report support
> >    perf kwork: Add workqueue report support
> >    perf kwork: Implement perf kwork latency
> >    perf kwork: Add softirq latency support
> >    perf kwork: Add workqueue latency support
> >    perf kwork: Implement perf kwork timehist
> >    perf kwork: Implement bpf trace
> >    perf kwork: Add irq trace bpf support
> >    perf kwork: Add softirq trace bpf support
> >    perf kwork: Add workqueue trace bpf support
> > 
> >   tools/include/linux/list.h                 |   11 +
> >   tools/perf/Build                           |    1 +
> >   tools/perf/Documentation/perf-kwork.txt    |  180 ++
> >   tools/perf/Makefile.perf                   |    1 +
> >   tools/perf/builtin-kwork.c                 | 1834 ++++++++++++++++++++
> >   tools/perf/builtin.h                       |    1 +
> >   tools/perf/command-list.txt                |    1 +
> >   tools/perf/perf.c                          |    1 +
> >   tools/perf/util/Build                      |    1 +
> >   tools/perf/util/bpf_kwork.c                |  356 ++++
> >   tools/perf/util/bpf_skel/kwork_trace.bpf.c |  381 ++++
> >   tools/perf/util/kwork.h                    |  257 +++
> >   12 files changed, 3025 insertions(+)
> >   create mode 100644 tools/perf/Documentation/perf-kwork.txt
> >   create mode 100644 tools/perf/builtin-kwork.c
> >   create mode 100644 tools/perf/util/bpf_kwork.c
> >   create mode 100644 tools/perf/util/bpf_skel/kwork_trace.bpf.c
> >   create mode 100644 tools/perf/util/kwork.h
> > 

-- 

- Arnaldo
