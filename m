Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF36F582BB4
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 18:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238961AbiG0QhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 12:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238347AbiG0QfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 12:35:19 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 328C356BB2
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1658939237;
        bh=w78BZb3/xqbgYQ+T36abwKpBBa08iLK+uJwtwbDSaKg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=HrXKGczgsN/yeNOdBYgBvIkK2za43JLopbFjIe09dStH7jCVaz901Wnmb3OlH8/HG
         dZ1f5HK6FVF06WYvVUwtGqx23jJwLaT21lZhoEGuo/HbfWGUVLy2vuwes/QSAkUXs3
         ep6P+ub1a17cbpCpEzrRQo7O7rqOdecgo/1byKao=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id EC28766986;
        Wed, 27 Jul 2022 12:27:15 -0400 (EDT)
Message-ID: <26cf3550ce5f6a02631da29361b3fcac30a598d9.camel@xry111.site>
Subject: [PATCH 2/5] LoongArch: Support R_LARCH_SOP_PUSH_GPREL relocation
 type in kernel module
From:   Xi Ruoyao <xry111@xry111.site>
To:     loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>
Date:   Thu, 28 Jul 2022 00:27:14 +0800
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

This relocation type pushes the offset of the GOT entry for a symbol
from the beginning of GOT into the relocation stack.  Our linker script
has initialized an empty GOT, so we need to create a new GOT entry if
there is no exist one for a symbol.

Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/loongarch/kernel/module.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/loongarch/kernel/module.c b/arch/loongarch/kernel/module.=
c
index 638427ff0d51..e5f1fd022cd0 100644
--- a/arch/loongarch/kernel/module.c
+++ b/arch/loongarch/kernel/module.c
@@ -122,6 +122,16 @@ static int apply_r_larch_sop_push_plt_pcrel(struct mod=
ule *mod, u32 *location, E
 	return apply_r_larch_sop_push_pcrel(mod, location, v, rela_stack, rela_st=
ack_top, type);
 }
=20
+static int apply_r_larch_sop_push_gprel(struct module *mod, u32 *location,
+			Elf_Addr v, s64 *rela_stack, size_t *rela_stack_top,
+			unsigned int type)
+{
+	Elf_Addr got =3D module_emit_got_entry(mod, v);
+	ptrdiff_t offset =3D (void *)got - (void *)mod->arch.got.shdr->sh_addr;
+
+	return rela_stack_push(offset, rela_stack, rela_stack_top);
+}
+
 static int apply_r_larch_sop(struct module *mod, u32 *location, Elf_Addr v=
,
 			s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
 {
@@ -310,6 +320,7 @@ static reloc_rela_handler reloc_rela_handlers[] =3D {
 	[R_LARCH_SOP_SUB ... R_LARCH_SOP_IF_ELSE] 	     =3D apply_r_larch_sop,
 	[R_LARCH_SOP_POP_32_S_10_5 ... R_LARCH_SOP_POP_32_U] =3D apply_r_larch_so=
p_imm_field,
 	[R_LARCH_ADD32 ... R_LARCH_SUB64]		     =3D apply_r_larch_add_sub,
+	[R_LARCH_SOP_PUSH_GPREL]			     =3D apply_r_larch_sop_push_gprel,
 };
=20
 int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
--=20
2.37.0


