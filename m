Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87F374A4E48
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356129AbiAaS2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:28:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356567AbiAaS2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:28:07 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FED8C061748
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:28:01 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id y23so28274913oia.13
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:28:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uv9kZcj+SYuMKmc2v8qVWQoeoD1xbOxuZhUO9LDOn7M=;
        b=ae2tEWK0mabJWBmBgb5+OPbZ4b4jy14di2q6CL9US53w3IQdvYKiJqQL97T2G1wDVb
         M50JwRAHj1f5EZbC/U8JiRH/KACoNyG/uqmAO3x6eKrJkOmt9gJi9U0ifS3seocUEW9r
         hyaY3Xg6rvhtptwS5T0dGbJAKZaAMebQ/Qc53ybw5n+gqM9uxnLXV6hHOkYDR5yGHFS7
         Z3ORY6td/UaqX8Ax1lYM1IDFFab8WZtPvgutSSoaqW4g7/FDPZPYTid+YrJa62DTXZUi
         MhsD7QtoIZwz6MtZUjbgf5vaNl0O/132oNzAS1fkOSz9QfYHQC+Lv79GFuYie5OG218Q
         wjZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=Uv9kZcj+SYuMKmc2v8qVWQoeoD1xbOxuZhUO9LDOn7M=;
        b=Q0npmfwGNdV2hwGAoGdksHLd3qzFRP1i75A2w5Z1sNV+kvOqgSmSppwsNeCjMiXDgZ
         1nMDwJrx32k7lfqsQDPFbZ7bxIVDiU7GPS9fuqFPPTpNzPaLtNb1hbCZLLET+oK2FrZT
         a0M7i5uR9b74PwXtNd0vegGKrl55NtIm3wCfn17LJPdqTIwg81cIAmc9bnqug9QU7g5K
         sT1I9QJ903u+fuO/UqM1QkLgu5YgRpeu7YZFFCLEnQYzhdOQgO+qZqm+0kZojHnF3rdp
         9c2JAT3OSj+WHcJ8zdECu93LynmWSGfPtJyFt163A7AD6d58MIOFgBbATkkvpzFdZ7aV
         Raug==
X-Gm-Message-State: AOAM532f8ZpsGo33wSmNt/+bcuQl5woEf2drxInjeonLvHTCnwXqSeD9
        PrSqGJBjFI3lA/TAAsEVi8Q=
X-Google-Smtp-Source: ABdhPJw/C4So3Aq1Zja1WakK5TxhFMU6yk7ULAS3F55FaGH/rIbSkWXxwvjmSKICqrUp4l6kNQa84Q==
X-Received: by 2002:aca:aa86:: with SMTP id t128mr13285285oie.169.1643653680913;
        Mon, 31 Jan 2022 10:28:00 -0800 (PST)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id a26sm16041676oiy.26.2022.01.31.10.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 10:28:00 -0800 (PST)
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
Subject: [PATCH v2 6/7] riscv: Use asm/insn.h to generate plt entries
Date:   Mon, 31 Jan 2022 19:27:19 +0100
Message-Id: <20220131182720.236065-7-kernel@esmil.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220131182720.236065-1-kernel@esmil.dk>
References: <20220131182720.236065-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This converts kernel/module-sections.c to use asm/insn.h to generate
the instructions in the plt entries.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 arch/riscv/kernel/module-sections.c | 27 ++++-----------------------
 1 file changed, 4 insertions(+), 23 deletions(-)

diff --git a/arch/riscv/kernel/module-sections.c b/arch/riscv/kernel/module-sections.c
index 39d4ac681c2a..cb73399c3603 100644
--- a/arch/riscv/kernel/module-sections.c
+++ b/arch/riscv/kernel/module-sections.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/moduleloader.h>
+#include <asm/insn.h>
 
 struct got_entry {
 	unsigned long symbol_addr;	/* the real variable address */
@@ -61,36 +62,16 @@ struct plt_entry {
 	u32 insn_jr;		/* jr    t1                            */
 };
 
-#define OPC_AUIPC  0x0017
-#define OPC_LD     0x3003
-#define OPC_JALR   0x0067
-#define REG_T0     0x5
-#define REG_T1     0x6
-
 static struct plt_entry emit_plt_entry(unsigned long val,
 				       unsigned long plt,
 				       unsigned long got_plt)
 {
-	/*
-	 * U-Type encoding:
-	 * +------------+----------+----------+
-	 * | imm[31:12] | rd[11:7] | opc[6:0] |
-	 * +------------+----------+----------+
-	 *
-	 * I-Type encoding:
-	 * +------------+------------+--------+----------+----------+
-	 * | imm[31:20] | rs1[19:15] | funct3 | rd[11:7] | opc[6:0] |
-	 * +------------+------------+--------+----------+----------+
-	 *
-	 */
 	unsigned long offset = got_plt - plt;
-	u32 hi20 = (offset + 0x800) & 0xfffff000;
-	u32 lo12 = (offset - hi20);
 
 	return (struct plt_entry) {
-		OPC_AUIPC | (REG_T0 << 7) | hi20,
-		OPC_LD | (lo12 << 20) | (REG_T0 << 15) | (REG_T1 << 7),
-		OPC_JALR | (REG_T1 << 15)
+		RISCV_INSN_AUIPC | RISCV_INSN_RD_T0 | riscv_insn_u_imm(offset + 0x800),
+		RISCV_INSN_LD    | RISCV_INSN_RD_T1 | RISCV_INSN_RS1_T0 | riscv_insn_i_imm(offset),
+		RISCV_INSN_JALR  | RISCV_INSN_RS1_T1,
 	};
 }
 
-- 
2.35.1

