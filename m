Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D854DA2E7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:03:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351303AbiCOTEd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351238AbiCOTEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:04:04 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08DE0522CA
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:02:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 3B4A2CE1C85
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:02:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D46C340F9;
        Tue, 15 Mar 2022 19:02:44 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nUCRP-003jhg-H2;
        Tue, 15 Mar 2022 15:02:43 -0400
Message-ID: <20220315190243.362257459@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 15 Mar 2022 15:02:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [for-next][PATCH 04/15] rtla/timerlat: Add the automatic trace option
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

It is equivalent to setting osnoise/stop_tracing_total_us and print_stack
with the argument, and saving the trace to timerlat_trace.txt file if the
trace is stopped automatically.

Link: https://lkml.kernel.org/r/92438f7ef132c731f538cebdf77850300afe04a5.1646247211.git.bristot@kernel.org

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Clark Williams <williams@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../tools/rtla/common_timerlat_options.rst    |  7 ++++++
 tools/tracing/rtla/src/timerlat_hist.c        | 24 +++++++++++++++----
 tools/tracing/rtla/src/timerlat_top.c         | 22 ++++++++++++++---
 3 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/Documentation/tools/rtla/common_timerlat_options.rst b/Documentation/tools/rtla/common_timerlat_options.rst
index e9c1bfd55d48..14a24a121f5d 100644
--- a/Documentation/tools/rtla/common_timerlat_options.rst
+++ b/Documentation/tools/rtla/common_timerlat_options.rst
@@ -1,3 +1,10 @@
+**-a**, **--auto** *us*
+
+        Set the automatic trace mode. This mode sets some commonly used options
+        while debugging the system. It is equivalent to use **-T** *us* **-s** *us*
+        **-t**. By default, *timerlat* tracer uses FIFO:95 for *timerlat* threads,
+        thus equilavent to **-P** *f:95*.
+
 **-p**, **--period** *us*
 
         Set the *timerlat* tracer period in microseconds.
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 237e1735afa7..9cd97095b04a 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -428,11 +428,12 @@ static void timerlat_hist_usage(char *usage)
 
 	char *msg[] = {
 		"",
-		"  usage: [rtla] timerlat hist [-h] [-q] [-d s] [-D] [-n] [-p us] [-i us] [-T us] [-s us] [-t[=file]] \\",
-		"         [-c cpu-list] [-P priority] [-E N] [-b N]  [--no-irq] [--no-thread] [--no-header] [--no-summary] \\",
-		"         [--no-index] [--with-zeros]",
+		"  usage: [rtla] timerlat hist [-h] [-q] [-d s] [-D] [-n] [-a us] [-p us] [-i us] [-T us] [-s us] \\",
+		"         [-t[=file]] [-c cpu-list] [-P priority] [-E N] [-b N]  [--no-irq] [--no-thread] [--no-header] \\",
+		"         [--no-summary] [--no-index] [--with-zeros]",
 		"",
 		"	  -h/--help: print this menu",
+		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us latency is hit",
 		"	  -p/--period us: timerlat period in us",
 		"	  -i/--irq us: stop trace if the irq latency is higher than the argument in us",
 		"	  -T/--thread us: stop trace if the thread latency is higher than the argument in us",
@@ -477,6 +478,7 @@ static struct timerlat_hist_params
 *timerlat_hist_parse_args(int argc, char *argv[])
 {
 	struct timerlat_hist_params *params;
+	int auto_thresh;
 	int retval;
 	int c;
 
@@ -491,6 +493,7 @@ static struct timerlat_hist_params
 
 	while (1) {
 		static struct option long_options[] = {
+			{"auto",		required_argument,	0, 'a'},
 			{"cpus",		required_argument,	0, 'c'},
 			{"bucket-size",		required_argument,	0, 'b'},
 			{"debug",		no_argument,		0, 'D'},
@@ -516,7 +519,7 @@ static struct timerlat_hist_params
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "c:b:d:E:Dhi:np:P:s:t::T:012345",
+		c = getopt_long(argc, argv, "a:c:b:d:E:Dhi:np:P:s:t::T:012345",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -524,6 +527,19 @@ static struct timerlat_hist_params
 			break;
 
 		switch (c) {
+		case 'a':
+			auto_thresh = get_llong_from_str(optarg);
+
+			/* set thread stop to auto_thresh */
+			params->stop_total_us = auto_thresh;
+
+			/* get stack trace */
+			params->print_stack = auto_thresh;
+
+			/* set trace */
+			params->trace_output = "timerlat_trace.txt";
+
+			break;
 		case 'c':
 			retval = parse_cpu_list(optarg, &params->monitored_cpus);
 			if (retval)
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index d4187f6534ed..aef044832964 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -266,10 +266,11 @@ static void timerlat_top_usage(char *usage)
 
 	static const char *const msg[] = {
 		"",
-		"  usage: rtla timerlat [top] [-h] [-q] [-d s] [-D] [-n] [-p us] [-i us] [-T us] [-s us] [-t[=file]] \\",
-		"	  [-c cpu-list] [-P priority]",
+		"  usage: rtla timerlat [top] [-h] [-q] [-a us] [-d s] [-D] [-n] [-p us] [-i us] [-T us] [-s us] \\",
+		"	  [[-t[=file]] -c cpu-list] [-P priority]",
 		"",
 		"	  -h/--help: print this menu",
+		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us latency is hit",
 		"	  -p/--period us: timerlat period in us",
 		"	  -i/--irq us: stop trace if the irq latency is higher than the argument in us",
 		"	  -T/--thread us: stop trace if the thread latency is higher than the argument in us",
@@ -307,6 +308,7 @@ static struct timerlat_top_params
 *timerlat_top_parse_args(int argc, char **argv)
 {
 	struct timerlat_top_params *params;
+	long long auto_thresh;
 	int retval;
 	int c;
 
@@ -319,6 +321,7 @@ static struct timerlat_top_params
 
 	while (1) {
 		static struct option long_options[] = {
+			{"auto",		required_argument,	0, 'a'},
 			{"cpus",		required_argument,	0, 'c'},
 			{"debug",		no_argument,		0, 'D'},
 			{"duration",		required_argument,	0, 'd'},
@@ -337,7 +340,7 @@ static struct timerlat_top_params
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "c:d:Dhi:np:P:qs:t::T:",
+		c = getopt_long(argc, argv, "a:c:d:Dhi:np:P:qs:t::T:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -345,6 +348,19 @@ static struct timerlat_top_params
 			break;
 
 		switch (c) {
+		case 'a':
+			auto_thresh = get_llong_from_str(optarg);
+
+			/* set thread stop to auto_thresh */
+			params->stop_total_us = auto_thresh;
+
+			/* get stack trace */
+			params->print_stack = auto_thresh;
+
+			/* set trace */
+			params->trace_output = "timerlat_trace.txt";
+
+			break;
 		case 'c':
 			retval = parse_cpu_list(optarg, &params->monitored_cpus);
 			if (retval)
-- 
2.35.1
