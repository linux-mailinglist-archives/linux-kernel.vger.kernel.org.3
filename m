Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144304BC212
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 22:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239883AbiBRVag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 16:30:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233540AbiBRVae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 16:30:34 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6936400
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 13:30:16 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21IIg1As014495;
        Fri, 18 Feb 2022 21:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=1/zEaM+Ts47rz/J6NDbNkQvB9LZMvGqSWa8RdWYDbPw=;
 b=OEp2+wPja+41Dnt5DKGdqD4cGQr1oeEWipTWoPKSeqBXISynMB5zCo7yUM47Mr5xcReQ
 Lb406gV8QFzoHqH0Ks5BhUVciUfD+CLxRWSJNgibaRz7e+GKjjAxPFU4h4ahYsExsBtV
 mND7pe/g472/rxmIn6b/1bHv8bzrKwgu3B+4OwYDpwMOOlxgESRdUEFBUyM6SAG5kjTb
 6/vVZRk/DtY1G2srpq5jlbx6l6KNey+ks3NU6Gk3zGkiVvQVxm6aXgMlsxcAhO1/4qWK
 WfCee7qlfLGOdgPxkngMYtMJTevBvxSF8XEK02DJlWx7LicIHv+hSYGhZ1wkeWE3nMUU ng== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8n3e2txn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 21:30:00 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21ILGU1l135431;
        Fri, 18 Feb 2022 21:29:59 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        by aserp3020.oracle.com with ESMTP id 3e8nvvvc3w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Feb 2022 21:29:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nLnJUI3DOLpNEi9MmlJbzNrcAw5KchOyS9S6u/2DkRv48EE5Wgwb4qJBliPelUikJb8UxDS4wJd7DkWw1t9j9UrLUYMrZK+qLez/wrSS+yNrnRPcs0zy8cIRDSPUfwfboa2ZmaNUc26kVl2EF/oPY6qYHxGWz+cTrxDCAJ8OwVKR2QGjjf7NCI40fjyqCyaQCq5rEnKJIixgzM4x+/6JFx1wWV0vAsOeIRkj1x2YZbYe1DCCQXob43cdFkSoxI2mien0dEJhnCR/sXBcvJTCD0RUViqtIAVZUWO8DHhVW5g7LuNd2ABjtXa9ys5il72l6Pt594u7DNIqRioj4FETfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/zEaM+Ts47rz/J6NDbNkQvB9LZMvGqSWa8RdWYDbPw=;
 b=FnLbREIqDjKj0CvwgIIak8rbDlPRIHUX1sXTXYqpBfzJOWzlqhqozRI4lH8ZFlsuywXsaQn0jI7Iv3b72Jwh2CeUIc+o1YHIpByNKgoo+ZW4ftcyffpVgNcJBJpwFHKpOtNLxwh/h7XbSrIyYXpscFahn2fqo0My28TUA4NXpuG0gN9mf1iH9ckNr9JbphAPGBkEcvXIvrTbOsqkN9qbNefbj4dL/k+z4S6Yz4pEEM187I0dZRoM4gT9nTlCIVj0QN+cvHirO0J6Ch1rD7vVVbzBkRo1bESSl7v3CIdJtbHUXwgVHPdmlEuxSk8XCAP5uzDd1CMq/N736dSXE0fpLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/zEaM+Ts47rz/J6NDbNkQvB9LZMvGqSWa8RdWYDbPw=;
 b=XSNV264kjLaNEHB7jTto3dSklrJ7TYxHGbTVgSfINafGU5vWlOF4isSpcp8b65YjQwZccRB5O1SrsNx+659RF6TMj+2t++Bu2tnvLVicwpk10XQ6n/BkP19L+uZUdZ6yQ3k3rizvLvfxI3CoFGOeoDWoi5QDFQdDLuyM2mbDEuU=
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by SA2PR10MB4538.namprd10.prod.outlook.com (2603:10b6:806:115::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.18; Fri, 18 Feb
 2022 21:29:57 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::11f6:860e:575a:e6f1%5]) with mapi id 15.20.4995.014; Fri, 18 Feb 2022
 21:29:57 +0000
From:   Mike Kravetz <mike.kravetz@oracle.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        Zhenguo Yao <yaozhenguo1@gmail.com>,
        Liu Yuntao <liuyuntao10@huawei.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: [PATCH v2] hugetlb: clean up potential spectre issue warnings
Date:   Fri, 18 Feb 2022 13:29:46 -0800
Message-Id: <20220218212946.35441-1-mike.kravetz@oracle.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CO2PR04CA0122.namprd04.prod.outlook.com
 (2603:10b6:104:7::24) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b354c3ca-de97-4c54-242a-08d9f325cfdd
X-MS-TrafficTypeDiagnostic: SA2PR10MB4538:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB45383F955DB2FC17AB669DE0E2379@SA2PR10MB4538.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1850;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4mbRcK9ycAMTGfVX8uvaUJDfc49U1NHn9hBBljPzHrThxbOKw7XvUBvb8libvGTYPtELKAzUR64xp7CI1/wNCWzTc70af6uAQ6jGc8w5tljOzKAyKq2oy/h7sCXfM4hYrwvHYzF9ps0aL36r4FA7n2vFUUsxhYBGD1l3sscd7gOEsb4ZDqgot46NBPEGdq69PuvB8bLje8qu0EeJR6TJH4jRzNoMsPbq9fJx0i4AC7qF7TiEfIhZBf3KhYyTBLctm7MtnhGZ3U5yUnOSwc2gGxEvfMhhoahmD7T5Lp43Rf0H7yZ/HxDjzTOD+QvLiuCakBQsMljoD08NJb7iCbgM0gZj3QJ2z55MZVL3s3Byp1C0LQzOGPhpkG4LxCwqJ8wG+DlC989LULooXq5+vgxi3p61mGcGnu/o0w6nVmCf4jzox0lzOj8e1yBKweIJU2VNF40ee1YA/XlmMVXz6ceupsR4k7bPQvkDOHZJdbR0oaSjl6XCA82Nyh3aIrq54w05QsMYy5w+EyDRZN9mQFgS5HHU41rb1fFeloDKRkyDGlDZXRkuXd68Resez1yCm58YckLSkulzqxsWVBV/SgU/Uopw89/Oc50vnrkUIx3Pe6NqBIfGKgtSowbUMNgSU05sK2pXmudEhI2xL7Nq1Q5dsspClOAZFtLEDJ6ir/oBvcKYzVRkH1nJYfH9ZmK1SZBqMjQGPZ/BiTIUUuhRlOzjl0ufcyud83TTLHGf7D6t6aVlELdb0IE+gwjhTHO7+XSUvRmZHTbiwTKgiovAktX0pXYzY8+eKGfcnX9GsNRnKbA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(2906002)(38100700002)(2616005)(107886003)(5660300002)(6506007)(186003)(38350700002)(1076003)(66556008)(52116002)(8936002)(66476007)(8676002)(4326008)(66946007)(316002)(508600001)(26005)(54906003)(44832011)(6666004)(6512007)(86362001)(966005)(83380400001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sWERCIZUrqQQUnp7yHmGyFIQRjuvfZJO3PwJj8iB4hFiZzxRdKZ5PkaTjyEm?=
 =?us-ascii?Q?3yVVyY6+UcwrKNGYroW+rQDz1MM2PqmJGyk+HPBO+BmVdvmyr5I/5CbBNv7l?=
 =?us-ascii?Q?HuKZV+VlbD8wuCwltaSdStsEUqIJfq67/IhjtEW5P+Jv52snVpqcvCgCObCM?=
 =?us-ascii?Q?q9R8GUZBgQ5DRBUTK+ixlvlqkZkX4HOyNjs272vPQ7iQnsEZWzr+7goahZv2?=
 =?us-ascii?Q?9fiDq/cEhd5hDJZYnivBBRlmL3wtcQrH2c8ZmRgkuXHXOmecEBC5BRlQTULB?=
 =?us-ascii?Q?5pEgi1zXtW3ljF6Ujkwbuose9ausYIqe3Fb/6G7KITEif8Lb8w2KmFJbKPdN?=
 =?us-ascii?Q?NfHZpEbQtfmLfdghVC2gW4NhoPInM6R/S63Xl/CKnFuvpAwRMd9EjzroXd8o?=
 =?us-ascii?Q?DKLa+2GNgkcofJiU/UfSjfs+6Ah/T44qSu7Yo5l1X9DMdFRwGxXxVRM2bde2?=
 =?us-ascii?Q?Vf0LP9jTMoYeblcoYj5duw9MJOvDfBJ5risvEv2mmWXo1rHF/RephZGCacjh?=
 =?us-ascii?Q?BEchl49+wg1OjHC5+2EsIQ8zvLnWEcealLUoVJeTY8BCo/3ZyuFVyjggVUDi?=
 =?us-ascii?Q?dXusgiW2+QqVf461cKIfcNtN1LH+5btCtPvkX8djK6GLJ7L1AWuZZioznW14?=
 =?us-ascii?Q?PpxDTVNVhbp8eEfiFk0C9wPXiYw15BEdlXPwIp2C1WHpHZhinOJJYw4jFr3I?=
 =?us-ascii?Q?rD2QRkJUc+FJXdtxL/s0Qfa7LdDUtD5uq/bzLA8FU4kQQnNGO1B3GR11Xzbj?=
 =?us-ascii?Q?f0tR2ow7LTPUfcxjcx65zi5ctdQ7kaN2Jil+lqNDs+Ext/TS/8YcosIxlpao?=
 =?us-ascii?Q?8cQpmlD4KhG7cXoWR9O6vYg/25IygomlH3PFi0XL1RUpoc2e88+uNXd3f0NN?=
 =?us-ascii?Q?ltSTwtr0oZmfKdzvrevyYWlcL9XlH70vERGQ6bjszF4whA4inMlTl0B3WPkb?=
 =?us-ascii?Q?hLk/2Cds3MLZnmFeJb93ZJo8ooEKPms/dWGixnsNUkgZ8n0Bjprv1Ki7VWad?=
 =?us-ascii?Q?aya0+hsl/qLS8aEkX6FlWU472+BpJupa3ZrhUlKiS2eDZN0mMbOn9Fo+X4JM?=
 =?us-ascii?Q?ZukGcRqWWdHzY8mvl1vodg+IKU2Z4X9Uk5X/tR0W65p8GQ4az31xViL45cEq?=
 =?us-ascii?Q?bLzyWMCudFqXNn9Z2AXBUCWKqXHpSau04sngSOMToVwNYNyzTYCrbY7CAYl0?=
 =?us-ascii?Q?Xn2NPBJPYr4ygCBEwZU1SG7O03uHhDSE1hfNY0b2IV0WP1punrJt/N6oxV2C?=
 =?us-ascii?Q?FwyGvqVZ7hKYRlwklvLCysV7svKPGUxkdMrXm+loPfewBJMQ0BrCTQqdb4tL?=
 =?us-ascii?Q?lf7QoUznYOqAM9SRAQa1pm4j0c3d+wQ0JT7OvORzrmdrWmxuHxY2lIm9MQEb?=
 =?us-ascii?Q?/LyiwW4F8dkZJQNSyb2vaJvkYnP+aRm3fjpcbYrisOCgfYssi/ao75Eg39sg?=
 =?us-ascii?Q?w/nbjIHvNYLKw0Pz5c6Ub4xVIcwNA/1HfMRGogeZNg0ly76WXGR3HLwDBS/S?=
 =?us-ascii?Q?CwKCZSQ+AHD30w4/SIiA3dlJ3upJ9Fxjri1/dNviSZlB5mFc+/10+SWMyvux?=
 =?us-ascii?Q?zi9A7FL/vaKHThc+0OQyfpJYpKD3v5j0p1Eltnho5xBROTNTQhyEZZ5oFccN?=
 =?us-ascii?Q?XTgbUT3+l+wcnsjVFoydimc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b354c3ca-de97-4c54-242a-08d9f325cfdd
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 21:29:57.8226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hoMVHeWL1y2EznX95zmx+pQk3fzAN+cce8j+LEIWRwwbsLqWM/njH/UPsCvuzzYgkaLz02iSvz+Wr6ImgVYN0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4538
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10262 signatures=677614
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202180131
X-Proofpoint-ORIG-GUID: BALgnpFWc7pXhgERvYwFQq_MS6gNY1U_
X-Proofpoint-GUID: BALgnpFWc7pXhgERvYwFQq_MS6gNY1U_
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

The routine cmdline_parse_hugetlb_cma has the same overflow/truncation issue
addressed in [1].  That is also fixed with this change.

[1] https://lore.kernel.org/linux-mm/20220209134018.8242-1-liuyuntao10@huawei.com/

Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
---
 mm/hugetlb.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 1f0cca036f7f..55abf4e31603 100644
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
+			if (tmp >= MAX_NUMNODES)
 				break;
+			nid = array_index_nospec(tmp, MAX_NUMNODES);
 
 			s += count + 1;
 			tmp = memparse(s, &s);
-- 
2.34.1

