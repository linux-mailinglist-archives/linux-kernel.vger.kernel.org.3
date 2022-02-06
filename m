Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6531B4AB278
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 22:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238019AbiBFVtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 16:49:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiBFVti (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 16:49:38 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D273CC06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 13:49:37 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id 4so15070154oil.11
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 13:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=eeryvFF3YUzQVL6zRfYgPnpVjIrjeIiDC6NPipRUjo8=;
        b=dxv/xyq7a4YKz4HvXaiBhAykSn9i2EZYj69xdALi3OT6gz4vNRjQvKL9ctHf7bWKwz
         m1oXTJqiMhzmqtmOpY18jr5EWeEo24Q98eyAWwX3+Izq0Ax1ehI+Hrd4hiPd+/6j/V44
         pLUizWM1JLm6ymi4UZwkxaB8OfxquyNTA5VkqpFr/d+6/C7WatNV68zP69nfVRYO1GRr
         xx+1+cP+T9iuaiLlnhFbF2gghvgNs/luRc+E0t5x1gbpkquIQly0t1Snc02WRWXQEOuc
         qpRFJZoFkWIHBzzWhlzh71dTYejG7tLQ0s9YbqD1hpsK9MgIKY+Hncn3jydYgx0ogqoU
         7hPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=eeryvFF3YUzQVL6zRfYgPnpVjIrjeIiDC6NPipRUjo8=;
        b=aDIVAA0HxKvdX5DKmoV+mWLszvkPSXJ7yKchUE8NOcREKkx8EuqBAP0BjphNSz7cPK
         r4FjgROOevdKYxxQrlaI2jlqtzyXSaO1r3blaljpHJwaYMSVi3ePOFXdR5kK/nljnHLP
         QjdXnwo/KvC8/xj5Wt9vkc2o/F8DAmYZJpk/38qOu0Gg7mXae04fiv64AwOO/A06Lani
         BW4bz6YCFv1mFlfUHEMh+xvNrlqL07TQIgP91HByv2I7t4tI41thgUVJECtMB95yMxl2
         XZLv0AQjw/JVH8lJT03zfckesiUCNn4K3xf+wJfka9621zmI0moppfkt4iA9rE+LkJWM
         8cjw==
X-Gm-Message-State: AOAM530UsezUQpGf6aSs7mA54ZuRMmVIN/BXZgj7X96lGyeO2yv0KT36
        teQM0PJDItK3G3XnoY8OFp+/dQ==
X-Google-Smtp-Source: ABdhPJyN1McMGJJTaV8N1fTal8/WpBySojSZ784mbjvrg03WsAI06sgAW2MGqhXDzjPZIsjbUy04Iw==
X-Received: by 2002:aca:adc1:: with SMTP id w184mr3914400oie.305.1644184177107;
        Sun, 06 Feb 2022 13:49:37 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id 6sm3517091oig.29.2022.02.06.13.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 13:49:36 -0800 (PST)
Date:   Sun, 6 Feb 2022 13:49:34 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 11/13] mm/munlock: page migration needs mlock pagevec
 drained
In-Reply-To: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com>
Message-ID: <90c8962-d188-8687-dc70-628293316343@google.com>
References: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Page migration of a VM_LOCKED page tends to fail, because when the old
page is unmapped, it is put on the mlock pagevec with raised refcount,
which then fails the freeze.

At first I thought this would be fixed by a local mlock_page_drain() at
the upper rmap_walk() level - which would have nicely batched all the
munlocks of that page; but tests show that the task can too easily move
to another cpu, leaving pagevec residue behind which fails the migration.

So try_to_migrate_one() drain the local pagevec after page_remove_rmap()
from a VM_LOCKED vma; and do the same in try_to_unmap_one(), whose
TTU_IGNORE_MLOCK users would want the same treatment; and do the same
in remove_migration_pte() - not important when successfully inserting
a new page, but necessary when hoping to retry after failure.

Any new pagevec runs the risk of adding a new way of stranding, and we
might discover other corners where mlock_page_drain() or lru_add_drain()
would now help.  If the mlock pagevec raises doubts, we can easily add a
sysctl to tune its length to 1, which reverts to synchronous operation.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/migrate.c | 2 ++
 mm/rmap.c    | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/mm/migrate.c b/mm/migrate.c
index f4bcf1541b62..e7d0b68d5dcb 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -251,6 +251,8 @@ static bool remove_migration_pte(struct page *page, struct vm_area_struct *vma,
 				page_add_file_rmap(new, vma, false);
 			set_pte_at(vma->vm_mm, pvmw.address, pvmw.pte, pte);
 		}
+		if (vma->vm_flags & VM_LOCKED)
+			mlock_page_drain(smp_processor_id());
 
 		/* No need to invalidate - it was non-present before */
 		update_mmu_cache(vma, pvmw.address, pvmw.pte);
diff --git a/mm/rmap.c b/mm/rmap.c
index 5442a5c97a85..714bfdc72c7b 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -1656,6 +1656,8 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
 		 * See Documentation/vm/mmu_notifier.rst
 		 */
 		page_remove_rmap(subpage, vma, PageHuge(page));
+		if (vma->vm_flags & VM_LOCKED)
+			mlock_page_drain(smp_processor_id());
 		put_page(page);
 	}
 
@@ -1930,6 +1932,8 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
 		 * See Documentation/vm/mmu_notifier.rst
 		 */
 		page_remove_rmap(subpage, vma, PageHuge(page));
+		if (vma->vm_flags & VM_LOCKED)
+			mlock_page_drain(smp_processor_id());
 		put_page(page);
 	}
 
-- 
2.34.1

