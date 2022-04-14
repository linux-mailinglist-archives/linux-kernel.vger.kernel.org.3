Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 470C04FF6F3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 14:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbiDMMla (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233208AbiDMMlS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:41:18 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F11550E35;
        Wed, 13 Apr 2022 05:38:56 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Kdhqc1xJgzBsKf;
        Wed, 13 Apr 2022 20:34:36 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 13 Apr 2022 20:38:54 +0800
Received: from huawei.com (10.175.101.6) by dggpemm500017.china.huawei.com
 (7.185.36.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 13 Apr
 2022 20:38:53 +0800
From:   Wenchao Hao <haowenchao@huawei.com>
To:     Mike Christie <michael.christie@oracle.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linfeilong@huawei.com>, Wenchao Hao <haowenchao@huawei.com>
Subject: [PATCH 2/2] iscsi: set session to FREE state after unbind session in remove session
Date:   Wed, 13 Apr 2022 21:49:47 -0400
Message-ID: <20220414014947.4168447-3-haowenchao@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220414014947.4168447-1-haowenchao@huawei.com>
References: <20220414014947.4168447-1-haowenchao@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500017.china.huawei.com (7.185.36.178)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_12_24,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__iscsi_unbind_session() set session state to ISCSI_SESSION_UNBOUND, which
would overwrite the ISCSI_SESSION_FREE state.

Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
---
 drivers/scsi/scsi_transport_iscsi.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/scsi_transport_iscsi.c b/drivers/scsi/scsi_transport_iscsi.c
index 97a9fee02efa..d8dd9279cea8 100644
--- a/drivers/scsi/scsi_transport_iscsi.c
+++ b/drivers/scsi/scsi_transport_iscsi.c
@@ -2173,6 +2173,22 @@ void iscsi_remove_session(struct iscsi_cls_session *session)
 	if (!cancel_work_sync(&session->block_work))
 		cancel_delayed_work_sync(&session->recovery_work);
 	cancel_work_sync(&session->unblock_work);
+
+	scsi_target_unblock(&session->dev, SDEV_TRANSPORT_OFFLINE);
+	/*
+	 * qla4xxx can perform it's own scans when it runs in kernel only
+	 * mode. Make sure to flush those scans.
+	 */
+	flush_work(&session->scan_work);
+
+	/*
+	 * flush running unbind operations
+	 * if unbind work did not queued, call __iscsi_unbind_session
+	 * directly to perform target remove
+	 */
+	if (!flush_work(&session->unbind_work))
+		__iscsi_unbind_session(&session->unbind_work);
+
 	/*
 	 * If we are blocked let commands flow again. The lld or iscsi
 	 * layer should set up the queuecommand to fail commands.
@@ -2183,16 +2199,6 @@ void iscsi_remove_session(struct iscsi_cls_session *session)
 	session->state = ISCSI_SESSION_FREE;
 	spin_unlock_irqrestore(&session->lock, flags);
 
-	scsi_target_unblock(&session->dev, SDEV_TRANSPORT_OFFLINE);
-	/*
-	 * qla4xxx can perform it's own scans when it runs in kernel only
-	 * mode. Make sure to flush those scans.
-	 */
-	flush_work(&session->scan_work);
-	/* flush running unbind operations */
-	flush_work(&session->unbind_work);
-	__iscsi_unbind_session(&session->unbind_work);
-
 	/* hw iscsi may not have removed all connections from session */
 	err = device_for_each_child(&session->dev, NULL,
 				    iscsi_iter_destroy_conn_fn);
-- 
2.32.0

