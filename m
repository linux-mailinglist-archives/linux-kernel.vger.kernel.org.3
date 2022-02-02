Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E518C4A79F4
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 22:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347378AbiBBVCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 16:02:41 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:31794 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347357AbiBBVCj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:02:39 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212KwhBJ023474;
        Wed, 2 Feb 2022 21:02:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=vikfQxERUFBfKJD8ex3HEUPJE9sExSR4JsWfRTsN1EE=;
 b=GoZKA4AvSQaiPF+t7H/nOZPO6UCvm/zIBj1/C+So0CFp8l4evuCXuEm1hG9CW+2AvtGj
 lbAaWdG8+oHWbPKcJnrQjb40Zbq0xreCECDCdcRZxVkq3mfNWlt4hikJ00n16N1RUnDH
 vACI7c847zmI71LomU0rPlyjdekwn/u+lkTOrLkN5qofeCyGSHnMfppr30Wo0N2s1k0L
 k18+VSLmeJA02IOjo6xzm0+WJ1Lxkb5BJxDsS5NwItxFWotZXKevwHGKZddau61UCKgV
 EKQTTEjFoCYu6/vpCy3VLkiNdHqQYbzmZlDO2l06dNzzH7gWrcw8z5K6CONxUT44pUpw GQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxnk2pxcj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 21:02:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 212L1SZr079411;
        Wed, 2 Feb 2022 21:02:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by userp3030.oracle.com with ESMTP id 3dvtq3h0e8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 21:02:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f3B2ww9mLh4cCxPr8BcVyhRbHeaWjYazUsLkDmeycX+CbuYfdZ6bnaIcbqFO0aWTmEBM2EWemyeGB91puKkHKpv7KW9VJaUngaGAYCzzCddzuv2tH07zPTUoX3cSb2fd8JXV5vX23BNEsGCDxpVVVZgmrrYasF1iB/rnH1X61AariOOvuSs/bzSO0kosrI+OFESpLfHmXx12swNBW1QHPuW6hF8uZFSj6514Hg3ljWx2vNrLVp9ur1KnhIBoDeZzsHZD/i4ATgoS+snQNXX6HkIxK5vc42vYdrdOVeO6AaCAnojcHzNfUOoDqIRzvq6dvwu9AzUYIPguJrBAfXyS3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vikfQxERUFBfKJD8ex3HEUPJE9sExSR4JsWfRTsN1EE=;
 b=jq+eQQ3EhfbKJID36Qwe5LVcnHJNomJKGn13rUhCour6rg57zA3K8lnCQv1NJAignqolrA+Ib5gIeGhduDR/MNF4sI909JBg+tJZgAhz4SrK2yQDEHGQ+A7EGQdadY1PoKgou+T1CfGidJ5MTaTkN7K9zTaMMHVAoyo1ceT0Gw2WgaTV4D1tq2XiDO0sQpx9N/Lrewz0klfpkQ9TAbAdhr0cvQpUoOri9OACRmHWpOBod6nG/oAJGDaUPvx9xJZfMp2/ue7QO6jUEdUSVD86+jTKQRcxhODz/szKIq7VMD1sE4mmkt2bKq2lupcBzdav2Gzec5qtS030pSlpKdB5hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vikfQxERUFBfKJD8ex3HEUPJE9sExSR4JsWfRTsN1EE=;
 b=rh3ILSZIF/ef+zRRUFl7V17Y7A8dqRMWbEvU9Iud2p8ZkMRcKTp2K/CAGDfJt0IdbyYSqsA9DDt0NJTyvyuWO/ZOfg/LBc6n7gArqqVXJASmYWFUpxA/jgkN8Rg6yuQOp3DHmYEI8FLG1pGLq0BF58o3TZkdwykGE7FH7o0urXs=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 MN2PR10MB4014.namprd10.prod.outlook.com (2603:10b6:208:182::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Wed, 2 Feb
 2022 21:02:10 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::21b5:910:b965:9e6c]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::21b5:910:b965:9e6c%6]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 21:02:10 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     geert@linux-m68k.org, hdanton@sina.com, hch@infradead.org,
        stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 1/8] fork: Make IO worker options flag based
Date:   Wed,  2 Feb 2022 15:01:53 -0600
Message-Id: <20220202210200.5235-2-michael.christie@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4c2f11ff-ff74-4db6-f491-08d9e68f4704
X-MS-TrafficTypeDiagnostic: MN2PR10MB4014:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB40141E3565F49A0395BA04ACF1279@MN2PR10MB4014.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CQlIKMR2rCF+Nzt2vjnbKmpqvVrjEsZ66LNBC9Aa3ukFimGdXrqHDSxADMQFF+GjQp/iWAm6vzAWcfCDwkf8k94IfcOD9KQFPoNJ+OZL6oUtXbqug9G4Fa1vpY4Or8VWM8y6VhoZfUfddSLT+9dm5Dc03d7r/n36OPVrArfp3m+d4KUJMQ0TGIHC+I8Wygr7V+/NTc+QCp9do6Alaa/ItmdQKyKvatXz90mYIt+/g931GW4hFe7U/yb7c78JiQidX28K4l3n3/cnwNwaPwHy1g7Up7eTYN1anjjv433cUehZiB6a+4C7XAMOgHedl9NDUT+bOW1VZFyoFnXAbt47TNVzPgSdEoq1zsDP/+vhr2Lh03OXH38j41x6mJsCdlIUtxX7+uTu+qavDp2G3yomJNGE43W15Acf1Io2BjaZv7PdE4mq5scKt/gjQeMSXEJwby4T6xaApAI+9a9zncD+SCQAWydMqmXebw7zDxPBMPIBT6IuS6LSDPqdit7WyYu5faf7xv3qwEUynEd713TPRJCifZzyN/Bvgzc4AXbmNuYFut+M9TOmogWtZJPm7++tdkNZSEYIMz2S3W/0abt07CGnWNT4PXbjSFkWCtG4G7YvbVLDm+emOPlozPo6sg48P4kJLzsq3plpBLjMKw3+5qDrgYxYA6jQV4Iryqhm/2bxUbHl4eNlqKoEhHYIDQ1Wv0wDvh3ji6JzuRHJK35+XvyutUv7kHdom42Xr1CHItY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(6666004)(2906002)(316002)(38100700002)(1076003)(54906003)(38350700002)(5660300002)(186003)(26005)(2616005)(66556008)(4326008)(66476007)(7416002)(6506007)(66946007)(8676002)(52116002)(921005)(6486002)(8936002)(508600001)(6512007)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h3/s5h7ZJHIy3QU+SGkeACYjYY0Gzy57WbkROoP5E6iIKbZAjJ79F3fVLGu4?=
 =?us-ascii?Q?4p3b4BlZcuDe4j/4S7h06go09vvybrWbpRNmOIChnj7vTd/ydg4YXPCpmqwe?=
 =?us-ascii?Q?0Cq6BJ29m2mUSuadKCcOM/dMbY+I2LqepMQ1vQhcOTTd24kVHLhSvcDaKQNC?=
 =?us-ascii?Q?64RLf409LUxkODAjjmOpj3yEbru5nvyRfN4jPJ6b6CDmjlkKbWH5aRfzfDXm?=
 =?us-ascii?Q?dWhMRx4GeWbrHHymwg2O0SwS0Uj/xgWzV6g72725MeO6E+QfSxOY9rNvHLcV?=
 =?us-ascii?Q?1MW4jlFb98dUHONQXYAGW2TvriysnxESkpe86T3MkisIGiAinD0d/Z3UsSJr?=
 =?us-ascii?Q?lPshASAAriLcwHelusE0xIiks/Oo7AGF2Plf+4q4W3rvr1UGc9Tn92buho7K?=
 =?us-ascii?Q?BX3IF+p2wQZQMlrj7Ljcc6T602ys0QqZqmq6B0PLC7Hl/M1+ik76mawshsqd?=
 =?us-ascii?Q?gQgorMADwSjhYnbNMuBTbVweDUA5d8OY6KBZF8mSjxzFwS2rHu0EYJQq17nB?=
 =?us-ascii?Q?LMwDWLl5don+wValnYZFbh3S7VIWFagTTLqmpYRen/QCV5ArY+bgT/Ujfu2b?=
 =?us-ascii?Q?9NLn9vH5td38xFozgf1snc0pU8VUUjevqHV+/jc28oGKgzS1A8qgB/BIzRuG?=
 =?us-ascii?Q?vwaXR56R4Qg4k8iKE094bWwsEEpgX2iFvvyANPFPRMxzM+bEI1BsF8jcMBmO?=
 =?us-ascii?Q?ICkf06LTdA8zjKH41JTO5l+WwRYFNkPb+/kADGmpIKRhxvUJm4Q3wyUrumR3?=
 =?us-ascii?Q?ggcCyxDwzzEjzuJgQRzvMV/SGKXAL6ueX4ceWJK5Fbn0beoT5ncakqXbJhZq?=
 =?us-ascii?Q?YIVC45QHH0I9mGfB7+ol3jPQudIPKgrsWl6x6fRuW6DQB4tnp/KJ7HstUI80?=
 =?us-ascii?Q?g+/TpRE5Iuc0X/zbSlLxw8GxMe7j74hBdRqrjJSr4gFDT/0ajXRouysxXTVz?=
 =?us-ascii?Q?zmC7WgcxgwiJh/lFBWApXjO6lv/4N1hN/oMy0nBLbTgu7JGcq40FkaD8qekr?=
 =?us-ascii?Q?az2RmRVfUcdirpizQ1K3dEMZyed6/mOh2cN84h4X1v7mLyKl7xErEw/rclkg?=
 =?us-ascii?Q?dnV+tVI4pD3fpNxWn79LBT47Uo7lavCzjk1fcoN96lXXK41gkkDRj09XlPTs?=
 =?us-ascii?Q?1uJF8CHoLpQCYExmx2GNxH4baBJBerR7w53a8xVByJc3lnoJW4ZsrT1nsLPq?=
 =?us-ascii?Q?ghnBQ9kElpeGQB/tj2pJHpgG9fFc4xPUsFkKIu+BsPzP6IyHVKMPKIOjhtWs?=
 =?us-ascii?Q?fuI6x10p/dABmdoZD4cI6nLwyOes0vKRnFfoQMi+9m0VBuv+TDjRzVtb2P8F?=
 =?us-ascii?Q?SFlAqJjxdk2IPO6YoBYuQkSbT9QEbQGqDweRrOZlW94e3Nz34nJinsTGdbT3?=
 =?us-ascii?Q?ck2oLOh+pM499s6a1iHn67jYED5p9/E1W9Vn+uB9z+7Qje2HyviClD/ZWJDw?=
 =?us-ascii?Q?ugjR7epDBTm14DBKD0IY4hU9KQ/kq5GLp/jECPBz9LsVL7cqOYC/zeHh9a/h?=
 =?us-ascii?Q?03edVou2TvnEukxYJ5X+E3+MnnSdpbx+H9cI0JeKuxBzjkWPLFReeXTwRhou?=
 =?us-ascii?Q?M2ElUTxiiOwAilaR2awE3WKgQIJDIRFI/OosPk8MLarN/aIHb/vRGiuIstJf?=
 =?us-ascii?Q?0RyL/fE3kvJA2ZOsbHpgpdOpB8QREspOPC27OMDOoEZAmWN3rF8M/klQM5oz?=
 =?us-ascii?Q?lOhyJg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c2f11ff-ff74-4db6-f491-08d9e68f4704
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 21:02:09.7260
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GtO8zH2qYaGVuLUSfHLGycXUgfZfzuhCzzRoa/goy93HlLVsNO8czVSemf+mAFVunnf0D51T2CT71yig6RlfioDQhIjZ0yIWoVh9WTRZpZg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4014
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=949
 adultscore=0 malwarescore=0 bulkscore=0 suspectscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020115
X-Proofpoint-GUID: 14kvZM3z14v1J5m_ZdDRnjCkBAbxIwEu
X-Proofpoint-ORIG-GUID: 14kvZM3z14v1J5m_ZdDRnjCkBAbxIwEu
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset adds a couple new options to kernel_clone_args for the vhost
layer which is going to work like PF_IO_WORKER but will differ enough that
we will need to add several fields to kernel_clone_args. This patch moves
us to a flags based approach for these types of users.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
Suggested-by: Christian Brauner <christian.brauner@ubuntu.com>
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/sched/task.h | 4 +++-
 kernel/fork.c              | 4 ++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index b9198a1b3a84..0bf95966ae7d 100644
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
index d75a528f7b21..9273fd81a329 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1998,7 +1998,7 @@ static __latent_entropy struct task_struct *copy_process(
 	p = dup_task_struct(current, node);
 	if (!p)
 		goto fork_out;
-	if (args->io_thread) {
+	if (args->worker_flags & USER_WORKER_IO) {
 		/*
 		 * Mark us an IO worker, and block any signal that isn't
 		 * fatal or STOP
@@ -2497,7 +2497,7 @@ struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node)
 		.exit_signal	= (lower_32_bits(flags) & CSIGNAL),
 		.stack		= (unsigned long)fn,
 		.stack_size	= (unsigned long)arg,
-		.io_thread	= 1,
+		.worker_flags	= USER_WORKER_IO,
 	};
 
 	return copy_process(NULL, 0, node, &args);
-- 
2.25.1

