Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C9A14BB7C3
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 12:10:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234447AbiBRLKA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Feb 2022 06:10:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234388AbiBRLJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:09:56 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 31F0C2AEDA2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 03:09:40 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-495-gxrR3mq-M1GIme7GRRwvIg-1; Fri, 18 Feb 2022 06:09:34 -0500
X-MC-Unique: gxrR3mq-M1GIme7GRRwvIg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 95315814245;
        Fri, 18 Feb 2022 11:09:32 +0000 (UTC)
Received: from x1.com (unknown [10.22.32.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F202C2B4B5;
        Fri, 18 Feb 2022 11:09:30 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-trace-devel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/7] rtla/osnoise: Add an option to set the threshold
Date:   Fri, 18 Feb 2022 12:09:14 +0100
Message-Id: <c86c6181bb7ca689e962b9c75c24b9c0f311aaad.1645182327.git.bristot@kernel.org>
In-Reply-To: <cover.1645182327.git.bristot@kernel.org>
References: <cover.1645182327.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
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

Add the -T/--threshold option to set the minimum threshold to be
considered a noise to osnoise top and hist commands. Also update
the man pages.

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-trace-devel@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 .../tools/rtla/common_osnoise_options.rst        |  5 +++++
 tools/tracing/rtla/src/osnoise_hist.c            | 16 +++++++++++++++-
 tools/tracing/rtla/src/osnoise_top.c             | 16 +++++++++++++++-
 3 files changed, 35 insertions(+), 2 deletions(-)

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
index 1f0b7fce55cf..a6ce312ef621 100644
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
@@ -434,6 +435,7 @@ static void osnoise_hist_usage(char *usage)
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
 
-		c = getopt_long(argc, argv, "c:b:d:e:Dhp:P:r:s:S:t::0123",
+		c = getopt_long(argc, argv, "c:b:d:e:Dhp:P:r:s:S:t::T:0123",
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
index c67dc28ef716..613c9486a01e 100644
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
@@ -252,6 +253,7 @@ void osnoise_top_usage(char *usage)
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
2.34.1

