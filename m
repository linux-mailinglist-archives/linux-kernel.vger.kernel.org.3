Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D57597547
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 19:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238174AbiHQRtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 13:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237052AbiHQRtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 13:49:17 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 899EC65821
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 10:49:16 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-324966c28e5so164004667b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 10:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc;
        bh=M5S6AbdkVVbSnSfN9/DAhnwSxKsAuBYodWwik9s6ZfI=;
        b=b7wOw1EkyAq3QKpxWwsvGGOitsz3gO6HkDKqrLtqYR8egq2Cng/I2Q+5J/yXk0gKkc
         pPOp/sLtqOZ8rleYh0yUs4yxGk8ic7w57MroP+WIcBS6WE2lHHsEGhu3JvHjsPjkaRRV
         Tvn3Y7JGBWCGjRisO2SOvqhovF7oJYB0Cz05PyBPDS8pe3yD1y7rVJrPfSuuhX1dhnF9
         +gm1Es3hFwDtk+Lnr1PQRMcNtyee6766z42/gWXiLhqbdfa9jaWSkmPTWd9z86MEgmDJ
         Vnh92bLCkCjrkTsuf07AAnU1QiYsZCiL/kXv8ZzcTZBiHfFvUJE4YobOzgf09KZisdLB
         wNsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc;
        bh=M5S6AbdkVVbSnSfN9/DAhnwSxKsAuBYodWwik9s6ZfI=;
        b=ri5PklXbPPJMbR+aF+cPwInTNoSq7FvX2XvaiNe0jTvOS80X8m0zMNzR4dFZgLY4Xv
         O7cygeONqBh3NwJH0s7ec+JN/Y9kmVs0THXYKYQSkQagn1HgFQXUDEZU6QP7KIMXJO0j
         fw7+zseOm8dzEV+nnqq9/iqpiR/HBeAw/48LgUkOXn+x3NYZQhytgrnAnIIIOHXomeJt
         5ZHun6IAEFY/lZZ4q9H9/kJzK0KOPCAwWNI5ed8sLd5e5f5MZlhKJJU0hjcOBl6VXqCr
         Ll7NJhiwDm6MXReXVv7ZizbA9diauCbk5SaIn4CzzP4tkO0l0DdlbzqBtFv2D75spfJU
         idOA==
X-Gm-Message-State: ACgBeo3ce9D2eiYJq7uqtn/fuv1xkKH4Y+/kuRXL0UcDvjHfA+0b/oLM
        Xi+ycM/rSMYB87LMZK9A9OhNIGTIqUBt
X-Google-Smtp-Source: AA6agR4VxwATvDhl8n87bMtS9U47mhZWWdFKxULZ6Sl7Ek669qjcQ5RdrwxIyMw70WScIz43kLNeoI/kn5FT
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:9c12:6eda:f67d:4ffb])
 (user=irogers job=sendgmr) by 2002:a5b:591:0:b0:66d:edde:4ca with SMTP id
 l17-20020a5b0591000000b0066dedde04camr20968031ybp.641.1660758555884; Wed, 17
 Aug 2022 10:49:15 -0700 (PDT)
Date:   Wed, 17 Aug 2022 10:49:09 -0700
Message-Id: <20220817174909.877139-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
Subject: [PATCH v4] perf: Align user space counter reading with code
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        Rob Herring <robh@kernel.org>
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

Align the user space counter reading documentation with the code in
perf_mmap__read_self. Previously the documentation was based on the perf
rdpmc test, but now general purpose code is provided by libperf.

Signed-off-by: Ian Rogers <irogers@google.com>
Reviewed-by: Rob Herring <robh@kernel.org>

v4. Is a rebase.
---
 include/uapi/linux/perf_event.h       | 35 +++++++++++++++++----------
 tools/include/uapi/linux/perf_event.h | 35 +++++++++++++++++----------
 2 files changed, 44 insertions(+), 26 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 03b370062741..f35c10aa71b9 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -541,9 +541,13 @@ struct perf_event_mmap_page {
 	 *
 	 *     if (pc->cap_usr_time && enabled != running) {
 	 *       cyc = rdtsc();
-	 *       time_offset = pc->time_offset;
 	 *       time_mult   = pc->time_mult;
 	 *       time_shift  = pc->time_shift;
+	 *       time_offset = pc->time_offset;
+	 *       if (pc->cap_user_time_short) {
+	 *         time_cycles = pc->time_cycles;
+	 *         time_mask = pc->time_mask;
+	 *       }
 	 *     }
 	 *
 	 *     index = pc->index;
@@ -551,6 +555,9 @@ struct perf_event_mmap_page {
 	 *     if (pc->cap_user_rdpmc && index) {
 	 *       width = pc->pmc_width;
 	 *       pmc = rdpmc(index - 1);
+	 *       pmc <<= 64 - width;
+	 *       pmc >>= 64 - width;
+	 *       count += pmc;
 	 *     }
 	 *
 	 *     barrier();
@@ -593,25 +600,27 @@ struct perf_event_mmap_page {
 	 * If cap_usr_time the below fields can be used to compute the time
 	 * delta since time_enabled (in ns) using rdtsc or similar.
 	 *
-	 *   u64 quot, rem;
-	 *   u64 delta;
-	 *
-	 *   quot = (cyc >> time_shift);
-	 *   rem = cyc & (((u64)1 << time_shift) - 1);
-	 *   delta = time_offset + quot * time_mult +
-	 *              ((rem * time_mult) >> time_shift);
+	 *   cyc = time_cycles + ((cyc - time_cycles) & time_mask);
+	 *   delta = time_offset + mul_u64_u32_shr(cyc, time_mult, time_shift);
 	 *
 	 * Where time_offset,time_mult,time_shift and cyc are read in the
-	 * seqcount loop described above. This delta can then be added to
-	 * enabled and possible running (if index), improving the scaling:
+	 * seqcount loop described above. mul_u64_u32_shr will compute:
+	 *
+	 *   (u64)(((unsigned __int128)cyc * time_mult) >> time_shift)
+	 *
+	 * This delta can then be added to enabled and possible running (if
+	 * index) to improve the scaling. Due to event multiplexing, running
+	 * may be zero and so care is needed to avoid division by zero.
 	 *
 	 *   enabled += delta;
 	 *   if (index)
 	 *     running += delta;
 	 *
-	 *   quot = count / running;
-	 *   rem  = count % running;
-	 *   count = quot * enabled + (rem * enabled) / running;
+	 *   if (running != 0) {
+	 *     quot = count / running;
+	 *     rem  = count % running;
+	 *     count = quot * enabled + (rem * enabled) / running;
+	 *   }
 	 */
 	__u16	time_shift;
 	__u32	time_mult;
diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 581ed4bdc062..9c93e521a6b0 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -541,9 +541,13 @@ struct perf_event_mmap_page {
 	 *
 	 *     if (pc->cap_usr_time && enabled != running) {
 	 *       cyc = rdtsc();
-	 *       time_offset = pc->time_offset;
 	 *       time_mult   = pc->time_mult;
 	 *       time_shift  = pc->time_shift;
+	 *       time_offset = pc->time_offset;
+	 *       if (pc->cap_user_time_short) {
+	 *         time_cycles = pc->time_cycles;
+	 *         time_mask = pc->time_mask;
+	 *       }
 	 *     }
 	 *
 	 *     index = pc->index;
@@ -551,6 +555,9 @@ struct perf_event_mmap_page {
 	 *     if (pc->cap_user_rdpmc && index) {
 	 *       width = pc->pmc_width;
 	 *       pmc = rdpmc(index - 1);
+	 *       pmc <<= 64 - width;
+	 *       pmc >>= 64 - width;
+	 *       count += pmc;
 	 *     }
 	 *
 	 *     barrier();
@@ -593,25 +600,27 @@ struct perf_event_mmap_page {
 	 * If cap_usr_time the below fields can be used to compute the time
 	 * delta since time_enabled (in ns) using rdtsc or similar.
 	 *
-	 *   u64 quot, rem;
-	 *   u64 delta;
-	 *
-	 *   quot = (cyc >> time_shift);
-	 *   rem = cyc & (((u64)1 << time_shift) - 1);
-	 *   delta = time_offset + quot * time_mult +
-	 *              ((rem * time_mult) >> time_shift);
+	 *   cyc = time_cycles + ((cyc - time_cycles) & time_mask);
+	 *   delta = time_offset + mul_u64_u32_shr(cyc, time_mult, time_shift);
 	 *
 	 * Where time_offset,time_mult,time_shift and cyc are read in the
-	 * seqcount loop described above. This delta can then be added to
-	 * enabled and possible running (if index), improving the scaling:
+	 * seqcount loop described above. mul_u64_u32_shr will compute:
+	 *
+	 *   (u64)(((unsigned __int128)cyc * time_mult) >> time_shift)
+	 *
+	 * This delta can then be added to enabled and possible running (if
+	 * index) to improve the scaling. Due to event multiplexing, running
+	 * may be zero and so care is needed to avoid division by zero.
 	 *
 	 *   enabled += delta;
 	 *   if (index)
 	 *     running += delta;
 	 *
-	 *   quot = count / running;
-	 *   rem  = count % running;
-	 *   count = quot * enabled + (rem * enabled) / running;
+	 *   if (running != 0) {
+	 *     quot = count / running;
+	 *     rem  = count % running;
+	 *     count = quot * enabled + (rem * enabled) / running;
+	 *   }
 	 */
 	__u16	time_shift;
 	__u32	time_mult;
-- 
2.37.1.595.g718a3a8f04-goog

