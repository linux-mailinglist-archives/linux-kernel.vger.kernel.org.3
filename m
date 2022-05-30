Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A382537895
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbiE3JDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 05:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbiE3JDq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 05:03:46 -0400
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AA642A0D;
        Mon, 30 May 2022 02:03:44 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 24U92WD0001546;
        Mon, 30 May 2022 18:02:32 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 24U92WD0001546
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653901352;
        bh=qnB7DrGCZmM/ZxcobGqgLO4ePepsPRhLiCFUI8CqYrc=;
        h=From:To:Cc:Subject:Date:From;
        b=oKRMVwEwyYcjgur8o2JE4rLIAzIEPWWDpfcmX8ElUAYMjA3crBC+KXM0Tn2HvHakm
         sT1z43SKVY4GMQRpG96ZZs8+53ILr8/4/TxVPzPjgFXLTHzkTtUI9FAtnybMZOALEt
         mrec7LDbWx7PISHxZ4vFKTBLIZjuSmf6lM7i8q7803TVAw5jb+HVo07hp3Kg3cwEMe
         8KoZYg9Y9xkiv0Ctrdt0Sseexlr35NFX3D07Kbdi4wMJIelQ3pItLfMf/VdCTFeYr6
         L+QyTWWH/7AtYM3OaUCf/o6HHQ9EUZK9d9broVyNDMBcqDXjo6adRaVjdVLCj0MIrE
         R4b7kCOgku8/Q==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Michal Marek <michal.lkml@markovi.net>
Subject: [PATCH 1/2] modpost: simplify mod->name allocation
Date:   Mon, 30 May 2022 18:01:38 +0900
Message-Id: <20220530090139.3030866-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
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

mod->name is set to the ELF filename with the suffix ".o" stripped.

The current code calls strdup() and free() to manipulate the string,
but a simpler approach is to pass new_module() with the name length
subtracted by 2.

Also, check if the passed filename ends with ".o" before stripping it.

The current code blindly chops the suffix:

    tmp[strlen(tmp) - 2] = '\0'

It will cause buffer under-run if strlen(tmp) < 2;

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
---

 scripts/mod/modpost.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 9269735f85c5..c1558bacf717 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -172,11 +172,11 @@ static struct module *find_module(const char *modname)
 	return NULL;
 }
 
-static struct module *new_module(const char *modname)
+static struct module *new_module(const char *name, size_t namelen)
 {
 	struct module *mod;
 
-	mod = NOFAIL(malloc(sizeof(*mod) + strlen(modname) + 1));
+	mod = NOFAIL(malloc(sizeof(*mod) + namelen + 1));
 	memset(mod, 0, sizeof(*mod));
 
 	INIT_LIST_HEAD(&mod->exported_symbols);
@@ -184,8 +184,9 @@ static struct module *new_module(const char *modname)
 	INIT_LIST_HEAD(&mod->missing_namespaces);
 	INIT_LIST_HEAD(&mod->imported_namespaces);
 
-	strcpy(mod->name, modname);
-	mod->is_vmlinux = (strcmp(modname, "vmlinux") == 0);
+	memcpy(mod->name, name, namelen);
+	mod->name[namelen] = '\0';
+	mod->is_vmlinux = (strcmp(mod->name, "vmlinux") == 0);
 
 	/*
 	 * Set mod->is_gpl_compatible to true by default. If MODULE_LICENSE()
@@ -2017,16 +2018,14 @@ static void read_symbols(const char *modname)
 	if (!parse_elf(&info, modname))
 		return;
 
-	{
-		char *tmp;
-
-		/* strip trailing .o */
-		tmp = NOFAIL(strdup(modname));
-		tmp[strlen(tmp) - 2] = '\0';
-		mod = new_module(tmp);
-		free(tmp);
+	if (!strends(modname, ".o")) {
+		error("%s: filename must be suffixed with .o\n", modname);
+		return;
 	}
 
+	/* strip trailing .o */
+	mod = new_module(modname, strlen(modname) - strlen(".o"));
+
 	if (!mod->is_vmlinux) {
 		license = get_modinfo(&info, "license");
 		if (!license)
@@ -2488,7 +2487,7 @@ static void read_dump(const char *fname)
 
 		mod = find_module(modname);
 		if (!mod) {
-			mod = new_module(modname);
+			mod = new_module(modname, strlen(modname));
 			mod->from_dump = true;
 		}
 		s = sym_add_exported(symname, mod, gpl_only);
-- 
2.32.0

