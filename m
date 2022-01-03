Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632DE482F14
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 09:46:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232224AbiACIq0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 03:46:26 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:51662 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232169AbiACIqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 03:46:24 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2031SY9H012098;
        Mon, 3 Jan 2022 08:46:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Qwz1WJni+5K28H0erTh5ws4OGYqy92oEeDjQJl/qebY=;
 b=h49THU7auLmwARZqg4KI/rlKIV9PS/LWNRO+8MTWdO5jwIt4mI7etjGYrm3XP6ygSkGI
 8Fcfvr9CU6FAlUEvZR8x5/9Bs10ai+siI4OYzV/fYJfJT2rs5UD2/CdFbp/j3/JsAYlc
 neWZMg6IGnev46Nx85ywXbSZ0G/ikqCyHZlsggIbmXHLOj2WB3AV/5mt8NPsIek3YhQr
 JtJqxZWuRF2b/DX5X0P0L8J7WyB+OyhwTIE0qzo47qM5tGtW4Vj7aKTNFa05+Z31Jqau
 gxmBjDUc7Mx7E8oyRfyEOEB9JHuFgnVtvrQrScctf0KV8WHYsGm1HU1NjFA1Qh76IRbr gQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dadr8a794-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jan 2022 08:46:16 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2038fAWr016692;
        Mon, 3 Jan 2022 08:46:15 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2171.outbound.protection.outlook.com [104.47.58.171])
        by userp3020.oracle.com with ESMTP id 3dagdkd7f5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 03 Jan 2022 08:46:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwRKSJVdbWsfPIlnPxPH2orXsD9uWaGYbwwR63Rf3mJsPi5zKapwDazb+vLeQUGwvWJqMhte7jIzVIo2k6irxQZ3RJo5TWaxsveDQznEYwofEwoBheV3WmY53WmiO2cUhcvLZGeCafxBufSwCOfNlS6ILIw0dcRj8ZC0JAe4hMgXgTaUvE5OZhEUC7O56rI7lqV5JFm37U4C+N7TQMNgDiDS2npVoBuyxeu7pUgDEdVp5/DL+6Rh4OXLjCL0KziGn+V/LGT3K37YhQdmrxv90Dez9YM76wF0cFpWHCLZbMqpLIoRVhLbuxnFfbyA1qUSRF3xPU2chC0e0mJBLgdLlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qwz1WJni+5K28H0erTh5ws4OGYqy92oEeDjQJl/qebY=;
 b=Ne3rDkCvm1AJe4sdYFlsiH6ORC/0qln1acy+bT+TlueFLkj1l+GO1LS0b5d3p4dN4nC81YoERLlZHgA9vuHbjuYZxW7MGQ8uH0JAMCTZT0cjJesMDN51PMD+Y0cYOodEWX+mw+4qTzmJhou9cdqqDXdlO2LumUwOCwo/zR5gCwDPe5Am5Skj9HJF7NPqkqJesgjlS/UYVeggN4nAruvUYeTxXvKF3UkinM3qD8/241Xf82WUjSUdhS2TG8s/MWYyNzRyi+SyKs6gfF6b9o9mQjNnnTc7UkRLlJ9fGTABGCkoegKdG+Fo4uJe+7m7r6MkG3aoaEKwZOxGGT4fYAO9gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Qwz1WJni+5K28H0erTh5ws4OGYqy92oEeDjQJl/qebY=;
 b=jUrlK8BN3ng4YviZ7bh6qKAgY6m4dB9WqVv8hZohpGAfxGGCAgn24Mdgrw6A6urc7sPv/aROvT77F+uCZ3tRWzoCpTKBxvACKplJSO4Hg7oyfCvIsmpIdwo18g0rBWYA9j92DwCqf1JMAQiFeb+ch5Dly+dlLz3qaFBryKdg/sQ=
Received: from CO1PR10MB4468.namprd10.prod.outlook.com (2603:10b6:303:6c::24)
 by CO1PR10MB4417.namprd10.prod.outlook.com (2603:10b6:303:93::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Mon, 3 Jan
 2022 08:46:12 +0000
Received: from CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::d17e:432c:af45:248a]) by CO1PR10MB4468.namprd10.prod.outlook.com
 ([fe80::d17e:432c:af45:248a%6]) with mapi id 15.20.4844.016; Mon, 3 Jan 2022
 08:46:12 +0000
From:   Imran Khan <imran.f.khan@oracle.com>
To:     gregkh@linuxfoundation.org, tj@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [RFC PATCH v2 0/2] kernfs: use kernfs_node specific mutex and spinlock
Date:   Mon,  3 Jan 2022 19:45:42 +1100
Message-Id: <20220103084544.1109829-1-imran.f.khan@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SYYP282CA0010.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:b4::20) To CO1PR10MB4468.namprd10.prod.outlook.com
 (2603:10b6:303:6c::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4e2a4378-e153-4bf1-8385-08d9ce957edb
X-MS-TrafficTypeDiagnostic: CO1PR10MB4417:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB4417B60FB7B5FB8422CBA9E0B0499@CO1PR10MB4417.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:264;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: O+6kq+Kji1yaiqQHgivP4x84y2sIJq3o7NyiLIV/KUq7TSNpmOX20dyZrzaogr+1DrXuGIVxiEeTjWixjtRNyqZsXxZMFIMJznhyuTwEnvf2yA00k6kk5Qg/sAsOULd7FvmAbXgA6enwebIZq/jGkic7Vmc2FSJp8K/DPAgcyPCksvWVHeyGQRr+ESTsMlAgvRFY0XT1bMPY0ulhf/l0st4QYAPq/ehTPPUCidmSM5Y2nvruigdyGG2u/QKcagax1+NqiYMDUqYb4avKap8HZx5fBnvGzM+K0I7iWrj7bjYtBHB/0U7KcydJzYIB2WT9lwXaG5IspVCoVaJ5xYYnV2d04XMGfy5nD/2scsJVEjtKJwGM6qiRYi14gE2YzrikAxP+edEhTxnV3HACs0SGLfMlYXtI8mkPFkb5OodjpG7g1LdkH5TcOFGHGOTFNGY8NYOEAp85uTrAyK5L6fpJIjbvzn8uOSi0SrWTYKUMYFseY1Jr94NahptIusYpqM+xDIJl9QxDo2MG/680TG16D+nKq+LbGIdflW5kDVHPzWd251DQzWrDZIuS0wD/DCMfhyZ7oeZ7wjkwmLWdpRZ+IrzX4VfwXrXLe/Xz0tjw+1sjE1ZNHrgqflDX/7PTl7dBRTFcb2PuEKvTGwUysf5XITXiIMbixhY/sdepf1jySHTyrfuTjcz2z6SpfniCu11INo+agHHsJDEE4iMtRdOVfA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR10MB4468.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(103116003)(1076003)(8676002)(508600001)(8936002)(38100700002)(5660300002)(86362001)(4744005)(83380400001)(316002)(36756003)(26005)(38350700002)(186003)(2616005)(52116002)(4326008)(6506007)(6512007)(2906002)(6486002)(66476007)(66946007)(66556008)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?OnHHZ/NFyKaBEPoQHE+gJaoHC6NUN58z7PEcwEGJ2L3ExJUFnjJs9RweiP3+?=
 =?us-ascii?Q?VymlOrpeXK/C2OtuFpHLYe+6raBIwlZyhLBT1zYZNZCg7a1F/IwTWL3+6aYh?=
 =?us-ascii?Q?l9v4bXCu3SuSX22xYDbAtCnWWw5QL6N6WWprtmv3xtbteRWZ0Pqu/2X9I6hT?=
 =?us-ascii?Q?q7EoGKMIuyilC4gj7RLNCFlRUiGk8mfyMHQ77VeOHNE/hLun8VAtSkTcR7jq?=
 =?us-ascii?Q?lXdtJIP3Yd+MI8kIRtRUmNL37EtkLcQd+DCGlWE/GNIkP/JqAeIfjr95DrLG?=
 =?us-ascii?Q?1lnxaQ/FGPavg9YLmaMMmWhkYwYhjOtfFBfMt04FKmJbjVn9hk3o+57/CUxP?=
 =?us-ascii?Q?PUZIlVJOk0/BiVM34S2FJWz8+t+hKhGxRcZgGnwzponFSIswd7HQPdjJcmPy?=
 =?us-ascii?Q?tkDDhRVrEAVykUNb7fsk7MJzkb+i8fcv1sFoSLYatiblT8FzsDv00SEpUiJo?=
 =?us-ascii?Q?vzs/n2afXJ280UvrDXySvtWPT6D5ubS4GsbO2lPEk2WUIRhx9QuLSPWBEYuT?=
 =?us-ascii?Q?Pjzwq+x5aQHZeVly2k7tJID19JCztOaiiGEapBV9BB6lW5MQ7HqDYzNaLc0B?=
 =?us-ascii?Q?lNkWV7zXO29rT4/4RwQVQXGtJo7NdsRMWd0GFrmmBoj0yhxvhBgAmLJoX+Ji?=
 =?us-ascii?Q?QvZT2IHIcvyTQb6vLc8scODV6mwPLLGWkReNogu281r8YI/Ij7DSfhL9r+Rk?=
 =?us-ascii?Q?QTF1/+glB41bJDPB8BFJyjTJABKuWzCZdhPtHbyc/1OJsguwWPs83phkBnvG?=
 =?us-ascii?Q?xJ8HFQphmREinFVvDb3J9rENDWrdqa6Z+ClLqzLEEdv813KN7TypiFu2MdLy?=
 =?us-ascii?Q?jC6RgT0OYRgA+OjHow7Q2xpXKnMADZ54ElY2QvauFd6NrbI9pNKiDIc0EIH6?=
 =?us-ascii?Q?GyRhgLXVXGK9NUjwvAuthOPUtOflMI/T5yFodDc6AXgTu8T0M6vnIft94VlS?=
 =?us-ascii?Q?GrZrCXdjxjJ6HIYgB3jHuwP/Q+/dEQadqUhiVZBAkFCf2+YelEeJ+o7beq5/?=
 =?us-ascii?Q?sry58Rt6P1WqnIx5RyvdC0BegIX1M2SbuxJ2eZ+qeeCj2vHJzFyep+0kNI12?=
 =?us-ascii?Q?W2hgdza75K0nQ7JDdnAfrWlcsTHNnPJXMHKTFuToUhHMlRHQeVQpgMh4Uu5l?=
 =?us-ascii?Q?VEYwg0vkEXoZxrwbLbPyqQrARzuPdYnymo7NEw4dY7zNazmQp9GIHPONZGij?=
 =?us-ascii?Q?bADtyhztgXtRmvfMeqTLpo5DzKd+EUy2VIa6v95Alj+POnQ7Ek2rL8OIjt7C?=
 =?us-ascii?Q?mng1p1sSlCgi0H68dsP82O3QP2yMQnJMpZMhSjCezZwXGdx9+249KI33/lzv?=
 =?us-ascii?Q?BpYwH1TRaaQToR8vxy6YLUHdkeSKJdlCWWijKxRCisRR/X0uPOGeB0x3xORX?=
 =?us-ascii?Q?VzzqQzfKg+Zc+VXHOhR0HDjx10seEAtWyqaByKbGnWGmOKO+/GpnhMwftcWC?=
 =?us-ascii?Q?UwdS4fdxbpPP5G9ug+VzDpN5hpFKYUPYk9iSgPvLoyVZnBjh9gvupEet1uMM?=
 =?us-ascii?Q?+yxGQr3GjkxmA/LETnscUiglATQZ3RwI4hvo23j2JLDxUccT2h3h/AMnvwpw?=
 =?us-ascii?Q?AsZ8pMgSOkeSwXGPMxYmyWuODQGaGIG53FgBlmvnY3dftwhNxd7wMAqbZzTL?=
 =?us-ascii?Q?2oIohNghX88pFSBcMiRj+7w=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e2a4378-e153-4bf1-8385-08d9ce957edb
X-MS-Exchange-CrossTenant-AuthSource: CO1PR10MB4468.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2022 08:46:12.6367
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1q+RXDeh7KyW8fzrhmYrFD5XMcGaEwhvu5LFxRmLvvZWWh1ef+XEw573pkNalMQ+AsNFuaMNJF0XTZuHM6bmGQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4417
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10215 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=743 bulkscore=0 spamscore=0
 mlxscore=0 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201030058
X-Proofpoint-ORIG-GUID: qbiZehFxNf-gW_Sr3ih5bAPZcbIRssNR
X-Proofpoint-GUID: qbiZehFxNf-gW_Sr3ih5bAPZcbIRssNR
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RFC patchset to reduce usage of global locks in kernfs operations.

PATCH-1: Move kernfs_open_file_mutex and kernfs_open_node_lock within
         kernfs_node.

PATCH-2: Use per kernfs_node specific lock to access permissions

------------------------------------------------------------------

Changes since v1:
 - Introduce PATCH-2 to reduce contention seen around kernfs_rwsem after 
   introduction of PATCH-1.

Imran Khan (2):
  kernfs: use kernfs_node specific mutex and spinlock.
  kernfs: Reduce contention around global per-fs kernfs_rwsem.

 fs/kernfs/dir.c        |  6 ++++++
 fs/kernfs/file.c       | 48 +++++++++++++++---------------------------
 fs/kernfs/inode.c      | 25 +++++++++++++++-------
 include/linux/kernfs.h |  3 +++
 4 files changed, 43 insertions(+), 39 deletions(-)


base-commit: ea586a076e8aa606c59b66d86660590f18354b11
-- 
2.30.2

