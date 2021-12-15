Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B732476115
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 19:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344006AbhLOSwG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 13:52:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344000AbhLOSwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 13:52:00 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 938EBC06173E
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 10:52:00 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id k6-20020a17090a7f0600b001ad9d73b20bso20129263pjl.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 10:52:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tow+Nc6EtPapuXOnqTsuFmvcP25mJfOCoP64WLyCgxo=;
        b=KddrVcFagg6SyW+/ypspkDVjoJ85Z+S2BlfwFGTOcdL+VqsMqYHkpoKc7e96oKwv5/
         +u1m7YAG4A6tcEhlXqr00SBxXulkiwB+KcUKaAQhECKCkriHLaxrpLCx4uSv64SRPzS6
         vZwp2948zC9GmENRCuOGdnVjG3d4rGsoALsqLEPhaVmlGiGeKJ5DTCE/rvP46YERLNAY
         8aQT8Bhph89o1rqViHsHnRNbLZ+tmQ0/xPvXm4q/VCNxKIgZtUnxCy42K2lON02rZM4I
         7cq2LUMntUYcofGk3T5sPIyYMaIJHjrNlNDl1n5hLhWjlGoSd+EIRB+9BGrb157enBrr
         aVUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=tow+Nc6EtPapuXOnqTsuFmvcP25mJfOCoP64WLyCgxo=;
        b=x/rYLmFCyz9FvGbJa1X2xdwGn/bw3A+vsIsX8IMK5Y5DTmHnJKVxBzAxf1L1xEELa9
         PjooGOeR2zSJ29FZpeeX3NM1OFKh1TwFT6nMaK4rhK2Qhcm1tWU//hUdxbHC+jYNXBTj
         AkpDmrsbwgtUXzO90qpvClmIlMe4UwrVbmiYnX/CyCebm49Agc66v7ldiwhsroJrIpOC
         KJZHGt1lPItd6f0igcfy4CnXfbYR+wLgZ32/z69mPdzvBUI2KyE8xzq+ZLseSMbK6C6U
         5+UywGtEPVGCnvQlBGb/VBDZ7WqM29vyhy92ZhJr0P9oL5ZDwJipvw3hbH1G1cIdWGmX
         YpAw==
X-Gm-Message-State: AOAM530vfIRrfxDbYYhLAuxhYvLDb0I8OGgtEENAcRS4oJC+1npdRpC1
        nV+3cUo66tb29tWEFTyvLS4=
X-Google-Smtp-Source: ABdhPJzDBqLJBNCNXf3sgdQxc6oRSil/aTSZEc0K8oy1X/Yx9zqWp8/W+s5EQO6zkCHM11b9sB4Orw==
X-Received: by 2002:a17:90a:bc92:: with SMTP id x18mr65544pjr.130.1639594320116;
        Wed, 15 Dec 2021 10:52:00 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:5800:b969:356c:bdef:8748])
        by smtp.gmail.com with ESMTPSA id f2sm3646428pfe.132.2021.12.15.10.51.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 10:51:59 -0800 (PST)
Sender: Namhyung Kim <namhyung@gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Changbin Du <changbin.du@gmail.com>,
        Song Liu <songliubraving@fb.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 2/5] perf ftrace: Move out common code from __cmd_ftrace
Date:   Wed, 15 Dec 2021 10:51:51 -0800
Message-Id: <20211215185154.360314-3-namhyung@kernel.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
In-Reply-To: <20211215185154.360314-1-namhyung@kernel.org>
References: <20211215185154.360314-1-namhyung@kernel.org>
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
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Changbin Du <changbin.du@gmail.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Song Liu <songliubraving@fb.com>
Cc: Stephane Eranian <eranian@google.com>
Link: https://lore.kernel.org/r/20211129231830.1117781-3-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.34.1.173.g76aa8bc2d0-goog

