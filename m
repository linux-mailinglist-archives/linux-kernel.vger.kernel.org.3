Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E3A528741
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 16:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244603AbiEPOkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 10:40:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232814AbiEPOkp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 10:40:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60A43B3D
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 07:40:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 13411B81247
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 14:40:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EC54C385AA;
        Mon, 16 May 2022 14:40:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652712039;
        bh=/LjZDM0tlNGi7ZrpCRvjcDx6kOF+zSUPdV+ox6kBvhU=;
        h=From:To:Cc:Subject:Date:From;
        b=NJhtJktX0yTMk0aDnZn0NnEzXf5PBQJ8E2hc3f+ckAZ4A00WEXhePXoXwowYigGfc
         XUoiWOmt6bZi0s9o2PrBxpl4JR51Jyg6komF7j1F+G74ud4ZYbsfyVqN3H3mZ6KPnN
         3yZ5d9g/FoHguUTCvqH0MtbTiRN1z/nRi8B13sXbIntKjfaAD6xGez/Kvh07MPMXA1
         T0rB8jf04krNXuZGCtUtgPdLGMprVpao3c9nEKboEZtytrqvf0m0S58W/Tk7Omjl/1
         C3D/oL4trXu7FRzyqmuIFFdWqk6cSXv1QcNk4g8/RwLD0c3SnElMksJMyG0jTtKZeu
         8RTutvHVklLPQ==
From:   Jisheng Zhang <jszhang@kernel.org>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [PATCH v2] riscv: mm: init: make pt_ops_set_[early|late|fixmap] static
Date:   Mon, 16 May 2022 22:32:04 +0800
Message-Id: <20220516143204.2603-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Reviewed-by: Anup Patel <anup@brainfault.org>
---

since v1:
 - collect Reviewed-by tag
 - move out from the static key series as a separate patch

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

