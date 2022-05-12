Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C38C752456B
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 08:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350191AbiELGN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 02:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349200AbiELGNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 02:13:17 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7834771D91
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 23:13:16 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w133-20020a25c78b000000b0064847b10a22so3786268ybe.18
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 23:13:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=f+e4pvMpvZ5FD8KZvOjUh4XoOW7Z6kreH9FTFgJ4ipI=;
        b=FjsXibDunA+Dx5EV7EM1Jq8yd6LDr220wmrdKWi6QRiQgd+r61DfTxp0ijxQQON9Z2
         4pEA/4bd+PSqwIeuQ2ltxwo32q7MAPuk01Zup0Yd9+haDMRPSoKNs+UNL+8em6C/lS46
         VBTPSC8S83NnQki5HSoAgj+fm9ODAV8lBJfF9jM/5Go+MtV0tXUoB8kenWbIngV3YLUK
         jZllC0hSseK/MgTh74z5j5n5QwNER06x3bCP1Wh6wkZauXZXI0kL0s8cZEyUs+a2ROir
         MzXQwQE7T+NZsNR5sQrXRP6MzquqoFIjFB3ZuCB48j1lQLTQ89J6eViOzWcAX2fK6Mb5
         6qkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=f+e4pvMpvZ5FD8KZvOjUh4XoOW7Z6kreH9FTFgJ4ipI=;
        b=QSfGZLtj3nPXTqIWq83hY6nximEbofDtpB3Kcs2EJbe8PbSJJPH/716AQfSm98Msua
         3inztVfa0G65j6Gilr//qEelc0jJsXqTySeCIQm0xSe8kfeeLGa8AEOSvmUp+Se9+e5i
         riBoaNOBAIoWE89gAeVE6vXvT5ZiqL+lVgR05b7bCs2yPQlyze0se27tdLuxxgnPVuYn
         ZM7PtCZiyEOrfZRheAFFF6rqeRLeBrHknBFtDFIGVKFZ4E9xIFF7tn3MgZy3xsU6mQDW
         fqwqj9Y/6uN55rdnwIHzaVDSGQ8jUQCMKL42ZyrfvVDR9sJJT5IIpVZZi78KMA8JKOgD
         fCiw==
X-Gm-Message-State: AOAM532xtr9+6lTMcAxKIDcE9RjHRf7mBSF5EPIuhIMxGTmQ81dHKCOQ
        MQzCUDPJ42rwuxJXqPvYsUoTyMESLPQZ
X-Google-Smtp-Source: ABdhPJxJ7Z11zeGY8MwMQzcwm2TOvqePLmEMB/wktyCWJdtOg7cn9h9TvTVluTrz8IUg56U5LUsQ8WUMXwbj
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:5993:294b:7b62:54cb])
 (user=irogers job=sendgmr) by 2002:a25:44c1:0:b0:64a:94d7:6a5a with SMTP id
 r184-20020a2544c1000000b0064a94d76a5amr23664672yba.396.1652335995713; Wed, 11
 May 2022 23:13:15 -0700 (PDT)
Date:   Wed, 11 May 2022 23:13:08 -0700
In-Reply-To: <20220512061308.1152233-1-irogers@google.com>
Message-Id: <20220512061308.1152233-3-irogers@google.com>
Mime-Version: 1.0
References: <20220512061308.1152233-1-irogers@google.com>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
Subject: [PATCH v2 2/2] perf test: Add basic stat and topdown group test
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
2.36.0.512.ge40c2bad7a-goog

