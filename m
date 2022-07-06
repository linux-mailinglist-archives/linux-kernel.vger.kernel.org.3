Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B20DC56955A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 00:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbiGFWdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 18:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiGFWdJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 18:33:09 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08D9E14D17;
        Wed,  6 Jul 2022 15:33:07 -0700 (PDT)
Date:   Wed, 06 Jul 2022 22:33:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1657146785;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m1d6tssk1qKROgDUlojal0QK0+AWMxs+toYm3o4QLIE=;
        b=pXqCJ8F856WDnrMSzbfyIBP6n7vAKVRVAhbgv9wDsxDMYlQVSvq5QGDXKaX8H1b5BnVYBK
        gV2tPJu3/LQKKof4ZMxCdFWMNH1gOIn8bAi2n9D5zjhMFQLEcAdU0OEXO3Zdq9OcZynlab
        7rm0MELUH5ITOuyqfIDeJQjz0sgn6DAeMAn4QfAtViGoQb/+vO/T/1t1bIMc4La9XRISnK
        2k6qr+GOGfTzCL4sqGe1aQejUNsif4/xIay98CB4//toaZ4zme/IJ8NOte4Q4u9yG6IKMk
        78vXlGqyzrot9vygzj54CMpErQyd4+6Eg4dUMsszepaId5YEd6reyCOM0VdAzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1657146785;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m1d6tssk1qKROgDUlojal0QK0+AWMxs+toYm3o4QLIE=;
        b=L6GaqmRhSIkyvG2pXZFW8w3/5QxnlYw6VyPiSz0Wahm4rXXl5NVFdAMvuXZMBZ4lBH/jRp
        9OhaX1vhw+DFOlBQ==
From:   "tip-bot2 for Nathan Chancellor" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/Kconfig: Fix CONFIG_CC_HAS_SANE_STACKPROTECTOR
 when cross compiling with clang
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220617180845.2788442-1-nathan@kernel.org>
References: <20220617180845.2788442-1-nathan@kernel.org>
MIME-Version: 1.0
Message-ID: <165714678380.15455.941309204578354056.tip-bot2@tip-bot2>
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

Commit-ID:     b230402b0dbd6930a616a07641f0bbc30325881e
Gitweb:        https://git.kernel.org/tip/b230402b0dbd6930a616a07641f0bbc30325881e
Author:        Nathan Chancellor <nathan@kernel.org>
AuthorDate:    Fri, 17 Jun 2022 11:08:46 -07:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 06 Jul 2022 14:57:10 -07:00

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
Link: https://github.com/chimera-linux/cports/commit/0fb7e506d5f83fdf2104feb22cdac34934561226
Link: https://github.com/llvm/llvm-project/issues/48553
Link: https://lkml.kernel.org/r/20220617180845.2788442-1-nathan@kernel.org
---
 arch/x86/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index b0142e0..b7767ba 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -386,8 +386,8 @@ config PGTABLE_LEVELS
 
 config CC_HAS_SANE_STACKPROTECTOR
 	bool
-	default $(success,$(srctree)/scripts/gcc-x86_64-has-stack-protector.sh $(CC)) if 64BIT
-	default $(success,$(srctree)/scripts/gcc-x86_32-has-stack-protector.sh $(CC))
+	default $(success,$(srctree)/scripts/gcc-x86_64-has-stack-protector.sh $(CC) $(CLANG_FLAGS)) if 64BIT
+	default $(success,$(srctree)/scripts/gcc-x86_32-has-stack-protector.sh $(CC) $(CLANG_FLAGS))
 	help
 	   We have to make sure stack protector is unconditionally disabled if
 	   the compiler produces broken code or if it does not let us control
