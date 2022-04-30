Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AF1E515CDF
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 14:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240350AbiD3M2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 08:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbiD3M2C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 08:28:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A79A0139;
        Sat, 30 Apr 2022 05:24:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4367560AE5;
        Sat, 30 Apr 2022 12:24:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23826C385A7;
        Sat, 30 Apr 2022 12:24:38 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eshy/VUi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1651321475;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fgcN0qR53PxDNDyRz8mDwIaBEjIsjkyTe89/FfZgIDM=;
        b=eshy/VUiIAgCcfeuV75Wr/Er5w1aUXt6kzCJoYjL15KSNHeEk5Jh2kfFZE04m/Q87EiXym
        PF2/F+ko2ujnFvZfStEdi9cFC/HZqkpv+lmKPIP8OWcglsvBB5pRZAhWxmxKRJcfHYA6V9
        N9vHELmyGyG+03V5TZgeyG3/1+c+VV8=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f9b1305e (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 30 Apr 2022 12:24:35 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        openrisc@lists.librecores.org, shorne@gmail.com
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH v8 06/19] openrisc: start CPU timer early in boot
Date:   Sat, 30 Apr 2022 14:24:33 +0200
Message-Id: <20220430122433.2719029-1-Jason@zx2c4.com>
In-Reply-To: <20220430122355.2718797-1-Jason@zx2c4.com>
References: <20220430122355.2718797-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to measure the boot process, the timer should be switched on as
early in boot as possible. This is necessary so that by the time the
setup code reaches random_init(), get_cycles() (by way of
random_get_entropy()) returns non-zero, indicating that it is actually
capable of counting. So this commit enables the timer immediately upon
booting up. As well, the commit define the get_cycles macro, like the
previous patches in this series, so that generic code is aware that it's
implemented by the platform, as is done on other archs.

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
Changes v7->v8:
- Rather than doing get_cycles()+1 to handle the early boot case,
  actually start the timer early in boot. This has the huge advantage of
  properly measuring the boot sequence timing, which could be a valuable
  source of entropy.

 arch/openrisc/include/asm/timex.h | 1 +
 arch/openrisc/kernel/setup.c      | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/openrisc/include/asm/timex.h b/arch/openrisc/include/asm/timex.h
index d52b4e536e3f..5487fa93dd9b 100644
--- a/arch/openrisc/include/asm/timex.h
+++ b/arch/openrisc/include/asm/timex.h
@@ -23,6 +23,7 @@ static inline cycles_t get_cycles(void)
 {
 	return mfspr(SPR_TTCR);
 }
+#define get_cycles get_cycles
 
 /* This isn't really used any more */
 #define CLOCK_TICK_RATE 1000
diff --git a/arch/openrisc/kernel/setup.c b/arch/openrisc/kernel/setup.c
index 0cd04d936a7a..1cb7c1770a17 100644
--- a/arch/openrisc/kernel/setup.c
+++ b/arch/openrisc/kernel/setup.c
@@ -220,6 +220,13 @@ void __init setup_cpuinfo(void)
 
 void __init or1k_early_setup(void *fdt)
 {
+	/* Start the TTCR as early as possible, so that the RNG can make use of
+	 * measurements of boot time from the earliest opportunity. Especially
+	 * important is that the TTCR does not return zero by the time we reach
+	 * rand_initialize().
+	 */
+	mtspr(SPR_TTMR, SPR_TTMR_CR);
+
 	if (fdt)
 		pr_info("FDT at %p\n", fdt);
 	else {
-- 
2.35.1

