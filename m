Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67D0257A461
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 18:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbiGSQyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 12:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbiGSQyS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 12:54:18 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BCB751418;
        Tue, 19 Jul 2022 09:54:15 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 26JGr86D000327;
        Wed, 20 Jul 2022 01:53:08 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 26JGr86D000327
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1658249588;
        bh=KrtNqk9IJyz2JuCxX8lc6MlGUgVdyQMIHScZ5HpM6s4=;
        h=From:To:Cc:Subject:Date:From;
        b=rW2UN17bVc9ibI9XgZICeWuD6Q/8VHisBM4Hx2rMyQJKRtms3bHIM3WyDOx5xpRm8
         ULUFG9DE+CeM7pTkhSMgGW4LY4BOFvd79gMQ9cZqrvjJEKYHMCL2XYUGe1b2S0HfSD
         /fbOBFXK8Y1X8r88TvwUCy2PObWfXmtHLEfjaWdxLxbJxqs5LmOmTHZc+7XNj+E0qi
         s7nAS3LcBQk849R0CdAH2qK+LzLTcrpmq3F2EfEXGsTFBgF4iCJ5epiujus+zyjyNe
         y8Z7f6Le10n/SOA+e0icA89zaE1YWPtlDFSHxuuC7/4eI0UpRZX/rgI9N4C5+d282F
         2gAFu4tDwojWg==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] modpost: drop executable ELF support
Date:   Wed, 20 Jul 2022 01:52:59 +0900
Message-Id: <20220719165300.3000580-1-masahiroy@kernel.org>
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

Since commit 269a535ca931 ("modpost: generate vmlinux.symvers and
reuse it for the second modpost"), modpost only parses relocatable
files (ET_REL).

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 7735d095338c..6370f9accb8e 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -321,9 +321,6 @@ static void *sym_get_data_by_offset(const struct elf_info *info,
 {
 	Elf_Shdr *sechdr = &info->sechdrs[secindex];
 
-	if (info->hdr->e_type != ET_REL)
-		offset -= sechdr->sh_addr;
-
 	return (void *)info->hdr + sechdr->sh_offset + offset;
 }
 
@@ -477,6 +474,10 @@ static int parse_elf(struct elf_info *info, const char *filename)
 	sechdrs = (void *)hdr + hdr->e_shoff;
 	info->sechdrs = sechdrs;
 
+	/* modpost only works for relocatable objects */
+	if (hdr->e_type != ET_REL)
+		fatal("%s: not relocatable object.", filename);
+
 	/* Check if file offset is correct */
 	if (hdr->e_shoff > info->size) {
 		fatal("section header offset=%lu in file '%s' is bigger than filesize=%zu\n",
@@ -1633,9 +1634,6 @@ static int addend_386_rel(struct elf_info *elf, Elf_Shdr *sechdr, Elf_Rela *r)
 		break;
 	case R_386_PC32:
 		r->r_addend = TO_NATIVE(*location) + 4;
-		/* For CONFIG_RELOCATABLE=y */
-		if (elf->hdr->e_type == ET_EXEC)
-			r->r_addend += r->r_offset;
 		break;
 	}
 	return 0;
-- 
2.34.1

