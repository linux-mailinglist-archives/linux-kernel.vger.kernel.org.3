Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0224C2F90
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 16:26:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236249AbiBXP0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 10:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbiBXPZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 10:25:52 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E22FA22B95F
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:25:21 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id qk11so5167288ejb.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 07:25:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xb6ZbsBfJcNQTb4eFVxZ+eD4ollYnCaYaEUkZiE9buU=;
        b=XE4Mjw0oW6cyh7Jz/klql52/xhVYa6R3/iQA8JMo4UcXgDnA7XP/kt9VYeJjcct+TU
         fk4oaYlJrq1hov7+CB8pLoqAIyKv0UC2H25etYmgwtsr4WVP14vrICEZ5BgFFfFWU29e
         DRVioE05DadX6IfGCD+P7K9pHHkMrtzANp6NuKOWeHc+2ENGdJaGcli8AuoXXlB1/bpQ
         ue8hNGTE7Unql/nSYX95SRS1v2QRT9XD728n90NAVUHegHsCrZyyxhad61I3wI52C+m2
         rt5/9+PVIa8+J0vi43+bWyU1ZpJ1OzngNS/tZUF7gqylKf4z8jrPmMjCnhY9ny3/zBs/
         +ddQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=xb6ZbsBfJcNQTb4eFVxZ+eD4ollYnCaYaEUkZiE9buU=;
        b=vqqnlYdjUk9dxCUBPm3/bAqPiFnNYj7O1whlLnBwqdnHDDL+I2APRRzLVulhSeIm00
         l6+2mLOHCCsSafN4X7/ntbJ8fSVbIqXXXhVLfqzXNLwRw58YnJwaMcKEUmEKOP3OVnX8
         b+ypcAcQXJ+IlZzcGVds4l/sk+eGxNedWzv2rc4rbk0xixtYdyqTsAgim2TwsNfP9i8V
         N0V7J57ZZROw9zRt/FpG2o1NRcxMzQ94Zp2CJA78NfrIIVzEEEgmm+mAofIWanNAAPRZ
         sHdLG3NO007Pc9dAYpCbeHmN+xIqDh56Bfdtte3knY1qTEiUAiurpAeky/DU+zNq3ckV
         FAVA==
X-Gm-Message-State: AOAM530P6Xd/gA+y59n4PA70Xa1szBc9UcrzayYPsoTcldWT5x6jQp9V
        Q4bbYBSMsvtRyJ2OFQuHk8E=
X-Google-Smtp-Source: ABdhPJyal/+V9nN3rpbn43hnO657ZZ2qZJ/qzGLGOKSpxlqsaAfLg7zoK74dogk+Cxfnd6mQyPpG/Q==
X-Received: by 2002:a17:907:3c7:b0:6cd:5399:c1ad with SMTP id su7-20020a17090703c700b006cd5399c1admr2687583ejb.547.1645716320508;
        Thu, 24 Feb 2022 07:25:20 -0800 (PST)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id s11sm1509693edt.10.2022.02.24.07.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 07:25:20 -0800 (PST)
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
Subject: [PATCH v3 4/8] riscv: Add asm/insn.h header
Date:   Thu, 24 Feb 2022 16:24:52 +0100
Message-Id: <20220224152456.493365-5-kernel@esmil.dk>
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

Add new asm/insn.h header to consolidate RISC-V instruction constants
and inline helper functions.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 arch/riscv/include/asm/insn.h | 151 ++++++++++++++++++++++++++++++++++
 1 file changed, 151 insertions(+)
 create mode 100644 arch/riscv/include/asm/insn.h

diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
new file mode 100644
index 000000000000..02f387a06ef3
--- /dev/null
+++ b/arch/riscv/include/asm/insn.h
@@ -0,0 +1,151 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Emil Renner Berthing
+ */
+#ifndef __ASM_RISCV_INSN_H
+#define __ASM_RISCV_INSN_H
+
+#include <linux/const.h>
+
+#define RISCV_INSN_LW		_AC(0x00002003, U)
+#define RISCV_INSN_LD		_AC(0x00003003, U)
+#define RISCV_INSN_ADDI		_AC(0x00000013, U)
+#define RISCV_INSN_NOP		RISCV_INSN_ADDI
+#define RISCV_INSN_SW		_AC(0x00002023, U)
+#define RISCV_INSN_SD		_AC(0x00003023, U)
+#define RISCV_INSN_AUIPC	_AC(0x00000017, U)
+#define RISCV_INSN_LUI		_AC(0x00000037, U)
+#define RISCV_INSN_JALR		_AC(0x00000067, U)
+#define RISCV_INSN_JAL		_AC(0x0000006f, U)
+
+#if __riscv_xlen == 64
+#define RISCV_INSN_REG_L	RISCV_INSN_LD
+#define RISCV_INSN_REG_S	RISCV_INSN_SD
+#define RISCV_INSN_SZREG	8
+#elif __riscv_xlen == 32
+#define RISCV_INSN_REG_L	RISCV_INSN_LW
+#define RISCV_INSN_REG_S	RISCV_INSN_SW
+#define RISCV_INSN_SZREG	4
+#else
+#error "Unexpected __riscv_xlen"
+#endif
+
+#define RISCV_INSN_RA		_AC(0x1, U)
+#define RISCV_INSN_SP		_AC(0x2, U)
+#define RISCV_INSN_T0		_AC(0x5, U)
+#define RISCV_INSN_T1		_AC(0x6, U)
+
+#define RISCV_INSN_RD_POS	7
+#define RISCV_INSN_RD_RA	(RISCV_INSN_RA << RISCV_INSN_RD_POS)
+#define RISCV_INSN_RD_SP	(RISCV_INSN_SP << RISCV_INSN_RD_POS)
+#define RISCV_INSN_RD_T0	(RISCV_INSN_T0 << RISCV_INSN_RD_POS)
+#define RISCV_INSN_RD_T1	(RISCV_INSN_T1 << RISCV_INSN_RD_POS)
+
+#define RISCV_INSN_RS1_POS	15
+#define RISCV_INSN_RS1_RA	(RISCV_INSN_RA << RISCV_INSN_RS1_POS)
+#define RISCV_INSN_RS1_SP	(RISCV_INSN_SP << RISCV_INSN_RS1_POS)
+#define RISCV_INSN_RS1_T0	(RISCV_INSN_T0 << RISCV_INSN_RS1_POS)
+#define RISCV_INSN_RS1_T1	(RISCV_INSN_T1 << RISCV_INSN_RS1_POS)
+
+#define RISCV_INSN_RS2_POS	20
+#define RISCV_INSN_RS2_RA	(RISCV_INSN_RA << RISCV_INSN_RS2_POS)
+#define RISCV_INSN_RS2_SP	(RISCV_INSN_SP << RISCV_INSN_RS2_POS)
+#define RISCV_INSN_RS2_T0	(RISCV_INSN_T0 << RISCV_INSN_RS2_POS)
+#define RISCV_INSN_RS2_T1	(RISCV_INSN_T1 << RISCV_INSN_RS2_POS)
+
+#define RISCV_INSN_I_IMM_MASK	_AC(0xfff00000, U)
+#define RISCV_INSN_S_IMM_MASK	_AC(0xfe000f80, U)
+#define RISCV_INSN_B_IMM_MASK	_AC(0xfe000f80, U)
+#define RISCV_INSN_U_IMM_MASK	_AC(0xfffff000, U)
+#define RISCV_INSN_J_IMM_MASK	_AC(0xfffff000, U)
+
+#define RISCV_INSN_CI_IMM_MASK	_AC(0x107c, U)
+#define RISCV_INSN_CSS_IMM_MASK	_AC(0x1f80, U)
+#define RISCV_INSN_CIW_IMM_MASK	_AC(0x1fe0, U)
+#define RISCV_INSN_CL_IMM_MASK	_AC(0x1c60, U)
+#define RISCV_INSN_CS_IMM_MASK	_AC(0x1c60, U)
+#define RISCV_INSN_CB_IMM_MASK	_AC(0x1c7c, U)
+#define RISCV_INSN_CJ_IMM_MASK	_AC(0x1ffc, U)
+
+#ifndef __ASSEMBLY__
+#include <linux/bits.h>
+#include <asm/types.h>
+
+/*
+ * The J-format jump and link instruction, jal, has a 20bit immediate except
+ * bit 0 is always taken to be 0, so it must be even and is interpreted as a
+ * signed value.
+ */
+static inline bool riscv_insn_valid_20bit_offset(ptrdiff_t val)
+{
+	return !(val & 1) && -(1L << 19) <= val && val < (1L << 19);
+}
+
+/*
+ * The auipc+jalr instruction pair can reach any PC-relative offset
+ * in the range [-2^31 - 2^11, 2^31 - 2^11)
+ */
+static inline bool riscv_insn_valid_32bit_offset(ptrdiff_t val)
+{
+#if __riscv_xlen == 32
+	return true;
+#else
+	return (-(1L << 31) - (1L << 11)) <= val && val < ((1L << 31) - (1L << 11));
+#endif
+}
+
+static inline u32 riscv_insn_i_imm(u32 imm)
+{
+	return (imm & GENMASK(11, 0)) << 20;
+}
+
+static inline u32 riscv_insn_s_imm(u32 imm)
+{
+	return (imm & GENMASK( 4, 0)) << ( 7 - 0) |
+	       (imm & GENMASK(11, 5)) << (25 - 5);
+}
+
+static inline u32 riscv_insn_b_imm(u32 imm)
+{
+	return (imm & GENMASK(11, 11)) >> (11 -  7) |
+	       (imm & GENMASK( 4,  1)) << ( 8 -  1) |
+	       (imm & GENMASK(10,  5)) << (25 -  5) |
+	       (imm & GENMASK(12, 12)) << (31 - 12);
+}
+
+static inline u32 riscv_insn_u_imm(u32 imm)
+{
+	return imm & GENMASK(31, 12);
+}
+
+static inline u32 riscv_insn_j_imm(u32 imm)
+{
+	return (imm & GENMASK(19, 12)) << (12 - 12) |
+	       (imm & GENMASK(11, 11)) << (20 - 11) |
+	       (imm & GENMASK(10,  1)) << (21 -  1) |
+	       (imm & GENMASK(20, 20)) << (31 - 20);
+}
+
+static inline u16 riscv_insn_rvc_branch_imm(u16 imm)
+{
+	return (imm & GENMASK(5, 5)) >> ( 5 - 2) |
+	       (imm & GENMASK(2, 1)) << ( 3 - 1) |
+	       (imm & GENMASK(7, 6)) >> ( 6 - 5) |
+	       (imm & GENMASK(4, 3)) << (10 - 3) |
+	       (imm & GENMASK(8, 8)) << (12 - 8);
+}
+
+static inline u16 riscv_insn_rvc_jump_imm(u16 imm)
+{
+	return (imm & GENMASK( 5,  5)) >> ( 5 -  2) |
+	       (imm & GENMASK( 3,  1)) << ( 3 -  1) |
+	       (imm & GENMASK( 7,  7)) >> ( 7 -  6) |
+	       (imm & GENMASK( 6,  6)) << ( 7 -  6) |
+	       (imm & GENMASK(10, 10)) >> (10 -  8) |
+	       (imm & GENMASK( 9,  8)) << ( 9 -  8) |
+	       (imm & GENMASK( 4,  4)) << (11 -  4) |
+	       (imm & GENMASK(11, 11)) << (12 - 11);
+}
+
+#endif
+#endif
-- 
2.35.1

