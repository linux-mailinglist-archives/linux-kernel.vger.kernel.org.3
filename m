Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 933655AFCC6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbiIGGrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:47:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiIGGq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:46:58 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 953F797B12;
        Tue,  6 Sep 2022 23:46:57 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id v1so209324plo.9;
        Tue, 06 Sep 2022 23:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=C442dDRUzk55Xyrw81byl1NSbbzKYSZS3cxh3IVRC9o=;
        b=gb+fX6H9pLhIsKjoDlaz7YWl6+j+UG+pf6JCafWdaQ5WSr9hZWFeOdJCsPaMfOOkV+
         KRXkZ6SDiDdfsqWY/3MyVUdnF9MAIQSSHEFWirjUGfNbsdBlGkJpAA8aKFT7aSiMdRVB
         cgQhGN0fqVIyfpv1lrluYIgAxX+vFxPq0yJvDD+a8xpcuvcaVQn8oS1X3wzIQ/t8VYFo
         cBd3QXu2UScMxNp1KHHpUZWdjesglUfEE5DmuViYwvVB+g0R6XAHye2Hq0skK96tFiuH
         DxDNItZemOk61v8n+J8di2UklBhd0Eqk5a+wJBynsflmRzjFUWoOMIfHAp1k9vpqqg5H
         Ifzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=C442dDRUzk55Xyrw81byl1NSbbzKYSZS3cxh3IVRC9o=;
        b=UvZSvs5zCQFZDs8aILnNzcAoBvuPJj6IdDFxOTz2oJepFyMlYlfU+PbjLSf0Tj6Nwc
         Q1qxzIQeI4/4aN+gLLt98z/ikP9HE7VnrgVhuq6Foj2p5MKgxmPdshDqaTub8zb7sWD6
         qt+YZQZfbG06r5DK/L8D547iC86FTHu8ezZEHklRmYuIjeHkUHWFOgMYW9QU2kN/mXLl
         AabJTX2gCHnGKDSORVf8f1ARBEtyL1MxTPbifQiy877xDMuB9mm+VPM8j0a9TExuVmPE
         haslpJpqQbqWSmTsNROhMj/ni5n6qZ1Igid4gvZISjfSHZKxFlbNnWFYKgWmN4/SQxKn
         g0Tw==
X-Gm-Message-State: ACgBeo2w7xMlg1rkB5E4WUs2V+TSe/xTs7mcwe38kgXIr5MWh2Gti6EN
        GI+ES9ZE4ao/M5XMxO3bjic+yQil7uE=
X-Google-Smtp-Source: AA6agR7DQOcvEvkzk2PTtMl98Btjc+oP9gaWgCY8rsufCVNAHBCk4XA225LtY+nUYMZA1hzkxMShHQ==
X-Received: by 2002:a17:902:e741:b0:175:2ffe:9280 with SMTP id p1-20020a170902e74100b001752ffe9280mr2102395plf.153.1662533217057;
        Tue, 06 Sep 2022 23:46:57 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:f249:9066:7da7:4a37])
        by smtp.gmail.com with ESMTPSA id z4-20020a170902ccc400b00172c7a2c662sm11192192ple.48.2022.09.06.23.46.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 23:46:56 -0700 (PDT)
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
Subject: [PATCH 4/6] perf test: Add system-wide mode in perf record tests
Date:   Tue,  6 Sep 2022 23:46:43 -0700
Message-Id: <20220907064645.1197894-5-namhyung@kernel.org>
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

Add system wide recording test with the same pattern.  It'd skip the
test when it failes to run perf record.  For system-wide mode, it needs
to avoid build-id collection and synthesis because the test only cares
about the test program and kernel would generates necessary events as
the process starts.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/record.sh | 34 ++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index 3331fb092654..bd4ef60948bd 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -134,10 +134,44 @@ test_register_capture() {
   echo "Register capture test [Success]"
 }
 
+test_system_wide() {
+  echo "Basic --system-wide mode test"
+  if ! perf record -aB --synth=no ${testopt} -o ${perfdata} ${testprog} 2> /dev/null
+  then
+    echo "System-wide record [Skipped not supported]"
+    if [ $err -ne 1 ]
+    then
+      err=2
+    fi
+    return
+  fi
+  if ! perf report -i ${perfdata} -q | egrep -q ${testsym}
+  then
+    echo "System-wide record [Failed missing output]"
+    err=1
+    return
+  fi
+  if ! perf record -aB --synth=no -e cpu-clock,cs --threads=cpu ${testopt} \
+    -o ${perfdata} ${testprog} 2> /dev/null
+  then
+    echo "System-wide test [Failed recording with threads]"
+    err=1
+    return
+  fi
+  if ! perf report -i ${perfdata} -q | egrep -q ${testsym}
+  then
+    echo "System-wide record [Failed missing output]"
+    err=1
+    return
+  fi
+  echo "Basic --system-wide mode test [Success]"
+}
+
 build_test_program
 
 test_per_thread
 test_register_capture
+test_system_wide
 
 cleanup
 exit $err
-- 
2.37.2.789.g6183377224-goog

