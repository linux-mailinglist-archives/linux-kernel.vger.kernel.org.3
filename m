Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28434B03C0
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 04:08:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbiBJDH6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 22:07:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231760AbiBJDHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 22:07:55 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B10BA1E7CE;
        Wed,  9 Feb 2022 19:07:57 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 219Nrheq008871;
        Thu, 10 Feb 2022 00:32:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=jLWQH5xQnaQj4lHyUS/aSmvSO7CQxCsZWp6vWW5E6wE=;
 b=dMCHAU/AqkDGF9t6z2ucmasXEzbqYG/IqhviO3nVpc8NOtoTV6ewcQcF45Qaw2NPFr+f
 nibQ74ftf12zGE5uBdh9P+61Af2VJXfBYZlP9ZCHCMxEuMhlx5pFqENvoSNnbo4VQB8t
 TG9bLp/scLRmeBPc5L4F9h4Cd3XWuKnG5clXbUoKGcdj75470eR3J+sxqr7EYj3J5KnD
 kzCSfcfleJECuGtwQdqOn3Gm/uFxG8XUdovLi5suYhVRLvZQ8lRuwoeuZfUlVomztjV8
 z2fQ6jvk6c3i7SUhi35p/4lBtMbed739CsMF83nugVU/C2xNzrlnSwo/USir/cAbLs8D mA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e3fpgpda1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 00:32:33 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21A0GbPF053614;
        Thu, 10 Feb 2022 00:32:31 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by userp3020.oracle.com with ESMTP id 3e1jpu1rnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 10 Feb 2022 00:32:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B3eagC/IRjdJfAQA28mTC1yW0N7A9oUz7s1ie9vDtaZs98mhVaswBi2cXpMAo25sse8ehD20AJRlZGhTVq+avXHXtq8uFLL+xX1PSTJl02TTnQeNvPSvZ0TT4s2L/aovETu+hUkEtPz6AVf1+CoaH3QmyFlcyhGqyDILZ02kgxh+fcJh+HCIBhNlXwfOGiSTbbj6fIO/bKEwPvrj3WGrgMTNtjZLqr2QtD80AiFtAEuxHFT3uo2U9XdD9zso8H3zPOEPoaSw6WhjPjQeE7ff56MA2JB0cO1unzDHnaYIsBqwsan37E4hk8GYY3chRBE9c7FtOS+rG3KNEpl6zoKalw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jLWQH5xQnaQj4lHyUS/aSmvSO7CQxCsZWp6vWW5E6wE=;
 b=jEzZuUa2EOAaRhp/ixJMF0Hx2A8X4hajbGLjdP4eZ0akChkJQirAwrR/B9IY2COCHz59TVXYuuA34I/L2wsnkL+tawPWINsedd8Vp5nFHHicgHzmw7Xq8jzNmM+fgPqB58NESiiNych2TzKwrJXccmQBk+fpIV32GhJ8UxGyWEYVMmMLpJb986vuvdaoM7dtdrLa+r2VWMKt3HyVrLUMcKfW+5XDXkHhPixtibhl5Od6asMSnBxFY6JLI/cwp8ikHZXQMHaNkYjY9NBtLTzQ5jr14Nk8tN/w1EqRQbo9h9gwAb3tjsDcs26H8HLikknWJJUtYy26Br9wN/2lJz0E4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jLWQH5xQnaQj4lHyUS/aSmvSO7CQxCsZWp6vWW5E6wE=;
 b=ELOeVYrelX8VLiZQ3VlhVf623Jcy0t5YqK+utYk7uec1pwX+8/gx8mX7Kim4MijgnPemAxz/4b8WWGDPI91BbCU4TqymViFOaUT207ycAn4hPO252TEG/hPRB/1bmaEskqd12CRicJx4EAb5JO1NU68f+PDvMv9q+em2eYaVM9I=
Received: from PH0PR10MB4472.namprd10.prod.outlook.com (2603:10b6:510:30::13)
 by DM5PR10MB1945.namprd10.prod.outlook.com (2603:10b6:3:114::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Thu, 10 Feb
 2022 00:32:29 +0000
Received: from PH0PR10MB4472.namprd10.prod.outlook.com
 ([fe80::94eb:56d8:7cd8:ca76]) by PH0PR10MB4472.namprd10.prod.outlook.com
 ([fe80::94eb:56d8:7cd8:ca76%5]) with mapi id 15.20.4951.019; Thu, 10 Feb 2022
 00:32:29 +0000
From:   Victor Erminpour <victor.erminpour@oracle.com>
To:     lorenzo.pieralisi@arm.com
Cc:     guohanjun@huawei.com, sudeep.holla@arm.com, rafael@kernel.org,
        lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        trivial@kernel.org, victor.erminpour@oracle.com
Subject: [PATCH] ACPI/IORT: Fix GCC 12 warning
Date:   Wed,  9 Feb 2022 16:32:21 -0800
Message-Id: <1644453141-1181-1-git-send-email-victor.erminpour@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-ClientProxiedBy: SN4PR0601CA0012.namprd06.prod.outlook.com
 (2603:10b6:803:2f::22) To PH0PR10MB4472.namprd10.prod.outlook.com
 (2603:10b6:510:30::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea16f449-93b0-4ee7-26b7-08d9ec2cd1ba
X-MS-TrafficTypeDiagnostic: DM5PR10MB1945:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB19455067D909D9CF0AF94A6AFD2F9@DM5PR10MB1945.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2150;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KV1tarckijER7Ymf3v9ZKYUzB3AOsbXIk2d5FHX6fxUCvuzu/i9d21P6yTCeiS4dHhKmISqen3BB0uF/NyYDrXQDI1PycDbAnz52qdAMDwnQhc5mCjtVUawtdAXnCygzQwJANHx/IsEpZA7VHnCb4itrnASJbgiVhMgoCyPlNCruB0zkcF3XZAC1+OnF9495qFOjNJke2wzR8Qrypwhn140US0vSAf7tJuLzTKQIZSK6t/OLGZ0b92KgHOahdJumu1QAvw7hqqGcs+9KtQ0T411lw+p+saOYoC5qesFlSl3uE5Kpk/c18JjQP/cKhwM1RiHif+7zplVCHfoAE49wnqd2I8ks9BVIFg2hNiF0CF4w9YhDrcNNsAwaHPlZ1enSknbxOb4cGpwSuK2K5QTfnPQIkxT98yPJAYHEJcivdZTLeYAa/GnEeyVjW2VpLI/tifV07VRSt/VuF+FvWmNHM8C4Um/Y6mPo2knjoXTFWhKzDhkcPidT1lxWmKr3mPjVvm1QwR8SLyz21SZQw1LGMBS1HQNp+Ak3okuaTEZPUYT7DGcUaJUJnf/2q7ZletqBh4MqHdhab8WhZ/PMw6v4HFHOSL8FR4crRz+TmQXIAt5ruZX56tfoC3iuLtS1XQoW5BUAYhFj7Vs4au7o5fMiM7cPuKSoj4FDxTtjCKEbUu7bWqm76alV2uB8QUqOeX4yXgxHC59ypzASo4M/AQtNPw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4472.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(4326008)(66556008)(6916009)(8676002)(316002)(8936002)(44832011)(66946007)(66476007)(36756003)(6486002)(38350700002)(38100700002)(186003)(2906002)(2616005)(6506007)(83380400001)(6512007)(86362001)(52116002)(6666004)(26005)(508600001)(107886003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9nJmncIor8fm8A6F4wnXLCFSgBKSqqNcXOQ5vwsp5KBUmoVfF4J+Gjj3xDOW?=
 =?us-ascii?Q?7jpxgC9O83AYtjKt8AlMFLHQOq36NRjrlrBGO1NO5EPLiHAOZkWC9izjfNDY?=
 =?us-ascii?Q?7ig2wKWGIeo9VoClT41XXljrUX786cvmev2Ete0yjX4hyNlWwxd9o+Pxo6ZJ?=
 =?us-ascii?Q?Z0BBKCIvQO1nW+Sz53cb8HHMLJsGnDEUMGL+42aK3v4GvsQcRXgXsvMTv7tv?=
 =?us-ascii?Q?QOjKxMxpoOhyQ5ajSN6vJ9EpjQRqXfIuF+TZXZUrMSq4rzzVrGJmY8VkJqw0?=
 =?us-ascii?Q?DdbWUM7YwMwnVn5dmECOdvnfBBWRtZ/LeX2TXYfpxG/qWe9KViKucF/7aguW?=
 =?us-ascii?Q?3yW0YSpqjLWUm1oAq1Ko2PMSgZMBCHIqcQBJAEzAlCiWyRiJVRtSNJpGEQJC?=
 =?us-ascii?Q?Ik0QPAznYX9/435kAx3bKxQjt31uD4ztwuylb3erSEb0m7zV5DjFnLDn8GC0?=
 =?us-ascii?Q?8bCRNpFppzuiniEpeW8BkcY+zYHAnaeG+yAneCInUSHFuDaE43LMkLV+FKh/?=
 =?us-ascii?Q?1VH3LNTufew49xOYDjYvkCZOfnQiZFNUcMnnp+8/oJDQRPcE4OuTsNMvA90R?=
 =?us-ascii?Q?407IqA9ubrStITSAXZBjAjFTypn1JSSBLXXm0bDvhKg5y3VFlCYJYzaOHcvS?=
 =?us-ascii?Q?Piaj5ypivlTry8JWPpx9VKODJkPH4QQGmKF+fXn7LnuvwN4dxfGdBtyPuOD2?=
 =?us-ascii?Q?MRlZ8aH5djPUIITSaAKuQcj9dxa8odzYHpSYfP77Ktel7oyamgGzXdsLN9+D?=
 =?us-ascii?Q?aK0/zn+o23w+qZLIIEW9IA7JgEVrSXKqeGNyR3png+xAMZpIs3eSv9akbowk?=
 =?us-ascii?Q?VD9u2ScKTdzttpRH2rgds5pdNTuZXKOBgKOxSnoD8qLMDGxjTJamgf1FyaWA?=
 =?us-ascii?Q?fUOTv9CW9OBHJmWMznkP4v+rh4ZAERIT1oOjnoSEMgd5u/RzChbghgCNwnNI?=
 =?us-ascii?Q?RpdSuK5C5spqn4uobZftcBz8xBb0MUnBS4M9tUCPEv3xv17uvAxPy8JqMkrS?=
 =?us-ascii?Q?qHi5t1932u5W9JZbSPG/slyLSt+6o7IV7Hfn7ax0DLG5fVSNWzex4XYPLP2N?=
 =?us-ascii?Q?bF7/V6y2QasVGESpyjXPwLYk+BKyi0/KPaX32g8WblxKWnOd9Auy85Amsx27?=
 =?us-ascii?Q?g5t28dnvFROe0a5pZRE2PZQDCnfMYZsr0CYeD43g0r8XZeSsTA8JKcan0k61?=
 =?us-ascii?Q?Q0H7V0iLBt62Q4QFy4rKT7yJEx5JiCq19zq1vEJwM+qWE+lbETINktx5qEu8?=
 =?us-ascii?Q?47YAhq7XYiH9kcvXU8DvlfGZrBzQuy5Nr0JQT03aHSAkEc5GXmhBAK6I3f8F?=
 =?us-ascii?Q?OxMg7LF/ixSsVF4VwUqYradDOh3lGiz3m8el74yLXO8CBoQXJUU1gNIgJEYW?=
 =?us-ascii?Q?2k5wQroiqxtV67YmOYnmVa22lyD42icotCpI1HPZx93W4HgAmJ09UEcHL4Wh?=
 =?us-ascii?Q?T0NjXTG4C+tOpKF8VgSvQ0Cu77eYBQn/N1Sh/ePEOUZCA2PDpRog/ilF/7Jb?=
 =?us-ascii?Q?Pxk+nOEMtYDOt1Rg58U/Us/AOcOYqFs0UpIOnLWSj4QLCREulKL10GsYN0ep?=
 =?us-ascii?Q?3ViOgAJWY0wxs2W8bMs6mG41YWjyPjLojJCVUktZtmhAGhdy+xOUSgIMj6W3?=
 =?us-ascii?Q?Pmd7w/FYFVmE9lS0lpnO4gzbsaPAAUYCgL21V4dBXArt0ldN89j/S/3Lwcsc?=
 =?us-ascii?Q?V9t6Pw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea16f449-93b0-4ee7-26b7-08d9ec2cd1ba
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4472.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2022 00:32:29.4751
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ivn6WDo0al0QIIEnctOO6rB6QP7WBfR1JSQM/m0PtOjy0Mvvf8AhXnQR+vkpZ59QCX5Y+7MDQGkPM+6QHqlu6KEs5IRAF45OWIsekOuAjN8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1945
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10253 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202100000
X-Proofpoint-GUID: 2KwHeknjWIMBVZjmDCpT8Pe265ydNfIs
X-Proofpoint-ORIG-GUID: 2KwHeknjWIMBVZjmDCpT8Pe265ydNfIs
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
 drivers/acpi/arm64/iort.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 3b23fb775ac4..5c5d2e56d756 100644
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
@@ -1667,17 +1667,15 @@ phys_addr_t __init acpi_iort_dma_get_max_cpu_address(void)
 			break;
 
 		switch (node->type) {
-			struct acpi_iort_named_component *ncomp;
-			struct acpi_iort_root_complex *rc;
-			phys_addr_t local_limit;
-
 		case ACPI_IORT_NODE_NAMED_COMPONENT:
+			struct acpi_iort_named_component *ncomp;
 			ncomp = (struct acpi_iort_named_component *)node->node_data;
 			local_limit = DMA_BIT_MASK(ncomp->memory_address_limit);
 			limit = min_not_zero(limit, local_limit);
 			break;
 
 		case ACPI_IORT_NODE_PCI_ROOT_COMPLEX:
+			struct acpi_iort_root_complex *rc;
 			if (node->revision < 1)
 				break;
 
