Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D044B6119
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 03:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233680AbiBOCjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 21:39:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiBOCjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 21:39:01 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D264F1029DA
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 18:38:51 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id p14so17348303qtx.0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 18:38:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=7RY/qhKlJPQeH1IwAyGGlnES1Mny5ocT5QtyB/fayZE=;
        b=CssZuZOe3DBbjf8JJaBjw58IQNx1PjFb/exoxSarxXEXb0Oku+9ZRuCUj5Z7Ybceav
         LxQzjdOLq1kQgG8GGiKW3Qcn+MN7WOn76nP1logW5v3dLX60adeSoNzxXJZkNF2yUrwx
         XIP/VjCPuz4BreDgp6azxwICU4A7RuibWm8BmOIru5OKZPerzNFnTXIE3RgfavBFXe4E
         L7GwFOHtBTXGz0268x1zY/1+ABnLkf1a3F32q/cqc8MXzk5h1SULSzWDWIgkwDyxJKDQ
         RsslYR7OvL/db5PKlOCiW1UED3kwElfK3o6xq0CcIoCuGhhXPzPh8MgCllnZA31k3/Uj
         c6MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=7RY/qhKlJPQeH1IwAyGGlnES1Mny5ocT5QtyB/fayZE=;
        b=SLEUTEuIys90hbY2WgzB4MBfYNSjjDRKwND3UAvkUo+9M8nFCp1tdVHJtwLhqiP4B8
         rBqR9PP2oTXGrEnrUoZ8RnHmZRw45yqxT9eqyZD/m2rTaZaejS4bfzNxUPkqDT1Q5kiR
         xZUcxC12ZtKhcz8vTPSnsPmWe1o0x/RhSJj3dJmeDf1i8TlyR14HJifZ4x+AQi/tCwPe
         mff8CqPY4fZtJ+Bx7tNacqjEgHxyTk79DEqpGgEsj7gP07mdIaDIUfEVhdOm4JHBtY8s
         K1shD3NVAYfSsVXLVw7dp24e7JZqmnIsZPMYHvHGYvlAW0g4bj4nP3y9gHJZ1JFGFlBh
         oHtQ==
X-Gm-Message-State: AOAM533goBSs2qx05pnKVZBzgAvjA472QJUAsFLyirsaNTTtSlW4PnKr
        TBpyaphLgT5Xvo5u1WW3dUnqFA==
X-Google-Smtp-Source: ABdhPJxVwCU2R6EW1pfoD9ezIoDE5R0PkX8gv3sUUegKvg3dhIR6WvgfD5QXF7JGwdRw6BNI9vYXVA==
X-Received: by 2002:a05:622a:1ce:: with SMTP id t14mr1338296qtw.25.1644892730863;
        Mon, 14 Feb 2022 18:38:50 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id r13sm10993253qkp.129.2022.02.14.18.38.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 18:38:50 -0800 (PST)
Date:   Mon, 14 Feb 2022 18:38:47 -0800 (PST)
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
Subject: [PATCH v2 11/13] mm/munlock: page migration needs mlock pagevec
 drained
In-Reply-To: <55a49083-37f9-3766-1de9-9feea7428ac@google.com>
Message-ID: <9e2ed861-951a-6e86-e298-a09d2d8e9b9f@google.com>
References: <55a49083-37f9-3766-1de9-9feea7428ac@google.com>
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
would now help.

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
v2: Delete suggestion of sysctl from changelog, per Vlastimil.

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

