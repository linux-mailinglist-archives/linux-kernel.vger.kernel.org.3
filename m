Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FFD54D157
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 21:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350089AbiFOTHq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 15:07:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiFOTHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 15:07:43 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152281182C;
        Wed, 15 Jun 2022 12:07:38 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id u37so3852803pfg.3;
        Wed, 15 Jun 2022 12:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=h6tRYruc0V5Cohol4GRMnPOLxDy9KK9MqLJG9857f+o=;
        b=EPwo47etFGbDXxA3C9s2Y+FhZ26CDF9BORo6UO78Vm4ynG8SlnH/5XpEzK6GbSae1l
         SYbEHy0yB88gYEjQeQ0PaMFwD9LKWdA7JSnOObAsYETM8zhN9U1b09oSGaDvLpUClxA3
         AB6h4h/2E4q4oy768g++O01h38N0ZyORAzn4Xzl2hI2Z3E3UNtfLH7EZl9aMk3jgMtrA
         XWhDxktpiel5DbFeFbB9N/w1IYjyrbxtXQ9lsWzL+yXaLrFw6JxjGblik7a1x+mCSVT7
         BKUuJJccb5Zzwwa6AxgvOlI4f7iK6IOpkc8QSkRcs4FTMKAJFxJOPKe0Typfy/0LqDLw
         QyPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=h6tRYruc0V5Cohol4GRMnPOLxDy9KK9MqLJG9857f+o=;
        b=hWmUQFZ4bvNGxrPDeQurYFHe7lYPUgifhEbOpZKLcGj4751ENwUfLdblQrKFYnZ/Gs
         g4bGB2fr5ukG6wL5dnaBYDEX62PmvS9wRvQQ5fJ6ZkJytA+ZMO8KuRhN3uEnpPTUKEZ+
         1F/NopM0u6Ju4lloN+6N8zMLRxe5UkP9ypSYjH0cade/EkU70bK0v89L4Cgfl+vAnFzs
         yGW1LarnAqZEO5FL4mjzAnz3imA9CCQlngGCJy4w4sa+eWawDpBVQYscbhgNM9KnqNo1
         IXd+xBEnMUwkYDVXwCLq38jUMbCG35lHC9F5fO3UKIc5cKzcNgePYFW+9o596bL8dLMW
         OHxw==
X-Gm-Message-State: AJIora+iQ7i40l+YJV/FPXUzvB7YDUGYeFWoRyTWlVx3ssSP2P7AVlWd
        plbJbQEq+w13agMiWX/L3QzHIqYHrHae+A==
X-Google-Smtp-Source: AGRyM1uTzQ/tshi0AoPH7dTPOaOqHkG3atVLlhU6YIvrW9qHYMjyzIussN/gXjS3WJbrjOcZUJTCdA==
X-Received: by 2002:a63:1220:0:b0:408:a4cd:8aae with SMTP id h32-20020a631220000000b00408a4cd8aaemr1039007pgl.377.1655320057519;
        Wed, 15 Jun 2022 12:07:37 -0700 (PDT)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:6b99:92ca:1efa:c0fb])
        by smtp.gmail.com with ESMTPSA id t21-20020a17090aae1500b001e2ebcce5d5sm2175795pjq.37.2022.06.15.12.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 12:07:37 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        German Gomez <german.gomez@arm.com>,
        Leo Yan <leo.yan@linaro.org>
Subject: [PATCH] perf test: Add ARM SPE system wide test
Date:   Wed, 15 Jun 2022 12:07:35 -0700
Message-Id: <20220615190735.1298213-1-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
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

In the past it had a problem not setting the pid/tid on the sample
correctly when system-wide mode is used.  Although it's fixed now it'd
be nice if we have a test case for it.

Cc: German Gomez <german.gomez@arm.com>
Cc: Leo Yan <leo.yan@linaro.org>
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/tests/shell/test_arm_spe.sh | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/tools/perf/tests/shell/test_arm_spe.sh b/tools/perf/tests/shell/test_arm_spe.sh
index e59044edc406..b9c588ae393b 100755
--- a/tools/perf/tests/shell/test_arm_spe.sh
+++ b/tools/perf/tests/shell/test_arm_spe.sh
@@ -23,6 +23,7 @@ glb_err=0
 cleanup_files()
 {
 	rm -f ${perfdata}
+	rm -f ${perfdata}.old
 	exit $glb_err
 }
 
@@ -85,5 +86,19 @@ arm_spe_snapshot_test() {
 	arm_spe_report "SPE snapshot testing" $err
 }
 
+arm_spe_system_wide_test() {
+	echo "Recording trace with system-wide mode $perfdata"
+	perf record -o ${perfdata} -e arm_spe// -a \
+		-- dd if=/dev/zero of=/dev/null count=100000 > /dev/null 2>&1
+
+	perf_script_samples dd &&
+	perf_report_samples dd
+
+	err=$?
+	arm_spe_report "SPE system-wide testing" $err
+}
+
 arm_spe_snapshot_test
+arm_spe_system_wide_test
+
 exit $glb_err
-- 
2.36.1.476.g0c4daa206d-goog

