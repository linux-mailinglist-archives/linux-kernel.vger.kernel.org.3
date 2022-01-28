Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C7449FA96
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:20:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349028AbiA1NU2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:20:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348754AbiA1NTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:19:11 -0500
Received: from server.lespinasse.org (server.lespinasse.org [IPv6:2001:470:82ab::100:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED46DC061747
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 05:19:08 -0800 (PST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-52-ed;
 t=1643375407; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=WKv5bmQRqPHdZUO4LXo+QEVU5+AgH+NzFasQ6BtkXFM=;
 b=/llg3A/maOZyNvvtAsqPMT8BSicLcbnbTOgrCs9XoOeH6gnm+d0cUa1QPJAqq4O8MYZk+
 73okmSGTVaB7uXOAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-52-rsa; t=1643375407; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=WKv5bmQRqPHdZUO4LXo+QEVU5+AgH+NzFasQ6BtkXFM=;
 b=isSEOn+qW7HslS9ExCPC4SWo6ixC3JaQtA/XDcgOW/HSjp235iI6dbuuhQWVnRuW3C4VC
 uRo57aSyhVd7UxYlHuifDAq7xC7OAJVnykW+5LpOPvsqHyO0fvzHtEyGaSJUUSc7CqFFm/Y
 f1UKBDtJAXBGHOuTmsMGu6qrs5b+pNzdA1bQ34JZYbkQLf44t13EMFyrga+f9AXa9GS7G53
 enzvE6DnD84v9hHe1ky+dyUTlXSOY08Oer0XUwqyqHSkurysfooyCTMjsrS5KRj/PVI3i+v
 tIRp6oX2lYonjB00oQJKO6OFfmuobq1OxPPYGWKNhfaNDoAx3E7ifbr3/sew==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id 36C7E160AC7;
        Fri, 28 Jan 2022 05:10:07 -0800 (PST)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 1CA4E2023B; Fri, 28 Jan 2022 05:10:07 -0800 (PST)
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
Subject: [PATCH v2 29/35] mm: disable rcu safe vma freeing for single threaded user space
Date:   Fri, 28 Jan 2022 05:10:00 -0800
Message-Id: <20220128131006.67712-30-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220128131006.67712-1-michel@lespinasse.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Performance tuning: as single threaded userspace does not use
speculative page faults, it does not require rcu safe vma freeing.
Turn this off to avoid the related (small) extra overheads.

For multi threaded userspace, we often see a performance benefit from
the rcu safe vma freeing - even in tests that do not have any frequent
concurrent page faults ! This is because rcu safe vma freeing prevents
recently released vmas from being immediately reused in a new thread.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 kernel/fork.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index db92e42d0087..34600fe86743 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -384,10 +384,12 @@ void vm_area_free(struct vm_area_struct *vma)
 {
 	free_vma_anon_name(vma);
 #ifdef CONFIG_SPECULATIVE_PAGE_FAULT
-	call_rcu(&vma->vm_rcu, __vm_area_free);
-#else
-	kmem_cache_free(vm_area_cachep, vma);
+	if (atomic_read(&vma->vm_mm->mm_users) > 1) {
+		call_rcu(&vma->vm_rcu, __vm_area_free);
+		return;
+	}
 #endif
+	kmem_cache_free(vm_area_cachep, vma);
 }
 
 static void account_kernel_stack(struct task_struct *tsk, int account)
-- 
2.20.1

