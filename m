Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E82588E0D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 15:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238351AbiHCN5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 09:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238779AbiHCNzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 09:55:53 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB441055C
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 06:55:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F2836CE23A0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 13:55:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45390C43143;
        Wed,  3 Aug 2022 13:55:39 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oJEqY-007kRj-0w;
        Wed, 03 Aug 2022 09:55:38 -0400
Message-ID: <20220803135538.130965846@goodmis.org>
User-Agent: quilt/0.66
Date:   Wed, 03 Aug 2022 09:55:12 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Subject: [for-next][PATCH 4/5] tracing/eprobe: Show syntax error logs in error_log file
References: <20220803135508.240797292@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>

Show the syntax errors for event probes in error_log file as same as
other dynamic events, so that user can understand what is the problem.

Link: https://lkml.kernel.org/r/165932113556.2850673.3483079297896607612.stgit@devnote2

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_eprobe.c | 11 +++++++++--
 kernel/trace/trace_probe.h  |  5 ++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index a30f21499e81..4a0e9d927443 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -839,8 +839,11 @@ static int trace_eprobe_tp_update_arg(struct trace_eprobe *ep, const char *argv[
 	if (ret)
 		return ret;
 
-	if (ep->tp.args[i].code->op == FETCH_OP_TP_ARG)
+	if (ep->tp.args[i].code->op == FETCH_OP_TP_ARG) {
 		ret = trace_eprobe_tp_arg_update(ep, i);
+		if (ret)
+			trace_probe_log_err(0, BAD_ATTACH_ARG);
+	}
 
 	return ret;
 }
@@ -880,8 +883,10 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 	trace_probe_log_set_index(1);
 	sys_event = argv[1];
 	ret = traceprobe_parse_event_name(&sys_event, &sys_name, buf2, 0);
-	if (!sys_event || !sys_name)
+	if (!sys_event || !sys_name) {
+		trace_probe_log_err(0, NO_EVENT_INFO);
 		goto parse_error;
+	}
 
 	if (!event) {
 		strscpy(buf1, argv[1], MAX_EVENT_NAME_LEN);
@@ -896,6 +901,8 @@ static int __trace_eprobe_create(int argc, const char *argv[])
 
 	if (IS_ERR(ep)) {
 		ret = PTR_ERR(ep);
+		if (ret == -ENODEV)
+			trace_probe_log_err(0, BAD_ATTACH_EVENT);
 		/* This must return -ENOMEM or missing event, else there is a bug */
 		WARN_ON_ONCE(ret != -ENOMEM && ret != -ENODEV);
 		ep = NULL;
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 92cc149af0fd..3b3869ae8cfd 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -442,7 +442,10 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(FAIL_REG_PROBE,	"Failed to register probe event"),\
 	C(DIFF_PROBE_TYPE,	"Probe type is different from existing probe"),\
 	C(DIFF_ARG_TYPE,	"Argument type or name is different from existing probe"),\
-	C(SAME_PROBE,		"There is already the exact same probe event"),
+	C(SAME_PROBE,		"There is already the exact same probe event"),\
+	C(NO_EVENT_INFO,	"This requires both group and event name to attach"),\
+	C(BAD_ATTACH_EVENT,	"Attached event does not exist"),\
+	C(BAD_ATTACH_ARG,	"Attached event does not have this field"),
 
 #undef C
 #define C(a, b)		TP_ERR_##a
-- 
2.35.1
