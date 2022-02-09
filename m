Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C323F4AF466
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 15:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235223AbiBIOtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 09:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiBIOtM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:49:12 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83DBEC06157B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 06:49:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 295D561B46
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 14:49:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B3BAC340E7;
        Wed,  9 Feb 2022 14:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644418154;
        bh=KVIO38dzo035pW3Nl02VKZAmVAvK8RnnVGsfFHuf01c=;
        h=From:To:Cc:Subject:Date:From;
        b=MuD1eQjZnj2M1DW0d+GO+nC+ia+CKy014ShuBh0G7w638RaR8S6gVyjG8jN2Sjs+R
         vkr+9VhxpYiT/BrdpI9SK8ptyYIaDI2mqBGl40WhaDjEy0f4WiGsXSnWxICOVlkzGE
         wRrhWlZvi8u5OF8W4ZvptkU/wW8R7cgafjVJFd5R1CyNOJELx8AgyWZ6qh9+feFFb2
         pLFZqdrX3tbK28SUCgxhJ/e+8mZfzcNCtQW/pzMF5wHI0w+2NlmZefvFHMcLALTyts
         ZC/Fkyf2319ZykNmcYnzjrF4iKEnaVNRbzRpTUL4iBzhaqM+WUP054QbhlOjvW0EEF
         46eoi9Nwh/agQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Michal Simek <monstr@monstr.eu>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [PATCH] microblaze: remove CONFIG_SET_FS
Date:   Wed,  9 Feb 2022 15:48:54 +0100
Message-Id: <20220209144910.1484686-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Remove the address space override API set_fs().  The microblaze user
address space is now limited to TASK_SIZE.

To support this we implement and wire in __get_kernel_nofault and
__set_kernel_nofault.

The function user_addr_max is removed as there is a default definition
provided when CONFIG_SET_FS is not used.

Link: https://lore.kernel.org/lkml/20220117132757.1881981-1-arnd@kernel.org/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/microblaze/Kconfig                   |  1 -
 arch/microblaze/include/asm/thread_info.h |  6 ---
 arch/microblaze/include/asm/uaccess.h     | 56 ++++++++++-------------
 arch/microblaze/kernel/asm-offsets.c      |  1 -
 4 files changed, 25 insertions(+), 39 deletions(-)

diff --git a/arch/microblaze/Kconfig b/arch/microblaze/Kconfig
index 59798e43cdb0..1fb1cec087b7 100644
--- a/arch/microblaze/Kconfig
+++ b/arch/microblaze/Kconfig
@@ -42,7 +42,6 @@ config MICROBLAZE
 	select CPU_NO_EFFICIENT_FFS
 	select MMU_GATHER_NO_RANGE
 	select SPARSE_IRQ
-	select SET_FS
 	select ZONE_DMA
 	select TRACE_IRQFLAGS_SUPPORT
 
diff --git a/arch/microblaze/include/asm/thread_info.h b/arch/microblaze/include/asm/thread_info.h
index 44f5ca331862..a0ddd2a36fb9 100644
--- a/arch/microblaze/include/asm/thread_info.h
+++ b/arch/microblaze/include/asm/thread_info.h
@@ -56,17 +56,12 @@ struct cpu_context {
 	__u32	fsr;
 };
 
-typedef struct {
-	unsigned long seg;
-} mm_segment_t;
-
 struct thread_info {
 	struct task_struct	*task; /* main task structure */
 	unsigned long		flags; /* low level flags */
 	unsigned long		status; /* thread-synchronous flags */
 	__u32			cpu; /* current CPU */
 	__s32			preempt_count; /* 0 => preemptable,< 0 => BUG*/
-	mm_segment_t		addr_limit; /* thread address space */
 
 	struct cpu_context	cpu_context;
 };
@@ -80,7 +75,6 @@ struct thread_info {
 	.flags		= 0,			\
 	.cpu		= 0,			\
 	.preempt_count	= INIT_PREEMPT_COUNT,	\
-	.addr_limit	= KERNEL_DS,		\
 }
 
 /* how to get the thread information struct from C */
diff --git a/arch/microblaze/include/asm/uaccess.h b/arch/microblaze/include/asm/uaccess.h
index d2a8ef9f8978..346fe4618b27 100644
--- a/arch/microblaze/include/asm/uaccess.h
+++ b/arch/microblaze/include/asm/uaccess.h
@@ -16,45 +16,20 @@
 #include <asm/extable.h>
 #include <linux/string.h>
 
-/*
- * On Microblaze the fs value is actually the top of the corresponding
- * address space.
- *
- * The fs value determines whether argument validity checking should be
- * performed or not. If get_fs() == USER_DS, checking is performed, with
- * get_fs() == KERNEL_DS, checking is bypassed.
- *
- * For historical reasons, these macros are grossly misnamed.
- *
- * For non-MMU arch like Microblaze, KERNEL_DS and USER_DS is equal.
- */
-# define MAKE_MM_SEG(s)       ((mm_segment_t) { (s) })
-
-#  define KERNEL_DS	MAKE_MM_SEG(0xFFFFFFFF)
-#  define USER_DS	MAKE_MM_SEG(TASK_SIZE - 1)
-
-# define get_fs()	(current_thread_info()->addr_limit)
-# define set_fs(val)	(current_thread_info()->addr_limit = (val))
-# define user_addr_max() get_fs().seg
-
-# define uaccess_kernel()	(get_fs().seg == KERNEL_DS.seg)
-
 static inline int access_ok(const void __user *addr, unsigned long size)
 {
 	if (!size)
 		goto ok;
 
-	if ((get_fs().seg < ((unsigned long)addr)) ||
-			(get_fs().seg < ((unsigned long)addr + size - 1))) {
-		pr_devel("ACCESS fail at 0x%08x (size 0x%x), seg 0x%08x\n",
-			(__force u32)addr, (u32)size,
-			(u32)get_fs().seg);
+	if ((((unsigned long)addr) > TASK_SIZE) ||
+	    (((unsigned long)addr + size - 1) > TASK_SIZE)) {
+		pr_devel("ACCESS fail at 0x%08x (size 0x%x)",
+			(__force u32)addr, (u32)size);
 		return 0;
 	}
 ok:
-	pr_devel("ACCESS OK at 0x%08x (size 0x%x), seg 0x%08x\n",
-			(__force u32)addr, (u32)size,
-			(u32)get_fs().seg);
+	pr_devel("ACCESS OK at 0x%08x (size 0x%x)\n",
+			(__force u32)addr, (u32)size);
 	return 1;
 }
 
@@ -280,6 +255,25 @@ extern long __user_bad(void);
 	__gu_err;							\
 })
 
+#define __get_kernel_nofault(dst, src, type, label)	\
+{							\
+	type __user *p = (type __force __user *)(src);	\
+	type data;					\
+	if (__get_user(data, p))			\
+		goto label;				\
+	*(type *)dst = data;				\
+}
+
+#define __put_kernel_nofault(dst, src, type, label)	\
+{							\
+	type __user *p = (type __force __user *)(dst);	\
+	type data = *(type *)src;			\
+	if (__put_user(data, p))			\
+		goto label;				\
+}
+
+#define HAVE_GET_KERNEL_NOFAULT
+
 static inline unsigned long
 raw_copy_from_user(void *to, const void __user *from, unsigned long n)
 {
diff --git a/arch/microblaze/kernel/asm-offsets.c b/arch/microblaze/kernel/asm-offsets.c
index b77dd188dec4..47ee409508b1 100644
--- a/arch/microblaze/kernel/asm-offsets.c
+++ b/arch/microblaze/kernel/asm-offsets.c
@@ -86,7 +86,6 @@ int main(int argc, char *argv[])
 	/* struct thread_info */
 	DEFINE(TI_TASK, offsetof(struct thread_info, task));
 	DEFINE(TI_FLAGS, offsetof(struct thread_info, flags));
-	DEFINE(TI_ADDR_LIMIT, offsetof(struct thread_info, addr_limit));
 	DEFINE(TI_CPU_CONTEXT, offsetof(struct thread_info, cpu_context));
 	DEFINE(TI_PREEMPT_COUNT, offsetof(struct thread_info, preempt_count));
 	BLANK();
-- 
2.29.2

