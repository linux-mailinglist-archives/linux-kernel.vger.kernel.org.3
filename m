Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 782B3593CFB
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 22:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346944AbiHOUa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 16:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245187AbiHOUWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 16:22:19 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FC3357C7;
        Mon, 15 Aug 2022 12:02:43 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 202so7241484pgc.8;
        Mon, 15 Aug 2022 12:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc;
        bh=T1urwYp+ngUfbtL/zRS1WH8Fw+1Y+MfmKi5JR02MB5Y=;
        b=aZUuvkegx2ruNP8I4pY27Gd7ajx8X7gfwOxSAZ3xO1ObIxlYQCyO+KsPGzDJdleVTv
         hGYNLNcK1bd4lx7e5tOpFAVQQat1kKKrbOnhbZVf/vzXlCVLycrJBvSo6GZqBb6xhon5
         w64+6nGYOe1CU8KjLKooaF5XJnYY8fFQJIANLHPyxTrE+i+T6NqwBCvLV8/DRuCUYsVA
         cbR9a22h60S3UnNmRA4/ngshmTMqszxt1Y/9kGjBtpqXsMHLcCKLBOs0rr1NgThW2cy9
         LhoEHznxETNRdAg9+KRCxsNXk5Ty5LZSCMAlrb7JiEuMhWSsGVgcw33aSwNl8id53TRG
         zFgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc;
        bh=T1urwYp+ngUfbtL/zRS1WH8Fw+1Y+MfmKi5JR02MB5Y=;
        b=ugGFFmcTUOaFdGFh2TRcZ/ZM6P5MTbzHZfBD886PY0uaoDJl/R1B8+8mSMtQFu4f5q
         uiDvSp80rxDrtqFRVJxOl5b6HZoJOg6pyKbxdfvfB7un76+Xlwm1/a4e1pX6eye1v7kr
         CpHMdrWIrp8ZJIDcWXK5YWfCQuOkjdCkXYpNcH7yPWIkswLCAvfFZL/NVPKetHAnHKn7
         wPMUKFvQrAI9JkXQsz+Hg7dcvU/cCFP5nQNWhv+nF3l57Mt/7G6oanAq2MxXJk5YmOZW
         884JzrUkXgjKWHAABLIQpSQMV9FT3cpi61P6aBNQBgRaGY1nOrYEM8+UuTIn5UQQAyRk
         ajCg==
X-Gm-Message-State: ACgBeo2tjXUSsEOHe3oUC6b/Gyz+wN4qxJ/ELJw/li2Y34lg9vKFDddi
        HSXmkd5NPxg7IRsQDp77CaA=
X-Google-Smtp-Source: AA6agR4b/ybl6R8xhfXlQvXXGF/WKD/S1mp5KP2qIF0fDxTUUsj1b0ep3zp3dknndIRIq/PtXohsXA==
X-Received: by 2002:a63:db06:0:b0:41d:f6f6:49d0 with SMTP id e6-20020a63db06000000b0041df6f649d0mr14624683pgg.83.1660590163000;
        Mon, 15 Aug 2022 12:02:43 -0700 (PDT)
Received: from youngsil.svl.corp.google.com ([2620:15c:2d4:203:df3e:22e0:b905:822b])
        by smtp.gmail.com with ESMTPSA id q13-20020a170902a3cd00b0016a4db13429sm7266926plb.192.2022.08.15.12.02.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 12:02:42 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH 2/4] tools lib perf: Handle read format in perf_evsel__read()
Date:   Mon, 15 Aug 2022 12:01:04 -0700
Message-Id: <20220815190106.1293082-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.37.1.595.g718a3a8f04-goog
In-Reply-To: <20220815190106.1293082-1-namhyung@kernel.org>
References: <20220815190106.1293082-1-namhyung@kernel.org>
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
 tools/lib/perf/evsel.c              | 72 +++++++++++++++++++++++++++++
 tools/lib/perf/include/perf/event.h |  3 +-
 tools/lib/perf/include/perf/evsel.h |  4 +-
 3 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/tools/lib/perf/evsel.c b/tools/lib/perf/evsel.c
index 952f3520d5c2..fc23670231cb 100644
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
@@ -314,24 +317,93 @@ int perf_evsel__read_size(struct perf_evsel *evsel)
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
+static void perf_evsel__adjust_values(struct perf_evsel *evsel,
+				      struct perf_counts_values *count)
+{
+	u64 read_format = evsel->attr.read_format;
+
+	if (!(read_format & PERF_FORMAT_TOTAL_TIME_ENABLED)) {
+		memmove(&count->values[2], &count->values[1], 24);
+		count->ena = 0;
+	}
+
+	if (!(read_format & PERF_FORMAT_TOTAL_TIME_RUNNING)) {
+		memmove(&count->values[3], &count->values[2], 16);
+		count->run = 0;
+	}
+
+	if (!(read_format & PERF_FORMAT_ID)) {
+		memmove(&count->values[4], &count->values[3], 8);
+		count->id = 0;
+	}
+}
+
 int perf_evsel__read(struct perf_evsel *evsel, int cpu_map_idx, int thread,
 		     struct perf_counts_values *count)
 {
 	size_t size = perf_evsel__read_size(evsel);
 	int *fd = FD(evsel, cpu_map_idx, thread);
+	u64 read_format = evsel->attr.read_format;
 
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
 
 	if (readn(*fd, count->values, size) <= 0)
 		return -errno;
 
+	perf_evsel__adjust_values(evsel, count);
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

