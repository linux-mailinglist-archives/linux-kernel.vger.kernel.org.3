Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565EB4BAF54
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 02:55:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231396AbiBRBzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 20:55:01 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbiBRBy7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 20:54:59 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB76D3207D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 17:54:43 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21HMOThE014562;
        Thu, 17 Feb 2022 23:42:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=ke7oQAnvwnloj5cvdoqA9mijRVbumF5HUlIzURe1lnA=;
 b=JOwWdkSth8M5mKm4t/SRxppdS12HBzqygq8g9dSOSvxdWSJxCE6n7lJFPifzum3oCVUQ
 UpDPlIw6OQsM4cbhxsNKAaif5Rq6gIPGt7sIJXHu1UQbnEouH0Lmck/nwQX7KfpOF0fA
 uP81MeCPokbEDhL4vnGixQMXW4+T+677d2gXay0IKq/9Tf//L7MUFhIsAeK1vy2jbvqx
 teFdzvvgBT2KR5CmIvNFwqW8f7dtxf6o7zg5SN43Ht5eRtXC0MyuM2lwEwTtpaR2vQgi
 iEsmyvdoDnTZEpeljyp9ZqlYWQUjLVJmkx/0p5RSWm8bFVosbssC68WoS74VDNr3S7q3 0w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8nkdqs27-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 23:42:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21HNQpHs055941;
        Thu, 17 Feb 2022 23:42:33 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
        by aserp3030.oracle.com with ESMTP id 3e9brd2yd8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 23:42:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBbedggoZTka+q9FeBV2DZewQP34i/SBiF6Nq3r1jioWiiOkGzrdHDONn8fR9eZk6hPVUy5d1dmp1jYq5qVsvVxtaNtSrtCJGXJONleGPFYyvlIyoM43p6owitdcTxIpoXqioyVEzTgng7C78yhhqhh2/r0IFnk4Ep5krojr5Aub2McWTrZJ1lrtB9kDFVZwlf0efViX50hagVg/X4f3NtHmPYsCThHimCUC5mxclFNb2pH4MOMGCznEA0kTFFzYnhaojGdTnslxNhx0MjVA9yrZwJOSGOBfGgqtKF6C0VWxQRIr34C0Vd6Tqaky2xsb3Pob3gkkIUGQ43mPccHqCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ke7oQAnvwnloj5cvdoqA9mijRVbumF5HUlIzURe1lnA=;
 b=aYyH4UNXlpIzgVNDM+Ek1SDIBiN0im0FWZ8Muqzs8z2ZVyTuIgrhD3Ua1vYsA42Aop0vWD+rb5ujSLFqIhMeDDDuoi5frd4MUMb9EWEx01ScSrP03/YP5XFD/vmzQetGXpK0HUFQW3ehgrkSaU5g8PwqK25VL6ZkVDirzTFtHT0LEQ5olVYtoWiherYa1CMHTfJF+Gch+jyHfLkDnXTdjAd4iZu16WYDyDphmwSW2GQ5msg6PC/Wt6YW1TGlN4/OL2EqmBlM7/DOfh/bNP4Abf1ai8oUtbp0q5srx094y7ijm9w0QdyjCq9jejsIc0hKd738ZkYxcUfLrjgLF6gX8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ke7oQAnvwnloj5cvdoqA9mijRVbumF5HUlIzURe1lnA=;
 b=fNZU3D33/f+wRvV1+vNwV6VXGDkmioRW9dLj4vUzu4/1coXoVeFhQl0+GNDpKIPYVGli3OFvb4L/uWOBBTdcO3TAEqFStR3P3AqHqsgvc/YmvYt/sxfxiNuju9CugbAcPFRtTH0znyuwzUScYjhuXsNjDMfWCoi2BpyFnZpY1Go=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by CH2PR10MB4279.namprd10.prod.outlook.com (2603:10b6:610:a8::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 23:42:32 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1%5]) with mapi id 15.20.4995.014; Thu, 17 Feb 2022
 23:42:31 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zhenguo Yao <yaozhenguo1@gmail.com>,
        Liu Yuntao <liuyuntao10@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH] hugetlb: clean up potential spectre issue warnings
Date:   Thu, 17 Feb 2022 15:42:18 -0800
Message-Id: <20220217234218.192885-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MW4PR04CA0263.namprd04.prod.outlook.com
 (2603:10b6:303:88::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cc1bbef-9c56-4fca-9510-08d9f26f2a19
X-MS-TrafficTypeDiagnostic: CH2PR10MB4279:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB42795A15C6371EF4B36655C4E2369@CH2PR10MB4279.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1443;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uTat0LoIidY3BKjvIRqK3Jdn2I85q5xtbECMhF22S/xXdLxSLmXkMSdxZOSUr14XGEeUwncgnmSiSioAInfChsF5lmdHusASr2LLx+Pa5fBH5UIC6iws63YgYXqEC0+huFklMbJHLwd/kf284hxYdA6clUnG8EZYAN6GVfakIwr7o/KyaOU3+KIQfoJG0i0fDb7S+paTzb6UKCcoMTZQr/thZFi8LzWbx3QntUB4FJdfSXqFgcHWc+Y4kc+NP2a0xHtuJUeU0jRpRC+tSCsjgVjypA9tlYdvMnCeMg4oauo9T17e2NuuhbspdOGUtbPCdtjoesnhC9cXwzppdqiiqZTUp/EYB7nUn2tlG/tOMgbxg+uRZKagp35B5iFDTO1pIwE+AxSk36OEu2D6VAYt2gVg5JskGGyuBgs76XP1fStV+lQo53p/OOosYKkAsYDA4VGkbBW6JyKxpQvtdx4nhkJatGQyv82xrfyEZ5CkEwN3m7TQ65h4OEBdfSVWsnWtiCaobgPifQWlTlHDagXFS/cRiXk4duHLbU5SRJgIH6WmiidH7mnTlSbyGt0z5n53/MesF1al1GyrcK32WbrEm/UKIGI8XvHGQwNss9BzLxPVZwT/vs5cp2B3lnKgJ4dCeHfydXT1jIE/bv0XMHJ6xEeV+IstPfMc9NC00L0Ejh508lAAfJx2zfmMJtQujSMXXQra4tvT7goJfkFG8SWrSg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(66476007)(2906002)(66946007)(38100700002)(83380400001)(8676002)(4326008)(66556008)(86362001)(6512007)(6506007)(52116002)(6666004)(38350700002)(5660300002)(6486002)(508600001)(8936002)(1076003)(2616005)(186003)(44832011)(26005)(107886003)(316002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3HaqzvjVZ4bf0XnJWp9eBbNN0aNRrpXOkgt1gsBCG3rCaxMLkj8F5fvs4vDx?=
 =?us-ascii?Q?ejfdLUgBKSNPVC9gGB/j4D3FjENx7P7IsZYkdN5dSWpZH+sUWKo8RRXszroD?=
 =?us-ascii?Q?Nla7Zt9KRJxrpuZmdY6ztlJ4/BC5Z6lCn7DiHKEOsZ6yvqi4Obj1s2wQxAY4?=
 =?us-ascii?Q?9f4YYW1LKjPzfG3Iq6btq7TZr8RDcIqRCM+MXIKTca4t45VEQ+qzB2rWyHRG?=
 =?us-ascii?Q?8R7DyoqBdRrafmSSbR0rTJEJA4pY8rN0ei8S0vTD64JlhpexYsISf89J3Z9X?=
 =?us-ascii?Q?nZOcxkPc1lMudxRt/zmzFATyt93MB/NR4h8KaM/OfkHr3vyu4B/ROlH2DmvB?=
 =?us-ascii?Q?tkZYDe1sSSS8E5eWLLsjZZe4exorAZK7FLElHfXc8Ps0G4elv41mikkB+WkZ?=
 =?us-ascii?Q?hGDUJdSIRw5XKmUCdFSQaMF7ajNBPS/vwHUwx3Zo506U3jNWwgBd3gP0m/gz?=
 =?us-ascii?Q?X6DNqJJUT2C3Oao3yjoL+om104RHyEsmh+iwXXs9bN0bHDeFrjXRXJ8/gm9u?=
 =?us-ascii?Q?kmlP2XFciX3skdYO6MhOdVoNQWwWtyBa3ifaq0AaFELmDHgwocsAca0OL9TI?=
 =?us-ascii?Q?rR/L0k7r+pvmcH1IQMOnBRlEDELC+dcgU1tWGp24yqU9ZD4YrtJ2ahtWGoFG?=
 =?us-ascii?Q?5z67wihzKV6zorZkhdG6h6L0Nz/0IqJez0UtJnH+Nox3blODc/kX1LbmkzxO?=
 =?us-ascii?Q?DALOdecM+Mh8t23wfy4ad/Wu5WXYOZUye0cT4GYnKdgm550opLx8Ots/uD3L?=
 =?us-ascii?Q?2krv9LBxAr680r9m2i0FJHWW6trL4QKpLeePxkiyhd1rHQoR2O2jFvt5G5SN?=
 =?us-ascii?Q?XcLUdXfPdVqCNZ2m2lFDKTRlhKhyCFFdcond2VmVx3PgUZmIpZ9CdtliCBgv?=
 =?us-ascii?Q?0lHd0iDMoytX5telMXEkYp6HNSX3ASnUnqNzpLIHa6Dd2loJN9j2ax8V6CeA?=
 =?us-ascii?Q?csZVh5w04OfkibFbDvnK4yYVUXEVEXH/XnadCAUHcsdOVfOCAgB2Hxy1frto?=
 =?us-ascii?Q?lQ0kJxXyUO81ItJ6Y54FK5Xi5MsP0Otw6pbR/XJ+STWLvT3xsktucSPuh5oJ?=
 =?us-ascii?Q?eKbbXjeOIf7njFuWkGgZUta64Y6GP+c5YWM0jcRkNbUzl3jyRo5rTyaoNSYe?=
 =?us-ascii?Q?J7QxhksCOHw+h0zBVT8uhkDlPN4+FjX6aU4ajn1bbP9S2JajmMfkX7/QF+qL?=
 =?us-ascii?Q?To4Yk7CpIbXPOX2SMKDEDE3dOG1IOZZrsFaEyFoZ8rpO3HVrIZCYoXEOIxJn?=
 =?us-ascii?Q?VqC9tTFeMTtA0WFBaSSsf3Vbs685CYzKGwyliSxpbkf7GZ62bHHgTg+cm9Z5?=
 =?us-ascii?Q?hrLxq+tDYsimRlShxZm/siFE8607ni1+DUAPo1hjN739VCSrhvOpLZRiXnCG?=
 =?us-ascii?Q?ZWBXG166327u+ypnTvwi3v/00OzpkI6W3Ub9hXmE7YLrzect1kQBekwtBy7I?=
 =?us-ascii?Q?WTC4I//njCVaPkVSYeyKun+rtchy0sY4y1eaYbvJ3C9JWoHypMD0CvvBLSAr?=
 =?us-ascii?Q?em9kENwrzsNwVkC4ei/2y3lBNWFv13dLcVLN2JZFLLEHY/Mx3V7L0aEP4hJ9?=
 =?us-ascii?Q?1/by57VbQQdPVvdgz2FHdsa2uzD0x5Nrb7lwZFtl2fOuXXtYFvjkhhr+h0Cu?=
 =?us-ascii?Q?JCcj+vmzsWLl7seR68+lBIY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cc1bbef-9c56-4fca-9510-08d9f26f2a19
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 23:42:31.3121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mu+/Q0PfB70pdvW1XB6u5mgY0MntXJSZPQ3IHl7TrYQDPqspUi2YlD2BFUomiHRST5CWJ4ySyqnoV9JczSz1IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4279
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10261 signatures=677564
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202170113
X-Proofpoint-ORIG-GUID: HcvNx5Gez_CMHpS1F2BxO8gO6AJQQZx6
X-Proofpoint-GUID: HcvNx5Gez_CMHpS1F2BxO8gO6AJQQZx6
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recently introduced code allows numa nodes to be specified on the
kernel command line for hugetlb allocations or CMA reservations.  The
node values are user specified and used as indicies into arrays.  This
generated the following smatch warnings:

mm/hugetlb.c:4170 hugepages_setup() warn: potential spectre issue 'default_hugepages_in_node' [w]
mm/hugetlb.c:4172 hugepages_setup() warn: potential spectre issue 'parsed_hstate->max_huge_pages_node' [w]
mm/hugetlb.c:6898 cmdline_parse_hugetlb_cma() warn: potential spectre issue 'hugetlb_cma_size_in_node' [w] (local cap)

Clean up by using array_index_nospec to sanitize array indicies.

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1f0cca036f7f..6b14d0791cb4 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -31,6 +31,7 @@
 #include <linux/llist.h>
 #include <linux/cma.h>
 #include <linux/migrate.h>
+#include <linux/nospec.h>
 
 #include <asm/page.h>
 #include <asm/pgalloc.h>
@@ -4161,7 +4162,7 @@ static int __init hugepages_setup(char *s)
 			}
 			if (tmp >= nr_online_nodes)
 				goto invalid;
-			node = tmp;
+			node = array_index_nospec(tmp, nr_online_nodes);
 			p += count + 1;
 			/* Parse hugepages */
 			if (sscanf(p, "%lu%n", &tmp, &count) != 1)
@@ -6889,9 +6890,9 @@ static int __init cmdline_parse_hugetlb_cma(char *p)
 			break;
 
 		if (s[count] == ':') {
-			nid = tmp;
-			if (nid < 0 || nid >= MAX_NUMNODES)
+			if (tmp < 0 || tmp >= MAX_NUMNODES)
 				break;
+			nid = array_index_nospec(tmp, MAX_NUMNODES);
 
 			s += count + 1;
 			tmp = memparse(s, &s);
-- 
2.34.1

