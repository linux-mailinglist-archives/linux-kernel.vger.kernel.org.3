Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BA2462205
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 21:18:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233892AbhK2UUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 15:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbhK2URA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 15:17:00 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACF2C06FD50
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 08:50:19 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 200so16724650pga.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Nov 2021 08:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NAYnSsQgkjzjR6q6DfDs5ntOOEkr6eFLSdOVqdLwhMs=;
        b=ZBoKCCC9B59dOnP0J8v5zGKgk6wEgZIEvFyAGJqfi6IQ+5Sk5FmqbO1y7jJMgTF5XS
         AbHpAJVHEfDk4drV5bhFyEtUDEy8n86lqLhz1vmK5KB4aUdoGFUtwIYklalvUr3sqo87
         fZ1Up009J7jXmfBo3gnIvSHzJ0m3sruLFnxb0rS3W9sICpUomfzcr45NGs9096BbGFiP
         HwhgcLX+R/E2+QmpBv1drVGDzncSMKPs60YomaCI3JFmf++cQdoZvTgQjvWLrXaniNV0
         b/y8y9kZlJexdlKpIgtvyeJgrU5E3ToYFnkYjK8pmAFYCjxJiF7PNnJgehg6NyNIWD4d
         UUUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NAYnSsQgkjzjR6q6DfDs5ntOOEkr6eFLSdOVqdLwhMs=;
        b=2JbTqFsl/YcvLOGG9N6sYmDlJb/HEhfi1WIjHmiX+U2noxvO5eQZKfaldhkIvwfK4X
         2aAtG7bwJR34pCVM6GQS4W6Erh1fel+/8VJWH70BdgN2egWQCoBm5UhYyIuIhj7o/HLd
         O9SvNHXgG0EjZWxSK7KT6XaVS0a05WTge54GAWefEZkMYDOzei7y0HBt7372MAFOZMZ+
         6k6KrngmphkgoLAWWdvH5rk2F7PY3OIUvNkiJKfFHSxuISbFNB1vtJeeBuoP0NcSlIWI
         3tM6gIVateKBwKTQuHw9PCJP1DpFBtrkc+t2BdZ45UwB7I9foQjSo1C3Mm2hUPPb23Um
         rjZQ==
X-Gm-Message-State: AOAM530s0mnUJCksUE1Qi43+Tk2UpatggpLkR0BeCkLYOiJWSi65koiy
        qJ7MPshIZW9SHITiTXQ5SDk=
X-Google-Smtp-Source: ABdhPJx826u0rasaJRSE6HvgtqrrilXWKV30vRzSGh5Z7f6w/2pLo0oh4wmY/nJ0n5b7uZdTOsmIxg==
X-Received: by 2002:a05:6a00:1744:b0:4a4:f4e6:1cc0 with SMTP id j4-20020a056a00174400b004a4f4e61cc0mr39860471pfc.15.1638204619044;
        Mon, 29 Nov 2021 08:50:19 -0800 (PST)
Received: from localhost.localdomain (li567-56.members.linode.com. [192.155.81.56])
        by smtp.gmail.com with ESMTPSA id mr2sm14044211pjb.25.2021.11.29.08.50.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 08:50:18 -0800 (PST)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, mingo@redhat.com, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xie <xiehuan09@gmail.com>
Subject: [RFC][PATCH v6 2/5] trace/objtrace: get the value of the object
Date:   Tue, 30 Nov 2021 00:49:48 +0800
Message-Id: <20211129164951.220511-3-xiehuan09@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211129164951.220511-1-xiehuan09@gmail.com>
References: <20211129164951.220511-1-xiehuan09@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using objtrace trigger to get the value of the object which from the kernel
function parameter.

Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
---
 kernel/trace/trace_entries.h |   5 +-
 kernel/trace/trace_object.c  | 184 +++++++++++++++++++++++++++++------
 kernel/trace/trace_output.c  |   6 +-
 3 files changed, 161 insertions(+), 34 deletions(-)

diff --git a/kernel/trace/trace_entries.h b/kernel/trace/trace_entries.h
index bb120d9498a9..2407c45a568c 100644
--- a/kernel/trace/trace_entries.h
+++ b/kernel/trace/trace_entries.h
@@ -413,8 +413,9 @@ FTRACE_ENTRY(object, trace_object_entry,
 		__field(	unsigned long,		ip		)
 		__field(	unsigned long,		parent_ip	)
 		__field(	unsigned long,		object		)
+		__field(	unsigned long,		value		)
 	),
 
-	F_printk(" %ps <-- %ps object:%lx\n",
-		 (void *)__entry->ip, (void *)__entry->parent_ip, __entry->object)
+	F_printk(" %ps <-- %ps object:%lx value:%lx\n", (void *)__entry->ip,
+	       (void *)__entry->parent_ip, __entry->object, __entry->value)
 );
diff --git a/kernel/trace/trace_object.c b/kernel/trace/trace_object.c
index 83fccd587b63..c66e53da6aff 100644
--- a/kernel/trace/trace_object.c
+++ b/kernel/trace/trace_object.c
@@ -12,14 +12,25 @@
 static DEFINE_PER_CPU(atomic_t, trace_object_event_disable);
 static DEFINE_RAW_SPINLOCK(object_spin_lock);
 static struct trace_event_file event_trace_file;
-static const int max_args_num = 6;
 static const int max_obj_pool = 10;
 static atomic_t trace_object_ref;
 static int exit_trace_object(void);
 static int init_trace_object(void);
 
+struct objtrace_trigger_data {
+	struct ftrace_event_field *field;
+	long offset;
+	int type_size;
+};
+
+struct objtrace_fetch_type {
+	char *name;
+	int type_size;
+};
+
 struct object_instance {
 	void *object;
+	int obj_type_size;
 	struct freelist_node free_list;
 	struct list_head active_list;
 };
@@ -50,7 +61,7 @@ static bool object_empty(void)
 	return list_empty(&obj_pool->active_list);
 }
 
-static void set_trace_object(void *obj)
+static void set_trace_object(void *obj, int type_size)
 {
 	struct freelist_node *fn;
 	struct object_instance *ins;
@@ -73,6 +84,7 @@ static void set_trace_object(void *obj)
 
 	ins = container_of(fn, struct object_instance, free_list);
 	ins->object = obj;
+	ins->obj_type_size = type_size;
 
 	raw_spin_lock_irqsave(&object_spin_lock, flags);
 	list_add_rcu(&ins->active_list, &obj_pool->active_list);
@@ -135,7 +147,7 @@ static int init_object_pool(void)
 }
 
 static void submit_trace_object(unsigned long ip, unsigned long parent_ip,
-				 unsigned long object)
+				 unsigned long object, unsigned long value)
 {
 
 	struct trace_buffer *buffer;
@@ -152,19 +164,68 @@ static void submit_trace_object(unsigned long ip, unsigned long parent_ip,
 	entry->ip                       = ip;
 	entry->parent_ip                = parent_ip;
 	entry->object			= object;
+	entry->value			= value;
 
 	event_trigger_unlock_commit(&event_trace_file, buffer, event,
 		entry, pc);
 }
 
+static inline long get_object_value(unsigned long *val, void *obj, int type_size)
+{
+	long ret = 0;
+
+	switch (type_size) {
+	case 1: {
+		u8 tmp;
+
+		ret = copy_from_kernel_nofault(&tmp, obj, sizeof(tmp));
+		if (ret)
+			goto out;
+		*val = tmp;
+		break;
+	}
+	case 2: {
+		u16 tmp;
+
+		ret = copy_from_kernel_nofault(&tmp, obj, sizeof(tmp));
+		if (ret)
+			goto out;
+		*val = tmp;
+		break;
+	}
+	case 4: {
+		u32 tmp;
+
+		ret = copy_from_kernel_nofault(&tmp, obj, sizeof(tmp));
+		if (ret)
+			goto out;
+		*val = tmp;
+		break;
+	}
+	case 8: {
+		u64 tmp;
+
+		ret = copy_from_kernel_nofault(&tmp, obj, sizeof(tmp));
+		if (ret)
+			goto out;
+		*val = tmp;
+		break;
+	}
+	default:
+		return -EINVAL;
+	}
+out:
+	return ret;
+}
+
 static void
 trace_object_events_call(unsigned long ip, unsigned long parent_ip,
 		struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
-	struct pt_regs *pt_regs = ftrace_get_regs(fregs);
-	unsigned long obj;
+	struct object_instance *inst;
+	unsigned long val = 0;
 	long disabled;
-	int cpu, n;
+	int cpu;
 
 	preempt_disable_notrace();
 
@@ -177,12 +238,11 @@ trace_object_events_call(unsigned long ip, unsigned long parent_ip,
 	if (object_empty())
 		goto out;
 
-	for (n = 0; n < max_args_num; n++) {
-		obj = regs_get_kernel_argument(pt_regs, n);
-		if (object_exist((void *)obj))
-			submit_trace_object(ip, parent_ip, obj);
+	list_for_each_entry_rcu(inst, &obj_pool->active_list, active_list) {
+		if (get_object_value(&val, inst->object, inst->obj_type_size))
+			goto out;
+		submit_trace_object(ip, parent_ip, (unsigned long)inst->object, val);
 	}
-
 out:
 	atomic_dec(&per_cpu(trace_object_event_disable, cpu));
 	preempt_enable_notrace();
@@ -198,12 +258,14 @@ trace_object_trigger(struct event_trigger_data *data,
 		   struct trace_buffer *buffer,  void *rec,
 		   struct ring_buffer_event *event)
 {
+	struct objtrace_trigger_data *obj_data = data->private_data;
+	struct ftrace_event_field *field;
+	void *obj, *val = NULL;
 
-	struct ftrace_event_field *field = data->private_data;
-	void *obj = NULL;
-
-	memcpy(&obj, rec + field->offset, sizeof(obj));
-	set_trace_object(obj);
+	field = obj_data->field;
+	memcpy(&val, rec + field->offset, sizeof(val));
+	obj = val + obj_data->offset;
+	set_trace_object(obj, obj_data->type_size);
 }
 
 static void
@@ -349,6 +411,22 @@ static void unregister_object_trigger(char *glob, struct event_trigger_ops *ops,
 	}
 }
 
+static const struct objtrace_fetch_type objtrace_fetch_types[] = {
+	{"u8", 1},
+	{"s8", 1},
+	{"x8", 1},
+	{"u16", 2},
+	{"s16", 2},
+	{"x16", 2},
+	{"u32", 4},
+	{"s32", 4},
+	{"x32", 4},
+	{"u64", 8},
+	{"s64", 8},
+	{"x64", 8},
+	{}
+};
+
 static int
 event_object_trigger_callback(struct event_command *cmd_ops,
 		       struct trace_event_file *file,
@@ -356,19 +434,21 @@ event_object_trigger_callback(struct event_command *cmd_ops,
 {
 	struct event_trigger_data *trigger_data;
 	struct event_trigger_ops *trigger_ops;
+	struct objtrace_trigger_data *obj_data;
 	struct trace_event_call *call;
 	struct ftrace_event_field *field;
-	char *objtrace_cmd;
-	char *trigger = NULL;
-	char *arg;
-	char *number;
-	int ret;
+	char *type, *tr, *obj, *tmp, *trigger = NULL;
+	char *number, *objtrace_cmd;
+	int ret, i, def_type_size, type_size = 0;
+	long offset = 0;
 
 	ret = -EINVAL;
 	if (!param)
 		goto out;
-
-	/* separate the trigger from the filter (c:a:n [if filter]) */
+	/*
+	 * separate the trigger from the filter:
+	 * objtrace:add:OBJ[,OFFS][:TYPE][:COUNT] [if filter]
+	 */
 	trigger = strsep(&param, " \t");
 	if (!trigger)
 		goto out;
@@ -382,33 +462,78 @@ event_object_trigger_callback(struct event_command *cmd_ops,
 	if (!objtrace_cmd || strcmp(objtrace_cmd, "add"))
 		goto out;
 
-	arg = strsep(&trigger, ":");
-	if (!arg)
+	obj = strsep(&trigger, ":");
+	if (!obj)
 		goto out;
+
+	tr = strchr(obj, ',');
+	if (!tr)
+		offset = 0;
+	else {
+		*tr++ = '\0';
+		ret = kstrtol(tr, 0, &offset);
+		if (ret)
+			goto out;
+	}
+
+	ret = -EINVAL;
 	call = file->event_call;
-	field = trace_find_event_field(call, arg);
+	field = trace_find_event_field(call, obj);
 	if (!field)
 		goto out;
-
 	if (field->size != sizeof(void *))
 		goto out;
+	def_type_size = sizeof(void *);
+	if (!trigger) {
+		type_size = def_type_size;
+		goto skip_get_type;
+	}
 
+	tmp = trigger;
+	type = strsep(&trigger, ":");
+	if (!type)
+		type_size = def_type_size;
+	else if (isdigit(type[0])) {
+		type_size = def_type_size;
+		trigger = tmp;
+	} else {
+		for (i = 0; objtrace_fetch_types[i].name; i++) {
+			if (strcmp(objtrace_fetch_types[i].name, type) == 0) {
+				type_size = objtrace_fetch_types[i].type_size;
+				break;
+			}
+		}
+	}
+	if (!type_size)
+		goto out;
+skip_get_type:
 	trigger_ops = cmd_ops->get_trigger_ops(cmd, trigger);
 
 	ret = -ENOMEM;
+	obj_data = kzalloc(sizeof(*obj_data), GFP_KERNEL);
+	if (!obj_data)
+		goto out;
+
+	obj_data->field = field;
+	obj_data->offset = offset;
+	obj_data->type_size = type_size;
+
 	trigger_data = kzalloc(sizeof(*trigger_data), GFP_KERNEL);
-	if (!trigger_data)
+	if (!trigger_data) {
+		kfree(obj_data);
 		goto out;
+	}
 
 	trigger_data->count = -1;
 	trigger_data->ops = trigger_ops;
 	trigger_data->cmd_ops = cmd_ops;
-	trigger_data->private_data = field;
+	trigger_data->private_data = obj_data;
 	INIT_LIST_HEAD(&trigger_data->list);
 	INIT_LIST_HEAD(&trigger_data->named_list);
 
 	if (glob[0] == '!') {
 		cmd_ops->unreg(glob+1, trigger_ops, trigger_data, file);
+		kfree(obj_data);
 		kfree(trigger_data);
 		ret = 0;
 		goto out;
@@ -463,6 +588,7 @@ event_object_trigger_callback(struct event_command *cmd_ops,
  out_free:
 	if (cmd_ops->set_filter)
 		cmd_ops->set_filter(NULL, trigger_data, NULL);
+	kfree(obj_data);
 	kfree(trigger_data);
 	goto out;
 }
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index d747aed27104..12a971927d8c 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1553,6 +1553,7 @@ static enum print_line_t trace_object_print(struct trace_iterator *iter, int fla
 	trace_assign_type(field, iter->ent);
 	print_fn_trace(s, field->ip, field->parent_ip, flags);
 	trace_seq_printf(s, " object:0x%lx", field->object);
+	trace_seq_printf(s, " value:0x%lx", field->value);
 	trace_seq_putc(s, '\n');
 
 	return trace_handle_return(s);
@@ -1565,9 +1566,8 @@ static enum print_line_t trace_object_raw(struct trace_iterator *iter, int flags
 
 	trace_assign_type(field, iter->ent);
 
-	trace_seq_printf(&iter->seq, "%lx %lx\n",
-			 field->ip,
-			 field->parent_ip);
+	trace_seq_printf(&iter->seq, "%lx %lx %lx %lx\n", field->ip,
+			field->parent_ip, field->object, field->value);
 
 	return trace_handle_return(&iter->seq);
 }
-- 
2.25.1

