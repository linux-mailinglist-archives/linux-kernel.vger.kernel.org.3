Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D97155E1BE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241460AbiF1J7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 05:59:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344202AbiF1J7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 05:59:01 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BECF2E6BB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:59:00 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id sg40-20020a170907a42800b00722faf0aacbso3417061ejc.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 02:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=MrF5aaShEN6B7UjaZWC1TSqA3Z20kM5d1l/pRL2xCe0=;
        b=kpac3JTWggRdiHBa1fh59jMkbCSb9OblwJN+RfZ/fjE4TPO76j/gmwnSWiMqirO/RA
         MtTi0fzXw/WvbDygEa8XmyBZWWv2LuPU5ilmvRbvg+qDo7rJ6DcpD45MbwShAf9gYcT4
         58D0kDspgGu8+ctdqSssbUA7tsc65VeY5aG4g876MM2ToFCKqdihwENvPWn0UTUi6yl4
         lzT6hrrYw9uwZNPpHny3QZvwu6p21XsvqJUitxVvhT50c15CL3uUPY2xFITl5liDkI7H
         p1WOWea+7N0BdGIRUCqRUJNLZg9qyiTWACWLDmZ4AN7CghQcExbp5T5IhlOXd+FnUH9J
         UWbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=MrF5aaShEN6B7UjaZWC1TSqA3Z20kM5d1l/pRL2xCe0=;
        b=BpsSt3sxXzz4AepLURKaPzF9nsVb3k2JRBO2ZNcCuvy4SiNEPys8mVV4MU1/6+WsmJ
         +cih7yzp1PX0jpyFbY1N8MPKfETfprZJqCipEgq7RPbwUjP1PhN5MpPPd1ouFslsjCps
         jA49MsCstbrLuTp2zcNb0Mq+dPK1y9TGdo4PIL30XPdph249aGOBmSDcC1NJLB/zN/bf
         v5fo9FEeYycunktelT+Mmk2DUpMqYkWhc8JxAmuiY0sTH40Rwh73LgV3Z0Qc3Pc3QDmL
         hGkxUjCE1VXTcUGwcP4zv1/a/KMFLEDZqPFfwBgvZlff/1m+wiThhqEw2hD7cS7k257n
         KtrA==
X-Gm-Message-State: AJIora+ko+pUzJG+h4IA4Z6c3mipW9e5w16euwF1aCcxk+8mKykJKdgS
        MEekXvFo3sdyPVR8Mf7jvTbFerp96Q==
X-Google-Smtp-Source: AGRyM1u3/0hvVVmDLacPPBFeWP8vaAFalfonAP5U/UldSOaNizgt1tCkuWBKHhsyPyl7bj7GKBvrytijQg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:3496:744e:315a:b41b])
 (user=elver job=sendgmr) by 2002:a05:6402:1c09:b0:435:6562:e70d with SMTP id
 ck9-20020a0564021c0900b004356562e70dmr21782463edb.203.1656410338427; Tue, 28
 Jun 2022 02:58:58 -0700 (PDT)
Date:   Tue, 28 Jun 2022 11:58:20 +0200
Message-Id: <20220628095833.2579903-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v2 00/13] perf/hw_breakpoint: Optimize for thousands of tasks
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org, linux-perf-users@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The hw_breakpoint subsystem's code has seen little change in over 10
years. In that time, systems with >100s of CPUs have become common,
along with improvements to the perf subsystem: using breakpoints on
thousands of concurrent tasks should be a supported usecase.

The breakpoint constraints accounting algorithm is the major bottleneck
in doing so:

  1. toggle_bp_slot() and fetch_bp_busy_slots() are O(#cpus * #tasks):
     Both iterate through all CPUs and call task_bp_pinned(), which is
     O(#tasks).

  2. Everything is serialized on a global mutex, 'nr_bp_mutex'.

The series progresses with the simpler optimizations and finishes with
the more complex optimizations:

 1. We first optimize task_bp_pinned() to only take O(1) on average.

 2. Rework synchronization to allow concurrency when checking and
    updating breakpoint constraints for tasks.

 3. Eliminate the O(#cpus) loops in the CPU-independent case.

Along the way, smaller micro-optimizations and cleanups are done as they
seemed obvious when staring at the code (but likely insignificant).

The result is (on a system with 256 CPUs) that we go from:

 | $> perf bench -r 30 breakpoint thread -b 4 -p 64 -t 64
	 	[ ^ more aggressive benchmark parameters took too long ]
 | # Running 'breakpoint/thread' benchmark:
 | # Created/joined 30 threads with 4 breakpoints and 64 parallelism
 |      Total time: 236.418 [sec]
 |
 |   123134.794271 usecs/op
 |  7880626.833333 usecs/op/cpu

... to the following with all optimizations:

 | $> perf bench -r 30 breakpoint thread -b 4 -p 64 -t 64
 |      Total time: 0.067 [sec]
 |
 |       35.292187 usecs/op
 |     2258.700000 usecs/op/cpu

On the used test system, that's an effective speedup of ~3490x per op.

Which is on par with the theoretical ideal performance through
optimizations in hw_breakpoint.c (constraints accounting disabled), and
only 12% slower than no breakpoints at all.

Changelog
---------

v2:
 * Add KUnit test suite.
 * Remove struct bp_busy_slots and simplify functions.
 * Add "powerpc/hw_breakpoint: Avoid relying on caller synchronization".
 * Add "locking/percpu-rwsem: Add percpu_is_write_locked() and percpu_is_read_locked()".
 * Use percpu-rwsem instead of rwlock.
 * Use task_struct::perf_event_mutex instead of sharded mutex.
 * Drop v1 "perf/hw_breakpoint: Optimize task_bp_pinned() if CPU-independent".
 * Add "perf/hw_breakpoint: Introduce bp_slots_histogram".
 * Add "perf/hw_breakpoint: Optimize max_bp_pinned_slots() for CPU-independent task targets".
 * Add "perf/hw_breakpoint: Optimize toggle_bp_slot() for CPU-independent task targets".
 * Apply Acked-by/Reviewed-by given in v1 for unchanged patches.
==> Speedup of ~3490x (vs. ~3315x in v1).

v1: https://lore.kernel.org/all/20220609113046.780504-1-elver@google.com/

Marco Elver (13):
  perf/hw_breakpoint: Add KUnit test for constraints accounting
  perf/hw_breakpoint: Clean up headers
  perf/hw_breakpoint: Optimize list of per-task breakpoints
  perf/hw_breakpoint: Mark data __ro_after_init
  perf/hw_breakpoint: Optimize constant number of breakpoint slots
  perf/hw_breakpoint: Make hw_breakpoint_weight() inlinable
  perf/hw_breakpoint: Remove useless code related to flexible
    breakpoints
  powerpc/hw_breakpoint: Avoid relying on caller synchronization
  locking/percpu-rwsem: Add percpu_is_write_locked() and
    percpu_is_read_locked()
  perf/hw_breakpoint: Reduce contention with large number of tasks
  perf/hw_breakpoint: Introduce bp_slots_histogram
  perf/hw_breakpoint: Optimize max_bp_pinned_slots() for CPU-independent
    task targets
  perf/hw_breakpoint: Optimize toggle_bp_slot() for CPU-independent task
    targets

 arch/powerpc/kernel/hw_breakpoint.c  |  53 ++-
 arch/sh/include/asm/hw_breakpoint.h  |   5 +-
 arch/x86/include/asm/hw_breakpoint.h |   5 +-
 include/linux/hw_breakpoint.h        |   1 -
 include/linux/percpu-rwsem.h         |   6 +
 include/linux/perf_event.h           |   3 +-
 kernel/events/Makefile               |   1 +
 kernel/events/hw_breakpoint.c        | 594 ++++++++++++++++++++-------
 kernel/events/hw_breakpoint_test.c   | 321 +++++++++++++++
 kernel/locking/percpu-rwsem.c        |   6 +
 lib/Kconfig.debug                    |  10 +
 11 files changed, 826 insertions(+), 179 deletions(-)
 create mode 100644 kernel/events/hw_breakpoint_test.c

-- 
2.37.0.rc0.161.g10f37bed90-goog

