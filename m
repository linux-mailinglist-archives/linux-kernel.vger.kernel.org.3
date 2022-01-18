Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2962492F96
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 21:43:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349394AbiARUnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 15:43:40 -0500
Received: from linux.microsoft.com ([13.77.154.182]:43822 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345699AbiARUnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 15:43:31 -0500
Received: from localhost.localdomain (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7991320B927C;
        Tue, 18 Jan 2022 12:43:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7991320B927C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1642538611;
        bh=/HgTyLUM1y/ekRW1ED5OYV5fNJHETloYSTRQcsY0MkA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IaP0qq9pIVzaL2kwlrx0iHeGSYlqFMhGv5zIB+Xn4wgx1yVklrkD4Lt7Rv74QTMrw
         CkW1H1Q2iJ63h6bqg6344Wlcqll9Fw5QGIReThkH8RB+Gx8AqtJ609d9XfO4bDVjBD
         HdhrsZKUQWU+EaY80mpIKkbfkSPVsSd+bCFx6xEo=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        beaub@linux.microsoft.com
Subject: [PATCH v10 04/12] user_events: Add basic perf and eBPF support
Date:   Tue, 18 Jan 2022 12:43:18 -0800
Message-Id: <20220118204326.2169-5-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118204326.2169-1-beaub@linux.microsoft.com>
References: <20220118204326.2169-1-beaub@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support to write out user_event data to perf_probe/perf files as
well as to any attached eBPF program.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c | 72 +++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index a6794cb1f586..371f31472156 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -551,6 +551,50 @@ static void user_event_ftrace(struct user_event *user, void *data, u32 datalen,
 	trace_event_buffer_commit(&event_buffer);
 }
 
+#ifdef CONFIG_PERF_EVENTS
+/*
+ * Writes the user supplied payload out to perf ring buffer or eBPF program.
+ */
+static void user_event_perf(struct user_event *user, void *data, u32 datalen,
+			    void *tpdata)
+{
+	struct hlist_head *perf_head;
+
+	if (bpf_prog_array_valid(&user->call)) {
+		struct user_bpf_context context = {0};
+
+		context.data_len = datalen;
+		context.data_type = USER_BPF_DATA_KERNEL;
+		context.kdata = data;
+
+		trace_call_bpf(&user->call, &context);
+	}
+
+	perf_head = this_cpu_ptr(user->call.perf_events);
+
+	if (perf_head && !hlist_empty(perf_head)) {
+		struct trace_entry *perf_entry;
+		struct pt_regs *regs;
+		size_t size = sizeof(*perf_entry) + datalen;
+		int context;
+
+		perf_entry = perf_trace_buf_alloc(ALIGN(size, 8),
+						  &regs, &context);
+
+		if (unlikely(!perf_entry))
+			return;
+
+		perf_fetch_caller_regs(regs);
+
+		memcpy(perf_entry + 1, data, datalen);
+
+		perf_trace_buf_submit(perf_entry, size, context,
+				      user->call.event.type, 1, regs,
+				      perf_head, NULL);
+	}
+}
+#endif
+
 /*
  * Update the register page that is shared between user processes.
  */
@@ -573,6 +617,10 @@ static void update_reg_page_for(struct user_event *user)
 
 				if (probe_func == user_event_ftrace)
 					status |= EVENT_STATUS_FTRACE;
+#ifdef CONFIG_PERF_EVENTS
+				else if (probe_func == user_event_perf)
+					status |= EVENT_STATUS_PERF;
+#endif
 				else
 					status |= EVENT_STATUS_OTHER;
 			} while ((++probe_func_ptr)->func);
@@ -612,8 +660,27 @@ static int user_event_reg(struct trace_event_call *call,
 					    data);
 		goto dec;
 
-	default:
+#ifdef CONFIG_PERF_EVENTS
+	case TRACE_REG_PERF_REGISTER:
+		ret = tracepoint_probe_register(call->tp,
+						call->class->perf_probe,
+						data);
+		if (!ret)
+			goto inc;
+		break;
+
+	case TRACE_REG_PERF_UNREGISTER:
+		tracepoint_probe_unregister(call->tp,
+					    call->class->perf_probe,
+					    data);
+		goto dec;
+
+	case TRACE_REG_PERF_OPEN:
+	case TRACE_REG_PERF_CLOSE:
+	case TRACE_REG_PERF_ADD:
+	case TRACE_REG_PERF_DEL:
 		break;
+#endif
 	}
 
 	return ret;
@@ -870,6 +937,9 @@ static int user_event_parse(char *name, char *args, char *flags,
 	user->class.get_fields = user_event_get_fields;
 	user->class.reg = user_event_reg;
 	user->class.probe = user_event_ftrace;
+#ifdef CONFIG_PERF_EVENTS
+	user->class.perf_probe = user_event_perf;
+#endif
 
 	mutex_lock(&event_mutex);
 	ret = user_event_trace_register(user);
-- 
2.17.1

