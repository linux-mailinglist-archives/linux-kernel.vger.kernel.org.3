Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94BB0489C5D
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236314AbiAJPh1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:37:27 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:34312 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235120AbiAJPhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:37:25 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20ADofHg020293;
        Mon, 10 Jan 2022 15:37:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=aJ5mQZaD3YVId4hhMk/O3PAXpOltJQZ958EujWjXQp4=;
 b=BGrnUdfw08dVAYMVeiSCJ40jdtM4uQuu4XxkQkjNfxwk90GbTYDYXqHBPMDEBvo39HFf
 lh5CrGwRK1PI31o3H2uOPSeId4d4ulkqwKlDfRkJZHI1wK7W3rFwS5dkGlkjV8DttYGg
 6uP1Cu1+reBotJa4GWs9CKwCuEan8snoBkxQlmV2ovJaTJq1nWCS72PMJQfiULHZDbvn
 dSiNpeUDedTipaHdny+dmapkRsd8+3domLdbFLYAkvzIzMvVGwhyr0BBf+fBjpFkrQ7w
 C8HkL1ij4r+ScJ9KAvyPTwgP+I7gEjTXz6TlGD73gexp5lgBFGkFn+UUVOz0Eq2eLCQb 9w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dgjdbru45-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 15:37:22 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20AFVZWk162993;
        Mon, 10 Jan 2022 15:37:20 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2101.outbound.protection.outlook.com [104.47.55.101])
        by userp3020.oracle.com with ESMTP id 3df42k4t38-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 10 Jan 2022 15:37:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c5nrslaI3BcoVYHAuWZpQeTtSrUXywTGmy6YC8xHCbZcm/ktV1dZEifsvEyv95e7vUuY27jBqusZG7+2G5b7l1ZQUEn4u8WvW0f51SjteBC3M7NJ7OTToSOXUoUTJKyqgch8dXPpcm6/l3Va6d11bocMnoz/djbocgrujNzQcxJeyXaEWdEGhQ8mQOk+XIqt/DhgeHOSZQauxO863Rlrk87KjrvJg8/dCPAZCMa53xn17phxLIwVvQ0KnODk7XJzmICAi4kJ+JW1u8IJ0tN5r1bui1wBMjpYV4a5LwloaDYbbBTiDql86Bg6jVSo6XsI9ZcEuH3tovkhTDoHZBj1eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aJ5mQZaD3YVId4hhMk/O3PAXpOltJQZ958EujWjXQp4=;
 b=oILZhAF/Cy0PqoY+n13UGFo2lmzsIELOzysQuEbwnquo91RqvMw/EVM2CHBBeyYcJW55E4dzUor5va1XLDGlLHOai2AGHDjXPaD4k4KicA4HckYsxrMAfLGi2YQyup+yJGkzLtRe53FzdHmsF1eyvFJfBUL1XZxZ3nmVDSqAENbLpb4J28cmLBlUhFX9GypeO6cxIyi6ahIGyPau9SmRpB/Y9f8IWtFfiUU9qYcRBXmaQ/pwpPfbXwufR1FRa6VnnqV//a+i/q93m6Mj4J7hDat/vLzSv5ZJ7Tt/7noP+Sk9TM7AuLVfEOc1kxad5FXEq5OtcG+D7oqXNYDi4ssBCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aJ5mQZaD3YVId4hhMk/O3PAXpOltJQZ958EujWjXQp4=;
 b=qV3dDD8JuwJAXiigcAFrxMWA9c1oV/qkKe67htfukpAZyH0O6IUFfymxCEHMvYAKZ5EXYySOvTD9/yYgT4/8fJmEjndxNhuiLzjhTc1gouxo2Yl7qpfL3uzSpe1kV6e9yCOCJtQ41diO592URzaqZPirQ1qxwatMO5d0Q4OZoSU=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4421.namprd10.prod.outlook.com (2603:10b6:510:33::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Mon, 10 Jan
 2022 15:37:18 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::1053:7ae3:932b:f166%7]) with mapi id 15.20.4867.011; Mon, 10 Jan 2022
 15:37:18 +0000
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     James Smart <james.smart@broadcom.com>,
        Ram Vegesna <ram.vegesna@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-scsi@vger.kernel.org, target-devel@vger.kernel.org
Subject: Re: [PATCH] scsi: efct: Remove useless DMA-32 fallback configuration
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq18rvntxek.fsf@ca-mkp.ca.oracle.com>
References: <958bcb2a6e86344c14f38369e8e7079615a2b0e3.1641754613.git.christophe.jaillet@wanadoo.fr>
Date:   Mon, 10 Jan 2022 10:37:15 -0500
In-Reply-To: <958bcb2a6e86344c14f38369e8e7079615a2b0e3.1641754613.git.christophe.jaillet@wanadoo.fr>
        (Christophe JAILLET's message of "Sun, 9 Jan 2022 19:57:04 +0100")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0082.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::27) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 25a794ec-4387-4b57-8092-08d9d44f15ab
X-MS-TrafficTypeDiagnostic: PH0PR10MB4421:EE_
X-Microsoft-Antispam-PRVS: <PH0PR10MB44212AB00DAE17F1774B56938E509@PH0PR10MB4421.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xoxb6EftOllmHS3Po4l6DLtWO1Yje+siZVgDCzFHQDzGOjIVLe8OqWl3ksLMN657osDketRnmjw+rYGXqiXDco6ochYQv2A2T+bNqe+vQywWIucNMuCYMspHGtEmIf/NH+BY+s6cf3U98vwcUsDv1yq3XGfk/lUsMzM587TKZpFZX6j6fRneSAP5zDUseeellj2SZNqp5VBWXadY5cIG8EfmsXx0IUgvMq/6IIKTlcR7rPTYAwyC/PC0jue5o+aYo909IyuYAD8iFZ+Q45ta6pDJm6ZypU86OSJuC4rhlebjWlLY+ZCLTepHVFS4jWYpQy1bNQa87ZjJOd+qrNZqNdcdBsqD4ThBS+YTMPNmVyl9M84zdgZG7Xw1xsjRzBM4vE2eL3mL+iX0UesFFLqD5FEREbDsARd/x8GzNUa9S+A0WrSb6M+IOGM0PxyH0ZWSzFHxpIR1E14Q5fn/HHl2mWMCNySSbXzgehg9I9DhRtGuxEiVFYL55A01Zor0bGW9kbefUeTG9sieMrTGJSBEZYCpN+DP8mMytFA3SzHKsHf8qRiJrChLrR2Z+Vc4vFvdAJB5xpxiZnjgrwha9uU0jxw1jYlDVMwYahFB75zLcWN2E/3Gfc7xXUw3deaNaqlLajawyRE471mwUpxKcmXJvY9MvWpt8fXlXETB+/PvV8VHsGHjak/z4OhnPsA3b4OB/1h/XlbZPjDWv/VRcT4l7g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6506007)(26005)(52116002)(36916002)(508600001)(558084003)(6916009)(8676002)(6486002)(2906002)(54906003)(66556008)(6666004)(6512007)(66946007)(66476007)(86362001)(8936002)(316002)(5660300002)(38100700002)(4326008)(38350700002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WuashqNHKHrLdGsCFgPyUG5nPMxLVnmyzjaNeuttID3u+dEyPOZz4HcbmGLk?=
 =?us-ascii?Q?oF/3EFYygV+zrF7xURolwcQcDjWFqnCqT60FR6TY0IG34a8Zl/XxjqYo0n2V?=
 =?us-ascii?Q?ibeIzrnTnq6OoUP9gUfCzPbSivlR2pXQzm69lAa0qDD/WF4cu7vzIVPorvzg?=
 =?us-ascii?Q?NYsbb6ctID3t5MxCFXa2m75srdU2qFUTyari2010ih9jGJUPlNNPCXRHZhlJ?=
 =?us-ascii?Q?GR0SVKtCXCZnkylWFOGkSudZF9Zea9C7/Dn8H4bIY8BhgqayUEtzKqIJpvoq?=
 =?us-ascii?Q?9vDSxXvNPFR8JXbmecCeKg7aW7OBeFxUsEgo2fpQhe0IhhPrtW6VB6WhHN1o?=
 =?us-ascii?Q?U5o8B+vriy3hgTnV26u23iLyyQfPJvvWlzQyj45Sg7Q0R+VNpgJQ4cvwrlQd?=
 =?us-ascii?Q?7oHlFJVXdmVGaEbRJHGo+ytEPgbk/R1RRY08C1ifiwP33saLK+RqfyNqnKhM?=
 =?us-ascii?Q?xfrPqCFf5TZTIpiYyKrQXQ/dx+qbJnXEDA/vYrRLeB5vjBMl5INPAVKWnEWB?=
 =?us-ascii?Q?RdMZVAUQggZcRGVe/UdQYpRSS2Iw92rBEqgP0eVd3IwLd8dz9jUJ2lnYlAGd?=
 =?us-ascii?Q?5xLD0Yk33LTfHgpWGVkeBz8czFUgDD0MXl1xf8jnG8/lNezXmjmn15kF+UwR?=
 =?us-ascii?Q?cMObJgzVSyZ3v3PhumDUymbcKhtcLzZnkkdtTj3sfjPK237ODKPWFF9bk5C2?=
 =?us-ascii?Q?HOg6mSKBilXcu1x63g+5eg/efHPFmowABZtd7rF+IuLkSOEI87Zt3QbsiyqE?=
 =?us-ascii?Q?9XDjqP81gwgJ3hSkFCgAwwyRlz/PS8ubpPrSN4WcosunCpjsZmyaydE3DfQE?=
 =?us-ascii?Q?88dM94EkaR4ga9ZliGBbTCVXKsVkLLHN/6ykk0+G/uaKEeRVL3AW2Rp3sZH3?=
 =?us-ascii?Q?lPWbTC4Pdys9NK6VMCxHqO12bZFxJTRF8Z39GSxo0L/MiXmPDMu7rHsP9eFg?=
 =?us-ascii?Q?JvGQwLLxs9xVRmIKSBN6iWt555HfbF95S5UOSmml876NZAsKaHOCizGE3Z9f?=
 =?us-ascii?Q?2KoQFa/QsnLTYGl9Wwk1EJ/OujN/ja9d/qawPE8qyXx61f9kvbnVOCdD2Vgc?=
 =?us-ascii?Q?hbMqietPWdxoK1ypKQ8EEV8FXZuMX0WAl7sO2Odw0lYGEAYfDqQGVl2z+Ao2?=
 =?us-ascii?Q?1bZZvEL6JWehLkA33BOoQYG/q1SOzZ2M0AUewhg9LN8yRJLx7UpcnH0LwDZo?=
 =?us-ascii?Q?SWa+gqqc9Q/w5l+QXrSGYSxSvU29eehcsHeTQ9tpjxP66DaXfh6n6pIh3zp5?=
 =?us-ascii?Q?B99bUXgIqwWnXWobvYGurweqMEGja1dmoSrwgt1wNCOZmunasE6OCRR2TPnD?=
 =?us-ascii?Q?k1yWvGI3xg5vt+07sfIYDWbTeb8zGjjg9UAdS5N+8mD7DYGiQ7AVB/aAni21?=
 =?us-ascii?Q?sw9RBQE/GTLbsLWJO/rPhmblTb4NG/Xg9F56ZZ/Z6UcLdIsTQdmmlZeKuDT0?=
 =?us-ascii?Q?pSGCjTEIbVBT5YkkNR3yP4NGkXmaj+bzE1qgzt/1NWTT7O9xqk6Mw+eA5vSR?=
 =?us-ascii?Q?ipo2kMAHmY5EO4wJLPHoEnRUCDlYNlrV8FVT+Rj9ARkgKXP0ZMrzIxPzXbVx?=
 =?us-ascii?Q?8VJM2iqeOz4u6T2cfQc82KLiYR2LVHPejdZUPHQ2pv+b/HXcDAl/CK24eVLQ?=
 =?us-ascii?Q?Neq7ER11umUNtBwEcU/BiZeNJInCd34wJUxoMFysu8A3ESK9W8dHykKcLx6r?=
 =?us-ascii?Q?CIQq/g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25a794ec-4387-4b57-8092-08d9d44f15ab
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2022 15:37:18.1482
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lEumW6h0YTRJC1w1645JerBY4J6jHyq43j1yRGjsBPvIKXnGb+qAIfyanFw05JQ9MtEGzenNZ2N6F6osn5tLJz4YJThZw/3HcW6bj1ZQXZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4421
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10223 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 mlxlogscore=992 spamscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201100108
X-Proofpoint-GUID: _G9QLXTjdNJXnInsP2M_P_47OLcFV3e6
X-Proofpoint-ORIG-GUID: _G9QLXTjdNJXnInsP2M_P_47OLcFV3e6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christophe,

> As stated in [1], dma_set_mask() with a 64-bit mask never fails if
> dev->dma_mask is non-NULL.  So, if it fails, the 32 bits case will
> also fail for the same reason.

Applied to 5.17/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
