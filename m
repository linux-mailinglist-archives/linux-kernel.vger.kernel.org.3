Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38F5851B8E2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 09:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344293AbiEEHa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 03:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343863AbiEEHaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 03:30:01 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C44922019E;
        Thu,  5 May 2022 00:26:22 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 2457Nenr019426;
        Thu, 5 May 2022 16:23:51 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2457Nenr019426
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651735431;
        bh=deMcQZf2rwvxgyQGD7in8mESLk5fxT6vorLWV4tne3Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LKb9i/3w3DMPwJnPsDAMOVrR3B4nWnHCP4Q+MopZawSX+Pqf9Z0IrBFntQK3VY0pp
         Q2Ox7zrUwfuy1014KZ3va76bqdF5NaW/cH7FMjqnHAb0fAix6gIQ4Ot2Pcw5iYqdCb
         QWYxu2YEB4XQWqVXbtClu24aO3PfD8QdAAXWAHHzhhcqctb8UCokNfXctDjqu+tzsj
         iJoZuodvftvxTF8yqaChLNLetQI2bd/q/GF1zkPponfWMO+efH0cQquLVaWe5yzpSk
         tKgueNamU2uL+ywETFYsFkY3I/S8OYCKuICOBbGhc9Iq2vOpogFWeLOisVRDWTHmGD
         OSl58DDKUjcgA==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Nicolas Schier a <nicolas@fjasle.eu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-um@lists.infradead.org,
        linux-s390@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v3 09/15] kbuild: stop merging *.symversions
Date:   Thu,  5 May 2022 16:22:38 +0900
Message-Id: <20220505072244.1155033-10-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220505072244.1155033-1-masahiroy@kernel.org>
References: <20220505072244.1155033-1-masahiroy@kernel.org>
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

These merged *.symversions are not used any more.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v1)

 scripts/Makefile.build  | 21 ++-------------------
 scripts/link-vmlinux.sh | 15 ---------------
 2 files changed, 2 insertions(+), 34 deletions(-)

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
index 2742b7dd089a..07333181938b 100755
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
@@ -299,7 +285,6 @@ cleanup()
 	rm -f .btf.*
 	rm -f .tmp_System.map
 	rm -f .tmp_initcalls.lds
-	rm -f .tmp_symversions.lds
 	rm -f .tmp_vmlinux*
 	rm -f System.map
 	rm -f vmlinux
-- 
2.32.0

