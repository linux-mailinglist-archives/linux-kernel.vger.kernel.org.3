Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBE54CAE11
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 20:02:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244813AbiCBTDW convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 2 Mar 2022 14:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244791AbiCBTDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 14:03:15 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B4B652A713
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 11:02:29 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-287-X6Jj7_TLPuWSKOXBcV-bIw-1; Wed, 02 Mar 2022 14:02:22 -0500
X-MC-Unique: X6Jj7_TLPuWSKOXBcV-bIw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7ECEB84A5F3;
        Wed,  2 Mar 2022 19:02:21 +0000 (UTC)
Received: from x1.com (unknown [10.22.32.168])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0114819C59;
        Wed,  2 Mar 2022 19:02:17 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Clark Williams <williams@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [PATCH V3 03/15] rtla/osnoise: Add the automatic trace option
Date:   Wed,  2 Mar 2022 20:01:28 +0100
Message-Id: <ef04c961b227eb93a83cd0b54bfca45e1a381b77.1646247211.git.bristot@kernel.org>
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

Add the -a/--auto <arg in us> option. This option sets some commonly
used options while debugging the system. It aims to help users produce
reports in the field, reducing the number of arguments passed to the
tool in the first approach to a problem.

It is equivalent to setting osnoise/stop_tracing_us with the argument,
setting tracing_thresh to 1 us, and saving the trace to osnoise_trace.txt
file if the trace is stopped automatically.

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
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
2.34.1

