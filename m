Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58C052964B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 02:57:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242764AbiEQA4s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 20:56:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243107AbiEQA4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 20:56:13 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3FD521834
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:56:09 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id h186so12972193pgc.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YyxbfrF93QriCFR9e9/Ieq2jTtQBkK6LoG1jr7zyJxk=;
        b=oCAMl1DsQ3OB64WTGBzI6nY/tqFRzPvF50jEnkNYVq85ORdMBGfWYreKS5Th/RLfdF
         OH3OoRASSBEmOtBkGh2q/+xrz7Va/cq9uFCA12vne/Nj4eptouLiTNYPt4dxxiG+eZry
         e+uFALuiN8eQAmSZVy+L22wMIn3vP2quo87T3x3vJ3xZ7uy0RoyXsB51t0mkyGshPmWI
         QMKfF9mWSf7o2kmAtzyB30dJL+dNkOuFg8+QcGubMpCViLxzZrfz05Dxc6UWLsdO4ppK
         TkEtLCBaa6X5EXDFistYnYs2lx4xX/H/PinuowyMWEsSODnzH+DfM+N4jiIQriHI2e+Q
         qMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YyxbfrF93QriCFR9e9/Ieq2jTtQBkK6LoG1jr7zyJxk=;
        b=7AHm3/F5z3xwRHHM5usb2hoEp6epRvoWoUgybZIMXj69F303mOwCnixzul0FKv/B6y
         NTTJ1r6DKP3IbHCJZRotNhHt/5I1vYFpT1+K4sFHa8RCjgl6AS0J9RuEHp7CIsNcbOad
         Ogws9tvJXGT3bp2qAAFkZTtx+7iIpc2AauTgw3aN5KdllT6OMDROZSOxH5OqIzF/ThS9
         y9a3PhMFFm+G+OvYhgxYN/N7yo4IDj02gEVrOx1K9zofFWpbmb+y74x1edKjDB3joG58
         a93pQPH0lF+bp5opRopJX3XeFTLWEiYvZJfnbzn1rHhzzU4J8WYK8yagfRHNZdvYUcxd
         J/pg==
X-Gm-Message-State: AOAM533Pviyh/nIr6N9P5wmrygB3M1qZpbUwf/7EIVeIjHqvpBh5n8lt
        WMSNZ+mxX/XGs4uoQrCp3REKB4ldcu8=
X-Google-Smtp-Source: ABdhPJzWupGGZ1FqSFLiIMHuDJPPH9C1E94cICFIkU9GYZO5qupsuiir0HalN6xqjCJRIW5P713vHw==
X-Received: by 2002:a05:6a00:ac1:b0:4f1:29e4:b3a1 with SMTP id c1-20020a056a000ac100b004f129e4b3a1mr20055546pfl.63.1652748968794;
        Mon, 16 May 2022 17:56:08 -0700 (PDT)
Received: from localhost ([2409:10:24a0:4700:e8ad:216a:2a9d:6d0c])
        by smtp.gmail.com with ESMTPSA id x21-20020a1709027c1500b0015e8d4eb29csm7586085pll.230.2022.05.16.17.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 17:56:08 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Openrisc <openrisc@lists.librecores.org>,
        Stafford Horne <shorne@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH v2 13/13] openrisc: Remove unused IMMU tlb workardound
Date:   Tue, 17 May 2022 09:55:10 +0900
Message-Id: <20220517005510.3500105-14-shorne@gmail.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220517005510.3500105-1-shorne@gmail.com>
References: <20220517005510.3500105-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This looks to be some historical code that was used to convert TLB
misses on branches from l.bf, l.jal, l.j etc all to a trampoline
using l.jr (jump register).  I don't see this being used and I don't
know the history of it so remove it.

Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/kernel/head.S | 209 ------------------------------------
 1 file changed, 209 deletions(-)

diff --git a/arch/openrisc/kernel/head.S b/arch/openrisc/kernel/head.S
index 21db50563f97..9b59d0ca665c 100644
--- a/arch/openrisc/kernel/head.S
+++ b/arch/openrisc/kernel/head.S
@@ -1325,215 +1325,6 @@ i_pte_not_present:
 
 /* =================================================[ debugging aids ]=== */
 
-	.align 64
-_immu_trampoline:
-	.space 64
-_immu_trampoline_top:
-
-#define TRAMP_SLOT_0		(0x0)
-#define TRAMP_SLOT_1		(0x4)
-#define TRAMP_SLOT_2		(0x8)
-#define TRAMP_SLOT_3		(0xc)
-#define TRAMP_SLOT_4		(0x10)
-#define TRAMP_SLOT_5		(0x14)
-#define TRAMP_FRAME_SIZE	(0x18)
-
-ENTRY(_immu_trampoline_workaround)
-	// r2 EEA
-	// r6 is physical EEA
-	tophys(r6,r2)
-
-	LOAD_SYMBOL_2_GPR(r5,_immu_trampoline)
-	tophys	(r3,r5)			// r3 is trampoline (physical)
-
-	LOAD_SYMBOL_2_GPR(r4,0x15000000)
-	l.sw	TRAMP_SLOT_0(r3),r4
-	l.sw	TRAMP_SLOT_1(r3),r4
-	l.sw	TRAMP_SLOT_4(r3),r4
-	l.sw	TRAMP_SLOT_5(r3),r4
-
-					// EPC = EEA - 0x4
-	l.lwz	r4,0x0(r6)		// load op @ EEA + 0x0 (fc address)
-	l.sw	TRAMP_SLOT_3(r3),r4	// store it to _immu_trampoline_data
-	l.lwz	r4,-0x4(r6)		// load op @ EEA - 0x4 (f8 address)
-	l.sw	TRAMP_SLOT_2(r3),r4	// store it to _immu_trampoline_data
-
-	l.srli  r5,r4,26                // check opcode for write access
-	l.sfeqi r5,0                    // l.j
-	l.bf    0f
-	l.sfeqi r5,0x11                 // l.jr
-	l.bf    1f
-	l.sfeqi r5,1                    // l.jal
-	l.bf    2f
-	l.sfeqi r5,0x12                 // l.jalr
-	l.bf    3f
-	l.sfeqi r5,3                    // l.bnf
-	l.bf    4f
-	l.sfeqi r5,4                    // l.bf
-	l.bf    5f
-99:
-	l.nop
-	l.j	99b			// should never happen
-	l.nop	1
-
-	// r2 is EEA
-	// r3 is trampoline address (physical)
-	// r4 is instruction
-	// r6 is physical(EEA)
-	//
-	// r5
-
-2:	// l.jal
-
-	/* 19 20 aa aa	l.movhi r9,0xaaaa
-	 * a9 29 bb bb  l.ori	r9,0xbbbb
-	 *
-	 * where 0xaaaabbbb is EEA + 0x4 shifted right 2
-	 */
-
-	l.addi	r6,r2,0x4		// this is 0xaaaabbbb
-
-					// l.movhi r9,0xaaaa
-	l.ori	r5,r0,0x1920		// 0x1920 == l.movhi r9
-	l.sh	(TRAMP_SLOT_0+0x0)(r3),r5
-	l.srli	r5,r6,16
-	l.sh	(TRAMP_SLOT_0+0x2)(r3),r5
-
-					// l.ori   r9,0xbbbb
-	l.ori	r5,r0,0xa929		// 0xa929 == l.ori r9
-	l.sh	(TRAMP_SLOT_1+0x0)(r3),r5
-	l.andi	r5,r6,0xffff
-	l.sh	(TRAMP_SLOT_1+0x2)(r3),r5
-
-	/* falthrough, need to set up new jump offset */
-
-
-0:	// l.j
-	l.slli	r6,r4,6			// original offset shifted left 6 - 2
-//	l.srli	r6,r6,6			// original offset shifted right 2
-
-	l.slli	r4,r2,4			// old jump position: EEA shifted left 4
-//	l.srli	r4,r4,6			// old jump position: shifted right 2
-
-	l.addi	r5,r3,0xc		// new jump position (physical)
-	l.slli	r5,r5,4			// new jump position: shifted left 4
-
-	// calculate new jump offset
-	// new_off = old_off + (old_jump - new_jump)
-
-	l.sub	r5,r4,r5		// old_jump - new_jump
-	l.add	r5,r6,r5		// orig_off + (old_jump - new_jump)
-	l.srli	r5,r5,6			// new offset shifted right 2
-
-	// r5 is new jump offset
-					// l.j has opcode 0x0...
-	l.sw	TRAMP_SLOT_2(r3),r5	// write it back
-
-	l.j	trampoline_out
-	l.nop
-
-/* ----------------------------- */
-
-3:	// l.jalr
-
-	/* 19 20 aa aa	l.movhi r9,0xaaaa
-	 * a9 29 bb bb  l.ori	r9,0xbbbb
-	 *
-	 * where 0xaaaabbbb is EEA + 0x4 shifted right 2
-	 */
-
-	l.addi	r6,r2,0x4		// this is 0xaaaabbbb
-
-					// l.movhi r9,0xaaaa
-	l.ori	r5,r0,0x1920		// 0x1920 == l.movhi r9
-	l.sh	(TRAMP_SLOT_0+0x0)(r3),r5
-	l.srli	r5,r6,16
-	l.sh	(TRAMP_SLOT_0+0x2)(r3),r5
-
-					// l.ori   r9,0xbbbb
-	l.ori	r5,r0,0xa929		// 0xa929 == l.ori r9
-	l.sh	(TRAMP_SLOT_1+0x0)(r3),r5
-	l.andi	r5,r6,0xffff
-	l.sh	(TRAMP_SLOT_1+0x2)(r3),r5
-
-	l.lhz	r5,(TRAMP_SLOT_2+0x0)(r3)	// load hi part of jump instruction
-	l.andi	r5,r5,0x3ff		// clear out opcode part
-	l.ori	r5,r5,0x4400		// opcode changed from l.jalr -> l.jr
-	l.sh	(TRAMP_SLOT_2+0x0)(r3),r5 // write it back
-
-	/* falthrough */
-
-1:	// l.jr
-	l.j	trampoline_out
-	l.nop
-
-/* ----------------------------- */
-
-4:	// l.bnf
-5:	// l.bf
-	l.slli	r6,r4,6			// original offset shifted left 6 - 2
-//	l.srli	r6,r6,6			// original offset shifted right 2
-
-	l.slli	r4,r2,4			// old jump position: EEA shifted left 4
-//	l.srli	r4,r4,6			// old jump position: shifted right 2
-
-	l.addi	r5,r3,0xc		// new jump position (physical)
-	l.slli	r5,r5,4			// new jump position: shifted left 4
-
-	// calculate new jump offset
-	// new_off = old_off + (old_jump - new_jump)
-
-	l.add	r6,r6,r4		// (orig_off + old_jump)
-	l.sub	r6,r6,r5		// (orig_off + old_jump) - new_jump
-	l.srli	r6,r6,6			// new offset shifted right 2
-
-	// r6 is new jump offset
-	l.lwz	r4,(TRAMP_SLOT_2+0x0)(r3)	// load jump instruction
-	l.srli	r4,r4,16
-	l.andi	r4,r4,0xfc00		// get opcode part
-	l.slli	r4,r4,16
-	l.or	r6,r4,r6		// l.b(n)f new offset
-	l.sw	TRAMP_SLOT_2(r3),r6	// write it back
-
-	/* we need to add l.j to EEA + 0x8 */
-	tophys	(r4,r2)			// may not be needed (due to shifts down_
-	l.addi	r4,r4,(0x8 - 0x8)	// jump target = r2 + 0x8 (compensate for 0x8)
-					// jump position = r5 + 0x8 (0x8 compensated)
-	l.sub	r4,r4,r5		// jump offset = target - new_position + 0x8
-
-	l.slli	r4,r4,4			// the amount of info in imediate of jump
-	l.srli	r4,r4,6			// jump instruction with offset
-	l.sw	TRAMP_SLOT_4(r3),r4	// write it to 4th slot
-
-	/* fallthrough */
-
-trampoline_out:
-	// set up new EPC to point to our trampoline code
-	LOAD_SYMBOL_2_GPR(r5,_immu_trampoline)
-	l.mtspr	r0,r5,SPR_EPCR_BASE
-
-	// immu_trampoline is (4x) CACHE_LINE aligned
-	// and only 6 instructions long,
-	// so we need to invalidate only 2 lines
-
-	/* Establish cache block size
-	   If BS=0, 16;
-	   If BS=1, 32;
-	   r14 contain block size
-	*/
-	l.mfspr r21,r0,SPR_ICCFGR
-	l.andi	r21,r21,SPR_ICCFGR_CBS
-	l.srli	r21,r21,7
-	l.ori	r23,r0,16
-	l.sll	r14,r23,r21
-
-	l.mtspr	r0,r5,SPR_ICBIR
-	l.add	r5,r5,r14
-	l.mtspr	r0,r5,SPR_ICBIR
-
-	l.jr	r9
-	l.nop
-
 /*
  * DESC: Prints ASCII character stored in r7
  *
-- 
2.31.1

