Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B2DD55A039
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbiFXRhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231510AbiFXRhV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:37:21 -0400
Received: from mail-ua1-x949.google.com (mail-ua1-x949.google.com [IPv6:2607:f8b0:4864:20::949])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35EF05DF3E
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:21 -0700 (PDT)
Received: by mail-ua1-x949.google.com with SMTP id g21-20020ab02455000000b0037f227fdc94so1016494uan.10
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LYP6EWO0tHkDZ/Eb/N4ct/rtumW77ceMKYt6OWO28gw=;
        b=XFGCLL1FPCDch3s8zoHY1/aiVrNxiWrnh/6o6qV/K2RAwhUG1NoqoYSivh5BlEjSSN
         JSeDqdD7wmJqUHehWTyabP/SFxoPxLcdmJQciamvw0zZEkmrFOLEfH5MKvY7BMKKaRs5
         OeQHOUrdz9iPL7xkNs8N8nJEHEVe58C79l9VExLO0snSG9Lzk432UZi5FNR67YMTpjNb
         nWD0bA1/rl29atfGjcsEE2x8Ah2JCvGLGQcQO7+KX8SrBMuFX9ufi1FM9t5s4yyq73GD
         HMYrizZfRIn1go+aVU8Gs1V6ny5gGjt1jqAVjKkGM9IiyAl9gtwolhjj4PEcCHbqvzlV
         R5nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LYP6EWO0tHkDZ/Eb/N4ct/rtumW77ceMKYt6OWO28gw=;
        b=Xbjlai8HJblQNR4MXddm3IrZpIt07whGkmf8QNrs9IMMwCWHhAR/uoGi9CEMoHqaSZ
         WNPjsNQOkHkCPId9x7BoZMgeQqYPfBaoFubJZdY1uEztY5ArfK6RkGPxvy+/nqDCqk32
         n4YfQi0gF2Os2O4EOud95873Q1cgqSjhNw/dTRC0EWGK+HwAVSmsFHwBrWqudfU6VlV1
         qaxI38RTaTQ11DH01EQmYB7vl0YuoGxf9i205OdYsdk7kTzZMhkkuIvA0tictQs4wkPH
         9wUHkiNuBOqP84MZ1MyHSlEm3IixL2TbpKB2HW+e2ddjlb7xR9W07+bcX2ragW7EuE3e
         Qr/g==
X-Gm-Message-State: AJIora8tujQEcdfTbZwq0ghOhXc+epdwuAtrQ2lTMPSs5t0D0uzjzhuq
        b2Y/rE1Mva2KTMvjepcPpeEF1fHdoACxq7wB
X-Google-Smtp-Source: AGRyM1ssMLMIRbwDkEduAqDq4DS/T59s9retjKTDy0iTSci5NwCImR9/ISla7A1bU/FQrm45/Cl8LL0Be0TLQc6l
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a05:6102:374d:b0:34c:1f02:aa59 with
 SMTP id u13-20020a056102374d00b0034c1f02aa59mr21351211vst.21.1656092240411;
 Fri, 24 Jun 2022 10:37:20 -0700 (PDT)
Date:   Fri, 24 Jun 2022 17:36:38 +0000
In-Reply-To: <20220624173656.2033256-1-jthoughton@google.com>
Message-Id: <20220624173656.2033256-9-jthoughton@google.com>
Mime-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [RFC PATCH 08/26] hugetlb: add hugetlb_free_range to free PT structures
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

This is a helper function for freeing the bits of the page table that
map a particular HugeTLB PTE.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 include/linux/hugetlb.h |  2 ++
 mm/hugetlb.c            | 17 +++++++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
index 1d4ec9dfdebf..33ba48fac551 100644
--- a/include/linux/hugetlb.h
+++ b/include/linux/hugetlb.h
@@ -107,6 +107,8 @@ bool hugetlb_pte_none_mostly(const struct hugetlb_pte *hpte);
 pte_t hugetlb_ptep_get(const struct hugetlb_pte *hpte);
 void hugetlb_pte_clear(struct mm_struct *mm, const struct hugetlb_pte *hpte,
 		       unsigned long address);
+void hugetlb_free_range(struct mmu_gather *tlb, const struct hugetlb_pte *hpte,
+			unsigned long start, unsigned long end);
 
 struct hugepage_subpool {
 	spinlock_t lock;
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1a1434e29740..a2d2ffa76173 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1120,6 +1120,23 @@ static bool vma_has_reserves(struct vm_area_struct *vma, long chg)
 	return false;
 }
 
+void hugetlb_free_range(struct mmu_gather *tlb, const struct hugetlb_pte *hpte,
+			unsigned long start, unsigned long end)
+{
+	unsigned long floor = start & hugetlb_pte_mask(hpte);
+	unsigned long ceiling = floor + hugetlb_pte_size(hpte);
+
+	if (hugetlb_pte_size(hpte) >= PGDIR_SIZE) {
+		free_p4d_range(tlb, (pgd_t *)hpte->ptep, start, end, floor, ceiling);
+	} else if (hugetlb_pte_size(hpte) >= P4D_SIZE) {
+		free_pud_range(tlb, (p4d_t *)hpte->ptep, start, end, floor, ceiling);
+	} else if (hugetlb_pte_size(hpte) >= PUD_SIZE) {
+		free_pmd_range(tlb, (pud_t *)hpte->ptep, start, end, floor, ceiling);
+	} else if (hugetlb_pte_size(hpte) >= PMD_SIZE) {
+		free_pte_range(tlb, (pmd_t *)hpte->ptep, start);
+	}
+}
+
 bool hugetlb_pte_present_leaf(const struct hugetlb_pte *hpte)
 {
 	pgd_t pgd;
-- 
2.37.0.rc0.161.g10f37bed90-goog

