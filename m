Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9138C46A105
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 17:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381052AbhLFQTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 11:19:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245042AbhLFQTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 11:19:13 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 901ABC0497A2
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 08:12:46 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id D845ACE16D0
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 16:12:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F174AC341C1;
        Mon,  6 Dec 2021 16:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638807163;
        bh=4lrA7vab3IqapjTBi4sA+eK+CFU9COhOnI0b6b8qoS8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nojnBAoYR0mRHYKp/3KVaGhmt58qmV4P0h9vURAhHbgbEO7zcXe4ur7GDw0rCgOeI
         McNXdDdSpd7iEsatyNZVqw8n5EwyKupKsmZgGDjcje28IpyJbkIlNBsu4SQfKafcF/
         9VqU0GV14BMYQJa5PVfNPtYypBOmxWNoBxg+J80nW19lbsCIyw3EoWPWI0sagLQL8L
         rUmObWt1OLaXrw5qNdQcNyJDMOb8iODS5dY4G+iQRXa4FOwMGmYsyL+dxAH2bhZhup
         nDNjoEuuOyaWpjm6E7SAUhv2zy03XYCk94gpE7HKst3S+kzWWbyvwHbgfSJgO/rcq8
         3br6qYWpR+s8A==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        hpa@zytor.com, Eric Biederman <ebiederm@xmission.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, kexec@lists.infradead.org,
        Alexandre ghiti <alex@ghiti.fr>
Subject: [PATCH v2 3/5] x86/setup: use IS_ENABLED(CONFIG_KEXEC_CORE) instead of #ifdef
Date:   Tue,  7 Dec 2021 00:05:12 +0800
Message-Id: <20211206160514.2000-4-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211206160514.2000-1-jszhang@kernel.org>
References: <20211206160514.2000-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace the conditional compilation using "#ifdef CONFIG_KEXEC_CORE"
by a check for "IS_ENABLED(CONFIG_KEXEC_CORE)", to simplify the code
and increase compile coverage.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/x86/kernel/setup.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index c410be738ae7..56b738c1ca33 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -390,8 +390,6 @@ static void __init memblock_x86_reserve_range_setup_data(void)
  * --------- Crashkernel reservation ------------------------------
  */
 
-#ifdef CONFIG_KEXEC_CORE
-
 /* 16M alignment for crash kernel regions */
 #define CRASH_ALIGN		SZ_16M
 
@@ -469,6 +467,9 @@ static void __init reserve_crashkernel(void)
 	bool high = false;
 	int ret;
 
+	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
+		return;
+
 	total_mem = memblock_phys_mem_size();
 
 	/* crashkernel=XM */
@@ -534,11 +535,6 @@ static void __init reserve_crashkernel(void)
 	crashk_res.end   = crash_base + crash_size - 1;
 	insert_resource(&iomem_resource, &crashk_res);
 }
-#else
-static void __init reserve_crashkernel(void)
-{
-}
-#endif
 
 static struct resource standard_io_resources[] = {
 	{ .name = "dma1", .start = 0x00, .end = 0x1f,
-- 
2.34.1

