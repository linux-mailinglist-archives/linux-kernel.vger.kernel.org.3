Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D143496A15
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 05:58:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232936AbiAVE6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 23:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232871AbiAVE6S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 23:58:18 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB48C06173D
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 20:58:18 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id n2-20020a255902000000b0060f9d75eafeso23411678ybb.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 20:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=JB4PMbLFwwTJE1pVsJg0aZE8Jxxgb6zDQEa9JYUrP8w=;
        b=LEK+9Zv5eOLB9d9pyP4W8eQgSUUnsA9OkP28FB9cxcwnyhyvpQQFytWhIjkntVaJ39
         WpmhKzkFqLx+Us1khMx20SHDCSmYdzwQaKsWy3fM2VueBqxbxa3zAfjSmSC5tm29m0Rk
         r6zkSjyn3m41UZqS5Ua2Un8hSeod4oXUtzp3cVZQsD8zI/+R3HOTOw7OTlWE3TZwe3b0
         sr0IqUAt+o0UL4GghPrLOhoxnPOqLlvDpZ4Hi4BMDyA5XhTIPTf1RfJ/KeG7GfRfNonx
         cRJR4oJ9CU9zb0gxI7FuOMEozh5G358bd7M3ZKFoN9OqFTgNjKXgQ/eTvZgGMxow3DiB
         v+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=JB4PMbLFwwTJE1pVsJg0aZE8Jxxgb6zDQEa9JYUrP8w=;
        b=KmfjkoUoitITVjv2jaZkXHt/VQQDOS5YMmy3AuK69esUnGbT6w9hKxBMVBPeBYgOZp
         /CWxx5WsHzQCjmXN4zJJvawMic3zEuZCoFR6oJYUOFDBH4/lk85MSPa1F55rVw0rkxZh
         Gis3h7/1V4e5+3TBNrROl9wWVVLKsN3S7nzOiKIbPSYu/psariiDo7efJr2qAaZF2uJR
         tnkKu1UNM5/lamdIAWS+2gqFq8siVNYXXUPs4xLngUUlr+36o3yer5onYwGtKEYxsF4F
         FvlElW+pI5+H25Qp/A9RrWwlU+LFpKJpNjHS31qAvTbbfrVju1OGkyab9TgVqfF8yD89
         4zNw==
X-Gm-Message-State: AOAM532707xIorPk+xNZX4TwBCscHdAC9RFVLPjqxonlG+IWKhDM73aV
        JSjjVk5QdbpPRqmDBbAfwA1SHHIGNun7
X-Google-Smtp-Source: ABdhPJxQyhjotp5S/jVWYuSFIkid83dTb+1hQ9M2JVpaSzEKwFVQR37ula1iyGNARV3+l2nKSW1HXSkxEcP+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:6125:f911:aa9a:59ee])
 (user=irogers job=sendgmr) by 2002:a81:6bc2:0:b0:2ca:3398:7d1b with SMTP id
 00721157ae682-2ca33987e3amr17b3.59.1642827497427; Fri, 21 Jan 2022 20:58:17
 -0800 (PST)
Date:   Fri, 21 Jan 2022 20:58:08 -0800
Message-Id: <20220122045811.3402706-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH 0/3] Reference count checker and cpu map related fixes
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        "=?UTF-8?q?Andr=C3=A9=20Almeida?=" <andrealmeid@collabora.com>,
        James Clark <james.clark@arm.com>,
        John Garry <john.garry@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jin Yao <yao.jin@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, Andi Kleen <ak@linux.intel.com>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Song Liu <song@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Miaoqian Lin <linmq006@gmail.com>,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        German Gomez <german.gomez@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eric Dumazet <edumazet@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The first patch is a fix, the second a refactor/cleanup and the third
something of an RFC.

The perf tool has a class of memory problems where reference counts
are used incorrectly. Memory sanitizers and valgrind don't provide
useful ways to debug these problems, you see a memory leak where the
only pertinent information is the original allocation site. What would
be more useful is knowing where a get fails to have a corresponding
put, where there are double puts, etc.

This work was motivated by the roll-back of:
https://lore.kernel.org/linux-perf-users/20211118193714.2293728-1-irogers@google.com/
where fixing a missed put resulted in a use-after-free in a different
context. There was a sense in fixing the issue that a game of
wac-a-mole had been embarked upon in adding missed gets and puts.

The basic approach of the change is to add a level of indirection at
the get and put calls. Get allocates a level of indirection that, if
no corresponding put is called, becomes a memory leak (and associated
stack trace) that leak sanitizer can report. Similarly if two puts are
called for the same get, then a double free can be detected by address
sanitizer. This can also detect the use after put, which should also
yield a segv without a sanitizer.

The patches demonstrates the approach on the reference counted
perf_cpu_map API. The associated struct only has two variables and so
the associated indirection is limited, and the API was recently
refactored and should be fresh of mind. To avoid two APIs the approach
calls the indirection layer perf_cpu_map when in effect. To control
the naming of the struct and the stripping of the indirection macros
are necessary. Patch 3 implements the checker and has diffstats of:
 5 files changed, 146 insertions(+), 74 deletions(-)
The number of files changed is a reflection of the partial move to
libperf of this API and isn't typical. Overall reference count safety
is being added in at a cost of about 72 lines of code, hopefully
demonstrating the approach to be cheap enough that we can repeat it on
the other reference counted structs in perf - albeit that perf_cpu_map
is somewhat unusual in already using lots of accessor functions to
access the struct.

Did the approach spot any bugs? Not really. It did spot that in
perf_cpu_map__merge get was being used for the side-effect of
incrementing a reference count, but not returning the perf_cpu_map the
get returns. Having to be accurate with this kind of behavior is a
frustration of the approach, but it demonstrates the tool works and
for resolving reference count issues I feel it is worth it.

An alternative that was considered was ref_tracker:
 https://lwn.net/Articles/877603/
ref_tracker requires use of a reference counted struct to also use a
cookie/tracker. The cookie is combined with data in a ref_tracker_dir
to spot double puts. When an object is finished with leaks can be
detected, as with this approach when leak analysis happens. This
approach was preferred as it doesn't introduce cookies, spots use
after put and appears moderately more neutral to the API. Weaknesses
of the implemented approcah are not being able to do adhoc leak
detection and a preference for adding an accessor API to structs. I
believe there are other issues, hence the RFC.

Ian Rogers (3):
  perf python: Fix cpu_map__item building
  perf cpumap: Migrate to libperf cpumap api
  perf cpumap: Add reference count checking

 tools/lib/perf/cpumap.c                       | 120 ++++++++++++------
 tools/lib/perf/evsel.c                        |   4 +-
 tools/lib/perf/include/internal/cpumap.h      |  14 +-
 tools/perf/bench/epoll-ctl.c                  |   2 +-
 tools/perf/bench/epoll-wait.c                 |   2 +-
 tools/perf/bench/evlist-open-close.c          |   4 +-
 tools/perf/bench/futex-hash.c                 |   2 +-
 tools/perf/bench/futex-lock-pi.c              |   2 +-
 tools/perf/bench/futex-requeue.c              |   2 +-
 tools/perf/bench/futex-wake-parallel.c        |   2 +-
 tools/perf/bench/futex-wake.c                 |   2 +-
 tools/perf/builtin-ftrace.c                   |   2 +-
 tools/perf/builtin-stat.c                     |   7 +-
 tools/perf/tests/bitmap.c                     |   4 +-
 tools/perf/tests/cpumap.c                     |  20 ++-
 tools/perf/tests/event_update.c               |   8 +-
 tools/perf/tests/mem2node.c                   |   4 +-
 tools/perf/tests/mmap-basic.c                 |   5 +-
 tools/perf/tests/topology.c                   |  37 +++---
 tools/perf/util/auxtrace.c                    |   2 +-
 tools/perf/util/counts.c                      |   2 +-
 tools/perf/util/cpumap.c                      |  42 +++---
 tools/perf/util/cpumap.h                      |   2 +-
 tools/perf/util/cputopo.c                     |   4 +-
 tools/perf/util/evlist-hybrid.c               |  11 +-
 tools/perf/util/evsel.c                       |  20 +--
 tools/perf/util/evsel.h                       |   3 +-
 tools/perf/util/mmap.c                        |   2 +-
 tools/perf/util/perf_api_probe.c              |   4 +-
 tools/perf/util/pmu.c                         |  24 ++--
 tools/perf/util/python.c                      |   6 +-
 tools/perf/util/record.c                      |   6 +-
 .../scripting-engines/trace-event-python.c    |   4 +-
 tools/perf/util/session.c                     |   4 +-
 tools/perf/util/svghelper.c                   |   4 +-
 tools/perf/util/synthetic-events.c            |  18 +--
 tools/perf/util/top.c                         |   6 +-
 37 files changed, 245 insertions(+), 162 deletions(-)

-- 
2.35.0.rc0.227.g00780c9af4-goog

