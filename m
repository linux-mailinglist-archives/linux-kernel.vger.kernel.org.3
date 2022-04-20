Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D114E508197
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 09:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359553AbiDTHEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 03:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359556AbiDTHEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 03:04:16 -0400
Received: from nksmu.kylinos.cn (mailgw.kylinos.cn [123.150.8.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE6C039160
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 00:01:26 -0700 (PDT)
X-UUID: 69e668de44fb4f439643a0331dc566d8-20220420
X-CPASD-INFO: 63b831e30fb54d35af0f6d9a4ce594fa@f4OcWGBjk2NchqSBg6d-b4GXYJZnkFm
        wdp2FZWdkkoGVhH5xTWJsXVKBfG5QZWNdYVN_eGpQY19gZFB5i3-XblBgXoZgUZB3hXWcWGNflQ==
X-CLOUD-ID: 63b831e30fb54d35af0f6d9a4ce594fa
X-CPASD-SUMMARY: SIP:-1,APTIP:-2.0,KEY:0.0,FROMBLOCK:1,OB:0.0,URL:-5,TVAL:186.
        0,ESV:0.0,ECOM:-5.0,ML:0.0,FD:1.0,CUTS:317.0,IP:-2.0,MAL:-5.0,PHF:-5.0,PHC:-5
        .0,SPF:4.0,EDMS:-5,IPLABEL:4480.0,FROMTO:0,AD:0,FFOB:0.0,CFOB:0.0,SPC:0,SIG:-
        5,AUF:1,DUF:37701,ACD:259,DCD:361,SL:0,EISP:0,AG:0,CFC:0.168,CFSR:0.106,UAT:0
        ,RAF:0,IMG:-5.0,DFA:0,DTA:0,IBL:-2.0,ADI:-5,SBL:0,REDM:0,REIP:0,ESB:0,ATTNUM:
        0,EAF:0,CID:-5.0,VERSION:2.3.17
X-CPASD-ID: 69e668de44fb4f439643a0331dc566d8-20220420
X-CPASD-BLOCK: 1001
X-CPASD-STAGE: 1
X-UUID: 69e668de44fb4f439643a0331dc566d8-20220420
X-User: sunliming@kylinos.cn
Received: from localhost.localdomain [(116.128.244.169)] by nksmu.kylinos.cn
        (envelope-from <sunliming@kylinos.cn>)
        (Generic MTA)
        with ESMTP id 1389788075; Wed, 20 Apr 2022 14:59:58 +0800
From:   sunliming <sunliming@kylinos.cn>
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        sunliming <sunliming@kylinos.cn>
Subject: [PATCH] arm64,trace: Add page fault traceponits
Date:   Wed, 20 Apr 2022 15:01:09 +0800
Message-Id: <20220420070109.1010257-1-sunliming@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The arm64 architecture lacks some tracepoints support, this patch
adds page fault tracepoints. The code and arch policy is mainly
inherited  from x86.

Experimented on my centos8 virtual machine:
	dracut:/# echo 1 > /sys/kernel/tracing/events/exceptions/enable
	dracut:/# cat /sys/kernel/tracing/trace

The results:
              sh-6098    [001] .....  1186.024675: page_fault_user: addr=0xffffe153cc00 pc=0xffffa4117338 esr=0xffffe153cc00
             cat-6126    [000] .....  1186.024677: page_fault_kernel: addr=0xffffa4323740 pc=schedule_tail esr=0xffffa4323740
              sh-6098    [001] .....  1186.026085: page_fault_user: addr=0xaaaad23fae34 pc=0xaaaad231c0fc esr=0xaaaad23fae34
             cat-6126    [000] .....  1186.026106: page_fault_user: addr=0xffffa414565c pc=0xffffa414565c esr=0xffffa414565c
             cat-6126    [000] .....  1186.026222: page_fault_user: addr=0xffffa4214e10 pc=0xffffa4145670 esr=0xffffa4214e10
             cat-6126    [000] .....  1186.026243: page_fault_user: addr=0xffffa420fd88 pc=0xffffa41456ac esr=0xffffa420fd88
             cat-6126    [000] .....  1186.026282: page_fault_user: addr=0xffffa4117338 pc=0xffffa4117338 esr=0xffffa4117338
             cat-6126    [000] .....  1186.026308: page_fault_user: addr=0xffffe153cc00 pc=0xffffa4117338 esr=0xffffe153cc00
             cat-6126    [000] .....  1186.026365: page_fault_user: addr=0xaaaad231bd84 pc=0xaaaad231bd84 esr=0xaaaad231bd84
              sh-6098    [001] .....  1186.026372: page_fault_user: addr=0xaaab04330098 pc=0xffffa411be68 esr=0xaaab04330098
             cat-6126    [000] .....  1186.026394: page_fault_user: addr=0xaaaad22ef420 pc=0xaaaad22ef420 esr=0xaaaad22ef420
             cat-6126    [000] .....  1186.026414: page_fault_user: addr=0xaaaad23ee9b0 pc=0xaaaad22ef424 esr=0xaaaad23ee9b0
             cat-6126    [000] .....  1186.026426: page_fault_user: addr=0xffffa40c3110 pc=0xffffa40c3110 esr=0xffffa40c3110
             cat-6126    [000] .....  1186.026450: page_fault_user: addr=0xaaaad22f23f8 pc=0xaaaad22f23f8 esr=0xaaaad22f23f8
             cat-6126    [000] .....  1186.026467: page_fault_user: addr=0xaaaad23f0030 pc=0xaaaad22f240c esr=0xaaaad23f0030
             cat-6126    [000] .....  1186.026481: page_fault_user: addr=0xaaaad23fae3c pc=0xaaaad231be40 esr=0xaaaad23fae3c
             cat-6126    [000] .....  1186.026530: page_fault_user: addr=0xffffa40d63d8 pc=0xffffa40d63d8 esr=0xffffa40d63d8
             cat-6126    [000] .....  1186.026554: page_fault_user: addr=0xffffa431f650 pc=0xffffa40d63f8 esr=0xffffa431f650
              sh-6098    [001] .....  1186.026556: page_fault_user: addr=0xaaab04358d28 pc=0xffffa411be70 esr=0xaaab04358d28
             cat-6126    [000] .....  1186.026571: page_fault_user: addr=0xaaaad24015d0 pc=0xffffa40d640c esr=0xaaaad24015d0
             cat-6126    [000] .....  1186.026600: page_fault_user: addr=0xaaaad2332be8 pc=0xaaaad2332be8 esr=0xaaaad2332be8
             cat-6126    [000] .....  1186.026703: page_fault_user: addr=0xffffa416c438 pc=0xffffa416c438 esr=0xffffa416c438
              sh-6098    [001] .....  1186.026749: page_fault_user: addr=0xaaab04369d70 pc=0xffffa41193d8 esr=0xaaab04369d70
             cat-6126    [000] .....  1186.027610: page_fault_user: addr=0xaaaad2307754 pc=0xaaaad2307754 esr=0xaaaad2307754
             cat-6126    [000] .....  1186.027711: page_fault_user: addr=0xaaaad24014c4 pc=0xaaaad23310e4 esr=0xaaaad24014c4
             cat-6126    [000] .....  1186.027892: page_fault_user: addr=0xaaab04359a80 pc=0xaaaad23052f0 esr=0xaaab04359a80
             cat-6126    [000] .....  1186.027916: page_fault_user: addr=0xaaaad236cf80 pc=0xaaaad236cf80 esr=0xaaaad236cf80

Signed-off-by: sunliming <sunliming@kylinos.cn>
---
 arch/arm64/include/asm/trace/common.h     | 12 +++++
 arch/arm64/include/asm/trace/exceptions.h | 54 +++++++++++++++++++++++
 arch/arm64/kernel/Makefile                |  1 +
 arch/arm64/kernel/tracepoint.c            | 24 ++++++++++
 arch/arm64/mm/Makefile                    |  3 ++
 arch/arm64/mm/fault.c                     | 19 ++++++++
 6 files changed, 113 insertions(+)
 create mode 100644 arch/arm64/include/asm/trace/common.h
 create mode 100644 arch/arm64/include/asm/trace/exceptions.h
 create mode 100644 arch/arm64/kernel/tracepoint.c

diff --git a/arch/arm64/include/asm/trace/common.h b/arch/arm64/include/asm/trace/common.h
new file mode 100644
index 000000000000..f0f9bcdb74d9
--- /dev/null
+++ b/arch/arm64/include/asm/trace/common.h
@@ -0,0 +1,12 @@
+#ifndef _ASM_TRACE_COMMON_H
+#define _ASM_TRACE_COMMON_H
+
+#ifdef CONFIG_TRACING
+DECLARE_STATIC_KEY_FALSE(trace_pagefault_key);
+#define trace_pagefault_enabled()			\
+	static_branch_unlikely(&trace_pagefault_key)
+#else
+static inline bool trace_pagefault_enabled(void) { return false; }
+#endif
+
+#endif
diff --git a/arch/arm64/include/asm/trace/exceptions.h b/arch/arm64/include/asm/trace/exceptions.h
new file mode 100644
index 000000000000..b0309aeca50b
--- /dev/null
+++ b/arch/arm64/include/asm/trace/exceptions.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM exceptions
+
+#if !defined(_TRACE_PAGE_FAULT_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_PAGE_FAULT_H
+
+#include <linux/tracepoint.h>
+#include <asm/trace/common.h>
+
+extern int trace_pagefault_reg(void);
+extern void trace_pagefault_unreg(void);
+
+DECLARE_EVENT_CLASS(arm64_exceptions,
+
+	TP_PROTO(unsigned long addr, struct pt_regs *regs,
+		unsigned int esr),
+
+	TP_ARGS(addr, regs, esr),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, addr)
+		__field(unsigned long, pc)
+		__field(unsigned int, esr)
+	),
+
+	TP_fast_assign(
+		__entry->addr = addr;
+		__entry->pc = regs->pc;
+		__entry->esr = esr;
+	),
+
+	TP_printk("addr=%ps pc=%ps esr=0x%lx",
+		(void *)__entry->addr, (void *)__entry->pc,
+		__entry->addr));
+
+#define DEFINE_PAGE_FAULT_EVENT(name)				\
+DEFINE_EVENT_FN(arm64_exceptions, name,				\
+	TP_PROTO(unsigned long addr, struct pt_regs *regs,	\
+		unsigned int esr),				\
+	TP_ARGS(addr, regs, esr),				\
+	trace_pagefault_reg, trace_pagefault_unreg);
+
+DEFINE_PAGE_FAULT_EVENT(page_fault_user);
+DEFINE_PAGE_FAULT_EVENT(page_fault_kernel);
+
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE exceptions
+#endif /*  _TRACE_PAGE_FAULT_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
diff --git a/arch/arm64/kernel/Makefile b/arch/arm64/kernel/Makefile
index 986837d7ec82..538476d91894 100644
--- a/arch/arm64/kernel/Makefile
+++ b/arch/arm64/kernel/Makefile
@@ -74,6 +74,7 @@ obj-$(CONFIG_ARM64_PTR_AUTH)		+= pointer_auth.o
 obj-$(CONFIG_ARM64_MTE)			+= mte.o
 obj-y					+= vdso-wrap.o
 obj-$(CONFIG_COMPAT_VDSO)		+= vdso32-wrap.o
+obj-$(CONFIG_TRACING)			+= tracepoint.o
 
 obj-y					+= probes/
 head-y					:= head.o
diff --git a/arch/arm64/kernel/tracepoint.c b/arch/arm64/kernel/tracepoint.c
new file mode 100644
index 000000000000..ea36aa37a885
--- /dev/null
+++ b/arch/arm64/kernel/tracepoint.c
@@ -0,0 +1,24 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Code for supporting page fault tracepoints.
+ *
+ *
+ */
+#include <linux/jump_label.h>
+#include <linux/atomic.h>
+
+#include <asm/trace/exceptions.h>
+
+DEFINE_STATIC_KEY_FALSE(trace_pagefault_key);
+
+int trace_pagefault_reg(void)
+{
+	static_branch_inc(&trace_pagefault_key);
+	return 0;
+}
+
+void trace_pagefault_unreg(void)
+{
+	static_branch_dec(&trace_pagefault_key);
+}
+
diff --git a/arch/arm64/mm/Makefile b/arch/arm64/mm/Makefile
index ff1e800ba7a1..62fef44062fa 100644
--- a/arch/arm64/mm/Makefile
+++ b/arch/arm64/mm/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
+
 obj-y				:= dma-mapping.o extable.o fault.o init.o \
 				   cache.o copypage.o flush.o \
 				   ioremap.o mmap.o pgd.o mmu.o \
@@ -12,5 +13,7 @@ obj-$(CONFIG_DEBUG_VIRTUAL)	+= physaddr.o
 obj-$(CONFIG_ARM64_MTE)		+= mteswap.o
 KASAN_SANITIZE_physaddr.o	+= n
 
+CFLAGS_fault.o := -I $(srctree)/$(src)/../include/asm/trace
+
 obj-$(CONFIG_KASAN)		+= kasan_init.o
 KASAN_SANITIZE_kasan_init.o	:= n
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index 77341b160aca..5898d18ee20c 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -42,6 +42,9 @@
 #include <asm/tlbflush.h>
 #include <asm/traps.h>
 
+#define CREATE_TRACE_POINTS
+#include <asm/trace/exceptions.h>
+
 struct fault_info {
 	int	(*fn)(unsigned long far, unsigned int esr,
 		      struct pt_regs *regs);
@@ -515,6 +518,20 @@ static bool is_write_abort(unsigned int esr)
 	return (esr & ESR_ELx_WNR) && !(esr & ESR_ELx_CM);
 }
 
+static __always_inline void
+trace_page_fault_entries(struct pt_regs *regs, unsigned int esr,
+		unsigned long addr)
+{
+	if (!trace_pagefault_enabled())
+		return;
+
+	if (user_mode(regs))
+		trace_page_fault_user(addr, regs, esr);
+	else
+		trace_page_fault_kernel(addr, regs, esr);
+}
+
+
 static int __kprobes do_page_fault(unsigned long far, unsigned int esr,
 				   struct pt_regs *regs)
 {
@@ -525,6 +542,8 @@ static int __kprobes do_page_fault(unsigned long far, unsigned int esr,
 	unsigned int mm_flags = FAULT_FLAG_DEFAULT;
 	unsigned long addr = untagged_addr(far);
 
+	trace_page_fault_entries(regs, esr, addr);
+
 	if (kprobe_page_fault(regs, esr))
 		return 0;
 
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus
