Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB0450763C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 19:13:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355860AbiDSRKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 13:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355633AbiDSRJz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 13:09:55 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D6525CE
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 10:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650388028; x=1681924028;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IUlIcjFdu0Dobv9fAtc/uX0neIYthgVEegS00Ix8hIg=;
  b=dmRqoDbZnfQk/G6/1nJXiMymlJgMQek+SuumVgsn2r2VhIuwmHipEA9T
   /DLzozVGT9inA1kFTt1DVgWe1U9A1USJpQty28uhuSsZFYkmHmozidkT+
   OHxOrpiaqb3ewejSv0eFfxnyBGo61/dZCdYeMkijxKPcS4xHBjao0WgOo
   dDxqgGnvNSF+thtRYC6L8iNGpeW1lGIngq+VAnQKBn6O6PkvmQxdorrim
   X+0qao69hlsOLtQ7MiaotWEnhs13UqJmzY4qQdiSF0CilE62lizTY/bQE
   qD2IVANSaGZNoQlW4QiFMJHYBy6VqidGEgNdX+dKTZyOawWI+Fp3629/8
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="324261459"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="324261459"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:02 -0700
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="561781853"
Received: from ajacosta-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.11.4])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:07:01 -0700
From:   ira.weiny@intel.com
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V10 13/44] x86/pkeys: Preserve the PKS MSR on context switch
Date:   Tue, 19 Apr 2022 10:06:18 -0700
Message-Id: <20220419170649.1022246-14-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419170649.1022246-1-ira.weiny@intel.com>
References: <20220419170649.1022246-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The PKS MSR (PKRS) is a per-logical-processor register.  Unfortunately,
the MSR is not managed by XSAVE.  Therefore, software must save/restore
the MSR value on context switch.

Allocate space in thread_struct to hold the saved MSR value.  Ensure all
tasks, including the init_task are properly initialized.  Set the CPU
PKRS value when a task is scheduled.

Co-developed-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes for V9
	From Dave Hansen
		Clarify the commit message
		s/pks_saved_pkrs/pkrs/
		s/pks_write_current/x86_pkrs_load/
		Change x86_pkrs_load to take the next thread instead of
			'current'

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
 arch/x86/include/asm/processor.h | 15 ++++++++++++++-
 arch/x86/kernel/process_64.c     |  2 ++
 arch/x86/mm/pkeys.c              |  9 +++++++++
 4 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pks.h b/arch/x86/include/asm/pks.h
index 8180fc59790b..a7bad7301783 100644
--- a/arch/x86/include/asm/pks.h
+++ b/arch/x86/include/asm/pks.h
@@ -5,10 +5,12 @@
 #ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
 
 void pks_setup(void);
+void x86_pkrs_load(struct thread_struct *thread);
 
 #else /* !CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
 
 static inline void pks_setup(void) { }
+static inline void x86_pkrs_load(struct thread_struct *thread) { }
 
 #endif /* CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS */
 
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 91d0f93a00c7..d52970816594 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -2,6 +2,8 @@
 #ifndef _ASM_X86_PROCESSOR_H
 #define _ASM_X86_PROCESSOR_H
 
+#include <linux/pks-keys.h>
+
 #include <asm/processor-flags.h>
 
 /* Forward declaration, a strange C thing */
@@ -529,6 +531,10 @@ struct thread_struct {
 	 * PKRU is the hardware itself.
 	 */
 	u32			pkru;
+#ifdef	CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
+	/* Saved Protection key register for supervisor mappings */
+	u32			pkrs;
+#endif
 
 	/* Floating point and extended processor state */
 	struct fpu		fpu;
@@ -771,7 +777,14 @@ static inline void spin_lock_prefetch(const void *x)
 #define KSTK_ESP(task)		(task_pt_regs(task)->sp)
 
 #else
-#define INIT_THREAD { }
+
+#ifdef CONFIG_ARCH_ENABLE_SUPERVISOR_PKEYS
+#define INIT_THREAD  {			\
+	.pkrs = PKS_INIT_VALUE,		\
+}
+#else
+#define INIT_THREAD  { }
+#endif
 
 extern unsigned long KSTK_ESP(struct task_struct *task);
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index e459253649be..5cfa1f8c8465 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -59,6 +59,7 @@
 /* Not included via unistd.h */
 #include <asm/unistd_32_ia32.h>
 #endif
+#include <asm/pks.h>
 
 #include "process.h"
 
@@ -612,6 +613,7 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	x86_fsgsbase_load(prev, next);
 
 	x86_pkru_load(prev, next);
+	x86_pkrs_load(next);
 
 	/*
 	 * Switch the PDA and FPU contexts.
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index 10521f1a292e..39e4c2cbc279 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -246,6 +246,15 @@ static inline void pks_write_pkrs(u32 new_pkrs)
 	}
 }
 
+/* x86_pkrs_load() - Update CPU with the incoming thread pkrs value */
+void x86_pkrs_load(struct thread_struct *thread)
+{
+	if (!cpu_feature_enabled(X86_FEATURE_PKS))
+		return;
+
+	pks_write_pkrs(thread->pkrs);
+}
+
 /*
  * PKS is independent of PKU and either or both may be supported on a CPU.
  *
-- 
2.35.1

