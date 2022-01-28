Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9AE49FA7D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348802AbiA1NTP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:19:15 -0500
Received: from server.lespinasse.org ([63.205.204.226]:58853 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244878AbiA1NTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:19:08 -0500
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-52-ed;
 t=1643375407; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=2AfpzyewhmOlo0fUb0SXI6JxtNUdQC+AYomvKlpL5Ds=;
 b=Ib2Yh44H5XDzNjpRtIRI02jAIe/KU1DMungZIVzI88t8j0wqwdIWvvyZGtOBMiXiwJPBl
 1pvNr0iYL9/q4z0Ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-52-rsa; t=1643375407; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=2AfpzyewhmOlo0fUb0SXI6JxtNUdQC+AYomvKlpL5Ds=;
 b=5vh96h1Q6g4N+Rf+N+L3AUPDrGbYhjVO2jJ3zEgFGhjHvXxcXZ2UelKDr0orcD9V/RPx0
 p5Q0nD4RoGulcGvYr4T2j2KS6Y8Nmo1yyVjTSxyPV5ukSEa6Z0WqgfRx/fGV5YLjT2YHiGY
 MYn4cHvOeaN43jwZLJOzr1/VUkCiNfYsbcIkX2U4U2RnXIiR+uiILVQ5NlydE7BZN1lKDiu
 Vk1qSP3Q4CcqDst4aKcWBqHyIecdT9aM67g6clkLZv7FImiBwcJSEwCiAr2We5zJHeLqlY3
 s/efKuCQOuQ9YI1KuFZR0xC9y+bkr2mnw2hIltaEe6+eCUsrWrmb9JXQqRbg==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [IPv6:fd00::150:0])
        by server.lespinasse.org (Postfix) with ESMTPS id 0D973160977;
        Fri, 28 Jan 2022 05:10:07 -0800 (PST)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id E6DC020328; Fri, 28 Jan 2022 05:10:06 -0800 (PST)
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
Subject: [PATCH v2 14/35] mm: add speculative_page_walk_begin() and speculative_page_walk_end()
Date:   Fri, 28 Jan 2022 05:09:45 -0800
Message-Id: <20220128131006.67712-15-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220128131006.67712-1-michel@lespinasse.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Speculative page faults will use these to protect against races with
page table reclamation.

This could always be handled by disabling local IRQs as the fast GUP
code does; however speculative page faults do not need to protect
against races with THP page splitting, so a weaker rcu read lock is
sufficient in the MMU_GATHER_RCU_TABLE_FREE case.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 mm/memory.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/mm/memory.c b/mm/memory.c
index aa24cd8c06e9..663952d14bad 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2725,6 +2725,28 @@ int apply_to_existing_page_range(struct mm_struct *mm, unsigned long addr,
 }
 EXPORT_SYMBOL_GPL(apply_to_existing_page_range);
 
+#ifdef CONFIG_SPECULATIVE_PAGE_FAULT
+
+/*
+ * speculative_page_walk_begin() ... speculative_page_walk_end() protects
+ * against races with page table reclamation.
+ *
+ * This is similar to what fast GUP does, but fast GUP also needs to
+ * protect against races with THP page splitting, so it always needs
+ * to disable interrupts.
+ * Speculative page faults only need to protect against page table reclamation,
+ * so rcu_read_lock() is sufficient in the MMU_GATHER_RCU_TABLE_FREE case.
+ */
+#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
+#define speculative_page_walk_begin() rcu_read_lock()
+#define speculative_page_walk_end()   rcu_read_unlock()
+#else
+#define speculative_page_walk_begin() local_irq_disable()
+#define speculative_page_walk_end()   local_irq_enable()
+#endif
+
+#endif	/* CONFIG_SPECULATIVE_PAGE_FAULT */
+
 /*
  * handle_pte_fault chooses page fault handler according to an entry which was
  * read non-atomically.  Before making any commitment, on those architectures
-- 
2.20.1

