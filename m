Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926414A79F7
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 22:02:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347359AbiBBVC4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 16:02:56 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:33234 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347367AbiBBVCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 16:02:40 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 212KwhBN023474;
        Wed, 2 Feb 2022 21:02:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=Vs8tFpLTMOGvTyZKGEuCsbE6CFo8oWe+4mPnhyqiYJc=;
 b=MNT1HjfLYhwkZkHJS4a0KU1nNMQT3BeiwZfnzNYDWA2bdi/JMBD3zzQh76Vufo1nZ7jE
 f3vjncdR+2UuzKHIILloXXK9oHaXU5VVXaUU4M4lRHf7zR3bUbBarwEfsUnR/xfCl5VE
 wVhEjE13m7GmtwgK+FSy2S+KoaYhSZEEOD8lNVQ/wBJnIn0Rlmd9rclNgcExGjQFFtxj
 Qzz04k6mqmzx0opip7yHsdAixMdtrIuLPbBWBd8Z6en+7Cd5eoBYdOrF4KrJQbOC4oSF
 pWOXlaxBI20HiPQUNB5PUBSgPWwzcCfp8ogwKXkbwt/vwsidNLHoPVWDzYWkAByv9vFk Uw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dxnk2pxct-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 21:02:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 212L1Ejq021471;
        Wed, 2 Feb 2022 21:02:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by aserp3020.oracle.com with ESMTP id 3dvwd8xt3n-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 02 Feb 2022 21:02:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZIZEMhZOTMTNt8ZD5L9FjViYmYTyldPUXjj3FZODPIhbIItTaFIUsbPFtkB23wvBAarlWb0n8UQ/IcisAo+9qdMD0wodpvO6M6hbJoIdOu52oScwqypej+y6V7K+BKXFTaKh2wkGYbSRUQXtkAseJT15yCD7P/FDM/176ybhUcZUwpwQvZpsdf/eMmZbjFHGK2tuipmYurCwW1E7OoS931Q4B/GPfxsCrUOMzDwdYffLfFGaM+tp6Y1bt7nY0yr5nKUW99OlzSQBgQvOxNOA+bI8TT0gYiSQ+00YxdVWNxg8i/r/tuwx/zPKWQ20xy5AtTwf+bxBZgb2kBHEqZ8Zbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vs8tFpLTMOGvTyZKGEuCsbE6CFo8oWe+4mPnhyqiYJc=;
 b=H3vdFn1WdwSHhM6HU+63iMcaeHT/P7EyRV4lOhgE89lF4G1Qzh8l2YQHrxQ3Np3m6c3somwj4NOvvAQlnCYUy+rOhgErXTfxymKxaH+8/bDYIHeboQdAdYnUZ6F3mBbWLPPdwzaSte7FGwx1qCdhbWR6S6KmBZAX5O6VoKXvfFFd3582Qu2BGkwVYZ2T+EPeGMJ/TeyhI80tPVnJH5E08EiEH3X+wyv1XyCFurEcC+zd65Fl0mTO7k1vcAD0QK3u3z3ZNrC8cyRqRSjfLk/ydm1PqqrhwmtgaLMuQvZ6Z5FV/4KH6JCTi8KTaeW+YzOT9BGAwYgtXIL6fLufSEAEVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vs8tFpLTMOGvTyZKGEuCsbE6CFo8oWe+4mPnhyqiYJc=;
 b=BmQp6+Qqz52wPsnxMIJQdnnNHLTJlbgMjmxVgYkQ3vIoZwDaNB6nngoiUVa6ywPMxOwZ4ZHOdUEOIsRMHp27eNr5zBKaycToADV8RLTA1H/VU1mjMEoW4cT643gF40NBILFh67uwUALJ1sUNdAAgwrv2RypAYGq2/sIhA4XDmu0=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 MN2PR10MB4014.namprd10.prod.outlook.com (2603:10b6:208:182::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Wed, 2 Feb
 2022 21:02:15 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::21b5:910:b965:9e6c]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::21b5:910:b965:9e6c%6]) with mapi id 15.20.4930.022; Wed, 2 Feb 2022
 21:02:15 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     geert@linux-m68k.org, hdanton@sina.com, hch@infradead.org,
        stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>
Subject: [PATCH 5/8] fork: allow kernel code to call copy_process
Date:   Wed,  2 Feb 2022 15:01:57 -0600
Message-Id: <20220202210200.5235-6-michael.christie@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: b3ff5f6b-2c42-4807-069d-08d9e68f4842
X-MS-TrafficTypeDiagnostic: MN2PR10MB4014:EE_
X-Microsoft-Antispam-PRVS: <MN2PR10MB401409D116C43AE872FE096FF1279@MN2PR10MB4014.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HusVTPQadQEbG+xkWMYjo5T5Rx79mm8YZxOBde0jV3a1jpblkGwZrLb5VLpZd44ctMW9VvjVqIdljhVeOjhNQAFVPI7Fy2mmhaMefwAiyorExyAokdaafXEj9Q3V3/aaXWGcNunI2DdzYaXqSk6EcUfUAQJXqgtkBn5cikrFZUCGm2karIqFCW5lhPF6tmpMAf4wyxNdg2LTObnp22KAXJo9+yVi6hvi0NTv3pRzhnbKjWLwZV/3PC0aJzkvTe9EA7xx959tv7odTOQuGpotDlDkjjCrJMCjW4qRTDh5gEIzB7Ql6VJ84lkSGijorEOGNDwBse2cXyShma6dPX0rSF8S3BT6NubGiOjnfIoZJyc4pGw10to3GJ9jTT8gLR6gqrS910GmnsU09sMMYY2HwRAGG84frgsIEEIV0sbtahGsTaX114SmcwsmfxWD+4Ss92fQv8CqyWA1dLtRMf/wWqCCJSfbGs+hZt6hqmiK3cXdKbzzF+btqF9/XHMwp02gRkUsxeen/ITwqptM8SIXwrJSoNIfSODzkHgYEdaOAQFTm6RB6meS5x8H6rtER1Gm5OKwrLaJfzXsj9wnZaMIIoSqtsO89hKMGlo2mDS6RUQa2pPyqtWQ+faPPVwaQaapfoajNDoAENtVgixVGb9HQIeIWS/VD1bEuBJ9lFVH/qYyKRatV+07wCr6BvoVHxUPFwahKZYvywBClq+LGJW/X5uDLk9FEAJPnXyxvtaOBP0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(6666004)(2906002)(107886003)(316002)(38100700002)(1076003)(38350700002)(5660300002)(186003)(26005)(2616005)(66556008)(4326008)(66476007)(7416002)(6506007)(66946007)(8676002)(52116002)(921005)(6486002)(8936002)(508600001)(6512007)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oAB5dGQ5YOCcD8WjhqSstJ4sfl1x2g4gyj9bejO6Wjw8D3t7HITjuzTIYtkp?=
 =?us-ascii?Q?PwpFqrk4FnDUVldLki0/kylMaIeu4knO4kIMS+tH9O5DY+4bdhQ+mRpAgsxI?=
 =?us-ascii?Q?zYe7a4bwFOKFJvuUes3BjJhl+6NUDUEEdzuqXEWB2bN9BavxA9NZZZxHqZzd?=
 =?us-ascii?Q?ghc65nwA6eIHK5k+XUX5iqGDYszwHTmPsFf1M+obO1TpnrCELSFg2nxq/ZK+?=
 =?us-ascii?Q?0NeRaiS0F/ntM8Ji1JbiuUN15Fd3aGotHHgL7o+c1ofGMAvr3IQDL94Wa0HK?=
 =?us-ascii?Q?Vhh7NE9AhIZs61rX5uFanVdI9qtCltcy4ZZqa6dBt6oSuhdmxmyAR8BXIWIp?=
 =?us-ascii?Q?ksJS1k3lq5/hy1GI9coW9+1dlEd0iZLEl0E+nTD7e6KrKF8ZGJvPaN+T5wh5?=
 =?us-ascii?Q?fTacEDJdG6q6qGPmAGDWQBefsQLVoTld0Xy5NXCc8hqKoGeNZu2n/z+INv+m?=
 =?us-ascii?Q?B1z8ANxNPaS7Ql1Yl2CNXI1Swp/+7J1D1fL7fHFhuZs8E9r2xZtGRAED7+ej?=
 =?us-ascii?Q?ieFohgnJD/TmsNrQqz4vMgNrb5QwjQ3fhKyvLXm8bU5EOYA3vb2QC2gVQouU?=
 =?us-ascii?Q?MA3Bx1FULikopAftkjnUTwyzAG2drziyqM/r7nuUY4196QZzZYxJyfSx9us0?=
 =?us-ascii?Q?Xfu7yKTZ/H0cpEEHrYLlWhV+gIdgHWnUPITRj964WtGXyDXEvg8eqVCMWNFB?=
 =?us-ascii?Q?fVzq/JpjoFExIOKxelEQjzbq5pSGHqk9mnou6yf8R/6axsHNbZOijFQox9K1?=
 =?us-ascii?Q?KxGTZCBPeOlJak9C/NCq2pZOleoYHOB3Z3Gvn59N/b/OwFMkWiScjZOzPMX7?=
 =?us-ascii?Q?ANloSaLrsivYLGY6c7jk8jx1ZwsIH04Fa30GGe631bEzoJRqJlB1OSoPN6+v?=
 =?us-ascii?Q?m87kVfNswh5uhS9HdeieVIN950x/OCmC0J6P4+GMN8O8raMnMdZbpKyNncZs?=
 =?us-ascii?Q?bOFLCBG52TnCfAQUo1ZcYcuXtASjJfBts/u7Jm5h5W1QGq8QZJatxOS3v9y0?=
 =?us-ascii?Q?4O2yzS9efnJzGc2bR0kbt1AY4mJxR+TzBLQgu2DcggYcJK4+OdcJytqrjTFT?=
 =?us-ascii?Q?Po3VYUWua9aTvSDJ+7IrCI1rL75KJqYXKXaPGM5sGCvq8XlL0BzMlBGtGa4+?=
 =?us-ascii?Q?oCchTBdfNkrILsvudjj0lcN4oihFm8BW0ywXNZGE/ybUGQ5hOpjno8cqcmwW?=
 =?us-ascii?Q?/m0rs/Ygbgthuxi5SVE7KWOJoi6nZXJGpvFteo/DiFQrdbqrqD0+6qoeGsiD?=
 =?us-ascii?Q?qks7OfPdZGKx0HzeY0PogVPx2zHtyZ/B+rWqgnRhgWib8tKGSllZhA+P7bF8?=
 =?us-ascii?Q?cDDpFjQKAuBAqz43FEO0h0pk3STvDVEzHdcIcN8xydpqTJ2unXcvee5mQOvQ?=
 =?us-ascii?Q?DPcB32+9s//GWG4ooxG1TqlgTxonRTisfaro68LFzBWcKsgGQKOzVf2EdddH?=
 =?us-ascii?Q?6s3E4VZaQQJT5kgSpch9cWQ6uU+VWXoIDOzFQEelWTBWE+UIDGGxtbut8ySw?=
 =?us-ascii?Q?XtDIB3ZjwjftSrvVk5ChKXjGO18xUsj3+WMv3+qP6TC+96RvrwhiEAb6319z?=
 =?us-ascii?Q?HLVpo8ZT5yP96sbehRkRiWO1CoMHMTZSNOaOUdYKzgWb1mlROVxoWeyBCedb?=
 =?us-ascii?Q?WIYG6EnmdaWLvXbmWfhUopJq4bMTquU3uRJm1Zpz4HOqkV1jhGEpLCdz8cm8?=
 =?us-ascii?Q?9RcE0Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3ff5f6b-2c42-4807-069d-08d9e68f4842
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 21:02:11.8040
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8OFGetJfSS0JJm3Mhmm3V8tEweKPBI9A7xmkx/4jTZ1Vspsv6rgfLzy16kesfY7y6jE1iDqz7RUSyEWWR6KmBxHgyVQH3/8IAz3Kn6vZ4U8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4014
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10246 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202020115
X-Proofpoint-GUID: ZFGl40QeADzwGtSK1KPpum7W2mn0Uy9o
X-Proofpoint-ORIG-GUID: ZFGl40QeADzwGtSK1KPpum7W2mn0Uy9o
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The next patch adds helpers like create_io_thread, but for use by the
vhost layer. There are several functions, so they are in their own file
instead of cluttering up fork.c. This patch allows that new file to
call copy_process.

Signed-off-by: Mike Christie <michael.christie@oracle.com>
---
 include/linux/sched/task.h | 2 ++
 kernel/fork.c              | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index c001d0fa1426..787e6108fd65 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -90,6 +90,8 @@ extern void exit_files(struct task_struct *);
 extern void exit_itimers(struct signal_struct *);
 
 extern pid_t kernel_clone(struct kernel_clone_args *kargs);
+struct task_struct *copy_process(struct pid *pid, int trace, int node,
+				 struct kernel_clone_args *args);
 struct task_struct *create_io_thread(int (*fn)(void *), void *arg, int node);
 struct task_struct *fork_idle(int);
 struct mm_struct *copy_init_mm(void);
diff --git a/kernel/fork.c b/kernel/fork.c
index 6a04860fa1ae..04eb7fc50a13 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1905,7 +1905,7 @@ static void copy_oom_score_adj(u64 clone_flags, struct task_struct *tsk)
  * parts of the process environment (as per the clone
  * flags). The actual kick-off is left to the caller.
  */
-static __latent_entropy struct task_struct *copy_process(
+__latent_entropy struct task_struct *copy_process(
 					struct pid *pid,
 					int trace,
 					int node,
-- 
2.25.1

