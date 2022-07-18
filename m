Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F251F578B07
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 21:37:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236240AbiGRThc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 15:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236188AbiGRThR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 15:37:17 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D68130541
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:37:15 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id s27so11490852pga.13
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 12:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pKws8yGRo63vLoo5PvEhs398wa0pzhCZmm6r0b5wNuc=;
        b=qMpMBqoEJowM7hHEVUp4urmfW4BmRk2K5WRu6rjNNtcGI/q+u2qcbzoTj0dymzU/YN
         GICq1D6c+IwKTAtMkM/ialUwiAbHd2qyav/oi4Lb2/tQir2MH5L1/9FN/OSYwOL11ogc
         J95A/oNh44qpCzubW1bL4lW6pv2SZPldzPpGkHfXoFe/mJfk3/K11+ZWWai+ZuaWUxuj
         ZktYEG+NaXZRrAZnM4dfOCYWFErlRI/RQXv4NrUjDJOmLWof5hAYkt6ED39XDfIu11Ol
         QDBHOQm0nz2tV3l6dVnFXwCweU/mVRE1/C2vxelapt4M8n9mqIfwuSDyhKsokwR/n6pa
         5lRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pKws8yGRo63vLoo5PvEhs398wa0pzhCZmm6r0b5wNuc=;
        b=p19nGqIbcAFUMXODGLbp5jyjrhLm3T5bzu5wCgv5behm4KjNDftIlVhBcghfbm/w5V
         nDHfxuVqq01uLqLnsswCfLjADBO1LUD0Y795bEDV5QMiNzkahi+qNKl76EJLgNN74BUB
         RhcMjuBqjwBrwf+UnSwTa/uzvvKh3LGK0ecJKQc0TdGj4vKbYpl986X2lKMMzTU5gM5l
         TxjJ4J9O5rjSy3koi/I84TPOX9ZBTLNZwmhbvkUN+oH2FOCJxEWrpDoeQYqIaK5M0+M4
         Ok113NBIUa0JHTnM5qVNQeS00ULQ9sNyZFatmzbkDWtdyQR5IR8k6IEw+eDvsXOny8SX
         XW3g==
X-Gm-Message-State: AJIora+M516yro9aU1Oktzw2lt+fkXmZPV3Xiw2fQBdP+1HU3fcHDuRT
        t+l1/7SiJAioiHTUNvu9cz0=
X-Google-Smtp-Source: AGRyM1v2EDFEp/irIA5oLmEjHJRkKj6neMr06kHIqrOuqyOom6q/rRWy9YaOFocxFmxkQmdYOSbCBw==
X-Received: by 2002:aa7:9256:0:b0:52a:cbf7:43ea with SMTP id 22-20020aa79256000000b0052acbf743eamr29902665pfp.7.1658173034758;
        Mon, 18 Jul 2022 12:37:14 -0700 (PDT)
Received: from sc2-haas01-esx0118.eng.vmware.com ([66.170.99.1])
        by smtp.gmail.com with ESMTPSA id q6-20020a170902a3c600b0016bc4a6ce28sm9907887plb.98.2022.07.18.12.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jul 2022 12:37:14 -0700 (PDT)
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
Subject: [RFC PATCH 08/14] x86/mm: introduce flush_tlb_fix_spurious_fault
Date:   Mon, 18 Jul 2022 05:02:06 -0700
Message-Id: <20220718120212.3180-9-namit@vmware.com>
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

The next patches introduce relaxed TLB flushes for x86, which would
require a full TLB flush upon spurious page-fault. If a spurious
page-fault occurs on x86, check if the local TLB generation is out of
sync and perform a TLB flush if needed.

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
 arch/x86/include/asm/pgtable.h |  4 +++-
 arch/x86/mm/tlb.c              | 17 +++++++++++++++++
 2 files changed, 20 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 44e2d6f1dbaa..1fbdaff1bb7a 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -1079,7 +1079,9 @@ static inline void ptep_set_wrprotect(struct mm_struct *mm,
 	clear_bit(_PAGE_BIT_RW, (unsigned long *)&ptep->pte);
 }
 
-#define flush_tlb_fix_spurious_fault(vma, address) do { } while (0)
+extern void flush_tlb_fix_spurious_fault(struct vm_area_struct *vma,
+					 unsigned long address);
+#define flush_tlb_fix_spurious_fault flush_tlb_fix_spurious_fault
 
 #define mk_pmd(page, pgprot)   pfn_pmd(page_to_pfn(page), (pgprot))
 
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index d400b6d9d246..ff3bcc55435e 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -955,6 +955,23 @@ static void put_flush_tlb_info(void)
 #endif
 }
 
+void flush_tlb_fix_spurious_fault(struct vm_area_struct *vma,
+				  unsigned long address)
+{
+	u32 loaded_mm_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
+	u64 mm_tlb_gen = atomic64_read(&vma->vm_mm->context.tlb_gen);
+	u64 local_tlb_gen = this_cpu_read(cpu_tlbstate.ctxs[loaded_mm_asid].tlb_gen);
+	struct flush_tlb_info *info;
+
+	if (local_tlb_gen == mm_tlb_gen)
+		return;
+
+	preempt_disable();
+	info = get_flush_tlb_info(NULL, 0, TLB_FLUSH_ALL, 0, false, 0);
+	flush_tlb_func(info);
+	preempt_enable();
+}
+
 void flush_tlb_mm_range(struct mm_struct *mm, unsigned long start,
 				unsigned long end, unsigned int stride_shift,
 				bool freed_tables)
-- 
2.25.1

