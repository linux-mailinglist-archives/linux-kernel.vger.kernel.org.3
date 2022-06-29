Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3A7F560900
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 20:25:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229774AbiF2SZe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 14:25:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiF2SZc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:25:32 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 457392982A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 11:25:31 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-317b6ecba61so132802227b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 11:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=1f0Ur6hbGyTYzxP4DvfGWl44AJTfod6EaR5IYzCVFo4=;
        b=tOoS6bbd/0Ckdjf3fUN9LHcpnfnrZf1cuEgEb8U6NMdaeoo3m6AcP5/ZsqFJk0mWPd
         gkn/0GGkbrvYcnYCGIauJfpVdxs3BT8FuMDBoSh86dg/XV3fFjIpuHg/hNo1ZPHEgVSN
         Jzxog92KnO6NOwEtKY7WN5rDk6VTXDkyETvGNnxjl8fEIQQVGuHqTvI5tb7KXr6Y/mt8
         SELiyHcw3PSGPfCZnNFvrw4cdBRy10f3oqGdfiRjw2niWUbtMfh3dBgaxrnVlkoHLzWC
         ej1pbtNrXWjf7njSHMa0PcZqTDAzk6GTuhobAQfy+g/f8oj0UiAuZl5G7o/I4z+gw60f
         OxFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=1f0Ur6hbGyTYzxP4DvfGWl44AJTfod6EaR5IYzCVFo4=;
        b=3w7ZqeGqD9p181yS1Nzq2wzpwxwjyxwHdgxj/n05W+kAShGQIPq7+WubJwDlv7AH6J
         phWcNNBQE6v3BkrRxlPseFojqApQ8HZAGTTD6XCOIzMbCNk38TSpTo3etpQSePwPBpXc
         9kKjp/22/922tEKXsvntJL18RvSq8tQHy6XcmwFsQRhiZYUH10/NWNKp+KdyTgv+ltxx
         e0LeUrmnijm2yWUBKJKl8HJIM6ClHq57E2ukxrkq6f4DC1c0LdjBRlX0CudRXGaAsu+0
         mkXaTa1xhcte5fAMnl2IJbWgNoa/9yG5gq1ASbD7fMUBx2h6i4uwKdcDhJO5RPvFDu5F
         pP4g==
X-Gm-Message-State: AJIora++010qTJiWc9l0i+4FvZMCPCpH2y8qpzZDwZmo2qDU+mRz8/4z
        Z61Yz3Dlt7WUOGfgOWRb6TAacn/COixf
X-Google-Smtp-Source: AGRyM1tE0QYu5xftU0kl9VWEzzxD6BkZj/8WgT0dTjS8P4XcNOoJyoarGWwbUmLqEjKpKr6Bms2W2lQ8nsFp
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:f5a1:84fb:df7d:bd89])
 (user=irogers job=sendgmr) by 2002:a25:5c5:0:b0:66c:b809:ddde with SMTP id
 188-20020a2505c5000000b0066cb809dddemr4885032ybf.67.1656527130312; Wed, 29
 Jun 2022 11:25:30 -0700 (PDT)
Date:   Wed, 29 Jun 2022 11:25:01 -0700
Message-Id: <20220629182505.406269-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v7 0/4] Rewrite jevents program in python
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Felix Fietkau <nbd@nbd.name>, Qi Liu <liuqi115@huawei.com>,
        Like Xu <likexu@tencent.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Nick Forrington <nick.forrington@arm.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        James Clark <james.clark@arm.com>,
        Andrew Kilroy <andrew.kilroy@arm.com>,
        "Paul A . Clarke" <pc@us.ibm.com>, Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        ananth.narayan@amd.com, ravi.bangoria@amd.com,
        santosh.shukla@amd.com, sandipan.das@amd.com,
        Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
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

New architectures bring new complexity, such as Intel's hybrid
models. jevents provides an alternative to specifying events in the
kernel and exposing them through sysfs, however, it is difficult to
work with. For example, an error in the json input would yield an
error message but no json file or location. It is also a challenge to
update jsmn.c given its forked nature.

The changes here switch from jevents.c to a rewrite in python called
jevents.py. This means there is a build time dependency on python, but
such a dependency already exists for asciidoc (used to generate perf's
man pages). If the build detects that python isn't present or is older
than version 3.6 (released Dec. 2016) then an empty file is
substituted for the generated one.

A challenge with this code is in avoiding regressions. For this reason
the jevents.py produces identical output to jevents.c, validated with a
test script and build target.

v7. Adds Tested-by from John Garry <john.garry@huawei.com>.
v6. Adds Tested-by from Zhengjun Xing <zhengjun.xing@linux.intel.com>
    and Thomas Richter <tmricht@linux.ibm.com>. Fixes issues spotted
    by Jiri Olsa <jolsa@kernel.org>, jsmn.c wasn't deleted and the
    empty pmu-events.c didn't pass the pmu-events test. It also adds a
    missing mkdir which is necessary before creating pmu-events.c and
    tweaks the quiet display code in the empty case to display a gen.
v5. Adds a 2>/dev/null as suggested by David Laight
    <David.Laight@aculab.com>.
v4. Fixes the build for systems with python2 installed by adding a
    patch that makes python3 the preferred python (Reported-by: John
    Garry <john.garry@huawei.com>). It also fixes a bash-ism in the
    jevents-test.sh and fixes the handling of an empty string for a
    metric BriefDescription as one was added for sapphirerapids in the
    metric Execute.
v3. Updates the patches for merged changes (on
    acme/tmp.perf/core). Re-runs all comparisons to make sure the
    generated pmu-events.c isn't altered at all by this change. Adds
    the jevents.c ExtSel fix in:
    https://lore.kernel.org/lkml/20220525140410.1706851-1-zhengjun.xing@linux.intel.com/
    Bumps the python version from 3.5 to 3.6, as f-strings weren't
    introduced until 3.6.
v2. Fixes the build for architectures that don't have pmu-events json
    (Suggested-by: John Garry <john.garry@huawei.com>) and fixes the
    build for python not being present or too old (Suggested-by: Peter
    Zijlstra <peterz@infradead.org>/John Garry <john.garry@huawei.com>).

Ian Rogers (4):
  perf python: Prefer python3
  perf jevents: Add python converter script
  perf jevents: Switch build to use jevents.py
  perf jevents: Remove jevents.c

 tools/perf/Makefile.config               |   27 +-
 tools/perf/Makefile.perf                 |   16 +-
 tools/perf/pmu-events/Build              |   17 +-
 tools/perf/pmu-events/empty-pmu-events.c |  158 +++
 tools/perf/pmu-events/jevents.c          | 1342 ----------------------
 tools/perf/pmu-events/jevents.py         |  409 +++++++
 tools/perf/pmu-events/jsmn.c             |  352 ------
 tools/perf/pmu-events/jsmn.h             |   68 --
 tools/perf/pmu-events/json.c             |  162 ---
 tools/perf/pmu-events/json.h             |   39 -
 10 files changed, 604 insertions(+), 1986 deletions(-)
 create mode 100644 tools/perf/pmu-events/empty-pmu-events.c
 delete mode 100644 tools/perf/pmu-events/jevents.c
 create mode 100755 tools/perf/pmu-events/jevents.py
 delete mode 100644 tools/perf/pmu-events/jsmn.c
 delete mode 100644 tools/perf/pmu-events/jsmn.h
 delete mode 100644 tools/perf/pmu-events/json.c
 delete mode 100644 tools/perf/pmu-events/json.h

-- 
2.37.0.rc0.161.g10f37bed90-goog

