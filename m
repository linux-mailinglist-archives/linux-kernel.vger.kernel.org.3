Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0164523AD2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345176AbiEKQue (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:50:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345038AbiEKQtr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:49:47 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5936395DE9;
        Wed, 11 May 2022 09:49:42 -0700 (PDT)
Received: from grover.jp (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 24BGlWc0031975;
        Thu, 12 May 2022 01:47:37 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 24BGlWc0031975
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652287658;
        bh=cga2j3/RnX95UXo6+4HyPv/WWKGxfQZ0xpYK4BVs9G8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GdvD1dXtHHjlc81z6WeX1zZzwaMcqZHFeFqOQLIbP0Gqz0Cn/Q9Q4yURc9g4PlXs4
         HimDPcY35Lre7OznD7JTvCHNbJGvJKQCwvxzy0Le8GkxqQaG7oeedg2GxCfwn57754
         SikCqgASO1nzN94iVAI2CZaGiaU78q2Xn8QTWyHM8DNOkHRDMi6bcHueuhuMu3gIUN
         31TtNTA1QAlZvf/8H7VE7dq4ymlUy0+Vwnwrw1m3F4WmjQSWvIOu7NMolHY5hrBtq2
         6N9o2Pwlgw4XwWlVedDtUCmx2AliUCsiCJ1vuVkVW7x+mWMiOL7OK+K9pCoIDunCiU
         mlzjMcBgavDGQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules@vger.kernel.org, llvm@lists.linux.dev,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v5 05/12] kbuild: stop merging *.symversions
Date:   Thu, 12 May 2022 01:45:07 +0900
Message-Id: <20220511164514.2741934-6-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220511164514.2741934-1-masahiroy@kernel.org>
References: <20220511164514.2741934-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now modpost reads symbol versions from .*.cmd files.

The merged *.symversions are no longer needed.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---

(no changes since v1)

 scripts/Makefile.build  | 21 ++-------------------
 scripts/link-vmlinux.sh | 19 -------------------
 2 files changed, 2 insertions(+), 38 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index ddd9080fc028..dff9220135c4 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -390,17 +390,6 @@ $(obj)/%.asn1.c $(obj)/%.asn1.h: $(src)/%.asn1 $(objtree)/scripts/asn1_compiler
 $(subdir-builtin): $(obj)/%/built-in.a: $(obj)/% ;
 $(subdir-modorder): $(obj)/%/modules.order: $(obj)/% ;
 
-# combine symversions for later processing
-ifeq ($(CONFIG_LTO_CLANG) $(CONFIG_MODVERSIONS),y y)
-      cmd_update_lto_symversions =					\
-	rm -f $@.symversions						\
-	$(foreach n, $(filter-out FORCE,$^),				\
-		$(if $(shell test -s $(n).symversions && echo y),	\
-			; cat $(n).symversions >> $@.symversions))
-else
-      cmd_update_lto_symversions = echo >/dev/null
-endif
-
 #
 # Rule to compile a set of .o files into one .a file (without symbol table)
 #
@@ -408,11 +397,8 @@ endif
 quiet_cmd_ar_builtin = AR      $@
       cmd_ar_builtin = rm -f $@; $(AR) cDPrST $@ $(real-prereqs)
 
-quiet_cmd_ar_and_symver = AR      $@
-      cmd_ar_and_symver = $(cmd_update_lto_symversions); $(cmd_ar_builtin)
-
 $(obj)/built-in.a: $(real-obj-y) FORCE
-	$(call if_changed,ar_and_symver)
+	$(call if_changed,ar_builtin)
 
 #
 # Rule to create modules.order file
@@ -432,16 +418,13 @@ $(obj)/modules.order: $(obj-m) FORCE
 #
 # Rule to compile a set of .o files into one .a file (with symbol table)
 #
-quiet_cmd_ar_lib = AR      $@
-      cmd_ar_lib = $(cmd_update_lto_symversions); $(cmd_ar)
 
 $(obj)/lib.a: $(lib-y) FORCE
-	$(call if_changed,ar_lib)
+	$(call if_changed,ar)
 
 ifneq ($(CONFIG_LTO_CLANG)$(CONFIG_X86_KERNEL_IBT),)
 quiet_cmd_link_multi-m = AR [M]  $@
 cmd_link_multi-m =						\
-	$(cmd_update_lto_symversions);				\
 	rm -f $@; 						\
 	$(AR) cDPrsT $@ @$(patsubst %.o,%.mod,$@)
 else
diff --git a/scripts/link-vmlinux.sh b/scripts/link-vmlinux.sh
index 7313cbd755df..47e5336d0c75 100755
--- a/scripts/link-vmlinux.sh
+++ b/scripts/link-vmlinux.sh
@@ -56,20 +56,6 @@ gen_initcalls()
 		> .tmp_initcalls.lds
 }
 
-# If CONFIG_LTO_CLANG is selected, collect generated symbol versions into
-# .tmp_symversions.lds
-gen_symversions()
-{
-	info GEN .tmp_symversions.lds
-	rm -f .tmp_symversions.lds
-
-	for o in ${KBUILD_VMLINUX_OBJS} ${KBUILD_VMLINUX_LIBS}; do
-		if [ -f ${o}.symversions ]; then
-			cat ${o}.symversions >> .tmp_symversions.lds
-		fi
-	done
-}
-
 # Link of vmlinux.o used for section mismatch analysis
 # ${1} output file
 modpost_link()
@@ -88,10 +74,6 @@ modpost_link()
 		gen_initcalls
 		lds="-T .tmp_initcalls.lds"
 
-		if is_enabled CONFIG_MODVERSIONS; then
-			gen_symversions
-		fi
-
 		# This might take a while, so indicate that we're doing
 		# an LTO link
 		info LTO ${1}
@@ -307,7 +289,6 @@ cleanup()
 	rm -f .btf.*
 	rm -f .tmp_System.map
 	rm -f .tmp_initcalls.lds
-	rm -f .tmp_symversions.lds
 	rm -f .tmp_vmlinux*
 	rm -f System.map
 	rm -f vmlinux
-- 
2.32.0

