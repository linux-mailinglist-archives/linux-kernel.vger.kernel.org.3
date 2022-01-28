Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1680649FA9C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 14:20:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349214AbiA1NUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 08:20:50 -0500
Received: from server.lespinasse.org ([63.205.204.226]:45397 "EHLO
        server.lespinasse.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348748AbiA1NTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:19:11 -0500
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=lespinasse.org; i=@lespinasse.org; q=dns/txt; s=srv-52-ed;
 t=1643375407; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=brYV8LPA4M9MTtgPlp3UWTnacdv4IgtI3z+1Ewrumi8=;
 b=I1DZbEmzQI4BcXWoERJUPqVuo+xoDE/u5gIe/livDsttlyUfT+MZsR0eXQlVWW88IXojZ
 0jaTameOtDQD5k0Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lespinasse.org;
 i=@lespinasse.org; q=dns/txt; s=srv-52-rsa; t=1643375407; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=brYV8LPA4M9MTtgPlp3UWTnacdv4IgtI3z+1Ewrumi8=;
 b=BnwIWxwakg1LSUdfMDZOXM07NSkkaRmm7gkd+wArC4muOcJ34MoFFiQ8zPm2Gv9Fvzeb6
 Uvld4y0CFz/xgMOWzzPdrQS8SkI/FRPZS+avWFDq9lAW4LHsL1zFSMRRoDILiO22d27+8l4
 h4wYnNj/8p/IH1qHJ2oEOMNuJpsAFjSLzHMu2eeXkTUpGHu3yjRJnPqUtFs0XGwkiuMcG/H
 voXrhVBC9PZEQuTti4ut+rreXnIDxCC/XYgPL3+TiU757qOBPUm39Ch+wXPw/DG0yIxAOTy
 35hiWPkK/9hDr8NZ6eENLlEC6XtGLCsYgX477+xRrPBYMdb2h5hkkByDflOA==
Received: from zeus.lespinasse.org (zeus.lespinasse.org [10.0.0.150])
        by server.lespinasse.org (Postfix) with ESMTPS id 29450160AAB;
        Fri, 28 Jan 2022 05:10:07 -0800 (PST)
Received: by zeus.lespinasse.org (Postfix, from userid 1000)
        id 0E8D620132; Fri, 28 Jan 2022 05:10:07 -0800 (PST)
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
Subject: [PATCH v2 24/35] mm: write lock mmu_notifier_lock when registering mmu notifiers
Date:   Fri, 28 Jan 2022 05:09:55 -0800
Message-Id: <20220128131006.67712-25-michel@lespinasse.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220128131006.67712-1-michel@lespinasse.org>
References: <20220128131006.67712-1-michel@lespinasse.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change mm_take_all_locks to also take the mmu_notifier_lock.
Note that mm_take_all_locks is called from mmu_notifier_register() only.

Signed-off-by: Michel Lespinasse <michel@lespinasse.org>
---
 mm/mmap.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/mm/mmap.c b/mm/mmap.c
index b09a2c875507..a67c3600d995 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -3592,6 +3592,10 @@ int mm_take_all_locks(struct mm_struct *mm)
 
 	mutex_lock(&mm_all_locks_mutex);
 
+#if defined(CONFIG_MMU_NOTIFIER) && defined(CONFIG_SPECULATIVE_PAGE_FAULT)
+	percpu_down_write(mm->mmu_notifier_lock);
+#endif
+
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
 		if (signal_pending(current))
 			goto out_unlock;
@@ -3679,6 +3683,10 @@ void mm_drop_all_locks(struct mm_struct *mm)
 			vm_unlock_mapping(vma->vm_file->f_mapping);
 	}
 
+#if defined(CONFIG_MMU_NOTIFIER) && defined(CONFIG_SPECULATIVE_PAGE_FAULT)
+	percpu_up_write(mm->mmu_notifier_lock);
+#endif
+
 	mutex_unlock(&mm_all_locks_mutex);
 }
 
-- 
2.20.1

