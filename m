Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF6C75AFCC7
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 08:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbiIGGrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 02:47:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiIGGq7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 02:46:59 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08A5A9C2F5;
        Tue,  6 Sep 2022 23:46:59 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id c24so12686609pgg.11;
        Tue, 06 Sep 2022 23:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=dBkY5JwPDDUc5Z+yQMBHF4hE+B7AnxknIsLcIO1DB2I=;
        b=lWzucFOt1vclx3hLauvKAPhxr85eZcZnyCV4UjOvmq8efLBbnSoiVNziD2MHxXdeqj
         Iii6iPyewSjcR+LqWWdR9QjNPW7+elhX1MyHm/wgMKby8PVuui/qLfGiQ+EwksaXefuR
         HAOaI0h2+CihpLFwNJ8EGdIcJuxzU101f3A9NIenoIhJ3MomTYbIvO16W+ZiO4bASNbj
         4U5jVgssR6S9tjyvp0XQerA1n6C1iEMR9R270ApK8y1hQVyP/UVhFyyAT71WqDJhExiN
         mgfv3jK5+2Qi/xYlcaExUq1UAMsYxUKSTTULAI43aCmxuomfnl9S800/FpoStn1QZVt9
         jNbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=dBkY5JwPDDUc5Z+yQMBHF4hE+B7AnxknIsLcIO1DB2I=;
        b=L/YKnmFcS7zJBIygNtqzOkBjhJIXuyNlSVQEyPOgpO7IJnHeeapkm4izJl8gXNl6zm
         QJhMJqL0RrnlgLy+diVpO34tXstx2VKgq01+NEiK+Y76RTsv7J+MJyTEbXCqnmVGw0V7
         j8QPBf7WvjNJfpig+nSewbEu2K+3fuD+zQI3ETc2h6kyssTsp40IK2l4VNDvSX97NruS
         J7nJwpCxA7vqUuIftHZzKmBODeBW+YXSD4Uo7vw53zeSHUf0b2a6QMUKO7JoeDCaUTF1
         9ntdfmHMv0mvhPS6U4aJVJFSHjFM7PFE6G7xnl9wIbFmYRrEbnIvFmJpEmtvBN8G9QOa
         qJMg==
X-Gm-Message-State: ACgBeo3+3HZQkintGpDdVNsVgf6pnLFu1keGs2fqrY73s6Ae6WRFqQ7Y
        UD7wmG1RZ8Nr5XA8binAgoTWsfE7z7o=
X-Google-Smtp-Source: AA6agR6JYPQ8mgm4UPsUnteieZTlaE7gI5YJmHghfoV6xOT1f7siCYbJyx7FveF3q8eV447F6Utuxw==
X-Received: by 2002:a63:1660:0:b0:42a:7efe:d554 with SMTP id 32-20020a631660000000b0042a7efed554mr2225641pgw.110.1662533218465;
        Tue, 06 Sep 2022 23:46:58 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:f249:9066:7da7:4a37])
        by smtp.gmail.com with ESMTPSA id z4-20020a170902ccc400b00172c7a2c662sm11192192ple.48.2022.09.06.23.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 23:46:57 -0700 (PDT)
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
Subject: [PATCH 5/6] perf test: Add target workload test in perf record tests
Date:   Tue,  6 Sep 2022 23:46:44 -0700
Message-Id: <20220907064645.1197894-6-namhyung@kernel.org>
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

Add a subtest which profiles the given workload on the command line.
As it's a minimal requirement, test should run ok so it doesn't skip
the test even if it failed to run the perf record.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/record.sh | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/perf/tests/shell/record.sh b/tools/perf/tests/shell/record.sh
index bd4ef60948bd..ff66e58f3a26 100755
--- a/tools/perf/tests/shell/record.sh
+++ b/tools/perf/tests/shell/record.sh
@@ -167,11 +167,42 @@ test_system_wide() {
   echo "Basic --system-wide mode test [Success]"
 }
 
+test_workload() {
+  echo "Basic target workload test"
+  if ! perf record ${testopt} -o ${perfdata} ${testprog} 2> /dev/null
+  then
+    echo "Workload record [Failed record]"
+    err=1
+    return
+  fi
+  if ! perf report -i ${perfdata} -q | egrep -q ${testsym}
+  then
+    echo "Workload record [Failed missing output]"
+    err=1
+    return
+  fi
+  if ! perf record -e cpu-clock,cs --threads=package ${testopt} \
+    -o ${perfdata} ${testprog} 2> /dev/null
+  then
+    echo "Workload record [Failed recording with threads]"
+    err=1
+    return
+  fi
+  if ! perf report -i ${perfdata} -q | egrep -q ${testsym}
+  then
+    echo "Workload record [Failed missing output]"
+    err=1
+    return
+  fi
+  echo "Basic target workload test [Success]"
+}
+
 build_test_program
 
 test_per_thread
 test_register_capture
 test_system_wide
+test_workload
 
 cleanup
 exit $err
-- 
2.37.2.789.g6183377224-goog

