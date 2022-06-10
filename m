Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D63546C7E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 20:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348344AbiFJSei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 14:34:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347734AbiFJSeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 14:34:25 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA62339BB3;
        Fri, 10 Jun 2022 11:34:22 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 25AIX5TN020882;
        Sat, 11 Jun 2022 03:33:07 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 25AIX5TN020882
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1654885988;
        bh=3IE60WW7Xg7rXgGuszZsJXuJ1I7EaTrx4m8Z7Lvb9no=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a4OGGuQgrOyh6Q06Etn1eXD9vw6HbiLwvEQt96iq2c4KxGUtZOgtQbhhtIkIr3w7v
         pDQylld6dBNBrlBOLaspZ1cRyqQVuOKem3friZXlyymxTGZKKXLtM46m2IbG40bvQe
         PlHrf7mSsuVmFbgUuQvYPrrqMT8fXCP2/WBLZvXVG4eT2/Z9zxYE1mM3li9wL0J+lq
         /xWy8C3v4vGd6YZmeYeWv6qBkeqV5IofvuK963O04bBofuWLeZcmGS1h6QYvukFPSD
         eHKTpvbL62fDpvnG5c5BkO8I3g9+yaFRrpcdxhZ4cgeBKlCN0KsEBZPG2c7y/nYOc+
         WUFYCVH6E3MOA==
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
Subject: [PATCH 2/7] modpost: put get_secindex() call inside sec_name()
Date:   Sat, 11 Jun 2022 03:32:31 +0900
Message-Id: <20220610183236.1272216-3-masahiroy@kernel.org>
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

There are 5 callsites of sec_name(). In all the places, sec_name() is
used together with get_secindex().

So, it is simpler to merge two function calls

    sec_name(elf, get_secindex(elf, sym))

into one call:

    sec_name_of_symbol(elf, sym)

While I was here, I also inserted this array range check:

    if (secindex >= info->num_sections)
            return "";

This will make the code robust against info->sechdrs[] overrun.

sym->st_shndx is 2 bytes (for both 32 and 64 bit systems), and the
range 0xff00..0xffff is reserved for special sections.

For example, a symbol specifies an absolute value, sym->st_shndx==0xfff1.
get_secindex() remaps it to 0xfffffff1.

There is no corresponding section header for such special sections.

The existing code does not hit this issue, but it is better to check
the array range.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 620dc8c4c814..b9f2a040f185 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -339,8 +339,19 @@ static const char *sech_name(const struct elf_info *info, Elf_Shdr *sechdr)
 				      sechdr->sh_name);
 }
 
-static const char *sec_name(const struct elf_info *info, int secindex)
+static const char *sec_name_of_symbol(const struct elf_info *info,
+				      const Elf_Sym *sym)
 {
+	unsigned int secindex = get_secindex(info, sym);
+
+	/*
+	 * If sym->st_shndx is within the special section range, get_secindex()
+	 * will remapit to a big number.
+	 * Bail out here, otherwise info->sechdrs[secindex] would overrun.
+	 */
+	if (secindex >= info->num_sections)
+		return "";
+
 	return sech_name(info, &info->sechdrs[secindex]);
 }
 
@@ -649,7 +660,7 @@ static void handle_symbol(struct module *mod, struct elf_info *info,
 			const char *name, *secname;
 
 			name = symname + strlen("__ksymtab_");
-			secname = sec_name(info, get_secindex(info, sym));
+			secname = sec_name_of_symbol(info, sym);
 
 			if (strstarts(secname, "___ksymtab_gpl+"))
 				sym_add_exported(name, mod, true);
@@ -1217,7 +1228,7 @@ static Elf_Sym *find_elf_symbol2(struct elf_info *elf, Elf_Addr addr,
 
 		if (is_shndx_special(sym->st_shndx))
 			continue;
-		symsec = sec_name(elf, get_secindex(elf, sym));
+		symsec = sec_name_of_symbol(elf, sym);
 		if (strcmp(symsec, sec) != 0)
 			continue;
 		if (!is_valid_name(elf, sym))
@@ -1457,7 +1468,7 @@ static void default_mismatch_handler(const char *modname, struct elf_info *elf,
 	if (strstarts(fromsym, "reference___initcall"))
 		return;
 
-	tosec = sec_name(elf, get_secindex(elf, sym));
+	tosec = sec_name_of_symbol(elf, sym);
 	to = find_elf_symbol(elf, r->r_addend, sym);
 	tosym = sym_name(elf, to);
 
@@ -1559,7 +1570,7 @@ static void extable_mismatch_handler(const char* modname, struct elf_info *elf,
 				     Elf_Rela* r, Elf_Sym* sym,
 				     const char *fromsec)
 {
-	const char* tosec = sec_name(elf, get_secindex(elf, sym));
+	const char *tosec = sec_name_of_symbol(elf, sym);
 
 	sec_mismatch_count++;
 
@@ -1593,7 +1604,7 @@ static void extable_mismatch_handler(const char* modname, struct elf_info *elf,
 static void check_section_mismatch(const char *modname, struct elf_info *elf,
 				   Elf_Rela *r, Elf_Sym *sym, const char *fromsec)
 {
-	const char *tosec = sec_name(elf, get_secindex(elf, sym));
+	const char *tosec = sec_name_of_symbol(elf, sym);
 	const struct sectioncheck *mismatch = section_mismatch(fromsec, tosec);
 
 	if (mismatch) {
-- 
2.32.0

