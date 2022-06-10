Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 293D2546602
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 13:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346749AbiFJLvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 07:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345490AbiFJLvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 07:51:39 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767654D273
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 04:51:37 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id r1so5350575plo.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 04:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BxPYDNavbRQmqCL1Xt8uI/WJYd3wztyGqIUZKoZSMcA=;
        b=JJJEdofF62kQpO6ht9IRJF7BC2iyfZpxNeoZmj0OKgy062NS6BylsMYQH6IV3XA6Xf
         /t2ik1PsYUviiOMQsS3fJ530WZrsnydVjDnM4bsYafY/4TW9ymvkAdwgwLB2kQvc01fR
         Zszre46NAO9zgztkUulwZnt9/iFBVyUE4oRiJ8F4t48G+TkR5xIUKfD/iUgvvxzYVwdD
         CkSTMJ7Mp8OYLIdiofKAW3+6jqObd5fhF5t6R1gJonxBfPLFL9GlzAg6Mh+V6I8nKTpX
         XqlmdDpZ+4sX+7iTpkqs0HawJS8yAI43Y5nbIzcXmV1pk5tZQL4BGcuTTca6ahELiZck
         9bMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BxPYDNavbRQmqCL1Xt8uI/WJYd3wztyGqIUZKoZSMcA=;
        b=CKCGWbwWMvudaIK/3rixDfD6nx8PDfRcdRekSnKc/CGpQAlpEo08BwOfazBXRarDQ9
         Hyfo7pUMfz7R5CKbo7UF5C3Pz2UdieDwHKaMzENwElZJL9SQ8RzvFG8LXFvA2dC16UJt
         Ru+ukg8S26uQXjSciyV6brBKK32lbOeOmYw/xdgXoGCqa9njKRddDq9cGW+2dJjbfICC
         K+hEkJyEadLXkA63LBYiEcCFzxvlWpY6EXeORec0S4E+TWh1aNkYFw7ebrs78iXnY8Xv
         0+d9iHkVe3rbCpBuVTPXJIuDlF5oiUx5hblF16pjdmVkLS4RtANueW7SAY8w4IDzb88Q
         wiOQ==
X-Gm-Message-State: AOAM530Sb+xCuoklKoXfVhbYvh4PwXHSaKGIpNfH9sXZ4opuv5Jx4CoR
        3x4vdnA1kNAMThUel9hyMcavtQ==
X-Google-Smtp-Source: ABdhPJwkLm2xML4BO3IAex09iPykCtD2OGvbDL2cxtaLzB2tF0QzXm9b/vhbnZlBUuRP1H7kKwbmDQ==
X-Received: by 2002:a17:90a:5ae1:b0:1db:d0a4:30a4 with SMTP id n88-20020a17090a5ae100b001dbd0a430a4mr8428983pji.128.1654861896928;
        Fri, 10 Jun 2022 04:51:36 -0700 (PDT)
Received: from always-x1.bytedance.net ([61.120.150.70])
        by smtp.gmail.com with ESMTPSA id n5-20020a170902d2c500b001616723b8ddsm12638302plc.45.2022.06.10.04.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 04:51:36 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     pizhenwei@bytedance.com, naoya.horiguchi@nec.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v3 1/1] mm/memory-failure: don't allow to unpoison hw corrupted page
Date:   Fri, 10 Jun 2022 19:46:46 +0800
Message-Id: <20220610114646.162764-2-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220610114646.162764-1-pizhenwei@bytedance.com>
References: <20220610114646.162764-1-pizhenwei@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently unpoison_memory(unsigned long pfn) is designed for soft
poison(hwpoison-inject) only. Since 17fae1294ad9d, the KPTE gets
cleared on a x86 platform once hardware memory corrupts.

Unpoisoning a hardware corrupted page puts page back buddy only,
the kernel has a chance to access the page with *NOT PRESENT* KPTE.
This leads BUG during accessing on the corrupted KPTE.

Do not allow to unpoison hardware corrupted page in unpoison_memory() to
avoid BUG like this:

 Unpoison: Software-unpoisoned page 0x61234
 BUG: unable to handle page fault for address: ffff888061234000
 #PF: supervisor write access in kernel mode
 #PF: error_code(0x0002) - not-present page
 PGD 2c01067 P4D 2c01067 PUD 107267063 PMD 10382b063 PTE 800fffff9edcb062
 Oops: 0002 [#1] PREEMPT SMP NOPTI
 CPU: 4 PID: 26551 Comm: stress Kdump: loaded Tainted: G   M       OE     5.18.0.bm.1-amd64 #7
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996) ...
 RIP: 0010:clear_page_erms+0x7/0x10
 Code: ...
 RSP: 0000:ffffc90001107bc8 EFLAGS: 00010246
 RAX: 0000000000000000 RBX: 0000000000000901 RCX: 0000000000001000
 RDX: ffffea0001848d00 RSI: ffffea0001848d40 RDI: ffff888061234000
 RBP: ffffea0001848d00 R08: 0000000000000901 R09: 0000000000001276
 R10: 0000000000000003 R11: 0000000000000000 R12: 0000000000000001
 R13: 0000000000000000 R14: 0000000000140dca R15: 0000000000000001
 FS:  00007fd8b2333740(0000) GS:ffff88813fd00000(0000) knlGS:0000000000000000
 CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
 CR2: ffff888061234000 CR3: 00000001023d2005 CR4: 0000000000770ee0
 DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
 DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
 PKRU: 55555554
 Call Trace:
  <TASK>
  prep_new_page+0x151/0x170
  get_page_from_freelist+0xca0/0xe20
  ? sysvec_apic_timer_interrupt+0xab/0xc0
  ? asm_sysvec_apic_timer_interrupt+0x1b/0x20
  __alloc_pages+0x17e/0x340
  __folio_alloc+0x17/0x40
  vma_alloc_folio+0x84/0x280
  __handle_mm_fault+0x8d4/0xeb0
  handle_mm_fault+0xd5/0x2a0
  do_user_addr_fault+0x1d0/0x680
  ? kvm_read_and_reset_apf_flags+0x3b/0x50
  exc_page_fault+0x78/0x170
  asm_exc_page_fault+0x27/0x30

Fixes: 847ce401df392 ("HWPOISON: Add unpoisoning support")
Fixes: 17fae1294ad9d ("x86/{mce,mm}: Unmap the entire page if the whole page is affected and poisoned")
Cc: Naoya Horiguchi <naoya.horiguchi@nec.com>
Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 mm/memory-failure.c | 59 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index b85661cbdc4a..3124f428302c 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2068,6 +2068,58 @@ static int __init memory_failure_init(void)
 }
 core_initcall(memory_failure_init);
 
+/*
+ * Unpoisoning a hardware corrupted page with *NOT PRESENT* KPTE leads panic.
+ * Test a page is valid in the kernel mapping.
+ */
+static bool kmap_valid(struct page *page)
+{
+	unsigned long addr = (unsigned long)page_to_virt(page);
+	pgd_t *pgd;
+	p4d_t *p4d;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+
+	pgd = pgd_offset_k(addr);
+	if (pgd_none(*pgd))
+		return false;
+	if (pgd_leaf(*pgd))
+		return true;
+	if (pgd_bad(*pgd))
+		return false;
+
+	p4d = p4d_offset(pgd, addr);
+	if (p4d_none(*p4d))
+		return false;
+	if (p4d_leaf(*p4d))
+		return true;
+	if (p4d_bad(*p4d))
+		return false;
+
+	pud = pud_offset(p4d, addr);
+	if (pud_none(*pud))
+		return false;
+	if (pud_leaf(*pud))
+		return true;
+	if (pud_bad(*pud))
+		return false;
+
+	pmd = pmd_offset(pud, addr);
+	if (pmd_none(*pmd))
+		return false;
+	if (pmd_leaf(*pmd))
+		return true;
+	if (pmd_bad(*pmd))
+		return false;
+
+	pte = pte_offset_map(pmd, addr);
+	if (pte_none(*pte) || !pte_present(*pte))
+		return false;
+
+	return true;
+}
+
 #define unpoison_pr_info(fmt, pfn, rs)			\
 ({							\
 	if (__ratelimit(rs))				\
@@ -2109,6 +2161,13 @@ int unpoison_memory(unsigned long pfn)
 		goto unlock_mutex;
 	}
 
+	if (!kmap_valid(page)) {
+		unpoison_pr_info("Unpoison: Page was hardware poisoned %#lx\n",
+				 pfn, &unpoison_rs);
+		ret = -EOPNOTSUPP;
+		goto unlock_mutex;
+	}
+
 	if (page_count(page) > 1) {
 		unpoison_pr_info("Unpoison: Someone grabs the hwpoison page %#lx\n",
 				 pfn, &unpoison_rs);
-- 
2.20.1

