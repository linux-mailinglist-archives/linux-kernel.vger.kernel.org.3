Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A067D4620FC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 20:49:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbhK2Tw7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 14:52:59 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:48052 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242081AbhK2Tu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 14:50:57 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ATJVED8009101;
        Mon, 29 Nov 2021 19:47:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=Kd0kZIm+qebPR0daitmuUgHhyt3OvaR98NXR2OYgaxM=;
 b=GgihwesIkbJ8SrGIR/k1EmYsGieN6Ntkr7YmSGisrklGhRzcYnF72QHCCSs2Adc99aXy
 LKyzvrTV3NSfIN6BUscqa5KTkmmTcjrtytZt++jZlVK90uCX9k2DNYkGq/dzEhgNhI9H
 /did4qi6ADPtybS9NEGoqKsI+UpbMt9khvfPdNiHVvvULwCmID7VsLz/0NWsBbKKWRA7
 MiHVlq253pJaKtV/evIQoinoFPS4cWxyOr1ijyWSNf7dcv2Ph78pgazgLz39o59Zl35Z
 1uxwklhCu7GOO2m8bR4/BTWqEvmYATVfwOlwzExttIDkIDtWhJizuTupzonL5hOLD6dZ vA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmuc9kt02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 19:47:23 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ATJjb8c181733;
        Mon, 29 Nov 2021 19:47:21 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by aserp3030.oracle.com with ESMTP id 3ckaqdcbmb-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 19:47:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWnWBSDlcHwazskgFq90c7EffUZVhp+9ab9I5Nod7YsK+XGUkwdGMeUvS7IVpAQE67BngrxNLMhIY5mmDRYotEspku4n4HmKAqxpFrNLO88Q+vDCdwgfX5uzSmyKdtwxaarrL2BnkHZrWFDPsGO5XIGhdtGNKxIyC1gjnSkHeQP0Y9nHjtMKzLNL0tjBuqe8aYXvyBlR7N6fcuVmxeUo+KONqYO2cd1Cr5xlZePkHNuVrm3xvM1P1xfPZc+ZLdcykPl5MHBymDwDGPkwEz54rLCsQ0JWmK180yguraOCcqec4O35hMSwV40iZhWL/yijeS9C0yheBMp5EQeW5sndNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kd0kZIm+qebPR0daitmuUgHhyt3OvaR98NXR2OYgaxM=;
 b=FjMAgF2Ym2GopmWKruv5gjxq8VwMWOF9JbyQCNFJE60z1jC0SBfMnKlpJ7WWbYhtfKZSrEpPX5rd4f6Je+EP22nj0yus8bwoBsrT9Ow/0liP1Vr67lwlRnp7e2hgvF80crKrwzgirrp1r64ITtIsDtbsO5UaLJtyY6ATOK/h65alqIawDRJVsJamHvNJ02M3ajjm5vvNkI29iUME5aQCQX99RSoeJv+zDLgBXA0jxHCuZRLOyckdao0yKgD8w43ii0D3zveYP+SM+pLSyRJINFha9aFwdUVOOJ2QVoxjbvx+yYOsfl2vadK+lxdTfLT9AslKpaV9beRU6483Vx9eEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kd0kZIm+qebPR0daitmuUgHhyt3OvaR98NXR2OYgaxM=;
 b=yURPLzjnip1DFqCOBcHLTqI9iW17QUCxkEBE5K3X0gd1cCwvnSHdVofOJyJ+KuLdZbSwevUoT0Z1L5L/4Dh0TfIk6RpuYuH7+mQgbIS9VlWO2b/5zz97g066I80WOug0eqdASeF1E7XZA5z0k6UzEy90NwVSyMbnq0FggN++bqM=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 DM5PR10MB1307.namprd10.prod.outlook.com (2603:10b6:3:e::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.21; Mon, 29 Nov 2021 19:47:19 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::601a:d0f6:b9db:f041%11]) with mapi id 15.20.4734.024; Mon, 29 Nov
 2021 19:47:19 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     geert@linux-m68k.org, vverma@digitalocean.com, hdanton@sina.com,
        hch@infradead.org, stefanha@redhat.com, jasowang@redhat.com,
        mst@redhat.com, sgarzare@redhat.com,
        virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V6 04/10] fork: Add USER_WORKER flag to ignore signals
Date:   Mon, 29 Nov 2021 13:47:01 -0600
Message-Id: <20211129194707.5863-5-michael.christie@oracle.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211129194707.5863-1-michael.christie@oracle.com>
References: <20211129194707.5863-1-michael.christie@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0086.namprd03.prod.outlook.com
 (2603:10b6:610:cc::31) To DM5PR10MB1466.namprd10.prod.outlook.com
 (2603:10b6:3:b::7)
MIME-Version: 1.0
Received: from localhost.localdomain (73.88.28.6) by CH0PR03CA0086.namprd03.prod.outlook.com (2603:10b6:610:cc::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 19:47:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3d4642dc-b0e8-4f86-3cda-08d9b3710de2
X-MS-TrafficTypeDiagnostic: DM5PR10MB1307:
X-Microsoft-Antispam-PRVS: <DM5PR10MB1307DD22AF8EC65EB1AA89B7F1669@DM5PR10MB1307.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:590;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3dCAVeutjp2Xt8CuNbVrzn/vdOyDcijGCUIWjjcoQRVOphFPkP7Ek2gh4Uz7TOpZcxk1f7/t9kwkFBQC00ysLPcvkSDq+t2+OSJRNNEdFRSkjPhQXQ2+VkznZDlgah7Ko9GPkWXvID0JXF6BtlQi1HbBsNDi8AV4Vs9r42wbMfACBgH2jF5M1K+wTYa4QnTmWz3PDJuJAp8S4oKoZeEAgqEa6MkVC54RxOa/rYbToCeTfek/D/Sdgwvc6XqDjCPu6f3p91vz2J7Op4BZblOShbxf1YSGz+JfEX1e31HBB20EZRJEjKPCj/Gx2GFUYnD/C8r1bSEauBhAKwsiHauJIQ6r9xeUJ9CsfB1ZI7XXe0gtlL2tcNLdoEOHB+jmEHi8ZJPxrmbp+/wsC10onJ4mWVU/eqPBw9axnTsCS1TfpwRHektZbLXNiaWOnTaUMLXPkfuiWTd3rkGv5oagSrFh2tnky8zOOoY/XkaOkxyNhIAwQ8s75wEPbIbgLwwp5EkBzr6/uJcARowZhBBxj9ikf/SaiHGjbqB4l4Ok6Bbnoi4F7THFZ4P7oas3dK02KzHkedpm960VN6qvsy5pxTJMkNdzDFqLhYwf8zXfXPrtJuu53vbnxyhoRfJ2GpugG6qbDJA18Dy4w99wzdURkdilmuFjW8k9GTgXbgoeWyN+KjwrdwzcxCxpVJRSeMZQ6mzoGmd5kJVWGCSILYphf9iqJeafXkGXJFxBQNyMwrxmmS0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(36756003)(8936002)(8676002)(38350700002)(86362001)(6512007)(2906002)(54906003)(956004)(52116002)(1076003)(26005)(66556008)(66476007)(186003)(508600001)(5660300002)(921005)(6666004)(2616005)(6486002)(66946007)(38100700002)(316002)(83380400001)(4326008)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3omZs57Avpnm+85sCXjFLstJgMkLqf63TlSsA4Or40X8xZ7Uz0AGBO0uCi+Z?=
 =?us-ascii?Q?/FwRzO+FccnxKKL5UrAG62vTKpTZ0k4AoD9EcYgeFD23eRDsY3r0EDM67ahv?=
 =?us-ascii?Q?wfQ3TbgHVfiatdKW7raa00dcz1slWfTzQl3mko6qGJKOsuRhXowNFd9XxNjM?=
 =?us-ascii?Q?8hLNeo24NeDysZuv5E6vP0Qqd6/dWX6CPigzmU8+lrK4SCs/qRqQAuc8pSs4?=
 =?us-ascii?Q?ipfJP2pgJHRRfwKTbK+QILLHC7I3IqDEsJXRXMeko3hMCHqilNTaSjVwL1F8?=
 =?us-ascii?Q?7ctZDXJz+vI83SLlL6w3kwPjV89O1bfdtPD/9/gYWuJl+JSIEUyfB50hDBQX?=
 =?us-ascii?Q?bscOTZ5S3MAlMovi1j8HVf+Z7DOS8JyEb+hqAcOD67qTbsNVtjyVCM/OzQvA?=
 =?us-ascii?Q?r0INI9AACK6oCSOLr5t9aym3Ekb+dB10NOj+DaJEe2NPrqAegeWwTr49sn9p?=
 =?us-ascii?Q?pA+ud5F1PaKyeK6zvR5iw3Pu8gpZvgK6jWlvzUSSdivPpofE+v2ZlydY8vSS?=
 =?us-ascii?Q?qYsn8QzRP8igDUuiFyY5TGxYZdShnyOCESelFNJ3MsNqLwiVK6JYrTsCBer+?=
 =?us-ascii?Q?A/MW8webbOEQnfjtqZYDpXE5V0BzJweDalxsUSP/i7/IinJC7aQkHe5hUJP+?=
 =?us-ascii?Q?7fecKBV9/HZxB/PzH9BjzrKRozyhfqa5Zy9FpUZbMut8L5kCyDHEWy0Y/Bt+?=
 =?us-ascii?Q?WwXShl+vVCdcUGSbBpFS3WQkIU+zlApCDB4EWGjK/zIEXlslYzjdRpRqL/Fc?=
 =?us-ascii?Q?oU8TSJj+kbqIwDCjo5gYVYUKTYXz6B/93uYTrRFnBtapf7r8mZ3DCqRFnkeN?=
 =?us-ascii?Q?mxDctnsK3nRUGz2LtbWxa3nKhqgPieVawUMv/NoOAx4GUsUx0fmz+avX+Gyo?=
 =?us-ascii?Q?v+vsZ8U2DcHbjm1t8X+B6Q/8a0IuSuq3kLplveaA/oVV5lZ0f4gbFjHhHOcW?=
 =?us-ascii?Q?InMjZ5x2LyX9fi2cqLMbohO+VAg9oZQw+M+rdMyGD1BxXqOywFxRiy2koHbB?=
 =?us-ascii?Q?tpaldEyjiSG7aS8GBRMmbNer87HcAS4aYLsa6k6xU6CiuPkGITEGQNgeo7J0?=
 =?us-ascii?Q?VfnfXwaJyOXtHh2jDfSUib7XtEf7NsD9Jj0siSFXWexA1HFxWyoSnl3gZBf2?=
 =?us-ascii?Q?zjnB5krDeqsSeNfSllAbZgaiaPlaaexe2pajMIVfOOcYeGQv12iBp2AVA3G3?=
 =?us-ascii?Q?5FcXwkNMaEQ4gluJPCFutgims+jCg/yTvkz9fOjJ++XVdSteu0Q5DdnQjQnL?=
 =?us-ascii?Q?w1NwElWPYkdFYR2G11bKS7Wd2fONCWV74X4i14LnhlPq/b4GX+1dboAaMNmi?=
 =?us-ascii?Q?d9XmdsrH7vEAOH/5Hdw1pdFijc6M29BGGGQ/tVRbPQjeciVctPhL50CFSKxC?=
 =?us-ascii?Q?d1LmM9e6zT9Lni6A+SJHRZ/vWzMTvzSIFabWiJHF3aUQrS2Mz35pZJ7r6k7a?=
 =?us-ascii?Q?WCNHty4NV0aMUnCaGRuxow+MlfWO24DkWZOuRehwbMMjr/zDZ95OY1LfVixR?=
 =?us-ascii?Q?IZsbn4SJF/iAjdasLFqU/XIOl3IO8jc5cP4iAWclVyEGL0oa0RT1JyKdwEhF?=
 =?us-ascii?Q?I7mnJNi6enfwwPwVDbeoQTHZ4vHlAKWNqYmpwdiiItDkMrNjeSnVslSmZAj+?=
 =?us-ascii?Q?WwMejokZI8Jtibve3CzWn2iQuSGqGoF0nEWGtCt0R9Cr9xMdQ0/6uby3zJZV?=
 =?us-ascii?Q?nJjpNA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d4642dc-b0e8-4f86-3cda-08d9b3710de2
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 19:47:19.7121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BQOn3NHZ7fCZFmm612IjtEhjxKq+k3s8AO5DZznO9YfbbyVv1kKxoKRrH7rBl4j+OpStIk2iiNgGZupYB0xNyCPEp9ISrPIi0snZxZjhx0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1307
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111290092
X-Proofpoint-GUID: AYVkpCwPD6VBig1QPtzEALt5Z0pUXT8W
X-Proofpoint-ORIG-GUID: AYVkpCwPD6VBig1QPtzEALt5Z0pUXT8W
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Since this is mirroring kthread's sig ignore api introduced in

commit 10ab825bdef8 ("change kernel threads to ignore signals instead of
blocking them")

this patch adds an option flag, USER_WORKER_SIG_IGN, handled in
copy_process() after copy_sighand() and copy_signals() to ease the
transition from kthreads to this new api.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/sched/task.h | 1 +
 kernel/fork.c              | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index e094502b2eea..f8a658700075 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -21,6 +21,7 @@ struct css_set;
 #define USER_WORKER		BIT(0)
 #define USER_WORKER_IO		BIT(1)
 #define USER_WORKER_NO_FILES	BIT(2)
+#define USER_WORKER_SIG_IGN	BIT(3)
 
 struct kernel_clone_args {
 	u64 flags;
diff --git a/kernel/fork.c b/kernel/fork.c
index a47bec00f37c..c9152596a285 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2211,6 +2211,9 @@ static __latent_entropy struct task_struct *copy_process(
 	if (retval)
 		goto bad_fork_cleanup_io;
 
+	if (args->worker_flags & USER_WORKER_SIG_IGN)
+		ignore_signals(p);
+
 	stackleak_task_init(p);
 
 	if (pid != &init_struct_pid) {
-- 
2.25.1

