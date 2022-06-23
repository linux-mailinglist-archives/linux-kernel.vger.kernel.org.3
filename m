Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225D3558BF3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 01:52:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbiFWXwk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 19:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiFWXwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 19:52:38 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00B060C47
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 16:52:37 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id m14so621330plg.5
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 16:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gLXI0bFmtdpL1fm2aZ9vhvRpJm3p+mQNTKIlYsIrOjU=;
        b=n3EpWNne89DpkqcHeRXrJ15yy+IykIai7ornumZPTFP3oBklmi1A9IfZR2B/qtHRBE
         fEhmAFan4uUC7OrYWIDjV7OSRH6ALcWMbKnDZSnGBAIPyEKvGE2GD8iLzFiQWbhjOx8P
         IFNuSd9GajJZepS7jAVhRX8+KQZnAlpgD4YGn66q6n+VtWWRkfFQljjadM7UsZJhdNcu
         W5am1TruDf29uTRDkrxWzSbMs3OV9pweR6PMVYdkYTxMG98IlJmK7MRM3Pe2tLTOpxMP
         w9fq/O2WZelM6ft+W/kTXDjoHIMwggETk7IWGuE//bekvG8z5qhjUlCrGxuudfCbY2gV
         /lcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gLXI0bFmtdpL1fm2aZ9vhvRpJm3p+mQNTKIlYsIrOjU=;
        b=wURwaRGzHKOQr/n48YjdU260iq3jESUwQi5hO4l3PLWCY9nEuoKxkk8vYiNY8/dQF7
         MG2qbDtbcXLx9ADYheIUQqbp1yVLzA5LdxsC2rglP4qcqmpVQOoq8mu8r5rrAC6PT/fu
         Iwr1bTtFH8gTnPQ9whsYoWEw91SOD6BjFsox6UGdrk+hZOEP6PPWMLNNSho864R1gnwk
         oDE1BNqHwkZz6MB/b9k7im1T8mkam17Qoh6VfP1QGjGms2cIjOP2IEk7FF7V/o+Q1lQm
         GZpl7IvenaX5xP94IG1cumeWi83Pejq3NXMiJsTE+gadxSOaYQM0Q4KT3vt61OGAWIn4
         WHug==
X-Gm-Message-State: AJIora9OcV7y0fJtaDGul3F1FVPWCYJGUkm/myv+CIUHlpiXkwotI6U0
        3HkpDYsPBMUo9BDevOJWXg==
X-Google-Smtp-Source: AGRyM1swwZN4zwkDXsQnlRX7chaljh2k4qwXaQviyOxNxdAje8fNl06jiLeDO1ZeRVZ07VAF4OC9+g==
X-Received: by 2002:a17:903:2350:b0:16a:4246:f1b6 with SMTP id c16-20020a170903235000b0016a4246f1b6mr12420841plh.35.1656028357207;
        Thu, 23 Jun 2022 16:52:37 -0700 (PDT)
Received: from ik1-406-35019.vs.sakura.ne.jp (ik1-406-35019.vs.sakura.ne.jp. [153.127.16.23])
        by smtp.gmail.com with ESMTPSA id r10-20020a170903020a00b00168eab11f67sm362571plh.94.2022.06.23.16.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 16:52:36 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
X-Google-Original-From: Naoya Horiguchi <naoya.horiguchi@linux.dev>
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
Subject: [PATCH v2 3/9] mm/hugetlb: make pud_huge() and huge_pud() aware of non-present pud entry
Date:   Fri, 24 Jun 2022 08:51:47 +0900
Message-Id: <20220623235153.2623702-4-naoya.horiguchi@linux.dev>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
References: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

Update pud_huge() and huge_pud() to handle non-present pud entries.  The
changes are similar to previous works for pud entries commit e66f17ff7177
("mm/hugetlb: take page table lock in follow_huge_pmd()") and commit
cbef8478bee5 ("mm/hugetlb: pmd_huge() returns true for non-present hugepage").

Signed-off-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
---
 arch/x86/mm/hugetlbpage.c |  3 ++-
 mm/hugetlb.c              | 26 +++++++++++++++++++++++++-
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/hugetlbpage.c b/arch/x86/mm/hugetlbpage.c
index a0d023cb4292..5fb86fb49ba8 100644
--- a/arch/x86/mm/hugetlbpage.c
+++ b/arch/x86/mm/hugetlbpage.c
@@ -70,7 +70,8 @@ int pmd_huge(pmd_t pmd)
 
 int pud_huge(pud_t pud)
 {
-	return !!(pud_val(pud) & _PAGE_PSE);
+	return !pud_none(pud) &&
+		(pud_val(pud) & (_PAGE_PRESENT|_PAGE_PSE)) != _PAGE_PRESENT;
 }
 #endif
 
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f59f43c06601..b7ae5f73f3b2 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6946,10 +6946,34 @@ struct page * __weak
 follow_huge_pud(struct mm_struct *mm, unsigned long address,
 		pud_t *pud, int flags)
 {
+	struct page *page = NULL;
+	spinlock_t *ptl;
+	pte_t pte;
+
 	if (flags & (FOLL_GET | FOLL_PIN))
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
+	}
+out:
+	spin_unlock(ptl);
+	return page;
 }
 
 struct page * __weak
-- 
2.25.1

