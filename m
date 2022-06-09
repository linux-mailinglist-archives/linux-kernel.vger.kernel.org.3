Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72814544366
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 07:57:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238695AbiFIF5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 01:57:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238557AbiFIF5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:57:00 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3958828733;
        Wed,  8 Jun 2022 22:56:59 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id j6so20169917pfe.13;
        Wed, 08 Jun 2022 22:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+fAQAu3R4tRVZ7vW7DjEw1aerx7t4qGkXj4hQ6RBGyw=;
        b=KLfpmjlHernPBNccU93rloiN/vAGD+fHH2nWE/9bBlI7lFtsMCQ1i5LtMhFJLRGkg4
         HgafSmoOwaSmiKSEew2Zv6Wcx0f3he8tNJTSwAiwXGyU8I0RK8FNOUp6nGMpgGh3zV1i
         ypuj6PyucdRPzrN+11xX+l4nAhm+m6k7vh/uHS4GdX1i/GngcVcbJsR/UWBQDlmWnRfQ
         MVtT/GP8uj2WayviBYDV0kfzIndZz9Ij1qRi2sNHuWw2nusy9Cd6t21Jv1ZetsQZaLzs
         +0/RN2AsPkzwpTlE9/farDil3Iz14zuCItC1qHfVrgYkvjef4UQYtyoutbRri7Rw40ez
         wi0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=+fAQAu3R4tRVZ7vW7DjEw1aerx7t4qGkXj4hQ6RBGyw=;
        b=ExDRxpdGwvs1sIzDEfA45dM5cdN23zfZqT/H3hEmOdjELiOfEii+MxxXP7/MpdZQZ9
         Eh16HEoG5X7o3AwAhvMJgH0sEkpeRtr9GAnp66SSFOriamKUCSWuNXxy1meB0ighhtEz
         CAD5B35B2WoJf4nqjHo36bLC3aULvjXNTQ09I6XZzzVAIZfGwoyjV1M4ejdp65Trqe7L
         LjtIn53PFpDUCKogQqA6iNsiy3YvyXOXdYAHxIQTdXMywQ3nO0CpIyLgkN0ZyeiEJAZu
         EWmQ1KcI2MIHhT1lhLkDXyE53TQgTmE/2EKAjXZBo7GvNwcbNTJcb619oc/Uy47H426w
         er3g==
X-Gm-Message-State: AOAM533dObazI63BWL1nU+bXJWs3X9365YF7Gtj3bFYpwllpaLH4XTqe
        1LYEz93rOcA5zVt/C+0L1CGkLdabqUpvSA==
X-Google-Smtp-Source: ABdhPJzkZvdLkaMWgBdukltQgNaAPbbIGh8w5PSupFwbVZaGVXon5byHTeZkWKsWiZl8KWqfBrfjwQ==
X-Received: by 2002:a05:6a00:2450:b0:4f7:bf07:c063 with SMTP id d16-20020a056a00245000b004f7bf07c063mr104299026pfj.51.1654754218741;
        Wed, 08 Jun 2022 22:56:58 -0700 (PDT)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:6780:cb0:2c32:ceaf:ea06:c5de])
        by smtp.gmail.com with ESMTPSA id w22-20020a1709026f1600b0016196bcf743sm9502413plk.275.2022.06.08.22.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 22:56:58 -0700 (PDT)
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
Date:   Wed,  8 Jun 2022 22:56:49 -0700
Message-Id: <20220609055652.938821-5-namhyung@kernel.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220609055652.938821-1-namhyung@kernel.org>
References: <20220609055652.938821-1-namhyung@kernel.org>
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
index 2337b09dd2cd..7df182a8443b 100644
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
@@ -1062,6 +1086,11 @@ static const struct evsel_str_handler lock_tracepoints[] = {
 	{ "lock:lock_release",	 evsel__process_lock_release,   }, /* CONFIG_LOCKDEP */
 };
 
+static const struct evsel_str_handler contention_tracepoints[] = {
+	{ "lock:contention_begin", evsel__process_contention_begin, },
+	{ "lock:contention_end",   evsel__process_contention_end,   },
+};
+
 static bool force;
 
 static int __cmd_report(bool display_info)
@@ -1125,20 +1154,41 @@ static int __cmd_record(int argc, const char **argv)
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
@@ -1147,9 +1197,19 @@ static int __cmd_record(int argc, const char **argv)
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

