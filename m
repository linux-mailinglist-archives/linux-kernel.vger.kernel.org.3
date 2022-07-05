Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA805664FC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbiGEI1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 04:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230152AbiGEI1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 04:27:05 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A50C13E01
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 01:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657009623; x=1688545623;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=87nKChQAMSt/8e7Pv+us8zTUekQ9gM88+8g8bJ3bwvA=;
  b=cjyi44yTh6I4BLjkccO1ua2DmLRvVWMwDYaryjPprUhvl1VSyvhDR5wt
   0F5aVYcnQjSgDi6FN/N1tmI41sBcLbDjoragTBh6/fpYDPXDNkjXIxq9C
   +BXprmNBwhftpKQyOJPaUs13Y5lmbRd+GixO8xT3MmYLsqWv16JJoVHGd
   gqvbPpp52XbfzlUMzZOExCYCsZvn6USJ8quRxW0P62YsG/xqjyxU32/wB
   oT3J7kNwOnpMTGlKaBkNukC5aA/IsVfcKXakCdu/uhjW+iyKwdbTB1LS2
   RNE3sXMojKJHeeUsbojA/BFXdHcaQeZ/SWQF2CnXVJDXwDIodxzjnJnoh
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="263713136"
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="263713136"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 01:27:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,245,1650956400"; 
   d="scan'208";a="592834150"
Received: from black.fi.intel.com (HELO black.fi.intel.com.) ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 05 Jul 2022 01:27:02 -0700
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 3/6] intel_th: msu: Fix vmalloced buffers
Date:   Tue,  5 Jul 2022 11:26:34 +0300
Message-Id: <20220705082637.59979-4-alexander.shishkin@linux.intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220705082637.59979-1-alexander.shishkin@linux.intel.com>
References: <20220705082637.59979-1-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

After commit f5ff79fddf0e ("dma-mapping: remove CONFIG_DMA_REMAP") there's
a chance of DMA buffer getting allocated via vmalloc(), which messes up
the mmapping code:

> RIP: msc_mmap_fault [intel_th_msu]
> Call Trace:
>  <TASK>
>  __do_fault
>  do_fault
...

Fix this by accounting for vmalloc possibility.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Fixes: ba39bd830605 ("intel_th: msu: Switch over to scatterlist")
---
 drivers/hwtracing/intel_th/msu.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/intel_th/msu.c b/drivers/hwtracing/intel_th/msu.c
index 70a07b4e9967..6c8215a47a60 100644
--- a/drivers/hwtracing/intel_th/msu.c
+++ b/drivers/hwtracing/intel_th/msu.c
@@ -1067,6 +1067,16 @@ msc_buffer_set_uc(struct msc *msc) {}
 static inline void msc_buffer_set_wb(struct msc *msc) {}
 #endif /* CONFIG_X86 */
 
+static struct page *msc_sg_page(struct scatterlist *sg)
+{
+	void *addr = sg_virt(sg);
+
+	if (is_vmalloc_addr(addr))
+		return vmalloc_to_page(addr);
+
+	return sg_page(sg);
+}
+
 /**
  * msc_buffer_win_alloc() - alloc a window for a multiblock mode
  * @msc:	MSC device
@@ -1137,7 +1147,7 @@ static void __msc_buffer_win_free(struct msc *msc, struct msc_window *win)
 	int i;
 
 	for_each_sg(win->sgt->sgl, sg, win->nr_segs, i) {
-		struct page *page = sg_page(sg);
+		struct page *page = msc_sg_page(sg);
 
 		page->mapping = NULL;
 		dma_free_coherent(msc_dev(win->msc)->parent->parent, PAGE_SIZE,
@@ -1401,7 +1411,7 @@ static struct page *msc_buffer_get_page(struct msc *msc, unsigned long pgoff)
 	pgoff -= win->pgoff;
 
 	for_each_sg(win->sgt->sgl, sg, win->nr_segs, blk) {
-		struct page *page = sg_page(sg);
+		struct page *page = msc_sg_page(sg);
 		size_t pgsz = PFN_DOWN(sg->length);
 
 		if (pgoff < pgsz)
-- 
2.35.1

