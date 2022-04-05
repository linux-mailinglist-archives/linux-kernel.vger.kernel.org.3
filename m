Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BFA4F4B63
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574450AbiDEW4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 18:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384117AbiDEM1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 08:27:11 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2E1574AB;
        Tue,  5 Apr 2022 04:35:17 -0700 (PDT)
Received: from grover.. (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 235BYCGs000464;
        Tue, 5 Apr 2022 20:34:16 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 235BYCGs000464
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1649158456;
        bh=jQYNKCFxuPQP3ZPrlr5taAXi8gXxcKaNemFjBDbWpQI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KIbFiadPsQ0UMZCQcC/JAQ4dYrCBvGqON+8YV7gUab1+ukbGOIE3lm8KFYlA+dL6S
         J5z3+ipr5aPapMUf6ro01z2XRhnGSYgMWgg9/PcbGJ4OGJUbcZeozObKqKS8V1Bgo+
         n6q8yked1G7CVRG8o5QraRVE+WrNzXCTZ+7RvPaUM4eTNqKVsNY+6bbSuByPRIfuq4
         8ksMsfKJTh3s6y/zWKTqUXTxKwCslsDVDa3bQ2s9KTqfmdpCh3wtWMKrCJaZ9ziPkn
         GDx3mhB4z4FIDquk5BpblgbpDe3B3sAogF/KKfwtYVYYpY0VmOW3lXe0yT55uLgud5
         JfUXVDEqeDvtQ==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2 06/10] modpost: remove annoying namespace_from_kstrtabns()
Date:   Tue,  5 Apr 2022 20:33:54 +0900
Message-Id: <20220405113359.2880241-7-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220405113359.2880241-1-masahiroy@kernel.org>
References: <20220405113359.2880241-1-masahiroy@kernel.org>
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

There are two call sites for sym_update_namespace().

When the symbol has no namespace, s->namespace is set to NULL,
but the conversion from "" to NULL is done in two different places.

[1] read_symbols()

  This gets the namespace from __kstrtabns_<symbol>. If the symbol has
  no namespace, sym_get_data(info, sym) returns the empty string "".
  namespace_from_kstrtabns() converts it to NULL before it is passed to
  sym_update_namespace().

[2] read_dump()

  This gets the namespace from the dump file, *.symvers. If the symbol
  has no namespace, the 'namespace' is the empty string "", which is
  directly passed into sym_update_namespace(). The conversion from
  "" to NULL is done in sym_update_namespace().

namespace_from_kstrtabns() exists only for creating this inconsistency.

By removing it, sym_update_namespace() is consistently passed with ""
when the symbol has no namespace.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

Changes in v2:
  - new

 scripts/mod/modpost.c | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 2a202764ff48..522d5249d196 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -369,13 +369,6 @@ static enum export export_from_secname(struct elf_info *elf, unsigned int sec)
 		return export_unknown;
 }
 
-static const char *namespace_from_kstrtabns(const struct elf_info *info,
-					    const Elf_Sym *sym)
-{
-	const char *value = sym_get_data(info, sym);
-	return value[0] ? value : NULL;
-}
-
 static void sym_update_namespace(const char *symname, const char *namespace)
 {
 	struct symbol *s = find_symbol(symname);
@@ -391,8 +384,7 @@ static void sym_update_namespace(const char *symname, const char *namespace)
 	}
 
 	free(s->namespace);
-	s->namespace =
-		namespace && namespace[0] ? NOFAIL(strdup(namespace)) : NULL;
+	s->namespace = namespace[0] ? NOFAIL(strdup(namespace)) : NULL;
 }
 
 /**
@@ -2049,9 +2041,7 @@ static void read_symbols(const char *modname)
 		/* Apply symbol namespaces from __kstrtabns_<symbol> entries. */
 		if (strstarts(symname, "__kstrtabns_"))
 			sym_update_namespace(symname + strlen("__kstrtabns_"),
-					     namespace_from_kstrtabns(&info,
-								      sym));
-
+					     sym_get_data(&info, sym));
 		if (strstarts(symname, "__crc_"))
 			handle_modversion(mod, &info, sym,
 					  symname + strlen("__crc_"));
-- 
2.32.0

