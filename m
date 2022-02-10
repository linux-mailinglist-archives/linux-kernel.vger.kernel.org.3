Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2914F4B0738
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 08:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236149AbiBJH3x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 02:29:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236073AbiBJH32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 02:29:28 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A50226F
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 23:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=zGyKKbpob2jKuUoVhg21xS0brp0ZuvbpPYxyQsLpvrY=; b=iJGuHG0f0lD7DoQncmPS2ParR5
        KxCks+Bp5nJENeFnI4VlZU9TuxI3ve9mj03FG6U7WpDS92xIoLF7uKO6UFMuXnHvzmdmocQW3BDy+
        493NiErvPKBDX7e4tdCzX6+mKgsc9YcD8xxsiq26BWP/+hAuRU5GAvnE1Ona+4KghRp8m58WECJCE
        wpxIn0by2WrZttMVtHFMFk4CwasYSLanhvoWdHa/JPPo+H3E+k7Z6njMlEnvzPeDjjEctHSRHiX/g
        lCS6jqLsBWkXhw6wOT3p4S0KafLAs/9eWHggPdIRwc2tFevhnT6M2jVXY0TmUVm+Hb4tv7LeyXms+
        c3GmYNRw==;
Received: from [2001:4bb8:188:3efc:8014:b2f2:fdfd:57ea] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nI3tH-002s8p-Jo; Thu, 10 Feb 2022 07:29:20 +0000
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
        nvdimm@lists.linux.dev, linux-mm@kvack.org,
        Alex Sierra <alex.sierra@amd.com>
Subject: [PATCH 17/27] mm/gup: fail get_user_pages for LONGTERM dev coherent type
Date:   Thu, 10 Feb 2022 08:28:18 +0100
Message-Id: <20220210072828.2930359-18-hch@lst.de>
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

From: Alex Sierra <alex.sierra@amd.com>

Avoid long term pinning for Coherent device type pages. This could
interfere with their own device memory manager. For now, we are just
returning error for PIN_LONGTERM Coherent device type pages. Eventually,
these type of pages will get migrated to system memory, once the device
migration pages support is added.

Signed-off-by: Alex Sierra <alex.sierra@amd.com>
Acked-by: Felix Kuehling <Felix.Kuehling@amd.com>
Reviewed-by: Alistair Poppple <apopple@nvidia.com>
[hch: rebased on previous cleanups, split the two checks]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 mm/gup.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/mm/gup.c b/mm/gup.c
index 37d6c24ca71225..39b23ad39a7bde 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1881,6 +1881,19 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 			continue;
 		prev_head = head;
 
+		/*
+		 * Device private pages will get faulted in during gup so it
+		 * shouldn't be possible to see one here.
+		 */
+		if (WARN_ON_ONCE(is_device_private_page(head))) {
+			ret = -EFAULT;
+			goto unpin_pages;
+		}
+		if (is_device_coherent_page(head)) {
+			ret = -EFAULT;
+			goto unpin_pages;
+		}
+
 		if (is_pinnable_page(head))
 			continue;
 
@@ -1925,7 +1938,7 @@ static long check_and_migrate_movable_pages(unsigned long nr_pages,
 			put_page(pages[i]);
 	}
 
-	if (!list_empty(&movable_page_list)) {
+	if (!ret && !list_empty(&movable_page_list)) {
 		struct migration_target_control mtc = {
 			.nid = NUMA_NO_NODE,
 			.gfp_mask = GFP_USER | __GFP_NOWARN,
-- 
2.30.2

