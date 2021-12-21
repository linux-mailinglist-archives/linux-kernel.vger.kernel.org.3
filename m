Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D18247C3DE
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 17:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239861AbhLUQgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 11:36:11 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53790 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239850AbhLUQgJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 11:36:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D20C6B8173F;
        Tue, 21 Dec 2021 16:36:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D353C36AEA;
        Tue, 21 Dec 2021 16:36:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640104566;
        bh=faphGyURWtXEOMLKUCGGnY6spV2KyoBcjjwgGbOApL0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aR/lUQ3Dl/Yrlw2FPQpM8gDT3ARBPF5FXM+b7HA2ng28yMnFUO6rxFWxKmsmJT0Xi
         cAfsd31NvOSrnEzrHbhpPRcWHE2pLL+b2JfaPqbFeqiERHGx60Xl4qOnp/YWbCw4Qh
         tbtJ2+eCNx5b3jmpR6mzxVUTb18DrtjHAYBAUmNYgSTE8YF0Z00XgSp1RfER8jkFu9
         OCEAMYW7ntoWpg+XcHMIy8zGsYdNXzsw7D42lTB+uWG1PvMAtxyo2D0BgaTS1YHe8R
         F9+/wdd2guvw60dADD1QmDVxx14WxZA/sgjV0FraFibyNP0e1QxLyaW2mjTuCF/IUH
         m8U61P3lOguJQ==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        anup.patel@wdc.com, gregkh@linuxfoundation.org,
        liush@allwinnertech.com, wefu@redhat.com, drew@beagleboard.org,
        wangjunqiang@iscas.ac.cn, lazyparser@gmail.com
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 05/13] riscv: compat: syscall: Add compat_sys_call_table implementation
Date:   Wed, 22 Dec 2021 00:35:24 +0800
Message-Id: <20211221163532.2636028-6-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211221163532.2636028-1-guoren@kernel.org>
References: <20211221163532.2636028-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Implement compat_syscall_table.c with compat_sys_call_table & fixup
system call such as truncate64,pread64,fallocate which need two
regs to indicate 64bit-arg (copied from arm64).

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
---
 arch/riscv/include/asm/syscall.h         |  3 +
 arch/riscv/kernel/compat_syscall_table.c | 84 ++++++++++++++++++++++++
 2 files changed, 87 insertions(+)
 create mode 100644 arch/riscv/kernel/compat_syscall_table.c

diff --git a/arch/riscv/include/asm/syscall.h b/arch/riscv/include/asm/syscall.h
index 7ac6a0e275f2..4ff98a22ef24 100644
--- a/arch/riscv/include/asm/syscall.h
+++ b/arch/riscv/include/asm/syscall.h
@@ -16,6 +16,9 @@
 
 /* The array of function pointers for syscalls. */
 extern void * const sys_call_table[];
+#ifdef CONFIG_COMPAT
+extern void * const compat_sys_call_table[];
+#endif
 
 /*
  * Only the low 32 bits of orig_r0 are meaningful, so we return int.
diff --git a/arch/riscv/kernel/compat_syscall_table.c b/arch/riscv/kernel/compat_syscall_table.c
new file mode 100644
index 000000000000..9b81fb9a8683
--- /dev/null
+++ b/arch/riscv/kernel/compat_syscall_table.c
@@ -0,0 +1,84 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#define __SYSCALL_COMPAT
+#undef __LP64__
+
+#include <linux/compat.h>
+#include <linux/syscalls.h>
+#include <asm-generic/mman-common.h>
+#include <asm-generic/syscalls.h>
+#include <asm/syscall.h>
+
+SYSCALL_DEFINE6(mmap2, unsigned long, addr, unsigned long, len,
+	unsigned long, prot, unsigned long, flags,
+	unsigned long, fd, unsigned long, offset)
+{
+	if ((prot & PROT_WRITE) && (prot & PROT_EXEC))
+		if (unlikely(!(prot & PROT_READ)))
+			return -EINVAL;
+
+	return ksys_mmap_pgoff(addr, len, prot, flags, fd, offset);
+}
+
+#define arg_u32p(name)  u32, name##_lo, u32, name##_hi
+
+#define arg_u64(name)   (((u64)name##_hi << 32) | \
+			 ((u64)name##_lo & 0xffffffff))
+
+COMPAT_SYSCALL_DEFINE3(truncate64, const char __user *, pathname,
+		       arg_u32p(length))
+{
+	return ksys_truncate(pathname, arg_u64(length));
+}
+
+COMPAT_SYSCALL_DEFINE3(ftruncate64, unsigned int, fd, arg_u32p(length))
+{
+	return ksys_ftruncate(fd, arg_u64(length));
+}
+
+COMPAT_SYSCALL_DEFINE6(fallocate, int, fd, int, mode,
+		       arg_u32p(offset), arg_u32p(len))
+{
+	return ksys_fallocate(fd, mode, arg_u64(offset), arg_u64(len));
+}
+
+COMPAT_SYSCALL_DEFINE5(pread64, unsigned int, fd, char __user *, buf,
+		       size_t, count, arg_u32p(pos))
+{
+	return ksys_pread64(fd, buf, count, arg_u64(pos));
+}
+
+COMPAT_SYSCALL_DEFINE5(pwrite64, unsigned int, fd,
+		       const char __user *, buf, size_t, count, arg_u32p(pos))
+{
+	return ksys_pwrite64(fd, buf, count, arg_u64(pos));
+}
+
+COMPAT_SYSCALL_DEFINE6(sync_file_range, int, fd, arg_u32p(offset),
+		       arg_u32p(nbytes), unsigned int, flags)
+{
+	return ksys_sync_file_range(fd, arg_u64(offset), arg_u64(nbytes),
+				    flags);
+}
+
+COMPAT_SYSCALL_DEFINE4(readahead, int, fd, arg_u32p(offset),
+		       size_t, count)
+{
+	return ksys_readahead(fd, arg_u64(offset), count);
+}
+
+COMPAT_SYSCALL_DEFINE6(fadvise64_64, int, fd, int, advice, arg_u32p(offset),
+		       arg_u32p(len))
+{
+	return ksys_fadvise64_64(fd, arg_u64(offset), arg_u64(len), advice);
+}
+
+#undef __SYSCALL
+#define __SYSCALL(nr, call)      [nr] = (call),
+
+asmlinkage long compat_sys_rt_sigreturn(void);
+
+void * const compat_sys_call_table[__NR_syscalls] = {
+	[0 ... __NR_syscalls - 1] = sys_ni_syscall,
+#include <asm/unistd.h>
+};
-- 
2.25.1

