Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EFE04C0999
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 03:46:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237843AbiBWCqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 21:46:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237839AbiBWCqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 21:46:30 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26FB06D3BC;
        Tue, 22 Feb 2022 18:41:45 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21MN0KgS026299;
        Wed, 23 Feb 2022 02:41:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=dfk7uf3EOkuJNsAdGZZbR/Kn05P1Ig9TjjA0akGndI4=;
 b=olaelRn219wAMN1BdorFJYxhd3G2c2Ewz8wJsO5Unhhhccjp73Cu/EpAMl9sGP/A9Ax8
 ZHF4bqGxUKD63DpeZnN0DNPKO61bhW8AG6QQ+Nv3zEL3o3UouGaSsokN9rOopq7yUqzu
 F53RPA0LqLXd7iymT9+rhvwOf8RLSvh9OsAHzGFY4TDNq3I3/FZtTyI/z0M4P+mzqgdW
 xcu2N5yQuZf+/2wyHDCetIvmv7YLSpce41wALbIybEJKYQHNFJIEHQZoEXCQBsi3PNmC
 XBIxPdi49/zCbvyj+rVvk+WaVj69A63QWOCiCmcTzHtWgO+6IXWyigFkUle7z0JwjlRB 3w== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ecv6etpaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 02:41:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21N2ZaIV032756;
        Wed, 23 Feb 2022 02:41:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2107.outbound.protection.outlook.com [104.47.58.107])
        by userp3030.oracle.com with ESMTP id 3eannv5ut5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 23 Feb 2022 02:41:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmVdfsKIJ3JqTQwq/L86u7CaCIFh6pj9oZNVdIHYX6Ezr/IFf2qf1HOmduNdul8NZRw5wn31HDR8dEovo67Kv61yPOQ5EdnvwN1t+oc1Kvgw1lGwaFULMNPRcQyeG+aZyFqyEGbN5YFMvZpxHiAsWMvw5MChdkwJmiYwtCjRg5bPOmfxUm8LZWsjboPEItsnPnqy4hvzaTLDKNtc1M4gS36/8yCl7TCbmZp0N2+2nZxkapieOtGiDLQtkis9G4Qk3Mzha0OPekHCkdwhuytPjx3x7oAB0XWqmGSTFToU8Xnp4iAXiUvsM5DRBJVE3ZkPZTv1PvrKQ3oVWMl8j4WpEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dfk7uf3EOkuJNsAdGZZbR/Kn05P1Ig9TjjA0akGndI4=;
 b=MC7f1ZZB0nZrbxOAvltH20VvnirdKqb+w8jP6HCUBrAvHakkObGZPufNvbVFRfsR65QLKxLF74kAM97KdaYlc4FDBdWTGmvaqWvc7aCZVghORRLPseNl3YiM3oc9QYgTBS8UQHzQ6E5YW3/qldMMJ1TSDeLOWZnKBuoBFZupY2ThgAlpAWidY1j1xvfHMLBK6POLQKgrzy+RuSgmOs7zGyb748NOxudevUEb7O62DKMAptekw1B3yxvFWFHcBjSKpqJosLlThujtsBL4pCXDH8PLkGuawt+XsGYJ39GHuiqX131JEwb/+dE2sHNv9UUtlQ2xt6nldR9rLBROEV10KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dfk7uf3EOkuJNsAdGZZbR/Kn05P1Ig9TjjA0akGndI4=;
 b=LJVrMEpIeZ/ksJcSnASW6j/2zb8FQloT2lScQXscJ+GaYlK7x4FdhPNq8M0VWQSDWa1/Y/Sb4zpmW0LkECxwP2K/cxyQR2FMULD+iI69Hm8wCGrumuUwJpNenK/rQkQNkvj/ZFLiCXk+KqTBrj5bqlTVU/db42Li1HOXBFoWJ0o=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by DM6PR10MB2490.namprd10.prod.outlook.com (2603:10b6:5:ae::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Wed, 23 Feb
 2022 02:41:09 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c9f0:b3fb:25a6:3593]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c9f0:b3fb:25a6:3593%5]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 02:41:09 +0000
To:     Christian =?utf-8?Q?Gro=C3=9Fegger?= <christian@grossegger.com>
Cc:     linux-scsi@vger.kernel.org,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sagar Biradar <sagar.biradar@microchip.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Konstantin Khorenko <khorenko@virtuozzo.com>,
        James Hilliard <james.hilliard1@gmail.com>,
        Don Brace <don.brace@microchip.com>
Subject: Re: [PATCH v3 0/1] aacraid: Host adapter Adaptec 6405 constantly
 resets under high io load
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq135kacnny.fsf@ca-mkp.ca.oracle.com>
References: <yq15zo86nvk.fsf@oracle.com>
        <20190819163546.915-1-khorenko@virtuozzo.com>
        <CADvTj4rVS-wJy1B=dgEO1AOADNYgL3XkZ01Aq=RTfPGEZC+VMA@mail.gmail.com>
        <ffdb2223-eed3-75b4-a003-4e4c96b49947@grossegger.com>
Date:   Tue, 22 Feb 2022 21:41:07 -0500
In-Reply-To: <ffdb2223-eed3-75b4-a003-4e4c96b49947@grossegger.com>
 ("Christian
        =?utf-8?Q?Gro=C3=9Fegger=22's?= message of "Mon, 21 Feb 2022 18:34:07
 +0100")
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0087.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::28) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5345ac31-df44-4fa6-ffd8-08d9f675f2ad
X-MS-TrafficTypeDiagnostic: DM6PR10MB2490:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB2490DDBBED4014F82D9C75418E3C9@DM6PR10MB2490.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TazsNcouQicSTyZcY3/IHh1XKUlmDg3b4eTJMONQpUo779uGqjQFPK3zFAalBkwQ+/vGCMhhZX30jA/PbwPdlV/UBjXV/pJHhk1Txcv3Bk9Il7oUO+4wnv6UdXhYnJSqIgUE5sX7Ss9BAeNANIiG11wyMptatbf0Be99CcWKosYF9PKsRMu2xYcHfHqmYZlTufWlPp5B9lkfJrxSYCzSyxkVsieKGzAV7+a7bSrfaEnSJnm3TvuAJDX9GhSTij0PetPYWICxuFJvO/5C+oAiI653AgnRnblMwu/BrZQNwsRxzggHmqhlL72KWKZbCLCb1J1hEj6cmzzZCCSahAqLErNMDx9o2CMa0wkeLFUBD1O1rSQcAwEG5zGuCW7e5toXHkZs+ARUiVh15/SVL8iS8M+nNL3/FZOuDQD7BoVwYPH2SmHvf41AaK0PhMQRi1h9/wSH7ddYZ/ZX0geKJer/89Mzx3a94DmB5qFPcMJGFwPebjsefILLg06qKqm+UZG/r728Z2XQ275YUZq0FmKZ8lc+rgBJRS4VIlommN90q7Cpg2nMWtu7JevTrjdSad2qV/QsZzM4M677cMA9Ia4Dzblk4pkYqbhvpMJ+EVnrZlieZttrMGOTWnHXeCpcW2BpRqC6Tv3AlsOhGBugRONqsZdneu2opRIWNb+YwpQY3TbxQ+OPJkn6E6LMN7IEFXETVRm633HDHFmhKILFgaEoUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(6916009)(316002)(5660300002)(66556008)(8676002)(38350700002)(66476007)(6506007)(6512007)(52116002)(36916002)(508600001)(6486002)(38100700002)(8936002)(4744005)(2906002)(86362001)(26005)(66946007)(4326008)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C6kHgSbqFdZe9OJDs4K6MZHggJT/i1TTRGylqNoyOiDFWQzAg+9uXcIUQj1K?=
 =?us-ascii?Q?U3OvOmzADwcIl+FoAmNlb8094UibtN8h+3qhWRANLUXAt36ylNNMHo2laBEV?=
 =?us-ascii?Q?1PLzmQRa3EeX6RkwLDbTDR3NxcAoTwoozjLrNBt2agC3+e3KZFVkzOE10p/w?=
 =?us-ascii?Q?gjbd9EvETVomAR+iZIp9dvjsqQ8//A9E1+S5lYYc+PFURdiwsNWY9V1yEbq0?=
 =?us-ascii?Q?iyzMb9fCRBqrX0EGqxF6ad2JqLqz+gm6HYOg/ykvcMNAFuBGIeFspev4Cs5t?=
 =?us-ascii?Q?wwDsc9FqnRnH53T9gipQi3PAXyfVkRqj8sp6vXDszKw5AvbbY/BNgPSk0z+b?=
 =?us-ascii?Q?73E394jVSi1OFJJ3Q6gnlu1q/j3DmMexuUCjZg7YkFN8navFGca9QDj6eEFp?=
 =?us-ascii?Q?NUvl+dEW9EDBslATLOJn77zD5mkxZFLwegX9ZlcaxF8p1ogPxlnFcVgPZtDD?=
 =?us-ascii?Q?Yl4t0cb5cX7k5iS0W5m1FeiuU5cF3JXEKV779ieD9AMfTNhfWR8sS6mRBBW2?=
 =?us-ascii?Q?aKKpsu3VRv0ZKY7kF7M8JchKKWYh25uqzWrRQjCkNsupbMm5MPIUjdMCHZZQ?=
 =?us-ascii?Q?equFv11mL94gBX7XMmK6rRT+E995hZUVRTsLUrVmm5xgZZJdItitSjpaOCxw?=
 =?us-ascii?Q?xuAku43RsqVTN1DBS8SjMFvGRpdf6w2rAdl767iTG3w3ZAXGiv9Fq8FcZ3zD?=
 =?us-ascii?Q?KRmHVTD9ICqPmEwtSlo5OOEuCXtT9BDm41Hz07dti9mWuedqNKSYpxflCvHm?=
 =?us-ascii?Q?zRpKq3mNn8kmepdd6/5sTTLTlNds4DzgILqBCZma4kJutRcz4eKBETrFu4ti?=
 =?us-ascii?Q?kgNc1M6dAjar5CcSz5pk1j7z85efoVxZEWNYqDfLQR9b1dgJ3/30B/yx0Dm7?=
 =?us-ascii?Q?kkr/ON/W0xweMj/hYid7I8c4eLZkrNfaKzqhGAv+ZDdrz8/TS0I6wUDMMdU/?=
 =?us-ascii?Q?RSSl2wJy4EsxhtC+BmIySq7/NcOElnEYQEzgerehthzlYbXHT6WalGBqJ8X+?=
 =?us-ascii?Q?Saqb+N7lfojpAwq2stwyCvwR/mBZrEm1me1GDDtQ93wSKJD7pQwNvJoMMCzX?=
 =?us-ascii?Q?Y1iFvsTOqjwP+ZtdvndydyRu0LHbXGRtYGiuD5OgvAlB5uOkJRxjZm7OB0Uu?=
 =?us-ascii?Q?1opbRnlAPL3xPuHjTaRxUODenYKIxB/G/Z8Px7zJ9PQBWO+TY5PG8ik4WSpn?=
 =?us-ascii?Q?SBBMZunlOgoOCg0LfZZIOP4tnE0z15LxBTj33nW7yx+oAz9OrXHhPIxxbnOa?=
 =?us-ascii?Q?1+8619N2IuHGwKr0LFT92pGr6YK9gtlFyTFJTDUyxt9wiuwe0G0k66QKIfBp?=
 =?us-ascii?Q?GrncxnsrC+N3kqQwf67sJ08Q4yLSSEtGvAWr9vbn7mQY0L1XfvxFUNoGRSLr?=
 =?us-ascii?Q?7L0Yss+XMXuV1JpV0KwVjMnbEyxFtiKcoXBvgcW7Jg8TC8diBeeul/rYlQUL?=
 =?us-ascii?Q?/GKjo+t6A2mE4wJT/Bs8BZaFTA29PuXiEeKQKAKWzWC9bNAaZCazXxxjMx4r?=
 =?us-ascii?Q?iURnIPiqkjKNYChLaOME2jQcRberTTY/dydsW67pLeDRbRiuW4YrsKlIVtBe?=
 =?us-ascii?Q?bxIGiEJqraFdHUmI8dIZn8yhpk91ct9kLOs7ypIDMBVi2Ucy0q3L2pI4u00b?=
 =?us-ascii?Q?7rF/CcP8v51sY3ZMZ5fkwBuet7p0ee0M8zS/0G8r2weO79xzf3//zBjwWpGK?=
 =?us-ascii?Q?ecbw2gJH0FntXB2bah2a6fAWdsw=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5345ac31-df44-4fa6-ffd8-08d9f675f2ad
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 02:41:09.3825
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iSL5Z21BKOG1Advq0+IoqE8IlPcjVG71Rk+697hQGCflgroA9DmCOWZaneKv6UR2oQ/WE6RXwhKtsPcE4Edj9m+88QftnlYS2UkpwQoYy1c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2490
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10266 signatures=677939
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=934 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202230011
X-Proofpoint-GUID: POQcadUR9enw7ucllo_haykceWAB34Il
X-Proofpoint-ORIG-GUID: POQcadUR9enw7ucllo_haykceWAB34Il
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Christian,

> The faulty patch (Commit: 395e5df79a9588abf) from 2017 should be
> repaired with Konstantin Khorenko (1):
>
>   scsi: aacraid: resurrect correct arc ctrl checks for Series-6

It would be great to get this patch resubmitted by Konstantin and acked
by Microchip.

Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
