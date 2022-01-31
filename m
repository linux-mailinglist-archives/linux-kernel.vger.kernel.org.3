Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 962984A4DF0
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347827AbiAaSWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347944AbiAaSWW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:22:22 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B902C06173B
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:22:22 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id r27so6143388oiw.4
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:22:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pFasC+wyxSnpAZ2usTdBEAt8b8vmkJCatL6gaFi2YnA=;
        b=X85EtuRVbP7VmY8U9w6XBemW3oyMbvOi6t+f+1/vlgaxSrZUBi++URa8FrZbl+rz9S
         2DH0pSVz3TZQZk3gHUgfeS8Peq37lvCmUkXrypyeOk5hshaATlpWFccU9AVoPYWOgMu4
         qqtyfAjRBnqak+I5eV5tXX+052rjOUd4oduGlu+e6KmsegV7tI9KDL2MqLP9cFD0kZIm
         wM/7qMBrFy3J4dPDZFxLOUZ3qadx+jQv1eAOo/p8ilxmb3YsqZdBSuEsLvg5k6u9fi8U
         tGR3UrhypNq5+kIdfJhrZemZ5oD8SOD3edfFIOEYJ3r5Kmr13TyKIz0VNDn3XaJBdrgD
         /dUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=pFasC+wyxSnpAZ2usTdBEAt8b8vmkJCatL6gaFi2YnA=;
        b=RBoDhNQh6aFu2alJRi2Jdfzzvqi91twNqOF48l/aUk3HiXa9svgelQLLAKl5s4BxVT
         lKNjLi2Th/wLL343OoioxEwOS5gt/lWUo4LGPaYR1vn8CaPUDjBwoxYTzJ7PSzQivoDz
         hMUWpEZ0T1jNNacID+Lbd83srhQyK07EQjPt5y5nKLKAERZv2hPNF9QxDmobSeTPyONW
         F5OlexXum/hcW7YbE10zGLVSeO8OahmIJ5URG5K6jEpvnvnGKrNmMHQ0slCfIDHavT+6
         fWDBvSN4AlsNkXvKmEgPVc4bByedTaKczYzxbwBaFjfnwObRjqUb8PbaexgF23QNpgs3
         smiw==
X-Gm-Message-State: AOAM531f9Se+0z93PjW389J6peKWdBOgOmyGNy3Fod4rFVt+Y1L7OdXN
        U48J7T/QnFGHEmkpMmP/9BA=
X-Google-Smtp-Source: ABdhPJyKFi+2vEaah3m+jVJTG6IWp7Pd6tL2mUk1usiWRVU22DVjJnMz9fCOUh2+KDMXrG6LUFUhsQ==
X-Received: by 2002:a05:6808:1890:: with SMTP id bi16mr15170985oib.307.1643653341692;
        Mon, 31 Jan 2022 10:22:21 -0800 (PST)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id t4sm12986340oie.14.2022.01.31.10.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 10:22:21 -0800 (PST)
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
Subject: [PATCH v1 2/7] riscv: Fix auipc+jalr relocation range checks
Date:   Mon, 31 Jan 2022 19:21:40 +0100
Message-Id: <20220131182145.236005-3-kernel@esmil.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220131182145.236005-1-kernel@esmil.dk>
References: <20220131182145.236005-1-kernel@esmil.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RISC-V can do PC-relative jumps with a 32bit range using the following
two instructions:

	auipc	t0, imm20	; t0 = PC + imm20 * 2^12
	jalr	ra, t0, imm12	; ra = PC + 4, PC = t0 + imm12,

Crucially both the 20bit immediate imm20 and the 12bit immediate imm12
are treated as two's-complement signed values. For this reason the
immediates are usually calculated like this:

	imm20 = (offset + 0x800) >> 12
	imm12 = offset & 0xfff

..where offset is the signed offset from the auipc instruction. When
the 11th bit of offset is 0 the addition of 0x800 doesn't change the top
20 bits and imm12 considered positive. When the 11th bit is 1 the carry
of the addition by 0x800 means imm20 is one higher, but since imm12 is
then considered negative the two's complement representation means it
all cancels out nicely.

However, this addition by 0x800 (2^11) means an offset greater than or
equal to 2^31 - 2^11 would overflow so imm20 is considered negative and
result in a backwards jump. Similarly the lower range of offset is also
moved down by 2^11 and hence the true 32bit range is

	[-2^31 - 2^11, 2^31 - 2^11)

Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
---
 arch/riscv/kernel/module.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 3d33442226e7..a75ccf3a6ce8 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -13,6 +13,18 @@
 #include <linux/pgtable.h>
 #include <asm/sections.h>
 
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
 static int riscv_insn_rmw(void *location, u32 keep, u32 set)
 {
 	u16 *parcel = location;
@@ -111,7 +123,7 @@ static int apply_r_riscv_pcrel_hi20_rela(struct module *me, void *location,
 {
 	ptrdiff_t offset = (void *)v - location;
 
-	if (offset != (s32)offset) {
+	if (!riscv_insn_valid_32bit_offset(offset)) {
 		pr_err(
 		  "%s: target %016llx can not be addressed by the 32-bit offset from PC = %p\n",
 		  me->name, (long long)v, location);
@@ -201,10 +213,9 @@ static int apply_r_riscv_call_plt_rela(struct module *me, void *location,
 				       Elf_Addr v)
 {
 	ptrdiff_t offset = (void *)v - location;
-	s32 fill_v = offset;
 	u32 hi20, lo12;
 
-	if (offset != fill_v) {
+	if (!riscv_insn_valid_32bit_offset(offset)) {
 		/* Only emit the plt entry if offset over 32-bit range */
 		if (IS_ENABLED(CONFIG_MODULE_SECTIONS)) {
 			offset = (void *)module_emit_plt_entry(me, v) - location;
@@ -226,10 +237,9 @@ static int apply_r_riscv_call_rela(struct module *me, void *location,
 				   Elf_Addr v)
 {
 	ptrdiff_t offset = (void *)v - location;
-	s32 fill_v = offset;
 	u32 hi20, lo12;
 
-	if (offset != fill_v) {
+	if (!riscv_insn_valid_32bit_offset(offset)) {
 		pr_err(
 		  "%s: target %016llx can not be addressed by the 32-bit offset from PC = %p\n",
 		  me->name, (long long)v, location);
-- 
2.35.1

