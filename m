Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32F094B611F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 03:41:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233699AbiBOClJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 21:41:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233696AbiBOClI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 21:41:08 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65B9120E90
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 18:40:59 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id d7so16450353qvk.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 18:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=4LCswZrElV6Pmzb8YyUA7fug85GktLISWrDlYL4+cJU=;
        b=RK8Rg5/4qjjIjh2MTmUdnU7ZE6Ocg/1c/4CORITP3/BkGS1yJqcNkG4BUYhF3CsYX7
         XNdKA9GUjgoh2Xw/MQZrmTMn98R8uxZp/nDVs2vc6bQ3D2VZ9zBBrjuJZ1MYtsEK7OpY
         ric3eQtbdsLIvZ3djy3yq/LSIvgsGyPLvO0Fo31gqGU8Q0uhhfMtJVKSzSm1GNxuhh2D
         NcWiyqOB4fIBiqJ6eIWhcEj2nkTnwxVYrKT6TP00O81qEGGsHr3do/QRqhygbnlSg0zf
         aopiU81m8kQKUrsRc6VhRrcX0ffKj4+M/8Z8aU/3XHNigrR3fv536/y/lnNuXm47bxK5
         a0GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=4LCswZrElV6Pmzb8YyUA7fug85GktLISWrDlYL4+cJU=;
        b=jHwsXNQI0SqqsrQKeAgAdI+W+zJv/mJwPkYDEL5Pbo9ERIbwwMH9LijjNhaT+1/71S
         F8dNd7/HSDea7269ziu4ZlWIHJWL0hMR70DugqetqANS5R9wrZwgNKePnQ14cHjXuzPx
         Jx7/zaSzqNGmimrmeP4EcSDKcAfFhWDKGz0N5G/4gKsCokto81TE3AICTo/jjw/7NVwE
         7I8nwsRUvXhVjP8jnAlcRy6ljezP6oqAo/zwtpgzZBxxLEl+za030vFAR2fTcTGzFg4W
         Iuf972H7mIxyof2qx/PxguC930rYSWLapCwJrpfyA7OzpZ7usFd8bn/ba8ngafjE3/cL
         kaYQ==
X-Gm-Message-State: AOAM531ZuJDuWd+kKBTPt1Dvt6HToB1WKRXRuv8F+MpWp2O0l2VTgP71
        HUvTY8lMdAxmFHe4Cvg3CGgz2g==
X-Google-Smtp-Source: ABdhPJwoOBqHBajFmA50x9euRGxs5w57fNsAgoxQwuf0kGlCmHaynY42ZIqWK7LLuu2RSLh3vtEqlQ==
X-Received: by 2002:a05:6214:627:: with SMTP id a7mr1412718qvx.91.1644892858736;
        Mon, 14 Feb 2022 18:40:58 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m9sm17437831qkn.81.2022.02.14.18.40.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 18:40:57 -0800 (PST)
Date:   Mon, 14 Feb 2022 18:40:55 -0800 (PST)
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
Subject: [PATCH v2 12/13] mm/thp: collapse_file() do
 try_to_unmap(TTU_BATCH_FLUSH)
In-Reply-To: <55a49083-37f9-3766-1de9-9feea7428ac@google.com>
Message-ID: <c390e7b-7648-b3e9-9ae1-87c9b9e95ed4@google.com>
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

collapse_file() is using unmap_mapping_pages(1) on each small page found
mapped, unlike others (reclaim, migration, splitting, memory-failure) who
use try_to_unmap().  There are four advantages to try_to_unmap(): first,
its TTU_IGNORE_MLOCK option now avoids leaving mlocked page in pagevec;
second, its vma lookup uses i_mmap_lock_read() not i_mmap_lock_write();
third, it breaks out early if page is not mapped everywhere it might be;
fourth, its TTU_BATCH_FLUSH option can be used, as in page reclaim, to
save up all the TLB flushing until all of the pages have been unmapped.

Wild guess: perhaps it was originally written to use try_to_unmap(),
but hit the VM_BUG_ON_PAGE(page_mapped) after unmapping, because without
TTU_SYNC it may skip page table locks; but unmap_mapping_pages() never
skips them, so fixed the issue.  I did once hit that VM_BUG_ON_PAGE()
since making this change: we could pass TTU_SYNC here, but I think just
delete the check - the race is very rare, this is an ordinary small page
so we don't need to be so paranoid about mapcount surprises, and the
page_ref_freeze() just below already handles the case adequately.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
v2: same as v1.

 mm/khugepaged.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index d5e387c58bde..e0883a33efd6 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1829,13 +1829,12 @@ static void collapse_file(struct mm_struct *mm,
 		}
 
 		if (page_mapped(page))
-			unmap_mapping_pages(mapping, index, 1, false);
+			try_to_unmap(page, TTU_IGNORE_MLOCK | TTU_BATCH_FLUSH);
 
 		xas_lock_irq(&xas);
 		xas_set(&xas, index);
 
 		VM_BUG_ON_PAGE(page != xas_load(&xas), page);
-		VM_BUG_ON_PAGE(page_mapped(page), page);
 
 		/*
 		 * The page is expected to have page_count() == 3:
@@ -1899,6 +1898,13 @@ static void collapse_file(struct mm_struct *mm,
 	xas_unlock_irq(&xas);
 xa_unlocked:
 
+	/*
+	 * If collapse is successful, flush must be done now before copying.
+	 * If collapse is unsuccessful, does flush actually need to be done?
+	 * Do it anyway, to clear the state.
+	 */
+	try_to_unmap_flush();
+
 	if (result == SCAN_SUCCEED) {
 		struct page *page, *tmp;
 
-- 
2.34.1

