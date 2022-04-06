Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4E6E4F5EB3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 15:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiDFMwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbiDFMv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:51:57 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB54F11141
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:54:37 -0700 (PDT)
Received: from kwepemi100003.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KYJDz4LY3zgYQg;
        Wed,  6 Apr 2022 16:52:51 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100003.china.huawei.com (7.221.188.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 6 Apr 2022 16:54:35 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 6 Apr 2022 16:54:34 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Tong Tiangen <tongtiangen@huawei.com>
Subject: [RFC PATCH -next V2 7/7] arm64: add pagecache reading to machine check safe
Date:   Wed, 6 Apr 2022 09:13:11 +0000
Message-ID: <20220406091311.3354723-8-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.18.0.huawei.25
In-Reply-To: <20220406091311.3354723-1-tongtiangen@huawei.com>
References: <20220406091311.3354723-1-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When user process reading file, the data is cached in pagecache and
the data belongs to the user process, When machine check error is
encountered during pagecache reading, killing the user process and
isolate the user page with hardware memory errors is a more reasonable
choice than kernel panic.

The __arch_copy_mc_to_user() in copy_to_user_mc.S is largely borrows
from __arch_copy_to_user() in copy_to_user.S and the main difference
is __arch_copy_mc_to_user() add the extable entry to support machine
check safe.

In _copy_page_to_iter(), machine check safe only considered ITER_IOVEC
which is used by pagecache reading.

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 arch/arm64/include/asm/uaccess.h | 15 ++++++
 arch/arm64/lib/Makefile          |  2 +-
 arch/arm64/lib/copy_to_user_mc.S | 78 +++++++++++++++++++++++++++++
 include/linux/uio.h              |  9 +++-
 lib/iov_iter.c                   | 85 +++++++++++++++++++++++++-------
 5 files changed, 170 insertions(+), 19 deletions(-)
 create mode 100644 arch/arm64/lib/copy_to_user_mc.S

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uaccess.h
index 24b662407fbd..f0d5e811165a 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -448,6 +448,21 @@ extern long strncpy_from_user(char *dest, const char __user *src, long count);
 
 extern __must_check long strnlen_user(const char __user *str, long n);
 
+#ifdef CONFIG_ARCH_HAS_COPY_MC
+extern unsigned long __must_check __arch_copy_mc_to_user(void __user *to,
+							 const void *from, unsigned long n);
+static inline unsigned long __must_check
+copy_mc_to_user(void __user *to, const void *from, unsigned long n)
+{
+	uaccess_ttbr0_enable();
+	n = __arch_copy_mc_to_user(__uaccess_mask_ptr(to), from, n);
+	uaccess_ttbr0_disable();
+
+	return n;
+}
+#define copy_mc_to_user copy_mc_to_user
+#endif
+
 #ifdef CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE
 struct page;
 void memcpy_page_flushcache(char *to, struct page *page, size_t offset, size_t len);
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 29c578414b12..9b3571227fb4 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -23,4 +23,4 @@ obj-$(CONFIG_ARM64_MTE) += mte.o
 
 obj-$(CONFIG_KASAN_SW_TAGS) += kasan_sw_tags.o
 
-obj-$(CONFIG_ARCH_HAS_CPY_MC) += copy_page_mc.o
+obj-$(CONFIG_ARCH_HAS_COPY_MC) += copy_page_mc.o copy_to_user_mc.o
diff --git a/arch/arm64/lib/copy_to_user_mc.S b/arch/arm64/lib/copy_to_user_mc.S
new file mode 100644
index 000000000000..9d228ff15446
--- /dev/null
+++ b/arch/arm64/lib/copy_to_user_mc.S
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ */
+
+#include <linux/linkage.h>
+
+#include <asm/asm-uaccess.h>
+#include <asm/assembler.h>
+#include <asm/cache.h>
+
+/*
+ * Copy to user space from a kernel buffer (alignment handled by the hardware)
+ *
+ * Parameters:
+ *	x0 - to
+ *	x1 - from
+ *	x2 - n
+ * Returns:
+ *	x0 - bytes not copied
+ */
+	.macro ldrb1 reg, ptr, val
+	1000: ldrb  \reg, [\ptr], \val;
+	_asm_extable_mc 1000b, 9998f;
+	.endm
+
+	.macro strb1 reg, ptr, val
+	user_ldst_mc 9998f, sttrb, \reg, \ptr, \val
+	.endm
+
+	.macro ldrh1 reg, ptr, val
+	1001: ldrh  \reg, [\ptr], \val;
+	_asm_extable_mc 1001b, 9998f;
+	.endm
+
+	.macro strh1 reg, ptr, val
+	user_ldst_mc 9997f, sttrh, \reg, \ptr, \val
+	.endm
+
+	.macro ldr1 reg, ptr, val
+	1002: ldr \reg, [\ptr], \val;
+	_asm_extable_mc 1002b, 9998f;
+	.endm
+
+	.macro str1 reg, ptr, val
+	user_ldst_mc 9997f, sttr, \reg, \ptr, \val
+	.endm
+
+	.macro ldp1 reg1, reg2, ptr, val
+	1003: ldp \reg1, \reg2, [\ptr], \val;
+	_asm_extable_mc 1003b, 9998f;
+	.endm
+
+	.macro stp1 reg1, reg2, ptr, val
+	user_stp 9997f, \reg1, \reg2, \ptr, \val
+	.endm
+
+end	.req	x5
+srcin	.req	x15
+SYM_FUNC_START(__arch_copy_mc_to_user)
+	add	end, x0, x2
+	mov	srcin, x1
+#include "copy_template.S"
+	mov	x0, #0
+	ret
+
+	// Exception fixups
+9997:	cbz	x0, 9998f			// Check machine check exception
+	cmp	dst, dstin
+	b.ne	9998f
+	// Before being absolutely sure we couldn't copy anything, try harder
+	ldrb	tmp1w, [srcin]
+USER(9998f, sttrb tmp1w, [dst])
+	add	dst, dst, #1
+9998:	sub	x0, end, dst			// bytes not copied
+	ret
+SYM_FUNC_END(__arch_copy_mc_to_user)
+EXPORT_SYMBOL(__arch_copy_mc_to_user)
diff --git a/include/linux/uio.h b/include/linux/uio.h
index 739285fe5a2f..539d9ee9b032 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -147,10 +147,17 @@ size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i);
 size_t _copy_from_iter(void *addr, size_t bytes, struct iov_iter *i);
 size_t _copy_from_iter_nocache(void *addr, size_t bytes, struct iov_iter *i);
 
+#ifdef CONFIG_ARCH_HAS_COPY_MC
+size_t copy_mc_page_to_iter(struct page *page, size_t offset, size_t bytes,
+			    struct iov_iter *i);
+#else
+#define copy_mc_page_to_iter copy_page_to_iter
+#endif
+
 static inline size_t copy_folio_to_iter(struct folio *folio, size_t offset,
 		size_t bytes, struct iov_iter *i)
 {
-	return copy_page_to_iter(&folio->page, offset, bytes, i);
+	return copy_mc_page_to_iter(&folio->page, offset, bytes, i);
 }
 
 static __always_inline __must_check
diff --git a/lib/iov_iter.c b/lib/iov_iter.c
index 6dd5330f7a99..2c5f3bb6391d 100644
--- a/lib/iov_iter.c
+++ b/lib/iov_iter.c
@@ -157,6 +157,19 @@ static int copyout(void __user *to, const void *from, size_t n)
 	return n;
 }
 
+#ifdef CONFIG_ARCH_HAS_COPY_MC
+static int copyout_mc(void __user *to, const void *from, size_t n)
+{
+	if (access_ok(to, n)) {
+		instrument_copy_to_user(to, from, n);
+		n = copy_mc_to_user((__force void *) to, from, n);
+	}
+	return n;
+}
+#else
+#define copyout_mc copyout
+#endif
+
 static int copyin(void *to, const void __user *from, size_t n)
 {
 	if (should_fail_usercopy())
@@ -169,7 +182,7 @@ static int copyin(void *to, const void __user *from, size_t n)
 }
 
 static size_t copy_page_to_iter_iovec(struct page *page, size_t offset, size_t bytes,
-			 struct iov_iter *i)
+			 struct iov_iter *i, bool mc_safe)
 {
 	size_t skip, copy, left, wanted;
 	const struct iovec *iov;
@@ -194,7 +207,10 @@ static size_t copy_page_to_iter_iovec(struct page *page, size_t offset, size_t b
 		from = kaddr + offset;
 
 		/* first chunk, usually the only one */
-		left = copyout(buf, from, copy);
+		if (mc_safe)
+			left = copyout_mc(buf, from, copy);
+		else
+			left = copyout(buf, from, copy);
 		copy -= left;
 		skip += copy;
 		from += copy;
@@ -204,7 +220,10 @@ static size_t copy_page_to_iter_iovec(struct page *page, size_t offset, size_t b
 			iov++;
 			buf = iov->iov_base;
 			copy = min(bytes, iov->iov_len);
-			left = copyout(buf, from, copy);
+			if (mc_safe)
+				left = copyout_mc(buf, from, copy);
+			else
+				left = copyout(buf, from, copy);
 			copy -= left;
 			skip = copy;
 			from += copy;
@@ -223,7 +242,10 @@ static size_t copy_page_to_iter_iovec(struct page *page, size_t offset, size_t b
 
 	kaddr = kmap(page);
 	from = kaddr + offset;
-	left = copyout(buf, from, copy);
+	if (mc_safe)
+		left = copyout_mc(buf, from, copy);
+	else
+		left = copyout(buf, from, copy);
 	copy -= left;
 	skip += copy;
 	from += copy;
@@ -232,7 +254,10 @@ static size_t copy_page_to_iter_iovec(struct page *page, size_t offset, size_t b
 		iov++;
 		buf = iov->iov_base;
 		copy = min(bytes, iov->iov_len);
-		left = copyout(buf, from, copy);
+		if (mc_safe)
+			left = copyout_mc(buf, from, copy);
+		else
+			left = copyout(buf, from, copy);
 		copy -= left;
 		skip = copy;
 		from += copy;
@@ -674,15 +699,6 @@ size_t _copy_to_iter(const void *addr, size_t bytes, struct iov_iter *i)
 EXPORT_SYMBOL(_copy_to_iter);
 
 #ifdef CONFIG_ARCH_HAS_COPY_MC
-static int copyout_mc(void __user *to, const void *from, size_t n)
-{
-	if (access_ok(to, n)) {
-		instrument_copy_to_user(to, from, n);
-		n = copy_mc_to_user((__force void *) to, from, n);
-	}
-	return n;
-}
-
 static size_t copy_mc_pipe_to_iter(const void *addr, size_t bytes,
 				struct iov_iter *i)
 {
@@ -846,10 +862,10 @@ static inline bool page_copy_sane(struct page *page, size_t offset, size_t n)
 }
 
 static size_t __copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
-			 struct iov_iter *i)
+			 struct iov_iter *i, bool mc_safe)
 {
 	if (likely(iter_is_iovec(i)))
-		return copy_page_to_iter_iovec(page, offset, bytes, i);
+		return copy_page_to_iter_iovec(page, offset, bytes, i, mc_safe);
 	if (iov_iter_is_bvec(i) || iov_iter_is_kvec(i) || iov_iter_is_xarray(i)) {
 		void *kaddr = kmap_local_page(page);
 		size_t wanted = _copy_to_iter(kaddr + offset, bytes, i);
@@ -878,7 +894,7 @@ size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 	offset %= PAGE_SIZE;
 	while (1) {
 		size_t n = __copy_page_to_iter(page, offset,
-				min(bytes, (size_t)PAGE_SIZE - offset), i);
+				min(bytes, (size_t)PAGE_SIZE - offset), i, false);
 		res += n;
 		bytes -= n;
 		if (!bytes || !n)
@@ -893,6 +909,41 @@ size_t copy_page_to_iter(struct page *page, size_t offset, size_t bytes,
 }
 EXPORT_SYMBOL(copy_page_to_iter);
 
+#ifdef CONFIG_ARCH_HAS_COPY_MC
+/**
+ * copy_mc_page_to_iter - copy page to iter with source memory error exception handling.
+ *
+ * The filemap_read deploys this for pagecache reading and the main differences between
+ * this and typical copy_page_to_iter() is call __copy_page_to_iter with mc_safe true.
+ *
+ * Return: number of bytes copied (may be %0)
+ */
+size_t copy_mc_page_to_iter(struct page *page, size_t offset, size_t bytes,
+			 struct iov_iter *i)
+{
+	size_t res = 0;
+
+	if (unlikely(!page_copy_sane(page, offset, bytes)))
+		return 0;
+	page += offset / PAGE_SIZE; // first subpage
+	offset %= PAGE_SIZE;
+	while (1) {
+		size_t n = __copy_page_to_iter(page, offset,
+				min(bytes, (size_t)PAGE_SIZE - offset), i, true);
+		res += n;
+		bytes -= n;
+		if (!bytes || !n)
+			break;
+		offset += n;
+		if (offset == PAGE_SIZE) {
+			page++;
+			offset = 0;
+		}
+	}
+	return res;
+}
+#endif
+
 size_t copy_page_from_iter(struct page *page, size_t offset, size_t bytes,
 			 struct iov_iter *i)
 {
-- 
2.18.0.huawei.25

