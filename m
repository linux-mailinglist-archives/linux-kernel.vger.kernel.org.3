Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230944DA2ED
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350898AbiCOTFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:05:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351248AbiCOTEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:04:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195F3522F7
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:02:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B7BED616F6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8320AC340F5;
        Tue, 15 Mar 2022 19:02:45 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nUCRQ-003jl2-LM;
        Tue, 15 Mar 2022 15:02:44 -0400
Message-ID: <20220315190244.489193587@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 15 Mar 2022 15:02:24 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [for-next][PATCH 10/15] rtla: Add --filter support
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

Add --filter option. This option enables a trace event filtering of the
previous -e sys:event argument.

This option is available for all current tools.

Link: https://lkml.kernel.org/r/509d70b6348d3e5bcbf1f07ab725ce08d063149a.1646247211.git.bristot@kernel.org

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Clark Williams <williams@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 Documentation/tools/rtla/common_options.rst |  4 ++++
 tools/tracing/rtla/src/osnoise_hist.c       | 20 +++++++++++++++++---
 tools/tracing/rtla/src/osnoise_top.c        | 18 ++++++++++++++++--
 tools/tracing/rtla/src/timerlat_hist.c      | 20 +++++++++++++++++---
 tools/tracing/rtla/src/timerlat_top.c       | 18 ++++++++++++++++--
 5 files changed, 70 insertions(+), 10 deletions(-)

diff --git a/Documentation/tools/rtla/common_options.rst b/Documentation/tools/rtla/common_options.rst
index e5870b944334..afd45bae821f 100644
--- a/Documentation/tools/rtla/common_options.rst
+++ b/Documentation/tools/rtla/common_options.rst
@@ -18,6 +18,10 @@
 
         Enable an event in the trace (**-t**) session. The argument can be a specific event, e.g., **-e** *sched:sched_switch*, or all events of a system group, e.g., **-e** *sched*. Multiple **-e** are allowed. It is only active when **-t** or **-a** are set.
 
+**--filter** *<filter>*
+
+        Filter the previous **-e** *sys:event* event with *<filter>*. For further information about event filtering see https://www.kernel.org/doc/html/latest/trace/events.html#event-filtering.
+
 **--trigger** *<trigger>*
         Enable a trace event trigger to the previous **-e** *sys:event*. For further information about event trigger see https://www.kernel.org/doc/html/latest/trace/events.html#event-triggers.
 
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 3e8f89b4f306..f86b5fb94efd 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -428,8 +428,9 @@ static void osnoise_hist_usage(char *usage)
 	static const char * const msg[] = {
 		"",
 		"  usage: rtla osnoise hist [-h] [-D] [-d s] [-a us] [-p us] [-r us] [-s us] [-S us] \\",
-		"	  [-T us] [-t[=file]] [-e sys[:event]] [--trigger <trigger>] [-c cpu-list] [-P priority] \\",
-		"	  [-b N] [-E N] [--no-header] [--no-summary] [--no-index] [--with-zeros]",
+		"	  [-T us] [-t[=file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] \\",
+		"	  [-c cpu-list] [-P priority] [-b N] [-E N] [--no-header] [--no-summary] [--no-index] \\",
+		"	  [--with-zeros]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us sample is hit",
@@ -443,6 +444,7 @@ static void osnoise_hist_usage(char *usage)
 		"	  -D/--debug: print debug info",
 		"	  -t/--trace[=file]: save the stopped trace to [file|osnoise_trace.txt]",
 		"	  -e/--event <sys:event>: enable the <sys:event> in the trace instance, multiple -e are allowed",
+		"	     --filter <filter>: enable a trace event filter to the previous -e event",
 		"	     --trigger <trigger>: enable a trace event trigger to the previous -e event",
 		"	  -b/--bucket-size N: set the histogram bucket size (default 1)",
 		"	  -E/--entries N: set the number of entries of the histogram (default 256)",
@@ -512,13 +514,14 @@ static struct osnoise_hist_params
 			{"no-index",		no_argument,		0, '2'},
 			{"with-zeros",		no_argument,		0, '3'},
 			{"trigger",		required_argument,	0, '4'},
+			{"filter",		required_argument,	0, '5'},
 			{0, 0, 0, 0}
 		};
 
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:b:d:e:E:Dhp:P:r:s:S:t::T:01234:",
+		c = getopt_long(argc, argv, "a:c:b:d:e:E:Dhp:P:r:s:S:t::T:01234:5:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -632,6 +635,17 @@ static struct osnoise_hist_params
 				osnoise_hist_usage("--trigger requires a previous -e\n");
 			}
 			break;
+		case '5': /* filter */
+			if (params->events) {
+				retval = trace_event_add_filter(params->events, optarg);
+				if (retval) {
+					err_msg("Error adding filter %s\n", optarg);
+					exit(EXIT_FAILURE);
+				}
+			} else {
+				osnoise_hist_usage("--filter requires a previous -e\n");
+			}
+			break;
 		default:
 			osnoise_hist_usage("Invalid option");
 		}
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index d16c7ce3e9fa..c3d75ee456a5 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -247,7 +247,8 @@ void osnoise_top_usage(char *usage)
 
 	static const char * const msg[] = {
 		"  usage: rtla osnoise [top] [-h] [-q] [-D] [-d s] [-a us] [-p us] [-r us] [-s us] [-S us] \\",
-		"	  [-T us] [-t[=file]] [-e sys[:event]] [--trigger <trigger>] [-c cpu-list] [-P priority]",
+		"	  [-T us] [-t[=file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] \\",
+		"	  [-c cpu-list] [-P priority]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us sample is hit",
@@ -261,6 +262,7 @@ void osnoise_top_usage(char *usage)
 		"	  -D/--debug: print debug info",
 		"	  -t/--trace[=file]: save the stopped trace to [file|osnoise_trace.txt]",
 		"	  -e/--event <sys:event>: enable the <sys:event> in the trace instance, multiple -e are allowed",
+		"	     --filter <filter>: enable a trace event filter to the previous -e event",
 		"	     --trigger <trigger>: enable a trace event trigger to the previous -e event",
 		"	  -q/--quiet print only a summary at the end",
 		"	  -P/--priority o:prio|r:prio|f:prio|d:runtime:period : set scheduling parameters",
@@ -314,13 +316,14 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 			{"threshold",		required_argument,	0, 'T'},
 			{"trace",		optional_argument,	0, 't'},
 			{"trigger",		required_argument,	0, '0'},
+			{"filter",		required_argument,	0, '1'},
 			{0, 0, 0, 0}
 		};
 
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:d:De:hp:P:qr:s:S:t::T:0:",
+		c = getopt_long(argc, argv, "a:c:d:De:hp:P:qr:s:S:t::T:0:1:",
 				 long_options, &option_index);
 
 		/* Detect the end of the options. */
@@ -415,6 +418,17 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 				osnoise_top_usage("--trigger requires a previous -e\n");
 			}
 			break;
+		case '1': /* filter */
+			if (params->events) {
+				retval = trace_event_add_filter(params->events, optarg);
+				if (retval) {
+					err_msg("Error adding filter %s\n", optarg);
+					exit(EXIT_FAILURE);
+				}
+			} else {
+				osnoise_top_usage("--filter requires a previous -e\n");
+			}
+			break;
 		default:
 			osnoise_top_usage("Invalid option");
 		}
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 765b5a313bd2..8341f38fd0b1 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -430,8 +430,9 @@ static void timerlat_hist_usage(char *usage)
 	char *msg[] = {
 		"",
 		"  usage: [rtla] timerlat hist [-h] [-q] [-d s] [-D] [-n] [-a us] [-p us] [-i us] [-T us] [-s us] \\",
-		"         [-t[=file]] [-e sys[:event]] [--trigger <trigger>] [-c cpu-list] [-P priority] [-E N] \\",
-		"         [-b N] [--no-irq] [--no-thread] [--no-header] [--no-summary] [--no-index] [--with-zeros]",
+		"         [-t[=file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] [-c cpu-list] \\",
+		"	  [-P priority] [-E N] [-b N] [--no-irq] [--no-thread] [--no-header] [--no-summary] \\",
+		"	  [--no-index] [--with-zeros]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us latency is hit",
@@ -444,6 +445,7 @@ static void timerlat_hist_usage(char *usage)
 		"	  -D/--debug: print debug info",
 		"	  -t/--trace[=file]: save the stopped trace to [file|timerlat_trace.txt]",
 		"	  -e/--event <sys:event>: enable the <sys:event> in the trace instance, multiple -e are allowed",
+		"	     --filter <filter>: enable a trace event filter to the previous -e event",
 		"	     --trigger <trigger>: enable a trace event trigger to the previous -e event",
 		"	  -n/--nano: display data in nanoseconds",
 		"	  -b/--bucket-size N: set the histogram bucket size (default 1)",
@@ -519,13 +521,14 @@ static struct timerlat_hist_params
 			{"no-index",		no_argument,		0, '4'},
 			{"with-zeros",		no_argument,		0, '5'},
 			{"trigger",		required_argument,	0, '6'},
+			{"filter",		required_argument,	0, '7'},
 			{0, 0, 0, 0}
 		};
 
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:b:d:e:E:Dhi:np:P:s:t::T:0123456:",
+		c = getopt_long(argc, argv, "a:c:b:d:e:E:Dhi:np:P:s:t::T:0123456:7:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -645,6 +648,17 @@ static struct timerlat_hist_params
 				timerlat_hist_usage("--trigger requires a previous -e\n");
 			}
 			break;
+		case '7': /* filter */
+			if (params->events) {
+				retval = trace_event_add_filter(params->events, optarg);
+				if (retval) {
+					err_msg("Error adding filter %s\n", optarg);
+					exit(EXIT_FAILURE);
+				}
+			} else {
+				timerlat_hist_usage("--filter requires a previous -e\n");
+			}
+			break;
 		default:
 			timerlat_hist_usage("Invalid option");
 		}
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 76927d4e0dac..9ce5a09664bc 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -268,7 +268,8 @@ static void timerlat_top_usage(char *usage)
 	static const char *const msg[] = {
 		"",
 		"  usage: rtla timerlat [top] [-h] [-q] [-a us] [-d s] [-D] [-n] [-p us] [-i us] [-T us] [-s us] \\",
-		"	  [[-t[=file]] [-e sys[:event]] [--trigger <trigger>] [-c cpu-list] [-P priority]",
+		"	  [[-t[=file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] [-c cpu-list] \\",
+		"	  [-P priority]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us latency is hit",
@@ -281,6 +282,7 @@ static void timerlat_top_usage(char *usage)
 		"	  -D/--debug: print debug info",
 		"	  -t/--trace[=file]: save the stopped trace to [file|timerlat_trace.txt]",
 		"	  -e/--event <sys:event>: enable the <sys:event> in the trace instance, multiple -e are allowed",
+		"	     --filter <command>: enable a trace event filter to the previous -e event",
 		"	     --trigger <command>: enable a trace event trigger to the previous -e event",
 		"	  -n/--nano: display data in nanoseconds",
 		"	  -q/--quiet print only a summary at the end",
@@ -340,13 +342,14 @@ static struct timerlat_top_params
 			{"thread",		required_argument,	0, 'T'},
 			{"trace",		optional_argument,	0, 't'},
 			{"trigger",		required_argument,	0, '0'},
+			{"filter",		required_argument,	0, '1'},
 			{0, 0, 0, 0}
 		};
 
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:d:De:hi:np:P:qs:t::T:0:",
+		c = getopt_long(argc, argv, "a:c:d:De:hi:np:P:qs:t::T:0:1:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -440,6 +443,17 @@ static struct timerlat_top_params
 				timerlat_top_usage("--trigger requires a previous -e\n");
 			}
 			break;
+		case '1': /* filter */
+			if (params->events) {
+				retval = trace_event_add_filter(params->events, optarg);
+				if (retval) {
+					err_msg("Error adding filter %s\n", optarg);
+					exit(EXIT_FAILURE);
+				}
+			} else {
+				timerlat_top_usage("--filter requires a previous -e\n");
+			}
+			break;
 		default:
 			timerlat_top_usage("Invalid option");
 		}
-- 
2.35.1
