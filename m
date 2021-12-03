Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD05F46715D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 06:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346328AbhLCFOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 00:14:06 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:48476 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346136AbhLCFOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 00:14:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5603CB825BE
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 05:10:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78123C53FCE;
        Fri,  3 Dec 2021 05:10:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638508238;
        bh=B/zsYpq5+A4GvqC7QPKWBXDoi6KpkUlp/0uSJZbfvns=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WD6Qtv0Sh02axx6BSHidc9fhCdMLUOK4Lec+xUPnxJ7D3vjMjl2Ryx+w3uazem6OL
         6gB+d1URWrUBOBChJJdRbgDne9TOQMftsvmYyedqO6lv7WC6SxsB222hc2dk3W1Jv0
         ZZE74zGZnewmIwTeAoqSLV3E43RRcevXkl93u/RK+VMj6O/e+A3Eu81HjL9/CaKVzo
         WRMBRO3yUp21rVVbpsgDea1jGM90d0lopTSi0CHHmzgHcJQlwFAE5jPqoZ6FvVzPOU
         fjxQ2Eyvq0VMZPj53GsOi43Q89K+VXG7rCc4WHQRX52O7cqozUyfFZ168oCojUr/G1
         eRveUrGvgdt9Q==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] riscv: mm: init: try IS_ENABLED(CONFIG_XIP_KERNEL) instead of #ifdef
Date:   Fri,  3 Dec 2021 13:03:16 +0800
Message-Id: <20211203050317.2102-5-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211203050317.2102-1-jszhang@kernel.org>
References: <20211203050317.2102-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try our best to replace the conditional compilation using
"#ifdef CONFIG_XIP_KERNEL" with "IS_ENABLED(CONFIG_XIP_KERNEL)", to
simplify the code and to increase compile coverage.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/mm/init.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 4d4fcd7ef1a9..4a9e3f429042 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -161,13 +161,13 @@ early_param("mem", early_mem);
 static void __init setup_bootmem(void)
 {
 	phys_addr_t vmlinux_end = __pa_symbol(&_end);
-	phys_addr_t vmlinux_start = __pa_symbol(&_start);
 	phys_addr_t __maybe_unused max_mapped_addr;
-	phys_addr_t phys_ram_end;
+	phys_addr_t phys_ram_end, vmlinux_start;
 
-#ifdef CONFIG_XIP_KERNEL
-	vmlinux_start = __pa_symbol(&_sdata);
-#endif
+	if (IS_ENABLED(CONFIG_XIP_KERNEL))
+		vmlinux_start = __pa_symbol(&_sdata);
+	else
+		vmlinux_start = __pa_symbol(&_start);
 
 	memblock_enforce_memory_limit(memory_limit);
 
@@ -183,11 +183,9 @@ static void __init setup_bootmem(void)
 	 */
 	memblock_reserve(vmlinux_start, vmlinux_end - vmlinux_start);
 
-
 	phys_ram_end = memblock_end_of_DRAM();
-#ifndef CONFIG_XIP_KERNEL
-	phys_ram_base = memblock_start_of_DRAM();
-#endif
+	if (!IS_ENABLED(CONFIG_XIP_KERNEL))
+		phys_ram_base = memblock_start_of_DRAM();
 	/*
 	 * memblock allocator is not aware of the fact that last 4K bytes of
 	 * the addressable memory can not be mapped because of IS_ERR_VALUE
-- 
2.34.1

