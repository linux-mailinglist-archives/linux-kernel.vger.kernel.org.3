Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B96D480D7D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 22:31:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237639AbhL1VbJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 16:31:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42659 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237587AbhL1Va5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 16:30:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640727056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xa7dxlntY/DpkYx7DfautLpI2nhSdeShR7fEHZvJHJg=;
        b=hdMv+Ud/YKaq10Na5mnRNGKL0p//s/Kp6OxEBUegFoTzKtEZ/gLFY06C2sPKUpRKwnj5Ei
        kBYAe6rRgBvZlT3Hg8Zur+sOU5Wf5uoS9dRKAM2H1cM4025WTnV0HlWE62YEyWhrYVopWK
        2IZgDLl+UR7E4CRbfL7HD0p3c7Swrqk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-292-pZmfCTWMMWeF_yRKg6kZDQ-1; Tue, 28 Dec 2021 16:30:55 -0500
X-MC-Unique: pZmfCTWMMWeF_yRKg6kZDQ-1
Received: by mail-wr1-f71.google.com with SMTP id d6-20020adfa346000000b001a262748c6fso4288222wrb.12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Dec 2021 13:30:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xa7dxlntY/DpkYx7DfautLpI2nhSdeShR7fEHZvJHJg=;
        b=4MZBigncIwiNUD0Xl1TzKWqP7T1gsnAj7WZKDdqvYRwEkwjrYMpk1yaFimPqQxSRhJ
         N/4ULRUCGtaKfRXf1TNgJb0sDP3ry1i8+R1JJLS2kxjd4yRifCa7asa0hjXPQC0MjIgt
         hLa4zS2R91u+DOAAgFeG02SETNmoSh7tMjIwxeueoDLnJH8vTX75SY8O66q0U0gCnXwQ
         FEd6Q8vL7nh9TyoFs5pwJkMTUoQz6qWeFbBX24dkQzv4ekMQAiEpQj7vBZMKG/57wLIU
         lIGxYwJrJP1pvBY/jYgizNsS3lctOrO52F2rOp38P88oul44S78MMVoK/nGZhuMNlCxW
         617A==
X-Gm-Message-State: AOAM530ngub9gx5Qb5V7HYIkR6tASjieG3/UdtxbnqGjoHTuWzlRFjKe
        Odd3Rc4nKbJaks1bpTx1mco++KYuBYsje+Mx7HkiCwJP/mUrVHlNCIqlZe9Akvs41iV14mZokmb
        53wBN0DNR/jkMkuiMY6/WwZQ=
X-Received: by 2002:a1c:494:: with SMTP id 142mr19456419wme.191.1640727053836;
        Tue, 28 Dec 2021 13:30:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwRr16cZDRN4qIsVfdtpfPWok+Nvwpi5LJtl2+6YvMIyuyZGUCRolJWNwBrYBP91MDRVqWpPg==
X-Received: by 2002:a1c:494:: with SMTP id 142mr19456395wme.191.1640727053498;
        Tue, 28 Dec 2021 13:30:53 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id s207sm19375411wme.2.2021.12.28.13.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Dec 2021 13:30:52 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        atomlin@atomlin.com, ghalat@redhat.com
Subject: [RFC PATCH 11/12] module: Move sysfs support into a separate file
Date:   Tue, 28 Dec 2021 21:30:40 +0000
Message-Id: <20211228213041.1356334-12-atomlin@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211228213041.1356334-1-atomlin@redhat.com>
References: <YbKUUJUtjBk/n913@bombadil.infradead.org>
 <20211228213041.1356334-1-atomlin@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change.

This patch migrates module sysfs support out of core code into
kernel/module/sysfs.c. In addition simple code refactoring to
make this possible.

Signed-off-by: Aaron Tomlin <atomlin@redhat.com>
---
 kernel/module/Makefile   |   1 +
 kernel/module/internal.h |  20 ++
 kernel/module/main.c     | 462 +--------------------------------------
 kernel/module/procfs.c   |   3 +
 kernel/module/sysfs.c    | 426 ++++++++++++++++++++++++++++++++++++
 5 files changed, 455 insertions(+), 457 deletions(-)
 create mode 100644 kernel/module/sysfs.c

diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index cba3e608b4ca..917910302ac0 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_STRICT_MODULE_RWX) += strict_rwx.o
 obj-$(CONFIG_DEBUG_KMEMLEAK) += debug_kmemleak.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
 obj-$(CONFIG_PROC_FS) += procfs.o
+obj-$(CONFIG_SYSFS) += sysfs.o
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index 119d42c304a1..4d81eb1f58ef 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -99,3 +99,23 @@ static inline char *find_kallsyms_symbol(struct module *mod, unsigned long addr,
 	return NULL;
 }
 #endif /* CONFIG_KALLSYMS */
+
+#ifdef CONFIG_SYSFS
+extern int mod_sysfs_setup(struct module *mod, const struct load_info *info, struct kernel_param *kparam, unsigned int num_params);
+extern void mod_sysfs_fini(struct module *mod);
+extern void module_remove_modinfo_attrs(struct module *mod, int end);
+extern void del_usage_links(struct module *mod);
+extern void init_param_lock(struct module *mod);
+#else /* !CONFIG_SYSFS */
+static int mod_sysfs_setup(struct module *mod,
+                          const struct load_info *info,
+                          struct kernel_param *kparam,
+                          unsigned int num_params)
+{
+       return 0;
+}
+static inline void mod_sysfs_fini(struct module *mod) { }
+static inline void module_remove_modinfo_attrs(struct module *mod, int end) { }
+static inline void del_usage_links(struct module *mod) { }
+static inline void init_param_lock(struct module *mod) { }
+#endif /* CONFIG_SYSFS */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 2da580c7b069..354fb2697188 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -13,9 +13,7 @@
 #include <linux/trace_events.h>
 #include <linux/init.h>
 #include <linux/kallsyms.h>
-#include <linux/file.h>
 #include <linux/fs.h>
-#include <linux/sysfs.h>
 #include <linux/kernel.h>
 #include <linux/kernel_read_file.h>
 #include <linux/slab.h>
@@ -801,7 +799,7 @@ SYSCALL_DEFINE2(delete_module, const char __user *, name_user,
 	return ret;
 }
 
-static inline void print_unload_info(struct seq_file *m, struct module *mod)
+inline void print_unload_info(struct seq_file *m, struct module *mod)
 {
 	struct module_use *use;
 	int printed_something = 0;
@@ -1017,7 +1015,7 @@ static ssize_t show_taint(struct module_attribute *mattr,
 static struct module_attribute modinfo_taint =
 	__ATTR(taint, 0444, show_taint, NULL);
 
-static struct module_attribute *modinfo_attrs[] = {
+struct module_attribute *modinfo_attrs[] = {
 	&module_uevent,
 	&modinfo_version,
 	&modinfo_srcversion,
@@ -1031,6 +1029,8 @@ static struct module_attribute *modinfo_attrs[] = {
 	NULL,
 };
 
+size_t modinfo_attrs_count = ARRAY_SIZE(modinfo_attrs);
+
 static const char vermagic[] = VERMAGIC_STRING;
 
 static int try_to_force_load(struct module *mod, const char *reason)
@@ -1281,458 +1281,6 @@ resolve_symbol_wait(struct module *mod,
 	return ksym;
 }
 
-/*
- * /sys/module/foo/sections stuff
- * J. Corbet <corbet@lwn.net>
- */
-#ifdef CONFIG_SYSFS
-
-#ifdef CONFIG_KALLSYMS
-struct module_sect_attr {
-	struct bin_attribute battr;
-	unsigned long address;
-};
-
-struct module_sect_attrs {
-	struct attribute_group grp;
-	unsigned int nsections;
-	struct module_sect_attr attrs[];
-};
-
-static ssize_t module_sect_read(struct file *file, struct kobject *kobj,
-				struct bin_attribute *battr,
-				char *buf, loff_t pos, size_t count)
-{
-	struct module_sect_attr *sattr =
-		container_of(battr, struct module_sect_attr, battr);
-	char bounce[MODULE_SECT_READ_SIZE + 1];
-	size_t wrote;
-
-	if (pos != 0)
-		return -EINVAL;
-
-	/*
-	 * Since we're a binary read handler, we must account for the
-	 * trailing NUL byte that sprintf will write: if "buf" is
-	 * too small to hold the NUL, or the NUL is exactly the last
-	 * byte, the read will look like it got truncated by one byte.
-	 * Since there is no way to ask sprintf nicely to not write
-	 * the NUL, we have to use a bounce buffer.
-	 */
-	wrote = scnprintf(bounce, sizeof(bounce), "0x%px\n",
-			 kallsyms_show_value(file->f_cred)
-				? (void *)sattr->address : NULL);
-	count = min(count, wrote);
-	memcpy(buf, bounce, count);
-
-	return count;
-}
-
-static void free_sect_attrs(struct module_sect_attrs *sect_attrs)
-{
-	unsigned int section;
-
-	for (section = 0; section < sect_attrs->nsections; section++)
-		kfree(sect_attrs->attrs[section].battr.attr.name);
-	kfree(sect_attrs);
-}
-
-static void add_sect_attrs(struct module *mod, const struct load_info *info)
-{
-	unsigned int nloaded = 0, i, size[2];
-	struct module_sect_attrs *sect_attrs;
-	struct module_sect_attr *sattr;
-	struct bin_attribute **gattr;
-
-	/* Count loaded sections and allocate structures */
-	for (i = 0; i < info->hdr->e_shnum; i++)
-		if (!sect_empty(&info->sechdrs[i]))
-			nloaded++;
-	size[0] = ALIGN(struct_size(sect_attrs, attrs, nloaded),
-			sizeof(sect_attrs->grp.bin_attrs[0]));
-	size[1] = (nloaded + 1) * sizeof(sect_attrs->grp.bin_attrs[0]);
-	sect_attrs = kzalloc(size[0] + size[1], GFP_KERNEL);
-	if (sect_attrs == NULL)
-		return;
-
-	/* Setup section attributes. */
-	sect_attrs->grp.name = "sections";
-	sect_attrs->grp.bin_attrs = (void *)sect_attrs + size[0];
-
-	sect_attrs->nsections = 0;
-	sattr = &sect_attrs->attrs[0];
-	gattr = &sect_attrs->grp.bin_attrs[0];
-	for (i = 0; i < info->hdr->e_shnum; i++) {
-		Elf_Shdr *sec = &info->sechdrs[i];
-		if (sect_empty(sec))
-			continue;
-		sysfs_bin_attr_init(&sattr->battr);
-		sattr->address = sec->sh_addr;
-		sattr->battr.attr.name =
-			kstrdup(info->secstrings + sec->sh_name, GFP_KERNEL);
-		if (sattr->battr.attr.name == NULL)
-			goto out;
-		sect_attrs->nsections++;
-		sattr->battr.read = module_sect_read;
-		sattr->battr.size = MODULE_SECT_READ_SIZE;
-		sattr->battr.attr.mode = 0400;
-		*(gattr++) = &(sattr++)->battr;
-	}
-	*gattr = NULL;
-
-	if (sysfs_create_group(&mod->mkobj.kobj, &sect_attrs->grp))
-		goto out;
-
-	mod->sect_attrs = sect_attrs;
-	return;
-  out:
-	free_sect_attrs(sect_attrs);
-}
-
-static void remove_sect_attrs(struct module *mod)
-{
-	if (mod->sect_attrs) {
-		sysfs_remove_group(&mod->mkobj.kobj,
-				   &mod->sect_attrs->grp);
-		/*
-		 * We are positive that no one is using any sect attrs
-		 * at this point.  Deallocate immediately.
-		 */
-		free_sect_attrs(mod->sect_attrs);
-		mod->sect_attrs = NULL;
-	}
-}
-
-/*
- * /sys/module/foo/notes/.section.name gives contents of SHT_NOTE sections.
- */
-
-struct module_notes_attrs {
-	struct kobject *dir;
-	unsigned int notes;
-	struct bin_attribute attrs[];
-};
-
-static ssize_t module_notes_read(struct file *filp, struct kobject *kobj,
-				 struct bin_attribute *bin_attr,
-				 char *buf, loff_t pos, size_t count)
-{
-	/*
-	 * The caller checked the pos and count against our size.
-	 */
-	memcpy(buf, bin_attr->private + pos, count);
-	return count;
-}
-
-static void free_notes_attrs(struct module_notes_attrs *notes_attrs,
-			     unsigned int i)
-{
-	if (notes_attrs->dir) {
-		while (i-- > 0)
-			sysfs_remove_bin_file(notes_attrs->dir,
-					      &notes_attrs->attrs[i]);
-		kobject_put(notes_attrs->dir);
-	}
-	kfree(notes_attrs);
-}
-
-static void add_notes_attrs(struct module *mod, const struct load_info *info)
-{
-	unsigned int notes, loaded, i;
-	struct module_notes_attrs *notes_attrs;
-	struct bin_attribute *nattr;
-
-	/* failed to create section attributes, so can't create notes */
-	if (!mod->sect_attrs)
-		return;
-
-	/* Count notes sections and allocate structures.  */
-	notes = 0;
-	for (i = 0; i < info->hdr->e_shnum; i++)
-		if (!sect_empty(&info->sechdrs[i]) &&
-		    (info->sechdrs[i].sh_type == SHT_NOTE))
-			++notes;
-
-	if (notes == 0)
-		return;
-
-	notes_attrs = kzalloc(struct_size(notes_attrs, attrs, notes),
-			      GFP_KERNEL);
-	if (notes_attrs == NULL)
-		return;
-
-	notes_attrs->notes = notes;
-	nattr = &notes_attrs->attrs[0];
-	for (loaded = i = 0; i < info->hdr->e_shnum; ++i) {
-		if (sect_empty(&info->sechdrs[i]))
-			continue;
-		if (info->sechdrs[i].sh_type == SHT_NOTE) {
-			sysfs_bin_attr_init(nattr);
-			nattr->attr.name = mod->sect_attrs->attrs[loaded].battr.attr.name;
-			nattr->attr.mode = S_IRUGO;
-			nattr->size = info->sechdrs[i].sh_size;
-			nattr->private = (void *) info->sechdrs[i].sh_addr;
-			nattr->read = module_notes_read;
-			++nattr;
-		}
-		++loaded;
-	}
-
-	notes_attrs->dir = kobject_create_and_add("notes", &mod->mkobj.kobj);
-	if (!notes_attrs->dir)
-		goto out;
-
-	for (i = 0; i < notes; ++i)
-		if (sysfs_create_bin_file(notes_attrs->dir,
-					  &notes_attrs->attrs[i]))
-			goto out;
-
-	mod->notes_attrs = notes_attrs;
-	return;
-
-  out:
-	free_notes_attrs(notes_attrs, i);
-}
-
-static void remove_notes_attrs(struct module *mod)
-{
-	if (mod->notes_attrs)
-		free_notes_attrs(mod->notes_attrs, mod->notes_attrs->notes);
-}
-
-#else
-
-static inline void add_sect_attrs(struct module *mod,
-				  const struct load_info *info)
-{
-}
-
-static inline void remove_sect_attrs(struct module *mod)
-{
-}
-
-static inline void add_notes_attrs(struct module *mod,
-				   const struct load_info *info)
-{
-}
-
-static inline void remove_notes_attrs(struct module *mod)
-{
-}
-#endif /* CONFIG_KALLSYMS */
-
-static void del_usage_links(struct module *mod)
-{
-#ifdef CONFIG_MODULE_UNLOAD
-	struct module_use *use;
-
-	mutex_lock(&module_mutex);
-	list_for_each_entry(use, &mod->target_list, target_list)
-		sysfs_remove_link(use->target->holders_dir, mod->name);
-	mutex_unlock(&module_mutex);
-#endif
-}
-
-static int add_usage_links(struct module *mod)
-{
-	int ret = 0;
-#ifdef CONFIG_MODULE_UNLOAD
-	struct module_use *use;
-
-	mutex_lock(&module_mutex);
-	list_for_each_entry(use, &mod->target_list, target_list) {
-		ret = sysfs_create_link(use->target->holders_dir,
-					&mod->mkobj.kobj, mod->name);
-		if (ret)
-			break;
-	}
-	mutex_unlock(&module_mutex);
-	if (ret)
-		del_usage_links(mod);
-#endif
-	return ret;
-}
-
-static void module_remove_modinfo_attrs(struct module *mod, int end);
-
-static int module_add_modinfo_attrs(struct module *mod)
-{
-	struct module_attribute *attr;
-	struct module_attribute *temp_attr;
-	int error = 0;
-	int i;
-
-	mod->modinfo_attrs = kzalloc((sizeof(struct module_attribute) *
-					(ARRAY_SIZE(modinfo_attrs) + 1)),
-					GFP_KERNEL);
-	if (!mod->modinfo_attrs)
-		return -ENOMEM;
-
-	temp_attr = mod->modinfo_attrs;
-	for (i = 0; (attr = modinfo_attrs[i]); i++) {
-		if (!attr->test || attr->test(mod)) {
-			memcpy(temp_attr, attr, sizeof(*temp_attr));
-			sysfs_attr_init(&temp_attr->attr);
-			error = sysfs_create_file(&mod->mkobj.kobj,
-					&temp_attr->attr);
-			if (error)
-				goto error_out;
-			++temp_attr;
-		}
-	}
-
-	return 0;
-
-error_out:
-	if (i > 0)
-		module_remove_modinfo_attrs(mod, --i);
-	else
-		kfree(mod->modinfo_attrs);
-	return error;
-}
-
-static void module_remove_modinfo_attrs(struct module *mod, int end)
-{
-	struct module_attribute *attr;
-	int i;
-
-	for (i = 0; (attr = &mod->modinfo_attrs[i]); i++) {
-		if (end >= 0 && i > end)
-			break;
-		/* pick a field to test for end of list */
-		if (!attr->attr.name)
-			break;
-		sysfs_remove_file(&mod->mkobj.kobj, &attr->attr);
-		if (attr->free)
-			attr->free(mod);
-	}
-	kfree(mod->modinfo_attrs);
-}
-
-static void mod_kobject_put(struct module *mod)
-{
-	DECLARE_COMPLETION_ONSTACK(c);
-	mod->mkobj.kobj_completion = &c;
-	kobject_put(&mod->mkobj.kobj);
-	wait_for_completion(&c);
-}
-
-static int mod_sysfs_init(struct module *mod)
-{
-	int err;
-	struct kobject *kobj;
-
-	if (!module_sysfs_initialized) {
-		pr_err("%s: module sysfs not initialized\n", mod->name);
-		err = -EINVAL;
-		goto out;
-	}
-
-	kobj = kset_find_obj(module_kset, mod->name);
-	if (kobj) {
-		pr_err("%s: module is already loaded\n", mod->name);
-		kobject_put(kobj);
-		err = -EINVAL;
-		goto out;
-	}
-
-	mod->mkobj.mod = mod;
-
-	memset(&mod->mkobj.kobj, 0, sizeof(mod->mkobj.kobj));
-	mod->mkobj.kobj.kset = module_kset;
-	err = kobject_init_and_add(&mod->mkobj.kobj, &module_ktype, NULL,
-				   "%s", mod->name);
-	if (err)
-		mod_kobject_put(mod);
-
-out:
-	return err;
-}
-
-static int mod_sysfs_setup(struct module *mod,
-			   const struct load_info *info,
-			   struct kernel_param *kparam,
-			   unsigned int num_params)
-{
-	int err;
-
-	err = mod_sysfs_init(mod);
-	if (err)
-		goto out;
-
-	mod->holders_dir = kobject_create_and_add("holders", &mod->mkobj.kobj);
-	if (!mod->holders_dir) {
-		err = -ENOMEM;
-		goto out_unreg;
-	}
-
-	err = module_param_sysfs_setup(mod, kparam, num_params);
-	if (err)
-		goto out_unreg_holders;
-
-	err = module_add_modinfo_attrs(mod);
-	if (err)
-		goto out_unreg_param;
-
-	err = add_usage_links(mod);
-	if (err)
-		goto out_unreg_modinfo_attrs;
-
-	add_sect_attrs(mod, info);
-	add_notes_attrs(mod, info);
-
-	return 0;
-
-out_unreg_modinfo_attrs:
-	module_remove_modinfo_attrs(mod, -1);
-out_unreg_param:
-	module_param_sysfs_remove(mod);
-out_unreg_holders:
-	kobject_put(mod->holders_dir);
-out_unreg:
-	mod_kobject_put(mod);
-out:
-	return err;
-}
-
-static void mod_sysfs_fini(struct module *mod)
-{
-	remove_notes_attrs(mod);
-	remove_sect_attrs(mod);
-	mod_kobject_put(mod);
-}
-
-static void init_param_lock(struct module *mod)
-{
-	mutex_init(&mod->param_lock);
-}
-#else /* !CONFIG_SYSFS */
-
-static int mod_sysfs_setup(struct module *mod,
-			   const struct load_info *info,
-			   struct kernel_param *kparam,
-			   unsigned int num_params)
-{
-	return 0;
-}
-
-static void mod_sysfs_fini(struct module *mod)
-{
-}
-
-static void module_remove_modinfo_attrs(struct module *mod, int end)
-{
-}
-
-static void del_usage_links(struct module *mod)
-{
-}
-
-static void init_param_lock(struct module *mod)
-{
-}
-#endif /* CONFIG_SYSFS */
-
 static void mod_sysfs_teardown(struct module *mod)
 {
 	del_usage_links(mod);
@@ -3505,7 +3053,7 @@ static void cfi_cleanup(struct module *mod)
 }
 
 /* Keep in sync with MODULE_FLAGS_BUF_SIZE !!! */
-static char *module_flags(struct module *mod, char *buf)
+char *module_flags(struct module *mod, char *buf)
 {
 	int bx = 0;
 
diff --git a/kernel/module/procfs.c b/kernel/module/procfs.c
index 98d898250475..365d5e52ac23 100644
--- a/kernel/module/procfs.c
+++ b/kernel/module/procfs.c
@@ -12,6 +12,9 @@
 #include <linux/proc_fs.h>
 #include "internal.h"
 
+extern void print_unload_info(struct seq_file *m, struct module *mod);
+extern char *module_flags(struct module *mod, char *buf);
+
 /* Called by the /proc file system to return a list of modules. */
 static void *m_start(struct seq_file *m, loff_t *pos)
 {
diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
new file mode 100644
index 000000000000..1cd91c214b72
--- /dev/null
+++ b/kernel/module/sysfs.c
@@ -0,0 +1,426 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * kernel/module/sysfs.c - module sysfs support
+ *
+ * Copyright (C) 2008 Rusty Russell
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/fs.h>
+#include <linux/sysfs.h>
+#include <linux/slab.h>
+#include <linux/kallsyms.h>
+#include <linux/mutex.h>
+#include "internal.h"
+
+/*
+ * /sys/module/foo/sections stuff
+ * J. Corbet <corbet@lwn.net>
+ */
+#ifdef CONFIG_KALLSYMS
+struct module_sect_attr {
+	struct bin_attribute battr;
+	unsigned long address;
+};
+
+struct module_sect_attrs {
+	struct attribute_group grp;
+	unsigned int nsections;
+	struct module_sect_attr attrs[];
+};
+
+static ssize_t module_sect_read(struct file *file, struct kobject *kobj,
+				struct bin_attribute *battr,
+				char *buf, loff_t pos, size_t count)
+{
+	struct module_sect_attr *sattr =
+		container_of(battr, struct module_sect_attr, battr);
+	char bounce[MODULE_SECT_READ_SIZE + 1];
+	size_t wrote;
+
+	if (pos != 0)
+		return -EINVAL;
+
+	/*
+	 * Since we're a binary read handler, we must account for the
+	 * trailing NUL byte that sprintf will write: if "buf" is
+	 * too small to hold the NUL, or the NUL is exactly the last
+	 * byte, the read will look like it got truncated by one byte.
+	 * Since there is no way to ask sprintf nicely to not write
+	 * the NUL, we have to use a bounce buffer.
+	 */
+	wrote = scnprintf(bounce, sizeof(bounce), "0x%px\n",
+			 kallsyms_show_value(file->f_cred)
+				? (void *)sattr->address : NULL);
+	count = min(count, wrote);
+	memcpy(buf, bounce, count);
+
+	return count;
+}
+
+static void free_sect_attrs(struct module_sect_attrs *sect_attrs)
+{
+	unsigned int section;
+
+	for (section = 0; section < sect_attrs->nsections; section++)
+		kfree(sect_attrs->attrs[section].battr.attr.name);
+	kfree(sect_attrs);
+}
+
+static void add_sect_attrs(struct module *mod, const struct load_info *info)
+{
+	unsigned int nloaded = 0, i, size[2];
+	struct module_sect_attrs *sect_attrs;
+	struct module_sect_attr *sattr;
+	struct bin_attribute **gattr;
+
+	/* Count loaded sections and allocate structures */
+	for (i = 0; i < info->hdr->e_shnum; i++)
+		if (!sect_empty(&info->sechdrs[i]))
+			nloaded++;
+	size[0] = ALIGN(struct_size(sect_attrs, attrs, nloaded),
+			sizeof(sect_attrs->grp.bin_attrs[0]));
+	size[1] = (nloaded + 1) * sizeof(sect_attrs->grp.bin_attrs[0]);
+	sect_attrs = kzalloc(size[0] + size[1], GFP_KERNEL);
+	if (sect_attrs == NULL)
+		return;
+
+	/* Setup section attributes. */
+	sect_attrs->grp.name = "sections";
+	sect_attrs->grp.bin_attrs = (void *)sect_attrs + size[0];
+
+	sect_attrs->nsections = 0;
+	sattr = &sect_attrs->attrs[0];
+	gattr = &sect_attrs->grp.bin_attrs[0];
+	for (i = 0; i < info->hdr->e_shnum; i++) {
+		Elf_Shdr *sec = &info->sechdrs[i];
+		if (sect_empty(sec))
+			continue;
+		sysfs_bin_attr_init(&sattr->battr);
+		sattr->address = sec->sh_addr;
+		sattr->battr.attr.name =
+			kstrdup(info->secstrings + sec->sh_name, GFP_KERNEL);
+		if (sattr->battr.attr.name == NULL)
+			goto out;
+		sect_attrs->nsections++;
+		sattr->battr.read = module_sect_read;
+		sattr->battr.size = MODULE_SECT_READ_SIZE;
+		sattr->battr.attr.mode = 0400;
+		*(gattr++) = &(sattr++)->battr;
+	}
+	*gattr = NULL;
+
+	if (sysfs_create_group(&mod->mkobj.kobj, &sect_attrs->grp))
+		goto out;
+
+	mod->sect_attrs = sect_attrs;
+	return;
+  out:
+	free_sect_attrs(sect_attrs);
+}
+
+static void remove_sect_attrs(struct module *mod)
+{
+	if (mod->sect_attrs) {
+		sysfs_remove_group(&mod->mkobj.kobj,
+				   &mod->sect_attrs->grp);
+		/*
+		 * We are positive that no one is using any sect attrs
+		 * at this point.  Deallocate immediately.
+		 */
+		free_sect_attrs(mod->sect_attrs);
+		mod->sect_attrs = NULL;
+	}
+}
+
+/*
+ * /sys/module/foo/notes/.section.name gives contents of SHT_NOTE sections.
+ */
+
+struct module_notes_attrs {
+	struct kobject *dir;
+	unsigned int notes;
+	struct bin_attribute attrs[];
+};
+
+static ssize_t module_notes_read(struct file *filp, struct kobject *kobj,
+				 struct bin_attribute *bin_attr,
+				 char *buf, loff_t pos, size_t count)
+{
+	/*
+	 * The caller checked the pos and count against our size.
+	 */
+	memcpy(buf, bin_attr->private + pos, count);
+	return count;
+}
+
+static void free_notes_attrs(struct module_notes_attrs *notes_attrs,
+			     unsigned int i)
+{
+	if (notes_attrs->dir) {
+		while (i-- > 0)
+			sysfs_remove_bin_file(notes_attrs->dir,
+					      &notes_attrs->attrs[i]);
+		kobject_put(notes_attrs->dir);
+	}
+	kfree(notes_attrs);
+}
+
+static void add_notes_attrs(struct module *mod, const struct load_info *info)
+{
+	unsigned int notes, loaded, i;
+	struct module_notes_attrs *notes_attrs;
+	struct bin_attribute *nattr;
+
+	/* failed to create section attributes, so can't create notes */
+	if (!mod->sect_attrs)
+		return;
+
+	/* Count notes sections and allocate structures.  */
+	notes = 0;
+	for (i = 0; i < info->hdr->e_shnum; i++)
+		if (!sect_empty(&info->sechdrs[i]) &&
+		    (info->sechdrs[i].sh_type == SHT_NOTE))
+			++notes;
+
+	if (notes == 0)
+		return;
+
+	notes_attrs = kzalloc(struct_size(notes_attrs, attrs, notes),
+			      GFP_KERNEL);
+	if (notes_attrs == NULL)
+		return;
+
+	notes_attrs->notes = notes;
+	nattr = &notes_attrs->attrs[0];
+	for (loaded = i = 0; i < info->hdr->e_shnum; ++i) {
+		if (sect_empty(&info->sechdrs[i]))
+			continue;
+		if (info->sechdrs[i].sh_type == SHT_NOTE) {
+			sysfs_bin_attr_init(nattr);
+			nattr->attr.name = mod->sect_attrs->attrs[loaded].battr.attr.name;
+			nattr->attr.mode = S_IRUGO;
+			nattr->size = info->sechdrs[i].sh_size;
+			nattr->private = (void *) info->sechdrs[i].sh_addr;
+			nattr->read = module_notes_read;
+			++nattr;
+		}
+		++loaded;
+	}
+
+	notes_attrs->dir = kobject_create_and_add("notes", &mod->mkobj.kobj);
+	if (!notes_attrs->dir)
+		goto out;
+
+	for (i = 0; i < notes; ++i)
+		if (sysfs_create_bin_file(notes_attrs->dir,
+					  &notes_attrs->attrs[i]))
+			goto out;
+
+	mod->notes_attrs = notes_attrs;
+	return;
+
+  out:
+	free_notes_attrs(notes_attrs, i);
+}
+
+static void remove_notes_attrs(struct module *mod)
+{
+	if (mod->notes_attrs)
+		free_notes_attrs(mod->notes_attrs, mod->notes_attrs->notes);
+}
+
+#else /* !CONFIG_KALLSYMS */
+static inline void add_sect_attrs(struct module *mod, const struct load_info *info) { }
+static inline void remove_sect_attrs(struct module *mod) { }
+static inline void add_notes_attrs(struct module *mod, const struct load_info *info) { }
+static inline void remove_notes_attrs(struct module *mod) { }
+#endif /* CONFIG_KALLSYMS */
+
+void del_usage_links(struct module *mod)
+{
+#ifdef CONFIG_MODULE_UNLOAD
+	struct module_use *use;
+
+	mutex_lock(&module_mutex);
+	list_for_each_entry(use, &mod->target_list, target_list)
+		sysfs_remove_link(use->target->holders_dir, mod->name);
+	mutex_unlock(&module_mutex);
+#endif
+}
+
+static int add_usage_links(struct module *mod)
+{
+	int ret = 0;
+#ifdef CONFIG_MODULE_UNLOAD
+	struct module_use *use;
+
+	mutex_lock(&module_mutex);
+	list_for_each_entry(use, &mod->target_list, target_list) {
+		ret = sysfs_create_link(use->target->holders_dir,
+					&mod->mkobj.kobj, mod->name);
+		if (ret)
+			break;
+	}
+	mutex_unlock(&module_mutex);
+	if (ret)
+		del_usage_links(mod);
+#endif
+	return ret;
+}
+
+extern struct module_attribute *modinfo_attrs[];
+extern size_t modinfo_attrs_count;
+
+static int module_add_modinfo_attrs(struct module *mod)
+{
+	struct module_attribute *attr;
+	struct module_attribute *temp_attr;
+	int error = 0;
+	int i;
+
+	mod->modinfo_attrs = kzalloc((sizeof(struct module_attribute) *
+					(modinfo_attrs_count + 1)),
+					GFP_KERNEL);
+	if (!mod->modinfo_attrs)
+		return -ENOMEM;
+
+	temp_attr = mod->modinfo_attrs;
+	for (i = 0; (attr = modinfo_attrs[i]); i++) {
+		if (!attr->test || attr->test(mod)) {
+			memcpy(temp_attr, attr, sizeof(*temp_attr));
+			sysfs_attr_init(&temp_attr->attr);
+			error = sysfs_create_file(&mod->mkobj.kobj,
+					&temp_attr->attr);
+			if (error)
+				goto error_out;
+			++temp_attr;
+		}
+	}
+
+	return 0;
+
+error_out:
+	if (i > 0)
+		module_remove_modinfo_attrs(mod, --i);
+	else
+		kfree(mod->modinfo_attrs);
+	return error;
+}
+
+void module_remove_modinfo_attrs(struct module *mod, int end)
+{
+	struct module_attribute *attr;
+	int i;
+
+	for (i = 0; (attr = &mod->modinfo_attrs[i]); i++) {
+		if (end >= 0 && i > end)
+			break;
+		/* pick a field to test for end of list */
+		if (!attr->attr.name)
+			break;
+		sysfs_remove_file(&mod->mkobj.kobj, &attr->attr);
+		if (attr->free)
+			attr->free(mod);
+	}
+	kfree(mod->modinfo_attrs);
+}
+
+static void mod_kobject_put(struct module *mod)
+{
+	DECLARE_COMPLETION_ONSTACK(c);
+	mod->mkobj.kobj_completion = &c;
+	kobject_put(&mod->mkobj.kobj);
+	wait_for_completion(&c);
+}
+
+static int mod_sysfs_init(struct module *mod)
+{
+	int err;
+	struct kobject *kobj;
+
+	if (!module_sysfs_initialized) {
+		pr_err("%s: module sysfs not initialized\n", mod->name);
+		err = -EINVAL;
+		goto out;
+	}
+
+	kobj = kset_find_obj(module_kset, mod->name);
+	if (kobj) {
+		pr_err("%s: module is already loaded\n", mod->name);
+		kobject_put(kobj);
+		err = -EINVAL;
+		goto out;
+	}
+
+	mod->mkobj.mod = mod;
+
+	memset(&mod->mkobj.kobj, 0, sizeof(mod->mkobj.kobj));
+	mod->mkobj.kobj.kset = module_kset;
+	err = kobject_init_and_add(&mod->mkobj.kobj, &module_ktype, NULL,
+				   "%s", mod->name);
+	if (err)
+		mod_kobject_put(mod);
+
+out:
+	return err;
+}
+
+int mod_sysfs_setup(struct module *mod,
+			   const struct load_info *info,
+			   struct kernel_param *kparam,
+			   unsigned int num_params)
+{
+	int err;
+
+	err = mod_sysfs_init(mod);
+	if (err)
+		goto out;
+
+	mod->holders_dir = kobject_create_and_add("holders", &mod->mkobj.kobj);
+	if (!mod->holders_dir) {
+		err = -ENOMEM;
+		goto out_unreg;
+	}
+
+	err = module_param_sysfs_setup(mod, kparam, num_params);
+	if (err)
+		goto out_unreg_holders;
+
+	err = module_add_modinfo_attrs(mod);
+	if (err)
+		goto out_unreg_param;
+
+	err = add_usage_links(mod);
+	if (err)
+		goto out_unreg_modinfo_attrs;
+
+	add_sect_attrs(mod, info);
+	add_notes_attrs(mod, info);
+
+	return 0;
+
+out_unreg_modinfo_attrs:
+	module_remove_modinfo_attrs(mod, -1);
+out_unreg_param:
+	module_param_sysfs_remove(mod);
+out_unreg_holders:
+	kobject_put(mod->holders_dir);
+out_unreg:
+	mod_kobject_put(mod);
+out:
+	return err;
+}
+
+void mod_sysfs_fini(struct module *mod)
+{
+	remove_notes_attrs(mod);
+	remove_sect_attrs(mod);
+	mod_kobject_put(mod);
+}
+
+void init_param_lock(struct module *mod)
+{
+	mutex_init(&mod->param_lock);
+}
-- 
2.31.1

