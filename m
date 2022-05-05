Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 917B251BDEB
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 13:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357177AbiEELYg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 07:24:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238682AbiEELYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 07:24:33 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE66205F3;
        Thu,  5 May 2022 04:20:52 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KvB2x6FckzHnV5;
        Thu,  5 May 2022 19:16:09 +0800 (CST)
Received: from ubuntu1804.huawei.com (10.67.174.58) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 5 May 2022 19:20:51 +0800
From:   Xiu Jianfeng <xiujianfeng@huawei.com>
To:     <mpe@ellerman.id.au>, <benh@kernel.crashing.org>,
        <paulus@samba.org>, <npiggin@gmail.com>,
        <christophe.leroy@csgroup.eu>, <tglx@linutronix.de>,
        <mark.rutland@arm.com>
CC:     <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>
Subject: [PATCH -next] powerpc: add support for syscall stack randomization
Date:   Thu, 5 May 2022 19:19:32 +0800
Message-ID: <20220505111932.228814-1-xiujianfeng@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.174.58]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for adding a random offset to the stack while handling
syscalls. This patch uses mftb() instead of get_random_int() for better
performance.

Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
---
 arch/powerpc/Kconfig            | 1 +
 arch/powerpc/kernel/interrupt.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 5fc9153927ac..7e04c9f80cbc 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -192,6 +192,7 @@ config PPC
 	select HAVE_ARCH_KASAN			if PPC32 && PPC_PAGE_SHIFT <= 14
 	select HAVE_ARCH_KASAN_VMALLOC		if PPC32 && PPC_PAGE_SHIFT <= 14
 	select HAVE_ARCH_KFENCE			if PPC_BOOK3S_32 || PPC_8xx || 40x
+	select HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS
 	select HAVE_ARCH_MMAP_RND_COMPAT_BITS	if COMPAT
diff --git a/arch/powerpc/kernel/interrupt.c b/arch/powerpc/kernel/interrupt.c
index 784ea3289c84..459385769721 100644
--- a/arch/powerpc/kernel/interrupt.c
+++ b/arch/powerpc/kernel/interrupt.c
@@ -4,6 +4,7 @@
 #include <linux/err.h>
 #include <linux/compat.h>
 #include <linux/sched/debug.h> /* for show_regs */
+#include <linux/randomize_kstack.h>
 
 #include <asm/kup.h>
 #include <asm/cputime.h>
@@ -82,6 +83,7 @@ notrace long system_call_exception(long r3, long r4, long r5,
 
 	kuap_lock();
 
+	add_random_kstack_offset();
 	regs->orig_gpr3 = r3;
 
 	if (IS_ENABLED(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG))
@@ -405,6 +407,7 @@ interrupt_exit_user_prepare_main(unsigned long ret, struct pt_regs *regs)
 
 	/* Restore user access locks last */
 	kuap_user_restore(regs);
+	choose_random_kstack_offset(mftb() & 0xFF);
 
 	return ret;
 }
-- 
2.17.1

