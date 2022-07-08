Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1831456B249
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 07:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237217AbiGHFhx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 01:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237180AbiGHFho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 01:37:44 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EEF026AFC
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 22:37:44 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1657258662;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uxYP30zRX3+087a7ADNvtSYGr7OYdBOK6+qjv5apzug=;
        b=QmNYSzR8WxPgvEHooLZcizvFyZgAoinmGHv6QYOIerCWy+kH2jeZvEKTg+JreBmUeK+29J
        qa49GAc/9y1cLVpURCTvHcjQxSsn0b5f1rC/YVXJv5L9INjsnoKfgmZT/iJT4k3nkFrAL9
        bLYw8aaYAFzt9LBjxNgBsejCWUl8lGA=
From:   Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [mm-unstable PATCH v5 2/8] mm/hugetlb: make pud_huge() and follow_huge_pud() aware of non-present pud entry
Date:   Fri,  8 Jul 2022 14:36:47 +0900
Message-Id: <20220708053653.964464-3-naoya.horiguchi@linux.dev>
In-Reply-To: <20220708053653.964464-1-naoya.horiguchi@linux.dev>
References: <20220708053653.964464-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Naoya Horiguchi <naoya.horiguchi@nec.com>

follow_pud_mask() does not support non-present pud entry now.  As long as
I tested on x86_64 server, follow_pud_mask() still simply returns
no_page_table() for non-present_pud_entry() due to pud_bad(), so no severe
user-visible effect should happen.  But generally we should call
follow_huge_pud() for non-present pud entry for 1GB hugetlb page.

Update pud_huge() and follow_huge_pud() to handle non-present pud entries.
The changes are similar to previous works for pud entries commit e66f17ff7177
("mm/hugetlb: take page table lock in follow_huge_pmd()") and commit
cbef8478bee5 ("mm/hugetlb: pmd_huge() returns true for non-present hugepage").

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
---
v2 -> v3:
- fixed typos in subject and description,
- added comment on pud_huge(),
- added comment about fallback for hwpoisoned entry,
- updated initial check about FOLL_{PIN,GET} flags.
---
 arch/x86/mm/hugetlbpage.c |  8 +++++++-
 mm/hugetlb.c              | 32 ++++++++++++++++++++++++++++++--
 2 files changed, 37 insertions(+), 3 deletions(-)

diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
index 509408da0da1..6b3033845c6d 100644
--- a/arch/x86/mm/hugetlbpage.c
+++ b/arch/x86/mm/hugetlbpage.c
@@ -30,9 +30,15 @@ int pmd_huge(pmd_t pmd)
 		(pmd_val(pmd) & (_PAGE_PRESENT|_PAGE_PSE)) != _PAGE_PRESENT;
 }
 
+/*
+ * pud_huge() returns 1 if @pud is hugetlb related entry, that is normal
+ * hugetlb entry or non-present (migration or hwpoisoned) hugetlb entry.
+ * Otherwise, returns 0.
+ */
 int pud_huge(pud_t pud)
 {
-	return !!(pud_val(pud) & _PAGE_PSE);
+	return !pud_none(pud) &&
+		(pud_val(pud) & (_PAGE_PRESENT|_PAGE_PSE)) != _PAGE_PRESENT;
 }
 
 #ifdef CONFIG_HUGETLB_PAGE
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index cf8ccee7654c..77119d93a0f9 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6978,10 +6978,38 @@ struct page * __weak
 follow_huge_pud(struct mm_struct *mm, unsigned long address,
 		pud_t *pud, int flags)
 {
-	if (flags & (FOLL_GET | FOLL_PIN))
+	struct page *page = NULL;
+	spinlock_t *ptl;
+	pte_t pte;
+
+	if (WARN_ON_ONCE(flags & FOLL_PIN))
 		return NULL;
 
-	return pte_page(*(pte_t *)pud) + ((address & ~PUD_MASK) >> PAGE_SHIFT);
+retry:
+	ptl = huge_pte_lock(hstate_sizelog(PUD_SHIFT), mm, (pte_t *)pud);
+	if (!pud_huge(*pud))
+		goto out;
+	pte = huge_ptep_get((pte_t *)pud);
+	if (pte_present(pte)) {
+		page = pud_page(*pud) + ((address & ~PUD_MASK) >> PAGE_SHIFT);
+		if (WARN_ON_ONCE(!try_grab_page(page, flags))) {
+			page = NULL;
+			goto out;
+		}
+	} else {
+		if (is_hugetlb_entry_migration(pte)) {
+			spin_unlock(ptl);
+			__migration_entry_wait(mm, (pte_t *)pud, ptl);
+			goto retry;
+		}
+		/*
+		 * hwpoisoned entry is treated as no_page_table in
+		 * follow_page_mask().
+		 */
+	}
+out:
+	spin_unlock(ptl);
+	return page;
 }
 
 struct page * __weak
-- 
2.25.1

