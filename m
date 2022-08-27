Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27EB35A3956
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 19:57:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbiH0R4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 13:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbiH0R4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 13:56:24 -0400
Received: from xry111.site (xry111.site [IPv6:2001:470:683e::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BF8EA312
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 10:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
        s=default; t=1661622961;
        bh=Cy5JEnPKz+uW+QWU7fbJlNTXHrB/qYUsL6GTu0Jzp/Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PwPg5TKlaGWemvSDB9vCeTQeELlJIKL27iBTNUV/BgcGM4P1XejlnKwLRVKkdYZBV
         pACvZkYjzUP/bjYK19EbXjc/+EqZ1pRk67jQLneBT7oDv/XcQM0IlaVodJfk3vIVxJ
         rp09tMLT0p4Rb5qlMjbsM5Neh/f594MIfyyYFI7s=
Received: from xry111-x57s1.. (unknown [IPv6:240e:358:1157:dc00:dc73:854d:832e:4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
        (Client did not present a certificate)
        (Authenticated sender: xry111@xry111.site)
        by xry111.site (Postfix) with ESMTPSA id 0BE5066802;
        Sat, 27 Aug 2022 13:55:52 -0400 (EDT)
From:   Xi Ruoyao <xry111@xry111.site>
To:     loongarch@lists.linux.dev
Cc:     linux-kernel@vger.kernel.org, WANG Xuerui <kernel@xen0n.name>,
        Huacai Chen <chenhuacai@kernel.org>,
        Youling Tang <tangyouling@loongson.cn>,
        Jinyang He <hejinyang@loongson.cn>,
        Xi Ruoyao <xry111@xry111.site>
Subject: [PATCH 5/8] LoongArch: Support R_LARCH_ABS* in modules
Date:   Sun, 28 Aug 2022 01:54:33 +0800
Message-Id: <20220827175436.156464-6-xry111@xry111.site>
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

Binutils >= 2.40 uses R_LARCH_ABS* for relocations expanding "la.abs"
macro, instead of R_LARCH_PUSH_ABSOLUTE and other stack operations.
Handle R_LARCH_ABS* so we can load modules built with Binutils >= 2.40.

Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 arch/loongarch/kernel/module.c | 36 ++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/loongarch/kernel/module.c b/arch/loongarch/kernel/module.c
index e54df4717e4f..54be05c62145 100644
--- a/arch/loongarch/kernel/module.c
+++ b/arch/loongarch/kernel/module.c
@@ -313,6 +313,41 @@ static int apply_r_larch_b26(struct module *mod, u32 *location, Elf_Addr v,
 	return 0;
 }
 
+static int apply_r_larch_abs(struct module *mod, u32 *location, Elf_Addr v,
+			s64 *rela_stack, size_t *rela_stack_top, unsigned int type)
+{
+	union loongarch_instruction *insn = (union loongarch_instruction *)location;
+
+	switch (type) {
+	case R_LARCH_ABS_HI20:
+		v >>= 12;
+		break;
+	case R_LARCH_ABS64_LO20:
+		v >>= 32;
+		break;
+	case R_LARCH_ABS64_HI12:
+		v >>= 52;
+		break;
+	default:
+		/* Do nothing. */
+	}
+
+	switch (type) {
+	case R_LARCH_ABS_HI20:
+	case R_LARCH_ABS64_LO20:
+		insn->reg1i20_format.immediate = v & 0xfffff;
+		break;
+	case R_LARCH_ABS_LO12:
+	case R_LARCH_ABS64_HI12:
+		insn->reg2i12_format.immediate = v & 0xfff;
+		break;
+	default:
+		pr_err("%s: Unsupport relocation type %u\n", mod->name, type);
+		return -EINVAL;
+	}
+
+	return 0;
+}
 /*
  * reloc_handlers_rela() - Apply a particular relocation to a module
  * @mod: the module to apply the reloc to
@@ -343,6 +378,7 @@ static reloc_rela_handler reloc_rela_handlers[] = {
 	[R_LARCH_SOP_POP_32_S_10_5 ... R_LARCH_SOP_POP_32_U] = apply_r_larch_sop_imm_field,
 	[R_LARCH_ADD32 ... R_LARCH_SUB64]		     = apply_r_larch_add_sub,
 	[R_LARCH_B26]					     = apply_r_larch_b26,
+	[R_LARCH_ABS_HI20...R_LARCH_ABS64_HI12]		     = apply_r_larch_abs,
 };
 
 int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
-- 
2.37.0

