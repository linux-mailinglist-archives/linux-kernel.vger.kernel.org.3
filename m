Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D99C5462102
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 20:50:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379618AbhK2TxM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:53:12 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:52792 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350851AbhK2TvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:51:00 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATJVDID009070;
        Mon, 29 Nov 2021 19:47:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=BpQTing1krFEgpMmyCq+kgMwk9CU1E55tcmGxV/btdk=;
 b=zRFT0d9VXGw004+SjcpIUlXXXzFf3r+pBxneZo76JxchD53eA/1+cDcvMrtP3n4aZSA6
 yzWCz6RB3dEy23GDZEERcMEqYP6TKucRaWx+2u/87KVTAhJSs0bcL/0bgyz4AJXrtQ8p
 wngae86yp8+T6zwh3xwLnhUGpLP02ByXLyhdflGeeAUa2C8yDK3k4hlmc14iX/LVUdbd
 tR886C1rWOnrSFZ+H3sTfCVBa1RYJuf/502VTGq5BvRjoDl9UJ49cRTyQlF+rpE628ze
 QCP8T6gJaY3YpivGm5dF7o4h/Sohy61uyU2v2uq2RpB6/SJInieAwH2cwwoVyt29+WB3 XQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmuc9kt0c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 19:47:26 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ATJjb8g181733;
        Mon, 29 Nov 2021 19:47:25 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by aserp3030.oracle.com with ESMTP id 3ckaqdcbmb-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 19:47:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kBjCC4egx7dbuvUwjCeliKVY3/Fx+QHCk9N3Zm6eLWflTBHYCh2I9cNfozqvnr125jMobVEcES4WHYWatJtyoET4Gvc2vZhUrokIddNM7SMoTkPvgY9q/2iL/baylO9jyCoXC0SDzUn+qvGchbqnlNkQEAfz/eC3eqe1WyZ0TDWU+52rEnvk0x4sudvoK6DrUaWDzNfq8Xy9DSe7ofm4g+sYY/V7NHidlBY40d6UQYsmbt6uddMNG9k+Q4GCZqypY1JlC4aFfbRavFtNRzVxjsFEWiD9sJg7dqEl7gM4yuvgRXOsvHdBNVUo68aRvs8541xLlfnkBrtjY12gQ9YU6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BpQTing1krFEgpMmyCq+kgMwk9CU1E55tcmGxV/btdk=;
 b=NGmKN30jdn6GzTBuyFoUn9aZ3jFAcLSi7M0osLYcqB5j0YWeKZmeXNbigT73J0shzdnFMR08XKfHp9Eb/JwjrhfPAt7udn+H/BPgVZs3TIaIBiJyZDMbv6eQh65M18sTHrOJZgBCDg1cyVnRjEh/32c4KEc5JxC0s/KG56SIGUE3WHtEKK8SwHqpeWb4sNL0V9tyykeGSEcB6AkQ7Wy7N3kpFcYJGKWT/5PL2FGcmB39r+v/dsjmFbGzX2ltSvzlfi6lXJ0ta5GzOkiTZfei+sQMLx7ywR06r1iVEShL1qJu/CPvy3LVSVb7nySoHQ7PkpB3LUJpS6lrAkwk/n7LUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BpQTing1krFEgpMmyCq+kgMwk9CU1E55tcmGxV/btdk=;
 b=eZYTEAaG8mQuSix4zGWlsRukUys0iHLdKAlGp4fFgpWT7EwGKvhanpH8h9B/18W4UrKq201pOoRNuzB5POO1XW5aBrn05iNUyH9DNbAIzHBsKSOGpeJ8u1t7o1xZXV6y+wcGUZ306e+6iu25DWbVmHzoHjaJ6qUZwlflXnjKW1E=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM5PR10MB1307.namprd10.prod.outlook.com (2603:10b6:3:e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.21; Mon, 29 Nov 2021 19:47:23 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4734.024; Mon, 29 Nov
 2021 19:47:23 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH V6 08/10] fork: remove create_io_thread
Date:   Mon, 29 Nov 2021 13:47:05 -0600
Message-Id: <20211129194707.5863-9-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211129194707.5863-1-michael.christie@oracle.com>
References: <20211129194707.5863-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:610:cc::31) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by CH0PR03CA0086.namprd03.prod.outlook.com (2603:10b6:610:cc::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 19:47:23 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4d1cefde-b06d-4d02-c51d-08d9b371104d
X-MS-TrafficTypeDiagnostic: DM5PR10MB1307:
X-Microsoft-Antispam-PRVS: <DM5PR10MB1307857AD23628611D237E5BF1669@DM5PR10MB1307.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b/5k4rpVX28zHRiszoB0R4stgxjuiU4fASEvrG6HYVxhVSJVELtyEWMucf8OryyMf43b2uZXiuePjqOTUubazUOed9kp2LB7T/w2G9xJI010gT19WLqweBW7M1cIeX1x06ZhpVzZ5doBqINYSUs3roLhSwKYJ9zJUvT2XnPs2kcd5oS8lyw8L7eVYicEaGqCl6Bpz/EhDzEWmK1yj7fktvCZpXyu4JJX4COBahE9zB48f5n2oiUVyzdcc1aAYSe1yh7EqMgPITpeL6VBeYPQRl4WgPOXkHnlp/5ZeqaaE6eRZwZ85cqCtnuCG0tXqwLxFyAo3VRE9DDMpzLkGluxtM4Rhyjmp+2HdpKwEVdn7uzwKu00fArKfke7rg7Gqcp2o+iTM8mKCqANHireSSS3Hwu70yuQcn5RoEhsjLvPkMahJ989y4KBSqHvUMHyow0EdK56LzVHrIP1b0d31sEnLajPapYTlvXagFjWuMpE/b7swzyp2w6gf1KdDgzLeycBMLHJnamkeco1lwMFr/20hJScbDtBVObah3N0rZg148Gc3hxLsXegS/N6yuL2gv1eY+AYsUKSXV+HAm6cBMlxMZrb2J6CQ3vFkWjXalevwnd6xn2Gz5zuNMGFxaic+QMPTpduMqpLGN7mIyVh/V3DlvJH7jmGrfYk1fsHtJEgHeAaCzxDpE7bMQceYd0xRkKwrbqHlSOEiZXgslzI3YEAagRAN+IEPb4yT/1HiQvbh6A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(36756003)(8936002)(8676002)(38350700002)(86362001)(6512007)(2906002)(956004)(52116002)(1076003)(26005)(66556008)(66476007)(186003)(508600001)(5660300002)(921005)(6666004)(2616005)(6486002)(66946007)(107886003)(38100700002)(316002)(83380400001)(4326008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S7RdlFkPqaJ0pt/7Z2LXUhXZLPm821IL7tV9gzaGmgyGhMua0Lch2ewnMZeW?=
 =?us-ascii?Q?awzGgaho2GMADGLBBiw1jGEMWtmmSY/GQdKbkB+cgl7AXCG1FzGIvdW0qO5u?=
 =?us-ascii?Q?Yl5NUiXrqj9b8k07ykRBQxqOt7bxzOJDvgo18BWQq7jMQvnVzoq5hQb+/m+X?=
 =?us-ascii?Q?kuLCJs25qBRx8IRpf1RurhbgXw7JuhLImu1tE7S7itJLBRDAYTiufaIxwtdM?=
 =?us-ascii?Q?S+z0ZdwK5AB20zL3Skl43tz2IeT1IfGZct6wLh948Umzyi5fJD4FO6AFyVgj?=
 =?us-ascii?Q?FX3eXy/qpvp8S2mFUuBqRPJYlurXjh+tRggH3ams2f61HEjP0+PBK5suMseM?=
 =?us-ascii?Q?RLDhz8vDHBdT6vqgT3+SaRMV8p4r1LrP0W74JmR+m/zCtLW1DGpn0qJ/dE64?=
 =?us-ascii?Q?s0WZ2DBNNhE2qqb4IRLd06DLiufUirt2UgNC+Dwyq/6hYQjbRpIp12p2kirV?=
 =?us-ascii?Q?aBWi926X6Wj6E3qqvf8tPsDK0PaLzV5XttReoVZhpoVVDIsi6sgQfLihrfz5?=
 =?us-ascii?Q?sndlApSE8noLkisvFPNyNVrh1B0vvsHsk9nJcuol5MpuIiNj+GxFXQzTVT28?=
 =?us-ascii?Q?RtloChF/97ciJDGYGyJyu1eye10dWfrYRMdqfgJ0uhMjz2CxkEbFo8sQG2G7?=
 =?us-ascii?Q?wNWJUhP8L/YbQF3YT6KsHwHndv9MojTc4Zyf9WRRdY7xqHiWCVI/jHddIz+Y?=
 =?us-ascii?Q?sQCLTtgfzOuwLzKT98Ej2izZGXI+WsbINLidf+OcXn3noF64Kdb5mdrbUCUE?=
 =?us-ascii?Q?cj7FMdu5LC+WtbUS5TZ4opMbkUU/bOuw0SnJ9Ff/pNM8JkH1HMbCtvsEDqEy?=
 =?us-ascii?Q?SEM7pgRnIh86pj675Ui9KlpJnor7wTc76stnymjH21fNduNTDHEJwLKDkjOo?=
 =?us-ascii?Q?0RbzCB7ocogEhhyJFHTl6Sb1sJrqzL47MRMHPH2vjqMNeZUrReGBuzevAKQW?=
 =?us-ascii?Q?enlAJXANq8iVI3Oq0p0cvmHODD/KCX80w11d8CZnTV4LzlE0DtHppcoaK2t1?=
 =?us-ascii?Q?QkC7hdue0FEtTlw7qkMNXHvP4mgtBMwEDeSbG6KputKqLVjT2epCmcSlvGT+?=
 =?us-ascii?Q?uADaDYM+rln7ce8C+0tupvZpJUdqy9hJrZybWqnAF5b4xKu60R5OsfDaO+0Y?=
 =?us-ascii?Q?NH3F5ycSYRiU01XQssfbc8vmX7TAxdLSFD2IiFKsYAVg6btrhl/hbQmuNyCl?=
 =?us-ascii?Q?doBAenJA2adBvMVCN8cjPPZSMbOsGcPPtqeaTHvMKzN8s01fB4z/Nic1xoRt?=
 =?us-ascii?Q?pw/eRzETaNGj9khXMphaf74ptDsxnLnC2FL2am8PkRI2ExMf9huW8++2AeQu?=
 =?us-ascii?Q?gX0VHWtP8qA4Ig9FhfECLNqH9FSMe4ekCq0hmQbmI+irPoWgkkHCDIVXJP/z?=
 =?us-ascii?Q?v+GnAPYAzfOrtk+1HQcmDqzrQpj+YXajk7bPPlOEfo6djXtwxQ6jJM9BQwIl?=
 =?us-ascii?Q?tDyqGVOJKLIWeyEsUiQcaAobedUfuV2lGWroYmc2pPkIL6yanMSmpM6bkt5z?=
 =?us-ascii?Q?6skmwF/ugRyjZkMhhgD6914NMY3L4tcLXxQ0vtWKJu1DASENaj7HeKepnjvD?=
 =?us-ascii?Q?a8oKuvEQ3LdwayDZdHfm5aQ1AKS86UiB0oUEYshPp1N3PDW4JiDRhE2FYxY/?=
 =?us-ascii?Q?+5zN83T6VzIFOLTO7L/PYFKoMzavdRrQtrilWyh4TNc90mrElffNu9LT2XY1?=
 =?us-ascii?Q?eub2rw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1cefde-b06d-4d02-c51d-08d9b371104d
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 19:47:23.8243
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zl6E6trcTe568lUTtqBZtwr0zB7LZpDXxdRC4OHrYYVWklqDz59OoA+kiI3wiwc//GQXReNa7EfebE5Rsc5oYIuqE83q9Ut2Bum/pp/u8LM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1307
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111290092
X-Proofpoint-GUID: ED0leY_DqPvA8pui8WLlEvsF0Qfq0_Lr
X-Proofpoint-ORIG-GUID: ED0leY_DqPvA8pui8WLlEvsF0Qfq0_Lr
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

create_io_thread is not used anymore so remove it.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 include/linux/sched/task.h |  1 -
 kernel/fork.c              | 22 ----------------------
 2 files changed, 23 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index ecb21c0d95ce..cef69ce64e6f 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -89,7 +89,6 @@ extern void exit_files(struct task_struct *);
 extern void exit_itimers(struct signal_struct *);
 
 extern pid_t kernel_clone(struct kernel_clone_args *kargs);
-struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node);
 struct task_struct *fork_idle(int);
 struct mm_struct *copy_init_mm(void);
 extern pid_t kernel_thread(int (*fn)(void *), void *arg, unsigned long flags);
diff --git a/kernel/fork.c b/kernel/fork.c
index e72239ae1e08..3d4586502190 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2521,28 +2521,6 @@ struct mm_struct *copy_init_mm(void)
 	return dup_mm(NULL, &init_mm);
 }
 
-/*
- * This is like kernel_clone(), but shaved down and tailored to just
- * creating io_uring workers. It returns a created task, or an error pointer.
- * The returned task is inactive, and the caller must fire it up through
- * wake_up_new_task(p). All signals are blocked in the created task.
- */
-struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
-{
-	unsigned long flags = CLONE_FS|CLONE_FILES|CLONE_SIGHAND|CLONE_THREAD|
-				CLONE_IO;
-	struct kernel_clone_args args = {
-		.flags		= ((lower_32_bits(flags) | CLONE_VM |
-				    CLONE_UNTRACED) & ~CSIGNAL),
-		.exit_signal	= (lower_32_bits(flags) & CSIGNAL),
-		.stack		= (unsigned long)fn,
-		.stack_size	= (unsigned long)arg,
-		.worker_flags	= USER_WORKER | USER_WORKER_IO,
-	};
-
-	return copy_process(NULL, 0, node, &args);
-}
-
 static bool user_worker_flags_valid(struct kernel_clone_args *kargs)
 {
 	/* Verify that no unknown flags are passed along. */
-- 
2.25.1

