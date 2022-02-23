Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 442F74C1B8D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 20:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244178AbiBWTOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 14:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbiBWTOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 14:14:00 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44A1931213
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:13:31 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id hw13so54227491ejc.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 11:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KvNxmsK7om4nL0g4ISMz7hk28jUTX9RGKaudCuq0JlY=;
        b=qvK/o2neNOE9fwRjjEgYLKlvcTiSSxUZMrznc5hxZwocp9ffqx2apCHysxGbeqGDi7
         mH+RG4Wjj0AtY3gnZi2ySafbFWXK1qtl3uDAYuuaI3zMn7bzqLJptTrtySFiPKJr90Md
         MmsNZNYMcgiWrabAktg9+MJENZ0B/SVsoZGG9GPaYZVoFsmG8DoLqgcb2LU1yWjIOwZI
         iw1j6PSOpeWkcOhC7wFGKT7V1f3yDEw42P14B7kB549S5la2deEY19Op8vpkieCxXUj+
         bJ6vl7EjMpwiogGguNzTckZRVTyDZspXb6NNEnAVuhl/6QYfj70OJ48w0GvhGigu2UiE
         da8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=KvNxmsK7om4nL0g4ISMz7hk28jUTX9RGKaudCuq0JlY=;
        b=a6RTmUhm2KbMIwmWHDKdrbQg993MyHp9euCLqajKVe5DwoFjTZJZ7hHh55F6UU0hYV
         XGJEOGPjb3IQFLQYDU3ylmnjKa2epRCbNyKrCE0TuUg77vdHK5ft7AwFit288rolm3TO
         ivhirUf9lha+t2VxMbO7x3tE40XnhgTzQmX7ZyHULkBEBaV8/lsNQubUUA7C/7+3FhCK
         EgP0bMkjNSZuL24pqYFxsddGOiL+7Sbzx34GvxA4NsxJfb0C2u69DQc9+F/RPVyCw4Hd
         lhMSqcQeuH/lBCz5OHK3P7MGeCm3dtW7ZmDuw/HrB088tUwmunaaj5nG/7YvjHEitvGx
         kMCw==
X-Gm-Message-State: AOAM530MuSPyX7J37lDtPlURgIPTnBIo2eWEa6e5ZXz0b8kAk+iNPZWK
        6QB5cEFq99UeXuIiFCvf8jw=
X-Google-Smtp-Source: ABdhPJyjtTfEFnQp3At+KO8m88JiOl5OJKsTdy/54iBndqcYTE66kpgLLNFrjFkUjL5zNNBDKQ4+ZA==
X-Received: by 2002:a17:906:8a5b:b0:6ce:2a05:813b with SMTP id gx27-20020a1709068a5b00b006ce2a05813bmr864005ejc.589.1645643609692;
        Wed, 23 Feb 2022 11:13:29 -0800 (PST)
Received: from stitch.. ([2a01:4262:1ab:c:6aa:aa1e:3637:3a48])
        by smtp.gmail.com with ESMTPSA id z22sm304172edd.45.2022.02.23.11.13.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 11:13:29 -0800 (PST)
Sender: Emil Renner Berthing <emil.renner.berthing@gmail.com>
From:   Emil Renner Berthing <kernel@esmil.dk>
To:     linux-riscv@lists.infradead.org
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>,
        Jisheng Zhang <jszhang@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: Fix auipc+jalr relocation range checks
Date:   Wed, 23 Feb 2022 20:12:57 +0100
Message-Id: <20220223191257.143694-1-kernel@esmil.dk>
X-Mailer: git-send-email 2.35.1
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

RISC-V can do PC-relative jumps with a 32bit range using the following
two instructions:

	auipc	t0, imm20	; t0 = PC + imm20 * 2^12
	jalr	ra, t0, imm12	; ra = PC + 4, PC = t0 + imm12

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
 arch/riscv/kernel/module.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/module.c b/arch/riscv/kernel/module.c
index 68a9e3d1fe16..4a48287513c3 100644
--- a/arch/riscv/kernel/module.c
+++ b/arch/riscv/kernel/module.c
@@ -13,6 +13,19 @@
 #include <linux/pgtable.h>
 #include <asm/sections.h>
 
+/*
+ * The auipc+jalr instruction pair can reach any PC-relative offset
+ * in the range [-2^31 - 2^11, 2^31 - 2^11)
+ */
+static bool riscv_insn_valid_32bit_offset(ptrdiff_t val)
+{
+#ifdef CONFIG_32BIT
+	return true;
+#else
+	return (-(1L << 31) - (1L << 11)) <= val && val < ((1L << 31) - (1L << 11));
+#endif
+}
+
 static int apply_r_riscv_32_rela(struct module *me, u32 *location, Elf_Addr v)
 {
 	if (v != (u32)v) {
@@ -95,7 +108,7 @@ static int apply_r_riscv_pcrel_hi20_rela(struct module *me, u32 *location,
 	ptrdiff_t offset = (void *)v - (void *)location;
 	s32 hi20;
 
-	if (offset != (s32)offset) {
+	if (!riscv_insn_valid_32bit_offset(offset)) {
 		pr_err(
 		  "%s: target %016llx can not be addressed by the 32-bit offset from PC = %p\n",
 		  me->name, (long long)v, location);
@@ -197,10 +210,9 @@ static int apply_r_riscv_call_plt_rela(struct module *me, u32 *location,
 				       Elf_Addr v)
 {
 	ptrdiff_t offset = (void *)v - (void *)location;
-	s32 fill_v = offset;
 	u32 hi20, lo12;
 
-	if (offset != fill_v) {
+	if (!riscv_insn_valid_32bit_offset(offset)) {
 		/* Only emit the plt entry if offset over 32-bit range */
 		if (IS_ENABLED(CONFIG_MODULE_SECTIONS)) {
 			offset = module_emit_plt_entry(me, v);
@@ -224,10 +236,9 @@ static int apply_r_riscv_call_rela(struct module *me, u32 *location,
 				   Elf_Addr v)
 {
 	ptrdiff_t offset = (void *)v - (void *)location;
-	s32 fill_v = offset;
 	u32 hi20, lo12;
 
-	if (offset != fill_v) {
+	if (!riscv_insn_valid_32bit_offset(offset)) {
 		pr_err(
 		  "%s: target %016llx can not be addressed by the 32-bit offset from PC = %p\n",
 		  me->name, (long long)v, location);
-- 
2.35.1

