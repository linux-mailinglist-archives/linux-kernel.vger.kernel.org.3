Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C59105AA086
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 21:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234791AbiIAT57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 15:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234747AbiIAT5s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 15:57:48 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C49883D6;
        Thu,  1 Sep 2022 12:57:47 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q63so55748pga.9;
        Thu, 01 Sep 2022 12:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=4VCsaeRAK1M38gR1W7ltGYYJiX1OmeYS/OXpgWUx2pk=;
        b=K91OI8cqSfGZ87/LqWuyFzhy5QO//6LNKqYC2/V9AgdqP7rpVEo6RBt9RaUSBwOsnw
         XXis8BSH34EeRPNIt/ND3dqiRlcWG5cSw2iUDWKO8isDLVF5MWKtCnvq0ZlsiN9V2kO2
         o0O3fA3Kk5ZiwiAL5jr+NXMNK2Pau+qFMv07E+M3/Slc/wCBtCSqVOQliHzjws1plDd5
         B8DA7NDFsY2vYWMurhgExRNd79fNJUduPLMxKGCTygRpwQh2glU5kdQDTqmZT53VBax2
         Omu4ez105e9KI6QHRczmB+KO3XnHk6CAEoMlRSbUixh3rhpMgiwz7j6Y4B/vywEh0EPV
         QcLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=4VCsaeRAK1M38gR1W7ltGYYJiX1OmeYS/OXpgWUx2pk=;
        b=7Ng7oQBBWMAWiMPm6sVw1oygynEseW5Jisx2rVGmUwLSp0Gb61Y2a12qagSmrbfo9h
         kJ/ZWA7yTI1iYjZ3GVRBJ9r6maXhIUGRSIM9yZxSbwG7ziPfjTnwgaisVb/it43noU3F
         86Q1JolHcxvuqtZdJ3UopWDmam0x5j4rfKRK/EPkERAl5yqKEvSIuPIFb/FejC32SL8k
         ytuJ97h4C8Wr9Daie1HzKJRIKrWQWgeooiw7fUtwIJz3hhBGmrAgzpK4lnTgeNKZbiW5
         VqbJVnGMtrGiRGvy4iqoi5L7P1wcqXtytSfht4alzIwnAAFyV39QanRZqDv9z84VOq0d
         1jKg==
X-Gm-Message-State: ACgBeo1nEh0dp+URgJIpEnqfqWQE1Ucqc6xAjmY+T36tBE1ueCSv9Nz6
        hS8oKFEvaR807r9Y0pxBdpK/CCSp5CY=
X-Google-Smtp-Source: AA6agR5w9JVc1SBmqasK71ColFwb7McTWisATESthVANEYSTuuH84iAEjoGb5SmIL6ONqJigQedh4A==
X-Received: by 2002:a05:6a00:1889:b0:538:2efa:ff7a with SMTP id x9-20020a056a00188900b005382efaff7amr21769066pfh.2.1662062267274;
        Thu, 01 Sep 2022 12:57:47 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:87ff:65c0:eb6a:d2b3])
        by smtp.gmail.com with ESMTPSA id z10-20020a17090a1fca00b001fb23c28e9asm3728500pjz.2.2022.09.01.12.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 12:57:46 -0700 (PDT)
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
Subject: [PATCH 3/5] perf record: Read and inject LOST_SAMPLES events
Date:   Thu,  1 Sep 2022 12:57:37 -0700
Message-Id: <20220901195739.668604-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220901195739.668604-1-namhyung@kernel.org>
References: <20220901195739.668604-1-namhyung@kernel.org>
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

When there are lost samples, it can read the number of PERF_FORMAT_LOST and
convert it to PERF_RECORD_LOST_SAMPLES and write to the data file at the end.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-record.c | 64 +++++++++++++++++++++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index bce8c941d558..9df77b81a3bb 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -10,6 +10,7 @@
 
 #include "util/build-id.h"
 #include <subcmd/parse-options.h>
+#include <internal/xyarray.h>
 #include "util/parse-events.h"
 #include "util/config.h"
 
@@ -1852,6 +1853,68 @@ record__switch_output(struct record *rec, bool at_exit)
 	return fd;
 }
 
+static void __record__read_lost_samples(struct record *rec, struct evsel *evsel,
+					struct perf_record_lost_samples *lost,
+					int cpu_idx, int thread_idx)
+{
+	struct perf_counts_values count;
+	struct perf_sample_id *sid;
+	struct perf_sample sample = {};
+	int id_hdr_size;
+
+	if (perf_evsel__read(&evsel->core, cpu_idx, thread_idx, &count) < 0) {
+		pr_err("read LOST count failed\n");
+		return;
+	}
+
+	if (count.lost == 0)
+		return;
+
+	lost->lost = count.lost;
+	if (evsel->core.ids) {
+		sid = xyarray__entry(evsel->core.sample_id, cpu_idx, thread_idx);
+		sample.id = sid->id;
+	}
+
+	id_hdr_size = perf_event__synthesize_id_sample((void *)(lost + 1),
+						       evsel->core.attr.sample_type, &sample);
+	lost->header.size = sizeof(*lost) + id_hdr_size;
+	record__write(rec, NULL, lost, lost->header.size);
+}
+
+static void record__read_lost_samples(struct record *rec)
+{
+	struct perf_session *session = rec->session;
+	struct perf_record_lost_samples *lost;
+	struct evsel *evsel;
+
+	lost = zalloc(PERF_SAMPLE_MAX_SIZE);
+	if (lost == NULL) {
+		pr_debug("Memory allocation failed\n");
+		return;
+	}
+
+	lost->header.type = PERF_RECORD_LOST_SAMPLES;
+
+	evlist__for_each_entry(session->evlist, evsel) {
+		struct xyarray *xy = evsel->core.sample_id;
+
+		if (xyarray__max_x(evsel->core.fd) != xyarray__max_x(xy) ||
+		    xyarray__max_y(evsel->core.fd) != xyarray__max_y(xy)) {
+			pr_debug("Unmatched FD vs. sample ID: skip reading LOST count\n");
+			continue;
+		}
+
+		for (int x = 0; x < xyarray__max_x(xy); x++) {
+			for (int y = 0; y < xyarray__max_y(xy); y++) {
+				__record__read_lost_samples(rec, evsel, lost, x, y);
+			}
+		}
+	}
+	free(lost);
+
+}
+
 static volatile int workload_exec_errno;
 
 /*
@@ -2710,6 +2773,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	if (rec->off_cpu)
 		rec->bytes_written += off_cpu_write(rec->session);
 
+	record__read_lost_samples(rec);
 	record__synthesize(rec, true);
 	/* this will be recalculated during process_buildids() */
 	rec->samples = 0;
-- 
2.37.2.789.g6183377224-goog

