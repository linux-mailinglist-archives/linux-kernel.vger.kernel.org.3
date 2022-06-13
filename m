Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75702549C54
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244427AbiFMS4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345085AbiFMSz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:55:27 -0400
X-Greylist: delayed 345 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Jun 2022 08:59:53 PDT
Received: from mx4.veeam.com (mx4.veeam.com [104.41.138.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD41FC82F;
        Mon, 13 Jun 2022 08:59:53 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 534EECCE09;
        Mon, 13 Jun 2022 18:54:13 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx4-2022; t=1655135653;
        bh=aRFGym7kwa4RqUADCDRdVFkUJkXbvEQPS4p/ABSZMYo=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=X9m9ZYcme0Y5JmeuPizSlRQCNoDbcVOWg45FpiQHM+q1zySyZO0W6QNO66HKSX59N
         gM7Fc7AQA9JrnL/cKjap+RKipC9qcS+2lADFgcnY5uFdU4esrr7HjSO7t0cLzUOQw5
         J16d59gViAUXnLGIDonOGkdMcrN1amyFp9KnAZADwMdsS+3MAFh0tORnGJNJr+3vn3
         4H9Esh9csGM6MJI2jACjmy7WZ1+ezCbkfxvOv1c99UKPKk2nSvQDgzS74NlpU6FSiZ
         ZM0FnRCi2iUuvnRWiX1idQpbRvbRybvEzmPZk9L8SYZNfKXWPBSuDYM3Ahif1HAlT7
         K072HF5W1WQgQ==
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Mon, 13 Jun 2022 17:54:10 +0200
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH 04/20] block, blksnap: init() and exit() functions
Date:   Mon, 13 Jun 2022 18:52:57 +0300
Message-ID: <1655135593-1900-5-git-send-email-sergei.shtepa@veeam.com>
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
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Contains callback functions for loading and unloading the module. The
module parameters and other mandatory declarations for the kernel module
are also defined.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/block/blksnap/main.c    | 109 ++++++++++++++++++++++++++++++++
 drivers/block/blksnap/params.h  |  10 +++
 drivers/block/blksnap/version.h |   8 +++
 3 files changed, 127 insertions(+)
 create mode 100644 drivers/block/blksnap/main.c
 create mode 100644 drivers/block/blksnap/params.h
 create mode 100644 drivers/block/blksnap/version.h

diff --git a/drivers/block/blksnap/main.c b/drivers/block/blksnap/main.c
new file mode 100644
index 000000000000..9737df4e6461
--- /dev/null
+++ b/drivers/block/blksnap/main.c
@@ -0,0 +1,109 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/module.h>
+#include <linux/blk_snap.h>
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+#include "memory_checker.h"
+#endif
+#include "version.h"
+#include "params.h"
+#include "ctrl.h"
+#include "sysfs.h"
+#include "snapimage.h"
+#include "snapshot.h"
+#include "tracker.h"
+#include "diff_io.h"
+
+static int __init blk_snap_init(void)
+{
+	int result;
+
+	pr_info("Loading\n");
+	pr_debug("Version: %s\n", VERSION_STR);
+	pr_debug("tracking_block_minimum_shift: %d\n",
+		 tracking_block_minimum_shift);
+	pr_debug("tracking_block_maximum_count: %d\n",
+		 tracking_block_maximum_count);
+	pr_debug("chunk_minimum_shift: %d\n", chunk_minimum_shift);
+	pr_debug("chunk_maximum_count: %d\n", chunk_maximum_count);
+	pr_debug("chunk_maximum_in_cache: %d\n", chunk_maximum_in_cache);
+	pr_debug("free_diff_buffer_pool_size: %d\n",
+		 free_diff_buffer_pool_size);
+	pr_debug("diff_storage_minimum: %d\n", diff_storage_minimum);
+
+	result = diff_io_init();
+	if (result)
+		return result;
+
+	result = snapimage_init();
+	if (result)
+		return result;
+
+	result = tracker_init();
+	if (result)
+		return result;
+
+	result = ctrl_init();
+	if (result)
+		return result;
+
+	result = sysfs_init();
+	return result;
+}
+
+static void __exit blk_snap_exit(void)
+{
+	pr_info("Unloading module\n");
+
+	sysfs_done();
+	ctrl_done();
+
+	diff_io_done();
+	snapshot_done();
+	snapimage_done();
+	tracker_done();
+
+	pr_info("Module was unloaded\n");
+}
+
+module_init(blk_snap_init);
+module_exit(blk_snap_exit);
+
+int tracking_block_minimum_shift = CONFIG_BLK_SNAP_TRACKING_BLOCK_MINIMUM_SHIFT;
+int tracking_block_maximum_count = CONFIG_BLK_SNAP_TRACKING_BLOCK_MAXIMUM_COUNT;
+int chunk_minimum_shift = CONFIG_BLK_SNAP_CHUNK_MINIMUM_SHIFT;
+int chunk_maximum_count = CONFIG_BLK_SNAP_CHUNK_MAXIMUM_COUNT;
+int chunk_maximum_in_cache = CONFIG_BLK_SNAP_CHUNK_MAXIMUM_IN_CACHE;
+int free_diff_buffer_pool_size = CONFIG_BLK_SNAP_FREE_DIFF_BUFFER_POOL_SIZE;
+int diff_storage_minimum = CONFIG_BLK_SNAP_DIFF_STORAGE_MINIMUM;
+
+module_param_named(tracking_block_minimum_shift, tracking_block_minimum_shift,
+		   int, 0644);
+MODULE_PARM_DESC(tracking_block_minimum_shift,
+		 "The power of 2 for minimum trackings block size");
+module_param_named(tracking_block_maximum_count, tracking_block_maximum_count,
+		   int, 0644);
+MODULE_PARM_DESC(tracking_block_maximum_count,
+		 "The limit of the maximum number of trackings blocks");
+module_param_named(chunk_minimum_shift, chunk_minimum_shift, int, 0644);
+MODULE_PARM_DESC(chunk_minimum_shift,
+		 "The power of 2 for minimum snapshots chunk size");
+module_param_named(chunk_maximum_count, chunk_maximum_count, int, 0644);
+MODULE_PARM_DESC(chunk_maximum_count,
+		 "The limit of the maximum number of snapshots chunks");
+module_param_named(chunk_maximum_in_cache, chunk_maximum_in_cache, int, 0644);
+MODULE_PARM_DESC(chunk_maximum_in_cache,
+		 "The limit of the maximum chunks in memory cache");
+module_param_named(free_diff_buffer_pool_size, free_diff_buffer_pool_size, int,
+		   0644);
+MODULE_PARM_DESC(free_diff_buffer_pool_size,
+		 "The maximum size of the free buffers pool");
+module_param_named(diff_storage_minimum, diff_storage_minimum, int, 0644);
+MODULE_PARM_DESC(
+	diff_storage_minimum,
+	"The minimum allowable size of the difference storage in sectors");
+
+MODULE_DESCRIPTION("Block Layer Snapshot Kernel Module");
+MODULE_VERSION(VERSION_STR);
+MODULE_AUTHOR("Veeam Software Group GmbH");
+MODULE_LICENSE("GPL");
diff --git a/drivers/block/blksnap/params.h b/drivers/block/blksnap/params.h
new file mode 100644
index 000000000000..1f8f0bd23e9f
--- /dev/null
+++ b/drivers/block/blksnap/params.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#pragma once
+
+extern int tracking_block_minimum_shift;
+extern int tracking_block_maximum_count;
+extern int chunk_minimum_shift;
+extern int chunk_maximum_count;
+extern int chunk_maximum_in_cache;
+extern int free_diff_buffer_pool_size;
+extern int diff_storage_minimum;
diff --git a/drivers/block/blksnap/version.h b/drivers/block/blksnap/version.h
new file mode 100644
index 000000000000..0d02a68f44a8
--- /dev/null
+++ b/drivers/block/blksnap/version.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#pragma once
+
+#define VERSION_MAJOR 1
+#define VERSION_MINOR 0
+#define VERSION_REVISION 0
+#define VERSION_BUILD 0
+#define VERSION_STR "1.0.0.0"
-- 
2.20.1

