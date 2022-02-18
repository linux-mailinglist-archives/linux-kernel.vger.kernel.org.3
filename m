Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22834BB7CC
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 12:10:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbiBRLK0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Feb 2022 06:10:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234515AbiBRLKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:10:08 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B8EAF2B460F
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 03:09:51 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-86-b7UDO-nNOCmEL06BJVJruw-1; Fri, 18 Feb 2022 06:09:44 -0500
X-MC-Unique: b7UDO-nNOCmEL06BJVJruw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B9A56814245;
        Fri, 18 Feb 2022 11:09:43 +0000 (UTC)
Received: from x1.com (unknown [10.22.32.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B14792B4B5;
        Fri, 18 Feb 2022 11:09:41 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-trace-devel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 7/7] rtla/timerlat: Add -e/--event option
Date:   Fri, 18 Feb 2022 12:09:19 +0100
Message-Id: <5323a74c8121667a2a199eb3ce872a05c95a5157.1645182327.git.bristot@kernel.org>
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

Add the -e <sys:[event]> option. This option allows the timerlat top to
enable additional events to the trace instance. Multiple -e are enabled,
and it implies the -t option (if not already set).

Cc: Daniel Bristot de Oliveira <bristot@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-trace-devel@vger.kernel.org
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 tools/tracing/rtla/src/timerlat_top.c | 32 +++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index aef044832964..795dc0c673ad 100644
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
@@ -375,6 +379,21 @@ static struct timerlat_top_params
 			if (!params->duration)
 				timerlat_top_usage("Invalid -D duration\n");
 			break;
+		case 'e':
+			tevent = alloc_trace_event(optarg);
+			if (!tevent) {
+				err_msg("error alloc trace event");
+				exit(EXIT_FAILURE);
+			}
+
+			if (params->events)
+				tevent->next = params->events;
+			params->events = tevent;
+
+			/* if -e && !-t -> -t */
+			if (!params->trace_output)
+				params->trace_output = "timerlat_trace.txt";
+			break;
 		case 'h':
 		case '?':
 			timerlat_top_usage(NULL);
@@ -583,6 +602,13 @@ int timerlat_top_main(int argc, char *argv[])
 			err_msg("Failed to enable the trace instance\n");
 			goto out_top;
 		}
+
+		if (params->events) {
+			retval = enable_trace_events(&record->trace, params->events);
+			if (retval)
+				goto out_top;
+		}
+
 		trace_instance_start(&record->trace);
 	}
 
@@ -624,6 +650,8 @@ int timerlat_top_main(int argc, char *argv[])
 	}
 
 out_top:
+	destroy_trace_events(&record->trace, params->events);
+	params->events = NULL;
 	timerlat_free_top(top->data);
 	osnoise_destroy_tool(record);
 	osnoise_destroy_tool(top);
-- 
2.34.1

