Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0660E4CD8A5
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:10:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240524AbiCDQL3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:11:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240466AbiCDQL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:11:26 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2020B1C7EA0;
        Fri,  4 Mar 2022 08:10:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=uo0ZltVxD3vA31XmjhxcoENqFiRC1PTPgbxse0EESEM=; b=3XV1oFX+rKFFK7fHEO1bVDwQrT
        rUMGMRPzMfz1G8v9F7TmeqEh+659jiXuAShypiJCN9fNNPy38sa7+q26rbvkeS6DfwfsCxU/ndGbB
        aeb79iGm8b7lAgqtMeurEBOzI3dtOzavHeaF5tESegTcaryBr+tgA3o9ZOonE6eQKguuPd8aRBZxa
        dNelLTbslmu0+1x1kIg2P/G2jI/ZZBnQsIPVzeGmhVYXcv9fjMlDRo3rX+GSBrvCO61Qla7K5FcR9
        XKWDoLYGgTg4q1JEIHuB1o8NhziybJuxgUAC+r/zLQdCUWlRyYX8Mc3sqjI4eVatG6ZjlOCil8NzZ
        RLmmKElg==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nQAVp-00Avgl-GM; Fri, 04 Mar 2022 16:10:37 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        Paul Burton <paulburton@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        "Maciej W . Rozycki" <macro@orcam.me.uk>,
        linux-mips@vger.kernel.org
Subject: [PATCH v2] mips: DEC: honor CONFIG_MIPS_FP_SUPPORT=n
Date:   Fri,  4 Mar 2022 08:10:36 -0800
Message-Id: <20220304161036.16008-1-rdunlap@infradead.org>
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

 arch/mips/dec/int-handler.S |    6 +++---
 arch/mips/dec/setup.c       |    2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

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
@@ -746,6 +746,7 @@ void __init arch_init_irq(void)
 		dec_interrupt[DEC_IRQ_HALT] = -1;
 
 	/* Register board interrupts: FPU and cascade. */
+#if defined(CONFIG_MIPS_FP_SUPPORT)
 	if (dec_interrupt[DEC_IRQ_FPU] >= 0 && cpu_has_fpu) {
 		struct irq_desc *desc_fpu;
 		int irq_fpu;
@@ -757,6 +758,7 @@ void __init arch_init_irq(void)
 		desc_fpu = irq_to_desc(irq_fpu);
 		fpu_kstat_irq = this_cpu_ptr(desc_fpu->kstat_irqs);
 	}
+#endif
 	if (dec_interrupt[DEC_IRQ_CASCADE] >= 0) {
 		if (request_irq(dec_interrupt[DEC_IRQ_CASCADE], no_action,
 				IRQF_NO_THREAD, "cascade", NULL))
