Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 371124B014D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 00:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230062AbiBIXav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 18:30:51 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:52610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiBIXaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 18:30:16 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7489E05111B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 15:30:18 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219KAjBi027666;
        Wed, 9 Feb 2022 23:29:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=4o5CoxdRVCPF8/Ow59bNL16B/u8lUm0INV/6+C4mVOQ=;
 b=EZ5LUUtj0STXRZqTIQF4jHM0r2FvgQohaGuS8JEN05jorhCzeTKkmMzuQuCtXcpRghmy
 1BJZeIts1HjFtJWH4SKX5Uuh8sL3ElCIszDyXdtkJ49WIVLR6WpDh2YPByTRBO2qJsZa
 E7Wq7VKECiyX//oxVRTswtwHakGZW0Lwpm+c++oZaut5lXPXRoaxvqffBxfj6Ir0y92v
 ZKRAVPyK96lzqxPi1hioLPy89+xecT5WP7wgHmpDMxI/WiS+rAbfLixk6C6knI6Fh1O7
 DbWVVaUaMpxRp5ZRQGZWpd6qhcGlgDwAO2TrC74ikXZhKCgKh9mCslT6LhiM3z9hFKAg hw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3hdsx37h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 23:29:57 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 219NFrFY117827;
        Wed, 9 Feb 2022 23:29:55 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2170.outbound.protection.outlook.com [104.47.73.170])
        by userp3030.oracle.com with ESMTP id 3e1ec3m196-5
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Feb 2022 23:29:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XUEO937IJLTy6xFerpKSdYGlvEqihVCLy/eMU4489ltwqHr/hEQAp6H0g5sM19mpiB+As+8DA4jxP60Zo95ZayFmWaVn6kjDSKUpnpaCCrAGZY9DW+ewdhEhMbUsuaet6k2Wv4MmrPpYgi8f801khed+YBTCX+Q0tPtVLynXmBmoPbDk/o8ARmitrHu0Sy3x9RpuHb5e1lzCTT4GhpnBqBXYABFUNXH4rFN64noOoiAmJ1UqUNjhS2IMqBBziAr+VprYJLMSlDA0azjUoGYRV4O7PEfIqV6Y1kVmPmxXM42wV8ITnTLrHRqkxUWuOugsKC5p++asZqh0vRDwDpJ73g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4o5CoxdRVCPF8/Ow59bNL16B/u8lUm0INV/6+C4mVOQ=;
 b=NDVPKycrp+f/P/r4g8zX/waiPX2wtnUw6I6EGGmYgvvBz2UkkNJiCfDvjNZw/eRO51XpFTTo1RTf+a0EqYbZcKEZvABLAWApbMWurksoV+mGneH+sH8KCMWpelljiWgxs+Cq4Vh+2JcQRDh2QRIwgretWj5whN3iYAebkryxe9Pb08bFGvKgmNFYSSIjFl2+LN5I1qe0HZlAdtixLwRuzz5d7ug27Zb0fQDdbQIhrWGJ1OZkqC3UeZ3M1OMkEDiJD2vv1LffFbm0mjW799VPBcpd9muFlenkRW1r6bRzbfTQJqYpmbwlcJm7ko5Hn0wVgwYbFEUBgVHxjEH7DCGl9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4o5CoxdRVCPF8/Ow59bNL16B/u8lUm0INV/6+C4mVOQ=;
 b=kg9r0am+owJ8nxhCFLj6KTbnUFhsdRKShfCogXknJGz0PDh4oQ84z9y9baIKlAAijCanNxkap4doFaIN3N1o85oT2lxbYKeVM96mxofX0jQJCbYWjaXR+yBH3Wr73an+sq2PDMhTY5JKJqZwQScCXZp59ytwAOJFUMMgU/tk2lo=
Received: from DM5PR10MB1466.namprd10.prod.outlook.com (2603:10b6:3:b::7) by
 SN6PR10MB3007.namprd10.prod.outlook.com (2603:10b6:805:d9::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4951.17; Wed, 9 Feb 2022 23:29:52 +0000
Received: from DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3448:8685:9668:b4d5]) by DM5PR10MB1466.namprd10.prod.outlook.com
 ([fe80::3448:8685:9668:b4d5%5]) with mapi id 15.20.4951.019; Wed, 9 Feb 2022
 23:29:52 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     geert@linux-m68k.org, hdanton@sina.com, hch@infradead.org,
        stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com,
        sgarzare@redhat.com, virtualization@lists.linux-foundation.org,
        christian.brauner@ubuntu.com, axboe@kernel.dk,
        ebiederm@xmission.com, linux-kernel@vger.kernel.org
Cc:     Mike Christie <michael.christie@oracle.com>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH V8 4/8] fork: Add USER_WORKER flag to ignore signals
Date:   Wed,  9 Feb 2022 17:29:35 -0600
Message-Id: <20220209232939.9169-5-michael.christie@oracle.com>
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
X-MS-Office365-Filtering-Correlation-Id: 095d3f05-411d-46ee-5731-08d9ec241241
X-MS-TrafficTypeDiagnostic: SN6PR10MB3007:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB3007D2B957801FA9630812D1F12E9@SN6PR10MB3007.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0N0afFyqX33xNNqjf5Wl310BmC9Zu7ga3OTXriwb/QI9fkmsJ+6JrsutexeYEwinn+8wmOg1nJMT28BJwRcDtrdlXmFWfQNtOH4Qtau3UbjmGH4yUNSCDQw8DHw0u+h7fFTL8pq6vvw4e7tYMkQXTKEpCXvdr+v+jxsHQuQBqjCuzLqpvhMkytNLxrvqHO2WURKRmfHsztcbQtepuRDWnb3JCRCNo65es8Yt4IuXouUiCG2ymfQ41QJp7eQnPmYO8Nxl3OV3lM7s/SqhqcCzCcxfn3OcctqJzyxKNsViWmZCKa8XRHXxrNloqIv95oTO9LSzJJMHVmxsfrW/NMSKUesBcQ+oge7BPIuFyIX09cGM/BPCbYxcrTvjBUGA10eGj9Cl+4tVIwjvN/jQ5XS9hfb0Y7LZbUWDKCWvv+6ACfpqz3iT2LQ6LazazoV2MKvpdN3GEz7Z93nLF3Hqj5A5vjpNDXKlOHOwinORjoo6vLQWqgG7tSQnhPGCcfrprFiE6Ho84kb2+dBqTRsTp7TaOlJZI5N7JOqIzKIQVnKow7C/LiHfw3uzpgnwlESF6u3PgeAH2iP5nwt0c+YuBExRykEo5fP580h61hdTzOKOU2kwjUMKnIltAfReFs2UmxfEJq5e7rlzrsxg4twdtVbY+PCIOOU0nFKaYmXDMShvqcuUU1V+U2NAZ2CeXmZL+pPhUYElHIwaFN13qDMLqpBNBVTEfPqvppKR3Dc/e3QiRbk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR10MB1466.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(921005)(86362001)(508600001)(2616005)(1076003)(2906002)(36756003)(26005)(186003)(83380400001)(6486002)(6506007)(8936002)(52116002)(38350700002)(38100700002)(54906003)(66476007)(66556008)(66946007)(4326008)(8676002)(7416002)(6666004)(5660300002)(316002)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/shXJrPoen1Ajaz9yj6X1+j81EUd6tzPKdZtgHB7vKi5tH+uABE/FJ5jKpZd?=
 =?us-ascii?Q?c5gnZzQWtdapJtl2NVXXDAmyjffLiYRNte0LNoA0STi2w2yRODPxZ94r91vk?=
 =?us-ascii?Q?N7o+mhvaCugfPy+6WqLVHCGKdAYyeH44+N5LsY34K0mwfT6Y81+uSD3G3HHp?=
 =?us-ascii?Q?cNj9VFA5bic1jl514QXFekO0AA/VCttF1WsolPKKVEzMJX3u23dQbU0p4JM9?=
 =?us-ascii?Q?KmuoP2mXpQQmzJkFGpUpcN19bIR9Lf1Fq10xTseEMh3wuFn+wgXxQ4Z0fUVE?=
 =?us-ascii?Q?OMRP4t/Op+ox1bp9KkgJnqDV1yUWkKKLJCk3d8m/lJuuc3MF6+3sQeslHud8?=
 =?us-ascii?Q?NcWXY4Mzlhx/yhv1diqC7oKwFy4g2jhl7GrBKF7fGyJmUjQt1iVy9lowoW5N?=
 =?us-ascii?Q?t4hgyp3POrJLwlPIja7hwbrshZTi2MF+yxlIZ2JSOkSim+oSk1iuVA+qFVOP?=
 =?us-ascii?Q?6prdlFJJkL+X/pi8Ei6cLu0QNaTH0g35yfzBxiDH3ONwmt32GMYk7b/EqrTC?=
 =?us-ascii?Q?vX+jQFmcea2iHVAAAY+fUFZCgEGVKeUb/We9bljAShnHPfS71ZfrzdAtC+DS?=
 =?us-ascii?Q?FycjtWFx0BQsuaFixVFdoBGvN6+wy7IcfRJfhMy5KDE4EsfvIC/Nb5f9HCCe?=
 =?us-ascii?Q?zx5DbHN+ydQTn29z+ect3QKQJR16sAnoHD57+WTnjpUdww6Z3lxcWecxWx3B?=
 =?us-ascii?Q?mLhJMFBOw+TWd23y6g9fIJlqSZINqdJKkemPGcrrqDxVHQp6246bNHoPUMfI?=
 =?us-ascii?Q?mQ2Szd+GJWD0+Q8CTtejWgiLdVUiTKXSO8ZkaPloC/Lr1UlMRW0PGGd0flAR?=
 =?us-ascii?Q?VZYTSczJinxvaS0Wm82jK7bd6XOjv9xusdRgMVatBBuxwymrd3dIufBUPA9C?=
 =?us-ascii?Q?QeJWe2tcwpcfTdguCybDhJP59by/ZaONNHMyhFjdIhBKFawx8mZ3wVXmRifs?=
 =?us-ascii?Q?mQRd3AQt/Pfid0dYvuTnzSjv8yhA8p5jYMUdW1Eg2ziVv77SB8xnuySb3JCM?=
 =?us-ascii?Q?SAUWcgoT7b/4tlNlW1QAQKgePQDakgDP7VMUY4sCovz/WkGhz1zBgk6pzwHg?=
 =?us-ascii?Q?capLRg7oQL4R5rt8/+3MMGMzskVCcOEmk7ziRjN0sm2KzFIWI+98Tzozd8QX?=
 =?us-ascii?Q?0gq42lb0Ntn0bsY2TnpXNPZ/FfmNMORSg7DwItUxA2W0e7Wd27co29HbS57o?=
 =?us-ascii?Q?81tDh9jud3O1Jn4I4ZHnnsYqlcdwsV2lF+Hqkn0raMnIPLdZL9lBQP/bPEmj?=
 =?us-ascii?Q?u1sQDDUFjKd4Hvfibjd0CQOm8VWShqXnMNGwn5EKuLNSPyyPSmhN/BPnztpg?=
 =?us-ascii?Q?KkH0OsF9teRzFKq5D14qaPOkcjUp+/vkPxs6jBpPUVa0FyBBJ1pAKN2MxH3B?=
 =?us-ascii?Q?dHKc/GTCeLj2U7ceDqYykwKMzqt/HyZtu0d/ZzrCY6zXODOTeZUiXuOkJPsX?=
 =?us-ascii?Q?jd5Bb+vPc+O/92PGbDdZvf75Ivg8++e8orNF44Gu+D+bk6KC+PxoRG83XJGT?=
 =?us-ascii?Q?Lncxe8UNp2wa6c5kDO6hCblVKS55fd6/VzQSaQpny304YHIMpTbADmgyrVBE?=
 =?us-ascii?Q?KlGBpJgfOIIStnuoTeV9hrx58jxLcHR1EC/iQlr5/Et33lLkw8IwtrwZgl3Z?=
 =?us-ascii?Q?UUIvoo0z9hluOyN4a4N70eOmSCxTJE939ycQOntoos1J9YK3CV+5uES1WIhy?=
 =?us-ascii?Q?cc3o+Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 095d3f05-411d-46ee-5731-08d9ec241241
X-MS-Exchange-CrossTenant-AuthSource: DM5PR10MB1466.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 23:29:52.0135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YwgqhnodzHmQkGuJp4/KMB4eTqJ1pUM1Rq4dxNxFkh8P3KW7tD+izs1pD4YKCgLFieJ1qAkS3Qyoe5jAekPSUi/htq+cP3hVNISgFk4njT0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3007
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202090122
X-Proofpoint-GUID: 8yGYRheDKHL6XKqAiDhl3d2xGsEsYQBn
X-Proofpoint-ORIG-GUID: 8yGYRheDKHL6XKqAiDhl3d2xGsEsYQBn
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>

Since:

commit 10ab825bdef8 ("change kernel threads to ignore signals instead of
blocking them")

kthreads have been ignoring signals by default, and the vhost layer has
never had a need to change that. This patch adds an option flag,
USER_WORKER_SIG_IGN, handled in copy_process() after copy_sighand()
and copy_signals() so vhost_tasks added in the next patches which are
based directly off task_structs instead of kthreads can continue to ignore
singals.

Signed-off-by: Christian Brauner <christian.brauner@ubuntu.com>
Signed-off-by: Mike Christie <michael.christie@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/sched/task.h | 1 +
 kernel/fork.c              | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 706ca3dc3423..c001d0fa1426 100644
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
index 81a1096d6ee9..6a04860fa1ae 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2185,6 +2185,9 @@ static __latent_entropy struct task_struct *copy_process(
 	if (retval)
 		goto bad_fork_cleanup_io;
 
+	if (args->worker_flags & USER_WORKER_SIG_IGN)
+		ignore_signals(p);
+
 	stackleak_task_init(p);
 
 	if (pid != &init_struct_pid) {
-- 
2.25.1

