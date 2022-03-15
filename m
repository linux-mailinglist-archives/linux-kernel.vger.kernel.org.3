Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C89C14D9D49
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 15:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349111AbiCOOU3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 10:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349115AbiCOOU0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 10:20:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA76041F9C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 07:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647353950;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jc+cEdEl7LGBIs1sXVyEIKh1m/fhthwqXZBcWFtK9j4=;
        b=CpF/XLcQRMLHjTfpTcANKJLp9uuA9p0224UiRBMBJHesdLBr3iEIrUsB8zTPiCuAt/dy9a
        M0wbVHHFtf4cxnDvUiRH7Hm2fc/vC3xw+VZEwxfQ3mZeRnXI0nuyKYPiheg13B/zEm15wX
        RF4mvFvT6jlit69kDSFWhavHt1zXT9U=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-5-Ld5KWDtUPEq6XKGoMZ7Gdw-1; Tue, 15 Mar 2022 10:19:07 -0400
X-MC-Unique: Ld5KWDtUPEq6XKGoMZ7Gdw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 293F038008A2;
        Tue, 15 Mar 2022 14:19:05 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.72])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 23B234087D7E;
        Tue, 15 Mar 2022 14:18:58 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-mm@kvack.org,
        x86@kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v1 2/7] mm/debug_vm_pgtable: add tests for __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Date:   Tue, 15 Mar 2022 15:18:32 +0100
Message-Id: <20220315141837.137118-3-david@redhat.com>
In-Reply-To: <20220315141837.137118-1-david@redhat.com>
References: <20220315141837.137118-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's test that __HAVE_ARCH_PTE_SWP_EXCLUSIVE works as expected.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/debug_vm_pgtable.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/mm/debug_vm_pgtable.c b/mm/debug_vm_pgtable.c
index db2abd9e415b..55f1a8dc716f 100644
--- a/mm/debug_vm_pgtable.c
+++ b/mm/debug_vm_pgtable.c
@@ -837,6 +837,19 @@ static void __init pmd_soft_dirty_tests(struct pgtable_debug_args *args) { }
 static void __init pmd_swap_soft_dirty_tests(struct pgtable_debug_args *args) { }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
+static void __init pte_swap_exclusive_tests(struct pgtable_debug_args *args)
+{
+#ifdef __HAVE_ARCH_PTE_SWP_EXCLUSIVE
+	pte_t pte = pfn_pte(args->fixed_pte_pfn, args->page_prot);
+
+	pr_debug("Validating PTE swap exclusive\n");
+	pte = pte_swp_mkexclusive(pte);
+	WARN_ON(!pte_swp_exclusive(pte));
+	pte = pte_swp_clear_exclusive(pte);
+	WARN_ON(pte_swp_exclusive(pte));
+#endif /* __HAVE_ARCH_PTE_SWP_EXCLUSIVE */
+}
+
 static void __init pte_swap_tests(struct pgtable_debug_args *args)
 {
 	swp_entry_t swp;
@@ -1288,6 +1301,8 @@ static int __init debug_vm_pgtable(void)
 	pte_swap_soft_dirty_tests(&args);
 	pmd_swap_soft_dirty_tests(&args);
 
+	pte_swap_exclusive_tests(&args);
+
 	pte_swap_tests(&args);
 	pmd_swap_tests(&args);
 
-- 
2.35.1

