Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C04E4A79F6
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 22:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347387AbiBBVCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 16:02:52 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:33104 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347365AbiBBVCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:02:40 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212KwoGp024812;
        Wed, 2 Feb 2022 21:02:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=PXXdV0JicyRwxDzTfgVc9CnWFDR1h6e3mgSqpxLKbUs=;
 b=IEi6dPbyTij8yamApfQjqbdp6BIGo+mOpnHQrw6xWTOy0TPdLELzjBik9fr4DwLn/Unh
 2bA7donjStZoiF4gwx0E7pZRfTwujQuG8Zl51W8pryAKYrV0wRpyAgnsC8ZaGNmYsTl4
 R2pqjqWBP67NrEemKc1iaBJJ8kB8NSKwcwf090q/VwDgezqf9iX9QNNW5pSOVLrAeZqr
 oeJXEFQ4mIRUqtD6tfwtUyJuO7DBl2iwVL+urJDllZFwlwIuEghkL8Qc5DPV/56+Kaq1
 q4SsO9uWnsYMqVNVxjczs5+9oK9FPFcvxQDhdRQcmqiLX9hsh9yvPoclT7huxj7E3xOJ DA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxjatyf0s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 21:02:20 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 212L1Eju021471;
        Wed, 2 Feb 2022 21:02:19 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by aserp3020.oracle.com with ESMTP id 3dvwd8xt3n-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 21:02:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PXXcW6Ps6lqJ1ndymDz+D4JFQxQe6QXGF1S5V+ArbDm/3iLUMwschKO/SiOOEOGL+TjQA5fF2OZgYy3/Y1Zk1VVsLHTMV1gyko7dT8yBp/8s8+VBpIu9oPQhWmQ4I6sZc2z9gy5YT2kZ3FeUMXHzqRV/3oeP1xEfFZ6K+B0IBPqDrbu8Pt7xHB9ZsT9QxDCm76nwvXQQ5H4zDMwwVYUGZCUFkXiSmnZkE6vDiFg0DzmUXxVOkJBS9REdg5n5Gbm+BDoN0mTWFUHnR4GciUk0yPNZTm8wL2Xtq2pmFVuG4RESQuTVzX5J6d55Z/8z+WfbNxN+izGy6mgiOQ4TCU6p6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXXdV0JicyRwxDzTfgVc9CnWFDR1h6e3mgSqpxLKbUs=;
 b=cNVWMZaAnceau4AIlMnpa3viPfFZfC9xfIrtR3RCtXjCAoAS/R/iAsqV/ndy+C7jBQ1xnlQWcsRRIvKxnUKawo5lp0sEdV72HBdPQJhD1tp8R//cIB0dMHAYvE3U9Ut0z/pw4OFbWtHOVykotGbea7j4XqoZ+od1BYR/xTGIE43I2aLOFrG2pI/+xymnuU+afjZm6HihhcyBbwrpwFy8Gpl55tNTlDy2g/PKtHLKg10KW60dvnCFHe4Mqa+x+7j8HAqjt7wIwv65NhoV+b1eyK9Xy1WhQtrleTssPzbcISqvNkHNo9oIiQ3lUIxAXJf7hYRp66rHnMDuRkEmyhKSvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXXdV0JicyRwxDzTfgVc9CnWFDR1h6e3mgSqpxLKbUs=;
 b=YZRq8hmYR8k//HH+D2CTxCLdsQHUWVfRsyMYCfKjJ4AQ1xub47lxy0bbIR1ygp4XFZrJvfqGG0UYCn2E61bHOIyQESc8QUvyHYXynaOBnIyahGHd+a8TgVfEg5cT1G88xSZjl+NcEaenPJrZ/jl/QpePYKE5451HB8ME9mD9Y90=
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
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 8/8] vhost: use vhost_tasks for worker threads
Date:   Wed,  2 Feb 2022 15:02:00 -0600
Message-Id: <20220202210200.5235-9-michael.christie@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8be98cfe-3983-4109-a606-08d9e68f494a
X-MS-TrafficTypeDiagnostic: MN2PR10MB4014:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB40143C7A50409775A83A66A7F1279@MN2PR10MB4014.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:334;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uGg6QqxstN6oT6xyjuMgvS+oDU30afnXw/9EF13gokgP74EL89bBUMC7pmBi9Iw89iNhPtV24VN2KkFvAVMblf04SzraPJrlvgsT82Fz8IrlQPNfz4R21qWH7oNNVID6ycYmsueQsNt6gseYu09jks55zeUoi23G4dqb9wF50YWk9ldC6SSCyu5EC9vcUiHt8pbq+r7aX9w1s3PW5anmcIyQf7lBKATYccZF7C76HbRZC7UUz/Xn4d8ZAnHXMGpixmQDu2skev3FdQet++u/eEK4BsTISjJr3DMGRaibGXilifS8AOFt/krgVNTpKtd/UjrngoU2DBDyat0rW/Lr/CQZjCP5VwJ6b3FGxQXdmZym6Zsov2XkaDkED1Y/w0di1s62JXzv5zwJBqXlrGkJ0fvqltGcG2UeFNHHrRG46jY9YUmwkqKpsIr/pZCuFhH8NWlo4oXMrm/ADacKySzAMuCocUY/ZovascOMsISI72qQPvZn3nvOv5zIIGsDfRnervTqJ6XOPzNy6hSxImK2fiVX8vn31kmX85zj/qnu1+LYoxokdE60kFBymTYJ4tfM5DY9J8J4F9r8AaKCwYPOrITdbj8qROhzfHwx+XAtkG+QfKPIcOCWm4759biaEJZQQsKN+Fl1k73O/W+MtTShK8dK7nWzXVOnSJDXXdQRowBdVqq3qNBihIH3a/Hs98KprcYRHpIY6nRNRgJHpCnkwxgIiof4+me1CB5MCDID3m8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(6666004)(2906002)(107886003)(316002)(38100700002)(1076003)(38350700002)(5660300002)(186003)(26005)(2616005)(66556008)(4326008)(66476007)(7416002)(6506007)(66946007)(8676002)(52116002)(921005)(6486002)(8936002)(508600001)(6512007)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0wnWS43h2mG1q1fa4+eoWG2QPojAAmFIjCCF5toV4RwuEsNRTLhQTxmmyWpS?=
 =?us-ascii?Q?UsCipJMYzLpcDbM+DcHIVwoPKSwKGbG1yeHk55LXZY0RRz9IwB00Rjf0umy9?=
 =?us-ascii?Q?QLudhW5SUAUWuhwtZAt/oJ4pC9B9+oP2MfwXRBBdf7+G7fZBwqHzTvUnfJzT?=
 =?us-ascii?Q?istVwPEaCdsECmWGYPXxw+ixC1bX4fPooRTOGyPuazdyIh7yzLdkoXgBAXCb?=
 =?us-ascii?Q?5W8HtWW+nUYBve4UAzx0joxh/NFydsSpVVaIicG3KUD2c+F4Y5OLHE9qUUel?=
 =?us-ascii?Q?kgXDYyqy320Bkb5T0w6R+5wwb6Yi3Il5fAtjxQpWP1mlzd9pcqdBrgkNbHWu?=
 =?us-ascii?Q?kwMZ597jCxUbkw1eNgtH6bdHPoZjxm8qNnmjvcdXt7F0VnyLzVZJs5WHSMSl?=
 =?us-ascii?Q?HvNULq87pHd3S91UBWCn4ODiKUn1/7QO7rsnQxLYCJDp7hICUdkviHNRTrO6?=
 =?us-ascii?Q?ZsjGkMw+6jhlB8M757iIMHP/Wq9zzJSGZsFmQ1LNjD7LcSEB5/sURAaacbff?=
 =?us-ascii?Q?ZLkcx4yLHfCogdL0Icu8DhjQRUet4Rp9ft7ioEUOQ7r/UCi9S96uOo9WJQlo?=
 =?us-ascii?Q?PbvIddWq/45gVer08dw3hQiFCPvfEqUUrqD5OmlmuVNnaGBmSu+t+geGCIWd?=
 =?us-ascii?Q?piFI0JiWHIVHHLoUjAh41VZA2M2dbcsaud1klYlAIOoBzmG7pR0H+jzGVo6C?=
 =?us-ascii?Q?Wv9bCthFpAD+7P7sVLNIyrvrXEhguBQhdvO68n4K127BDULhCbNEJCnxrrLG?=
 =?us-ascii?Q?06ApJKnq+8Z6oYsFe8p6jRcET5rNIyJjeV1Uoe7RRtf1bG8HzCnfCFP1HQXi?=
 =?us-ascii?Q?kClrrOrNcbdtcc/a5wyB+2W/DMyJ2kibgbAZRkY+6N7Eimd311uezblAPIhU?=
 =?us-ascii?Q?iv82DqHMdGnnkYHLWmnECz/VeSVHjvJKHfxGHmkoPkTaf6PyNH03Mc8ZvsFN?=
 =?us-ascii?Q?Ed7EJh4spZ8XgqbRLRAQWpYx8buMzkdvoR1/T5KAg9dRxHYC7KoiDDnbHLol?=
 =?us-ascii?Q?8sxI4J71HNq/Qam1MEPHohbfH0k3+6Xp8vzsfyS502lGbj48hvDyQxDiK1En?=
 =?us-ascii?Q?aHsrnkNAiQEk8hEkCFgp8vZP37MSbpGpMmnW4DKm50b8cMlXnVHa6t5Ua+74?=
 =?us-ascii?Q?AvGOo9MxM1wBl3VibAURT467mFWZ1ew2IirU89FSOWzNray+A3lUSFhPHQh+?=
 =?us-ascii?Q?X9kuLkcSTd+fLwhsxxhIryy70EVwcz7/2gEqOnE7o6HwilPTu8v6Ej6dJUKU?=
 =?us-ascii?Q?pJROgkYSUqXmQ6jZ9/xfjtIjIvgRidRWYwPyTQircvplrZi+a7NflGwnCWIR?=
 =?us-ascii?Q?ghGuK/Idxd/EA75ZSfMaYh9PWjTEdmOOTcvOjcxO7pV6LIBxy0sLHx7qU/Vp?=
 =?us-ascii?Q?Vgh66ScrCEK8ap0X80lDESGfy9K+CNJy6/Dc9BLRxPPtqR38BuHyAv45/uoL?=
 =?us-ascii?Q?g5N1CkRCgmxmrahHuzpYfs3FhHdL7uldkURDyhOzqpO5R3mkQqzbFj0r42kG?=
 =?us-ascii?Q?OOMcSAVqHVPzqBaFGGv7iplAWHxoJudzmZEdGWTn9xm8/QTg5xRYWOIj+rHb?=
 =?us-ascii?Q?i3nn34svnTP69eqpKjjOOWOqdR0nuchHqtD0tIwnIUDufLLqvYYOmPUVPI39?=
 =?us-ascii?Q?GEJx1AqnQLu3qO9kbAgJPPafOST9Ozix/Ms/emv3W/3MzzgilMeFUHaTqf4o?=
 =?us-ascii?Q?Gxlw8Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8be98cfe-3983-4109-a606-08d9e68f494a
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 21:02:13.4914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rdc9yuW8Exd0yIFJ1dDE3OJDJndzdq1lRDECtYqQepDhwRBz2DgARyUPMNHJ80Cl4oOG68BKVoUHZf1RI60gn0c7PkVaqWj97wVXFeCW/40=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4014
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020115
X-Proofpoint-GUID: RvkaAtiCK5Bb6EJgJuCeAY2qLVq-qjA7
X-Proofpoint-ORIG-GUID: RvkaAtiCK5Bb6EJgJuCeAY2qLVq-qjA7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For vhost workers we use the kthread API which inherit's its values from
and checks against the kthreadd thread. This results in the wrong RLIMITs
being checked, so while tools like libvirt try to control the number of
threads based on the nproc rlimit setting we can end up creating more
threads than the user wanted.

This patch has us use the vhost_task helpers which will inherit its
values/checks from the thread that owns the device similar to if we did
a clone in userspace.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 drivers/vhost/vhost.c | 58 ++++++++-----------------------------------
 drivers/vhost/vhost.h |  4 +--
 2 files changed, 13 insertions(+), 49 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index c9a1f706989c..ce356f5dc751 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -22,11 +22,11 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/kthread.h>
-#include <linux/cgroup.h>
 #include <linux/module.h>
 #include <linux/sort.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/signal.h>
+#include <linux/sched/vhost_task.h>
 #include <linux/interval_tree_generic.h>
 #include <linux/nospec.h>
 #include <linux/kcov.h>
@@ -264,7 +264,7 @@ void vhost_work_queue(struct vhost_dev *dev, struct vhost_work *work)
 		 * test_and_set_bit() implies a memory barrier.
 		 */
 		llist_add(&work->node, &dev->worker->work_list);
-		wake_up_process(dev->worker->task);
+		wake_up_process(dev->worker->vtsk->task);
 	}
 }
 EXPORT_SYMBOL_GPL(vhost_work_queue);
@@ -344,17 +344,14 @@ static void vhost_vq_reset(struct vhost_dev *dev,
 static int vhost_worker(void *data)
 {
 	struct vhost_worker *worker = data;
-	struct vhost_dev *dev = worker->dev;
 	struct vhost_work *work, *work_next;
 	struct llist_node *node;
 
-	kthread_use_mm(dev->mm);
-
 	for (;;) {
 		/* mb paired w/ kthread_stop */
 		set_current_state(TASK_INTERRUPTIBLE);
 
-		if (kthread_should_stop()) {
+		if (vhost_task_should_stop(worker->vtsk)) {
 			__set_current_state(TASK_RUNNING);
 			break;
 		}
@@ -376,7 +373,7 @@ static int vhost_worker(void *data)
 				schedule();
 		}
 	}
-	kthread_unuse_mm(dev->mm);
+
 	return 0;
 }
 
@@ -517,31 +514,6 @@ long vhost_dev_check_owner(struct vhost_dev *dev)
 }
 EXPORT_SYMBOL_GPL(vhost_dev_check_owner);
 
-struct vhost_attach_cgroups_struct {
-	struct vhost_work work;
-	struct task_struct *owner;
-	int ret;
-};
-
-static void vhost_attach_cgroups_work(struct vhost_work *work)
-{
-	struct vhost_attach_cgroups_struct *s;
-
-	s = container_of(work, struct vhost_attach_cgroups_struct, work);
-	s->ret = cgroup_attach_task_all(s->owner, current);
-}
-
-static int vhost_attach_cgroups(struct vhost_dev *dev)
-{
-	struct vhost_attach_cgroups_struct attach;
-
-	attach.owner = current;
-	vhost_work_init(&attach.work, vhost_attach_cgroups_work);
-	vhost_work_queue(dev, &attach.work);
-	vhost_work_dev_flush(dev);
-	return attach.ret;
-}
-
 /* Caller should have device mutex */
 bool vhost_dev_has_owner(struct vhost_dev *dev)
 {
@@ -588,14 +560,14 @@ static void vhost_worker_free(struct vhost_dev *dev)
 
 	dev->worker = NULL;
 	WARN_ON(!llist_empty(&worker->work_list));
-	kthread_stop(worker->task);
+	vhost_task_stop(worker->vtsk);
 	kfree(worker);
 }
 
 static int vhost_worker_create(struct vhost_dev *dev)
 {
 	struct vhost_worker *worker;
-	struct task_struct *task;
+	struct vhost_task *vtsk;
 	int ret;
 
 	worker = kzalloc(sizeof(*worker), GFP_KERNEL_ACCOUNT);
@@ -603,27 +575,19 @@ static int vhost_worker_create(struct vhost_dev *dev)
 		return -ENOMEM;
 
 	dev->worker = worker;
-	worker->dev = dev;
 	worker->kcov_handle = kcov_common_handle();
 	init_llist_head(&worker->work_list);
 
-	task = kthread_create(vhost_worker, worker, "vhost-%d", current->pid);
-	if (IS_ERR(task)) {
-		ret = PTR_ERR(task);
+	vtsk = vhost_task_create(vhost_worker, worker, NUMA_NO_NODE);
+	if (!vtsk) {
+		ret = -ENOMEM;
 		goto free_worker;
 	}
 
-	worker->task = task;
-	wake_up_process(task); /* avoid contributing to loadavg */
-
-	ret = vhost_attach_cgroups(dev);
-	if (ret)
-		goto stop_worker;
-
+	worker->vtsk = vtsk;
+	vhost_task_start(vtsk, "vhost-%d", current->pid);
 	return 0;
 
-stop_worker:
-	kthread_stop(worker->task);
 free_worker:
 	kfree(worker);
 	dev->worker = NULL;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 102ce25e4e13..c9f391326dd5 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -16,6 +16,7 @@
 #include <linux/irqbypass.h>
 
 struct vhost_work;
+struct vhost_task;
 typedef void (*vhost_work_fn_t)(struct vhost_work *work);
 
 #define VHOST_WORK_QUEUED 1
@@ -26,9 +27,8 @@ struct vhost_work {
 };
 
 struct vhost_worker {
-	struct task_struct	*task;
+	struct vhost_task	*vtsk;
 	struct llist_head	work_list;
-	struct vhost_dev	*dev;
 	u64			kcov_handle;
 };
 
-- 
2.25.1

