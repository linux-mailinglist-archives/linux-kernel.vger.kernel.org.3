Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFA45531832
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239202AbiEWQsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239148AbiEWQsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:48:35 -0400
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7EE265D3B;
        Mon, 23 May 2022 09:48:29 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 24NGlJD2027017;
        Tue, 24 May 2022 01:47:21 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 24NGlJD2027017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653324441;
        bh=9VkSZyqvjBg0Nd6+4A0acMuL4QkugOVgV61qsiUyjxo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vgcW+5UuTOCoZwOd3bihOfnGjtXB0QM4j45PjQOSAxwc2OfU+cU4BKu8m1mcGU0Tt
         UW84tfeMdGyzBU20U2VPKrDJ2GDT+TQPbASRau+UGWNZvZGAA839PUFhnTaVVI7cOb
         M5xYyyZj810ta78qYLm+HeA35myOccYP0Td0poM1nu0veamtIHDVgBFpMi4M7s727J
         g+H8KCzW6oYV08Yr42eueCpMJs9I5zj8AW4I0BgZVbkiyU8b4OQ7NHqadsH7glN6GO
         GZCCYorECD94/GDTs5bgSKpyiXcCjIFjIkRJLeftSfBv8SIkw+JJkNv8tie11jL1d0
         GT9pw4Y8AAMYA==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 3/5] modpost: simplify mod->name allocation
Date:   Tue, 24 May 2022 01:46:24 +0900
Message-Id: <20220523164626.858340-3-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220523164626.858340-1-masahiroy@kernel.org>
References: <20220523164626.858340-1-masahiroy@kernel.org>
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

The current code blindly chops the suffix

    tmp[strlen(tmp) - 2] = '\0'

but it will cause buffer under-run if strlen(tmp) < 2;

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 25 ++++++++++++-------------
 1 file changed, 12 insertions(+), 13 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 843c64eebe8b..77c315dea1a3 100644
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
@@ -2022,16 +2023,14 @@ static void read_symbols(const char *modname)
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
@@ -2493,7 +2492,7 @@ static void read_dump(const char *fname)
 
 		mod = find_module(modname);
 		if (!mod) {
-			mod = new_module(modname);
+			mod = new_module(modname, strlen(modname));
 			mod->from_dump = true;
 		}
 		s = sym_add_exported(symname, mod, gpl_only);
-- 
2.32.0

