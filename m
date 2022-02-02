Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68274A6F7E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 12:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343882AbiBBLE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 06:04:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343697AbiBBLEG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 06:04:06 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76C4C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 03:04:02 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id k13so7542151lfg.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 03:04:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=frSxJsenabMGYgz0iYH0G/tZpbsKwlTyJiIBXkslbKA=;
        b=VqvfK+mJwe35fv5IGXARk4nhqGyaq7TsJDgSIvhsno7rcN+kyAWf7SNo0jQS+r/RZ4
         KFxdvpvYsUamXQsRLJGp+pXIj6SGBDJZFk8VrFT3RirLo+IAy2FKCIDJAtG5opOohABL
         l1FYRHI5v+xj3erHVKohqVZqKrs3hTnu0AqoXt87rfvzjasSgt0p2klPk7itipgwcZtl
         vtSZgDyj178NPDSEw4lb3cOF7W++XoJ2jsfUNWwGzOINUFIHzeikUtAqFaowMiOF69u7
         t3T6luTeKVbNlpthOO/eUYZXHxe2twU+xnZrlp6YHQKtOFqrjNFg0NxbJAhWP/scbAvL
         oI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=frSxJsenabMGYgz0iYH0G/tZpbsKwlTyJiIBXkslbKA=;
        b=20zGypJejmorHd4Y8r41n75k8Cg2BkkV/BUQnZWdztLjuT25/qCAYBXKGsN5OktCcv
         jDMztoaNP27lO+XjDasxsg4jO7gpStcdp+BswhUi9je4tvWGh+0//vIaQLRknphPXlOa
         IeiFPdTmHFh7Gn/D1o7j3OKV0i9RgHcrRmlAD8AolpRHFHXdzIkFyi/rlBJEoSLRVZQ4
         PQ5edBGsAdBNXx0x/1qSG3PJVAwHSKixP1lEFY2RM8uM93EAtExq83xh2axrsUYQzp9X
         LGpgSP0u1nAxRkR18sWsNCNM0HXhr/4vUdfxbSluGQaLGoXgGPBE9RmCRNOuImBvUNNM
         Uw0w==
X-Gm-Message-State: AOAM531+af0sk8jfLgaqPHjqwVPtztuedn6gSJL6MwRqg5mnCkrOjjnn
        ptA3fIZJxFfsbjKnRGYYNbY=
X-Google-Smtp-Source: ABdhPJws6G1iAazt3hqXhISVwa1U+jVQuk1ODxJP7q/Y5LSdKb9PKgw6etgnPnEt78WwChs4W5Mumw==
X-Received: by 2002:a05:6512:3b9b:: with SMTP id g27mr22655463lfv.655.1643799841057;
        Wed, 02 Feb 2022 03:04:01 -0800 (PST)
Received: from localhost.localdomain (staticline-31-183-164-222.toya.net.pl. [31.183.164.222])
        by smtp.gmail.com with ESMTPSA id r14sm4503937lfr.129.2022.02.02.03.04.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 03:04:00 -0800 (PST)
From:   Karolina Drobnik <karolinadrobnik@gmail.com>
To:     linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, rppt@kernel.org,
        linux-kernel@vger.kernel.org,
        Karolina Drobnik <karolinadrobnik@gmail.com>
Subject: [PATCH v2 10/16] memblock tests: Add skeleton of the memblock simulator
Date:   Wed,  2 Feb 2022 12:03:09 +0100
Message-Id: <d296fceb023a04b316a31fbff9acf1e76ac684e4.1643796665.git.karolinadrobnik@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1643796665.git.karolinadrobnik@gmail.com>
References: <cover.1643796665.git.karolinadrobnik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add basic project files, together with local stubs of required headers.
Update tools/include/slab.h to include definitions used by memblock.

Signed-off-by: Karolina Drobnik <karolinadrobnik@gmail.com>
---
 MAINTAINERS                                   |  1 +
 tools/include/linux/slab.h                    | 10 ++++
 tools/testing/memblock/.gitignore             |  4 ++
 tools/testing/memblock/Makefile               | 52 +++++++++++++++++++
 tools/testing/memblock/asm/dma.h              |  5 ++
 tools/testing/memblock/internal.h             | 12 +++++
 tools/testing/memblock/lib/slab.c             |  9 ++++
 tools/testing/memblock/linux/init.h           | 34 ++++++++++++
 tools/testing/memblock/linux/kernel.h         | 12 +++++
 tools/testing/memblock/linux/kmemleak.h       | 18 +++++++
 tools/testing/memblock/linux/memory_hotplug.h | 19 +++++++
 tools/testing/memblock/linux/mmzone.h         | 35 +++++++++++++
 tools/testing/memblock/linux/printk.h         | 25 +++++++++
 tools/testing/memblock/main.c                 |  6 +++
 tools/testing/memblock/mmzone.c               | 20 +++++++
 .../testing/memblock/scripts/Makefile.include | 17 ++++++
 16 files changed, 279 insertions(+)
 create mode 100644 tools/testing/memblock/.gitignore
 create mode 100644 tools/testing/memblock/Makefile
 create mode 100644 tools/testing/memblock/asm/dma.h
 create mode 100644 tools/testing/memblock/internal.h
 create mode 100644 tools/testing/memblock/lib/slab.c
 create mode 100644 tools/testing/memblock/linux/init.h
 create mode 100644 tools/testing/memblock/linux/kernel.h
 create mode 100644 tools/testing/memblock/linux/kmemleak.h
 create mode 100644 tools/testing/memblock/linux/memory_hotplug.h
 create mode 100644 tools/testing/memblock/linux/mmzone.h
 create mode 100644 tools/testing/memblock/linux/printk.h
 create mode 100644 tools/testing/memblock/main.c
 create mode 100644 tools/testing/memblock/mmzone.c
 create mode 100644 tools/testing/memblock/scripts/Makefile.include

diff --git a/MAINTAINERS b/MAINTAINERS
index f41088418aae..86ae61c39171 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12406,6 +12406,7 @@ S:	Maintained
 F:	Documentation/core-api/boot-time-mm.rst
 F:	include/linux/memblock.h
 F:	mm/memblock.c
+F:	tools/testing/memblock/
 
 MEMORY CONTROLLER DRIVERS
 M:	Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
diff --git a/tools/include/linux/slab.h b/tools/include/linux/slab.h
index 07d7930d4003..f41d8a0eb1a4 100644
--- a/tools/include/linux/slab.h
+++ b/tools/include/linux/slab.h
@@ -13,6 +13,16 @@
 void *kmalloc(size_t size, gfp_t gfp);
 void kfree(void *p);
 
+bool slab_is_available(void);
+
+enum slab_state {
+	DOWN,
+	PARTIAL,
+	PARTIAL_NODE,
+	UP,
+	FULL
+};
+
 static inline void *kzalloc(size_t size, gfp_t gfp)
 {
 	return kmalloc(size, gfp | __GFP_ZERO);
diff --git a/tools/testing/memblock/.gitignore b/tools/testing/memblock/.gitignore
new file mode 100644
index 000000000000..654338e0be52
--- /dev/null
+++ b/tools/testing/memblock/.gitignore
@@ -0,0 +1,4 @@
+main
+memblock.c
+linux/memblock.h
+asm/cmpxchg.h
diff --git a/tools/testing/memblock/Makefile b/tools/testing/memblock/Makefile
new file mode 100644
index 000000000000..e43ed9de9bcf
--- /dev/null
+++ b/tools/testing/memblock/Makefile
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: GPL-2.0
+
+# Memblock simulator requires AddressSanitizer (libasan) and liburcu development
+# packages installed
+CFLAGS += -I. -I../../include -Wall -O2 -fsanitize=address \
+	  -fsanitize=undefined -D CONFIG_PHYS_ADDR_T_64BIT
+LDFLAGS += -fsanitize=address -fsanitize=undefined
+TARGETS = main
+OFILES = main.o memblock.o lib/slab.o mmzone.o slab.o
+EXTR_SRC = ../../../mm/memblock.c
+
+ifeq ($(BUILD), 32)
+	CFLAGS += -m32
+	LDFLAGS += -m32
+endif
+
+# Process user parameters
+include scripts/Makefile.include
+
+main: $(OFILES)
+
+$(OFILES): include
+
+include: ../../../include/linux/memblock.h ../../include/linux/*.h \
+	../../include/asm/*.h
+
+	@mkdir -p linux
+	test -L linux/memblock.h || ln -s ../../../../include/linux/memblock.h linux/memblock.h
+	test -L asm/cmpxchg.h || ln -s ../../../arch/x86/include/asm/cmpxchg.h asm/cmpxchg.h
+
+memblock.c: $(EXTR_SRC)
+	test -L memblock.c || ln -s $(EXTR_SRC) memblock.c
+
+clean:
+	$(RM) $(TARGETS) $(OFILES) linux/memblock.h memblock.c asm/cmpxchg.h
+
+help:
+	@echo  'Memblock simulator'
+	@echo  ''
+	@echo  'Available targets:'
+	@echo  '  main		  - Build the memblock simulator'
+	@echo  '  clean		  - Remove generated files and symlinks in the directory'
+	@echo  ''
+	@echo  'Configuration:'
+	@echo  '  make NUMA=1               - simulate enabled NUMA'
+	@echo  '  make MOVABLE_NODE=1       - override `movable_node_is_enabled`'
+	@echo  '                              definition to simulate movable NUMA nodes'
+	@echo  '  make 32BIT_PHYS_ADDR_T=1  - Use 32 bit physical addresses'
+
+vpath %.c ../../lib
+
+.PHONY: clean include help
diff --git a/tools/testing/memblock/asm/dma.h b/tools/testing/memblock/asm/dma.h
new file mode 100644
index 000000000000..13ff8e5d22ef
--- /dev/null
+++ b/tools/testing/memblock/asm/dma.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_DMA_H
+#define _TOOLS_DMA_H
+
+#endif
diff --git a/tools/testing/memblock/internal.h b/tools/testing/memblock/internal.h
new file mode 100644
index 000000000000..94b52a8718b5
--- /dev/null
+++ b/tools/testing/memblock/internal.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+#ifndef _MM_INTERNAL_H
+#define _MM_INTERNAL_H
+
+struct page {};
+
+void memblock_free_pages(struct page *page, unsigned long pfn,
+			 unsigned int order)
+{
+}
+
+#endif
diff --git a/tools/testing/memblock/lib/slab.c b/tools/testing/memblock/lib/slab.c
new file mode 100644
index 000000000000..6be6020328fb
--- /dev/null
+++ b/tools/testing/memblock/lib/slab.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/slab.h>
+
+enum slab_state slab_state;
+
+bool slab_is_available(void)
+{
+	return slab_state >= UP;
+}
diff --git a/tools/testing/memblock/linux/init.h b/tools/testing/memblock/linux/init.h
new file mode 100644
index 000000000000..828e0ee0bc6c
--- /dev/null
+++ b/tools/testing/memblock/linux/init.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_INIT_H
+#define _LINUX_INIT_H
+
+#include <linux/compiler.h>
+#include <asm/export.h>
+#include <linux/memory_hotplug.h>
+
+#define __section(section)              __attribute__((__section__(section)))
+
+#define __initconst
+#define __meminit
+#define __meminitdata
+#define __refdata
+#define __initdata
+
+struct obs_kernel_param {
+	const char *str;
+	int (*setup_func)(char *st);
+	int early;
+};
+
+#define __setup_param(str, unique_id, fn, early)			\
+	static const char __setup_str_##unique_id[] __initconst		\
+		__aligned(1) = str;					\
+	static struct obs_kernel_param __setup_##unique_id		\
+		__used __section(".init.setup")				\
+		__aligned(__alignof__(struct obs_kernel_param)) =	\
+		{ __setup_str_##unique_id, fn, early }
+
+#define early_param(str, fn)						\
+	__setup_param(str, fn, fn, 1)
+
+#endif
diff --git a/tools/testing/memblock/linux/kernel.h b/tools/testing/memblock/linux/kernel.h
new file mode 100644
index 000000000000..d2f148bd8902
--- /dev/null
+++ b/tools/testing/memblock/linux/kernel.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _MEMBLOCK_LINUX_KERNEL_H
+#define _MEMBLOCK_LINUX_KERNEL_H
+
+#include <../../include/linux/kernel.h>
+#include <linux/errno.h>
+#include <string.h>
+#include <linux/printk.h>
+#include <linux/linkage.h>
+#include <linux/kconfig.h>
+
+#endif
diff --git a/tools/testing/memblock/linux/kmemleak.h b/tools/testing/memblock/linux/kmemleak.h
new file mode 100644
index 000000000000..462f8c5e8aa0
--- /dev/null
+++ b/tools/testing/memblock/linux/kmemleak.h
@@ -0,0 +1,18 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _KMEMLEAK_H
+#define _KMEMLEAK_H
+
+static inline void kmemleak_free_part_phys(phys_addr_t phys, size_t size)
+{
+}
+
+static inline void kmemleak_alloc_phys(phys_addr_t phys, size_t size,
+				       int min_count, gfp_t gfp)
+{
+}
+
+static inline void dump_stack(void)
+{
+}
+
+#endif
diff --git a/tools/testing/memblock/linux/memory_hotplug.h b/tools/testing/memblock/linux/memory_hotplug.h
new file mode 100644
index 000000000000..47988765a219
--- /dev/null
+++ b/tools/testing/memblock/linux/memory_hotplug.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_MEMORY_HOTPLUG_H
+#define _LINUX_MEMORY_HOTPLUG_H
+
+#include <linux/numa.h>
+#include <linux/pfn.h>
+#include <linux/cache.h>
+#include <linux/types.h>
+
+static inline bool movable_node_is_enabled(void)
+{
+#ifdef MOVABLE_NODE
+	return true;
+#else
+	return false;
+#endif
+}
+
+#endif
diff --git a/tools/testing/memblock/linux/mmzone.h b/tools/testing/memblock/linux/mmzone.h
new file mode 100644
index 000000000000..7c2eb5c9bb54
--- /dev/null
+++ b/tools/testing/memblock/linux/mmzone.h
@@ -0,0 +1,35 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _TOOLS_MMZONE_H
+#define _TOOLS_MMZONE_H
+
+#include <linux/atomic.h>
+
+struct pglist_data *first_online_pgdat(void);
+struct pglist_data *next_online_pgdat(struct pglist_data *pgdat);
+
+#define for_each_online_pgdat(pgdat)			\
+	for (pgdat = first_online_pgdat();		\
+	     pgdat;					\
+	     pgdat = next_online_pgdat(pgdat))
+
+enum zone_type {
+	__MAX_NR_ZONES
+};
+
+#define MAX_NR_ZONES __MAX_NR_ZONES
+#define MAX_ORDER 11
+#define MAX_ORDER_NR_PAGES (1 << (MAX_ORDER - 1))
+
+#define pageblock_order		(MAX_ORDER - 1)
+#define pageblock_nr_pages	BIT(pageblock_order)
+
+struct zone {
+	atomic_long_t		managed_pages;
+};
+
+typedef struct pglist_data {
+	struct zone node_zones[MAX_NR_ZONES];
+
+} pg_data_t;
+
+#endif
diff --git a/tools/testing/memblock/linux/printk.h b/tools/testing/memblock/linux/printk.h
new file mode 100644
index 000000000000..61af424d8c6c
--- /dev/null
+++ b/tools/testing/memblock/linux/printk.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _PRINTK_H
+#define _PRINTK_H
+
+#include <stdio.h>
+#include <asm/bug.h>
+
+/*
+ * memblock_dbg is called with u64 arguments that don't match the "%llu"
+ * specifier in printf. This results in warnings that cannot be fixed without
+ * modifying memblock.c, which we wish to avoid. As these messaged are not used
+ * in testing anyway, the mismatch can be ignored.
+ */
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wformat"
+#define printk printf
+#pragma GCC diagnostic push
+
+#define pr_info printk
+#define pr_debug printk
+#define pr_cont printk
+#define pr_err printk
+#define pr_warn printk
+
+#endif
diff --git a/tools/testing/memblock/main.c b/tools/testing/memblock/main.c
new file mode 100644
index 000000000000..62958da35d0f
--- /dev/null
+++ b/tools/testing/memblock/main.c
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+
+int main(int argc, char **argv)
+{
+	return 0;
+}
diff --git a/tools/testing/memblock/mmzone.c b/tools/testing/memblock/mmzone.c
new file mode 100644
index 000000000000..7b0909e8b759
--- /dev/null
+++ b/tools/testing/memblock/mmzone.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#include <linux/mmzone.h>
+
+struct pglist_data *first_online_pgdat(void)
+{
+	return NULL;
+}
+
+struct pglist_data *next_online_pgdat(struct pglist_data *pgdat)
+{
+	return NULL;
+}
+
+void reserve_bootmem_region(phys_addr_t start, phys_addr_t end)
+{
+}
+
+void atomic_long_set(atomic_long_t *v, long i)
+{
+}
diff --git a/tools/testing/memblock/scripts/Makefile.include b/tools/testing/memblock/scripts/Makefile.include
new file mode 100644
index 000000000000..699b0d6cda07
--- /dev/null
+++ b/tools/testing/memblock/scripts/Makefile.include
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0
+# Definitions for user-provided arguments
+
+# Simulate CONFIG_NUMA=y
+ifeq ($(NUMA), 1)
+	CFLAGS += -D CONFIG_NUMA
+endif
+
+# Simulate movable NUMA memory regions
+ifeq ($(MOVABLE_NODE), 1)
+	CFLAGS += -D MOVABLE_NODE
+endif
+
+# Use 32 bit physical addresses
+ifeq ($(32BIT_PHYS_ADDR_T), 1)
+	CFLAGS += -U CONFIG_PHYS_ADDR_T_64BIT
+endif
-- 
2.30.2

