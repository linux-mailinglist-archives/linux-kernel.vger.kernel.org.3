Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B59024AB27B
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 22:51:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242877AbiBFVvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 16:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234786AbiBFVvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 16:51:49 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2DEDC06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 13:51:48 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id o10so9603572qkg.0
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 13:51:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=2F7iZLYdwYPM4sLsD/XEKrj7yTpwecjzx+f9IFfRioI=;
        b=O2A7e30ZNErMc7sLTDRbVDo+u9vgGRRPsIn3pHksPoXr7DO3I1ltCMlVsvYZ1LrMY/
         bEHygfTQCo2ZhfRS7GvvoLp23fy77sW2s7bXsUHlO698TZbolDPRiVAE/uQlpFNN8FT+
         +vMcuytvVqjY6qnHuwXZjbSQ9xJXKhn4qljFm7CcUjv9AOOUaOlLOz64fJ+4Ta7E39bP
         t+r0JgS7YSQoJ1P2tu1+ztrxegopNrrtPcB7CEglsmPWjrZXjGUlZFdTBJMFHFje+sRF
         3f9ktE3m4hku9+G61oT4wjShEY7leMZRZpbH8WKc0jKZsvK7Yt6pEfme/mAEhf8YYfSJ
         QlsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=2F7iZLYdwYPM4sLsD/XEKrj7yTpwecjzx+f9IFfRioI=;
        b=WGDJcEsDwVHTEtM+x9IJ6PhSRuvhh3gL/lJhEBr7T3LxLLUw0fVH2OPnYb+vLqZJRw
         fFWh2+foFo7TuqFKhfZ96skgitOqUUBDathpOoy5hkywi9WDWB/iQPNEIStG9lPL3AjX
         Xt7TVLMhHvNkmCy4e1TQ2L0ajtzLm42+lWUwvMozs2hVqDIFg+WqALb8plRuVckVft9n
         /c3QUkMeGiU60r5N/4qvPBsMK0mWxILzjEgyp3T9+LdfuahfRMu6KG2uc5byNrSYNIBR
         AsyflgQ8eqlV+KPes0n7MUjFxps9V7x2T3q+W1gTHTfLdydinn9AtULoABxBWSASniiw
         7zvQ==
X-Gm-Message-State: AOAM531y2IKb7QBi1+4MSlHg+LzSLKlZrgy8NCWNFQPg4EBiXDfK96tD
        yHhMg9/eM7mGAe3y08ofQ/N+/Q==
X-Google-Smtp-Source: ABdhPJzBUJKcxDIYJSCu6HIiFnNizBKr8UU37iMWcm6qXkJlQTiR0K//R2/i+23oBe3NLv6QegczpA==
X-Received: by 2002:a37:9a82:: with SMTP id c124mr5060970qke.433.1644184307966;
        Sun, 06 Feb 2022 13:51:47 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id n6sm4798616qtx.23.2022.02.06.13.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 13:51:47 -0800 (PST)
Date:   Sun, 6 Feb 2022 13:51:45 -0800 (PST)
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
Subject: [PATCH 12/13] mm/thp: collapse_file() do
 try_to_unmap(TTU_BATCH_FLUSH)
In-Reply-To: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com>
Message-ID: <cc3ad3e4-7045-f00-5a81-de3e3de6b69@google.com>
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

