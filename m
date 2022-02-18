Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 610DE4BB7C0
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 12:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbiBRLKC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Feb 2022 06:10:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234412AbiBRLJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:09:58 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 559A82AEDA2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 03:09:42 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-400-mr83F3u0NlGFbQMPlCVGOg-1; Fri, 18 Feb 2022 06:09:38 -0500
X-MC-Unique: mr83F3u0NlGFbQMPlCVGOg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BA941091DA0;
        Fri, 18 Feb 2022 11:09:37 +0000 (UTC)
Received: from x1.com (unknown [10.22.32.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4C3542B4B5;
        Fri, 18 Feb 2022 11:09:35 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-trace-devel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/7] rtla/timerlat: Add the automatic trace option
Date:   Fri, 18 Feb 2022 12:09:16 +0100
Message-Id: <104a95dc532a4cc005400af7a4286108ce96597f.1645182327.git.bristot@kernel.org>
In-Reply-To: <cover.1645182327.git.bristot@kernel.org>
References: <cover.1645182327.git.bristot@kernel.org>
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

Add the -a/--auto <arg in us> option. This option sets some commonly
used options while debugging the system. It aims to help users produce
reports in the field, reducing the number of arguments passed to the
tool in the first approach to a problem.

It is equivalent to setting osnoise/stop_tracing_total_us and print_stack
with the argument, and saving the trace to timerlat_trace.txt file if the
trace is stopped automatically.

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-trace-devel@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
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
index 436a799f9adf..41d681ba6f4a 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -428,11 +428,12 @@ static void timerlat_hist_usage(char *usage)
 
 	char *msg[] = {
 		"",
-		"  usage: [rtla] timerlat hist [-h] [-q] [-d s] [-D] [-n] [-p us] [-i us] [-T us] [-s us] [-t[=file]] \\",
-		"         [-c cpu-list] [-P priority] [-e N] [-b N]  [--no-irq] [--no-thread] [--no-header] [--no-summary] \\",
-		"         [--no-index] [--with-zeros]",
+		"  usage: [rtla] timerlat hist [-h] [-q] [-d s] [-D] [-n] [-a us] [-p us] [-i us] [-T us] [-s us] \\",
+		"         [-t[=file]] [-c cpu-list] [-P priority] [-e N] [-b N]  [--no-irq] [--no-thread] [--no-header] \\",
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
 
-		c = getopt_long(argc, argv, "c:b:d:e:Dhi:np:P:s:t::T:012345",
+		c = getopt_long(argc, argv, "a:c:b:d:e:Dhi:np:P:s:t::T:012345",
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
2.34.1

