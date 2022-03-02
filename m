Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C83B4CAE2E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:04:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244900AbiCBTFY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Mar 2022 14:05:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244869AbiCBTFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:05:19 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B64EBB12CB
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:04:33 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-103-RxvgnynMN5ePsk1nYiuWXA-1; Wed, 02 Mar 2022 14:04:29 -0500
X-MC-Unique: RxvgnynMN5ePsk1nYiuWXA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 38A941091DA0;
        Wed,  2 Mar 2022 19:04:27 +0000 (UTC)
Received: from x1.com (unknown [10.22.32.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 18EC919C59;
        Wed,  2 Mar 2022 19:04:24 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH V3 14/15] rtla/timerlat: Add --dma-latency option
Date:   Wed,  2 Mar 2022 20:01:39 +0100
Message-Id: <72ddb0d913459f13217086dadafad88a7c46dd28.1646247211.git.bristot@kernel.org>
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

Add the --dma-latency to set /dev/cpu_dma_latency to the
specified value, this aims to avoid having exit from idle
states latencies that could be influencing the analysis.

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 .../tools/rtla/common_timerlat_options.rst    |  5 +++
 tools/tracing/rtla/src/timerlat_hist.c        | 28 ++++++++++++++--
 tools/tracing/rtla/src/timerlat_top.c         | 28 ++++++++++++++--
 tools/tracing/rtla/src/utils.c                | 33 +++++++++++++++++++
 tools/tracing/rtla/src/utils.h                |  1 +
 5 files changed, 91 insertions(+), 4 deletions(-)

diff --git a/Documentation/tools/rtla/common_timerlat_options.rst b/Documentation/tools/rtla/common_timerlat_options.rst
index 14a24a121f5d..bacdea6de7a3 100644
--- a/Documentation/tools/rtla/common_timerlat_options.rst
+++ b/Documentation/tools/rtla/common_timerlat_options.rst
@@ -21,3 +21,8 @@
 
         Save the stack trace at the *IRQ* if a *Thread* latency is higher than the
         argument in us.
+
+**--dma-latency** *us*
+        Set the /dev/cpu_dma_latency to *us*, aiming to bound exit from idle latencies.
+        *cyclictest* sets this value to *0* by default, use **--dma-latency** *0* to have
+        similar results.
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 17188ccb6e8b..0f6ce80a198a 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -28,6 +28,7 @@ struct timerlat_hist_params {
 	int			output_divisor;
 	int			duration;
 	int			set_sched;
+	int			dma_latency;
 	struct sched_attr	sched_param;
 	struct trace_events	*events;
 
@@ -432,7 +433,7 @@ static void timerlat_hist_usage(char *usage)
 		"  usage: [rtla] timerlat hist [-h] [-q] [-d s] [-D] [-n] [-a us] [-p us] [-i us] [-T us] [-s us] \\",
 		"         [-t[=file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] [-c cpu-list] \\",
 		"	  [-P priority] [-E N] [-b N] [--no-irq] [--no-thread] [--no-header] [--no-summary] \\",
-		"	  [--no-index] [--with-zeros]",
+		"	  [--no-index] [--with-zeros] [--dma-latency us]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us latency is hit",
@@ -456,6 +457,7 @@ static void timerlat_hist_usage(char *usage)
 		"	     --no-summary: do not print summary",
 		"	     --no-index: do not print index",
 		"	     --with-zeros: print zero only entries",
+		"	     --dma-latency us: set /dev/cpu_dma_latency latency <us> to reduce exit from idle latency",
 		"	  -P/--priority o:prio|r:prio|f:prio|d:runtime:period : set scheduling parameters",
 		"		o:prio - use SCHED_OTHER with prio",
 		"		r:prio - use SCHED_RR with prio",
@@ -492,6 +494,9 @@ static struct timerlat_hist_params
 	if (!params)
 		exit(1);
 
+	/* disabled by default */
+	params->dma_latency = -1;
+
 	/* display data in microseconds */
 	params->output_divisor = 1000;
 	params->bucket_size = 1;
@@ -522,13 +527,14 @@ static struct timerlat_hist_params
 			{"with-zeros",		no_argument,		0, '5'},
 			{"trigger",		required_argument,	0, '6'},
 			{"filter",		required_argument,	0, '7'},
+			{"dma-latency",		required_argument,	0, '8'},
 			{0, 0, 0, 0}
 		};
 
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:b:d:e:E:Dhi:np:P:s:t::T:0123456:7:",
+		c = getopt_long(argc, argv, "a:c:b:d:e:E:Dhi:np:P:s:t::T:0123456:7:8:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -659,6 +665,13 @@ static struct timerlat_hist_params
 				timerlat_hist_usage("--filter requires a previous -e\n");
 			}
 			break;
+		case '8':
+			params->dma_latency = get_llong_from_str(optarg);
+			if (params->dma_latency < 0 || params->dma_latency > 10000) {
+				err_msg("--dma-latency needs to be >= 0 and < 10000");
+				exit(EXIT_FAILURE);
+			}
+			break;
 		default:
 			timerlat_hist_usage("Invalid option");
 		}
@@ -791,6 +804,7 @@ int timerlat_hist_main(int argc, char *argv[])
 	struct osnoise_tool *record = NULL;
 	struct osnoise_tool *tool = NULL;
 	struct trace_instance *trace;
+	int dma_latency_fd = -1;
 	int return_value = 1;
 	int retval;
 
@@ -826,6 +840,14 @@ int timerlat_hist_main(int argc, char *argv[])
 		}
 	}
 
+	if (params->dma_latency >= 0) {
+		dma_latency_fd = set_cpu_dma_latency(params->dma_latency);
+		if (dma_latency_fd < 0) {
+			err_msg("Could not set /dev/cpu_dma_latency.\n");
+			goto out_hist;
+		}
+	}
+
 	trace_instance_start(trace);
 
 	if (params->trace_output) {
@@ -878,6 +900,8 @@ int timerlat_hist_main(int argc, char *argv[])
 	}
 
 out_hist:
+	if (dma_latency_fd >= 0)
+		close(dma_latency_fd);
 	trace_events_destroy(&record->trace, params->events);
 	params->events = NULL;
 	timerlat_free_histogram(tool->data);
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index bf2a50350e61..53f4cdfd395e 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -29,6 +29,7 @@ struct timerlat_top_params {
 	int			duration;
 	int			quiet;
 	int			set_sched;
+	int			dma_latency;
 	struct sched_attr	sched_param;
 	struct trace_events	*events;
 };
@@ -269,7 +270,7 @@ static void timerlat_top_usage(char *usage)
 		"",
 		"  usage: rtla timerlat [top] [-h] [-q] [-a us] [-d s] [-D] [-n] [-p us] [-i us] [-T us] [-s us] \\",
 		"	  [[-t[=file]] [-e sys[:event]] [--filter <filter>] [--trigger <trigger>] [-c cpu-list] \\",
-		"	  [-P priority]",
+		"	  [-P priority] [--dma-latency us]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -a/--auto: set automatic trace mode, stopping the session if argument in us latency is hit",
@@ -286,6 +287,7 @@ static void timerlat_top_usage(char *usage)
 		"	     --trigger <command>: enable a trace event trigger to the previous -e event",
 		"	  -n/--nano: display data in nanoseconds",
 		"	  -q/--quiet print only a summary at the end",
+		"	     --dma-latency us: set /dev/cpu_dma_latency latency <us> to reduce exit from idle latency",
 		"	  -P/--priority o:prio|r:prio|f:prio|d:runtime:period : set scheduling parameters",
 		"		o:prio - use SCHED_OTHER with prio",
 		"		r:prio - use SCHED_RR with prio",
@@ -322,6 +324,9 @@ static struct timerlat_top_params
 	if (!params)
 		exit(1);
 
+	/* disabled by default */
+	params->dma_latency = -1;
+
 	/* display data in microseconds */
 	params->output_divisor = 1000;
 
@@ -343,13 +348,14 @@ static struct timerlat_top_params
 			{"trace",		optional_argument,	0, 't'},
 			{"trigger",		required_argument,	0, '0'},
 			{"filter",		required_argument,	0, '1'},
+			{"dma-latency",		required_argument,	0, '2'},
 			{0, 0, 0, 0}
 		};
 
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:d:De:hi:np:P:qs:t::T:0:1:",
+		c = getopt_long(argc, argv, "a:c:d:De:hi:np:P:qs:t::T:0:1:2:",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -454,6 +460,13 @@ static struct timerlat_top_params
 				timerlat_top_usage("--filter requires a previous -e\n");
 			}
 			break;
+		case '2': /* dma-latency */
+			params->dma_latency = get_llong_from_str(optarg);
+			if (params->dma_latency < 0 || params->dma_latency > 10000) {
+				err_msg("--dma-latency needs to be >= 0 and < 10000");
+				exit(EXIT_FAILURE);
+			}
+			break;
 		default:
 			timerlat_top_usage("Invalid option");
 		}
@@ -582,6 +595,7 @@ int timerlat_top_main(int argc, char *argv[])
 	struct osnoise_tool *record = NULL;
 	struct osnoise_tool *top = NULL;
 	struct trace_instance *trace;
+	int dma_latency_fd = -1;
 	int return_value = 1;
 	int retval;
 
@@ -617,6 +631,14 @@ int timerlat_top_main(int argc, char *argv[])
 		}
 	}
 
+	if (params->dma_latency >= 0) {
+		dma_latency_fd = set_cpu_dma_latency(params->dma_latency);
+		if (dma_latency_fd < 0) {
+			err_msg("Could not set /dev/cpu_dma_latency.\n");
+			goto out_top;
+		}
+	}
+
 	trace_instance_start(trace);
 
 	if (params->trace_output) {
@@ -673,6 +695,8 @@ int timerlat_top_main(int argc, char *argv[])
 	}
 
 out_top:
+	if (dma_latency_fd >= 0)
+		close(dma_latency_fd);
 	trace_events_destroy(&record->trace, params->events);
 	params->events = NULL;
 	timerlat_free_top(top->data);
diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index ffaf8ec84001..da2b590edaed 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -10,6 +10,7 @@
 #include <unistd.h>
 #include <ctype.h>
 #include <errno.h>
+#include <fcntl.h>
 #include <sched.h>
 #include <stdio.h>
 
@@ -431,3 +432,35 @@ int parse_prio(char *arg, struct sched_attr *sched_param)
 	}
 	return 0;
 }
+
+/*
+ * set_cpu_dma_latency - set the /dev/cpu_dma_latecy
+ *
+ * This is used to reduce the exit from idle latency. The value
+ * will be reset once the file descriptor of /dev/cpu_dma_latecy
+ * is closed.
+ *
+ * Return: the /dev/cpu_dma_latecy file descriptor
+ */
+int set_cpu_dma_latency(int32_t latency)
+{
+	int retval;
+	int fd;
+
+	fd = open("/dev/cpu_dma_latency", O_RDWR);
+	if (fd < 0) {
+		err_msg("Error opening /dev/cpu_dma_latency\n");
+		return -1;
+	}
+
+	retval = write(fd, &latency, 4);
+	if (retval < 1) {
+		err_msg("Error setting /dev/cpu_dma_latency\n");
+		close(fd);
+		return -1;
+	}
+
+	debug_msg("Set /dev/cpu_dma_latency to %d\n", latency);
+
+	return fd;
+}
diff --git a/tools/tracing/rtla/src/utils.h b/tools/tracing/rtla/src/utils.h
index 9aa962319ca2..fa08e374870a 100644
--- a/tools/tracing/rtla/src/utils.h
+++ b/tools/tracing/rtla/src/utils.h
@@ -54,3 +54,4 @@ struct sched_attr {
 
 int parse_prio(char *arg, struct sched_attr *sched_param);
 int set_comm_sched_attr(const char *comm, struct sched_attr *attr);
+int set_cpu_dma_latency(int32_t latency);
-- 
2.34.1

