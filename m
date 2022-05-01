Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6026A51630E
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 10:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344037AbiEAIqV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 04:46:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245759AbiEAIpu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 04:45:50 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561F24C43E;
        Sun,  1 May 2022 01:42:23 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 2418f2Rx008518;
        Sun, 1 May 2022 17:41:10 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2418f2Rx008518
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651394470;
        bh=OmaZil0Vb85UCwkjr92TzJ32MZ+hWemh6WOewWDTZHI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tJj4GfjyJ4JlwI4OAh0KTCytKkwhqIHUZBNUCBw2rdDye4axoBttcVFBo7jCJyf3m
         1GAo7M8+FgEQdprk4N0bDUVfgzaXvP8At3sPASVnT8ti0rsE/QOtk3yWYRe0R6qyMZ
         wNrV2bXev2xwp3Ns1cWzs2qKhI8xCiasijA0wruJxeSr9S97NeF8SnIlBKVpgEqB9x
         jFBPMvlUA+H1zedwX9HpW4NUjxj5CoZoNAY+oRhzp0IIJtZwHHA70xpT65h6Ou7agV
         LmZSQbH0b7+FFXUmpPDkuzitZrak4/J5hzCiBceAbn8biVJwwrZoWbK5k7EarXhB0s
         wRfU6swl+FIxA==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH v2 12/26] modpost: make sym_add_exported() always allocate a new symbol
Date:   Sun,  1 May 2022 17:40:18 +0900
Message-Id: <20220501084032.1025918-13-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220501084032.1025918-1-masahiroy@kernel.org>
References: <20220501084032.1025918-1-masahiroy@kernel.org>
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

Currently, sym_add_exported() does not allocate a symbol if the same
name symbol already exists in the hash table.

This does not reflect the real use cases. You can let an external
module override the in-tree one. In this case, the external module
will export the same name symbols as the in-tree one. However,
modpost simply ignores those symbols, then Module.symvers for the
external module loses its symbols.

sym_add_exported() should allocate a new symbol.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v1)

 scripts/mod/modpost.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 1f01fc942f94..c9b75697d0fc 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -412,19 +412,17 @@ static struct symbol *sym_add_exported(const char *name, struct module *mod,
 {
 	struct symbol *s = find_symbol(name);
 
-	if (!s) {
-		s = new_symbol(name, mod, export);
-		list_add_tail(&s->list, &mod->exported_symbols);
-	} else if (!external_module || s->module->is_vmlinux ||
-		   s->module == mod) {
+	if (s && (!external_module || s->module->is_vmlinux || s->module == mod)) {
 		error("%s: '%s' exported twice. Previous export was in %s%s\n",
 		      mod->name, name, s->module->name,
 		      s->module->is_vmlinux ? "" : ".ko");
-		return s;
 	}
 
+	s = new_symbol(name, mod, export);
 	s->module = mod;
 	s->export    = export;
+	list_add_tail(&s->list, &mod->exported_symbols);
+
 	return s;
 }
 
-- 
2.32.0

