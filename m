Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA554F839C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 17:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344723AbiDGPgg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 11:36:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbiDGPgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 11:36:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3F781011;
        Thu,  7 Apr 2022 08:34:20 -0700 (PDT)
Date:   Thu, 07 Apr 2022 15:34:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649345656;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d4NuBDNGqUwoS57MQGXuWKDq8DHCGD33bEpIIZe/pWM=;
        b=dUUYxi3+LvHqHZtheNlklbBm7HfPX9GQLhn3IxzNdA0n0mkzUtVJHO86xzGzCX+bwXXYyq
        ivU5RWtB1qP1PS1C/cEUryIbyrQatX2mQ1xQBogZjbxH92LUZdNi0yiByKi3Oim1mdK0NX
        mOHioAk2KD4uIk5uToR4QbJMDaggHpYD8tjq9ljrz1t61yc9Pa5epXQO+rJGzOmbz1eB3f
        7z1abh3A3iuIE6Xt5DweJfC0el/Ggi0AJ4ecMrjf7O1L5+uSD4IeYFkyGyPQRAp5ri+Ycw
        gW5MTmMIwB1l0KiqPAHYe4U9j2QmNS+J8v0Av/HIXRWpwHZ12Sa5+u3Aq8om9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649345656;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d4NuBDNGqUwoS57MQGXuWKDq8DHCGD33bEpIIZe/pWM=;
        b=EUjxVEqduqlfaMoOXW+3VWo90j3W4+Q1+pXDXKFsn78CwSbnZdnt9H5GRyu+Z3fJbhLS/Y
        tnrTKJfylHQdGRCA==
From:   "tip-bot2 for Nick Desaulniers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/build: Don't build CONFIG_X86_32 as -ffreestanding
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Borislav Petkov <bp@suse.de>,
        Fangrui Song <maskray@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200817220212.338670-5-ndesaulniers@google.com>
References: <20200817220212.338670-5-ndesaulniers@google.com>
MIME-Version: 1.0
Message-ID: <164934565464.389.2546833245037255032.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     9b2687f29bc1a050ffd63b425129aa9db987e4f3
Gitweb:        https://git.kernel.org/tip/9b2687f29bc1a050ffd63b425129aa9db987e4f3
Author:        Nick Desaulniers <ndesaulniers@google.com>
AuthorDate:    Thu, 03 Feb 2022 12:40:25 -08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 07 Apr 2022 11:55:42 +02:00

x86/build: Don't build CONFIG_X86_32 as -ffreestanding

-ffreestanding typically inhibits "libcall optimizations" where calls to
certain library functions can be replaced by the compiler in certain
cases to calls to other library functions that may be more efficient.
This can be problematic for embedded targets that don't provide full
libc implementations.

-ffreestanding inhibits all such optimizations, which is the safe
choice, but generally we want the optimizations that are performed. The
Linux kernel does implement a fair amount of libc routines. Instead of
-ffreestanding (which makes more sense in smaller images like kexec's
purgatory image), prefer -fno-builtin-* flags to disable the compiler
from emitting calls to functions which may not be defined.

If you see a linkage failure due to a missing symbol that's typically
defined in a libc, and not explicitly called from the source code, then
the compiler may have done such a transform. You can either implement
such a function (i.e. in lib/string.c) or disable the transform outright
via -fno-builtin-* flag (where * is the name of the library routine,
i.e. -fno-builtin-bcmp).

i386_defconfig build+boot tested with GCC and Clang. Removes a pretty
old TODO from the code base.

[kees: These libcall optimizations are specifically needed to allow Clang
to correctly optimize the string functions under CONFIG_FORTIFY_SOURCE.]

Fixes: 6edfba1b33c7 ("[PATCH] x86_64: Don't define string functions to builtin")
Suggested-by: Arvind Sankar <nivedita@alum.mit.edu>
Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Fangrui Song <maskray@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20200817220212.338670-5-ndesaulniers@google.com
Link: https://lore.kernel.org/r/20220203204025.1153397-1-keescook@chromium.org
---
 arch/x86/Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index 1abd7cc..670fe40 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -100,9 +100,6 @@ ifeq ($(CONFIG_X86_32),y)
         include $(srctree)/arch/x86/Makefile_32.cpu
         KBUILD_CFLAGS += $(cflags-y)
 
-        # temporary until string.h is fixed
-        KBUILD_CFLAGS += -ffreestanding
-
 	ifeq ($(CONFIG_STACKPROTECTOR),y)
 		ifeq ($(CONFIG_SMP),y)
 			KBUILD_CFLAGS += -mstack-protector-guard-reg=fs -mstack-protector-guard-symbol=__stack_chk_guard
