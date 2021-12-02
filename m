Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0B574666EF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 16:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347883AbhLBPrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 10:47:20 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:47060 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbhLBPrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 10:47:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B7428B82245
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 15:43:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C00AFC00446;
        Thu,  2 Dec 2021 15:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638459834;
        bh=BDRSNL9BJAP1UjvZCjvjufVD+ftasp+KJrQWz/J5q1w=;
        h=From:To:Cc:Subject:Date:From;
        b=cA+D8334NBV6lGyNqEo8UikXSUjyLMlNO3yixR3uWqsVcYSemQyRvSHXUrGkXLd4N
         v/VP1T7ZxJeaoQ4twH5/pby+NC6qLcMx5VmIGNM2hxa9sLyM4FbkJDTxtB2NAIeYeg
         6nGzpN0MroGLquFPPY3pdOqtXGA2RZWbn7OOMKIVExewxUeig19Sguy/IJzzIzpxpr
         +pU3ux2BWzL4cu2Z6gGDGnnrcR30OE25891kmczOJ5m/Ot45SfC1MkTBDDZWxpiNUN
         VW+5bsVCYjGdrNMuDEqfPRz4lQjj1tV3MizJ90njnCPeIiE75cdIWswhr8XYLmJBP6
         18sQ1mMeiYyJw==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     Alexandre Ghiti <alex@ghiti.fr>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] riscv: mm: fix wrong phys_ram_base value for RV64
Date:   Thu,  2 Dec 2021 23:36:41 +0800
Message-Id: <20211202153641.1961-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if 64BIT and !XIP_KERNEL, the phys_ram_base is always 0,
no matter the real start of dram reported by memblock is. The original
patch[1] is correct, I believe it's not corrected merged due to lots
of #ifdef in arch/riscv/mm/init.c, I plan to send a clean up series
soon.

[1] http://lists.infradead.org/pipermail/linux-riscv/2021-July/007650.html

Fixes: 6d7f91d914bc ("riscv: Get rid of CONFIG_PHYS_RAM_BASE in kernel physical address conversion")
Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/mm/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 24b2b8044602..3c0649dba4ff 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -187,10 +187,10 @@ static void __init setup_bootmem(void)
 
 
 	phys_ram_end = memblock_end_of_DRAM();
-#ifndef CONFIG_64BIT
 #ifndef CONFIG_XIP_KERNEL
 	phys_ram_base = memblock_start_of_DRAM();
 #endif
+#ifndef CONFIG_64BIT
 	/*
 	 * memblock allocator is not aware of the fact that last 4K bytes of
 	 * the addressable memory can not be mapped because of IS_ERR_VALUE
-- 
2.34.1

