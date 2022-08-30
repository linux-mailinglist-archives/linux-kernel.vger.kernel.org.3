Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 583185A6123
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 12:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiH3Kua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 06:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230079AbiH3KuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 06:50:04 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CE9CBAB
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 03:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1661856597;
        bh=xwyA5+g8JSApQRoCXLyrCSM88yP+CbIqwJ7m9kBGWbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D7YaoPeCkFxnRz5OOFgWEZoCwM4CJCqL8pQE/qfNojMmI1zJAH8FaaDYnit54N7tc
         j/8gPc1fkftU8HXayzdnR5SbViZdnwJyo0XhqDhywEEbd9SgooISipSLk9wLqaVi0f
         qNMj/0wuLQs/cNHs2lZ9ZOAOykYHH5ROYK1xJAzY=
Received: from xry111-x57s1.. (unknown [IPv6:240e:358:11dd:1900:dc73:854d:832e:5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 36BBC660B9;
        Tue, 30 Aug 2022 06:49:52 -0400 (EDT)
From:   Xi Ruoyao <xry111@xry111.site>
To:     loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH v7 4/5] LoongArch: Support PC-relative relocations in modules
Date:   Tue, 30 Aug 2022 18:48:05 +0800
Message-Id: <20220830104806.128365-5-xry111@xry111.site>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20220830104806.128365-1-xry111@xry111.site>
References: <20220830104806.128365-1-xry111@xry111.site>
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

Binutils >= 2.40 uses R_LARCH_B26 instead of R_LARCH_SOP_PUSH_PLT_PCREL,
and R_LARCH_PCALA* instead of R_LARCH_SOP_PUSH_PCREL.

Handle R_LARCH_B26 and R_LARCH_PCALA* in the module loader.  For
R_LARCH_B26, also create a PLT entry as needed.

Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/loongarch/kernel/module-sections.c |  7 ++-
 arch/loongarch/kernel/module.c          | 67 +++++++++++++++++++++++++
 2 files changed, 73 insertions(+), 1 deletion(-)

diff --git a/arch/loongarch/kernel/module-sections.c b/arch/loongarch/kernel/module-sections.c
index 6d498288977d..c67b9cb220eb 100644
--- a/arch/loongarch/kernel/module-sections.c
+++ b/arch/loongarch/kernel/module-sections.c
@@ -56,9 +56,14 @@ static void count_max_entries(Elf_Rela *relas, int num, unsigned int *plts)
 
 	for (i = 0; i < num; i++) {
 		type = ELF_R_TYPE(relas[i].r_info);
-		if (type == R_LARCH_SOP_PUSH_PLT_PCREL) {
+		switch (type) {
+		case R_LARCH_SOP_PUSH_PLT_PCREL:
+		case R_LARCH_B26:
 			if (!duplicate_rela(relas, i))
 				(*plts)++;
+			break;
+		default:
+			/* Do nothing. */
 		}
 	}
 }
diff --git a/arch/loongarch/kernel/module.c b/arch/loongarch/kernel/module.c
index 755d91ef8d85..c09ddbe5ed8b 100644
--- a/arch/loongarch/kernel/module.c
+++ b/arch/loongarch/kernel/module.c
@@ -281,6 +281,71 @@ static int apply_r_larch_add_sub(struct module *mod, u32 *location, Elf_Addr v,
 	}
 }
 
+static int apply_r_larch_b26(struct module *mod, u32 *location, Elf_Addr v,
+			s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
+{
+	ptrdiff_t offset = (void *)v - (void *)location;
+	union loongarch_instruction *insn = (union loongarch_instruction *)location;
+
+	if (offset >= SZ_128M)
+		v = module_emit_plt_entry(mod, v);
+
+	if (offset < -SZ_128M)
+		v = module_emit_plt_entry(mod, v);
+
+	offset = (void *)v - (void *)location;
+
+	if (offset & 3) {
+		pr_err("module %s: jump offset = 0x%llx unaligned! dangerous R_LARCH_B26 (%u) relocation\n",
+				mod->name, (long long)offset, type);
+		return -ENOEXEC;
+	}
+
+	if (!signed_imm_check(offset, 28)) {
+		pr_err("module %s: jump offset = 0x%llx overflow! dangerous R_LARCH_B26 (%u) relocation\n",
+				mod->name, (long long)offset, type);
+		return -ENOEXEC;
+	}
+
+	offset >>= 2;
+	insn->reg0i26_format.immediate_l = offset & 0xffff;
+	insn->reg0i26_format.immediate_h = (offset >> 16) & 0x3ff;
+	return 0;
+}
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
+		insn->reg1i20_format.immediate = v & 0xfffff;
+		break;
+	case R_LARCH_PCALA64_LO20:
+		v = offset_rem >> 32;
+		insn->reg1i20_format.immediate = v & 0xfffff;
+		break;
+	case R_LARCH_PCALA64_HI12:
+		v = offset_rem >> 52;
+		/* fall through */
+	case R_LARCH_PCALA_LO12:
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
@@ -310,6 +375,8 @@ static reloc_rela_handler reloc_rela_handlers[] = {
 	[R_LARCH_SOP_SUB ... R_LARCH_SOP_IF_ELSE] 	     = apply_r_larch_sop,
 	[R_LARCH_SOP_POP_32_S_10_5 ... R_LARCH_SOP_POP_32_U] = apply_r_larch_sop_imm_field,
 	[R_LARCH_ADD32 ... R_LARCH_SUB64]		     = apply_r_larch_add_sub,
+	[R_LARCH_B26]					     = apply_r_larch_b26,
+	[R_LARCH_PCALA_HI20...R_LARCH_PCALA64_HI12]	     = apply_r_larch_pcala,
 };
 
 int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
-- 
2.37.0

