Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D88B5229D9
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 04:47:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241333AbiEKCaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 22:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241244AbiEKC3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:29:45 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFAD3219C01
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 19:29:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652236180; x=1683772180;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5G0RO9Jzv5sMl5l3KPmaPojaLlcXXs9/0fmVZgdGWDk=;
  b=NLqC9Zr2qIDkvZQ2vNnnIW/ci0JMlX8OUV9uJOQmjK+TSCXShq7dC1nP
   WSBdHl6j0sqsdTveMqZSs0kc9Mjv3lMKWHrWRFYb8pFqgm91IRZt+5ZSo
   KRArKAQ3MGG4v11ZqOKb8nmlb4QZJZ7HPG+xfZB+j5unhmaCKR3Kqo5uE
   X02s974ZixwaEOhJnvEfHK4lMzsaPfx3ryBv/D7G14jkXIUaOhzw4aiwF
   iJ2vovKyzA2DPtdGP24ZSdrOWEnvmmyp/KZuh1RR3FQSqL/WtQp0Y9FxY
   IkU42T3JbaZ7gIrReGdITWL1E/mdRzmyp0LMgaC/fMQfM5XEJ/918KxcK
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10343"; a="251610732"
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="251610732"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 19:29:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,215,1647327600"; 
   d="scan'208";a="895145510"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga005.fm.intel.com with ESMTP; 10 May 2022 19:29:36 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
        id 2BB1B556; Wed, 11 May 2022 05:28:01 +0300 (EEST)
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
Subject: [RFCv2 03/10] x86: Introduce userspace API to handle per-thread features
Date:   Wed, 11 May 2022 05:27:44 +0300
Message-Id: <20220511022751.65540-5-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
References: <20220511022751.65540-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add three new arch_prctl() handles:

 - ARCH_THREAD_FEATURE_ENABLE/DISABLE enables or disables the specified
   features. Returns what features are enabled after the operation.

 - ARCH_THREAD_FEATURE_LOCK prevents future disabling or enabling of the
   specified features. Returns the new set of locked features.

The features handled per-thread and inherited over fork(2)/clone(2), but
reset on exec().

This is preparation patch. It does not impelement any features.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/processor.h  |  3 +++
 arch/x86/include/uapi/asm/prctl.h |  5 +++++
 arch/x86/kernel/process.c         | 37 +++++++++++++++++++++++++++++++
 3 files changed, 45 insertions(+)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 91d0f93a00c7..ff0c34e18cc6 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -530,6 +530,9 @@ struct thread_struct {
 	 */
 	u32			pkru;
 
+	unsigned long		features;
+	unsigned long		features_locked;
+
 	/* Floating point and extended processor state */
 	struct fpu		fpu;
 	/*
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 500b96e71f18..67fc30d36c73 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -20,4 +20,9 @@
 #define ARCH_MAP_VDSO_32		0x2002
 #define ARCH_MAP_VDSO_64		0x2003
 
+/* Never implement 0x3001, it will confuse old glibc's */
+#define ARCH_THREAD_FEATURE_ENABLE	0x3002
+#define ARCH_THREAD_FEATURE_DISABLE	0x3003
+#define ARCH_THREAD_FEATURE_LOCK	0x3004
+
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b370767f5b19..cb8fc28f2eae 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -367,6 +367,10 @@ void arch_setup_new_exec(void)
 		task_clear_spec_ssb_noexec(current);
 		speculation_ctrl_update(read_thread_flags());
 	}
+
+	/* Reset thread features on exec */
+	current->thread.features = 0;
+	current->thread.features_locked = 0;
 }
 
 #ifdef CONFIG_X86_IOPL_IOPERM
@@ -985,6 +989,35 @@ unsigned long __get_wchan(struct task_struct *p)
 	return addr;
 }
 
+static long thread_feature_prctl(struct task_struct *task, int option,
+				 unsigned long features)
+{
+	const unsigned long known_features = 0;
+
+	if (features & ~known_features)
+		return -EINVAL;
+
+	if (option == ARCH_THREAD_FEATURE_LOCK) {
+		task->thread.features_locked |= features;
+		return task->thread.features_locked;
+	}
+
+	/* Do not allow to change locked features */
+	if (features & task->thread.features_locked)
+		return -EPERM;
+
+	if (option == ARCH_THREAD_FEATURE_DISABLE) {
+		task->thread.features &= ~features;
+		goto out;
+	}
+
+	/* Handle ARCH_THREAD_FEATURE_ENABLE */
+
+	task->thread.features |= features;
+out:
+	return task->thread.features;
+}
+
 long do_arch_prctl_common(struct task_struct *task, int option,
 			  unsigned long arg2)
 {
@@ -999,6 +1032,10 @@ long do_arch_prctl_common(struct task_struct *task, int option,
 	case ARCH_GET_XCOMP_GUEST_PERM:
 	case ARCH_REQ_XCOMP_GUEST_PERM:
 		return fpu_xstate_prctl(task, option, arg2);
+	case ARCH_THREAD_FEATURE_ENABLE:
+	case ARCH_THREAD_FEATURE_DISABLE:
+	case ARCH_THREAD_FEATURE_LOCK:
+		return thread_feature_prctl(task, option, arg2);
 	}
 
 	return -EINVAL;
-- 
2.35.1

