Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6334A4E44
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355479AbiAaS15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:27:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355172AbiAaS1u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:27:50 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F3AC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:27:50 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id l12-20020a0568302b0c00b005a4856ff4ceso5702827otv.13
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 10:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pFasC+wyxSnpAZ2usTdBEAt8b8vmkJCatL6gaFi2YnA=;
        b=jpvQ12JqsAmFiYXikZczOVDw5Kt0XfkhYMBMzN6tcJTC0FJYu+eD55ciJJi5xu+xHK
         oVgSpKYqmmNFXvxtbjYbM7q1joXuoE3Rbh1bNsWsWRSdTybFgvZr7/NQfmMG4HtfKIKG
         /5rSVurc0tNqeuZZTrKFzuZb0N6M2N5YH3LWhKryCYuun0JxbvgkTp/58CgzctLUQ9B6
         3PeZ6hWRPyRORzvu2gB3By23xMKcv31tvbkcvFSp3LTWHOwTX6X9iFBc8vTyMnTaC4nW
         qDessmj1nBnuYWhbzRkklIq6ewo0Aih4AFMR1V3VMexgtpaNoequZrxlCHp2bLOm+J49
         5AzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=pFasC+wyxSnpAZ2usTdBEAt8b8vmkJCatL6gaFi2YnA=;
        b=Fm9G0hPhitK4Hg8WkequJEQyqZw6N76ddj+e9QDov6QHG0CaSfb0avRdnNhVwF2Ixs
         T0KnXcFIR8s0DsA8/shpK5sT0IXYV/5Y9QPDq4Zbkiapdk6LyMCaNLYD/EzCkuRK67El
         17GPcie/Uhr+GcsCGwhqRGuwzXMxr5UEsPZzKaZQL5AqQa7AsfYfWD700tQVjXN5of30
         Xu3y3zJ/WXB7sVg49rFtzo08TCR6jsjUKY8xARbCeNQsiQQACn0E8aH6/hw3pHj0w5d5
         D7e3v1TCYQL/FPYtPrB0gMmoi+C8wEDmoQrScLIzSJLhFGU11ham86G2KG4vnl5B4Gu9
         2V9A==
X-Gm-Message-State: AOAM531vGZvnPN6DnRlTx7OFhM/TAvxUPzRZFA3FuxqamHd156gJIW69
        8CgHrGB9S/Y4z9o5PZl+jn8=
X-Google-Smtp-Source: ABdhPJzBTaqANAdPoa+FjV2Ik3Mc6tUBsaq3/j7JGk9sEd6q1zJXozM9fiU3Tnt/9CFg85fhURwygA==
X-Received: by 2002:a9d:4e89:: with SMTP id v9mr12038860otk.177.1643653669852;
        Mon, 31 Jan 2022 10:27:49 -0800 (PST)
Received: from stitch.. (80.71.140.73.ipv4.parknet.dk. [80.71.140.73])
        by smtp.gmail.com with ESMTPSA id a26sm16041676oiy.26.2022.01.31.10.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 10:27:49 -0800 (PST)
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
Subject: [PATCH v2 3/7] riscv: Fix auipc+jalr relocation range checks
Date:   Mon, 31 Jan 2022 19:27:16 +0100
Message-Id: <20220131182720.236065-4-kernel@esmil.dk>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220131182720.236065-1-kernel@esmil.dk>
References: <20220131182720.236065-1-kernel@esmil.dk>
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

