Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97DDC4EA504
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 04:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230175AbiC2CSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 22:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiC2CRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 22:17:51 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 236693FBD3;
        Mon, 28 Mar 2022 19:16:09 -0700 (PDT)
Received: from grover.. (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 22T2FUb2001635;
        Tue, 29 Mar 2022 11:15:31 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 22T2FUb2001635
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1648520131;
        bh=g57u72lpAuIX196RYY1FCITKCQY30fd5oZXIlZxKaww=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l8hCku74HD3Zb+GqA+VGBhwEQgwhdlzh/IaKvsr0HdTfirwY7ntObhRNc/1lZzOU+
         JdSLWVAeF7wuUxHV3wMRYa4Vwx5N5TcrQmTzu0/bjoBsrq3rGJVfgHkvIb4bqavEh8
         AyeWeqJT04hsVS/kMWGLO8fsZ5Aw2COirfd3vJk5CPw52MeUWZtIugE3A/HHj3Mo3z
         WW34tmzABrCejEHRCgSxOhWV0RFNixiN2LIxeSYww2loew0E1rA5fAZwvGDJfkmf2H
         ZNAZ/AuqzETGAMWihcqpoUL1gTDXy7yEp++iU1DtYuvfxcrZY4Jo7CxfaO8IdFvD+W
         /tZ/1KmX5ggRg==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 2/2] kbuild: do not remove empty *.symtypes explicitly
Date:   Tue, 29 Mar 2022 11:15:20 +0900
Message-Id: <20220329021520.308997-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220329021520.308997-1-masahiroy@kernel.org>
References: <20220329021520.308997-1-masahiroy@kernel.org>
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

 scripts/Makefile.build | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/scripts/Makefile.build b/scripts/Makefile.build
index 3f2985df4d60..974bb6435826 100644
--- a/scripts/Makefile.build
+++ b/scripts/Makefile.build
@@ -135,9 +135,7 @@ genksyms = scripts/genksyms/genksyms		\
 cmd_gensymtypes_c = $(CPP) -D__GENKSYMS__ $(c_flags) $< | $(genksyms)
 
 quiet_cmd_cc_symtypes_c = SYM $(quiet_modtag) $@
-cmd_cc_symtypes_c =                                                         \
-    $(call cmd_gensymtypes_c,true,$@) >/dev/null;                           \
-    test -s $@ || rm -f $@
+      cmd_cc_symtypes_c = $(call cmd_gensymtypes_c,true,$@)
 
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

