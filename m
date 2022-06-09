Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7A225441E6
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 05:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237585AbiFID25 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 23:28:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236504AbiFID2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 23:28:53 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C399D15702
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 20:28:49 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31382419c22so19613007b3.18
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 20:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=9pnnBT0UYhrlxY+16+u8NQGh3M3CK1PWCQ4+N0B3YuE=;
        b=Mr3ujL43dXU2Fxl87koL94ItiqlZH9yfDIzoaF14NVltaDPAyOSyRVWvzXvUXNAr8D
         +MfMtaE87Jvu52b0B90VG9Xur5fIAosJ8MhM3R/z0pb5Sa0fMOmTFRK/n0CmuqjfUSrz
         XijYoCdtDKmkgFlHEqmRM118YHsfSMHdyWkGwJK4TYfRIeqfKSI6At2xj9XsiVMbdjvE
         b1KzgzWYjgHt4NI+98P8uYr7Aw3dQOwJpFPQiwRFMQ1s5+8jdOhkzcN9vyfBprKCn7xH
         btCBhK99kLKsS21hPFLve11i+/jguNLOytlzIp/wIu80uXOpIuZqbcmJVjRc6HLQ3G6/
         BOBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=9pnnBT0UYhrlxY+16+u8NQGh3M3CK1PWCQ4+N0B3YuE=;
        b=6rdfSJ1lLv9/41XX/Ux0suT00GyCLHfO/xA360Ej7Y+VK/56EjOvxeiz0eUMV6I7lZ
         nGi/QhIGXjyqDrFeldQzEA7o2uYoMkgUUtnOZVj0LZ9kgirPCFwTEYrDUI7lwUF6VeCu
         oGd4R/OMFMm7N1q/X39W6m2gX6+cbPfQ8ZfpiydWxqs7Eo8lRbBa3CXfGp6FDB8q9miz
         Cw0kry11E/q5Hp3MMTmdL9jNRcF3X2iBvNdjR2WxgDB+JrnDHTBHgnMLvDASSvDwGAY8
         pZrHTrIezlADxDpIfgKpxxq6Lk1cbvXpv8elDAQqINGiRpW8FNPPvnnfB/3TbjMK6Ppc
         DtQQ==
X-Gm-Message-State: AOAM533roqM0bpsw5/vxjsCj/feGtArzyRwuz1UaxZkLKUXHoIXuQzjt
        G/2XxSWfZDL2xkXygbrKGNJzd3wzLDF8
X-Google-Smtp-Source: ABdhPJys41xg53VvG1GIvRlRyxEYnJpong5Qk7TfMCvQsgh2dbiJOv0+by/SC7e9Dssa0SuFHmAfFjjNw7M6
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:de48:5efa:e4a1:2219])
 (user=irogers job=sendgmr) by 2002:a25:8909:0:b0:656:ae08:d91a with SMTP id
 e9-20020a258909000000b00656ae08d91amr37913706ybl.414.1654745328994; Wed, 08
 Jun 2022 20:28:48 -0700 (PDT)
Date:   Wed,  8 Jun 2022 20:28:42 -0700
Message-Id: <20220609032842.1257761-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
Subject: [PATCH] perf test: Add flake tolerance to record test
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Richter <tmricht@linux.ibm.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
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

Testing at scale exposes record tests failing with no samples. Retry the
test a bounded number of times to eliminate this.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/record.sh | 70 +++++++++++++++++++++-----------
 1 file changed, 47 insertions(+), 23 deletions(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 00c7285ce1ac..aeed364e834a 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -30,19 +30,29 @@ test_per_thread() {
     fi
     return
   fi
-  if ! perf record -e instructions:u --per-thread -o ${perfdata} true 2> /dev/null
-  then
-    echo "Per-thread record of instructions:u [Failed]"
-    err=1
-    return
-  fi
-  if ! perf report -i ${perfdata} -q | egrep -q true
-  then
-    echo "Per-thread record [Failed missing output]"
-    err=1
-    return
-  fi
-  echo "Basic --per-thread mode test [Success]"
+  flake_count=0
+  while true
+  do
+    if ! perf record -e instructions:u --per-thread -o ${perfdata} true 2> /dev/null
+    then
+      echo "Per-thread record of instructions:u [Failed]"
+      err=1
+      return
+    fi
+    if perf report -i ${perfdata} -q | egrep -q true
+    then
+      echo "Basic --per-thread mode test [Success]"
+      return
+    else
+      flake_count=$(($flake_count + 1))
+      if [ $flake_count -ge 30 ]
+      then
+        echo "Per-thread record attempted 30 times [Failed missing output]"
+        err=1
+        return
+      fi
+    fi
+  done
 }
 
 test_register_capture() {
@@ -61,16 +71,30 @@ test_register_capture() {
     echo "Register capture test [Skipped missing registers]"
     return
   fi
-  if ! perf record -o - --intr-regs=di,r8,dx,cx -e cpu/br_inst_retired.near_call/p \
-    -c 1000 --per-thread true 2> /dev/null \
-    | perf script -F ip,sym,iregs -i - 2> /dev/null \
-    | egrep -q "DI:"
-  then
-    echo "Register capture test [Failed missing output]"
-    err=1
-    return
-  fi
-  echo "Register capture test [Success]"
+  flake_count=0
+  while true
+  do
+    if ! perf record -o ${perfdata} --intr-regs=di,r8,dx,cx -e cpu/br_inst_retired.near_call/p \
+      -c 1000 --per-thread true 2> /dev/null
+    then
+      echo "Register capture test of cpu/br_inst_retired.near_call/p with --intr-regs [Failed]"
+      err=1
+      return
+    fi
+    if perf script -F ip,sym,iregs -i ${perfdata} 2> /dev/null | egrep -q "DI:"
+    then
+      echo "Register capture test [Success]"
+      return
+    else
+      flake_count=$(($flake_count + 1))
+      if [ $flake_count -ge 30 ]
+      then
+        echo "Register capture test attempted 30 times [Failed missing output]"
+        err=1
+        return
+      fi
+    fi
+  done
 }
 
 test_per_thread
-- 
2.36.1.255.ge46751e96f-goog

