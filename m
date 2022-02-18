Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 876AB4BBE15
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238293AbiBRRPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:15:38 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238210AbiBRRPP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:15:15 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414874C7A8
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=8QxJLwdgnNMjqYRU8ifgTHykf6DSn1b+TSErOW7SiFU=; b=RuvPA1earPSVXIUoWKbLEdw8ud
        ap6Y5sWYTF/6ZYQvHGLuP6yhorsMNbIvc7oJTcJaCTR2ZT3JRRUf2d/Dp7BZkcSYMI9MSm/m33VXu
        C+bbyTLK+0S+0q28whUKlsBUz/uAtRmKqqwovTtjxUG5uUA5m2mdlE4dlDZqtKKW5Q+/J3CtafVcr
        iMdCvU/rl/zD6TNxHkBdnjYLSqzQYGk/CtHDpR4C8n7IhRd3RWTT/LsicTMqacryvG8ydwmh13Ox/
        Lqybyxwt+wt8iszeWaK6AX6n4N6IriXzfqqHnL2WgtGVB5NND+1/Rxs3gZ/8G14lOgzTOdwfpejLs
        o/QFsMxA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nL6qA-00AsBi-Iy; Fri, 18 Feb 2022 17:14:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D412330220B;
        Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5FC122B09A2B0; Fri, 18 Feb 2022 18:14:39 +0100 (CET)
Message-ID: <20220218171409.872776952@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 18 Feb 2022 17:49:24 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com
Subject: [PATCH 22/29] Kbuild: Prepare !CLANG whole module objtool
References: <20220218164902.008644515@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Massage the Kbuild stuff to allow running objtool on whole modules.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 Makefile               |    2 ++
 scripts/Makefile.build |   25 ++++++++++++++++---------
 scripts/Makefile.lib   |    2 +-
 3 files changed, 19 insertions(+), 10 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -907,6 +907,8 @@ ifdef CONFIG_LTO
 KBUILD_CFLAGS	+= -fno-lto $(CC_FLAGS_LTO)
 KBUILD_AFLAGS	+= -fno-lto
 export CC_FLAGS_LTO
+BUILD_LTO	:= y
+export BUILD_LTO
 endif
 
 ifdef CONFIG_CFI_CLANG
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -88,7 +88,7 @@ endif
 
 targets-for-modules := $(patsubst %.o, %.mod, $(filter %.o, $(obj-m)))
 
-ifdef CONFIG_LTO_CLANG
+ifdef BUILD_LTO
 targets-for-modules += $(patsubst %.o, %.lto.o, $(filter %.o, $(obj-m)))
 endif
 
@@ -230,6 +230,7 @@ objtool := $(objtree)/tools/objtool/objt
 objtool_args =								\
 	$(if $(CONFIG_UNWINDER_ORC),orc generate,check)			\
 	$(if $(part-of-module), --module)				\
+	$(if $(BUILD_LTO), --lto)					\
 	$(if $(CONFIG_FRAME_POINTER),, --no-fp)				\
 	$(if $(CONFIG_GCOV_KERNEL)$(CONFIG_LTO_CLANG), --no-unreachable)\
 	$(if $(CONFIG_RETPOLINE), --retpoline)				\
@@ -242,11 +243,16 @@ cmd_gen_objtooldep = $(if $(objtool-enab
 
 endif # CONFIG_STACK_VALIDATION
 
-ifdef CONFIG_LTO_CLANG
+ifdef BUILD_LTO
 
 # Skip objtool for LLVM bitcode
 $(obj)/%.o: objtool-enabled :=
 
+# objtool was skipped for LLVM bitcode, run it now that we have compiled
+# modules into native code
+$(obj)/%.lto.o: objtool-enabled = y
+$(obj)/%.lto.o: part-of-module := y
+
 else
 
 # 'OBJECT_FILES_NON_STANDARD := y': skip objtool checking for a directory
@@ -292,21 +298,22 @@ ifdef CONFIG_LTO_CLANG
 # Module .o files may contain LLVM bitcode, compile them into native code
 # before ELF processing
 quiet_cmd_cc_lto_link_modules = LTO [M] $@
-cmd_cc_lto_link_modules =						\
+      cmd_cc_lto_link_modules =						\
 	$(LD) $(ld_flags) -r -o $@					\
 		$(shell [ -s $(@:.lto.o=.o.symversions) ] &&		\
 			echo -T $(@:.lto.o=.o.symversions))		\
 		--whole-archive $(filter-out FORCE,$^)			\
 		$(cmd_objtool)
-
-# objtool was skipped for LLVM bitcode, run it now that we have compiled
-# modules into native code
-$(obj)/%.lto.o: objtool-enabled = y
-$(obj)/%.lto.o: part-of-module := y
+else
+quiet_cmd_cc_lto_link_modules = LD [M] $@
+      cmd_cc_lto_link_modules =						\
+	$(LD) $(ld_flags) -r -o $@					\
+		$(filter-out FORCE,$^)					\
+		$(cmd_objtool)
+endif
 
 $(obj)/%.lto.o: $(obj)/%.o FORCE
 	$(call if_changed,cc_lto_link_modules)
-endif
 
 cmd_mod = { \
 	echo $(if $($*-objs)$($*-y)$($*-m), $(addprefix $(obj)/, $($*-objs) $($*-y) $($*-m)), $(@:.mod=.o)); \
--- a/scripts/Makefile.lib
+++ b/scripts/Makefile.lib
@@ -230,7 +230,7 @@ dtc_cpp_flags  = -Wp,-MMD,$(depfile).pre
 		 $(addprefix -I,$(DTC_INCLUDE))                          \
 		 -undef -D__DTS__
 
-ifeq ($(CONFIG_LTO_CLANG),y)
+ifdef BUILD_LTO
 # With CONFIG_LTO_CLANG, .o files in modules might be LLVM bitcode, so we
 # need to run LTO to compile them into native code (.lto.o) before further
 # processing.


