Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C431A542022
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 02:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380325AbiFHARo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 20:17:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1391411AbiFGW40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 18:56:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33B030C9FA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:58:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3ED0616A8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 19:58:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44582C385A2;
        Tue,  7 Jun 2022 19:58:00 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="P3yIR3c3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1654631878;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UkQJjvZ5xCdBwiht+8tu2AP0BLnypsD3C8jDx5YCgmc=;
        b=P3yIR3c3DtR/RhcoMlwU4sIlFUoCPUUImnF0ckmOipgBY1DMO0Mr7snbuEmvcVropUQvY+
        1+phCFG5vWnyOj2zdcr06D8eVgM1LzYv7wfljGWl2x/n8RrmYu9w+z90FdjamBIDjW/kyK
        /93Sjs9SFfqRUWrygIZrwCI5ylBXVf8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5d384389 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Tue, 7 Jun 2022 19:57:57 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Stephen Boyd <swboyd@chromium.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russel King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>
Subject: [PATCH] riscv: initialize jump labels before early_init_dt_scan()
Date:   Tue,  7 Jun 2022 21:57:52 +0200
Message-Id: <20220607195752.1146431-1-Jason@zx2c4.com>
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
contain an "rng-seed" property, because the dtb is parsed is called
before jump_label_init() during setup_arch(), which was fixed by
73e2d827a501 ("arm64: Initialize jump labels before
setup_machine_fdt()").

The same basic issue applies to RISC-V as well. So this commit moves the
call to jump_label_init() just before early_init_dt_scan().
jump_label_init() actually requires sbi_init() to be called first for
proper functioning, so it also moves that to the right place.

Reported-by: Stephen Boyd <swboyd@chromium.org>
Reported-by: Phil Elwell <phil@raspberrypi.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Russel King <linux@armlinux.org.uk>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Fixes: f5bda35fba61 ("random: use static branch for crng_ready()")
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 arch/riscv/kernel/setup.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/kernel/setup.c b/arch/riscv/kernel/setup.c
index f0f36a4a0e9b..c44c81b1cfb3 100644
--- a/arch/riscv/kernel/setup.c
+++ b/arch/riscv/kernel/setup.c
@@ -263,13 +263,15 @@ static void __init parse_dtb(void)
 
 void __init setup_arch(char **cmdline_p)
 {
+	early_ioremap_setup();
+	sbi_init();
+	jump_label_init();
+
 	parse_dtb();
 	setup_initial_init_mm(_stext, _etext, _edata, _end);
 
 	*cmdline_p = boot_command_line;
 
-	early_ioremap_setup();
-	jump_label_init();
 	parse_early_param();
 
 	efi_init();
@@ -285,7 +287,6 @@ void __init setup_arch(char **cmdline_p)
 	misc_mem_init();
 
 	init_resources();
-	sbi_init();
 
 #ifdef CONFIG_KASAN
 	kasan_init();
-- 
2.35.1

