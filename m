Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEE034DD088
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 23:10:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbiCQWLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 18:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiCQWLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 18:11:20 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0ABB1FB518;
        Thu, 17 Mar 2022 15:10:01 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22HLY7Sa022983;
        Thu, 17 Mar 2022 22:09:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=/kTBvFUOeAsOHDBzP37bM/e4lhHJsjB6uZfOI/ZMR8E=;
 b=q5JIjR0Y522EQ9ZgoPXoiqH1XHf6u4hb8R1eSKKYje1YjC6wBCkR0mbE6IL4w91Qa0Gh
 h6ysKg8zYfpElq82um7j3YugPzGqJEaBNq8+odioUe+H9vWK7oCh8COJdyY/9bygzOTI
 ZMu/qrU6fvmpBBReYJ0lJFcLV6aOnmOPl3628ubMZRMP1jt8C/6ZNyujz3acM20g+9Yw
 adkVSBPCrCEl/kPxEuvb49H4D3EnKhjwtji244XxXqocjk5tHRZVysHqAnNpDL2hutNj
 JwJLBj1ZXbuDosmemstnCKJ9esOjSALrVZxmc8Cqvly3NF4KH89reDE2hcMyD5twDT7S 0g== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3et5fuat6c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 22:09:44 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22HM7crC160142;
        Thu, 17 Mar 2022 22:09:43 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2175.outbound.protection.outlook.com [104.47.56.175])
        by aserp3030.oracle.com with ESMTP id 3et64u33br-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Mar 2022 22:09:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LtTgdZhSuhcFwVr03mssj1YEQh9C5BvT1iSxoV4ko1qPG0AoCPE099N0/uBU9O5ZOzggjI6Iv2l+Q0RiZxrOEMfyePovjn7qj/dgep2xYTuOdPFZBsO0CsxguCD+2lNrYCkHmnnWK3q03gfyColjR0qECM59MpN7HxWRxRK7eI/1FsM9kv/ltUNjONAFcSHsvxkhLgl1dPovKvFn692hv/WACR8WE5ihWIGHxW0IbtECxXjf8ARYc3uHBvul/l3IVJz+ieHhwqZMPSXF6fiXBwirzlaUlwzvlVr4Jt2nkmFV+k5kGFfH2175ugnFkrJcJVq0ps2vfoj5973I6LfG8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/kTBvFUOeAsOHDBzP37bM/e4lhHJsjB6uZfOI/ZMR8E=;
 b=UpczpwZh6hcEl9MJ7sSL61J2hHBDXj3LPNwtvYEP8ZLOKl715Ykqz5i15GroFSakIFqLUlOZH2MuArMEQm17i8Qe/PTXwDRuxVLIw8w7CYiZaxCoOGWiBJut/ggrajA/bidDuSbTpuZIdULCf+K9Fsstk3rBxXniF1QaQcZHHXmuDvCuL02pDcF2/3DOJwRemUplX55lBJYnM6FD8YcUzz8Ph1Va8dZ/78oYnbqd4u+aE0LGnOLD5+YgY9UqCNahvDo+QNU/SKqtsvPMPTP9EHbVfGOPUqgNvj1LDuzYgAb2DKwOtbNep2IIgeAdDExP+fcUZsjMLdioipIyPOxgTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/kTBvFUOeAsOHDBzP37bM/e4lhHJsjB6uZfOI/ZMR8E=;
 b=KmjSnC/p1VMGeuQzxp23bVDH8WRNVw1I2cXas54DD6yhhUFgEoFiJGzxTiSOXYtzwPpQAd6BD4AHhISaJJGwDOPRuvds6YGoCxEVo0ByrqZOl0p1+A3WEOm9/CTxQZtkik7gPPdxXew+M+j26IZsmZxc7egkbpsnW6V1/ii7bq4=
Received: from BYAPR10MB2663.namprd10.prod.outlook.com (2603:10b6:a02:a9::20)
 by DM6PR10MB2892.namprd10.prod.outlook.com (2603:10b6:5:67::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Thu, 17 Mar
 2022 22:09:40 +0000
Received: from BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::a0d5:610d:bcf:9b47]) by BYAPR10MB2663.namprd10.prod.outlook.com
 ([fe80::a0d5:610d:bcf:9b47%4]) with mapi id 15.20.5061.028; Thu, 17 Mar 2022
 22:09:40 +0000
From:   Dongli Zhang <dongli.zhang@oracle.com>
To:     linux-block@vger.kernel.org, xen-devel@lists.xenproject.org
Cc:     boris.ostrovsky@oracle.com, jgross@suse.com,
        sstabellini@kernel.org, roger.pau@citrix.com, axboe@kernel.dk,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] xen/blkfront: fix comment for need_copy
Date:   Thu, 17 Mar 2022 15:09:30 -0700
Message-Id: <20220317220930.5698-1-dongli.zhang@oracle.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: DM6PR08CA0025.namprd08.prod.outlook.com
 (2603:10b6:5:80::38) To BYAPR10MB2663.namprd10.prod.outlook.com
 (2603:10b6:a02:a9::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 92529182-2eb4-4256-3029-08da0862d56b
X-MS-TrafficTypeDiagnostic: DM6PR10MB2892:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB289274B64CF705B3A512695CF0129@DM6PR10MB2892.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C/+o8/S5Uk9IVmkwomADeUWGCXDafov+tCJgdw7ofwoMk1L4SfFCZbHlQyQqvaBYPQIRGoQsH9JC7NLvKKX8bVanO76tlH51j5q+qO9NB5x/ucF7HgQWjzYcgna5kOYldnGUwlvVR1n//LnMDwe4rn2spLxcDjqaeJm5zYGP5OZCrypxYJCY60fRXVyKMHkbgHjjJI1BnAmsKQcpx/b3L6hcitbF7gVC+SMWFy3o5QV/sAnVm1IKf9NwJ0MibwN67G0FIi6tItoxEj6EirmJZXEMX7wW5z4DiOuBPqh5yVdQbu055Xg+a2hb8aA8+fkB58HSLYUDemO4Zx4sSGH0P49Dr3SghLMCxnp35zq7NJEAli++6JHw+M3iUnjKLFYU4tR3nVTPAh5gfgDAFraQWheNEed6eTGHNuctWGu86SR63mCVoZMMn3xghzumHI5WuhP+rIZWMhKS/qf9YTCQ0UkegrG7u8cPmIFwae47oFKoB7TeYCPFZZ0HNgiOGVQoSSn75fODyr205Pz36gBEYs1mGRDFrjfj2nopRViJ54f6kEkylZdbtj+bFCvzrl/GFWNlelUfSFA5D3Rg9BzxGazuMk5vnma0F7GYEY31RoyynKsgdX1HoV2WITHbHN149gNjf6Ft2IrUbg9iqjYvebvyX9L2UpOW03iozzm8cYKDg4trNp06QQNf0AzTYo/4YwXINz3amXw63Jyj+iffJg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2663.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66476007)(66556008)(8676002)(316002)(4326008)(6666004)(2906002)(86362001)(38350700002)(38100700002)(66946007)(508600001)(52116002)(6486002)(1076003)(26005)(2616005)(5660300002)(186003)(44832011)(36756003)(6512007)(4744005)(6506007)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?d6Ux0QHB3/e7nLmX9qBEOby3qdGHSHTz1204PbSWA5VvXKoR418MrZ3kx3oi?=
 =?us-ascii?Q?66GttkmKrnc2WLLQTgCCN41eX7/kqrLMdI54sJ5SDyf0rxc/bfuaHcD64Lrl?=
 =?us-ascii?Q?wMXDbyH6lMr/GGA+iZVBZd2y64KK7TNX2B6I8LddhMhnsneeKWwxg+eTvs08?=
 =?us-ascii?Q?LvP6OquimP7vRmXBGKr0dDHRL9HkKrgQuNqZWaiYkVR0zVUtI445gXjedqEY?=
 =?us-ascii?Q?zTCcJxgOAQ2oB5DgLKUuQnVdKNup4UK7AFHOE8T3RH8r0rvt2iA2zU88cS1j?=
 =?us-ascii?Q?xYAAcMzzAmjA7ymg5u7gJ5SgMNGtjvoQr8E1sMaFmtPwUgJULQdWA5HWKLoj?=
 =?us-ascii?Q?drtb2RUDQPSIM680bMl9S4mJMZ8rp+Ps7EGhTvZ65jxPsLLwZi8iQoUU3xUK?=
 =?us-ascii?Q?o2zh5Jj3bA69AA/pGm/ousHZbqpaPTW7BR5K/o3EBGP8oxR8k3c6fuTnpr2c?=
 =?us-ascii?Q?FiDym8XTE0A/1F1QcAd10dFfDttt5B9z68yoeQl87DkPguYCiXrdLtSYaM+d?=
 =?us-ascii?Q?H2dAG3qQErSbRcLLQFno5Lb/dAe8hjXeVEp5zftFSH0EI8PJ05oGOexEPTqc?=
 =?us-ascii?Q?bzQhOmBPM2UvwFKNDz5vi0asV3GZOEd/rGetWf05kXnLicZJfPpwKU86uKGZ?=
 =?us-ascii?Q?o3jzD4KKPfdQGJchwTMqxpbSwxDEqZOYhOsjdCBKc+TX93Dh4IhCUr0gOY/B?=
 =?us-ascii?Q?+5zBTS3hiTmvdKupUEDU4P+G09r4H7zlgZ9TTckd2iK1G97XQ1c1bdHzHsWU?=
 =?us-ascii?Q?roMuQvGv28qt+V10fCXmNW4Hj9AtIaQavZP4+ChgIFgo+R9LrWgE/5PG0yVJ?=
 =?us-ascii?Q?bo6l51YRjGJJKONy/KgeuOpiZML9F7cXycBz/NCspWftB+N3hFR9rbzi3z/K?=
 =?us-ascii?Q?Gm2CULQFWZL3Lro2d9lsO4QaI9f+A6rNlYDVPipcZxi52E32Kks8G/DC77B6?=
 =?us-ascii?Q?qaR0jG/gOaqSnjM7rIe974b/O4fBBLFZJHmUcq0GOJ+Ggqwy41dc25Oea/Bz?=
 =?us-ascii?Q?BoKJ+oadpyWxrR6OxGYX/NzCnhwlAdRJtf6/rniWNLaTvrqnITV49XPja5HE?=
 =?us-ascii?Q?x5vu5ePG2dM8XOFVYB8BZP8iOrDBn5hYtnys7bYo0K05ksb9QJmTafe1H9v5?=
 =?us-ascii?Q?DGFybMIsP5U+1B2aGJLnCL6iVZv3XAewKSFOFbdW56Wf1jeRRSaas1R/4ET6?=
 =?us-ascii?Q?BL0VT0Z2YV4nha9PK00S5SLXCBA0IrCy72USyBu065tNtS+6GQ3wxaC0blpy?=
 =?us-ascii?Q?VK5q75xlPwvs4FDzpwXsPwLgUAISWigV3Vrfd3CMHkGhkKv9Aimn3CHlsAbx?=
 =?us-ascii?Q?XJe1cH5OXeS5uqZSe/1KlCe/5oiOecC+2W/4FeI02A/px4LNCqJRrWOv4Fz8?=
 =?us-ascii?Q?RIsGCDZFgEXE8y2ZkU1z5U5mSLSJ4Ne876/CmbfU8TkP7OBVA2j5/tcIMWOy?=
 =?us-ascii?Q?hHDozeZPirL2Nquhki+BFeOgABiTR36G58mNGmxfBTvDMv8RVvkBFA=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92529182-2eb4-4256-3029-08da0862d56b
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2663.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2022 22:09:40.8454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HrSOxpsQfjQfJNVGjhH1N+UC1P5nmC+DPD9Okf558NmR3UxM/Axz5FCdwFvVcylJq1s3nKibNmX/JOrMunW/Ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2892
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10289 signatures=693715
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203170121
X-Proofpoint-GUID: keNzdS04akPg-lEdyBqSVlYd-LMaV_SL
X-Proofpoint-ORIG-GUID: keNzdS04akPg-lEdyBqSVlYd-LMaV_SL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'need_copy' is set when rq_data_dir(req) returns WRITE, in order to
copy the written data to persistent page.

".need_copy = rq_data_dir(req) && info->feature_persistent,"

Signed-off-by: Dongli Zhang <dongli.zhang@oracle.com>
---
 drivers/block/xen-blkfront.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 03b5fb341e58..dbc32d0a4b1a 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -576,7 +576,7 @@ struct setup_rw_req {
 	struct blkif_request *ring_req;
 	grant_ref_t gref_head;
 	unsigned int id;
-	/* Only used when persistent grant is used and it's a read request */
+	/* Only used when persistent grant is used and it's a write request */
 	bool need_copy;
 	unsigned int bvec_off;
 	char *bvec_data;
-- 
2.17.1

