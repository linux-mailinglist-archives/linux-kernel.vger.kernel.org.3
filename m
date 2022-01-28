Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C62DF49FA87
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348853AbiA1NTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:19:40 -0500
Received: from server.lespinasse.org ([63.205.204.226]:35959 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348643AbiA1NTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:19:09 -0500
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-52-ed;
 t=1643375407; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=UxJsNKcxVkmfEwrc0wLrYxktFQMDzJ2NvtD6CGXLcSg=;
 b=6r7aPZUUazHr0Yx+Qnh+976CFWlOQ4YNyXZG/9wDEuqKvF1jaH590LzBlXz8Je2wT6aJb
 sogFe4e9NylpbJwBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-52-rsa; t=1643375407; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=UxJsNKcxVkmfEwrc0wLrYxktFQMDzJ2NvtD6CGXLcSg=;
 b=cTAUtcMfHA1B3iEc5GrsP2U2HjGn6DIPIpn7HZ2gtLjdNDl8krMjya4tVaK+5OTEA+wWr
 Xnj0JsNTJP/v2UE6Qsd7hSwMV2FYZb/nMEA+ldwp10eTwW0rADGPdxnBB0m+O1JNdfdTyqv
 DWC7tylQgCiEGBa3oQfzqNx34zEWcKxrdjdG5t1zaryzw8AnVDwsekcgtaT7VAtf2Kd5SWG
 5j8zgxXTRAe0xi5ToCDyGNZTmpWWZqs9+6c9rc7+Iq/vJ0rEbK2KxJ4ohHyWwm+TXbktBQe
 jtI88AyNoZA1+73B7ej+1TJ+MKPzv+tBflBZwOqGNbR2DaZWuOFVvuP5R8TA==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id 1758B16099D;
        Fri, 28 Jan 2022 05:10:07 -0800 (PST)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id F241320481; Fri, 28 Jan 2022 05:10:06 -0800 (PST)
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
Subject: [PATCH v2 18/35] mm: implement speculative handling in do_anonymous_page()
Date:   Fri, 28 Jan 2022 05:09:49 -0800
Message-Id: <20220128131006.67712-19-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220128131006.67712-1-michel@lespinasse.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change do_anonymous_page() to handle the speculative case.
This involves aborting speculative faults if they have to allocate a new
anon_vma, and using pte_map_lock() instead of pte_offset_map_lock()
to complete the page fault.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 mm/memory.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/mm/memory.c b/mm/memory.c
index 1ce837e47395..8d036140634d 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3846,8 +3846,12 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 						vma->vm_page_prot));
 	} else {
 		/* Allocate our own private page. */
-		if (unlikely(anon_vma_prepare(vma)))
-			goto oom;
+		if (unlikely(!vma->anon_vma)) {
+			if (vmf->flags & FAULT_FLAG_SPECULATIVE)
+				return VM_FAULT_RETRY;
+			if (__anon_vma_prepare(vma))
+				goto oom;
+		}
 		page = alloc_zeroed_user_highpage_movable(vma, vmf->address);
 		if (!page)
 			goto oom;
@@ -3869,8 +3873,10 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 			entry = pte_mkwrite(pte_mkdirty(entry));
 	}
 
-	vmf->pte = pte_offset_map_lock(vma->vm_mm, vmf->pmd, vmf->address,
-			&vmf->ptl);
+	if (!pte_map_lock(vmf)) {
+		ret = VM_FAULT_RETRY;
+		goto release;
+	}
 	if (!pte_none(*vmf->pte)) {
 		update_mmu_tlb(vma, vmf->address, vmf->pte);
 		goto unlock;
@@ -3885,6 +3891,8 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 		pte_unmap_unlock(vmf->pte, vmf->ptl);
 		if (page)
 			put_page(page);
+		if (vmf->flags & FAULT_FLAG_SPECULATIVE)
+			return VM_FAULT_RETRY;
 		return handle_userfault(vmf, VM_UFFD_MISSING);
 	}
 
@@ -3902,6 +3910,7 @@ static vm_fault_t do_anonymous_page(struct vm_fault *vmf)
 	return 0;
 unlock:
 	pte_unmap_unlock(vmf->pte, vmf->ptl);
+release:
 	if (page)
 		put_page(page);
 	return ret;
-- 
2.20.1

