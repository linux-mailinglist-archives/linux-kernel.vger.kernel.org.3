Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34084514235
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 08:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354440AbiD2GRE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 02:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354419AbiD2GQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 02:16:59 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993BEA0BE1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 23:13:41 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id z14-20020a5b0b0e000000b0064848b628cfso6611285ybp.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 23:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=Kqo59qgKd1gaX20d6SNzOXicZIkv6urxzb/rb9AIZQ4=;
        b=K1nJzgo8S7CyE26PvnGHw0Xo0cKbXQMzSTUbU4RZXQWNvthmXLa1Fa/55QdsRFbfMr
         C0U9sTC1gbZi5m2tPBNzFFsY+eSUlaO32uAv0XIV5WzOS8FzgAzgVn8uotaI6Edqpc2Y
         l2C+p6Vi4ZB5cdwz7MRyI67/bBYbF3MB2FZlT3rzV9hH5XXw7FeqZo0MXAaVxWGooE5+
         DbOt5cGIh+LNg0O4OPhyQTwg2GYtKVPH69P0w3rQjbIMuhXpKyV002lZy3kZR25R850V
         qJ67vs573N67W/vwECJO9fgtHh5GpxxkTJwOta3kSKPRdcGvTyQDIv5UA5fcrrwZgAXv
         myuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=Kqo59qgKd1gaX20d6SNzOXicZIkv6urxzb/rb9AIZQ4=;
        b=h5oxnhH0XTYnU0WeA1Tx0bcI+Jb3/B2IhcnVKALeAUGp5eUb2oGiHLwqAGjW9pye8j
         Rfxs6r83ANQKQSzaq/IdV6UTdGtSJ60eYFfQFWISPbNzKUMrfraCexKbMJHAeq+ucmPR
         h6NTNkLfGYxUsAfZVy6cF1G17RsWxL41P176rZuVHdC7qsrzo/Dekn5XBABAN3eRQ/xx
         uGJ7PfyPERiKnqIByGZ4glI1E9hFSOHEaMlRTNE7sXQlCpkrw5zhky2/gla6VipjwISk
         WVX/tEr05l4qC96dKCxzGPfSzUWiLL6BOhQ9Nxo9EzKUpRRKvt6DnQtAbDqhlPrNbaNW
         E+dg==
X-Gm-Message-State: AOAM531qIpCLrjrKN8/LCxv2z3Um6V63v310KceN4wXBULXfiGm7MZ+W
        GwgZXlggD2fOVT2K5l9yrTwkvu4LmSjG
X-Google-Smtp-Source: ABdhPJyHpmgogZV5669KSyoTmYzPXdpO4rHCuq4zduFqHlDxAwemPHgNsDQPhWVBwDMKZN+yfhhsTISvmoQE
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:3c33:ed69:1770:973e])
 (user=irogers job=sendgmr) by 2002:a25:2553:0:b0:649:1c7e:51ee with SMTP id
 l80-20020a252553000000b006491c7e51eemr3811092ybl.458.1651212820823; Thu, 28
 Apr 2022 23:13:40 -0700 (PDT)
Date:   Thu, 28 Apr 2022 23:13:36 -0700
Message-Id: <20220429061336.1184848-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.36.0.464.gb9c8b46e94-goog
Subject: [PATCH] perf test: Add skip to --per-thread test
From:   Ian Rogers <irogers@google.com>
To:     Thomas Richter <tmricht@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     svens@linux.ibm.com, gor@linux.ibm.com, sumanthk@linux.ibm.com,
        hca@linux.ibm.com, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As reported in:
https://lore.kernel.org/linux-perf-users/20220428122821.3652015-1-tmricht@linux.ibm.com/
the 'instructions:u' event may not be supported. Add a skip using 'perf
stat'.

Switch some code away from pipe to make the failures clearer.

Reported-by: Thomas Richter <tmricht@linux.ibm.com>
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/tests/shell/record.sh | 44 +++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index cd1cf14259b8..efc0cb07a929 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -5,11 +5,43 @@
 set -e
 
 err=0
+perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+
+cleanup() {
+  rm -f ${perfdata}
+  rm -f ${perfdata}.old
+  trap - exit term int
+}
+
+trap_cleanup() {
+  cleanup
+  exit 1
+}
+trap trap_cleanup exit term int
+
 test_per_thread() {
   echo "Basic --per-thread mode test"
-  perf record -e instructions:u --per-thread -o- true 2> /dev/null \
-    | perf report -i- -q \
-    | egrep -q true
+  if ! perf stat -e instructions:u --quiet true
+  then
+    echo "Per-thread record [Skipped instructions:u not supported]"
+    if [ $err -ne 1 ]
+    then
+      err=2
+    fi
+    return
+  fi
+  if ! perf record -e instructions:u --per-thread -o ${perfdata} true 2> /dev/null
+  then
+    echo "Per-thread record of instructions:u [Failed]"
+    err=1
+    return
+  fi
+  if ! perf report -i ${perfdata} -q | egrep -q true
+  then
+    echo "Per-thread record [Failed missing output]"
+    err=1
+    return
+  fi
   echo "Basic --per-thread mode test [Success]"
 }
 
@@ -18,6 +50,10 @@ test_register_capture() {
   if ! perf list | egrep -q 'br_inst_retired.near_call'
   then
     echo "Register capture test [Skipped missing instruction]"
+    if [ $err -ne 1 ]
+    then
+      err=2
+    fi
     return
   fi
   if ! perf record --intr-regs=\? 2>&1 | egrep -q 'available registers: AX BX CX DX SI DI BP SP IP FLAGS CS SS R8 R9 R10 R11 R12 R13 R14 R15'
@@ -39,4 +75,6 @@ test_register_capture() {
 
 test_per_thread
 test_register_capture
+
+cleanup
 exit $err
-- 
2.36.0.464.gb9c8b46e94-goog

