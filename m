Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0B2469D04
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357113AbhLFP1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347560AbhLFPSE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:18:04 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49EBC08E83B
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 07:11:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 63A416132C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 15:11:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52BE1C341C2;
        Mon,  6 Dec 2021 15:11:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638803475;
        bh=YYjWVRV3U9MP8993oG6RsEXcX9rrLfWp3/tBMtaj+kw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kIPOtVJ0TSZca6iqQIoXetm9b3tQgBOJ5YUXwqPlmAPyNrZT7HEZwm9bl0I3smvuI
         FqdymKoWkb5iTU9ivhoCw+iwYMewOQd52G+Md5X9QZA37EmKoGFVTUPLhMY1aiM8d0
         QbNbX8nWAz9dq+rUNmp5Odsocjgc3dOFLvIQxh43coEiSV7kB3gdHAtp8H6/wqsAZ5
         1J7tgKWUs6t0HmBcmCiCCTurvZdu+2CvfTyUtH5m9kH831G2wT8YcFGzXF6XfO+lzb
         rxfUlBVC/+aBLf4vObDPFSIghnXYN78GJwZA/KMrcMqPZBY2ntihl7O3fzLc9+Rktk
         zLTIhH/2mynaw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alexandre Ghiti <alex@ghiti.fr>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] riscv: mm: init: try IS_ENABLED(CONFIG_XIP_KERNEL) instead of #ifdef
Date:   Mon,  6 Dec 2021 23:03:52 +0800
Message-Id: <20211206150353.731-5-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211206150353.731-1-jszhang@kernel.org>
References: <20211206150353.731-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Try our best to replace the conditional compilation using
"#ifdef CONFIG_XIP_KERNEL" with "IS_ENABLED(CONFIG_XIP_KERNEL)", to
simplify the code and to increase compile coverage.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
Reviewed-by: Alexandre Ghiti <alex@ghiti.fr>
---
 arch/riscv/mm/init.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 9c5816971f40..5e979fe06054 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -161,13 +161,13 @@ early_param("mem", early_mem);
 static void __init setup_bootmem(void)
 {
 	phys_addr_t vmlinux_end = __pa_symbol(&_end);
-	phys_addr_t vmlinux_start = __pa_symbol(&_start);
 	phys_addr_t max_mapped_addr;
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

