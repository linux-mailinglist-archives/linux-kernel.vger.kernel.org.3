Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C944B4F01DE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 15:01:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354905AbiDBNC7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 09:02:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354880AbiDBNCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 09:02:52 -0400
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2DF13F32;
        Sat,  2 Apr 2022 06:00:59 -0700 (PDT)
Received: from grover.. (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 232D0S3a030001;
        Sat, 2 Apr 2022 22:00:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 232D0S3a030001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1648904429;
        bh=5OZ0/yILFQHmNR7TzDJ3t5BjHVkIHlCUOY7TO3seEhs=;
        h=From:To:Cc:Subject:Date:From;
        b=uU2wE63f/QCf6b/d0e3XBsAGZUk4eVbD9hxfoJudd4sGIWlOPxwJyI9cftNFXY75K
         Br/8DNAtdG/hUylZnK/BmgK1gQrxQkQRB0X3RrgdPU07z1d9wFOfQ7VFYISjSQKPUI
         EkO7bjTahUAo/UVsWCklCjrhWulZxoXxvEYtxOvFVY4t2kSxmQWqWr3zB894OQ76sj
         TnjhPIe21/62pBKpCvjsbLJxi0rQcBMQDIh15VOvdm1PPaBXYfG+sKZlvAuKkNRJLd
         z5B5HTewvyII+dI7KDYIWQIEd+uKnrgO6M505WmUbePEXerhBcSNNISVfISBEzeNP/
         o7EMIDIup+6Qg==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 1/2] modpost: remove useless export_from_sec()
Date:   Sat,  2 Apr 2022 22:00:13 +0900
Message-Id: <20220402130014.1417773-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
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

With commit 1743694eb235 ("modpost: stop symbol preloading for
modversion CRC") applied, now export_from_sec() is useless.

handle_symbol() is called for every symbol in the ELF.

When 'symname' does not start with "__ksymtab", export_from_sec() is
called, and the returned value is stored in 'export'.

It is used in the last part of handle_symbol():

                if (strstarts(symname, "__ksymtab_")) {
                        name = symname + strlen("__ksymtab_");
                        sym_add_exported(name, mod, export);
                }

'export' is used only when 'symname' starts with "__ksymtab_".

So, the value returned by export_from_sec() is never used.

Remove this useless function. This makes further cleanups possible.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 17 +----------------
 scripts/mod/modpost.h |  4 ----
 2 files changed, 1 insertion(+), 20 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index ed9d056d2108..194ca9083c7a 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -369,16 +369,6 @@ static enum export export_from_secname(struct elf_info *elf, unsigned int sec)
 		return export_unknown;
 }
 
-static enum export export_from_sec(struct elf_info *elf, unsigned int sec)
-{
-	if (sec == elf->export_sec)
-		return export_plain;
-	else if (sec == elf->export_gpl_sec)
-		return export_gpl;
-	else
-		return export_unknown;
-}
-
 static const char *namespace_from_kstrtabns(const struct elf_info *info,
 					    const Elf_Sym *sym)
 {
@@ -576,10 +566,7 @@ static int parse_elf(struct elf_info *info, const char *filename)
 				fatal("%s has NOBITS .modinfo\n", filename);
 			info->modinfo = (void *)hdr + sechdrs[i].sh_offset;
 			info->modinfo_len = sechdrs[i].sh_size;
-		} else if (strcmp(secname, "__ksymtab") == 0)
-			info->export_sec = i;
-		else if (strcmp(secname, "__ksymtab_gpl") == 0)
-			info->export_gpl_sec = i;
+		}
 
 		if (sechdrs[i].sh_type == SHT_SYMTAB) {
 			unsigned int sh_link_idx;
@@ -702,8 +689,6 @@ static void handle_symbol(struct module *mod, struct elf_info *info,
 
 	if (strstarts(symname, "__ksymtab"))
 		export = export_from_secname(info, get_secindex(info, sym));
-	else
-		export = export_from_sec(info, get_secindex(info, sym));
 
 	switch (sym->st_shndx) {
 	case SHN_COMMON:
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 0c47ff95c0e2..a85dcec3669a 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -25,7 +25,6 @@
 #define Elf_Sym     Elf32_Sym
 #define Elf_Addr    Elf32_Addr
 #define Elf_Sword   Elf64_Sword
-#define Elf_Section Elf32_Half
 #define ELF_ST_BIND ELF32_ST_BIND
 #define ELF_ST_TYPE ELF32_ST_TYPE
 
@@ -40,7 +39,6 @@
 #define Elf_Sym     Elf64_Sym
 #define Elf_Addr    Elf64_Addr
 #define Elf_Sword   Elf64_Sxword
-#define Elf_Section Elf64_Half
 #define ELF_ST_BIND ELF64_ST_BIND
 #define ELF_ST_TYPE ELF64_ST_TYPE
 
@@ -138,8 +136,6 @@ struct elf_info {
 	Elf_Shdr     *sechdrs;
 	Elf_Sym      *symtab_start;
 	Elf_Sym      *symtab_stop;
-	Elf_Section  export_sec;
-	Elf_Section  export_gpl_sec;
 	char         *strtab;
 	char	     *modinfo;
 	unsigned int modinfo_len;
-- 
2.32.0

