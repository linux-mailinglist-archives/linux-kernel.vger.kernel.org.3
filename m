Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 278BC549C5F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233163AbiFMS53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343922AbiFMSxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:53:06 -0400
Received: from mx2.veeam.com (mx2.veeam.com [64.129.123.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2B30F5059;
        Mon, 13 Jun 2022 08:55:21 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx2.veeam.com (Postfix) with ESMTPS id 9C18843023;
        Mon, 13 Jun 2022 11:55:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx2-2022; t=1655135717;
        bh=6Cwo/SxoNVP3OE3qPkaFglLUcEDMuSRtn+M7BoPqfwI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=GrUDrOH6sXXEnPaB2INMtSUDWP9te2/XtEi3880mLTgB0PbuY8nUgNkk9tuIx610D
         PvYZWDAWnl1iSLdv8ypNOtpyZ0PZb/aLRa8PZcpPjEfhVwDZjdQo93g5mXwLsvh3/+
         VsrN267XXkCYOplMy9dh3pU7Hspq1YCVjs7ZMDLV51ezupbrUX5+dg+lfhYp/5RC1D
         Wjvv5s/Pib51Q2UXrMg+0sNXHF8eRavyN80qSlnf41c5fPX7ZwOdirBTGbzsj15nuy
         6DEbWq4NOHvPew2nv7vXUq/jQFt1udYONqqK2mjV+1lRo399h24QNAMM1wo3dA9DWR
         MiY/UyLJUihKw==
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Mon, 13 Jun 2022 17:54:57 +0200
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH 18/20] block, blksnap: Kconfig
Date:   Mon, 13 Jun 2022 18:53:11 +0300
Message-ID: <1655135593-1900-19-git-send-email-sergei.shtepa@veeam.com>
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

The module configuration file allows you to set default values for
module parameters.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/block/blksnap/Kconfig | 101 ++++++++++++++++++++++++++++++++++
 1 file changed, 101 insertions(+)
 create mode 100644 drivers/block/blksnap/Kconfig

diff --git a/drivers/block/blksnap/Kconfig b/drivers/block/blksnap/Kconfig
new file mode 100644
index 000000000000..8588a89e30ad
--- /dev/null
+++ b/drivers/block/blksnap/Kconfig
@@ -0,0 +1,101 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# block io layer filter module configuration
+#
+#
+
+config BLK_SNAP
+	tristate "Block device snapshot and change tracker module"
+	depends on BLK_FILTER
+	help
+	  Allow to create snapshots and track block changes for a block
+	  devices. Designed for creating backups for any block devices
+	  (without device mapper). Snapshots are temporary and are released
+	  then backup is completed. Change block tracking allows you to
+	  create incremental or differential backups.
+
+config BLK_SNAP_TRACKING_BLOCK_MINIMUM_SHIFT
+	depends on BLK_SNAP
+	int "The power of 2 for minimum trackings block size"
+	default 16
+	help
+	  The minimum tracking block size by default is 64 KB (shift 16)
+	  It's looks good for block device 128 GB or lower.
+	  In this case, the block device is divided into 2097152 blocks.
+
+config BLK_SNAP_TRACKING_BLOCK_MAXIMUM_COUNT
+	depends on BLK_SNAP
+	int "The limit of the maximum number of trackings blocks"
+	default 2097152
+	help
+	  As the size of the block device grows, the size of the tracking block
+	  size should also grow. For this purpose, the limit of the maximum
+	  number of block size is set.
+
+config BLK_SNAP_CHUNK_MINIMUM_SHIFT
+	depends on BLK_SNAP
+	int "The power of 2 for minimum snapshots chunk size"
+	default 18
+	help
+	  The minimum chunk size by default is 256 KB (shift 18)
+	  It's looks good for block device 128 GB or lower.
+	  In this case, the block device is divided into 524288 chunks.
+
+config BLK_SNAP_CHUNK_MAXIMUM_COUNT
+	depends on BLK_SNAP
+	int "The limit of the maximum number of snapshots chunks"
+	default 2097152
+	help
+	  As the size of the block device grows, the size of the chunk
+	  should also grow. For this purpose, the limit of the maximum number
+	  of chunks is set.
+
+config BLK_SNAP_CHUNK_MAXIMUM_IN_CACHE
+	depends on BLK_SNAP
+	int "The limit of the maximum chunks in memory cache"
+	default 64
+	help
+	  Since reading and writing to snapshots is performed in large chunks,
+	  a cache is implemented to optimize reading small portions of data
+	  from the snapshot image. As the number of chunks in the cache
+	  increases, memory consumption also increases.
+	  The minimum recommended value is four.
+
+config BLK_SNAP_FREE_DIFF_BUFFER_POOL_SIZE
+	depends on BLK_SNAP
+	int "The maximum size of the free buffers pool"
+	default 128
+	help
+	  A buffer can be allocated for each chunk. After use, this buffer is
+	  not released immediately, but is sent to the pool of free buffers.
+	  However, if there are too many free buffers in the pool, they are
+	  released immediately. The maximum size of the pool is regulated by
+	  this define.
+
+config BLK_SNAP_DIFF_STORAGE_MINIMUM
+	depends on BLK_SNAP
+	int "The minimum allowable size of the difference storage in sectors"
+	default 2097152
+	help
+	  When reached, an event is generated about the lack of free space.
+
+config BLK_SNAP_DEBUG_MEMORY_LEAK
+	depends on BLK_SNAP
+	bool "Enable memory leak detector"
+	default n
+	help
+	  Enables debugging code to monitor memory consumption by the module.
+
+	  If unsure, say N.
+
+config BLK_SNAP_ALLOW_DIFF_STORAGE_IN_MEMORY
+	depends on BLK_SNAP
+	bool "Allow difference storage in memory"
+	default n
+	help
+	  Enables the ability to create a repository of changes in memory.
+	  This feature can be useful for debugging. Or it can be used for
+	  mobile phones or other devices if there are guaranteed not to be
+	  a large number of writings during the snapshot hold.
+
+	  If unsure, say N.
-- 
2.20.1

