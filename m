Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D06D24F4EF4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343684AbiDEXpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384116AbiDEM1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 08:27:11 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB444574B2;
        Tue,  5 Apr 2022 04:35:17 -0700 (PDT)
Received: from grover.. (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 235BYCGw000464;
        Tue, 5 Apr 2022 20:34:19 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 235BYCGw000464
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649158459;
        bh=gVdAU8NgX5021NtvHRpFHdYK2UvqDo2vrSD9W1vtAMA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HMNX5DFw87nSaiwE1Oo5QFT6reR50jBMkjc3VpbZqaffBYJ707hRf11BYqrmfG7Si
         OEk8mucbkGCcabxfxTRYnhJtTam4qTUT0s+rlYH4AU6zu91BXOwblHaJB9nlWRMK3k
         PX/WMesC5umLhTDADPVcsa4/ZIv4Kj3w8rFt4xrVERsnrvYxY+BDQgLVMUyk6hzw6g
         lxKidVH1fL6pbLHsXTrO+a7YdLlT0lwmsw4LrDPb29fj6n+ifhxZPUky7uYD27diBB
         nnXV2AUwL6PUhndQZvDnRnOxKOX4jvZ9CTxiJDFL7xaFK1QuE4+e+NdZ8iGSvrtY1k
         rjviBygrWfAdg==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2 10/10] kbuild: refactor cmd_modversions_S
Date:   Tue,  5 Apr 2022 20:33:58 +0900
Message-Id: <20220405113359.2880241-11-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220405113359.2880241-1-masahiroy@kernel.org>
References: <20220405113359.2880241-1-masahiroy@kernel.org>
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

Split the code into two macros, cmd_gen_symversions_S for running
genksyms, and cmd_modversions for running $(LD) to update the object
with CRCs.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - new

 scripts/Makefile.build | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index ba2be555f942..58be0997c5dd 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -274,7 +274,8 @@ define rule_as_o_S
 	$(call cmd_and_fixdep,as_o_S)
 	$(call cmd,gen_ksymdeps)
 	$(call cmd,gen_objtooldep)
-	$(call cmd,modversions_S)
+	$(call cmd,gen_symversions_S)
+	$(call cmd,modversions)
 endef
 
 # Built-in and composite module parts
@@ -366,16 +367,8 @@ ifdef CONFIG_ASM_MODVERSIONS
 # versioning matches the C process described above, with difference that
 # we parse asm-prototypes.h C header to get function definitions.
 
-cmd_modversions_S =								\
-	if $(OBJDUMP) -h $@ | grep -q __ksymtab; then				\
-		$(call cmd_gensymtypes_S,$(KBUILD_SYMTYPES),$(@:.o=.symtypes))	\
-		    > $(@D)/.tmp_$(@F:.o=.ver);					\
-										\
-		$(LD) $(KBUILD_LDFLAGS) -r -o $(@D)/.tmp_$(@F) $@ 		\
-			-T $(@D)/.tmp_$(@F:.o=.ver);				\
-		mv -f $(@D)/.tmp_$(@F) $@;					\
-		rm -f $(@D)/.tmp_$(@F:.o=.ver);					\
-	fi
+cmd_gen_symversions_S = $(call gen_symversions,S)
+
 endif
 
 $(obj)/%.o: $(src)/%.S FORCE
-- 
2.32.0

