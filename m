Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F115AF3EF
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 20:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiIFSvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 14:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiIFSu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 14:50:57 -0400
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED337B2B6;
        Tue,  6 Sep 2022 11:50:56 -0700 (PDT)
Received: from zoe.. (133-32-182-133.west.xps.vectant.ne.jp [133.32.182.133]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 286InaOb018748;
        Wed, 7 Sep 2022 03:49:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 286InaOb018748
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1662490177;
        bh=4f8pc2B57gs1haEvHPNa1HDXqw3G4PfAJtWsxZ08q9U=;
        h=From:To:Cc:Subject:Date:From;
        b=ojyREgNNjekrT2nbGqtetz/G/lBGdIIKbobVodj6dIp8wZnJq1MCvs++Nt1jHlh8c
         PUq5KOozPLmKlugpyGADeX44hVZEh4MfDh2ezxWIVbX7xavAEhCU2Ujd4F0yL0apQt
         9MRveCllzcOy61UphTNBHBw2M59edqe4DzlIeAE4Hj5z5dML1RlXaVMMLC1MQ73NYU
         aa/ssrijvejeKCP0sbMseMZraT7+xXLF6qE1K8ZEp9WHBc2LbNNrBjSQCFR7MJ9GKU
         gom9Q7pIezN3qEHfo19OKtFNMkI0yfUwX7Qv93ZuU5df/2jGQapKjGjLCraQr2xVtj
         igqQI3HeS0J/A==
X-Nifty-SrcIP: [133.32.182.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2] kbuild: use objtool-args-y to clean up objtool arguments
Date:   Wed,  7 Sep 2022 03:49:35 +0900
Message-Id: <20220906184935.1157228-1-masahiroy@kernel.org>
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

Based on Linus' patch. Refactor scripts/Makefile.vmlinux_o as well.

Link: https://lore.kernel.org/lkml/CAHk-=wgjTMQgiKzBZTmb=uWGDEQxDdyF1+qxBkODYciuNsmwnw@mail.gmail.com/
Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - bug fix

 scripts/Makefile.lib       | 31 ++++++++++++++++---------------
 scripts/Makefile.vmlinux_o | 15 ++++-----------
 2 files changed, 20 insertions(+), 26 deletions(-)

diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
index 9bdc9ed37f49..3392721e1355 100644
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -231,25 +231,26 @@ ifdef CONFIG_OBJTOOL
 
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
index 81a4e0484457..68c22879bade 100644
--- a/scripts/Makefile.vmlinux_o
+++ b/scripts/Makefile.vmlinux_o
@@ -35,18 +35,11 @@ endif
 
 objtool-enabled := $(or $(delay-objtool),$(CONFIG_NOINSTR_VALIDATION))
 
-# Reuse objtool_args defined in scripts/Makefile.lib if LTO or IBT is enabled.
-#
-# Add some more flags as needed.
-# --no-unreachable and --link might be added twice, but it is fine.
-#
-# Expand objtool_args to a simple variable to avoid circular reference.
+vmlinux-objtool-args-$(delay-objtool)			+= $(objtool-args-y)
+vmlinux-objtool-args-$(CONFIG_GCOV_KERNEL)		+= --no-unreachable
+vmlinux-objtool-args-$(CONFIG_NOINSTR_VALIDATION)	+= --noinstr $(if $(CONFIG_CPU_UNRET_ENTRY), --unret)
 
-objtool_args := \
-	$(if $(delay-objtool),$(objtool_args)) \
-	$(if $(CONFIG_NOINSTR_VALIDATION), --noinstr $(if $(CONFIG_CPU_UNRET_ENTRY), --unret)) \
-	$(if $(CONFIG_GCOV_KERNEL), --no-unreachable) \
-	--link
+objtool-args = $(vmlinux-objtool-args-y) --link
 
 # Link of vmlinux.o used for section mismatch analysis
 # ---------------------------------------------------------------------------
-- 
2.34.1

