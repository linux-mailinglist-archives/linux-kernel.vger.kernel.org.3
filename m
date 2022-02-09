Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10734B0149
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 00:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbiBIXbD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 18:31:03 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230053AbiBIXaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 18:30:18 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3D90E05ADC0
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 15:30:18 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219KAjBl027666;
        Wed, 9 Feb 2022 23:30:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=PXXdV0JicyRwxDzTfgVc9CnWFDR1h6e3mgSqpxLKbUs=;
 b=di8OuzAXxtJZazxtMZ5SbNRmE9qYiwwgFB6rkEE7qRyifJ11sGgyPSS6GSI6VbWRFSqR
 39puxRp6bRpxKL10aAgOJs9AZUOsMg8M+wIYBU/5CiY+AzGrgv6JYlRKEdWxqUxQDKyX
 9mD4oZu8c1axTI5nH9zaOHDuTJvHX5YcEkihMCVT0ELjktg9yPqw4h2AJN+jOgnVigJy
 nwy/SslVid5rIMiRD3A7cUa+PvnYmWDyeL2990mIqe0WePRmLR/lr6kOEOvuR98WddBh
 dpiHrE8ytlCsAp7C03yMykFn9XzcHQFPtl/kTxw6UrwDYXuAeNQQHGQhNGEo44tojM54 1Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3hdsx383-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 23:29:59 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 219NFrFc117827;
        Wed, 9 Feb 2022 23:29:58 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2170.outbound.protection.outlook.com [104.47.73.170])
        by userp3030.oracle.com with ESMTP id 3e1ec3m196-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 23:29:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VzI8jc8suHAIsELU0vZc3cHrClwNid/Q45PXBGaYSHsAgmsxo7el3J2lzQ4XPT8aBVhS/Gn73ewxyFJIj0kCDjxj8a9FVletUEfd9Q0eFKumMchNPpcnSyd+C6qu1qvg3eQ1PkwoPxO5+CdwM7Bu38V7Nzx93Cf+cuRgK7sFPhEawnbcHN6hW3g7GIiaSZx8bl8ttI/yUuMZrUqv0lLCPTTLrH3TIGVgXEuXORa8vgVQA4Ahtn6dDLi39Bhya+I/qd8O302EtjFi32GZ4UFqeyD7OHQ0JRl5OL/1MKm+KayBr9EWd/brRdcnkGnX6nSdi2Ryv3AJJ7OAPjePLmYnqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PXXdV0JicyRwxDzTfgVc9CnWFDR1h6e3mgSqpxLKbUs=;
 b=ga+2hVyy7Ay3frl6sIaUq91qZplLEPHiUoKebN44psVgsvpx22kHdv1U6xId1GuK0l6C/iMVETew93zm1b0We0uKzd+9JY8k2jQ/iIbT50KPbTTSEQxIaqkRG/M92m/2K/IjRCLWEsJ6jyJbcHAFOFFYT3MmMWL9RssjCDbst8kx2mkfPo808gQUdHCD+UkCalKAVUwHxhQdN1AIOJ+OOBDXnjl/8SCfZYl+L0o/VXaUZKM7SO5GB4KjdQlHcOxaNBoizClzAmpX0zQTh5WULcAQ5vCPAPE5P6OkTGbDh29DNWwLPsThZ4S7lXMMujl58Kewygv1L+3HY0axYKY50Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PXXdV0JicyRwxDzTfgVc9CnWFDR1h6e3mgSqpxLKbUs=;
 b=curc3ZGjSjC7bYFI+ejp7gnEzR6zWVilaThwHJzPBuG/A9kJ4LO2ANUdmqGIdWpuS3DJfTJ31wAPKE/TIQ33ZxCfMDG6xwaYOju/HoJaEsDrFWziI/kVit3CuvdQph5bmo8hj9AW+lx5JnlQ32YkXIqrp/ppmIh1HRZDOrJ5JTs=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 SN6PR10MB3007.namprd10.prod.outlook.com (2603:10b6:805:d9::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.17; Wed, 9 Feb 2022 23:29:55 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3448:8685:9668:b4d5]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3448:8685:9668:b4d5%5]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 23:29:55 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     geert@linux-m68k.org, hdanton@sina.com, hch@infradead.org,
        stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH V8 8/8] vhost: use vhost_tasks for worker threads
Date:   Wed,  9 Feb 2022 17:29:39 -0600
Message-Id: <20220209232939.9169-9-michael.christie@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 178ea36a-d7a1-4b09-257f-08d9ec2413ff
X-MS-TrafficTypeDiagnostic: SN6PR10MB3007:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB3007EB7F27687C6B9B9BD694F12E9@SN6PR10MB3007.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:334;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ze/CADhCRIDR/3wA8YTBPcrcsY0wjlS1MniA4GUxjZCkfdcmxUaN7EE0uc5Z62MfJDMhU+JZpB/M3Grq/pn7fvZxepIVyvPj2q66EFdxKrfqcbObyverMEu0KE2hqTTm+YgrNrij1dClWfxhiyrJsYUeUlkoOyxv6VU/Ogbg2o1YWj3AczCZieSZKCzcJhgl0xHUebIOfrKOFo9tvPhp1ntHKx77uTaI0f44WKtCSZW26YoLRkt7Sq9rfHqh5fv1Ny+XeExQEkhJ8dlojGnyllZ8qbXsGz2R0tJfbnrq1yRw+hjjNsiNizBU2tC8QqudJ92QRuVjJC0gpB8/y7mR8xivt5k/XxbmIHeUfukTanAZZevWwjuVN13T6unnZQ3vgKKKBuwZAKHgjto+1cjsUKgZg09QSBEbZ8qiC+BzB8v9XmATv5logJENasgFZcoUkw8lB4Lro70YBO6bFv8LL0KtvSAfLfU0mKKRpkqzyXGckE1H0Zzl2W0zc4V9C9zKsTBF8CAu8DyTOn1Y5QyCAFUXU0/qKk6Yj2pGQneS5TCROJbyKPoXs1EzYCIbv1AnRkqrTPNPG9gqR8bmAh69aQrMm3TK/v4aHIuHWfyS2XTXY72hQLKVxqh43eyLodK23gahEk55GD1F3Q+Oj9nt89P9ufM8AgS60r+7ULeb1gQkqi2LEzC/B+KnXo31hj65teAKPZPWCwkWqEzFkysSrlFTTbEpeD9tIzy6IIszYG8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(921005)(86362001)(508600001)(2616005)(107886003)(1076003)(2906002)(36756003)(26005)(186003)(83380400001)(6486002)(6506007)(8936002)(52116002)(38350700002)(38100700002)(66476007)(66556008)(66946007)(4326008)(8676002)(7416002)(6666004)(5660300002)(316002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w4umnrYY5aK0tMJlylJths4HQY49UEg5sPovCa+oDHPk8xTU49RbTadNlEA6?=
 =?us-ascii?Q?1ghk4r0kCTbyVET8zlFZLsCY0TEc3lub6vR9/K2jWD+5oypXZHLcbpbaBrk/?=
 =?us-ascii?Q?nhLvj96FcxM1p/77LsdVEQeQS0okxhpsqdd2AVCWcx6BvkJ9fZyZGbBYIj20?=
 =?us-ascii?Q?UJFxFX4K+qSCmltAjIjHUrrxwtpIQkSulxQWWLir+d6k/zHIQ6b3Hj5+6taH?=
 =?us-ascii?Q?Kq9RmCTi6MxzvcvcvBM6Ka98iTgwIlPHb5LLrNrxGhA2aqiOL6LyDttpih4C?=
 =?us-ascii?Q?bi2wNvBCkXWVzrtzauLE30vZyHBdWfysKjw5c2pSVs9lsN2GyEpm4rD/iSXj?=
 =?us-ascii?Q?HwdeXT4IrF8qY9OUl01AFPSk2UkjjGgpjcKUfdXT/n8orlGsE0MELhlRwOjJ?=
 =?us-ascii?Q?s35VUQcvYtFmU5882LvvieXaon66yezAvVsGdZKJYTtKD74nk5SAU0DpwEjA?=
 =?us-ascii?Q?eyCQM8OQYF+Ht8J7rojGYsIxDIi2UaGiZCMujM8rMZN6CiuILK5i2R8jGP/o?=
 =?us-ascii?Q?/pUY8u7Vc7r/GifG7MaXTsgi06gQbU0TSrzQNaB5LNmkllR8nbtUSoKvHqnI?=
 =?us-ascii?Q?XRscjLhFaLG+XmBrXDsWWz4hwuIPJXNsnRyl3FS3qYZa7nK3vDtZAJdDAsSY?=
 =?us-ascii?Q?U1XN9VXLEcTUHfzYy97B/maD79Z/566gmvxarHc4cdr/25pst8GfH7Izv1Mm?=
 =?us-ascii?Q?dVVDh1uKCxpFVFRaxBJtX/viHBed28he/k7p9hKEbOhct2sEXo4ejoQ4bQQi?=
 =?us-ascii?Q?FG+U0tVBuTC1tU/g+9FUa170T4wCzIjce4eddjCv26QjK7Kqfidn7AasUXfu?=
 =?us-ascii?Q?yWbjLe0sCjX/hn7duaK7P74AFpzyl8YCPAn7uGNQNfP4ZgtAgkx/CSHsw0eg?=
 =?us-ascii?Q?iuMk+9GRNIFxVryWHLGNJOXIaITqdRggOFzJEg1TpKCM0vntKj6Dp7r23rV6?=
 =?us-ascii?Q?Bfj3lEsXNjG6ObnT6jgBvoTsm4JZq2iiG0qawvWZR/qFmhY+WFX5En1hTPku?=
 =?us-ascii?Q?36FK0frkgoyX/+rjTuGMV7UhIEDVKTle2m0Ke+eflncVjuzi/VKXoBmzlNiu?=
 =?us-ascii?Q?ZZgLbvpKu8YiMdon3kLpJZjts3unuH/WR/rztt6ZY5xzTjgpY7f/Ggf6QrZr?=
 =?us-ascii?Q?TaGTuOyZkZEQrOFmqqNBAGmnOp3SIDU+Eq6yLptVkxHI4UaYnWuIAiNuTVhg?=
 =?us-ascii?Q?CZYI7+yIWg3WWI+7Z1BwmUqes8zYhKmV0mXvjGsc3Hs0pG3H/lzwZnpzdt02?=
 =?us-ascii?Q?jQ3sg9F7JPE4KMR3VNtLMhroQ+KaKxe3zONgHOWg7Snpkn07+RoMAOEknOWy?=
 =?us-ascii?Q?CYS6NPjwztVR4hHRYOgoA1xsA3AlHCi7aoFG+GAX8+xpAcNVO0k2+oqlPn8S?=
 =?us-ascii?Q?0MdRvuyYcO6l42pcqUbTmyTcQz0y7rd1Hpw/VSvn/FcKdvX68M9j/MCYGnRT?=
 =?us-ascii?Q?aar0zIch1lPyMum8eiI/gjaVToC5Bqe3GzbjFg0j0R9NI2QNGKmQmdKLizYt?=
 =?us-ascii?Q?JvClkXtf6ACLmwAYJKrGKgWFzJ6CYZNttWW0NEplfFgWPiPvmYgHKI5PuWHs?=
 =?us-ascii?Q?rvFreB/pgUsq9TX/i4xY/Llbybz8TrM4d9Gqf+5fwAEAAI1s80ZfYxL63SMQ?=
 =?us-ascii?Q?kH+t+mUVEQHiH0TFs7ttW31ELP2od6LMi6gx1KW8mK3bDEqtRd6v9YFIDeAl?=
 =?us-ascii?Q?fYEpBA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 178ea36a-d7a1-4b09-257f-08d9ec2413ff
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 23:29:54.9508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gjjt7WWShifTxgDos3Dp6lKXNR6xO8xANeFCeOplCFV9SS8jqeP8Jv8jeEd4c7jc5EcdSOGIIXlDAjU+8jHYv8SuaBiZeiGBUKZ2ZbX/oQo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3007
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090122
X-Proofpoint-GUID: p-9BZ38JFy1X6KuprSzKDsypVoteTPH3
X-Proofpoint-ORIG-GUID: p-9BZ38JFy1X6KuprSzKDsypVoteTPH3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

