Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12318476114
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 19:52:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344002AbhLOSwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 13:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239049AbhLOSv7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 13:51:59 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 076D3C061574
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 10:51:59 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id u11so17282579plf.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 10:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=njr+cYO7xEG0qBkZ/YmHt6HYhJLzs7sEC9t03EpurCA=;
        b=dCDQ8kWFXlc0N7qfukRib3fou4QHLj/5kM/EJZPYLQp5AuthvNDDS7unLV6CW3E+79
         mz0tc0Sq+EP1pROs/sAiKjXUoFFsZtBendfDsoJUu3HyDPsFIzq+e66z/0UyiatuDiMX
         Zy68QbXKztccQv8YmtCEyb2qZ0XFGQ05hENcILJ900TqDEDQMYomJdxzTMpIIzB0Psov
         Tw9jw180jtLUxc3kP1xgezYjhCutZMx1TLAWkg48qGs81eUyVR5u9EknH3t7rynsueKx
         PQAOKLYDikAo0ybIYYVxZPASfVHlMWJMumZfCpZY9C6MY0CHvZlHi5aNiDG5LIhvjNBL
         LBqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=njr+cYO7xEG0qBkZ/YmHt6HYhJLzs7sEC9t03EpurCA=;
        b=wZ6UtoiUcyWZSToBxHSiuC0sXgeSum9NCJ+2XUb/RwRlL5SyArpP7d8Bo+ojsH6GMu
         MgZqywKRtlUs2tiWJuuo1CWNpVOC6SldWWgqz9uurvQt2UbtvYqykD4ofXnngNO+1hrs
         vdoumwDOtlyyFBQGWWuA5befHZMVXYVO8Ps08E9Vpgo4xQ3Q+dMOxq5jsR6d/T5E7Ts8
         v7wIM3DecZSH+DC4jh6F1F+Nkq67HSA4Quq7y5QumK1flxWnk+2NuxO2t1UEoU9tUe+a
         cbT11gO8Fe6gGr55UuoRaiEHOBlTltJKaT1YTrp0u/Q6VN4scs4Ybrhvr2WZL/lR/Aj1
         sb7w==
X-Gm-Message-State: AOAM531EqjtWE0GAB96qoGLF5G0TQRgpQYh8IBC0+JgRbYnEvGFLqm6w
        8zyDmZ1PEoNNaiM/XXaMQ20=
X-Google-Smtp-Source: ABdhPJxWRHc2kwQCDfdoISuiDHm0Dth+7/x/QOIXQ59icPaUp5Kj1BAx6aoQdJDgh64C3NdJ/yzArA==
X-Received: by 2002:a17:90b:4f83:: with SMTP id qe3mr1309127pjb.56.1639594318545;
        Wed, 15 Dec 2021 10:51:58 -0800 (PST)
Received: from balhae.hsd1.ca.comcast.net ([2601:647:4800:5800:b969:356c:bdef:8748])
        by smtp.gmail.com with ESMTPSA id f2sm3646428pfe.132.2021.12.15.10.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 10:51:57 -0800 (PST)
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
Subject: [PATCH 1/5] perf ftrace: Add 'trace' subcommand
Date:   Wed, 15 Dec 2021 10:51:50 -0800
Message-Id: <20211215185154.360314-2-namhyung@kernel.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
In-Reply-To: <20211215185154.360314-1-namhyung@kernel.org>
References: <20211215185154.360314-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a preparation to add more sub-commands for ftrace.  The
'trace' subcommand does the same thing when no subcommand is given.

Committer testing:

The previous mode, i.e. no subcommand and the new 'perf ftrace trace'
are equivalent:

  # perf ftrace -G check_preempt_curr sleep 0.00001
  # tracer: function_graph
  #
  # CPU  DURATION                  FUNCTION CALLS
  # |     |   |                     |   |   |   |
   25)               |  check_preempt_curr() {
   25)               |    resched_curr() {
   25)               |      native_smp_send_reschedule() {
   25)               |        default_send_IPI_single_phys() {
   25)   0.110 us    |          __default_send_IPI_dest_field();
   25)   0.490 us    |        }
   25)   0.640 us    |      }
   25)   0.850 us    |    }
   25)   2.060 us    |  }
  # perf ftrace trace -G check_preempt_curr sleep 0.00001
  # tracer: function_graph
  #
  # CPU  DURATION                  FUNCTION CALLS
  # |     |   |                     |   |   |   |
   10)               |  check_preempt_curr() {
   10)               |    resched_curr() {
   10)               |      native_smp_send_reschedule() {
   10)               |        default_send_IPI_single_phys() {
   10)   0.080 us    |          __default_send_IPI_dest_field();
   10)   0.460 us    |        }
   10)   0.610 us    |      }
   10)   0.830 us    |    }
   10)   2.020 us    |  }
  #

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
Link: https://lore.kernel.org/r/20211129231830.1117781-2-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
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
2.34.1.173.g76aa8bc2d0-goog

