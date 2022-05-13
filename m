Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFDB52613A
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 13:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242313AbiEMLnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 07:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379963AbiEMLmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 07:42:17 -0400
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1041453A50;
        Fri, 13 May 2022 04:42:13 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 24DBeEwc008349;
        Fri, 13 May 2022 20:40:17 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 24DBeEwc008349
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652442018;
        bh=cga2j3/RnX95UXo6+4HyPv/WWKGxfQZ0xpYK4BVs9G8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p5ftmnST03FxjYRjjdJDBeXs1RhWVX7sEj20o6h2lFkAVs15LD1gYUdS+kWEJMdL5
         MLb11fpAipT++S44EFXq3/PS6tTfaBrqtn75TgVO0yORnZoqj8I4topwBsyynYgYr2
         MkT68Pxjy0ae+j/tZcpYGZzPmFuB7yVd4ulEip6sX2Zm9V8OyvUtoe7/7rN1gBovqk
         sYlkruGLARitLMDo/zZwMuqKEUQfPksHfRv7c5VxaRH5iTO6CJUy+hxYw2VAPlDWZY
         TJQE0xnYgcTEsNQF+b8WM9Sr6xPJSG7QP1df1B1kifECu8jVFRo8s6fCEBE4PxdR2c
         aXWgWnQ/ledng==
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
Subject: [PATCH v6 03/10] kbuild: stop merging *.symversions
Date:   Fri, 13 May 2022 20:39:23 +0900
Message-Id: <20220513113930.10488-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220513113930.10488-1-masahiroy@kernel.org>
References: <20220513113930.10488-1-masahiroy@kernel.org>
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

