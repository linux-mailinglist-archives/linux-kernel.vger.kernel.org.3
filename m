Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71904BA4B7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 16:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240440AbiBQPob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 10:44:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236162AbiBQPo0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 10:44:26 -0500
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A538CB5614
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:44:10 -0800 (PST)
Received: by mail-pj1-x1032.google.com with SMTP id n19-20020a17090ade9300b001b9892a7bf9so9773094pjv.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 07:44:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hqy86u0ZED7OARERFcnhUlvL2Y04xjEjeUymkxasBiY=;
        b=Gi59zsKpQWCuQ8PG4x+ntVYtg08eJIxcxHORdNGwl2egrvFw37UZFLiBzZpZX+kvPh
         tJbTwrrgbSxjLuNTjwDfmaA20GFMKmnjbBzYkX0zS1IFEN8t51fxojs2VRpM9dYXrVDH
         BZ8M59n6no58m19G1PPUle0A53Z2AO/jsWytEoDoUg9A0O89168esUXGbSloHqU+t/x+
         fDLMyl4j8+/LzL89hi7+4o7xz2MpxAcgepNu+JgglTQssxfbOo/7RPyjFiGrjjHni+QO
         CxjkM8/KmDD5PfWmv0nVmI8Bo0VI7bMTf+45OgrHrkzLp3VUaa9dDzX4AvMUv6eJfp4e
         W/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hqy86u0ZED7OARERFcnhUlvL2Y04xjEjeUymkxasBiY=;
        b=txrSl4omgT2vcnWEJMWTXrkwYhggYwRzKyIryCN8JCYY7plnqislpudRK0CtKcNnCA
         mW4e9GgzqIBjSCxO3Bd9TE2V+3zSI0hbBp0gst5h1N6ZvvZ6loyReSClBCEO0Wk5e7TG
         eko1YznDAl5t2DGX/8pUPXhOFzLB6l96wf1p+qbmIOrNGi7Csp/tUKxLlVJXsHN2K90p
         NgpoZW24pzaVgGlowBe5zAU0x+amYY+/KZsVxa00VN7jWCvROzFE2MUk4K1BWbeAVKAG
         AmQgs88rqmXz7JWhcHsm+AAiDP940ozSxfuPiqnvEFe9x90aJRLGjylwu1xl+3jGcPwo
         bXAA==
X-Gm-Message-State: AOAM531qY2KdIbGjk1/iy2oBqwylUwb8MLobMu4fooJuqG91FRaAxAF+
        CFkye3FMPb1SNUyngJgOO3FV8tGav2b9Fw==
X-Google-Smtp-Source: ABdhPJzKttrc/PFvdleVMEu31pvkyr0W9SeNPZwkyZKM/c1e4rzsRpdyQ4+kYlgk6ibnOC5d5OvKqQ==
X-Received: by 2002:a17:902:c443:b0:14d:a756:b1f2 with SMTP id m3-20020a170902c44300b0014da756b1f2mr3247673plm.94.1645112650146;
        Thu, 17 Feb 2022 07:44:10 -0800 (PST)
Received: from localhost.localdomain ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id s6sm24108pfk.86.2022.02.17.07.44.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Feb 2022 07:44:09 -0800 (PST)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC PATCH 0/5] introduce sched-idle balancing
Date:   Thu, 17 Feb 2022 23:43:56 +0800
Message-Id: <20220217154403.6497-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current load balancing is mainly based on cpu capacity
and task util, which makes sense in the POV of overall
throughput. While there still might be some improvement
can be done by reducing number of overloaded cfs rqs if
sched-idle or idle rq exists.

An CFS runqueue is considered overloaded when there are
more than one pullable non-idle tasks on it (since sched-
idle cpus are treated as idle cpus). And idle tasks are
counted towards rq->cfs.idle_h_nr_running, that is either
assigned SCHED_IDLE policy or placed under idle cgroups.

The overloaded cfs rqs can cause performance issues to
both task types:

  - for latency critical tasks like SCHED_NORMAL,
    time of waiting in the rq will increase and
    result in higher pct99 latency, and

  - batch tasks may not be able to make full use
    of cpu capacity if sched-idle rq exists, thus
    presents poorer throughput.

So in short, the goal of the sched-idle balancing is to
let the *non-idle tasks* make full use of cpu resources.
To achieve that, we mainly do two things:

  - pull non-idle tasks for sched-idle or idle rqs
    from the overloaded ones, and

  - prevent pulling the last non-idle task in an rq

The mask of overloaded cpus is updated in periodic tick
and the idle path at the LLC domain basis. This cpumask
will also be used in SIS as a filter, improving idle cpu
searching.

Tests are done in an Intel Xeon E5-2650 v4 server with
2 NUMA nodes each of which has 12 cores, and with SMT2
enabled, so 48 CPUs in total. Test results are listed
as follows.

  - we used perf messaging test to test throughput
    at different load (groups).

      perf bench sched messaging -g [N] -l 40000

	N	w/o	w/	diff
	1	2.897	2.834	-2.17%
	3	5.156	4.904	-4.89%
	5	7.850	7.617	-2.97%
	10	15.140	14.574	-3.74%
	20	29.387	27.602	-6.07%

    the result shows approximate 2~6% improvement.

  - and schbench to test latency performance in two
    scenarios: quiet and noisy. In quiet test, we
    run schbench in a normal cpu cgroup in a quiet
    system, while the noisy test additionally runs
    perf messaging workload inside an idle cgroup
    as nosie.

      schbench -m 2 -t 24 -i 60 -r 60
      perf bench sched messaging -g 1 -l 4000000

	[quiet]
			w/o	w/
	50.0th		31	31
	75.0th		45	45
	90.0th		55	55
	95.0th		62	61
	*99.0th		85	86
	99.5th		565	318
	99.9th		11536	10992
	max		13029	13067

	[nosiy]
			w/o	w/
	50.0th		34	32
	75.0th		48	45
	90.0th		58	55
	95.0th		65	61
	*99.0th		2364	208
	99.5th		6696	2068
	99.9th		12688	8816
	max		15209	14191

    it can be seen that the quiet test results are
    quite similar, but the p99 latency is greatly
    improved in the nosiy test.

Comments and tests are appreciated!

Abel Wu (5):
  sched/fair: record overloaded cpus
  sched/fair: introduce sched-idle balance
  sched/fair: add stats for sched-idle balancing
  sched/fair: filter out overloaded cpus in sis
  sched/fair: favor cpu capacity for idle tasks

 include/linux/sched/idle.h     |   1 +
 include/linux/sched/topology.h |  15 ++++
 kernel/sched/core.c            |   1 +
 kernel/sched/fair.c            | 187 ++++++++++++++++++++++++++++++++++++++++-
 kernel/sched/sched.h           |   6 ++
 kernel/sched/stats.c           |   5 +-
 kernel/sched/topology.c        |   4 +-
 7 files changed, 215 insertions(+), 4 deletions(-)

-- 
2.11.0

