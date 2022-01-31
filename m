Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB8C4A4E3F
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:27:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355254AbiAaS1s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:27:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355318AbiAaS1n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:27:43 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622DFC06173D
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:27:43 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id t199so11734064oie.10
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:27:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YCCLljOzkZTWVhp4UcnxVmYpwCgumhAeXuk5FTxJkB0=;
        b=HZ220OEWLABp3aSXvxPQNJay8YMq8judO11CWtgvZ1gyUaqL8ZYaudw7PMHX1V580g
         GnLIYZLGx8ohGTmZqFeiMGuxWkyzqIYWKO1yOdgweCylB5F7apPKMWg+2jbdBj1QBL4f
         QRhAFMHIY6iKV5heV2a92ydHpDNOqeSWaiLm1Rw/Mw+ukfv/7L3FRcS7lYzFLjERFhJ2
         iwY3FA4Yw55OFcZFnoAy7FkSGZz0yWbw9ooKFwXbqENn1d5FC/MZQPlQIf3P/WEEWmMf
         1luCJH36Asqiac3lcfPC1Ta9PpPS9elHcNxDORDJZqlYkNzvcx1CgAKYpKMrGE4XjEYo
         mcRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=YCCLljOzkZTWVhp4UcnxVmYpwCgumhAeXuk5FTxJkB0=;
        b=vuFM/aSM9wCp2PQkAhD8KsVoW7FE4JRdmk48Snd+FYf5QUWeq9zATnJj7V5sG935Tx
         55MiT129YvlV/gHwYDndayxLB0r2hJDrLn+DjHXcCMZrzDhegqLA+G2r6mOQmjgEO/1i
         dODMJIjKEmQWKKg3dDeCZzBnEy8xrjxjZCsPMMUk6qy+ulrZs/RftE5HTmXl1gtrV5xv
         pR4Zq/+LROLxTEd/CRuIKATKpPD+sR/MtvojHBlx9+BfCvBSHhm8phV8NMRrLs3H0PAI
         EIkaoIQaRVpINyFL1GEIGLF0iwD8ZDvlzVx+5QhQHJgnK2erdU2qTEccQQXfjPJKHPSi
         TCBg==
X-Gm-Message-State: AOAM533duueseuDNN9qMe862J+gq2AkfzT6Ra9VIBV8EQC/i9l8M53n6
        +ukGUKSEDMIzvSVu0bPY+Us=
X-Google-Smtp-Source: ABdhPJwKrM5CvEkYXnzGhb6PF6RnsL6qpETWKpCPSqV4wqkW4E6AQWHPesBXyiHuVEjJ+So+Z8fShg==
X-Received: by 2002:a05:6808:1897:: with SMTP id bi23mr6779955oib.217.1643653662815;
        Mon, 31 Jan 2022 10:27:42 -0800 (PST)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id a26sm16041676oiy.26.2022.01.31.10.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 10:27:42 -0800 (PST)
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
Subject: [PATCH v2 1/7] riscv: Remove unneeded definitions from asm/module.h
Date:   Mon, 31 Jan 2022 19:27:14 +0100
Message-Id: <20220131182720.236065-2-kernel@esmil.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220131182720.236065-1-kernel@esmil.dk>
References: <20220131182720.236065-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The inline functions previously defined here are only ever
used in kernel/module-sections.c, so there is no need to
include them in every user of asm/module.h. Through
linux/module.h this is just about every driver.

Now that these functions are static in a single file
remove the inline marker to allow the compiler to make
its own decisions.

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 arch/riscv/include/asm/module.h     | 87 ----------------------------
 arch/riscv/kernel/module-sections.c | 90 +++++++++++++++++++++++++++++
 2 files changed, 90 insertions(+), 87 deletions(-)

diff --git a/arch/riscv/include/asm/module.h b/arch/riscv/include/asm/module.h
index 76aa96a9fc08..570cd025f220 100644
--- a/arch/riscv/include/asm/module.h
+++ b/arch/riscv/include/asm/module.h
@@ -22,93 +22,6 @@ struct mod_arch_specific {
 	struct mod_section plt;
 	struct mod_section got_plt;
 };
-
-struct got_entry {
-	unsigned long symbol_addr;	/* the real variable address */
-};
-
-static inline struct got_entry emit_got_entry(unsigned long val)
-{
-	return (struct got_entry) {val};
-}
-
-static inline struct got_entry *get_got_entry(unsigned long val,
-					      const struct mod_section *sec)
-{
-	struct got_entry *got = (struct got_entry *)(sec->shdr->sh_addr);
-	int i;
-	for (i = 0; i < sec->num_entries; i++) {
-		if (got[i].symbol_addr == val)
-			return &got[i];
-	}
-	return NULL;
-}
-
-struct plt_entry {
-	/*
-	 * Trampoline code to real target address. The return address
-	 * should be the original (pc+4) before entring plt entry.
-	 */
-	u32 insn_auipc;		/* auipc t0, 0x0                       */
-	u32 insn_ld;		/* ld    t1, 0x10(t0)                  */
-	u32 insn_jr;		/* jr    t1                            */
-};
-
-#define OPC_AUIPC  0x0017
-#define OPC_LD     0x3003
-#define OPC_JALR   0x0067
-#define REG_T0     0x5
-#define REG_T1     0x6
-
-static inline struct plt_entry emit_plt_entry(unsigned long val,
-					      unsigned long plt,
-					      unsigned long got_plt)
-{
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
-	unsigned long offset = got_plt - plt;
-	u32 hi20 = (offset + 0x800) & 0xfffff000;
-	u32 lo12 = (offset - hi20);
-	return (struct plt_entry) {
-		OPC_AUIPC | (REG_T0 << 7) | hi20,
-		OPC_LD | (lo12 << 20) | (REG_T0 << 15) | (REG_T1 << 7),
-		OPC_JALR | (REG_T1 << 15)
-	};
-}
-
-static inline int get_got_plt_idx(unsigned long val, const struct mod_section *sec)
-{
-	struct got_entry *got_plt = (struct got_entry *)sec->shdr->sh_addr;
-	int i;
-	for (i = 0; i < sec->num_entries; i++) {
-		if (got_plt[i].symbol_addr == val)
-			return i;
-	}
-	return -1;
-}
-
-static inline struct plt_entry *get_plt_entry(unsigned long val,
-					      const struct mod_section *sec_plt,
-					      const struct mod_section *sec_got_plt)
-{
-	struct plt_entry *plt = (struct plt_entry *)sec_plt->shdr->sh_addr;
-	int got_plt_idx = get_got_plt_idx(val, sec_got_plt);
-	if (got_plt_idx >= 0)
-		return plt + got_plt_idx;
-	else
-		return NULL;
-}
-
 #endif /* CONFIG_MODULE_SECTIONS */
 
 #endif /* _ASM_RISCV_MODULE_H */
diff --git a/arch/riscv/kernel/module-sections.c b/arch/riscv/kernel/module-sections.c
index e264e59e596e..39d4ac681c2a 100644
--- a/arch/riscv/kernel/module-sections.c
+++ b/arch/riscv/kernel/module-sections.c
@@ -10,6 +10,28 @@
 #include <linux/module.h>
 #include <linux/moduleloader.h>
 
+struct got_entry {
+	unsigned long symbol_addr;	/* the real variable address */
+};
+
+static struct got_entry emit_got_entry(unsigned long val)
+{
+	return (struct got_entry) {val};
+}
+
+static struct got_entry *get_got_entry(unsigned long val,
+				       const struct mod_section *sec)
+{
+	struct got_entry *got = (struct got_entry *)(sec->shdr->sh_addr);
+	int i;
+
+	for (i = 0; i < sec->num_entries; i++) {
+		if (got[i].symbol_addr == val)
+			return &got[i];
+	}
+	return NULL;
+}
+
 unsigned long module_emit_got_entry(struct module *mod, unsigned long val)
 {
 	struct mod_section *got_sec = &mod->arch.got;
@@ -29,6 +51,74 @@ unsigned long module_emit_got_entry(struct module *mod, unsigned long val)
 	return (unsigned long)&got[i];
 }
 
+struct plt_entry {
+	/*
+	 * Trampoline code to real target address. The return address
+	 * should be the original (pc+4) before entring plt entry.
+	 */
+	u32 insn_auipc;		/* auipc t0, 0x0                       */
+	u32 insn_ld;		/* ld    t1, 0x10(t0)                  */
+	u32 insn_jr;		/* jr    t1                            */
+};
+
+#define OPC_AUIPC  0x0017
+#define OPC_LD     0x3003
+#define OPC_JALR   0x0067
+#define REG_T0     0x5
+#define REG_T1     0x6
+
+static struct plt_entry emit_plt_entry(unsigned long val,
+				       unsigned long plt,
+				       unsigned long got_plt)
+{
+	/*
+	 * U-Type encoding:
+	 * +------------+----------+----------+
+	 * | imm[31:12] | rd[11:7] | opc[6:0] |
+	 * +------------+----------+----------+
+	 *
+	 * I-Type encoding:
+	 * +------------+------------+--------+----------+----------+
+	 * | imm[31:20] | rs1[19:15] | funct3 | rd[11:7] | opc[6:0] |
+	 * +------------+------------+--------+----------+----------+
+	 *
+	 */
+	unsigned long offset = got_plt - plt;
+	u32 hi20 = (offset + 0x800) & 0xfffff000;
+	u32 lo12 = (offset - hi20);
+
+	return (struct plt_entry) {
+		OPC_AUIPC | (REG_T0 << 7) | hi20,
+		OPC_LD | (lo12 << 20) | (REG_T0 << 15) | (REG_T1 << 7),
+		OPC_JALR | (REG_T1 << 15)
+	};
+}
+
+static int get_got_plt_idx(unsigned long val, const struct mod_section *sec)
+{
+	struct got_entry *got_plt = (struct got_entry *)sec->shdr->sh_addr;
+	int i;
+
+	for (i = 0; i < sec->num_entries; i++) {
+		if (got_plt[i].symbol_addr == val)
+			return i;
+	}
+	return -1;
+}
+
+static struct plt_entry *get_plt_entry(unsigned long val,
+				       const struct mod_section *sec_plt,
+				       const struct mod_section *sec_got_plt)
+{
+	struct plt_entry *plt = (struct plt_entry *)sec_plt->shdr->sh_addr;
+	int got_plt_idx = get_got_plt_idx(val, sec_got_plt);
+
+	if (got_plt_idx >= 0)
+		return plt + got_plt_idx;
+	else
+		return NULL;
+}
+
 unsigned long module_emit_plt_entry(struct module *mod, unsigned long val)
 {
 	struct mod_section *got_plt_sec = &mod->arch.got_plt;
-- 
2.35.1

