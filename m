Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929464B0148
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 00:32:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbiBIXa4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 18:30:56 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiBIXaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 18:30:17 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C36B9E05111C
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 15:30:18 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219KYQ2U020178;
        Wed, 9 Feb 2022 23:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=vikfQxERUFBfKJD8ex3HEUPJE9sExSR4JsWfRTsN1EE=;
 b=Vybrh8Pb1UR/86Y/B+VvX4KrDgXjXWkfifmNfmLuzMca5DypTU0ethcTq4YmKlJRThve
 H6Up7qL9EoVA0f/B7c1ifsHT9rfyh/jheuw4n50JP63mr5gm94KwrxgtewpQHSkSfpT0
 7FQbLx9l1a0NoUzU5pnrp8KORQRYSmn+6j0Babqs0NDJGuQ2zq8hIXRlP5CeS3+YFAeB
 fXE8LZIiAa7ylYkl099yZJhCyh7SHLP1BjJ0hcFAMeDZkUQNtSEkWIU+GXRP1FJURRa1
 f5CsZ9tzsWyEyYqTaEMuqDShMVDv1dLyDCkcZsfGSC+W4grp17htd4ye/L9CxsfpDRqI BQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e366wyd42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 23:29:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 219NFrFV117827;
        Wed, 9 Feb 2022 23:29:53 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2170.outbound.protection.outlook.com [104.47.73.170])
        by userp3030.oracle.com with ESMTP id 3e1ec3m196-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 23:29:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QMfZaNDXAtZ7cta5xEaMVzsZUkrsZtulVoKDPoc/EObbaBc+HA6zmHwxfzKZC4kobwvO/eYn0Lb1bx58UgV3qVB43wuKkFerCZaFSL4O/MS2ZP00mTDzlCHUR3Nyv6U9NEt4x1zcMTA1kUashaaww8tEP0HBTyWNGT0MIkAlJJiKmBBSBx9H3nmsZbW0xW7tG/LePpmllaQDSIPxowa21YjgtTGyYdVOunYBYj4vrkMJMF4I8fZQN5SFkrd4fjqy+qjwxi2DEm7CLyU7nR81iFAl2EwGYujRF/ikT2CGtWuc1r0++mCK+pvfG+x1LhZoCdmT3pj3I9p4jqMk2GQynA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vikfQxERUFBfKJD8ex3HEUPJE9sExSR4JsWfRTsN1EE=;
 b=SV2wUoiLSF9zuSc6u1AEQz6COBRU/w21wIv5ryXGeApgHJUEsCqEpvgd0LAKU154xbEl22a3Gk8O1jkAU4xcOcsorOggaDaLhotOMUbvg/ogsLZc3bX4jYriZp+WVmjPSydwUNB1QuqGhrppxcZmaCGmpKygmjsceztAtkPDHPD5z7XrHHAKSVVmLvbVE51iIlyowHgmhcfq1aZd7JQX7OJ2YtC0hfNRHy5zDfR7kvoOSYF3eMt8rKo4vXppXKcOgCPqLG8GEJwYb/pmPQ25c7L1rgEQjXKkujUjXJMTWSga5DWMgLxYv/Q24WRin+JsGgHq6ttnvWp5Gg+6VQWHBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vikfQxERUFBfKJD8ex3HEUPJE9sExSR4JsWfRTsN1EE=;
 b=Ta+fkgrgExdBNITIP7H1tvynpEid0WTPRD2CWW3I40ExWox90Tr7cB0tbkNIhjsbpmcp03ZzRLzkLimhdawAjaZj6zWUHvLtoqvmwcT5xXMLSVIQIPIRzXxxi7McSBdTqochkIndxL/vKsbfZ5MHm1QmhEAnuvDLej7exZ8Mr/8=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 SN6PR10MB3007.namprd10.prod.outlook.com (2603:10b6:805:d9::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.17; Wed, 9 Feb 2022 23:29:50 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3448:8685:9668:b4d5]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3448:8685:9668:b4d5%5]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 23:29:50 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     geert@linux-m68k.org, hdanton@sina.com, hch@infradead.org,
        stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V8 1/8] fork: Make IO worker options flag based
Date:   Wed,  9 Feb 2022 17:29:32 -0600
Message-Id: <20220209232939.9169-2-michael.christie@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2ae3ee28-9f43-4827-d071-08d9ec2410ee
X-MS-TrafficTypeDiagnostic: SN6PR10MB3007:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB3007AEB439D5B9D445089C5DF12E9@SN6PR10MB3007.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2512;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NyWI2VyLKvizM9pDoeT6sfxvVijMwfp4kdoY+9g2YZntgRFjTnrJIfrdr3mHwCAbUc9dRoD9dv2PhFX/upvwWS3I5vFXVpE4sile57GJlcY9yYCzWn7jX+IFDEF8IhbYMQW2UPikgRWJW20NuLpejiXYBJBBaXxjA8/Jg2HzyUjdIgpJ8Vwes/DUa+FRkLyfIq2dC5JauAjwvtEXhc4sJ7uKqMsDTL/4Kyk201WVxnzZn8FcG41sccxmQcv4CZDkGyDQh49W3hKXW6RT08CUu6IY+1h3WghPUSssQMx/ZP3NnLR2+4Zs1ztBVSY3TKiWyFnijdg1/NBm3JHoF/6ZW2LF2uwNF0TNnWQt6tN++Jc0eCum2fPxfMh5IgYDarl3kkR33gcNb3+gKSsPVtxGIR+b1ELaFB+LDYngqRFEQj90pVtsVunHGTo71XlB1G2WDcOfNrEDkgTYceRKO5YlmrQ015p/0DAj1CIOn2Oa14S/EGZvlc1kNiVY9DO45AlfjDiNrBx49+DQMi1suBqatlVEz7YcJO2IZK9fFWMqxJaPvMVYwCE+5tRFuGYK8kvcHNNaQ+OyPgLVlY565vsbf4YQ0UZ0Z0QZmtqRSDUfNEIHOrdbvVxzLhqLPah1PzAtLKHFsvP0m9M2w+PUchdezD72LBkAPUHmo4weSVZMMZ/VWD734f+T8vCSRscMklHZX/0pqeVqtDQ6j56AE/drjTsjwSABCfrCRk8CURIQmpA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(921005)(86362001)(508600001)(2616005)(1076003)(2906002)(36756003)(26005)(186003)(83380400001)(6486002)(6506007)(8936002)(52116002)(38350700002)(38100700002)(54906003)(66476007)(66556008)(66946007)(4326008)(8676002)(7416002)(6666004)(5660300002)(316002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IGnonroSM85zyIpPZHCDIe6km2bD+8OOuOCNKfCc8A3Bkj+y4BvX2iPnx53p?=
 =?us-ascii?Q?6SBuxZrvCcXYLGpUSAWOUsJUtzy7YTktebIcCVdJWOCC2X8hOLBkrFCx/4Xw?=
 =?us-ascii?Q?TIDQcTl08gj0XpXiV78s7VXdNpPzab0JLHlUgMwLTv69HqRvklYz7a0gp+iX?=
 =?us-ascii?Q?sgBMmhnu4cwJxEeQ9ioko+9DJS9/LRc5tgGuF3vgxvkFbRZoY7mHg3HVkYcU?=
 =?us-ascii?Q?U3IlSmFLmSnP9AeIiX/PR/B5cZ1M+Ha7NxooJYG0FkCZ2Y1ums9uJE9k4d45?=
 =?us-ascii?Q?J2WMUSwTkix9qb5/hu0UKJTrrbnC5cfhU3yULN84z4nzWrKUQ5WQ6A5uoTR5?=
 =?us-ascii?Q?6kQ+NDtfPJ31rFy/S1jXVHakKNs+tZt3sp8VshkQMPlnryHB6ANdMmfkRrr6?=
 =?us-ascii?Q?vFADWRhg0CxTZ3OuKX0vkuWCxCERaALZqp/nvd1HD50N/NS8apoms1taxZ0f?=
 =?us-ascii?Q?XZ1Qmeu6xsfVVBen7XHgAuNWeMlDYM8vEff5KIk6YJ5gTnTSzHHlYe6CY3xX?=
 =?us-ascii?Q?wMEJBLgMN8JCg6hsRKDH/KiJHKu+MPv5ilUCqfInB6dXMDJ98RGKvw/I9YHc?=
 =?us-ascii?Q?OFCHFK9voqxQoWsMpP9bIUqG93vR4ZpjCYfaNqYijViSYVxqC1s3neowYuNp?=
 =?us-ascii?Q?mTXpPLcDXajEc0uR5AMTaNKW073hICmhQijo1KMI3id+prgZnzLn3syGbpoh?=
 =?us-ascii?Q?y8YgLFxIm2lUlVJilD7NiobGXlCFjgN8CF8X21RD+e9yzUblXrlcsZIWPI74?=
 =?us-ascii?Q?fgkdFrb4KETys1zaK5ZL74YAkLuJvWJkBO8nbBctuKfkHXNtUzcBK81jhVZA?=
 =?us-ascii?Q?Ej/a8KwxOA96QZBl9oSw6JVAafg3vPQ1twj8LzsrAjr4Pf0BiV2UjJxWf3ze?=
 =?us-ascii?Q?VPlyzjJRKbOZa2PSKa7mtwyJ63hMP2ONSkOXbtyA4BKsJ/+IUjRpKwxChdft?=
 =?us-ascii?Q?114+5rQvQa3dhs6hvwW5wChMrSOHMMPxIBLtOTiVjuJ7/G1VWGgWczayFEVO?=
 =?us-ascii?Q?v/cnyMspmKyHD7E1XZcNpAe8Lj6RvO+YyhFpoA/USHsqpbCSAeZGHVIK2AK8?=
 =?us-ascii?Q?QQUMliyVKgEXqVCH7HqH6aNatA0j5v1bXl4VFPOLC9lLxG58JdGiiipXl5mx?=
 =?us-ascii?Q?374MeL4Mu+4mjQXciJVtnOtw87YBQywSTPvgtmNfV/NWfeNM8ogpdcPZ8KW1?=
 =?us-ascii?Q?kFOo4fNwPfbdbbOVUf766ku/gFdyvSiNuEbGzQftLDXRLe4qcVgoRXRhWqZo?=
 =?us-ascii?Q?8eeKFn/2ZT0fqdZrf/4N+6i1w2HpALjxPkvjH8KI4NmMX697CTtleyt8UJGp?=
 =?us-ascii?Q?KN2z0PGftlckfFlstXSCtXDHw57hR1ZzhCj/549B3eB116xxV7dz1lX8zRX+?=
 =?us-ascii?Q?Ag+yV90bXftoD94GUP23GB9u68ykZ9qY7K3iAxbihfw8ZVG8FLrmftdZY96y?=
 =?us-ascii?Q?vLVtOYVwrYcQZPFTtisor7Z3TJFIkEq51QhxkpcJ7LK8Y/baluNaElYOty0V?=
 =?us-ascii?Q?XY/+6Dwp/Y+TYYxZ2zaNsYUjYtnfSsA3KaJHDIrOHSyaNvfgv0Jt/JfF8rgE?=
 =?us-ascii?Q?cpqXiBimCj4vXYl/g08fTRn0VwaKeKhysuVAdAA2ds+BXDBLHVOmEElAbH41?=
 =?us-ascii?Q?8Hr65W6Oqvz1f7bhi9RRPsVudJveaQIUnid4dUs50NKwGbVRFPbsNacLkHI3?=
 =?us-ascii?Q?6s3WjQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ae3ee28-9f43-4827-d071-08d9ec2410ee
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 23:29:49.7949
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SvkJWOjhY0t6wo3eU5+oNLKlmHFtw0ak1At8nMoQQ3DaKVeqFEdq2faCP70DUstHSI73TlgzeK0jAGQntNz/ZsruEbRIhe43Ffz7VuRFE0o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3007
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=938 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090122
X-Proofpoint-GUID: _gA-PLb7DGrAvZO4t-wtgDvsAkzi87-1
X-Proofpoint-ORIG-GUID: _gA-PLb7DGrAvZO4t-wtgDvsAkzi87-1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

