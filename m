Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23CF9462100
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 20:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379409AbhK2TxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:53:08 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:48862 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348382AbhK2Tu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:50:58 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATJVDf3026597;
        Mon, 29 Nov 2021 19:47:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=ZwRoUTCdhHp+eUdKNxuRYpvCkMuqJs+ple1/71xBtLY=;
 b=R4VMuKdhsbPfvmD/qatoLntO6Dlk4PxGRFyCQOxwMDTN940lI9nrTCP85gs3+xEFZrTU
 apk/i4KQo4y4JQuZ6le2IFJVNe+YgazW4wj0hlBw5hM/kaDVgxGy3Ci4O0C0md8xJTxN
 WblI9H0lNfGJ3aqYKDEsPiQRA3VwpyKdpdE0uBE2bfifLyMc3t3N68hNJN8SpDOgHt7O
 PRKNPc7FxQ3JKMLllK4lPBhr6xIV+a7iwSdBdxwjqJUY6hbl1Cx7IAmFh65L2tOpLkke
 fM7jZXANrdbC4WUnm+zUvqftQIbQXwpiBu+yJfb/v/n7CY5pMH3rTW54ZKINvOJQeO3n Mg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmt8c3wjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 19:47:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ATJjb8i181733;
        Mon, 29 Nov 2021 19:47:26 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by aserp3030.oracle.com with ESMTP id 3ckaqdcbmb-10
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 19:47:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IeO/F5Uw2YhYG47iVKxdz2vpABUDYviKBJSRnkelUkgCAszfPFcHi7RwrMFk7zP5TG9nELpjV41MsWvJjAVKKBm5IwfQd16u/AndmeOqKJfrrehTfuHZk9+7dSeP7uhWRcz4zc6qz39tGmIFGvjrGafZF5Fa4kPjva+GCM+RLlN9P/vgcjr3/BIAFNF1CvYk+VJh/rGxfvT4M9SdM3wt3FdhRSSUzBEYb1MIccnGBtUnKuLhIo+dgpQewyWR1IrkyhF+OzAmOGBuW/Dpj1gDvSAujLYQH60LaXDgDPK9lUICtMMHLCbzuIwI7+9dpaLlFCDi0SU71ANAWXWXTjo2Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwRoUTCdhHp+eUdKNxuRYpvCkMuqJs+ple1/71xBtLY=;
 b=nXhRiemcAXEyg6qyZ+V0E3Vg7KruvHmOzgCFi1GcNb0eNRHDhBoQkESPI2T9VYj4aiLkJZJwocipv7QNfSvDxQFMAatG79zhAdUp6ILUk/VNDl1cTc+anANr4jM53YvDl6EKvehYwquSfVWbz+H7LCCVD9J8ZrZk2B1zwL3+Ny95z7OpHxTNE6lh0GFesiDWZPCQ8EwywK5uQh+OU9txEI88KzvuLpM1Ofa4hQKExy0m/HxN+7toYv42X6+vv50r/vC9eNsvq3e/p2YN4YqWA9HDpysXIA6SPLSplAweBtl1CUkr4636VL1GaWzcsuRQiEMEFfyFWfs9s+ix7/4oug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwRoUTCdhHp+eUdKNxuRYpvCkMuqJs+ple1/71xBtLY=;
 b=ZWC1noqxi1BeDoPOZEFcct6fvWtGgbccpw2AhJvSoVlQWE6ZJq1Ys9U1k6K/LkQ8WS2z5VJn2JMrrCtDaBieDaHjpybXXJpUU8yi0BvLs66rcBnj48IuqLkFDcSVuZMpmRS9lRX/4AiyyIlucl6R6ZYs0HL4WEO+rcKjkoed0sk=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM5PR10MB1307.namprd10.prod.outlook.com (2603:10b6:3:e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.21; Mon, 29 Nov 2021 19:47:24 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4734.024; Mon, 29 Nov
 2021 19:47:24 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V6 09/10] vhost: move worker thread fields to new struct
Date:   Mon, 29 Nov 2021 13:47:06 -0600
Message-Id: <20211129194707.5863-10-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211129194707.5863-1-michael.christie@oracle.com>
References: <20211129194707.5863-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:610:cc::31) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by CH0PR03CA0086.namprd03.prod.outlook.com (2603:10b6:610:cc::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 19:47:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d567de65-9ff2-40f4-63c6-08d9b37110ec
X-MS-TrafficTypeDiagnostic: DM5PR10MB1307:
X-Microsoft-Antispam-PRVS: <DM5PR10MB1307E8FFB25B068487C53D60F1669@DM5PR10MB1307.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yrVY+eAYJZOEnjEdJQefCFMvJxbtbzFkFEbL3o1zu10duftqeXNY1yKuiqqAbENMKQPA37nMRXgtUtj3au3mCmmN/PWCaV14MukZQl5ykU3El9AB5br/K/coWCfZR2onohd+22dHiR0R8zVGHhxdFVG51OWMZvEdnyTN3cfYeJLoSR4t0FbnRdi2HhpKkQz6uV+LA7tQFTtu8sZSXgRlk8SQkvZ2LiadJyZUJMQHnSIinjCbL2l715bzMDbezb+k/SQgeSWBMtGD7AS29i18nLh8bT1FIy9CJk5b9OPo/TIunWkdf0vRyg01ir2aA3rOPqHCYbIwQPm703mPlWxGIRAiOV//GHLjRUkcFClS6aVVcu8VEpZPCkGMXNZiEkXpoIWBJdYZatCnnXg42tiuidILTsEuQw/0u2sCg17ZBQzi/Cd3qeFWatSeyJY6zcb1vV/vBcVUKhWfBrc1KuG92HmDYsgL5wkbOx+McYIwwRarETeIHh6lyC4+FIdsckQg7auRf8SvA6a97IeB3sVtxuB5xtR5t8z+mVMkeqVqmCkcFdgwuvnhDKnzIZNLbvE//OZE0x6dAYal/QRzeJY5tMEZRK3bwijzlD21QLjYZmj0MEXmiHspM3srCkeQCqv90Fo2ZEOaN4UDWtBg9/dbEAdAgiUqDgK+TPHg1pFnGYq7yNno7rR1Kdl19rkA2xf5vUlkgOrOwCZ9l6TqyJhdAjO8rvGq0RdIBAxL60g64rA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(36756003)(8936002)(8676002)(38350700002)(86362001)(6512007)(2906002)(54906003)(956004)(52116002)(1076003)(26005)(66556008)(66476007)(186003)(508600001)(5660300002)(921005)(6666004)(2616005)(6486002)(66946007)(38100700002)(316002)(83380400001)(4326008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sOrbyHWpIxruh1JbzJf83l7c3ONiNYlL2a1uuZq7FiqozBFsjNj9hObyekn7?=
 =?us-ascii?Q?8SE0htrkwNwT57vxlmfLmaVrE3MLNXLIKyIOX3ByPUUUlKsKdicrWKq1s6ej?=
 =?us-ascii?Q?2GUCzKXfmW7wSgw97Inw5Tlc48jXYQAP1Q9yjje8HLiIpQVveXymZwVLWfr1?=
 =?us-ascii?Q?/91hnkZd2+zTSz95Gjmw4D+6piyPjQC7uRqD+RBlsRQChHhyMApcJgb6avjw?=
 =?us-ascii?Q?NMWGiWaHXr8+1GtCm44VVM6bO0I90bQ2US/oRvedmUKS9lO25UCz9tTdar8Y?=
 =?us-ascii?Q?TK+8JeP5abIZM2RMy9JtNrR+r14i3MRHdSlv3VYZmxZIVs0xfz5nvugqtJlW?=
 =?us-ascii?Q?hm9kbigFEcVqwI45EatefZGoQicofiLCe4wFJ1wOpxJoa0DG3nY9X7JZg1W8?=
 =?us-ascii?Q?XhIYXgQ4d8pf4mBIz4+QEE+7osRnT8aL2poFIBh61LI4YBTbo9YgW84Bxuqi?=
 =?us-ascii?Q?qb7V7cjOBD5mwd4OPRD/9485QhWNPZ5znweMM76RaURLkQAbEYNPCBxCf+wT?=
 =?us-ascii?Q?DL1V6qlvPmt8i7giQdFGq9ph3exJEYRAWkeig68WvZ+hs0cpxiLRwmya7j2Z?=
 =?us-ascii?Q?FgMjLFKpq+4tD/KG/f7p6ZEQDKz592a45MuNlRwX+TssZ3USlLfUDhtoPBse?=
 =?us-ascii?Q?+KP4R7K3TVUry1S/ri9ylJ+Exl9ApYEU/m3MX+yT7qpTu+OJ9gVrQqcU4a+J?=
 =?us-ascii?Q?H/niC+LyjZAuID+jOxsOSBzSmB9ooH3B73nSqorpLyRQ1YBgUvyVyQ4xp7D9?=
 =?us-ascii?Q?eg/e+OebY2YnLWvJPo1XAUfYEZ/Rkjj0g0Aw1mYnGu1uU9KwN0szAuOz+wTU?=
 =?us-ascii?Q?aXVNqpB4562JeG36Vb6AyW6dWiyUfOlv/phrhkuPRrhIIeVXusYZyN02A4lt?=
 =?us-ascii?Q?3LU2I/5ZfToQn4ihUmSlOlbIa4DTXNN5xJ86Ny9YQW1zODkNiGevzPU54iuB?=
 =?us-ascii?Q?rBxMDvvF/IRkPzoh9a3lJYD+2pC0woRXcMegIQlWc5ACKVoV3RKH6KxcIHL4?=
 =?us-ascii?Q?gpgMmVJtm9RzBz8R4+qC3zyDZvlJEyS3WkrByef+F3tDK0LsXdOEaQDByLFJ?=
 =?us-ascii?Q?yKdObzrrxfmSNQbKQ9sy9aUlgIVUMqkWDmOHzAoeVrxxsfFfZRYRB7hdzr8c?=
 =?us-ascii?Q?fAeAPRioQtz1NMqQkCLKHRl6UDbgYCFz6t8TU74PCpF6yDoQif862G/Gswge?=
 =?us-ascii?Q?k4AqNH2l3aMenV7PjL51NAa+vEbcmWUSC9vvoHY/bESs5SAJ4SZVqu2Ec/N4?=
 =?us-ascii?Q?QgrM4818bBLkblLHjqiXw/SIeMLwQZyIzm76dWCmRdpTANNzu2Bm+mTGCegT?=
 =?us-ascii?Q?rpsAv8QvglXoopK/JyTJnrah9CHz01O3jRY2yTa7cYOIVTGjVjXEFd6DMdH4?=
 =?us-ascii?Q?UzArliYuiZzuDxgYILVCugRnzQkWnupORqx7rSyUYNLaYQUE5Ojuo1h+TjhE?=
 =?us-ascii?Q?kr5LFFMImzWf/Lvs/haU9z7duMVxoubR/yiar9CvFmf/NMgO+ARS7jqvdogh?=
 =?us-ascii?Q?gTUlBR5QxdWIwad/ZuL8MD371vbNQ3p4oQb+lx7rZDVTuo7de+2uJHLihmYh?=
 =?us-ascii?Q?PhiRSmecutdbZMKWCON9pNbR9r85/MIAssdHxciMSw5Hw4LMBxcRc0hhzW2Q?=
 =?us-ascii?Q?ng0sHF4TT1lIakQP5P17WGHX4snbrRjmzfXA80f9xJTkCeGLIS+U273u2JZE?=
 =?us-ascii?Q?EcEr4g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d567de65-9ff2-40f4-63c6-08d9b37110ec
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 19:47:24.8478
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eN/tWFj6AOIdy1TEAD5uVNbp+/HPqV1uCu6G6HHg5SrQe910xrDEjC0l4xeeqUSdXrjIb8sW9ZmkD8MPyd+w97AU2+QSwTWbO8+jFOFKyp4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1307
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111290092
X-Proofpoint-ORIG-GUID: lGIee-3MfNxJ4nfXampXt-QXBNiX-oPm
X-Proofpoint-GUID: lGIee-3MfNxJ4nfXampXt-QXBNiX-oPm
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is just a prep patch. It moves the worker related fields to a new
vhost_worker struct and moves the code around to create some helpers that
will be used in the next patch.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/vhost/vhost.c | 98 ++++++++++++++++++++++++++++---------------
 drivers/vhost/vhost.h | 11 +++--
 2 files changed, 72 insertions(+), 37 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 59edb5a1ffe2..c9a1f706989c 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -263,8 +263,8 @@ void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
 		 * sure it was not in the list.
 		 * test_and_set_bit() implies a memory barrier.
 		 */
-		llist_add(&work->node, &dev->work_list);
-		wake_up_process(dev->worker);
+		llist_add(&work->node, &dev->worker->work_list);
+		wake_up_process(dev->worker->task);
 	}
 }
 EXPORT_SYMBOL_GPL(vhost_work_queue);
@@ -272,7 +272,7 @@ EXPORT_SYMBOL_GPL(vhost_work_queue);
 /* A lockless hint for busy polling code to exit the loop */
 bool vhost_has_work(struct vhost_dev *dev)
 {
-	return !llist_empty(&dev->work_list);
+	return dev->worker && !llist_empty(&dev->worker->work_list);
 }
 EXPORT_SYMBOL_GPL(vhost_has_work);
 
@@ -343,7 +343,8 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 
 static int vhost_worker(void *data)
 {
-	struct vhost_dev *dev = data;
+	struct vhost_worker *worker = data;
+	struct vhost_dev *dev = worker->dev;
 	struct vhost_work *work, *work_next;
 	struct llist_node *node;
 
@@ -358,7 +359,7 @@ static int vhost_worker(void *data)
 			break;
 		}
 
-		node = llist_del_all(&dev->work_list);
+		node = llist_del_all(&worker->work_list);
 		if (!node)
 			schedule();
 
@@ -368,7 +369,7 @@ static int vhost_worker(void *data)
 		llist_for_each_entry_safe(work, work_next, node, node) {
 			clear_bit(VHOST_WORK_QUEUED, &work->flags);
 			__set_current_state(TASK_RUNNING);
-			kcov_remote_start_common(dev->kcov_handle);
+			kcov_remote_start_common(worker->kcov_handle);
 			work->fn(work);
 			kcov_remote_stop();
 			if (need_resched())
@@ -487,7 +488,6 @@ void vhost_dev_init(struct vhost_dev *dev,
 	dev->byte_weight = byte_weight;
 	dev->use_worker = use_worker;
 	dev->msg_handler = msg_handler;
-	init_llist_head(&dev->work_list);
 	init_waitqueue_head(&dev->wait);
 	INIT_LIST_HEAD(&dev->read_list);
 	INIT_LIST_HEAD(&dev->pending_list);
@@ -579,10 +579,60 @@ static void vhost_detach_mm(struct vhost_dev *dev)
 	dev->mm = NULL;
 }
 
+static void vhost_worker_free(struct vhost_dev *dev)
+{
+	struct vhost_worker *worker = dev->worker;
+
+	if (!worker)
+		return;
+
+	dev->worker = NULL;
+	WARN_ON(!llist_empty(&worker->work_list));
+	kthread_stop(worker->task);
+	kfree(worker);
+}
+
+static int vhost_worker_create(struct vhost_dev *dev)
+{
+	struct vhost_worker *worker;
+	struct task_struct *task;
+	int ret;
+
+	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
+	if (!worker)
+		return -ENOMEM;
+
+	dev->worker = worker;
+	worker->dev = dev;
+	worker->kcov_handle = kcov_common_handle();
+	init_llist_head(&worker->work_list);
+
+	task = kthread_create(vhost_worker, worker, "vhost-%d", current->pid);
+	if (IS_ERR(task)) {
+		ret = PTR_ERR(task);
+		goto free_worker;
+	}
+
+	worker->task = task;
+	wake_up_process(task); /* avoid contributing to loadavg */
+
+	ret = vhost_attach_cgroups(dev);
+	if (ret)
+		goto stop_worker;
+
+	return 0;
+
+stop_worker:
+	kthread_stop(worker->task);
+free_worker:
+	kfree(worker);
+	dev->worker = NULL;
+	return ret;
+}
+
 /* Caller should have device mutex */
 long vhost_dev_set_owner(struct vhost_dev *dev)
 {
-	struct task_struct *worker;
 	int err;
 
 	/* Is there an owner already? */
@@ -593,36 +643,21 @@ long vhost_dev_set_owner(struct vhost_dev *dev)
 
 	vhost_attach_mm(dev);
 
-	dev->kcov_handle = kcov_common_handle();
 	if (dev->use_worker) {
-		worker = kthread_create(vhost_worker, dev,
-					"vhost-%d", current->pid);
-		if (IS_ERR(worker)) {
-			err = PTR_ERR(worker);
-			goto err_worker;
-		}
-
-		dev->worker = worker;
-		wake_up_process(worker); /* avoid contributing to loadavg */
-
-		err = vhost_attach_cgroups(dev);
+		err = vhost_worker_create(dev);
 		if (err)
-			goto err_cgroup;
+			goto err_worker;
 	}
 
 	err = vhost_dev_alloc_iovecs(dev);
 	if (err)
-		goto err_cgroup;
+		goto err_iovecs;
 
 	return 0;
-err_cgroup:
-	if (dev->worker) {
-		kthread_stop(dev->worker);
-		dev->worker = NULL;
-	}
+err_iovecs:
+	vhost_worker_free(dev);
 err_worker:
 	vhost_detach_mm(dev);
-	dev->kcov_handle = 0;
 err_mm:
 	return err;
 }
@@ -712,12 +747,7 @@ void vhost_dev_cleanup(struct vhost_dev *dev)
 	dev->iotlb = NULL;
 	vhost_clear_msg(dev);
 	wake_up_interruptible_poll(&dev->wait, EPOLLIN | EPOLLRDNORM);
-	WARN_ON(!llist_empty(&dev->work_list));
-	if (dev->worker) {
-		kthread_stop(dev->worker);
-		dev->worker = NULL;
-		dev->kcov_handle = 0;
-	}
+	vhost_worker_free(dev);
 	vhost_detach_mm(dev);
 }
 EXPORT_SYMBOL_GPL(vhost_dev_cleanup);
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 638bb640d6b4..102ce25e4e13 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -25,6 +25,13 @@ struct vhost_work {
 	unsigned long		flags;
 };
 
+struct vhost_worker {
+	struct task_struct	*task;
+	struct llist_head	work_list;
+	struct vhost_dev	*dev;
+	u64			kcov_handle;
+};
+
 /* Poll a file (eventfd or socket) */
 /* Note: there's nothing vhost specific about this structure. */
 struct vhost_poll {
@@ -148,8 +155,7 @@ struct vhost_dev {
 	struct vhost_virtqueue **vqs;
 	int nvqs;
 	struct eventfd_ctx *log_ctx;
-	struct llist_head work_list;
-	struct task_struct *worker;
+	struct vhost_worker *worker;
 	struct vhost_iotlb *umem;
 	struct vhost_iotlb *iotlb;
 	spinlock_t iotlb_lock;
@@ -159,7 +165,6 @@ struct vhost_dev {
 	int iov_limit;
 	int weight;
 	int byte_weight;
-	u64 kcov_handle;
 	bool use_worker;
 	int (*msg_handler)(struct vhost_dev *dev,
 			   struct vhost_iotlb_msg *msg);
-- 
2.25.1

