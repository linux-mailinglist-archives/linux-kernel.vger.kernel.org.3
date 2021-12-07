Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDCF646B13E
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 04:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233291AbhLGDL6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 22:11:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37150 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233090AbhLGDL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 22:11:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638846506;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=eS5hnHo6fS3srX/T0Jg5HoFYDVnRWpFswXlegYGnrds=;
        b=TIkvDbqXZG7jhmE4ExcpN7PSmWAzbTHZN/qF4SctRt0TCAaz1fnq5gXHHiXlH6zQuofomj
        BUrY7SOjNP8xFEl2yO+tlUVYd1MnceI0hrEHyoJR+HfcnXeXfbBUs3fZVFwrMJ/dZWkINH
        aiKppXKH8F9SOKMtIUVakLlXYqPGh4Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-309-KJEMnVkSM96TyaxgypcYXA-1; Mon, 06 Dec 2021 22:08:23 -0500
X-MC-Unique: KJEMnVkSM96TyaxgypcYXA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 345E781CCB4;
        Tue,  7 Dec 2021 03:08:21 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-87.pek2.redhat.com [10.72.12.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DD48719C59;
        Tue,  7 Dec 2021 03:08:15 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de,
        robin.murphy@arm.com, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, vbabka@suse.cz,
        m.szyprowski@samsung.com, John.p.donnelly@oracle.com,
        kexec@lists.infradead.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH RESEND v2 3/5] mm_zone: add function to check if managed dma zone exists
Date:   Tue,  7 Dec 2021 11:07:48 +0800
Message-Id: <20211207030750.30824-4-bhe@redhat.com>
In-Reply-To: <20211207030750.30824-1-bhe@redhat.com>
References: <20211207030750.30824-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some places of the current kernel, it assumes that dma zone must have
managed pages if CONFIG_ZONE_DMA is enabled. While this is not always true.
E.g in kdump kernel of x86_64, only low 1M is presented and locked down
at very early stage of boot, so that there's no managed pages at all in
DMA zone. This exception will always cause page allocation failure if page
is requested from DMA zone.

Here add function has_managed_dma() and the relevant helper functions to
check if there's DMA zone with managed pages. It will be used in later
patches.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 include/linux/mmzone.h | 21 +++++++++++++++++++++
 mm/page_alloc.c        | 11 +++++++++++
 2 files changed, 32 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 58e744b78c2c..82d23e13e0e5 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -998,6 +998,18 @@ static inline bool zone_is_zone_device(struct zone *zone)
 }
 #endif
 
+#ifdef CONFIG_ZONE_DMA
+static inline bool zone_is_dma(struct zone *zone)
+{
+	return zone_idx(zone) == ZONE_DMA;
+}
+#else
+static inline bool zone_is_dma(struct zone *zone)
+{
+	return false;
+}
+#endif
+
 /*
  * Returns true if a zone has pages managed by the buddy allocator.
  * All the reclaim decisions have to use this function rather than
@@ -1046,6 +1058,7 @@ static inline int is_highmem_idx(enum zone_type idx)
 #endif
 }
 
+bool has_managed_dma(void);
 /**
  * is_highmem - helper function to quickly check if a struct zone is a
  *              highmem zone or not.  This is an attempt to keep references
@@ -1131,6 +1144,14 @@ extern struct zone *next_zone(struct zone *zone);
 			; /* do nothing */		\
 		else
 
+#define for_each_managed_zone(zone)		        \
+	for (zone = (first_online_pgdat())->node_zones; \
+	     zone;					\
+	     zone = next_zone(zone))			\
+		if (!managed_zone(zone))		\
+			; /* do nothing */		\
+		else
+
 static inline struct zone *zonelist_zone(struct zoneref *zoneref)
 {
 	return zoneref->zone;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c5952749ad40..ac0ea42a4e5f 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9459,4 +9459,15 @@ bool take_page_off_buddy(struct page *page)
 	spin_unlock_irqrestore(&zone->lock, flags);
 	return ret;
 }
+
+bool has_managed_dma(void)
+{
+	struct zone *zone;
+
+	for_each_managed_zone(zone) {
+		if (zone_is_dma(zone))
+			return true;
+	}
+	return false;
+}
 #endif
-- 
2.17.2

