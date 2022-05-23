Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7843531C1C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239190AbiEWQsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 12:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239093AbiEWQsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 12:48:35 -0400
Received: from conuserg-09.nifty.com (conuserg-09.nifty.com [210.131.2.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC32C633BA;
        Mon, 23 May 2022 09:48:28 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-09.nifty.com with ESMTP id 24NGlJD1027017;
        Tue, 24 May 2022 01:47:20 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-09.nifty.com 24NGlJD1027017
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1653324440;
        bh=lc+fo6j/ioCeXPDSmA+V4raO61i1wvnDNsz3Z956OcE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Ayr1gMhnatRU5ootEInfCpUCIbW2afVk+iyRM+8y94EqrZLNOHH41gN7boKNGI9+X
         /vdHbEgGeMzMrzQzSsqil4tuZ7IltBwR2Y33mbUsah7p4gku8aDqmK1BH+QfdtnXmD
         f3zqanazqXGRjg58LQsF6aYCQfJO1ZCswFQefAekniYtq4e9KZlO0TzNmgVpG/iyzh
         7s2irRYaV8SeMYn2z6nbt8ggP0Lde5MFnD0Cx47ouOCzgc8urZU7xDNm5u4tCd78L4
         98oTY5l0jmij2uBvY0FILUvpXtuzWKExJGwix5hqJtCANq8eyl5gBDjKIjGMhAOkoz
         nTkDHcnVT2qvg==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 2/5] modpost: remove the unused argument of check_sec_ref()
Date:   Tue, 24 May 2022 01:46:23 +0900
Message-Id: <20220523164626.858340-2-masahiroy@kernel.org>
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

check_sec_ref() does not use the first parameter 'mod'.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 845bc438ca49..843c64eebe8b 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -1883,8 +1883,7 @@ static void section_rel(const char *modname, struct elf_info *elf,
  * to find all references to a section that reference a section that will
  * be discarded and warns about it.
  **/
-static void check_sec_ref(struct module *mod, const char *modname,
-			  struct elf_info *elf)
+static void check_sec_ref(const char *modname, struct elf_info *elf)
 {
 	int i;
 	Elf_Shdr *sechdrs = elf->sechdrs;
@@ -2069,7 +2068,7 @@ static void read_symbols(const char *modname)
 					     sym_get_data(&info, sym));
 	}
 
-	check_sec_ref(mod, modname, &info);
+	check_sec_ref(modname, &info);
 
 	if (!mod->is_vmlinux) {
 		version = get_modinfo(&info, "version");
-- 
2.32.0

