Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D579751637C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 11:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239384AbiEAJiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 05:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238883AbiEAJiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 05:38:14 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DE538796
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 02:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1651397689; x=1682933689;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vQnqRVgN+GEzG3Xd+sEQOnTd2bIKfmhRxNvprPbW8G4=;
  b=Vxeloz/D1mbNfKj+YdBqSTGjBw2T7E2BmwAkspBhNsipVjcdC0uuSW/9
   gko1A4ttUbbDf+d7SFN1l7geq+CliWL0ISXqNKO8ViqMR+9No4GxwOby8
   y+CLVVNTHW9KCXa2fPCKqS4YBJKoQSVOIJ0B4lqR5wT4V6ebPudmjXJKe
   4=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 01 May 2022 02:34:49 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 May 2022 02:34:49 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 1 May 2022 02:34:28 -0700
Received: from linyyuan-gv.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 1 May 2022 02:34:27 -0700
From:   Linyu Yuan <quic_linyyuan@quicinc.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
CC:     <linux-kernel@vger.kernel.org>,
        Linyu Yuan <quic_linyyuan@quicinc.com>
Subject: [PATCH 2/2] tracing/probes: make match function safe
Date:   Sun, 1 May 2022 17:34:11 +0800
Message-ID: <1651397651-30454-3-git-send-email-quic_linyyuan@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651397651-30454-1-git-send-email-quic_linyyuan@quicinc.com>
References: <1651397651-30454-1-git-send-email-quic_linyyuan@quicinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When delete one kprobe/uprobe/eprobe event entry
using /sys/kernel/debug/tracing/dynamic_events file,
it will loop all dynamic envent entries,
as user will not input dyn_event_operations type,
when call the match function of kprobe/uprobe/eprobe,
the dynamic event may have different dyn_event_operations type,
but currently match function may return a match.

Fix by check dyn_event_operations type first.

Signed-off-by: Linyu Yuan <quic_linyyuan@quicinc.com>
---
 kernel/trace/trace_eprobe.c | 31 +++++++++++++++++++++++--------
 kernel/trace/trace_kprobe.c |  3 +++
 kernel/trace/trace_uprobe.c |  3 +++
 3 files changed, 29 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index b16e067..0029840 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -19,6 +19,21 @@
 
 #define EPROBE_EVENT_SYSTEM "eprobes"
 
+static int eprobe_dyn_event_create(const char *raw_command);
+static int eprobe_dyn_event_show(struct seq_file *m, struct dyn_event *ev);
+static bool eprobe_dyn_event_is_busy(struct dyn_event *ev);
+static int eprobe_dyn_event_release(struct dyn_event *ev);
+static bool eprobe_dyn_event_match(const char *system, const char *event,
+			int argc, const char **argv, struct dyn_event *ev);
+
+static struct dyn_event_operations eprobe_dyn_event_ops = {
+	.create = eprobe_dyn_event_create,
+	.show = eprobe_dyn_event_show,
+	.is_busy = eprobe_dyn_event_is_busy,
+	.free = eprobe_dyn_event_release,
+	.match = eprobe_dyn_event_match,
+};
+
 struct trace_eprobe {
 	/* tracepoint system */
 	const char *event_system;
@@ -39,6 +54,11 @@ struct eprobe_data {
 
 static int __trace_eprobe_create(int argc, const char *argv[]);
 
+static bool is_trace_eprobe(struct dyn_event *ev)
+{
+	return ev->ops == &eprobe_dyn_event_ops;
+}
+
 static void trace_event_probe_cleanup(struct trace_eprobe *ep)
 {
 	if (!ep)
@@ -121,6 +141,9 @@ static bool eprobe_dyn_event_match(const char *system, const char *event,
 	struct trace_eprobe *ep = to_trace_eprobe(ev);
 	const char *slash;
 
+	if (!is_trace_eprobe(ev))
+		return false;
+
 	/*
 	 * We match the following:
 	 *  event only			- match all eprobes with event name
@@ -174,14 +197,6 @@ static bool eprobe_dyn_event_match(const char *system, const char *event,
 	return trace_probe_match_command_args(&ep->tp, argc, argv);
 }
 
-static struct dyn_event_operations eprobe_dyn_event_ops = {
-	.create = eprobe_dyn_event_create,
-	.show = eprobe_dyn_event_show,
-	.is_busy = eprobe_dyn_event_is_busy,
-	.free = eprobe_dyn_event_release,
-	.match = eprobe_dyn_event_match,
-};
-
 static struct trace_eprobe *alloc_event_probe(const char *group,
 					      const char *this_event,
 					      struct trace_event_call *event,
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 2cd8ef9..f63abfa 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -163,6 +163,9 @@ static bool trace_kprobe_match(const char *system, const char *event,
 {
 	struct trace_kprobe *tk = to_trace_kprobe(ev);
 
+	if (!is_trace_kprobe(ev))
+		return false;
+
 	return (event[0] == '\0' ||
 		strcmp(trace_probe_name(&tk->tp), event) == 0) &&
 	    (!system || strcmp(trace_probe_group_name(&tk->tp), system) == 0) &&
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index a935c08..ee55ed0 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -312,6 +312,9 @@ static bool trace_uprobe_match(const char *system, const char *event,
 {
 	struct trace_uprobe *tu = to_trace_uprobe(ev);
 
+	if (!is_trace_uprobe(ev))
+		return false;
+
 	return (event[0] == '\0' ||
 		strcmp(trace_probe_name(&tu->tp), event) == 0) &&
 	   (!system || strcmp(trace_probe_group_name(&tu->tp), system) == 0) &&
-- 
2.7.4

