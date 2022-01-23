Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A73F74974EE
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 20:19:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239694AbiAWTTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 14:19:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239672AbiAWTS5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 14:18:57 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34EAC06173D
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 11:18:56 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id d65-20020a256844000000b00614359972a6so21772347ybc.16
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 11:18:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=c3BO1dm7RCwPO9NDUrb6d3wTfeZ/r9fC9ifvGOyDdbk=;
        b=AQLwJ8NgHkSIpLKXwAuweEt1NMn2ZHeQtWeEMnCF0ueu5t/Ur8jWWXJQP89E3znpi/
         GjWpvEQmhMHGMbkZsA3NQZyfuoVNrmMxmUYw79liIbh3ZPQKJNZ1M80KO9TVxh0AaMXz
         1M/TGvAsh5PJk/im4cUzkEfKUYL0zXQyBhK93IkqPmdD8zsO1V+G6bWCE2gFa+PO0ZhZ
         vrkFpkxktXPuvGLziO6YZCx2wkXVJZUNf3dAcHu0u5Gw3BGY3tIOtQEC7JaBDjFMNzx9
         FGRQZNq9ToEHXwkEUCfXuZsLH9F0/QxPygRDyHmO0XHdtE94OuOImNv3+TJ9hr6IEMoP
         k0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=c3BO1dm7RCwPO9NDUrb6d3wTfeZ/r9fC9ifvGOyDdbk=;
        b=YMMkyyRe3vjhLzSXoeU4WtRXYa/q2lAzb3M8Ft/XC89jB6wVA6oXv/F0HkXgg8ixK/
         AhPOXlvzRJYmsIFmS3c+Mi9mxQ9LXrN5raMx9nldwjETKTxCnHCzVZYIH572X3mgTG6H
         VHSIXfH/QbV0KsiEWsP508wNuTpjfKotJGGYJPPADIrKQTOuA/bKLkmomX9mEZSJ+5XP
         Y957POa/Fm1WXIYdrdREormRH4QnOOTTroM7Pw2mdOZO1hE8xGqJBldkcW1UOLTnm37q
         5LggElKq2AoddYl2utmb2tSAML8MXL5OxkgLbbE0H9MJVP7xOzYkjjpkIhCzWhr89yRH
         IChQ==
X-Gm-Message-State: AOAM5335H3If/Yhjks+et6fyHrtnXtsWTs/TML0fW3WBmfMD8Swojx+S
        Vp6wQiFhDy1AH5Ckf3DXnZF6dS30VWw9
X-Google-Smtp-Source: ABdhPJwRXehyzd1gqRhKZ2FkXAbPGpKBcvrxVDQ95RaYC/VdgOT/WjI/+85FoS70LyXp5vgYXMRaZGcPSFmx
X-Received: from irogers.svl.corp.google.com ([2620:15c:2cd:202:1d5e:35c2:7748:3a52])
 (user=irogers job=sendgmr) by 2002:a25:e711:: with SMTP id
 e17mr18520857ybh.327.1642965536208; Sun, 23 Jan 2022 11:18:56 -0800 (PST)
Date:   Sun, 23 Jan 2022 11:18:49 -0800
In-Reply-To: <20220123191849.3655855-1-irogers@google.com>
Message-Id: <20220123191849.3655855-2-irogers@google.com>
Mime-Version: 1.0
References: <20220123191849.3655855-1-irogers@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH 2/2] perf gtk: Only support --gtk if compiled in
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

If HAVE_GTK2_SUPPORT isn't defined then --gtk can't succeed, don't
support it as a command line option in this case.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c | 8 ++++++++
 tools/perf/builtin-report.c   | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 5e038d9bab05..7664e54bb785 100644
--- a/tools/perf/builtin-annotate.c
+++ b/tools/perf/builtin-annotate.c
@@ -50,7 +50,9 @@ struct perf_annotate {
 	bool	   use_tui;
 #endif
 	bool	   use_stdio, use_stdio2;
+#ifdef HAVE_GTK2_SUPPORT
 	bool	   use_gtk;
+#endif
 	bool	   skip_missing;
 	bool	   has_br_stack;
 	bool	   group_set;
@@ -506,7 +508,9 @@ int cmd_annotate(int argc, const char **argv)
 	OPT_BOOLEAN('q', "quiet", &quiet, "do now show any message"),
 	OPT_BOOLEAN('D', "dump-raw-trace", &dump_trace,
 		    "dump raw trace in ASCII"),
+#ifdef HAVE_GTK2_SUPPORT
 	OPT_BOOLEAN(0, "gtk", &annotate.use_gtk, "Use the GTK interface"),
+#endif
 #ifdef HAVE_SLANG_SUPPORT
 	OPT_BOOLEAN(0, "tui", &annotate.use_tui, "Use the TUI interface"),
 #endif
@@ -592,10 +596,12 @@ int cmd_annotate(int argc, const char **argv)
 	if (annotate_check_args(&annotate.opts) < 0)
 		return -EINVAL;
 
+#ifdef HAVE_GTK2_SUPPORT
 	if (symbol_conf.show_nr_samples && annotate.use_gtk) {
 		pr_err("--show-nr-samples is not available in --gtk mode at this time\n");
 		return ret;
 	}
+#endif
 
 	ret = symbol__validate_sym_arguments();
 	if (ret)
@@ -634,8 +640,10 @@ int cmd_annotate(int argc, const char **argv)
 	else if (annotate.use_tui)
 		use_browser = 1;
 #endif
+#ifdef HAVE_GTK2_SUPPORT
 	else if (annotate.use_gtk)
 		use_browser = 2;
+#endif
 
 	setup_browser(true);
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 1ad75c7ba074..b325d180293d 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -74,7 +74,9 @@ struct report {
 #ifdef HAVE_SLANG_SUPPORT
 	bool			use_tui;
 #endif
+#ifdef HAVE_GTK2_SUPPORT
 	bool			use_gtk;
+#endif
 	bool			use_stdio;
 	bool			show_full_info;
 	bool			show_threads;
@@ -1213,7 +1215,9 @@ int cmd_report(int argc, const char **argv)
 #ifdef HAVE_SLANG_SUPPORT
 	OPT_BOOLEAN(0, "tui", &report.use_tui, "Use the TUI interface"),
 #endif
+#ifdef HAVE_GTK2_SUPPORT
 	OPT_BOOLEAN(0, "gtk", &report.use_gtk, "Use the GTK2 interface"),
+#endif
 	OPT_BOOLEAN(0, "stdio", &report.use_stdio,
 		    "Use the stdio interface"),
 	OPT_BOOLEAN(0, "header", &report.header, "Show data header."),
@@ -1502,8 +1506,10 @@ int cmd_report(int argc, const char **argv)
 	else if (report.use_tui)
 		use_browser = 1;
 #endif
+#ifdef HAVE_GTK2_SUPPORT
 	else if (report.use_gtk)
 		use_browser = 2;
+#endif
 
 	/* Force tty output for header output and per-thread stat. */
 	if (report.header || report.header_only || report.show_threads)
-- 
2.35.0.rc0.227.g00780c9af4-goog

