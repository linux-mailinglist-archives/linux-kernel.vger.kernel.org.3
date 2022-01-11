Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC2348B3C6
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 18:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344329AbiAKR0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 12:26:54 -0500
Received: from linux.microsoft.com ([13.77.154.182]:33902 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344172AbiAKR0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 12:26:32 -0500
Received: from localhost.localdomain (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 87BDD20B7186;
        Tue, 11 Jan 2022 09:26:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 87BDD20B7186
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1641921992;
        bh=RcR+xQbVPDiU7noqi+dqilCOcZVvvB+GiBebBBsT7Gs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Al8vnG8u9jIQNPaVFGoJ/BnUqSYylPx1KqKon8tmdxhILAK8/uIVCS6MdE5ayN1B9
         IyvEiqrKlYuMgEi/XF1WMX7ZmE9Sp8b8Wy8oj6g8V5cfJ8+WHbJZM658WcMYwC/f6u
         2jUp4UNcuTHD+RozYgrIAtOjDHlw73ngqwfD/H1c=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        beaub@linux.microsoft.com
Subject: [PATCH v9 04/12] user_events: Add basic perf and eBPF support
Date:   Tue, 11 Jan 2022 09:25:54 -0800
Message-Id: <20220111172602.2513-5-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220111172602.2513-1-beaub@linux.microsoft.com>
References: <20220111172602.2513-1-beaub@linux.microsoft.com>
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
index 05d0d7e0e6c9..966dfb4fdc8d 100644
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
@@ -865,6 +932,9 @@ static int user_event_parse(char *name, char *args, char *flags,
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

