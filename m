Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55DBF58196B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 20:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234575AbiGZSJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 14:09:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiGZSJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 14:09:17 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B0C28E1A;
        Tue, 26 Jul 2022 11:09:15 -0700 (PDT)
Received: from localhost.localdomain (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 26QI7oe1026394;
        Wed, 27 Jul 2022 03:07:50 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 26QI7oe1026394
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1658858871;
        bh=osqk3HZjsVA6bUJ9rRIMAah9RI9UxNCyttv8wgZ8qq4=;
        h=From:To:Cc:Subject:Date:From;
        b=lBDZipMJw0B56j53MaMX5CeHTG0MyXNweT26goQkNkmfcr5/t8UvxV7g/Q3mLhJ1X
         9TcCWXIIxKGUKb/FVjRB154rLre8D6RysihBg+5SgU2D1W2HNH9qRYL0vb2vRwFTRN
         BwZmrfbM88zp2VdNDqWvRq+9s6ddf2467gyaGy9fGKCGrB1oQHinieTRz7jUjswi5s
         VT+dFmItk6SFM7P8hQ/ImWhmqvsZ1najvlQ8fSUQlWmaL6golYHYa348I1QLwdJGh4
         H8Z07QkDBy8RCx8qaNaJXh3eY3yx9jYspdCNyDEjtIuk8N40JQFaIbVBh2aZPn4nmm
         lvj5JXhdeLtVQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] modpost: refactor get_secindex()
Date:   Wed, 27 Jul 2022 03:07:47 +0900
Message-Id: <20220726180748.4101236-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SPECIAL() is only used in get_secindex(). Squash it.

Make the code more readable with more comments.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.h | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index bd874f906781..33b376d9ba71 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -156,22 +156,28 @@ static inline int is_shndx_special(unsigned int i)
 	return i != SHN_XINDEX && i >= SHN_LORESERVE && i <= SHN_HIRESERVE;
 }
 
-/*
- * Move reserved section indices SHN_LORESERVE..SHN_HIRESERVE out of
- * the way to -256..-1, to avoid conflicting with real section
- * indices.
- */
-#define SPECIAL(i) ((i) - (SHN_HIRESERVE + 1))
-
 /* Accessor for sym->st_shndx, hides ugliness of "64k sections" */
 static inline unsigned int get_secindex(const struct elf_info *info,
 					const Elf_Sym *sym)
 {
-	if (is_shndx_special(sym->st_shndx))
-		return SPECIAL(sym->st_shndx);
-	if (sym->st_shndx != SHN_XINDEX)
-		return sym->st_shndx;
-	return info->symtab_shndx_start[sym - info->symtab_start];
+	unsigned int index = sym->st_shndx;
+
+	/*
+	 * Elf{32,64}_Sym::st_shndx is 2 byte. Big section numbers are available
+	 * in the .symtab_shndx section.
+	 */
+	if (index == SHN_XINDEX)
+		return info->symtab_shndx_start[sym - info->symtab_start];
+
+	/*
+	 * Move reserved section indices SHN_LORESERVE..SHN_HIRESERVE out of
+	 * the way to UINT_MAX-255..UINT_MAX, to avoid conflicting with real
+	 * section indices.
+	 */
+	if (index >= SHN_LORESERVE)
+		return index - SHN_HIRESERVE - 1;
+
+	return index;
 }
 
 /* file2alias.c */
-- 
2.34.1

