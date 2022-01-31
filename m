Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 054DF4A3F0C
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 10:07:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234516AbiAaJH5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 04:07:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234397AbiAaJHs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 04:07:48 -0500
Received: from mail-wm1-x349.google.com (mail-wm1-x349.google.com [IPv6:2a00:1450:4864:20::349])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D213C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 01:07:46 -0800 (PST)
Received: by mail-wm1-x349.google.com with SMTP id v185-20020a1cacc2000000b0034906580813so10070220wme.1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 01:07:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Bko2bBOFt8SFav6I5TjYOIulrzQuEbXeq+2gLbCWAVI=;
        b=sSmlJYozmYThA2O9gEj8NcX81sjnLIMmnNuddGd24vO0kHkAjWApKSsxMBRveAZdas
         lMCb0Hg4j5DWgstoNW22bQKdU6vEZXbY4OHaacX1kjX1iDwHeNdtu25YCr0g9qZDVufe
         wTvexoeRxifXBfzJcQDF9Y+EiulHdFhPHhoLIelkVEW88GJnF+fVq/fbHG8NZjic3fjb
         wfG1Ns+bMU7vM9+zjgLUDwAH+nOVdIZ2LfP5u2t9teBkPIO+lGvyFMBqYQmeG8R5fgP1
         r/ZbtcwgrFs/EhayiW39fNoe2rMfpxYsZRGkZ2FT2ivfDY0Tv2LaycUSO+/w6A2HnnYi
         M26Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Bko2bBOFt8SFav6I5TjYOIulrzQuEbXeq+2gLbCWAVI=;
        b=lLU+NlhKk6fJbGzT/dGOWDo5n0GzF51mQhXmADjMvtmsIs5wVNy7BOpgAvwjIOeBKF
         z79z4Bjc3BqPbKt9zrCxD+8ZeiitbX3oBqSGiPo+YeT3dG1HNsWQ9QlQJoB+WAVTtaq8
         aDvPyc5eXTjvoQmeRAcAjflQ0unl2Nuo9CYDbqg8CBtMs7XbzYJdrh7hiGnr7F8I7GNp
         HlChAxwrdgSWkuwQypzhfnqufbqTjchjsdCrmgKmL6BPkefxaxaT2RSOoGJhB2eVBrzw
         JNGt3Vacs1LgDcyLYT6L0KYKAXWs5T372jSkDdH4HqGdvIx7tzi0awNvilYEcEe3katl
         usrg==
X-Gm-Message-State: AOAM532D1O35T0JUGXh63TLiMiMjSaQEJ6V9aNcnbaWtPQqDYTHw+Qke
        ZmwIvUbC6+3Y4t+dIvWWrdOFVWOK+g==
X-Google-Smtp-Source: ABdhPJxrdHCArDGaHzsq5ML+QFS3K9GYi+DLIQHLfVABlfCy8j3KELH38OY+E7uZJ2JSgzwZoy2pCDp3IQ==
X-Received: from elver.muc.corp.google.com ([2a00:79e0:15:13:9caa:cc34:599f:ecd4])
 (user=elver job=sendgmr) by 2002:a05:600c:2741:: with SMTP id
 1mr17797025wmw.50.1643620064562; Mon, 31 Jan 2022 01:07:44 -0800 (PST)
Date:   Mon, 31 Jan 2022 10:05:21 +0100
In-Reply-To: <20220131090521.1947110-1-elver@google.com>
Message-Id: <20220131090521.1947110-2-elver@google.com>
Mime-Version: 1.0
References: <20220131090521.1947110-1-elver@google.com>
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH v2 2/2] stack: Constrain and fix stack offset randomization
 with Clang builds
From:   Marco Elver <elver@google.com>
To:     elver@google.com, Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Alexander Potapenko <glider@google.com>, llvm@lists.linux.dev,
        kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

All supported versions of Clang perform auto-init of __builtin_alloca()
when stack auto-init is on (CONFIG_INIT_STACK_ALL_{ZERO,PATTERN}).

add_random_kstack_offset() uses __builtin_alloca() to add a stack
offset. This means, when CONFIG_INIT_STACK_ALL_{ZERO,PATTERN} is
enabled, add_random_kstack_offset() will auto-init that unused portion
of the stack used to add an offset.

There are several problems with this:

	1. These offsets can be as large as 1023 bytes. Performing
	   memset() on them isn't exactly cheap, and this is done on
	   every syscall entry.

	2. Architectures adding add_random_kstack_offset() to syscall
	   entry implemented in C require them to be 'noinstr' (e.g. see
	   x86 and s390). The potential problem here is that a call to
	   memset may occur, which is not noinstr.

A x86_64 defconfig kernel with Clang 11 and CONFIG_VMLINUX_VALIDATION shows:

 | vmlinux.o: warning: objtool: do_syscall_64()+0x9d: call to memset() leaves .noinstr.text section
 | vmlinux.o: warning: objtool: do_int80_syscall_32()+0xab: call to memset() leaves .noinstr.text section
 | vmlinux.o: warning: objtool: __do_fast_syscall_32()+0xe2: call to memset() leaves .noinstr.text section
 | vmlinux.o: warning: objtool: fixup_bad_iret()+0x2f: call to memset() leaves .noinstr.text section

Clang 14 (unreleased) will introduce a way to skip alloca initialization
via __builtin_alloca_uninitialized() (https://reviews.llvm.org/D115440).

Constrain RANDOMIZE_KSTACK_OFFSET to only be enabled if no stack
auto-init is enabled, the compiler is GCC, or Clang is version 14+. Use
__builtin_alloca_uninitialized() if the compiler provides it, as is done
by Clang 14.

Link: https://lkml.kernel.org/r/YbHTKUjEejZCLyhX@elver.google.com
Fixes: 39218ff4c625 ("stack: Optionally randomize kernel stack offset each syscall")
Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
---
v2:
* Update comment to point out which compilers initialize allocas.
---
 arch/Kconfig                     |  1 +
 include/linux/randomize_kstack.h | 16 ++++++++++++++--
 2 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 2cde48d9b77c..c5b50bfe31c1 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1163,6 +1163,7 @@ config RANDOMIZE_KSTACK_OFFSET
 	bool "Support for randomizing kernel stack offset on syscall entry" if EXPERT
 	default y
 	depends on HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET
+	depends on INIT_STACK_NONE || !CC_IS_CLANG || CLANG_VERSION >= 140000
 	help
 	  The kernel stack offset can be randomized (after pt_regs) by
 	  roughly 5 bits of entropy, frustrating memory corruption
diff --git a/include/linux/randomize_kstack.h b/include/linux/randomize_kstack.h
index 91f1b990a3c3..1468caf001c0 100644
--- a/include/linux/randomize_kstack.h
+++ b/include/linux/randomize_kstack.h
@@ -17,8 +17,20 @@ DECLARE_PER_CPU(u32, kstack_offset);
  * alignment. Also, since this use is being explicitly masked to a max of
  * 10 bits, stack-clash style attacks are unlikely. For more details see
  * "VLAs" in Documentation/process/deprecated.rst
+ *
+ * The normal __builtin_alloca() is initialized with INIT_STACK_ALL (currently
+ * only with Clang and not GCC). Initializing the unused area on each syscall
+ * entry is expensive, and generating an implicit call to memset() may also be
+ * problematic (such as in noinstr functions). Therefore, if the compiler
+ * supports it (which it should if it initializes allocas), always use the
+ * "uninitialized" variant of the builtin.
  */
-void *__builtin_alloca(size_t size);
+#if __has_builtin(__builtin_alloca_uninitialized)
+#define __kstack_alloca __builtin_alloca_uninitialized
+#else
+#define __kstack_alloca __builtin_alloca
+#endif
+
 /*
  * Use, at most, 10 bits of entropy. We explicitly cap this to keep the
  * "VLA" from being unbounded (see above). 10 bits leaves enough room for
@@ -37,7 +49,7 @@ void *__builtin_alloca(size_t size);
 	if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT,	\
 				&randomize_kstack_offset)) {		\
 		u32 offset = raw_cpu_read(kstack_offset);		\
-		u8 *ptr = __builtin_alloca(KSTACK_OFFSET_MAX(offset));	\
+		u8 *ptr = __kstack_alloca(KSTACK_OFFSET_MAX(offset));	\
 		/* Keep allocation even after "ptr" loses scope. */	\
 		asm volatile("" :: "r"(ptr) : "memory");		\
 	}								\
-- 
2.35.0.rc2.247.g8bbb082509-goog

