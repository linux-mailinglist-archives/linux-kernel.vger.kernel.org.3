Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77CB9555142
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 18:24:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376531AbiFVQXz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 12:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376875AbiFVQXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 12:23:39 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D35B3FBE5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 09:23:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655915011; x=1687451011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CU7rCkgXezI1vM2ho8MmDRIt7VouvlyZWqM/6FmVbeI=;
  b=nnoNytrxZB+fqjpwNcP2EJB+dWIu0UCQeS7sF5e51yevoCTTyWxvn11T
   ojloXzVX4RBeDLNskb/Fh/Ad9oenxkR66XsGmaFApHY/LLfsw14mKYLN+
   ugBMJ+XlsvCGXtYwm+6aEEkGqWWoVB5+2EDR4bjIfku7A3tcTmUL9Tp8g
   10K7axyybLtUxXcPRxY2gKGA+fqt93PjwdwF1GOcYi8CXhda20lkJIX7h
   wMXbpN30mBzCu804EAbFLvA3ogyHZjV/m4r6hT68w4HI+vBRyQJchec3A
   Vg6V+CnQgMkT5B6yViIF+Ra0MT8kQYQ2Q7DIoIL4QrTLIB5KmOdzn2URR
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="260898822"
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="260898822"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 09:22:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,212,1650956400"; 
   d="scan'208";a="764947851"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 22 Jun 2022 09:22:42 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 6A3F813C; Wed, 22 Jun 2022 19:22:43 +0300 (EEST)
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
Subject: [PATCHv4 7/8] x86: Expose untagging mask in /proc/$PID/arch_status
Date:   Wed, 22 Jun 2022 19:22:29 +0300
Message-Id: <20220622162230.83474-8-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220622162230.83474-1-kirill.shutemov@linux.intel.com>
References: <20220622162230.83474-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a line in /proc/$PID/arch_status to report untag_mask. It can be
used to find out LAM status of the process from the outside. It is
useful for debuggers.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/mmu_context.h | 10 +++++
 arch/x86/kernel/Makefile           |  2 +
 arch/x86/kernel/fpu/xstate.c       | 47 -----------------------
 arch/x86/kernel/proc.c             | 60 ++++++++++++++++++++++++++++++
 4 files changed, 72 insertions(+), 47 deletions(-)
 create mode 100644 arch/x86/kernel/proc.c

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 05821534aadc..a6cded0f5e64 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -103,6 +103,11 @@ static inline void dup_lam(struct mm_struct *oldmm, struct mm_struct *mm)
 	mm->context.untag_mask = oldmm->context.untag_mask;
 }
 
+static inline unsigned long mm_untag_mask(struct mm_struct *mm)
+{
+	return mm->context.untag_mask;
+}
+
 static inline void mm_reset_untag_mask(struct mm_struct *mm)
 {
 	mm->context.untag_mask = -1UL;
@@ -119,6 +124,11 @@ static inline void dup_lam(struct mm_struct *oldmm, struct mm_struct *mm)
 {
 }
 
+static inline unsigned long mm_untag_mask(struct mm_struct *mm)
+{
+	return -1UL;
+}
+
 static inline void mm_reset_untag_mask(struct mm_struct *mm)
 {
 }
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 4c8b6ae802ac..313f1d8e7783 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -141,6 +141,8 @@ obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
 
 obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev.o
 
+obj-$(CONFIG_PROC_FS)			+= proc.o
+
 ###
 # 64 bit specific files
 ifeq ($(CONFIG_X86_64),y)
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index c8340156bfd2..838a6f0627fd 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -10,8 +10,6 @@
 #include <linux/mman.h>
 #include <linux/nospec.h>
 #include <linux/pkeys.h>
-#include <linux/seq_file.h>
-#include <linux/proc_fs.h>
 #include <linux/vmalloc.h>
 
 #include <asm/fpu/api.h>
@@ -1745,48 +1743,3 @@ long fpu_xstate_prctl(int option, unsigned long arg2)
 		return -EINVAL;
 	}
 }
-
-#ifdef CONFIG_PROC_PID_ARCH_STATUS
-/*
- * Report the amount of time elapsed in millisecond since last AVX512
- * use in the task.
- */
-static void avx512_status(struct seq_file *m, struct task_struct *task)
-{
-	unsigned long timestamp = READ_ONCE(task->thread.fpu.avx512_timestamp);
-	long delta;
-
-	if (!timestamp) {
-		/*
-		 * Report -1 if no AVX512 usage
-		 */
-		delta = -1;
-	} else {
-		delta = (long)(jiffies - timestamp);
-		/*
-		 * Cap to LONG_MAX if time difference > LONG_MAX
-		 */
-		if (delta < 0)
-			delta = LONG_MAX;
-		delta = jiffies_to_msecs(delta);
-	}
-
-	seq_put_decimal_ll(m, "AVX512_elapsed_ms:\t", delta);
-	seq_putc(m, '\n');
-}
-
-/*
- * Report architecture specific information
- */
-int proc_pid_arch_status(struct seq_file *m, struct pid_namespace *ns,
-			struct pid *pid, struct task_struct *task)
-{
-	/*
-	 * Report AVX512 state if the processor and build option supported.
-	 */
-	if (cpu_feature_enabled(X86_FEATURE_AVX512F))
-		avx512_status(m, task);
-
-	return 0;
-}
-#endif /* CONFIG_PROC_PID_ARCH_STATUS */
diff --git a/arch/x86/kernel/proc.c b/arch/x86/kernel/proc.c
new file mode 100644
index 000000000000..9765b4d05ce4
--- /dev/null
+++ b/arch/x86/kernel/proc.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0-only
+#include <linux/proc_fs.h>
+#include <linux/sched/mm.h>
+#include <linux/seq_file.h>
+#include <uapi/asm/prctl.h>
+#include <asm/mmu_context.h>
+
+/*
+ * Report the amount of time elapsed in millisecond since last AVX512
+ * use in the task.
+ */
+static void avx512_status(struct seq_file *m, struct task_struct *task)
+{
+	unsigned long timestamp = READ_ONCE(task->thread.fpu.avx512_timestamp);
+	long delta;
+
+	if (!timestamp) {
+		/*
+		 * Report -1 if no AVX512 usage
+		 */
+		delta = -1;
+	} else {
+		delta = (long)(jiffies - timestamp);
+		/*
+		 * Cap to LONG_MAX if time difference > LONG_MAX
+		 */
+		if (delta < 0)
+			delta = LONG_MAX;
+		delta = jiffies_to_msecs(delta);
+	}
+
+	seq_put_decimal_ll(m, "AVX512_elapsed_ms:\t", delta);
+	seq_putc(m, '\n');
+}
+
+/*
+ * Report architecture specific information
+ */
+int proc_pid_arch_status(struct seq_file *m, struct pid_namespace *ns,
+			struct pid *pid, struct task_struct *task)
+{
+	struct mm_struct *mm;
+	unsigned long untag_mask = -1UL;
+
+	/*
+	 * Report AVX512 state if the processor and build option supported.
+	 */
+	if (cpu_feature_enabled(X86_FEATURE_AVX512F))
+		avx512_status(m, task);
+
+	mm = get_task_mm(task);
+	if (mm) {
+		untag_mask = mm_untag_mask(task->mm);
+		mmput(mm);
+	}
+
+	seq_printf(m, "untag_mask:\t%#lx\n", untag_mask);
+
+	return 0;
+}
-- 
2.35.1

