Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 027AA4A6BB5
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 07:51:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244668AbiBBFxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 00:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244122AbiBBFxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 00:53:20 -0500
Received: from mail-ej1-x64a.google.com (mail-ej1-x64a.google.com [IPv6:2a00:1450:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72370C061714
        for <linux-kernel@vger.kernel.org>; Tue,  1 Feb 2022 21:53:20 -0800 (PST)
Received: by mail-ej1-x64a.google.com with SMTP id r18-20020a17090609d200b006a6e943d09eso7567567eje.20
        for <linux-kernel@vger.kernel.org>; Tue, 01 Feb 2022 21:53:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=YEcxhso9sKjwZhJ6R9y6hnaWvi7Bzl1Na0XtKw+cwWk=;
        b=fUSdWYOdHeKUeMgW6YkmBxSB/53js0/Xi9yPMPIeXKRuuprd68oDxxw8HXs56pmzJG
         TbGOtSyTeaMoteeqDmLO5y7xP36mECmU8T0tPomihYtHDMaGXXCkcWYOyUfUasPNi835
         kDXwHeG0kcsd3Cn/KKcZGwYPIkWPIroW53VaM1DC8BSncx9oeWZCe29sgii32Q7ug5mh
         u/0Ws5Jq/MiYnvh1cosoRQlgXMdK8sVbo/KwcYTdIh7dVj2F9LN3w5Ss57bUGk40JoT7
         qzUrnoNpR1o7tJSkKNk5bZ0w15/js/EiMbtt8yYzNZnBSHucZmO1n+E+sZakSLGPxv1l
         VlXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=YEcxhso9sKjwZhJ6R9y6hnaWvi7Bzl1Na0XtKw+cwWk=;
        b=QDMckJRRE4IxFvE8PzsYvoaFPTUvy64214h2Ps5/18irDo2gXiQEk6QM8/FbWIciD9
         KUO/5/mJFWqJNw6ciqg2kz/XetecNPDy5AFp5o4oTExcn7j6Vkps1eR1JwAH6Lj2rNTX
         /x3IxWtokpH6UTmv/wwAyJEell9nqkh7AnZl8rGXJX9LOeqS34RYCsu9ZXIBWoGNj+Xh
         NNQtxWGemer6IHwfxDHkV8PYD2Si7fB6NHgU09tE8Q70Z2Rt3boZOeLpaUgDR+5sRCAs
         JnbF7KhUWoQ6hZ7iFfZTv8BGWcDEVenG3MTkjDaIsDkitJ3ola3GN51X4Z/VcKl+VYDO
         FrGA==
X-Gm-Message-State: AOAM5331Fl/B7qvSWMcVLUjezZTuJqIUqri1znxM1G8ICSuX27NMHpZN
        ++gXoscTlIufr63wO8l0rZfrtSTMa6vY
X-Google-Smtp-Source: ABdhPJy+IHzyXutWJqA4hoUVM+uvXkIGkC09+jxx++EYw7o7QO1y6QxSCE62QHzHX7JdsiYBk8mn1cr2h8hxeQ==
X-Received: from wedsonaf2.lon.corp.google.com ([2a00:79e0:d:209:954b:6afb:eea6:ecc2])
 (user=wedsonaf job=sendgmr) by 2002:a50:ed16:: with SMTP id
 j22mr29245372eds.114.1643781198818; Tue, 01 Feb 2022 21:53:18 -0800 (PST)
Date:   Wed,  2 Feb 2022 05:51:23 +0000
Message-Id: <20220202055123.2144842-1-wedsonaf@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.0.rc2.247.g8bbb082509-goog
Subject: [PATCH] powerpc/module_64: use module_init_section instead of
 patching names
From:   Wedson Almeida Filho <wedsonaf@google.com>
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <wedsonaf@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Without this patch, module init sections are disabled by patching their
names in arch-specific code when they're loaded (which prevents code in
layout_sections from finding init sections). This patch uses the new
arch-specific module_init_section instead.

This allows modules that have .init_array sections to have the
initialisers properly called (on load, before init). Without this patch,
the initialisers are not called because .init_array is renamed to
_init_array, and thus isn't found by code in find_module_sections().

Signed-off-by: Wedson Almeida Filho <wedsonaf@google.com>
---
 arch/powerpc/kernel/module_64.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index 5d77d3f5fbb5..6a45e6ddbe58 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -277,6 +277,12 @@ static Elf64_Sym *find_dot_toc(Elf64_Shdr *sechdrs,
 	return NULL;
 }
 
+bool module_init_section(const char *name)
+{
+	/* We don't handle .init for the moment: always return false. */
+	return false;
+}
+
 int module_frob_arch_sections(Elf64_Ehdr *hdr,
 			      Elf64_Shdr *sechdrs,
 			      char *secstrings,
@@ -286,7 +292,6 @@ int module_frob_arch_sections(Elf64_Ehdr *hdr,
 
 	/* Find .toc and .stubs sections, symtab and strtab */
 	for (i = 1; i < hdr->e_shnum; i++) {
-		char *p;
 		if (strcmp(secstrings + sechdrs[i].sh_name, ".stubs") == 0)
 			me->arch.stubs_section = i;
 		else if (strcmp(secstrings + sechdrs[i].sh_name, ".toc") == 0) {
@@ -298,10 +303,6 @@ int module_frob_arch_sections(Elf64_Ehdr *hdr,
 			dedotify_versions((void *)hdr + sechdrs[i].sh_offset,
 					  sechdrs[i].sh_size);
 
-		/* We don't handle .init for the moment: rename to _init */
-		while ((p = strstr(secstrings + sechdrs[i].sh_name, ".init")))
-			p[0] = '_';
-
 		if (sechdrs[i].sh_type == SHT_SYMTAB)
 			dedotify((void *)hdr + sechdrs[i].sh_offset,
 				 sechdrs[i].sh_size / sizeof(Elf64_Sym),
-- 
2.35.0.rc2.247.g8bbb082509-goog

