Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9958555B5A3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jun 2022 05:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbiF0C54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 22:57:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232390AbiF0C5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 22:57:54 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DCE38AE
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 19:57:53 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-317ae1236feso67519627b3.11
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 19:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=a2fOd84tKma8EBOoYLl1yXcF/bVpn+tXFfh8wONSJHw=;
        b=ld2t9CLo7nP+OT5H09VRlzkjhJzVA/xlWaaKHg5RZ3dWu31QWLXofNhGoSm3pl/aNs
         kTQYjc+efB3HD0NhScP7BDurQ+CBnrzDdVC1GiErxiMXbacl1x+bQeBGYfxGNaAu6apP
         oY06Z0bj04lSRXQoq2MiJQXbMWYNTcG+E05x7qGCHiXic4RW983rBeOO1d3nVfCATkyE
         RAS+MgMjm63UEswkEEreSlH41Kw3aTu2VCsC36zZBB1cJSf0Uk1C1SLaLvrnyc3XxvSt
         xe5pgbPZLnRfkOQgJKwgV9kk32SpkNS8H6xbGVizl/TcqVgigKr4K8CFHi2Jtkit7nGM
         VPiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=a2fOd84tKma8EBOoYLl1yXcF/bVpn+tXFfh8wONSJHw=;
        b=kZWNZXfYZ4qj7XN3+91QnEXRbqdUf1WMueFBZg/DYcCosEZ+zIPAu4gjoRlPK5w0VX
         Qcd9zXTBT7v9wN7IBNRwPWRO50//61aFKhfXH9K+w7I621eJy/feX/zlZO5PHxpQ/zkH
         u96YZOQRIidoAbspgwaSAcNrWmCp8Zz3wkTcv3x3/2c9TD31Ph3dII86cQu99lWBbxwJ
         zvhANkOJ/mv4WjjGru60iIUumy6CknShCGQ2/b7xWTG4xajaSBkSmQFuHR8Uy10gganH
         UxC73RLvgLOBId5JlU1h4s5pzXW0rssTvCjt20Cm1oa5wmQhcl0KU6KUut4HlWRsmfpj
         crgQ==
X-Gm-Message-State: AJIora8lTg4GN5LNuBzXNxKIKR6RK48lJ/UVfNoTvxh856HwYaC2lhfu
        st6sfgGZxvM4fUbH9Voi3ZVj/V18o9eS
X-Google-Smtp-Source: AGRyM1sOfbkoS05RkdeEbrjjtiZ+bs28kS1Kb1As8SCl552Ng8sc/DP26748w4s3JvZD2H1AlSUv1oQzdZ0L
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:646b:8b65:8f13:1c18])
 (user=irogers job=sendgmr) by 2002:a25:1944:0:b0:66c:7ba4:7481 with SMTP id
 65-20020a251944000000b0066c7ba47481mr11127858ybz.640.1656298672703; Sun, 26
 Jun 2022 19:57:52 -0700 (PDT)
Date:   Sun, 26 Jun 2022 19:57:40 -0700
Message-Id: <20220627025744.106527-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v6 0/4] Rewrite jevents program in python
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

