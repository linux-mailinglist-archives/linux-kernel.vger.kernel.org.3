Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D414A5A3955
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 19:57:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiH0R4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 13:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbiH0R40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 13:56:26 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392BFEEC6A
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 10:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1661622974;
        bh=D/xO81IDb2K17po/ppXxDCpbQzjp4AkgROc9wcYpui8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=B9+Xs5ty+niYC0SswmGljn7sE6xKUCS5Y4m/L0oxJYTX3ugIJRfYpHjvpQA/eJ/+U
         1b7ACzzCCvWb856iZI/DR6CLQFGlsAnkkKlJMa59Z1GY47GnCTuq9djUvaerdvhTgH
         ysmBPjobWIgKbb+1voxSGONlb1i79mVYim4hR91M=
Received: from xry111-x57s1.. (unknown [IPv6:240e:358:1157:dc00:dc73:854d:832e:4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 5043666801;
        Sat, 27 Aug 2022 13:56:07 -0400 (EDT)
From:   Xi Ruoyao <xry111@xry111.site>
To:     loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH 7/8] LoongArch: Support R_LARCH_PCALA* in modules
Date:   Sun, 28 Aug 2022 01:54:35 +0800
Message-Id: <20220827175436.156464-8-xry111@xry111.site>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220827175436.156464-1-xry111@xry111.site>
References: <20220827175436.156464-1-xry111@xry111.site>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_SUSPICIOUS_NTLD,
        PDS_OTHER_BAD_TLD,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC >= 13 and GNU assembler >= 2.40 use these relocations to address
local symbols, so we need to add them.

Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/loongarch/kernel/module.c | 43 ++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/loongarch/kernel/module.c b/arch/loongarch/kernel/module.c
index 54be05c62145..61ecd174dd03 100644
--- a/arch/loongarch/kernel/module.c
+++ b/arch/loongarch/kernel/module.c
@@ -348,6 +348,48 @@ static int apply_r_larch_abs(struct module *mod, u32 *location, Elf_Addr v,
 
 	return 0;
 }
+
+static int apply_r_larch_pcala(struct module *mod, u32 *location, Elf_Addr v,
+			s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
+{
+	union loongarch_instruction *insn = (union loongarch_instruction *)location;
+	/* Use s32 for a sign-extension deliberately. */
+	s32 offset_hi20 = (void *)((v + 0x800) & ~0xfff) -
+		(void *)((Elf_Addr)location & ~0xfff);
+	Elf_Addr anchor = (((Elf_Addr)location) & ~0xfff) + offset_hi20;
+	ptrdiff_t offset_rem = (void *)v - (void *)anchor;
+
+	switch (type) {
+	case R_LARCH_PCALA_HI20:
+		v = offset_hi20 >> 12;
+		break;
+	case R_LARCH_PCALA64_LO20:
+		v = offset_rem >> 32;
+		break;
+	case R_LARCH_PCALA64_HI12:
+		v = offset_rem >> 52;
+		break;
+	default:
+		/* Do nothing. */
+	}
+
+	switch (type) {
+	case R_LARCH_PCALA_HI20:
+	case R_LARCH_PCALA64_LO20:
+		insn->reg1i20_format.immediate = v & 0xfffff;
+		break;
+	case R_LARCH_PCALA_LO12:
+	case R_LARCH_PCALA64_HI12:
+		insn->reg2i12_format.immediate = v & 0xfff;
+		break;
+	default:
+		pr_err("%s: Unsupport relocation type %u\n", mod->name, type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /*
  * reloc_handlers_rela() - Apply a particular relocation to a module
  * @mod: the module to apply the reloc to
@@ -379,6 +421,7 @@ static reloc_rela_handler reloc_rela_handlers[] = {
 	[R_LARCH_ADD32 ... R_LARCH_SUB64]		     = apply_r_larch_add_sub,
 	[R_LARCH_B26]					     = apply_r_larch_b26,
 	[R_LARCH_ABS_HI20...R_LARCH_ABS64_HI12]		     = apply_r_larch_abs,
+	[R_LARCH_PCALA_HI20...R_LARCH_PCALA64_HI12]	     = apply_r_larch_pcala,
 };
 
 int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
-- 
2.37.0

