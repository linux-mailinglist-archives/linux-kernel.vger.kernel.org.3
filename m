Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 175165836A1
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 04:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbiG1CDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 22:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233438AbiG1CDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 22:03:23 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11E764F6BF;
        Wed, 27 Jul 2022 19:03:22 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id t15so333856ilm.7;
        Wed, 27 Jul 2022 19:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OP/gI+cc/a9ksDLMqrE+cy6IXUld4Z3z8e3cv+rJevc=;
        b=q4wCNGpi9F9R0vYn2hX/ftOwc9M5kPE0rjRWp4ZFGWElhlUtwMKN1DQEq+mKhHw5iE
         GGOSAG0VR+HPIpRnUALGv7/DSSkGg9siDE74uBlYtQXSOPC7ohL9JtbgFbBl6Dx/NFL9
         1Q3PCD7XVWCk0dFtd1mhhgZTyvXDKVrhlDvqrhHCdHQrUeiowhPL3RCtst5Sk6DXm0L8
         mqocBAuq90GGaGKyGwukLbIk2Vo3nI4A2+5KqMP94jovMr6aWQJO89y67F7qUhfhbQh3
         ql8hZyj1iVApeG2DJo4ZflH6IF9jc1xJ4wqRsUto8L3ydM4hi+cPWN37TFJufie78heP
         I4Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OP/gI+cc/a9ksDLMqrE+cy6IXUld4Z3z8e3cv+rJevc=;
        b=REQOC78h6dXETads9f3iXoIMF6sxR4yOAAVhqqYxHLG1SP/eqUe/F0Txl8W+7t/UqI
         lTs1yj6EGa/A/VgyDfTodxXxJCuws8GLGdbxSenjZwmrBMlb586A0DQsSGeA0uaAGo5m
         wXMgaiLNQ0ztWsUZL9chzEK2Ygx0NgOJs1vBo0F/CdiXDBAx+QnXMBpyMb0xmBIz37dx
         cePeb1nBbjXil2tz6EDaArwxrPpL7Y1RVmuBYO4dTtXvCvsdxs2tTeurZbsMGVu8S8J+
         tnezVB7LHSSteEKpo2QMbjSyMrSXqAXiNESSKD4cCFD04xScenSsfFipxOiST5bg8+e0
         1/Jg==
X-Gm-Message-State: AJIora+DmIiePJNvEAoa/cdvBdcin+0TnWRVvMSnDpb6XA8G5524L0zg
        I03fPkxt2d7xXhzhJ9Hrpno=
X-Google-Smtp-Source: AGRyM1sJxo10YNEaWoYjVa5BpCWjq/PvxUwk41QWSR126Sx0Sjg3fNgMoXyj1CwlOlcta3jwvo3cOA==
X-Received: by 2002:a05:6e02:20e7:b0:2dd:3e74:4488 with SMTP id q7-20020a056e0220e700b002dd3e744488mr8270269ilv.231.1658973801369;
        Wed, 27 Jul 2022 19:03:21 -0700 (PDT)
Received: from ip-172-31-23-7.us-east-2.compute.internal (ec2-18-118-35-90.us-east-2.compute.amazonaws.com. [18.118.35.90])
        by smtp.googlemail.com with ESMTPSA id d3-20020a92d783000000b002dc258e3093sm7412589iln.64.2022.07.27.19.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 19:03:20 -0700 (PDT)
From:   Jianlin Lv <iecedge@gmail.com>
To:     corbet@lwn.net, catalin.marinas@arm.com, will@kernel.org,
        rostedt@goodmis.org, mingo@redhat.com, naveen.n.rao@linux.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        mhiramat@kernel.org, arnd@arndb.de, zhengzengkai@huawei.com
Cc:     iecedge@gmail.com, jianlv@ebay.com, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] arm64/kprobes: Add support for KPROBES_ON_FTRACE
Date:   Thu, 28 Jul 2022 02:02:50 +0000
Message-Id: <20220728020250.1699-1-iecedge@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the arm64 version of ftrace-based kprobes to avoid the overhead
with regular kprobes, by using the ftrace infrastructure.

Signed-off-by: Jianlin Lv <iecedge@gmail.com>
---
 .../debug/kprobes-on-ftrace/arch-support.txt  |  2 +-
 arch/arm64/Kconfig                            |  1 +
 arch/arm64/kernel/probes/Makefile             |  1 +
 arch/arm64/kernel/probes/kprobes-ftrace.c     | 81 +++++++++++++++++++
 include/linux/kprobes.h                       |  2 +
 kernel/kprobes.c                              |  4 +-
 6 files changed, 88 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm64/kernel/probes/kprobes-ftrace.c

diff --git a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
index b3697f4c806e..fadbd4513c91 100644
--- a/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
+++ b/Documentation/features/debug/kprobes-on-ftrace/arch-support.txt
@@ -9,7 +9,7 @@
     |       alpha: | TODO |
     |         arc: | TODO |
     |         arm: | TODO |
-    |       arm64: | TODO |
+    |       arm64: |  ok  |
     |        csky: |  ok  |
     |     hexagon: | TODO |
     |        ia64: | TODO |
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1652a9800ebe..7271d97e035a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -204,6 +204,7 @@ config ARM64
 	select HAVE_STACKPROTECTOR
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_KPROBES
+	select HAVE_KPROBES_ON_FTRACE
 	select HAVE_KRETPROBES
 	select HAVE_GENERIC_VDSO
 	select IOMMU_DMA if IOMMU_SUPPORT
diff --git a/arch/arm64/kernel/probes/Makefile b/arch/arm64/kernel/probes/Makefile
index 8e4be92e25b1..dab2fa4dba81 100644
--- a/arch/arm64/kernel/probes/Makefile
+++ b/arch/arm64/kernel/probes/Makefile
@@ -4,3 +4,4 @@ obj-$(CONFIG_KPROBES)		+= kprobes.o decode-insn.o	\
 				   simulate-insn.o
 obj-$(CONFIG_UPROBES)		+= uprobes.o decode-insn.o	\
 				   simulate-insn.o
+obj-$(CONFIG_KPROBES_ON_FTRACE)	+= kprobes-ftrace.o
diff --git a/arch/arm64/kernel/probes/kprobes-ftrace.c b/arch/arm64/kernel/probes/kprobes-ftrace.c
new file mode 100644
index 000000000000..fcfa6b6533a0
--- /dev/null
+++ b/arch/arm64/kernel/probes/kprobes-ftrace.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Dynamic Ftrace based Kprobes Optimization
+ *
+ * Copyright (C) Hitachi Ltd., 2012
+ */
+#include <linux/kprobes.h>
+
+int arch_check_ftrace_location(struct kprobe *p)
+{
+	unsigned long addr = (unsigned long)p->addr;
+
+	/* ftrace location at the BL in the callsite (<function-entry> + AARCH64_INSN_SIZE)  */
+	if (ftrace_location(addr) == (addr + AARCH64_INSN_SIZE)) {
+#ifdef CONFIG_KPROBES_ON_FTRACE
+		p->flags |= KPROBE_FLAG_FTRACE;
+#else	/* !CONFIG_KPROBES_ON_FTRACE */
+		return -EINVAL;
+#endif
+	}
+	return 0;
+}
+
+/* Ftrace callback handler for kprobes */
+void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
+			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
+{
+	struct pt_regs *regs;
+	struct kprobe *p;
+	struct kprobe_ctlblk *kcb;
+	int bit;
+
+	bit = ftrace_test_recursion_trylock(ip, parent_ip);
+	if (bit < 0)
+		return;
+
+	regs = ftrace_get_regs(fregs);
+	p = get_kprobe((kprobe_opcode_t *) (ip - AARCH64_INSN_SIZE));
+	if (unlikely(!p) || kprobe_disabled(p))
+		goto out;
+
+	kcb = get_kprobe_ctlblk();
+	if (kprobe_running()) {
+		kprobes_inc_nmissed_count(p);
+	} else {
+		unsigned long orig_ip = instruction_pointer(regs);
+
+		instruction_pointer_set(regs, ip - AARCH64_INSN_SIZE);
+
+		__this_cpu_write(current_kprobe, p);
+		kcb->kprobe_status = KPROBE_HIT_ACTIVE;
+		if (!p->pre_handler || !p->pre_handler(p, regs)) {
+			/*
+			 * Emulate singlestep (and also recover regs->pc)
+			 * as if there is a 4byte nop
+			 */
+			instruction_pointer_set(regs, ip);
+			if (unlikely(p->post_handler)) {
+				kcb->kprobe_status = KPROBE_HIT_SSDONE;
+				p->post_handler(p, regs, 0);
+			}
+			instruction_pointer_set(regs, orig_ip);
+		}
+
+		/*
+		 * If pre_handler returns !0, it changes regs->pc. We have to
+		 * skip emulating post_handler.
+		 */
+		__this_cpu_write(current_kprobe, NULL);
+	}
+out:
+	ftrace_test_recursion_unlock(bit);
+}
+NOKPROBE_SYMBOL(kprobe_ftrace_handler);
+
+int arch_prepare_kprobe_ftrace(struct kprobe *p)
+{
+	p->ainsn.api.insn = NULL;
+	return 0;
+}
+
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 55041d2f884d..83a479908029 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -392,6 +392,8 @@ static inline int arch_prepare_kprobe_ftrace(struct kprobe *p)
 }
 #endif /* CONFIG_KPROBES_ON_FTRACE */
 
+int arch_check_ftrace_location(struct kprobe *p);
+
 /* Get the kprobe at this addr (if any) - called with preemption disabled */
 struct kprobe *get_kprobe(void *addr);
 
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index f214f8c088ed..34754c2fe14e 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1534,7 +1534,7 @@ static inline int warn_kprobe_rereg(struct kprobe *p)
 	return ret;
 }
 
-static int check_ftrace_location(struct kprobe *p)
+int __weak arch_check_ftrace_location(struct kprobe *p)
 {
 	unsigned long addr = (unsigned long)p->addr;
 
@@ -1553,7 +1553,7 @@ static int check_kprobe_address_safe(struct kprobe *p,
 {
 	int ret;
 
-	ret = check_ftrace_location(p);
+	ret = arch_check_ftrace_location(p);
 	if (ret)
 		return ret;
 	jump_label_lock();
-- 
2.25.1

