Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C8A655A004
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbiFXRjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 13:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbiFXRh4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 13:37:56 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FEAC6DB37
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:44 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2dc7bdd666fso26872577b3.7
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 10:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+v5vFcEkCeptJMisViVmMo9Bs1ZO+THs4heiTRIsd+o=;
        b=NNXX2wgNjzsnd7NQe74D6jQQ3JbhNS1xVYTChLiQX5nqdIcnMSKpyyj3i3EvpGCsEm
         RHq6youwXY0rUgRMsMTqDuY+7MTgv+Ntfb9USuGpLdovFk8QaUNnj/5hu4tOf0Mr8Ypa
         tM+TcTpJN5YH+/RNf30TRecLDgM5H/Zp5MJnxEVgf0YteupwUS+Lg1C1mvGu3kxmJaAP
         xgJKg9LuXjQrzoqn63vyXZqC4Ckt6dxdIBoGoTX+pIFxhc2k6bw9SxJVfy3KdgryLAmu
         8iaVOe1LIhnXOC1SpxD4kIV9TfjqwXSaMv6b0r1/9KFQEay+2Tk+s5gsM4+trTfyjtP4
         tSMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+v5vFcEkCeptJMisViVmMo9Bs1ZO+THs4heiTRIsd+o=;
        b=TlRMTihQpXKV8+Are596oJW0TjHT/rcUziUppx3KlB6cRADZZ219m5MDFl6qlZncJP
         q5QvFQF8AeYtgsG8I7BrhHpA/fkx+E9ST7v3v3dZRF7gVMOG31v2jBpSvwb3XaerCG3A
         cxeXGjQLWEiKdzYBXBWTCp5vtY3sjC3upr9jPZt3kCpOcBxl85CE4ZCgQiJoIw8wEbe6
         DvSA4OZ6LqMPYJuj4m7vyvUOwHFybxuGf3ek63bYyRUk9ZoTxNoxU7sNnGADw973fy1i
         F/6upRw6KxBHRPTk5ft0lctaXPsU6UIR9VXS2xG/6k6jV9Ch3h5x85f8Vs5mbfYvk3fB
         LmmQ==
X-Gm-Message-State: AJIora+36zAvojn7jCdX3mWozWckcaymCa4SiSVPzaNFCCQde7kG5Bzs
        1datimYXiCUwbi+ZDfpvC2tlYuhvfNzmrYVK
X-Google-Smtp-Source: AGRyM1uKY4yvxaVhU0NJgxRylqUzzNHeETpBTfmI2EV5YsAV33yJ/2TcaSldBOT8fH//yUIflu07auIqQ61eftvT
X-Received: from jthoughton.c.googlers.com ([fda3:e722:ac3:cc00:14:4d90:c0a8:2a4f])
 (user=jthoughton job=sendgmr) by 2002:a81:5e42:0:b0:31b:6254:1c2b with SMTP
 id s63-20020a815e42000000b0031b62541c2bmr3298ywb.35.1656092263238; Fri, 24
 Jun 2022 10:37:43 -0700 (PDT)
Date:   Fri, 24 Jun 2022 17:36:54 +0000
In-Reply-To: <20220624173656.2033256-1-jthoughton@google.com>
Message-Id: <20220624173656.2033256-25-jthoughton@google.com>
Mime-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [RFC PATCH 24/26] arm64/hugetlb: add support for high-granularity mappings
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

This is included in this RFC to demonstrate how an architecture that
doesn't use ARCH_WANT_GENERAL_HUGETLB can be updated to support HugeTLB
high-granularity mappings: an architecture just needs to implement
hugetlb_walk_to.

Signed-off-by: James Houghton <jthoughton@google.com>
---
 arch/arm64/Kconfig          |  1 +
 arch/arm64/mm/hugetlbpage.c | 63 +++++++++++++++++++++++++++++++++++++
 2 files changed, 64 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1652a9800ebe..74108713a99a 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -99,6 +99,7 @@ config ARM64
 	select ARCH_WANT_FRAME_POINTERS
 	select ARCH_WANT_HUGE_PMD_SHARE if ARM64_4K_PAGES || (ARM64_16K_PAGES && !ARM64_VA_BITS_36)
 	select ARCH_WANT_HUGETLB_PAGE_OPTIMIZE_VMEMMAP
+	select ARCH_HAS_SPECIAL_HUGETLB_HGM
 	select ARCH_WANT_LD_ORPHAN_WARN
 	select ARCH_WANTS_NO_INSTR
 	select ARCH_HAS_UBSAN_SANITIZE_ALL
diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index e2a5ec9fdc0d..1901818bed9d 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -281,6 +281,69 @@ void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
 		set_pte(ptep, pte);
 }
 
+int hugetlb_walk_to(struct mm_struct *mm, struct hugetlb_pte *hpte,
+		    unsigned long addr, unsigned long sz, bool stop_at_none)
+{
+	pgd_t *pgdp;
+	p4d_t *p4dp;
+	pte_t *ptep;
+
+	if (!hpte->ptep) {
+		pgdp = pgd_offset(mm, addr);
+		p4dp = p4d_offset(pgdp, addr);
+		if (!p4dp)
+			return -ENOMEM;
+		hugetlb_pte_populate(hpte, (pte_t *)p4dp, P4D_SHIFT);
+	}
+
+	while (hugetlb_pte_size(hpte) > sz &&
+			!hugetlb_pte_present_leaf(hpte) &&
+			!(stop_at_none && hugetlb_pte_none(hpte))) {
+		if (hpte->shift == PMD_SHIFT) {
+			unsigned long rounded_addr = sz == CONT_PTE_SIZE
+						     ? addr & CONT_PTE_MASK
+						     : addr;
+
+			ptep = pte_offset_kernel((pmd_t *)hpte->ptep,
+						 rounded_addr);
+			if (!ptep)
+				return -ENOMEM;
+			if (sz == CONT_PTE_SIZE)
+				hpte->shift = CONT_PTE_SHIFT;
+			else
+				hpte->shift = pte_cont(*ptep) ? CONT_PTE_SHIFT
+							      : PAGE_SHIFT;
+			hpte->ptep = ptep;
+		} else if (hpte->shift == PUD_SHIFT) {
+			pud_t *pudp = (pud_t *)hpte->ptep;
+
+			ptep = (pte_t *)pmd_alloc(mm, pudp, addr);
+
+			if (!ptep)
+				return -ENOMEM;
+			if (sz == CONT_PMD_SIZE)
+				hpte->shift = CONT_PMD_SHIFT;
+			else
+				hpte->shift = pte_cont(*ptep) ? CONT_PMD_SHIFT
+							      : PMD_SHIFT;
+			hpte->ptep = ptep;
+		} else if (hpte->shift == P4D_SHIFT) {
+			ptep = (pte_t *)pud_alloc(mm, (p4d_t *)hpte->ptep, addr);
+			if (!ptep)
+				return -ENOMEM;
+			hpte->shift = PUD_SHIFT;
+			hpte->ptep = ptep;
+		} else
+			/*
+			 * This also catches the cases of CONT_PMD_SHIFT and
+			 * CONT_PTE_SHIFT. Those PTEs should always be leaves.
+			 */
+			BUG();
+	}
+
+	return 0;
+}
+
 pte_t *huge_pte_alloc(struct mm_struct *mm, struct vm_area_struct *vma,
 		      unsigned long addr, unsigned long sz)
 {
-- 
2.37.0.rc0.161.g10f37bed90-goog

