Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26E14E3B6C
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 10:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231469AbiCVJFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 05:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbiCVJEe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 05:04:34 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC641C01;
        Tue, 22 Mar 2022 02:03:05 -0700 (PDT)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KN5786v40z6892N;
        Tue, 22 Mar 2022 17:00:52 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 22 Mar 2022 10:03:03 +0100
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 22 Mar 2022 09:03:00 +0000
From:   John Garry <john.garry@huawei.com>
To:     <jejb@linux.ibm.com>, <martin.petersen@oracle.com>
CC:     <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <hch@lst.de>, <ming.lei@redhat.com>, <bvanassche@acm.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH] scsi: core: Refine how we set tag_set NUMA node
Date:   Tue, 22 Mar 2022 16:57:18 +0800
Message-ID: <1647939438-187933-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For SCSI hosts which enable host_tagset the NUMA node returned from
blk_mq_hw_queue_to_node() is NUMA_NO_NODE always. Then, since in
scsi_mq_setup_tags() the default we choose for the tag_set NUMA node is
NUMA_NO_NODE, we always evaluate the NUMA node as NUMA_NO_NODE in
functions like blk_mq_alloc_rq_map().

The reason we get NUMA_NO_NODE from blk_mq_hw_queue_to_node() is that
the hctx_idx passed is BLK_MQ_NO_HCTX_IDX - so we can't match against a
(HW) queue mapping index.

Improve this by defaulting the tag_set NUMA node to the same NUMA node
of the SCSI host DMA dev.

Signed-off-by: John Garry <john.garry@huawei.com>

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index f69b77cbf538..8352f90d997d 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -229,10 +229,6 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
 	if (error)
 		goto fail;
 
-	error = scsi_mq_setup_tags(shost);
-	if (error)
-		goto fail;
-
 	if (!shost->shost_gendev.parent)
 		shost->shost_gendev.parent = dev ? dev : &platform_bus;
 	if (!dma_dev)
@@ -240,6 +236,10 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
 
 	shost->dma_dev = dma_dev;
 
+	error = scsi_mq_setup_tags(shost);
+	if (error)
+		goto fail;
+
 	/*
 	 * Increase usage count temporarily here so that calling
 	 * scsi_autopm_put_host() will trigger runtime idle if there is
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 0a70aa763a96..7faa83b89fa4 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1982,7 +1982,11 @@ int scsi_mq_setup_tags(struct Scsi_Host *shost)
 	tag_set->nr_maps = shost->nr_maps ? : 1;
 	tag_set->queue_depth = shost->can_queue;
 	tag_set->cmd_size = cmd_size;
+	#ifdef CONFIG_NUMA
+	tag_set->numa_node = shost->dma_dev->numa_node;
+	#else
 	tag_set->numa_node = NUMA_NO_NODE;
+	#endif
 	tag_set->flags = BLK_MQ_F_SHOULD_MERGE;
 	tag_set->flags |=
 		BLK_ALLOC_POLICY_TO_MQ_FLAG(shost->hostt->tag_alloc_policy);
-- 
2.26.2

