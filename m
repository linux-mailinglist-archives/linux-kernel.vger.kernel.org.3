Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 098B546282B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 00:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231488AbhK2XWc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 18:22:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbhK2XWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 18:22:13 -0500
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70C9C06174A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 15:18:51 -0800 (PST)
Received: by mail-pg1-x52d.google.com with SMTP id 71so17689527pgb.4
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 15:18:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SAyAzJ5taVIYm32wiupcjIXsXfuuqlIHwLrCj5uNLVw=;
        b=X1Th978QN6NJGfSkS2HPXGzKGBeAHR/rjTvNUSwN/57UOGgWmJVYjGyQHR9c/SJ6V+
         ZbGkdhQy21Uf7IFWrtas+4koC4MwDBG/SWwx32APykjBt73cDwrKlKUAHXvZqhOnq4Ug
         4765p5SuMlVA39jpgR0NAD3JlQMjFakVNZlPvJBRo8JeB7qRHz8vlEW3zDwk2sXmq7xv
         DjJ9lh17E0Fo5IRbSou+gxa7w8qXfUGySIwTcspalgmmA47g9pFPyxmIpikJPcStVIvI
         2ZXBMYwE3O3/fcMaE76QEVFVW3H+yT8dWsSN1Qq6cIDYWkcZqiBzZmrROrfj+pJwUmrD
         qaNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=SAyAzJ5taVIYm32wiupcjIXsXfuuqlIHwLrCj5uNLVw=;
        b=GaUPt3Y9p/wZfWOOBLJKvI3St2gjjZGTDPMcE8v/DhpZUPtU7qNWWHciyFPSGbUQF1
         KDZq2sYUzAuaGXjhQQ5/g1yAjNrOkdKt3paUy4Puz3VL7TBi+BR2/iZsYTqYvzp8uGL8
         7YK7JlmLjrhUUH5mzEKyKVHv9lCJH67/4mHS7IWkfHFRuFtcviLqZZdYCP9ybuAPChTN
         g8mkkB/pa1j3Mev7lxNyFQqRPYZArJH+AFRKV0sP2nDYB8U1bdfi8q7v7ULQw7V5iqjg
         ybHDkv1JhHz0ebBAn+4EYfRmaxIaeIeGgENL6CdLwf8fktBrW9ova5q11OOHqbtBspm2
         dxtw==
X-Gm-Message-State: AOAM532GXXS4I9oSE/cCAvneRvMqAzySOPiHcdYyenb+teNdrL5nNzOa
        /uQb+tsAjrxH41IBLm3h7ro=
X-Google-Smtp-Source: ABdhPJzR8qfkEf3ezF+ASs97jJyPKIFen+0dF9+GRka0EPY4J0rKzKkoZeNJxtxkE3NV3LL265dHKw==
X-Received: by 2002:a63:5d3:: with SMTP id 202mr6314130pgf.454.1638227914358;
        Mon, 29 Nov 2021 15:18:34 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:5800:7f54:1f52:ae81:8c78])
        by smtp.gmail.com with ESMTPSA id j7sm18334762pfu.164.2021.11.29.15.18.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 15:18:33 -0800 (PST)
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
Subject: [PATCH 1/5] perf ftrace: Add 'trace' subcommand
Date:   Mon, 29 Nov 2021 15:18:26 -0800
Message-Id: <20211129231830.1117781-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
In-Reply-To: <20211129231830.1117781-1-namhyung@kernel.org>
References: <20211129231830.1117781-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparation to add more sub-commands for ftrace.  The
'trace' subcommand does the same thing when no subcommand is given.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-ftrace.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/tools/perf/builtin-ftrace.c b/tools/perf/builtin-ftrace.c
index 87cb11a7a3ee..b28e762c5d54 100644
--- a/tools/perf/builtin-ftrace.c
+++ b/tools/perf/builtin-ftrace.c
@@ -879,17 +879,7 @@ int cmd_ftrace(int argc, const char **argv)
 		.tracer = DEFAULT_TRACER,
 		.target = { .uid = UINT_MAX, },
 	};
-	const char * const ftrace_usage[] = {
-		"perf ftrace [<options>] [<command>]",
-		"perf ftrace [<options>] -- <command> [<options>]",
-		NULL
-	};
-	const struct option ftrace_options[] = {
-	OPT_STRING('t', "tracer", &ftrace.tracer, "tracer",
-		   "Tracer to use: function_graph(default) or function"),
-	OPT_CALLBACK_DEFAULT('F', "funcs", NULL, "[FILTER]",
-			     "Show available functions to filter",
-			     opt_list_avail_functions, "*"),
+	const struct option common_options[] = {
 	OPT_STRING('p', "pid", &ftrace.target.pid, "pid",
 		   "Trace on existing process id"),
 	/* TODO: Add short option -t after -t/--tracer can be removed. */
@@ -901,6 +891,14 @@ int cmd_ftrace(int argc, const char **argv)
 		    "System-wide collection from all CPUs"),
 	OPT_STRING('C', "cpu", &ftrace.target.cpu_list, "cpu",
 		    "List of cpus to monitor"),
+	OPT_END()
+	};
+	const struct option ftrace_options[] = {
+	OPT_STRING('t', "tracer", &ftrace.tracer, "tracer",
+		   "Tracer to use: function_graph(default) or function"),
+	OPT_CALLBACK_DEFAULT('F', "funcs", NULL, "[FILTER]",
+			     "Show available functions to filter",
+			     opt_list_avail_functions, "*"),
 	OPT_CALLBACK('T', "trace-funcs", &ftrace.filters, "func",
 		     "Trace given functions using function tracer",
 		     parse_filter_func),
@@ -923,7 +921,15 @@ int cmd_ftrace(int argc, const char **argv)
 		    "Trace children processes"),
 	OPT_UINTEGER('D', "delay", &ftrace.initial_delay,
 		     "Number of milliseconds to wait before starting tracing after program start"),
-	OPT_END()
+	OPT_PARENT(common_options),
+	};
+
+	const char * const ftrace_usage[] = {
+		"perf ftrace [<options>] [<command>]",
+		"perf ftrace [<options>] -- [<command>] [<options>]",
+		"perf ftrace trace [<options>] [<command>]",
+		"perf ftrace trace [<options>] -- [<command>] [<options>]",
+		NULL
 	};
 
 	INIT_LIST_HEAD(&ftrace.filters);
@@ -935,6 +941,11 @@ int cmd_ftrace(int argc, const char **argv)
 	if (ret < 0)
 		return -1;
 
+	if (argc > 1 && !strcmp(argv[1], "trace")) {
+		argc--;
+		argv++;
+	}
+
 	argc = parse_options(argc, argv, ftrace_options, ftrace_usage,
 			    PARSE_OPT_STOP_AT_NON_OPTION);
 	if (!argc && target__none(&ftrace.target))
-- 
2.34.0.rc2.393.gf8c9666880-goog

