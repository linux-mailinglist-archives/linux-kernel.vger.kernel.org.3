Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FA17544A20
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:31:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243613AbiFILbC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiFILa7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:30:59 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63AF639A647
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:30:58 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id m11-20020a25710b000000b0065d4a4abca1so20093146ybc.18
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jun 2022 04:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=jgek/xbFyP6k/AwYv1XTJdXWbQnAo26L2HOt5DoBXsU=;
        b=Fy1H55PfDYCeMv8rBas4mMZS/7wfUvzeY4alUyUvMTdSV3m3MAHIgl2lhFhM4iqz3P
         YnaeOG+42f2NjxIhArYfXRZSxZonJWpaECkFLRCvTg1F76NCfywWgev/wqpvNYq4Hhwo
         AdtkN0B+vIuRGRU/wnQialrAQTiWXlVD/60uOsII0WFLwboa5gkk6vMW4GvQjOMP5i7E
         gA63ioD8KVexeU0PApbtl5WMaQ4uoZ82otDrNIf4MSwUeY1q0JhvWuBFiDOYPjMHZlSQ
         rKxrnJrlJigxt/xzjjLJLCi+IOankjnEysaeMJ17SLfYsH3lqjGVKvcnmM7DtTaIhjo7
         46AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=jgek/xbFyP6k/AwYv1XTJdXWbQnAo26L2HOt5DoBXsU=;
        b=yKeNQ5K3MQ5j01SLU2IPn0YkUstNSpuGFvyzkSW4XZPRbhBO6JTNrrkCYftrhkvYp5
         DejGUXJPvrzEkpsbN1YBAJTZeQRbRDazpnBNZYDPjNoWpsJdbuDb7AbwuyHNLeceKYwh
         9X1KGNlYlkP4IPYl/EAps82lSng7Z+/Ms9xYj8Fv/+bdO6mjPs/9fo+c6lgzkD98IetM
         htATD4Wk2fW1PNTxIlVEVyJciJhMGF0SCrLcD58+VjLtt5cCT1IYSBvVjZBiOXs9uxI9
         XIx4AOcgdLGpGPHxI2xxnQ0t4AXPDLeCOKKEelPEZCtwO5hRjxbCcIjr+FZI4MWRDx9L
         XPfA==
X-Gm-Message-State: AOAM533Luxqv9rwBc7Obq7eB56jcfKxv+1/nqQtb/yvAByVFV0g5Ui/e
        p6uU9lobmv3FUXL96C2p6JD9I3tN0Q==
X-Google-Smtp-Source: ABdhPJwXl9EhYDUHMoRUsonHSMafUY49HAbhznQ0um7Z0gJyfC6OvtmdmrnCE0gDShvyyDzCT8kDCUNF2w==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:9c:201:dcf:e5ba:10a5:1ea5])
 (user=elver job=sendgmr) by 2002:a05:6902:102c:b0:663:32b8:4b24 with SMTP id
 x12-20020a056902102c00b0066332b84b24mr30477830ybt.1.1654774257606; Thu, 09
 Jun 2022 04:30:57 -0700 (PDT)
Date:   Thu,  9 Jun 2022 13:30:38 +0200
Message-Id: <20220609113046.780504-1-elver@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH 0/8] perf/hw_breakpoint: Optimize for thousands of tasks
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
        linux-perf-users@vger.kernel.org, x86@kernel.org,
        linux-sh@vger.kernel.org, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
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

  1. task_bp_pinned() has been O(#tasks), and called twice for each CPU.

  2. Everything is serialized on a global mutex, 'nr_bp_mutex'.

This series first optimizes task_bp_pinned() to only take O(1) on
average, and then reworks synchronization to allow concurrency when
checking and updating breakpoint constraints for tasks. Along the way,
smaller micro-optimizations and cleanups are done as they seemed obvious
when staring at the code (but likely insignificant).

The result is (on a system with 256 CPUs) that we go from:

 | $> perf bench -r 30 breakpoint thread -b 4 -p 64 -t 64
	 	[ ^ more aggressive benchmark parameters took too long ]
 | # Running 'breakpoint/thread' benchmark:
 | # Created/joined 30 threads with 4 breakpoints and 64 parallelism
 |      Total time: 236.418 [sec]
 |
 |   123134.794271 usecs/op
 |  7880626.833333 usecs/op/cpu

... to -- with all optimizations:

 | $> perf bench -r 30 breakpoint thread -b 4 -p 64 -t 64
 | # Running 'breakpoint/thread' benchmark:
 | # Created/joined 30 threads with 4 breakpoints and 64 parallelism
 |      Total time: 0.071 [sec]
 |
 |       37.134896 usecs/op
 |     2376.633333 usecs/op/cpu

On the used test system, that's an effective speedup of ~3315x per op.

Which is close to the theoretical ideal performance through
optimizations in hw_breakpoint.c -- for reference, constraints
accounting disabled:

 | perf bench -r 30 breakpoint thread -b 4 -p 64 -t 64
 | # Running 'breakpoint/thread' benchmark:
 | # Created/joined 30 threads with 4 breakpoints and 64 parallelism
 |      Total time: 0.067 [sec]
 |
 |       35.286458 usecs/op
 |     2258.333333 usecs/op/cpu

At this point, the current implementation is only ~5% slower than the
theoretical ideal. However, given constraints accounting cannot
realistically be disabled, this is likely as far as we can push it.

Marco Elver (8):
  perf/hw_breakpoint: Optimize list of per-task breakpoints
  perf/hw_breakpoint: Mark data __ro_after_init
  perf/hw_breakpoint: Optimize constant number of breakpoint slots
  perf/hw_breakpoint: Make hw_breakpoint_weight() inlinable
  perf/hw_breakpoint: Remove useless code related to flexible
    breakpoints
  perf/hw_breakpoint: Reduce contention with large number of tasks
  perf/hw_breakpoint: Optimize task_bp_pinned() if CPU-independent
  perf/hw_breakpoint: Clean up headers

 arch/sh/include/asm/hw_breakpoint.h  |   5 +-
 arch/x86/include/asm/hw_breakpoint.h |   5 +-
 include/linux/hw_breakpoint.h        |   1 -
 include/linux/perf_event.h           |   3 +-
 kernel/events/hw_breakpoint.c        | 374 +++++++++++++++++++--------
 5 files changed, 276 insertions(+), 112 deletions(-)

-- 
2.36.1.255.ge46751e96f-goog
