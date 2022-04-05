Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D6614F42DC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 23:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1451313AbiDEUKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 16:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444196AbiDEPlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:41:00 -0400
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C74B5FD3;
        Tue,  5 Apr 2022 07:03:31 -0700 (PDT)
Received: from grover.. (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 235E2k8L021295;
        Tue, 5 Apr 2022 23:02:48 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 235E2k8L021295
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649167369;
        bh=EKCTJzUdUAuHIhmyqzQO5DkjoUd5sMZA3XV4MtVgo6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MhOn01GySX77Cjemm3oCakRXcI11I2w6P7ivi9W6aTx/LVS2cBOtPIlxCUtLi1XMM
         UpIEidA/FLeoegbtsbJ4/sdSb+QIYKiholVhbkRs14VfO5a8SmIA5lVXKJEyllOpEN
         R9mxoFcDJOkucbF9KGVhv4v43bYIPNv/7vtI3Q7J6Pp9ShrpIRo2BqKM2mpYed4G0k
         n4DMa3IbYZIedsY0Bw2Sx2LKxzSa0bjSFOPCd7++CSU37EnQOmYchsmyyTcqCDuhv1
         lSnj/CWnQhjiSbrwuViSX9jr9CpwKiZY1MEpzwoGpgw7CUednaT7hqrP27tQm8HsjG
         pJDiGd/SUxbJA==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH v2 03/10] modpost: remove useless export_from_sec()
Date:   Tue,  5 Apr 2022 23:02:22 +0900
Message-Id: <20220405140229.2895394-4-masahiroy@kernel.org>
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

Remove useless export_from_sec(). This makes further cleanups possible.

I put the temporary code:

    export = export_unknown;

Otherwise, I would get the compiler warning:

    warning: 'export' may be used uninitialized in this function [-Wmaybe-uninitialized]

This is apparently false positive because

    if (strstarts(symname, "__ksymtab_")

... is a stronger condition than:

    if (strstarts(symname, "__ksymtab")

Anyway, this part will be cleaned up by the next commit.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

Changes in v2:
  - Fix compiler warning

 scripts/mod/modpost.c | 17 ++---------------
 scripts/mod/modpost.h |  4 ----
 2 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index ed9d056d2108..eebb32689816 100644
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
@@ -703,7 +690,7 @@ static void handle_symbol(struct module *mod, struct elf_info *info,
 	if (strstarts(symname, "__ksymtab"))
 		export = export_from_secname(info, get_secindex(info, sym));
 	else
-		export = export_from_sec(info, get_secindex(info, sym));
+		export = export_unknown;
 
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

