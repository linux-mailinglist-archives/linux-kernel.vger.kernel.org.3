Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C6ED4974ED
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 20:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239640AbiAWTS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 14:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239609AbiAWTSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 14:18:55 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 753D8C06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 11:18:54 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id z15-20020a25bb0f000000b00613388c7d99so30724569ybg.8
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 11:18:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=P/7gZvy2o2L6f4h71xYi4mBHo31wqAY/4B1y57WLH3o=;
        b=HEebOQbIk+xbsbGW+rLpNby3a4cXiZ1P/ijiIEZB5iDXJ/cNOAM4ZtKOt/i+KKbJ+f
         aa6gOqyHOrqYvWowU/oXQ/v69R2EW+hGVIS4kVABi4tnD0xEOsKPNBWVuJ+MtDDVcduU
         PuZLLpyYiQMMk3VPSmWZA69VOhY8rT17B51g3gNpmaoIYfzMi7yywbwWyexdhNoYy8lR
         3AeGrjv5LNqEA7WTqR3BvCE7CiP174QV70C2E0UL6tfrqi4U2oP0SrcvPSz5szdKXW5R
         T2sUZhf8OnJwQzUZFZk9YZGpWJmQbSkLW3DyNV6nF9CK3ru4E8ZT12U5GSYt2XOF6BJC
         npYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=P/7gZvy2o2L6f4h71xYi4mBHo31wqAY/4B1y57WLH3o=;
        b=ElRopl27Bv5y9gGdr3NeIE0b5wl+1jZGpKZGMyPF5vd2KvndFPi8Gjfyz7CeuHxMc6
         T8sD1emKZYF3oHgap/RZDdN5vBngI40FyGGtqsGQRi5A5bni+217cI2xjQKcIELtbQ1C
         q3GtPmL3d0aOEX4seR27V7Q/bcA3VLTNHI8hSIMCiAZxjE/J3o3qGhO3AKTijKOcFiAm
         DHgNKrCnUVymKMU6g3PKgFoZeTdLHlRv38ODWrBvcJhdo4Df7Aewrm7KTwIguYi3FN9X
         D6zEQ6++SOXw0nurbYCRN24nZ/ftMtyvjNEK2Bh+3WhmCTt7Eo8HIyOOlpmOQdRNMBjL
         vfxQ==
X-Gm-Message-State: AOAM530olGYhMhO5nhWeYs4UJIeujS22LAF4eoDchjXNt6Cxw7Qg7ma5
        2KyvN6dvDjVD+InwKycAsaV+zw/z/u0U
X-Google-Smtp-Source: ABdhPJwI1iRlHJNG3lEv38NvX2E9aZ/UxtKvOOynEgqs0TfiJh3KpVYpOstq2FAsvCW9xJ7H2cRtBQVdcjlm
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:1d5e:35c2:7748:3a52])
 (user=irogers job=sendgmr) by 2002:a81:1544:0:b0:2ca:287c:6cd6 with SMTP id
 00721157ae682-2ca287c6f50mr47b3.379.1642965533245; Sun, 23 Jan 2022 11:18:53
 -0800 (PST)
Date:   Sun, 23 Jan 2022 11:18:48 -0800
Message-Id: <20220123191849.3655855-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH 1/2] perf tui: Only support --tui with slang
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>, xaizek <xaizek@posteo.net>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make the --tui command line flags dependent HAVE_SLANG_SUPPORT. This was
reported as confusing in:
https://lore.kernel.org/linux-perf-users/YevaTkzdXmFKdGpc@zx-spectrum.none/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c | 10 +++++++++-
 tools/perf/builtin-report.c   | 10 +++++++++-
 tools/perf/builtin-top.c      |  4 ++++
 tools/perf/util/top.h         |  5 ++++-
 4 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 490bb9b8cf17..5e038d9bab05 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -46,7 +46,11 @@ struct perf_annotate {
 	struct perf_tool tool;
 	struct perf_session *session;
 	struct annotation_options opts;
-	bool	   use_tui, use_stdio, use_stdio2, use_gtk;
+#ifdef HAVE_SLANG_SUPPORT
+	bool	   use_tui;
+#endif
+	bool	   use_stdio, use_stdio2;
+	bool	   use_gtk;
 	bool	   skip_missing;
 	bool	   has_br_stack;
 	bool	   group_set;
@@ -503,7 +507,9 @@ int cmd_annotate(int argc, const char **argv)
 	OPT_BOOLEAN('D', "dump-raw-trace", &dump_trace,
 		    "dump raw trace in ASCII"),
 	OPT_BOOLEAN(0, "gtk", &annotate.use_gtk, "Use the GTK interface"),
+#ifdef HAVE_SLANG_SUPPORT
 	OPT_BOOLEAN(0, "tui", &annotate.use_tui, "Use the TUI interface"),
+#endif
 	OPT_BOOLEAN(0, "stdio", &annotate.use_stdio, "Use the stdio interface"),
 	OPT_BOOLEAN(0, "stdio2", &annotate.use_stdio2, "Use the stdio interface"),
 	OPT_BOOLEAN(0, "ignore-vmlinux", &symbol_conf.ignore_vmlinux,
@@ -624,8 +630,10 @@ int cmd_annotate(int argc, const char **argv)
 
 	if (annotate.use_stdio || annotate.use_stdio2)
 		use_browser = 0;
+#ifdef HAVE_SLANG_SUPPORT
 	else if (annotate.use_tui)
 		use_browser = 1;
+#endif
 	else if (annotate.use_gtk)
 		use_browser = 2;
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 1dd92d8c9279..1ad75c7ba074 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -71,7 +71,11 @@ struct report {
 	struct perf_tool	tool;
 	struct perf_session	*session;
 	struct evswitch		evswitch;
-	bool			use_tui, use_gtk, use_stdio;
+#ifdef HAVE_SLANG_SUPPORT
+	bool			use_tui;
+#endif
+	bool			use_gtk;
+	bool			use_stdio;
 	bool			show_full_info;
 	bool			show_threads;
 	bool			inverted_callchain;
@@ -1206,7 +1210,9 @@ int cmd_report(int argc, const char **argv)
 		    "Show per-thread event counters"),
 	OPT_STRING(0, "pretty", &report.pretty_printing_style, "key",
 		   "pretty printing style key: normal raw"),
+#ifdef HAVE_SLANG_SUPPORT
 	OPT_BOOLEAN(0, "tui", &report.use_tui, "Use the TUI interface"),
+#endif
 	OPT_BOOLEAN(0, "gtk", &report.use_gtk, "Use the GTK2 interface"),
 	OPT_BOOLEAN(0, "stdio", &report.use_stdio,
 		    "Use the stdio interface"),
@@ -1492,8 +1498,10 @@ int cmd_report(int argc, const char **argv)
 
 	if (report.use_stdio)
 		use_browser = 0;
+#ifdef HAVE_SLANG_SUPPORT
 	else if (report.use_tui)
 		use_browser = 1;
+#endif
 	else if (report.use_gtk)
 		use_browser = 2;
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 1fc390f136dd..e1a134a0a377 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -1486,7 +1486,9 @@ int cmd_top(int argc, const char **argv)
 		    "display this many functions"),
 	OPT_BOOLEAN('U', "hide_user_symbols", &top.hide_user_symbols,
 		    "hide user symbols"),
+#ifdef HAVE_SLANG_SUPPORT
 	OPT_BOOLEAN(0, "tui", &top.use_tui, "Use the TUI interface"),
+#endif
 	OPT_BOOLEAN(0, "stdio", &top.use_stdio, "Use the stdio interface"),
 	OPT_INCR('v', "verbose", &verbose,
 		    "be more verbose (show counter open errors, etc)"),
@@ -1667,8 +1669,10 @@ int cmd_top(int argc, const char **argv)
 
 	if (top.use_stdio)
 		use_browser = 0;
+#ifdef HAVE_SLANG_SUPPORT
 	else if (top.use_tui)
 		use_browser = 1;
+#endif
 
 	setup_browser(false);
 
diff --git a/tools/perf/util/top.h b/tools/perf/util/top.h
index ff8391208ecd..1c2c0a838430 100644
--- a/tools/perf/util/top.h
+++ b/tools/perf/util/top.h
@@ -33,7 +33,10 @@ struct perf_top {
 	int		   print_entries, count_filter, delay_secs;
 	int		   max_stack;
 	bool		   hide_kernel_symbols, hide_user_symbols, zero;
-	bool		   use_tui, use_stdio;
+#ifdef HAVE_SLANG_SUPPORT
+	bool		   use_tui;
+#endif
+	bool		   use_stdio;
 	bool		   vmlinux_warned;
 	bool		   dump_symtab;
 	bool		   stitch_lbr;
-- 
2.35.0.rc0.227.g00780c9af4-goog

