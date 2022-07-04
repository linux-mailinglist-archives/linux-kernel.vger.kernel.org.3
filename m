Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34801565E10
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 21:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233120AbiGDTff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 15:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbiGDTfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 15:35:33 -0400
Received: from smtp.smtpout.orange.fr (smtp08.smtpout.orange.fr [80.12.242.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA1CB1FE
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 12:35:32 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 8RqzoUFingNxB8RqzoyK6y; Mon, 04 Jul 2022 21:35:30 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Mon, 04 Jul 2022 21:35:30 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Nilesh Javali <njavali@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-scsi@vger.kernel.org
Subject: [PATCH] scsi: qla2xxx: Use the bitmap API to allocate bitmaps
Date:   Mon,  4 Jul 2022 21:35:28 +0200
Message-Id: <8188ce4a66713d7b709bc84621d31fa1cc8d087e.1656963310.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.

It is less verbose and it improves the semantic.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/scsi/qla2xxx/qla_edif.c | 12 +++++-------
 drivers/scsi/qla2xxx/qla_os.c   |  8 +++-----
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/scsi/qla2xxx/qla_edif.c b/drivers/scsi/qla2xxx/qla_edif.c
index 400a8b6f3982..5a7b23a5479e 100644
--- a/drivers/scsi/qla2xxx/qla_edif.c
+++ b/drivers/scsi/qla2xxx/qla_edif.c
@@ -3349,8 +3349,7 @@ void qla_edif_sadb_release(struct qla_hw_data *ha)
 /* build the rx and tx sa_index free pools -- only done at fcport init */
 int qla_edif_sadb_build_free_pool(struct qla_hw_data *ha)
 {
-	ha->edif_tx_sa_id_map =
-	    kcalloc(BITS_TO_LONGS(EDIF_NUM_SA_INDEX), sizeof(long), GFP_KERNEL);
+	ha->edif_tx_sa_id_map = bitmap_zalloc(EDIF_NUM_SA_INDEX, GFP_KERNEL);
 
 	if (!ha->edif_tx_sa_id_map) {
 		ql_log_pci(ql_log_fatal, ha->pdev, 0x0009,
@@ -3358,10 +3357,9 @@ int qla_edif_sadb_build_free_pool(struct qla_hw_data *ha)
 		return -ENOMEM;
 	}
 
-	ha->edif_rx_sa_id_map =
-	    kcalloc(BITS_TO_LONGS(EDIF_NUM_SA_INDEX), sizeof(long), GFP_KERNEL);
+	ha->edif_rx_sa_id_map = bitmap_zalloc(EDIF_NUM_SA_INDEX, GFP_KERNEL);
 	if (!ha->edif_rx_sa_id_map) {
-		kfree(ha->edif_tx_sa_id_map);
+		bitmap_free(ha->edif_tx_sa_id_map);
 		ha->edif_tx_sa_id_map = NULL;
 		ql_log_pci(ql_log_fatal, ha->pdev, 0x0009,
 		    "Unable to allocate memory for sadb rx.\n");
@@ -3373,9 +3371,9 @@ int qla_edif_sadb_build_free_pool(struct qla_hw_data *ha)
 /* release the free pool - only done during fcport teardown */
 void qla_edif_sadb_release_free_pool(struct qla_hw_data *ha)
 {
-	kfree(ha->edif_tx_sa_id_map);
+	bitmap_free(ha->edif_tx_sa_id_map);
 	ha->edif_tx_sa_id_map = NULL;
-	kfree(ha->edif_rx_sa_id_map);
+	bitmap_free(ha->edif_rx_sa_id_map);
 	ha->edif_rx_sa_id_map = NULL;
 }
 
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 1c7fb6484db2..d5f292612cda 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -4356,9 +4356,7 @@ qla2x00_mem_alloc(struct qla_hw_data *ha, uint16_t req_len, uint16_t rsp_len,
 	INIT_LIST_HEAD(&ha->vp_list);
 
 	/* Allocate memory for our loop_id bitmap */
-	ha->loop_id_map = kcalloc(BITS_TO_LONGS(LOOPID_MAP_SIZE),
-				  sizeof(long),
-				  GFP_KERNEL);
+	ha->loop_id_map = bitmap_zalloc(LOOPID_MAP_SIZE, GFP_KERNEL);
 	if (!ha->loop_id_map)
 		goto fail_loop_id_map;
 	else {
@@ -4418,7 +4416,7 @@ qla2x00_mem_alloc(struct qla_hw_data *ha, uint16_t req_len, uint16_t rsp_len,
 	dma_free_coherent(&ha->pdev->dev, SFP_DEV_SIZE,
 	    ha->sfp_data, ha->sfp_data_dma);
 fail_sfp_data:
-	kfree(ha->loop_id_map);
+	bitmap_free(ha->loop_id_map);
 fail_loop_id_map:
 	dma_pool_free(ha->s_dma_pool, ha->async_pd, ha->async_pd_dma);
 fail_async_pd:
@@ -4948,7 +4946,7 @@ qla2x00_mem_free(struct qla_hw_data *ha)
 	ha->npiv_info = NULL;
 	kfree(ha->swl);
 	ha->swl = NULL;
-	kfree(ha->loop_id_map);
+	bitmap_free(ha->loop_id_map);
 	ha->sf_init_cb = NULL;
 	ha->sf_init_cb_dma = 0;
 	ha->loop_id_map = NULL;
-- 
2.34.1

