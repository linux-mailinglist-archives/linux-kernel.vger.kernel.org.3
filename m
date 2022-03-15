Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D05A14DA2DF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351253AbiCOTEH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:04:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351220AbiCOTEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:04:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154C1522C6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:02:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D7011616E2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:02:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E73FC340F6;
        Tue, 15 Mar 2022 19:02:44 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nUCRP-003jh8-B2;
        Tue, 15 Mar 2022 15:02:43 -0400
Message-ID: <20220315190243.178569363@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 15 Mar 2022 15:02:17 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [for-next][PATCH 03/15] rtla/osnoise: Add the automatic trace option
References: <20220315190214.613102181@goodmis.org>
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

Add the -a/--auto <arg in us> option. This option sets some commonly
used options while debugging the system. It aims to help users produce
reports in the field, reducing the number of arguments passed to the
tool in the first approach to a problem.

It is equivalent to setting osnoise/stop_tracing_us with the argument,
setting tracing_thresh to 1 us, and saving the trace to osnoise_trace.txt
file if the trace is stopped automatically.

Link: https://lkml.kernel.org/r/ef04c961b227eb93a83cd0b54bfca45e1a381b77.1646247211.git.bristot@kernel.org

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Clark Williams <williams@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../tools/rtla/common_osnoise_options.rst     |  5 +++++
 tools/tracing/rtla/src/osnoise_hist.c         | 19 ++++++++++++++++---
 tools/tracing/rtla/src/osnoise_top.c          | 19 ++++++++++++++++---
 3 files changed, 37 insertions(+), 6 deletions(-)

diff --git a/Documentation/tools/rtla/common_osnoise_options.rst b/Documentation/tools/rtla/common_osnoise_options.rst
index 27f1493f7bc0..f792ca58c211 100644
--- a/Documentation/tools/rtla/common_osnoise_options.rst
+++ b/Documentation/tools/rtla/common_osnoise_options.rst
@@ -1,3 +1,8 @@
+**-a**, **--auto** *us*
+
+        Set the automatic trace mode. This mode sets some commonly used options
+        while debugging the system. It is equivalent to use **-s** *us* **-T 1 -t**.
+
 **-p**, **--period** *us*
 
         Set the *osnoise* tracer period in microseconds.
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index ab02219de528..5698da2fe3dd 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -426,11 +426,12 @@ static void osnoise_hist_usage(char *usage)
 
 	static const char * const msg[] = {
 		"",
-		"  usage: rtla osnoise hist [-h] [-D] [-d s] [-p us] [-r us] [-s us] [-S us] [-T us] \\",
-		"	  [-t[=file]] [-c cpu-list] [-P priority] [-b N] [-E N] [--no-header] \\",
+		"  usage: rtla osnoise hist [-h] [-D] [-d s] [-a us] [-p us] [-r us] [-s us] [-S us] \\",
+		"	  [-T us] [-t[=file]] [-c cpu-list] [-P priority] [-b N] [-E N] [--no-header] \\",
 		"	  [--no-summary] [--no-index] [--with-zeros]",
 		"",
 		"	  -h/--help: print this menu",
+		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us sample is hit",
 		"	  -p/--period us: osnoise period in us",
 		"	  -r/--runtime us: osnoise runtime in us",
 		"	  -s/--stop us: stop trace if a single sample is higher than the argument in us",
@@ -487,6 +488,7 @@ static struct osnoise_hist_params
 
 	while (1) {
 		static struct option long_options[] = {
+			{"auto",		required_argument,	0, 'a'},
 			{"bucket-size",		required_argument,	0, 'b'},
 			{"entries",		required_argument,	0, 'E'},
 			{"cpus",		required_argument,	0, 'c'},
@@ -510,7 +512,7 @@ static struct osnoise_hist_params
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "c:b:d:E:Dhp:P:r:s:S:t::T:0123",
+		c = getopt_long(argc, argv, "a:c:b:d:E:Dhp:P:r:s:S:t::T:0123",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -518,6 +520,17 @@ static struct osnoise_hist_params
 			break;
 
 		switch (c) {
+		case 'a':
+			/* set sample stop to auto_thresh */
+			params->stop_us = get_llong_from_str(optarg);
+
+			/* set sample threshold to 1 */
+			params->threshold = 1;
+
+			/* set trace */
+			params->trace_output = "osnoise_trace.txt";
+
+			break;
 		case 'b':
 			params->bucket_size = get_llong_from_str(optarg);
 			if ((params->bucket_size == 0) || (params->bucket_size >= 1000000))
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 07fb1b8314d3..a6f434f85738 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -245,10 +245,11 @@ void osnoise_top_usage(char *usage)
 	int i;
 
 	static const char * const msg[] = {
-		"  usage: rtla osnoise [top] [-h] [-q] [-D] [-d s] [-p us] [-r us] [-s us] [-S us] [-T us] \\",
-		"	  [-t[=file]] [-c cpu-list] [-P priority]",
+		"  usage: rtla osnoise [top] [-h] [-q] [-D] [-d s] [-a us] [-p us] [-r us] [-s us] [-S us] \\",
+		"	  [-T us] [-t[=file]] [-c cpu-list] [-P priority]",
 		"",
 		"	  -h/--help: print this menu",
+		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us sample is hit",
 		"	  -p/--period us: osnoise period in us",
 		"	  -r/--runtime us: osnoise runtime in us",
 		"	  -s/--stop us: stop trace if a single sample is higher than the argument in us",
@@ -294,6 +295,7 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 
 	while (1) {
 		static struct option long_options[] = {
+			{"auto",		required_argument,	0, 'a'},
 			{"cpus",		required_argument,	0, 'c'},
 			{"debug",		no_argument,		0, 'D'},
 			{"duration",		required_argument,	0, 'd'},
@@ -312,7 +314,7 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "c:d:Dhp:P:qr:s:S:t::T:",
+		c = getopt_long(argc, argv, "a:c:d:Dhp:P:qr:s:S:t::T:",
 				 long_options, &option_index);
 
 		/* Detect the end of the options. */
@@ -320,6 +322,17 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 			break;
 
 		switch (c) {
+		case 'a':
+			/* set sample stop to auto_thresh */
+			params->stop_us = get_llong_from_str(optarg);
+
+			/* set sample threshold to 1 */
+			params->threshold = 1;
+
+			/* set trace */
+			params->trace_output = "osnoise_trace.txt";
+
+			break;
 		case 'c':
 			retval = parse_cpu_list(optarg, &params->monitored_cpus);
 			if (retval)
-- 
2.35.1
