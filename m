Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1872F58629D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 04:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239044AbiHACcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 22:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239013AbiHACcW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 22:32:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B5012ABA
        for <linux-kernel@vger.kernel.org>; Sun, 31 Jul 2022 19:32:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 689C861205
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 02:32:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C684C4314D;
        Mon,  1 Aug 2022 02:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659321139;
        bh=kMRPtGRuT0shf2/slxZfL4SP6ABHEl6v4bjwo3XuLpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i8OZt0PbUrRVMJYlH3z5eNtD26Qo+Ws7Wh95+YN3Id2We30fYvXoy9YIkhrPvuKMc
         z7g6HYa82Hf6743Y3lE7qiTzgJrGHHzX8f3d3niyKHWxUGacDjSEtBbdG9PQ2bU/IT
         qbIVeq9B26YcEPJiwK8fCR9vlCpKByUeSsKWGPjBzoofuB9TrQBlHHQ0Omei/RrlYU
         VaNe487sBWfrMuSFkqFost7gOHP4+l7MgCS+QWuicMgJU5kvfg4ybbgFwJ0Dq/6V24
         BMAV924NW0Ht/+nO2cNEPwimBfJ2smpEHFNcXNv4FR5v954CkTW4o2BowBJBhgZenU
         ulMxgdk2FEprg==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH 1/3] tracing/eprobe: Show syntax error logs in error_log file
Date:   Mon,  1 Aug 2022 11:32:15 +0900
Message-Id: <165932113556.2850673.3483079297896607612.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <165932112555.2850673.7704483936633223533.stgit@devnote2>
References: <165932112555.2850673.7704483936633223533.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Show the syntax errors for event probes in error_log file as same as
other dynamic events, so that user can understand what is the problem.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_eprobe.c |   11 +++++++++--
 kernel/trace/trace_probe.h  |    5 ++++-
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

