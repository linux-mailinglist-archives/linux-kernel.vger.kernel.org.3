Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18DEA5991D0
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 02:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240015AbiHSAg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 20:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243261AbiHSAgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 20:36:50 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB28DEA78;
        Thu, 18 Aug 2022 17:36:49 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id x19so204899pfq.1;
        Thu, 18 Aug 2022 17:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=JozqI5HGaTqIqUqt2jBuKrvzFFJykmSG4D6AZASqs+k=;
        b=CraHROS+NJtL9SDztOre+0LV3k2cwcFvVDvpbMu+G5jpBWjogKNH90GAYIc18Aahxc
         63LxIuF5eZ0DLYq5BLvZKTePK/kNoYBhvUS1tCkpCQTqGk0J50qznbNkHyypeUxFjWAG
         4OIi+3wRMDOV82uwc0C4wg+PJQEZlzNpCoupgEjNBmYJLH2GqegJFjyNiWWiMmzr1wQg
         Q6jvMfoDSySu/gFWKB6ndFQ1Qu4xthMGs9F63iwCmDwtDPgN1KsL87WISz1XZK+1gRED
         m9Y6b4mN+T++RSsipMPkNIMeBVH8S2sBLWNOZlyhm3N9pNJ101VUVC8DrWEZq+NMLhf7
         3QgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=JozqI5HGaTqIqUqt2jBuKrvzFFJykmSG4D6AZASqs+k=;
        b=w289hpWwH8+4/z5pZqb+BhW7FAwJEM4G6ceq7+59bi4OgED35Mm81LXu5PHw89+FZA
         Pmcg55+aQYPstBnNBDOmWgAeX0O0sASv84VRnAb/MBRbmsxhemdspZ57qUniRrFm8BVU
         PBDdQ1rz6MXr4+R/PkRya9NWJx7YkwBdi377IOrAd1tPbx/6iaAMHvtQYXs9edsEAxCk
         ikidb+pYlkpWT3aks3ZfTvlUufIiYO4F8GiTP7oVXxUqmA8yUxjJwJq9KgfrrGpvZ+Jq
         DUY+wqvNHG0kK5gD9+6r6ptFm33yJTKhUWT7XBEN3cXXqMm4+UUedf99x/dTGCgUiOEH
         QmLQ==
X-Gm-Message-State: ACgBeo0kxfmQp03Po4ivjESxLDxGVKsvtVCuGYdsn0HbqTonl6tyIgIJ
        sRfpAlz6ZvAKXaSunp4tUhv1Rd0wfEOc/Q==
X-Google-Smtp-Source: AA6agR7jbzEls61dp0C+sz/vuCAt0Fo6xmASdDDEnzuR5s2axkwcpWNx+poX9JZL908ldPDxmiMgqw==
X-Received: by 2002:a05:6a00:14d3:b0:52f:918f:c3b8 with SMTP id w19-20020a056a0014d300b0052f918fc3b8mr5391066pfu.1.1660869409160;
        Thu, 18 Aug 2022 17:36:49 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:1040:436c:3fa9:2b77:a856])
        by smtp.gmail.com with ESMTPSA id e5-20020a17090a4a0500b001f303d149casm2057567pjh.50.2022.08.18.17.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 17:36:48 -0700 (PDT)
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
Date:   Thu, 18 Aug 2022 17:36:42 -0700
Message-Id: <20220819003644.508916-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
In-Reply-To: <20220819003644.508916-1-namhyung@kernel.org>
References: <20220819003644.508916-1-namhyung@kernel.org>
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

