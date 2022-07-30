Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDBA0585B6E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 19:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235384AbiG3Rht (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 13:37:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233216AbiG3Rhr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 13:37:47 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7130B15835;
        Sat, 30 Jul 2022 10:37:45 -0700 (PDT)
Received: from localhost.localdomain (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 26UHad9a015991;
        Sun, 31 Jul 2022 02:36:39 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 26UHad9a015991
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1659202600;
        bh=zDHb71qwI+a+ejytrtA7mu7Mj8TpMPar35Ic/moKcDM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=aPlwIx7XNgw5TU8kj+kuzexvwVlz4VP6ZXUkaE8PhcbY+/K3sPcGnk4unpZvrtQl9
         LcMczhDuL4hDERQFqHTptmSpU+ls/Mtf4c6bTBuDFb9bCxq46cEHqs3VNh2C7puo32
         VSHkx9TSbOdOgZPdYRILZm7t0CiRtzpuGBv2Id30plEecuqcVQC29FOCrPMbzkQESN
         +w9WK9NYZr4TU2eAr7eFnFLXKAW7znVMluN3LYejDmcainuX9jkIXHpgWiB87h5ntG
         cyDdMDxGFbVqeTe1zFGjDYXTGqbKbvnq3mBteF14Bz6CjeuO1pfpGr9bf5E0KXZKgJ
         DwyaJ39qT1ivA==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] modpost: use more reliable way to get fromsec in section_rel(a)()
Date:   Sun, 31 Jul 2022 02:36:35 +0900
Message-Id: <20220730173636.1303357-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220730173636.1303357-1-masahiroy@kernel.org>
References: <20220730173636.1303357-1-masahiroy@kernel.org>
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

The section name of Rel and Rela starts with ".rel" and ".rela"
respectively (but, I do not know whether this is specification or
convention).

For example, ".rela.text" holds relocation entries applied to the
".text" section.

So, the code chops the ".rel" or ".rela" prefix to get the name of
the section to which the relocation applies.

However, I do not like to skip 4 or 5 bytes blindly because it is
potential memory overrun.

The ELF specification provides a more reliable way to do this.

 - The sh_info field holds extra information, whose interpretation
   depends on the section type

 - If the section type is SHT_REL or SHT_RELA, the sh_info field holds
   the section header index of the section to which the relocation
   applies.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 148b38699889..c6a055c0291e 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1723,8 +1723,7 @@ static void section_rela(const char *modname, struct elf_info *elf,
 	Elf_Rela *start = (void *)elf->hdr + sechdr->sh_offset;
 	Elf_Rela *stop  = (void *)start + sechdr->sh_size;
 
-	fromsec = sech_name(elf, sechdr);
-	fromsec += strlen(".rela");
+	fromsec = sec_name(elf, sechdr->sh_info);
 	/* if from section (name) is know good then skip it */
 	if (match(fromsec, section_white_list))
 		return;
@@ -1776,8 +1775,7 @@ static void section_rel(const char *modname, struct elf_info *elf,
 	Elf_Rel *start = (void *)elf->hdr + sechdr->sh_offset;
 	Elf_Rel *stop  = (void *)start + sechdr->sh_size;
 
-	fromsec = sech_name(elf, sechdr);
-	fromsec += strlen(".rel");
+	fromsec = sec_name(elf, sechdr->sh_info);
 	/* if from section (name) is know good then skip it */
 	if (match(fromsec, section_white_list))
 		return;
-- 
2.34.1

