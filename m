Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C18247E0F2
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 10:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347524AbhLWJp1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 04:45:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24879 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232539AbhLWJpZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 04:45:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640252725;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MioVwl50/1zwGEDq/n1UXoEdkpTw5W8/roYGjRktX6M=;
        b=EGadDvAzfVz4IfeyoA6LE+JeKlvauUSq+zQv4himC6T3iEJuH0Wm+3MbZB55w+pz1X+Efu
        QvGVLcoooOIWFLg838KCC9l98a+EI6jg1uqb68fpgXxmoY2kvRdxqbPb58mwgK1aGZ6EXG
        IOzxnJloFwg6ZLMeKdSMsWoAhfA7b4w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-488-qTwuIA3kOOO6jy3G6Mc_dg-1; Thu, 23 Dec 2021 04:45:21 -0500
X-MC-Unique: qTwuIA3kOOO6jy3G6Mc_dg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C777318397A7;
        Thu, 23 Dec 2021 09:45:19 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-13-71.pek2.redhat.com [10.72.13.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2CA215F4E7;
        Thu, 23 Dec 2021 09:44:55 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@lst.de,
        cl@linux.com, John.p.donnelly@oracle.com,
        kexec@lists.infradead.org, bhe@redhat.com, 42.hyeyoo@gmail.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz, David.Laight@ACULAB.COM, david@redhat.com,
        x86@kernel.org, bp@alien8.de
Subject: [PATCH v4 1/3] mm_zone: add function to check if managed dma zone exists
Date:   Thu, 23 Dec 2021 17:44:33 +0800
Message-Id: <20211223094435.248523-2-bhe@redhat.com>
In-Reply-To: <20211223094435.248523-1-bhe@redhat.com>
References: <20211223094435.248523-1-bhe@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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

Fixes: 6f599d84231f ("x86/kdump: Always reserve the low 1M when the crashkernel option is specified")
Cc: stable@vger.kernel.org
Signed-off-by: Baoquan He <bhe@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mmzone.h |  9 +++++++++
 mm/page_alloc.c        | 15 +++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/linux/mmzone.h b/include/linux/mmzone.h
index 58e744b78c2c..6e1b726e9adf 100644
--- a/include/linux/mmzone.h
+++ b/include/linux/mmzone.h
@@ -1046,6 +1046,15 @@ static inline int is_highmem_idx(enum zone_type idx)
 #endif
 }
 
+#ifdef CONFIG_ZONE_DMA
+bool has_managed_dma(void);
+#else
+static inline bool has_managed_dma(void)
+{
+	return false;
+}
+#endif
+
 /**
  * is_highmem - helper function to quickly check if a struct zone is a
  *              highmem zone or not.  This is an attempt to keep references
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index c5952749ad40..7c7a0b5de2ff 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -9460,3 +9460,18 @@ bool take_page_off_buddy(struct page *page)
 	return ret;
 }
 #endif
+
+#ifdef CONFIG_ZONE_DMA
+bool has_managed_dma(void)
+{
+	struct pglist_data *pgdat;
+
+	for_each_online_pgdat(pgdat) {
+		struct zone *zone = &pgdat->node_zones[ZONE_DMA];
+
+		if (managed_zone(zone))
+			return true;
+	}
+	return false;
+}
+#endif /* CONFIG_ZONE_DMA */
-- 
2.26.3

