Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9770D494891
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 08:42:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357693AbiATHlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 02:41:13 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:34272 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359103AbiATHk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 02:40:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9CA73B81CEE;
        Thu, 20 Jan 2022 07:40:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91272C340E7;
        Thu, 20 Jan 2022 07:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642664423;
        bh=+foGi24mAAkXv8HxHMW+tCVoz4WSBNmzOsAdyp+IN6s=;
        h=From:To:Cc:Subject:Date:From;
        b=lom4qx8Te+fvkiYhBhSctO4VuKi6tI0DbDmkHwpzmV//j2i2ErVO3t7aDskslPgRk
         LXTRb5IbUV0LggS3rARH7FiiY0sWWAT9q10+8hsW1WjRumx52fSr5qZJKdbQfdUUS7
         kAQvkC0DVHon+jSt2vPO8VA514PVFxa+kNydggWhJNkc43VoOnglGKDpg5szAiFQur
         prLryGZqMuK0lxnZOklFZOwDE8CIEOpqR8J1HPksfNnG6dbefol4ArvNWMQMcXHeyO
         Yxw7TwdmL7JKjLzKI8rr/xbpzXgy8JvrhlnHCqbqMlk/yMvPXvVNEF2wZN8MMCH0DO
         cEGKyYdX/LGLg==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        anup@brainfault.org, gregkh@linuxfoundation.org,
        liush@allwinnertech.com, wefu@redhat.com, drew@beagleboard.org,
        wangjunqiang@iscas.ac.cn, hch@lst.de, hch@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        inux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V3 07/17] riscv: compat: Re-implement TASK_SIZE for COMPAT_32BIT
Date:   Thu, 20 Jan 2022 15:39:00 +0800
Message-Id: <20220120073911.99857-8-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
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
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/riscv/include/asm/pgtable.h        | 11 ++++++++++-
 arch/riscv/include/asm/processor.h      |  6 ++++++
 drivers/firmware/efi/libstub/efi-stub.c |  2 +-
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
index 67f687aee673..e0add598e66a 100644
--- a/arch/riscv/include/asm/pgtable.h
+++ b/arch/riscv/include/asm/pgtable.h
@@ -669,7 +669,16 @@ static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
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
index e87e7f1b1a33..f57f85646a45 100644
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

