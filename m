Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857C54B014F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 00:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbiBIXam (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 18:30:42 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbiBIXaP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 18:30:15 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A4E4E0513B7
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 15:30:18 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219KLRfZ013540;
        Wed, 9 Feb 2022 23:29:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=ZwRoUTCdhHp+eUdKNxuRYpvCkMuqJs+ple1/71xBtLY=;
 b=DYGlGe/Zcfa8qZXJoq3iyBlThExTWda9h+D9jZZ+FP3X/3eZZ8jl/4MMvmXa3dlFrnOy
 E1c8a/H1mF5IUJ27p3iSsFkS3gUsYEjCH21kk49FM8pjoinGTVwZd8fhu2BNWjB1TkyV
 VSbo+GFIT3510rFzH/9956UUltjPm7YYHe7vL4BabhM5kA02+mAgS3zhUNB+gpINcRCH
 jS6O4eqobDNf/i5RwELC2oNtqMAQ/Ixl94YDqZr8B3swASj1MXEfzZjsbrN8/k1T0Q+t
 9J8ZTN2To+QUDRfuwU+Xt8lJfwAzl39C8XxfzOmdRlviw2YyG+JYwwu+5u9bLVGg6xAE uw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e345sr1ks-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 23:29:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 219NFrFb117827;
        Wed, 9 Feb 2022 23:29:57 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2170.outbound.protection.outlook.com [104.47.73.170])
        by userp3030.oracle.com with ESMTP id 3e1ec3m196-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 23:29:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iKZrgfF66OggA4Mnhz+W8wzjG4JZfZtxTWEAs/vS+1IhHnNPPTDizaNumuMhx3XDwYn/p5P1NN3FDIt9JP3xNgwRZHyYMwZ0BAQsW1rxOBV3R9AjAcS2V8tlmQ1wBsVkV6cu/vjAdaYG/WAwwuC0UoCZv8z6TgWojPpticaRI7rcAdUdqgUDVMTDXt2qcKFF3FRuAuxsWUOKMZPjigj630SWE+e7ZGnOqdvbW65wiSVdAfGsI3jcT3SzcjgK54Q+AmUxPVzAhbUpinZZGs7BN7C4SlHkyM++X//qpbpcVpTCrd5QQaS07/gotE3ENPqJH5BYgICj9e+9so/UCeL1fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZwRoUTCdhHp+eUdKNxuRYpvCkMuqJs+ple1/71xBtLY=;
 b=mYnnKU3T3lgPHcEcmSsq3vnvRDZq1Pxwb1fTOmHy3hWEigwj7uEYrd1SVPNSIPyNd0bq5jjPJM3TPr4xDvMu8roYImVJRuoGNWrEKdJUvsg5mQciRMA4YgCO+bamee9MZOTWcDGsu5iCzKyDmv0RylNkCLEKNizth2jpC7YHI/MBiql/G4cSc23ADS7l7FJksz8+HOo6UotYqMJY5hlAQkDqE9uCp+X46xwQpS9drvRUEXev/LNoS2CXEaM/3k/K50q+NFJGrZPTDkDzTVEQUnr5d0/ZkccfiQQUQOs5vxhe2dGz3rma1L10b9LvFcWgK5l/Qp+s2ZnLYPaI1Tlmtw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZwRoUTCdhHp+eUdKNxuRYpvCkMuqJs+ple1/71xBtLY=;
 b=g4QCR3/RSWstSioPC8QzR9E9Ff7qx20xcMjQRALNTeZBRPtGLIxeH57jTXoE6SsyS89/P+rEtYw/c7AxHJfDmsg4C6A+HD2wqqYUeoArtXJ+F8GWemoxPaBP4v+Zjj6YUvy+PVSSwQMP1fBCMRe+488RfDgoMjscdePrCZu+Z0Q=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 SN6PR10MB3007.namprd10.prod.outlook.com (2603:10b6:805:d9::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.17; Wed, 9 Feb 2022 23:29:54 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3448:8685:9668:b4d5]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3448:8685:9668:b4d5%5]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 23:29:54 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     geert@linux-m68k.org, hdanton@sina.com, hch@infradead.org,
        stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V8 7/8] vhost: move worker thread fields to new struct
Date:   Wed,  9 Feb 2022 17:29:38 -0600
Message-Id: <20220209232939.9169-8-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220209232939.9169-1-michael.christie@oracle.com>
References: <20220209232939.9169-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0043.namprd03.prod.outlook.com
 (2603:10b6:610:b3::18) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37efed19-2ac5-44c1-7ba8-08d9ec241391
X-MS-TrafficTypeDiagnostic: SN6PR10MB3007:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB3007F1F05EDDCC4BFA82BE50F12E9@SN6PR10MB3007.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Nb/GK5xmn2ksqs1JPnCRmA740ZFnRzf+jT1mta14NgE73VJL0T2c6aFL2pz40pjeeyuRZ2c8w3gX1mFsSXLFR0LYkNJ9RJkKtBTjIIJGbK0h2rtrh9WE3aeMBB7MUfWUVtrEIPYNlmbiJDyl/qXUebyPPomOeZ3S4uNZtZRNKGVRcR/yWPCOug/BRmj5ZcVEoEsOP6eJ7EOSAOTKynRPalGEz6REF1g+K3su2limC07R7gMsMGyXvqLfwOT6KV5bmO6gid2aGzhLWvJKLHZS+MJglyLPmqQxudDG+CGvrw8SskuOz74blO1lb9LK6Z72aJ6HPxTltR8h4T9x8KdPw4uAsRREeNWjI3KJDriRfYo95+wj9GQIXTE9/62K+ClpJQk3EI3Swmmg2EB6vCRJfHeco1qu3XSBEw1aZqZvLQFHVcGx4OHltF/bAX2YdPKkeCeysy6wj2jHpbNCMk5Q8jSrsb8k5r61JOFWqx4U+Jjq9ul/9frg86QgWcrmM42TmlzAR1fjHYHXnMYpdDf10muxqbZSoXeAZ8LGRzbnWJUKxNEcPuaRZCjqnnC4t53ScOl3F5wcE+RmlmqIbl7bBu7Z8CZ1bp45P62Mu2CcnrgdT9FLzaW9aULVPNGw6adnGylpI5pfIF2vp9AkEHdeB1HiJZXcJHz5AhrGqboQzwhsfFTcr1C4hk5V7TDJDrSpFgAM8SrdKTfLfcyqaajiDPpFJRhyuJj6rHZbiiuJ73g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(921005)(86362001)(508600001)(2616005)(1076003)(2906002)(36756003)(26005)(186003)(83380400001)(6486002)(6506007)(8936002)(52116002)(38350700002)(38100700002)(54906003)(66476007)(66556008)(66946007)(4326008)(8676002)(7416002)(6666004)(5660300002)(316002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZmxdVLYbkfZA+/j4aE4E/O/Z0WYCyzznoA95Rl8MIorzW65C/ZGetENdvAxc?=
 =?us-ascii?Q?d1v3mn8RPJ3DN8Iz5B+fp3ddCa7A9Dj9trMmSwNQc7EcDU4FcxEzJZ/zjZHz?=
 =?us-ascii?Q?rixhgwrNklJm87Kj0AypRZ4lZWqMtI/W1gwl6TqlDizEEVGbEdcXJMXPNK3i?=
 =?us-ascii?Q?6ZhS+tt3FvFpOwPoOWHTQXx/OJ2hmHgsxffms1uZQyGYnGXI+rd7bhTZM9vL?=
 =?us-ascii?Q?17XkNzb9/26a0x3o0k2A5HxZuDLCVAPJ/ZJqB3aL/plhMSy4m5p2uvJ3od3l?=
 =?us-ascii?Q?3rqU+zRP693uqwEbRamy8rO6IzXUxGn/aUWdXviChsCjvreOf3aA2QTLjxek?=
 =?us-ascii?Q?c3ui8APq5NiXVsqwA0bykEaLOllGMIXnFE4lKp/3SkTqnDT1EBp+oAOYp7nM?=
 =?us-ascii?Q?juIlRIMXQIsE8Vhd7tI80TPrUbwJPUitCFzcfO1P0eN2x05zkO3LlBotcaDq?=
 =?us-ascii?Q?ZCz4sr+4HD5+VAsSW3/QyoUtrBgj4JSkJNade81LdnCafoHYiPrtRVfM0ctV?=
 =?us-ascii?Q?uwL26bt4GpQh9ykLRBUki7Kpb/0sW/PRkHlWQ3pFnB7viFYEp/foHYhtaiQ/?=
 =?us-ascii?Q?J4oGLYSuYLi0hcBzWszrdmVM6wfI+dFVhsRw5TZ9E3C+Nn+ww7t0LI8SGjpn?=
 =?us-ascii?Q?/eOGjn9xW1q//AlPKEqVjG9pDrOQDRFFK1V5FgfvV5qbcinQ7k0rzKhmSOex?=
 =?us-ascii?Q?VkZ2BCAzQPG0O0VSvIwpw+0+QmG95COG07BmRn16u+Oh+Y1ZaSbB6N/c8P+H?=
 =?us-ascii?Q?qIgs64sR1Tz4JE5lIeUOwI01MF3qTzi4SpKf+oScba38jurynV5770WoTFFB?=
 =?us-ascii?Q?PlFgI/sopuYy8YxlakXM5U+DVPYved9ZGV5y5faAw/QQ4lAS58Ckl710clMR?=
 =?us-ascii?Q?VFp6FzutWRHqmr5DheFFeYFx28WMMbRqvP7L/NqXTTsFrrwGbD0NcaZMmLck?=
 =?us-ascii?Q?RBgvkZSV+VH2HefJ31pfX5vHQBJTT+i7flMfDD/Vs4/H0dpLXWmy3MhEeVlm?=
 =?us-ascii?Q?ctuE0I6BLRz65ZFhpYvRGqk0PmoiXym/jY8dzyxa85AP9cEZMv48Kbt1P0O3?=
 =?us-ascii?Q?0VDPRYa3UHVJ8pGoM0R+0Xsi0554Bx69pKqzjd+2Kz32OtIutn0IYqi2DLhp?=
 =?us-ascii?Q?RIBmwcUtMuy/5EY7staH07WIe7v9+9Kq6p4DXbph0w8egAakyLdijdEk2+v7?=
 =?us-ascii?Q?taecI1/Ta4v6RQq/xMeW6sseHvAzstHxVSLykTfjny/wtXudOL/w7XRYn3ul?=
 =?us-ascii?Q?zkYlfIKiuxeFCgn1r1XDUtg4/BjX2gWhIzRE5o+CWQHNcW/awIxwP3wefzfx?=
 =?us-ascii?Q?ipGtFSl+GJRQ7NVUuGzR8i/DXffaynLqgPdLdoER5iVzzOo6yIhsZvqeg1Fk?=
 =?us-ascii?Q?SkRvjr7w4NqQuuKZtwYDHredVtWwPMJdBm+txlZrCzsczr1iwzC70p0E8CPa?=
 =?us-ascii?Q?TMzwJzxJ7xNX4Hk9jPHj/gr4DCWnco6Nm9sh/OifEVQJhMRX7shgvKkWXpqn?=
 =?us-ascii?Q?wMURWfV0mAOg0P6VfeQ4DirAobGHfzkcdMr+9IRahGY3ngXcLOtgpJdbdbyY?=
 =?us-ascii?Q?WDXyQHx9sjBb9LicGgfi1ZwopICay301JR1+piI3oLkHHBaP2Ktm8199r+Xd?=
 =?us-ascii?Q?4FTsiEAkyTPFfxOpz4IMjpRINyyV4PttM0QK6P3xXLzKjQGplz2aEnW2GNWV?=
 =?us-ascii?Q?0iaz1Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37efed19-2ac5-44c1-7ba8-08d9ec241391
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 23:29:54.2477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eRit/Vpn2ZowpLo0vNVbrHpR56q5fnHL4Q5thnQNegU3QuTMzYCw/q32ePlaIEWTWrklWP8XLEkvx+IXZ8bnt8/CmgTo4Pa6VTityEvE4ms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3007
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090122
X-Proofpoint-GUID: sq1xv2t0mbvOufOdpDkicR01qRebeRr_
X-Proofpoint-ORIG-GUID: sq1xv2t0mbvOufOdpDkicR01qRebeRr_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

