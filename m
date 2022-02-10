Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A7B24B071D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 08:29:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235980AbiBJH3Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 02:29:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236123AbiBJH3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 02:29:04 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEB8410BE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 23:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=nwQK8rTzBeKvGcrtCRWh1dh2jjlfr7yyGwSU0Am+w+s=; b=HpIhsMcgR2ml6ZX6xWqvoyf1/O
        JYbbjkJeGj+Vr2y7NNas0msPbsv7XIDfhYm/ASJ2vOYm9xc+NnDrDB5b9TDYBwhApZnQ8388w+VMC
        oV4R477KDNIdE8Lctpl7xV0S2GA4ZImCbTINY00BJFrJRL2sZxyRSw/y+xxkn1mK9yZh5vDkDDfJ7
        yE7oQ92FoD5PiopPrvkomGyl+xLc+e56mzByFPCIS0GaxRV2G2ppPSXe8bJsNC+nc+AlDD7noP8qw
        9ZyBl+/C/fiuzpkjde64hfsOYBI43MFjAHA922mCys8kjTfXl5CJIxWQRspbVqIlB6t/25F45NZLI
        YoiVjs8w==;
Received: from [2001:4bb8:188:3efc:8014:b2f2:fdfd:57ea] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nI3su-002rtD-Me; Thu, 10 Feb 2022 07:28:57 +0000
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
Subject: [PATCH 09/27] mm: generalize the pgmap based page_free infrastructure
Date:   Thu, 10 Feb 2022 08:28:10 +0100
Message-Id: <20220210072828.2930359-10-hch@lst.de>
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

Key off on the existence of ->page_free to prepare for adding support for
more pgmap types that are device managed and thus need the free callback.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/memremap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/mm/memremap.c b/mm/memremap.c
index fef5734d5e4933..e00ffcdba7b632 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -452,7 +452,7 @@ EXPORT_SYMBOL_GPL(get_dev_pagemap);
 
 void free_zone_device_page(struct page *page)
 {
-	if (WARN_ON_ONCE(!is_device_private_page(page)))
+	if (WARN_ON_ONCE(!page->pgmap->ops || !page->pgmap->ops->page_free))
 		return;
 
 	__ClearPageWaiters(page);
@@ -460,7 +460,7 @@ void free_zone_device_page(struct page *page)
 	mem_cgroup_uncharge(page_folio(page));
 
 	/*
-	 * When a device_private page is freed, the page->mapping field
+	 * When a device managed page is freed, the page->mapping field
 	 * may still contain a (stale) mapping value. For example, the
 	 * lower bits of page->mapping may still identify the page as an
 	 * anonymous page. Ultimately, this entire field is just stale
-- 
2.30.2

