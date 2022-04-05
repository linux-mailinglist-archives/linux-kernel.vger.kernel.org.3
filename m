Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C2F84F46FE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 01:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384027AbiDEUzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384133AbiDEM1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 08:27:12 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F21C357B0E;
        Tue,  5 Apr 2022 04:35:19 -0700 (PDT)
Received: from grover.. (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 235BYCGq000464;
        Tue, 5 Apr 2022 20:34:15 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 235BYCGq000464
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649158455;
        bh=yB8mBxh6zgfFkl1vR4ponG9HVyr7i/FNMeStWHFyu/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h0WQLw9dcMALq734ybEzZQq76OeHfQxuob6gpI5eh80gF2Uz9pGzrXICIkcRUStAS
         K25/8dKR9NZGr0vc0fC/nS68dzZca6mYfVasGPxgZkQqkGfoIVyo5KtEbO3Ev4XUGt
         pFq5V07TpDITzwvO3b80w1jkFQI8gYbF9tdOTwftw3UvyiSrlJm8aNI3ipxfu8K0q0
         3WWKcRUZDPrbI8pUPhS7xx1tDmOz7k/xTldK1szWZab7Izbs7rlrPBmNc4wJRFtA34
         VakyuWNidnh86Yb+lmI3yVGw1ZxyowpWwNuSxjsskejHC6ySAp4SIK+toeONLl114D
         k9n4B7BiatM+Q==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH v2 04/10] modpost: move export_from_secname() call to more relevant place
Date:   Tue,  5 Apr 2022 20:33:52 +0900
Message-Id: <20220405113359.2880241-5-masahiroy@kernel.org>
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

