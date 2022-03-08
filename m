Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1464E4CFD4C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:46:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238749AbiCGLrN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:47:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237595AbiCGLrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:47:10 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000F16620C;
        Mon,  7 Mar 2022 03:46:15 -0800 (PST)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KBxSh5Dh1zBrWR;
        Mon,  7 Mar 2022 19:44:20 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 7 Mar 2022 19:46:14 +0800
Received: from huawei.com (10.175.101.6) by dggpemm500017.china.huawei.com
 (7.185.36.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Mon, 7 Mar
 2022 19:46:13 +0800
From:   Wenchao Hao <haowenchao@huawei.com>
To:     Mike Christie <michael.christie@oracle.com>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Wu Bo <wubo40@huawei.com>, Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        Wenchao Hao <haowenchao@huawei.com>
Subject: [PATCH 2/2] scsi:libiscsi: Add iscsi_cls_conn to sysfs after been initialized
Date:   Mon, 7 Mar 2022 19:56:54 -0500
Message-ID: <20220308005654.2281343-3-haowenchao@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220308005654.2281343-1-haowenchao@huawei.com>
References: <20220308005654.2281343-1-haowenchao@huawei.com>
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

iscsi_create_conn() would expose iscsi_cls_conn to sysfs, while the
initialization of iscsi_conn's dd_data is not ready now. When userspace
try to access an attribute such as connect's address, it might cause
a NULL pointer dereference.

So we should add iscsi_cls_conn to sysfs until it has been initialized.

Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 drivers/scsi/libiscsi.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/libiscsi.c b/drivers/scsi/libiscsi.c
index 059dae8909ee..1cf25f4acb71 100644
--- a/drivers/scsi/libiscsi.c
+++ b/drivers/scsi/libiscsi.c
@@ -3040,8 +3040,9 @@ iscsi_conn_setup(struct iscsi_cls_session *cls_session, int dd_size,
 	struct iscsi_conn *conn;
 	struct iscsi_cls_conn *cls_conn;
 	char *data;
+	int err;
 
-	cls_conn = iscsi_create_conn(cls_session, sizeof(*conn) + dd_size,
+	cls_conn = iscsi_alloc_conn(cls_session, sizeof(*conn) + dd_size,
 				     conn_idx);
 	if (!cls_conn)
 		return NULL;
@@ -3078,13 +3079,21 @@ iscsi_conn_setup(struct iscsi_cls_session *cls_session, int dd_size,
 		goto login_task_data_alloc_fail;
 	conn->login_task->data = conn->data = data;
 
+	err = iscsi_add_conn(cls_conn);
+	if (err)
+		goto login_task_add_dev_fail;
+
 	return cls_conn;
 
+login_task_add_dev_fail:
+	free_pages((unsigned long) conn->data,
+		   get_order(ISCSI_DEF_MAX_RECV_SEG_LEN));
+
 login_task_data_alloc_fail:
 	kfifo_in(&session->cmdpool.queue, (void*)&conn->login_task,
 		    sizeof(void*));
 login_task_alloc_fail:
-	iscsi_destroy_conn(cls_conn);
+	kfree(cls_conn);
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(iscsi_conn_setup);
-- 
2.32.0

