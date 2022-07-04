Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6ACD56593F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:06:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234800AbiGDPGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234742AbiGDPF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:05:59 -0400
Received: from mail-ed1-x549.google.com (mail-ed1-x549.google.com [IPv6:2a00:1450:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370A5FD10
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 08:05:57 -0700 (PDT)
Received: by mail-ed1-x549.google.com with SMTP id z17-20020a05640235d100b0043762b1e1e3so7401898edc.21
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 08:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=vCw+qYcLfEryg0NCqZvoZGaEOfEUqqIfSJ3H2Y/La+U=;
        b=HFp/v8d2JOu2HioOUO0UTDm9Zyhs+v2Kftdg2XX6m5HUrg5WguofD2OUwXCJFmS2t5
         MzJ+MRI0ygIfoJcIf/tMFNJNZbGyjzyrLWGWivMyMHmp8eVi4nsp7ExUK3gmGVz/wyw0
         7U6+cUacp1FI8hB1JqPYKjF6K/yUIZFAuD4PFsJqvZ864ha8FmfiajnGNjREe9ugM/7A
         2bwVpugmtHL2oGjoONBY82pn1ytKFJaNZ1V8XrMgfIf418nJTEtcHiaSuoetYrZep8i9
         0Co/EUanDPBpyvGSg4MjLbGcZRFp1iZpG2VX08sIwcAZPlkaF3A6n4gwMxMPGNYD6Br1
         yaSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=vCw+qYcLfEryg0NCqZvoZGaEOfEUqqIfSJ3H2Y/La+U=;
        b=cQbXfxpi7B72QSSXhC2CLQ1iVyQ1yFCGGjuVx/truBJe8qf9CXEwzF3Kw0ZNSpBg4T
         Pj2dtiqE6c8OPGegxllWL9WuvnsonI37iPZwSGTB9cQsSIEzjBX59KG13borJbN9LkNr
         3aHBjTWjnJ7ufMLDTUmgzJ3OuqvJ4/Gofr+IDlvnuhnsNWWAf5pQ0PjgkQOgYM5eAk/2
         y3HpcttoVHiorQmOa1hx7H8IkOrud/1ifkgHVSGV9Yo13M9Ob7WnfymFVn69N4OCpvXx
         4A8IMrCveqTwDt7mJ9SY12w/utizwIWJxDSEwAbI072HSGfZzJWwd3JxP08yL8VnV/y0
         IVCg==
X-Gm-Message-State: AJIora+EIiATbdiIBFFXspPQ5Qa0HLQOcH87ViOXQku/ae2nn52NzLc/
        J7O8u2dGyiXIFYRgs6azO2VD+FemPw==
X-Google-Smtp-Source: AGRyM1vcv+ey9wUHmm7mpO7HIaPskiyQmKiaXY4E4O4MknYpkUaDhKf/gg5exg6tZAXZRBybUUWCEVO2Hg==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:6edf:e1bc:9a92:4ad0])
 (user=elver job=sendgmr) by 2002:a17:906:9b86:b0:6f8:24e7:af7d with SMTP id
 dd6-20020a1709069b8600b006f824e7af7dmr29696674ejc.295.1656947155542; Mon, 04
 Jul 2022 08:05:55 -0700 (PDT)
Date:   Mon,  4 Jul 2022 17:05:00 +0200
Message-Id: <20220704150514.48816-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v3 00/14] perf/hw_breakpoint: Optimize for thousands of tasks
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

v3:
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
2.37.0.rc0.161.g10f37bed90-goog

