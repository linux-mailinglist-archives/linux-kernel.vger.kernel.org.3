Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 621F756ACDA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 22:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236437AbiGGUio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 16:38:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231875AbiGGUim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 16:38:42 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9560D1CFCF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 13:38:41 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-31ce88f9ab8so39189837b3.16
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 13:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=MtmsWhHJfa7z6EGDAwuHnwZvzmYyvpgdzqZZqyHQmxU=;
        b=SvBsyqgeUtFCOrwSGE21tf7OVIzDLVqlgjC31Qjwz3eXSGy3keVTu5byI7NFAGM13Z
         DKHnL2hMKDyFYZseWOr8PLiB0Z0MexDr92vfEzihUDHIDr8H1Xgg+mWVtw7dPggcnx69
         AagT5Dlkmpn1tzFrNeW84M801vDVhdHqKZMJKndqrF/re3dWM95/ex/dj8vFDlhQr+ge
         pnWso1m+u2J6AVT+Rh1IqAdfTLTCWAcIAyypt3QQJ65nCETR8nmjDUyelkY856lyCp3z
         yejGaPAC2scFt6i7Z0k19x9RgCGB1O883p6rUoMhvDnbzoqfrlyiqzrszPLV3O92Dd/j
         pHVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=MtmsWhHJfa7z6EGDAwuHnwZvzmYyvpgdzqZZqyHQmxU=;
        b=NDM3hVCjmtiChlzDyw2fNr3+snH6rBz4LYe/QeCaQ5cn3JOwn5jxL0b1zB8L2O9jm/
         Yne9SlZowO7xqSCzF500wmssbt6iF5cbYB1kiI0z1j15xFslj173a6C3z4L6OwzNMwBl
         v2TpflmEbAxHLUGWaU/vd9qM2qIo5j+4lbz3CYS4EjhmrAo+xLQ72wdU7S1RSFq1pU+k
         RUCPanTbiTMfRY8FVkyHRRLAYHogayQhoE70I/3B+rJZLmj8gJ8exnJvHyLy+CSAvRgJ
         Eo63sDkg+S65B/fufUXo9kdNjUM/J2UeYmB7Rhrm11ChLjaEfSNAbc3/IKaxOF3Gt7cF
         C+4Q==
X-Gm-Message-State: AJIora8jnkspebpBR8uGWxM1NIsZwmblbR6CEFdT7FsQyD9Q2RhMNdcJ
        HTOHvSaRnxoyByyM5RVV+hHUY/GMMXQn
X-Google-Smtp-Source: AGRyM1vslLtKenxRif28iTau2qVy76RKBRFTYtWiRIc+Cm3GzLY4Tsaqyt6Jd+NeqkRZ7LehqxcUHpVuKay+
X-Received: from irogers.svl.corp.google.com ([2620:15c:2d4:203:bf75:f79:d509:a8d1])
 (user=irogers job=sendgmr) by 2002:a0d:cc8c:0:b0:31d:1154:b730 with SMTP id
 o134-20020a0dcc8c000000b0031d1154b730mr10257ywd.440.1657226320914; Thu, 07
 Jul 2022 13:38:40 -0700 (PDT)
Date:   Thu,  7 Jul 2022 13:38:36 -0700
Message-Id: <20220707203836.345918-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v2] perf gtk: Only support --gtk if compiled in
From:   Ian Rogers <irogers@google.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        xaizek <xaizek@posteo.net>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If HAVE_GTK2_SUPPORT isn't defined then --gtk can't succeed, don't
support it as a command line option in this case.

v2. Is a rebase. Patch appears to have been missed in:
https://lore.kernel.org/lkml/Ygu40djM1MqAfkcF@kernel.org/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-annotate.c | 8 ++++++++
 tools/perf/builtin-report.c   | 6 ++++++
 2 files changed, 14 insertions(+)

diff --git a/tools/perf/builtin-annotate.c b/tools/perf/builtin-annotate.c
index 2ffe071dbcff..f839e69492e8 100644
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
@@ -526,7 +528,9 @@ int cmd_annotate(int argc, const char **argv)
 	OPT_BOOLEAN('q', "quiet", &quiet, "do now show any message"),
 	OPT_BOOLEAN('D', "dump-raw-trace", &dump_trace,
 		    "dump raw trace in ASCII"),
+#ifdef HAVE_GTK2_SUPPORT
 	OPT_BOOLEAN(0, "gtk", &annotate.use_gtk, "Use the GTK interface"),
+#endif
 #ifdef HAVE_SLANG_SUPPORT
 	OPT_BOOLEAN(0, "tui", &annotate.use_tui, "Use the TUI interface"),
 #endif
@@ -614,10 +618,12 @@ int cmd_annotate(int argc, const char **argv)
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
@@ -656,8 +662,10 @@ int cmd_annotate(int argc, const char **argv)
 	else if (annotate.use_tui)
 		use_browser = 1;
 #endif
+#ifdef HAVE_GTK2_SUPPORT
 	else if (annotate.use_gtk)
 		use_browser = 2;
+#endif
 
 	setup_browser(true);
 
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index afe4a5539ecc..91ed41cc7d88 100644
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
@@ -1227,7 +1229,9 @@ int cmd_report(int argc, const char **argv)
 #ifdef HAVE_SLANG_SUPPORT
 	OPT_BOOLEAN(0, "tui", &report.use_tui, "Use the TUI interface"),
 #endif
+#ifdef HAVE_GTK2_SUPPORT
 	OPT_BOOLEAN(0, "gtk", &report.use_gtk, "Use the GTK2 interface"),
+#endif
 	OPT_BOOLEAN(0, "stdio", &report.use_stdio,
 		    "Use the stdio interface"),
 	OPT_BOOLEAN(0, "header", &report.header, "Show data header."),
@@ -1516,8 +1520,10 @@ int cmd_report(int argc, const char **argv)
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
2.37.0.rc0.161.g10f37bed90-goog

