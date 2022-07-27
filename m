Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBB2C582BF0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 18:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239283AbiG0QkA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 12:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239463AbiG0QjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 12:39:16 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3035926A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1658939322;
        bh=Iwt8WdYsuC5jK4JTIRtEaA1Ad9D4kr5a9YoeDI0+3FU=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=ggUT3csrm6pEJ5Wmol1fudCE/EKG7wqnSEXfikmrzN+PId1w+FCAFt1KI5jXx5vR4
         EQZyhh27swq4ZjBoxFDDvhO+wRGLrlculT22SI0eE9uJGohhNj36eaiR7l3vP3UqnI
         kQtnSlTbcHEX26UpQspAh35ZnYqaKnIyHzJEXjN0=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 0E74266986;
        Wed, 27 Jul 2022 12:28:40 -0400 (EDT)
Message-ID: <99733532831377ab6585d43ee40bf314a2d4c5a3.camel@xry111.site>
Subject: [PATCH 3/5] LoongArch: Support relocation against
 _GLOBAL_OFFSET_TABLE_
From:   Xi Ruoyao <xry111@xry111.site>
To:     loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 28 Jul 2022 00:28:39 +0800
In-Reply-To: <385f63bcbee8e37c42f479ce9cdc7e7d731d419b.camel@xry111.site>
References: <385f63bcbee8e37c42f479ce9cdc7e7d731d419b.camel@xry111.site>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.3 
MIME-Version: 1.0
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With the stack-based relocations, the assembler emits three relocations
to push the PC-relative offset of a GOT entry:

    R_LARCH_SOP_PUSH_PCREL _GLOBAL_OFFSET_TABLE_
    R_LARCH_SOP_PUSH_GPREL foo
    R_LARCH_SOP_ADD

"_GLOBAL_OFFSET_TABLE_" does not really exist in the symtab and the BFD
linker handles it with special hack.  Implement a similar hack for
kernel so we will be able to really use R_LARCH_SOP_PUSH_GPREL
relocation.

Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/loongarch/kernel/module-sections.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/arch/loongarch/kernel/module-sections.c b/arch/loongarch/kerne=
l/module-sections.c
index 509c0b86b1e9..73976addbf60 100644
--- a/arch/loongarch/kernel/module-sections.c
+++ b/arch/loongarch/kernel/module-sections.c
@@ -89,6 +89,9 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr *s=
echdrs,
 			      char *secstrings, struct module *mod)
 {
 	unsigned int i, num_plts =3D 0, num_gots =3D 0;
+	Elf_Shdr *symtab =3D NULL;
+	Elf_Sym *symbols;
+	char *strings;
=20
 	/*
 	 * Find the empty .plt sections.
@@ -100,6 +103,8 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr =
*sechdrs,
 			mod->arch.plt_idx.shdr =3D sechdrs + i;
 		else if (!strcmp(secstrings + sechdrs[i].sh_name, ".got"))
 			mod->arch.got.shdr =3D sechdrs + i;
+		else if (sechdrs[i].sh_type =3D=3D SHT_SYMTAB)
+			symtab =3D sechdrs + i;
 	}
=20
 	if (!mod->arch.plt.shdr) {
@@ -115,6 +120,22 @@ int module_frob_arch_sections(Elf_Ehdr *ehdr, Elf_Shdr=
 *sechdrs,
 		return -ENOEXEC;
 	}
=20
+	if (!symtab) {
+		pr_err("%s: module symbol table missing\n", mod->name);
+		return -ENOEXEC;
+	}
+
+	symbols =3D (void *) ehdr + symtab->sh_offset;
+	strings =3D (void *) ehdr + sechdrs[symtab->sh_link].sh_offset;
+
+	for (i =3D 0; i < symtab->sh_size / sizeof(Elf_Sym); i++)
+		if (symbols[i].st_shndx =3D=3D SHN_UNDEF &&
+		    strcmp(strings + symbols[i].st_name,
+			   "_GLOBAL_OFFSET_TABLE_") =3D=3D 0) {
+			symbols[i].st_shndx =3D mod->arch.got.shdr - sechdrs;
+			symbols[i].st_value =3D 0;
+		}
+
 	/* Calculate the maxinum number of entries */
 	for (i =3D 0; i < ehdr->e_shnum; i++) {
 		int num_rela =3D sechdrs[i].sh_size / sizeof(Elf_Rela);
--=20
2.37.0


