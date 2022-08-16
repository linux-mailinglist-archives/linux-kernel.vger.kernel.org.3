Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C399259655F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 00:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237944AbiHPWSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 18:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238000AbiHPWRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 18:17:53 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA838901AD;
        Tue, 16 Aug 2022 15:17:52 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id 17so10473340pli.0;
        Tue, 16 Aug 2022 15:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=JozqI5HGaTqIqUqt2jBuKrvzFFJykmSG4D6AZASqs+k=;
        b=VtebnvoeSwqIJoYSMWLDIqk72k0WBw9KRGwVuMkxBTV+kVJbz382YZcC1Bh4PeJKDi
         jVGpjeDqA+UN/hY57cSxT9cV94aByX0LSqfjKGkRG0D+E+RaC2eXi89mO6wzmkBLXlCp
         b+/4p7ixrkyj9alGoPisGY3uDxAUC7MMy5ZDrbXZtMM9Zqd3Fh+ymQjX/aZzywr2EmrC
         n78P/0Eo/xnGZubCBZ2k5KxoQgrh5kNPZm/fBd+pABXr721HKEPYfPRk1kmH7VjiP02V
         JhBrNxF1I7RKLY26Q6M5tjtBCW6eU5IY4k3ZmQiydKqQ7JA92nSxMt57cALmYDB1pq0/
         dLEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=JozqI5HGaTqIqUqt2jBuKrvzFFJykmSG4D6AZASqs+k=;
        b=X8INFlMme+ccvZIXQc/wopQRlacSL11jUY2QoRaz0P1LO4zp80te040ompZhNo5szq
         jXRGef0AGdEH+57MWulC3QSOBrfx1EEaPXQdEUcSd0P9frRLgWaYCsybVJxrox1gh3DN
         pSL9Zm2dowQSzdYXulAXvXi9oS7qXxqjuxD36ebDUvbhlntoTHSeQvXh4r8wvluxXi8+
         +5voS+noj6smcs0dFLTmgT7sZSElA06sVyhSYicNDcNgbM+JXGGbp1eBLXlgTT4q64cZ
         URQ6PHRMuNMWn64Hvgo6mkkfoLqP9XqTydW0EjwOJwIpR6MpY8bFF3M0EMqFJrYZyqu8
         89hQ==
X-Gm-Message-State: ACgBeo1UlzAMuS5iuWZS64+8dgzk6J3gUBw9927UVhQrE4VWBKW+Z3X9
        dqzGDlIGrLwaidlPhirGNc8=
X-Google-Smtp-Source: AA6agR4+XvQZ7aOAhSU041b+KS5YR/g0e4WbsOo9eIXerUgE/wmCqsWxyvnBw57wAivJWNsE+n2YoA==
X-Received: by 2002:a17:90b:4a06:b0:1f4:e4fc:91ed with SMTP id kk6-20020a17090b4a0600b001f4e4fc91edmr720840pjb.152.1660688272055;
        Tue, 16 Aug 2022 15:17:52 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:d539:e967:9fd8:5c81])
        by smtp.gmail.com with ESMTPSA id 3-20020a620603000000b0052b7f0ff197sm8965943pfg.49.2022.08.16.15.17.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Aug 2022 15:17:51 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 2/4] tools lib perf: Handle read format in perf_evsel__read()
Date:   Tue, 16 Aug 2022 15:17:45 -0700
Message-Id: <20220816221747.275828-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
In-Reply-To: <20220816221747.275828-1-namhyung@kernel.org>
References: <20220816221747.275828-1-namhyung@kernel.org>
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

The perf_counts_values should be increased to read the new lost data.
Also adjust values after read according the read format.

This supports PERF_FORMAT_GROUP which has a different data format but
it's only available for leader events.  Currently it doesn't have an API
to read sibling (member) events in the group.  But users may read the
sibling event directly.

Also reading from mmap would be disabled when the read format has ID or
LOST bit as it's not exposed via mmap.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/lib/perf/evsel.c              | 79 ++++++++++++++++++++++++++++-
 tools/lib/perf/include/perf/event.h |  3 +-
 tools/lib/perf/include/perf/evsel.h |  4 +-
 3 files changed, 83 insertions(+), 3 deletions(-)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 952f3520d5c2..8ce5bbd09666 100644
--- a/tools/lib/perf/evsel.c
+++ b/tools/lib/perf/evsel.c
@@ -305,6 +305,9 @@ int perf_evsel__read_size(struct perf_evsel *evsel)
 	if (read_format & PERF_FORMAT_ID)
 		entry += sizeof(u64);
 
+	if (read_format & PERF_FORMAT_LOST)
+		entry += sizeof(u64);
+
 	if (read_format & PERF_FORMAT_GROUP) {
 		nr = evsel->nr_members;
 		size += sizeof(u64);
@@ -314,24 +317,98 @@ int perf_evsel__read_size(struct perf_evsel *evsel)
 	return size;
 }
 
+/* This only reads values for the leader */
+static int perf_evsel__read_group(struct perf_evsel *evsel, int cpu_map_idx,
+				  int thread, struct perf_counts_values *count)
+{
+	size_t size = perf_evsel__read_size(evsel);
+	int *fd = FD(evsel, cpu_map_idx, thread);
+	u64 read_format = evsel->attr.read_format;
+	u64 *data;
+	int idx = 1;
+
+	if (fd == NULL || *fd < 0)
+		return -EINVAL;
+
+	data = calloc(1, size);
+	if (data == NULL)
+		return -ENOMEM;
+
+	if (readn(*fd, data, size) <= 0) {
+		free(data);
+		return -errno;
+	}
+
+	/*
+	 * This reads only the leader event intentionally since we don't have
+	 * perf counts values for sibling events.
+	 */
+	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
+		count->ena = data[idx++];
+	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
+		count->run = data[idx++];
+
+	/* value is always available */
+	count->val = data[idx++];
+	if (read_format & PERF_FORMAT_ID)
+		count->id = data[idx++];
+	if (read_format & PERF_FORMAT_LOST)
+		count->lost = data[idx++];
+
+	free(data);
+	return 0;
+}
+
+/*
+ * The perf read format is very flexible.  It needs to set the proper
+ * values according to the read format.
+ */
+static void perf_evsel__adjust_values(struct perf_evsel *evsel, u64 *buf,
+				      struct perf_counts_values *count)
+{
+	u64 read_format = evsel->attr.read_format;
+	int n = 0;
+
+	count->val = buf[n++];
+
+	if (read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)
+		count->ena = buf[n++];
+
+	if (read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)
+		count->run = buf[n++];
+
+	if (read_format & PERF_FORMAT_ID)
+		count->id = buf[n++];
+
+	if (read_format & PERF_FORMAT_LOST)
+		count->lost = buf[n++];
+}
+
 int perf_evsel__read(struct perf_evsel *evsel, int cpu_map_idx, int thread,
 		     struct perf_counts_values *count)
 {
 	size_t size = perf_evsel__read_size(evsel);
 	int *fd = FD(evsel, cpu_map_idx, thread);
+	u64 read_format = evsel->attr.read_format;
+	struct perf_counts_values buf;
 
 	memset(count, 0, sizeof(*count));
 
 	if (fd == NULL || *fd < 0)
 		return -EINVAL;
 
+	if (read_format & PERF_FORMAT_GROUP)
+		return perf_evsel__read_group(evsel, cpu_map_idx, thread, count);
+
 	if (MMAP(evsel, cpu_map_idx, thread) &&
+	    !(read_format & (PERF_FORMAT_ID | PERF_FORMAT_LOST)) &&
 	    !perf_mmap__read_self(MMAP(evsel, cpu_map_idx, thread), count))
 		return 0;
 
-	if (readn(*fd, count->values, size) <= 0)
+	if (readn(*fd, buf.values, size) <= 0)
 		return -errno;
 
+	perf_evsel__adjust_values(evsel, buf.values, count);
 	return 0;
 }
 
diff --git a/tools/lib/perf/include/perf/event.h b/tools/lib/perf/include/perf/event.h
index 556bb06798f2..38dd35cbca71 100644
--- a/tools/lib/perf/include/perf/event.h
+++ b/tools/lib/perf/include/perf/event.h
@@ -76,7 +76,7 @@ struct perf_record_lost_samples {
 };
 
 /*
- * PERF_FORMAT_ENABLED | PERF_FORMAT_RUNNING | PERF_FORMAT_ID
+ * PERF_FORMAT_ENABLED | PERF_FORMAT_RUNNING | PERF_FORMAT_ID | PERF_FORMAT_LOST
  */
 struct perf_record_read {
 	struct perf_event_header header;
@@ -85,6 +85,7 @@ struct perf_record_read {
 	__u64			 time_enabled;
 	__u64			 time_running;
 	__u64			 id;
+	__u64			 lost;
 };
 
 struct perf_record_throttle {
diff --git a/tools/lib/perf/include/perf/evsel.h b/tools/lib/perf/include/perf/evsel.h
index 699c0ed97d34..6f92204075c2 100644
--- a/tools/lib/perf/include/perf/evsel.h
+++ b/tools/lib/perf/include/perf/evsel.h
@@ -18,8 +18,10 @@ struct perf_counts_values {
 			uint64_t val;
 			uint64_t ena;
 			uint64_t run;
+			uint64_t id;
+			uint64_t lost;
 		};
-		uint64_t values[3];
+		uint64_t values[5];
 	};
 };
 
-- 
2.37.1.595.g718a3a8f04-goog

