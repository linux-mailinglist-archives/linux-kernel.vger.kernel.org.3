Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A74B04CBF1D
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 14:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233843AbiCCNqN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 08:46:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231370AbiCCNqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 08:46:12 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198D018A7B6;
        Thu,  3 Mar 2022 05:45:27 -0800 (PST)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4K8XG60D7SzrRns;
        Thu,  3 Mar 2022 21:41:50 +0800 (CST)
Received: from dggpemm500017.china.huawei.com (7.185.36.178) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 21:45:25 +0800
Received: from huawei.com (10.175.101.6) by dggpemm500017.china.huawei.com
 (7.185.36.178) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 3 Mar
 2022 21:45:24 +0800
From:   Wenchao Hao <haowenchao@huawei.com>
To:     Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        <open-iscsi@googlegroups.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Wu Bo <wubo40@huawei.com>, Zhiqiang Liu <liuzhiqiang26@huawei.com>,
        <linfeilong@huawei.com>, Wenchao Hao <haowenchao@huawei.com>
Subject: [PATCH 2/2] iscsi_tcp: Check if tcp_conn is valid in
Date:   Thu, 3 Mar 2022 21:56:08 -0500
Message-ID: <20220304025608.1874516-2-haowenchao@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220304025608.1874516-1-haowenchao@huawei.com>
References: <20220304025608.1874516-1-haowenchao@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

iscsi_create_conn() would add newly alloced iscsi_cls_conn to connlist,
it means when userspace sends ISCSI_UEVENT_SET_PARAM, iscsi_conn_lookup()
would found this iscsi_cls_conn and call the set_param callback which is
iscsi_sw_tcp_conn_set_param(). While the iscsi_conn's dd_data might not
been initialized.

Signed-off-by: Wenchao Hao <haowenchao@huawei.com>
Signed-off-by: Wu Bo <wubo40@huawei.com>
---
 drivers/scsi/iscsi_tcp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/iscsi_tcp.c b/drivers/scsi/iscsi_tcp.c
index 14db224486be..a42449df6156 100644
--- a/drivers/scsi/iscsi_tcp.c
+++ b/drivers/scsi/iscsi_tcp.c
@@ -716,13 +716,17 @@ static int iscsi_sw_tcp_conn_set_param(struct iscsi_cls_conn *cls_conn,
 {
 	struct iscsi_conn *conn = cls_conn->dd_data;
 	struct iscsi_tcp_conn *tcp_conn = conn->dd_data;
-	struct iscsi_sw_tcp_conn *tcp_sw_conn = tcp_conn->dd_data;
+	struct iscsi_sw_tcp_conn *tcp_sw_conn;
 
 	switch(param) {
 	case ISCSI_PARAM_HDRDGST_EN:
 		iscsi_set_param(cls_conn, param, buf, buflen);
 		break;
 	case ISCSI_PARAM_DATADGST_EN:
+		if (!tcp_conn || !tcp_conn->dd_data)
+			return -ENOTCONN;
+
+		tcp_sw_conn = tcp_conn->dd_data;
 		iscsi_set_param(cls_conn, param, buf, buflen);
 		tcp_sw_conn->sendpage = conn->datadgst_en ?
 			sock_no_sendpage : tcp_sw_conn->sock->ops->sendpage;
-- 
2.32.0

