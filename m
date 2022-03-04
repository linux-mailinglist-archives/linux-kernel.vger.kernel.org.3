Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6AA4CD90C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:24:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240663AbiCDQZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229966AbiCDQZR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:25:17 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3FE81C2D8C;
        Fri,  4 Mar 2022 08:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=fNKlE8/kIbGxOpYhbE5ion9py1Wp9T9tuw8AH7oCcZA=; b=UFYS7S+J+lksj2QuEtV0TQuSLE
        LGVCc45JgNyS5hIudM0yXJbStGtiAEk77Ap35ryCFMJc/7yDbC8XdwPyR+F3JrWrQ+ovjtrakkCSI
        MihN0AxqV08kY5/yY+uHs3Ed8pUNR+eOtdIbIt9z27R4kPudYlw00XeLW/c8IPSp9XeMLZCJ7bUwg
        MfiXOoAv0py1RXBTT450L6N77fuiUXXQ/MNhtyUX60pjq+P1EAWFD+uJzUMTvPHFTqXnpNO3X+vxz
        eLcCkpJNQdvyAdNTwuy7ub7NgK8BFcKTohEjNmd6vrU1sgUMJK+nmf+5CNjZumqYgYp4H1ovWZ/ML
        xqYU9qqA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQAjE-00B1Mk-6D; Fri, 04 Mar 2022 16:24:28 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        linux-mips@vger.kernel.org
Subject: [PATCH v3] mips: DEC: honor CONFIG_MIPS_FP_SUPPORT=n
Date:   Fri,  4 Mar 2022 08:24:27 -0800
Message-Id: <20220304162427.27276-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Include the DECstation interrupt handler in opting out of
FPU support.

Fixes a linker error:

mips-linux-ld: arch/mips/dec/int-handler.o: in function `fpu':
(.text+0x148): undefined reference to `handle_fpe_int'

Fixes: 183b40f992c8 ("MIPS: Allow FP support to be disabled")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Paul Burton <paulburton@kernel.org>
Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: Maciej W. Rozycki <macro@orcam.me.uk>
Cc: linux-mips@vger.kernel.org
---
v2: add another ifdef block in int-handler.S; (Maciej)
    add an ifdef block in dec/setup.c; (Maciej)
v3: use IS_ENABLED() instead of an ifdef block in dec/setup.c; (Maciej)

 arch/mips/dec/int-handler.S |    6 +++---
 arch/mips/dec/setup.c       |    3 ++-
 2 files changed, 5 insertions(+), 4 deletions(-)

--- linux-next-20220303.orig/arch/mips/dec/int-handler.S
+++ linux-next-20220303/arch/mips/dec/int-handler.S
@@ -131,7 +131,7 @@
 		 */
 		mfc0	t0,CP0_CAUSE		# get pending interrupts
 		mfc0	t1,CP0_STATUS
-#ifdef CONFIG_32BIT
+#if defined(CONFIG_32BIT) && defined(CONFIG_MIPS_FP_SUPPORT)
 		lw	t2,cpu_fpu_mask
 #endif
 		andi	t0,ST0_IM		# CAUSE.CE may be non-zero!
@@ -139,7 +139,7 @@
 
 		beqz	t0,spurious
 
-#ifdef CONFIG_32BIT
+#if defined(CONFIG_32BIT) && defined(CONFIG_MIPS_FP_SUPPORT)
 		 and	t2,t0
 		bnez	t2,fpu			# handle FPU immediately
 #endif
@@ -280,7 +280,7 @@ handle_it:
 		j	dec_irq_dispatch
 		 nop
 
-#ifdef CONFIG_32BIT
+#if defined(CONFIG_32BIT) && defined(CONFIG_MIPS_FP_SUPPORT)
 fpu:
 		lw	t0,fpu_kstat_irq
 		nop
--- linux-next-20220303.orig/arch/mips/dec/setup.c
+++ linux-next-20220303/arch/mips/dec/setup.c
@@ -746,7 +746,8 @@ void __init arch_init_irq(void)
 		dec_interrupt[DEC_IRQ_HALT] = -1;
 
 	/* Register board interrupts: FPU and cascade. */
-	if (dec_interrupt[DEC_IRQ_FPU] >= 0 && cpu_has_fpu) {
+	if (IS_ENABLED(CONFIG_MIPS_FP_SUPPORT) &&
+	    dec_interrupt[DEC_IRQ_FPU] >= 0 && cpu_has_fpu) {
 		struct irq_desc *desc_fpu;
 		int irq_fpu;
 
