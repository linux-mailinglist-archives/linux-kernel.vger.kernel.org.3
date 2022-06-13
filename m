Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51135549C61
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345144AbiFMS5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237408AbiFMSxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:53:00 -0400
Received: from mx2.veeam.com (mx2.veeam.com [64.129.123.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EE2F45F4;
        Mon, 13 Jun 2022 08:55:17 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 95DB6431DB;
        Mon, 13 Jun 2022 11:55:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx2-2022; t=1655135714;
        bh=m5WZciF763E0+xCIFmFDSURLec1OZVtfXv6gTUhZ7xc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=KEZcWRF1G+QDkNvQa4Gq7V1cn+XBwcXUTvTg4DapPGa38uy8tGN4hoEtzj0sO+a+6
         AhsseO7rfJX8AzoDrzbxK1IucG/Bf2t3rvmkSv8GAEBLqZXLIEFxeoi3U+P/cSAMY5
         Demo556Ii1jrHE+iJZ8LBxJeLO2EW/HSCDo/hjI28+MePQwnugtKqNtVUPDbw0EwUu
         dWL4DNkU0u6Z65tyYjI6lWd8YpRO/N+3l0n1QCv/7fWEqPOJaQFZXS84h7kA8kqpDp
         uWCVugL6DwwLQgaFUYTwrg5UEGLIJszs8WR5Ud6ek83dxrKhPHrtwRQe0ZlF4p/vBK
         x/QIqdZ/HKh+A==
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Mon, 13 Jun 2022 17:54:53 +0200
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH 17/20] block, blksnap: debugging mechanism for monitoring memory consumption
Date:   Mon, 13 Jun 2022 18:53:10 +0300
Message-ID: <1655135593-1900-18-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1655135593-1900-1-git-send-email-sergei.shtepa@veeam.com>
References: <1655135593-1900-1-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx01.amust.local (172.24.128.102) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A29D2A50A536D7766
X-Veeam-MMEX: True
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Of course, the kernel contains mechanisms for detecting memory leaks.
There are tools for monitoring memory consumption. However, this
mechanism turned out to be very simple and convenient for debugging,
and therefore it was decided to leave it in the current version.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/block/blksnap/memory_checker.c | 100 +++++++++++++++++++++++++
 drivers/block/blksnap/memory_checker.h |  41 ++++++++++
 2 files changed, 141 insertions(+)
 create mode 100644 drivers/block/blksnap/memory_checker.c
 create mode 100644 drivers/block/blksnap/memory_checker.h

diff --git a/drivers/block/blksnap/memory_checker.c b/drivers/block/blksnap/memory_checker.c
new file mode 100644
index 000000000000..96988ed99f08
--- /dev/null
+++ b/drivers/block/blksnap/memory_checker.c
@@ -0,0 +1,100 @@
+// SPDX-License-Identifier: GPL-2.0
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+#define pr_fmt(fmt) KBUILD_MODNAME "-memory_checker: " fmt
+#include <linux/atomic.h>
+#include <linux/module.h>
+#include "memory_checker.h"
+
+char *memory_object_names[] = {
+	/*alloc_page*/
+	"page",
+	/*kzalloc*/
+	"cbt_map",
+	"chunk",
+	"blk_snap_snaphot_event",
+	"diff_area",
+	"big_buffer",
+	"diff_io",
+	"diff_storage",
+	"storage_bdev",
+	"storage_block",
+	"diff_region",
+	"diff_buffer",
+	"event",
+	"snapimage",
+	"snapshot",
+	"tracker",
+	"tracked_device",
+	/*kcalloc*/
+	"blk_snap_cbt_info",
+	"blk_snap_block_range",
+	"blk_snap_dev_t",
+	"tracker_array",
+	"snapimage_array",
+	"superblock_array",
+	"blk_snap_image_info",
+	/*end*/
+};
+
+static_assert(
+	sizeof(memory_object_names) == (memory_object_count * sizeof(char *)),
+	"The size of enum memory_object_type is not equal to size of memory_object_names array.");
+
+static atomic_t memory_counter[memory_object_count];
+static atomic_t memory_counter_max[memory_object_count];
+
+void memory_object_inc(enum memory_object_type type)
+{
+	int value;
+
+	if (unlikely(type >= memory_object_count))
+		return;
+
+	value = atomic_inc_return(&memory_counter[type]);
+	if (value > atomic_read(&memory_counter_max[type]))
+		atomic_inc(&memory_counter_max[type]);
+}
+
+void memory_object_dec(enum memory_object_type type)
+{
+	if (unlikely(type >= memory_object_count))
+		return;
+
+	atomic_dec(&memory_counter[type]);
+}
+
+int memory_object_print(void)
+{
+	int inx;
+	int not_free = 0;
+
+	pr_info("Objects in memory:\n");
+	for (inx = 0; inx < memory_object_count; inx++) {
+		int count = atomic_read(&memory_counter[inx]);
+
+		if (count) {
+			not_free += count;
+			pr_info("%s: %d\n", memory_object_names[inx], count);
+		}
+	}
+	if (not_free)
+		pr_info("Found %d allocated objects\n", not_free);
+	else
+		pr_info("All objects have been released\n");
+	return not_free;
+}
+
+void memory_object_max_print(void)
+{
+	int inx;
+
+	pr_info("Maximim objects in memory:\n");
+	for (inx = 0; inx < memory_object_count; inx++) {
+		int count = atomic_read(&memory_counter_max[inx]);
+
+		if (count)
+			pr_info("%s: %d\n", memory_object_names[inx], count);
+	}
+	pr_info(".\n");
+}
+#endif
diff --git a/drivers/block/blksnap/memory_checker.h b/drivers/block/blksnap/memory_checker.h
new file mode 100644
index 000000000000..b19a2584d0ce
--- /dev/null
+++ b/drivers/block/blksnap/memory_checker.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#pragma once
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+
+enum memory_object_type {
+	/*alloc_page*/
+	memory_object_page,
+	/*kzalloc*/
+	memory_object_cbt_map,
+	memory_object_chunk,
+	memory_object_blk_snap_snapshot_event,
+	memory_object_diff_area,
+	memory_object_big_buffer,
+	memory_object_diff_io,
+	memory_object_diff_storage,
+	memory_object_storage_bdev,
+	memory_object_storage_block,
+	memory_object_diff_region,
+	memory_object_diff_buffer,
+	memory_object_event,
+	memory_object_snapimage,
+	memory_object_snapshot,
+	memory_object_tracker,
+	memory_object_tracked_device,
+	/*kcalloc*/
+	memory_object_blk_snap_cbt_info,
+	memory_object_blk_snap_block_range,
+	memory_object_blk_snap_dev_t,
+	memory_object_tracker_array,
+	memory_object_snapimage_array,
+	memory_object_superblock_array,
+	memory_object_blk_snap_image_info,
+	/*end*/
+	memory_object_count
+};
+
+void memory_object_inc(enum memory_object_type type);
+void memory_object_dec(enum memory_object_type type);
+int  memory_object_print(void);
+void memory_object_max_print(void);
+#endif
-- 
2.20.1

