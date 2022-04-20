Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDBE7507F0D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 04:46:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359041AbiDTCsi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 22:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359019AbiDTCsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:48:24 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0F531DFC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 19:45:39 -0700 (PDT)
Received: from kwepemi500009.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KjlKh2Q8MzCr9W;
        Wed, 20 Apr 2022 10:41:12 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500009.china.huawei.com (7.221.188.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 10:45:37 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 20 Apr 2022 10:45:35 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Robin Murphy <robin.murphy@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>
CC:     <linuxppc-dev@lists.ozlabs.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Xie XiuQi <xiexiuqi@huawei.com>,
        Guohanjun <guohanjun@huawei.com>,
        Tong Tiangen <tongtiangen@huawei.com>
Subject: [PATCH -next v4 3/7] arm64: add support for machine check error safe
Date:   Wed, 20 Apr 2022 03:04:14 +0000
Message-ID: <20220420030418.3189040-4-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220420030418.3189040-1-tongtiangen@huawei.com>
References: <20220420030418.3189040-1-tongtiangen@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
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

During the processing of arm64 kernel hardware memory errors(do_sea()), if
the errors is consumed in the kernel, the current processing is panic.
However, it is not optimal.

Take uaccess for example, if the uaccess operation fails due to memory
error, only the user process will be affected, kill the user process
and isolate the user page with hardware memory errors is a better choice.

This patch only enable machine error check framework, it add exception
fixup before kernel panic in do_sea() and only limit the consumption of
hardware memory errors in kernel mode triggered by user mode processes.
If fixup successful, panic can be avoided.

Consistent with PPC/x86, it is implemented by CONFIG_ARCH_HAS_COPY_MC.

Also add copy_mc_to_user() in include/linux/uaccess.h, this helper is
called when CONFIG_ARCH_HAS_COPOY_MC is open.

Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
---
 arch/arm64/Kconfig               |  1 +
 arch/arm64/include/asm/extable.h |  1 +
 arch/arm64/mm/extable.c          | 17 +++++++++++++++++
 arch/arm64/mm/fault.c            | 27 ++++++++++++++++++++++++++-
 include/linux/uaccess.h          |  9 +++++++++
 5 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index d9325dd95eba..012e38309955 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -19,6 +19,7 @@ config ARM64
 	select ARCH_ENABLE_SPLIT_PMD_PTLOCK if PGTABLE_LEVELS > 2
 	select ARCH_ENABLE_THP_MIGRATION if TRANSPARENT_HUGEPAGE
 	select ARCH_HAS_CACHE_LINE_SIZE
+	select ARCH_HAS_COPY_MC if ACPI_APEI_GHES
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEBUG_VM_PGTABLE
diff --git a/arch/arm64/include/asm/extable.h b/arch/arm64/include/asm/extable.h
index 72b0e71cc3de..f80ebd0addfd 100644
--- a/arch/arm64/include/asm/extable.h
+++ b/arch/arm64/include/asm/extable.h
@@ -46,4 +46,5 @@ bool ex_handler_bpf(const struct exception_table_entry *ex,
 #endif /* !CONFIG_BPF_JIT */
 
 bool fixup_exception(struct pt_regs *regs);
+bool fixup_exception_mc(struct pt_regs *regs);
 #endif
diff --git a/arch/arm64/mm/extable.c b/arch/arm64/mm/extable.c
index 489455309695..4f0083a550d4 100644
--- a/arch/arm64/mm/extable.c
+++ b/arch/arm64/mm/extable.c
@@ -9,6 +9,7 @@
 
 #include <asm/asm-extable.h>
 #include <asm/ptrace.h>
+#include <asm/esr.h>
 
 static inline unsigned long
 get_ex_fixup(const struct exception_table_entry *ex)
@@ -84,3 +85,19 @@ bool fixup_exception(struct pt_regs *regs)
 
 	BUG();
 }
+
+bool fixup_exception_mc(struct pt_regs *regs)
+{
+	const struct exception_table_entry *ex;
+
+	ex = search_exception_tables(instruction_pointer(regs));
+	if (!ex)
+		return false;
+
+	/*
+	 * This is not complete, More Machine check safe extable type can
+	 * be processed here.
+	 */
+
+	return false;
+}
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 77341b160aca..a9e6fb1999d1 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -695,6 +695,29 @@ static int do_bad(unsigned long far, unsigned int esr, struct pt_regs *regs)
 	return 1; /* "fault" */
 }
 
+static bool arm64_do_kernel_sea(unsigned long addr, unsigned int esr,
+				     struct pt_regs *regs, int sig, int code)
+{
+	if (!IS_ENABLED(CONFIG_ARCH_HAS_COPY_MC))
+		return false;
+
+	if (user_mode(regs) || !current->mm)
+		return false;
+
+	if (apei_claim_sea(regs) < 0)
+		return false;
+
+	if (!fixup_exception_mc(regs))
+		return false;
+
+	set_thread_esr(0, esr);
+
+	arm64_force_sig_fault(sig, code, addr,
+		"Uncorrected hardware memory error in kernel-access\n");
+
+	return true;
+}
+
 static int do_sea(unsigned long far, unsigned int esr, struct pt_regs *regs)
 {
 	const struct fault_info *inf;
@@ -720,7 +743,9 @@ static int do_sea(unsigned long far, unsigned int esr, struct pt_regs *regs)
 		 */
 		siaddr  = untagged_addr(far);
 	}
-	arm64_notify_die(inf->name, regs, inf->sig, inf->code, siaddr, esr);
+
+	if (!arm64_do_kernel_sea(siaddr, esr, regs, inf->sig, inf->code))
+		arm64_notify_die(inf->name, regs, inf->sig, inf->code, siaddr, esr);
 
 	return 0;
 }
diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 546179418ffa..884661b29c17 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -174,6 +174,15 @@ copy_mc_to_kernel(void *dst, const void *src, size_t cnt)
 }
 #endif
 
+#ifndef copy_mc_to_user
+static inline unsigned long __must_check
+copy_mc_to_user(void *dst, const void *src, size_t cnt)
+{
+	check_object_size(src, cnt, true);
+	return raw_copy_to_user(dst, src, cnt);
+}
+#endif
+
 static __always_inline void pagefault_disabled_inc(void)
 {
 	current->pagefault_disabled++;
-- 
2.25.1

