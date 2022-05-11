Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0896C5229CE
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 04:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241421AbiEKCaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 22:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241263AbiEKC3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:29:45 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EFDA21B140
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652236184; x=1683772184;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Gd+nZWXT2Vj5sId1tBKnAzjGgf10Zdvpv1KhXHK183k=;
  b=Zx6av7+RxIk25NKdtYZHace8dWbp+R9syyquj262x8RQyA5SXdO8ihen
   eBlJV87l2ddRe2+I2x2rjzKj7LZGHq6JUYJFKT2yQbntxUtgw/9Yi4C8I
   Rg1LcTvc7tM8Ro7Boi75cUPQu9uffxgWQ7hX3wkzcplgwYQqxj97nwTJ5
   AtWpfn+WRpWLPW512kjOozI10u2epzgJ575oSfYoqci59jNHIQlZNTE1P
   mkcomXyRMqv/scXUQ3KzW6zz5jyMDZLSoUkc1qxpJJzVmqpiPOoiiWNhv
   7EXlpfRmivMBngMxrZxYKZZ/URj+miR7jelODqAsdVSVTk5Hlh9ZDNCcL
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="250093488"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="250093488"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 19:29:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="670166557"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 10 May 2022 19:29:40 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 69FD1646; Wed, 11 May 2022 05:28:01 +0300 (EEST)
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     x86@kernel.org, Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andi Kleen <ak@linux.intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFCv2 09/10] x86/mm: Add userspace API to enable Linear Address Masking
Date:   Wed, 11 May 2022 05:27:50 +0300
Message-Id: <20220511022751.65540-11-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Allow to enable Linear Address Masking via ARCH_THREAD_FEATURE_ENABLE
arch_prctl(2).

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/kernel/process.c    | 21 +++++++++++++++-
 arch/x86/kernel/process.h    |  2 ++
 arch/x86/kernel/process_64.c | 46 ++++++++++++++++++++++++++++++++++++
 3 files changed, 68 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index cb8fc28f2eae..911c24321312 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -46,6 +46,8 @@
 #include <asm/proto.h>
 #include <asm/frame.h>
 #include <asm/unwind.h>
+#include <asm/mmu_context.h>
+#include <asm/compat.h>
 
 #include "process.h"
 
@@ -992,7 +994,9 @@ unsigned long __get_wchan(struct task_struct *p)
 static long thread_feature_prctl(struct task_struct *task, int option,
 				 unsigned long features)
 {
-	const unsigned long known_features = 0;
+	const unsigned long known_features =
+		X86_THREAD_LAM_U48 |
+		X86_THREAD_LAM_U57;
 
 	if (features & ~known_features)
 		return -EINVAL;
@@ -1013,8 +1017,23 @@ static long thread_feature_prctl(struct task_struct *task, int option,
 
 	/* Handle ARCH_THREAD_FEATURE_ENABLE */
 
+	if (features & (X86_THREAD_LAM_U48 | X86_THREAD_LAM_U57)) {
+		long ret;
+
+		/* LAM is only available in long mode */
+		if (in_32bit_syscall())
+			return -EINVAL;
+
+		ret = enable_lam(task, features);
+		if (ret)
+			return ret;
+	}
+
 	task->thread.features |= features;
 out:
+	/* Update CR3 to get LAM active */
+	switch_mm(task->mm, task->mm, task);
+
 	return task->thread.features;
 }
 
diff --git a/arch/x86/kernel/process.h b/arch/x86/kernel/process.h
index 76b547b83232..b8fa0e599c6e 100644
--- a/arch/x86/kernel/process.h
+++ b/arch/x86/kernel/process.h
@@ -4,6 +4,8 @@
 
 #include <asm/spec-ctrl.h>
 
+long enable_lam(struct task_struct *task, unsigned long features);
+
 void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p);
 
 /*
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index e459253649be..a25c51da7005 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -729,6 +729,52 @@ void set_personality_ia32(bool x32)
 }
 EXPORT_SYMBOL_GPL(set_personality_ia32);
 
+static bool lam_u48_allowed(void)
+{
+	struct mm_struct *mm = current->mm;
+
+	if (!full_va_allowed(mm))
+		return true;
+
+	return find_vma(mm, DEFAULT_MAP_WINDOW) == NULL;
+}
+
+long enable_lam(struct task_struct *task, unsigned long features)
+{
+	features |= task->thread.features;
+
+	/* LAM_U48 and LAM_U57 are mutually exclusive */
+	if ((features & X86_THREAD_LAM_U48) && (features & X86_THREAD_LAM_U57))
+		return -EINVAL;
+
+	if (!cpu_feature_enabled(X86_FEATURE_LAM))
+		return -ENXIO;
+
+	if (mmap_write_lock_killable(task->mm))
+		return -EINTR;
+
+	if ((features & X86_THREAD_LAM_U48) && !lam_u48_allowed()) {
+		mmap_write_unlock(task->mm);
+		return -EINVAL;
+	}
+
+	/*
+	 * Record the most permissive (allowing the widest tags) LAM
+	 * mode to the mm context. It determinates if a mappings above
+	 * 47 bit is allowed for the process.
+	 *
+	 * The mode is also used by a kernel thread when it does work
+	 * on behalf of the process (like async I/O, io_uring, etc.)
+	 */
+	if (features & X86_THREAD_LAM_U48)
+		current->mm->context.lam = LAM_U48;
+	else if (current->mm->context.lam == LAM_NONE)
+		current->mm->context.lam = LAM_U57;
+
+	mmap_write_unlock(task->mm);
+	return 0;
+}
+
 #ifdef CONFIG_CHECKPOINT_RESTORE
 static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
 {
-- 
2.35.1

