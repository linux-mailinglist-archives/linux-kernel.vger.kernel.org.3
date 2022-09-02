Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECED5AB31E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238725AbiIBOMS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:12:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235543AbiIBOLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:11:44 -0400
X-Greylist: delayed 276 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 02 Sep 2022 06:39:45 PDT
Received: from condef-04.nifty.com (condef-04.nifty.com [202.248.20.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CB029C;
        Fri,  2 Sep 2022 06:39:44 -0700 (PDT)
Received: from conuserg-08.nifty.com ([10.126.8.71])by condef-04.nifty.com with ESMTP id 282DBpdd029154;
        Fri, 2 Sep 2022 22:11:51 +0900
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 282D8u4t015655;
        Fri, 2 Sep 2022 22:09:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 282D8u4t015655
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662124194;
        bh=4dyKSCwv1RuBVxoRRl8+r1I2FIxdbUPQmkn7fQPLx+s=;
        h=From:To:Cc:Subject:Date:From;
        b=jRXxtqI6uli/WimRxJVT0qUGZnA5uL/TjKU9Gq9wky/bAhgJEKH9+sIXWQ4on2KwS
         F6guS2TljGxHa3N+gzoEJPB4R2AWygKYWHGczYdDjKTPfxIP3TWRQAcnBTzikwUYTy
         zx0bonPyUPr+DXduqe9zFYaFvDaZqBTAW1M2BeLbp7r97wKPkobq3T26Kvqt2Nezf9
         itGVvTtDixlORHSlwEG89BAqVT7ZGtAR5/LEv4rFqkD8Ww7FImNwdYyiePdfbKjazS
         FIWZJjSFUqyux9XGLm1oWis7DByEjhlaj48+RPhgiE3TDIeoQ8V6JaBab7gImsbJDG
         LW/6mFCRl/PDw==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] kbuild: use objtool-args-y to clean up objtool arguments
Date:   Fri,  2 Sep 2022 22:08:45 +0900
Message-Id: <20220902130846.654526-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Based on Linus' patch.

Link: https://lore.kernel.org/lkml/CAHk-=wgjTMQgiKzBZTmb=uWGDEQxDdyF1+qxBkODYciuNsmwnw@mail.gmail.com/
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/Makefile.lib       | 31 ++++++++++++++++---------------
 scripts/Makefile.vmlinux_o | 17 ++++++++---------
 2 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index b594705d571a..731f735240f8 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -229,25 +229,26 @@ ifdef CONFIG_OBJTOOL
 
 objtool := $(objtree)/tools/objtool/objtool
 
-objtool_args =								\
-	$(if $(CONFIG_HAVE_JUMP_LABEL_HACK), --hacks=jump_label)	\
-	$(if $(CONFIG_HAVE_NOINSTR_HACK), --hacks=noinstr)		\
-	$(if $(CONFIG_X86_KERNEL_IBT), --ibt)				\
-	$(if $(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL), --mcount)		\
-	$(if $(CONFIG_UNWINDER_ORC), --orc)				\
-	$(if $(CONFIG_RETPOLINE), --retpoline)				\
-	$(if $(CONFIG_RETHUNK), --rethunk)				\
-	$(if $(CONFIG_SLS), --sls)					\
-	$(if $(CONFIG_STACK_VALIDATION), --stackval)			\
-	$(if $(CONFIG_HAVE_STATIC_CALL_INLINE), --static-call)		\
-	$(if $(CONFIG_HAVE_UACCESS_VALIDATION), --uaccess)		\
+objtool-args-$(CONFIG_HAVE_JUMP_LABEL_HACK)		+= --hacks=jump_label
+objtool-args-$(CONFIG_HAVE_NOINSTR_HACK)		+= --hacks=noinstr
+objtool-args-$(CONFIG_X86_KERNEL_IBT)			+= --ibt
+objtool-args-$(CONFIG_FTRACE_MCOUNT_USE_OBJTOOL)	+= --mcount
+objtool-args-$(CONFIG_UNWINDER_ORC)			+= --orc
+objtool-args-$(CONFIG_RETPOLINE)			+= --retpoline
+objtool-args-$(CONFIG_RETHUNK)				+= --rethunk
+objtool-args-$(CONFIG_SLS)				+= --sls
+objtool-args-$(CONFIG_STACK_VALIDATION)			+= --stackval
+objtool-args-$(CONFIG_HAVE_STATIC_CALL_INLINE)		+= --static-call
+objtool-args-$(CONFIG_HAVE_UACCESS_VALIDATION)		+= --uaccess
+objtool-args-$(CONFIG_GCOV_KERNEL)			+= --no-unreachable
+
+objtool-args = $(objtool-args-y)					\
 	$(if $(delay-objtool), --link)					\
-	$(if $(part-of-module), --module)				\
-	$(if $(CONFIG_GCOV_KERNEL), --no-unreachable)
+	$(if $(part-of-module), --module)
 
 delay-objtool := $(or $(CONFIG_LTO_CLANG),$(CONFIG_X86_KERNEL_IBT))
 
-cmd_objtool = $(if $(objtool-enabled), ; $(objtool) $(objtool_args) $@)
+cmd_objtool = $(if $(objtool-enabled), ; $(objtool) $(objtool-args) $@)
 cmd_gen_objtooldep = $(if $(objtool-enabled), { echo ; echo '$@: $$(wildcard $(objtool))' ; } >> $(dot-target).cmd)
 
 endif # CONFIG_OBJTOOL
diff --git a/scripts/Makefile.vmlinux_o b/scripts/Makefile.vmlinux_o
index 81a4e0484457..df928a6717a1 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -35,18 +35,17 @@ endif
 
 objtool-enabled := $(or $(delay-objtool),$(CONFIG_NOINSTR_VALIDATION))
 
-# Reuse objtool_args defined in scripts/Makefile.lib if LTO or IBT is enabled.
+# Reuse objtool-args-y defined in scripts/Makefile.lib if LTO or IBT is enabled.
+# (Expand objtool-args-y to a simple variable to avoid circular reference)
 #
 # Add some more flags as needed.
-# --no-unreachable and --link might be added twice, but it is fine.
-#
-# Expand objtool_args to a simple variable to avoid circular reference.
+# --no-unreachable might be added twice, but it is fine.
+
+objtool-args-$(delay-objtool)			:= $(objtool-args-y)
+objtool-args-$(CONFIG_GCOV_KERNEL)		+= --no-unreachable
+objtool-args-$(CONFIG_NOINSTR_VALIDATION)	+= --noinstr $(if $(CONFIG_CPU_UNRET_ENTRY), --unret))
 
-objtool_args := \
-	$(if $(delay-objtool),$(objtool_args)) \
-	$(if $(CONFIG_NOINSTR_VALIDATION), --noinstr $(if $(CONFIG_CPU_UNRET_ENTRY), --unret)) \
-	$(if $(CONFIG_GCOV_KERNEL), --no-unreachable) \
-	--link
+objtool-args = $(objtool-args-y) --link
 
 # Link of vmlinux.o used for section mismatch analysis
 # ---------------------------------------------------------------------------
-- 
2.34.1

