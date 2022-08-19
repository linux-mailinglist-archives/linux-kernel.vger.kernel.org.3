Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4D359938B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 05:38:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244970AbiHSD1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 23:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240757AbiHSD1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 23:27:42 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6031DF66A
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 20:27:40 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id x19so465812pfq.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 20:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=GldylU5dd1JEW5gLCDjVvkeue4tyo1rlosgRSvESHms=;
        b=cbN8+GrAY//bN9pc6s3/JQoXB8PHSjYxHvvkvlA+s7xNXp7stCF2W1HnU/k/pVnrH4
         nGa8QteoLmPvdCTinLgN7CKCR9Ryh32tegmW4nw4JI2FdR3vmkgSYxMqAGs00SwAD8JB
         ehggIltAACMqkZ5WMOYT8mJr9ebFJTrNO8q0r55WP0zq429hm/1XiAgSvhnCZqGwImk2
         5b8iLlj9SFnpsiGhmWvbNXaKYQe7GbRz7wkEYs5sjhQeq0zE0DpvB/wADCBqxBLEMpZZ
         dr6CQB4fpUlI0LlbxvJvMB0MNSOCQ2gg5lFZsBh39zum3xmMEM/SzROjB43oQ2kH3J3h
         ndVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=GldylU5dd1JEW5gLCDjVvkeue4tyo1rlosgRSvESHms=;
        b=vxab+EA1WKtsB8lqcKYQnCKuL2EvFkRyF9APhxzvhXDt94am7UQQAm8JuNAXaWU/D2
         R5j/RvLs1SBHQgkxngqVe13cDWeYQHv5wiZ7cMDzXyB24+Y9qbkO6PnTxj/NOMs83DNR
         PnN/7WUYHYHC/ckO1z/7WydmsQsAXPHLzWiz0CD2tS20Qv8RA71zR/md5RgHdkJY6bHk
         JMrdVDZL/9AAwmM1eAJSZ2qFjRu3myWfWPwgRdOJGMCJJ5qzT+ColcQcEENYDKKv3F54
         iqHBH89v60gY1zCq34Q/DGKEoD24k3+MnvOIVha2OmNQVSooLn2J0f63okVlEyDf36fp
         G6Jg==
X-Gm-Message-State: ACgBeo1TQObi3xKR2RTtxcmZb/dB+62Q1erq0f1I03baCYHzZEatwxXS
        H1k846en/VwzdGb3Snqws4U=
X-Google-Smtp-Source: AA6agR6xhkVjl8V1BvK/lh4rZDoOkog1Booasdt1WVPEWMFuIoQPhqoJK8f4rQ0NczrEs5VDHGWk/Q==
X-Received: by 2002:a05:6a00:1681:b0:52e:d9b1:8596 with SMTP id k1-20020a056a00168100b0052ed9b18596mr5878433pfc.56.1660879660272;
        Thu, 18 Aug 2022 20:27:40 -0700 (PDT)
Received: from localhost.localdomain (li567-56.members.linode.com. [192.155.81.56])
        by smtp.gmail.com with ESMTPSA id q5-20020a170902a3c500b0016befc83c6bsm2101032plb.165.2022.08.18.20.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 20:27:39 -0700 (PDT)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, mhiramat@kernel.org, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, chensong_2000@189.cn,
        Jeff Xie <xiehuan09@gmail.com>
Subject: [PATCH v15 1/4] trace: Add trace any kernel object
Date:   Fri, 19 Aug 2022 11:27:03 +0800
Message-Id: <20220819032706.695212-2-xiehuan09@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220819032706.695212-1-xiehuan09@gmail.com>
References: <20220819032706.695212-1-xiehuan09@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce objtrace trigger to get the call flow by tracing any kernel
object in the function parameter.

The objtrace trigger makes a list of the target object address from
the given event parameter, and records all kernel function calls
which has the object address in its parameter.

Syntax:
	objtrace:add:obj[:count][if <filter>]

Usage:
	# echo 'p bio_add_page arg1=$arg1' > kprobe_events
	# cd events/kprobes/p_bio_add_page_0
	# echo 'objtrace:add:arg1:1 if comm == "cat"' > ./trigger
	# cat /test.txt

Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 include/linux/trace_events.h        |   1 +
 kernel/trace/Kconfig                |  10 +
 kernel/trace/Makefile               |   1 +
 kernel/trace/trace.c                |  11 +
 kernel/trace/trace.h                |  21 ++
 kernel/trace/trace_entries.h        |  17 ++
 kernel/trace/trace_events_trigger.c |   5 +-
 kernel/trace/trace_object.c         | 450 ++++++++++++++++++++++++++++
 kernel/trace/trace_output.c         |  40 +++
 9 files changed, 554 insertions(+), 2 deletions(-)
 create mode 100644 kernel/trace/trace_object.c

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index b18759a673c6..4c9a899fc041 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -693,6 +693,7 @@ enum event_trigger_type {
 	ETT_EVENT_HIST		= (1 << 4),
 	ETT_HIST_ENABLE		= (1 << 5),
 	ETT_EVENT_EPROBE	= (1 << 6),
+	ETT_TRACE_OBJECT	= (1 << 7),
 };
 
 extern int filter_match_preds(struct event_filter *filter, void *rec);
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 1052126bdca2..4a78e72a07df 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -278,6 +278,16 @@ config FUNCTION_PROFILER
 
 	  If in doubt, say N.
 
+config TRACE_OBJECT
+	bool "Trace kernel object in function parameter"
+	depends on FUNCTION_TRACER
+	depends on HAVE_FUNCTION_ARG_ACCESS_API
+	select TRACING
+	default y
+	help
+	 You can trace the kernel object in the kernel function parameter.
+	 The kernel object is dynamically specified via event trigger.
+
 config STACK_TRACER
 	bool "Trace max stack"
 	depends on HAVE_FUNCTION_TRACER
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index c6651e16b557..9bbd1ac22518 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -71,6 +71,7 @@ obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += trace_functions_graph.o
 obj-$(CONFIG_TRACE_BRANCH_PROFILING) += trace_branch.o
 obj-$(CONFIG_BLK_DEV_IO_TRACE) += blktrace.o
 obj-$(CONFIG_FUNCTION_GRAPH_TRACER) += fgraph.o
+obj-$(CONFIG_TRACE_OBJECT) += trace_object.o
 ifeq ($(CONFIG_BLOCK),y)
 obj-$(CONFIG_EVENT_TRACING) += blktrace.o
 endif
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 27febd4ee33e..2c2477dea0f2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5621,6 +5621,9 @@ static const char readme_msg[] =
 	"\t            enable_hist:<system>:<event>\n"
 	"\t            disable_hist:<system>:<event>\n"
 #endif
+#ifdef CONFIG_TRACE_OBJECT
+	"\t            objtrace:add:obj[:count][if <filter>]\n"
+#endif
 #ifdef CONFIG_STACKTRACE
 	"\t\t    stacktrace\n"
 #endif
@@ -9261,6 +9264,9 @@ static struct trace_array *trace_array_create(const char *name)
 	if (ftrace_allocate_ftrace_ops(tr) < 0)
 		goto out_free_tr;
 
+	if (allocate_objtrace_data(tr) < 0)
+		goto out_free_tr;
+
 	ftrace_init_trace_array(tr);
 
 	init_trace_flags_index(tr);
@@ -9280,6 +9286,7 @@ static struct trace_array *trace_array_create(const char *name)
 
  out_free_tr:
 	ftrace_free_ftrace_ops(tr);
+	free_objtrace_data(tr);
 	free_trace_buffers(tr);
 	free_cpumask_var(tr->tracing_cpumask);
 	kfree(tr->name);
@@ -9373,6 +9380,7 @@ static int __remove_instance(struct trace_array *tr)
 	event_trace_del_tracer(tr);
 	ftrace_clear_pids(tr);
 	ftrace_destroy_function_files(tr);
+	free_objtrace_data(tr);
 	tracefs_remove(tr->dir);
 	free_percpu(tr->last_func_repeats);
 	free_trace_buffers(tr);
@@ -10110,6 +10118,9 @@ __init static int tracer_alloc_buffers(void)
 		goto out_free_savedcmd;
 	}
 
+	if (allocate_objtrace_data(&global_trace))
+		goto out_free_savedcmd;
+
 	if (global_trace.buffer_disabled)
 		tracing_off();
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 900e75d96c84..8da1ef78a09a 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -54,6 +54,7 @@ enum trace_type {
 	TRACE_TIMERLAT,
 	TRACE_RAW_DATA,
 	TRACE_FUNC_REPEATS,
+	TRACE_OBJECT,
 
 	__TRACE_LAST_TYPE,
 };
@@ -363,6 +364,9 @@ struct trace_array {
 	cpumask_var_t		tracing_cpumask; /* only trace on set CPUs */
 	int			ref;
 	int			trace_ref;
+#ifdef CONFIG_TRACE_OBJECT
+	struct objtrace_data	*obj_data;
+#endif
 #ifdef CONFIG_FUNCTION_TRACER
 	struct ftrace_ops	*ops;
 	struct trace_pid_list	__rcu *function_pids;
@@ -471,6 +475,7 @@ extern void __ftrace_bad_type(void);
 			  TRACE_GRAPH_RET);		\
 		IF_ASSIGN(var, ent, struct func_repeats_entry,		\
 			  TRACE_FUNC_REPEATS);				\
+		IF_ASSIGN(var, ent, struct trace_object_entry, TRACE_OBJECT);\
 		__ftrace_bad_type();					\
 	} while (0)
 
@@ -1536,6 +1541,16 @@ static inline int register_trigger_hist_cmd(void) { return 0; }
 static inline int register_trigger_hist_enable_disable_cmds(void) { return 0; }
 #endif
 
+#ifdef CONFIG_TRACE_OBJECT
+extern int register_trigger_object_cmd(void);
+extern int allocate_objtrace_data(struct trace_array *tr);
+extern void free_objtrace_data(struct trace_array *tr);
+#else
+static inline int register_trigger_object_cmd(void) { return 0; }
+static inline int allocate_objtrace_data(struct trace_array *tr) { return 0; }
+static inline void free_objtrace_data(struct trace_array *tr) { };
+#endif
+
 extern int register_trigger_cmds(void);
 extern void clear_event_triggers(struct trace_array *tr);
 
@@ -1611,6 +1626,12 @@ extern bool event_trigger_check_remove(const char *glob);
 extern bool event_trigger_empty_param(const char *param);
 extern int event_trigger_separate_filter(char *param_and_filter, char **param,
 					 char **filter, bool param_required);
+extern int register_trigger(char *glob,
+			struct event_trigger_data *data,
+			struct trace_event_file *file);
+extern void unregister_trigger(char *glob,
+			struct event_trigger_data *test,
+			struct trace_event_file *file);
 extern struct event_trigger_data *
 event_trigger_alloc(struct event_command *cmd_ops,
 		    char *cmd,
diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index cd41e863b51c..bb120d9498a9 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -401,3 +401,20 @@ FTRACE_ENTRY(timerlat, timerlat_entry,
 		 __entry->context,
 		 __entry->timer_latency)
 );
+
+/*
+ * trace object entry:
+ */
+FTRACE_ENTRY(object, trace_object_entry,
+
+	TRACE_OBJECT,
+
+	F_STRUCT(
+		__field(	unsigned long,		ip		)
+		__field(	unsigned long,		parent_ip	)
+		__field(	unsigned long,		object		)
+	),
+
+	F_printk(" %ps <-- %ps object:%lx\n",
+		 (void *)__entry->ip, (void *)__entry->parent_ip, __entry->object)
+);
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index cb866c3141af..8bad4eb3b997 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -560,7 +560,7 @@ void update_cond_flag(struct trace_event_file *file)
  *
  * Return: 0 on success, errno otherwise
  */
-static int register_trigger(char *glob,
+int register_trigger(char *glob,
 			    struct event_trigger_data *data,
 			    struct trace_event_file *file)
 {
@@ -605,7 +605,7 @@ static int register_trigger(char *glob,
  * Usually used directly as the @unreg method in event command
  * implementations.
  */
-static void unregister_trigger(char *glob,
+void unregister_trigger(char *glob,
 			       struct event_trigger_data *test,
 			       struct trace_event_file *file)
 {
@@ -1976,6 +1976,7 @@ __init int register_trigger_cmds(void)
 	register_trigger_enable_disable_cmds();
 	register_trigger_hist_enable_disable_cmds();
 	register_trigger_hist_cmd();
+	register_trigger_object_cmd();
 
 	return 0;
 }
diff --git a/kernel/trace/trace_object.c b/kernel/trace/trace_object.c
new file mode 100644
index 000000000000..19ec4b1c0186
--- /dev/null
+++ b/kernel/trace/trace_object.c
@@ -0,0 +1,450 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * trace the kernel object in the kernel function parameter
+ * Copyright (C) 2021 Jeff Xie <xiehuan09@gmail.com>
+ */
+
+#define pr_fmt(fmt) "trace_object: " fmt
+
+#include "trace_output.h"
+
+#define MAX_TRACED_OBJECT 5
+#define OBJTRACE_CMD_LEN  16
+#define OBJTRACE_CMD_ADD "add"
+static LIST_HEAD(obj_data_head);
+static const int max_args_num = 6;
+static void exit_trace_object(struct trace_array *tr);
+static int init_trace_object(struct trace_array *tr);
+
+struct object_instance {
+	void *obj;
+	struct trace_array *tr;
+};
+
+/* objtrace private data */
+struct objtrace_trigger_data {
+	struct ftrace_event_field *field;
+	char objtrace_cmd[OBJTRACE_CMD_LEN];
+	struct trace_array *tr;
+};
+
+/* objtrace data with fops and objtrace_instances */
+struct objtrace_data {
+	struct list_head head;
+	struct trace_array *tr;
+	struct ftrace_ops fops;
+	int num_traced_obj;
+	struct object_instance traced_obj[MAX_TRACED_OBJECT];
+	raw_spinlock_t obj_data_lock;
+};
+
+static struct objtrace_data *get_obj_data(struct trace_array *tr)
+{
+	struct objtrace_data *obj_data = NULL;
+
+	list_for_each_entry(obj_data, &obj_data_head, head) {
+		if (obj_data->tr == tr)
+			break;
+	}
+	return obj_data;
+}
+
+static bool object_exist(void *obj, struct trace_array *tr)
+{
+	int i, max;
+	struct objtrace_data *obj_data;
+
+	obj_data = get_obj_data(tr);
+	if (!obj_data)
+		return false;
+
+	max = READ_ONCE(obj_data->num_traced_obj);
+	smp_rmb();
+	for (i = 0; i < max; i++) {
+		if (obj_data->traced_obj[i].obj == obj)
+			return true;
+	}
+	return false;
+}
+
+static bool object_empty(struct trace_array *tr)
+{
+	struct objtrace_data *obj_data;
+
+	obj_data = get_obj_data(tr);
+	if (!obj_data)
+		return false;
+
+	return !READ_ONCE(obj_data->num_traced_obj);
+}
+
+static void set_trace_object(void *obj, struct trace_array *tr)
+{
+	unsigned long flags;
+	struct object_instance *obj_ins;
+	struct objtrace_data *obj_data;
+
+	if (in_nmi())
+		return;
+
+	if (!obj && object_exist(obj, tr))
+		return;
+
+	obj_data = get_obj_data(tr);
+	if (!obj_data)
+		return;
+
+	/* only this place has write operations */
+	raw_spin_lock_irqsave(&obj_data->obj_data_lock, flags);
+	if (READ_ONCE(obj_data->num_traced_obj) == MAX_TRACED_OBJECT) {
+		trace_array_printk_buf(tr->array_buffer.buffer, _THIS_IP_,
+				"object_pool is full, can't trace object:0x%px\n", obj);
+		goto out;
+	}
+	obj_ins = &obj_data->traced_obj[READ_ONCE(obj_data->num_traced_obj)];
+	obj_ins->obj = obj;
+	obj_ins->tr = tr;
+	/* make sure the num_traced_obj update always appears after traced_obj update */
+	smp_wmb();
+	obj_data->num_traced_obj++;
+out:
+	raw_spin_unlock_irqrestore(&obj_data->obj_data_lock, flags);
+}
+
+static void submit_trace_object(unsigned long ip, unsigned long parent_ip,
+				 unsigned long object, struct trace_array *tr)
+{
+
+	struct trace_buffer *buffer = tr->array_buffer.buffer;
+	struct ring_buffer_event *event;
+	struct trace_object_entry *entry;
+	unsigned int trace_ctx = 0;
+
+	trace_ctx = tracing_gen_ctx();
+	event = trace_buffer_lock_reserve(buffer, TRACE_OBJECT,
+			sizeof(*entry), trace_ctx);
+	if (!event)
+		return;
+	entry   = ring_buffer_event_data(event);
+	entry->ip                       = ip;
+	entry->parent_ip                = parent_ip;
+	entry->object			= object;
+
+	trace_buffer_unlock_commit(tr, buffer, event, trace_ctx);
+}
+
+static void
+trace_object_events_call(unsigned long ip, unsigned long parent_ip,
+		struct ftrace_ops *op, struct ftrace_regs *fregs)
+{
+	struct pt_regs *pt_regs = ftrace_get_regs(fregs);
+	struct trace_array *tr = op->private;
+	struct trace_array_cpu *data;
+	unsigned long obj;
+	long disabled;
+	int cpu, n;
+
+	preempt_disable_notrace();
+
+	cpu = raw_smp_processor_id();
+	data = per_cpu_ptr(tr->array_buffer.data, cpu);
+	disabled = atomic_inc_return(&data->disabled);
+	if (likely(disabled == 1)) {
+		if (object_empty(tr))
+			goto out;
+		for (n = 0; n < max_args_num; n++) {
+			obj = regs_get_kernel_argument(pt_regs, n);
+			if (object_exist((void *)obj, tr))
+				submit_trace_object(ip, parent_ip, obj, tr);
+		/* The parameters of a function may match multiple objects */
+		}
+	}
+out:
+	atomic_dec(&data->disabled);
+	preempt_enable_notrace();
+}
+
+static void
+trace_object_trigger(struct event_trigger_data *data,
+		   struct trace_buffer *buffer,  void *rec,
+		   struct ring_buffer_event *event)
+{
+	struct objtrace_trigger_data *obj_data = data->private_data;
+	struct trace_array *tr = obj_data->tr;
+	struct ftrace_event_field *field;
+	void *obj = NULL;
+
+	field = obj_data->field;
+	memcpy(&obj, rec + field->offset, sizeof(obj));
+	set_trace_object(obj, tr);
+}
+
+static void
+trace_object_trigger_free(struct event_trigger_data *data)
+{
+	struct objtrace_trigger_data *obj_data = data->private_data;
+
+	if (WARN_ON_ONCE(data->ref <= 0))
+		return;
+
+	data->ref--;
+	if (!data->ref) {
+		exit_trace_object(obj_data->tr);
+		kfree(data->private_data);
+		trigger_data_free(data);
+	}
+}
+
+static void
+trace_object_count_trigger(struct event_trigger_data *data,
+			 struct trace_buffer *buffer, void *rec,
+			 struct ring_buffer_event *event)
+{
+	if (!data->count)
+		return;
+
+	if (data->count != -1)
+		(data->count)--;
+
+	trace_object_trigger(data, buffer, rec, event);
+}
+
+static int
+event_trigger_print(const char *name, struct seq_file *m,
+		void *data, char *filter_str, void *objtrace_data)
+{
+	long count = (long)data;
+	struct objtrace_trigger_data *obj_data = objtrace_data;
+
+	seq_puts(m, name);
+
+	seq_printf(m, ":%s", obj_data->objtrace_cmd);
+	seq_printf(m, ":%s", obj_data->field->name);
+
+	if (count == -1)
+		seq_puts(m, ":unlimited");
+	else
+		seq_printf(m, ":count=%ld", count);
+
+	if (filter_str)
+		seq_printf(m, " if %s\n", filter_str);
+	else
+		seq_putc(m, '\n');
+
+	return 0;
+}
+
+static int event_object_trigger_init(struct event_trigger_data *data)
+{
+	struct objtrace_trigger_data *obj_data = data->private_data;
+	int ret;
+
+	if (!data->ref) {
+		ret = init_trace_object(obj_data->tr);
+		if (ret)
+			return ret;
+	}
+	data->ref++;
+	return 0;
+}
+
+static int
+trace_object_trigger_print(struct seq_file *m, struct event_trigger_data *data)
+{
+	return event_trigger_print("objtrace", m, (void *)data->count,
+				   data->filter_str, data->private_data);
+}
+
+static struct event_trigger_ops objecttrace_trigger_ops = {
+	.trigger		= trace_object_trigger,
+	.print			= trace_object_trigger_print,
+	.init			= event_object_trigger_init,
+	.free			= trace_object_trigger_free,
+};
+
+static struct event_trigger_ops objecttrace_count_trigger_ops = {
+	.trigger		= trace_object_count_trigger,
+	.print			= trace_object_trigger_print,
+	.init			= event_object_trigger_init,
+	.free			= trace_object_trigger_free,
+};
+
+static struct event_trigger_ops *
+objecttrace_get_trigger_ops(char *cmd, char *param)
+{
+	return param ? &objecttrace_count_trigger_ops : &objecttrace_trigger_ops;
+}
+
+static bool field_exist(struct trace_event_file *file,
+			struct event_command *cmd_ops,
+			const char *field_name)
+{
+	struct event_trigger_data *data;
+	struct objtrace_trigger_data *obj_data;
+
+	lockdep_assert_held(&event_mutex);
+
+	list_for_each_entry(data, &file->triggers, list) {
+		if (data->cmd_ops->trigger_type == cmd_ops->trigger_type) {
+			obj_data = data->private_data;
+			if (!strcmp(obj_data->field->name, field_name))
+				return true;
+		}
+	}
+
+	return false;
+}
+
+static int
+event_object_trigger_parse(struct event_command *cmd_ops,
+		       struct trace_event_file *file,
+		       char *glob, char *cmd, char *param_and_filter)
+{
+	struct event_trigger_data *trigger_data;
+	struct objtrace_trigger_data *obj_data;
+	struct ftrace_event_field *field;
+	char *objtrace_cmd, *arg;
+	char *param, *filter;
+	int ret;
+	bool remove;
+
+	remove = event_trigger_check_remove(glob);
+
+	/*
+	 * separate the param and the filter:
+	 * objtrace:add:OBJ[:COUNT] [if filter]
+	 */
+	ret = event_trigger_separate_filter(param_and_filter, &param, &filter, true);
+	if (ret)
+		return ret;
+
+	objtrace_cmd = strsep(&param, ":");
+	if (!objtrace_cmd || strcmp(objtrace_cmd, OBJTRACE_CMD_ADD)) {
+		pr_err("error objtrace command\n");
+		return -EINVAL;
+	}
+
+	arg = strsep(&param, ":");
+	if (!arg)
+		return -EINVAL;
+
+	field = trace_find_event_field(file->event_call, arg);
+	if (!field)
+		return -EINVAL;
+
+	if (field->size != sizeof(void *)) {
+		pr_err("the size of the %s should be:%zu\n", field->name, sizeof(void *));
+		return -EINVAL;
+	}
+
+	if (remove && !field_exist(file, cmd_ops, field->name))
+		return -ENOENT;
+
+	obj_data = kzalloc(sizeof(*obj_data), GFP_KERNEL);
+	if (!obj_data)
+		return -ENOMEM;
+
+	obj_data->field = field;
+	obj_data->tr = file->tr;
+	snprintf(obj_data->objtrace_cmd, OBJTRACE_CMD_LEN, objtrace_cmd);
+
+	trigger_data = event_trigger_alloc(cmd_ops, cmd, param, obj_data);
+	if (!trigger_data) {
+		kfree(obj_data);
+		return -ENOMEM;
+	}
+	if (remove) {
+		event_trigger_unregister(cmd_ops, file, glob+1, trigger_data);
+		kfree(obj_data);
+		kfree(trigger_data);
+		return 0;
+	}
+
+	ret = event_trigger_parse_num(param, trigger_data);
+	if (ret)
+		goto out_free;
+
+	ret = event_trigger_set_filter(cmd_ops, file, filter, trigger_data);
+	if (ret < 0)
+		goto out_free;
+
+	ret = event_trigger_register(cmd_ops, file, glob, trigger_data);
+	if (ret)
+		goto out_free;
+
+	return ret;
+
+ out_free:
+	event_trigger_reset_filter(cmd_ops, trigger_data);
+	kfree(obj_data);
+	kfree(trigger_data);
+	return ret;
+}
+
+static struct event_command trigger_object_cmd = {
+	.name			= "objtrace",
+	.trigger_type		= ETT_TRACE_OBJECT,
+	.flags			= EVENT_CMD_FL_NEEDS_REC,
+	.parse			= event_object_trigger_parse,
+	.reg			= register_trigger,
+	.unreg			= unregister_trigger,
+	.get_trigger_ops	= objecttrace_get_trigger_ops,
+	.set_filter		= set_trigger_filter,
+};
+
+__init int register_trigger_object_cmd(void)
+{
+	int ret;
+
+	ret = register_event_command(&trigger_object_cmd);
+	WARN_ON(ret < 0);
+
+	return ret;
+}
+
+int allocate_objtrace_data(struct trace_array *tr)
+{
+	struct objtrace_data *obj_data;
+	struct ftrace_ops *fops;
+
+	obj_data = kzalloc(sizeof(*obj_data), GFP_KERNEL);
+	if (!obj_data)
+		return -ENOMEM;
+
+	raw_spin_lock_init(&obj_data->obj_data_lock);
+	obj_data->tr = tr;
+	fops = &obj_data->fops;
+	fops->func = trace_object_events_call;
+	fops->flags = FTRACE_OPS_FL_SAVE_REGS;
+	fops->private = tr;
+	list_add(&obj_data->head, &obj_data_head);
+
+	tr->obj_data = obj_data;
+
+	return 0;
+}
+
+static int init_trace_object(struct trace_array *tr)
+{
+	int ret;
+
+	ret = register_ftrace_function(&tr->obj_data->fops);
+	WARN_ON(ret < 0);
+
+	return ret;
+}
+
+void free_objtrace_data(struct trace_array *tr)
+{
+	kfree(tr->obj_data);
+	tr->obj_data = NULL;
+}
+
+static void exit_trace_object(struct trace_array *tr)
+{
+	struct objtrace_data *obj_data = tr->obj_data;
+
+	obj_data->num_traced_obj = 0;
+	WARN_ONCE(unregister_ftrace_function(&obj_data->fops),
+			"can't unregister ftrace for trace object\n");
+}
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 67f47ea27921..34ff7b4dc521 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1551,6 +1551,45 @@ static struct trace_event trace_func_repeats_event = {
 	.funcs		= &trace_func_repeats_funcs,
 };
 
+/* TRACE_OBJECT */
+static enum print_line_t trace_object_print(struct trace_iterator *iter, int flags,
+					struct trace_event *event)
+{
+	struct trace_object_entry *field;
+	struct trace_seq *s = &iter->seq;
+
+	trace_assign_type(field, iter->ent);
+	print_fn_trace(s, field->ip, field->parent_ip, flags);
+	trace_seq_printf(s, " object:0x%lx", field->object);
+	trace_seq_putc(s, '\n');
+
+	return trace_handle_return(s);
+}
+
+static enum print_line_t trace_object_raw(struct trace_iterator *iter, int flags,
+				      struct trace_event *event)
+{
+	struct trace_object_entry *field;
+
+	trace_assign_type(field, iter->ent);
+
+	trace_seq_printf(&iter->seq, "%lx %lx\n",
+			 field->ip,
+			 field->parent_ip);
+
+	return trace_handle_return(&iter->seq);
+}
+
+static struct trace_event_functions trace_object_funcs = {
+	.trace		= trace_object_print,
+	.raw		= trace_object_raw,
+};
+
+static struct trace_event trace_object_event = {
+	.type		= TRACE_OBJECT,
+	.funcs		= &trace_object_funcs,
+};
+
 static struct trace_event *events[] __initdata = {
 	&trace_fn_event,
 	&trace_ctx_event,
@@ -1565,6 +1604,7 @@ static struct trace_event *events[] __initdata = {
 	&trace_timerlat_event,
 	&trace_raw_data_event,
 	&trace_func_repeats_event,
+	&trace_object_event,
 	NULL
 };
 
-- 
2.25.1

