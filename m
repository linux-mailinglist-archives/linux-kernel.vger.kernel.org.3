Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF2B4BC203
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 22:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239871AbiBRV2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 16:28:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239819AbiBRV2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 16:28:22 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 86C4A21B2
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 13:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645219681;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2eTsWCqXXycb20dSK+w8lhKLdsUdR2Yi7FwWnRgx6P4=;
        b=CBifOSTIT1TBjngm3/OMC7FKghyyJGyv/4QbrBvNvHAype3wm1tAjAVFhYEdzTseRsUSqo
        zkRDv0V1q+qCw8GTNlojZG7qB0itb2LZzcxLbkg+x1DfWskOVD2E5/GcwBQrX6tlmiKxWJ
        FaijrjcYGUJ23Hw6sSPFz0x+yVXQBQE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-253-hYTIOIoKNv29kR_NdE92Fg-1; Fri, 18 Feb 2022 16:28:00 -0500
X-MC-Unique: hYTIOIoKNv29kR_NdE92Fg-1
Received: by mail-wm1-f72.google.com with SMTP id v130-20020a1cac88000000b0037e3d70e7e1so3710977wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 13:28:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :mime-version:content-transfer-encoding;
        bh=2eTsWCqXXycb20dSK+w8lhKLdsUdR2Yi7FwWnRgx6P4=;
        b=lptZdxas8KwrNNJYVyU3knLrjYVo+5jLX6pB0w3eahVgt6pX4L/SDadXB78tx5mH1V
         ZQQ8quLrHU41+cIjzd2zM2LY4BSTuXPsZnVHXRFCwgu3c+l3Mx9ecP1Sj2gxfvQmxquk
         DYWvv4w1h2cShHU5SJE3dpgo3AJBa7H7HIitsnf0K6bwTD9jweuvh0r5SzHumCF1OESp
         sGPmG/W+o+WwJBKJQZK057r41FOYeMWsgluoJwppJxdk8vltzkFk8s5nuQRdGdLx4N4D
         oI5ba7bm9yM7AkFUkJ1V0NtKMEfnTYrx4M/1ZiywIeK9OJrk7HHVxTN9jP7RyMt80eO7
         kKnQ==
X-Gm-Message-State: AOAM530EOxDiHHeDYLFEHxItJTAfSfUVcfDy3VZb9dT98+FY3wuCW5+g
        ySc1/weGak3hoKeWyx+sMYKXQeRzVIV/9HFDPsnkcy3iSZ3UEDCSVp/k1AhCP6SzyB47Kr1OHRK
        IkyIm8D2PQxWWpUX57N46n0k=
X-Received: by 2002:a05:600c:3acb:b0:37b:db39:f3b1 with SMTP id d11-20020a05600c3acb00b0037bdb39f3b1mr8635457wms.175.1645219678751;
        Fri, 18 Feb 2022 13:27:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzRvvnJQhAw3RYBTsKYoznBImsAJOxiQwAFeFDECnVNAEfibUCeXHOWw3OW1ybn/8Lhz0g7Bw==
X-Received: by 2002:a05:600c:3acb:b0:37b:db39:f3b1 with SMTP id d11-20020a05600c3acb00b0037bdb39f3b1mr8635428wms.175.1645219678393;
        Fri, 18 Feb 2022 13:27:58 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id x17sm33385085wrv.107.2022.02.18.13.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 13:27:58 -0800 (PST)
From:   Aaron Tomlin <atomlin@redhat.com>
To:     mcgrof@kernel.org
Cc:     cl@linux.com, pmladek@suse.com, mbenes@suse.cz,
        akpm@linux-foundation.org, jeyu@kernel.org,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org,
        live-patching@vger.kernel.org, atomlin@atomlin.com,
        ghalat@redhat.com, allen.lkml@gmail.com, joe@perches.com,
        christophe.leroy@csgroup.eu, msuchanek@suse.de,
        oleksandr@natalenko.name
Subject: [PATCH v6 11/13] module: Move sysfs support into a separate file
Date:   Fri, 18 Feb 2022 21:27:55 +0000
Message-Id: <20220218212757.888751-1-atomlin@redhat.com>
X-Mailer: git-send-email 2.34.1
Reply-To: 20220218212511.887059-11-atomlin@redhat.com
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
 kernel/module/internal.h |  21 ++
 kernel/module/main.c     | 469 +--------------------------------------
 kernel/module/sysfs.c    | 436 ++++++++++++++++++++++++++++++++++++
 4 files changed, 461 insertions(+), 466 deletions(-)
 create mode 100644 kernel/module/sysfs.c

diff --git a/kernel/module/Makefile b/kernel/module/Makefile
index f66fda0b41cc..a3cbe09ce2b2 100644
--- a/kernel/module/Makefile
+++ b/kernel/module/Makefile
@@ -14,4 +14,5 @@ obj-$(CONFIG_STRICT_MODULE_RWX) += strict_rwx.o
 obj-$(CONFIG_DEBUG_KMEMLEAK) += debug_kmemleak.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
 obj-$(CONFIG_PROC_FS) += procfs.o
+obj-$(CONFIG_SYSFS) += sysfs.o
 endif
diff --git a/kernel/module/internal.h b/kernel/module/internal.h
index ddb37024a0d6..74096cca742c 100644
--- a/kernel/module/internal.h
+++ b/kernel/module/internal.h
@@ -34,6 +34,9 @@
 extern struct mutex module_mutex;
 extern struct list_head modules;
 
+extern struct module_attribute *modinfo_attrs[];
+extern size_t modinfo_attrs_count;
+
 /* Provided by the linker */
 extern const struct kernel_symbol __start___ksymtab[];
 extern const struct kernel_symbol __stop___ksymtab[];
@@ -213,3 +216,21 @@ static inline bool sect_empty(const Elf_Shdr *sect)
 static inline void layout_symtab(struct module *mod, struct load_info *info) { }
 static inline void add_kallsyms(struct module *mod, const struct load_info *info) { }
 #endif /* CONFIG_KALLSYMS */
+
+#ifdef CONFIG_SYSFS
+int mod_sysfs_setup(struct module *mod, const struct load_info *info,
+		    struct kernel_param *kparam, unsigned int num_params);
+void mod_sysfs_teardown(struct module *mod);
+void init_param_lock(struct module *mod);
+#else /* !CONFIG_SYSFS */
+static inline int mod_sysfs_setup(struct module *mod,
+			   	  const struct load_info *info,
+			   	  struct kernel_param *kparam,
+			   	  unsigned int num_params)
+{
+	return 0;
+}
+
+static inline void mod_sysfs_teardown(struct module *mod) { }
+static inline void init_param_lock(struct module *mod) { }
+#endif /* CONFIG_SYSFS */
diff --git a/kernel/module/main.c b/kernel/module/main.c
index 44b6fd1acc44..b8a59b5c3e3a 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -14,9 +14,7 @@
 #include <linux/init.h>
 #include <linux/kallsyms.h>
 #include <linux/buildid.h>
-#include <linux/file.h>
 #include <linux/fs.h>
-#include <linux/sysfs.h>
 #include <linux/kernel.h>
 #include <linux/kernel_read_file.h>
 #include <linux/slab.h>
@@ -989,7 +987,7 @@ static ssize_t show_taint(struct module_attribute *mattr,
 static struct module_attribute modinfo_taint =
 	__ATTR(taint, 0444, show_taint, NULL);
 
-static struct module_attribute *modinfo_attrs[] = {
+struct module_attribute *modinfo_attrs[] = {
 	&module_uevent,
 	&modinfo_version,
 	&modinfo_srcversion,
@@ -1003,6 +1001,8 @@ static struct module_attribute *modinfo_attrs[] = {
 	NULL,
 };
 
+size_t modinfo_attrs_count = ARRAY_SIZE(modinfo_attrs);
+
 static const char vermagic[] = VERMAGIC_STRING;
 
 static int try_to_force_load(struct module *mod, const char *reason)
@@ -1253,469 +1253,6 @@ resolve_symbol_wait(struct module *mod,
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
-#define MODULE_SECT_READ_SIZE (3 /* "0x", "\n" */ + (BITS_PER_LONG / 4))
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
-static void mod_sysfs_teardown(struct module *mod)
-{
-	del_usage_links(mod);
-	module_remove_modinfo_attrs(mod, -1);
-	module_param_sysfs_remove(mod);
-	kobject_put(mod->mkobj.drivers_dir);
-	kobject_put(mod->holders_dir);
-	mod_sysfs_fini(mod);
-}
-
 /*
  * LKM RO/NX protection: protect module's text/ro-data
  * from modification and any data from execution.
diff --git a/kernel/module/sysfs.c b/kernel/module/sysfs.c
new file mode 100644
index 000000000000..ce68f821dcd1
--- /dev/null
+++ b/kernel/module/sysfs.c
@@ -0,0 +1,436 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Module sysfs support
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
+#define MODULE_SECT_READ_SIZE (3 /* "0x", "\n" */ + (BITS_PER_LONG / 4))
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
+			  kallsyms_show_value(file->f_cred)
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
+	if (!sect_attrs)
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
+
+		if (sect_empty(sec))
+			continue;
+		sysfs_bin_attr_init(&sattr->battr);
+		sattr->address = sec->sh_addr;
+		sattr->battr.attr.name =
+			kstrdup(info->secstrings + sec->sh_name, GFP_KERNEL);
+		if (!sattr->battr.attr.name)
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
+out:
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
+		    info->sechdrs[i].sh_type == SHT_NOTE)
+			++notes;
+
+	if (notes == 0)
+		return;
+
+	notes_attrs = kzalloc(struct_size(notes_attrs, attrs, notes),
+			      GFP_KERNEL);
+	if (!notes_attrs)
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
+			nattr->attr.mode = 0444;
+			nattr->size = info->sechdrs[i].sh_size;
+			nattr->private = (void *)info->sechdrs[i].sh_addr;
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
+out:
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
+static void del_usage_links(struct module *mod)
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
+static void module_remove_modinfo_attrs(struct module *mod, int end)
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
+						  &temp_attr->attr);
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
+static void mod_kobject_put(struct module *mod)
+{
+	DECLARE_COMPLETION_ONSTACK(c);
+
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
+		    const struct load_info *info,
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
+static void mod_sysfs_fini(struct module *mod)
+{
+	remove_notes_attrs(mod);
+	remove_sect_attrs(mod);
+	mod_kobject_put(mod);
+}
+
+void mod_sysfs_teardown(struct module *mod)
+{
+	del_usage_links(mod);
+	module_remove_modinfo_attrs(mod, -1);
+	module_param_sysfs_remove(mod);
+	kobject_put(mod->mkobj.drivers_dir);
+	kobject_put(mod->holders_dir);
+	mod_sysfs_fini(mod);
+}
+
+void init_param_lock(struct module *mod)
+{
+	mutex_init(&mod->param_lock);
+}
-- 
2.34.1

