Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDFF475DFA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 17:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245067AbhLOQ4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 11:56:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245068AbhLOQ4b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 11:56:31 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11073C061747
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 08:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=i/cAbkCycixb+RulDXx3MjXiNXkL5Qw3VoM1dX130dM=; b=iYATqBKIRZOQh5NkAnt88i6CUh
        eZgKgR7O++chKO2/4WyC6oZuwWpuvc3pRkR7v27rda4rkKPbIOBwPJUy4Pdch4T/IAeLiwpZZpO/i
        uymFd4MNr8A7QBAPx0+paYjgmYsasModkH+cjJHKOxwDXNf7Hkvg7hRJEgwdOEvVKQoVJEKU4HP5O
        6mqS2HeAjnNz0LxPZfv1pHOhxpuX+5TNrNKUjLsI9q/5GnkQWPfG722wV/LHjU8V0tbYclBHOjzsp
        ESou0YSzWxGPGKPeESZb4ZZ3X+eWgBDIDGZa9EPIsUwezgtK6G3zUzk857jqjVQahlprvtM6T74CM
        IL3Vp9cw==;
Received: from [2001:4bb8:184:5c65:a9d9:2b74:3491:e72b] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mxXZg-00EpXg-My; Wed, 15 Dec 2021 16:56:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc:     x86@kernel.org, linux-um@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] um: remove set_fs
Date:   Wed, 15 Dec 2021 17:56:12 +0100
Message-Id: <20211215165612.554426-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211215165612.554426-1-hch@lst.de>
References: <20211215165612.554426-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove address space overrides using set_fs() for User Mode Linux.
Note that just like the existing kernel access case of the uaccess
routines the new nofault kernel handlers do not actually have any
exception handling.  This is probably broken, but not change to the
status quo.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/um/Kconfig                   |  1 -
 arch/um/include/asm/thread_info.h |  4 ----
 arch/um/include/asm/uaccess.h     | 21 +++++++++++++++++++--
 arch/um/kernel/skas/uaccess.c     | 25 -------------------------
 arch/x86/um/asm/segment.h         |  8 --------
 5 files changed, 19 insertions(+), 40 deletions(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index c18b45f75d41f..aafdbb6e8059e 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -21,7 +21,6 @@ config UML
 	select GENERIC_IRQ_SHOW
 	select GENERIC_CPU_DEVICES
 	select HAVE_GCC_PLUGINS
-	select SET_FS
 	select TRACE_IRQFLAGS_SUPPORT
 	select TTY # Needed for line.c
 	select HAVE_ARCH_VMAP_STACK
diff --git a/arch/um/include/asm/thread_info.h b/arch/um/include/asm/thread_info.h
index 3b1cb8b3b1864..1395cbd7e340d 100644
--- a/arch/um/include/asm/thread_info.h
+++ b/arch/um/include/asm/thread_info.h
@@ -22,9 +22,6 @@ struct thread_info {
 	__u32			cpu;		/* current CPU */
 	int			preempt_count;  /* 0 => preemptable,
 						   <0 => BUG */
-	mm_segment_t		addr_limit;	/* thread address space:
-					 	   0-0xBFFFFFFF for user
-						   0-0xFFFFFFFF for kernel */
 	struct thread_info	*real_thread;    /* Points to non-IRQ stack */
 	unsigned long aux_fp_regs[FP_SIZE];	/* auxiliary fp_regs to save/restore
 						   them out-of-band */
@@ -36,7 +33,6 @@ struct thread_info {
 	.flags =		0,		\
 	.cpu =		0,			\
 	.preempt_count = INIT_PREEMPT_COUNT,	\
-	.addr_limit =	KERNEL_DS,		\
 	.real_thread = NULL,			\
 }
 
diff --git a/arch/um/include/asm/uaccess.h b/arch/um/include/asm/uaccess.h
index 191ef36dd5439..17d18cfd82a51 100644
--- a/arch/um/include/asm/uaccess.h
+++ b/arch/um/include/asm/uaccess.h
@@ -8,6 +8,7 @@
 #define __UM_UACCESS_H
 
 #include <asm/elf.h>
+#include <asm/unaligned.h>
 
 #define __under_task_size(addr, size) \
 	(((unsigned long) (addr) < TASK_SIZE) && \
@@ -39,8 +40,24 @@ static inline int __access_ok(unsigned long addr, unsigned long size)
 {
 	return __addr_range_nowrap(addr, size) &&
 		(__under_task_size(addr, size) ||
-		__access_ok_vsyscall(addr, size) ||
-		uaccess_kernel());
+		 __access_ok_vsyscall(addr, size));
 }
 
+/* no pagefaults for kernel addresses in um */
+#define HAVE_GET_KERNEL_NOFAULT 1
+
+#define __get_kernel_nofault(dst, src, type, err_label)			\
+do {									\
+	*((type *)dst) = get_unaligned((type *)(src));			\
+	if (0) /* make sure the label looks used to the compiler */	\
+		goto err_label;						\
+} while (0)
+
+#define __put_kernel_nofault(dst, src, type, err_label)			\
+do {									\
+	put_unaligned(*((type *)src), (type *)(dst));			\
+	if (0) /* make sure the label looks used to the compiler */	\
+		goto err_label;						\
+} while (0)
+
 #endif
diff --git a/arch/um/kernel/skas/uaccess.c b/arch/um/kernel/skas/uaccess.c
index a509be9110260..23775d01a2a61 100644
--- a/arch/um/kernel/skas/uaccess.c
+++ b/arch/um/kernel/skas/uaccess.c
@@ -146,11 +146,6 @@ static int copy_chunk_from_user(unsigned long from, int len, void *arg)
 
 unsigned long raw_copy_from_user(void *to, const void __user *from, unsigned long n)
 {
-	if (uaccess_kernel()) {
-		memcpy(to, (__force void*)from, n);
-		return 0;
-	}
-
 	return buffer_op((unsigned long) from, n, 0, copy_chunk_from_user, &to);
 }
 EXPORT_SYMBOL(raw_copy_from_user);
@@ -166,11 +161,6 @@ static int copy_chunk_to_user(unsigned long to, int len, void *arg)
 
 unsigned long raw_copy_to_user(void __user *to, const void *from, unsigned long n)
 {
-	if (uaccess_kernel()) {
-		memcpy((__force void *) to, from, n);
-		return 0;
-	}
-
 	return buffer_op((unsigned long) to, n, 1, copy_chunk_to_user, &from);
 }
 EXPORT_SYMBOL(raw_copy_to_user);
@@ -196,12 +186,6 @@ long strncpy_from_user(char *dst, const char __user *src, long count)
 
 	if (!access_ok(src, 1))
 		return -EFAULT;
-
-	if (uaccess_kernel()) {
-		strncpy(dst, (__force void *) src, count);
-		return strnlen(dst, count);
-	}
-
 	n = buffer_op((unsigned long) src, count, 0, strncpy_chunk_from_user,
 		      &ptr);
 	if (n != 0)
@@ -218,11 +202,6 @@ static int clear_chunk(unsigned long addr, int len, void *unused)
 
 unsigned long __clear_user(void __user *mem, unsigned long len)
 {
-	if (uaccess_kernel()) {
-		memset((__force void*)mem, 0, len);
-		return 0;
-	}
-
 	return buffer_op((unsigned long) mem, len, 1, clear_chunk, NULL);
 }
 EXPORT_SYMBOL(__clear_user);
@@ -245,10 +224,6 @@ long strnlen_user(const char __user *str, long len)
 
 	if (!access_ok(str, 1))
 		return -EFAULT;
-
-	if (uaccess_kernel())
-		return strnlen((__force char*)str, len) + 1;
-
 	n = buffer_op((unsigned long) str, len, 0, strnlen_chunk, &count);
 	if (n == 0)
 		return count + 1;
diff --git a/arch/x86/um/asm/segment.h b/arch/x86/um/asm/segment.h
index 453db377150d6..2ef507bc69890 100644
--- a/arch/x86/um/asm/segment.h
+++ b/arch/x86/um/asm/segment.h
@@ -8,12 +8,4 @@ extern int host_gdt_entry_tls_min;
 #define GDT_ENTRY_TLS_MIN host_gdt_entry_tls_min
 #define GDT_ENTRY_TLS_MAX (GDT_ENTRY_TLS_MIN + GDT_ENTRY_TLS_ENTRIES - 1)
 
-typedef struct {
-	unsigned long seg;
-} mm_segment_t;
-
-#define MAKE_MM_SEG(s)	((mm_segment_t) { (s) })
-#define KERNEL_DS	MAKE_MM_SEG(~0UL)
-#define USER_DS		MAKE_MM_SEG(TASK_SIZE)
-
 #endif
-- 
2.30.2

