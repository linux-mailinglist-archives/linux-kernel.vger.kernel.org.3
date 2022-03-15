Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754104D9790
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346563AbiCOJYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbiCOJYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:24:45 -0400
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B185B65E0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 02:23:30 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.2.5.185])
        by mail.loongson.cn (Coremail) with SMTP id AQAAf9BxAM8LWzBiLrAJAA--.30383S2;
        Tue, 15 Mar 2022 17:23:24 +0800 (CST)
From:   Bibo Mao <maobibo@loongson.cn>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] mm: add access/dirty bit on numa page fault
Date:   Tue, 15 Mar 2022 05:23:23 -0400
Message-Id: <20220315092323.620610-1-maobibo@loongson.cn>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf9BxAM8LWzBiLrAJAA--.30383S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur47tr13AF4DJFW3Ww45KFg_yoW8ArWUpF
        93C3yjganrXrn7Aa13GFn0yr15Xa48Ka48Ar9xtw1qqws8Wrn7uayUW3yS9aykGry8tw4D
        Jr4UWFW8CF48Xw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnUUvcSsGvfC2KfnxnUUI43ZEXa7xR_UUUUUUUUU==
X-CM-SenderInfo: xpdruxter6z05rqj20fqof0/
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During numa page fault, dirty bit can be added for old pte if
fail to migrate on write fault. And if it succeeds to migrate,
access bit can be added for migrated new pte, also dirty bit
can be added for write fault.

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
---
 mm/memory.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/mm/memory.c b/mm/memory.c
index c125c4969913..65813bec9c06 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -4404,6 +4404,22 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	if (migrate_misplaced_page(page, vma, target_nid)) {
 		page_nid = target_nid;
 		flags |= TNF_MIGRATED;
+
+		/*
+		 * update pte entry with access bit, and dirty bit for
+		 * write fault
+		 */
+		spin_lock(vmf->ptl);
+		pte = *vmf->pte;
+		pte = pte_mkyoung(pte);
+		if (was_writable) {
+			pte = pte_mkwrite(pte);
+			if (vmf->flags & FAULT_FLAG_WRITE)
+				pte = pte_mkdirty(pte);
+		}
+		set_pte_at(vma->vm_mm, vmf->address, vmf->pte, pte);
+		update_mmu_cache(vma, vmf->address, vmf->pte);
+		pte_unmap_unlock(vmf->pte, vmf->ptl);
 	} else {
 		flags |= TNF_MIGRATE_FAIL;
 		vmf->pte = pte_offset_map(vmf->pmd, vmf->address);
@@ -4427,8 +4443,11 @@ static vm_fault_t do_numa_page(struct vm_fault *vmf)
 	old_pte = ptep_modify_prot_start(vma, vmf->address, vmf->pte);
 	pte = pte_modify(old_pte, vma->vm_page_prot);
 	pte = pte_mkyoung(pte);
-	if (was_writable)
+	if (was_writable) {
 		pte = pte_mkwrite(pte);
+		if (vmf->flags & FAULT_FLAG_WRITE)
+			pte = pte_mkdirty(pte);
+	}
 	ptep_modify_prot_commit(vma, vmf->address, vmf->pte, old_pte, pte);
 	update_mmu_cache(vma, vmf->address, vmf->pte);
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
-- 
2.31.1

