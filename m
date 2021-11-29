Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 645C84620FE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 20:49:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379081AbhK2TxF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:53:05 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:47946 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236265AbhK2Tu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:50:57 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATJVDU4009072;
        Mon, 29 Nov 2021 19:47:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=R8RBPPfhwxXBMtuh/f9DRs0awov8ZmZkUHd0ZAOhuRg=;
 b=Cfs+gEDXbV3AMrzu1kfPguq8UT3oTU6842JTBn2Q2MiC4Xy+dHwi4SHUNuvS6rBTMCPO
 EfwGVFQ6DRLmG6odZSraCsuvkW+U1OdzyPejZRBInYiVR91DOwoeeWj6yK6iLEiHiy1S
 kl2R3MclLN1H3dvNJFx+Ij99gAzK1l0SEWVA+rltqs3sRq1ZPvg8+KTo/FMLUIPsHA7w
 x5CQ9ptaJ/jQ5YBOtrq5TAM0U2QUVH/c63MrooI+N7IdY/XN6llar93IUH7tj18Y5sIG
 CjlVVxeD57w54brYkV6GWLXNrT/kkeHoSuhNlTLjZP4VEBGghzq+UekdIm7XAAMPTe8Z /A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmuc9ksyq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 19:47:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ATJjb8Z181733;
        Mon, 29 Nov 2021 19:47:19 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by aserp3030.oracle.com with ESMTP id 3ckaqdcbmb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 19:47:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B8feDG2IFOK0bkQGXazeQz6wvX54dB4WNoIl40V/qkMLgP2QUiQCdExTCvewu/4XxOgTkU+gUy5v51Vhu2jzYwuOJ1JZiINsZt/496gNTRhwT1Yjg9bRlVejbCn1iVJ/GtNkJVOxgDYZKmWMrhoNQ2WtetCaW1gfc+p9Q+DIQZE5lwld2McRCBwY2TMJJCH/6oT9SSdmWshTyUzanxrYWm2dqpCpwIDG6vp3tfFd7Zu1z7BmhoDEv9hcxs1P18//Qt2PGOOQP6XnWHhao2Sk6eRzHZ0Gf1M7LF5pPfgj2jEMuIDj7kErJAJ4XLeTVbQgHB7mwMAQ8DKmekwnZmfKNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R8RBPPfhwxXBMtuh/f9DRs0awov8ZmZkUHd0ZAOhuRg=;
 b=Vsj3iTb2mcfs5AIkgl0SNDAwkj1VNGDnNzWPZ5Pfr/cywHQ5KvhsiEIi5EOnYnKdoN1Fv9K1cbPb69xes+TGnUGfBTwpvV3DaLBYQN1Q8nK+jJGtbjZUBmI9hu4flMScZy2zqACdLzUWwHNuTe06cmRvMZHZEfONUgrI6wUyvKYGr6l3O3TF8RkeLc8/6S5BlowmmUTnPZd9sClpKAkVoOfdHFxyEQuPunA4qEt3fddmMttn8iw5t0UB+/lkDbSXCwH5rTHrIiGC42ShbQIyPpRwQb27LiTG4OYJjkWg4YY7mmEaqDr3PJkSzsONJFRWcyoooaVsYU10VpSY8vPZsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R8RBPPfhwxXBMtuh/f9DRs0awov8ZmZkUHd0ZAOhuRg=;
 b=ET/E0MgApx4cD9Vg6JnUq6pGOfHiTX8Dkz0wKs8W06T1VfVadTj66IbOfjXGm4nYPWS5PU2QM6CNY6GrIhaUBOgYaDA6ewML/6DIFEHwqx2Rsfn3VVPOaDBlr5b6DY6ETAHda+5ADhnOvmdoaAM9LhnYFIvNLckokrgTNYJ+pxc=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM5PR10MB1307.namprd10.prod.outlook.com (2603:10b6:3:e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.21; Mon, 29 Nov 2021 19:47:16 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4734.024; Mon, 29 Nov
 2021 19:47:16 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V6 01/10] fork: Make IO worker options flag based
Date:   Mon, 29 Nov 2021 13:46:58 -0600
Message-Id: <20211129194707.5863-2-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211129194707.5863-1-michael.christie@oracle.com>
References: <20211129194707.5863-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:610:cc::31) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by CH0PR03CA0086.namprd03.prod.outlook.com (2603:10b6:610:cc::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 19:47:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4aa25c57-90f8-4a60-e285-08d9b3710c12
X-MS-TrafficTypeDiagnostic: DM5PR10MB1307:
X-Microsoft-Antispam-PRVS: <DM5PR10MB1307680018F4D5C0D1787891F1669@DM5PR10MB1307.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1201;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zbRn1dOPIoMrDZpMbO8SxDl/wIyib5/kDlH5H9OR4LgYUsaUpt72P6r8HqlJGMlKHc48aa6EaazyU7yV5rW2+H5eXauXnN5jxMutl974btvZxALJGWcS5aL7kERWEpXfyHHuBfaS40zt8tW+6Vs6p/H/lhPQeGTmyyk4YSkgwJKRRw83fBRznyBpABBaipB//IiCcRx6M9ZjjirGSg/FcwoAEfJOgr044YmQSxRbis7COIlVCeB17xAl6strg5baawTQB7ODcSwMswFByuJU1gy/U0ZO1+2VyTfojc0vHmirzbCHIKYOTekWc0F/Tsvr+4isPgqoM+c90YxaNdr9svVOgrsB3F5Vit7NOI8H4Bag9xTK4xH2d1v0bzYKywQcxdzqdnV77L0wj0ToWxrFTB9p6nTsKwucvSbrDdTLplCpvKjP4jDeg54UreKXuEe3kWtrBhSOO0uLorhsKFyK6OOGC2t9djpvdo6whsbJWDKpo3t/rKBO5hW8saLrkjyjPaVvJ/4jJICPTgIDulHgpCAS5d2osLVLjS/wsI0X04TPGobFDiB3yktcRpyM/bJu+BqD+uAvvTr3dZJ20XpCG9ERBPqbn41FFE8qxKSNymAhT307gTdlXTEBxQPy4Pi4zk238/1w+JifluTqLxA3dfvC1MY8nBKYAIJAw1FbXOph/VhZyzmfRc8Po3WwuZWLfxsRgB9FUMFiKTR7R3Kflyoq9Y32PzSNvbFU+Sih+lA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(36756003)(8936002)(8676002)(38350700002)(86362001)(6512007)(2906002)(54906003)(956004)(52116002)(1076003)(26005)(66556008)(66476007)(186003)(508600001)(5660300002)(921005)(6666004)(2616005)(6486002)(66946007)(38100700002)(316002)(83380400001)(4326008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l3NdoDiimHIeqA6JVtLKuBSaEwIrOR+G03DSdxdIEz/6VM8njrRNKdlgPRcs?=
 =?us-ascii?Q?cMRjhKyIb+SMMO++Pkp/b215xRW6rm4Il/Vno0s9U1tfPIyLJ/cxz7NDbAnW?=
 =?us-ascii?Q?WCFR+tf3h8jrCdVsWRBI8PpjgvGq0neXLuuHg5tpV/raw2saCkDcxEiWh8AN?=
 =?us-ascii?Q?ufhJG6EddY8FukhAEGaHQjt2OpwHiFSfmm7MxdR4NlL7FMsFGTdeZhFjORlU?=
 =?us-ascii?Q?sr4rioY0WVeQYBfV4SsKdVH+tsRTHjhiAZ1uHFfNRq2wkcisop2ACk3Q7SmI?=
 =?us-ascii?Q?KuPrv1wy6RG1f2yDTGiFidW+H1JjIw7bmAsFob7ku6dDj+DKTiFQcx9Ba5Tc?=
 =?us-ascii?Q?dBWc9YPtEXCVxI2LD8ribNfuBeLFAWboTmNbVPDPvu1nZXYmm7Fl6JUvwklw?=
 =?us-ascii?Q?mIVM4tEOlMs/tdZ3eM1IjU7HMATrycTyZJqik6Mpl9A8NQ3ybEHKFq5TzQlc?=
 =?us-ascii?Q?XUb8Efkf2awIzT/DlPVrCyZgmhjtHAp5BqbdkPrJt2lYGkp3Wldn2kNYSM2b?=
 =?us-ascii?Q?cfV1oNK6YzE3RNxH+EWkFMTZ0jhWWGJ/ppC77ytLIUYF8a1/pzLehubZ/MqT?=
 =?us-ascii?Q?la4MBbEZYW51U5xpZihjxZbEuaicJzHdPPz8kxNPDT5L1p0WaFOtpm0U9Ngt?=
 =?us-ascii?Q?y2md7amDqfRVoeDmfbCzq+z3ntDY0/8qdBPqUF7/OjQkW/tEYt54INtrYjOJ?=
 =?us-ascii?Q?OWko5ER0ScTcYgQvVyWiJx+rfise/xpc6Qf/JnI+shSp0xPtUEMI7CXMujJH?=
 =?us-ascii?Q?VhfUEFoXY8NaFDofmT+MGgrAMu60RBF7t6qURDtOQOYlm844G9VAOrNcFkEE?=
 =?us-ascii?Q?fH/PSgDQTgEJMYpruk7egeZt/9EyI3ujVZVWENvhzEa5OJ3PnnERA1o2CcNL?=
 =?us-ascii?Q?1bzA34cXNKlfAp68JfJl/WBxXWrF4t+DbLroDaBMQFs88B1176/dMC9sJxxa?=
 =?us-ascii?Q?ooLAPswaxThniKvb/ggYRONdbgZGXMieAHrlMAucqALB8lgit9ULVp70PHuY?=
 =?us-ascii?Q?W4v6RCJEnn4GAXXW/zvn6Tw5HwYxaarUhwW2KQUOaGE3RsyPwP7Ebau4ZUr3?=
 =?us-ascii?Q?FkTfMpSDsKciq2nph5bgP56cKQMl5hlMdNqp3ADc+s8SxvRuBG3a6H3SSC8Q?=
 =?us-ascii?Q?fHCKS9iIqDJi3ziZgh9EPtss3ZzZSjdTbxQ0nl5/xD9DwdmTfQXYwmTizhDv?=
 =?us-ascii?Q?1Uf8/ciJYQIqE3Ro+J7lWvtmpaqdSH7x9sJTY9NpxveZToEdyq1oL/ptyl7K?=
 =?us-ascii?Q?LB8xawPuAJkmpXEbWKW88bHAiKk62r6zu55yuHERC3eQ6oDe4MNEqJ16aExA?=
 =?us-ascii?Q?RTAHJZm6USamv8tmKNartVvygxCYj1e3wmU60iSKqAL4SAtyQfO63+BBLAzQ?=
 =?us-ascii?Q?xV+9elGXDBvz7wS4GElJ6ysysXfOog4uiZdJHSDX6barWPumg8zT4RIShOEL?=
 =?us-ascii?Q?bQiEBrxIYVMYey3qLZyCBDlUP45I/my41hLRapgjO7OAXwjiz+ySNfce3uAo?=
 =?us-ascii?Q?oYGDmlSxTCEoifBRmxprPLf6wCORBfpaMnGWSLgbTNRkdczXbrESJ99pm84z?=
 =?us-ascii?Q?qGBVUr+tPpVTbZZnEhsVMclGftI1dVg6zyUjwOsb9L97878i1yk4WaR0I6tY?=
 =?us-ascii?Q?eA8d6oEHRkVL418WDvZBON2oDmkPv4RqeTWoZEhkdi79mr+iS4+KnnPrxRGE?=
 =?us-ascii?Q?is/F8w=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa25c57-90f8-4a60-e285-08d9b3710c12
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 19:47:16.6315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bfQ9gDJROhw5BqX2ONOZ+yV4GLhu0WcAlRx4/yYolmMuxrZoOLunP043sWrx4ZNUBJg6q/1UNz1kU6z0THScWQjsA9EGVbeN1Ji9pq0MEIo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1307
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111290092
X-Proofpoint-GUID: HCMBK9iL5YiZvYee12F0HTBoRfc8GeK7
X-Proofpoint-ORIG-GUID: HCMBK9iL5YiZvYee12F0HTBoRfc8GeK7
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a couple new options to kernel_clone_args for IO thread
like/related users. Instead of adding new fields to kernel_clone_args for
each option, this moves us to a flags based approach by first converting
io_thread.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Suggested-by: Christian Brauner <christian.brauner@ubuntu.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/sched/task.h | 4 +++-
 kernel/fork.c              | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 058d7f371e25..65d5ec3a8a04 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -18,8 +18,11 @@ struct css_set;
 /* All the bits taken by the old clone syscall. */
 #define CLONE_LEGACY_FLAGS 0xffffffffULL
 
+#define USER_WORKER_IO		BIT(0)
+
 struct kernel_clone_args {
 	u64 flags;
+	u32 worker_flags;
 	int __user *pidfd;
 	int __user *child_tid;
 	int __user *parent_tid;
@@ -31,7 +34,6 @@ struct kernel_clone_args {
 	/* Number of elements in *set_tid */
 	size_t set_tid_size;
 	int cgroup;
-	int io_thread;
 	struct cgroup *cgrp;
 	struct css_set *cset;
 };
diff --git a/kernel/fork.c b/kernel/fork.c
index 3244cc56b697..6effd839d566 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2023,7 +2023,7 @@ static __latent_entropy struct task_struct *copy_process(
 	p = dup_task_struct(current, node);
 	if (!p)
 		goto fork_out;
-	if (args->io_thread) {
+	if (args->worker_flags & USER_WORKER_IO) {
 		/*
 		 * Mark us an IO worker, and block any signal that isn't
 		 * fatal or STOP
@@ -2524,7 +2524,7 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 		.exit_signal	= (lower_32_bits(flags) & CSIGNAL),
 		.stack		= (unsigned long)fn,
 		.stack_size	= (unsigned long)arg,
-		.io_thread	= 1,
+		.worker_flags	= USER_WORKER_IO,
 	};
 
 	return copy_process(NULL, 0, node, &args);
-- 
2.25.1

