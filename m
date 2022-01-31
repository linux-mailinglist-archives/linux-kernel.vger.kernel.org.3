Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D75B4A4DF6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:23:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350447AbiAaSXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:23:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349447AbiAaSWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:22:41 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82361C061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:22:41 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id g15-20020a9d6b0f000000b005a062b0dc12so13825421otp.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:22:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CCzMOkXflHmWMxX1XPAY7nKtPtpcp9g4eQAqLH2YIns=;
        b=cVK8q8IqPDBCtC4ivwSc3NI0vzhHzduPJmRPfeneeNFUbDsICRd+mkaStOSPBXhwS7
         Yx81OYIDDpFzjBTNOXUaGn/MCdv/wSm3v8jx2LYnh3iCrOLoYMgisLM9s0zDdt3XYU0v
         2+XHQyESKt6wXm0aFMHt1OxQBc5j1k0lnSxg2K2pmNugaNF/xBDjvMtxNwe8W25DoE5N
         HICPrAY5HXD+8fEfd3JVjEYXTgPSLkCAZWBw5gJQVhkwuRhuCECPzoVpuJWoJjbjFfGf
         bCWDU4WTLWSkNE1aquajGR2doEYuqN9JQ1XvjyD3VEgq6EyAfhfFbS2mcsffA4xD6Qu4
         SBsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=CCzMOkXflHmWMxX1XPAY7nKtPtpcp9g4eQAqLH2YIns=;
        b=mf16P1DBmowaOLHPzME3p9jnznH/EAPcUoJCgBUg3Ldn3l3izbLv3J6Hj/Sh2hVObs
         8idFc3rjtucXOjV4byu+hOV8sNxdNylf3+xuCsFuiJyreXYG2mVOjb+nDNGZ0cbeisw0
         s1RTUWqk8x0QnWTh4uFEXehd5yBdKN5wgKLbZfaP9gPPBlQr1XJIO/wW6AD2EUlBM1zx
         Fvy4lEIWr9l7cQq247UkhlF36VwUJDgUhxa7P8o4RBo98kK4s2wVQ433WPV2OA0cdwdD
         B5xIs83OtonPhgGW/zhmZAiQn3iJ0iWuBLgRA5YS6khTmrHAuTCEEV7xeR9a2PQamviR
         bxOg==
X-Gm-Message-State: AOAM533JH859ZGS9r3VW2lm+KHEAhxxpIjcnQmZj9taURI8lGzT6DHGT
        ZVd14xLo6QkHhYeljq0Pumc=
X-Google-Smtp-Source: ABdhPJyINXPwfY18wwXLDqhZ/f1W5qGuM2/i1IID9PGprXPfceL3GeaWq/hfJyqgBqtWWKNNWrltLA==
X-Received: by 2002:a05:6830:30b6:: with SMTP id g22mr12237496ots.122.1643653360912;
        Mon, 31 Jan 2022 10:22:40 -0800 (PST)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id t4sm12986340oie.14.2022.01.31.10.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 10:22:40 -0800 (PST)
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
Subject: [PATCH v1 7/7] riscv: kernel/modules.c simplification
Date:   Mon, 31 Jan 2022 19:21:45 +0100
Message-Id: <20220131182145.236005-8-kernel@esmil.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220131182145.236005-1-kernel@esmil.dk>
References: <20220131182145.236005-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 arch/riscv/kernel/module.c | 93 ++++++++++++++++----------------------
 1 file changed, 39 insertions(+), 54 deletions(-)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 2212d88776e0..e371977aecfd 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -298,24 +298,23 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 		       unsigned int symindex, unsigned int relsec,
 		       struct module *me)
 {
-	Elf_Rela *rel = (void *) sechdrs[relsec].sh_addr;
-	int (*handler)(struct module *me, void *location, Elf_Addr v);
-	Elf_Sym *sym;
-	void *location;
-	unsigned int i, type;
-	Elf_Addr v;
-	int res;
+	Elf_Rela *rel = (void *)sechdrs[relsec].sh_addr;
+	unsigned int entries = sechdrs[relsec].sh_size / sizeof(*rel);
+	unsigned int i;
 
 	pr_debug("Applying relocate section %u to %u\n", relsec,
 	       sechdrs[relsec].sh_info);
 
-	for (i = 0; i < sechdrs[relsec].sh_size / sizeof(*rel); i++) {
-		/* This is where to make the change */
-		location = (void *)sechdrs[sechdrs[relsec].sh_info].sh_addr
-			+ rel[i].r_offset;
-		/* This is the symbol it is referring to */
-		sym = (Elf_Sym *)sechdrs[symindex].sh_addr
+	for (i = 0; i < entries; i++) {
+		Elf_Sym *sym = (Elf_Sym *)sechdrs[symindex].sh_addr
 			+ ELF_RISCV_R_SYM(rel[i].r_info);
+		Elf_Addr loc = sechdrs[sechdrs[relsec].sh_info].sh_addr
+			+ rel[i].r_offset;
+		unsigned int type = ELF_RISCV_R_TYPE(rel[i].r_info);
+		int (*handler)(struct module *me, void *location, Elf_Addr v);
+		Elf_Addr v;
+		int res;
+
 		if (IS_ERR_VALUE(sym->st_value)) {
 			/* Ignore unresolved weak symbol */
 			if (ELF_ST_BIND(sym->st_info) == STB_WEAK)
@@ -325,8 +324,6 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 			return -ENOENT;
 		}
 
-		type = ELF_RISCV_R_TYPE(rel[i].r_info);
-
 		if (type < ARRAY_SIZE(reloc_handlers_rela))
 			handler = reloc_handlers_rela[type];
 		else
@@ -343,48 +340,36 @@ int apply_relocate_add(Elf_Shdr *sechdrs, const char *strtab,
 		if (type == R_RISCV_PCREL_LO12_I || type == R_RISCV_PCREL_LO12_S) {
 			unsigned int j;
 
-			for (j = 0; j < sechdrs[relsec].sh_size / sizeof(*rel); j++) {
-				unsigned long hi20_loc =
-					sechdrs[sechdrs[relsec].sh_info].sh_addr
+			/* find the corresponding HI20 entry */
+			for (j = 0; j < entries; j++) {
+				Elf_Sym *hi20_sym = (Elf_Sym *)sechdrs[symindex].sh_addr
+					+ ELF_RISCV_R_SYM(rel[j].r_info);
+				Elf_Addr hi20_loc = sechdrs[sechdrs[relsec].sh_info].sh_addr
 					+ rel[j].r_offset;
-				u32 hi20_type = ELF_RISCV_R_TYPE(rel[j].r_info);
-
-				/* Find the corresponding HI20 relocation entry */
-				if (hi20_loc == sym->st_value
-				    && (hi20_type == R_RISCV_PCREL_HI20
-					|| hi20_type == R_RISCV_GOT_HI20)) {
-					s32 hi20, lo12;
-					Elf_Sym *hi20_sym =
-						(Elf_Sym *)sechdrs[symindex].sh_addr
-						+ ELF_RISCV_R_SYM(rel[j].r_info);
-					unsigned long hi20_sym_val =
-						hi20_sym->st_value
-						+ rel[j].r_addend;
-
-					/* Calculate lo12 */
-					size_t offset = hi20_sym_val - hi20_loc;
-					if (IS_ENABLED(CONFIG_MODULE_SECTIONS)
-					    && hi20_type == R_RISCV_GOT_HI20) {
-						offset = module_emit_got_entry(
-							 me, hi20_sym_val);
-						offset = offset - hi20_loc;
-					}
-					hi20 = (offset + 0x800) & 0xfffff000;
-					lo12 = offset - hi20;
-					v = lo12;
-
-					break;
-				}
-			}
-			if (j == sechdrs[relsec].sh_size / sizeof(*rel)) {
-				pr_err(
-				  "%s: Can not find HI20 relocation information\n",
-				  me->name);
-				return -EINVAL;
+				unsigned int hi20_type = ELF_RISCV_R_TYPE(rel[j].r_info);
+
+				if (hi20_loc != sym->st_value ||
+						(hi20_type != R_RISCV_PCREL_HI20 &&
+						 hi20_type != R_RISCV_GOT_HI20))
+					continue;
+
+				/* calculate relative offset */
+				v = hi20_sym->st_value + rel[j].r_addend;
+
+				if (IS_ENABLED(CONFIG_MODULE_SECTIONS) &&
+						hi20_type == R_RISCV_GOT_HI20)
+					v = module_emit_got_entry(me, v);
+
+				v -= hi20_loc;
+				goto handle_reloc;
 			}
-		}
 
-		res = handler(me, location, v);
+			pr_err("%s: Cannot find HI20 relocation information\n",
+					me->name);
+			return -EINVAL;
+		}
+handle_reloc:
+		res = handler(me, (void *)loc, v);
 		if (res)
 			return res;
 	}
-- 
2.35.1

