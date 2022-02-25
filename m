Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013664C4B61
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 17:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243399AbiBYQxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 11:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243262AbiBYQw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 11:52:56 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F16322321C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 08:52:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5969261CFC
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 16:52:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32C52C340E7;
        Fri, 25 Feb 2022 16:52:21 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nNdpM-00B8O9-91;
        Fri, 25 Feb 2022 11:52:20 -0500
Message-ID: <20220225165220.114580289@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 25 Feb 2022 11:52:02 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [for-linus][PATCH 11/13] rtla/hist: Make -E the short version of --entries
References: <20220225165151.824659113@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@kernel.org>

Currently, --entries uses -e as the short version in the hist mode of
timerlat and osnoise tools. But as -e is already used to enable events
on trace sessions by other tools, thus let's keep it available for the
same usage for all rtla tools.

Make -E the short version of --entries for hist mode on all tools.

Note: rtla was merged in this merge window, so rtla was not released yet.

Link: https://lkml.kernel.org/r/5dbf0cbe7364d3a05e708926b41a097c59a02b1e.1645206561.git.bristot@kernel.org

Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/tools/rtla/common_hist_options.rst |  2 +-
 Documentation/tools/rtla/rtla-osnoise-hist.rst   |  2 +-
 tools/tracing/rtla/src/osnoise_hist.c            | 10 +++++-----
 tools/tracing/rtla/src/timerlat_hist.c           | 10 +++++-----
 4 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/tools/rtla/common_hist_options.rst b/Documentation/tools/rtla/common_hist_options.rst
index 0266cd08a6c9..df53ff835bfb 100644
--- a/Documentation/tools/rtla/common_hist_options.rst
+++ b/Documentation/tools/rtla/common_hist_options.rst
@@ -2,7 +2,7 @@
 
         Set the histogram bucket size (default *1*).
 
-**-e**, **--entries** *N*
+**-E**, **--entries** *N*
 
         Set the number of entries of the histogram (default 256).
 
diff --git a/Documentation/tools/rtla/rtla-osnoise-hist.rst b/Documentation/tools/rtla/rtla-osnoise-hist.rst
index 52298ddd8701..f2e79d22c4c4 100644
--- a/Documentation/tools/rtla/rtla-osnoise-hist.rst
+++ b/Documentation/tools/rtla/rtla-osnoise-hist.rst
@@ -36,7 +36,7 @@ default). The reason for reducing the runtime is to avoid starving the
 **rtla** tool. The tool is also set to run for *one minute*. The output
 histogram is set to group outputs in buckets of *10us* and *25* entries::
 
-  [root@f34 ~/]# rtla osnoise hist -P F:1 -c 0-11 -r 900000 -d 1M -b 10 -e 25
+  [root@f34 ~/]# rtla osnoise hist -P F:1 -c 0-11 -r 900000 -d 1M -b 10 -E 25
   # RTLA osnoise histogram
   # Time unit is microseconds (us)
   # Duration:   0 00:01:00
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 1f0b7fce55cf..52c053cc1789 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -426,7 +426,7 @@ static void osnoise_hist_usage(char *usage)
 	static const char * const msg[] = {
 		"",
 		"  usage: rtla osnoise hist [-h] [-D] [-d s] [-p us] [-r us] [-s us] [-S us] [-t[=file]] \\",
-		"	  [-c cpu-list] [-P priority] [-b N] [-e N] [--no-header] [--no-summary] \\",
+		"	  [-c cpu-list] [-P priority] [-b N] [-E N] [--no-header] [--no-summary] \\",
 		"	  [--no-index] [--with-zeros]",
 		"",
 		"	  -h/--help: print this menu",
@@ -439,7 +439,7 @@ static void osnoise_hist_usage(char *usage)
 		"	  -D/--debug: print debug info",
 		"	  -t/--trace[=file]: save the stopped trace to [file|osnoise_trace.txt]",
 		"	  -b/--bucket-size N: set the histogram bucket size (default 1)",
-		"	  -e/--entries N: set the number of entries of the histogram (default 256)",
+		"	  -E/--entries N: set the number of entries of the histogram (default 256)",
 		"	     --no-header: do not print header",
 		"	     --no-summary: do not print summary",
 		"	     --no-index: do not print index",
@@ -486,7 +486,7 @@ static struct osnoise_hist_params
 	while (1) {
 		static struct option long_options[] = {
 			{"bucket-size",		required_argument,	0, 'b'},
-			{"entries",		required_argument,	0, 'e'},
+			{"entries",		required_argument,	0, 'E'},
 			{"cpus",		required_argument,	0, 'c'},
 			{"debug",		no_argument,		0, 'D'},
 			{"duration",		required_argument,	0, 'd'},
@@ -507,7 +507,7 @@ static struct osnoise_hist_params
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "c:b:d:e:Dhp:P:r:s:S:t::0123",
+		c = getopt_long(argc, argv, "c:b:d:E:Dhp:P:r:s:S:t::0123",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -534,7 +534,7 @@ static struct osnoise_hist_params
 			if (!params->duration)
 				osnoise_hist_usage("Invalid -D duration\n");
 			break;
-		case 'e':
+		case 'E':
 			params->entries = get_llong_from_str(optarg);
 			if ((params->entries < 10) || (params->entries > 9999999))
 				osnoise_hist_usage("Entries must be > 10 and < 9999999\n");
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 436a799f9adf..237e1735afa7 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -429,7 +429,7 @@ static void timerlat_hist_usage(char *usage)
 	char *msg[] = {
 		"",
 		"  usage: [rtla] timerlat hist [-h] [-q] [-d s] [-D] [-n] [-p us] [-i us] [-T us] [-s us] [-t[=file]] \\",
-		"         [-c cpu-list] [-P priority] [-e N] [-b N]  [--no-irq] [--no-thread] [--no-header] [--no-summary] \\",
+		"         [-c cpu-list] [-P priority] [-E N] [-b N]  [--no-irq] [--no-thread] [--no-header] [--no-summary] \\",
 		"         [--no-index] [--with-zeros]",
 		"",
 		"	  -h/--help: print this menu",
@@ -443,7 +443,7 @@ static void timerlat_hist_usage(char *usage)
 		"	  -T/--trace[=file]: save the stopped trace to [file|timerlat_trace.txt]",
 		"	  -n/--nano: display data in nanoseconds",
 		"	  -b/--bucket-size N: set the histogram bucket size (default 1)",
-		"	  -e/--entries N: set the number of entries of the histogram (default 256)",
+		"	  -E/--entries N: set the number of entries of the histogram (default 256)",
 		"	     --no-irq: ignore IRQ latencies",
 		"	     --no-thread: ignore thread latencies",
 		"	     --no-header: do not print header",
@@ -494,7 +494,7 @@ static struct timerlat_hist_params
 			{"cpus",		required_argument,	0, 'c'},
 			{"bucket-size",		required_argument,	0, 'b'},
 			{"debug",		no_argument,		0, 'D'},
-			{"entries",		required_argument,	0, 'e'},
+			{"entries",		required_argument,	0, 'E'},
 			{"duration",		required_argument,	0, 'd'},
 			{"help",		no_argument,		0, 'h'},
 			{"irq",			required_argument,	0, 'i'},
@@ -516,7 +516,7 @@ static struct timerlat_hist_params
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "c:b:d:e:Dhi:np:P:s:t::T:012345",
+		c = getopt_long(argc, argv, "c:b:d:E:Dhi:np:P:s:t::T:012345",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -543,7 +543,7 @@ static struct timerlat_hist_params
 			if (!params->duration)
 				timerlat_hist_usage("Invalid -D duration\n");
 			break;
-		case 'e':
+		case 'E':
 			params->entries = get_llong_from_str(optarg);
 			if ((params->entries < 10) || (params->entries > 9999999))
 					timerlat_hist_usage("Entries must be > 10 and < 9999999\n");
-- 
2.34.1
