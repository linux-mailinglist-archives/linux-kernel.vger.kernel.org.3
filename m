Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8F3B4B233A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 11:36:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348956AbiBKKea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 05:34:30 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244145AbiBKKeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 05:34:21 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB958EA8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:34:20 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id a88-20020a25a1e1000000b00615c588ab22so18035221ybi.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 02:34:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=B464xe9sanuCkUdSAgAbRa9cIl7UmZX/F8ddhiHNQ94=;
        b=c2QD8es5g2+0xpisqEsymRiUDvZlpK8pqAPbTyFCslLXMucQxoiFVoIT2w8OJFS+nN
         IsbwXWcOkBQ3Fc0TPK9XdRFRVDW84JIN19xGVDJl7w45mkIjoWzotWpqFIZtZMi/uWQP
         L++1n4mwS9Hy75B1B0mQU9If9hKDb4UWOZH24kLccQeaVR2GYeRcsvj2w9yQg8U6z/+w
         DmknnKSH99lUGf380/1812+RRBK+UzZLQ+ZPrvluAnnXtgBHcyayffKlhsj1yV8NQtPP
         kZvbbfJvR8zMRGXnzGA757yVeAkpwwVqKDrpzrODSbc7HnQ1n6ohqmW90rg+EbbW9Ap+
         MFNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=B464xe9sanuCkUdSAgAbRa9cIl7UmZX/F8ddhiHNQ94=;
        b=beUxmoQydPcGrtDPMdWEtkLSV0q4rpOCekiEOQQjzrlM7XHOyKHzEFC2ILddRZfIMl
         gDZEK8j93zfTDfxPFMSB+zushzimwEDKtDQ6a4Isk4rRITabqhvENPON6uipI9m/aC/z
         nc7lrwjaZ/MNeb23M1nN+aJ/v7QMMomEDdVU2+dRvv7O7W5jjBIIQaQI4o9ffkgzMVRa
         YOoPSUxXOP7pkSn04tk5IIq2NJVWnNzHmtsdzsfura9JAR3Fp5F3/V4tqJm0OacgmenC
         pdjfKn3/xvQu3bjQKOVpi7GCCwEGFVM4MYzN/Cu0/YipY19CkipnYlWt7Md2IFwYCLlw
         P/bg==
X-Gm-Message-State: AOAM530jeFgOg8kxQV+q9wBaM2o1m50F0ESAf4D4OLXO6MfWdlLBSASX
        FBRvvDLYE+STt3iRoaG15pVKME66nWhJ
X-Google-Smtp-Source: ABdhPJyGjdPw24dh7MOrdvEJpAMjETNHbpZUzNClSzM+DkET/7p3D2jMtL5UO4WEtbW3bbayFa5fzi6NxXvV
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:2d98:3ad9:1d8a:fb9b])
 (user=irogers job=sendgmr) by 2002:a25:6c6:: with SMTP id 189mr744294ybg.436.1644575660069;
 Fri, 11 Feb 2022 02:34:20 -0800 (PST)
Date:   Fri, 11 Feb 2022 02:33:53 -0800
Message-Id: <20220211103415.2737789-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.265.g69c8d7142f-goog
Subject: [PATCH v3 00/22] Reference count checker and related fixes
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
        Dmitry Vyukov <dvyukov@google.com>, Hao Luo <haoluo@google.com>
Cc:     eranian@google.com, Ian Rogers <irogers@google.com>
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

The v3 version addresses problems in v2, in particular using macros to
avoid #ifdefs. The v3 version applies the reference count checking
approach to two more data structures, maps and map. While maps was
straightforward, struct map showed a problem where reference counted
thing can be on lists and rb-trees that are oblivious to the
reference count. To sanitize this, struct map is changed so that it is
referenced by either a list or rb-tree node and not part of it. This
simplifies the reference count and the patches have caught and fixed a
number of missed or mismatched reference counts relating to struct
map.

The patches are arranged so that API refactors and bug fixes appear
first, then the reference count checker itself appears. This allows
for the refactor and fixes to be applied upstream first, as has
already happened with cpumap.

A wider discussion of the approach is on the mailing list:
 https://lore.kernel.org/linux-perf-users/YffqnynWcc5oFkI5@kernel.org/T/#mf25ccd7a2e03de92cec29d36e2999a8ab5ec7f88
Comparing it to a past approach:
 https://lore.kernel.org/all/20151209021047.10245.8918.stgit@localhost.localdomain/
and to ref_tracker:
 https://lwn.net/Articles/877603/

Ian Rogers (22):
  perf cpumap: Migrate to libperf cpumap api
  perf cpumap: Use for each loop
  perf dso: Make lock error check and add BUG_ONs
  perf dso: Hold lock when accessing nsinfo
  perf maps: Use a pointer for kmaps
  perf test: Use pointer for maps
  perf maps: Reduce scope of init and exit
  perf maps: Move maps code to own C file
  perf map: Add const to map_ip and unmap_ip
  perf map: Make map__contains_symbol args const
  perf map: Move map list node into symbol
  perf maps: Remove rb_node from struct map
  perf namespaces: Add functions to access nsinfo
  perf maps: Add functions to access maps
  perf map: Use functions to access the variables in map
  perf test: Add extra diagnostics to maps test
  perf map: Changes to reference counting
  libperf: Add reference count checking macros.
  perf cpumap: Add reference count checking
  perf namespaces: Add reference count checking
  perf maps: Add reference count checking.
  perf map: Add reference count checking

 tools/lib/perf/cpumap.c                       |  93 +--
 tools/lib/perf/include/internal/cpumap.h      |   4 +-
 tools/lib/perf/include/internal/rc_check.h    |  94 +++
 tools/perf/arch/s390/annotate/instructions.c  |   4 +-
 tools/perf/arch/x86/tests/dwarf-unwind.c      |   2 +-
 tools/perf/arch/x86/util/event.c              |  15 +-
 tools/perf/builtin-annotate.c                 |   8 +-
 tools/perf/builtin-inject.c                   |  14 +-
 tools/perf/builtin-kallsyms.c                 |   6 +-
 tools/perf/builtin-kmem.c                     |   4 +-
 tools/perf/builtin-mem.c                      |   4 +-
 tools/perf/builtin-probe.c                    |   2 +-
 tools/perf/builtin-report.c                   |  26 +-
 tools/perf/builtin-script.c                   |  26 +-
 tools/perf/builtin-top.c                      |  16 +-
 tools/perf/builtin-trace.c                    |   2 +-
 .../scripts/python/Perf-Trace-Util/Context.c  |  14 +-
 tools/perf/tests/code-reading.c               |  32 +-
 tools/perf/tests/cpumap.c                     |  14 +-
 tools/perf/tests/hists_common.c               |   4 +-
 tools/perf/tests/hists_cumulate.c             |  14 +-
 tools/perf/tests/hists_filter.c               |  14 +-
 tools/perf/tests/hists_link.c                 |  18 +-
 tools/perf/tests/hists_output.c               |  12 +-
 tools/perf/tests/maps.c                       |  87 ++-
 tools/perf/tests/mmap-thread-lookup.c         |   3 +-
 tools/perf/tests/thread-maps-share.c          |  29 +-
 tools/perf/tests/vmlinux-kallsyms.c           |  56 +-
 tools/perf/ui/browsers/annotate.c             |   7 +-
 tools/perf/ui/browsers/hists.c                |  21 +-
 tools/perf/ui/browsers/map.c                  |   4 +-
 tools/perf/util/Build                         |   1 +
 tools/perf/util/annotate.c                    |  38 +-
 tools/perf/util/auxtrace.c                    |   2 +-
 tools/perf/util/block-info.c                  |   4 +-
 tools/perf/util/bpf-event.c                   |  10 +-
 tools/perf/util/build-id.c                    |   6 +-
 tools/perf/util/callchain.c                   |  28 +-
 tools/perf/util/cpumap.c                      |  36 +-
 tools/perf/util/data-convert-json.c           |   4 +-
 tools/perf/util/db-export.c                   |  16 +-
 tools/perf/util/dlfilter.c                    |  29 +-
 tools/perf/util/dso.c                         |  21 +-
 tools/perf/util/event.c                       |  30 +-
 tools/perf/util/evsel_fprintf.c               |   4 +-
 tools/perf/util/hist.c                        |  22 +-
 tools/perf/util/intel-pt.c                    |  48 +-
 tools/perf/util/jitdump.c                     |  10 +-
 tools/perf/util/machine.c                     | 252 ++++---
 tools/perf/util/machine.h                     |   8 +-
 tools/perf/util/map.c                         | 629 ++++--------------
 tools/perf/util/map.h                         |  80 ++-
 tools/perf/util/maps.c                        | 475 +++++++++++++
 tools/perf/util/maps.h                        |  69 +-
 tools/perf/util/namespaces.c                  | 158 +++--
 tools/perf/util/namespaces.h                  |  13 +-
 tools/perf/util/pmu.c                         |  18 +-
 tools/perf/util/probe-event.c                 |  58 +-
 .../util/scripting-engines/trace-event-perl.c |   9 +-
 .../scripting-engines/trace-event-python.c    |  14 +-
 tools/perf/util/sort.c                        |  48 +-
 tools/perf/util/symbol-elf.c                  |  59 +-
 tools/perf/util/symbol.c                      | 280 +++++---
 tools/perf/util/symbol_fprintf.c              |   2 +-
 tools/perf/util/synthetic-events.c            |  34 +-
 tools/perf/util/thread-stack.c                |   4 +-
 tools/perf/util/thread.c                      |  40 +-
 tools/perf/util/unwind-libunwind-local.c      |  50 +-
 tools/perf/util/unwind-libunwind.c            |  34 +-
 tools/perf/util/vdso.c                        |   7 +-
 70 files changed, 1941 insertions(+), 1358 deletions(-)
 create mode 100644 tools/lib/perf/include/internal/rc_check.h
 create mode 100644 tools/perf/util/maps.c

-- 
2.35.1.265.g69c8d7142f-goog

