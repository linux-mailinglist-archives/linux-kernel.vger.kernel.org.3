Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB8C4A36D4
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 15:45:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355130AbiA3Oo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 09:44:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355093AbiA3Oow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 09:44:52 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AC1FC061714
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 06:44:52 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id nn16-20020a17090b38d000b001b56b2bce31so11180288pjb.3
        for <linux-kernel@vger.kernel.org>; Sun, 30 Jan 2022 06:44:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=66psKv/JXm9/Wr593dlqnm/Uu7uPX3XYGWB9MwbiDlE=;
        b=OvEbLoqEJxhsF2PxZFrmfGuDwOolt0HOF+/rcOhes7vh+2DahECFrHIkXYBqdmCRlB
         be4X86AJvpy22r63il4uFZuL6ijXPSWI5SkVXsp/yeg/tQQMKNFoo7nhWh1h8Exex9zF
         Q9AzF7YoJ4rePS+cpYewXEWR8xDW/Xxxt3Q1sw9T8/lag17KURoY3uQSFGBRe7SXZTOA
         z7sxfnRBernSgd5NbXK8a61BB/t0MHPxYTncH3kerBGpzDMWFYeyy1q/Y1/um1JDTsVV
         +v3PaZ6+sEP7Zmp83kJ5pnwsROx1dbJ4ozuBOR9cWzSQr7ciGk68fbLkBqooUXQyHkD0
         n5lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=66psKv/JXm9/Wr593dlqnm/Uu7uPX3XYGWB9MwbiDlE=;
        b=NU2uTVwqTbE7thJJm7m4b7uS+j3LmrE5zgGe2PW5y7xRALXjESGwAe3npGEdIfIbzN
         qeEd48ypJMwg+QePgRTnLJ1HKbi85bUgyV6Cw5tSg5Ahw+jKBzh+o6/W3eyRVM3pOQtI
         uBQZmzwy6WmvicguSw1+ceJZ0/Lr+9gj3vOpX0rxfCJ3588F7RZSmKF47mQMbIeBmqrY
         yWVqyak8qZ6e8Ssnoe0lkDF/o1Ytqaf1zVcAHwyjseAbjj6m0QHBgWZfxWJDeB9s9DhB
         tU3qu1jKb0hqyoT0GPfk70iD+7nLrKQCVS49zPT2OHUtSGZwmPCnYNQ/xej5ZfrlfsoP
         49WA==
X-Gm-Message-State: AOAM532OAWYS30pZ4AtAhj9Qe0KDlPvpsvrPcaTaCD0/zzILTEnDEs+G
        nVrT5MYl6CpyidxU+WMEE0s=
X-Google-Smtp-Source: ABdhPJxIQCxEl0+CMZs7yr4V19DXsAR3+BojsU295SzUcFJWKa25ZEKwfF36ZNbtYqgFp+kn/weKBw==
X-Received: by 2002:a17:902:f54b:: with SMTP id h11mr17771588plf.58.1643553891705;
        Sun, 30 Jan 2022 06:44:51 -0800 (PST)
Received: from localhost.localdomain (li567-56.members.linode.com. [192.155.81.56])
        by smtp.gmail.com with ESMTPSA id w8sm10502126pfu.128.2022.01.30.06.44.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 06:44:51 -0800 (PST)
From:   Jeff Xie <xiehuan09@gmail.com>
To:     rostedt@goodmis.org
Cc:     mhiramat@kernel.org, mingo@redhat.com, zanussi@kernel.org,
        linux-kernel@vger.kernel.org, Jeff Xie <xiehuan09@gmail.com>
Subject: [PATCH v8 2/4] trace/objtrace: get the value of the object
Date:   Sun, 30 Jan 2022 22:44:28 +0800
Message-Id: <20220130144430.453221-3-xiehuan09@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220130144430.453221-1-xiehuan09@gmail.com>
References: <20220130144430.453221-1-xiehuan09@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using objtrace trigger to get the value of the object which from the kernel
function parameter.

Syntax:
	objtrace:add:obj[,offset][:type][:count][if <filter>]

Usage:
	# echo 'p bio_add_page arg1=$arg1' > ./kprobe_events
	# gdb vmlinux
	(gdb) p &(((struct bio *)0)->bi_iter.bi_size)
	$1 = (unsigned int *) 0x28
	# echo 'objtrace:add:arg1,0x28:u32:1 if comm == "cat"' > ./events/kprobes/ \
		 p_bio_add_page_0/trigger
	# cat /test.txt

Signed-off-by: Jeff Xie <xiehuan09@gmail.com>
---
 kernel/trace/trace.c         |   2 +-
 kernel/trace/trace_entries.h |   5 +-
 kernel/trace/trace_object.c  | 214 +++++++++++++++++++++++++++++++----
 kernel/trace/trace_output.c  |   6 +-
 4 files changed, 197 insertions(+), 30 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b4513c2bbd52..5f145837d2ff 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -5606,7 +5606,7 @@ static const char readme_msg[] =
 	"\t            disable_hist:<system>:<event>\n"
 #endif
 #ifdef CONFIG_TRACE_OBJECT
-	"\t            objtrace:add:obj[:count][if <filter>]\n"
+	"\t            objtrace:add:obj[,offset][:type][:count][if <filter>]\n"
 #endif
 #ifdef CONFIG_STACKTRACE
 	"\t\t    stacktrace\n"
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
index 1eb485c513e9..01821aa6be04 100644
--- a/kernel/trace/trace_object.c
+++ b/kernel/trace/trace_object.c
@@ -18,10 +18,35 @@ static atomic_t num_traced_obj;
 static int exit_trace_object(void);
 static int init_trace_object(void);
 
+/*
+ * get the offset from the special object and
+ * the type size of the value
+ */
 static struct object_instance {
 	void *obj;
+	int obj_offset;
+	int obj_value_type_size;
 } traced_obj[MAX_TRACED_OBJECT];
 
+/* objtrace private data */
+struct objtrace_trigger_data {
+	struct ftrace_event_field *field;
+	int obj_offset;
+	int obj_value_type_size;
+};
+
+/* get the type size for the special object */
+struct objtrace_fetch_type {
+	char *name;
+	int type_size;
+};
+
+enum objattr {
+	OBJ_OFFSET,
+	OBJ_VAL_TYPE_SIZE,
+	MAX_OBJ_ATTR
+};
+
 static bool object_exist(void *obj)
 {
 	int i, max;
@@ -35,13 +60,37 @@ static bool object_exist(void *obj)
 	return false;
 }
 
+static int get_object_attr(void *obj, int objattr, int *result)
+{
+	int i, max;
+
+	max = atomic_read(&num_traced_obj);
+	smp_rmb();
+	for (i = 0; i < max; i++) {
+		if (traced_obj[i].obj == obj) {
+			switch (objattr) {
+			case OBJ_OFFSET:
+				*result =  traced_obj[i].obj_offset;
+				return 0;
+			case OBJ_VAL_TYPE_SIZE:
+				*result = traced_obj[i].obj_value_type_size;
+				return 0;
+			default:
+				return -EINVAL;
+			}
+		}
+	}
+	return -EINVAL;
+}
+
 static bool object_empty(void)
 {
 	return !atomic_read(&num_traced_obj);
 }
 
-static void set_trace_object(void *obj)
+static void set_trace_object(void *obj, int obj_offset, int obj_value_type_size)
 {
+	unsigned int traced_objs;
 	unsigned long flags;
 
 	if (in_nmi())
@@ -55,11 +104,14 @@ static void set_trace_object(void *obj)
 
 	/* only this place has write operations */
 	raw_spin_lock_irqsave(&trace_obj_lock, flags);
-	if (atomic_read(&num_traced_obj) == MAX_TRACED_OBJECT) {
+	traced_objs = atomic_read(&num_traced_obj);
+	if (traced_objs == MAX_TRACED_OBJECT) {
 		trace_printk("object_pool is full, can't trace object:0x%px\n", obj);
 		goto out;
 	}
-	traced_obj[atomic_read(&num_traced_obj)].obj = obj;
+	traced_obj[traced_objs].obj = obj;
+	traced_obj[traced_objs].obj_value_type_size = obj_value_type_size;
+	traced_obj[traced_objs].obj_offset = obj_offset;
 	/* make sure the num_traced_obj update always appears after traced_obj update */
 	smp_wmb();
 	atomic_inc(&num_traced_obj);
@@ -68,7 +120,7 @@ static void set_trace_object(void *obj)
 }
 
 static void submit_trace_object(unsigned long ip, unsigned long parent_ip,
-				 unsigned long object)
+				 unsigned long object, unsigned long value)
 {
 
 	struct trace_buffer *buffer;
@@ -85,19 +137,52 @@ static void submit_trace_object(unsigned long ip, unsigned long parent_ip,
 	entry->ip                       = ip;
 	entry->parent_ip                = parent_ip;
 	entry->object			= object;
+	entry->value			= value;
 
 	event_trigger_unlock_commit(&event_trace_file, buffer, event,
 		entry, pc);
 }
 
+static inline long get_object_value(unsigned long *val, void *obj, int type_size)
+{
+	char tmp[sizeof(u64)];
+	long ret = 0;
+
+	ret = copy_from_kernel_nofault(tmp, obj, sizeof(tmp));
+	if (ret)
+		return ret;
+	switch (type_size) {
+	case 1: {
+		*val = (unsigned long)*(u8 *)tmp;
+		break;
+	}
+	case 2: {
+		*val = (unsigned long)*(u16 *)tmp;
+		break;
+	}
+	case 4: {
+		*val = (unsigned long)*(u32 *)tmp;
+		break;
+	}
+	case 8: {
+		*val = (unsigned long)*(u64 *)tmp;
+		break;
+	}
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static void
 trace_object_events_call(unsigned long ip, unsigned long parent_ip,
 		struct ftrace_ops *op, struct ftrace_regs *fregs)
 {
 	struct pt_regs *pt_regs = ftrace_get_regs(fregs);
-	unsigned long obj;
+	int n, ret, val_type_size, obj_offset;
+	unsigned long obj, val;
 	unsigned int disabled;
-	int n;
 
 	preempt_disable_notrace();
 
@@ -110,8 +195,19 @@ trace_object_events_call(unsigned long ip, unsigned long parent_ip,
 
 	for (n = 0; n < max_args_num; n++) {
 		obj = regs_get_kernel_argument(pt_regs, n);
-		if (object_exist((void *)obj))
-			submit_trace_object(ip, parent_ip, obj);
+		if (object_exist((void *)obj)) {
+			ret =  get_object_attr((void *)obj, OBJ_OFFSET, &obj_offset);
+			if (unlikely(ret) < 0)
+				goto out;
+
+			get_object_attr((void *)obj, OBJ_VAL_TYPE_SIZE, &val_type_size);
+			if (unlikely(ret) < 0)
+				goto out;
+
+			if (get_object_value(&val, (void *)(obj + obj_offset), val_type_size))
+				continue;
+			submit_trace_object(ip, parent_ip, obj, val);
+		}
 	/* The parameters of a function may match multiple objects */
 	}
 out:
@@ -129,12 +225,14 @@ trace_object_trigger(struct event_trigger_data *data,
 		   struct trace_buffer *buffer,  void *rec,
 		   struct ring_buffer_event *event)
 {
+	struct objtrace_trigger_data *obj_data = data->private_data;
+	struct ftrace_event_field *field;
+	void *obj;
 
-	struct ftrace_event_field *field = data->private_data;
-	void *obj = NULL;
-
+	field = obj_data->field;
 	memcpy(&obj, rec + field->offset, sizeof(obj));
-	set_trace_object(obj);
+	/* set the offset from the special object and the type size of the value*/
+	set_trace_object(obj, obj_data->obj_offset, obj_data->obj_value_type_size);
 }
 
 static void
@@ -145,8 +243,10 @@ trace_object_trigger_free(struct event_trigger_ops *ops,
 		return;
 
 	data->ref--;
-	if (!data->ref)
+	if (!data->ref) {
+		kfree(data->private_data);
 		trigger_data_free(data);
+	}
 }
 
 static void
@@ -281,6 +381,22 @@ static void unregister_object_trigger(char *glob,
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
 event_object_trigger_parse(struct event_command *cmd_ops,
 		       struct trace_event_file *file,
@@ -288,19 +404,22 @@ event_object_trigger_parse(struct event_command *cmd_ops,
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
+	int ret, i, def_type_size, obj_value_type_size = 0;
+	long offset = 0;
 
 	ret = -EINVAL;
 	if (!param)
 		goto out;
 
-	/* separate the trigger from the filter (c:a:n [if filter]) */
+	/*
+	 * separate the trigger from the filter:
+	 * objtrace:add:OBJ[,OFFS][:TYPE][:COUNT] [if filter]
+	 */
 	trigger = strsep(&param, " \t");
 	if (!trigger)
 		goto out;
@@ -314,33 +433,79 @@ event_object_trigger_parse(struct event_command *cmd_ops,
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
 
 	if (field->size != sizeof(void *))
 		goto out;
+	def_type_size = sizeof(void *);
+	if (!trigger) {
+		obj_value_type_size = def_type_size;
+		goto skip_get_type;
+	}
 
+	tmp = trigger;
+	type = strsep(&trigger, ":");
+	if (!type)
+		obj_value_type_size = def_type_size;
+	else if (isdigit(type[0])) {
+		obj_value_type_size = def_type_size;
+		trigger = tmp;
+	} else {
+		for (i = 0; objtrace_fetch_types[i].name; i++) {
+			if (strcmp(objtrace_fetch_types[i].name, type) == 0) {
+				obj_value_type_size = objtrace_fetch_types[i].type_size;
+				break;
+			}
+		}
+	}
+	if (!obj_value_type_size)
+		goto out;
+skip_get_type:
 	trigger_ops = cmd_ops->get_trigger_ops(cmd, trigger);
 
 	ret = -ENOMEM;
+	obj_data = kzalloc(sizeof(*obj_data), GFP_KERNEL);
+	if (!obj_data)
+		goto out;
+
+	obj_data->field = field;
+	obj_data->obj_offset = offset;
+	obj_data->obj_value_type_size = obj_value_type_size;
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
 		cmd_ops->unreg(glob+1, trigger_data, file);
+		kfree(obj_data);
 		kfree(trigger_data);
 		ret = 0;
 		goto out;
@@ -395,6 +560,7 @@ event_object_trigger_parse(struct event_command *cmd_ops,
  out_free:
 	if (cmd_ops->set_filter)
 		cmd_ops->set_filter(NULL, trigger_data, NULL);
+	kfree(obj_data);
 	kfree(trigger_data);
 	goto out;
 }
diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 265428154638..04804f53cadd 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1557,6 +1557,7 @@ static enum print_line_t trace_object_print(struct trace_iterator *iter, int fla
 	trace_assign_type(field, iter->ent);
 	print_fn_trace(s, field->ip, field->parent_ip, flags);
 	trace_seq_printf(s, " object:0x%lx", field->object);
+	trace_seq_printf(s, " value:0x%lx", field->value);
 	trace_seq_putc(s, '\n');
 
 	return trace_handle_return(s);
@@ -1569,9 +1570,8 @@ static enum print_line_t trace_object_raw(struct trace_iterator *iter, int flags
 
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

