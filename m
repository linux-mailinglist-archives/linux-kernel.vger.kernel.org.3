Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1F058F0CB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbiHJQyI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiHJQyG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:54:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2ED181BEBD
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660150444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=TTGWzxCjDJzoBTfs7PLy6BgM0SdljH8TTEXTgLlppnY=;
        b=X0Zceq+e0zBR3l+veAHrTWB+M9UkarbAETEti/C5CfXr+1NU5AodOQ03AS6wCV2G/8ugFa
        HrnEtnpPXIGUxirsoOYTbngH1pSMhpXBFRVVvkHVAKXq2eCVqm7L+V2uWYrvZuPp4v95tn
        gPa1n37PUSwr+XcPVoW9pbZh/7YlSBg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-386-Nc8QxchhP2qL872tcXFedg-1; Wed, 10 Aug 2022 12:54:01 -0400
X-MC-Unique: Nc8QxchhP2qL872tcXFedg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9B60F803FFA;
        Wed, 10 Aug 2022 16:54:00 +0000 (UTC)
Received: from [172.30.41.16] (unknown [10.22.18.188])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EFBA240CF8EB;
        Wed, 10 Aug 2022 16:53:59 +0000 (UTC)
Subject: [PATCH v2] mm: re-allow pinning of zero pfns (again)
From:   Alex Williamson <alex.williamson@redhat.com>
To:     akpm@linux-foundation.org
Cc:     alex.sierra@amd.com, willy@infradead.org, hch@lst.de,
        Felix.Kuehling@amd.com, apopple@nvidia.com, david@redhat.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Wed, 10 Aug 2022 10:53:59 -0600
Message-ID: <166015037385.760108.16881097713975517242.stgit@omen>
User-Agent: StGit/1.5.dev2+g9ce680a52bd9
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The below referenced commit makes the same error as 1c563432588d ("mm: fix
is_pinnable_page against a cma page"), re-interpreting the logic to exclude
pinning of the zero page, which breaks device assignment with vfio.

To avoid further subtle mistakes, split the logic into discrete tests.

Suggested-by: Matthew Wilcox <willy@infradead.org>
Suggested-by: Felix Kuehling <felix.kuehling@amd.com>
Link: https://lore.kernel.org/all/165490039431.944052.12458624139225785964.stgit@omen
Fixes: f25cbb7a95a2 ("mm: add zone device coherent type memory support")
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
---
 include/linux/mm.h |   17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 18e01474cf6b..835106a9718f 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1544,9 +1544,20 @@ static inline bool is_longterm_pinnable_page(struct page *page)
 	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
 		return false;
 #endif
-	return !(is_device_coherent_page(page) ||
-		 is_zone_movable_page(page) ||
-		 is_zero_pfn(page_to_pfn(page)));
+	/*
+	 * The zero page might reside in a movable zone, however it may not
+	 * be migrated and can therefore be pinned.  The vfio subsystem pins
+	 * user mappings including the zero page for IOMMU translation.
+	 */
+	if (is_zero_pfn(page_to_pfn(page)))
+		return true;
+
+	/* Coherent device memory must always allow eviction. */
+	if (is_device_coherent_page(page))
+		return false;
+
+	/* Otherwise, non-movable zone pages can be pinned. */
+	return !is_zone_movable_page(page);
 }
 #else
 static inline bool is_longterm_pinnable_page(struct page *page)


