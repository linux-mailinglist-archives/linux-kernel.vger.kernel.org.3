Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26ED529907
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 07:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237266AbiEQF1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 01:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236101AbiEQF1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 01:27:34 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F0F237E8
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 22:27:33 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2fb7bf98f1aso148766047b3.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 22:27:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=Oo0cEG8PI+5L/vf8eiiditzi/mq8iK5al1bzl2MFWFc=;
        b=n01fylJR1lJSvx/jdDzD+0NVzUxkWd+0nl3FOPG95yM12glrdF0XMO0tJMBCYLPGJ5
         l8uC58N4yqI2Rz6XTcaB5J9GMBdYZVdQuj95xs/KoVeRs2FJZmWPl/SrklShMbLKI2YS
         Rn/bQMvcIoXk26DgJExCNgbjXboRTI+OpjZPv0i1UtuXbeB4Fevvz6WIyhuPGbYRedfd
         kSb2L58qmTNgDoVN2IjvQ1yvyGAQOx+Bb/wT3YbxLmuAcrnwWxy6KI9Rn6djJOK20h+8
         4Po33TeGhFNdig0M+M4cyk7NfaQ/5ZX6hqLaVzAYQfj/QiP2he6sfh/8e9GqoLYaTxAB
         wO0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=Oo0cEG8PI+5L/vf8eiiditzi/mq8iK5al1bzl2MFWFc=;
        b=NtTvNKtJHMOu9yoL3uj7mGheH2ztPdVY9HBQ4qbYpqNwq46d6/trxExWxhAAQ57RmZ
         VtJbrLeytsA7f3nm/eL8wgLCumgsnsGEgNmn4PAH96onBQjISCdxEaeAjX07l+tnKMDa
         HpxAvoTfLulLLx/LcncR22yk9qSdt7EvGGepCFkkv5zjPpRu+srn4p2T01dsnHmPvqU6
         YS1OcSbh2/yZ1f21onQvEWH0jMNMXViTwmiRM+QTosLjLhl4BH6P1WD8SFHsWSLOjZou
         hebxx5WcWc0YFXCgNnFM/F8F9PATVpJpE1fZ9n66mEU00OQ3ETIukNnyn7huuEQ1ilg8
         zDMw==
X-Gm-Message-State: AOAM531gJtgBxp/1Wu8ld6Pm63jjxW45QoBcKskYWxbzQzUheLi5FzhA
        pizeyRf8Ex0Nbx0YE+cPc4ICUMbZZ/RM
X-Google-Smtp-Source: ABdhPJzeLq12ZohTeKdhYCNUmbJTdchTeyphmgzsTscwirUuwlYhvk/M4bey6+VENeBvXs61Cr788PPrTzru
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:d585:282c:3f88:36e3])
 (user=irogers job=sendgmr) by 2002:a25:9ac8:0:b0:64d:fee6:1c8 with SMTP id
 t8-20020a259ac8000000b0064dfee601c8mr947979ybo.344.1652765252213; Mon, 16 May
 2022 22:27:32 -0700 (PDT)
Date:   Mon, 16 May 2022 22:27:24 -0700
In-Reply-To: <20220517052724.283874-1-irogers@google.com>
Message-Id: <20220517052724.283874-3-irogers@google.com>
Mime-Version: 1.0
References: <20220517052724.283874-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.550.gb090851708-goog
Subject: [PATCH v3 2/2] perf test: Add basic stat and topdown group test
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>,
        Kan Liang <kan.liang@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a basic stat test.
Add two tests of grouping behavior for topdown events. Topdown events
are special as they must be grouped with the slots event first.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
---
 tools/perf/tests/shell/stat.sh | 67 ++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100755 tools/perf/tests/shell/stat.sh

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.s=
h
new file mode 100755
index 000000000000..c7894764d4a6
--- /dev/null
+++ b/tools/perf/tests/shell/stat.sh
@@ -0,0 +1,67 @@
+#!/bin/sh
+# perf stat tests
+# SPDX-License-Identifier: GPL-2.0
+
+set -e
+
+err=3D0
+test_default_stat() {
+  echo "Basic stat command test"
+  if ! perf stat true 2>&1 | egrep -q "Performance counter stats for 'true=
':"
+  then
+    echo "Basic stat command test [Failed]"
+    err=3D1
+    return
+  fi
+  echo "Basic stat command test [Success]"
+}
+
+test_topdown_groups() {
+  # Topdown events must be grouped with the slots event first. Test that
+  # parse-events reorders this.
+  echo "Topdown event group test"
+  if ! perf stat -e '{slots,topdown-retiring}' true > /dev/null 2>&1
+  then
+    echo "Topdown event group test [Skipped event parsing failed]"
+    return
+  fi
+  if perf stat -e '{slots,topdown-retiring}' true 2>&1 | egrep -q "<not su=
pported>"
+  then
+    echo "Topdown event group test [Failed events not supported]"
+    err=3D1
+    return
+  fi
+  if perf stat -e '{topdown-retiring,slots}' true 2>&1 | egrep -q "<not su=
pported>"
+  then
+    echo "Topdown event group test [Failed slots not reordered first]"
+    err=3D1
+    return
+  fi
+  echo "Topdown event group test [Success]"
+}
+
+test_topdown_weak_groups() {
+  # Weak groups break if the perf_event_open of multiple grouped events
+  # fails. Breaking a topdown group causes the events to fail. Test a very=
 large
+  # grouping to see that the topdown events aren't broken out.
+  echo "Topdown weak groups test"
+  ok_grouping=3D"{slots,topdown-bad-spec,topdown-be-bound,topdown-fe-bound=
,topdown-retiring},branch-instructions,branch-misses,bus-cycles,cache-misse=
s,cache-references,cpu-cycles,instructions,mem-loads,mem-stores,ref-cycles,=
cache-misses,cache-references"
+  if ! perf stat --no-merge -e "$ok_grouping" true > /dev/null 2>&1
+  then
+    echo "Topdown weak groups test [Skipped event parsing failed]"
+    return
+  fi
+  group_needs_break=3D"{slots,topdown-bad-spec,topdown-be-bound,topdown-fe=
-bound,topdown-retiring,branch-instructions,branch-misses,bus-cycles,cache-=
misses,cache-references,cpu-cycles,instructions,mem-loads,mem-stores,ref-cy=
cles,cache-misses,cache-references}:W"
+  if perf stat --no-merge -e "$group_needs_break" true 2>&1 | egrep -q "<n=
ot supported>"
+  then
+    echo "Topdown weak groups test [Failed events not supported]"
+    err=3D1
+    return
+  fi
+  echo "Topdown weak groups test [Success]"
+}
+
+test_default_stat
+test_topdown_groups
+test_topdown_weak_groups
+exit $err
--=20
2.36.0.550.gb090851708-goog

