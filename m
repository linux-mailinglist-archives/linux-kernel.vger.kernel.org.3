Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D3C753D3F7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Jun 2022 01:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349798AbiFCX5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 19:57:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbiFCX5G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 19:57:06 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A29D32B19E;
        Fri,  3 Jun 2022 16:57:00 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id gc3-20020a17090b310300b001e33092c737so8203800pjb.3;
        Fri, 03 Jun 2022 16:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EHrPNtgTpbjgDc4LmyfqxOYA7SRUHR6rzrdM1rqaC4I=;
        b=F7scXzHpZJpjS8CUuPwmLMPCXEKmI25baPdDEPbQV6PmBMTFGiKBcwTttyxzEmdb1l
         GrBOyIG10yyUYI3fFUXKf5NkSIRwABMVipcxu5ay1NO7CEsPgOnZ5klzGnwcfO3gxdrd
         A+l8qM/G3AMUtJyLxLsnVA3vBj7ml8BIhiJZSYjkNKywzxItYyS1O6q5Hm30x1SCN/Bv
         SBCBjqcVbB4ujLB718fhJMehROuZAf3aMV+ekU8Z6yBqYxSyMCsvsgMDz92qQqoSJLli
         uXEat2jhVy6LTkb4jQw2d/qZW4cORKEQB7y2DY/2nUKzAXrj1f8uuB0zmdZA7oBrLS6o
         YE3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=EHrPNtgTpbjgDc4LmyfqxOYA7SRUHR6rzrdM1rqaC4I=;
        b=z8bXP3Ia5Aw9RJlkLYQF8Uf98hlX4NQXK3Wsw4kD2Gl+m141yGenikk4uAl3IZMjD7
         cOq6TmU8PmolScAtv5wazM6etxTF51BdkO2o5xdX+qS+rgdPZALpaIzGSkBZIK+nfXni
         ITWjGSHpMzEwi3E0cW/oODj30ONj453lirKfQoImJN7YPUn3NLOTrW9mCfHNmEDa3DNa
         LTjXuDD9vs0h+BoiI2h18j6XgT9exyQ9/gK+sPdTwlepDqi9i2/BomNslghKtVQsjnte
         J6X6ui6PwsVTJBMCLT9+1jHuAgFVOiaVjs+dfHozQMjvi3fPMC8FCJqKd+9imybvGGfI
         gClQ==
X-Gm-Message-State: AOAM532e4woa+UaIkp1qgh48vPVAZrSRlL+l7HvLIbUUVBIjbxV6UJd0
        XONzLc5BcOKf5dyT90cuuiU=
X-Google-Smtp-Source: ABdhPJz/opoBzwKfnFM+pquTNqX6yxwIb5z7dOwk62DswxroC3+pjlSchzjpug29Oxfsh5f0ZuQ5SQ==
X-Received: by 2002:a17:90b:3141:b0:1e0:6062:9c10 with SMTP id ip1-20020a17090b314100b001e060629c10mr48188874pjb.84.1654300620150;
        Fri, 03 Jun 2022 16:57:00 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:cb0:e599:3567:7c60:5f5a])
        by smtp.gmail.com with ESMTPSA id a37-20020a631a65000000b003c14af50626sm5868289pgm.62.2022.06.03.16.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 16:56:59 -0700 (PDT)
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
Date:   Fri,  3 Jun 2022 16:56:53 -0700
Message-Id: <20220603235656.715800-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220603235656.715800-1-namhyung@kernel.org>
References: <20220603235656.715800-1-namhyung@kernel.org>
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
 tools/perf/builtin-lock.c | 74 +++++++++++++++++++++++++++++++++++----
 1 file changed, 67 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
index 57e396323d05..60a45973744d 100644
--- a/tools/perf/builtin-lock.c
+++ b/tools/perf/builtin-lock.c
@@ -516,17 +516,27 @@ static struct lock_stat *lock_stat_findnew(u64 addr, const char *name)
 }
 
 struct trace_lock_handler {
+	/* it's used on CONFIG_LOCKDEP */
 	int (*acquire_event)(struct evsel *evsel,
 			     struct perf_sample *sample);
 
+	/* it's used on CONFIG_LOCK_STAT */
 	int (*acquired_event)(struct evsel *evsel,
 			      struct perf_sample *sample);
 
+	/* it's used on CONFIG_LOCK_STAT */
 	int (*contended_event)(struct evsel *evsel,
 			       struct perf_sample *sample);
 
+	/* it's used on CONFIG_LOCKDEP */
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
@@ -854,6 +864,20 @@ static int evsel__process_lock_release(struct evsel *evsel, struct perf_sample *
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
@@ -1055,6 +1079,11 @@ static const struct evsel_str_handler lock_tracepoints[] = {
 	{ "lock:lock_release",	 evsel__process_lock_release,   }, /* CONFIG_LOCKDEP */
 };
 
+static const struct evsel_str_handler contention_tracepoints[] = {
+	{ "lock:contention_begin", evsel__process_contention_begin, },
+	{ "lock:contention_end",   evsel__process_contention_end,   },
+};
+
 static bool force;
 
 static int __cmd_report(bool display_info)
@@ -1118,20 +1147,41 @@ static int __cmd_record(int argc, const char **argv)
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
@@ -1140,9 +1190,19 @@ static int __cmd_record(int argc, const char **argv)
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

