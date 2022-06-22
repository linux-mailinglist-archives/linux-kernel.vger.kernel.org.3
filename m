Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE58855513F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359207AbiFVQXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376551AbiFVQWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:22:50 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50F263F89D
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655914967; x=1687450967;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OChFIveiqJ9oJhDxBw4UZzfrhSKP5CJTbXz/rUdgIPw=;
  b=h78V+TI6//c4pmfFX+D8q23p8Kzmg9xgrRHwwWtv7WS+4Jqs3nSCWekO
   NLqI0gTRsxFseblVDbuZDn8ugNjk+Q21AJsfA2mPSoyGx7XZK9pvlMx0H
   xixz3nbhVVTRs42tVQEB7waytphjiqSWAaC46Kaoh+aVLxK+cp3fxL0OI
   nI2aXwN6iZO4nFlDbq+ciEkWCpKOwFUdyYKplNNxRt5UvP+W1ZH/kmySm
   at/HzQ6B9kyieqH5xGpvVFiX6/+0dryqNU2ytFT0hQzw3EyZlp8LeQlqN
   4RJ03t0LORxVDFddDgd4MOGCgXPp8FABH+OKQr208Iz+ZPT6VlBaoiR6f
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="278013495"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="278013495"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 09:22:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="592264461"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga007.fm.intel.com with ESMTP; 22 Jun 2022 09:22:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 52A1F36A; Wed, 22 Jun 2022 19:22:43 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Kostya Serebryany <kcc@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [PATCHv4 5/8] x86/uaccess: Provide untagged_addr() and remove tags before address check
Date:   Wed, 22 Jun 2022 19:22:27 +0300
Message-Id: <20220622162230.83474-6-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220622162230.83474-1-kirill.shutemov@linux.intel.com>
References: <20220622162230.83474-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

untagged_addr() is a helper used by the core-mm to strip tag bits and
get the address to the canonical shape. In only handles userspace
addresses. The untagging mask is stored in mmu_context and will be set
on enabling LAM for the process.

The tags must not be included into check whether it's okay to access the
userspace address.

Strip tags in access_ok().

get_user() and put_user() don't use access_ok(), but check access
against TASK_SIZE directly in assembly. Strip tags, before calling into
the assembly helper.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/mmu.h         |  1 +
 arch/x86/include/asm/mmu_context.h | 11 ++++++++
 arch/x86/include/asm/uaccess.h     | 42 +++++++++++++++++++++++++++---
 arch/x86/kernel/process.c          |  3 +++
 4 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index d150e92163b6..59c617fc7c6f 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -41,6 +41,7 @@ typedef struct {
 #ifdef CONFIG_X86_64
 	unsigned short flags;
 	u64 lam_cr3_mask;
+	u64 untag_mask;
 #endif
 
 	struct mutex lock;
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index e6eac047c728..05821534aadc 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -100,6 +100,12 @@ static inline u64 mm_cr3_lam_mask(struct mm_struct *mm)
 static inline void dup_lam(struct mm_struct *oldmm, struct mm_struct *mm)
 {
 	mm->context.lam_cr3_mask = oldmm->context.lam_cr3_mask;
+	mm->context.untag_mask = oldmm->context.untag_mask;
+}
+
+static inline void mm_reset_untag_mask(struct mm_struct *mm)
+{
+	mm->context.untag_mask = -1UL;
 }
 
 #else
@@ -112,6 +118,10 @@ static inline u64 mm_cr3_lam_mask(struct mm_struct *mm)
 static inline void dup_lam(struct mm_struct *oldmm, struct mm_struct *mm)
 {
 }
+
+static inline void mm_reset_untag_mask(struct mm_struct *mm)
+{
+}
 #endif
 
 #define enter_lazy_tlb enter_lazy_tlb
@@ -138,6 +148,7 @@ static inline int init_new_context(struct task_struct *tsk,
 		mm->context.execute_only_pkey = -1;
 	}
 #endif
+	mm_reset_untag_mask(mm);
 	init_new_context_ldt(mm);
 	return 0;
 }
diff --git a/arch/x86/include/asm/uaccess.h b/arch/x86/include/asm/uaccess.h
index 913e593a3b45..803241dfc473 100644
--- a/arch/x86/include/asm/uaccess.h
+++ b/arch/x86/include/asm/uaccess.h
@@ -6,6 +6,7 @@
  */
 #include <linux/compiler.h>
 #include <linux/kasan-checks.h>
+#include <linux/mm_types.h>
 #include <linux/string.h>
 #include <asm/asm.h>
 #include <asm/page.h>
@@ -20,6 +21,30 @@ static inline bool pagefault_disabled(void);
 # define WARN_ON_IN_IRQ()
 #endif
 
+#ifdef CONFIG_X86_64
+/*
+ * Mask out tag bits from the address.
+ *
+ * Magic with the 'sign' allows to untag userspace pointer without any branches
+ * while leaving kernel addresses intact.
+ */
+#define untagged_addr(mm, addr)	({					\
+	u64 __addr = (__force u64)(addr);				\
+	s64 sign = (s64)__addr >> 63;					\
+	__addr &= (mm)->context.untag_mask | sign;			\
+	(__force __typeof__(addr))__addr;				\
+})
+
+#define untagged_ptr(mm, ptr)	({					\
+	u64 __ptrval = (__force u64)(ptr);				\
+	__ptrval = untagged_addr(mm, __ptrval);				\
+	(__force __typeof__(*(ptr)) *)__ptrval;				\
+})
+#else
+#define untagged_addr(mm, addr)	(addr)
+#define untagged_ptr(mm, ptr)	(ptr)
+#endif
+
 /**
  * access_ok - Checks if a user space pointer is valid
  * @addr: User space pointer to start of block to check
@@ -40,7 +65,7 @@ static inline bool pagefault_disabled(void);
 #define access_ok(addr, size)					\
 ({									\
 	WARN_ON_IN_IRQ();						\
-	likely(__access_ok(addr, size));				\
+	likely(__access_ok(untagged_addr(current->mm, addr), size));	\
 })
 
 #include <asm-generic/access_ok.h>
@@ -125,7 +150,13 @@ extern int __get_user_bad(void);
  * Return: zero on success, or -EFAULT on error.
  * On error, the variable @x is set to zero.
  */
-#define get_user(x,ptr) ({ might_fault(); do_get_user_call(get_user,x,ptr); })
+#define get_user(x,ptr)							\
+({									\
+	__typeof__(*(ptr)) __user *__ptr_clean;				\
+	__ptr_clean = untagged_ptr(current->mm, ptr);			\
+	might_fault();							\
+	do_get_user_call(get_user,x,__ptr_clean);			\
+})
 
 /**
  * __get_user - Get a simple variable from user space, with less checking.
@@ -222,7 +253,12 @@ extern void __put_user_nocheck_8(void);
  *
  * Return: zero on success, or -EFAULT on error.
  */
-#define put_user(x, ptr) ({ might_fault(); do_put_user_call(put_user,x,ptr); })
+#define put_user(x, ptr) ({						\
+	__typeof__(*(ptr)) __user *__ptr_clean;				\
+	__ptr_clean = untagged_ptr(current->mm, ptr);			\
+	might_fault();							\
+	do_put_user_call(put_user,x,__ptr_clean);			\
+})
 
 /**
  * __put_user - Write a simple value into user space, with less checking.
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 9b2772b7e1f3..18b2bfdf7b9b 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -47,6 +47,7 @@
 #include <asm/frame.h>
 #include <asm/unwind.h>
 #include <asm/tdx.h>
+#include <asm/mmu_context.h>
 
 #include "process.h"
 
@@ -367,6 +368,8 @@ void arch_setup_new_exec(void)
 		task_clear_spec_ssb_noexec(current);
 		speculation_ctrl_update(read_thread_flags());
 	}
+
+	mm_reset_untag_mask(current->mm);
 }
 
 #ifdef CONFIG_X86_IOPL_IOPERM
-- 
2.35.1

