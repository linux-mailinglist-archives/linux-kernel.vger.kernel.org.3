Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBED4BB7C5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 12:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234521AbiBRLKK convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Fri, 18 Feb 2022 06:10:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbiBRLKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 06:10:07 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0FDE42B4634
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 03:09:46 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427-ZeXwVsTJN_apnJ19RaSQHQ-1; Fri, 18 Feb 2022 06:09:42 -0500
X-MC-Unique: ZeXwVsTJN_apnJ19RaSQHQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5544118009C6;
        Fri, 18 Feb 2022 11:09:41 +0000 (UTC)
Received: from x1.com (unknown [10.22.32.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A789C2B4B5;
        Fri, 18 Feb 2022 11:09:39 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-trace-devel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] rtla/osnoise: Add -e/--event option
Date:   Fri, 18 Feb 2022 12:09:18 +0100
Message-Id: <8f30dbdc111c091294c76b40f9d807707535d1c8.1645182327.git.bristot@kernel.org>
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the -e <sys:[event]> option. This option allows the osnoise top to
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
 tools/tracing/rtla/src/osnoise_top.c | 29 +++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index 714976080dd8..c5ecaebe6a0d 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -31,6 +31,7 @@ struct osnoise_top_params {
 	int			quiet;
 	int			set_sched;
 	struct sched_attr	sched_param;
+	struct trace_events	*events;
 };
 
 struct osnoise_top_cpu {
@@ -286,6 +287,7 @@ void osnoise_top_usage(char *usage)
 struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 {
 	struct osnoise_top_params *params;
+	struct trace_events *tevent;
 	int retval;
 	int c;
 
@@ -299,6 +301,7 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 			{"cpus",		required_argument,	0, 'c'},
 			{"debug",		no_argument,		0, 'D'},
 			{"duration",		required_argument,	0, 'd'},
+			{"event",		required_argument,	0, 'e'},
 			{"help",		no_argument,		0, 'h'},
 			{"period",		required_argument,	0, 'p'},
 			{"priority",		required_argument,	0, 'P'},
@@ -314,7 +317,7 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "a:c:d:Dhp:P:qr:s:S:t::T:",
+		c = getopt_long(argc, argv, "a:c:d:De:hp:P:qr:s:S:t::T:",
 				 long_options, &option_index);
 
 		/* Detect the end of the options. */
@@ -347,6 +350,21 @@ struct osnoise_top_params *osnoise_top_parse_args(int argc, char **argv)
 			if (!params->duration)
 				osnoise_top_usage("Invalid -D duration\n");
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
+				params->trace_output = "osnoise_trace.txt";
+			break;
 		case 'h':
 		case '?':
 			osnoise_top_usage(NULL);
@@ -556,6 +574,13 @@ int osnoise_top_main(int argc, char **argv)
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
 
@@ -597,6 +622,8 @@ int osnoise_top_main(int argc, char **argv)
 	}
 
 out_top:
+	destroy_trace_events(&record->trace, params->events);
+	params->events = NULL;
 	osnoise_free_top(tool->data);
 	osnoise_destroy_tool(record);
 	osnoise_destroy_tool(tool);
-- 
2.34.1

