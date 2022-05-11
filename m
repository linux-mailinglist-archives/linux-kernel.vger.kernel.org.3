Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75B5523F55
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 23:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348068AbiEKVPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 17:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348059AbiEKVPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 17:15:32 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CCC02297CC
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 14:15:31 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id f7-20020a6547c7000000b003c600995546so1568995pgs.5
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 14:15:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=sKtjMHsY05r5Ju8O5pD25dxn5ZC74mq9R1+/d5sMQD0=;
        b=SVfEFYxpuijqaeCdH+yZDzht+Z/H+7bjJfqbtxOTlBgVSjQdcE384BGETvZWge95bu
         EK8b9NlYlW6FjwnYXKa7PmatW4ABPI3BsxmWPrL3a/Ou4JdM2f4Y31UcGa4AzM8DM7kY
         McFxc8ksLp47xyZZDTNqoKefN0oS+W7ws2nyqchWLePlKA2FpU1tMWAAr9qk6Q5iH3sR
         THC+yRJuLov65/sL42xnI/Xw6Zz27BUWu28FNS1iKP5Wtvkdau61V29Dzn/cYidoLFPB
         yHEH81lP9cNN1foROdDMdm59PQ0fZQ+m0Lt1VQ22ClyXsNLNo9dirdduHCiqg5yyrV/H
         dzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=sKtjMHsY05r5Ju8O5pD25dxn5ZC74mq9R1+/d5sMQD0=;
        b=bytL2w/n2JQC3qHm/h3bE8KnP5MXgoXadNjq1lBu3tzWJfXQZXUnJr3hjSs36yHvD2
         c3/Vt3VuLb+3RR0Px4TT4U89LYmfPwTsiUIShArUFlYXhdX1i9LlsaSviacUsxhMumts
         wjwTusH+aj2YiOYhSt6QRhSOiIH/E7LMG1ZXDixvnspkYI1z82/f7MLI6t/gGes3WiZG
         Prh6YFbKKNKUeB5z/yt47EX/UQ0CLvE+pjC4cxjQWn2X4Pga2Maq+9OfaQTutW4pUt+/
         xV/Ngjv2dsiNxkzFZIKuBA4T898qnO1f9tftxu7+Jks0yFTKlz+jJc4HE6uWgwFMDGjp
         +4dQ==
X-Gm-Message-State: AOAM531cqrx0iDiI8eaTnomhrcbdMCAjuRs2Kv0PT/QtAB5JFUuQPQhX
        AqLAz+8JdFhjnQTuumg571mGZSPW2Da8
X-Google-Smtp-Source: ABdhPJwrUmqA1QXCOuStvCO4jdvm38keaf5yQw+J7mAJ9wWyzBE63FrRRy0lugXyzLjjh5FeeNryFdDBLRV2
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:5993:294b:7b62:54cb])
 (user=irogers job=sendgmr) by 2002:a17:90a:4983:b0:1d9:ef5:29f with SMTP id
 d3-20020a17090a498300b001d90ef5029fmr7376388pjh.67.1652303730579; Wed, 11 May
 2022 14:15:30 -0700 (PDT)
Date:   Wed, 11 May 2022 14:15:19 -0700
Message-Id: <20220511211526.1021908-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH v2 0/7] Rewrite jevents program in python
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
man pages). If the build detects that python isn't present or is older
than version 3.5 (released Sept. 2015) then an empty file is
substituted for the generated one.

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

v2. Fixes the build for architectures that don't have pmu-events json
    (Suggested-by: John Garry <john.garry@huawei.com>) and fixes the
    build for python not being present or too old (Suggested-by: Peter
    Zijlstra <peterz@infradead.org>/John Garry <john.garry@huawei.com>).

Ian Rogers (7):
  perf jevents: Append PMU description later
  perf vendor events: Fix Alderlake metric groups
  perf vendor events: Fix Ivytown UNC_M_ACT_COUNT.RD umask
  perf jevents: Modify match field
  perf jevents: Add python converter script
  perf jevents: Switch build to use jevents.py
  perf jevents: Remove jevents.c

 tools/perf/Makefile.config                    |   19 +
 tools/perf/Makefile.perf                      |   16 +-
 tools/perf/pmu-events/Build                   |   15 +-
 .../arch/x86/alderlake/adl-metrics.json       |   32 -
 .../arch/x86/ivytown/uncore-memory.json       |    3 +-
 tools/perf/pmu-events/empty-pmu-events.c      |   21 +
 tools/perf/pmu-events/jevents.c               | 1322 -----------------
 tools/perf/pmu-events/jevents.py              |  392 +++++
 tools/perf/pmu-events/jsmn.h                  |   68 -
 tools/perf/pmu-events/json.c                  |  162 --
 tools/perf/pmu-events/json.h                  |   39 -
 tools/perf/tests/pmu-events.c                 |   30 +-
 12 files changed, 460 insertions(+), 1659 deletions(-)
 create mode 100644 tools/perf/pmu-events/empty-pmu-events.c
 delete mode 100644 tools/perf/pmu-events/jevents.c
 create mode 100755 tools/perf/pmu-events/jevents.py
 delete mode 100644 tools/perf/pmu-events/jsmn.h
 delete mode 100644 tools/perf/pmu-events/json.c
 delete mode 100644 tools/perf/pmu-events/json.h

-- 
2.36.0.512.ge40c2bad7a-goog

