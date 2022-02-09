Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02EA04AFA79
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 19:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239714AbiBIShY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 13:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239704AbiBISg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 13:36:57 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C04FC05CB8E;
        Wed,  9 Feb 2022 10:36:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644431805; x=1675967805;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v+VXW5fj89kbBLw30Yb+JRBx/zHxa1O7fYiS2MIddBE=;
  b=Q9hIZ2PjSWEyGiXCROtE2lwn853LbPMf/rTtNrVOwYae+CpBckUyd/L7
   /SRyGWwITHmAuBt6UmsRt8/wXkJuuhnphYL3/kTlYIm0h+l2PRB3VprKu
   FCmG9jhMgVS7agtSVHNTmdsQnhPd7izEdQe5aHtS46XLfCRlXehVoXCNU
   AIYGbjY6rfDyApoFiB3Ww6NutAws8tv7G1l2Lt/A3P3rjZEywplhOwqvg
   msVeUDvt9BtbNwxTTCYKCvAZmZ1iP4pqiPMzNnQLk5lzkiE2QpjoQMJFi
   n9kKFIxQHUqYRe6QW73p+3kroRhOvgGLeHrZi53/3JXeSFwmWdu7JlCTe
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10252"; a="229270391"
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="229270391"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2022 10:25:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,356,1635231600"; 
   d="scan'208";a="629374925"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga002.fm.intel.com with ESMTP; 09 Feb 2022 10:25:11 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 98AC4107; Wed,  9 Feb 2022 20:25:26 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Patrice Chotard <patrice.chotard@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v1 1/1] media: c8sectpfe: Clean up handling of *_buffer_aligned
Date:   Wed,  9 Feb 2022 20:25:21 +0200
Message-Id: <20220209182521.55632-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are a few cases where code is harder than needed to read.
Improve those by:
- dropping unnecessary castings (see note below)
- use PTR_ALING() to be more explicit on what's going on there
- use proper definitions instead of hard coded values

Note, dropping castings will allow to perform an additional check
that type is not changed from void * to something else, e.g. u64,
which may very well break the bitmap APIs.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 .../platform/sti/c8sectpfe/c8sectpfe-core.c   | 30 +++++++------------
 1 file changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
index 7bb1384e4bad..d60908ec9ea7 100644
--- a/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
+++ b/drivers/media/platform/sti/c8sectpfe/c8sectpfe-core.c
@@ -107,7 +107,7 @@ static void channel_swdemux_tsklet(struct tasklet_struct *t)
 				size,
 				DMA_FROM_DEVICE);
 
-	buf = (u8 *) channel->back_buffer_aligned;
+	buf = channel->back_buffer_aligned;
 
 	dev_dbg(fei->dev,
 		"chan=%d channel=%p num_packets = %d, buf = %p, pos = 0x%x\n\trp=0x%lx, wp=0x%lx\n",
@@ -176,7 +176,7 @@ static int c8sectpfe_start_feed(struct dvb_demux_feed *dvbdmxfeed)
 
 	channel = fei->channel_data[stdemux->tsin_index];
 
-	bitmap = (unsigned long *) channel->pid_buffer_aligned;
+	bitmap = channel->pid_buffer_aligned;
 
 	/* 8192 is a special PID */
 	if (dvbdmxfeed->pid == 8192) {
@@ -272,7 +272,7 @@ static int c8sectpfe_stop_feed(struct dvb_demux_feed *dvbdmxfeed)
 
 	channel = fei->channel_data[stdemux->tsin_index];
 
-	bitmap = (unsigned long *) channel->pid_buffer_aligned;
+	bitmap = channel->pid_buffer_aligned;
 
 	if (dvbdmxfeed->pid == 8192) {
 		tmp = readl(fei->io + C8SECTPFE_IB_PID_SET(channel->tsin_id));
@@ -333,8 +333,7 @@ static int c8sectpfe_stop_feed(struct dvb_demux_feed *dvbdmxfeed)
 			__func__, __LINE__, stdemux, channel->tsin_id);
 
 		/* turn off all PIDS in the bitmap */
-		memset((void *)channel->pid_buffer_aligned
-			, 0x00, PID_TABLE_SIZE);
+		memset(channel->pid_buffer_aligned, 0, PID_TABLE_SIZE);
 
 		/* manage cache so data is visible to HW */
 		dma_sync_single_for_device(fei->dev,
@@ -458,23 +457,19 @@ static int configure_memdma_and_inputblock(struct c8sectpfei *fei,
 
 	init_completion(&tsin->idle_completion);
 
-	tsin->back_buffer_start = kzalloc(FEI_BUFFER_SIZE +
-					FEI_ALIGNMENT, GFP_KERNEL);
-
+	tsin->back_buffer_start = kzalloc(FEI_BUFFER_SIZE + FEI_ALIGNMENT, GFP_KERNEL);
 	if (!tsin->back_buffer_start) {
 		ret = -ENOMEM;
 		goto err_unmap;
 	}
 
 	/* Ensure backbuffer is 32byte aligned */
-	tsin->back_buffer_aligned = tsin->back_buffer_start
-		+ FEI_ALIGNMENT;
+	tsin->back_buffer_aligned = tsin->back_buffer_start + FEI_ALIGNMENT;
 
-	tsin->back_buffer_aligned = (void *)
-		(((uintptr_t) tsin->back_buffer_aligned) & ~0x1F);
+	tsin->back_buffer_aligned = PTR_ALIGN(tsin->back_buffer_aligned, FEI_ALIGNMENT);
 
 	tsin->back_buffer_busaddr = dma_map_single(fei->dev,
-					(void *)tsin->back_buffer_aligned,
+					tsin->back_buffer_aligned,
 					FEI_BUFFER_SIZE,
 					DMA_BIDIRECTIONAL);
 
@@ -489,8 +484,7 @@ static int configure_memdma_and_inputblock(struct c8sectpfei *fei,
 	 * per pid. By powers of deduction we conclude stih407 family
 	 * is configured (at SoC design stage) for bit per pid.
 	 */
-	tsin->pid_buffer_start = kzalloc(2048, GFP_KERNEL);
-
+	tsin->pid_buffer_start = kzalloc(PID_TABLE_SIZE + PID_TABLE_SIZE, GFP_KERNEL);
 	if (!tsin->pid_buffer_start) {
 		ret = -ENOMEM;
 		goto err_unmap;
@@ -503,11 +497,9 @@ static int configure_memdma_and_inputblock(struct c8sectpfei *fei,
 	 * the register.
 	 */
 
-	tsin->pid_buffer_aligned = tsin->pid_buffer_start +
-		PID_TABLE_SIZE;
+	tsin->pid_buffer_aligned = tsin->pid_buffer_start + PID_TABLE_SIZE;
 
-	tsin->pid_buffer_aligned = (void *)
-		(((uintptr_t) tsin->pid_buffer_aligned) & ~0x3ff);
+	tsin->pid_buffer_aligned = PTR_ALIGN(tsin->pid_buffer_aligned, PID_TABLE_SIZE);
 
 	tsin->pid_buffer_busaddr = dma_map_single(fei->dev,
 						tsin->pid_buffer_aligned,
-- 
2.34.1

