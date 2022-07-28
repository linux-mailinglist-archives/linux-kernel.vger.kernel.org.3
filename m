Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7295848D0
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 01:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233467AbiG1XxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 19:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbiG1Xwv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 19:52:51 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EB94A70E52;
        Thu, 28 Jul 2022 16:52:48 -0700 (PDT)
Received: from localhost.localdomain (unknown [76.135.27.191])
        by linux.microsoft.com (Postfix) with ESMTPSA id A0D6D20FE9AA;
        Thu, 28 Jul 2022 16:52:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A0D6D20FE9AA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1659052368;
        bh=kkeIYCk4xRugfOKaGOA3vKIixSzKEtc2wGMUQxDoCEw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gk4lcjuBPg1338bAh/yKzySDxaPtgFq6jJipfr7O/NCLn99FI8g6OzqdtMvqIlOeX
         B+++hAJsMkqG5U0dYjOew/BBFffZH4gVhmuzAhMps8+DrAy5oHYIj591F3rKJ4wYyx
         LcV66e6Rm7OqK4pxl63rZ9G+PDzsTgotckRkwBio=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 4/7] tracing/user_events: Move pages/locks into groups to prepare for namespaces
Date:   Thu, 28 Jul 2022 16:52:38 -0700
Message-Id: <20220728235241.2249-5-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220728235241.2249-1-beaub@linux.microsoft.com>
References: <20220728235241.2249-1-beaub@linux.microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to enable namespaces or any sort of isolation within
user_events the register lock and pages need to be broken up into
groups. Each event and file now has a group pointer which stores the
actual pages to map, lookup data and synchronization objects.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c | 381 ++++++++++++++++++++++++-------
 1 file changed, 304 insertions(+), 77 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index fd8ea555437a..44f9efd58af5 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -69,11 +69,23 @@
 #define EVENT_STATUS_PERF BIT(1)
 #define EVENT_STATUS_OTHER BIT(7)
 
-static char *register_page_data;
+struct user_event_group {
+	struct page *pages;
+	char *register_page_data;
+	char *system_name;
+	struct dentry *status_file;
+	struct dentry *data_file;
+	struct hlist_node node;
+	struct mutex reg_mutex;
+	DECLARE_HASHTABLE(register_table, 8);
+	DECLARE_BITMAP(page_bitmap, MAX_EVENTS);
+	refcount_t refcnt;
+	int id;
+};
 
-static DEFINE_MUTEX(reg_mutex);
-static DEFINE_HASHTABLE(register_table, 8);
-static DECLARE_BITMAP(page_bitmap, MAX_EVENTS);
+static DEFINE_HASHTABLE(group_table, 8);
+static DEFINE_MUTEX(group_mutex);
+static struct user_event_group *root_group;
 
 /*
  * Stores per-event properties, as users register events
@@ -83,6 +95,7 @@ static DECLARE_BITMAP(page_bitmap, MAX_EVENTS);
  * refcnt reaches one.
  */
 struct user_event {
+	struct user_event_group *group;
 	struct tracepoint tracepoint;
 	struct trace_event_call call;
 	struct trace_event_class class;
@@ -109,6 +122,11 @@ struct user_event_refs {
 	struct user_event *events[];
 };
 
+struct user_event_file_info {
+	struct user_event_group *group;
+	struct user_event_refs *refs;
+};
+
 #define VALIDATOR_ENSURE_NULL (1 << 0)
 #define VALIDATOR_REL (1 << 1)
 
@@ -121,7 +139,8 @@ struct user_event_validator {
 typedef void (*user_event_func_t) (struct user_event *user, struct iov_iter *i,
 				   void *tpdata, bool *faulted);
 
-static int user_event_parse(char *name, char *args, char *flags,
+static int user_event_parse(struct user_event_group *group, char *name,
+			    char *args, char *flags,
 			    struct user_event **newuser);
 
 static u32 user_event_key(char *name)
@@ -129,12 +148,132 @@ static u32 user_event_key(char *name)
 	return jhash(name, strlen(name), 0);
 }
 
+static void set_page_reservations(char *pages, bool set)
+{
+	int page;
+
+	for (page = 0; page < MAX_PAGES; ++page) {
+		void *addr = pages + (PAGE_SIZE * page);
+
+		if (set)
+			SetPageReserved(virt_to_page(addr));
+		else
+			ClearPageReserved(virt_to_page(addr));
+	}
+}
+
+static void user_event_group_destroy(struct user_event_group *group)
+{
+	if (group->status_file)
+		tracefs_remove(group->status_file);
+
+	if (group->data_file)
+		tracefs_remove(group->data_file);
+
+	if (group->register_page_data)
+		set_page_reservations(group->register_page_data, false);
+
+	if (group->pages)
+		__free_pages(group->pages, MAX_PAGE_ORDER);
+
+	kfree(group->system_name);
+	kfree(group);
+}
+
+static char *user_event_group_system_name(const char *name)
+{
+	char *system_name;
+	int len = strlen(name) + sizeof(USER_EVENTS_SYSTEM) + 1;
+
+	system_name = kmalloc(len, GFP_KERNEL);
+
+	if (!system_name)
+		return NULL;
+
+	snprintf(system_name, len, "%s.%s", USER_EVENTS_SYSTEM, name);
+
+	return system_name;
+}
+
+static __always_inline
+void user_event_group_release(struct user_event_group *group)
+{
+	refcount_dec(&group->refcnt);
+}
+
+static struct user_event_group *user_event_group_find(int id)
+{
+	struct user_event_group *group;
+
+	mutex_lock(&group_mutex);
+
+	hash_for_each_possible(group_table, group, node, id)
+		if (group->id == id) {
+			refcount_inc(&group->refcnt);
+			mutex_unlock(&group_mutex);
+			return group;
+		}
+
+	mutex_unlock(&group_mutex);
+
+	return NULL;
+}
+
+static struct user_event_group *user_event_group_create(const char *name,
+							int id)
+{
+	struct user_event_group *group;
+
+	group = kzalloc(sizeof(*group), GFP_KERNEL);
+
+	if (!group)
+		return NULL;
+
+	if (name) {
+		group->system_name = user_event_group_system_name(name);
+
+		if (!group->system_name)
+			goto error;
+	}
+
+	group->pages = alloc_pages(GFP_KERNEL | __GFP_ZERO, MAX_PAGE_ORDER);
+
+	if (!group->pages)
+		goto error;
+
+	group->register_page_data = page_address(group->pages);
+
+	set_page_reservations(group->register_page_data, true);
+
+	/* Zero all bits beside 0 (which is reserved for failures) */
+	bitmap_zero(group->page_bitmap, MAX_EVENTS);
+	set_bit(0, group->page_bitmap);
+
+	mutex_init(&group->reg_mutex);
+	hash_init(group->register_table);
+
+	/* Mark and add to lookup */
+	group->id = id;
+	refcount_set(&group->refcnt, 2);
+
+	mutex_lock(&group_mutex);
+	hash_add(group_table, &group->node, group->id);
+	mutex_unlock(&group_mutex);
+
+	return group;
+error:
+	if (group)
+		user_event_group_destroy(group);
+
+	return NULL;
+};
+
 static __always_inline
 void user_event_register_set(struct user_event *user)
 {
 	int i = user->index;
 
-	register_page_data[MAP_STATUS_BYTE(i)] |= MAP_STATUS_MASK(i);
+	user->group->register_page_data[MAP_STATUS_BYTE(i)] |= MAP_STATUS_MASK(i);
 }
 
 static __always_inline
@@ -142,7 +281,7 @@ void user_event_register_clear(struct user_event *user)
 {
 	int i = user->index;
 
-	register_page_data[MAP_STATUS_BYTE(i)] &= ~MAP_STATUS_MASK(i);
+	user->group->register_page_data[MAP_STATUS_BYTE(i)] &= ~MAP_STATUS_MASK(i);
 }
 
 static __always_inline __must_check
@@ -186,7 +325,8 @@ static struct list_head *user_event_get_fields(struct trace_event_call *call)
  *
  * Upon success user_event has its ref count increased by 1.
  */
-static int user_event_parse_cmd(char *raw_command, struct user_event **newuser)
+static int user_event_parse_cmd(struct user_event_group *group,
+				char *raw_command, struct user_event **newuser)
 {
 	char *name = raw_command;
 	char *args = strpbrk(name, " ");
@@ -200,7 +340,7 @@ static int user_event_parse_cmd(char *raw_command, struct user_event **newuser)
 	if (flags)
 		*flags++ = '\0';
 
-	return user_event_parse(name, args, flags, newuser);
+	return user_event_parse(group, name, args, flags, newuser);
 }
 
 static int user_field_array_size(const char *type)
@@ -688,7 +828,7 @@ static int destroy_user_event(struct user_event *user)
 	dyn_event_remove(&user->devent);
 
 	user_event_register_clear(user);
-	clear_bit(user->index, page_bitmap);
+	clear_bit(user->index, user->group->page_bitmap);
 	hash_del(&user->node);
 
 	user_event_destroy_validators(user);
@@ -699,14 +839,15 @@ static int destroy_user_event(struct user_event *user)
 	return ret;
 }
 
-static struct user_event *find_user_event(char *name, u32 *outkey)
+static struct user_event *find_user_event(struct user_event_group *group,
+					  char *name, u32 *outkey)
 {
 	struct user_event *user;
 	u32 key = user_event_key(name);
 
 	*outkey = key;
 
-	hash_for_each_possible(register_table, user, node, key)
+	hash_for_each_possible(group->register_table, user, node, key)
 		if (!strcmp(EVENT_NAME(user), name)) {
 			refcount_inc(&user->refcnt);
 			return user;
@@ -953,14 +1094,14 @@ static int user_event_create(const char *raw_command)
 	if (!name)
 		return -ENOMEM;
 
-	mutex_lock(&reg_mutex);
+	mutex_lock(&root_group->reg_mutex);
 
-	ret = user_event_parse_cmd(name, &user);
+	ret = user_event_parse_cmd(root_group, name, &user);
 
 	if (!ret)
 		refcount_dec(&user->refcnt);
 
-	mutex_unlock(&reg_mutex);
+	mutex_unlock(&root_group->reg_mutex);
 
 	if (ret)
 		kfree(name);
@@ -1114,7 +1255,8 @@ static int user_event_trace_register(struct user_event *user)
  * The name buffer lifetime is owned by this method for success cases only.
  * Upon success the returned user_event has its ref count increased by 1.
  */
-static int user_event_parse(char *name, char *args, char *flags,
+static int user_event_parse(struct user_event_group *group, char *name,
+			    char *args, char *flags,
 			    struct user_event **newuser)
 {
 	int ret;
@@ -1124,7 +1266,7 @@ static int user_event_parse(char *name, char *args, char *flags,
 
 	/* Prevent dyn_event from racing */
 	mutex_lock(&event_mutex);
-	user = find_user_event(name, &key);
+	user = find_user_event(group, name, &key);
 	mutex_unlock(&event_mutex);
 
 	if (user) {
@@ -1137,7 +1279,7 @@ static int user_event_parse(char *name, char *args, char *flags,
 		return 0;
 	}
 
-	index = find_first_zero_bit(page_bitmap, MAX_EVENTS);
+	index = find_first_zero_bit(group->page_bitmap, MAX_EVENTS);
 
 	if (index == MAX_EVENTS)
 		return -EMFILE;
@@ -1151,6 +1293,7 @@ static int user_event_parse(char *name, char *args, char *flags,
 	INIT_LIST_HEAD(&user->fields);
 	INIT_LIST_HEAD(&user->validators);
 
+	user->group = group;
 	user->tracepoint.name = name;
 
 	ret = user_event_parse_fields(user, args);
@@ -1170,7 +1313,11 @@ static int user_event_parse(char *name, char *args, char *flags,
 	user->call.tp = &user->tracepoint;
 	user->call.event.funcs = &user_event_funcs;
 
-	user->class.system = USER_EVENTS_SYSTEM;
+	if (group->system_name)
+		user->class.system = group->system_name;
+	else
+		user->class.system = USER_EVENTS_SYSTEM;
+
 	user->class.fields_array = user_event_fields_array;
 	user->class.get_fields = user_event_get_fields;
 	user->class.reg = user_event_reg;
@@ -1193,8 +1340,8 @@ static int user_event_parse(char *name, char *args, char *flags,
 
 	dyn_event_init(&user->devent, &user_event_dops);
 	dyn_event_add(&user->devent, &user->call);
-	set_bit(user->index, page_bitmap);
-	hash_add(register_table, &user->node, key);
+	set_bit(user->index, group->page_bitmap);
+	hash_add(group->register_table, &user->node, key);
 
 	mutex_unlock(&event_mutex);
 
@@ -1212,10 +1359,10 @@ static int user_event_parse(char *name, char *args, char *flags,
 /*
  * Deletes a previously created event if it is no longer being used.
  */
-static int delete_user_event(char *name)
+static int delete_user_event(struct user_event_group *group, char *name)
 {
 	u32 key;
-	struct user_event *user = find_user_event(name, &key);
+	struct user_event *user = find_user_event(group, name, &key);
 
 	if (!user)
 		return -ENOENT;
@@ -1233,6 +1380,7 @@ static int delete_user_event(char *name)
  */
 static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
 {
+	struct user_event_file_info *info = file->private_data;
 	struct user_event_refs *refs;
 	struct user_event *user = NULL;
 	struct tracepoint *tp;
@@ -1244,7 +1392,7 @@ static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
 
 	rcu_read_lock_sched();
 
-	refs = rcu_dereference_sched(file->private_data);
+	refs = rcu_dereference_sched(info->refs);
 
 	/*
 	 * The refs->events array is protected by RCU, and new items may be
@@ -1302,6 +1450,30 @@ static ssize_t user_events_write_core(struct file *file, struct iov_iter *i)
 	return ret;
 }
 
+static int user_events_open(struct inode *node, struct file *file)
+{
+	struct user_event_group *group;
+	struct user_event_file_info *info;
+
+	group = user_event_group_find((int)(uintptr_t)node->i_private);
+
+	if (!group)
+		return -ENOENT;
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+
+	if (!info) {
+		user_event_group_release(group);
+		return -ENOMEM;
+	}
+
+	info->group = group;
+
+	file->private_data = info;
+
+	return 0;
+}
+
 static ssize_t user_events_write(struct file *file, const char __user *ubuf,
 				 size_t count, loff_t *ppos)
 {
@@ -1323,13 +1495,15 @@ static ssize_t user_events_write_iter(struct kiocb *kp, struct iov_iter *i)
 	return user_events_write_core(kp->ki_filp, i);
 }
 
-static int user_events_ref_add(struct file *file, struct user_event *user)
+static int user_events_ref_add(struct user_event_file_info *info,
+			       struct user_event *user)
 {
+	struct user_event_group *group = info->group;
 	struct user_event_refs *refs, *new_refs;
 	int i, size, count = 0;
 
-	refs = rcu_dereference_protected(file->private_data,
-					 lockdep_is_held(&reg_mutex));
+	refs = rcu_dereference_protected(info->refs,
+					 lockdep_is_held(&group->reg_mutex));
 
 	if (refs) {
 		count = refs->count;
@@ -1355,7 +1529,7 @@ static int user_events_ref_add(struct file *file, struct user_event *user)
 
 	refcount_inc(&user->refcnt);
 
-	rcu_assign_pointer(file->private_data, new_refs);
+	rcu_assign_pointer(info->refs, new_refs);
 
 	if (refs)
 		kfree_rcu(refs, rcu);
@@ -1392,7 +1566,8 @@ static long user_reg_get(struct user_reg __user *ureg, struct user_reg *kreg)
 /*
  * Registers a user_event on behalf of a user process.
  */
-static long user_events_ioctl_reg(struct file *file, unsigned long uarg)
+static long user_events_ioctl_reg(struct user_event_file_info *info,
+				  unsigned long uarg)
 {
 	struct user_reg __user *ureg = (struct user_reg __user *)uarg;
 	struct user_reg reg;
@@ -1413,14 +1588,14 @@ static long user_events_ioctl_reg(struct file *file, unsigned long uarg)
 		return ret;
 	}
 
-	ret = user_event_parse_cmd(name, &user);
+	ret = user_event_parse_cmd(info->group, name, &user);
 
 	if (ret) {
 		kfree(name);
 		return ret;
 	}
 
-	ret = user_events_ref_add(file, user);
+	ret = user_events_ref_add(info, user);
 
 	/* No longer need parse ref, ref_add either worked or not */
 	refcount_dec(&user->refcnt);
@@ -1438,7 +1613,8 @@ static long user_events_ioctl_reg(struct file *file, unsigned long uarg)
 /*
  * Deletes a user_event on behalf of a user process.
  */
-static long user_events_ioctl_del(struct file *file, unsigned long uarg)
+static long user_events_ioctl_del(struct user_event_file_info *info,
+				  unsigned long uarg)
 {
 	void __user *ubuf = (void __user *)uarg;
 	char *name;
@@ -1451,7 +1627,7 @@ static long user_events_ioctl_del(struct file *file, unsigned long uarg)
 
 	/* event_mutex prevents dyn_event from racing */
 	mutex_lock(&event_mutex);
-	ret = delete_user_event(name);
+	ret = delete_user_event(info->group, name);
 	mutex_unlock(&event_mutex);
 
 	kfree(name);
@@ -1465,19 +1641,21 @@ static long user_events_ioctl_del(struct file *file, unsigned long uarg)
 static long user_events_ioctl(struct file *file, unsigned int cmd,
 			      unsigned long uarg)
 {
+	struct user_event_file_info *info = file->private_data;
+	struct user_event_group *group = info->group;
 	long ret = -ENOTTY;
 
 	switch (cmd) {
 	case DIAG_IOCSREG:
-		mutex_lock(&reg_mutex);
-		ret = user_events_ioctl_reg(file, uarg);
-		mutex_unlock(&reg_mutex);
+		mutex_lock(&group->reg_mutex);
+		ret = user_events_ioctl_reg(info, uarg);
+		mutex_unlock(&group->reg_mutex);
 		break;
 
 	case DIAG_IOCSDEL:
-		mutex_lock(&reg_mutex);
-		ret = user_events_ioctl_del(file, uarg);
-		mutex_unlock(&reg_mutex);
+		mutex_lock(&group->reg_mutex);
+		ret = user_events_ioctl_del(info, uarg);
+		mutex_unlock(&group->reg_mutex);
 		break;
 	}
 
@@ -1489,17 +1667,24 @@ static long user_events_ioctl(struct file *file, unsigned int cmd,
  */
 static int user_events_release(struct inode *node, struct file *file)
 {
+	struct user_event_file_info *info = file->private_data;
+	struct user_event_group *group;
 	struct user_event_refs *refs;
 	struct user_event *user;
 	int i;
 
+	if (!info)
+		return -EINVAL;
+
+	group = info->group;
+
 	/*
 	 * Ensure refs cannot change under any situation by taking the
 	 * register mutex during the final freeing of the references.
 	 */
-	mutex_lock(&reg_mutex);
+	mutex_lock(&group->reg_mutex);
 
-	refs = file->private_data;
+	refs = info->refs;
 
 	if (!refs)
 		goto out;
@@ -1518,32 +1703,54 @@ static int user_events_release(struct inode *node, struct file *file)
 out:
 	file->private_data = NULL;
 
-	mutex_unlock(&reg_mutex);
+	mutex_unlock(&group->reg_mutex);
 
 	kfree(refs);
+	kfree(info);
+
+	/* No longer using group */
+	user_event_group_release(group);
 
 	return 0;
 }
 
 static const struct file_operations user_data_fops = {
+	.open = user_events_open,
 	.write = user_events_write,
 	.write_iter = user_events_write_iter,
 	.unlocked_ioctl	= user_events_ioctl,
 	.release = user_events_release,
 };
 
+static struct user_event_group *user_status_group(struct file *file)
+{
+	struct seq_file *m = file->private_data;
+
+	if (!m)
+		return NULL;
+
+	return m->private;
+}
+
 /*
  * Maps the shared page into the user process for checking if event is enabled.
  */
 static int user_status_mmap(struct file *file, struct vm_area_struct *vma)
 {
+	char *pages;
+	struct user_event_group *group = user_status_group(file);
 	unsigned long size = vma->vm_end - vma->vm_start;
 
 	if (size != MAX_BYTES)
 		return -EINVAL;
 
+	if (!group)
+		return -EINVAL;
+
+	pages = group->register_page_data;
+
 	return remap_pfn_range(vma, vma->vm_start,
-			       virt_to_phys(register_page_data) >> PAGE_SHIFT,
+			       virt_to_phys(pages) >> PAGE_SHIFT,
 			       size, vm_get_page_prot(VM_READ));
 }
 
@@ -1567,13 +1774,17 @@ static void user_seq_stop(struct seq_file *m, void *p)
 
 static int user_seq_show(struct seq_file *m, void *p)
 {
+	struct user_event_group *group = m->private;
 	struct user_event *user;
 	char status;
 	int i, active = 0, busy = 0, flags;
 
-	mutex_lock(&reg_mutex);
+	if (!group)
+		return -EINVAL;
+
+	mutex_lock(&group->reg_mutex);
 
-	hash_for_each(register_table, i, user, node) {
+	hash_for_each(group->register_table, i, user, node) {
 		status = user->status;
 		flags = user->flags;
 
@@ -1597,7 +1808,7 @@ static int user_seq_show(struct seq_file *m, void *p)
 		active++;
 	}
 
-	mutex_unlock(&reg_mutex);
+	mutex_unlock(&group->reg_mutex);
 
 	seq_puts(m, "\n");
 	seq_printf(m, "Active: %d\n", active);
@@ -1616,7 +1827,38 @@ static const struct seq_operations user_seq_ops = {
 
 static int user_status_open(struct inode *node, struct file *file)
 {
-	return seq_open(file, &user_seq_ops);
+	struct user_event_group *group;
+	int ret;
+
+	group = user_event_group_find((int)(uintptr_t)node->i_private);
+
+	if (!group)
+		return -ENOENT;
+
+	ret = seq_open(file, &user_seq_ops);
+
+	if (!ret) {
+		/* Chain group to seq_file */
+		struct seq_file *m = file->private_data;
+
+		m->private = group;
+	} else {
+		user_event_group_release(group);
+	}
+
+	return ret;
+}
+
+static int user_status_release(struct inode *node, struct file *file)
+{
+	struct user_event_group *group = user_status_group(file);
+
+	if (group)
+		user_event_group_release(group);
+	else
+		pr_warn("user_events: No group attached to status file\n");
+
+	return seq_release(node, file);
 }
 
 static const struct file_operations user_status_fops = {
@@ -1624,18 +1866,20 @@ static const struct file_operations user_status_fops = {
 	.mmap = user_status_mmap,
 	.read = seq_read,
 	.llseek  = seq_lseek,
-	.release = seq_release,
+	.release = user_status_release,
 };
 
 /*
  * Creates a set of tracefs files to allow user mode interactions.
  */
-static int create_user_tracefs(void)
+static int create_user_tracefs(struct dentry *parent,
+			       struct user_event_group *group)
 {
 	struct dentry *edata, *emmap;
 
 	edata = tracefs_create_file("user_events_data", TRACE_MODE_WRITE,
-				    NULL, NULL, &user_data_fops);
+				    parent, (void *)(uintptr_t)group->id,
+				    &user_data_fops);
 
 	if (!edata) {
 		pr_warn("Could not create tracefs 'user_events_data' entry\n");
@@ -1644,7 +1888,8 @@ static int create_user_tracefs(void)
 
 	/* mmap with MAP_SHARED requires writable fd */
 	emmap = tracefs_create_file("user_events_status", TRACE_MODE_WRITE,
-				    NULL, NULL, &user_status_fops);
+				    parent, (void *)(uintptr_t)group->id,
+				    &user_status_fops);
 
 	if (!emmap) {
 		tracefs_remove(edata);
@@ -1652,47 +1897,29 @@ static int create_user_tracefs(void)
 		goto err;
 	}
 
+	group->data_file = edata;
+	group->status_file = emmap;
+
 	return 0;
 err:
 	return -ENODEV;
 }
 
-static void set_page_reservations(bool set)
-{
-	int page;
-
-	for (page = 0; page < MAX_PAGES; ++page) {
-		void *addr = register_page_data + (PAGE_SIZE * page);
-
-		if (set)
-			SetPageReserved(virt_to_page(addr));
-		else
-			ClearPageReserved(virt_to_page(addr));
-	}
-}
-
 static int __init trace_events_user_init(void)
 {
-	struct page *pages;
 	int ret;
 
-	/* Zero all bits beside 0 (which is reserved for failures) */
-	bitmap_zero(page_bitmap, MAX_EVENTS);
-	set_bit(0, page_bitmap);
+	root_group = user_event_group_create(NULL, 0);
 
-	pages = alloc_pages(GFP_KERNEL | __GFP_ZERO, MAX_PAGE_ORDER);
-	if (!pages)
+	if (!root_group)
 		return -ENOMEM;
-	register_page_data = page_address(pages);
-
-	set_page_reservations(true);
 
-	ret = create_user_tracefs();
+	ret = create_user_tracefs(NULL, root_group);
 
 	if (ret) {
 		pr_warn("user_events could not register with tracefs\n");
-		set_page_reservations(false);
-		__free_pages(pages, MAX_PAGE_ORDER);
+		user_event_group_destroy(root_group);
+		root_group = NULL;
 		return ret;
 	}
 
-- 
2.25.1

