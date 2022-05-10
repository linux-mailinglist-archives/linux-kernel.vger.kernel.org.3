Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1CA2521CC1
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345017AbiEJOt3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242929AbiEJOtC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:49:02 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 856996C57D;
        Tue, 10 May 2022 07:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652191630; x=1683727630;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=BlQ0Cp+elT3/iPSUa4fUVbxemKM5LtOghkESJ25jI34=;
  b=hP3/qeBD5ypLPqxosoMyicHVwTwKt61dln+cLzHOIEJgtevKStTZ4Dqm
   HTaBd7N5ZrSfOmZlj5xvodrAcD9LDU9w2zfYLXgZF9GIzEZgFrX4VhAZl
   sD7uWXC1a2GC6kk6taingeGWMTWkkEVaGJkcWZL/r0QE+cd/cqyo+a88o
   4=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 10 May 2022 07:07:10 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2022 07:07:09 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 10 May 2022 07:06:46 -0700
Received: from hu-charante-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 10 May 2022 07:06:41 -0700
From:   Charan Teja Kalla <quic_charante@quicinc.com>
To:     <gregkh@linuxfoundation.org>, <christian.koenig@amd.com>,
        <sumit.semwal@linaro.org>, <hridya@google.com>,
        <daniel.vetter@ffwll.ch>, <tjmercier@google.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-media@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        <linaro-mm-sig@lists.linaro.org>,
        "Charan Teja Kalla" <quic_charante@quicinc.com>
Subject: [PATCH V2] dmabuf: ensure unique directory name for dmabuf stats
Date:   Tue, 10 May 2022 19:36:02 +0530
Message-ID: <1652191562-18700-1-git-send-email-quic_charante@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dmabuf file uses get_next_ino()(through dma_buf_getfile() ->
alloc_anon_inode()) to get an inode number and uses the same as a
directory name under /sys/kernel/dmabuf/buffers/<ino>. This directory is
used to collect the dmabuf stats and it is created through
dma_buf_stats_setup(). At current, failure to create this directory
entry can make the dma_buf_export() to fail.

Now, as the get_next_ino() can definitely give a repetitive inode no
causing the directory entry creation to fail with -EEXIST. This is a
problem on the systems where dmabuf stats functionality is enabled on
the production builds can make the dma_buf_export(), though the dmabuf
memory is allocated successfully, to fail just because it couldn't
create stats entry.

This issue we are able to see on the snapdragon system within 13 days
where there already exists a directory with inode no "122602" so
dma_buf_stats_setup() failed with -EEXIST as it is trying to create
the same directory entry.

To make the directory entry as unique, append the unique_id for every
inode. With this change the stats directory entries will be in the
format of: /sys/kernel/dmabuf/buffers/<inode_number-unique_id>.

Signed-off-by: Charan Teja Kalla <quic_charante@quicinc.com>
---
Changes in V2:
  -- Used the atomic64_t variable to generate a unique_id to be appended to inode
     to have an unique directory with name <inode_number-unique_id> -- Suggested by christian
  -- Updated the ABI documentation -- Identified by Greg.
  -- Massaged the commit log.

Changes in V1:
  -- Used the inode->i_ctime->tv_secs as an id appended to inode to create the
     unique directory with name <inode_number-time_in_secs>.
  -- https://lore.kernel.org/all/1652178212-22383-1-git-send-email-quic_charante@quicinc.com/

 Documentation/ABI/testing/sysfs-kernel-dmabuf-buffers | 10 +++++-----
 drivers/dma-buf/Kconfig                               |  6 +++---
 drivers/dma-buf/dma-buf-sysfs-stats.c                 |  8 +++++---
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-dmabuf-buffers b/Documentation/ABI/testing/sysfs-kernel-dmabuf-buffers
index 5d3bc99..9fffbd3 100644
--- a/Documentation/ABI/testing/sysfs-kernel-dmabuf-buffers
+++ b/Documentation/ABI/testing/sysfs-kernel-dmabuf-buffers
@@ -4,19 +4,19 @@ KernelVersion:	v5.13
 Contact:	Hridya Valsaraju <hridya@google.com>
 Description:	The /sys/kernel/dmabuf/buffers directory contains a
 		snapshot of the internal state of every DMA-BUF.
-		/sys/kernel/dmabuf/buffers/<inode_number> will contain the
-		statistics for the DMA-BUF with the unique inode number
-		<inode_number>
+		/sys/kernel/dmabuf/buffers/<inode_number-unique_id> will
+		contain the statistics for the DMA-BUF with the unique
+		pair <inode_number-unique_id>
 Users:		kernel memory tuning/debugging tools
 
-What:		/sys/kernel/dmabuf/buffers/<inode_number>/exporter_name
+What:		/sys/kernel/dmabuf/buffers/<inode_number-unique_id>/exporter_name
 Date:		May 2021
 KernelVersion:	v5.13
 Contact:	Hridya Valsaraju <hridya@google.com>
 Description:	This file is read-only and contains the name of the exporter of
 		the DMA-BUF.
 
-What:		/sys/kernel/dmabuf/buffers/<inode_number>/size
+What:		/sys/kernel/dmabuf/buffers/<inode_number-unique_id>/size
 Date:		May 2021
 KernelVersion:	v5.13
 Contact:	Hridya Valsaraju <hridya@google.com>
diff --git a/drivers/dma-buf/Kconfig b/drivers/dma-buf/Kconfig
index 541efe0..5bcbdb1 100644
--- a/drivers/dma-buf/Kconfig
+++ b/drivers/dma-buf/Kconfig
@@ -81,9 +81,9 @@ menuconfig DMABUF_SYSFS_STATS
 	   Choose this option to enable DMA-BUF sysfs statistics
 	   in location /sys/kernel/dmabuf/buffers.
 
-	   /sys/kernel/dmabuf/buffers/<inode_number> will contain
-	   statistics for the DMA-BUF with the unique inode number
-	   <inode_number>.
+	   /sys/kernel/dmabuf/buffers/<inode_number-unique_id> will contain
+	   statistics for the DMA-BUF with the unique pair
+	   <inode_number-unique_id>.
 
 source "drivers/dma-buf/heaps/Kconfig"
 
diff --git a/drivers/dma-buf/dma-buf-sysfs-stats.c b/drivers/dma-buf/dma-buf-sysfs-stats.c
index 2bba0ba..29e9e23 100644
--- a/drivers/dma-buf/dma-buf-sysfs-stats.c
+++ b/drivers/dma-buf/dma-buf-sysfs-stats.c
@@ -38,8 +38,8 @@
  *
  * The following stats are exposed by the interface:
  *
- * * ``/sys/kernel/dmabuf/buffers/<inode_number>/exporter_name``
- * * ``/sys/kernel/dmabuf/buffers/<inode_number>/size``
+ * * ``/sys/kernel/dmabuf/buffers/<inode_number-unique_id>/exporter_name``
+ * * ``/sys/kernel/dmabuf/buffers/<inode_number-unique_id>/size``
  *
  * The information in the interface can also be used to derive per-exporter
  * statistics. The data from the interface can be gathered on error conditions
@@ -172,6 +172,7 @@ int dma_buf_stats_setup(struct dma_buf *dmabuf)
 {
 	struct dma_buf_sysfs_entry *sysfs_entry;
 	int ret;
+	static atomic64_t unique_id = ATOMIC_INIT(0);
 
 	if (!dmabuf || !dmabuf->file)
 		return -EINVAL;
@@ -192,7 +193,8 @@ int dma_buf_stats_setup(struct dma_buf *dmabuf)
 
 	/* create the directory for buffer stats */
 	ret = kobject_init_and_add(&sysfs_entry->kobj, &dma_buf_ktype, NULL,
-				   "%lu", file_inode(dmabuf->file)->i_ino);
+				   "%lu-%lu", file_inode(dmabuf->file)->i_ino,
+				   atomic64_add_return(1, &unique_id));
 	if (ret)
 		goto err_sysfs_dmabuf;
 
-- 
2.7.4

