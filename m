Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E48A4B1BA1
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 02:50:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244487AbiBKBts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 20:49:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230175AbiBKBtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 20:49:47 -0500
X-Greylist: delayed 384 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Feb 2022 17:49:46 PST
Received: from ozlabs.ru (ozlabs.ru [107.174.27.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9892310FF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 17:49:46 -0800 (PST)
Received: from fstn1-p1.ozlabs.ibm.com. (localhost [IPv6:::1])
        by ozlabs.ru (Postfix) with ESMTP id A561F804B3;
        Thu, 10 Feb 2022 20:43:17 -0500 (EST)
From:   Alexey Kardashevskiy <aik@ozlabs.ru>
To:     llvm@lists.linux.dev
Cc:     Alexey Kardashevskiy <aik@ozlabs.ru>, linux-kernel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [RFC PATCH kernel] trace: Make FTRACE_MCOUNT_USE_RECORDMCOUNT configurable
Date:   Fri, 11 Feb 2022 12:43:13 +1100
Message-Id: <20220211014313.1790140-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For whatever reason LLVM does not allow LTO (Link Time Optimization) if
FTRACE_MCOUNT_USE_RECORDMCOUNT is enabled.

This allows disabling just this option instead of disabling all FTRACE
options.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

Or disabling FTRACE is the right thing to do if HAS_LTO_CLANG=y?

Came from arch/Kconfig:

config HAS_LTO_CLANG
        def_bool y
        depends on CC_IS_CLANG && LD_IS_LLD && AS_IS_LLVM
        depends on $(success,$(NM) --help | head -n 1 | grep -qi llvm)
        depends on $(success,$(AR) --help | head -n 1 | grep -qi llvm)
        depends on ARCH_SUPPORTS_LTO_CLANG
        depends on !FTRACE_MCOUNT_USE_RECORDMCOUNT  <======
        depends on !KASAN || KASAN_HW_TAGS
        depends on !GCOV_KERNEL


---
 kernel/trace/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index a5eb5e7fd624..87d82d2b0b0b 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -704,7 +704,8 @@ config FTRACE_MCOUNT_USE_OBJTOOL
 	depends on FTRACE_MCOUNT_RECORD
 
 config FTRACE_MCOUNT_USE_RECORDMCOUNT
-	def_bool y
+	bool "Enable FTRACE_MCOUNT_USE_RECORDMCOUNT"
+	default y
 	depends on !FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
 	depends on !FTRACE_MCOUNT_USE_CC
 	depends on !FTRACE_MCOUNT_USE_OBJTOOL
-- 
2.30.2

