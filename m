Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3267049E95A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244824AbiA0RzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:55:23 -0500
Received: from mga02.intel.com ([134.134.136.20]:19413 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244671AbiA0RzO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:55:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643306114; x=1674842114;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7XL+oRdHoLQGSDa1tB4Piu4QrCM6QEHvL+tEBVcvpp4=;
  b=TOXo11Wz+4qgmoT6wWvN2nwg4JOQPbbYmTBqNOCwQlFgMaRDDY4q3BNo
   Dbi0DJLQHKGuvRMVNQotbnK/CWwcvatXat+qF0pR774HEHoIoQa+jsBxu
   dP9rOZb3OVXrOXoyUDzDEyUDcJKtaaWi5CGFu6fJmAHDCeRmgnaDfcChc
   iRdeTIkK7o22OnmHia2yLazNT3CbuolvkMJ0lae4FsDltH5ahYeUlWzGj
   t3/5XoDeq4JbQ7HBY7fuPMVz2UPDAdBgwBMBxIylJJlAnAeL9vif3kFB+
   hkPjTVaPni7SO7IArPMnM6bPMUJx3s2jKe7vv4ss6/UdeL79ljo8e6Lya
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="234302425"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="234302425"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:09 -0800
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="674796095"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:55:09 -0800
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V8 15/44] x86/pkeys: Preserve the PKS MSR on context switch
Date:   Thu, 27 Jan 2022 09:54:36 -0800
Message-Id: <20220127175505.851391-16-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127175505.851391-1-ira.weiny@intel.com>
References: <20220127175505.851391-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The PKS MSR (PKRS) is defined as a per-logical-processor register.  This
isolates memory access by logical CPU.  Unfortunately, the MSR is not
managed by XSAVE.  Therefore, tasks must save/restore the MSR value on
context switch.

Define pks_saved_pkrs in struct thread_struct.  Initialize all tasks,
including the init_task, with the PKS_INIT_VALUE when created.  Restore
the CPU's MSR to the saved task value on schedule in.

pks_write_current() is added to ensures non-supervisor pkey
configurations compile correctly without pks_saved_pkrs in thread_struct
as well as ensuring CPUs without PKS support are ignored.

NOTE The value of pks_saved_pkrs does not change with this patch.  That
is left for future patches.

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V8
	From Thomas
		Ensure pkrs_write_current() does not suffer the overhead
		of preempt disable.
		Fix setting of initial value
		Remove flawed and broken create_initial_pkrs_value() in
			favor of a much simpler and robust macro default
		Update function names to be consistent.

	s/pkrs_write_current/pks_write_current
		This is a more consistent name
	s/saved_pkrs/pks_saved_pkrs
	s/pkrs_init_value/PKS_INIT_VALUE
	Remove pks_init_task()
		This function was added mainly to avoid the header file
		issue.  Adding pks-keys.h solved that and saves the
		complexity.

Changes for V7
	Move definitions from asm/processor.h to asm/pks.h
	s/INIT_PKRS_VALUE/pkrs_init_value
	Change pks_init_task()/pks_sched_in() to functions
	s/pks_sched_in/pks_write_current to be used more generically
	later in the series
---
 arch/x86/include/asm/pks.h       |  2 ++
 arch/x86/include/asm/processor.h | 17 ++++++++++++++++-
 arch/x86/kernel/process_64.c     |  3 +++
 arch/x86/mm/pkeys.c              | 13 +++++++++++++
 4 files changed, 34 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pks.h b/arch/x86/include/asm/pks.h
index 8180fc59790b..d211bf36492c 100644
--- a/arch/x86/include/asm/pks.h
+++ b/arch/x86/include/asm/pks.h
@@ -5,10 +5,12 @@
 #ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
 
 void pks_setup(void);
+void pks_write_current(void);
 
 #else /* !CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
 
 static inline void pks_setup(void) { }
+static inline void pks_write_current(void) { }
 
 #endif /* CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
 
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 2c5f12ae7d04..3530a0e50b4f 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_PROCESSOR_H
 #define _ASM_X86_PROCESSOR_H
 
+#include <linux/pks-keys.h>
+
 #include <asm/processor-flags.h>
 
 /* Forward declaration, a strange C thing */
@@ -502,6 +504,12 @@ struct thread_struct {
 	unsigned long		cr2;
 	unsigned long		trap_nr;
 	unsigned long		error_code;
+
+#ifdef	CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
+	/* Saved Protection key register for supervisor mappings */
+	u32			pks_saved_pkrs;
+#endif
+
 #ifdef CONFIG_VM86
 	/* Virtual 86 mode info */
 	struct vm86		*vm86;
@@ -769,7 +777,14 @@ static inline void spin_lock_prefetch(const void *x)
 #define KSTK_ESP(task)		(task_pt_regs(task)->sp)
 
 #else
-#define INIT_THREAD { }
+
+#ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
+#define INIT_THREAD  {					\
+	.pks_saved_pkrs = PKS_INIT_VALUE,		\
+}
+#else
+#define INIT_THREAD  { }
+#endif
 
 extern unsigned long KSTK_ESP(struct task_struct *task);
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 3402edec236c..81fc0b638308 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -59,6 +59,7 @@
 /* Not included via unistd.h */
 #include <asm/unistd_32_ia32.h>
 #endif
+#include <asm/pks.h>
 
 #include "process.h"
 
@@ -657,6 +658,8 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	/* Load the Intel cache allocation PQR MSR. */
 	resctrl_sched_in();
 
+	pks_write_current();
+
 	return prev_p;
 }
 
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 3dce99ef4127..6d94dfc9a219 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -242,6 +242,19 @@ static inline void pks_write_pkrs(u32 new_pkrs)
 	}
 }
 
+/**
+ * pks_write_current() - Write the current thread's saved PKRS value
+ *
+ * Context: must be called with preemption disabled
+ */
+void pks_write_current(void)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_PKS))
+		return;
+
+	pks_write_pkrs(current->thread.pks_saved_pkrs);
+}
+
 /*
  * PKS is independent of PKU and either or both may be supported on a CPU.
  *
-- 
2.31.1

