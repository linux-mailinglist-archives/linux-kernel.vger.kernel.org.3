Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3561462828
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 00:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230152AbhK2XWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 18:22:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbhK2XV7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:21:59 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A34D6C061746
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 15:18:41 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id v19so13405456plo.7
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 15:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5bMEBHv8ZQAixAQOBSmogFl0XpHA6nrBQMjNY31OM8A=;
        b=Mg9U9MdtmHmqOjr19Gj4I9W4nuZf2ruGi5BsY/5bdNWXPsDv7XatGDFv+sXEt8PYBK
         0Zk+0eB2wgX355zFXt14gsMaG2aw3xfG2z7IcPw1SY0WRl86PmUuys+D9iMLXb8AayMV
         IRV4tTAhbGhqZKmqQCEOjcTFi3Fu7AArppIAdZ1LvvYRumz6v7gBearCxy6ZigCIcKMx
         yXjwfMY78ekQeVoLOwoXpzAjrXBoihmjf8z2dcXa+OA8EZrP5eL28gTmuPdwfw4Rhthu
         rG6ovCnBGY+ApZwheUCL8dueYdAylLl+keB94NjPYUi1bD6SvzWNzVJpYFBfYYwnx5MA
         426w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=5bMEBHv8ZQAixAQOBSmogFl0XpHA6nrBQMjNY31OM8A=;
        b=c1BxfN9/I07046nY55A1JVkOLul+LESeefMcFiOMEExaJj1c/lbbSbxNLe9MkI8xKs
         dV4QTJjUe3uD2SmEPHYf4nrFkcL3JaEezaYF43+1bvQGWNK8xdjo9ElBL3Cuo9qSMfJv
         pVR/eyq1CJSPOWVSJpfoz7OzRFbW+p49K/yfmtP6/mSeNivMMXUjwFkKSsdzyaNgKdRY
         gFUOrWrkWHcaSIF3R1RlbfaQlOhiXmyrfxBfAbcuA4V34jf2xO5AktDpTCtj9qwD4EQL
         21XG9K0RkNfcjrAC9E0vlcxsOv2I/LAeOjGkhVTqLRAgwUXlMWYh1NJ1fsw2Ou+ofxEK
         1vTA==
X-Gm-Message-State: AOAM53125to/asehXqe+p1Co/c7ps4nrF7nsKrB4lhnBquhHvgwXaMzX
        uCSWkTEevGokPh24qOobOlc=
X-Google-Smtp-Source: ABdhPJyM221CN3m36LT9S2w4FSWSHKzdq6kfP2EVL4r8A7MXTnU5aSEjBVVRCSfZQzUPDErR7AYR5w==
X-Received: by 2002:a17:902:cb8a:b0:141:f601:d5f1 with SMTP id d10-20020a170902cb8a00b00141f601d5f1mr64073773ply.77.1638227921153;
        Mon, 29 Nov 2021 15:18:41 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:5800:7f54:1f52:ae81:8c78])
        by smtp.gmail.com with ESMTPSA id j7sm18334762pfu.164.2021.11.29.15.18.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 15:18:40 -0800 (PST)
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
Subject: [PATCH 3/5] perf ftrace: Add 'latency' subcommand
Date:   Mon, 29 Nov 2021 15:18:28 -0800
Message-Id: <20211129231830.1117781-4-namhyung@kernel.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
In-Reply-To: <20211129231830.1117781-1-namhyung@kernel.org>
References: <20211129231830.1117781-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The perf ftrace latency is to get a histogram of function execution
time.  Users should give a function name using -T option.

This is implemented using function_graph tracer with the given
function only.  And it parses the output to extract the time.

  $ sudo perf ftrace latency -a -T mutex_lock sleep 1
  #   DURATION     |      COUNT | GRAPH                          |
       0 - 1    us |       4596 | ########################       |
       1 - 2    us |       1680 | #########                      |
       2 - 4    us |       1106 | #####                          |
       4 - 8    us |        546 | ##                             |
       8 - 16   us |        562 | ###                            |
      16 - 32   us |          1 |                                |
      32 - 64   us |          0 |                                |
      64 - 128  us |          0 |                                |
     128 - 256  us |          0 |                                |
     256 - 512  us |          0 |                                |
     512 - 1024 us |          0 |                                |
       1 - 2    ms |          0 |                                |
       2 - 4    ms |          0 |                                |
       4 - 8    ms |          0 |                                |
       8 - 16   ms |          0 |                                |
      16 - 32   ms |          0 |                                |
      32 - 64   ms |          0 |                                |
      64 - 128  ms |          0 |                                |
     128 - 256  ms |          0 |                                |
     256 - 512  ms |          0 |                                |
     512 - 1024 ms |          0 |                                |
       1 - ...   s |          0 |                                |

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-ftrace.c | 285 ++++++++++++++++++++++++++++++++++--
 1 file changed, 276 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 0f8310bd0e6c..8fd3c9c44c69 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -13,7 +13,9 @@
 #include <signal.h>
 #include <stdlib.h>
 #include <fcntl.h>
+#include <math.h>
 #include <poll.h>
+#include <ctype.h>
 #include <linux/capability.h>
 #include <linux/string.h>
 
@@ -702,6 +704,224 @@ static int __cmd_ftrace(struct perf_ftrace *ftrace)
 	return (done && !workload_exec_errno) ? 0 : -1;
 }
 
+#define NUM_BUCKET  22  /* 20 + 2 (for outliers in both direction) */
+
+static void make_histogram(int buckets[], char *buf, size_t len, char *linebuf)
+{
+	char *p, *q;
+	char *unit;
+	double num;
+	int i;
+
+	/* ensure NUL termination */
+	buf[len] = '\0';
+
+	/* handle data line by line */
+	for (p = buf; (q = strchr(p, '\n')) != NULL; p = q + 1) {
+		*q = '\0';
+		/* move it to the line buffer */
+		strcat(linebuf, p);
+
+		/*
+		 * parse trace output to get function duration like in
+		 *
+		 * # tracer: function_graph
+		 * #
+		 * # CPU  DURATION                  FUNCTION CALLS
+		 * # |     |   |                     |   |   |   |
+		 *  1) + 10.291 us   |  do_filp_open();
+		 *  1)   4.889 us    |  do_filp_open();
+		 *  1)   6.086 us    |  do_filp_open();
+		 *
+		 */
+		if (linebuf[0] == '#')
+			goto next;
+
+		/* ignore CPU */
+		p = strchr(linebuf, ')');
+		if (p == NULL)
+			p = linebuf;
+
+		while (*p && !isdigit(*p) && (*p != '|'))
+			p++;
+
+		/* no duration */
+		if (*p == '\0' || *p == '|')
+			goto next;
+
+		num = strtod(p, &unit);
+		if (!unit || strncmp(unit, " us", 3))
+			goto next;
+
+		i = log2(num);
+		if (i < 0)
+			i = 0;
+		if (i >= NUM_BUCKET)
+			i = NUM_BUCKET - 1;
+
+		buckets[i]++;
+
+next:
+		/* empty the line buffer for the next output  */
+		linebuf[0] = '\0';
+	}
+
+	/* preserve any remaining output (before newline) */
+	strcat(linebuf, p);
+}
+
+static void display_histogram(int buckets[])
+{
+	int i;
+	int total = 0;
+	int bar_total = 46;  /* to fit in 80 column */
+	char bar[] = "###############################################";
+	int bar_len;
+
+	for (i = 0; i < NUM_BUCKET; i++)
+		total += buckets[i];
+
+	if (total == 0) {
+		printf("No data found\n");
+		return;
+	}
+
+	printf("# %14s | %10s | %-*s |\n",
+	       "  DURATION    ", "COUNT", bar_total, "GRAPH");
+
+	bar_len = buckets[0] * bar_total / total;
+	printf("  %4d - %-4d %s | %10d | %.*s%*s |\n",
+	       0, 1, "us", buckets[0], bar_len, bar, bar_total - bar_len, "");
+
+	for (i = 1; i < NUM_BUCKET - 1; i++) {
+		int start = (1 << (i - 1));
+		int stop = 1 << i;
+		const char *unit = "us";
+
+		if (start >= 1024) {
+			start >>= 10;
+			stop >>= 10;
+			unit = "ms";
+		}
+		bar_len = buckets[i] * bar_total / total;
+		printf("  %4d - %-4d %s | %10d | %.*s%*s |\n",
+		       start, stop, unit, buckets[i], bar_len, bar,
+		       bar_total - bar_len, "");
+	}
+
+	bar_len = buckets[NUM_BUCKET - 1] * bar_total / total;
+	printf("  %4d - %-4s %s | %10d | %.*s%*s |\n",
+	       1, "...", " s", buckets[NUM_BUCKET - 1], bar_len, bar,
+	       bar_total - bar_len, "");
+
+}
+
+static int __cmd_latency(struct perf_ftrace *ftrace)
+{
+	char *trace_file;
+	int trace_fd;
+	char buf[4096];
+	char line[256];
+	struct pollfd pollfd = {
+		.events = POLLIN,
+	};
+	int buckets[NUM_BUCKET] = { };
+
+	if (!(perf_cap__capable(CAP_PERFMON) ||
+	      perf_cap__capable(CAP_SYS_ADMIN))) {
+		pr_err("ftrace only works for %s!\n",
+#ifdef HAVE_LIBCAP_SUPPORT
+		"users with the CAP_PERFMON or CAP_SYS_ADMIN capability"
+#else
+		"root"
+#endif
+		);
+		return -1;
+	}
+
+	if (reset_tracing_files(ftrace) < 0) {
+		pr_err("failed to reset ftrace\n");
+		goto out;
+	}
+
+	/* reset ftrace buffer */
+	if (write_tracing_file("trace", "0") < 0)
+		goto out;
+
+	if (set_tracing_options(ftrace) < 0)
+		goto out_reset;
+
+	/* force to use the function_graph tracer to track duration */
+	if (write_tracing_file("current_tracer", "function_graph") < 0) {
+		pr_err("failed to set current_tracer to function_graph\n");
+		goto out_reset;
+	}
+
+	trace_file = get_tracing_file("trace_pipe");
+	if (!trace_file) {
+		pr_err("failed to open trace_pipe\n");
+		goto out_reset;
+	}
+
+	trace_fd = open(trace_file, O_RDONLY);
+
+	put_tracing_file(trace_file);
+
+	if (trace_fd < 0) {
+		pr_err("failed to open trace_pipe\n");
+		goto out_reset;
+	}
+
+	fcntl(trace_fd, F_SETFL, O_NONBLOCK);
+	pollfd.fd = trace_fd;
+
+	if (write_tracing_file("tracing_on", "1") < 0) {
+		pr_err("can't enable tracing\n");
+		goto out_close_fd;
+	}
+
+	evlist__start_workload(ftrace->evlist);
+
+	line[0] = '\0';
+	while (!done) {
+		if (poll(&pollfd, 1, -1) < 0)
+			break;
+
+		if (pollfd.revents & POLLIN) {
+			int n = read(trace_fd, buf, sizeof(buf) - 1);
+			if (n < 0)
+				break;
+
+			make_histogram(buckets, buf, n, line);
+		}
+	}
+
+	write_tracing_file("tracing_on", "0");
+
+	if (workload_exec_errno) {
+		const char *emsg = str_error_r(workload_exec_errno, buf, sizeof(buf));
+		pr_err("workload failed: %s\n", emsg);
+		goto out_close_fd;
+	}
+
+	/* read remaining buffer contents */
+	while (true) {
+		int n = read(trace_fd, buf, sizeof(buf) - 1);
+		if (n <= 0)
+			break;
+		make_histogram(buckets, buf, n, line);
+	}
+
+	display_histogram(buckets);
+
+out_close_fd:
+	close(trace_fd);
+out_reset:
+	reset_tracing_files(ftrace);
+out:
+	return (done && !workload_exec_errno) ? 0 : -1;
+}
+
 static int perf_ftrace_config(const char *var, const char *value, void *cb)
 {
 	struct perf_ftrace *ftrace = cb;
@@ -864,6 +1084,12 @@ static int parse_graph_tracer_opts(const struct option *opt,
 	return 0;
 }
 
+enum perf_ftrace_subcommand {
+	PERF_FTRACE_NONE,
+	PERF_FTRACE_TRACE,
+	PERF_FTRACE_LATENCY,
+};
+
 int cmd_ftrace(int argc, const char **argv)
 {
 	int ret;
@@ -915,14 +1141,21 @@ int cmd_ftrace(int argc, const char **argv)
 		     "Number of milliseconds to wait before starting tracing after program start"),
 	OPT_PARENT(common_options),
 	};
+	const struct option latency_options[] = {
+	OPT_CALLBACK('T', "trace-funcs", &ftrace.filters, "func",
+		     "Show latency of given function", parse_filter_func),
+	OPT_PARENT(common_options),
+	};
+	const struct option *options = ftrace_options;
 
 	const char * const ftrace_usage[] = {
 		"perf ftrace [<options>] [<command>]",
 		"perf ftrace [<options>] -- [<command>] [<options>]",
-		"perf ftrace trace [<options>] [<command>]",
-		"perf ftrace trace [<options>] -- [<command>] [<options>]",
+		"perf ftrace {trace|latency} [<options>] [<command>]",
+		"perf ftrace {trace|latency} [<options>] -- [<command>] [<options>]",
 		NULL
 	};
+	enum perf_ftrace_subcommand subcmd = PERF_FTRACE_NONE;
 
 	INIT_LIST_HEAD(&ftrace.filters);
 	INIT_LIST_HEAD(&ftrace.notrace);
@@ -938,15 +1171,29 @@ int cmd_ftrace(int argc, const char **argv)
 	if (ret < 0)
 		return -1;
 
-	if (argc > 1 && !strcmp(argv[1], "trace")) {
-		argc--;
-		argv++;
+	if (argc > 1) {
+		if (!strcmp(argv[1], "trace")) {
+			subcmd = PERF_FTRACE_TRACE;
+		} else if (!strcmp(argv[1], "latency")) {
+			subcmd = PERF_FTRACE_LATENCY;
+			options = latency_options;
+		}
+
+		if (subcmd != PERF_FTRACE_NONE) {
+			argc--;
+			argv++;
+		}
 	}
+	/* for backward compatibility */
+	if (subcmd == PERF_FTRACE_NONE)
+		subcmd = PERF_FTRACE_TRACE;
 
-	argc = parse_options(argc, argv, ftrace_options, ftrace_usage,
+	argc = parse_options(argc, argv, options, ftrace_usage,
 			    PARSE_OPT_STOP_AT_NON_OPTION);
-	if (!argc && target__none(&ftrace.target))
-		ftrace.target.system_wide = true;
+	if (argc < 0) {
+		ret = -EINVAL;
+		goto out_delete_filters;
+	}
 
 	ret = target__validate(&ftrace.target);
 	if (ret) {
@@ -975,7 +1222,27 @@ int cmd_ftrace(int argc, const char **argv)
 			goto out_delete_evlist;
 	}
 
-	ret = __cmd_ftrace(&ftrace);
+	switch (subcmd) {
+	case PERF_FTRACE_TRACE:
+		if (!argc && target__none(&ftrace.target))
+			ftrace.target.system_wide = true;
+		ret = __cmd_ftrace(&ftrace);
+		break;
+	case PERF_FTRACE_LATENCY:
+		if (list_empty(&ftrace.filters)) {
+			pr_err("Should provide a function to measure\n");
+			parse_options_usage(ftrace_usage, options, "T", 1);
+			ret = -EINVAL;
+			goto out_delete_evlist;
+		}
+		ret = __cmd_latency(&ftrace);
+		break;
+	case PERF_FTRACE_NONE:
+	default:
+		pr_err("Invalid subcommand\n");
+		ret = -EINVAL;
+		break;
+	}
 
 out_delete_evlist:
 	evlist__delete(ftrace.evlist);
-- 
2.34.0.rc2.393.gf8c9666880-goog

