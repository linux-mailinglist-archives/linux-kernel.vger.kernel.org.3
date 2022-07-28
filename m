Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728C7583E2B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236713AbiG1L74 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 07:59:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235732AbiG1L7z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 07:59:55 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A375691CD
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 04:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1659009591;
        bh=qVACV7bz4zGf1t3CnRp5Cj62T95tqtofD76Q2nBE43Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=XXHKtBMhzfQTjSB2WKW9ZpbxkEhzEZCCiGRXL7jeNJm7qnLQXvgv1nvwg2NEBYzMl
         pOBTsjrKoGSjDq5DlF63KUPFSmqXYcoteQW1Y4jTNlLfjhSuCVBPDrP9CGX7vhLUlF
         /7j/viIcj30zowF8dtRnS0inJWtUeyiKXi/urBDI=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 5346C6695D;
        Thu, 28 Jul 2022 07:59:50 -0400 (EDT)
Message-ID: <81c67c5f4c5f20fa5e6862f260884c61cafcaf93.camel@xry111.site>
Subject: [PATCH 2/4] LoongArch: Support R_LARCH_SOP_PUSH_GPREL relocation
 type in kernel module
From:   Xi Ruoyao <xry111@xry111.site>
To:     loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Date:   Thu, 28 Jul 2022 19:59:48 +0800
In-Reply-To: <c596e7a73953a1c49e8f5e94ec2db642f72e7813.camel@xry111.site>
References: <c596e7a73953a1c49e8f5e94ec2db642f72e7813.camel@xry111.site>
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
index 638427ff0d51..3ac4fbb5f109 100644
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
@@ -306,6 +316,7 @@ static reloc_rela_handler reloc_rela_handlers[] =3D {
 	[R_LARCH_SOP_PUSH_PCREL]			     =3D apply_r_larch_sop_push_pcrel,
 	[R_LARCH_SOP_PUSH_ABSOLUTE]			     =3D apply_r_larch_sop_push_absolute,
 	[R_LARCH_SOP_PUSH_DUP]				     =3D apply_r_larch_sop_push_dup,
+	[R_LARCH_SOP_PUSH_GPREL]			     =3D apply_r_larch_sop_push_gprel,
 	[R_LARCH_SOP_PUSH_PLT_PCREL]			     =3D apply_r_larch_sop_push_plt_pcrel,
 	[R_LARCH_SOP_SUB ... R_LARCH_SOP_IF_ELSE] 	     =3D apply_r_larch_sop,
 	[R_LARCH_SOP_POP_32_S_10_5 ... R_LARCH_SOP_POP_32_U] =3D apply_r_larch_so=
p_imm_field,
--=20
2.37.0


