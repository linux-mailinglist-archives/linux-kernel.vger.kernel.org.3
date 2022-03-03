Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A69B14CC8BA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 23:20:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236803AbiCCWVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 17:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236729AbiCCWVE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 17:21:04 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1252810A7E3
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 14:20:18 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id q11so6022488pln.11
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 14:20:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i+jhSHjqTSR2b7tP60Q6oAqpuTejuyJKZJEpX0NApkc=;
        b=XyAJUTQ4WSbV0ZyMFvjiRuolDwAoBCGZtPOcZOv7DEcHXHhJ299eb8alyt7lrHlu59
         CbD3DKrch2N1D3gLJ/bGZE2r5qBFdEiXN7AFlrNeumYPduVhNF6RzWVDmrr1vUjuBJJX
         N3mhBWlPcKo/qIUnGACQl+mA3ssd1t/Dj/jODZNjNWLv6IWIS/N4ZNTIOCmY1LEHWG5F
         jB2s9TqRRwLl0ETtLcCEV8fM3IieaSAvH0gxWxn4ATX1kEcbuRwbi/UuA8LnpoSwLHoE
         O3z1/cByBoQlobWc0WOqoEhtSwwl6cTpNmkGxcVOaN5hBT2rpO63LFIHvjlu0bbXxdxj
         OuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=i+jhSHjqTSR2b7tP60Q6oAqpuTejuyJKZJEpX0NApkc=;
        b=Cwps325wGRL2kn/r/+ns+Co8V4BV7hIf4lHVxKRHXkNqycFWplhpclDoZsrSNcCYDq
         9MIEYrSvxsYIWXe29elcuvRWk1IcteDrUp7AWDVKRQorctjyUNI9wVonr7MSz2DkJWjP
         BppvZxlilZHiyV95wO/g8+ztFw7fpXn8W/J9DCF+pR4rEmReln3PfCrIkALKp7d7SrtM
         oMMbWL3GaWAtpX2++O5VyBlVgV8SG0F0GLlJ4XBZTqk5ejKRhqWUCU/p/Xy5y3e+CWsy
         nyQJHulf4+W4YzPfq2+Jd0gTOdlqUYvewT63doZFMvBI6o8mbm/aCBX8x/tQf4wgvbh9
         ePLw==
X-Gm-Message-State: AOAM530LLnC18fJThBqT7Ih5K0nBlNxy1eYWuUcAkWINQZZMH6PZTFWh
        Bis0ctFDpI5AZ/otlIxfLf4=
X-Google-Smtp-Source: ABdhPJwRrG9E7twGHq/irRPt/iu4Nnxg+Oyd48nX0497BwVHi+gDwkd77MOdUbrwvBTRn4gCGupj9A==
X-Received: by 2002:a17:903:2342:b0:14f:dec2:9849 with SMTP id c2-20020a170903234200b0014fdec29849mr28439484plh.74.1646346017514;
        Thu, 03 Mar 2022 14:20:17 -0800 (PST)
Received: from localhost.localdomain (c-67-174-241-145.hsd1.ca.comcast.net. [67.174.241.145])
        by smtp.gmail.com with ESMTPSA id lx7-20020a17090b4b0700b001b7d5b6d10asm2862172pjb.48.2022.03.03.14.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 14:20:16 -0800 (PST)
From:   Yang Shi <shy828301@gmail.com>
To:     david@redhat.com, aarcange@redhat.com, hughd@google.com,
        kirill.shutemov@linux.intel.com, akpm@linux-foundation.org
Cc:     shy828301@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mm: thp: don't have to lock page anymore when splitting PMD
Date:   Thu,  3 Mar 2022 14:20:14 -0800
Message-Id: <20220303222014.517033-1-shy828301@gmail.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit c444eb564fb1 ("mm: thp: make the THP mapcount atomic against
__split_huge_pmd_locked()") locked the page for PMD split to make
mapcount stable for reuse_swap_page(), then commit 1c2f67308af4 ("mm:
thp: fix MADV_REMOVE deadlock on shmem THP") reduce the scope to
anonymous page only.

However COW has not used mapcount to determine if the page is shared or
not anymore due to the COW fixes [1] from David Hildenbrand and the
reuse_swap_page() was removed as well.  So PMD split doesn't have to
lock the page anymore.  This patch basically reverted the above two
commits.

[1] https://lore.kernel.org/linux-mm/20220131162940.210846-1-david@redhat.com/

Cc: David Hildenbrand <david@redhat.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Hugh Dickins <hughd@google.com>
Cc: "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Signed-off-by: Yang Shi <shy828301@gmail.com>
---
 mm/huge_memory.c | 44 +++++---------------------------------------
 1 file changed, 5 insertions(+), 39 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index b49e1a11df2e..daaa698bd273 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2134,8 +2134,6 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 {
 	spinlock_t *ptl;
 	struct mmu_notifier_range range;
-	bool do_unlock_folio = false;
-	pmd_t _pmd;
 
 	mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, vma->vm_mm,
 				address & HPAGE_PMD_MASK,
@@ -2148,48 +2146,16 @@ void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
 	 * pmd against. Otherwise we can end up replacing wrong folio.
 	 */
 	VM_BUG_ON(freeze && !folio);
-	if (folio) {
-		VM_WARN_ON_ONCE(!folio_test_locked(folio));
-		if (folio != page_folio(pmd_page(*pmd)))
-			goto out;
-	}
+	if (folio && folio != page_folio(pmd_page(*pmd)))
+		goto out;
 
-repeat:
-	if (pmd_trans_huge(*pmd)) {
-		if (!folio) {
-			folio = page_folio(pmd_page(*pmd));
-			/*
-			 * An anonymous page must be locked, to ensure that a
-			 * concurrent reuse_swap_page() sees stable mapcount;
-			 * but reuse_swap_page() is not used on shmem or file,
-			 * and page lock must not be taken when zap_pmd_range()
-			 * calls __split_huge_pmd() while i_mmap_lock is held.
-			 */
-			if (folio_test_anon(folio)) {
-				if (unlikely(!folio_trylock(folio))) {
-					folio_get(folio);
-					_pmd = *pmd;
-					spin_unlock(ptl);
-					folio_lock(folio);
-					spin_lock(ptl);
-					if (unlikely(!pmd_same(*pmd, _pmd))) {
-						folio_unlock(folio);
-						folio_put(folio);
-						folio = NULL;
-						goto repeat;
-					}
-					folio_put(folio);
-				}
-				do_unlock_folio = true;
-			}
-		}
-	} else if (!(pmd_devmap(*pmd) || is_pmd_migration_entry(*pmd)))
+	if (!(pmd_devmap(*pmd) || is_pmd_migration_entry(*pmd)))
 		goto out;
+
 	__split_huge_pmd_locked(vma, pmd, range.start, freeze);
 out:
 	spin_unlock(ptl);
-	if (do_unlock_folio)
-		folio_unlock(folio);
+
 	/*
 	 * No need to double call mmu_notifier->invalidate_range() callback.
 	 * They are 3 cases to consider inside __split_huge_pmd_locked():
-- 
2.26.3

