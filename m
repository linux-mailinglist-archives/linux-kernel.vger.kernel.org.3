Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2646532E7F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 18:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232008AbiEXQEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 12:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239453AbiEXQCb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 12:02:31 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3959E1AF0D
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 09:01:19 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id p190so4760447ybg.4
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 09:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ibK5zZlZzoTX21EL9YUHbCNp7IfG5R8p2zg2f67IZu0=;
        b=OiowJ/grrXZJDahpcxIDgReo1Bcq88hnpKB6Ue1i+eiC5MZT91VFSbjcoNkVqli57K
         CsuVfnkQ4bqud5mcRy+97bjdY3aOvldzV9KLkriUOjpNmmxkoPrkY/oFMsKBvL8G1Sm1
         Lou3AgzF6W2Ecf+g/fu+292DjpozGr8+m+SoozJ+QC0qdxElzMg0yDdVrxuf1vmJAVoE
         V5S2zToYRMHilMPsWofxGSIzlR6lg57ZazSTX1yqoFfN+9QKLccF4Sv+wDAT0nY5irOR
         TKw4N8CHJpNAu6KX1NXGvArny198wUUUY5LMY9zZeFeLOQ+12BHOPfYjdJvdeArLT6jk
         Kjtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ibK5zZlZzoTX21EL9YUHbCNp7IfG5R8p2zg2f67IZu0=;
        b=nsx7hO6GatH45GokibvkmoPeu+wiId208KUZ1UZuTd4NBDJz0e9JKJ7opezSLbQis9
         1pE+K8OWqCkNJpK8d+A/Y0pmWyXuZQtfarElB5OuT7Fptc5A7vWCdLbpjpqXoOkS5xZE
         e+79biGkb7kcI1T732ylLXqL4ie8FD3YDLp5GmYIxsYuEwzN/67iJu3qgASzfmgFcaDU
         eB3ig8uB2JFQjdghCtOwz35CbxaEhFtIuq9VfDtZZU1VTeu3GoFgDged3DnTnhXWdRCZ
         YvgYFWVR7/feMJE5tBQ/lSaKWEtjykmpTQ2CKpUZMcyMZ6FARZb7jUKZcvoBD3fSetHj
         TF6A==
X-Gm-Message-State: AOAM531YiBO3BwK6vJu2at50f9Eh3zk8H1QVg6yfh+OMIk7wzU0kn0A+
        dij5wntZnYo8e8wFeelpRBz/mvG4OmXRzttNzi7MhA==
X-Google-Smtp-Source: ABdhPJzvWboEo4H4UFd7xOByePlpDEeebsCC0VVr5C4Fs0KHhLsLM95qAU3wq9vzWc/1PTtAC2Rge13gUBZ61+/sVl4=
X-Received: by 2002:a5b:78b:0:b0:64f:de43:2d38 with SMTP id
 b11-20020a5b078b000000b0064fde432d38mr11074769ybq.225.1653408078266; Tue, 24
 May 2022 09:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <20220520103519.1863-1-mgorman@techsingularity.net>
In-Reply-To: <20220520103519.1863-1-mgorman@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 24 May 2022 18:01:07 +0200
Message-ID: <CAKfTPtDERvGAsmasGK=xtGEawx1yK6Lf4mV7Cc7JcNFKrxUWKw@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Mitigate inconsistent NUMA imbalance behaviour
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Ying Huang <ying.huang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 May 2022 at 12:35, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> Changes since V1
> o Consolidate [allow|adjust]_numa_imbalance                     (peterz)
> o #ifdefs around NUMA-specific pieces to build arc-allyesconfig (lkp)
>
> A problem was reported privately related to inconsistent performance of
> NAS when parallelised with MPICH. The root of the problem is that the
> initial placement is unpredictable and there can be a larger imbalance
> than expected between NUMA nodes. As there is spare capacity and the faults
> are local, the imbalance persists for a long time and performance suffers.
>
> This is not 100% an "allowed imbalance" problem as setting the allowed
> imbalance to 0 does not fix the issue but the allowed imbalance contributes
> the the performance problem. The unpredictable behaviour was most recently
> introduced by commit c6f886546cb8 ("sched/fair: Trigger the update of
> blocked load on newly idle cpu").
>
> mpirun forks hydra_pmi_proxy helpers with MPICH that go to sleep before the
> execing the target workload. As the new tasks are sleeping, the potential
> imbalance is not observed as idle_cpus does not reflect the tasks that
> will be running in the near future. How bad the problem depends on the
> timing of when fork happens and whether the new tasks are still running.
> Consequently, a large initial imbalance may not be detected until the
> workload is fully running. Once running, NUMA Balancing picks the preferred
> node based on locality and runtime load balancing often ignores the tasks
> as can_migrate_task() fails for either locality or task_hot reasons and
> instead picks unrelated tasks.
>
> This is the min, max and range of run time for mg.D parallelised with ~25%
> of the CPUs parallelised by MPICH running on a 2-socket machine (80 CPUs,
> 16 active for mg.D due to limitations of mg.D).
>
> v5.3                                     Min  95.84 Max  96.55 Range   0.71 Mean  96.16
> v5.7                                     Min  95.44 Max  96.51 Range   1.07 Mean  96.14
> v5.8                                     Min  96.02 Max 197.08 Range 101.06 Mean 154.70
> v5.12                                    Min 104.45 Max 111.03 Range   6.58 Mean 105.94
> v5.13                                    Min 104.38 Max 170.37 Range  65.99 Mean 117.35
> v5.13-revert-c6f886546cb8                Min 104.40 Max 110.70 Range   6.30 Mean 105.68
> v5.18rc4-baseline                        Min 110.78 Max 169.84 Range  59.06 Mean 131.22
> v5.18rc4-revert-c6f886546cb8             Min 113.98 Max 117.29 Range   3.31 Mean 114.71
> v5.18rc4-this_series                     Min  95.56 Max 163.97 Range  68.41 Mean 105.39
> v5.18rc4-this_series-revert-c6f886546cb8 Min  95.56 Max 104.86 Range   9.30 Mean  97.00

I'm interested to understand why such instability can be introduced by
c6f886546cb8 as it aims to do the opposite by not waking up a random
idle cpu but using the current cpu which is becoming idle, instead. I
haven't been able to reproduce your problem with my current setup but
I assume this is specific to some use cases so I will try to reproduce
the mg.D test above. If you have more details on the setup to ease the
reproduction of the problem I'm interested.

>
> This shows that we've had unpredictable performance for a long time for
> this load. Instability was introduced somewhere between v5.7 and v5.8,
> fixed in v5.12 and broken again since v5.13.  The revert against 5.13
> and 5.18-rc4 shows that c6f886546cb8 is the primary source of instability
> although the best case is still worse than 5.7.
>
> This series addresses the allowed imbalance problems to get the peak
> performance back to 5.7 although only some of the time due to the
> instability problem. The series plus the revert is both stable and has
> slightly better peak performance and similar average performance. I'm
> not convinced commit c6f886546cb8 is wrong but haven't isolated exactly
> why it's unstable. I'm just noting it has an issue for now.
>
> Patch 1 initialises numa_migrate_retry. While this resolves itself
>         eventually, it is unpredictable early in the lifetime of
>         a task.
>
> Patch 2 will not swap NUMA tasks in the same NUMA group or without
>         a NUMA group if there is spare capacity. Swapping is just
>         punishing one task to help another.
>
> Patch 3 fixes an issue where a larger imbalance can be created at
>         fork time than would be allowed at run time. This behaviour
>         can help some workloads that are short lived and prefer
>         to remain local but it punishes long-lived tasks that are
>         memory intensive.
>
> Patch 4 adjusts the threshold where a NUMA imbalance is allowed to
>         better approximate the number of memory channels, at least
>         for x86-64.
>
>  kernel/sched/fair.c     | 91 +++++++++++++++++++++++++----------------
>  kernel/sched/topology.c | 23 +++++++----
>  2 files changed, 70 insertions(+), 44 deletions(-)
>
> --
> 2.34.1
