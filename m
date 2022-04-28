Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAB051297D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 04:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241404AbiD1Cd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 22:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiD1Cdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 22:33:52 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5022780216;
        Wed, 27 Apr 2022 19:30:39 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 23RKx5NZ011324;
        Thu, 28 Apr 2022 02:30:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=kj6bEGgyrWQ/gKkXbcubaR4c4GLndnjBoaFKIhwYSuM=;
 b=rad5WQxsfrqXwLJpCCdt69T6e6iYvwj0H74QMsM+cLGRKYgeT60uasiXDPoJbX4cSeiN
 K/PQr72Xu096qfWngdyAGPGr4ruKYjFbfuTniqsG0c7C26phJF445g7HrXPc11Dgowp9
 HZq/2knqmS0AmdPPNCkMFOQOsIzcOesQZ2cHRbvE1VCAncEotFuqXdJso94oYmXj8PSF
 ZruOsnvJ6fi0lMKzRXQ2JnEWzT67gQ4oJbU+XpC9ec00v2tlXzidP7Ed0Sml9CcZH5om
 CHAw8DCA4TO8RcpOFY+QguIxRMr2OFAvJKNYCWEr/AXWhzvpBO3H6LCshs7sxMN6hNbt PQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3fmaw4js9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 02:30:30 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23S2A9a8027669;
        Thu, 28 Apr 2022 02:30:29 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fm7w5thmw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 28 Apr 2022 02:30:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOiX5WMLPaAfb8tAY/oKBjLZ1rpnI80el7XG6IptEHKhah6Bm3HfjgN0yrCBjcBligglrhA83RlE8CKCnwHcslCh2mhyT/ozEaoXLNUMpV0dUF+8rVdqUMF56MFM/GiLZOpEwzKPHFZrL/dllFrx+6PwL8esb8B9kn5f3VYTE7sHoeViiMqSCD11ZG/vgVYNJCeEcyWwoXpP/W+jyjIIjPiKQZLaJK6B/TbC5szjqrrZSlG6942ZDKUfVGJ+HJx/fWDQiQmVNpQfGqShv5Gw44D/9H4mkq/xqjx5qgIXlSCD25evBHQ89cLVXJ0rEmHpMQXp6+x/8bZKUsG4pzmtSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kj6bEGgyrWQ/gKkXbcubaR4c4GLndnjBoaFKIhwYSuM=;
 b=PPwUzK5XVp4PR4xmc8KJVYAj00LGMu0sNk49soEVyADayl58BStWGmlrvMTgLLBRumKg0orvLMQeYZHbXA+RKcY9WZg3d6tYwV8hYJrDUu1sNrg3dVri1f+k016kUWNCPz/8bo7fwktbFttMpCjJHiiwAv2XxPWtU9wvxmREW5ORtEaxMNwN0+a8+Ui84XGUmOeJgcjirWGnILlgVVHCIQ9oE1WRxao++6Uafa/CmPojS4nKNMCIq+fEplAirNZOvl+DqjnymMDvFtmxPKrplRqpKuxVjUFEPT7U8W6RvcMIZa7eX/76rq+ZzqygSCXQX0LdWycyXzL88CeF21XIqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kj6bEGgyrWQ/gKkXbcubaR4c4GLndnjBoaFKIhwYSuM=;
 b=ljlto6qAtAcAVikdbPwytJTCiogKoPTeD9X/aXXpI19b7CYHo+KpiGVpQIv8NW44y7fNSSTXeNOACnsQ23h+yN6bTFe/wukD+cW6TySUaI9qSuVvgTSCS+PC0u9aPKYb/+hHskdkNlF+ckHt0eo7i3Ww1tKCwFddk+dqYbKlpV8=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SA2PR10MB4729.namprd10.prod.outlook.com (2603:10b6:806:11c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Thu, 28 Apr
 2022 02:30:27 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::d1db:de4e:9b71:3192%9]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 02:30:27 +0000
To:     Enze Li <lienze@kylinos.cn>
Cc:     jejb@linux.ibm.com, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH v2] scsi: sr: add handling of memory allocation failures
 when calling get_capabilities
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1y1zqj5xj.fsf@ca-mkp.ca.oracle.com>
References: <20220413100008.522912-1-lienze@kylinos.cn>
        <20220427025647.298358-1-lienze@kylinos.cn>
Date:   Wed, 27 Apr 2022 22:30:25 -0400
In-Reply-To: <20220427025647.298358-1-lienze@kylinos.cn> (Enze Li's message of
        "Wed, 27 Apr 2022 10:56:47 +0800")
Content-Type: text/plain
X-ClientProxiedBy: MN2PR11CA0014.namprd11.prod.outlook.com
 (2603:10b6:208:23b::19) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 62ef4d6e-c2bc-4ee2-a7ec-08da28bf0e70
X-MS-TrafficTypeDiagnostic: SA2PR10MB4729:EE_
X-Microsoft-Antispam-PRVS: <SA2PR10MB47296702123AAF7D2A46441E8EFD9@SA2PR10MB4729.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NubMiS2JaYak0JoO/zIeb6WpGfKc0KESAZgnmM6euVOTS8N46j6nb8n2RckpTnR9VESbPI/iT39ozuDPW9s9XZeejZePJ10gCksTbv2ILiQCFuSzjA3mpAYCniR2eWi7GTPHyf0L58YmnqE8lXzyJA/kM8iWRVqdGGTmE2uXy8dNRzS5SqFN297GayYo6EIR+AnKK1sz90en0zsY7jL2WI3L8x8PCD5uz2ZBErus2fvWcMuXtXWz1ZHgiOqkIlIqOIh9C5Ta2WNM9uIeUrwow1Eua/0gfeaCMpVHlTOjafZ+SUOjVLDvXBAlnhnXrpVa86s5qu3H29wqkmXo7q2zFOiQcaPVgvM6JFC159jgBgwLq6hkq1my1jbrE4ZKtqPrQNnmVSuiqKgURFSuVgmJzObpEESSs8HXmz4iBw/ODIcesLQJQOgywbrLg/zwx98TbZaq2B2fR2w4qsKYX6dJ3oAiG7MryajNc7c9M09qaIZglRvmL5fsD1FdeAGVAM8rE4xnR3itDVM87TXYj397Yhu8pou/HmvR/qh9EOfjn4v0yOiKnYSPVE+Y/HHOXHIdlbMMtUdlMEx4/1M0l29q1qBBCs0YXxZDgltXLMdc1Ax9MbcLx/sc1gq1fwyI9TrndGgJyF42SedWXeQXEGmX7x049GG8JYnfGXpH7Cz15075PNbo5SzGTL5MU6zZ2WLZauoPQrkob64lrcKWyJTYyA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(8936002)(38100700002)(38350700002)(86362001)(5660300002)(2906002)(36916002)(6506007)(52116002)(26005)(6512007)(508600001)(6916009)(316002)(6486002)(83380400001)(66946007)(66556008)(66476007)(186003)(4326008)(8676002)(558084003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dK1lpeX5B4GZoFtECalGYTyKtGrJ8JObefymuvungpsXQhg1EhbfDMpXF4/u?=
 =?us-ascii?Q?QmcAr35AGMp9jp2/vZRlQhlAyPd61bEG874/vREkUjpATe++LST9sV2lJs+8?=
 =?us-ascii?Q?FPtHCnEeNv68bgcVuvbn+4ImXEVzE+yoFWDWkFyW2NxfdN/9sEbx+IYt/Kak?=
 =?us-ascii?Q?HBwPb9WQHlmu4WV09XV4kZ76CSYh1oUaCXeLGGu58yTJvTNhb8spXx33/2lf?=
 =?us-ascii?Q?aftY+3CU3IQ/7mSL7atcm7jqUU1ZFHYEVQo8WpeBWMgLcM+2FeljuLa4y7i+?=
 =?us-ascii?Q?62sgnDOVfe9f4ok6UkyGMTpXzOpifIaMlofc+owsz7KkKsnR4oLb2RJZExXO?=
 =?us-ascii?Q?MvD0J+uZwOKlXCYtyDZv1b0duzdtKiq0xk8wFwGSAnysmVeQ5rgOwrLP/0zW?=
 =?us-ascii?Q?b2N+C2GEvdtLsIHz7Y6Gx7JCQKdDGmfo9E5LH6FR+A7aLOIP7gX4giHJJHi9?=
 =?us-ascii?Q?rDWy3jE7tcC2t3NNCllXTzKiAR1F4l2B2aie9sun3Eph3UC//R70Xr72GEUq?=
 =?us-ascii?Q?EBgDuAk1E+T++pHwJlfRGL+2x6vR+U94w/GgkljnHw4ZFiFQWJsWBBSvykFX?=
 =?us-ascii?Q?9xHrPaYu3zSGWNVyZIHsXoyRnWd2qnZ7RWsIuedVzFju0kl2qj62+dFVX5i9?=
 =?us-ascii?Q?OZVVOzi+HzWOJvelfwUTgSo3kDuMB5OOyZbNTm9DGXouaHnD1WuT0ykoiKmC?=
 =?us-ascii?Q?D/kiajy+YKbeInYtaccXQDhnLFQrYMgSJhSDT1gFQSkxxN6eRabx01OK1z3I?=
 =?us-ascii?Q?LSZgNavmmvZMjykdBjZKU/+FYOz0aX3O0YEMbH1PGC2frM7+LKGL1cAjWA64?=
 =?us-ascii?Q?o6H3Rl0kwbekZlFN3UR4pCqVQ7B1QcFfjppeIn+hl3F+u2DG0XC6Id2Mc0sY?=
 =?us-ascii?Q?d7ngf6+MN9wB66VFGPUFZVfxmq2l+qXczrkVPhR4tRuwOUjLdZ3aGXS+LEim?=
 =?us-ascii?Q?/A12S46tjDgH1FZyfb+9YAxGP71AFtA4bGVkilvZ5JRCA2U19frbBcrV3GgC?=
 =?us-ascii?Q?p0TSgr6APaXRatO1a1veDMPhuWpvw+o5A+oKwywRh/pTmhd4omEeS5q8xo0A?=
 =?us-ascii?Q?XyeHDqBCBuhPH88Y/kmsHZqHLo/JtGDn3Q3YIHznvmuVecg2Fbl/plUnE5D0?=
 =?us-ascii?Q?tWZniLWH2157hYZz/jQXPHVSELcty+p6uffnS5zWPJZoXGmEo8SM24egnT9m?=
 =?us-ascii?Q?jkE88bSvhiwbZYSFWBg4iCmvEZLI/3U7HTIGe6QOshHKOgag0znororR1PZY?=
 =?us-ascii?Q?cVdWBfxQdeQGAeT2UkgfQWdkHzLNfD1ps3+2U/1mUWvXRfnrQ80henyBl+uD?=
 =?us-ascii?Q?MhQftmxbZo2S9Ywsiq3nkJO7ut+LQp6KlhuuC5GQv+C2iFnK1ZNyoiaGC66h?=
 =?us-ascii?Q?ByvGG31F0YkSLS28K18SxuaMKSb9AmjMuLdTTO6i7GcRp8Ja3zgIS4Iuupn+?=
 =?us-ascii?Q?9urYNzmrPZ9gXPCWviWMmOJMWq7k2kx95r6S2yBwi9dsAcnVIOrO2ZmKrvt/?=
 =?us-ascii?Q?uJWLOqOEN4uEAbTo+DvkYozQSYmdMvRIQbczpTOXrVKr5Vgouq1lC4GyCN1t?=
 =?us-ascii?Q?cnxrAzdvicd2h2Rmu0nT4eHMU0iaF+s+AvJoREMLXf24NywzmFGqLxE22jAL?=
 =?us-ascii?Q?pIkYmUCqVnfjLJrhAgWOqX0ytyC/dJILvSkmAT+DZhCuFeEdMUgXhwcn+XGO?=
 =?us-ascii?Q?xXdOQpL8TasJbjLUCTN5TjIvIGh18hJzthPiWe1RKBtpgIpCl+mHXCaTiROZ?=
 =?us-ascii?Q?tFVKpDipJr/arruXo3Samt/L8iT0KZQ=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62ef4d6e-c2bc-4ee2-a7ec-08da28bf0e70
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 02:30:27.7004
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sklsLHG8EuCWphedoY/XkWWKwVTNWzaUkLWjmnNg1g2kR8Atmje39ZN8K7WP4gIRgCsq7F+BnSvCtTt3U6YM77D+vFUbvfh7LPIGOkt0hbE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4729
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-27_04:2022-04-27,2022-04-27 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=975
 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204280011
X-Proofpoint-GUID: 9z7L2ENni7cA9fjrXYrgum10-XzZ_m6R
X-Proofpoint-ORIG-GUID: 9z7L2ENni7cA9fjrXYrgum10-XzZ_m6R
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Enze,

> The function get_capabilities() has the possibility of failing to
> allocate transfer buffer, but it does not currently handle this, which
> may lead to exceptions when accessing the buffer.

Applied to 5.19/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
