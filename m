Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8694E4C2F91
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236285AbiBXP0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:26:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236219AbiBXPZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:25:58 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0350E22B961
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:25:23 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id qk11so5167416ejb.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zFC8RrMScueCrfbuzC7oMwjqoiodd5KWPoUO6iBs4zE=;
        b=P9rZ74f43/Rjcitt8roVzvprR/aM94XNNwRVYeBMvQ/DGIKdO/YRwGvZE5bPjiAGVJ
         7wSGKeQObBcYFKHLvZKseUmZ6f65JnRyaulYCnOWQQLTOlU9YC5Cb4S7qL1E5nRaWV5v
         1o8QSZETpMDY3DqZeCHG1NWXzHE6nStg3l5bdLPF36mBBPWwD6OA83uchpYqAvV87L5d
         m1r9vqNnVBX8wHoXeSY4zeU7c+oqEPwDypSJLZYXfarvMu2b0k8LoTjjo6zouhLdPk9t
         cA0SoEQsYdAKHcJ3vEkC2LvPYcF/UZqydktdfIkCracdHCYjJsq4Pz1qRYYF9hOlSGR1
         sSnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=zFC8RrMScueCrfbuzC7oMwjqoiodd5KWPoUO6iBs4zE=;
        b=Dolicz5xzaCBIF2eNPI/3XJZQA+uM2oOy4txipqJ9EYGQgffn4ad8cyit3UcGl6Cgp
         zXHol/e8NA1hj4HexOQ7yD0bK5lxymy89GSfVAwdOsknqNjR2uwIjx9Ozg6tEV9/pcL4
         QDCfHsD8CG+1JTwQTY9zN/CNJhdHfrnh8EByXfLxVS0g3MMJiJR/yt4egTNxB/58ayug
         9EZfV4Xzy8MedEcp/YyjpUjQd8wSppION17VmflrNKCbJJRUvmhTnfX3ou8Rgl+iA6pd
         i08J1lu/hlfBS3D2hcEZVSeeozBqK4OpfXjMou2JkrIiKUvyX9iSB8FfLgXLPBOi+/xI
         GRRA==
X-Gm-Message-State: AOAM533wHq3BngHC/DqiwcpVQ5Y5HCLgUsN/7iYlphzeM6eLk9Q7DlpE
        0MdnJUemrV4Etct4Ekx3vk8=
X-Google-Smtp-Source: ABdhPJxUseKMXbJF3jbI1BLU1twwDUjL/41Lrh42NnUGf0qAivjc9hNG77gdcKbTvefH8Hrz4eQKgQ==
X-Received: by 2002:a17:906:7852:b0:6ce:88f5:4dc9 with SMTP id p18-20020a170906785200b006ce88f54dc9mr2720606ejm.491.1645716321533;
        Thu, 24 Feb 2022 07:25:21 -0800 (PST)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id s11sm1509693edt.10.2022.02.24.07.25.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 07:25:21 -0800 (PST)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     linux-riscv@lists.infradead.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Alexandre Ghiti <alex@ghiti.fr>, linux-kernel@vger.kernel.org
Subject: [PATCH v3 5/8] riscv: Use asm/insn.h for module relocations
Date:   Thu, 24 Feb 2022 16:24:53 +0100
Message-Id: <20220224152456.493365-6-kernel@esmil.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220224152456.493365-1-kernel@esmil.dk>
References: <20220224152456.493365-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts the module relocations in kernel/module.c to use
asm/insn.h for instruction manipulation.

Also RISC-V has a number of instruction pairs to
generate 32bit immediates or jump/call offsets. Eg.:

	lui   rd, hi20
	addi  rd, rd, lo12

..where hi20 is the upper 20bits to load into register rd and lo12 is
the lower 12bits. However both immediates are interpreted as two's
complement signed values. Hence the old code calculates hi20 and lo12
for 32bit immediates imm like this:

	hi20 = (imm + 0x800) & 0xfffff000;
	lo12 = (imm - hi20) & 0xfff;

This patch simplifies it to:

	hi20 = (imm + 0x800) & 0xfffff000;
	lo12 = imm & 0xfff;

..which amounts to the same: imm - hi20 may be become
negative/underflow, but it doesn't change the lower 12 bits.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 arch/riscv/kernel/module.c | 139 +++++++++++++++----------------------
 1 file changed, 56 insertions(+), 83 deletions(-)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 8d6a16d74b5b..2212d88776e0 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -2,6 +2,7 @@
 /*
  *
  *  Copyright (C) 2017 Zihao Yu
+ *  Copyright (C) 2020 Emil Renner Berthing
  */
 
 #include <linux/elf.h>
@@ -11,39 +12,27 @@
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
 #include <linux/pgtable.h>
+#include <asm/insn.h>
 #include <asm/sections.h>
 
-/*
- * The auipc+jalr instruction pair can reach any PC-relative offset
- * in the range [-2^31 - 2^11, 2^31 - 2^11)
- */
-static bool riscv_insn_valid_32bit_offset(ptrdiff_t val)
-{
-#ifdef CONFIG_32BIT
-	return true;
-#else
-	return (-(1L << 31) - (1L << 11)) <= val && val < ((1L << 31) - (1L << 11));
-#endif
-}
-
-static int riscv_insn_rmw(void *location, u32 keep, u32 set)
+static int riscv_insn_rmw(void *location, u32 mask, u32 value)
 {
 	u16 *parcel = location;
 	u32 insn = (u32)parcel[0] | (u32)parcel[1] << 16;
 
-	insn &= keep;
-	insn |= set;
+	insn &= ~mask;
+	insn |= value;
 
 	parcel[0] = insn;
 	parcel[1] = insn >> 16;
 	return 0;
 }
 
-static int riscv_insn_rvc_rmw(void *location, u16 keep, u16 set)
+static int riscv_insn_rvc_rmw(void *location, u16 mask, u16 value)
 {
 	u16 *parcel = location;
 
-	*parcel = (*parcel & keep) | set;
+	*parcel = (*parcel & ~mask) | value;
 	return 0;
 }
 
@@ -68,55 +57,40 @@ static int apply_r_riscv_branch_rela(struct module *me, void *location,
 				     Elf_Addr v)
 {
 	ptrdiff_t offset = (void *)v - location;
-	u32 imm12 = (offset & 0x1000) << (31 - 12);
-	u32 imm11 = (offset & 0x800) >> (11 - 7);
-	u32 imm10_5 = (offset & 0x7e0) << (30 - 10);
-	u32 imm4_1 = (offset & 0x1e) << (11 - 4);
 
-	return riscv_insn_rmw(location, 0x1fff07f, imm12 | imm11 | imm10_5 | imm4_1);
+	return riscv_insn_rmw(location,
+			      RISCV_INSN_B_IMM_MASK,
+			      riscv_insn_b_imm(offset));
 }
 
 static int apply_r_riscv_jal_rela(struct module *me, void *location,
 				  Elf_Addr v)
 {
 	ptrdiff_t offset = (void *)v - location;
-	u32 imm20 = (offset & 0x100000) << (31 - 20);
-	u32 imm19_12 = (offset & 0xff000);
-	u32 imm11 = (offset & 0x800) << (20 - 11);
-	u32 imm10_1 = (offset & 0x7fe) << (30 - 10);
 
-	return riscv_insn_rmw(location, 0xfff, imm20 | imm19_12 | imm11 | imm10_1);
+	return riscv_insn_rmw(location,
+			      RISCV_INSN_J_IMM_MASK,
+			      riscv_insn_j_imm(offset));
 }
 
 static int apply_r_riscv_rvc_branch_rela(struct module *me, void *location,
 					 Elf_Addr v)
 {
 	ptrdiff_t offset = (void *)v - location;
-	u16 imm8 = (offset & 0x100) << (12 - 8);
-	u16 imm7_6 = (offset & 0xc0) >> (6 - 5);
-	u16 imm5 = (offset & 0x20) >> (5 - 2);
-	u16 imm4_3 = (offset & 0x18) << (12 - 5);
-	u16 imm2_1 = (offset & 0x6) << (12 - 10);
-
-	return riscv_insn_rvc_rmw(location, 0xe383,
-			imm8 | imm7_6 | imm5 | imm4_3 | imm2_1);
+
+	return riscv_insn_rvc_rmw(location,
+				  RISCV_INSN_CB_IMM_MASK,
+				  riscv_insn_rvc_branch_imm(offset));
 }
 
 static int apply_r_riscv_rvc_jump_rela(struct module *me, void *location,
 				       Elf_Addr v)
 {
 	ptrdiff_t offset = (void *)v - location;
-	u16 imm11 = (offset & 0x800) << (12 - 11);
-	u16 imm10 = (offset & 0x400) >> (10 - 8);
-	u16 imm9_8 = (offset & 0x300) << (12 - 11);
-	u16 imm7 = (offset & 0x80) >> (7 - 6);
-	u16 imm6 = (offset & 0x40) << (12 - 11);
-	u16 imm5 = (offset & 0x20) >> (5 - 2);
-	u16 imm4 = (offset & 0x10) << (12 - 5);
-	u16 imm3_1 = (offset & 0xe) << (12 - 10);
-
-	return riscv_insn_rvc_rmw(location, 0xe003,
-			imm11 | imm10 | imm9_8 | imm7 | imm6 | imm5 | imm4 | imm3_1);
+
+	return riscv_insn_rvc_rmw(location,
+				  RISCV_INSN_CJ_IMM_MASK,
+				  riscv_insn_rvc_jump_imm(offset));
 }
 
 static int apply_r_riscv_pcrel_hi20_rela(struct module *me, void *location,
@@ -131,30 +105,27 @@ static int apply_r_riscv_pcrel_hi20_rela(struct module *me, void *location,
 		return -EINVAL;
 	}
 
-	return riscv_insn_rmw(location, 0xfff, (offset + 0x800) & 0xfffff000);
+	return riscv_insn_rmw(location,
+			      RISCV_INSN_U_IMM_MASK,
+			      riscv_insn_u_imm(offset + 0x800));
 }
 
 static int apply_r_riscv_pcrel_lo12_i_rela(struct module *me, void *location,
 					   Elf_Addr v)
 {
-	/*
-	 * v is the lo12 value to fill. It is calculated before calling this
-	 * handler.
-	 */
-	return riscv_insn_rmw(location, 0xfffff, (v & 0xfff) << 20);
+	/* v is already the relative offset */
+	return riscv_insn_rmw(location,
+			      RISCV_INSN_I_IMM_MASK,
+			      riscv_insn_i_imm(v));
 }
 
 static int apply_r_riscv_pcrel_lo12_s_rela(struct module *me, void *location,
 					   Elf_Addr v)
 {
-	/*
-	 * v is the lo12 value to fill. It is calculated before calling this
-	 * handler.
-	 */
-	u32 imm11_5 = (v & 0xfe0) << (31 - 11);
-	u32 imm4_0 = (v & 0x1f) << (11 - 4);
-
-	return riscv_insn_rmw(location, 0x1fff07f, imm11_5 | imm4_0);
+	/* v is already the relative offset */
+	return riscv_insn_rmw(location,
+			      RISCV_INSN_S_IMM_MASK,
+			      riscv_insn_s_imm(v));
 }
 
 static int apply_r_riscv_hi20_rela(struct module *me, void *location,
@@ -167,29 +138,27 @@ static int apply_r_riscv_hi20_rela(struct module *me, void *location,
 		return -EINVAL;
 	}
 
-	return riscv_insn_rmw(location, 0xfff, ((s32)v + 0x800) & 0xfffff000);
+	return riscv_insn_rmw(location,
+			      RISCV_INSN_U_IMM_MASK,
+			      riscv_insn_u_imm(v + 0x800));
 }
 
 static int apply_r_riscv_lo12_i_rela(struct module *me, void *location,
 				     Elf_Addr v)
 {
 	/* Skip medlow checking because of filtering by HI20 already */
-	s32 hi20 = ((s32)v + 0x800) & 0xfffff000;
-	s32 lo12 = ((s32)v - hi20);
-
-	return riscv_insn_rmw(location, 0xfffff, (lo12 & 0xfff) << 20);
+	return riscv_insn_rmw(location,
+			      RISCV_INSN_I_IMM_MASK,
+			      riscv_insn_i_imm(v));
 }
 
 static int apply_r_riscv_lo12_s_rela(struct module *me, void *location,
 				     Elf_Addr v)
 {
 	/* Skip medlow checking because of filtering by HI20 already */
-	s32 hi20 = ((s32)v + 0x800) & 0xfffff000;
-	s32 lo12 = ((s32)v - hi20);
-	u32 imm11_5 = (lo12 & 0xfe0) << (31 - 11);
-	u32 imm4_0 = (lo12 & 0x1f) << (11 - 4);
-
-	return riscv_insn_rmw(location, 0x1fff07f, imm11_5 | imm4_0);
+	return riscv_insn_rmw(location,
+			      RISCV_INSN_S_IMM_MASK,
+			      riscv_insn_s_imm(v));
 }
 
 static int apply_r_riscv_got_hi20_rela(struct module *me, void *location,
@@ -207,14 +176,15 @@ static int apply_r_riscv_got_hi20_rela(struct module *me, void *location,
 		return -EINVAL;
 	}
 
-	return riscv_insn_rmw(location, 0xfff, (offset + 0x800) & 0xfffff000);
+	return riscv_insn_rmw(location,
+			      RISCV_INSN_U_IMM_MASK,
+			      riscv_insn_u_imm(offset + 0x800));
 }
 
 static int apply_r_riscv_call_plt_rela(struct module *me, void *location,
 				       Elf_Addr v)
 {
 	ptrdiff_t offset = (void *)v - location;
-	u32 hi20, lo12;
 
 	if (!riscv_insn_valid_32bit_offset(offset)) {
 		/* Only emit the plt entry if offset over 32-bit range */
@@ -228,17 +198,18 @@ static int apply_r_riscv_call_plt_rela(struct module *me, void *location,
 		}
 	}
 
-	hi20 = (offset + 0x800) & 0xfffff000;
-	lo12 = (offset - hi20) & 0xfff;
-	riscv_insn_rmw(location, 0xfff, hi20);
-	return riscv_insn_rmw(location + 4, 0xfffff, lo12 << 20);
+	riscv_insn_rmw(location,
+		       RISCV_INSN_U_IMM_MASK,
+		       riscv_insn_u_imm(offset + 0x800));
+	return riscv_insn_rmw(location + 4,
+			      RISCV_INSN_I_IMM_MASK,
+			      riscv_insn_i_imm(offset));
 }
 
 static int apply_r_riscv_call_rela(struct module *me, void *location,
 				   Elf_Addr v)
 {
 	ptrdiff_t offset = (void *)v - location;
-	u32 hi20, lo12;
 
 	if (!riscv_insn_valid_32bit_offset(offset)) {
 		pr_err(
@@ -247,10 +218,12 @@ static int apply_r_riscv_call_rela(struct module *me, void *location,
 		return -EINVAL;
 	}
 
-	hi20 = (offset + 0x800) & 0xfffff000;
-	lo12 = (offset - hi20) & 0xfff;
-	riscv_insn_rmw(location, 0xfff, hi20);
-	return riscv_insn_rmw(location + 4, 0xfffff, lo12 << 20);
+	riscv_insn_rmw(location,
+		       RISCV_INSN_U_IMM_MASK,
+		       riscv_insn_u_imm(offset + 0x800));
+	return riscv_insn_rmw(location + 4,
+			      RISCV_INSN_I_IMM_MASK,
+			      riscv_insn_i_imm(offset));
 }
 
 static int apply_r_riscv_relax_rela(struct module *me, void *location,
-- 
2.35.1

