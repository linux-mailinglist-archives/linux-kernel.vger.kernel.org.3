Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC6975968BE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 07:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238402AbiHQFjj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 01:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238385AbiHQFjg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 01:39:36 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F1DF4D255
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 22:39:35 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-3344aa7e79aso41301607b3.23
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 22:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=ay7C3qxUv6wm2M5yxAB5RjaZvJl34dFW/a2TS0G4SVk=;
        b=btnq2puhvjoxHQHAy1baE77P6/KtF8feSe92/mRaRlqRRfJyTt4wzScjpvRrg71Cr8
         ytASsBkMV4g5uik8SYrXsVCpTOfmwaZ/fbOYRZQDp/SsdYajvCcSGYNk3d+Z94wRlXYl
         W4dYlfgiC8mM/W7RiqR7D9Yiu5swke91StU5P/ESOiDc60cVLzkjaB2VdJ98EbqoeVWR
         D4T8xqWx2PxP9dVZ36HlzCFiYeaWSpEf1ba+jKPVfPpB/5symWSETmagL7w5P0GBxub9
         uBBJgVAvsjPLhbjC9DPhYff5uKhx5UxVs7lrPYJP6IVXNHLRpNt1jUde2E7oxo0TaST5
         nAQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=ay7C3qxUv6wm2M5yxAB5RjaZvJl34dFW/a2TS0G4SVk=;
        b=sS6osNbwLdtEr2bOv8qmFM9RdPmyYOk6kMbg2AKsFjCW8Hs9bk/tAIn/A9tI+EQO+W
         87EGAquwlpd4TbgmCcvSw0k75jsxRa1DMNLabTvZz3um87CTWOnVBW7S/BRUFjHdyCKF
         QTQHkTX+eyALgTYunaBvb4mTMzRGT/KYrwvTTQBa7GAaIJdfA2QjSp7GZTvgB+FJ7oLb
         VZ0WLWSnL0ABk9egLyphWMUO30GmF3ICEFFpyr/VMpJqufBTZurRovqohcldVMTCtk36
         pBpqXlnUqqsF6yMhefQnLceT6QpN2zjaSFjyRgHWLmhUzImDoJSnAzKay3s3BwodRlYb
         w0hA==
X-Gm-Message-State: ACgBeo3OvlmsMfTL9yHuBf9s8baBH3Wpa9GvcwvkH9dwM4uVZyunYt09
        2/8jsLwu5BPahGFVsldHw7fQrHjX36QK
X-Google-Smtp-Source: AA6agR5/TuzIKPRvq9d6k2zC4Z/3B5xJV9wBXC8x3j+A2e24n1pFKzFGPTqkgN21/Upp/uI3FRsF9s4PNbsC
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:3bec:858f:9a6d:63de])
 (user=irogers job=sendgmr) by 2002:a25:ac10:0:b0:690:a94a:97eb with SMTP id
 w16-20020a25ac10000000b00690a94a97ebmr745776ybi.592.1660714774662; Tue, 16
 Aug 2022 22:39:34 -0700 (PDT)
Date:   Tue, 16 Aug 2022 22:39:24 -0700
Message-Id: <20220817053930.769840-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v1 0/6] Mutex wrapper, locking and memory leak fixes
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@igalia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Weiguo Li <liwg06@foxmail.com>,
        Pavithra Gurushankar <gpavithrasha@gmail.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Dario Petrillo <dario.pk1@gmail.com>,
        Wenyu Liu <liuwenyu7@huawei.com>,
        Hewenliang <hewenliang4@huawei.com>,
        yaowenbin <yaowenbin1@huawei.com>,
        Dave Marchevsky <davemarchevsky@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexandre Truong <alexandre.truong@arm.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Leo Yan <leo.yan@linaro.org>,
        Quentin Monnet <quentin@isovalent.com>,
        William Cohen <wcohen@redhat.com>,
        Andres Freund <andres@anarazel.de>,
        Song Liu <songliubraving@fb.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "=?UTF-8?q?Martin=20Li=C5=A1ka?=" <mliska@suse.cz>,
        Colin Ian King <colin.king@intel.com>,
        James Clark <james.clark@arm.com>,
        Fangrui Song <maskray@google.com>,
        Stephane Eranian <eranian@google.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zechuan Chen <chenzechuan1@huawei.com>,
        Jason Wang <wangborong@cdjrlc.com>,
        Lexi Shao <shaolexi@huawei.com>,
        Remi Bernon <rbernon@codeweavers.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        llvm@lists.linux.dev
Cc:     Ian Rogers <irogers@google.com>
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

When fixing a locking race and memory leak in:
https://lore.kernel.org/linux-perf-users/20211118193714.2293728-1-irogers@google.com/

It was requested that debug mutex code be separated out into its own
files. This was done by Pavithra Gurushankar in:
https://lore.kernel.org/lkml/20220727111954.105118-1-gpavithrasha@gmail.com/

These patches fix issues with the previous patches, add in the
original dso->nsinfo fix and then build on our mutex wrapper with
clang's -Wthread-safety analysis. The analysis found missing unlocks
in builtin-sched.c which are fixed and -Wthread-safety is enabled by
default when building with clang.

Ian Rogers (4):
  perf dso: Hold lock when accessing nsinfo
  perf mutex: Add thread safety annotations
  perf mutex: Fix thread safety analysis
  perf build: Enable -Wthread-safety with clang

Pavithra Gurushankar (2):
  perf mutex: Wrapped usage of mutex and cond
  perf mutex: Update use of pthread mutex/cond

 tools/perf/Makefile.config                 |   5 +
 tools/perf/bench/epoll-ctl.c               |  33 +++----
 tools/perf/bench/epoll-wait.c              |  33 +++----
 tools/perf/bench/futex-hash.c              |  33 +++----
 tools/perf/bench/futex-lock-pi.c           |  33 +++----
 tools/perf/bench/futex-requeue.c           |  33 +++----
 tools/perf/bench/futex-wake-parallel.c     |  33 +++----
 tools/perf/bench/futex-wake.c              |  33 +++----
 tools/perf/bench/numa.c                    |  93 +++++++-----------
 tools/perf/builtin-inject.c                |   4 +
 tools/perf/builtin-lock.c                  |   1 -
 tools/perf/builtin-record.c                |  13 ++-
 tools/perf/builtin-sched.c                 |  75 ++++++++-------
 tools/perf/builtin-top.c                   |  45 ++++-----
 tools/perf/tests/mmap-basic.c              |   2 -
 tools/perf/tests/openat-syscall-all-cpus.c |   2 +-
 tools/perf/tests/perf-record.c             |   2 -
 tools/perf/ui/browser.c                    |  20 ++--
 tools/perf/ui/browsers/annotate.c          |  12 +--
 tools/perf/ui/setup.c                      |   5 +-
 tools/perf/ui/tui/helpline.c               |   5 +-
 tools/perf/ui/tui/progress.c               |   8 +-
 tools/perf/ui/tui/setup.c                  |   8 +-
 tools/perf/ui/tui/util.c                   |  18 ++--
 tools/perf/ui/ui.h                         |   4 +-
 tools/perf/util/Build                      |   1 +
 tools/perf/util/annotate.c                 |  15 +--
 tools/perf/util/annotate.h                 |   4 +-
 tools/perf/util/bpf-event.h                |   1 -
 tools/perf/util/build-id.c                 |  12 ++-
 tools/perf/util/dso.c                      |  19 ++--
 tools/perf/util/dso.h                      |   4 +-
 tools/perf/util/hist.c                     |   6 +-
 tools/perf/util/hist.h                     |   4 +-
 tools/perf/util/map.c                      |   3 +
 tools/perf/util/mmap.h                     |   1 -
 tools/perf/util/mutex.c                    |  99 +++++++++++++++++++
 tools/perf/util/mutex.h                    | 105 +++++++++++++++++++++
 tools/perf/util/probe-event.c              |   3 +
 tools/perf/util/symbol.c                   |   4 +-
 tools/perf/util/top.h                      |   5 +-
 41 files changed, 529 insertions(+), 310 deletions(-)
 create mode 100644 tools/perf/util/mutex.c
 create mode 100644 tools/perf/util/mutex.h

-- 
2.37.1.595.g718a3a8f04-goog

