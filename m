Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66A05495EE6
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 13:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380315AbiAUMMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 07:12:52 -0500
Received: from foss.arm.com ([217.140.110.172]:50184 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237622AbiAUMMt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 07:12:49 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A4AD01FB;
        Fri, 21 Jan 2022 04:12:48 -0800 (PST)
Received: from e119884-lin.cambridge.arm.com (e119884-lin.cambridge.arm.com [10.1.196.72])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B94AF3F766;
        Fri, 21 Jan 2022 04:12:47 -0800 (PST)
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH] arm64: vdso: Fix "no previous prototype" warning
Date:   Fri, 21 Jan 2022 12:12:34 +0000
Message-Id: <20220121121234.47273-1-vincenzo.frascino@arm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220109113504.1921017-1-mkl@pengutronix.de>
References: <20220109113504.1921017-1-mkl@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If compiling the arm64 kernel with W=1 the following warning is produced:

| arch/arm64/kernel/vdso/vgettimeofday.c:9:5: error: no previous prototype for ‘__kernel_clock_gettime’ [-Werror=missing-prototypes]
|     9 | int __kernel_clock_gettime(clockid_t clock,
|       |     ^~~~~~~~~~~~~~~~~~~~~~
| arch/arm64/kernel/vdso/vgettimeofday.c:15:5: error: no previous prototype for ‘__kernel_gettimeofday’ [-Werror=missing-prototypes]
|    15 | int __kernel_gettimeofday(struct __kernel_old_timeval *tv,
|       |     ^~~~~~~~~~~~~~~~~~~~~
| arch/arm64/kernel/vdso/vgettimeofday.c:21:5: error: no previous prototype for ‘__kernel_clock_getres’ [-Werror=missing-prototypes]
|    21 | int __kernel_clock_getres(clockid_t clock_id,
|       |     ^~~~~~~~~~~~~~~~~~~~~

This patch removes "-Wmissing-prototypes" and "-Wmissing-declarations" compilers
flags from the compilation of vgettimeofday.c to make possible to build the
kernel with CONFIG_WERROR enabled.

Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
Suggested-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
---
 arch/arm64/kernel/vdso/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso/Makefile b/arch/arm64/kernel/vdso/Makefile
index 60813497a381..172452f79e46 100644
--- a/arch/arm64/kernel/vdso/Makefile
+++ b/arch/arm64/kernel/vdso/Makefile
@@ -29,8 +29,11 @@ ldflags-y := -shared -soname=linux-vdso.so.1 --hash-style=sysv	\
 ccflags-y := -fno-common -fno-builtin -fno-stack-protector -ffixed-x18
 ccflags-y += -DDISABLE_BRANCH_PROFILING -DBUILD_VDSO
 
+# -Wmissing-prototypes and -Wmissing-declarations are removed from
+# the CFLAGS of vgettimeofday.c to make possible to build the
+# kernel with CONFIG_WERROR enabled.
 CFLAGS_REMOVE_vgettimeofday.o = $(CC_FLAGS_FTRACE) -Os $(CC_FLAGS_SCS) $(GCC_PLUGINS_CFLAGS) \
-				$(CC_FLAGS_LTO)
+				$(CC_FLAGS_LTO) -Wmissing-prototypes -Wmissing-declarations
 KASAN_SANITIZE			:= n
 KCSAN_SANITIZE			:= n
 UBSAN_SANITIZE			:= n
-- 
2.34.1

