Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2C3D49BD63
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 21:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbiAYUqJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 15:46:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232437AbiAYUqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 15:46:08 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CBB4C061744
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 12:46:08 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id f12-20020a056902038c00b006116df1190aso43646706ybs.20
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 12:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=anQaSV8wgWDg5PaHVvH5H7QC7YRJVw+zbrdZNKl0Kfs=;
        b=npsJuwb9I37aB0Q6Mqjp/WG5l5nHKIjD6M3hDmED8nNF2zflyxZl1xfy823ytIBpwO
         ny4SWWT9KMoWRH27nEIIorHyHdu93628nEY4oP4j35JoiMYJRr4rJ+0fS0iEVEXYkwX0
         JEDkVAyyZ2mC9y21HpA5J5cGlEcODGCOFF8oBCl6wO2kzBInSdwPKnQaGU5/t1wPFzwS
         o00mVR8VWqzptvG++DLXV0RyhfsrYrU+bvvP9duWRRlim3LVE/j7JMWfYuuvzK/LOkry
         TL/ISFxkvBFoNfD5lw+/Oa1+kptJjt2gLz0QJbm5vfYRQlgKwEj8wJs4KQmFrFuteLFJ
         Bn5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=anQaSV8wgWDg5PaHVvH5H7QC7YRJVw+zbrdZNKl0Kfs=;
        b=ltHk8t1PGMIWFOwGf0iMCbiT8/nQJJEFeBhPR9LZbe38zw72Ra/AO93cFsbtfdB2+G
         61hqOTZHIuuPoqtUNrMfEu8gjdukbPqJmma/FM9zalJbWgLyUCN4zg/h0Rq9MdmmOmfe
         mZ6YMOS4ByLpc/sJgh/oAgF3P0c+5qJDcz9/vJ9/Lo1EzqAmW2ufPkGisys8hRO6fJvA
         hvLQtRpkNGyvT415sp9WNqgoDcUe3ECTssGi+PX974n5JBXTE5dLVKPcJ9Kde/xwe627
         hKl1mE3EHf4TAIEUstWyc9h5yCxL3rfXTFRurFuf3j9tQf57Qbj1QhgTokuQL25p7shS
         WThA==
X-Gm-Message-State: AOAM533AFXxVSYo6zFk5IwMtaXoVy8sydqEuAeF2g+dfSvLygif1rEJv
        RGdsdcQtrOAX41THf3f317vuSBXhx5Bx
X-Google-Smtp-Source: ABdhPJyyDRhsv7XHJfWsMxyNmwOLKL1kswIkIGL+GrM6PewkGCB5ZrnWTQP2teDZpZsUaiqSS4HvbXL8mjD1
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:1a99:924a:8878:c44a])
 (user=irogers job=sendgmr) by 2002:a81:4fd8:0:b0:2ca:287c:6cf2 with SMTP id
 00721157ae682-2cb14269f9emr7357057b3.407.1643143566870; Tue, 25 Jan 2022
 12:46:06 -0800 (PST)
Date:   Tue, 25 Jan 2022 12:45:58 -0800
Message-Id: <20220125204602.4137477-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH v2 0/4] Reference count checker and related fixes
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

This v2 patch set has the main reference count patch for cpu map from
the first set and then adds reference count checking to nsinfo. The
reference count checking on nsinfo helped diagnose a data race bug
which is fixed in the independent patches 2 and 3.

The perf tool has a class of memory problems where reference counts
are used incorrectly. Memory/address sanitizers and valgrind don't
provide useful ways to debug these problems, you see a memory leak
where the only pertinent information is the original allocation
site. What would be more useful is knowing where a get fails to have a
corresponding put, where there are double puts, etc.

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

Adding reference count checking to cpu map was done as a proof of
concept, it yielded little other than a location where the use of get
could be cleaner by using its result. Reference count checking on
nsinfo identified a double free of the indirection layer and the
related threads, thereby identifying a data race as discussed here:
https://lore.kernel.org/linux-perf-users/CAP-5=fWZH20L4kv-BwVtGLwR=Em3AOOT+Q4QGivvQuYn5AsPRg@mail.gmail.com/
Accordingly the dso->lock was extended and use to cover the race.

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
believe there are other issues and welcome suggestions.

Ian Rogers (4):
  perf cpumap: Add reference count checking
  perf dso: Make lock error check and add BUG_ONs
  perf dso: Hold lock when accessing nsinfo
  perf namespaces: Add reference count checking

 tools/lib/perf/cpumap.c                  | 120 ++++++++++-----
 tools/lib/perf/include/internal/cpumap.h |  14 +-
 tools/perf/builtin-inject.c              |   6 +-
 tools/perf/builtin-probe.c               |   2 +-
 tools/perf/tests/cpumap.c                |  20 ++-
 tools/perf/util/build-id.c               |   4 +-
 tools/perf/util/cpumap.c                 |  42 ++---
 tools/perf/util/dso.c                    |  17 ++-
 tools/perf/util/jitdump.c                |  10 +-
 tools/perf/util/map.c                    |   7 +-
 tools/perf/util/namespaces.c             | 187 ++++++++++++++++-------
 tools/perf/util/namespaces.h             |  23 ++-
 tools/perf/util/pmu.c                    |  24 +--
 tools/perf/util/probe-event.c            |   2 +
 tools/perf/util/symbol.c                 |  10 +-
 15 files changed, 337 insertions(+), 151 deletions(-)

-- 
2.35.0.rc0.227.g00780c9af4-goog

