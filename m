Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8165A46FA
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 12:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229596AbiH2KSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 06:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbiH2KSL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:18:11 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C13E11475;
        Mon, 29 Aug 2022 03:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=QFT9hMYWq2W9Wm3hwFVUs00NQS9JmhdUaG06XK5NWLE=; b=bImqDC41he467ZrhYMHorWLDPF
        CkDW2xcOCoQa0DEcUFOK3XIO8FdntztaVNzcUh4buifRrn3QL74aqDkt4EBW3ThXW7FIvcuDREVJE
        R3YpFtwnNB4EbiH69rJUymqMJim5ICSSXgM6bD60bWPEKD3rMF0WF17bpjEEiIJ9jjNzVfCxQG2xg
        dKe6vRRYDHEqvEZqOvM9m3rkSiC1yOn8fJ1JCkmvCnhP5kOceG64HnJ10YfGYWCptYoyr2UVHdKZp
        Viz02JQahdLne3d2Ydqp/uO+GNoYHzCfse6MxsV1ME3Wogimip6HCdPX861HuJ+IqD+yo4q9LoA+G
        3v68UN9Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oSbqF-007T4i-W1; Mon, 29 Aug 2022 10:18:04 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 716D63002C7;
        Mon, 29 Aug 2022 12:18:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 432AA203BFBC2; Mon, 29 Aug 2022 12:18:03 +0200 (CEST)
Date:   Mon, 29 Aug 2022 12:18:03 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Dave Hansen <dave.hansen@intel.com>, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        keescook@chromium.org, Sean Christopherson <seanjc@google.com>
Subject: [PATCH v2] x86/mm: Refuse W^X violations
Message-ID: <YwySW3ROc21hN7g9@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


x86 has STRICT_*_RWX, but not even a warning when someone violates it.

Add this warning and fully refuse the transition.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/mm/pat/set_memory.c |   32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -580,6 +580,33 @@ static inline pgprot_t static_protection
 }
 
 /*
+ * Validate and enforce strict W^X semantics.
+ */
+static inline pgprot_t verify_rwx(pgprot_t old, pgprot_t new, unsigned long start,
+				  unsigned long pfn, unsigned long npg)
+{
+	unsigned long end;
+
+	if (!cpu_feature_enabled(X86_FEATURE_NX))
+		return new;
+
+	if (!((pgprot_val(old) ^ pgprot_val(new)) & (_PAGE_RW | _PAGE_NX)))
+		return new;
+
+	if ((pgprot_val(new) & (_PAGE_RW | _PAGE_NX)) != _PAGE_RW)
+		return new;
+
+	end = start + npg * PAGE_SIZE - 1;
+	WARN_ONCE(1, "CPA refuse W^X violation: %016llx -> %016llx range: 0x%016lx - 0x%016lx PFN %lx\n",
+		  (unsigned long long)pgprot_val(old),
+		  (unsigned long long)pgprot_val(new),
+		  start, end, pfn);
+
+	/* refuse the transition into WX */
+	return old;
+}
+
+/*
  * Lookup the page table entry for a virtual address in a specific pgd.
  * Return a pointer to the entry and the level of the mapping.
  */
@@ -885,6 +912,8 @@ static int __should_split_large_page(pte
 	new_prot = static_protections(req_prot, lpaddr, old_pfn, numpages,
 				      psize, CPA_DETECT);
 
+	new_prot = verify_rwx(old_prot, new_prot, lpaddr, old_pfn, numpages);
+
 	/*
 	 * If there is a conflict, split the large page.
 	 *
@@ -1525,6 +1554,7 @@ static int __change_page_attr(struct cpa
 
 	if (level == PG_LEVEL_4K) {
 		pte_t new_pte;
+		pgprot_t old_prot = pte_pgprot(old_pte);
 		pgprot_t new_prot = pte_pgprot(old_pte);
 		unsigned long pfn = pte_pfn(old_pte);
 
@@ -1536,6 +1566,8 @@ static int __change_page_attr(struct cpa
 		new_prot = static_protections(new_prot, address, pfn, 1, 0,
 					      CPA_PROTECT);
 
+		new_prot = verify_rwx(old_prot, new_prot, address, pfn, 1);
+
 		new_prot = pgprot_clear_protnone_bits(new_prot);
 
 		/*
