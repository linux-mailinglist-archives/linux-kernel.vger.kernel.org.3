Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D72351EEE8
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 18:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235514AbiEHQU1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 12:20:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbiEHQUY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 12:20:24 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B393B1C2
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 09:16:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6D059CE0F0B
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 16:16:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCB75C385A4;
        Sun,  8 May 2022 16:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652026589;
        bh=cai4u5JKDr1cLjhdt9yaycCa4Y3iBnxfkpZjmnNWcVw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mdPAo0t5mrvr4GmAHEi7fUpzOr52OdPOdTfvMG2GDQeOpWO4nWnz+BT8ei8S8bldv
         KGF56HqI6nCm50Jia/awUHAqUlXLc5KirY9OTAv+cDqV+3VHJOJNG66cS9GlDqP5wP
         l4+sOr1tt2o3b7/L6ifGSp7h0MxMkLSy9wfI8RXXzx5TJtIaSd8MK8o9VM+DXOt7xy
         Po0SUd/H6NhU4PshiM8nAIBCnU85lUhGkdQXtmz5iY5gMnEkGC3VQTcQBPLoRKq/D9
         bESc0bsVD7erCPt7hJGlgaoO0YbJUdtISbpRRey/rCYsW+7jIV+hrrQTGz/IPqvvYI
         biSZhsinVL0Rg==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Alexandre Ghiti <alexandre.ghiti@canonical.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: [PATCH v2 1/4] riscv: mm: init: make pt_ops_set_[early|late|fixmap] static
Date:   Mon,  9 May 2022 00:07:46 +0800
Message-Id: <20220508160749.984-2-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220508160749.984-1-jszhang@kernel.org>
References: <20220508160749.984-1-jszhang@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These three functions are only used in init.c, so make them static.
Fix W=1 warnings like below:

arch/riscv/mm/init.c:721:13: warning: no previous prototype for function
'pt_ops_set_early' [-Wmissing-prototypes]
   void __init pt_ops_set_early(void)
               ^

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 arch/riscv/mm/init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
index 05ed641a1134..5f3f26dd9f21 100644
--- a/arch/riscv/mm/init.c
+++ b/arch/riscv/mm/init.c
@@ -849,7 +849,7 @@ static void __init create_fdt_early_page_table(pgd_t *pgdir, uintptr_t dtb_pa)
  * MMU is not enabled, the page tables are allocated directly using
  * early_pmd/pud/p4d and the address returned is the physical one.
  */
-void __init pt_ops_set_early(void)
+static void __init pt_ops_set_early(void)
 {
 	pt_ops.alloc_pte = alloc_pte_early;
 	pt_ops.get_pte_virt = get_pte_virt_early;
@@ -871,7 +871,7 @@ void __init pt_ops_set_early(void)
  * Note that this is called with MMU disabled, hence kernel_mapping_pa_to_va,
  * but it will be used as described above.
  */
-void __init pt_ops_set_fixmap(void)
+static void __init pt_ops_set_fixmap(void)
 {
 	pt_ops.alloc_pte = kernel_mapping_pa_to_va((uintptr_t)alloc_pte_fixmap);
 	pt_ops.get_pte_virt = kernel_mapping_pa_to_va((uintptr_t)get_pte_virt_fixmap);
@@ -889,7 +889,7 @@ void __init pt_ops_set_fixmap(void)
  * MMU is enabled and page table setup is complete, so from now, we can use
  * generic page allocation functions to setup page table.
  */
-void __init pt_ops_set_late(void)
+static void __init pt_ops_set_late(void)
 {
 	pt_ops.alloc_pte = alloc_pte_late;
 	pt_ops.get_pte_virt = get_pte_virt_late;
-- 
2.34.1

