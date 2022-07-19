Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E971D57A9EB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 00:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238898AbiGSWkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 18:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbiGSWj5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 18:39:57 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 375D85F103
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 15:39:56 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-31e62f7b377so14813617b3.17
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 15:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l87gG1WyC4n1XKCTQzQ6qazcqKsuewxndKvm1gZMqNQ=;
        b=GTxObVcma+OcUlt/RnVXBWHWI4KnrfiNrO5lDyplvM6yo7182eICqUB6x2Wl+NbEer
         M54pE1TuHvRTApLXtPeGwM5mpKetvKOXdWsMkq26IfDWWVzmpFooeBaY3cOUTimWCuTd
         M3/1azLothgNl6qSa+GrXNMdQEbROeVbsE+4r19QHWHYM3yJqg2Vae3L46SFFdc0x7I0
         Xx9jzeBCNgBobbaltASj+3pvzt2xDcNX+P3M/ZCl3pe3kgkUavXfmrPnKlD6tsw3JS+2
         IctNJddyGi7PfCvwcEa1mb0M3uy5zeibKR6Ci9+we7xQnS28r5fbELtewJ1Cgj94H2UI
         s4oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l87gG1WyC4n1XKCTQzQ6qazcqKsuewxndKvm1gZMqNQ=;
        b=SM17Bb4/4LuSBSfLUov/y2kZFIWRFrg3nh125ySMedP9+rA93/ZnpSKXv3ennujiz5
         7vUzdV92oEjAnLzad06qgIYNrOIhrOCbxiIz5gTs8kSTjE1CP6311SUZDIWlRnUPuckM
         r/+qzFJcyCtrymZnKS+8L/3OwOYRm8cDxcsjLxbvPpHSZRKQ98MtE7MqPH9PAPeY/+I3
         Fm6s3IfPpWJFsI3GfPxclb/xqnj2ug/8Eu1WRENji+tm54JHNdznu0O6s80IrBhs6qPI
         Jcouvsb2KAYXIUV0p9NeV25KgGNYD8Yh8WZmcTBk251fpbpEfCYoM/M4d8bLtfBDSFeI
         9yqg==
X-Gm-Message-State: AJIora8hRNaul8qrl7vE5YhLK/6HD8Y4mAIKWCZ84vJgStLse3n3DyeO
        7wyOKCN+ujjOxAs4cKmZE9/KihXXE0US
X-Google-Smtp-Source: AGRyM1sdo635dOXyXBIo0JfgAEuPZQ6T6iA4rAc3JR3JXFDiiyUG5qbf5vTPHLLd3x4XmowuZLmFd2ee+J+p
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:1251:e27b:f589:696c])
 (user=irogers job=sendgmr) by 2002:a81:e44:0:b0:31e:6077:45c0 with SMTP id
 65-20020a810e44000000b0031e607745c0mr4575757ywo.490.1658270395365; Tue, 19
 Jul 2022 15:39:55 -0700 (PDT)
Date:   Tue, 19 Jul 2022 15:39:44 -0700
In-Reply-To: <20220719223946.176299-1-irogers@google.com>
Message-Id: <20220719223946.176299-2-irogers@google.com>
Mime-Version: 1.0
References: <20220719223946.176299-1-irogers@google.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
Subject: [PATCH v3 1/3] perf: Align user space counter reading with code
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
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Align the user space counter reading documentation with the code in
perf_mmap__read_self. Previously the documentation was based on the perf
rdpmc test, but now general purpose code is provided by libperf.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 include/uapi/linux/perf_event.h       | 35 +++++++++++++++++----------
 tools/include/uapi/linux/perf_event.h | 35 +++++++++++++++++----------
 2 files changed, 44 insertions(+), 26 deletions(-)

diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index d37629dbad72..6826dabb7e03 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -538,9 +538,13 @@ struct perf_event_mmap_page {
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
@@ -548,6 +552,9 @@ struct perf_event_mmap_page {
 	 *     if (pc->cap_user_rdpmc && index) {
 	 *       width = pc->pmc_width;
 	 *       pmc = rdpmc(index - 1);
+	 *       pmc <<= 64 - width;
+	 *       pmc >>= 64 - width;
+	 *       count += pmc;
 	 *     }
 	 *
 	 *     barrier();
@@ -590,25 +597,27 @@ struct perf_event_mmap_page {
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
index d37629dbad72..6826dabb7e03 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -538,9 +538,13 @@ struct perf_event_mmap_page {
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
@@ -548,6 +552,9 @@ struct perf_event_mmap_page {
 	 *     if (pc->cap_user_rdpmc && index) {
 	 *       width = pc->pmc_width;
 	 *       pmc = rdpmc(index - 1);
+	 *       pmc <<= 64 - width;
+	 *       pmc >>= 64 - width;
+	 *       count += pmc;
 	 *     }
 	 *
 	 *     barrier();
@@ -590,25 +597,27 @@ struct perf_event_mmap_page {
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
2.37.0.170.g444d1eabd0-goog

