Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 986BE584D8F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235126AbiG2Imh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:42:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234710AbiG2Imb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:42:31 -0400
Received: from xry111.site (xry111.site [89.208.246.23])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E7DF580
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 01:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1659084150;
        bh=rcLqsq6zGpUEl1DJZyTxmkc4RA2vFFdgR8IfyXZm0Dc=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=P0njuex3OUTZGBSNK0zTohD3LhMK82QLrSm22A3Fq4aseIJ+EEcIfldV1HcV3CVNV
         MvxAVoeE+ZMlbNQd2yq9bgNr765SEQNUt38Zr80gZXvzCOnjEOoByUDQmtj+bzTz4u
         8QuR1ILvca3sE6zB8g6rbjSpdoOTKpsMr1sV2uzs=
Received: from localhost.localdomain (xry111.site [IPv6:2001:470:683e::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 6E53E667A1;
        Fri, 29 Jul 2022 04:42:28 -0400 (EDT)
Message-ID: <7fbcd23074e58117c6bcfbd832679de2386ff995.camel@xry111.site>
Subject: [PATCH v4 4/4] LoongArch: Support modules with new relocation types
From:   Xi Ruoyao <xry111@xry111.site>
To:     loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>
Date:   Fri, 29 Jul 2022 16:42:26 +0800
In-Reply-To: <32a74a218c76611f897fd1df1ad0059068621133.camel@xry111.site>
References: <32a74a218c76611f897fd1df1ad0059068621133.camel@xry111.site>
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

If GAS 2.40 and/or GCC 13 is used to build the kernel, the modules will
contain R_LARCH_B26, R_LARCH_PCALA_HI20, R_LARCH_PCALA_LO12,
R_LARCH_GOT_PC_HI20, and R_LARCH_GOT_PC_LO12 relocations.  Support them
in the module loader to allow a kernel built with latest toolchain
capable to load the modules.

Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/loongarch/include/asm/elf.h        | 37 +++++++++++
 arch/loongarch/kernel/module-sections.c | 12 +++-
 arch/loongarch/kernel/module.c          | 85 +++++++++++++++++++++++++
 3 files changed, 132 insertions(+), 2 deletions(-)

diff --git a/arch/loongarch/include/asm/elf.h b/arch/loongarch/include/asm/=
elf.h
index 5f3ff4781fda..7af0cebf28d7 100644
--- a/arch/loongarch/include/asm/elf.h
+++ b/arch/loongarch/include/asm/elf.h
@@ -74,6 +74,43 @@
 #define R_LARCH_SUB64				56
 #define R_LARCH_GNU_VTINHERIT			57
 #define R_LARCH_GNU_VTENTRY			58
+#define R_LARCH_B16				64
+#define R_LARCH_B21				65
+#define R_LARCH_B26				66
+#define R_LARCH_ABS_HI20			67
+#define R_LARCH_ABS_LO12			68
+#define R_LARCH_ABS64_LO20			69
+#define R_LARCH_ABS64_HI12			70
+#define R_LARCH_PCALA_HI20			71
+#define R_LARCH_PCALA_LO12			72
+#define R_LARCH_PCALA64_LO20			73
+#define R_LARCH_PCALA64_HI12			74
+#define R_LARCH_GOT_PC_HI20			75
+#define R_LARCH_GOT_PC_LO12			76
+#define R_LARCH_GOT64_PC_LO20			77
+#define R_LARCH_GOT64_PC_HI12			78
+#define R_LARCH_GOT_HI20			79
+#define R_LARCH_GOT_LO12			80
+#define R_LARCH_GOT64_LO20			81
+#define R_LARCH_GOT64_HI12			82
+#define R_LARCH_TLS_LE_HI20			83
+#define R_LARCH_TLS_LE_LO12			84
+#define R_LARCH_TLS_LE64_LO20			85
+#define R_LARCH_TLS_LE64_HI12			86
+#define R_LARCH_TLS_IE_PC_HI20			87
+#define R_LARCH_TLS_IE_PC_LO12			88
+#define R_LARCH_TLS_IE64_PC_LO20		89
+#define R_LARCH_TLS_IE64_PC_HI12		90
+#define R_LARCH_TLS_IE_HI20			91
+#define R_LARCH_TLS_IE_LO12			92
+#define R_LARCH_TLS_IE64_LO20			93
+#define R_LARCH_TLS_IE64_HI12			94
+#define R_LARCH_TLS_LD_PC_HI20			95
+#define R_LARCH_TLS_LD_HI20			96
+#define R_LARCH_TLS_GD_PC_HI20			97
+#define R_LARCH_TLS_GD_HI20			98
+#define R_LARCH_32_PCREL			99
+#define R_LARCH_RELAX				100
=20
 #ifndef ELF_ARCH
=20
diff --git a/arch/loongarch/kernel/module-sections.c b/arch/loongarch/kerne=
l/module-sections.c
index 36a77771d18c..8c0e4ad048cc 100644
--- a/arch/loongarch/kernel/module-sections.c
+++ b/arch/loongarch/kernel/module-sections.c
@@ -76,12 +76,20 @@ static void count_max_entries(Elf_Rela *relas, int num,
=20
 	for (i =3D 0; i < num; i++) {
 		type =3D ELF_R_TYPE(relas[i].r_info);
-		if (type =3D=3D R_LARCH_SOP_PUSH_PLT_PCREL) {
+		switch (type) {
+		case R_LARCH_SOP_PUSH_PLT_PCREL:
+		case R_LARCH_B26:
 			if (!duplicate_rela(relas, i))
 				(*plts)++;
-		} else if (type =3D=3D R_LARCH_SOP_PUSH_GPREL)
+			break;
+		case R_LARCH_SOP_PUSH_GPREL:
+		case R_LARCH_GOT_PC_HI20:
 			if (!duplicate_rela(relas, i))
 				(*gots)++;
+			break;
+		default:
+			/* Do nothing. */
+		}
 	}
 }
=20
diff --git a/arch/loongarch/kernel/module.c b/arch/loongarch/kernel/module.=
c
index 3ac4fbb5f109..c7b40150e1f0 100644
--- a/arch/loongarch/kernel/module.c
+++ b/arch/loongarch/kernel/module.c
@@ -291,6 +291,86 @@ static int apply_r_larch_add_sub(struct module *mod, u=
32 *location, Elf_Addr v,
 	}
 }
=20
+static int apply_r_larch_b26(struct module *mod, u32 *location, Elf_Addr v=
,
+			s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
+{
+	ptrdiff_t offset =3D (void *)v - (void *)location;
+	union loongarch_instruction *insn =3D (union loongarch_instruction *)loca=
tion;
+
+	if (offset >=3D SZ_128M)
+		v =3D module_emit_plt_entry(mod, v);
+
+	if (offset < -SZ_128M)
+		v =3D module_emit_plt_entry(mod, v);
+
+	offset =3D (void *)v - (void *)location;
+
+	if (offset & 3) {
+		pr_err("module %s: jump offset =3D 0x%llx unaligned! dangerous R_LARCH_B=
26 (%u) relocation\n",
+				mod->name, (long long)offset, type);
+		return -ENOEXEC;
+	}
+
+	if (!signed_imm_check(offset, 28)) {
+		pr_err("module %s: jump offset =3D 0x%llx overflow! dangerous R_LARCH_B2=
6 (%u) relocation\n",
+				mod->name, (long long)offset, type);
+		return -ENOEXEC;
+	}
+
+	offset >>=3D 2;
+	insn->reg0i26_format.immediate_l =3D offset & 0xffff;
+	insn->reg0i26_format.immediate_h =3D (offset >> 16) & 0x3ff;
+	return 0;
+}
+
+static int apply_r_larch_pcala_hi20(struct module *mod, u32 *location,
+		Elf_Addr v, s64 *rela_stack, size_t *rela_stack_top,
+		unsigned int type)
+{
+	ptrdiff_t offset =3D (void *)((v + 0x800) & ~0xfff) -
+		(void *)((Elf_Addr)location & ~0xfff);
+	union loongarch_instruction *insn =3D (union loongarch_instruction *)loca=
tion;
+
+	if (!signed_imm_check(offset, 32)) {
+		pr_err("module %s: PCALA offset =3D 0x%llx does not fit in 32-bit signed=
 and is unsupported by kernel! dangerous %s (%u) relocation\n",
+				mod->name, (long long)offset, __func__, type);
+		return -ENOEXEC;
+	}
+
+	insn->reg1i20_format.immediate =3D (offset >> 12) & 0xfffff;
+	return 0;
+}
+
+static int apply_r_larch_got_pc_hi20(struct module *mod, u32 *location,
+		Elf_Addr v, s64 *rela_stack, size_t *rela_stack_top,
+		unsigned int type)
+{
+	Elf_Addr got =3D module_emit_got_entry(mod, v);
+
+	return apply_r_larch_pcala_hi20(mod, location, got, rela_stack,
+			rela_stack_top, type);
+}
+
+static int apply_r_larch_pcala_lo12(struct module *mod, u32 *location,
+		Elf_Addr v, s64 *rela_stack, size_t *rela_stack_top,
+		unsigned int type)
+{
+	union loongarch_instruction *insn =3D (union loongarch_instruction *)loca=
tion;
+
+	insn->reg2i12_format.immediate =3D v & 0xfff;
+	return 0;
+}
+
+static int apply_r_larch_got_pc_lo12(struct module *mod, u32 *location,
+		Elf_Addr v, s64 *rela_stack, size_t *rela_stack_top,
+		unsigned int type)
+{
+	Elf_Addr got =3D module_emit_got_entry(mod, v);
+
+	return apply_r_larch_pcala_lo12(mod, location, got, rela_stack,
+			rela_stack_top, type);
+}
+
 /*
  * reloc_handlers_rela() - Apply a particular relocation to a module
  * @mod: the module to apply the reloc to
@@ -321,6 +401,11 @@ static reloc_rela_handler reloc_rela_handlers[] =3D {
 	[R_LARCH_SOP_SUB ... R_LARCH_SOP_IF_ELSE] 	     =3D apply_r_larch_sop,
 	[R_LARCH_SOP_POP_32_S_10_5 ... R_LARCH_SOP_POP_32_U] =3D apply_r_larch_so=
p_imm_field,
 	[R_LARCH_ADD32 ... R_LARCH_SUB64]		     =3D apply_r_larch_add_sub,
+	[R_LARCH_B26]					     =3D apply_r_larch_b26,
+	[R_LARCH_PCALA_HI20]				     =3D apply_r_larch_pcala_hi20,
+	[R_LARCH_PCALA_LO12]				     =3D apply_r_larch_pcala_lo12,
+	[R_LARCH_GOT_PC_HI20]				     =3D apply_r_larch_got_pc_hi20,
+	[R_LARCH_GOT_PC_LO12]				     =3D apply_r_larch_got_pc_lo12,
 };
=20
 int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
--=20
2.37.0


