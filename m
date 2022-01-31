Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D436B4A4E45
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356415AbiAaS2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355177AbiAaS1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:27:54 -0500
Received: from mail-oo1-xc2d.google.com (mail-oo1-xc2d.google.com [IPv6:2607:f8b0:4864:20::c2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A31DC06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:27:54 -0800 (PST)
Received: by mail-oo1-xc2d.google.com with SMTP id r128-20020a4a4e86000000b002edb589161bso3413267ooa.9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:27:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6eMWCVmEcwxhKWA4X00yoLIXiWrdcmbrlYXjWFueDp8=;
        b=fECWMfmSx7xi9TWXcSID08QPIXmifjyjSOyTWkkpZydwLb+0iGj2OVdfTN9kqGxnL4
         ZwisFQHbTkiIWRmmRUN7aMJZI2ypu0HlXEf0Yxa3pHBQ2yvrs1+n0KrImqtU7sugMlUm
         ffUSKi1p5GDz4iIQP2YUCLcYEPiUeqhBW3rRLNtKs84i9snx3IXPZWHPSNJ4FWJjzcGV
         0Bo5NhsjO+dmTKFPGzTMTMyJCUDSCoXnXR/b3FC6yvpRx5C2KGu1Tr31tkYor3KHO3JI
         h9FjxKDNy1QLGUjEx7qo5L/Uyzc1xJpbvX231oOTZvr+j9JuiPcDG4yk7twyf9IgFd5s
         3yVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=6eMWCVmEcwxhKWA4X00yoLIXiWrdcmbrlYXjWFueDp8=;
        b=PhwK6muEzzlbCGuEujkwJPjOrfCjx9RcBJsh5IMRjQWf2b2N45ZzC1OF75CjG4Rjas
         bI+RQfF+tMpCSpBlxIzwWp3f3srLJOZC7JxV5Ay7LjYZrcJl/aR1kRw2Q6FG/xGLXH9J
         liwi6G+Ac3O7jB2ys0cwPpI7UuSTtoB2UyjYinKCm1H8XWDsEJ1+ck3nIbeZK0MNNLB9
         Cu6jWRlpkm/kI8mgwRAzu7wTdZ05TR5BqOzoKJm7/AGcgMwHSsa59FCpyWSpe8Z98AHv
         3LnCWFIKbnKefTBWlVT3WrPqrXEgMZ1r39sg78DQ8sfCnQEi4wLUzMy5cu+Y99rHAw4G
         aCTQ==
X-Gm-Message-State: AOAM533IWlKYd76VPDq515uI4bc73pdrY43gy+D2yhF4c/v2THkLeFgE
        HR85E277xKZUzdii0wqBxsQ=
X-Google-Smtp-Source: ABdhPJxf60k7BXEd9jZi8bgw6CW7udffRwf/L9FTLY5jFqF6Lj+OoBEEtJufFm1rQ2GdCrSmPEMeKA==
X-Received: by 2002:a4a:e0d8:: with SMTP id e24mr10794943oot.56.1643653673746;
        Mon, 31 Jan 2022 10:27:53 -0800 (PST)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id a26sm16041676oiy.26.2022.01.31.10.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 10:27:53 -0800 (PST)
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
Subject: [PATCH v2 4/7] riscv: Add asm/insn.h header
Date:   Mon, 31 Jan 2022 19:27:17 +0100
Message-Id: <20220131182720.236065-5-kernel@esmil.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220131182720.236065-1-kernel@esmil.dk>
References: <20220131182720.236065-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add new asm/insn.h header to consolidate RISC-V instruction constants
and inline helper functions.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 arch/riscv/include/asm/insn.h | 121 ++++++++++++++++++++++++++++++++++
 1 file changed, 121 insertions(+)
 create mode 100644 arch/riscv/include/asm/insn.h

diff --git a/arch/riscv/include/asm/insn.h b/arch/riscv/include/asm/insn.h
new file mode 100644
index 000000000000..2bdb089390f0
--- /dev/null
+++ b/arch/riscv/include/asm/insn.h
@@ -0,0 +1,121 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2020 Emil Renner Berthing
+ */
+#ifndef __ASM_RISCV_INSN_H
+#define __ASM_RISCV_INSN_H
+
+#include <linux/const.h>
+
+#define RISCV_INSN_LD		_AC(0x00003003, U)
+#define RISCV_INSN_ADDI		_AC(0x00000013, U)
+#define RISCV_INSN_NOP		RISCV_INSN_ADDI
+#define RISCV_INSN_AUIPC	_AC(0x00000017, U)
+#define RISCV_INSN_LUI		_AC(0x00000037, U)
+#define RISCV_INSN_JALR		_AC(0x00000067, U)
+#define RISCV_INSN_JAL		_AC(0x0000006f, U)
+
+#define RISCV_INSN_RA		_AC(0x1, U)
+#define RISCV_INSN_T0		_AC(0x5, U)
+#define RISCV_INSN_T1		_AC(0x6, U)
+
+#define RISCV_INSN_RD_POS	7
+#define RISCV_INSN_RD_RA	(RISCV_INSN_RA << RISCV_INSN_RD_POS)
+#define RISCV_INSN_RD_T0	(RISCV_INSN_T0 << RISCV_INSN_RD_POS)
+#define RISCV_INSN_RD_T1	(RISCV_INSN_T1 << RISCV_INSN_RD_POS)
+
+#define RISCV_INSN_RS1_POS	15
+#define RISCV_INSN_RS1_RA	(RISCV_INSN_RA << RISCV_INSN_RS1_POS)
+#define RISCV_INSN_RS1_T0	(RISCV_INSN_T0 << RISCV_INSN_RS1_POS)
+#define RISCV_INSN_RS1_T1	(RISCV_INSN_T1 << RISCV_INSN_RS1_POS)
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
+static inline bool riscv_insn_valid_20bit_offset(ptrdiff_t val)
+{
+	return !(val & 1) && -(1L << 19) <= val && val < (1L << 19);
+}
+
+static inline bool riscv_insn_valid_32bit_offset(ptrdiff_t val)
+{
+	if (IS_ENABLED(CONFIG_32BIT))
+		return true;
+
+	/*
+	 * auipc+jalr can reach any PC-relative offset in the range
+	 * [-2^31 - 2^11, 2^31 - 2^11)
+	 */
+	return (-(1L << 31) - (1L << 11)) <= val && val < ((1L << 31) - (1L << 11));
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

