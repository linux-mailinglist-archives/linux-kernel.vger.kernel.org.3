Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A507588DF4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 15:54:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238489AbiHCNys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 09:54:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238326AbiHCNy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 09:54:26 -0400
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8158343E6B;
        Wed,  3 Aug 2022 06:52:02 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 273DokZX018578;
        Wed, 3 Aug 2022 22:50:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 273DokZX018578
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1659534646;
        bh=4lNUVwZLKGFu7RDUkST96BO8Yb9Fnq+wtWdIdDRUbnQ=;
        h=From:To:Cc:Subject:Date:From;
        b=D67NGJDpiuW4RkHT362dOxIXziItoAApb9cP0KVmchF3oKAjGnCacLheNCXO42Lmw
         OQNEcFXt21Bb/t6m1mnjLbDX4yrWMA9vGq0UdtIQGT9HCJ+jolTHz1396+sfS8Qgfw
         +lUDpqYuAT+pX77MpDUtNfiaftRPYZlgD6cxeBdixkbowtEruIJ4PVt1M035Tq3uTo
         KgNDtLF+Qpz2r37AOXQBZKia64LZzBDez9eDURgl+ZXmUr/D16bvfF2ZdN8LVE5lqb
         +8I38UlK28pNCwvQifXOlLLYLGnbXHKAwa1iX+ZPtAGyyqiPxKo/Jj54YVJuNAGwuL
         MFed38GPKUW6w==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] modpost: refactor get_secindex()
Date:   Wed,  3 Aug 2022 22:50:13 +0900
Message-Id: <20220803135013.1818199-1-masahiroy@kernel.org>
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

Changes in v2:
  - Revive 'index <= SHN_HIRESERVE)' check

 scripts/mod/modpost.h | 30 ++++++++++++++++++------------
 1 file changed, 18 insertions(+), 12 deletions(-)

diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index bd874f906781..1178f40a73f3 100644
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
+	if (index >= SHN_LORESERVE && index <= SHN_HIRESERVE)
+		return index - SHN_HIRESERVE - 1;
+
+	return index;
 }
 
 /* file2alias.c */
-- 
2.34.1

