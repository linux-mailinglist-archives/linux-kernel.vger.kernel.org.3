Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 774485A87E0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 23:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232075AbiHaVEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 17:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232115AbiHaVEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 17:04:06 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053E5F2D6D;
        Wed, 31 Aug 2022 14:04:04 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 78so1047546pgb.13;
        Wed, 31 Aug 2022 14:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date;
        bh=PljIzC2kef7tvsQZuyC5v+5hanwzmlHbh3BhWszm894=;
        b=UuvmYcB1J1nrG5wI+zEpzL0ViJbXSxPTcJvz7g4qvlOJSZzVHm25i2E9Pjemeun2mx
         VVEhAIw0rK/Hm8Rhk9+vQrLkRPgkuPK0hrvFLDpYShP50KLiGjf82xQ0eT22HclGeHve
         A6QWURZ/4P7gTlb5oQv4VjMw70Ooj+rd539oEYtes96jo/BcNVvRaXp8CIK9Yu1WOhPc
         3jwLpRG6ttG7A9GdejfVol5HwHXajjOLya/5MgNa7qnw9pUo7B/y+DrmEc4U+jatokBZ
         zRQvOtCnnXRLABPrQlgFbP5eAUo17200Ke1B8q0aKasZvDVusfrUt6GfU1qYvjoGilv0
         uonQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date;
        bh=PljIzC2kef7tvsQZuyC5v+5hanwzmlHbh3BhWszm894=;
        b=Tae2rSmZrDAQBiP/rs5+ZJhJqF1kC47GoyPKu31lmKr+j0q77w3QZOUoMsn5Mq8djF
         Wp45eDUyxMXD07lXwBUipCWhG0jEzVQFn6JNe3oCcuzcnYPDNWvepakdKvgt/mtEiPFT
         DNOknimgmsR9pnvgxw886+ogR7/vECrj0ZRDeepYwkZLT7RIn0dldbPzNGZNjBj+eFRz
         PAi89wzrmRSPXJeKFH/eIzA1sL8uxO7RKlyYt3AE2qNl/lQlNWsZbtA/MYJAWF0e+ztL
         9PAJAkud8DF+DJh281ar5hD1oy1e6MUDF8r0JtXqXbaNVvA3bhPe5vwles17MKzfD0bm
         qJrg==
X-Gm-Message-State: ACgBeo0O0GnMa9GhpsOYwm8P8yG3eEw9lJxYUwBXHYuonx34Ez5c8kN6
        /KDy5a5zm099s18xhvFK1Fs=
X-Google-Smtp-Source: AA6agR7sHvX1Rh3LfdsgqW5KGCobSnEu5m7T/adGfdJ3FA/cNm1anIMbtwtpuZIQMgfJEAw2PI1mGQ==
X-Received: by 2002:a05:6a00:3306:b0:538:444d:87d3 with SMTP id cq6-20020a056a00330600b00538444d87d3mr15707684pfb.38.1661979844448;
        Wed, 31 Aug 2022 14:04:04 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:4a6a:d1f4:9cf7:d0fb])
        by smtp.gmail.com with ESMTPSA id e27-20020a056a0000db00b0053ae6a3c51asm528931pfj.186.2022.08.31.14.04.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 14:04:03 -0700 (PDT)
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
Date:   Wed, 31 Aug 2022 14:03:50 -0700
Message-Id: <20220831210352.145753-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220831210352.145753-1-namhyung@kernel.org>
References: <20220831210352.145753-1-namhyung@kernel.org>
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
 tools/perf/builtin-record.c | 60 +++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index bce8c941d558..cb9881543a07 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -10,6 +10,7 @@
 
 #include "util/build-id.h"
 #include <subcmd/parse-options.h>
+#include <internal/xyarray.h>
 #include "util/parse-events.h"
 #include "util/config.h"
 
@@ -1852,6 +1853,64 @@ record__switch_output(struct record *rec, bool at_exit)
 	return fd;
 }
 
+static void __record__read_lost_samples(struct record *rec, struct evsel *evsel,
+					struct perf_record_lost_samples *lost,
+					int size, int cpu_idx, int thread_idx)
+{
+	struct perf_counts_values count;
+	struct perf_sample_id *sid;
+	struct perf_sample sample = {};
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
+	perf_event__synthesize_id_sample((void *)(lost + 1),
+					 evsel->core.attr.sample_type, &sample);
+	record__write(rec, NULL, lost, size);
+}
+
+static void record__read_lost_samples(struct record *rec)
+{
+	struct perf_session *session = rec->session;
+	struct machine *machine = &session->machines.host;
+	struct perf_record_lost_samples *lost;
+	struct evsel *evsel;
+	int size = sizeof(*lost) + machine->id_hdr_size;
+
+	lost = zalloc(size);
+	lost->header.type = PERF_RECORD_LOST_SAMPLES;
+	lost->header.size = size;
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
+				__record__read_lost_samples(rec, evsel, lost,
+							    size, x, y);
+			}
+		}
+	}
+
+}
+
 static volatile int workload_exec_errno;
 
 /*
@@ -2710,6 +2769,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 	if (rec->off_cpu)
 		rec->bytes_written += off_cpu_write(rec->session);
 
+	record__read_lost_samples(rec);
 	record__synthesize(rec, true);
 	/* this will be recalculated during process_buildids() */
 	rec->samples = 0;
-- 
2.37.2.789.g6183377224-goog

