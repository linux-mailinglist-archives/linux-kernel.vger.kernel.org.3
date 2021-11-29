Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BABD46210F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 20:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379504AbhK2Tz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:55:29 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:3032 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1380116AbhK2Tx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:53:27 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATJVD6Y009060;
        Mon, 29 Nov 2021 19:47:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=Rz0acln+bGH/t7SRpkxyLkfAesAkhxt36FXUjDOsNlI=;
 b=eE5oo2ynoVeOMuOupXLtKaHLK9D8sceZObpgzt5Go37HjZCaosWkNwLEMS8ag3TBeP42
 oCsUgZNiVlbnAdKS+/Rpenq0p1T0pKCeI6/TuZ85NJo5SiNPUjyNS/2rxqMv2pmSGMF2
 5srn1VYxVKlNbvAHI9FaNPQCI1uBDTVNGCyo1ghwFsL8xCbAaprLJ3405P0OaPkoSUbS
 sO2r9MuXzF+ARESHqr2qaZvjGdos5nHDc/3sjtuiQC/g+XMGTN4b3WRtoX3ThKi8kDn0
 ozRHkcek/Esa9LnRXL6+Hr6RoFA11OiYK87g0bQMpUk6YJs7bjiC+y8YlTpFvbFnkjxN uw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmuc9kt0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 19:47:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ATJjfDe105524;
        Mon, 29 Nov 2021 19:47:28 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2176.outbound.protection.outlook.com [104.47.73.176])
        by aserp3020.oracle.com with ESMTP id 3cmmunncj6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 19:47:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UKMDslz1KtBcS2ckXUtAeU+ENOb5XahEhTcs+53EvKKZlnKV4QJ8+2Q89KvSm0YvFY9HHzKPPurAsTPfi3G3yqAIfej2nxXwf4plxeKXIq8gCJcv0AADO3tZ5tb41QWEhDk9Boy3DxaXx/qL6A0RjgOfOeH3Aa/8nQ/2d9/1sbrGK5/kNTv5UpdkTiScC+y+cjlIyNL/QPyMmfnJb5+UTQMv3rGRvv1qC1LS6U0Rq87XP0Wmb6rUPWYZWVl1VjuO8VBbWZDOcpvWR4wQn8mjBfdwP7TdTbxwXaIwULh20v3TwwbSUoNEZjzakLarvQyE/UGq9BGZzumRtR5rDFEdAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rz0acln+bGH/t7SRpkxyLkfAesAkhxt36FXUjDOsNlI=;
 b=gmdktuG/2ewoz7z1gDkA+OpByoe0FHQqd86OItCh+VlNJgdTLokJPNXR0XYJpbuinbE6P3jUk5pSQoKJD9NCGbj2WeJdrN6VTR/2aePymF8O+DuagELSbufXHOuTsKR7zne9SMV5JNR+gmw0wANBkOdVhgpCADPcs1tsAwL6lSaKGCbX4yT2nsC7CD7SGsvHH6kTSdsgqc/NoxQJkdAPvNQGm57VjQWm1bieFuQeBZRdYEsgDR5ZqHjfT5rLn+K4rK61qPEb+xD0F0qhLLFRMorPJU82DRL31qJCLm8SPZlDWm4u8NAIF/ZIxY6P6m3P7UDSkmZiStOOoPdyXpvFTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rz0acln+bGH/t7SRpkxyLkfAesAkhxt36FXUjDOsNlI=;
 b=in/P0Avs98OX25e6oAoLc9ukj41EscLEASR4bY2nfUB/id06Xu0Fh8YkCKgDhIwo9NJWfrwnjKR++6YuM5CKWGsBG/udmVuz+AsaswlHuZ3I86f7GEX22aiIatspxPUQaLjBqQWlX2dLhqNPjg4w17CVRdIBIx1GAUgdcZtWHOM=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM5PR10MB1307.namprd10.prod.outlook.com (2603:10b6:3:e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.21; Mon, 29 Nov 2021 19:47:25 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4734.024; Mon, 29 Nov
 2021 19:47:25 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V6 10/10] vhost: use user_worker to check RLIMITs
Date:   Mon, 29 Nov 2021 13:47:07 -0600
Message-Id: <20211129194707.5863-11-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211129194707.5863-1-michael.christie@oracle.com>
References: <20211129194707.5863-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:610:cc::31) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by CH0PR03CA0086.namprd03.prod.outlook.com (2603:10b6:610:cc::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 19:47:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4b89d118-a007-4525-91b5-08d9b3711188
X-MS-TrafficTypeDiagnostic: DM5PR10MB1307:
X-Microsoft-Antispam-PRVS: <DM5PR10MB1307417D537A93B534BD9E1DF1669@DM5PR10MB1307.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:191;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +zl6OIT9P6mJEf+7DPaOtwgrA97X8VRIMqdo+HPDiajgaCG3KIpqlh2PaygJxxBczxUyIApDwRcqHwR45Bq15ws+9llks+4HHgGoy5Z6lPsNU/itZBYAoagD+QCWWewCuYjgY9aVuW6AQcO/L49k4B688Ebmx/zKGI3pQh1brii7cqXanGo1yKgtHi18j9rffkty8wvuUrm3Be4rCZgloKv2TCkPIY4bJYvbbUkVoOKp5NH9hitYuIZsdj7Imq5HpuzUnnOfhm8GAbAcNTj684yl6ONrj+KpZjGiUGGFyEa6bApIgIpSQyi5uuG0s/GUDqTWKRjCaxStO3KpwSOgpdHUrABq3mPEixvS0NlSYUknaCUsxk3ePCw/A2J2UQw7hKq3VC6iVgE5FT/GjC1FWSYuNzMpmQCQb45Lt3SvguBJ/hNFTaRljX8WXl9oLJJPxJpEhuVEPNGvj7AtLNKM5+dLePZhNJkZ7TSlfcBuCGsguOpnFbDvFdxJj89SihtLT9qiODZL3GpE6c/rRsy0n5ud41BcFUD+Ff1lQ3F0I9Wt8EO11bwIliRkABv6neEH78Tw+HFYMo21HsRDEY3fgi0nZyR8GjwIgJWYvzPLmdXmis0TrQkY9LqP1RXE4R4BTuHC4Zz76mcZ4qkc8YvaGxRw1g1m7XavUvb4M+BwEXbHBNG73RS3fsUwOetCEW8WETXGNLKcuNnHPsfWcp2mig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(36756003)(8936002)(8676002)(38350700002)(86362001)(6512007)(2906002)(54906003)(956004)(52116002)(1076003)(26005)(66556008)(66476007)(186003)(508600001)(5660300002)(921005)(6666004)(2616005)(6486002)(66946007)(38100700002)(316002)(83380400001)(4326008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+eVwHpuGuRuAWhz0JNHj0gPm6n3RDk/6arbx9R7m5VNqlroGYqrD7gBrOzmB?=
 =?us-ascii?Q?hMhOK/AS9hvqfXt4T1FOusjdVCJD3jS0CU657Y/k0RwPwWxYF3vP68cf9KBV?=
 =?us-ascii?Q?5Cpdy9oamj5mFZ5tSiHmlK0nYG5NDSNfWNw5zTtQ9+/Dfzp1m0xSLuHYhNKk?=
 =?us-ascii?Q?BIvqxkMbPcOxr5ouT11BvRNH/UtC9qi0oL3wXqGL1MXO1eNCE7BkLgvAAfe8?=
 =?us-ascii?Q?eUz/pBEM5RXCCAl7JDIs8IuCjksr2ghPJTLep3gq8S51EmgdjvhRIDploBhB?=
 =?us-ascii?Q?56arMiYwRO0v7QewJNBuxgRVwzYNgvquzwj7zXdJs2jSvnViopxR7XeJ6NZk?=
 =?us-ascii?Q?T7WmClRE4GhuftrYNUHaxJkPd5vny4MUmjgvoM6Hvej4EqoT7ROHzCycbtoc?=
 =?us-ascii?Q?tPLPDvQQXi0h/kBDCIjL1RAmA+o1xU9uNcPgNLw8Si9s5oTeglFhREJ2wi5H?=
 =?us-ascii?Q?nwxkVV9N0UMRkHwVutgV/4LxIW7kb/g1wHucTvJjCE1cgalB9YjLzNs/yo5B?=
 =?us-ascii?Q?s+N1ST5i/8WmRREWfNqA8zk4Opos6jPva/2XHTrHPc4ufbTOg5WcZLqROpN9?=
 =?us-ascii?Q?WXtauc51a52zT0EztpcSudeWlVOlq9eSoM71fDW9rBSZDMMWAvrRcLNz6YBN?=
 =?us-ascii?Q?8Kg6r/h+bkqYP4cc5aFHiaFcJA1fsjA9sq9pE0Jmj3Ut+Y8zheOP7h+e1g7B?=
 =?us-ascii?Q?LuL7QQ4hlsFwwRrkgbDNeCWbzW5rqGuFRMLrwbGoJ2kkZ3QaR+inl0WiGX0u?=
 =?us-ascii?Q?CjRUlydIFrOqV4w1bcRrb1iVLAAKrW7R9FF3Zq4I4zEZ1jam7hB1ci1vgYH7?=
 =?us-ascii?Q?+xoujOHMhQQ/LBqh4u2wpNcgXGwlpaKzOh22V+s/7Dfv9HIfB9m7bFKhKn7z?=
 =?us-ascii?Q?QgnwnCQxy4Q9lPxNzgdrP3mHAX5OmQfo9Un4jiESUggYmV5qdHuFDVlbwXOh?=
 =?us-ascii?Q?dxHCj7XwfbqMgC1UmFqpmXtovbg86WgOAw6q//8OvKcan4Nsi6gEDjfV2pic?=
 =?us-ascii?Q?npxEKC5qcQvmlyonrNOIhCc2X5Cb0yzvHD6MoIBvQGDIfPWz6yK2AeBeCTag?=
 =?us-ascii?Q?vl7CCmQStUquVL8KH5HOSrQI/wYaQnqN+lKlRzYjAZxgYJqbcas2O0uUlXiF?=
 =?us-ascii?Q?8uqfzIajFWnslATWZ9JPvD91ui4tCnPJN8ZRchd4YyvZ8RDQKZQaxpQPo1BG?=
 =?us-ascii?Q?lXHPUJngzuhV8yt362ppeHcAjp+6uc4/yDSc2OJ1vTIHTEsrc9Gn2JrkxgHD?=
 =?us-ascii?Q?FLbBfk0H7vGG6JCn5/qA6GDhe5cCDJQ5pQ28b0w4DtoRyZv8qZEAUVHQIETC?=
 =?us-ascii?Q?jg9tO38drz25mSbvuFCaZbH12vmHZ7afj71z+xLrnmHhaOLwaPwM5oYIRdDn?=
 =?us-ascii?Q?1cMH8OgN4Si7ZX9XkUo6Z0Snw5vcNNkUoY/yjl2zjw3HQUM6ZzXJkO6VAP9V?=
 =?us-ascii?Q?4KXOv9+OD15cAdTB7c1KTf09PvV9EABWH5w3l1Y6hMwEbtCIQ+Z0Vwqz3eml?=
 =?us-ascii?Q?BkhwoQ5Hk+W90Pw13z97iEsrnzxgY+NyU0kvvoDM9cT1ccQgPJYziYNRIYe0?=
 =?us-ascii?Q?if+1HnzGLOJM/OEq4TsEuOBUZA1b3Hlm+n6CMbMGIU7iSEyZk029zCHHny23?=
 =?us-ascii?Q?MEIb3JLeGEpLQPLo4j/Z/eXYuHj3IPT+ho04bxr+KSDGlXDY7N6iAnZrxI8o?=
 =?us-ascii?Q?FTF8JA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b89d118-a007-4525-91b5-08d9b3711188
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 19:47:25.8374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D0yjYh24jeiuspD93CfUm0xsIiOCpo07OemKLVoK/31npKKPgs0l5kkEGcQApD69aZk+vcVcN2BxJ/405BL5Kq9Tln8cpCf+zA2ZRk5Uy+Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1307
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111290092
X-Proofpoint-GUID: M417C8vXHlZ77ZWUcTvOanC81NZRFnMC
X-Proofpoint-ORIG-GUID: M417C8vXHlZ77ZWUcTvOanC81NZRFnMC
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For vhost workers we use the kthread API which inherit's its values from
and checks against the kthreadd thread. This results in the wrong RLIMITs
being checked. This patch has us use the user_worker helpers which will
inherit its values/checks from the thread that owns the device similar to
if we did a clone in userspace.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 drivers/vhost/vhost.c | 65 +++++++++++++++----------------------------
 drivers/vhost/vhost.h |  7 ++++-
 2 files changed, 28 insertions(+), 44 deletions(-)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index c9a1f706989c..8cf259d798c0 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -22,7 +22,6 @@
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/kthread.h>
-#include <linux/cgroup.h>
 #include <linux/module.h>
 #include <linux/sort.h>
 #include <linux/sched/mm.h>
@@ -344,17 +343,14 @@ static void vhost_vq_reset(struct vhost_dev *dev,
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
+		if (test_bit(VHOST_WORKER_FLAG_STOP, &worker->flags)) {
 			__set_current_state(TASK_RUNNING);
 			break;
 		}
@@ -376,8 +372,9 @@ static int vhost_worker(void *data)
 				schedule();
 		}
 	}
-	kthread_unuse_mm(dev->mm);
-	return 0;
+
+	complete(worker->exit_done);
+	do_exit(0);
 }
 
 static void vhost_vq_free_iovecs(struct vhost_virtqueue *vq)
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
@@ -579,6 +551,16 @@ static void vhost_detach_mm(struct vhost_dev *dev)
 	dev->mm = NULL;
 }
 
+static void vhost_worker_stop(struct vhost_worker *worker)
+{
+	DECLARE_COMPLETION_ONSTACK(exit_done);
+
+	worker->exit_done = &exit_done;
+	set_bit(VHOST_WORKER_FLAG_STOP, &worker->flags);
+	wake_up_process(worker->task);
+	wait_for_completion(worker->exit_done);
+}
+
 static void vhost_worker_free(struct vhost_dev *dev)
 {
 	struct vhost_worker *worker = dev->worker;
@@ -588,7 +570,7 @@ static void vhost_worker_free(struct vhost_dev *dev)
 
 	dev->worker = NULL;
 	WARN_ON(!llist_empty(&worker->work_list));
-	kthread_stop(worker->task);
+	vhost_worker_stop(worker);
 	kfree(worker);
 }
 
@@ -603,27 +585,24 @@ static int vhost_worker_create(struct vhost_dev *dev)
 		return -ENOMEM;
 
 	dev->worker = worker;
-	worker->dev = dev;
 	worker->kcov_handle = kcov_common_handle();
 	init_llist_head(&worker->work_list);
 
-	task = kthread_create(vhost_worker, worker, "vhost-%d", current->pid);
+	/*
+	 * vhost used to use the kthread API which ignores all signals by
+	 * default and the drivers expect this behavior.
+	 */
+	task = user_worker_create(vhost_worker, worker, NUMA_NO_NODE, CLONE_FS,
+				  USER_WORKER_NO_FILES | USER_WORKER_SIG_IGN);
 	if (IS_ERR(task)) {
 		ret = PTR_ERR(task);
 		goto free_worker;
 	}
 
 	worker->task = task;
-	wake_up_process(task); /* avoid contributing to loadavg */
-
-	ret = vhost_attach_cgroups(dev);
-	if (ret)
-		goto stop_worker;
-
+	user_worker_start(task, "vhost-%d", current->pid);
 	return 0;
 
-stop_worker:
-	kthread_stop(worker->task);
 free_worker:
 	kfree(worker);
 	dev->worker = NULL;
diff --git a/drivers/vhost/vhost.h b/drivers/vhost/vhost.h
index 102ce25e4e13..09748694cb66 100644
--- a/drivers/vhost/vhost.h
+++ b/drivers/vhost/vhost.h
@@ -25,11 +25,16 @@ struct vhost_work {
 	unsigned long		flags;
 };
 
+enum {
+	VHOST_WORKER_FLAG_STOP,
+};
+
 struct vhost_worker {
 	struct task_struct	*task;
+	struct completion	*exit_done;
 	struct llist_head	work_list;
-	struct vhost_dev	*dev;
 	u64			kcov_handle;
+	unsigned long		flags;
 };
 
 /* Poll a file (eventfd or socket) */
-- 
2.25.1

