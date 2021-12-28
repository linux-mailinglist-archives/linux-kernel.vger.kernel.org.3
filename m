Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49F11480A18
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 15:40:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234221AbhL1OkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 09:40:21 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52132 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234170AbhL1OkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 09:40:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1BFABB81217;
        Tue, 28 Dec 2021 14:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6636EC36AE7;
        Tue, 28 Dec 2021 14:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640702417;
        bh=m9/MBzAUgH+3KenwcR170Cj1Yqb+dUCRfCU8056oorc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SuDQRxSBTndFbHqf8KdtDab88SNqvj/cQ/AfoJQO48Qkn/amkzXV/X/2iffYfS10f
         VFV7QjJTAGQ7XCt/9cKHnWv5qWRIxxBrEX/M9K46pETIe5ghQUW+Y8g5UtKqyphafa
         ZqMXPRLBP4yFgHQsiWo881KQBpfm7oig8ZyKhUcVBYq3GzLDbP+Yun2ubgoOwelRd/
         DmgjYeSF4LhhlWdL6pYydsGkAdQq7JdokK/AanUGi2UqohMooEioITwhOhz6iVxVpr
         rJ1Yb+4vsFe3e1dIEvOdANIoisCyWczgl3hCy+jb81ywaTfy5UNHFsp2KfawLq4JjX
         zbieBkXKw4Gqg==
From:   guoren@kernel.org
To:     guoren@kernel.org, palmer@dabbelt.com, arnd@arndb.de,
        anup.patel@wdc.com, gregkh@linuxfoundation.org,
        liush@allwinnertech.com, wefu@redhat.com, drew@beagleboard.org,
        wangjunqiang@iscas.ac.cn, hch@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        inux-parisc@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH V2 01/17] kconfig: Add SYSVIPC_COMPAT for all architectures
Date:   Tue, 28 Dec 2021 22:39:42 +0800
Message-Id: <20211228143958.3409187-2-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211228143958.3409187-1-guoren@kernel.org>
References: <20211228143958.3409187-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

The existing per-arch definitions are pretty much historic cruft.
Move SYSVIPC_COMPAT into init/Kconfig.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@infradead.org>
---
 arch/arm64/Kconfig   | 4 ----
 arch/mips/Kconfig    | 5 -----
 arch/parisc/Kconfig  | 4 ----
 arch/powerpc/Kconfig | 5 -----
 arch/s390/Kconfig    | 3 ---
 arch/sparc/Kconfig   | 5 -----
 arch/x86/Kconfig     | 4 ----
 init/Kconfig         | 4 ++++
 8 files changed, 4 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index c4207cf9bb17..8ca8cc6f3253 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -2028,10 +2028,6 @@ config DMI
 
 endmenu
 
-config SYSVIPC_COMPAT
-	def_bool y
-	depends on COMPAT && SYSVIPC
-
 menu "Power management options"
 
 source "kernel/power/Kconfig"
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 0215dc1529e9..b84eba22fefe 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -3169,16 +3169,12 @@ config MIPS32_COMPAT
 config COMPAT
 	bool
 
-config SYSVIPC_COMPAT
-	bool
-
 config MIPS32_O32
 	bool "Kernel support for o32 binaries"
 	depends on 64BIT
 	select ARCH_WANT_OLD_COMPAT_IPC
 	select COMPAT
 	select MIPS32_COMPAT
-	select SYSVIPC_COMPAT if SYSVIPC
 	help
 	  Select this option if you want to run o32 binaries.  These are pure
 	  32-bit binaries as used by the 32-bit Linux/MIPS port.  Most of
@@ -3192,7 +3188,6 @@ config MIPS32_N32
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
 	select COMPAT
 	select MIPS32_COMPAT
-	select SYSVIPC_COMPAT if SYSVIPC
 	help
 	  Select this option if you want to run n32 binaries.  These are
 	  64-bit binaries using 32-bit quantities for addressing and certain
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index b2188da09c73..bd72696cbd42 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -364,10 +364,6 @@ config COMPAT
 	def_bool y
 	depends on 64BIT
 
-config SYSVIPC_COMPAT
-	def_bool y
-	depends on COMPAT && SYSVIPC
-
 config AUDIT_ARCH
 	def_bool y
 
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index dea74d7717c0..81d198daa998 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -296,11 +296,6 @@ config COMPAT
 	select ARCH_WANT_OLD_COMPAT_IPC
 	select COMPAT_OLD_SIGACTION
 
-config SYSVIPC_COMPAT
-	bool
-	depends on COMPAT && SYSVIPC
-	default y
-
 config SCHED_OMIT_FRAME_POINTER
 	bool
 	default y
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 2a5bb4f29cfe..c1816ca7ae43 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -461,9 +461,6 @@ config COMPAT
 	  (and some other stuff like libraries and such) is needed for
 	  executing 31 bit applications.  It is safe to say "Y".
 
-config SYSVIPC_COMPAT
-	def_bool y if COMPAT && SYSVIPC
-
 config SMP
 	def_bool y
 
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 66fc08646be5..45401b99d6cb 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -494,9 +494,4 @@ config COMPAT
 	select ARCH_WANT_OLD_COMPAT_IPC
 	select COMPAT_OLD_SIGACTION
 
-config SYSVIPC_COMPAT
-	bool
-	depends on COMPAT && SYSVIPC
-	default y
-
 source "drivers/sbus/char/Kconfig"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 5c2ccb85f2ef..569703122cce 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2850,10 +2850,6 @@ config COMPAT
 if COMPAT
 config COMPAT_FOR_U64_ALIGNMENT
 	def_bool y
-
-config SYSVIPC_COMPAT
-	def_bool y
-	depends on SYSVIPC
 endif
 
 endmenu
diff --git a/init/Kconfig b/init/Kconfig
index 4b7bac10c72d..aa0d63677c82 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -386,6 +386,10 @@ config SYSVIPC_SYSCTL
 	depends on SYSCTL
 	default y
 
+config SYSVIPC_COMPAT
+	def_bool y
+	depends on COMPAT && SYSVIPC
+
 config POSIX_MQUEUE
 	bool "POSIX Message Queues"
 	depends on NET
-- 
2.25.1

