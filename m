Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D95A7494872
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 08:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358805AbiATHkF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 02:40:05 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:33964 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359041AbiATHjs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 02:39:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2A154B81CEF;
        Thu, 20 Jan 2022 07:39:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17D94C340E4;
        Thu, 20 Jan 2022 07:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642664386;
        bh=wgws1+8L9i7kbgvgjdXAZl1XEXSQpZhiEofGPemoDl4=;
        h=From:To:Cc:Subject:Date:From;
        b=ud8l55tDJs0qsT01YNvnvWlOjIPKiurRmv+VTuSNrEiZD9q/k0YA3cROmmbFVIR2l
         nxELsCgfhZTAXqrWeYMw7ujI8NgOifJIyGOYjXNXKiqdu4EYVO5DFQThdLqCwOLf3N
         7cQ2xcz3nbSLOkM1FTf9yegh8JsjDbntzNSNz/PHI/rZ5oLmvwlNcwO8Shjkmgjat0
         9IFeN00MNcpfYpoYG9soTzGa9F/vMau5+E83t+ioOak5tzofeUoSTdhKwJuaapeFn3
         Fii9X23QYYXRbJFtE1QijCuHlxV8VrQYEm7J8hGmRk6mtRInHLFHIjm4RI2tO/QNaW
         OBjHH733VOmcA==
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
Subject: [PATCH V3 02/17] fs: stat: compat: Add __ARCH_WANT_COMPAT_STAT
Date:   Thu, 20 Jan 2022 15:38:55 +0800
Message-Id: <20220120073911.99857-3-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

RISC-V doesn't neeed compat_stat, so using __ARCH_WANT_COMPAT_STAT
to exclude unnecessary SYSCALL functions.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/unistd.h   | 1 +
 arch/mips/include/asm/unistd.h    | 2 ++
 arch/parisc/include/asm/unistd.h  | 1 +
 arch/powerpc/include/asm/unistd.h | 1 +
 arch/s390/include/asm/unistd.h    | 1 +
 arch/sparc/include/asm/unistd.h   | 1 +
 arch/x86/include/asm/unistd.h     | 1 +
 fs/stat.c                         | 2 +-
 8 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/unistd.h b/arch/arm64/include/asm/unistd.h
index 4e65da3445c7..037feba03a51 100644
--- a/arch/arm64/include/asm/unistd.h
+++ b/arch/arm64/include/asm/unistd.h
@@ -3,6 +3,7 @@
  * Copyright (C) 2012 ARM Ltd.
  */
 #ifdef CONFIG_COMPAT
+#define __ARCH_WANT_COMPAT_STAT
 #define __ARCH_WANT_COMPAT_STAT64
 #define __ARCH_WANT_SYS_GETHOSTNAME
 #define __ARCH_WANT_SYS_PAUSE
diff --git a/arch/mips/include/asm/unistd.h b/arch/mips/include/asm/unistd.h
index c2196b1b6604..25a5253db7f4 100644
--- a/arch/mips/include/asm/unistd.h
+++ b/arch/mips/include/asm/unistd.h
@@ -50,6 +50,8 @@
 # ifdef CONFIG_32BIT
 #  define __ARCH_WANT_STAT64
 #  define __ARCH_WANT_SYS_TIME32
+# else
+#  define __ARCH_WANT_COMPAT_STAT
 # endif
 # ifdef CONFIG_MIPS32_O32
 #  define __ARCH_WANT_SYS_TIME32
diff --git a/arch/parisc/include/asm/unistd.h b/arch/parisc/include/asm/unistd.h
index cd438e4150f6..14e0668184cb 100644
--- a/arch/parisc/include/asm/unistd.h
+++ b/arch/parisc/include/asm/unistd.h
@@ -168,6 +168,7 @@ type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, type5 arg5)	\
 #define __ARCH_WANT_SYS_CLONE
 #define __ARCH_WANT_SYS_CLONE3
 #define __ARCH_WANT_COMPAT_SYS_SENDFILE
+#define __ARCH_WANT_COMPAT_STAT
 
 #ifdef CONFIG_64BIT
 #define __ARCH_WANT_SYS_TIME
diff --git a/arch/powerpc/include/asm/unistd.h b/arch/powerpc/include/asm/unistd.h
index 5eb462af6766..b1129b4ef57d 100644
--- a/arch/powerpc/include/asm/unistd.h
+++ b/arch/powerpc/include/asm/unistd.h
@@ -44,6 +44,7 @@
 #define __ARCH_WANT_SYS_TIME
 #define __ARCH_WANT_SYS_UTIME
 #define __ARCH_WANT_SYS_NEWFSTATAT
+#define __ARCH_WANT_COMPAT_STAT
 #define __ARCH_WANT_COMPAT_SYS_SENDFILE
 #endif
 #define __ARCH_WANT_SYS_FORK
diff --git a/arch/s390/include/asm/unistd.h b/arch/s390/include/asm/unistd.h
index 9e9f75ef046a..4260bc5ce7f8 100644
--- a/arch/s390/include/asm/unistd.h
+++ b/arch/s390/include/asm/unistd.h
@@ -28,6 +28,7 @@
 #define __ARCH_WANT_SYS_SIGPENDING
 #define __ARCH_WANT_SYS_SIGPROCMASK
 # ifdef CONFIG_COMPAT
+#   define __ARCH_WANT_COMPAT_STAT
 #   define __ARCH_WANT_SYS_TIME32
 #   define __ARCH_WANT_SYS_UTIME32
 # endif
diff --git a/arch/sparc/include/asm/unistd.h b/arch/sparc/include/asm/unistd.h
index 1e66278ba4a5..d6bc76706a7a 100644
--- a/arch/sparc/include/asm/unistd.h
+++ b/arch/sparc/include/asm/unistd.h
@@ -46,6 +46,7 @@
 #define __ARCH_WANT_SYS_TIME
 #define __ARCH_WANT_SYS_UTIME
 #define __ARCH_WANT_COMPAT_SYS_SENDFILE
+#define __ARCH_WANT_COMPAT_STAT
 #endif
 
 #ifdef __32bit_syscall_numbers__
diff --git a/arch/x86/include/asm/unistd.h b/arch/x86/include/asm/unistd.h
index 80e9d5206a71..761173ccc33c 100644
--- a/arch/x86/include/asm/unistd.h
+++ b/arch/x86/include/asm/unistd.h
@@ -22,6 +22,7 @@
 #  include <asm/unistd_32_ia32.h>
 #  define __ARCH_WANT_SYS_TIME
 #  define __ARCH_WANT_SYS_UTIME
+#  define __ARCH_WANT_COMPAT_STAT
 #  define __ARCH_WANT_COMPAT_SYS_PREADV64
 #  define __ARCH_WANT_COMPAT_SYS_PWRITEV64
 #  define __ARCH_WANT_COMPAT_SYS_PREADV64V2
diff --git a/fs/stat.c b/fs/stat.c
index 28d2020ba1f4..ffdeb9065d53 100644
--- a/fs/stat.c
+++ b/fs/stat.c
@@ -639,7 +639,7 @@ SYSCALL_DEFINE5(statx,
 	return do_statx(dfd, filename, flags, mask, buffer);
 }
 
-#ifdef CONFIG_COMPAT
+#if defined(CONFIG_COMPAT) && defined(__ARCH_WANT_COMPAT_STAT)
 static int cp_compat_stat(struct kstat *stat, struct compat_stat __user *ubuf)
 {
 	struct compat_stat tmp;
-- 
2.25.1

