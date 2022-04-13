Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 772D54FFDA2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 20:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237634AbiDMSTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 14:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235896AbiDMSTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 14:19:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6767B46157
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 11:16:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2600EB82273
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 18:16:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58370C385A3;
        Wed, 13 Apr 2022 18:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649873805;
        bh=2PyU5+wH+1ioE4szb8MizzXuB+wDw+SvOadxmPcv3gw=;
        h=From:To:Cc:Subject:Date:From;
        b=XCfqrjUnlFQ2/Z3Dw1r25L1UJS/3jKHbfIkuMvjc9WxH/ngfCXMYbuA/iO/ouh3U5
         T0+221xA/m/n8vXhJf2Lh61SA8h8xH+zK3PLMhlyEc75mE89ClhUfyWnVgB7DAlEgS
         EjuQVXJRyn6Qy37OTeW3T7cDyAaiZRumMrceQ65TqzmyXtcsZRsTxcEALQ32CSc/l0
         qX23IuS3yLMZvE3hqqxyTSWYDfjMFHRW5+espAK701WLu8BBnbqAEwETFVJge/uBWo
         DLZQiVQ/CJqrlTXoYgEvXGSaGe2HcSuwQYxVA6faSDWqO7ga2aAT8AfPqjxpdfO54P
         q2qFDZ7W9LTHw==
From:   Nathan Chancellor <nathan@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>,
        Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] arm64: Improve HAVE_DYNAMIC_FTRACE_WITH_REGS selection for clang
Date:   Wed, 13 Apr 2022 11:14:21 -0700
Message-Id: <20220413181420.3522187-1-nathan@kernel.org>
X-Mailer: git-send-email 2.35.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Will and Anders reported that using just 'CC=clang' with CONFIG_FTRACE=y
and CONFIG_STACK_TRACER=y would result in an error while linking:

  aarch64-linux-gnu-ld: .init.data has both ordered [`__patchable_function_entries' in init/main.o] and unordered [`.meminit.data' in mm/sparse.o] sections
  aarch64-linux-gnu-ld: final link failed: bad value

This error was exposed by commit f12b034afeb3 ("scripts/Makefile.clang:
default to LLVM_IAS=1") in combination with binutils older than 2.36.

When '-fpatchable-function-entry' was implemented in LLVM, two code
paths were added for adding the section attributes, one for the
integrated assembler and another for GNU as, due to binutils
deficiencies at the time. If the integrated assembler was used,
attributes that GNU ld < 2.36 could not handle were added, presumably
with the assumption that use of the integrated assembler meant the whole
LLVM stack was being used, namely ld.lld.

Prior to the kernel change previously mentioned, that assumption was
valid, as there were three commonly used combinations of tools for
compiling, assembling, and linking respectively:

$ make CC=clang (clang, GNU as, GNU ld)
$ make LLVM=1 (clang, GNU as, ld.lld)
$ make LLVM=1 LLVM_IAS=1 (clang, integrated assembler, ld.lld)

After the default switch of the integrated assembler, the second and
third commands become equivalent and the first command means "clang,
integrated assembler, and GNU ld", which was not a combination that was
considered when the aforementioned LLVM change was implemented.

It is not possible to go back and fix LLVM, as this change was
implemented in the 10.x series, which is no longer supported. To
workaround this on the kernel side, split out the selection of
HAVE_DYNAMIC_FTRACE_WITH_REGS to two separate configurations, one for
GCC and one for clang.

The GCC config inherits the '-fpatchable-function-entry' check. The
Clang config does not it, as '-fpatchable-function-entry' is always
available for LLVM 11.0.0 and newer, which is the supported range of
versions for the kernel.

The Clang config makes sure that the user is using GNU as or the
integrated assembler with ld.lld or GNU ld 2.36 or newer, which will
avoid the error above.

Link: https://github.com/ClangBuiltLinux/linux/issues/1507
Link: https://github.com/ClangBuiltLinux/linux/issues/788
Link: https://lore.kernel.org/YlCA5PoIjF6nhwYj@dev-arch.thelio-3990X/
Link: https://sourceware.org/bugzilla/show_bug.cgi?id=26256
Link: https://github.com/llvm/llvm-project/commit/7fa5290d5bd5632d7a36a4ea9f46e81e04fb819e
Link: https://github.com/llvm/llvm-project/commit/853a2649160c1c80b9bbd38a20b53ca8fab704e8
Reported-by: Anders Roxell <anders.roxell@linaro.org>
Reported-by: Will Deacon <will@kernel.org>
Tested-by: Will Deacon <will@kernel.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---

If there is a better place to put these symbols, please let me know!

No fixes tag, as commit f12b034afeb3 ("scripts/Makefile.clang: default
to LLVM_IAS=1") made this easier to hit but this has always been a
problem that could be hit ('make CC=clang LLVM_IAS=1').

 arch/arm64/Kconfig | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 57c4c995965f..1fd16faa7f31 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -175,8 +175,6 @@ config ARM64
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DMA_CONTIGUOUS
 	select HAVE_DYNAMIC_FTRACE
-	select HAVE_DYNAMIC_FTRACE_WITH_REGS \
-		if $(cc-option,-fpatchable-function-entry=2)
 	select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY \
 		if DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
@@ -228,6 +226,17 @@ config ARM64
 	help
 	  ARM 64-bit (AArch64) Linux support.
 
+config CLANG_SUPPORTS_DYNAMIC_FTRACE_WITH_REGS
+	def_bool CC_IS_CLANG
+	# https://github.com/ClangBuiltLinux/linux/issues/1507
+	depends on AS_IS_GNU || (AS_IS_LLVM && (LD_IS_LLD || LD_VERSION >= 23600))
+	select HAVE_DYNAMIC_FTRACE_WITH_REGS
+
+config GCC_SUPPORTS_DYNAMIC_FTRACE_WITH_REGS
+	def_bool CC_IS_GCC
+	depends on $(cc-option,-fpatchable-function-entry=2)
+	select HAVE_DYNAMIC_FTRACE_WITH_REGS
+
 config 64BIT
 	def_bool y
 

base-commit: ce522ba9ef7e2d9fb22a39eb3371c0c64e2a433e
-- 
2.35.2

