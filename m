Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1EB04CAE1C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244854AbiCBTEQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Mar 2022 14:04:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236279AbiCBTEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:04:13 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86D4452B34
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:03:19 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-45-UjZ6NAtIPCKpRDxEz1ozTw-1; Wed, 02 Mar 2022 14:03:13 -0500
X-MC-Unique: UjZ6NAtIPCKpRDxEz1ozTw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1A69F1854E21;
        Wed,  2 Mar 2022 19:03:12 +0000 (UTC)
Received: from x1.com (unknown [10.22.32.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 094D019C59;
        Wed,  2 Mar 2022 19:03:09 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH V3 08/15] rtla: Add --trigger support
Date:   Wed,  2 Mar 2022 20:01:33 +0100
Message-Id: <07d2983d5f71261d4da89dbaf02efcad100ab8ee.1646247211.git.bristot@kernel.org>
In-Reply-To: <cover.1646247211.git.bristot@kernel.org>
References: <cover.1646247211.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add --trigger option. This option enables a trace event trigger to the
previous -e sys:event argument, allowing some advanced tracing options.

For instance, in a system with CPUs 2:23 isolated, it is possible to get
a stack trace of thread wakeup targeting those CPUs while running
osnoise with the following command line:

 # osnoise top -c 2-23 -a 50 -e sched:sched_wakeup --trigger="stacktrace if target_cpu >= 2"

This option is available for all current tools.

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 Documentation/tools/rtla/common_options.rst |  3 +++
 tools/tracing/rtla/src/osnoise_hist.c       | 19 ++++++++++++++++---
 tools/tracing/rtla/src/osnoise_top.c        | 17 +++++++++++++++--
 tools/tracing/rtla/src/timerlat_hist.c      | 19 ++++++++++++++++---
 tools/tracing/rtla/src/timerlat_top.c       | 17 +++++++++++++++--
 5 files changed, 65 insertions(+), 10 deletions(-)

diff --git a/Documentation/tools/rtla/common_options.rst b/Documentation/tools/rtla/common_options.rst
index 89d783dc3304..e5870b944334 100644
--- a/Documentation/tools/rtla/common_options.rst
+++ b/Documentation/tools/rtla/common_options.rst
@@ -18,6 +18,9 @@
 
         Enable an event in the trace (**-t**) session. The argument can be a specific event, e.g., **-e** *sched:sched_switch*, or all events of a system group, e.g., **-e** *sched*. Multiple **-e** are allowed. It is only active when **-t** or **-a** are set.
 
+**--trigger** *<trigger>*
+        Enable a trace event trigger to the previous **-e** *sys:event*. For further information about event trigger see https://www.kernel.org/doc/html/latest/trace/events.html#event-triggers.
+
 **-P**, **--priority** *o:prio|r:prio|f:prio|d:runtime:period*
 
         Set scheduling parameters to the osnoise tracer threads, the format to set the priority are:
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 10d683a98087..3e8f89b4f306 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -428,8 +428,8 @@ static void osnoise_hist_usage(char *usage)
 	static const char * const msg[] = {
 		"",
 		"  usage: rtla osnoise hist [-h] [-D] [-d s] [-a us] [-p us] [-r us] [-s us] [-S us] \\",
-		"	  [-T us] [-t[=file]] [-e sys[:event]] [-c cpu-list] [-P priority] [-b N] [-E N] \\",
-		"	  [--no-header] [--no-summary] [--no-index] [--with-zeros]",
+		"	  [-T us] [-t[=file]] [-e sys[:event]] [--trigger <trigger>] [-c cpu-list] [-P priority] \\",
+		"	  [-b N] [-E N] [--no-header] [--no-summary] [--no-index] [--with-zeros]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us sample is hit",
@@ -443,6 +443,7 @@ static void osnoise_hist_usage(char *usage)
 		"	  -D/--debug: print debug info",
 		"	  -t/--trace[=file]: save the stopped trace to [file|osnoise_trace.txt]",
 		"	  -e/--event <sys:event>: enable the <sys:event> in the trace instance, multiple -e are allowed",
+		"	     --trigger <trigger>: enable a trace event trigger to the previous -e event",
 		"	  -b/--bucket-size N: set the histogram bucket size (default 1)",
 		"	  -E/--entries N: set the number of entries of the histogram (default 256)",
 		"	     --no-header: do not print header",
@@ -510,13 +511,14 @@ static struct osnoise_hist_params
 			{"no-summary",		no_argument,		0, '1'},
 			{"no-index",		no_argument,		0, '2'},
 			{"with-zeros",		no_argument,		0, '3'},
+			{"trigger",		required_argument,	0, '4'},
 			{0, 0, 0, 0}
 		};
 
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:b:d:e:E:Dhp:P:r:s:S:t::T:0123",
+		c = getopt_long(argc, argv, "a:c:b:d:e:E:Dhp:P:r:s:S:t::T:01234:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -619,6 +621,17 @@ static struct osnoise_hist_params
 		case '3': /* with zeros */
 			params->with_zeros = 1;
 			break;
+		case '4': /* trigger */
+			if (params->events) {
+				retval = trace_event_add_trigger(params->events, optarg);
+				if (retval) {
+					err_msg("Error adding trigger %s\n", optarg);
+					exit(EXIT_FAILURE);
+				}
+			} else {
+				osnoise_hist_usage("--trigger requires a previous -e\n");
+			}
+			break;
 		default:
 			osnoise_hist_usage("Invalid option");
 		}
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 218dc1114139..d16c7ce3e9fa 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -247,7 +247,7 @@ void osnoise_top_usage(char *usage)
 
 	static const char * const msg[] = {
 		"  usage: rtla osnoise [top] [-h] [-q] [-D] [-d s] [-a us] [-p us] [-r us] [-s us] [-S us] \\",
-		"	  [-T us] [-t[=file]] [-e sys[:event]] [-c cpu-list] [-P priority]",
+		"	  [-T us] [-t[=file]] [-e sys[:event]] [--trigger <trigger>] [-c cpu-list] [-P priority]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us sample is hit",
@@ -261,6 +261,7 @@ void osnoise_top_usage(char *usage)
 		"	  -D/--debug: print debug info",
 		"	  -t/--trace[=file]: save the stopped trace to [file|osnoise_trace.txt]",
 		"	  -e/--event <sys:event>: enable the <sys:event> in the trace instance, multiple -e are allowed",
+		"	     --trigger <trigger>: enable a trace event trigger to the previous -e event",
 		"	  -q/--quiet print only a summary at the end",
 		"	  -P/--priority o:prio|r:prio|f:prio|d:runtime:period : set scheduling parameters",
 		"		o:prio - use SCHED_OTHER with prio",
@@ -312,13 +313,14 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 			{"stop-total",		required_argument,	0, 'S'},
 			{"threshold",		required_argument,	0, 'T'},
 			{"trace",		optional_argument,	0, 't'},
+			{"trigger",		required_argument,	0, '0'},
 			{0, 0, 0, 0}
 		};
 
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:d:De:hp:P:qr:s:S:t::T:",
+		c = getopt_long(argc, argv, "a:c:d:De:hp:P:qr:s:S:t::T:0:",
 				 long_options, &option_index);
 
 		/* Detect the end of the options. */
@@ -402,6 +404,17 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 		case 'T':
 			params->threshold = get_llong_from_str(optarg);
 			break;
+		case '0': /* trigger */
+			if (params->events) {
+				retval = trace_event_add_trigger(params->events, optarg);
+				if (retval) {
+					err_msg("Error adding trigger %s\n", optarg);
+					exit(EXIT_FAILURE);
+				}
+			} else {
+				osnoise_top_usage("--trigger requires a previous -e\n");
+			}
+			break;
 		default:
 			osnoise_top_usage("Invalid option");
 		}
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 2bd668fd36f5..765b5a313bd2 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -430,8 +430,8 @@ static void timerlat_hist_usage(char *usage)
 	char *msg[] = {
 		"",
 		"  usage: [rtla] timerlat hist [-h] [-q] [-d s] [-D] [-n] [-a us] [-p us] [-i us] [-T us] [-s us] \\",
-		"         [-t[=file]] [-e sys[:event]] [-c cpu-list] [-P priority] [-E N] [-b N] [--no-irq] \\",
-		"         [--no-thread] [--no-header] [--no-summary] [--no-index] [--with-zeros]",
+		"         [-t[=file]] [-e sys[:event]] [--trigger <trigger>] [-c cpu-list] [-P priority] [-E N] \\",
+		"         [-b N] [--no-irq] [--no-thread] [--no-header] [--no-summary] [--no-index] [--with-zeros]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us latency is hit",
@@ -444,6 +444,7 @@ static void timerlat_hist_usage(char *usage)
 		"	  -D/--debug: print debug info",
 		"	  -t/--trace[=file]: save the stopped trace to [file|timerlat_trace.txt]",
 		"	  -e/--event <sys:event>: enable the <sys:event> in the trace instance, multiple -e are allowed",
+		"	     --trigger <trigger>: enable a trace event trigger to the previous -e event",
 		"	  -n/--nano: display data in nanoseconds",
 		"	  -b/--bucket-size N: set the histogram bucket size (default 1)",
 		"	  -E/--entries N: set the number of entries of the histogram (default 256)",
@@ -517,13 +518,14 @@ static struct timerlat_hist_params
 			{"no-summary",		no_argument,		0, '3'},
 			{"no-index",		no_argument,		0, '4'},
 			{"with-zeros",		no_argument,		0, '5'},
+			{"trigger",		required_argument,	0, '6'},
 			{0, 0, 0, 0}
 		};
 
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:b:d:e:E:Dhi:np:P:s:t::T:012345",
+		c = getopt_long(argc, argv, "a:c:b:d:e:E:Dhi:np:P:s:t::T:0123456:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -632,6 +634,17 @@ static struct timerlat_hist_params
 		case '5': /* with zeros */
 			params->with_zeros = 1;
 			break;
+		case '6': /* trigger */
+			if (params->events) {
+				retval = trace_event_add_trigger(params->events, optarg);
+				if (retval) {
+					err_msg("Error adding trigger %s\n", optarg);
+					exit(EXIT_FAILURE);
+				}
+			} else {
+				timerlat_hist_usage("--trigger requires a previous -e\n");
+			}
+			break;
 		default:
 			timerlat_hist_usage("Invalid option");
 		}
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 13bd922ab147..76927d4e0dac 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -268,7 +268,7 @@ static void timerlat_top_usage(char *usage)
 	static const char *const msg[] = {
 		"",
 		"  usage: rtla timerlat [top] [-h] [-q] [-a us] [-d s] [-D] [-n] [-p us] [-i us] [-T us] [-s us] \\",
-		"	  [[-t[=file]] [-e sys[:event]] [-c cpu-list] [-P priority]",
+		"	  [[-t[=file]] [-e sys[:event]] [--trigger <trigger>] [-c cpu-list] [-P priority]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us latency is hit",
@@ -281,6 +281,7 @@ static void timerlat_top_usage(char *usage)
 		"	  -D/--debug: print debug info",
 		"	  -t/--trace[=file]: save the stopped trace to [file|timerlat_trace.txt]",
 		"	  -e/--event <sys:event>: enable the <sys:event> in the trace instance, multiple -e are allowed",
+		"	     --trigger <command>: enable a trace event trigger to the previous -e event",
 		"	  -n/--nano: display data in nanoseconds",
 		"	  -q/--quiet print only a summary at the end",
 		"	  -P/--priority o:prio|r:prio|f:prio|d:runtime:period : set scheduling parameters",
@@ -338,13 +339,14 @@ static struct timerlat_top_params
 			{"stack",		required_argument,	0, 's'},
 			{"thread",		required_argument,	0, 'T'},
 			{"trace",		optional_argument,	0, 't'},
+			{"trigger",		required_argument,	0, '0'},
 			{0, 0, 0, 0}
 		};
 
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:d:De:hi:np:P:qs:t::T:",
+		c = getopt_long(argc, argv, "a:c:d:De:hi:np:P:qs:t::T:0:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -427,6 +429,17 @@ static struct timerlat_top_params
 			else
 				params->trace_output = "timerlat_trace.txt";
 			break;
+		case '0': /* trigger */
+			if (params->events) {
+				retval = trace_event_add_trigger(params->events, optarg);
+				if (retval) {
+					err_msg("Error adding trigger %s\n", optarg);
+					exit(EXIT_FAILURE);
+				}
+			} else {
+				timerlat_top_usage("--trigger requires a previous -e\n");
+			}
+			break;
 		default:
 			timerlat_top_usage("Invalid option");
 		}
-- 
2.34.1

