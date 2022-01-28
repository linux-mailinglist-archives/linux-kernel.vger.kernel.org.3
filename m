Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0ED149FA9B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349093AbiA1NUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:20:48 -0500
Received: from server.lespinasse.org ([63.205.204.226]:35317 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348751AbiA1NTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:19:11 -0500
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-52-ed;
 t=1643375407; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=uHoqHiEitsG2adH6xd+AzaN4440pSdu1fLLTZyBjHdc=;
 b=1eE7s25AKDC9KWLUsK1P+gDDXQS3CKuxa6HMqYPfvCfGKLZhIojDGscSOm/Ufv9mPLMnG
 XKbeaxCLmPX/TWaAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-52-rsa; t=1643375407; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=uHoqHiEitsG2adH6xd+AzaN4440pSdu1fLLTZyBjHdc=;
 b=djUTh9Y+zDGOrV/rzW37emAErhohtTwhjN/ABtXVYGKLWtLhSR5MR8Sq5CIrnvNlX6iSC
 PW8YmSUJzY/Qx/HxEnw3rrkJamXcI0gSEsJJzN2rAMjvaHi/dsFb0kWQNFN+NKtX+jl7WLq
 x2ftK834MzhH3bnYqmlymAIGNsG3yyDZf3rDELQGZ12Eo5i2WP+HyI9hWLRiWIw2vJlbDY/
 IdBO/neq4UrCqmgYFRCG4lGSEK5TesRe+kWc/XrLlQRPU48c8a6kFaA2G/LswmRFkHszUzt
 PZgM/bnPyhFRiSsUyqeCMP3RLoLdB59R8VcKi5feKkRFSzc6MhQxJhC5FzXA==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id 21498160AA1;
        Fri, 28 Jan 2022 05:10:07 -0800 (PST)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 065B82044E; Fri, 28 Jan 2022 05:10:07 -0800 (PST)
From:   Michel Lespinasse <michel@lespinasse.org>
To:     Linux-MM <linux-mm@kvack.org>, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kernel-team@fb.com, Laurent Dufour <ldufour@linux.ibm.com>,
        Jerome Glisse <jglisse@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Matthew Wilcox <willy@infradead.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        Rik van Riel <riel@surriel.com>,
        Paul McKenney <paulmck@kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Minchan Kim <minchan@google.com>,
        Joel Fernandes <joelaf@google.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Michel Lespinasse <michel@lespinasse.org>
Subject: [PATCH v2 21/35] mm: enable speculative fault handling in do_numa_page()
Date:   Fri, 28 Jan 2022 05:09:52 -0800
Message-Id: <20220128131006.67712-22-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220128131006.67712-1-michel@lespinasse.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change handle_pte_fault() to allow speculative fault execution to proceed
through do_numa_page().

do_swap_page() does not implement speculative execution yet, so it
needs to abort with VM_FAULT_RETRY in that case.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 mm/memory.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 083e015ff194..73b1a328b797 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3589,6 +3589,11 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 	vm_fault_t ret = 0;
 	void *shadow = NULL;
 
+	if (vmf->flags & FAULT_FLAG_SPECULATIVE) {
+		pte_unmap(vmf->pte);
+		return VM_FAULT_RETRY;
+	}
+
 	if (!pte_unmap_same(vmf))
 		goto out;
 
@@ -4611,17 +4616,17 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
 			return do_fault(vmf);
 	}
 
-	if (vmf->flags & FAULT_FLAG_SPECULATIVE) {
-		pte_unmap(vmf->pte);
-		return VM_FAULT_RETRY;
-	}
-
 	if (!pte_present(vmf->orig_pte))
 		return do_swap_page(vmf);
 
 	if (pte_protnone(vmf->orig_pte) && vma_is_accessible(vmf->vma))
 		return do_numa_page(vmf);
 
+	if (vmf->flags & FAULT_FLAG_SPECULATIVE) {
+		pte_unmap(vmf->pte);
+		return VM_FAULT_RETRY;
+	}
+
 	vmf->ptl = pte_lockptr(vmf->vma->vm_mm, vmf->pmd);
 	spin_lock(vmf->ptl);
 	entry = vmf->orig_pte;
-- 
2.20.1

