Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9759E578B0D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:37:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236113AbiGRThx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:37:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234041AbiGRThY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:37:24 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DB62A42A
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:37:23 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id p9so12675814pjd.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qVM0y4gQPitFR1tKEmIDwlmAZZH+TL3Rnk5RAABBHP4=;
        b=V6nKbIynJQ32RQiVSsWsL92BBUcNPr/7NmtVMidKRitE6VlZae99PvNi8rcn+Np+jv
         pbcQ52AiEx1o9SZVttEDGEVOxJyIKTeKYIzcFXPWQ2G1C3zkD8cn5YkP2iBXBUXZlaa9
         Dy3y3Pvf3hypERuQAuX174h2D0jZEGUq76cBKglKQIYGgRfk5wLo1AfQulxtBGjoFPoU
         NeY2dZN8ekT0PmwfBJUXjrrFexeYdAxIeAOeiGPEDV4wWbXQZIW5CufcmI7B5mKfG2oK
         0gw2N3fyOtwK7H2d9kvGxukR6bLS/4L+jHEjvGnYCpck8OPzbSIcYAHTHgjEuhAB8YLR
         92pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qVM0y4gQPitFR1tKEmIDwlmAZZH+TL3Rnk5RAABBHP4=;
        b=D3MsYC/8Fz26Oomg+nSJkWj7AraScua9RwNlW+wo/yP4b3y8Iyu6bze7UCHflGG4QU
         ENfbSvA2lpmjmZCd1faBzShJeewutDT8WzSAtjDkro7GgscKIb6CLbbhLEIUy7DUbfyL
         oMGpl5/YQ/Ejj0lwvKd9oHnugThEJfh9TFJntszh8UOXb6SVwqwWaHJkqUZzNjUMYD3P
         zNDskyBAnmAIFtoqRsALH/JsehnTeRRuSoj7OuoTWhmrfIFJ1fs7+r2Ad1lLfTAq8Qbd
         /1bAjq/qP/OPSinCRDD9PxEAWEf2Bwp1npyHwKFNl5hzYvuDHgrsYEdfKrF8vJhRS6MU
         OZWA==
X-Gm-Message-State: AJIora/dkGYaiBcFVOs6sUK9eBAdfo3kkhzPculSJ72nQGudsauBcy42
        WK7/0o+c0lE9z5RXFY3eh2I=
X-Google-Smtp-Source: AGRyM1u6taPQ6doU3CQByQAU6zsUojk73LMBR4sgGh24aRXQUX89N81HjhtbgEEEFfcQzY5TwRCCRg==
X-Received: by 2002:a17:90b:4b4d:b0:1ef:a2c2:6bcc with SMTP id mi13-20020a17090b4b4d00b001efa2c26bccmr34467490pjb.186.1658173042743;
        Mon, 18 Jul 2022 12:37:22 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b0016bc4a6ce28sm9907887plb.98.2022.07.18.12.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 12:37:22 -0700 (PDT)
From:   Nadav Amit <nadav.amit@gmail.com>
X-Google-Original-From: Nadav Amit
To:     linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <namit@vmware.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Nick Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 13/14] mm/mprotect: do not check flush type if a strict is needed
Date:   Mon, 18 Jul 2022 05:02:11 -0700
Message-Id: <20220718120212.3180-14-namit@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220718120212.3180-1-namit@vmware.com>
References: <20220718120212.3180-1-namit@vmware.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nadav Amit <namit@vmware.com>

Once it was determined that a strict TLB flush is needed, it is both
likely that other PTEs would need strict TLB flush and little benefit
from not extending the range that is flushed.

Skip the check which TLB flush is needed, if it was determined a strict
flush is already needed.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Nick Piggin <npiggin@gmail.com>
Signed-off-by: Nadav Amit <namit@vmware.com>
---
 mm/huge_memory.c | 4 +++-
 mm/mprotect.c    | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 09e6608a6431..b32b7da0f6f7 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1816,7 +1816,9 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 	ret = HPAGE_PMD_NR;
 	set_pmd_at(mm, addr, pmd, entry);
 
-	flush_type = huge_pmd_flush_type(oldpmd, entry);
+	flush_type = PTE_FLUSH_STRICT;
+	if (!tlb->strict)
+		flush_type = huge_pmd_flush_type(oldpmd, entry);
 	if (flush_type != PTE_FLUSH_NONE)
 		tlb_flush_pmd_range(tlb, addr, HPAGE_PMD_SIZE,
 				    flush_type == PTE_FLUSH_STRICT);
diff --git a/mm/mprotect.c b/mm/mprotect.c
index ead20dc66d34..cf775f6c8c08 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -202,7 +202,9 @@ static unsigned long change_pte_range(struct mmu_gather *tlb,
 
 			ptep_modify_prot_commit(vma, addr, pte, oldpte, ptent);
 
-			flush_type = pte_flush_type(oldpte, ptent);
+			flush_type = PTE_FLUSH_STRICT;
+			if (!tlb->strict)
+				flush_type = pte_flush_type(oldpte, ptent);
 			if (flush_type != PTE_FLUSH_NONE)
 				tlb_flush_pte_range(tlb, addr, PAGE_SIZE,
 						flush_type == PTE_FLUSH_STRICT);
-- 
2.25.1

