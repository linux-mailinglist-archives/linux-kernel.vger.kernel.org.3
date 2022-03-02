Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45064CAE1A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:03:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244834AbiCBTDs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Mar 2022 14:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244840AbiCBTDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:03:44 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53839483AC
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:02:50 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-450-tWKVklkJNhePi9en3w9t9g-1; Wed, 02 Mar 2022 14:02:46 -0500
X-MC-Unique: tWKVklkJNhePi9en3w9t9g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D488C801AFE;
        Wed,  2 Mar 2022 19:02:44 +0000 (UTC)
Received: from x1.com (unknown [10.22.32.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7CE0019C59;
        Wed,  2 Mar 2022 19:02:31 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH V3 06/15] rtla: Add -e/--event support
Date:   Wed,  2 Mar 2022 20:01:31 +0100
Message-Id: <6a3b753be9b1e811953995f7f21a86918ad13390.1646247211.git.bristot@kernel.org>
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
        SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add -e/--event option. This option enables an event in the trace (-t)
session. The argument can be a specific event, e.g., -e sched:sched_switch,
or all events of a system group, e.g., -e sched. Multiple -e are allowed.
It is only active when -t or -a are set.

This option is available for all current tools.

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 Documentation/tools/rtla/common_options.rst |  4 +++
 tools/tracing/rtla/src/osnoise_hist.c       | 31 +++++++++++++++++--
 tools/tracing/rtla/src/osnoise_top.c        | 29 ++++++++++++++++--
 tools/tracing/rtla/src/timerlat_hist.c      | 33 ++++++++++++++++++---
 tools/tracing/rtla/src/timerlat_top.c       | 28 +++++++++++++++--
 5 files changed, 114 insertions(+), 11 deletions(-)

diff --git a/Documentation/tools/rtla/common_options.rst b/Documentation/tools/rtla/common_options.rst
index 721790ad984e..89d783dc3304 100644
--- a/Documentation/tools/rtla/common_options.rst
+++ b/Documentation/tools/rtla/common_options.rst
@@ -14,6 +14,10 @@
 
         Save the stopped trace to [*file|osnoise_trace.txt*].
 
+**-e**, **--event** *sys:event*
+
+        Enable an event in the trace (**-t**) session. The argument can be a specific event, e.g., **-e** *sched:sched_switch*, or all events of a system group, e.g., **-e** *sched*. Multiple **-e** are allowed. It is only active when **-t** or **-a** are set.
+
 **-P**, **--priority** *o:prio|r:prio|f:prio|d:runtime:period*
 
         Set scheduling parameters to the osnoise tracer threads, the format to set the priority are:
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 5698da2fe3dd..10d683a98087 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -29,6 +29,7 @@ struct osnoise_hist_params {
 	int			set_sched;
 	int			output_divisor;
 	struct sched_attr	sched_param;
+	struct trace_events	*events;
 
 	char			no_header;
 	char			no_summary;
@@ -427,8 +428,8 @@ static void osnoise_hist_usage(char *usage)
 	static const char * const msg[] = {
 		"",
 		"  usage: rtla osnoise hist [-h] [-D] [-d s] [-a us] [-p us] [-r us] [-s us] [-S us] \\",
-		"	  [-T us] [-t[=file]] [-c cpu-list] [-P priority] [-b N] [-E N] [--no-header] \\",
-		"	  [--no-summary] [--no-index] [--with-zeros]",
+		"	  [-T us] [-t[=file]] [-e sys[:event]] [-c cpu-list] [-P priority] [-b N] [-E N] \\",
+		"	  [--no-header] [--no-summary] [--no-index] [--with-zeros]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us sample is hit",
@@ -441,6 +442,7 @@ static void osnoise_hist_usage(char *usage)
 		"	  -d/--duration time[s|m|h|d]: duration of the session",
 		"	  -D/--debug: print debug info",
 		"	  -t/--trace[=file]: save the stopped trace to [file|osnoise_trace.txt]",
+		"	  -e/--event <sys:event>: enable the <sys:event> in the trace instance, multiple -e are allowed",
 		"	  -b/--bucket-size N: set the histogram bucket size (default 1)",
 		"	  -E/--entries N: set the number of entries of the histogram (default 256)",
 		"	     --no-header: do not print header",
@@ -474,6 +476,7 @@ static struct osnoise_hist_params
 *osnoise_hist_parse_args(int argc, char *argv[])
 {
 	struct osnoise_hist_params *params;
+	struct trace_events *tevent;
 	int retval;
 	int c;
 
@@ -501,6 +504,7 @@ static struct osnoise_hist_params
 			{"stop",		required_argument,	0, 's'},
 			{"stop-total",		required_argument,	0, 'S'},
 			{"trace",		optional_argument,	0, 't'},
+			{"event",		required_argument,	0, 'e'},
 			{"threshold",		required_argument,	0, 'T'},
 			{"no-header",		no_argument,		0, '0'},
 			{"no-summary",		no_argument,		0, '1'},
@@ -512,7 +516,7 @@ static struct osnoise_hist_params
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:b:d:E:Dhp:P:r:s:S:t::T:0123",
+		c = getopt_long(argc, argv, "a:c:b:d:e:E:Dhp:P:r:s:S:t::T:0123",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -550,6 +554,18 @@ static struct osnoise_hist_params
 			if (!params->duration)
 				osnoise_hist_usage("Invalid -D duration\n");
 			break;
+		case 'e':
+			tevent = trace_event_alloc(optarg);
+			if (!tevent) {
+				err_msg("Error alloc trace event");
+				exit(EXIT_FAILURE);
+			}
+
+			if (params->events)
+				tevent->next = params->events;
+
+			params->events = tevent;
+			break;
 		case 'E':
 			params->entries = get_llong_from_str(optarg);
 			if ((params->entries < 10) || (params->entries > 9999999))
@@ -778,6 +794,13 @@ int osnoise_hist_main(int argc, char *argv[])
 			err_msg("Failed to enable the trace instance\n");
 			goto out_hist;
 		}
+
+		if (params->events) {
+			retval = trace_events_enable(&record->trace, params->events);
+			if (retval)
+				goto out_hist;
+		}
+
 		trace_instance_start(&record->trace);
 	}
 
@@ -817,6 +840,8 @@ int osnoise_hist_main(int argc, char *argv[])
 	}
 
 out_hist:
+	trace_events_destroy(&record->trace, params->events);
+	params->events = NULL;
 	osnoise_free_histogram(tool->data);
 out_destroy:
 	osnoise_destroy_tool(record);
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index a6f434f85738..218dc1114139 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -31,6 +31,7 @@ struct osnoise_top_params {
 	int			quiet;
 	int			set_sched;
 	struct sched_attr	sched_param;
+	struct trace_events	*events;
 };
 
 struct osnoise_top_cpu {
@@ -246,7 +247,7 @@ void osnoise_top_usage(char *usage)
 
 	static const char * const msg[] = {
 		"  usage: rtla osnoise [top] [-h] [-q] [-D] [-d s] [-a us] [-p us] [-r us] [-s us] [-S us] \\",
-		"	  [-T us] [-t[=file]] [-c cpu-list] [-P priority]",
+		"	  [-T us] [-t[=file]] [-e sys[:event]] [-c cpu-list] [-P priority]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us sample is hit",
@@ -259,6 +260,7 @@ void osnoise_top_usage(char *usage)
 		"	  -d/--duration time[s|m|h|d]: duration of the session",
 		"	  -D/--debug: print debug info",
 		"	  -t/--trace[=file]: save the stopped trace to [file|osnoise_trace.txt]",
+		"	  -e/--event <sys:event>: enable the <sys:event> in the trace instance, multiple -e are allowed",
 		"	  -q/--quiet print only a summary at the end",
 		"	  -P/--priority o:prio|r:prio|f:prio|d:runtime:period : set scheduling parameters",
 		"		o:prio - use SCHED_OTHER with prio",
@@ -286,6 +288,7 @@ void osnoise_top_usage(char *usage)
 struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 {
 	struct osnoise_top_params *params;
+	struct trace_events *tevent;
 	int retval;
 	int c;
 
@@ -299,6 +302,7 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 			{"cpus",		required_argument,	0, 'c'},
 			{"debug",		no_argument,		0, 'D'},
 			{"duration",		required_argument,	0, 'd'},
+			{"event",		required_argument,	0, 'e'},
 			{"help",		no_argument,		0, 'h'},
 			{"period",		required_argument,	0, 'p'},
 			{"priority",		required_argument,	0, 'P'},
@@ -314,7 +318,7 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:d:Dhp:P:qr:s:S:t::T:",
+		c = getopt_long(argc, argv, "a:c:d:De:hp:P:qr:s:S:t::T:",
 				 long_options, &option_index);
 
 		/* Detect the end of the options. */
@@ -347,6 +351,18 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 			if (!params->duration)
 				osnoise_top_usage("Invalid -D duration\n");
 			break;
+		case 'e':
+			tevent = trace_event_alloc(optarg);
+			if (!tevent) {
+				err_msg("Error alloc trace event");
+				exit(EXIT_FAILURE);
+			}
+
+			if (params->events)
+				tevent->next = params->events;
+			params->events = tevent;
+
+			break;
 		case 'h':
 		case '?':
 			osnoise_top_usage(NULL);
@@ -556,6 +572,13 @@ int osnoise_top_main(int argc, char **argv)
 			err_msg("Failed to enable the trace instance\n");
 			goto out_top;
 		}
+
+		if (params->events) {
+			retval = trace_events_enable(&record->trace, params->events);
+			if (retval)
+				goto out_top;
+		}
+
 		trace_instance_start(&record->trace);
 	}
 
@@ -597,6 +620,8 @@ int osnoise_top_main(int argc, char **argv)
 	}
 
 out_top:
+	trace_events_destroy(&record->trace, params->events);
+	params->events = NULL;
 	osnoise_free_top(tool->data);
 	osnoise_destroy_tool(record);
 	osnoise_destroy_tool(tool);
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 9cd97095b04a..2bd668fd36f5 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -29,6 +29,7 @@ struct timerlat_hist_params {
 	int			duration;
 	int			set_sched;
 	struct sched_attr	sched_param;
+	struct trace_events	*events;
 
 	char			no_irq;
 	char			no_thread;
@@ -429,8 +430,8 @@ static void timerlat_hist_usage(char *usage)
 	char *msg[] = {
 		"",
 		"  usage: [rtla] timerlat hist [-h] [-q] [-d s] [-D] [-n] [-a us] [-p us] [-i us] [-T us] [-s us] \\",
-		"         [-t[=file]] [-c cpu-list] [-P priority] [-E N] [-b N]  [--no-irq] [--no-thread] [--no-header] \\",
-		"         [--no-summary] [--no-index] [--with-zeros]",
+		"         [-t[=file]] [-e sys[:event]] [-c cpu-list] [-P priority] [-E N] [-b N] [--no-irq] \\",
+		"         [--no-thread] [--no-header] [--no-summary] [--no-index] [--with-zeros]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us latency is hit",
@@ -441,7 +442,8 @@ static void timerlat_hist_usage(char *usage)
 		"	  -c/--cpus cpus: run the tracer only on the given cpus",
 		"	  -d/--duration time[m|h|d]: duration of the session in seconds",
 		"	  -D/--debug: print debug info",
-		"	  -T/--trace[=file]: save the stopped trace to [file|timerlat_trace.txt]",
+		"	  -t/--trace[=file]: save the stopped trace to [file|timerlat_trace.txt]",
+		"	  -e/--event <sys:event>: enable the <sys:event> in the trace instance, multiple -e are allowed",
 		"	  -n/--nano: display data in nanoseconds",
 		"	  -b/--bucket-size N: set the histogram bucket size (default 1)",
 		"	  -E/--entries N: set the number of entries of the histogram (default 256)",
@@ -478,6 +480,7 @@ static struct timerlat_hist_params
 *timerlat_hist_parse_args(int argc, char *argv[])
 {
 	struct timerlat_hist_params *params;
+	struct trace_events *tevent;
 	int auto_thresh;
 	int retval;
 	int c;
@@ -507,6 +510,7 @@ static struct timerlat_hist_params
 			{"stack",		required_argument,	0, 's'},
 			{"thread",		required_argument,	0, 'T'},
 			{"trace",		optional_argument,	0, 't'},
+			{"event",		required_argument,	0, 'e'},
 			{"no-irq",		no_argument,		0, '0'},
 			{"no-thread",		no_argument,		0, '1'},
 			{"no-header",		no_argument,		0, '2'},
@@ -519,7 +523,7 @@ static struct timerlat_hist_params
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:b:d:E:Dhi:np:P:s:t::T:012345",
+		c = getopt_long(argc, argv, "a:c:b:d:e:E:Dhi:np:P:s:t::T:012345",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -559,6 +563,18 @@ static struct timerlat_hist_params
 			if (!params->duration)
 				timerlat_hist_usage("Invalid -D duration\n");
 			break;
+		case 'e':
+			tevent = trace_event_alloc(optarg);
+			if (!tevent) {
+				err_msg("Error alloc trace event");
+				exit(EXIT_FAILURE);
+			}
+
+			if (params->events)
+				tevent->next = params->events;
+
+			params->events = tevent;
+			break;
 		case 'E':
 			params->entries = get_llong_from_str(optarg);
 			if ((params->entries < 10) || (params->entries > 9999999))
@@ -791,6 +807,13 @@ int timerlat_hist_main(int argc, char *argv[])
 			err_msg("Failed to enable the trace instance\n");
 			goto out_hist;
 		}
+
+		if (params->events) {
+			retval = trace_events_enable(&record->trace, params->events);
+			if (retval)
+				goto out_hist;
+		}
+
 		trace_instance_start(&record->trace);
 	}
 
@@ -828,6 +851,8 @@ int timerlat_hist_main(int argc, char *argv[])
 	}
 
 out_hist:
+	trace_events_destroy(&record->trace, params->events);
+	params->events = NULL;
 	timerlat_free_histogram(tool->data);
 	osnoise_destroy_tool(record);
 	osnoise_destroy_tool(tool);
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index aef044832964..13bd922ab147 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -30,6 +30,7 @@ struct timerlat_top_params {
 	int			quiet;
 	int			set_sched;
 	struct sched_attr	sched_param;
+	struct trace_events	*events;
 };
 
 struct timerlat_top_cpu {
@@ -267,7 +268,7 @@ static void timerlat_top_usage(char *usage)
 	static const char *const msg[] = {
 		"",
 		"  usage: rtla timerlat [top] [-h] [-q] [-a us] [-d s] [-D] [-n] [-p us] [-i us] [-T us] [-s us] \\",
-		"	  [[-t[=file]] -c cpu-list] [-P priority]",
+		"	  [[-t[=file]] [-e sys[:event]] [-c cpu-list] [-P priority]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us latency is hit",
@@ -279,6 +280,7 @@ static void timerlat_top_usage(char *usage)
 		"	  -d/--duration time[m|h|d]: duration of the session in seconds",
 		"	  -D/--debug: print debug info",
 		"	  -t/--trace[=file]: save the stopped trace to [file|timerlat_trace.txt]",
+		"	  -e/--event <sys:event>: enable the <sys:event> in the trace instance, multiple -e are allowed",
 		"	  -n/--nano: display data in nanoseconds",
 		"	  -q/--quiet print only a summary at the end",
 		"	  -P/--priority o:prio|r:prio|f:prio|d:runtime:period : set scheduling parameters",
@@ -308,6 +310,7 @@ static struct timerlat_top_params
 *timerlat_top_parse_args(int argc, char **argv)
 {
 	struct timerlat_top_params *params;
+	struct trace_events *tevent;
 	long long auto_thresh;
 	int retval;
 	int c;
@@ -325,6 +328,7 @@ static struct timerlat_top_params
 			{"cpus",		required_argument,	0, 'c'},
 			{"debug",		no_argument,		0, 'D'},
 			{"duration",		required_argument,	0, 'd'},
+			{"event",		required_argument,	0, 'e'},
 			{"help",		no_argument,		0, 'h'},
 			{"irq",			required_argument,	0, 'i'},
 			{"nano",		no_argument,		0, 'n'},
@@ -340,7 +344,7 @@ static struct timerlat_top_params
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:d:Dhi:np:P:qs:t::T:",
+		c = getopt_long(argc, argv, "a:c:d:De:hi:np:P:qs:t::T:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -375,6 +379,17 @@ static struct timerlat_top_params
 			if (!params->duration)
 				timerlat_top_usage("Invalid -D duration\n");
 			break;
+		case 'e':
+			tevent = trace_event_alloc(optarg);
+			if (!tevent) {
+				err_msg("Error alloc trace event");
+				exit(EXIT_FAILURE);
+			}
+
+			if (params->events)
+				tevent->next = params->events;
+			params->events = tevent;
+			break;
 		case 'h':
 		case '?':
 			timerlat_top_usage(NULL);
@@ -583,6 +598,13 @@ int timerlat_top_main(int argc, char *argv[])
 			err_msg("Failed to enable the trace instance\n");
 			goto out_top;
 		}
+
+		if (params->events) {
+			retval = trace_events_enable(&record->trace, params->events);
+			if (retval)
+				goto out_top;
+		}
+
 		trace_instance_start(&record->trace);
 	}
 
@@ -624,6 +646,8 @@ int timerlat_top_main(int argc, char *argv[])
 	}
 
 out_top:
+	trace_events_destroy(&record->trace, params->events);
+	params->events = NULL;
 	timerlat_free_top(top->data);
 	osnoise_destroy_tool(record);
 	osnoise_destroy_tool(top);
-- 
2.34.1

