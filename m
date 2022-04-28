Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59EE1512A0C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 05:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242353AbiD1Di0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 23:38:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242309AbiD1DiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 23:38:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F032AE24;
        Wed, 27 Apr 2022 20:35:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17C8BB82AEB;
        Thu, 28 Apr 2022 03:35:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98E55C385A9;
        Thu, 28 Apr 2022 03:34:58 +0000 (UTC)
From:   Greg Ungerer <gerg@linux-m68k.org>
To:     linux-m68k@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org, dalias@libc.org,
        Greg Ungerer <gerg@linux-m68k.org>
Subject: [PATCH 2/4] m68knommu: implement minimal regset support
Date:   Thu, 28 Apr 2022 13:33:17 +1000
Message-Id: <20220428033319.239341-3-gerg@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220428033319.239341-1-gerg@linux-m68k.org>
References: <20220428033319.239341-1-gerg@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add code support to the m68k architecture for regsets.

Currently the only thing that will need to use regsets for m68k will be
coredump support of the elf_fdpic loader. So the changes are conditional
on that. The added support is the minimum definitions required to support
just that.

Signed-off-by: Greg Ungerer <gerg@linux-m68k.org>
---
 arch/m68k/kernel/ptrace.c | 58 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 58 insertions(+)

diff --git a/arch/m68k/kernel/ptrace.c b/arch/m68k/kernel/ptrace.c
index 6342ff4d2073..4349b9c4dd68 100644
--- a/arch/m68k/kernel/ptrace.c
+++ b/arch/m68k/kernel/ptrace.c
@@ -19,6 +19,8 @@
 #include <linux/ptrace.h>
 #include <linux/user.h>
 #include <linux/signal.h>
+#include <linux/regset.h>
+#include <linux/elf.h>
 
 #include <linux/uaccess.h>
 #include <asm/page.h>
@@ -291,3 +293,59 @@ asmlinkage void syscall_trace_leave(void)
 		ptrace_report_syscall_exit(task_pt_regs(current), 0);
 }
 #endif /* CONFIG_COLDFIRE */
+
+#if defined(CONFIG_BINFMT_ELF_FDPIC) && defined(CONFIG_ELF_CORE)
+/*
+ * Currently the only thing that needs to use regsets for m68k is the
+ * coredump support of the elf_fdpic loader. Implement the minimum
+ * definitions required for that.
+ */
+static int m68k_regset_get(struct task_struct *target,
+			   const struct user_regset *regset,
+			   struct membuf to)
+{
+	struct pt_regs *ptregs = task_pt_regs(target);
+	u32 uregs[ELF_NGREG];
+
+	ELF_CORE_COPY_REGS(uregs, ptregs);
+	return membuf_write(&to, uregs, sizeof(uregs));
+}
+
+enum m68k_regset {
+	REGSET_GPR,
+#ifdef CONFIG_FPU
+	REGSET_FPU,
+#endif
+};
+
+static const struct user_regset m68k_user_regsets[] = {
+	[REGSET_GPR] = {
+		.core_note_type = NT_PRSTATUS,
+		.n = ELF_NGREG,
+		.size = sizeof(u32),
+		.align = sizeof(u16),
+		.regset_get = m68k_regset_get,
+	},
+#ifdef CONFIG_FPU
+	[REGSET_FPU] = {
+		.core_note_type = NT_PRFPREG,
+		.n = sizeof(struct user_m68kfp_struct) / sizeof(u32),
+		.size = sizeof(u32),
+		.align = sizeof(u32),
+	}
+#endif /* CONFIG_FPU */
+};
+
+static const struct user_regset_view user_m68k_view = {
+	.name = "m68k",
+	.e_machine = EM_68K,
+	.ei_osabi = ELF_OSABI,
+	.regsets = m68k_user_regsets,
+	.n = ARRAY_SIZE(m68k_user_regsets)
+};
+
+const struct user_regset_view *task_user_regset_view(struct task_struct *task)
+{
+	return &user_m68k_view;
+}
+#endif /* CONFIG_BINFMT_ELF_FDPIC && CONFIG_ELF_CORE */
-- 
2.25.1

