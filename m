Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7914D2899
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 06:53:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiCIFyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 00:54:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiCIFyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 00:54:22 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A069025E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 21:53:24 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id o133-20020a25738b000000b0062872621d0eso1014679ybc.2
        for <linux-kernel@vger.kernel.org>; Tue, 08 Mar 2022 21:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=w+xH5zPzO9fzlPZhErbu5z29jcELWn+6P2g2NcadMFA=;
        b=bM2zTSm8KeB90TkOWKQFIC/tP96YmuE33vq0ZZHg+gfP6vr07pc36lboEL6JZF5rR5
         W75V9utE8zwUPnLZzjdnO/rnaptxeubHArLRUSokfgYnm10dvJ8q/Tdcpp0lrxJZeNyq
         Gl+LV4FzMH/vIwBuNZEQvzimEn7Wj3yd7LiyPhj4y93RN3i8m6h44RvmxqzQAIchsiuy
         1I6AcDPYrSTmC1iHGDXqd3mW1TKBH5gmvcKxYkg5Tvrb9RJq77WweysJBeRKImUZpUzz
         2USDBl+/faFs+wkYCi4WjKFhXKwonyXvcHQ6HshEGLP7Z1mlSLGgD6446WhYeZzrjYvc
         VWPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=w+xH5zPzO9fzlPZhErbu5z29jcELWn+6P2g2NcadMFA=;
        b=HXbSOkc5sLZxvdFTh/yuf86vISl3E+STwBStmFQbz4b40kZ//SWvhpbvJ/T0NL4DNn
         5a6hZ+5V30XM7Q+VOawXLNkK0CAkD9vSLP8NryjmwFp/3hrazTDMPCZCjvq2kbWw3MvU
         XgtAtOaSx0C+OP/Q9yG7uqXGQwYl3sioJ1zd2tldrHLAF2/Xjv8nDZqyoCTLlwNiDBN6
         E/NEFvdxtV+OD3LRL26x4EgOB3dpIXRFPQ6vy9bx5QdwXhPie7JGzk4Ry5p+pX0yUcpS
         FjRVVNTZGXYulrdZaZ0U3k4y579FIgyvBX8gfJhZL7j69WPe5mw3QfmLvzfzm24g0kWY
         zLDw==
X-Gm-Message-State: AOAM530O7vg/NNXNX1QA+wOwTMDDosdcAHZVnONROuL7SsdlCED0gQiT
        lPDfewpge944dknbVssbeRsbci/s0K9Y
X-Google-Smtp-Source: ABdhPJzJF+c+5wFkgHiaslh6V5+cpIWKEMcc6bLulAiUfvYLAQ7jF7pXtx1VkHg0a/2mozQgRdhqhoOqJMwN
X-Received: from maskray1.svl.corp.google.com ([2620:15c:2ce:200:7036:807c:86c9:3f2e])
 (user=maskray job=sendgmr) by 2002:a81:15c9:0:b0:2dc:4bf9:41ea with SMTP id
 192-20020a8115c9000000b002dc4bf941eamr15213633ywv.145.1646805203519; Tue, 08
 Mar 2022 21:53:23 -0800 (PST)
Date:   Tue,  8 Mar 2022 21:51:18 -0800
Message-Id: <20220309055118.1551013-1-maskray@google.com>
Mime-Version: 1.0
Subject: [PATCH] powerpc: Replace ppc64 DT_RELACOUNT usage with DT_RELASZ/24
From:   Fangrui Song <maskray@google.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        linuxppc-dev@lists.ozlabs.org
Cc:     Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Fangrui Song <maskray@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DT_RELACOUNT is an ELF dynamic tag inherited from SunOS indicating the
number of R_*_RELATIVE relocations. It is optional but {ld.lld,ld.lld}
-z combreloc always creates it (if non-zero) to slightly speed up glibc
ld.so relocation resolving by avoiding R_*R_PPC64_RELATIVE type
comparison. The tag is otherwise nearly unused in the wild and I'd
recommend that software avoids using it.

lld>=14.0.0 (since commit da0e5b885b25cf4ded0fa89b965dc6979ac02ca9)
underestimates DT_RELACOUNT for ppc64 when position-independent long
branch thunks are used. Correcting it needs non-trivial arch-specific
complexity which I'd prefer to avoid. Since our code always compares the
relocation type with R_PPC64_RELATIVE, replacing every occurrence of
DT_RELACOUNT with DT_RELASZ/sizeof(Elf64_Rela)=DT_RELASZ/24 is a correct
alternative.

DT_RELASZ is in practice bounded by an uint32_t. Dividing x by 24 can be
implemented as (uint32_t)(x*0xaaaaaaab) >> 4.

Link: https://github.com/ClangBuiltLinux/linux/issues/1581
Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Fangrui Song <maskray@google.com>
---
 arch/powerpc/boot/crt0.S       | 28 +++++++++++++++++-----------
 arch/powerpc/kernel/reloc_64.S | 15 +++++++++------
 2 files changed, 26 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/boot/crt0.S b/arch/powerpc/boot/crt0.S
index feadee18e271..1c96ebe7ef1a 100644
--- a/arch/powerpc/boot/crt0.S
+++ b/arch/powerpc/boot/crt0.S
@@ -8,7 +8,7 @@
 #include "ppc_asm.h"
 
 RELA = 7
-RELACOUNT = 0x6ffffff9
+RELASZ = 8
 
 	.data
 	/* A procedure descriptor used when booting this as a COFF file.
@@ -65,7 +65,7 @@ p_base:	mflr	r10		/* r10 now points to runtime addr of p_base */
 	subf	r11,r11,r12	/* runtime - linktime offset */
 
 	/* The dynamic section contains a series of tagged entries.
-	 * We need the RELA and RELACOUNT entries. */
+	 * We need the RELA and RELASZ entries. */
 	li	r9,0
 	li	r0,0
 9:	lwz	r8,0(r12)	/* get tag */
@@ -75,18 +75,21 @@ p_base:	mflr	r10		/* r10 now points to runtime addr of p_base */
 	bne	11f
 	lwz	r9,4(r12)	/* get RELA pointer in r9 */
 	b	12f
-11:	addis	r8,r8,(-RELACOUNT)@ha
-	cmpwi	r8,RELACOUNT@l
+11:	cmpwi	r8,RELASZ
 	bne	12f
-	lwz	r0,4(r12)	/* get RELACOUNT value in r0 */
+	lwz	r0,4(r12)	/* get RELASZ / 24 in r0 */
+	lis     r8,0xaaaa
+	ori     r8,r8,0xaaab
+	mulhwu  r0,r0,r8
+	srwi    r0,r0,4
 12:	addi	r12,r12,8
 	b	9b
 
 	/* The relocation section contains a list of relocations.
 	 * We now do the R_PPC_RELATIVE ones, which point to words
 	 * which need to be initialized with addend + offset.
-	 * The R_PPC_RELATIVE ones come first and there are RELACOUNT
-	 * of them. */
+	 * The R_PPC_RELATIVE ones come first and there are at most
+         * RELASZ/24 of them. */
 10:	/* skip relocation if we don't have both */
 	cmpwi	r0,0
 	beq	3f
@@ -160,14 +163,17 @@ p_base:	mflr	r10		/* r10 now points to runtime addr of p_base */
 	bne	10f
 	ld	r13,8(r11)       /* get RELA pointer in r13 */
 	b	11f
-10:	addis	r12,r12,(-RELACOUNT)@ha
-	cmpdi	r12,RELACOUNT@l
+10:	cmpdi	r12,RELASZ
 	bne	11f
-	ld	r8,8(r11)       /* get RELACOUNT value in r8 */
+	ld	r8,8(r11)       /* get RELASZ / 24 in r8 */
+	lis     r0,0xaaaa
+	ori     r0,r0,0xaaab
+	mulhwu  r8,r8,r0
+	srwi    r8,r8,4
 11:	addi	r11,r11,16
 	b	9b
 12:
-	cmpdi	r13,0            /* check we have both RELA and RELACOUNT */
+	cmpdi	r13,0            /* check we have both RELA and RELASZ */
 	cmpdi	cr1,r8,0
 	beq	3f
 	beq	cr1,3f
diff --git a/arch/powerpc/kernel/reloc_64.S b/arch/powerpc/kernel/reloc_64.S
index 02d4719bf43a..362be759609f 100644
--- a/arch/powerpc/kernel/reloc_64.S
+++ b/arch/powerpc/kernel/reloc_64.S
@@ -8,7 +8,7 @@
 #include <asm/ppc_asm.h>
 
 RELA = 7
-RELACOUNT = 0x6ffffff9
+RELASZ = 8
 R_PPC64_RELATIVE = 22
 
 /*
@@ -27,7 +27,7 @@ _GLOBAL(relocate)
 	add	r10,r10,r12	/* r10 has runtime addr of _stext */
 
 	/*
-	 * Scan the dynamic section for the RELA and RELACOUNT entries.
+	 * Scan the dynamic section for the RELA and RELASZ entries.
 	 */
 	li	r7,0
 	li	r8,0
@@ -38,13 +38,16 @@ _GLOBAL(relocate)
 	bne	2f
 	ld	r7,8(r11)	/* get RELA pointer in r7 */
 	b	3f
-2:	addis	r6,r6,(-RELACOUNT)@ha
-	cmpdi	r6,RELACOUNT@l
+2:	cmpdi	r6,RELASZ
 	bne	3f
-	ld	r8,8(r11)	/* get RELACOUNT value in r8 */
+	ld	r8,8(r11)	/* get RELA / 24 in r8 */
+	lis     r0,0xaaaa
+	ori     r0,r0,0xaaab
+	mulhwu  r8,r8,r0
+	srwi    r8,r8,4
 3:	addi	r11,r11,16
 	b	1b
-4:	cmpdi	r7,0		/* check we have both RELA and RELACOUNT */
+4:	cmpdi	r7,0		/* check we have both RELA and RELASZ */
 	cmpdi	cr1,r8,0
 	beq	6f
 	beq	cr1,6f
-- 
2.35.1.616.g0bdcbb4464-goog

