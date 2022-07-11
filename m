Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B12CA56D522
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 09:04:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbiGKHEr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 03:04:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229780AbiGKHEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 03:04:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71067193E8;
        Mon, 11 Jul 2022 00:04:44 -0700 (PDT)
Date:   Mon, 11 Jul 2022 07:04:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657523082;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0dXxQxmSgJHcnsSzeFOMN8CG5WezYSlV6nFcX72pWuo=;
        b=Zh7CceDtfCzwhnXmBJv/KQXc/hpfCCPb7CE/nVKG504cNkTaF0QTZBeYH7GZ4Btqf4lybG
        tf9XXkZw08Xtyk9YUHjmVT6mF/WQQWhhY3XeSbB8ry9DGKUN2kWFAk5jI3Ciwy+obSTf0h
        tNcNYfT3Fg9goc4/oNEK34ne5GKUpJvgkzuuM0JHV6OOR7c8NzxRfxMFHs3n0pbwQWeQCR
        G2cvNRD6FxR5cACi0PBf+diVmUnLNknvfu8ctLTpgHmzsW53XReWHRXTemZwe97S2qE1jH
        CR/qpD32RH4lyTWWz3dcs/CkMFmqaH7XwksV2x2adBHoX1n0vNoK9xKa9XEiBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657523082;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0dXxQxmSgJHcnsSzeFOMN8CG5WezYSlV6nFcX72pWuo=;
        b=zqr2sCe+hA+wQE4/oLiNvlEdqX6FfxJ2jQb8vvvZaDyILzfUwk9Lqo52X3/ai5kfQnZjU/
        w5o7G04sc57enUBw==
From:   "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/Kconfig: Fix CONFIG_CC_HAS_SANE_STACKPROTECTOR
 when cross compiling with clang
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220617180845.2788442-1-nathan@kernel.org>
References: <20220617180845.2788442-1-nathan@kernel.org>
MIME-Version: 1.0
Message-ID: <165752308158.15455.15646323656197275070.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     1b8667812b3a1304f3db736ac4905d6ad77d721e
Gitweb:        https://git.kernel.org/tip/1b8667812b3a1304f3db736ac4905d6ad77d721e
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Fri, 17 Jun 2022 11:08:46 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 11 Jul 2022 08:49:39 +02:00

x86/Kconfig: Fix CONFIG_CC_HAS_SANE_STACKPROTECTOR when cross compiling with clang

Chimera Linux notes that CONFIG_CC_HAS_SANE_STACKPROTECTOR cannot be
enabled when cross compiling an x86_64 kernel with clang, even though it
does work when natively compiling.

When building on aarch64:

  $ make -sj"$(nproc)" ARCH=x86_64 LLVM=1 defconfig

  $ grep STACKPROTECTOR .config

When building on x86_64:

  $ make -sj"$(nproc)" ARCH=x86_64 LLVM=1 defconfig

  $ grep STACKPROTECTOR .config
  CONFIG_CC_HAS_SANE_STACKPROTECTOR=y
  CONFIG_HAVE_STACKPROTECTOR=y
  CONFIG_STACKPROTECTOR=y
  CONFIG_STACKPROTECTOR_STRONG=y

When clang is invoked without a '--target' flag, code is generated for
the default target, which is usually the host (it is configurable via
cmake). As a result, the has-stack-protector scripts will generate code
for the default target but check for x86 specific segment registers,
which cannot succeed if the default target is not x86.

$(CLANG_FLAGS) contains an explicit '--target' flag so pass that
variable along to the has-stack-protector scripts so that the stack
protector can be enabled when cross compiling with clang. The 32-bit
stack protector cannot currently be enabled with clang, as it does not
support '-mstack-protector-guard-symbol', so this results in no
functional change for ARCH=i386 when cross compiling.

Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://github.com/chimera-linux/cports/commit/0fb7e506d5f83fdf2104feb22cdac34934561226
Link: https://github.com/llvm/llvm-project/issues/48553
Link: https://lkml.kernel.org/r/20220617180845.2788442-1-nathan@kernel.org
---
 arch/x86/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index be0b95e..076adde 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -391,8 +391,8 @@ config PGTABLE_LEVELS
 
 config CC_HAS_SANE_STACKPROTECTOR
 	bool
-	default $(success,$(srctree)/scripts/gcc-x86_64-has-stack-protector.sh $(CC)) if 64BIT
-	default $(success,$(srctree)/scripts/gcc-x86_32-has-stack-protector.sh $(CC))
+	default $(success,$(srctree)/scripts/gcc-x86_64-has-stack-protector.sh $(CC) $(CLANG_FLAGS)) if 64BIT
+	default $(success,$(srctree)/scripts/gcc-x86_32-has-stack-protector.sh $(CC) $(CLANG_FLAGS))
 	help
 	  We have to make sure stack protector is unconditionally disabled if
 	  the compiler produces broken code or if it does not let us control
