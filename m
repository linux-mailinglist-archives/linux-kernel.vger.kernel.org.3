Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 709E95A3957
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 19:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbiH0R4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 13:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiH0R4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 13:56:08 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A3BE8300
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 10:55:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1661622952;
        bh=cjqHborlmmsEk4gf/sTqVWHd8WMhLLWTrrXr/AzZ8d4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WNQcolyo/59aa31yB0oBuXSLCbohxLagmFeDYFKGeomtYN55IT5XJ12CMumt1gxGV
         uNgpdsotyBum247PQJUoyyBczP0qvyFI55UlnSjqgJQHUUgmX7ITLSkeGpfHzzNoh6
         FqhD8vxOxDnz5BrhVtdSB+WuqE0c52x0x6BobEgY=
Received: from xry111-x57s1.. (unknown [IPv6:240e:358:1157:dc00:dc73:854d:832e:4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 0315B66801;
        Sat, 27 Aug 2022 13:55:46 -0400 (EDT)
From:   Xi Ruoyao <xry111@xry111.site>
To:     loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH 4/8] LoongArch: Support R_LARCH_B26 in modules
Date:   Sun, 28 Aug 2022 01:54:32 +0800
Message-Id: <20220827175436.156464-5-xry111@xry111.site>
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

Binutils >= 2.40 uses R_LARCH_B26 for function calls with "bl"
instructions, instead of a pair of
R_LARCH_SOP_PUSH_PLT_PCREL and R_LARCH_SOP_POP_32_S_0_10_10_16_S2.
Handle R_LARCH_B26 in the module loader and create a PLT entry as
needed, so a modules can call functions in main kernel image if it's
built with Binutils >= 2.40.

Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/loongarch/kernel/module-sections.c |  7 +++++-
 arch/loongarch/kernel/module.c          | 33 +++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 1 deletion(-)

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
index 755d91ef8d85..e54df4717e4f 100644
--- a/arch/loongarch/kernel/module.c
+++ b/arch/loongarch/kernel/module.c
@@ -281,6 +281,38 @@ static int apply_r_larch_add_sub(struct module *mod, u32 *location, Elf_Addr v,
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
 /*
  * reloc_handlers_rela() - Apply a particular relocation to a module
  * @mod: the module to apply the reloc to
@@ -310,6 +342,7 @@ static reloc_rela_handler reloc_rela_handlers[] = {
 	[R_LARCH_SOP_SUB ... R_LARCH_SOP_IF_ELSE] 	     = apply_r_larch_sop,
 	[R_LARCH_SOP_POP_32_S_10_5 ... R_LARCH_SOP_POP_32_U] = apply_r_larch_sop_imm_field,
 	[R_LARCH_ADD32 ... R_LARCH_SUB64]		     = apply_r_larch_add_sub,
+	[R_LARCH_B26]					     = apply_r_larch_b26,
 };
 
 int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
-- 
2.37.0

