Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D61744B1581
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 19:49:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242174AbiBJSrz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 13:47:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232363AbiBJSry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 13:47:54 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FA6CE9;
        Thu, 10 Feb 2022 10:47:54 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21AIkQsQ013543;
        Thu, 10 Feb 2022 18:47:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=zSaTJ4Ov1QJNHiRkuSe3LECoIAUBzUYYztNbdEbRMW8=;
 b=BccCn4OZHQ+uo+KJf/inItr7L2fJuBTbijTgYvu7HVen55jnZk7G/UenRduuJvbBOci/
 zfHV1ffXccKtIm2+cDkcrtivFogiVWhdE/e74tX0Q5r7m3SWyAr8O6QEohK3flhVmW6/
 elTg01fOSxkQc968YBnNr/TIWX4p3hDqtsW8i7OIp3o0whVnEdwL9FVm9FaxlZpHhHO1
 KxiJ0Vy7oju3MKf+RCWoqMgSDd8otTAO4AjzTTnlAoXDoKlNKVBmRfBqhz0zWqTS5kSj
 pHIihBkvL4huPkIrL6DOdSujO4K3JTz528oMijGyoxGOTY4/2kuBUZHchfLhDnipSnB+ AQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e345stwc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 18:47:42 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21AIfg5i126768;
        Thu, 10 Feb 2022 18:47:42 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2102.outbound.protection.outlook.com [104.47.70.102])
        by aserp3020.oracle.com with ESMTP id 3e1h2avn0x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 18:47:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AYtJFxuzjrGwNxFrffeDgNaoISN0AOoZPDRr9Zl0A78IFIjGGM9qWdDRB6XfHfVHDbzG6xY1A5RpiguBTe81KtLM6aIswJh9iJVALQTtT5Vua4g3qyqGa7fiTP8VmO/v/U9F5t8VzFtjAAkooEF9QbxGvoDUr6PMhWZaDT2djuSjuy8XhVpnsozMxUPyTwEPATl6bV+eq884G/B+UoorIk/8CEPy1UFOqFV5vYdKzDsv/dTzxZ0RbE6lZygGkqEwE/nuTb83bU0JIMfLtubtMcWA3b8ib9TGDdOeR1CQXAwvUMVMwALTEttDh8J/GrAZ8oXVPQtCUIiZHEc5XbkBoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zSaTJ4Ov1QJNHiRkuSe3LECoIAUBzUYYztNbdEbRMW8=;
 b=Y61mGD2sp6BEEECGTdYb3Bvkylm3tPs7rwvOTK1KqIb3mGSqeffUFE35i6NbXt70t74idIpFbNNiMf9jryoCeL5zlDmVxPEr0kkBh5hnRmZbp4Vda48Z4wFMLGa6tiBHuJasLKkGhHvzT2ZMvCDg9nt8psNUqpWXV3xginFZAejwyLwYp4f2X4Tn+RQQtkecbc20GlQsQrWQWAWJfif/twxw+LormJ2UYb2ufuYH55fwyl7p0DX3fXi6mmGVp/RD8iqkWMCFy4NRKRebXPnA1H21QVZMI/Y1Wfe+nusGUrL45ntB5RgQWJghD0uJLjGB63H3xKVmM4TyxuCfLzt/4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zSaTJ4Ov1QJNHiRkuSe3LECoIAUBzUYYztNbdEbRMW8=;
 b=f7V4cN8M01FcDflDhyZBT95UvnrTJ57crTBVbLXasc9JdvwUeqhZJvBc+TTSgx1TG6Ep/wN8jpssijnhByY+OFA9yl7jYfBdlAUcxUNUD+DUAAhPEpLlsVrbWhQD73AL8czhePya6mQY8xfHTLhCG/QrvVKruBzfnPYmNWYIfyQ=
Received: from SJ0PR10MB4477.namprd10.prod.outlook.com (2603:10b6:a03:2df::10)
 by DM5PR1001MB2186.namprd10.prod.outlook.com (2603:10b6:4:35::35) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Thu, 10 Feb
 2022 18:47:39 +0000
Received: from SJ0PR10MB4477.namprd10.prod.outlook.com
 ([fe80::c8d3:908b:a395:3753]) by SJ0PR10MB4477.namprd10.prod.outlook.com
 ([fe80::c8d3:908b:a395:3753%6]) with mapi id 15.20.4975.014; Thu, 10 Feb 2022
 18:47:39 +0000
From:   Victor Erminpour <victor.erminpour@oracle.com>
To:     lorenzo.pieralisi@arm.com
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org, victor.erminpour@oracle.com
Subject: [PATCH v2] ACPI/IORT: Fix GCC 12 warning
Date:   Thu, 10 Feb 2022 10:47:31 -0800
Message-Id: <1644518851-16847-1-git-send-email-victor.erminpour@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0108.namprd03.prod.outlook.com
 (2603:10b6:a03:333::23) To SJ0PR10MB4477.namprd10.prod.outlook.com
 (2603:10b6:a03:2df::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2aad255c-11a8-495e-1c02-08d9ecc5d02a
X-MS-TrafficTypeDiagnostic: DM5PR1001MB2186:EE_
X-Microsoft-Antispam-PRVS: <DM5PR1001MB2186C57E6748B18FC8F7BF9DFD2F9@DM5PR1001MB2186.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Gtvxtscqw4YH9IkG+ym4ph2R9y5W60o++Q9osKd4NsfuJI9s48Uh1/74ludbw5b0GDwzNZ5CdbaiBnhnER07kA+3DZdVlH9rQywiLf+Wx4foAdA2RNSeb5pw7ruLluUYKGguK+JH4k/kcXJn/1YcFJVvIHR0ByzU1NCt/47sgJoMqoGMkUi9YDIleGOgCBz8M3sNlD05DFlHNT2KDJCzB8kLerXQuJN0QWBJ77Xqv8OsbMR4m3Z1i6+1Gv3kL904LsZ4eC2Nbs2nMVSsl0utaOGjLa3z87gWs98khc14N6Kv9qYjaJCGnrrx+vzvyHkHcOPnP2RsqIjBYSQBXJ7T4agvYc+5bL1Yu8vu9oabibPwkKYuoCnw1Msg4F5AJI3mwDCcffqicLaoRVnym4aRHXsqcSkg8V8zu6NstNmhxk8Z86oYG/rYPoWGC+9FVy1ft3+X2eKROcOg0Pw0dWpNEv6lFqZJk+XsX0xEm8PCo0gVlvbuLYNmSQBun4o2T+/I20++hbE4lFMwUuxzWjzriDPdv5dU/eSwtowSFE5yi5nR0L9zsbqEOaavaV5qkmrADbGlbIcjwadP1GuIdjjt58JvyFcErxTqkMrKoF5GatlugYW3lzt6oG/KZVfUd0FE+Dt1NkMXCjFEriiN/jlyGtpGZtHJJyezjwO09TQxKzLXFrA4Ot4yCTHN8toTO0b2KrEwkzKXhAwZ/v+TukJhxw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4477.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6916009)(316002)(36756003)(5660300002)(6486002)(6666004)(6506007)(6512007)(83380400001)(52116002)(508600001)(44832011)(4326008)(38350700002)(66556008)(66476007)(38100700002)(2906002)(186003)(8936002)(26005)(107886003)(2616005)(8676002)(86362001)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DX0CgcLYcV2YNYiLnud2UFV8F5MfF9TXFP/+tj4fWyihaVkR384HXk2PGcpq?=
 =?us-ascii?Q?u18cgNlKf73Y4cF/Kj8/vnVI2INI9ciLvLnTrrL1IthnJ+d3IBKz1fjuXm1L?=
 =?us-ascii?Q?kdrXXjYOFvk/fYHmP2wUDPQ/BYkn7oh6/w01HqlinHE8BeCTzzvdc6xAhsNu?=
 =?us-ascii?Q?Xk9R2JefM7gnk6efdWLCABQvaP7n07+jnTf+Na827iguWDY/5dqT8CPrsJ2D?=
 =?us-ascii?Q?wjJQBgDRkcv1Fz+uHO581khgzLPh7zAnChV+bbedlGcTMlYwzu4MSkDhV9nz?=
 =?us-ascii?Q?i/mI3n8bZfUXkOmR2KQSw21g4rQ3IzrAOOGsy2/T6Xxs/QgLs/TNawydvC9l?=
 =?us-ascii?Q?+3YDmU7SlxglMCClshzL9KSjA06JLNdh3k4BjEQpHo724WiC3ce9toYWoo6y?=
 =?us-ascii?Q?z9i9O7+CaJo1rQ87mMXzSbzu9WYT24EBC5L6E76rsZAg/BolpYr/V+/AHEPU?=
 =?us-ascii?Q?5D+DCj9fytmMjGMREwnfMtMXG5mLHP+xU9rNo4tLBH6k4WFA0v5Pw088r/nu?=
 =?us-ascii?Q?EfCmkESIIcogY3g+eENgpbh8PrkeQFpSMOHtrqD+fqR4BDz04+pkVprWwZTu?=
 =?us-ascii?Q?ywSyTdjQDvwjyhPnZQ/s+tk5Zrxjs15F90tQCXLSwwDm9KdN1MfLc5eChlAI?=
 =?us-ascii?Q?thJl0m8Oprky6Hc3N1uDtrDSoEqbRUJ8RP54RtHp4LTvLJMmVe/d0Zk99oug?=
 =?us-ascii?Q?mpgspK0FvPCgPpRsK+/+ukZd/ORKAB5LT19qQKb7Mnh2q8mliQp+lSU2m3z/?=
 =?us-ascii?Q?/dhd+hIMNCbd06PLWNbmo0DwblzF0103NiNVEjQAzrl0BtYhlmf9EK1G/qw2?=
 =?us-ascii?Q?VnrO15TU3yCgeiHMakzay/RkUtF0s6jEgF4A0BkwD+7CvYFjpr/9OU2zjYkW?=
 =?us-ascii?Q?0EaE1E6dhWl14h2Sp5awKo20pBAJ0Koj3g/JIEtrDhrx7yfyGl/pQUS5X5YH?=
 =?us-ascii?Q?5PWWTshMAFW+zGcKbMjNFdCm+wXKBA1X3wzfYgmIOtuVgqR7JHazVK9+msCQ?=
 =?us-ascii?Q?zT189FoYTSZdA//P+BAkb6o0qvfiNW3IS/Gkej00DUG1tZJWVtj+iPBdyWQf?=
 =?us-ascii?Q?HqWPf4lBJZINcuconsFVn9aqhD8uGhrOWuvnzAaqRYajza8Bei0pm5PbONlj?=
 =?us-ascii?Q?C64+Loc2nbmnmKLiKEgtA/D9OEaBqc6MixHboRScjxxAhbxNA1ly6YMFa+hS?=
 =?us-ascii?Q?PF5xnCkeo37HzKlGi5tNJMKlNeJyV0AiUXBYbiCNImtg0GMk+ujXQR+ph3MK?=
 =?us-ascii?Q?Xg2s5sh0ilZNdweVPjMLp5F5j2L/kML6e6CK+Jmj+EJ+OCPNcSzulWTquMjG?=
 =?us-ascii?Q?vZT2ujE7xsZoBzcSzEUAv0bDyMw9BIzelsPpnAJhS1bRaqJ9mB6dgqVWXl9X?=
 =?us-ascii?Q?cZ3R5FlgFZGeqXYemI3HkdExtBnyJo0y3kAE0YCyiqeQxcBtRv7vbWs7OLOy?=
 =?us-ascii?Q?a9Nhw5ackT3tRBgvkn9h5fVf/k0tvol5GhzXz/qKostXzfK2JmrAxCxqPStC?=
 =?us-ascii?Q?4/iZe4FBMO8FUYFEYlqskdqUMBcDKRWogxc8q8O/Kf0utsxjPXNOL42fX4uc?=
 =?us-ascii?Q?xw/UuG1o9ZFFdJqV5yWItZ+zZ7+JN9ouBW6knMvnOMz4tSkdRqoekL+rWf6w?=
 =?us-ascii?Q?H+Ai7LSCuDjiTaDWOKx68lR/n8j6b16dsOWJ6pMAoq/yQPzGOvSqrtpLN6A/?=
 =?us-ascii?Q?6rPwew=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aad255c-11a8-495e-1c02-08d9ecc5d02a
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4477.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 18:47:39.7737
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImG8EQirHYxK6Gsc24cU2vDqsfBMAXprPG3MwVc3/B5MVpAaG3xGeLPzLyAUC1oM+8NnNbWQh8Vwd6S8SqJUIhErPGkmXJ/W06t3Dr4OBZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1001MB2186
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10254 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202100098
X-Proofpoint-GUID: TG6MLlh5Tt6i7YDqU0x8GGt8lijvNX3U
X-Proofpoint-ORIG-GUID: TG6MLlh5Tt6i7YDqU0x8GGt8lijvNX3U
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with automatic stack variable initialization, GCC 12
complains about variables defined outside of switch case statements.
Move the variable into the case that uses it, which silences the warning:

./drivers/acpi/arm64/iort.c:1670:59: error: statement will never be executed [-Werror=switch-unreachable]
  1670 |                         struct acpi_iort_named_component *ncomp;
       |                                                           ^~~~~

Signed-off-by: Victor Erminpour <victor.erminpour@oracle.com>
---
 drivers/acpi/arm64/iort.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 3b23fb775ac4..65395f0decf9 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -1645,7 +1645,7 @@ void __init acpi_iort_init(void)
  */
 phys_addr_t __init acpi_iort_dma_get_max_cpu_address(void)
 {
-	phys_addr_t limit = PHYS_ADDR_MAX;
+	phys_addr_t local_limit, limit = PHYS_ADDR_MAX;
 	struct acpi_iort_node *node, *end;
 	struct acpi_table_iort *iort;
 	acpi_status status;
@@ -1667,17 +1667,16 @@ phys_addr_t __init acpi_iort_dma_get_max_cpu_address(void)
 			break;
 
 		switch (node->type) {
+		case ACPI_IORT_NODE_NAMED_COMPONENT: {
 			struct acpi_iort_named_component *ncomp;
-			struct acpi_iort_root_complex *rc;
-			phys_addr_t local_limit;
-
-		case ACPI_IORT_NODE_NAMED_COMPONENT:
 			ncomp = (struct acpi_iort_named_component *)node->node_data;
 			local_limit = DMA_BIT_MASK(ncomp->memory_address_limit);
 			limit = min_not_zero(limit, local_limit);
 			break;
 
-		case ACPI_IORT_NODE_PCI_ROOT_COMPLEX:
+		}
+		case ACPI_IORT_NODE_PCI_ROOT_COMPLEX: {
+			struct acpi_iort_root_complex *rc;
 			if (node->revision < 1)
 				break;
 
@@ -1686,6 +1685,7 @@ phys_addr_t __init acpi_iort_dma_get_max_cpu_address(void)
 			limit = min_not_zero(limit, local_limit);
 			break;
 		}
+		}
 		node = ACPI_ADD_PTR(struct acpi_iort_node, node, node->length);
 	}
 	acpi_put_table(&iort->header);
