Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C274B42B1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 08:19:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240798AbiBNHSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 02:18:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbiBNHSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 02:18:02 -0500
Received: from mail-qv1-xf2d.google.com (mail-qv1-xf2d.google.com [IPv6:2607:f8b0:4864:20::f2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EC6059395
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 23:17:55 -0800 (PST)
Received: by mail-qv1-xf2d.google.com with SMTP id h9so14127055qvm.0
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 23:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=7RY/qhKlJPQeH1IwAyGGlnES1Mny5ocT5QtyB/fayZE=;
        b=VzHkAYMDY/HdX+dsw6NCrXxZNHuj/JmwC6wfDXY856bPWsyrZGDwKxWUbh+5fltduz
         GgqnA6zOXtDiABDP4mpEIa9EWec0IWNBR+s2DhUBQE6ySH3ojeItvuzQWwZUWcB7EgEd
         GW51aBMXNbU/JLRdIl0G7IbRDZn6K0pF9L7v90SUfQBOzRh9HbWx9ta8bjwGx/gRG000
         E2p+IV6RDhwBQMZj7sjM5yaOH0O94DPvVcUFuzZXhT6McR+b98r8KpXKaIh8CrVhpkRc
         ssJIjNQ1LJRCxNwuq356EHuwERotOggGTGu+SpkBdwaVSTj1sWLNrPWbyLTer/50nfVh
         RToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=7RY/qhKlJPQeH1IwAyGGlnES1Mny5ocT5QtyB/fayZE=;
        b=1lseTsXdjcQPv3vSW2Ax/D+b5n4qN6DRI7DWwOqB4XHKpAoCTUAPNOJMUW7q9rNMvq
         MRKWWazKTfzJHtoVEvoU07e23RDH9FB5Ie6ziSAhH4C+/e01VsuQtf8TPYdVNRZMGk9y
         RHAo8bZOYLWFgHhpqQrFUMKZTq5WzKZ0cvaDbccYNRMnJRSXtfRt4xC40uglQ/gIjmwg
         SmM52QuoXtCcCPFfz9YrzQ+4rdE98F81glXfETA1WoWEitVqHq0jtsNKnJerPAkz7YIi
         FD/i9QAnj5moH/qPWs0qFPiE+AgBupjNSoV7kZmz3WJAQd5/RKMM0pIkpWFD9MktkNMz
         GjgQ==
X-Gm-Message-State: AOAM530nNGvGHvdIXz86I+/C8Gu3DL3uQSx5yB6oruEHtwrCsOP5g0AA
        TiLYpc9+CVSE/OFRAfHdIPDqYQ==
X-Google-Smtp-Source: ABdhPJwGwX68z0qBHohS57F18pqVnq/mKw8WHUjx6KtfBL80xG8cXkQqofjGkCTSjuQrcuBY6S4Xcw==
X-Received: by 2002:a05:6214:62e:: with SMTP id a14mr699015qvx.9.1644823074534;
        Sun, 13 Feb 2022 23:17:54 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id j14sm16202816qko.10.2022.02.13.23.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 23:17:53 -0800 (PST)
Date:   Sun, 13 Feb 2022 23:17:51 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>,
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
In-Reply-To: <d74f2610-2595-cc51-5a35-dc037c23a28@google.com>
Message-ID: <27b835d-6fee-e62-ca32-266eb1b5544e@google.com>
References: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com> <90c8962-d188-8687-dc70-628293316343@google.com> <f9960727-d061-8856-45ce-4e33e8ed1de6@suse.cz> <d74f2610-2595-cc51-5a35-dc037c23a28@google.com>
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

