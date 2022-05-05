Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26A3351B738
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 06:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235678AbiEEEmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 00:42:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242826AbiEEEme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 00:42:34 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482D0457BE
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 21:38:53 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2f4dfd09d7fso29808577b3.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 21:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=CcdaVhY+2N/pSPp9MDh8luZCCl4PZJf4OlSTWHiC27U=;
        b=o8t/WMYszPRD1Jcw6CGfHsJQdXMUN1UM53DetWJR41bFO31stW+2jSH4RVgEj9rxRy
         ZratbzUuIp2ap7KH3v2Nmezp9fThnQMoK9VxHhoZwFgQO3Zgl2EuvnuGDnfse78nj+t5
         EMVw03OZjktSfv8cyh8JteNUopYxMyh+QPo+GPgUDLui2IL5Tp3z5fNiEOeBIisbDsuO
         KKxxRcAVIqjnHLBYSzRchkU0feXeXs6/6YwUt4jpiaAwry02SWycFrDNAf6tEpU/5BzO
         a6yJgYxP10D2+5PfVCh0Gnti6+ZBi8vJYnJpLOqYfkTzQ3xtSb7517Pj8SwXUvtI97ys
         oPbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=CcdaVhY+2N/pSPp9MDh8luZCCl4PZJf4OlSTWHiC27U=;
        b=1Szf+baDtfdl6SZZA/tkY7ACKyx7vUr0i3k8Ed1SIiov4Udjkbg5J0MJaptdsUMU5B
         mXBx9Jx7zXc+Ka04swLLAe4P3AgfDDRau6sa1znevCoUbVHz/PT8WILD/Gndzr5aHK7c
         5L47Xy/1Ecy1Risha9V9AkRRUPdjMcDvoAxr8J97wz4HPqqyI7lWxWP1nncBtkq4jjVf
         JiVS2ZkqAvkRpxAfmNJ2Db2lI5IYWiRnzlKSHYvU+rl2qhA6oKqQpd+aMoFQO4yDI4xj
         Q3sIYdjjMXsnakrbj6PhCJruGCs5sQ5qBCnt8Z2eEL6mAHEQl8ieSoB7/f6UP+clVMF6
         55Tw==
X-Gm-Message-State: AOAM533hMFPpKLGiOJBdl4wHk+rmc30OuqWgMta9Qkd8+/iBsgifkdYR
        mb7d9kmvXRJkrtpjBrBbtpObeCooovBM
X-Google-Smtp-Source: ABdhPJwxex3sU48Q1+MF+8X6oBei8TtadftQAcXZdvaDq1s/G2cW3NCBhXCUXo38MTf/bfVseQ084TMTY5cL
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:385b:60bc:5434:2897])
 (user=irogers job=sendgmr) by 2002:a25:8c10:0:b0:61d:b17e:703d with SMTP id
 k16-20020a258c10000000b0061db17e703dmr20792127ybl.154.1651725532371; Wed, 04
 May 2022 21:38:52 -0700 (PDT)
Date:   Wed,  4 May 2022 21:38:46 -0700
In-Reply-To: <20220505043846.3165303-1-irogers@google.com>
Message-Id: <20220505043846.3165303-2-irogers@google.com>
Mime-Version: 1.0
References: <20220505043846.3165303-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH 2/2] perf test: Add basic stat and topdown group test
From:   Ian Rogers <irogers@google.com>
To:     Caleb Biggers <caleb.biggers@intel.com>,
        Perry Taylor <perry.taylor@intel.com>,
        Kshipra Bopardikar <kshipra.bopardikar@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Andi Kleen <ak@linux.intel.com>,
        Haowen Bai <baihaowen@meizu.com>,
        Riccardo Mancini <rickyman7@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Shunsuke Nakamura <nakamura.shun@fujitsu.com>,
        Florian Fischer <florian.fischer@muhq.space>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
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
---
 tools/perf/tests/shell/stat.sh | 65 ++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100755 tools/perf/tests/shell/stat.sh

diff --git a/tools/perf/tests/shell/stat.sh b/tools/perf/tests/shell/stat.s=
h
new file mode 100755
index 000000000000..80869ea6debc
--- /dev/null
+++ b/tools/perf/tests/shell/stat.sh
@@ -0,0 +1,65 @@
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
+  if ! perf stat -e '{slots,topdown-bad-spec,topdown-be-bound,topdown-fe-b=
ound,topdown-retiring},branch-instructions,branch-misses,bus-cycles,cache-m=
isses,cache-references,cpu-cycles,instructions,mem-loads,mem-stores,ref-cyc=
les,baclears.any,ARITH.DIVIDER_ACTIVE' true > /dev/null 2>&1
+  then
+    echo "Topdown weak groups test [Skipped event parsing failed]"
+    return
+  fi
+  if perf stat -e '{slots,topdown-bad-spec,topdown-be-bound,topdown-fe-bou=
nd,topdown-retiring,branch-instructions,branch-misses,bus-cycles,cache-miss=
es,cache-references,cpu-cycles,instructions,mem-loads,mem-stores,ref-cycles=
,baclears.any,ARITH.DIVIDER_ACTIVE}:W' true 2>&1 | egrep -q "<not supported=
>"
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
2.36.0.464.gb9c8b46e94-goog

