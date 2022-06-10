Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EF2546C75
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 20:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350188AbiFJSf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 14:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350035AbiFJSet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:34:49 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178373A5F6;
        Fri, 10 Jun 2022 11:34:38 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 25AIX5TR020882;
        Sat, 11 Jun 2022 03:33:11 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 25AIX5TR020882
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654885992;
        bh=vdyCFoDb1ktlDMZ2of2KXWKno1vYYdppHQg9jC75LS4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RtKFZesTY2BntPapYcA7z3ne5NUz2dyrQ9mUBt83jiBraUQDCYGyQF84rID/7AkEV
         9XicUZ8jbgdXXXY0R+zSI2R1oDBv6SNdRAfrH18SflVQESgMpYfmeOJ36qHFzpO+sb
         k2P/d3yB8T42swzLopLjX5bH/ElEWBPAQpL6s3Z4X4cLo6HSd1j4z8oC3Ed2opBhTS
         e8ru/LMQaiY20MKlKXNYo9Zx2xAetdiBGOxetVCPP/bKRJwgWFOCeTK72pEaQi4ryT
         4SB3shJnXidH3XHlRJ36xtdTNYIjnypMKV4SQPYXWs3CkBkPIwyYHRQtFxOkgEeyVB
         VlhVU6U1VcnSg==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Nicolas Pitre <npitre@baylibre.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 6/7] modpost: merge sym_update_namespace() into sym_add_exported()
Date:   Sat, 11 Jun 2022 03:32:35 +0900
Message-Id: <20220610183236.1272216-7-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220610183236.1272216-1-masahiroy@kernel.org>
References: <20220610183236.1272216-1-masahiroy@kernel.org>
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

Pass a set of the name, license, and namespace to sym_add_exported().

sym_update_namespace() is unneeded.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 41 +++++++++--------------------------------
 1 file changed, 9 insertions(+), 32 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index f738dddde7b8..0db2cbb74a2a 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -357,26 +357,8 @@ static const char *sec_name_of_symbol(const struct elf_info *info,
 
 #define strstarts(str, prefix) (strncmp(str, prefix, strlen(prefix)) == 0)
 
-static void sym_update_namespace(const char *symname, const char *namespace)
-{
-	struct symbol *s = find_symbol(symname);
-
-	/*
-	 * That symbol should have been created earlier and thus this is
-	 * actually an assertion.
-	 */
-	if (!s) {
-		error("Could not update namespace(%s) for symbol %s\n",
-		      namespace, symname);
-		return;
-	}
-
-	free(s->namespace);
-	s->namespace = namespace[0] ? NOFAIL(strdup(namespace)) : NULL;
-}
-
 static struct symbol *sym_add_exported(const char *name, struct module *mod,
-				       bool gpl_only)
+				       bool gpl_only, const char *namespace)
 {
 	struct symbol *s = find_symbol(name);
 
@@ -389,6 +371,7 @@ static struct symbol *sym_add_exported(const char *name, struct module *mod,
 	s = alloc_symbol(name);
 	s->module = mod;
 	s->is_gpl_only = gpl_only;
+	s->namespace = namespace[0] ? NOFAIL(strdup(namespace)) : NULL;
 	list_add_tail(&s->list, &mod->exported_symbols);
 	hash_add_symbol(s);
 
@@ -658,17 +641,12 @@ static void handle_symbol(struct module *mod, struct elf_info *info,
 		break;
 	default:
 		if (sym->st_shndx == info->export_symbol_sec) {
-			const char *name;
-
-			if (strstarts(symname, "__export_symbol_gpl.")) {
-				name = symname + strlen("__export_symbol_gpl.");
-				sym_add_exported(name, mod, true);
-				sym_update_namespace(name, sym_get_data(info, sym));
-			} else if (strstarts(symname, "__export_symbol.")) {
-				name = symname + strlen("__export_symbol.");
-				sym_add_exported(name, mod, false);
-				sym_update_namespace(name, sym_get_data(info, sym));
-			}
+			if (strstarts(symname, "__export_symbol_gpl."))
+				sym_add_exported(symname + strlen("__export_symbol_gpl."),
+						 mod, true, sym_get_data(info, sym));
+			else if (strstarts(symname, "__export_symbol."))
+				sym_add_exported(symname + strlen("__export_symbol."),
+						 mod, false, sym_get_data(info, sym));
 
 			break;
 		}
@@ -2470,9 +2448,8 @@ static void read_dump(const char *fname)
 			mod = new_module(modname, strlen(modname));
 			mod->from_dump = true;
 		}
-		s = sym_add_exported(symname, mod, gpl_only);
+		s = sym_add_exported(symname, mod, gpl_only, namespace);
 		sym_set_crc(s, crc);
-		sym_update_namespace(symname, namespace);
 	}
 	free(buf);
 	return;
-- 
2.32.0

