Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDD68476BEA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 09:28:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232508AbhLPI2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 03:28:33 -0500
Received: from foss.arm.com ([217.140.110.172]:39962 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229979AbhLPI2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 03:28:32 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5EF6D1042;
        Thu, 16 Dec 2021 00:28:32 -0800 (PST)
Received: from entos-thunderx2-desktop.shanghai.arm.com (entos-thunderx2-desktop.shanghai.arm.com [10.169.212.208])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 72F233F774;
        Thu, 16 Dec 2021 00:28:28 -0800 (PST)
From:   Jianyong Wu <jianyong.wu@arm.com>
To:     catalin.marinas@arm.com, will@kernel.org,
        anshuman.khandual@arm.com, akpm@linux-foundation.org,
        david@redhat.com
Cc:     quic_qiancai@quicinc.com, ardb@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        gshan@redhat.com, justin.he@arm.com, jianyong.wu@arm.com,
        nd@arm.com
Subject: [PATCH v3] arm64/mm: avoid fixmap race condition when create pud mapping
Date:   Thu, 16 Dec 2021 16:28:12 +0800
Message-Id: <20211216082812.165387-1-jianyong.wu@arm.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'fixmap' is a global resource and is used recursively by
create pud mapping(), leading to a potential race condition in the
presence of a concurrent call to alloc_init_pud():

kernel_init thread                          virtio-mem workqueue thread
==================                          ===========================

  alloc_init_pud(...)                       alloc_init_pud(...)
  pudp = pud_set_fixmap_offset(...)         pudp = pud_set_fixmap_offset(...)
  READ_ONCE(*pudp)
  pud_clear_fixmap(...)
                                            READ_ONCE(*pudp) // CRASH!

As kernel may sleep during creating pud mapping, introduce a mutex lock to
serialise use of the fixmap entries by alloc_init_pud().

Signed-off-by: Jianyong Wu <jianyong.wu@arm.com>
---

Change log:

from v2 to v3:
     change spin lock to mutex lock as kernel may sleep when create pud
map.

 arch/arm64/mm/mmu.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index acfae9b41cc8..e680a6a8ca40 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -63,6 +63,7 @@ static pmd_t bm_pmd[PTRS_PER_PMD] __page_aligned_bss __maybe_unused;
 static pud_t bm_pud[PTRS_PER_PUD] __page_aligned_bss __maybe_unused;
 
 static DEFINE_SPINLOCK(swapper_pgdir_lock);
+static DEFINE_MUTEX(fixmap_lock);
 
 void set_swapper_pgd(pgd_t *pgdp, pgd_t pgd)
 {
@@ -329,6 +330,11 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
 	}
 	BUG_ON(p4d_bad(p4d));
 
+	/*
+	 * We only have one fixmap entry per page-table level, so take
+	 * the fixmap lock until we're done.
+	 */
+	mutex_lock(&fixmap_lock);
 	pudp = pud_set_fixmap_offset(p4dp, addr);
 	do {
 		pud_t old_pud = READ_ONCE(*pudp);
@@ -359,6 +365,7 @@ static void alloc_init_pud(pgd_t *pgdp, unsigned long addr, unsigned long end,
 	} while (pudp++, addr = next, addr != end);
 
 	pud_clear_fixmap();
+	mutex_unlock(&fixmap_lock);
 }
 
 static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
-- 
2.17.1

