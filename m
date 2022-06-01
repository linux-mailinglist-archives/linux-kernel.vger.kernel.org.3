Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70753539DA0
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 08:59:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350079AbiFAG7A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 02:59:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350050AbiFAG6x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 02:58:53 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D632AC77;
        Tue, 31 May 2022 23:58:51 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id j7so1137810pjn.4;
        Tue, 31 May 2022 23:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C4OURF1zHZFFhVzsDI1Pk89wZ1Ejc7c9NHHrBvA5gsw=;
        b=VbvvzD9vYe1DHYsYmAj1Kklq1M14msRaqs339+solqCDvZghv6D+MrwAPf7MZry4bm
         ynnsmMHE9NFWLVen5sbW1MjYj0yEuNz7gk1TQgdDCyEtw03IPxGla2m97wU/eekLHNxH
         lvOB6jeE2EeeBaiQu0SJYj1Ah7Aqb9PoFrXtNNNA6rtbT91QfLnIcha8fiqjGLSp0fSa
         6nsjS7PLlTn2xxO1u9Ha2MsdMWi3ToLFxi386QBMMDEFS2hOs6K2SdnxyRO3d/GlaqPW
         I8qDhBzHP16ZvjGAbWO6C1zgc7TlbHN/l1Q2qIHUu4u0b25yEJyMWKaCphAWU5imUDKf
         qkKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=C4OURF1zHZFFhVzsDI1Pk89wZ1Ejc7c9NHHrBvA5gsw=;
        b=DWtUv/F6qCZW5m7wbsd2I9hu1MhuOWtuwaQdC0sc/xY/Dw+7+An2Ds8D0xDqUIHomO
         XbmOPQueraaj3NOYJmiecbbdea2Iyczz4l6SYW5RVqeNK3lCv7Kpf/L7Zyx2nrnvJAIq
         ArC3Rsh1q2JEoS05+m6MspzPErsDi62/Z5UbJJYUxbRg1aS9pKPKOqUfTlwzHOIhyF0o
         XNFst+UEgkVZsw0IqmaRSy6KWISZ5OzBx44fh7PQcmDzY5J/Nr+V3q/NWEH2FGnFYWuR
         aif/ChaE5rqUwKn4ePCsSlCeL9TvXoNstMbrrwod0Ia7Ee7Ry/m1vyxPno4WhQPv+OGu
         iA4w==
X-Gm-Message-State: AOAM532bzH5tZoHIhc37NwK9a+gK+cn9bVPEj7MpvyZYWb0suAW12KEy
        NelKeS0fIKObR++EVHd2CN8=
X-Google-Smtp-Source: ABdhPJyEr9majNavpLa8V6xpaG85gA6Dp6kEHB+hTRnTLHdltWzynmtYMJ6+mZ8IdnJx9EpfPzJ1LA==
X-Received: by 2002:a17:902:f70a:b0:153:88c7:774 with SMTP id h10-20020a170902f70a00b0015388c70774mr64365924plo.166.1654066731360;
        Tue, 31 May 2022 23:58:51 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:cb0:82d7:adf7:b62d:6020])
        by smtp.gmail.com with ESMTPSA id b10-20020a17090a5a0a00b001cd4989febcsm3207271pjd.8.2022.05.31.23.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 May 2022 23:58:51 -0700 (PDT)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH 2/5] perf lock: Add lock contention tracepoints record support
Date:   Tue, 31 May 2022 23:58:43 -0700
Message-Id: <20220601065846.456965-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220601065846.456965-1-namhyung@kernel.org>
References: <20220601065846.456965-1-namhyung@kernel.org>
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

When LOCKDEP and LOCK_STAT events are not available, it falls back to
record the new lock contention tracepoints.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-lock.c | 70 +++++++++++++++++++++++++++++++++++----
 1 file changed, 63 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 23a33ac15e68..3e3320b8cede 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -495,6 +495,12 @@ struct trace_lock_handler {
 
 	int (*release_event)(struct evsel *evsel,
 			     struct perf_sample *sample);
+
+	int (*contention_begin_event)(struct evsel *evsel,
+				      struct perf_sample *sample);
+
+	int (*contention_end_event)(struct evsel *evsel,
+				    struct perf_sample *sample);
 };
 
 static struct lock_seq_stat *get_seq(struct thread_stat *ts, u64 addr)
@@ -822,6 +828,20 @@ static int evsel__process_lock_release(struct evsel *evsel, struct perf_sample *
 	return 0;
 }
 
+static int evsel__process_contention_begin(struct evsel *evsel, struct perf_sample *sample)
+{
+	if (trace_handler->contention_begin_event)
+		return trace_handler->contention_begin_event(evsel, sample);
+	return 0;
+}
+
+static int evsel__process_contention_end(struct evsel *evsel, struct perf_sample *sample)
+{
+	if (trace_handler->contention_end_event)
+		return trace_handler->contention_end_event(evsel, sample);
+	return 0;
+}
+
 static void print_bad_events(int bad, int total)
 {
 	/* Output for debug, this have to be removed */
@@ -1023,6 +1043,11 @@ static const struct evsel_str_handler lock_tracepoints[] = {
 	{ "lock:lock_release",	 evsel__process_lock_release,   }, /* CONFIG_LOCKDEP */
 };
 
+static const struct evsel_str_handler contention_tracepoints[] = {
+	{ "lock:contention_begin", evsel__process_contention_begin, },
+	{ "lock:contention_end",   evsel__process_contention_end,   },
+};
+
 static bool force;
 
 static int __cmd_report(bool display_info)
@@ -1086,20 +1111,41 @@ static int __cmd_record(int argc, const char **argv)
 		"record", "-R", "-m", "1024", "-c", "1", "--synth", "task",
 	};
 	unsigned int rec_argc, i, j, ret;
+	unsigned int nr_tracepoints;
 	const char **rec_argv;
+	bool has_lock_stat = true;
 
 	for (i = 0; i < ARRAY_SIZE(lock_tracepoints); i++) {
 		if (!is_valid_tracepoint(lock_tracepoints[i].name)) {
-				pr_err("tracepoint %s is not enabled. "
-				       "Are CONFIG_LOCKDEP and CONFIG_LOCK_STAT enabled?\n",
-				       lock_tracepoints[i].name);
-				return 1;
+			pr_debug("tracepoint %s is not enabled. "
+				 "Are CONFIG_LOCKDEP and CONFIG_LOCK_STAT enabled?\n",
+				 lock_tracepoints[i].name);
+			has_lock_stat = false;
+			break;
+		}
+	}
+
+	if (has_lock_stat)
+		goto setup_args;
+
+	for (i = 0; i < ARRAY_SIZE(contention_tracepoints); i++) {
+		if (!is_valid_tracepoint(contention_tracepoints[i].name)) {
+			pr_err("tracepoint %s is not enabled.\n",
+			       contention_tracepoints[i].name);
+			return 1;
 		}
 	}
 
+setup_args:
 	rec_argc = ARRAY_SIZE(record_args) + argc - 1;
+
+	if (has_lock_stat)
+		nr_tracepoints = ARRAY_SIZE(lock_tracepoints);
+	else
+		nr_tracepoints = ARRAY_SIZE(contention_tracepoints);
+
 	/* factor of 2 is for -e in front of each tracepoint */
-	rec_argc += 2 * ARRAY_SIZE(lock_tracepoints);
+	rec_argc += 2 * nr_tracepoints;
 
 	rec_argv = calloc(rec_argc + 1, sizeof(char *));
 	if (!rec_argv)
@@ -1108,9 +1154,19 @@ static int __cmd_record(int argc, const char **argv)
 	for (i = 0; i < ARRAY_SIZE(record_args); i++)
 		rec_argv[i] = strdup(record_args[i]);
 
-	for (j = 0; j < ARRAY_SIZE(lock_tracepoints); j++) {
+	for (j = 0; j < nr_tracepoints; j++) {
+		const char *ev_name;
+
+		if (has_lock_stat)
+			ev_name = strdup(lock_tracepoints[j].name);
+		else
+			ev_name = strdup(contention_tracepoints[j].name);
+
+		if (!ev_name)
+			return -ENOMEM;
+
 		rec_argv[i++] = "-e";
-		rec_argv[i++] = strdup(lock_tracepoints[j].name);
+		rec_argv[i++] = ev_name;
 	}
 
 	for (j = 1; j < (unsigned int)argc; j++, i++)
-- 
2.36.1.255.ge46751e96f-goog

