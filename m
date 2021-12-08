Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5780046D688
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 16:11:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235795AbhLHPPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 10:15:06 -0500
Received: from smtp1.axis.com ([195.60.68.17]:16745 "EHLO smtp1.axis.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235731AbhLHPPA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 10:15:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1638976288;
  x=1670512288;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=08mDDHOlgpqqtY4M6OaMAhl5Pbv8Ss4NTgo4wUqg5vU=;
  b=MDJT/zPeL3fQOHVowtDbdC5u8w9KEmNYE4wEnyS4tZAdhoGkPiHlGWwv
   59ZuWxtXpfiQ/5xvTXaB4vHwBmXHt1HJVEYEhMAB/Bfm5C+SX/qRwGi8P
   uXttnV76ZGgW6AHH+ipZx8jGnAZ4WFay+S6I+PaXmZDlNa2u8WhJh05bL
   kZsza42pQDP0r0hQul8IQK32f5LMWazvpgY4PoXcmNbmZIuvYqkPQnH2O
   BwiUdpgpDkSTc2+mGgtcwxCkd6HeMF0jw5WVNZgJKmLdp1559sJNjh0NL
   9GtiDiXrU/gqyjLfOVuVdDBuAQAEeQq0I9m97NsobeEtNzGJ8922DTQ7x
   Q==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
To:     <jdike@addtoit.com>, <richard@nod.at>,
        <anton.ivanov@cambridgegreys.com>
CC:     <kernel@axis.com>, <linux-kernel@vger.kernel.org>,
        <linux-um@lists.infradead.org>, <devicetree@vger.kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: [PATCH 1/2] um: Extract load file helper from initrd.c
Date:   Wed, 8 Dec 2021 16:11:22 +0100
Message-ID: <20211208151123.29313-2-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211208151123.29313-1-vincent.whitchurch@axis.com>
References: <20211208151123.29313-1-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The file loading support in initrd.c can be re-used for
loading devicetrees.  Move it out of initrd.c.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 arch/um/kernel/Makefile    |  1 +
 arch/um/kernel/initrd.c    | 48 ++++--------------------------
 arch/um/kernel/load_file.c | 61 ++++++++++++++++++++++++++++++++++++++
 arch/um/kernel/um_arch.h   |  8 +++++
 4 files changed, 75 insertions(+), 43 deletions(-)
 create mode 100644 arch/um/kernel/load_file.c
 create mode 100644 arch/um/kernel/um_arch.h

diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index 1d18e4e46989..92692bfef7ae 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -18,6 +18,7 @@ obj-y = config.o exec.o exitcode.o irq.o ksyms.o mem.o \
 	physmem.o process.o ptrace.o reboot.o sigio.o \
 	signal.o syscall.o sysrq.o time.o tlb.o trap.o \
 	um_arch.o umid.o maccess.o kmsg_dump.o capflags.o skas/
+obj-y += load_file.o
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
diff --git a/arch/um/kernel/initrd.c b/arch/um/kernel/initrd.c
index c1981ffb7179..47b8cb1a1156 100644
--- a/arch/um/kernel/initrd.c
+++ b/arch/um/kernel/initrd.c
@@ -10,37 +10,21 @@
 #include <init.h>
 #include <os.h>
 
+#include "um_arch.h"
+
 /* Changed by uml_initrd_setup, which is a setup */
 static char *initrd __initdata = NULL;
-static int load_initrd(char *filename, void *buf, int size);
 
 int __init read_initrd(void)
 {
+	unsigned long long size;
 	void *area;
-	long long size;
-	int err;
-
-	if (initrd == NULL)
-		return 0;
 
-	err = os_file_size(initrd, &size);
-	if (err)
+	if (!initrd)
 		return 0;
 
-	/*
-	 * This is necessary because alloc_bootmem craps out if you
-	 * ask for no memory.
-	 */
-	if (size == 0) {
-		printk(KERN_ERR "\"%s\" is a zero-size initrd\n", initrd);
-		return 0;
-	}
-
-	area = memblock_alloc(size, SMP_CACHE_BYTES);
+	area = uml_load_file(initrd, &size);
 	if (!area)
-		panic("%s: Failed to allocate %llu bytes\n", __func__, size);
-
-	if (load_initrd(initrd, area, size) == -1)
 		return 0;
 
 	initrd_start = (unsigned long) area;
@@ -59,25 +43,3 @@ __uml_setup("initrd=", uml_initrd_setup,
 "    This is used to boot UML from an initrd image.  The argument is the\n"
 "    name of the file containing the image.\n\n"
 );
-
-static int load_initrd(char *filename, void *buf, int size)
-{
-	int fd, n;
-
-	fd = os_open_file(filename, of_read(OPENFLAGS()), 0);
-	if (fd < 0) {
-		printk(KERN_ERR "Opening '%s' failed - err = %d\n", filename,
-		       -fd);
-		return -1;
-	}
-	n = os_read_file(fd, buf, size);
-	if (n != size) {
-		printk(KERN_ERR "Read of %d bytes from '%s' failed, "
-		       "err = %d\n", size,
-		       filename, -n);
-		return -1;
-	}
-
-	os_close_file(fd);
-	return 0;
-}
diff --git a/arch/um/kernel/load_file.c b/arch/um/kernel/load_file.c
new file mode 100644
index 000000000000..5cecd0e291fb
--- /dev/null
+++ b/arch/um/kernel/load_file.c
@@ -0,0 +1,61 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+ */
+#include <linux/memblock.h>
+#include <os.h>
+
+#include "um_arch.h"
+
+static int __init __uml_load_file(const char *filename, void *buf, int size)
+{
+	int fd, n;
+
+	fd = os_open_file(filename, of_read(OPENFLAGS()), 0);
+	if (fd < 0) {
+		printk(KERN_ERR "Opening '%s' failed - err = %d\n", filename,
+		       -fd);
+		return -1;
+	}
+	n = os_read_file(fd, buf, size);
+	if (n != size) {
+		printk(KERN_ERR "Read of %d bytes from '%s' failed, "
+		       "err = %d\n", size,
+		       filename, -n);
+		return -1;
+	}
+
+	os_close_file(fd);
+	return 0;
+}
+
+void *uml_load_file(const char *filename, unsigned long long *size)
+{
+	void *area;
+	int err;
+
+	*size = 0;
+
+	if (!filename)
+		return NULL;
+
+	err = os_file_size(filename, size);
+	if (err)
+		return NULL;
+
+	if (*size == 0) {
+		printk(KERN_ERR "\"%s\" is empty\n", filename);
+		return NULL;
+	}
+
+	area = memblock_alloc(*size, SMP_CACHE_BYTES);
+	if (!area)
+		panic("%s: Failed to allocate %llu bytes\n", __func__, *size);
+
+	if (__uml_load_file(filename, area, *size)) {
+		memblock_free(area, *size);
+		return NULL;
+	}
+
+	return area;
+}
diff --git a/arch/um/kernel/um_arch.h b/arch/um/kernel/um_arch.h
new file mode 100644
index 000000000000..b195df3a09a0
--- /dev/null
+++ b/arch/um/kernel/um_arch.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __UML_ARCH_H__
+#define __UML_ARCH_H__
+
+extern void * __init uml_load_file(const char *filename, unsigned long long *size);
+
+#endif
-- 
2.33.1

