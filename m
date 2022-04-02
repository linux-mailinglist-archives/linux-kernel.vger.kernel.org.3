Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BF0F4F01DD
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 15:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354894AbiDBNCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 09:02:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354867AbiDBNCw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 09:02:52 -0400
Received: from conuserg-11.nifty.com (conuserg-11.nifty.com [210.131.2.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0804913F20;
        Sat,  2 Apr 2022 06:00:59 -0700 (PDT)
Received: from grover.. (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-11.nifty.com with ESMTP id 232D0S3b030001;
        Sat, 2 Apr 2022 22:00:29 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-11.nifty.com 232D0S3b030001
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1648904430;
        bh=Hr0z8Jq2r4y/wTZlPQUO7u7pmOMOKaWWt9EOAuFI+cs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qProg9plOvQmbMAM1AXRBD+3AfhOemIyo3ZLmQBPHPYeXWlzuYUMwcXT2S/mKdrRI
         EuGTKefjiKr16CXBhDnjwM20RYf9jt/F/xwalcW1jshqi4oP1BQ0+hYAXY6VduFmkx
         qCLAPA+ih05zaziSBKF07YpDdg4/8U4IBCDcPwFa2iySJKCI6lFSSi3jyPYhVbvUhF
         +aQutHG/QaXEKKqcIF2BVlpfL3j2ZZEUpM7J2U7uMYDROvSffaUiVGMXvQh/gC2h6N
         A7nThDIOW4Yt6PDtPNRtFHHWf92LBtHDZBTay1cgaoor0uxTP4AzAMtRDc2SBCoBVk
         gUp9EOeMVtnhg==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 2/2] modpost: move export_from_secname() call to more relevant place
Date:   Sat,  2 Apr 2022 22:00:14 +0900
Message-Id: <20220402130014.1417773-2-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220402130014.1417773-1-masahiroy@kernel.org>
References: <20220402130014.1417773-1-masahiroy@kernel.org>
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

The value returned by export_from_secname() is only used by
sym_add_exported().

Move export_from_secname() just above sym_add_exported().

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 194ca9083c7a..f9e54247ae1d 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -684,12 +684,8 @@ static void handle_modversion(const struct module *mod,
 static void handle_symbol(struct module *mod, struct elf_info *info,
 			  const Elf_Sym *sym, const char *symname)
 {
-	enum export export;
 	const char *name;
 
-	if (strstarts(symname, "__ksymtab"))
-		export = export_from_secname(info, get_secindex(info, sym));
-
 	switch (sym->st_shndx) {
 	case SHN_COMMON:
 		if (strstarts(symname, "__gnu_lto_")) {
@@ -724,7 +720,11 @@ static void handle_symbol(struct module *mod, struct elf_info *info,
 	default:
 		/* All exported symbols */
 		if (strstarts(symname, "__ksymtab_")) {
+			enum export export;
+
 			name = symname + strlen("__ksymtab_");
+			export = export_from_secname(info,
+						     get_secindex(info, sym));
 			sym_add_exported(name, mod, export);
 		}
 		if (strcmp(symname, "init_module") == 0)
-- 
2.32.0

