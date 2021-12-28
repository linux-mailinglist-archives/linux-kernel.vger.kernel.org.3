Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10042480A2C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Dec 2021 15:40:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbhL1Okr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Dec 2021 09:40:47 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:52466 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234338AbhL1Okq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Dec 2021 09:40:46 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 41903B81215;
        Tue, 28 Dec 2021 14:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36233C36AE7;
        Tue, 28 Dec 2021 14:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640702443;
        bh=+qhzOX7FtWSdIhI7QlRbOlwinMS8T4cEoNqCEnZxYUg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jmY2KODyWVX4SJY0lIuz7Q+BDC478KFs/qBDBWcbDXaj1W8Df0mmlOk5JvOw9PPU4
         OhZJJaqVS78O/L1tSsdiRkE5Bfboj6V/wNh9hidfIuCAIh3HqRyfYCJS+lPGMmNlKk
         jjE6ey3V0dPx59u2wps9oPShYcR3TWMv9WqynRcK2/c4YY7qzx2ZVuYFTvYy8GNrId
         k8wbli6m1mW5MXgDy2wAUfQ7nyyyZHDawtqz3enxaKgFbWYxVqW1zgOe3T57dDMlBg
         Ac24kG3Efv/WXOrSupGII3tt9tfnyNQyZOez8CDWg8KyPkMO2L8Dn1POviHrmSLeLi
         5UbAQBYeeUovQ==
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
Subject: [PATCH V2 05/17] syscalls: compat: Fix the missing part for __SYSCALL_COMPAT
Date:   Tue, 28 Dec 2021 22:39:46 +0800
Message-Id: <20211228143958.3409187-6-guoren@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211228143958.3409187-1-guoren@kernel.org>
References: <20211228143958.3409187-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Make "uapi asm unistd.h" could be used for architectures' COMPAT
mode. The __SYSCALL_COMPAT is first used in riscv.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/asm-generic/unistd.h       | 4 ++--
 tools/include/uapi/asm-generic/unistd.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 4557a8b6086f..aafe5cfeb27c 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -383,7 +383,7 @@ __SYSCALL(__NR_syslog, sys_syslog)
 
 /* kernel/ptrace.c */
 #define __NR_ptrace 117
-__SYSCALL(__NR_ptrace, sys_ptrace)
+__SC_COMP(__NR_ptrace, sys_ptrace, compat_sys_ptrace)
 
 /* kernel/sched/core.c */
 #define __NR_sched_setparam 118
@@ -779,7 +779,7 @@ __SYSCALL(__NR_rseq, sys_rseq)
 #define __NR_kexec_file_load 294
 __SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
 /* 295 through 402 are unassigned to sync up with generic numbers, don't use */
-#if __BITS_PER_LONG == 32
+#if defined(__SYSCALL_COMPAT) || __BITS_PER_LONG == 32
 #define __NR_clock_gettime64 403
 __SYSCALL(__NR_clock_gettime64, sys_clock_gettime)
 #define __NR_clock_settime64 404
diff --git a/tools/include/uapi/asm-generic/unistd.h b/tools/include/uapi/asm-generic/unistd.h
index 4557a8b6086f..aafe5cfeb27c 100644
--- a/tools/include/uapi/asm-generic/unistd.h
+++ b/tools/include/uapi/asm-generic/unistd.h
@@ -383,7 +383,7 @@ __SYSCALL(__NR_syslog, sys_syslog)
 
 /* kernel/ptrace.c */
 #define __NR_ptrace 117
-__SYSCALL(__NR_ptrace, sys_ptrace)
+__SC_COMP(__NR_ptrace, sys_ptrace, compat_sys_ptrace)
 
 /* kernel/sched/core.c */
 #define __NR_sched_setparam 118
@@ -779,7 +779,7 @@ __SYSCALL(__NR_rseq, sys_rseq)
 #define __NR_kexec_file_load 294
 __SYSCALL(__NR_kexec_file_load,     sys_kexec_file_load)
 /* 295 through 402 are unassigned to sync up with generic numbers, don't use */
-#if __BITS_PER_LONG == 32
+#if defined(__SYSCALL_COMPAT) || __BITS_PER_LONG == 32
 #define __NR_clock_gettime64 403
 __SYSCALL(__NR_clock_gettime64, sys_clock_gettime)
 #define __NR_clock_settime64 404
-- 
2.25.1

