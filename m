Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F7DF4BA95F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:14:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245031AbiBQTOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:14:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242994AbiBQTOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:14:04 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553C68D697
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 11:13:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Slyaqa+LAiQa0jGtv7Mh1+rPVXd9IwiWq5lH5xrcQ2E=; b=h8bg3H/YhM6oc3YW53+uUUiRCc
        s6kKrckB3U6vJnzxanw8IRHc8qm00QPjmrNyCXy2EJRRy4WvqeL8CxTHlNUDjvG/YRGepoJopWW00
        PoswY64UhJFr9/WRo474O2S9ucHYviJf+gk5fPMPbU7ktFJNkmoNaU48HCp/LGQORbgtxqnmzbl3H
        +9rVyATOvCqmRwiIrBpne08/VvwnwDxTqtPahTe4CbN6hP64Lb/4UDxC4MYcd4Vew2sSUGrz+8feF
        W9oEYE8lw7aTUR4R0/dZeNw8n6enMNuiNGyJX2tNy2BvPZcOs9U4XOUZM/RGsj3fyhdm3hvjNFAV6
        dowzj+lg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nKmDr-00Br3x-Nx; Thu, 17 Feb 2022 19:13:47 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Nick Hu <nickhu@andestech.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Alan Kao <alankao@andestech.com>, KC <kclin@andestech.com>
Subject: [PATCH v2] NDS32: export __trace_hardirqs_on/_offf for entry/exit
Date:   Thu, 17 Feb 2022 11:13:47 -0800
Message-Id: <20220217191347.13480-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add exports for __trace_hardirqs_on/_off and use them in
kernel/ex-entry.S and kernel/ex-exit.S to fix build/linker errors.

nds32le-linux-ld: arch/nds32/kernel/ex-entry.o: in function `fucop_ctl_done':
(.text+0x12a): undefined reference to `__trace_hardirqs_off'
nds32le-linux-ld: arch/nds32/kernel/ex-exit.o: in function `no_work_pending':
(.text+0xea): undefined reference to `__trace_hardirqs_off'
nds32le-linux-ld: (.text+0xee): undefined reference to `__trace_hardirqs_off'
nds32le-linux-ld: (.text+0xf2): undefined reference to `__trace_hardirqs_on'
nds32le-linux-ld: (.text+0xf6): undefined reference to `__trace_hardirqs_on'

Fixes: 0cde56e0280d ("nds32: Fix a kernel panic issue because of wrong frame pointer access.")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Nick Hu <nickhu@andestech.com>
Cc: Vincent Chen <deanbo422@gmail.com>
Cc: Alan Kao <alankao@andestech.com>
Cc: KC <kclin@andestech.com>
---
v2: move the functions from ftrace.c to irq.c;
    #include <asm/irqflags.h> instead of <asm/ftrace.h>;
#Cc: Greentime Hu <green.hu@gmail.com>

 arch/nds32/include/asm/irqflags.h |    3 +++
 arch/nds32/kernel/ex-entry.S      |    1 +
 arch/nds32/kernel/ex-exit.S       |    2 +-
 arch/nds32/kernel/ftrace.c        |   12 ------------
 arch/nds32/kernel/irq.c           |   14 ++++++++++++++
 5 files changed, 19 insertions(+), 13 deletions(-)

--- linux-next-20220216.orig/arch/nds32/kernel/ftrace.c
+++ linux-next-20220216/arch/nds32/kernel/ftrace.c
@@ -264,15 +264,3 @@ int ftrace_disable_ftrace_graph_caller(v
 #endif /* CONFIG_DYNAMIC_FTRACE */
 
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
-
-
-#ifdef CONFIG_TRACE_IRQFLAGS
-noinline void __trace_hardirqs_off(void)
-{
-	trace_hardirqs_off();
-}
-noinline void __trace_hardirqs_on(void)
-{
-	trace_hardirqs_on();
-}
-#endif /* CONFIG_TRACE_IRQFLAGS */
--- linux-next-20220216.orig/arch/nds32/kernel/ex-entry.S
+++ linux-next-20220216/arch/nds32/kernel/ex-entry.S
@@ -8,6 +8,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/page.h>
 #include <asm/fpu.h>
+#include <asm/irqflags.h>
 
 #ifdef CONFIG_HWZOL
 	.macro push_zol
--- linux-next-20220216.orig/arch/nds32/kernel/ex-exit.S
+++ linux-next-20220216/arch/nds32/kernel/ex-exit.S
@@ -9,7 +9,7 @@
 #include <asm/thread_info.h>
 #include <asm/current.h>
 #include <asm/fpu.h>
-
+#include <asm/irqflags.h>
 
 
 #ifdef CONFIG_HWZOL
--- linux-next-20220216.orig/arch/nds32/include/asm/irqflags.h
+++ linux-next-20220216/arch/nds32/include/asm/irqflags.h
@@ -39,3 +39,6 @@ static inline int arch_irqs_disabled(voi
 {
 	return arch_irqs_disabled_flags(arch_local_save_flags());
 }
+
+void __trace_hardirqs_off(void);
+void __trace_hardirqs_on(void);
--- linux-next-20220216.orig/arch/nds32/kernel/irq.c
+++ linux-next-20220216/arch/nds32/kernel/irq.c
@@ -7,3 +7,17 @@ void __init init_IRQ(void)
 {
 	irqchip_init();
 }
+
+#ifdef CONFIG_TRACE_IRQFLAGS
+noinline void __trace_hardirqs_off(void)
+{
+	trace_hardirqs_off();
+}
+EXPORT_SYMBOL(__trace_hardirqs_off);
+
+noinline void __trace_hardirqs_on(void)
+{
+	trace_hardirqs_on();
+}
+EXPORT_SYMBOL(__trace_hardirqs_on);
+#endif /* CONFIG_TRACE_IRQFLAGS */
