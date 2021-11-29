Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9ADB462827
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 00:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbhK2XV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 18:21:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230033AbhK2XV6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:21:58 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F809C061574
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 15:18:40 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id y8so13426532plg.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 15:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3nCx1DgswVRvqVCwM/eBWRIbfPVRq+9mBZDyR1T1aLc=;
        b=PqhMya3vrWbMoETIDoMXwo6YtDjOKFsgUEBoB+qLxNjbF8PB8IOhEb8Rwn9fi9Uvt5
         xqn6Bu0IrMeT1weXi1YgaJRBuQ4/RCxPiUzZ84CD5WoF0SVoFa8bdTt9uOtR09kFyrmt
         9LD+G+r0k13mpGnoJzPPRd81V4Qi5/B8DXD9CLwlZzgCKk0KeHSA7KUuJevRuN1QxfZj
         rbramKgsUkFJeIz8Bf5uvARYIfWVEZ4Ze3f6j+DBuyk1Pcw/iOmZCQ4Qr2oxADbrvTKE
         h3fZX4j02qVTKvAtNuXzdAMmASVZGKZF0EdKf8czpGZCB0KF9wmJOzM3AOspsnY4aibH
         ll7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3nCx1DgswVRvqVCwM/eBWRIbfPVRq+9mBZDyR1T1aLc=;
        b=RBau58HPl2iyRsoWl9MbOqD4e9tHDGrUn8N2fAUcS819wA3zSHFFMjGlqDfyM5NeuN
         8y0R341J5e7SdyZmqKN4/xtKETXREf3jGkC++jabGbMcNM7yCnOUTaIBbjwl4zBL3P3C
         NRn3EuNyX4FlejyVb3jznaVzm/VFgJwsYWtS6M2oRxdwY9P4hiRADgY06Zg3PBeniz/Z
         fuhZY6ZEXsgxWpLb9I/YRegiI1d0U0iLHp0RUDqh9DyWQw6QLS/OtTeJo1Jqy8muzcFB
         Un45WQFa4J1OIbaWpfIW5qWDEKZ9g13C3a6lNMZBdbi8who7ULUXgU/iouNOWCCVbxH2
         jCFg==
X-Gm-Message-State: AOAM532h+GYsiI81Oud3TaoL7mkZsaBD9njqU1SBhcuV3VFPY8ZEi9P2
        mTCycfntbgPdpZPDFBT8vbc=
X-Google-Smtp-Source: ABdhPJyT7WlhLAkHr5HYqX/t2uZ8GLzqPJkuwXYhdjnZUt0VURkmBX/YjqAf26Kgq1Yq8PD8XmsCCg==
X-Received: by 2002:a17:902:8544:b0:142:66e7:afbb with SMTP id d4-20020a170902854400b0014266e7afbbmr62915532plo.62.1638227919904;
        Mon, 29 Nov 2021 15:18:39 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:5800:7f54:1f52:ae81:8c78])
        by smtp.gmail.com with ESMTPSA id j7sm18334762pfu.164.2021.11.29.15.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 15:18:39 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Stephane Eranian <eranian@google.com>,
        Song Liu <songliubraving@fb.com>,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH 2/5] perf ftrace: Move out common code from __cmd_ftrace
Date:   Mon, 29 Nov 2021 15:18:27 -0800
Message-Id: <20211129231830.1117781-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
In-Reply-To: <20211129231830.1117781-1-namhyung@kernel.org>
References: <20211129231830.1117781-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The signal setup code and evlist__prepare_workload() can be used for
other subcommands.  Let's move them out of the __cmd_ftrace().  Then
it doesn't need to pass argc and argv.

On the other hand, select_tracer() is specific to the 'trace'
subcommand so it'd better moving it into the __cmd_ftrace().

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-ftrace.c | 63 +++++++++++++++++++------------------
 1 file changed, 33 insertions(+), 30 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index b28e762c5d54..0f8310bd0e6c 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -565,7 +565,24 @@ static int set_tracing_options(struct perf_ftrace *ftrace)
 	return 0;
 }
 
-static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
+static void select_tracer(struct perf_ftrace *ftrace)
+{
+	bool graph = !list_empty(&ftrace->graph_funcs) ||
+		     !list_empty(&ftrace->nograph_funcs);
+	bool func = !list_empty(&ftrace->filters) ||
+		    !list_empty(&ftrace->notrace);
+
+	/* The function_graph has priority over function tracer. */
+	if (graph)
+		ftrace->tracer = "function_graph";
+	else if (func)
+		ftrace->tracer = "function";
+	/* Otherwise, the default tracer is used. */
+
+	pr_debug("%s tracer is used\n", ftrace->tracer);
+}
+
+static int __cmd_ftrace(struct perf_ftrace *ftrace)
 {
 	char *trace_file;
 	int trace_fd;
@@ -586,10 +603,7 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 		return -1;
 	}
 
-	signal(SIGINT, sig_handler);
-	signal(SIGUSR1, sig_handler);
-	signal(SIGCHLD, sig_handler);
-	signal(SIGPIPE, sig_handler);
+	select_tracer(ftrace);
 
 	if (reset_tracing_files(ftrace) < 0) {
 		pr_err("failed to reset ftrace\n");
@@ -600,11 +614,6 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace, int argc, const char **argv)
 	if (write_tracing_file("trace", "0") < 0)
 		goto out;
 
-	if (argc && evlist__prepare_workload(ftrace->evlist, &ftrace->target, argv, false,
-					     ftrace__workload_exec_failed_signal) < 0) {
-		goto out;
-	}
-
 	if (set_tracing_options(ftrace) < 0)
 		goto out_reset;
 
@@ -855,23 +864,6 @@ static int parse_graph_tracer_opts(const struct option *opt,
 	return 0;
 }
 
-static void select_tracer(struct perf_ftrace *ftrace)
-{
-	bool graph = !list_empty(&ftrace->graph_funcs) ||
-		     !list_empty(&ftrace->nograph_funcs);
-	bool func = !list_empty(&ftrace->filters) ||
-		    !list_empty(&ftrace->notrace);
-
-	/* The function_graph has priority over function tracer. */
-	if (graph)
-		ftrace->tracer = "function_graph";
-	else if (func)
-		ftrace->tracer = "function";
-	/* Otherwise, the default tracer is used. */
-
-	pr_debug("%s tracer is used\n", ftrace->tracer);
-}
-
 int cmd_ftrace(int argc, const char **argv)
 {
 	int ret;
@@ -937,6 +929,11 @@ int cmd_ftrace(int argc, const char **argv)
 	INIT_LIST_HEAD(&ftrace.graph_funcs);
 	INIT_LIST_HEAD(&ftrace.nograph_funcs);
 
+	signal(SIGINT, sig_handler);
+	signal(SIGUSR1, sig_handler);
+	signal(SIGCHLD, sig_handler);
+	signal(SIGPIPE, sig_handler);
+
 	ret = perf_config(perf_ftrace_config, &ftrace);
 	if (ret < 0)
 		return -1;
@@ -951,8 +948,6 @@ int cmd_ftrace(int argc, const char **argv)
 	if (!argc && target__none(&ftrace.target))
 		ftrace.target.system_wide = true;
 
-	select_tracer(&ftrace);
-
 	ret = target__validate(&ftrace.target);
 	if (ret) {
 		char errbuf[512];
@@ -972,7 +967,15 @@ int cmd_ftrace(int argc, const char **argv)
 	if (ret < 0)
 		goto out_delete_evlist;
 
-	ret = __cmd_ftrace(&ftrace, argc, argv);
+	if (argc) {
+		ret = evlist__prepare_workload(ftrace.evlist, &ftrace.target,
+					       argv, false,
+					       ftrace__workload_exec_failed_signal);
+		if (ret < 0)
+			goto out_delete_evlist;
+	}
+
+	ret = __cmd_ftrace(&ftrace);
 
 out_delete_evlist:
 	evlist__delete(ftrace.evlist);
-- 
2.34.0.rc2.393.gf8c9666880-goog

