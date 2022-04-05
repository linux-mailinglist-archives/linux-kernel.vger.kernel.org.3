Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37A14F4916
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:19:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390255AbiDEWDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444192AbiDEPlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:41:00 -0400
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A78575FCB;
        Tue,  5 Apr 2022 07:03:31 -0700 (PDT)
Received: from grover.. (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 235E2k8M021295;
        Tue, 5 Apr 2022 23:02:49 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 235E2k8M021295
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649167369;
        bh=yB8mBxh6zgfFkl1vR4ponG9HVyr7i/FNMeStWHFyu/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l2bI6SwM4DXiakwdb8B0EEcAferf7Hwfqdh2AWV7Vu42eBtMBZsdK07j/XqSwrIbu
         o/h4U5jifRvz3VrtDTKBHbqXO9asE+l1LlHn5b5vz5B8HeQLaJcRQWUhT0GPjyrwhl
         qoduk9NgUbcUzRypZzOpcbh0xn4FOo9UdwNj9jCYLAkJhLwOznXdFoxDVxlLKaN5qX
         NPOgULaYb/Ht3+n9/kfNKVdNTCpl2kpGdc5ENaiXaxi7610PZ0BKg/GRwLppzNv0EA
         CX6A6RmTkNKvhHVIlecsLuJtXkpsYd4lFrgbS8qW1gTOVyl4yp2o0nZrGgtJTG3aYG
         1Tn29v3k2xnww==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH v2 04/10] modpost: move export_from_secname() call to more relevant place
Date:   Tue,  5 Apr 2022 23:02:23 +0900
Message-Id: <20220405140229.2895394-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220405140229.2895394-1-masahiroy@kernel.org>
References: <20220405140229.2895394-1-masahiroy@kernel.org>
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

The assigned 'export' is only used when

    if (strstarts(symname, "__ksymtab_"))

is met. The else-part of the assignment is the dead code.

Move the export_from_secname() call to where it is used.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

(no changes since v1)

 scripts/mod/modpost.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index eebb32689816..f9e54247ae1d 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -684,14 +684,8 @@ static void handle_modversion(const struct module *mod,
 static void handle_symbol(struct module *mod, struct elf_info *info,
 			  const Elf_Sym *sym, const char *symname)
 {
-	enum export export;
 	const char *name;
 
-	if (strstarts(symname, "__ksymtab"))
-		export = export_from_secname(info, get_secindex(info, sym));
-	else
-		export = export_unknown;
-
 	switch (sym->st_shndx) {
 	case SHN_COMMON:
 		if (strstarts(symname, "__gnu_lto_")) {
@@ -726,7 +720,11 @@ static void handle_symbol(struct module *mod, struct elf_info *info,
 	default:
 		/* All exported symbols */
 		if (strstarts(symname, "__ksymtab_")) {
+			enum export export;
+
 			name = symname + strlen("__ksymtab_");
+			export = export_from_secname(info,
+						     get_secindex(info, sym));
 			sym_add_exported(name, mod, export);
 		}
 		if (strcmp(symname, "init_module") == 0)
-- 
2.32.0

