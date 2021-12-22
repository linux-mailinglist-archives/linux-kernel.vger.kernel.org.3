Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1421147CA92
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 01:53:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240269AbhLVAxO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 19:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbhLVAxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 19:53:13 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7DBC061574
        for <linux-kernel@vger.kernel.org>; Tue, 21 Dec 2021 16:53:12 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8822B81A1A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Dec 2021 00:53:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53259C36AE9;
        Wed, 22 Dec 2021 00:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640134390;
        bh=P5+2yc3KCKxVxhRcIuwHjO5vFJ9W3AScc9KUpeZDGDw=;
        h=From:To:Cc:Subject:Date:From;
        b=Sybfz6riq5b75n2hH5ZrRGrZjuzFYwr0uKNRXXm/V7pi8BSVAMTXrCGV8thBqstU1
         OEAZgOTmw4x/y/GB/xHjHwd7V/n5RsSGWTDm76mv/zlwFa4BSQdVOHLRXpcBdsgxtH
         aFEoLbTQyiPtnv80aoOJr+OEyETQyMWPqTFEqehFvNAjuLoWiYSO37KTAp2bKF8iwW
         rkIFfJb6KuVVyIdSUiB6kq/8+nz8FBhvsmwbC6z99EIdrTjofIoCckSza088zKQeDv
         Xsoam8+xfxRzhtcXifEA2ykhgMPL9nLSG99+RrPbjS9k7ueOldhZkCxPR/U26B8k+Z
         H8f8+dym+krPQ==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "H. Peter Anvin" <hpa@zytor.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH] x86/boot/compressed: Move CLANG_FLAGS to beginning of KBUILD_CFLAGS
Date:   Tue, 21 Dec 2021 17:52:45 -0700
Message-Id: <20211222005245.3081136-1-nathan@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
---
 arch/x86/boot/compressed/Makefile | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 431bf7f846c3..169186dba1d7 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -28,7 +28,7 @@ KCOV_INSTRUMENT		:= n
 targets := vmlinux vmlinux.bin vmlinux.bin.gz vmlinux.bin.bz2 vmlinux.bin.lzma \
 	vmlinux.bin.xz vmlinux.bin.lzo vmlinux.bin.lz4 vmlinux.bin.zst
 
-KBUILD_CFLAGS := -m$(BITS) -O2
+KBUILD_CFLAGS := -m$(BITS) -O2 $(CLANG_FLAGS)
 KBUILD_CFLAGS += -fno-strict-aliasing -fPIE
 KBUILD_CFLAGS += -Wundef
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
@@ -47,7 +47,6 @@ KBUILD_CFLAGS += -D__DISABLE_EXPORTS
 # Disable relocation relaxation in case the link is not PIE.
 KBUILD_CFLAGS += $(call as-option,-Wa$(comma)-mrelax-relocations=no)
 KBUILD_CFLAGS += -include $(srctree)/include/linux/hidden.h
-KBUILD_CFLAGS += $(CLANG_FLAGS)
 
 # sev.c indirectly inludes inat-table.h which is generated during
 # compilation and stored in $(objtree). Add the directory to the includes so

base-commit: 2f47a9a4dfa3674fad19a49b40c5103a9a8e1589
-- 
2.34.1

