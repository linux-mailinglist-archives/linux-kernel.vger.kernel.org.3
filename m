Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 668AE4AAD31
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 01:29:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381268AbiBFA3q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Feb 2022 19:29:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiBFA3p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Feb 2022 19:29:45 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3634CC061348
        for <linux-kernel@vger.kernel.org>; Sat,  5 Feb 2022 16:29:45 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id b35so8055967qkp.6
        for <linux-kernel@vger.kernel.org>; Sat, 05 Feb 2022 16:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qeONPiUHU0AkiH7BV62IDzBx2bto00KJNgoRZxV98iA=;
        b=kQSC1Pe05Uz4giRgdSeG/dUCvYdNhR3xP6xWEaZUv4NLV0xtqB6Y8J6m3Y/jxAZzkG
         QKc3MZOU4uIN7QPRnEj07KCQBXw93RTvFJqYM9cX6FonzmotOQwCJLHpFCWULcpBgCUr
         h1zH734FivNvSBPPLS0za7XIMRMd8ApdcczRb3Mg8qXmttgMILXJUYGQ+jJwR8i5j48c
         pcps2HslqXkZx4TUARgZBGBi8uBvao/mJ9jvbDowV0y4MU0x9/Q4isB16P+IV8ZIqRUM
         NKjaNR3OBveIcHkM8N83VH6XWkY0hj49Kc/KXE5NTBCU22/WkmWFZ7Y5WinkNWL+HXSL
         ISEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qeONPiUHU0AkiH7BV62IDzBx2bto00KJNgoRZxV98iA=;
        b=h5DWux0KorSYKN7QrRYY8WsvdvtrID6IXZtE2cazfiTqoEVeLJlgBHNMpx+kuct7M4
         7oz/nbQi9O7/Ttypv2JGaoZsf2Y/Uo5rpfRTRzKoqVI518tGS/TFz0a83a1YT718GUyi
         nvCqdsOxg7+Qu9G5fTfGnygUiJVW8ZfjUCSaqQhoJEnTbAGLLlT6RGOh8iTRVMZUNLep
         aD6S91/zINx6ywV11/Srb3C/3QxjI+71XKodtMK/6m/QGf09jZHy1RMp0IY/yECgpcl7
         pJmslNkFGJydAma55nrfzMBXEtoO1KA7ulpCHEp5q5sccsPjiG5LCPO+F+pIs/P61JYY
         R55g==
X-Gm-Message-State: AOAM532ggJkoEy+H+vkcwS7JrSNoYVuRnMTpOuFo3y0fO3U5ncuKqWt6
        GmDIN02k+aGTLJTOmbWTn6swFm+oHs/QKi1a
X-Google-Smtp-Source: ABdhPJyV6jCtE/ezy346p9XWtZmyqXQshDZ6e6xVjWH6u7KSk2N9qiqrZZ2LUd/VmVvRAHZ3Xi3htQ==
X-Received: by 2002:a05:620a:40cc:: with SMTP id g12mr3136238qko.308.1644107384324;
        Sat, 05 Feb 2022 16:29:44 -0800 (PST)
Received: from WRT-WX9.. ([207.246.89.135])
        by smtp.gmail.com with ESMTPSA id w10sm3843598qtj.73.2022.02.05.16.29.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Feb 2022 16:29:43 -0800 (PST)
From:   Changbin Du <changbin.du@gmail.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Changbin Du <changbin.du@gmail.com>
Subject: [PATCH v3] riscv: fix oops caused by irqsoff latency tracer
Date:   Sun,  6 Feb 2022 08:29:33 +0800
Message-Id: <20220206002933.437563-1-changbin.du@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The trace_hardirqs_{on,off}() requires at least two parent call frames.
This because these two functions use macro 'CALLER_ADDR1' (aka.
__builtin_return_address(1)) to acquire caller info. If there's no enough
frames, the code generated the macro could trigger memory access fault.

[    0.039615][    T0] Unable to handle kernel NULL pointer dereference at virtual address 00000000000000f8
[    0.041925][    T0] Oops [#1]
[    0.042063][    T0] Modules linked in:
[    0.042864][    T0] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.17.0-rc1-00233-g9a20c48d1ed2 #29
[    0.043568][    T0] Hardware name: riscv-virtio,qemu (DT)
[    0.044343][    T0] epc : trace_hardirqs_on+0x56/0xe2
[    0.044601][    T0]  ra : restore_all+0x12/0x6e
[    0.044721][    T0] epc : ffffffff80126a5c ra : ffffffff80003b94 sp : ffffffff81403db0
[    0.044801][    T0]  gp : ffffffff8163acd8 tp : ffffffff81414880 t0 : 0000000000000020
[    0.044882][    T0]  t1 : 0098968000000000 t2 : 0000000000000000 s0 : ffffffff81403de0
[    0.044967][    T0]  s1 : 0000000000000000 a0 : 0000000000000001 a1 : 0000000000000100
[    0.045046][    T0]  a2 : 0000000000000000 a3 : 0000000000000000 a4 : 0000000000000000
[    0.045124][    T0]  a5 : 0000000000000000 a6 : 0000000000000000 a7 : 0000000054494d45
[    0.045210][    T0]  s2 : ffffffff80003b94 s3 : ffffffff81a8f1b0 s4 : ffffffff80e27b50
[    0.045289][    T0]  s5 : ffffffff81414880 s6 : ffffffff8160fa00 s7 : 00000000800120e8
[    0.045389][    T0]  s8 : 0000000080013100 s9 : 000000000000007f s10: 0000000000000000
[    0.045474][    T0]  s11: 0000000000000000 t3 : 7fffffffffffffff t4 : 0000000000000000
[    0.045548][    T0]  t5 : 0000000000000000 t6 : ffffffff814aa368
[    0.045620][    T0] status: 0000000200000100 badaddr: 00000000000000f8 cause: 000000000000000d
[    0.046402][    T0] [<ffffffff80003b94>] restore_all+0x12/0x6e

To fix above issue, here we add one extra level wrapper so they can be
safely called by low level entry code.

Signed-off-by: Changbin Du <changbin.du@gmail.com>

---
v3: fix warning reported by documentation system.
v2: fix compile warning.
---
 arch/riscv/kernel/Makefile    |  2 ++
 arch/riscv/kernel/entry.S     | 10 +++++-----
 arch/riscv/kernel/trace_irq.c | 26 ++++++++++++++++++++++++++
 arch/riscv/kernel/trace_irq.h | 11 +++++++++++
 4 files changed, 44 insertions(+), 5 deletions(-)
 create mode 100644 arch/riscv/kernel/trace_irq.c
 create mode 100644 arch/riscv/kernel/trace_irq.h

diff --git a/arch/riscv/kernel/Makefile b/arch/riscv/kernel/Makefile
index 612556faa527..ffc87e76b1dd 100644
--- a/arch/riscv/kernel/Makefile
+++ b/arch/riscv/kernel/Makefile
@@ -51,6 +51,8 @@ obj-$(CONFIG_MODULE_SECTIONS)	+= module-sections.o
 obj-$(CONFIG_FUNCTION_TRACER)	+= mcount.o ftrace.o
 obj-$(CONFIG_DYNAMIC_FTRACE)	+= mcount-dyn.o
 
+obj-$(CONFIG_TRACE_IRQFLAGS)	+= trace_irq.o
+
 obj-$(CONFIG_RISCV_BASE_PMU)	+= perf_event.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_callchain.o
 obj-$(CONFIG_HAVE_PERF_REGS)	+= perf_regs.o
diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index ed29e9c8f660..d6a46ed0bf05 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -108,7 +108,7 @@ _save_context:
 .option pop
 
 #ifdef CONFIG_TRACE_IRQFLAGS
-	call trace_hardirqs_off
+	call __trace_hardirqs_off
 #endif
 
 #ifdef CONFIG_CONTEXT_TRACKING
@@ -143,7 +143,7 @@ skip_context_tracking:
 	li t0, EXC_BREAKPOINT
 	beq s4, t0, 1f
 #ifdef CONFIG_TRACE_IRQFLAGS
-	call trace_hardirqs_on
+	call __trace_hardirqs_on
 #endif
 	csrs CSR_STATUS, SR_IE
 
@@ -234,7 +234,7 @@ ret_from_exception:
 	REG_L s0, PT_STATUS(sp)
 	csrc CSR_STATUS, SR_IE
 #ifdef CONFIG_TRACE_IRQFLAGS
-	call trace_hardirqs_off
+	call __trace_hardirqs_off
 #endif
 #ifdef CONFIG_RISCV_M_MODE
 	/* the MPP value is too large to be used as an immediate arg for addi */
@@ -270,10 +270,10 @@ restore_all:
 	REG_L s1, PT_STATUS(sp)
 	andi t0, s1, SR_PIE
 	beqz t0, 1f
-	call trace_hardirqs_on
+	call __trace_hardirqs_on
 	j 2f
 1:
-	call trace_hardirqs_off
+	call __trace_hardirqs_off
 2:
 #endif
 	REG_L a0, PT_STATUS(sp)
diff --git a/arch/riscv/kernel/trace_irq.c b/arch/riscv/kernel/trace_irq.c
new file mode 100644
index 000000000000..54324d1bcc25
--- /dev/null
+++ b/arch/riscv/kernel/trace_irq.c
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 Changbin Du <changbin.du@gmail.com>
+ */
+
+#include <linux/irqflags.h>
+#include <linux/kprobes.h>
+#include "trace_irq.h"
+
+/*
+ * trace_hardirqs_on/off requires at least two parent call frames.
+ * Here we add one extra level so they can be safely called by low
+ * level entry code.
+ */
+
+void __trace_hardirqs_on(void)
+{
+	trace_hardirqs_on();
+}
+NOKPROBE_SYMBOL(__trace_hardirqs_on);
+
+void __trace_hardirqs_off(void)
+{
+	trace_hardirqs_off();
+}
+NOKPROBE_SYMBOL(__trace_hardirqs_off);
diff --git a/arch/riscv/kernel/trace_irq.h b/arch/riscv/kernel/trace_irq.h
new file mode 100644
index 000000000000..99fe67377e5e
--- /dev/null
+++ b/arch/riscv/kernel/trace_irq.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2022 Changbin Du <changbin.du@gmail.com>
+ */
+#ifndef __TRACE_IRQ_H
+#define __TRACE_IRQ_H
+
+void __trace_hardirqs_on(void);
+void __trace_hardirqs_off(void);
+
+#endif /* __TRACE_IRQ_H */
-- 
2.32.0

