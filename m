Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7AB94A79FC
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 22:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347354AbiBBVEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 16:04:43 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:39718 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231758AbiBBVEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:04:42 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212KwocE024834;
        Wed, 2 Feb 2022 21:02:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=ZwRoUTCdhHp+eUdKNxuRYpvCkMuqJs+ple1/71xBtLY=;
 b=rPDJvTxePdB6W8J9KLn4TwxhvO8tdCE6u2GMXWXkGiUDFw3ByGVh4AfYiiT5GpYRq2zc
 nV515gQhyHZZsc9qyhYGVQJGqFMyIIjQyDV0bETqJrmnInkDVA3kS6HtVczq+rzVX8CU
 KtAXQmuUGTmse+FU0XEZTTUCUEWcc5pmx6pShrqDaSGb00yyp7JanCqLcCqmeXAve8fo
 UQMfGInXJOn8MxMq3fzccwqSktdEiO8xN0uryCxP1xmCCuUYqvMJiPh9P0T1SZZHHFnY
 FxtVTqlryCrwDm0uq0Cbx5A9i434EowxU8eQH7JNP/V9fqy5elo/kS6VVJiLxNUG09Qz PA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjatyf0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 21:02:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 212L1Ejt021471;
        Wed, 2 Feb 2022 21:02:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by aserp3020.oracle.com with ESMTP id 3dvwd8xt3n-6
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 21:02:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FTtgvHsMFuiZxh7tfevHOD5YxfWBdb1KCCsV1vjtpSazUuHzfJVvKDCSph5LySkzDMfie0Oak18Zj2sR87/b8vLMnsMsD070FFkTcv+EGgpEnYpO9mb3UomRCttrzBn87MM4V8IdOd9eugdSLBAgl0Ql6rIcZeaKFBUkgsm95cNNtzTJIL1hdbChKIAab96UNd0ATt+nc4RFDV9pvuWb2R0XxIk/DCGDa1x5VS94L7Bik+Ngvwoe1lEyTwz2jhbpjlJi05s0DhPRP8VOS+Qlxoc6Ai8XPhlz8HeVGog93CC6FYeV0ll7WkU5S3Ia07gVweBdJzp5DyuiaPsUZrnOPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwRoUTCdhHp+eUdKNxuRYpvCkMuqJs+ple1/71xBtLY=;
 b=f33/xqymHfkTEeoyLDJxan8doohUET7nd2GZA6cyR4AvJPSzFHQgYLzoD2rmyAGiToagsn1hk3+Or1nVEM1pCcF0H//rFQXejuuVU7m9XroY4qcV4OXzkdxY76l6uWPYwwow04SUUik9CBIJuZOzRoI6i0+zZV/wKRVU/eca+XaZ1Ed8koEhhARCoFHxKsBajPBssL/c2xcXvHwG17XKuJmegSQ0DOA6MER68JO2hYBLL/82/TYJOcXiTngJsbc8WSiJ8YpMD8YPx1867e78BMc48G7eQC97c4l6HJ9CxcZcSFdIpVg0wFtBscD+uNURNxPz0TWP0b5K8uBl9Lt9uw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwRoUTCdhHp+eUdKNxuRYpvCkMuqJs+ple1/71xBtLY=;
 b=FPBmqbo7//I/UoCwyMd26gPC7kh/5KxdxaLfRy4QOpMc26nUjWLhHXAGHkyQwqhLi30TOi3R8YT/K7exmW7ldLyCSnGBW+5XVIRmKtC0vA09+yFAW7Lua1VxbzPUpT6y1iMqTZgxIeclcQDlJdpDygVZ/5x+2IxmMoi3/crBbK4=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 MN2PR10MB4014.namprd10.prod.outlook.com (2603:10b6:208:182::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Wed, 2 Feb
 2022 21:02:16 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::21b5:910:b965:9e6c]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::21b5:910:b965:9e6c%6]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 21:02:16 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     geert@linux-m68k.org, hdanton@sina.com, hch@infradead.org,
        stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 7/8] vhost: move worker thread fields to new struct
Date:   Wed,  2 Feb 2022 15:01:59 -0600
Message-Id: <20220202210200.5235-8-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220202210200.5235-1-michael.christie@oracle.com>
References: <20220202210200.5235-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DS7PR05CA0067.namprd05.prod.outlook.com
 (2603:10b6:8:57::12) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e1b91dba-c7d3-4cd5-97ca-08d9e68f48f9
X-MS-TrafficTypeDiagnostic: MN2PR10MB4014:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB4014FF52FA8D466C33968153F1279@MN2PR10MB4014.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ag/Evij9F8zJzpuELsKXM5pFNRZGzPGUb1fGwlt21D0AvJ4AbRd7kbXN9k3vh1VA2vLbW6+DdTaP/+/Wxxj5wA8Cru9VkC9XtfwWU+IYdO+wyc/b3P8B9yxkOlidyxCPiwUaWxT6poAduMOxv2wZKMRK60H3/Xt0nIld+Qn+BfH/Cj84oKiP2BUIClYXzUV1/ZViHz3vrsecBpwOA1yFC/LPp8XbT/eUt3++1zLlcgKue0SHaymrQmHx5rrHiXgFLGEobBX9uQ9XBDplSx6egIi4sef2V4lFeOXvho66cUHLxkROFBTTjaWf5H1OA2bZjySGHrB0/XM0SqHZpp7iH5SB5eHIyrOr903KkRHVDSXQFDtWxCx0fQiJJ0OuM2DLD0Qd8fis/L8w3fFYjbvSRzwfEe0DXT2XFDalvEFYQzYURQZBtbgsiAMRtAV50A9TKpCPWKIiLlgjwHoiyigq1/vMchFCPcuQpzpS6TI8cRnftcXhBWMz4/2actCTvqI+tscArnJ3wTyIwM4505D8D0tHVF0Tx8f0XUahgGlZSBFfaMxzZma74s3Mo2xfuGZLlTbjQLceOpthipI/Z1Po+R5OQQnangubkiETvffDhzvwsTpVy+vz1vqt9h6OaJSl/8XB+JKOM5KGlfTGmA7o4J+QkHxBAcnpVHWmqU/w10PHE+7lwrRu3h09O33esdoZu8FHtH27l6YJ1CrcKcWKR7rA2iMGGWDKW3NuqLRfuoc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(6666004)(2906002)(316002)(38100700002)(1076003)(54906003)(38350700002)(5660300002)(186003)(26005)(2616005)(66556008)(4326008)(66476007)(7416002)(6506007)(66946007)(8676002)(52116002)(921005)(6486002)(8936002)(508600001)(6512007)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yjlTEGMp54U+Yxkrl82RM90VLXXR4zqqgspIKVhtQVIwJcFOQpPyLOQjworL?=
 =?us-ascii?Q?p3c4W4kJuI4tw+RgLzU3LVnyxrd+hQovUgPbRlNDr1A26HPqZZo55P8wzZ1o?=
 =?us-ascii?Q?0nt+u9PLUv2GN+/lJxe5HOWzyOmuZejCPS6UoPVREZhZUnzEzIGfrQQoVPTq?=
 =?us-ascii?Q?2Lg4lbRcU5HlzCm1EyC8zGMtlRcHu1aUjXEQyUJGdeehgTFo+VZUNe3P9niN?=
 =?us-ascii?Q?KbyJEd7qndirncA0SvMWej5pcRB4YejH8w+f7YP4pHLmzqGwF5b4i4rtSu5b?=
 =?us-ascii?Q?oSPJPbHNTFtD1vqFK/W1K+4bbARifbGpM/v7jCSngNk6eps3NNuTWnl1Lg3e?=
 =?us-ascii?Q?eavmWctZhHXxrLwXxG+bXzLw6N2sAF1cFsiQEc4T6qNU9u3kS45KvMAPdb1Y?=
 =?us-ascii?Q?ZFxuo0FozAd6lpmc+P7t/GtitGHGf/LKToZubkYg4jCt/44qpefB9IcIw16V?=
 =?us-ascii?Q?WsNguI4cEMl85GRb3rZcHDXxAvTLSXYTW9RBP+UJUZ643tQv26xsKnSoEMNd?=
 =?us-ascii?Q?zlC6lzfUx0hEH2nFMYzc4U5dvEI42+4w9M5+8QYWpWDKAba80I1FIS8aEgSv?=
 =?us-ascii?Q?eupJzsoktUjQoZRiyvrMJhoLL695LutXlevyfdWb2LNB3IYKfKdzYdf3qk+v?=
 =?us-ascii?Q?6F0HJwou0az/kewr9QQh9hWTCx1f/+64CcuITKqp1xKp8YodJMVZn3XA2pP2?=
 =?us-ascii?Q?x2lO0YpEA053FMCGxjAGv6uC8wkw10BJITGbE8O4WvV3d3TUQN2I4WyQtZWp?=
 =?us-ascii?Q?AbNlbQROdmYlxT8S4iTYLCck64ruJCnxscSXZLMtft+4RyDG8rj0Ohmf3hOI?=
 =?us-ascii?Q?ZVJRgLffOiCoE/sggrHMMCWouk38tQmJHjg7KbwQrTQFm7j4G1eKQuKe1bcY?=
 =?us-ascii?Q?dlUbHqIgd3UhiwG2NtG8wfK1z6zhE34r1vszCjEyOErb80Dqiw/YvRfMyePg?=
 =?us-ascii?Q?XNaqDh1/OatmJl4JPdDJynDQndI/zzEfzK6NdPV6bqv2OMyPJb4czWEIdG4a?=
 =?us-ascii?Q?Mdj/m9DDSVgdNxQOwOZwsE6KFZW5sunCHCuq7xTaaxt9CBKTbDgRy0r4Ki6R?=
 =?us-ascii?Q?AxTo617mfTbhNNXeobu9/bnWgJbvewQoAqvr6IGUcl8ap9aSJHrdWI4XpciZ?=
 =?us-ascii?Q?wT0JWij7mSyDimKjwIyLoXYaw1LjGl4bfgYz4D3MMX70d86FPYYb6Z4kKzgy?=
 =?us-ascii?Q?s3F41Eu4K7vP/udAWvj8sLUbYNkoiKotf/jU3Fqsr8o+98S9DN0YWIrzhQpC?=
 =?us-ascii?Q?2bgXhSIadynTXYoIB20WOsqAVICAzWZ4UJUeDCwdT1Lx38Ri4/gqlu+nlRus?=
 =?us-ascii?Q?aSlFaWVVdN6nXUnPt0kxhSmjV/mNao+yVG0hqj9wDe476tZAuIIt1IQd9WPG?=
 =?us-ascii?Q?X34LSnN+YcYo/9QVoKYHVoWBOcQW90tLgUCU7O1c8uDFILL0LCwIeTnGMYRr?=
 =?us-ascii?Q?XRckzL9YBmb+vry8uPb+IJ86+G4LamdFu4YC2bTVoU1lMFg5sey5EVnXJI/o?=
 =?us-ascii?Q?ZwOjmzOuB8SjYDPTWcbA5XGT9/5/m6YMYv7tPpo9lZQaip+P56CEGMY0cej/?=
 =?us-ascii?Q?QIjIgy5rmcuCUz5S3acVN8sLp8GkkvJo/3uQmapJiwm00izGPmXOT9ryGtp9?=
 =?us-ascii?Q?x4yrCsYQYpodkqdeRbGnNQrbOeNprKsgyaQaTiRnAzdOznVKarBk8/83pCd5?=
 =?us-ascii?Q?65ReRg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1b91dba-c7d3-4cd5-97ca-08d9e68f48f9
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 21:02:12.9601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: giDtC1Wn/WJk+jHW2rZbKr4RdvfNeoy4sorHtxWYaCGApmn3eTPRCI7kbQqB1ZrMCPcZD2/+3c8sAaepWQyXWnqOF5ueJg2PW2wx7KNXKjQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4014
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020115
X-Proofpoint-GUID: xdYIK79-HarjMR8bsxWmj82xsFNp885h
X-Proofpoint-ORIG-GUID: xdYIK79-HarjMR8bsxWmj82xsFNp885h
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

