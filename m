Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B25947C3DC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 17:36:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239846AbhLUQgI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 11:36:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239856AbhLUQgF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 11:36:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C8F0C061401;
        Tue, 21 Dec 2021 08:36:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA799B81722;
        Tue, 21 Dec 2021 16:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486E2C36AE8;
        Tue, 21 Dec 2021 16:35:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640104562;
        bh=cBmBjJqc39uhGxOHQbIuz8go+AJACz6x34Rsmj9vtKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z20TRxowOiWW5Y8Oy0qdAA/PB8BLdrgphbD5xpDZ4vwY7/XrQvUQEjpjzQJM5/pO2
         kQ43LXYB1Chei/6vua5YzYwz7FUN7ypTomA9MxNYkl8luch/MRkHaXrI+7/x2p7Uoy
         5lycFkaR2DyJSZPh8b9/BZf8TfaFYdN0Sz+SKUpt55qca4j/sCgUA12uqXUD07HfUz
         GAZupTGtlG22DBcWHypaX3FCH9UCE+Ac24uwIIovEgLgvoM8GLWCpryNvuFC2+1dMu
         GsD6HNUTkiFtiqnwEVEUbkGKEBer+YA7dI/5cNOT2ZqwU5HEz9nST8gybQPQUZO5Hf
         UYzd0UXoxypgw==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        anup.patel@wdc.com, gregkh@linuxfoundation.org,
        liush@allwinnertech.com, wefu@redhat.com, drew@beagleboard.org,
        wangjunqiang@iscas.ac.cn, lazyparser@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 04/13] riscv: compat: Re-implement TASK_SIZE for COMPAT_32BIT
Date:   Wed, 22 Dec 2021 00:35:23 +0800
Message-Id: <20211221163532.2636028-5-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211221163532.2636028-1-guoren@kernel.org>
References: <20211221163532.2636028-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Make TASK_SIZE from const to dynamic detect TIF_32BIT flag
function. Refer to arm64 to implement DEFAULT_MAP_WINDOW_64 for
efi-stub.

Limit 32-bit compatible process in 0-2GB virtual address range
(which is enough for real scenarios), because it could avoid
address sign extend problem when 32-bit enter 64-bit and ease
software design.

The standard 32-bit TASK_SIZE is 0x9dc00000:FIXADDR_START, and
compared to a compatible 32-bit, it increases 476MB for the
application's virtual address.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/include/asm/pgtable.h        | 11 ++++++++++-
 arch/riscv/include/asm/processor.h      |  6 ++++++
 drivers/firmware/efi/libstub/efi-stub.c |  2 +-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index bf204e7c1f74..2dd5b8674380 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -663,7 +663,16 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
  * Note that PGDIR_SIZE must evenly divide TASK_SIZE.
  */
 #ifdef CONFIG_64BIT
-#define TASK_SIZE (PGDIR_SIZE * PTRS_PER_PGD / 2)
+#define TASK_SIZE_64	(PGDIR_SIZE * PTRS_PER_PGD / 2)
+
+#ifdef CONFIG_COMPAT
+#define TASK_SIZE_32	(_AC(0x80000000, UL) - PAGE_SIZE)
+#define TASK_SIZE	(test_thread_flag(TIF_32BIT) ? \
+			 TASK_SIZE_32 : TASK_SIZE_64)
+#else
+#define TASK_SIZE	TASK_SIZE_64
+#endif
+
 #else
 #define TASK_SIZE FIXADDR_START
 #endif
diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 0749924d9e55..8649436b8fcf 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -61,6 +61,12 @@ static inline void arch_thread_struct_whitelist(unsigned long *offset,
 extern void start_thread(struct pt_regs *regs,
 			unsigned long pc, unsigned long sp);
 
+#ifdef CONFIG_COMPAT
+#define DEFAULT_MAP_WINDOW_64 TASK_SIZE_64
+#else
+#define DEFAULT_MAP_WINDOW_64 TASK_SIZE
+#endif
+
 /* Free all resources held by a thread. */
 static inline void release_thread(struct task_struct *dead_task)
 {
diff --git a/drivers/firmware/efi/libstub/efi-stub.c b/drivers/firmware/efi/libstub/efi-stub.c
index 26e69788f27a..4075fd19d219 100644
--- a/drivers/firmware/efi/libstub/efi-stub.c
+++ b/drivers/firmware/efi/libstub/efi-stub.c
@@ -38,7 +38,7 @@
 #define EFI_RT_VIRTUAL_BASE	SZ_512M
 #define EFI_RT_VIRTUAL_SIZE	SZ_512M
 
-#ifdef CONFIG_ARM64
+#if defined(CONFIG_ARM64) || defined(CONFIG_RISCV)
 # define EFI_RT_VIRTUAL_LIMIT	DEFAULT_MAP_WINDOW_64
 #else
 # define EFI_RT_VIRTUAL_LIMIT	TASK_SIZE
-- 
2.25.1

