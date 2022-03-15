Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80464DA2E5
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 20:03:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351255AbiCOTEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 15:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351232AbiCOTEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 15:04:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E5525A16A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 12:02:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 78EC3B81883
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 19:02:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20BA1C340F7;
        Tue, 15 Mar 2022 19:02:44 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nUCRP-003jga-58;
        Tue, 15 Mar 2022 15:02:43 -0400
Message-ID: <20220315190242.994222859@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 15 Mar 2022 15:02:16 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: [for-next][PATCH 02/15] rtla/osnoise: Add an option to set the threshold
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

Add the -T/--threshold option to set the minimum threshold to be
considered a noise to osnoise top and hist commands. Also update
the man pages.

Link: https://lkml.kernel.org/r/031861200ffdb24a1df4aa72c458706889a20d5d.1646247211.git.bristot@kernel.org

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Clark Williams <williams@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../tools/rtla/common_osnoise_options.rst     |  5 +++++
 tools/tracing/rtla/src/osnoise_hist.c         | 22 +++++++++++++++----
 tools/tracing/rtla/src/osnoise_top.c          | 20 ++++++++++++++---
 3 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/Documentation/tools/rtla/common_osnoise_options.rst b/Documentation/tools/rtla/common_osnoise_options.rst
index d556883e4e26..27f1493f7bc0 100644
--- a/Documentation/tools/rtla/common_osnoise_options.rst
+++ b/Documentation/tools/rtla/common_osnoise_options.rst
@@ -15,3 +15,8 @@
 
         Stop the trace if the total sample is higher than the argument in microseconds.
         If **-T** is set, it will also save the trace to the output.
+
+**-T**, **--threshold** *us*
+
+        Specify the minimum delta between two time reads to be considered noise.
+        The default threshold is *5 us*.
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 52c053cc1789..ab02219de528 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -21,6 +21,7 @@ struct osnoise_hist_params {
 	char			*trace_output;
 	unsigned long long	runtime;
 	unsigned long long	period;
+	long long		threshold;
 	long long		stop_us;
 	long long		stop_total_us;
 	int			sleep_time;
@@ -425,15 +426,16 @@ static void osnoise_hist_usage(char *usage)
 
 	static const char * const msg[] = {
 		"",
-		"  usage: rtla osnoise hist [-h] [-D] [-d s] [-p us] [-r us] [-s us] [-S us] [-t[=file]] \\",
-		"	  [-c cpu-list] [-P priority] [-b N] [-E N] [--no-header] [--no-summary] \\",
-		"	  [--no-index] [--with-zeros]",
+		"  usage: rtla osnoise hist [-h] [-D] [-d s] [-p us] [-r us] [-s us] [-S us] [-T us] \\",
+		"	  [-t[=file]] [-c cpu-list] [-P priority] [-b N] [-E N] [--no-header] \\",
+		"	  [--no-summary] [--no-index] [--with-zeros]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -p/--period us: osnoise period in us",
 		"	  -r/--runtime us: osnoise runtime in us",
 		"	  -s/--stop us: stop trace if a single sample is higher than the argument in us",
 		"	  -S/--stop-total us: stop trace if the total sample is higher than the argument in us",
+		"	  -T/--threshold us: the minimum delta to be considered a noise",
 		"	  -c/--cpus cpu-list: list of cpus to run osnoise threads",
 		"	  -d/--duration time[s|m|h|d]: duration of the session",
 		"	  -D/--debug: print debug info",
@@ -497,6 +499,7 @@ static struct osnoise_hist_params
 			{"stop",		required_argument,	0, 's'},
 			{"stop-total",		required_argument,	0, 'S'},
 			{"trace",		optional_argument,	0, 't'},
+			{"threshold",		required_argument,	0, 'T'},
 			{"no-header",		no_argument,		0, '0'},
 			{"no-summary",		no_argument,		0, '1'},
 			{"no-index",		no_argument,		0, '2'},
@@ -507,7 +510,7 @@ static struct osnoise_hist_params
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "c:b:d:E:Dhp:P:r:s:S:t::0123",
+		c = getopt_long(argc, argv, "c:b:d:E:Dhp:P:r:s:S:t::T:0123",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -565,6 +568,9 @@ static struct osnoise_hist_params
 		case 'S':
 			params->stop_total_us = get_llong_from_str(optarg);
 			break;
+		case 'T':
+			params->threshold = get_llong_from_str(optarg);
+			break;
 		case 't':
 			if (optarg)
 				/* skip = */
@@ -645,6 +651,14 @@ osnoise_hist_apply_config(struct osnoise_tool *tool, struct osnoise_hist_params
 		}
 	}
 
+	if (params->threshold) {
+		retval = osnoise_set_tracing_thresh(tool->context, params->threshold);
+		if (retval) {
+			err_msg("Failed to set tracing_thresh\n");
+			goto out_err;
+		}
+	}
+
 	return 0;
 
 out_err:
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 7af769b9c0de..07fb1b8314d3 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -23,6 +23,7 @@ struct osnoise_top_params {
 	char			*trace_output;
 	unsigned long long	runtime;
 	unsigned long long	period;
+	long long		threshold;
 	long long		stop_us;
 	long long		stop_total_us;
 	int			sleep_time;
@@ -244,14 +245,15 @@ void osnoise_top_usage(char *usage)
 	int i;
 
 	static const char * const msg[] = {
-		"  usage: rtla osnoise [top] [-h] [-q] [-D] [-d s] [-p us] [-r us] [-s us] [-S us] [-t[=file]] \\",
-		"	  [-c cpu-list] [-P priority]",
+		"  usage: rtla osnoise [top] [-h] [-q] [-D] [-d s] [-p us] [-r us] [-s us] [-S us] [-T us] \\",
+		"	  [-t[=file]] [-c cpu-list] [-P priority]",
 		"",
 		"	  -h/--help: print this menu",
 		"	  -p/--period us: osnoise period in us",
 		"	  -r/--runtime us: osnoise runtime in us",
 		"	  -s/--stop us: stop trace if a single sample is higher than the argument in us",
 		"	  -S/--stop-total us: stop trace if the total sample is higher than the argument in us",
+		"	  -T/--threshold us: the minimum delta to be considered a noise",
 		"	  -c/--cpus cpu-list: list of cpus to run osnoise threads",
 		"	  -d/--duration time[s|m|h|d]: duration of the session",
 		"	  -D/--debug: print debug info",
@@ -302,6 +304,7 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 			{"runtime",		required_argument,	0, 'r'},
 			{"stop",		required_argument,	0, 's'},
 			{"stop-total",		required_argument,	0, 'S'},
+			{"threshold",		required_argument,	0, 'T'},
 			{"trace",		optional_argument,	0, 't'},
 			{0, 0, 0, 0}
 		};
@@ -309,7 +312,7 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "c:d:Dhp:P:qr:s:S:t::",
+		c = getopt_long(argc, argv, "c:d:Dhp:P:qr:s:S:t::T:",
 				 long_options, &option_index);
 
 		/* Detect the end of the options. */
@@ -367,6 +370,9 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 			else
 				params->trace_output = "osnoise_trace.txt";
 			break;
+		case 'T':
+			params->threshold = get_llong_from_str(optarg);
+			break;
 		default:
 			osnoise_top_usage("Invalid option");
 		}
@@ -425,6 +431,14 @@ osnoise_top_apply_config(struct osnoise_tool *tool, struct osnoise_top_params *p
 		}
 	}
 
+	if (params->threshold) {
+		retval = osnoise_set_tracing_thresh(tool->context, params->threshold);
+		if (retval) {
+			err_msg("Failed to set tracing_thresh\n");
+			goto out_err;
+		}
+	}
+
 	return 0;
 
 out_err:
-- 
2.35.1
