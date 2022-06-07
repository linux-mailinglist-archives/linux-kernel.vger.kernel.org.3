Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25827542504
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238859AbiFHCSb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 22:18:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390553AbiFHBuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 21:50:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE6E1A43EF
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:31:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 019C0B82182
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 19:31:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0832C385A2;
        Tue,  7 Jun 2022 19:31:15 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ezRz14S7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654630272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aIk3Rt4nDto2wWZJ+glqe0AEG6VQh1/nNLxNJJ+VXZQ=;
        b=ezRz14S7LF6mMOq6Y8L0jlHdpkHv5/MCl5Z6EXV61XdLF/2w+XGyhz5zXj8ZQqSGJlGW3q
        TKZJw2/TwkTK8xN8pMLyqzHxYkaMGeqWDEaBSHyQuowIiZYvWOrs0+akt9LBRFPvs69ClY
        BzBioCKFw9TzQO1WYsOtHnzigc1S7js=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id e15e7cd2 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 7 Jun 2022 19:31:12 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russel King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH v3] ARM: initialize jump labels before setup_machine_fdt()
Date:   Tue,  7 Jun 2022 21:30:44 +0200
Message-Id: <20220607193044.1063287-1-Jason@zx2c4.com>
In-Reply-To: <Yp9yUqHNNaAxZ/5y@zx2c4.com>
References: <Yp9yUqHNNaAxZ/5y@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen reported that a static key warning splat appears during early
boot on arm64 systems that credit randomness from device trees that
contain an "rng-seed" property, because setup_machine_fdt() is called
before jump_label_init() during setup_arch(), which was fixed by
73e2d827a501 ("arm64: Initialize jump labels before
setup_machine_fdt()").

The same basic issue applies to arm32 as well. So this commit adds a
call to jump_label_init() just before setup_machine_fdt(). Since the
page maps haven't been set yet, this also requires us to use the early
patching code in the jump label code.

Reported-by: Stephen Boyd <swboyd@chromium.org>
Reported-by: Phil Elwell <phil@raspberrypi.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Russel King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Fixes: f5bda35fba61 ("random: use static branch for crng_ready()")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/arm/kernel/jump_label.c | 3 ++-
 arch/arm/kernel/setup.c      | 1 +
 arch/arm/mm/mmu.c            | 3 +++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/arm/kernel/jump_label.c b/arch/arm/kernel/jump_label.c
index 303b3ab87f7e..8f8c5312f917 100644
--- a/arch/arm/kernel/jump_label.c
+++ b/arch/arm/kernel/jump_label.c
@@ -8,6 +8,7 @@ static void __arch_jump_label_transform(struct jump_entry *entry,
 					enum jump_label_type type,
 					bool is_static)
 {
+	extern bool early_mm_initialized;
 	void *addr = (void *)entry->code;
 	unsigned int insn;
 
@@ -16,7 +17,7 @@ static void __arch_jump_label_transform(struct jump_entry *entry,
 	else
 		insn = arm_gen_nop();
 
-	if (is_static)
+	if (is_static || !early_mm_initialized)
 		__patch_text_early(addr, insn);
 	else
 		patch_text(addr, insn);
diff --git a/arch/arm/kernel/setup.c b/arch/arm/kernel/setup.c
index 1e8a50a97edf..3ff80b1ee0b5 100644
--- a/arch/arm/kernel/setup.c
+++ b/arch/arm/kernel/setup.c
@@ -1101,6 +1101,7 @@ void __init setup_arch(char **cmdline_p)
 		atags_vaddr = FDT_VIRT_BASE(__atags_pointer);
 
 	setup_processor();
+	jump_label_init();
 	if (atags_vaddr) {
 		mdesc = setup_machine_fdt(atags_vaddr);
 		if (mdesc)
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 5e2be37a198e..3f63a5581966 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -1754,10 +1754,13 @@ void __init paging_init(const struct machine_desc *mdesc)
 	__flush_dcache_page(NULL, empty_zero_page);
 }
 
+bool early_mm_initialized;
+
 void __init early_mm_init(const struct machine_desc *mdesc)
 {
 	build_mem_type_table();
 	early_paging_init(mdesc);
+	early_mm_initialized = true;
 }
 
 void set_pte_at(struct mm_struct *mm, unsigned long addr,
-- 
2.35.1

