Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F36D5AFCC4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:47:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiIGGrG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:47:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229999AbiIGGqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:46:53 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 832AC83059;
        Tue,  6 Sep 2022 23:46:52 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id p18so13545014plr.8;
        Tue, 06 Sep 2022 23:46:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=HvxZPONrRbuUvmCxwCXx0tcsdz/6p+S6Y0WSBKTWG/c=;
        b=p3XOVyu6zm0XvHqdkPCYjoTO15xTNBblOw5dvDArdnwvbOWabVFDLk9qIv79j4RaRG
         yWhEs1YvobUr3RrfWFaPgiNNv9UdHTqogSrz+KK9Yip1G/8OVT+7d9976doAV9xFS84V
         Fpdj8GY6O2bptFqUj7F0JWWxInFDxii2X7UtX1+GgD2p4ju2+QuRpwbj/cdq8v4kMmyp
         OW/g2IfjhIrrIGt0TkiqQc6BWmmYh29bpn4WE8IsXug/LMI8T9G6dEiCHCNKD2ZH+8uz
         82sRtWJuxQLEKfhFWZt1e3vk29YSHWCbOQX8MfLWnz+vStsIUF45Xu8aWOi9CSMRrcSO
         0eqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=HvxZPONrRbuUvmCxwCXx0tcsdz/6p+S6Y0WSBKTWG/c=;
        b=kHSbD4ni21HWZ+ONUH8lX/Od7lrE9RAQ+Uhg/4Mo/byRxUO9LCpyQo0qRFOjq0UY0+
         y4MT6IZvXubjgXnvXy2hXWN16wVS0oMyHgjOtAb4Uq27SlqWOYvtlH++aOfpSHd2Hlgd
         G2RSlhimF8EfYTDh8Q1LFVetcAFclUM3HRpEqa9zd3eArbiv+chChPiXhMVHZSTEA9A5
         tMlSjXXqGbREA7kdb38yw9u+puWOTDaOK9a6F76sWkNSqtZDM4l3W7bJPpikmPVIiicz
         P5zDXexLY8HOYeIsoxbvHafESOvHQUo6obSMd8EDlX55K6jwXUZ/yfSP8FyY1Ucyt/8z
         u7Zw==
X-Gm-Message-State: ACgBeo2WCSabNTBPc8wHUIm1f2QRw1fF3qr9lV4UJjPFJW83Bv/eru9D
        f/BjWx+kxseHXUs/jjQ7enI=
X-Google-Smtp-Source: AA6agR4+xTCH0Mw7YOnD3q3yWcRKZFRM7ACW0uIB8IUFBL6Pbn8XyGFPSUl0MmlYtLsytoJH36HlhA==
X-Received: by 2002:a17:90b:2242:b0:200:1c81:c108 with SMTP id hk2-20020a17090b224200b002001c81c108mr2314266pjb.89.1662533211882;
        Tue, 06 Sep 2022 23:46:51 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:f249:9066:7da7:4a37])
        by smtp.gmail.com with ESMTPSA id z4-20020a170902ccc400b00172c7a2c662sm11192192ple.48.2022.09.06.23.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 23:46:50 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 2/6] perf test: Use a test program in perf record tests
Date:   Tue,  6 Sep 2022 23:46:41 -0700
Message-Id: <20220907064645.1197894-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220907064645.1197894-1-namhyung@kernel.org>
References: <20220907064645.1197894-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the system has cc it could build a test program with two threads
and then use it for more detailed testing.  Also it adds initial delay
of 3ms to profile a multi-threaded target.  This change make the test
failing but that's what we want to check for now.

If cc is not found, it falls back to use the default value 'true'.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/record.sh | 58 +++++++++++++++++++++++++++++---
 1 file changed, 54 insertions(+), 4 deletions(-)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 40b087bfdb76..cea3c7b7e2cd 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -6,10 +6,18 @@ set -e
 
 err=0
 perfdata=$(mktemp /tmp/__perf_test.perf.data.XXXXX)
+testprog=$(mktemp /tmp/__perf_test.prog.XXXXXX)
+testsym="test_loop"
+testopt="-D 3"
 
 cleanup() {
   rm -f ${perfdata}
   rm -f ${perfdata}.old
+
+  if [ "${testprog}" != "true" ]; then
+    rm -f ${testprog}
+  fi
+
   trap - exit term int
 }
 
@@ -19,9 +27,49 @@ trap_cleanup() {
 }
 trap trap_cleanup exit term int
 
+build_test_program() {
+  if ! [ -x "$(command -v cc)" ]; then
+    # No CC found. Fall back to 'true'
+    testprog=true
+    testsym=true
+    testopt=''
+    return
+  fi
+
+  echo "Build a test program"
+  cat <<EOF | cc -o ${testprog} -xc - -pthread
+#include <stdio.h>
+#include <unistd.h>
+#include <pthread.h>
+
+void test_loop(void) {
+  volatile int count = 1000000;
+
+  // wait for perf record
+  usleep(5000);
+
+  while (count--)
+    continue;
+}
+
+void *thfunc(void *arg) {
+  test_loop();
+  return NULL;
+}
+
+int main(void) {
+  pthread_t th;
+  pthread_create(&th, NULL, thfunc, NULL);
+  test_loop();
+  pthread_join(th, NULL);
+  return 0;
+}
+EOF
+}
+
 test_per_thread() {
   echo "Basic --per-thread mode test"
-  if ! perf record -o /dev/null --quiet true 2> /dev/null
+  if ! perf record -o /dev/null --quiet ${testprog} 2> /dev/null
   then
     echo "Per-thread record [Skipped event not supported]"
     if [ $err -ne 1 ]
@@ -30,13 +78,13 @@ test_per_thread() {
     fi
     return
   fi
-  if ! perf record --per-thread -o ${perfdata} true 2> /dev/null
+  if ! perf record --per-thread ${testopt} -o ${perfdata} ${testprog} 2> /dev/null
   then
     echo "Per-thread record [Failed record]"
     err=1
     return
   fi
-  if ! perf report -i ${perfdata} -q | egrep -q true
+  if ! perf report -i ${perfdata} -q | egrep -q ${testsym}
   then
     echo "Per-thread record [Failed missing output]"
     err=1
@@ -62,7 +110,7 @@ test_register_capture() {
     return
   fi
   if ! perf record -o - --intr-regs=di,r8,dx,cx -e cpu/br_inst_retired.near_call/p \
-    -c 1000 --per-thread true 2> /dev/null \
+    -c 1000 --per-thread ${testopt} ${testprog} 2> /dev/null \
     | perf script -F ip,sym,iregs -i - 2> /dev/null \
     | egrep -q "DI:"
   then
@@ -73,6 +121,8 @@ test_register_capture() {
   echo "Register capture test [Success]"
 }
 
+build_test_program
+
 test_per_thread
 test_register_capture
 
-- 
2.37.2.789.g6183377224-goog

