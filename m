Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D351E483BAF
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 06:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiADF2g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 00:28:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiADF2c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 00:28:32 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0775CC061761
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 21:28:32 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id f5so2419126pgk.12
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 21:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=EDvTRTZficrEvYXb990KdPV71mi4pEL5f0L1+5FSBd8=;
        b=AEYpEkUXiFgLmQ09uigSzbXm70+4yjsOLk6UFZny4DSKQDGicFbipKwPztfmNc0UzK
         rubmEgM9DKd0QtusncIDXEpbxQ2GrMPzrvsyPaH2ejGkmwtry5+1jfHCjzaSoq/CLPVI
         fjJ6mOtlr161pqcwzt0grZIa56DMYDIpPZb30ZRDSCSei/Vh/gGxQX6rsBdkzUjSLQDM
         TFzk8Y20bZUM2yzY4JbtwHP20GXEPq0OrCA1s2AvM2pncaS1CEup/d0700VodeIxtooU
         9Nu0jBwBOXmg3Og7Ihz/Yfq0wD21jsxP+ERkV6nQZeXLTRA8wZ/JXyT1FbuhruexUiq1
         nsxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=EDvTRTZficrEvYXb990KdPV71mi4pEL5f0L1+5FSBd8=;
        b=aVZ/+qL+mjmm7lNG+fp7V9Qf5wZVlxqc+Ox72j03phIGhonHBVRjbRpVbXTzJo0lrZ
         plQamvILtQSjhBQl2s49Mp1DwdZXKgLYTR3XQb43Mw4eYUanIWnby5V6/MtepoN6Sdef
         wKgZIynkwUCTpaGJot+OZnhLt+YtKcH8Mvr7OrAZV2JKlKFwAFcUZshRmhFnh2eTXaOl
         baLpqda8/0CXlaa7byhQafeBlhiBXrKMeLftwe+hWEBJ8bXeIYWbh3JhORyAnJ5PiNe1
         /KWG91FmiBNqhy0R7NuR1IhhdNtyub47AsXTK35fojld92rcp3Z+VgAaQG3Lc1tpI9L3
         DR0g==
X-Gm-Message-State: AOAM531IAIMzc+2PlAf04kXpU2XcAzrb3R4KiIa05mmhBe2sLcc0XJHk
        5jHJ2njBA06oGSI6gWrovSCa7ccyLFM=
X-Google-Smtp-Source: ABdhPJzqj/jVlGRhgVBIAV772k+wWHNYpraSbbvctBbtRXcJ9ynB0iSCngCx0ZUaiqcn75dWaZlwyQ==
X-Received: by 2002:a62:e907:0:b0:4a0:3a71:9712 with SMTP id j7-20020a62e907000000b004a03a719712mr49958959pfh.73.1641274111255;
        Mon, 03 Jan 2022 21:28:31 -0800 (PST)
Received: from google.com ([2620:15c:202:201:a7d6:43d7:bbe3:3573])
        by smtp.gmail.com with ESMTPSA id y126sm38855844pfy.40.2022.01.03.21.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 21:28:30 -0800 (PST)
Date:   Mon, 3 Jan 2022 21:28:27 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v4] module: add in-kernel support for decompressing
Message-ID: <YdPa+w0xYkXXEE9s@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Current scheme of having userspace decompress kernel modules before
loading them into the kernel runs afoul of LoadPin security policy, as
it loses link between the source of kernel module on the disk and binary
blob that is being loaded into the kernel. To solve this issue let's
implement decompression in kernel, so that we can pass a file descriptor
of compressed module file into finit_module() which will keep LoadPin
happy.

To let userspace know what compression/decompression scheme kernel
supports it will create /sys/module/compression attribute. kmod can read
this attribute and decide if it can pass compressed file to
finit_module(). New MODULE_INIT_COMPRESSED_DATA flag indicates that the
kernel should attempt to decompress the data read from file descriptor
prior to trying load the module.

To simplify things kernel will only implement single decompression
method matching compression method selected when generating modules.
This patch implements gzip and xz; more can be added later,

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v4:
 - use late_initcall() instead of module_init() for setting up
	'compression' sysfs attribute per Luis' request

v3:
 - fix missing Kconfig dependency

v2:
 - changed flag MODULE_INIT_COMPRESSED_DATA ->
	MODULE_INIT_COMPRESSED_FLAG per Kees' request

 include/uapi/linux/module.h |   1 +
 init/Kconfig                |  13 ++
 kernel/Makefile             |   1 +
 kernel/module-internal.h    |  18 +++
 kernel/module.c             |  35 +++--
 kernel/module_decompress.c  | 271 ++++++++++++++++++++++++++++++++++++
 6 files changed, 328 insertions(+), 11 deletions(-)

diff --git a/include/uapi/linux/module.h b/include/uapi/linux/module.h
index 50d98ec5e866..03a33ffffcba 100644
--- a/include/uapi/linux/module.h
+++ b/include/uapi/linux/module.h
@@ -5,5 +5,6 @@
 /* Flags for sys_finit_module: */
 #define MODULE_INIT_IGNORE_MODVERSIONS	1
 #define MODULE_INIT_IGNORE_VERMAGIC	2
+#define MODULE_INIT_COMPRESSED_FILE	4
 
 #endif /* _UAPI_LINUX_MODULE_H */
diff --git a/init/Kconfig b/init/Kconfig
index cd23faa163d1..d90774ff7610 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -2305,6 +2305,19 @@ config MODULE_COMPRESS_ZSTD
 
 endchoice
 
+config MODULE_DECOMPRESS
+	bool "Support in-kernel module decompression"
+	depends on MODULE_COMPRESS_GZIP || MODULE_COMPRESS_XZ
+	select ZLIB_INFLATE if MODULE_COMPRESS_GZIP
+	select XZ_DEC if MODULE_COMPRESS_XZ
+	help
+
+	  Support for decompressing kernel modules by the kernel itself
+	  instead of relying on userspace to perform this task. Useful when
+	  load pinning security policy is enabled.
+
+	  If unsure, say N.
+
 config MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS
 	bool "Allow loading of modules with missing namespace imports"
 	help
diff --git a/kernel/Makefile b/kernel/Makefile
index 186c49582f45..56f4ee97f328 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -67,6 +67,7 @@ obj-y += up.o
 endif
 obj-$(CONFIG_UID16) += uid16.o
 obj-$(CONFIG_MODULES) += module.o
+obj-$(CONFIG_MODULE_DECOMPRESS) += module_decompress.o
 obj-$(CONFIG_MODULE_SIG) += module_signing.o
 obj-$(CONFIG_MODULE_SIG_FORMAT) += module_signature.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
diff --git a/kernel/module-internal.h b/kernel/module-internal.h
index 33783abc377b..3c1143d2c8c7 100644
--- a/kernel/module-internal.h
+++ b/kernel/module-internal.h
@@ -22,6 +22,11 @@ struct load_info {
 	bool sig_ok;
 #ifdef CONFIG_KALLSYMS
 	unsigned long mod_kallsyms_init_off;
+#endif
+#ifdef CONFIG_MODULE_DECOMPRESS
+	struct page **pages;
+	unsigned int max_pages;
+	unsigned int used_pages;
 #endif
 	struct {
 		unsigned int sym, str, mod, vers, info, pcpu;
@@ -29,3 +34,16 @@ struct load_info {
 };
 
 extern int mod_verify_sig(const void *mod, struct load_info *info);
+
+#ifdef CONFIG_MODULE_DECOMPRESS
+int module_decompress(struct load_info *info, const void *buf, size_t size);
+void module_decompress_cleanup(struct load_info *info);
+#else
+int module_decompress(struct load_info *info, const void *buf, size_t size)
+{
+	return -EOPNOTSUPP;
+}
+void module_decompress_cleanup(struct load_info *info)
+{
+}
+#endif
diff --git a/kernel/module.c b/kernel/module.c
index 84a9141a5e15..a7c5490b41e9 100644
--- a/kernel/module.c
+++ b/kernel/module.c
@@ -3174,9 +3174,12 @@ static int copy_module_from_user(const void __user *umod, unsigned long len,
 	return err;
 }
 
-static void free_copy(struct load_info *info)
+static void free_copy(struct load_info *info, int flags)
 {
-	vfree(info->hdr);
+	if (flags & MODULE_INIT_COMPRESSED_FILE)
+		module_decompress_cleanup(info);
+	else
+		vfree(info->hdr);
 }
 
 static int rewrite_section_headers(struct load_info *info, int flags)
@@ -4125,7 +4128,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 	}
 
 	/* Get rid of temporary copy. */
-	free_copy(info);
+	free_copy(info, flags);
 
 	/* Done! */
 	trace_module_load(mod);
@@ -4174,7 +4177,7 @@ static int load_module(struct load_info *info, const char __user *uargs,
 
 	module_deallocate(mod, info);
  free_copy:
-	free_copy(info);
+	free_copy(info, flags);
 	return err;
 }
 
@@ -4201,7 +4204,8 @@ SYSCALL_DEFINE3(init_module, void __user *, umod,
 SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 {
 	struct load_info info = { };
-	void *hdr = NULL;
+	void *buf = NULL;
+	int len;
 	int err;
 
 	err = may_init_module();
@@ -4211,15 +4215,24 @@ SYSCALL_DEFINE3(finit_module, int, fd, const char __user *, uargs, int, flags)
 	pr_debug("finit_module: fd=%d, uargs=%p, flags=%i\n", fd, uargs, flags);
 
 	if (flags & ~(MODULE_INIT_IGNORE_MODVERSIONS
-		      |MODULE_INIT_IGNORE_VERMAGIC))
+		      |MODULE_INIT_IGNORE_VERMAGIC
+		      |MODULE_INIT_COMPRESSED_FILE))
 		return -EINVAL;
 
-	err = kernel_read_file_from_fd(fd, 0, &hdr, INT_MAX, NULL,
+	len = kernel_read_file_from_fd(fd, 0, &buf, INT_MAX, NULL,
 				       READING_MODULE);
-	if (err < 0)
-		return err;
-	info.hdr = hdr;
-	info.len = err;
+	if (len < 0)
+		return len;
+
+	if (flags & MODULE_INIT_COMPRESSED_FILE) {
+		err = module_decompress(&info, buf, len);
+		vfree(buf); /* compressed data is no longer needed */
+		if (err)
+			return err;
+	} else {
+		info.hdr = buf;
+		info.len = len;
+	}
 
 	return load_module(&info, uargs, flags);
 }
diff --git a/kernel/module_decompress.c b/kernel/module_decompress.c
new file mode 100644
index 000000000000..aeefd95a3337
--- /dev/null
+++ b/kernel/module_decompress.c
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright 2021 Google LLC.
+ */
+
+#include <linux/init.h>
+#include <linux/highmem.h>
+#include <linux/kobject.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/sysfs.h>
+#include <linux/vmalloc.h>
+
+#include "module-internal.h"
+
+static int module_extend_max_pages(struct load_info *info, unsigned int extent)
+{
+	struct page **new_pages;
+
+	new_pages = kvmalloc_array(info->max_pages + extent,
+				   sizeof(info->pages), GFP_KERNEL);
+	if (!new_pages)
+		return -ENOMEM;
+
+	memcpy(new_pages, info->pages, info->max_pages * sizeof(info->pages));
+	kvfree(info->pages);
+	info->pages = new_pages;
+	info->max_pages += extent;
+
+	return 0;
+}
+
+static struct page *module_get_next_page(struct load_info *info)
+{
+	struct page *page;
+	int error;
+
+	if (info->max_pages == info->used_pages) {
+		error = module_extend_max_pages(info, info->used_pages);
+		if (error)
+			return ERR_PTR(error);
+	}
+
+	page = alloc_page(GFP_KERNEL | __GFP_HIGHMEM);
+	if (!page)
+		return ERR_PTR(-ENOMEM);
+
+	info->pages[info->used_pages++] = page;
+	return page;
+}
+
+#ifdef CONFIG_MODULE_COMPRESS_GZIP
+#include <linux/zlib.h>
+#define MODULE_COMPRESSION	gzip
+#define MODULE_DECOMPRESS_FN	module_gzip_decompress
+
+/*
+ * Calculate length of the header which consists of signature, header
+ * flags, time stamp and operating system ID (10 bytes total), plus
+ * an optional filename.
+ */
+static size_t module_gzip_header_len(const u8 *buf, size_t size)
+{
+	const u8 signature[] = { 0x1f, 0x8b, 0x08 };
+	size_t len = 10;
+
+	if (size < len || memcmp(buf, signature, sizeof(signature)))
+		return 0;
+
+	if (buf[3] & 0x08) {
+		do {
+			/*
+			 * If we can't find the end of the file name we must
+			 * be dealing with a corrupted file.
+			 */
+			if (len == size)
+				return 0;
+		} while (buf[len++] != '\0');
+	}
+
+	return len;
+}
+
+static ssize_t module_gzip_decompress(struct load_info *info,
+				      const void *buf, size_t size)
+{
+	struct z_stream_s s = { 0 };
+	size_t new_size = 0;
+	size_t gzip_hdr_len;
+	ssize_t retval;
+	int rc;
+
+	gzip_hdr_len = module_gzip_header_len(buf, size);
+	if (!gzip_hdr_len) {
+		pr_err("not a gzip compressed module\n");
+		return -EINVAL;
+	}
+
+	s.next_in = buf + gzip_hdr_len;
+	s.avail_in = size - gzip_hdr_len;
+
+	s.workspace = kmalloc(zlib_inflate_workspacesize(), GFP_KERNEL);
+	if (!s.workspace)
+		return -ENOMEM;
+
+	rc = zlib_inflateInit2(&s, -MAX_WBITS);
+	if (rc != Z_OK) {
+		pr_err("failed to initialize decompresser: %d\n", rc);
+		retval = -EINVAL;
+		goto out;
+	}
+
+	do {
+		struct page *page = module_get_next_page(info);
+		if (!page) {
+			retval = -ENOMEM;
+			goto out_inflate_end;
+		}
+
+		s.next_out = kmap(page);
+		s.avail_out = PAGE_SIZE;
+		rc = zlib_inflate(&s, 0);
+		kunmap(page);
+
+		new_size += PAGE_SIZE - s.avail_out;
+	} while (rc == Z_OK);
+
+	if (rc != Z_STREAM_END) {
+		pr_err("decompression failed with status %d\n", rc);
+		retval = -EINVAL;
+		goto out_inflate_end;
+	}
+
+	retval = new_size;
+
+out_inflate_end:
+	zlib_inflateEnd(&s);
+out:
+	kfree(s.workspace);
+	return retval;
+}
+#elif CONFIG_MODULE_COMPRESS_XZ
+#include <linux/xz.h>
+#define MODULE_COMPRESSION	xz
+#define MODULE_DECOMPRESS_FN	module_xz_decompress
+
+static ssize_t module_xz_decompress(struct load_info *info,
+				    const void *buf, size_t size)
+{
+	static const u8 signature[] = { 0xfd, '7', 'z', 'X', 'Z', 0 };
+	struct xz_dec *xz_dec;
+	struct xz_buf xz_buf;
+	enum xz_ret xz_ret;
+	size_t new_size = 0;
+	ssize_t retval;
+
+	if (size < sizeof(signature) ||
+	    memcmp(buf, signature, sizeof(signature))) {
+		pr_err("not an xz compressed module\n");
+		return -EINVAL;
+	}
+
+	xz_dec = xz_dec_init(XZ_DYNALLOC, (u32)-1);
+	if (!xz_dec)
+		return -ENOMEM;
+
+	xz_buf.in_size = size;
+	xz_buf.in = buf;
+	xz_buf.in_pos = 0;
+
+	do {
+		struct page *page = module_get_next_page(info);
+		if (!page) {
+			retval = -ENOMEM;
+			goto out;
+		}
+
+		xz_buf.out = kmap(page);
+		xz_buf.out_pos = 0;
+		xz_buf.out_size = PAGE_SIZE;
+		xz_ret = xz_dec_run(xz_dec, &xz_buf);
+		kunmap(page);
+
+		new_size += xz_buf.out_pos;
+	} while (xz_buf.out_pos == PAGE_SIZE && xz_ret == XZ_OK);
+
+	if (xz_ret != XZ_STREAM_END) {
+		pr_err("decompression failed with status %d\n", xz_ret);
+		retval = -EINVAL;
+		goto out;
+	}
+
+	retval = new_size;
+
+ out:
+	xz_dec_end(xz_dec);
+	return retval;
+}
+#else
+#error "Unexpected configuration for CONFIG_MODULE_DECOMPRESS"
+#endif
+
+int module_decompress(struct load_info *info, const void *buf, size_t size)
+{
+	unsigned int n_pages;
+	ssize_t data_size;
+	int error;
+
+	/*
+	 * Start with number of pages twice as big as needed for
+	 * compressed data.
+	 */
+	n_pages = DIV_ROUND_UP(size, PAGE_SIZE) * 2;
+	error = module_extend_max_pages(info, n_pages);
+
+	data_size = MODULE_DECOMPRESS_FN(info, buf, size);
+	if (data_size < 0) {
+		error = data_size;
+		goto err;
+	}
+
+	info->hdr = vmap(info->pages, info->used_pages, VM_MAP, PAGE_KERNEL);
+	if (!info->hdr) {
+		error = -ENOMEM;
+		goto err;
+	}
+
+	info->len = data_size;
+	return 0;
+
+err:
+	module_decompress_cleanup(info);
+	return error;
+}
+
+void module_decompress_cleanup(struct load_info *info)
+{
+	int i;
+
+	if (info->hdr)
+		vunmap(info->hdr);
+
+	for (i = 0; i < info->used_pages; i++)
+		__free_page(info->pages[i]);
+
+	kvfree(info->pages);
+
+	info->pages = NULL;
+	info->max_pages = info->used_pages = 0;
+}
+
+static ssize_t compression_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%s\n", __stringify(MODULE_COMPRESSION));
+}
+static struct kobj_attribute module_compression_attr = __ATTR_RO(compression);
+
+static int __init module_decompress_sysfs_init(void)
+{
+	int error;
+
+	error = sysfs_create_file(&module_kset->kobj,
+				  &module_compression_attr.attr);
+	if (error)
+		pr_warn("Failed to create 'compression' attribute");
+
+	return 0;
+}
+late_initcall(module_decompress_sysfs_init);
-- 
2.34.1.448.ga2b2bfdf31-goog


-- 
Dmitry
