Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F52F5817F2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 18:53:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229697AbiGZQx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 12:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229648AbiGZQx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 12:53:26 -0400
Received: from conuserg-07.nifty.com (conuserg-07.nifty.com [210.131.2.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0A863C1;
        Tue, 26 Jul 2022 09:53:24 -0700 (PDT)
Received: from localhost.localdomain (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-07.nifty.com with ESMTP id 26QGq6sm002811;
        Wed, 27 Jul 2022 01:52:06 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-07.nifty.com 26QGq6sm002811
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1658854326;
        bh=bsANJFQL0PDyyCjbc6YJJ6rzr0lsBYl+Br0sYpHU1oU=;
        h=From:To:Cc:Subject:Date:From;
        b=fXkCFkPFyyI6MsyzwKg9vrCaid8MdGXQlfGJNVn3KKhDKnDYisp6cY/o5XgD+LPql
         uen8ATRdaMJeqFs+CmpvnlFcPr7m9au3CttXz3uTs4BnCn2o4CQddOY7BdgDTAy4sg
         T1fkwFQLbuCbJYoiBf6QcJ2p7HCTd03cPAMBlrEioc+c6mRbcv120q9fVShgRpNEgy
         8QMLMtzNPRoFm7yGmAKR0oiol3d3F9SdIeUuZLjAhlQBQisQQMj/V7zDWmjP+ULsKW
         UAlA+xAty9OyuF0zl8GKC2sVWuQ8hQQ0P040LN8ujR2EM+L2tS4E6oZgm5bE4ekPxL
         0iC3bP+D1CJGQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] modpost: remove unused Elf_Sword macro
Date:   Wed, 27 Jul 2022 01:52:04 +0900
Message-Id: <20220726165204.3363120-1-masahiroy@kernel.org>
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

Commit 9ad21c3f3ecf ("kbuild: try harder to find symbol names in
modpost") added Elf_Sword (in a wrong way), but did not use it at all.

BTW, the current code looks weird.

The fix for the 32-bit part would be:

    Elf64_Sword    -->    Elf32_Sword

(weirdness in the prefix, Elf32_ vs Elf64_)

The fix for the 64-bit part would be:

    Elf64_Sxword   -->    Elf64_Sword

(the size is different between Sword and Sxword)

Note:

    Elf32_Sword   ==  Elf64_Sword   ==  int32_t
    Elf32_Sxword  ==  Elf64_Sxword  ==  int64_t

Anyway, let's drop unused code instead of fixing it.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 68cd4aeeae3d..620f2fd08e05 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -26,7 +26,6 @@
 #define Elf_Shdr    Elf32_Shdr
 #define Elf_Sym     Elf32_Sym
 #define Elf_Addr    Elf32_Addr
-#define Elf_Sword   Elf64_Sword
 #define Elf_Section Elf32_Half
 #define ELF_ST_BIND ELF32_ST_BIND
 #define ELF_ST_TYPE ELF32_ST_TYPE
@@ -41,7 +40,6 @@
 #define Elf_Shdr    Elf64_Shdr
 #define Elf_Sym     Elf64_Sym
 #define Elf_Addr    Elf64_Addr
-#define Elf_Sword   Elf64_Sxword
 #define Elf_Section Elf64_Half
 #define ELF_ST_BIND ELF64_ST_BIND
 #define ELF_ST_TYPE ELF64_ST_TYPE
-- 
2.34.1

