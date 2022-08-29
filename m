Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF775A4CA5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:57:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbiH2M4m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230180AbiH2M4W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:56:22 -0400
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABA6B61DA5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:47:59 -0700 (PDT)
Received: by mail-ej1-x64a.google.com with SMTP id he38-20020a1709073da600b0073d98728570so2272936ejc.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc;
        bh=j9ioItL4hhuJk4q9fk8sTyuu8wzwxxiWo3yP0IVLpNU=;
        b=AEnnVlL+h99/eKY9FemzwOrgccR12Jm4H4toAg74fK8miA6B3P/wnQ9dHViXDfjGzk
         ANkIB1hemSKQ3ljjNM/gULvEHMbqdJYVFSEzMHzllccZ0ofvmU5+VZHzKeLCfELED6Qj
         RR8s3QNCww1xK8wOiHRz9LELswrYqjd11/S5Oip28P1mVWMZhkV+RHRbvShSHTnXRhMi
         a2hcxSSmbuOpzQpzKF4ICIywQDmWpyyZOmCak2PyU5NgzAaQda19CStINl3UHgJ9iH2z
         SoLIdtxeVlesKAYOKzA8ZHZvFWBiyrLd4rx48tk172r91N8we+kweSXjcf74iNZcHwm+
         C+VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc;
        bh=j9ioItL4hhuJk4q9fk8sTyuu8wzwxxiWo3yP0IVLpNU=;
        b=r3W/R3vkpiJsXjS+Fd6p8S+0Y2PD3eUBQyj6bMp74XPMVh9fZTdBD8KecK7FZmdw+V
         /5YR9Nw9TdbOhtWOKoGJQm/ykZiRTGCyvlYtiIu/zd591rqTELKGo4Z0fiKJsxpjGXSJ
         JHamguisxYUt2m6Psky2Ptb/qvil3ILMigO4XGYV+w1JzelIIeTH+ddvS8kX8BhgU3vV
         1Xxwt8bMeB5ZDZ+Ckjwjno1Y6qgMiEw6PrMbJP3j9WyvIjO1Ato3e3ShL3hTzUPqBDtd
         DP6M79NZxth9LCG1F8uFjIgRhqCWsZa8s9carzA/GirQMKn+fZorn/KpEr0D9vAF7TGe
         Byxw==
X-Gm-Message-State: ACgBeo0dltdzQCvccSFVeirEc7LKjufPrYeOSmFf+UtlxqcV5Y5woSyd
        v8NZ/+6frFu+18DN6UMBZEE21t0GXw==
X-Google-Smtp-Source: AA6agR5Vdd0EgFTNBuEB47wo2RfngI2ORjHWVJ+Z6x1a1VnVBpwvw2x0IZ4vXzPFklVTTTPIZTwL4NPoCw==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:196d:4fc7:fa9c:62e3])
 (user=elver job=sendgmr) by 2002:a05:6402:350e:b0:448:4918:af81 with SMTP id
 b14-20020a056402350e00b004484918af81mr6393841edd.384.1661777278181; Mon, 29
 Aug 2022 05:47:58 -0700 (PDT)
Date:   Mon, 29 Aug 2022 14:47:05 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220829124719.675715-1-elver@google.com>
Subject: [PATCH v4 00/14] perf/hw_breakpoint: Optimize for thousands of tasks
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
        autolearn=ham autolearn_force=no version=3.4.6
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
 | # Running 'breakpoint/thread' benchmark:
 | # Created/joined 30 threads with 4 breakpoints and 64 parallelism
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

v4:
* Fix percpu_is_read_locked(): Due to spurious read_count increments in
  __percpu_down_read_trylock() if sem->block != 0, check that
  !sem->block (reported by Peter).
* Apply Reviewed/Acked-by.

v3: https://lkml.kernel.org/r/20220704150514.48816-1-elver@google.com
* Fix typos.
* Introduce hw_breakpoint_is_used() for the test.
* Add WARN_ON in bp_blots_histogram_add().
* Don't use raw_smp_processor_id() in test.
* Apply Acked-by/Reviewed-by given in v2 for mostly unchanged patches.


v2: https://lkml.kernel.org/r/20220628095833.2579903-1-elver@google.com
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

Marco Elver (14):
  perf/hw_breakpoint: Add KUnit test for constraints accounting
  perf/hw_breakpoint: Provide hw_breakpoint_is_used() and use in test
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
 include/linux/hw_breakpoint.h        |   4 +-
 include/linux/percpu-rwsem.h         |   6 +
 include/linux/perf_event.h           |   3 +-
 kernel/events/Makefile               |   1 +
 kernel/events/hw_breakpoint.c        | 638 ++++++++++++++++++++-------
 kernel/events/hw_breakpoint_test.c   | 333 ++++++++++++++
 kernel/locking/percpu-rwsem.c        |   6 +
 lib/Kconfig.debug                    |  10 +
 11 files changed, 885 insertions(+), 179 deletions(-)
 create mode 100644 kernel/events/hw_breakpoint_test.c

-- 
2.37.2.672.g94769d06f0-goog
