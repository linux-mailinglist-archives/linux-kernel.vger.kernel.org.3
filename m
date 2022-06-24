Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F156E55A00F
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbiFXRha (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:37:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231757AbiFXRh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:37:26 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01AA9609CA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:26 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2eb7d137101so26909517b3.12
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=5N1QqSZZ3sAe7uqZbPvcX1MwgZtWBTxE3Z4UbaM2Ubk=;
        b=q+mTw9aXiewEEPn69Lo/c9WP/AOoUrPORPuTtAp49sBVoij1KAB/iU1Xsmfcz2RONi
         97ZReXD54tQvzGoEYGUk7bqiHAMjMBdSDeN0ZeRlmES9GnpySAERBNIAd4xcYCwSqWB9
         7rTzJ5T7Icb9PLM1GoXpIL2LTZ8f3PW3xI9Uskzsm3fmgHe4+UJzlKEwXBwzjTskVRhP
         jO0DeJtpPQFYq6QRquH/FNG3s47JBo454bcpHh+Nv3bPhNDZ/+ST1no2b8ufY9BNObOU
         06CUcUjjHu4D3yaQIgx4SDUgySvd1FhGM2vQVwgOwraU6Bc5o7byEvf4kBsFdHoToBy1
         X8+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=5N1QqSZZ3sAe7uqZbPvcX1MwgZtWBTxE3Z4UbaM2Ubk=;
        b=wc5JqplZlU/TJBrqEk3YmSJVsRKykt62LmmjI1Hru0SuTvVjGLoRJSxJ5cPkHNN36h
         pC56PjoHv52BRoyfnHH8pSJqDmMgHJHYoOSjFC8U5WvzpWSwtAPpy6u2ZAKiQ+FD9end
         teNarHp6lirbGsOVgBKXOcNSsSkX5XHLSSh4ZIqH/Q0YVjCJr2H78p8oHXAyuwaCtdRC
         C8k3/FcIgOn0oMub1Mk7xV6HJHk4gmRoeVXlkvjoP2ktPsgWlOHKycMYwoVVibgBVSHF
         yREz+ImbeEbSluPoklWwjlJlwiiyfrhaTr0JludJp9OGcx5cobL93uHljWkrnIZxlI6i
         WSBg==
X-Gm-Message-State: AJIora+ZWdejjUnZ8F5FPvtPj3mQ6pUVr0cZLgKczNbWO1zoGR11/Q/V
        FDGacpgOTINULISu4PoqYdwV4DB1aVT5WQAA
X-Google-Smtp-Source: AGRyM1s7zrxwUtB89vtQHWN8oyQ64yZ//LRbGigtUbZGCP3Sqfb2xmvuSoQ6VmyGFOOMey8Bgk7vqBsKoi9rXZ66
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a25:9103:0:b0:668:b7f8:b428 with SMTP
 id v3-20020a259103000000b00668b7f8b428mr309298ybl.270.1656092245324; Fri, 24
 Jun 2022 10:37:25 -0700 (PDT)
Date:   Fri, 24 Jun 2022 17:36:41 +0000
In-Reply-To: <20220624173656.2033256-1-jthoughton@google.com>
Message-Id: <20220624173656.2033256-12-jthoughton@google.com>
Mime-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [RFC PATCH 11/26] hugetlb: add hugetlb_walk_to to do PT walks
From:   James Houghton <jthoughton@google.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>
Cc:     David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        James Houghton <jthoughton@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds it for architectures that use GENERAL_HUGETLB, including x86.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 include/linux/hugetlb.h |  2 ++
 mm/hugetlb.c            | 45 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index e7a6b944d0cc..605aa19d8572 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -258,6 +258,8 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 			unsigned long addr, unsigned long sz);
 pte_t *huge_pte_offset(struct mm_struct *mm,
 		       unsigned long addr, unsigned long sz);
+int hugetlb_walk_to(struct mm_struct *mm, struct hugetlb_pte *hpte,
+		    unsigned long addr, unsigned long sz, bool stop_at_none);
 int huge_pmd_unshare(struct mm_struct *mm, struct vm_area_struct *vma,
 				unsigned long *addr, pte_t *ptep);
 void adjust_range_if_pmd_sharing_possible(struct vm_area_struct *vma,
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 557b0afdb503..3ec2a921ee6f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6981,6 +6981,51 @@ pte_t *huge_pte_offset(struct mm_struct *mm,
 	return (pte_t *)pmd;
 }
 
+int hugetlb_walk_to(struct mm_struct *mm, struct hugetlb_pte *hpte,
+		    unsigned long addr, unsigned long sz, bool stop_at_none)
+{
+	pte_t *ptep;
+
+	if (!hpte->ptep) {
+		pgd_t *pgd = pgd_offset(mm, addr);
+
+		if (!pgd)
+			return -ENOMEM;
+		ptep = (pte_t *)p4d_alloc(mm, pgd, addr);
+		if (!ptep)
+			return -ENOMEM;
+		hugetlb_pte_populate(hpte, ptep, P4D_SHIFT);
+	}
+
+	while (hugetlb_pte_size(hpte) > sz &&
+			!hugetlb_pte_present_leaf(hpte) &&
+			!(stop_at_none && hugetlb_pte_none(hpte))) {
+		if (hpte->shift == PMD_SHIFT) {
+			ptep = pte_alloc_map(mm, (pmd_t *)hpte->ptep, addr);
+			if (!ptep)
+				return -ENOMEM;
+			hpte->shift = PAGE_SHIFT;
+			hpte->ptep = ptep;
+		} else if (hpte->shift == PUD_SHIFT) {
+			ptep = (pte_t *)pmd_alloc(mm, (pud_t *)hpte->ptep,
+						  addr);
+			if (!ptep)
+				return -ENOMEM;
+			hpte->shift = PMD_SHIFT;
+			hpte->ptep = ptep;
+		} else if (hpte->shift == P4D_SHIFT) {
+			ptep = (pte_t *)pud_alloc(mm, (p4d_t *)hpte->ptep,
+						  addr);
+			if (!ptep)
+				return -ENOMEM;
+			hpte->shift = PUD_SHIFT;
+			hpte->ptep = ptep;
+		} else
+			BUG();
+	}
+	return 0;
+}
+
 #endif /* CONFIG_ARCH_WANT_GENERAL_HUGETLB */
 
 #ifdef CONFIG_HUGETLB_HIGH_GRANULARITY_MAPPING
-- 
2.37.0.rc0.161.g10f37bed90-goog

