Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D2B4EB236
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 18:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239908AbiC2QvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 12:51:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238991AbiC2QvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 12:51:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 948D5CF4AD
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 09:49:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648572570;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sC+ymRkt7JVDUa+jsWm6tHAksM2n+k+zaIL6QWBa32I=;
        b=Bm2RHli0iCGxiPAKcT5SdZnhs9TiP+EITXkK49j/50xYIcS3NNAaxY/wTU/73T4IdCG2d0
        o9XsMKezQkde1BKvwSlg/12ruc1CfBAmPlecpqALMQ4AFQ2oz/OEgKw3dAbUm+3EDccdzc
        ppMbTrs6mdi12GSy7gFv7VJsaJRHSEg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-41-roYzQxbCMv-hrUjMfAj--g-1; Tue, 29 Mar 2022 12:49:29 -0400
X-MC-Unique: roYzQxbCMv-hrUjMfAj--g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5ED81811E9B;
        Tue, 29 Mar 2022 16:49:27 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.194.134])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3BA641121314;
        Tue, 29 Mar 2022 16:48:32 +0000 (UTC)
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
        Dave Hansen <dave.hansen@linux.intel.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-mm@kvack.org, x86@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v2 6/8] s390/pgtable: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
Date:   Tue, 29 Mar 2022 18:43:27 +0200
Message-Id: <20220329164329.208407-7-david@redhat.com>
In-Reply-To: <20220329164329.208407-1-david@redhat.com>
References: <20220329164329.208407-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's use bit 52, which is unused.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/include/asm/pgtable.h | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 3982575bb586..a397b072a580 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -181,6 +181,8 @@ static inline int is_module_addr(void *addr)
 #define _PAGE_SOFT_DIRTY 0x000
 #endif
 
+#define _PAGE_SWP_EXCLUSIVE _PAGE_LARGE	/* SW pte exclusive swap bit */
+
 /* Set of bits not changed in pte_modify */
 #define _PAGE_CHG_MASK		(PAGE_MASK | _PAGE_SPECIAL | _PAGE_DIRTY | \
 				 _PAGE_YOUNG | _PAGE_SOFT_DIRTY)
@@ -826,6 +828,22 @@ static inline int pmd_protnone(pmd_t pmd)
 }
 #endif
 
+#define __HAVE_ARCH_PTE_SWP_EXCLUSIVE
+static inline int pte_swp_exclusive(pte_t pte)
+{
+	return pte_val(pte) & _PAGE_SWP_EXCLUSIVE;
+}
+
+static inline pte_t pte_swp_mkexclusive(pte_t pte)
+{
+	return set_pte_bit(pte, __pgprot(_PAGE_SWP_EXCLUSIVE));
+}
+
+static inline pte_t pte_swp_clear_exclusive(pte_t pte)
+{
+	return clear_pte_bit(pte, __pgprot(_PAGE_SWP_EXCLUSIVE));
+}
+
 static inline int pte_soft_dirty(pte_t pte)
 {
 	return pte_val(pte) & _PAGE_SOFT_DIRTY;
@@ -1715,14 +1733,15 @@ static inline int has_transparent_hugepage(void)
  * Bits 54 and 63 are used to indicate the page type. Bit 53 marks the pte
  * as invalid.
  * A swap pte is indicated by bit pattern (pte & 0x201) == 0x200
- * |			  offset			|X11XX|type |S0|
+ * |			  offset			|E11XX|type |S0|
  * |0000000000111111111122222222223333333333444444444455|55555|55566|66|
  * |0123456789012345678901234567890123456789012345678901|23456|78901|23|
  *
  * Bits 0-51 store the offset.
+ * Bit 52 (E) is used to remember PG_anon_exclusive.
  * Bits 57-61 store the type.
  * Bit 62 (S) is used for softdirty tracking.
- * Bits 52, 55 and 56 (X) are unused.
+ * Bits 55 and 56 (X) are unused.
  */
 
 #define __SWP_OFFSET_MASK	((1UL << 52) - 1)
-- 
2.35.1

