Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5AD51B6C7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 05:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242084AbiEED5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 23:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234446AbiEED5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 23:57:07 -0400
Received: from conuserg-08.nifty.com (conuserg-08.nifty.com [210.131.2.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A435614027;
        Wed,  4 May 2022 20:53:27 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-08.nifty.com with ESMTP id 2453qiRH021346;
        Thu, 5 May 2022 12:52:46 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-08.nifty.com 2453qiRH021346
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651722766;
        bh=24jtj+UYB0xv342M0DAJe77XkxPBb78c2WJx0IEENiY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dIbXKrf05r1Y4YxHOmc4jtJgcvH4V+h2lx5ydXY+efkZW+vFlpmpz0Pa2wesNvy9C
         G3kHE50VhBIPpkY3VpBTrH1/UaxIW8MBAuWDETlbm8RDSnQNFYwsYcQ0xr6qVRvCv/
         3kK0DC4XvlpHbFuGyAtj7JGMWeWv4I8wbfax9SFg7Z/TQVS772fWmv2wou9U24CWrn
         buhad7efVW3TKU0u/DyZiGmuPsnv9lVpA6puXgyZXQID+jI9DFB4p9jSJRUufangcN
         wVzllHHxmylVOvz+smzYoY4/z3S493lVMisRiUiFY501rYnVyzJoPoki9Lznfjt+Vd
         NsWhkgufBfuwA==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v2 3/3] module: merge check_exported_symbol() into find_exported_symbol_in_section()
Date:   Thu,  5 May 2022 12:52:12 +0900
Message-Id: <20220505035212.1130858-4-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220505035212.1130858-1-masahiroy@kernel.org>
References: <20220505035212.1130858-1-masahiroy@kernel.org>
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

Now check_exported_symbol() always succeeds.

Merge it into find_exported_symbol_in_search() to make the code concise.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 kernel/module/main.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/kernel/module/main.c b/kernel/module/main.c
index 22a860d42c16..14686571d4fc 100644
--- a/kernel/module/main.c
+++ b/kernel/module/main.c
@@ -243,17 +243,6 @@ static __maybe_unused void *any_section_objs(const struct load_info *info,
 #define symversion(base, idx) ((base != NULL) ? ((base) + (idx)) : NULL)
 #endif
 
-static bool check_exported_symbol(const struct symsearch *syms,
-				  struct module *owner, unsigned int symnum,
-				  struct find_symbol_arg *fsa)
-{
-	fsa->owner = owner;
-	fsa->crc = symversion(syms->crcs, symnum);
-	fsa->sym = &syms->start[symnum];
-	fsa->license = syms->license;
-	return true;
-}
-
 static const char *kernel_symbol_name(const struct kernel_symbol *sym)
 {
 #ifdef CONFIG_HAVE_ARCH_PREL32_RELOCATIONS
@@ -290,12 +279,15 @@ static bool find_exported_symbol_in_section(const struct symsearch *syms,
 
 	sym = bsearch(fsa->name, syms->start, syms->stop - syms->start,
 			sizeof(struct kernel_symbol), cmp_name);
+	if (!sym)
+		return false;
 
-	if (sym != NULL && check_exported_symbol(syms, owner,
-						 sym - syms->start, fsa))
-		return true;
+	fsa->owner = owner;
+	fsa->crc = symversion(syms->crcs, sym - syms->start);
+	fsa->sym = sym;
+	fsa->license = syms->license;
 
-	return false;
+	return true;
 }
 
 /*
-- 
2.32.0

