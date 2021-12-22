Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9103547D85E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 21:45:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbhLVUpV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 15:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbhLVUpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 15:45:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0D6C061574;
        Wed, 22 Dec 2021 12:45:19 -0800 (PST)
Date:   Wed, 22 Dec 2021 20:45:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1640205916;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W4II0sqBpYZULLv29dW6QN4kvxHDOlKgqpJrrzTvrtM=;
        b=IIaRyQMg8UUQGWy2N+1nt9VNHRbLW73X0cYeNM+a2FzcNfg8lncDFycPWhCK+yM/dpjP/r
        mQ9TI6QrI1sXEFPlAJCdCjwgaWSyi3Hd4/Uo7oTcmQugZ4xx9WiPzyflQPD3CIwGoiKbF+
        HOO8BkQuU/1RMt8W2fD/Q7c7JgJwl806ZYFXw1Iylu0GWBMSEhOeb3DgEWMf8SkJ0dEOAB
        QQvvxibmM/RgSXI7oyuQlxGICMFWJkYCJ3Li6CZSKfUaw9v6btzyr2Mujjglv7CRO608iy
        wMP9RpeVNPpJADgIj+6UOn+1I/muPqgmmtPKpaCJSl7OPuRWDP0kqVTDZ8AQUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1640205916;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=W4II0sqBpYZULLv29dW6QN4kvxHDOlKgqpJrrzTvrtM=;
        b=auA2TVqVkRnrw80f38gZ021A9+A17EHxat0eHYlDfVTTxeay0R6bxbY8Q/kwAZNT+Sl+wD
        s09rpUs3VnT2f0DA==
From:   "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/boot/compressed: Move CLANG_FLAGS to beginning
 of KBUILD_CFLAGS
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211222163040.1961481-1-nathan@kernel.org>
References: <20211222163040.1961481-1-nathan@kernel.org>
MIME-Version: 1.0
Message-ID: <164020591546.16921.3525899379668390932.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     9c42a8706f358ef6699f299916ad31acf2767c45
Gitweb:        https://git.kernel.org/tip/9c42a8706f358ef6699f299916ad31acf2767c45
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Wed, 22 Dec 2021 09:30:41 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 22 Dec 2021 19:39:55 +01:00

x86/boot/compressed: Move CLANG_FLAGS to beginning of KBUILD_CFLAGS

When cross compiling i386_defconfig on an arm64 host with clang, there
are a few instances of '-Waddress-of-packed-member' and
'-Wgnu-variable-sized-type-not-at-end' in arch/x86/boot/compressed/,
which should both be disabled with the cc-disable-warning calls in that
directory's Makefile, which indicates that cc-disable-warning is failing
at the point of testing these flags.

The cc-disable-warning calls fail because at the point that the flags
are tested, KBUILD_CFLAGS has '-march=i386' without $(CLANG_FLAGS),
which has the '--target=' flag to tell clang what architecture it is
targeting. Without the '--target=' flag, the host architecture (arm64)
is used and i386 is not a valid value for '-march=' in that case. This
error can be seen by adding some logging to try-run:

  clang-14: error: the clang compiler does not support '-march=i386'

Invoking the compiler has to succeed prior to calling cc-option or
cc-disable-warning in order to accurately test whether or not the flag
is supported; if it doesn't, the requested flag can never be added to
the compiler flags. Move $(CLANG_FLAGS) to the beginning of KBUILD_FLAGS
so that any new flags that might be added in the future can be
accurately tested.

Fixes: d5cbd80e302d ("x86/boot: Add $(CLANG_FLAGS) to compressed KBUILD_CFLAGS")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20211222163040.1961481-1-nathan@kernel.org
---
 arch/x86/boot/compressed/Makefile | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 431bf7f..e118136 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -28,7 +28,11 @@ KCOV_INSTRUMENT		:= n
 targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
 	vmlinux.bin.xz vmlinux.bin.lzo vmlinux.bin.lz4 vmlinux.bin.zst
 
-KBUILD_CFLAGS := -m$(BITS) -O2
+# CLANG_FLAGS must come before any cc-disable-warning or cc-option calls in
+# case of cross compiling, as it has the '--target=' flag, which is needed to
+# avoid errors with '-march=i386', and future flags may depend on the target to
+# be valid.
+KBUILD_CFLAGS := -m$(BITS) -O2 $(CLANG_FLAGS)
 KBUILD_CFLAGS += -fno-strict-aliasing -fPIE
 KBUILD_CFLAGS += -Wundef
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
@@ -47,7 +51,6 @@ KBUILD_CFLAGS += -D__DISABLE_EXPORTS
 # Disable relocation relaxation in case the link is not PIE.
 KBUILD_CFLAGS += $(call as-option,-Wa$(comma)-mrelax-relocations=no)
 KBUILD_CFLAGS += -include $(srctree)/include/linux/hidden.h
-KBUILD_CFLAGS += $(CLANG_FLAGS)
 
 # sev.c indirectly inludes inat-table.h which is generated during
 # compilation and stored in $(objtree). Add the directory to the includes so
