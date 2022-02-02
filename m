Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 870584A72A9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344546AbiBBOFG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:05:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:31083 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234321AbiBBOFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:05:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643810704;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LKXvUjky6U95W40duLCBj5rNPNib3n3NzIkg22PjaKw=;
        b=SvuiwrY0F8URFkAV7Z/bT+v4+reRW5MFRrXOf+Sd9x/v7S3hiL/SGEirSiAv6I7cfnYld8
        oiiAArpBZ01blHa3TJFnZg+bnGa2E/bF9NA3z34V8Aq7ao4ZsXgpfuIcbRpeawwukKvqKo
        H0qHxVapuczwzf1Sb7BSGgy6HP2D7Rw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-146-s5UF_5FIO-yeRT5dOZA3xA-1; Wed, 02 Feb 2022 09:05:03 -0500
X-MC-Unique: s5UF_5FIO-yeRT5dOZA3xA-1
Received: by mail-wm1-f69.google.com with SMTP id bg16-20020a05600c3c9000b0034bea12c043so3941274wmb.7
        for <linux-kernel@vger.kernel.org>; Wed, 02 Feb 2022 06:05:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LKXvUjky6U95W40duLCBj5rNPNib3n3NzIkg22PjaKw=;
        b=D9UIUf1M9M4QYkJGiAbVenpFST13nl/pz9jj7lLG9Hoc5d63CC1kKLhChJXQRQJX7j
         otVVWr11Y0LJWv/q4G+BNOy0Gv3vb5wMhsmr66s84d4WvoV4B8BLZEPbWKtHKhCkAELJ
         tmdk1lfQP8wCzURRtfHtum/9F3Bk/IOgJA4+8aXJLNqv4+zYN5B1wGRqjbu85SxGuj4L
         43T7ATtDKGEXXn+CDmhydBCIgAjUnq9w+zg8czi1KnM3lfuhvf3cmxktsgMrDp7H2tIk
         h3q2a6ml91KwZELqy34ImTkxNpvNCNixFT4GTYoEL3GG9rGUrhpLKMLDdyc3ZuEhakNo
         yejg==
X-Gm-Message-State: AOAM532MOqV5oBVgr/J2ag5UJOT5rVWOk63+eHOxxXdmVmBcvtVSBJCb
        A1iHhDylW+LQcxcWqB6Hf86Rk6AZjz0Q1qZvehq9lsFW0bJtjHiSlR8iZIJA0X3rEeEy3GS5Yzg
        hjCRLiCEWyNmgxtZqJu4oesm1
X-Received: by 2002:a5d:6c61:: with SMTP id r1mr26149499wrz.414.1643810702583;
        Wed, 02 Feb 2022 06:05:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyhUIST0Awqaun/ofpc39z5ZRnSV4PkM4qvGlYJX0Eb+SUFwsOtn9g5VHUyneOaLQomWHOKlg==
X-Received: by 2002:a5d:6c61:: with SMTP id r1mr26149481wrz.414.1643810702359;
        Wed, 02 Feb 2022 06:05:02 -0800 (PST)
Received: from vian.redhat.com ([2a0c:5a80:1e09:d600:637e:7f1b:a4a0:fc92])
        by smtp.gmail.com with ESMTPSA id e10sm20639384wrq.53.2022.02.02.06.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Feb 2022 06:05:02 -0800 (PST)
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: [PATCH] mm/page_alloc: Don't pass pfn to free_unref_page_commit()
Date:   Wed,  2 Feb 2022 15:04:51 +0100
Message-Id: <20220202140451.415928-1-nsaenzju@redhat.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

free_unref_page_commit() doesn't make use of its pfn argument, so get
rid of it.

Signed-off-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---

NOTE:
 This first appeared here, where Vlastimil gave his Reviewed-by:
   https://lore.kernel.org/lkml/51e45c99-1ad8-339b-0c6a-e88288fa41ba@suse.cz/
 The rest of the series was discarded, but this patch has value on its
 own.

 mm/page_alloc.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 7c417bec8207..4f549123150c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -3422,8 +3422,8 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone)
 	return min(READ_ONCE(pcp->batch) << 2, high);
 }
 
-static void free_unref_page_commit(struct page *page, unsigned long pfn,
-				   int migratetype, unsigned int order)
+static void free_unref_page_commit(struct page *page, int migratetype,
+				   unsigned int order)
 {
 	struct zone *zone = page_zone(page);
 	struct per_cpu_pages *pcp;
@@ -3472,7 +3472,7 @@ void free_unref_page(struct page *page, unsigned int order)
 	}
 
 	local_lock_irqsave(&pagesets.lock, flags);
-	free_unref_page_commit(page, pfn, migratetype, order);
+	free_unref_page_commit(page, migratetype, order);
 	local_unlock_irqrestore(&pagesets.lock, flags);
 }
 
@@ -3482,13 +3482,13 @@ void free_unref_page(struct page *page, unsigned int order)
 void free_unref_page_list(struct list_head *list)
 {
 	struct page *page, *next;
-	unsigned long flags, pfn;
+	unsigned long flags;
 	int batch_count = 0;
 	int migratetype;
 
 	/* Prepare pages for freeing */
 	list_for_each_entry_safe(page, next, list, lru) {
-		pfn = page_to_pfn(page);
+		unsigned long pfn = page_to_pfn(page);
 		if (!free_unref_page_prepare(page, pfn, 0)) {
 			list_del(&page->lru);
 			continue;
@@ -3504,15 +3504,10 @@ void free_unref_page_list(struct list_head *list)
 			free_one_page(page_zone(page), page, pfn, 0, migratetype, FPI_NONE);
 			continue;
 		}
-
-		set_page_private(page, pfn);
 	}
 
 	local_lock_irqsave(&pagesets.lock, flags);
 	list_for_each_entry_safe(page, next, list, lru) {
-		pfn = page_private(page);
-		set_page_private(page, 0);
-
 		/*
 		 * Non-isolated types over MIGRATE_PCPTYPES get added
 		 * to the MIGRATE_MOVABLE pcp list.
@@ -3522,7 +3517,7 @@ void free_unref_page_list(struct list_head *list)
 			migratetype = MIGRATE_MOVABLE;
 
 		trace_mm_page_free_batched(page);
-		free_unref_page_commit(page, pfn, migratetype, 0);
+		free_unref_page_commit(page, migratetype, 0);
 
 		/*
 		 * Guard against excessive IRQ disabled times when we get
-- 
2.34.1

