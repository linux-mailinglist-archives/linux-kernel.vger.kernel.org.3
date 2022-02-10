Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC874B0742
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 08:31:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236577AbiBJHa0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 02:30:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236350AbiBJH3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 02:29:52 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DA626E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 23:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=pctRQv8OEzOU2Keqo0z+r/HPLbvIIo5mspYS6O2PkxM=; b=BYP5tYP/QKbbO2Vxjb9/ZaUb6D
        nOdjuF6YkyS8HOXD1axOZbLCvz7kTpUdSm/82tKapGLua35RDF1KAfcShGILYfBKcJF0DPEGPaHKh
        mH9ohgT/hmmtcEUkxTHXeXo3EqRxrifPdgOFn0hBVsnOWgqs16A0s1G++JMBlHMgYYnsieRes/Lnf
        mKU8y5YstLGRqyg4El2iRyledqgz+PFodWP/L3bxaM9vuVB4bK5gxnsxNscCaOOrKLCYzIhzly4OP
        z6/DNQAhFf5my18jIQXb7GMc/sLDD6GDh5PUPuRsBA46cRcG2oDm+aJN/gVAjoV43/smEJtMvTO+w
        kVYL7WKA==;
Received: from [2001:4bb8:188:3efc:8014:b2f2:fdfd:57ea] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nI3th-002sR5-33; Thu, 10 Feb 2022 07:29:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        Ben Skeggs <bskeggs@redhat.com>,
        Karol Herbst <kherbst@redhat.com>,
        Lyude Paul <lyude@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Alistair Popple <apopple@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Ralph Campbell <rcampbell@nvidia.com>,
        linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        nvdimm@lists.linux.dev, linux-mm@kvack.org
Subject: [PATCH 26/27] mm/gup: migrate device coherent pages when pinning instead of failing
Date:   Thu, 10 Feb 2022 08:28:27 +0100
Message-Id: <20220210072828.2930359-27-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220210072828.2930359-1-hch@lst.de>
References: <20220210072828.2930359-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alistair Popple <apopple@nvidia.com>

Currently any attempts to pin a device coherent page will fail. This is
because device coherent pages need to be managed by a device driver, and
pinning them would prevent a driver from migrating them off the device.

However this is no reason to fail pinning of these pages. These are
coherent and accessible from the CPU so can be migrated just like
pinning ZONE_MOVABLE pages. So instead of failing all attempts to pin
them first try migrating them out of ZONE_DEVICE.

Signed-off-by: Alistair Popple <apopple@nvidia.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
[hch: rebased to the split device memory checks,
      moved migrate_device_page to migrate_device.c]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/gup.c            | 37 ++++++++++++++++++++++++++-----
 mm/internal.h       |  1 +
 mm/migrate_device.c | 53 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 85 insertions(+), 6 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index 39b23ad39a7bde..41349b685eafb4 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1889,9 +1889,31 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 			ret = -EFAULT;
 			goto unpin_pages;
 		}
+
+		/*
+		 * Device coherent pages are managed by a driver and should not
+		 * be pinned indefinitely as it prevents the driver moving the
+		 * page. So when trying to pin with FOLL_LONGTERM instead try
+		 * to migrate the page out of device memory.
+		 */
 		if (is_device_coherent_page(head)) {
-			ret = -EFAULT;
-			goto unpin_pages;
+			WARN_ON_ONCE(PageCompound(head));
+
+			/*
+			 * Migration will fail if the page is pinned, so convert
+			 * the pin on the source page to a normal reference.
+			 */
+			if (gup_flags & FOLL_PIN) {
+				get_page(head);
+				unpin_user_page(head);
+			}
+
+			pages[i] = migrate_device_page(head, gup_flags);
+			if (!pages[i]) {
+				ret = -EBUSY;
+				goto unpin_pages;
+			}
+			continue;
 		}
 
 		if (is_pinnable_page(head))
@@ -1931,10 +1953,13 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 	return nr_pages;
 
 unpin_pages:
-	if (gup_flags & FOLL_PIN) {
-		unpin_user_pages(pages, nr_pages);
-	} else {
-		for (i = 0; i < nr_pages; i++)
+	for (i = 0; i < nr_pages; i++) {
+		if (!pages[i])
+			continue;
+
+		if (gup_flags & FOLL_PIN)
+			unpin_user_page(pages[i]);
+		else
 			put_page(pages[i]);
 	}
 
diff --git a/mm/internal.h b/mm/internal.h
index a67222d17e5987..1bded5d7f41a9d 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -719,5 +719,6 @@ int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
 		      unsigned long addr, int page_nid, int *flags);
 
 void free_zone_device_page(struct page *page);
+struct page *migrate_device_page(struct page *page, unsigned int gup_flags);
 
 #endif	/* __MM_INTERNAL_H */
diff --git a/mm/migrate_device.c b/mm/migrate_device.c
index 03e182f9fc7865..3373b535d5c9d9 100644
--- a/mm/migrate_device.c
+++ b/mm/migrate_device.c
@@ -767,3 +767,56 @@ void migrate_vma_finalize(struct migrate_vma *migrate)
 	}
 }
 EXPORT_SYMBOL(migrate_vma_finalize);
+
+/*
+ * Migrate a device coherent page back to normal memory.  The caller should have
+ * a reference on page which will be copied to the new page if migration is
+ * successful or dropped on failure.
+ */
+struct page *migrate_device_page(struct page *page, unsigned int gup_flags)
+{
+	unsigned long src_pfn, dst_pfn = 0;
+	struct migrate_vma args;
+	struct page *dpage;
+
+	lock_page(page);
+	src_pfn = migrate_pfn(page_to_pfn(page)) | MIGRATE_PFN_MIGRATE;
+	args.src = &src_pfn;
+	args.dst = &dst_pfn;
+	args.cpages = 1;
+	args.npages = 1;
+	args.vma = NULL;
+	migrate_vma_setup(&args);
+	if (!(src_pfn & MIGRATE_PFN_MIGRATE))
+		return NULL;
+
+	dpage = alloc_pages(GFP_USER | __GFP_NOWARN, 0);
+
+	/*
+	 * get/pin the new page now so we don't have to retry gup after
+	 * migrating. We already have a reference so this should never fail.
+	 */
+	if (dpage && WARN_ON_ONCE(!try_grab_page(dpage, gup_flags))) {
+		__free_pages(dpage, 0);
+		dpage = NULL;
+	}
+
+	if (dpage) {
+		lock_page(dpage);
+		dst_pfn = migrate_pfn(page_to_pfn(dpage));
+	}
+
+	migrate_vma_pages(&args);
+	if (src_pfn & MIGRATE_PFN_MIGRATE)
+		copy_highpage(dpage, page);
+	migrate_vma_finalize(&args);
+	if (dpage && !(src_pfn & MIGRATE_PFN_MIGRATE)) {
+		if (gup_flags & FOLL_PIN)
+			unpin_user_page(dpage);
+		else
+			put_page(dpage);
+		dpage = NULL;
+	}
+
+	return dpage;
+}
-- 
2.30.2

