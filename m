Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD9F64F4680
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344840AbiDEUeC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:34:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384129AbiDEM1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 08:27:12 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F60574BE;
        Tue,  5 Apr 2022 04:35:18 -0700 (PDT)
Received: from grover.. (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 235BYCGo000464;
        Tue, 5 Apr 2022 20:34:14 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 235BYCGo000464
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649158454;
        bh=8ckilN9UB4blZbcYmDCNzJh4V9ShLvfJ5JTGztZasQY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bFVtcHGeE5Sc3eTAlXo6PVCIP1lQHMaFttQj3YsSu9T5CzBWdWQJEj0QpycKNUzYl
         46pD8XVdwiOiF3Y1DHkLOP+KBMu75pTvVBBzIz6rcHlIE/g+lvDF06y2o7zJEWgqQL
         G33sfKrOMLXJ8zXmee9CDbYX3RwuLoAGnml/s1RvJ6E9079yf9JV41GaS6JB3mfK7J
         sgY4590M0WGPIn5AtY6WLQZJYnsYL5YNOba1SgrtgABViXTPbOhe4k8qXb4mCczSdW
         iy1UMIAHz7NqL9DR1VG9skM9amXj4MHQ7H06IOlnbqL4z9tsMOIvU324KbQ2CCNdev
         XvOZYwYkBDfwg==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2 02/10] kbuild: do not remove empty *.symtypes explicitly
Date:   Tue,  5 Apr 2022 20:33:50 +0900
Message-Id: <20220405113359.2880241-3-masahiroy@kernel.org>
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

Presumably, 'test -s $@ || rm -f $@' intends to remove the output when
the genksyms command fails.

It is unneeded because .DELETE_ON_ERROR automatically removes the output
on failure.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - Fix accidental drop of '> /dev/null'

 scripts/Makefile.build | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 31e0e33dfe5d..3ef2373f0a57 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -135,9 +135,7 @@ genksyms = scripts/genksyms/genksyms		\
 cmd_gensymtypes_c = $(CPP) -D__GENKSYMS__ $(c_flags) $< | $(genksyms)
 
 quiet_cmd_cc_symtypes_c = SYM $(quiet_modtag) $@
-cmd_cc_symtypes_c =                                                         \
-    $(call cmd_gensymtypes_c,true,$@) >/dev/null;                           \
-    test -s $@ || rm -f $@
+      cmd_cc_symtypes_c = $(call cmd_gensymtypes_c,true,$@) >/dev/null
 
 $(obj)/%.symtypes : $(src)/%.c FORCE
 	$(call cmd,cc_symtypes_c)
@@ -348,9 +346,7 @@ cmd_gensymtypes_S =                                                         \
     $(CPP) -D__GENKSYMS__ $(c_flags) -xc - | $(genksyms)
 
 quiet_cmd_cc_symtypes_S = SYM $(quiet_modtag) $@
-cmd_cc_symtypes_S =                                                         \
-    $(call cmd_gensymtypes_S,true,$@) >/dev/null;                           \
-    test -s $@ || rm -f $@
+      cmd_cc_symtypes_S = $(call cmd_gensymtypes_S,true,$@) >/dev/null
 
 $(obj)/%.symtypes : $(src)/%.S FORCE
 	$(call cmd,cc_symtypes_S)
-- 
2.32.0

