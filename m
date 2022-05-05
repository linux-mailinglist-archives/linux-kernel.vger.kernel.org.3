Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8DD51B8F6
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 09:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344275AbiEEHb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 03:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343943AbiEEHaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 03:30:08 -0400
Received: from conuserg-12.nifty.com (conuserg-12.nifty.com [210.131.2.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C6D846146;
        Thu,  5 May 2022 00:26:24 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-12.nifty.com with ESMTP id 2457Nenu019426;
        Thu, 5 May 2022 16:23:54 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-12.nifty.com 2457Nenu019426
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1651735435;
        bh=CQEwGlTyJHJvfSf0T31INOBqtnHuEcYXjFZZEa+K6Lg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ghx0K94J/DL64wDGih7KSnS/4k03Qt4Kbxin/Vl55xhF9KLMNF5bx8nBvKcSP36Dn
         eoPEefSJUjqOAF87Fxw85pdJTrQO8gS4wdTR62AJg2BfxctFyX2s36HrMenLo4Rhms
         NI9dtfYloIa2j06X9VBQw9phyaczgOPoDkt+++60haCrD0WoHHHkztEUZTl0LnD8u1
         6OkVIDm8awnVEZ3ADerVv9w4gQOQCGsZ11ZwH9kgX1h9EmuTdfNDE0JEch/yaTKEXe
         hnJyW7ZerFxMvI4N0HGzrEnWfS6nEmT8RdTPAI79pqhZClIlq+8OGJfj15yXU+KFKE
         3n9iE4NPCuAMA==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Nicolas Schier a <nicolas@fjasle.eu>,
        Ard Biesheuvel <ardb@kernel.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linuxppc-dev@lists.ozlabs.org, linux-um@lists.infradead.org,
        linux-s390@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Masahiro Yamada <masahiroy@kernel.org>
Subject: [PATCH v3 12/15] modpost: simplify the ->is_static initialization
Date:   Thu,  5 May 2022 16:22:41 +0900
Message-Id: <20220505072244.1155033-13-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220505072244.1155033-1-masahiroy@kernel.org>
References: <20220505072244.1155033-1-masahiroy@kernel.org>
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

->is_static is set to true at allocation, then to false if the symbol
comes from the dump file.

It is simpler to use !mod->from_dump as the init value.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

(no changes since v2)

Changes in v2:
  - New patch

 scripts/mod/modpost.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index e07542a90fc6..4edd5b223f49 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -242,7 +242,7 @@ static struct symbol *alloc_symbol(const char *name)
 
 	memset(s, 0, sizeof(*s));
 	strcpy(s->name, name);
-	s->is_static = true;
+
 	return s;
 }
 
@@ -376,6 +376,7 @@ static struct symbol *sym_add_exported(const char *name, struct module *mod,
 
 	s = alloc_symbol(name);
 	s->module = mod;
+	s->is_static = !mod->from_dump;
 	s->is_gpl_only = gpl_only;
 	list_add_tail(&s->list, &mod->exported_symbols);
 	hash_add_symbol(s);
@@ -2523,7 +2524,6 @@ static void read_dump(const char *fname)
 			mod->from_dump = true;
 		}
 		s = sym_add_exported(symname, mod, gpl_only);
-		s->is_static = false;
 		sym_set_crc(s, crc);
 		sym_update_namespace(symname, namespace);
 	}
-- 
2.32.0

