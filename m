Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27A1E495BA1
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 09:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379407AbiAUIOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 03:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349312AbiAUIOV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 03:14:21 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83249C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 00:14:21 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id d12-20020a17090a628c00b001b4f47e2f51so9915644pjj.3
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 00:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NUBLyuZGx9EGOqRiyub00DClmOV9oJNDGNsE24u7OX4=;
        b=1VYMBBb5mRYIBmY88rfyjbzyYUn6xg4It5vlmh63KVQT0xL3q96ahenBlmXqkOLRgE
         I0nURUrCD+FKAMs1SxB2dhCEjBKmw9D3eni7sxtMvdzgvep1Uz0FTS/whYpc5iDxYplu
         tWEdbxhCmuZWdd0UJZLw+BHsvJIqwBdqK3FJ7JiVPbOLKHJzcanyIcB/ApExOF9+YxBf
         ZX8KiHRKAGAa1d1sYO88TsLJ51zEoH1V09HkeVRQGR8lQ0/dlqlFRxxuLa87vEnNwrhI
         7vmAXdSAwwnUTBDbtmhgNfRVvyO/gtF477oRSnwSFlbSqr0kUjfjGvEtlKo9M/QFC4mJ
         cLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NUBLyuZGx9EGOqRiyub00DClmOV9oJNDGNsE24u7OX4=;
        b=nUU4BKAbylBxQ8yPDpdJR5HDKTaeO3c6vUNNDp54y7zdJhDzBp+yGjkAKPqZoXOo3L
         P0ODK/s6To5KEjeem8oiF5j6zNZJxydsY3+gnM8fR5caL86kiT7OeRH7Ucg2yOHZ9vLN
         l1LzyMb3xm8EXNWs0pQ6WGh4dHZDZ0v4Z6P68E6xBKiRuEysaA6r1fFuUSgdCNuej777
         UG0k3by/PxvAXDGqteHdXSah300kH3lCeKkegb7DvLSI50u3QqunRuaPIfrLRZNuDz5R
         0cpaIdNuzPia9s4omCD0nllHOKhYYE6PeoW2HHrqUj92vj1V8mI4+XaSw7Vq+T0cNzEc
         i99Q==
X-Gm-Message-State: AOAM531tQPc9sI+B9p4SUW6xC7v/+IpZinatIzb1GPDubWZosuMgWYSQ
        w9SYDM9hecEndx6H1UrHZOJuOg==
X-Google-Smtp-Source: ABdhPJxcpqZv/OlIM7SZY8OGqKI5V0XfZzksOJ1RfFNoYzyXmLezjeSzliK5MeRSIpx/p9UtTE2NUA==
X-Received: by 2002:a17:902:cec1:b0:14a:5426:81a with SMTP id d1-20020a170902cec100b0014a5426081amr2784624plg.134.1642752861089;
        Fri, 21 Jan 2022 00:14:21 -0800 (PST)
Received: from FVFYT0MHHV2J.tiktokcdn.com ([139.177.225.230])
        by smtp.gmail.com with ESMTPSA id q9sm6191010pfk.137.2022.01.21.00.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jan 2022 00:14:20 -0800 (PST)
From:   Muchun Song <songmuchun@bytedance.com>
To:     akpm@linux-foundation.org, zi.yan@cs.rutgers.edu,
        kirill.shutemov@linux.intel.com
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH 1/2] mm: thp: fix wrong cache flush in remove_migration_pmd()
Date:   Fri, 21 Jan 2022 16:13:44 +0800
Message-Id: <20220121081345.80320-1-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.32.0 (Apple Git-132)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The flush_cache_page() is supposed to be justified only if the page
is already placed in process page table, and that is done right after
flush_cache_page(). So using this interface is wrong. And there is
no need to invalite cache since it was non-present before in
remove_migration_pmd(). So just to remove it.

Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/huge_memory.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index f58524394dc1..45ede45b11f5 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -3207,7 +3207,6 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 	if (pmd_swp_uffd_wp(*pvmw->pmd))
 		pmde = pmd_wrprotect(pmd_mkuffd_wp(pmde));
 
-	flush_cache_range(vma, mmun_start, mmun_start + HPAGE_PMD_SIZE);
 	if (PageAnon(new))
 		page_add_anon_rmap(new, vma, mmun_start, true);
 	else
@@ -3215,6 +3214,8 @@ void remove_migration_pmd(struct page_vma_mapped_walk *pvmw, struct page *new)
 	set_pmd_at(mm, mmun_start, pvmw->pmd, pmde);
 	if ((vma->vm_flags & VM_LOCKED) && !PageDoubleMap(new))
 		mlock_vma_page(new);
+
+	/* No need to invalidate - it was non-present before */
 	update_mmu_cache_pmd(vma, address, pvmw->pmd);
 }
 #endif
-- 
2.11.0

