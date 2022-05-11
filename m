Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E054522CB8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 09:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242478AbiEKHBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 03:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242416AbiEKHBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 03:01:41 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D45E56405
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:01:38 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f4dfd09d7fso10472077b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 00:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=NAsDtBmU2OgI3N2OOYVSrhImShkhZd5HyHIxRIc0E/4=;
        b=U8RCrW8+Yjn/wgcQOIYzzbAstXL9qyLNQ2FILySewotlZ1IO849+9WLjTbiNuCX8Er
         Ij9OQ35Qp20XpJUf6mROtP5zM+ndT6BOTe7nK5AQtUvfSm9XxSPuBW5mCTh9t4JWk98J
         Q4FmNAc/r0Z0FhOeFM+b8unLyApQCsb96U2/uM5emYaD5Dfh9XEcPSnyFAa2VZJi6YHU
         Cda0T9KALbpdEUAVtOV6BIHCMDE0UHkK1mer694Uqf9ekzKCkyWmudaj39y+I82o9FRM
         XAKOJnMKuJstgcdJ2bP1ImVc/X/mYPff0JvAuzgVtCXJE3Jw2DEW7HypOlNZnvDIZAsH
         F3WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=NAsDtBmU2OgI3N2OOYVSrhImShkhZd5HyHIxRIc0E/4=;
        b=f3SjHlP1vIeM2TPF23iv7T8GNpHO/LP2Vba6+oupY3yehxr26aq88yRVUhxljIke75
         1yhtsfBzNQ1TYS7edux5F7OUDIkw6ZUpBrxONnyDydeEJBTCYKnZTD/fXhXluUjfHTb7
         AJGI6DLm50zxQguNlznbzvll8KBmBHSB9xiqKm9jiHHDf7OCItwqtgrjAse6LD9M3RbV
         2FkqpJvAhctxnRH1XnXWGCqEKWq9AMGYRadjMrMbSG1xDoyQAY5XyxubLkSD4iA/xgPC
         IIXDyqjQ6INzjz0uTTqHBhWfMMBpB/gO7amkve/p1ETwndtp/8Q4aw9NaNJ6x7fDbQtY
         UYrQ==
X-Gm-Message-State: AOAM532uolNNyxYGge79MFmkEb3tefDJfzm+tv5TaxEQ09k0dGgEC+cC
        gFSSigpQctpu2P0O6yna7uIHVFUg0GSS
X-Google-Smtp-Source: ABdhPJwU4Jwffn6g4l/pH1fEXk9F+avTtorT4Pqr2TpYmFkYs0lyFCsfgyeFFaXwvAabbMAnregKh0qs2tlf
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:b6c9:16a6:f912:39d5])
 (user=irogers job=sendgmr) by 2002:a0d:edc7:0:b0:2f8:f300:df2b with SMTP id
 w190-20020a0dedc7000000b002f8f300df2bmr23506929ywe.515.1652252497609; Wed, 11
 May 2022 00:01:37 -0700 (PDT)
Date:   Wed, 11 May 2022 00:01:26 -0700
Message-Id: <20220511070133.710721-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH 0/7] Rewrite jevents program in python
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
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED,
        USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.6
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
man pages).

A challenge with this code is in avoiding regressions. For this reason
the jevents.py produces identical output to jevents.c, validated with a
test script and build target.

A difference in the python to the C approach is that the python loads
an entire json file in to memory, while the C code works from token to
token. In some cases the C approach was sensitive to the order of
dictionary items in the json file. To ensure matching output there are
two changes made to jevents.c to cause it to read all values before
creating output.

The changes also found a bug in Ivytown's UNC_M_ACT_COUNT.RD event
encoding, as well as unnecessary whitespace introduced in Alderlake's
metrics. In these cases the json input is fixed.

Ian Rogers (7):
  perf jevents: Append PMU description later
  perf vendor events: Fix Alderlake metric groups
  perf vendor events: Fix Ivytown UNC_M_ACT_COUNT.RD umask
  perf jevents: Modify match field
  perf jevents: Add python converter script
  perf jevents: Switch build to use jevents.py
  perf jevents: Remove jevents.c

 tools/perf/Makefile.perf                      |   13 +-
 tools/perf/pmu-events/Build                   |    9 +-
 .../arch/x86/alderlake/adl-metrics.json       |   32 -
 .../arch/x86/ivytown/uncore-memory.json       |    3 +-
 tools/perf/pmu-events/jevents.c               | 1322 -----------------
 tools/perf/pmu-events/jevents.py              |  392 +++++
 tools/perf/pmu-events/jsmn.h                  |   68 -
 tools/perf/pmu-events/json.c                  |  162 --
 tools/perf/pmu-events/json.h                  |   39 -
 tools/perf/tests/pmu-events.c                 |   30 +-
 10 files changed, 412 insertions(+), 1658 deletions(-)
 delete mode 100644 tools/perf/pmu-events/jevents.c
 create mode 100755 tools/perf/pmu-events/jevents.py
 delete mode 100644 tools/perf/pmu-events/jsmn.h
 delete mode 100644 tools/perf/pmu-events/json.c
 delete mode 100644 tools/perf/pmu-events/json.h

-- 
2.36.0.512.ge40c2bad7a-goog

