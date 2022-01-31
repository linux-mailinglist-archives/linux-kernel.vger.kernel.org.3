Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294204A4E46
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356063AbiAaS2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:28:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355874AbiAaS16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:27:58 -0500
Received: from mail-oo1-xc34.google.com (mail-oo1-xc34.google.com [IPv6:2607:f8b0:4864:20::c34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE9F6C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:27:57 -0800 (PST)
Received: by mail-oo1-xc34.google.com with SMTP id t75-20020a4a3e4e000000b002e9c0821d78so3415406oot.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VzUOBCF2GRIbP/r2774p/6cI7x5/0EzMdeh+yBNP7rI=;
        b=W/MZ1pMibpaaH/NEFmtpq4FZh2hmJ/5ZDneTaK6q29s4W0wzELdHifv4kJ5gUwl371
         8beImFnShdYyg++HyKF4sM4UdzDWOA+L13Jo+AlKteTrLguBzu0HQaAMBX+ergX3wD/X
         0gCfRrxsOo7T7Wzapmz6vRyEdqmCH7T5mYNXncQZZcRiR+rulbDiX7rppD/l3QJ/ijd4
         +9k+zR1Qn8tmK6Fd4faX/u4mp1KKiZW/GcIbwh+uFRKqDYAIznlZBBthnsNjxKh/fuPi
         Pkw585pkzeu3EQUFSE6aYYBfqJsFi7Z6m5VsWORfZcWjNjXVaQ6lJWPAaB0am/Y7dPGZ
         JuHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=VzUOBCF2GRIbP/r2774p/6cI7x5/0EzMdeh+yBNP7rI=;
        b=05Gvjz8M2mNQiNZN0upYAA/n2XiILyAt2oZYw+NPho++gdhi6PmolezPcqAs0YtSGn
         w72ykbliyQ9D7cd2ImPCOBhqwKndiKtESkUzuv+aD1N5oeXO2ADj4Hq0ZdqQ4QUkNSFR
         B4JsfhtcnjmJVuFTnvOhtVjLoz6tja8+Npwj8MeJa9RC+YDIYfS9N5dyiTkMsnRujZWi
         aTwhsmjl/R6+6dWuMxVGAp37lFR2B5R+6etLKcUOqphISht+z4Hdng85NIwmNZbCd8kO
         cDgEKnFiw0tYwooqKdyFQfnlkSrr/c7LfaITF3Xs35MCh1bSgSvskq0g7Z4uRFWr3gUZ
         Wzyg==
X-Gm-Message-State: AOAM532SqMlYJJigB0csTxHs0oGy1CI8QMvGRdUjMbGvdOay1U35eUn2
        wDzMitra6O4latuNH6y8CE0=
X-Google-Smtp-Source: ABdhPJyopLmiqXJePWRxpLpjaT4YVXQthxB0f67V867ujjyucDDfJYsQoZ/Op1IiA7vf4hq5oJ/wJg==
X-Received: by 2002:a4a:c606:: with SMTP id l6mr11026387ooq.27.1643653677285;
        Mon, 31 Jan 2022 10:27:57 -0800 (PST)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id a26sm16041676oiy.26.2022.01.31.10.27.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 10:27:56 -0800 (PST)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     linux-riscv@lists.infradead.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Peter Zijlstra <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jason Baron <jbaron@akamai.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] riscv: Use asm/insn.h for module relocations
Date:   Mon, 31 Jan 2022 19:27:18 +0100
Message-Id: <20220131182720.236065-6-kernel@esmil.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220131182720.236065-1-kernel@esmil.dk>
References: <20220131182720.236065-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
 arch/riscv/kernel/module.c | 138 +++++++++++++++----------------------
 1 file changed, 56 insertions(+), 82 deletions(-)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index a75ccf3a6ce8..2212d88776e0 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -2,6 +2,7 @@
 /*
  *
  *  Copyright (C) 2017 Zihao Yu
+ *  Copyright (C) 2020 Emil Renner Berthing
  */
 
 #include <linux/elf.h>
@@ -11,38 +12,27 @@
 #include <linux/vmalloc.h>
 #include <linux/sizes.h>
 #include <linux/pgtable.h>
+#include <asm/insn.h>
 #include <asm/sections.h>
 
-static inline bool riscv_insn_valid_32bit_offset(ptrdiff_t val)
-{
-	if (IS_ENABLED(CONFIG_32BIT))
-		return true;
-
-	/*
-	 * auipc+jalr can reach any PC-relative offset in the range
-	 * [-2^31 - 2^11, 2^31 - 2^11)
-	 */
-	return (-(1L << 31) - (1L << 11)) <= val && val < ((1L << 31) - (1L << 11));
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
 
@@ -67,55 +57,40 @@ static int apply_r_riscv_branch_rela(struct module *me, void *location,
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
@@ -130,30 +105,27 @@ static int apply_r_riscv_pcrel_hi20_rela(struct module *me, void *location,
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
@@ -166,29 +138,27 @@ static int apply_r_riscv_hi20_rela(struct module *me, void *location,
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
@@ -206,14 +176,15 @@ static int apply_r_riscv_got_hi20_rela(struct module *me, void *location,
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
@@ -227,17 +198,18 @@ static int apply_r_riscv_call_plt_rela(struct module *me, void *location,
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
@@ -246,10 +218,12 @@ static int apply_r_riscv_call_rela(struct module *me, void *location,
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

