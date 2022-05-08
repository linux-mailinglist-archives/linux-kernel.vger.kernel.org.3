Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B80151F081
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:42:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiEHTWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbiEHTPy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 15:15:54 -0400
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51DE317;
        Sun,  8 May 2022 12:11:12 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 248J8qSR030019;
        Mon, 9 May 2022 04:08:57 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 248J8qSR030019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1652036938;
        bh=fTWufSGLPIAfiy+llcmQSSOszMnmVGeqEYG5OUh4Gao=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IxQXJhKDS8X8Fsd44zY4pkmn3cOxr3A9N3bFK6Y49wQNuLZ+9WS7ZDQ/g+hNUo9kh
         BfYIrtdQIkpIfoQ1HXXT4fiR0FJ+hAyWHaNHjV6Leqy0NkCt24bhs6VazRcz8MCBT8
         ucy5n8tNqoIAPkAz1oN/vyb16Cfod/A1SkZyA2wLpEZz2HN1O4/wFs4k5EtWUXjNLz
         oHT0+VsMvpoQqx+ipAVBqCt2M/9YJagiYqzBEgBU1YR6P6MD7P0UExrDvJwDfNujrN
         W5DnekjBkKRUHoj4pPTA6E26syJUR4JOonvqa3MUDfu+kMuwpENMqYwXhknnf51Ygz
         oEUCfzjIkzsNw==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-modules@vger.kernel.org, linux-s390@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, clang-built-linux@googlegroups.com,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v4 04/14] modpost: add sym_find_with_module() helper
Date:   Mon,  9 May 2022 04:06:21 +0900
Message-Id: <20220508190631.2386038-5-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220508190631.2386038-1-masahiroy@kernel.org>
References: <20220508190631.2386038-1-masahiroy@kernel.org>
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

find_symbol() returns the first symbol found in the hash table. This
table is global, so it may return a symbol from an unexpected module.

There is a case where we want to search for a symbol with a given name
in a specified module.

Add sym_find_with_module(), which receives the module pointer as the
second argument. It is equivalent to find_module() if NULL is passed
as the module pointer.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>
Tested-by: Nathan Chancellor <nathan@kernel.org>
---

Changes in v4:
  - Only takes the new helper from
    https://patchwork.kernel.org/project/linux-kbuild/patch/20220505072244.1155033-2-masahiroy@kernel.org/

Changes in v2:
  - Rename the new func to sym_find_with_module()

 scripts/mod/modpost.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index e7e2c70a98f5..fc5db1f73cf1 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -266,7 +266,7 @@ static void sym_add_unresolved(const char *name, struct module *mod, bool weak)
 	list_add_tail(&sym->list, &mod->unresolved_symbols);
 }
 
-static struct symbol *find_symbol(const char *name)
+static struct symbol *sym_find_with_module(const char *name, struct module *mod)
 {
 	struct symbol *s;
 
@@ -275,12 +275,17 @@ static struct symbol *find_symbol(const char *name)
 		name++;
 
 	for (s = symbolhash[tdb_hash(name) % SYMBOL_HASH_SIZE]; s; s = s->next) {
-		if (strcmp(s->name, name) == 0)
+		if (strcmp(s->name, name) == 0 && (!mod || s->module == mod))
 			return s;
 	}
 	return NULL;
 }
 
+static struct symbol *find_symbol(const char *name)
+{
+	return sym_find_with_module(name, NULL);
+}
+
 struct namespace_list {
 	struct list_head list;
 	char namespace[];
-- 
2.32.0

