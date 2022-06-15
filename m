Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E39954CEB3
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 18:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356481AbiFOQcw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 12:32:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355839AbiFOQce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 12:32:34 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A25F32;
        Wed, 15 Jun 2022 09:32:32 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id r1so10840198plo.10;
        Wed, 15 Jun 2022 09:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g0LEEWlXezf+DhFRy9/pJdwTKt3G7SKknYeUYVPZCxM=;
        b=gJuHVdi6Ti69f8k/SlQXnh47mkTQADBNZoRt93YNZljieaGute7CEd85HbP3/Lq0wS
         GqsGLEYp1+/OK+1q4dELM4L2DXm85LLmoqmB7Is7WHECpcbtHIcy2noI979okT4ye8MM
         rm5+FNM+xn/qpRbU6AQxBjoeHScabwaRtIUULaf7vuJFu+aA/PLvNgFEtk4wPFae790i
         ef75F3pH1dcExyVIMaHh/F+DpPhLLQQzqDYmgGOJXPI48TdP/RrenEf3dYvqkBBvsbJR
         dbLil3WXKCe0TQRqLwdsS6nsN+O4PXfzKGs2RFBZcPquIRlvbLYlrRBVCCkK7q7Q7wGR
         MJZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=g0LEEWlXezf+DhFRy9/pJdwTKt3G7SKknYeUYVPZCxM=;
        b=W6OFexr2X6XdTjsbnOzJCIJfTgvUGQn6UqyetY8zeAcYrodqfiYMjg0Ws8i2Hu4jxn
         GZcqifDq0NzPOBDVQf3HAdw7lCOupC3olhRUrW0tBiRtCh/Ew9jUIYsKJ+t7qpHSeEhX
         LHPwya/Q89rwEjrlLF4pPL5IlYNsMnUy9kFsjjHLYFaUt1mQA5910GQs9Sgmky5seieV
         8VIeFl3lrVL5pEj2h1ejg0CccfAeMq8VyyCIS0b4KE+7fmN124uyoBGI0tgVOLdnIGvV
         4Lx2Pts7qXmmqWeWTRZgVv04Xx2qJwJfTu8mSU7in8CXgGLnE6G5iPNHcNDA6hPgahmj
         CEDg==
X-Gm-Message-State: AJIora/95sCOTpFIKiV1I4leTXGAFM/G0xV3yi5dqduMmNswSAjTHASC
        oXByhGNttNPZNPicqnPxNqI=
X-Google-Smtp-Source: AGRyM1tXYCUbi3hdkahvHXXQxj/n2yEqmpnM0U3PsQEJFkXZBmNM/Qv4llH5lWFX+IFFfRNBykY0Ag==
X-Received: by 2002:a17:902:da88:b0:167:5b56:8edb with SMTP id j8-20020a170902da8800b001675b568edbmr455594plx.71.1655310751504;
        Wed, 15 Jun 2022 09:32:31 -0700 (PDT)
Received: from balhae.corp.google.com ([2620:15c:2c1:200:6b99:92ca:1efa:c0fb])
        by smtp.gmail.com with ESMTPSA id q23-20020a170902edd700b00168bffd39a1sm9583881plk.143.2022.06.15.09.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 09:32:30 -0700 (PDT)
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
Subject: [PATCH 4/7] perf lock: Add lock contention tracepoints record support
Date:   Wed, 15 Jun 2022 09:32:19 -0700
Message-Id: <20220615163222.1275500-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.1.476.g0c4daa206d-goog
In-Reply-To: <20220615163222.1275500-1-namhyung@kernel.org>
References: <20220615163222.1275500-1-namhyung@kernel.org>
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
 tools/perf/builtin-lock.c | 76 +++++++++++++++++++++++++++++++++++----
 1 file changed, 69 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 2337b09dd2cd..9e3b90cac505 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -516,17 +516,29 @@ static struct lock_stat *lock_stat_findnew(u64 addr, const char *name)
 }
 
 struct trace_lock_handler {
+	/* it's used on CONFIG_LOCKDEP */
 	int (*acquire_event)(struct evsel *evsel,
 			     struct perf_sample *sample);
 
+	/* it's used on CONFIG_LOCKDEP && CONFIG_LOCK_STAT */
 	int (*acquired_event)(struct evsel *evsel,
 			      struct perf_sample *sample);
 
+	/* it's used on CONFIG_LOCKDEP && CONFIG_LOCK_STAT */
 	int (*contended_event)(struct evsel *evsel,
 			       struct perf_sample *sample);
 
+	/* it's used on CONFIG_LOCKDEP */
 	int (*release_event)(struct evsel *evsel,
 			     struct perf_sample *sample);
+
+	/* it's used when CONFIG_LOCKDEP is off */
+	int (*contention_begin_event)(struct evsel *evsel,
+				      struct perf_sample *sample);
+
+	/* it's used when CONFIG_LOCKDEP is off */
+	int (*contention_end_event)(struct evsel *evsel,
+				    struct perf_sample *sample);
 };
 
 static struct lock_seq_stat *get_seq(struct thread_stat *ts, u64 addr)
@@ -854,6 +866,20 @@ static int evsel__process_lock_release(struct evsel *evsel, struct perf_sample *
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
@@ -1062,6 +1088,11 @@ static const struct evsel_str_handler lock_tracepoints[] = {
 	{ "lock:lock_release",	 evsel__process_lock_release,   }, /* CONFIG_LOCKDEP */
 };
 
+static const struct evsel_str_handler contention_tracepoints[] = {
+	{ "lock:contention_begin", evsel__process_contention_begin, },
+	{ "lock:contention_end",   evsel__process_contention_end,   },
+};
+
 static bool force;
 
 static int __cmd_report(bool display_info)
@@ -1125,20 +1156,41 @@ static int __cmd_record(int argc, const char **argv)
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
@@ -1147,9 +1199,19 @@ static int __cmd_record(int argc, const char **argv)
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
2.36.1.476.g0c4daa206d-goog

