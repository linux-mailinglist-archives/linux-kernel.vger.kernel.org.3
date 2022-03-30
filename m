Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F0E04EB9AF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 06:31:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242596AbiC3Ecq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 00:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiC3Ecm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 00:32:42 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F00219298;
        Tue, 29 Mar 2022 21:30:56 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22U3OrIu016969;
        Wed, 30 Mar 2022 04:30:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=JJfSWl71FzmRfj/wgTtCtJypo8T+0xGTKWhRb0VXhiw=;
 b=KLCbKRnjGZ4HD25nX1+aZo3HuT8t8ds0/My1QvGo2J2P8419oIqSDvX9b4PSn6XpnpLP
 Mc0cHuaO6ehFPdyzJD4pPNRmiq4/DH2TrE1INPwsOLvPvGMDGa/C0WQqewbH0cfVDkHm
 P9zg/Slxtr/cb8Dra3RoVr9zo14rpy47NmxcdhsDy1CpUzL8eIXZzAxr4+DRcWPMiQsK
 PgvUNd5oclN35bYZGMzM+kM155CDtMgJn2mgNa5HiJzGeceC34IXdal4siy6y+B55dsd
 DQYAjWaTXLPClyg/PS4NE12K/7MHf704+phB/kuVpYF/AkHpmf5chV7pIcNm6CjIe1Q9 gQ== 
Received: from aserp3030.oracle.com ([141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1uctrf06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 04:30:50 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22U4GeC5182464;
        Wed, 30 Mar 2022 04:30:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
        by aserp3030.oracle.com with ESMTP id 3f1rv8ecwj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 30 Mar 2022 04:30:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X8qZ3wZ6pZFZJUT4QyF1jCgY6KI6nMANXvHKcSLglSmeFOJcZrp1nYE9aZnzyQWAklDv5yJkYHUHUI43UH/nDkXkBF0LiUSDT3Jd6XPOtJm509IKECrAZiKltnN8lLqsRwQ5RAtAXhMB0M6cBDGRkegSTydSHdMeOSRFEsN4uJsxOwqMyWVXteR21fDykRtCztnHVj1wyyW5EBGHG7IM55bZAA9zqYlH/xY578FhVVkUMeQ4trLtnRXmQ1GsjO9TOWsKzIxRmeknsJn9uo5wDofte/YHKlAv0SOtggxbJ3xZfCdfvus5TdVQkvU5r2SUHHI6a45Uk8ivNIQ/+2gfqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JJfSWl71FzmRfj/wgTtCtJypo8T+0xGTKWhRb0VXhiw=;
 b=FVEH/5mtPnPJyZQZNwx2tUM6L3gkxe+k1cC8xFuZd4DXbxwDJaIJ1Xedzbasey+HQ5H+kJYGP9gaLpHsBFT5gyK9Dj8y8Jm5bM32s6LkWx3q3mNllzv5P050Wwz64RRPOt6FaU94nmVWoEyEdh4IxHRsQBMmFObp53m39v6Nk9eAtP0cPmIbR+njnKL/dV43e+jHUyUDONG3GfX2Hw8S/Ko5BP8rhjXFKlsCiJfWTtXNj0/Jnl4faZFKWWQbRfXRkmbZV7O9kVm7IbnAHhQpSyRvaoxMoY/Ju0Y1z+WcpLBFX9G5aoAKoMkb3ltoFJCPabSa7HWxNIcy9WV04n8AJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JJfSWl71FzmRfj/wgTtCtJypo8T+0xGTKWhRb0VXhiw=;
 b=j7WQMUyOG9tdhrdxlTunsK10s6C/UGNdVgTtfwfLPzYUoF2VrB3zc6HDmVbrNoIA1zt7Nu3sWez6M9ulYZdTa48eA7xObyo+09y9b1Nt/2ZjLChp7G0sf8EmWKTEbTCBQbmescGPzXp8yUjTN1ts/lLxHJS6qMhZNnwnfECFZMk=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH2PR10MB4342.namprd10.prod.outlook.com
 (2603:10b6:610:a4::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Wed, 30 Mar
 2022 04:30:47 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Wed, 30 Mar 2022
 04:30:47 +0000
Date:   Wed, 30 Mar 2022 07:30:25 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     axboe@kernel.dk, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org,
        syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com
Subject: Re: [PATCH] scsi: sd: call device_del() if device_add_disk() fails
Message-ID: <20220330043025.GD3293@kadam>
References: <20220329154948.10350-1-fmdefrancesco@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329154948.10350-1-fmdefrancesco@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0032.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::20)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c05b9c60-6099-46d1-433c-08da12060fa1
X-MS-TrafficTypeDiagnostic: CH2PR10MB4342:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB43420E823A75636DE386EDCF8E1F9@CH2PR10MB4342.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U8D3ACWNt8H+DUnp/1tGCCP/MVMx/sFBLaXa2o88kQkyB8utvxOCiy7jzD9fWAQgEEngRkNEBB69a9Ae/ySJVZiqfezIH4+cjBwvuG/+DWkFTPBikg00xZSyTsfVJuOuG9ecie3D8v+5foNv5/5tcXdZsC8gYHZwublFadggHysn1mX0KCAvx6+m6SXXS5sgGaWbYqZSFkL24PFMssCYH9xtJ779KlRJ8+sXuJGk56WaoJJvMTHjkdrqJ+uVKJJbpePgh0hurpv6aIpJzT9706nNLqOS/hYAwJk/pfuAthYw/dChtu2hv1lmwQBnTTvf3IhbYKyVAvV9l+cP7aUg9R1uK/1kw/9nTdQlsmGPEC6bmkpFcZOEA6z5do0iRk50lAWaypumeXZLHrTjgDMNgmIbrq8OV7j7zE2vchuTm28ee7mPNnh9ACrUtbii7sMjZiijSw4/Bt7tPcqnxttNiTD0aOxvwR3OyWDlHqyCKXMeMAxPGTDjGIDZpcaV5l/nT2zwq/ywgL+ss4suFu6ZGAvHKnPVvg/pIhW1imsl+vxKVlmiPjYN1AgV/B6rnwq2AQedm0bOZaw2yv26EDOtj/rtmQCb7tfNW06XSz08Kbt5g1KGyfsRHfkKRVjyTLMuaLbkE4ye9gf7fyYH/5REfblRr/xjIAwnkBu5Sa7Uu26vkt167boUtwCVY0NcqMiC8uR9HUqVa62xfwyX8wrGZCx6s5ylcsTWwrOlLZx7u7N6ux5pHE5Q3zbpLXBzpRnjfVhxCKT6i99lqZe2NOqOW2ZMSBHRwhgH0BTr3Aflsi8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(8936002)(4326008)(66476007)(66556008)(86362001)(38350700002)(52116002)(6506007)(38100700002)(83380400001)(316002)(8676002)(66946007)(6916009)(5660300002)(186003)(33716001)(6666004)(33656002)(4744005)(508600001)(54906003)(9686003)(966005)(6512007)(2906002)(44832011)(26005)(1076003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/3w7V7fpx5Q4azdDo7x526Y8WwjBm/dyQXeYr0+yZle8jIr/HLfk4reSebnO?=
 =?us-ascii?Q?TrL+my/AUsiGfiZ9ctu4rRb4zo4vtnWEzRJI7JjolML2n0TSGub4s/INNlGk?=
 =?us-ascii?Q?9FXTKw3H9cUrtVe4XKW7/TPVbPOLAkLjS1RX8x46fayJsLGkUQ1iCGsju4Y8?=
 =?us-ascii?Q?PGCqelz6vBY2oEaHBGaFc/VX+yazcujY6OrKJRhqe9N+3MInsckBgWmZOMWf?=
 =?us-ascii?Q?PtnyK0OnlcND6B7oqMyJUz6+B8eEd1CVR9Dd5vuZqmCxLx/KOE7sNYmlVT98?=
 =?us-ascii?Q?mywyQTHQR1GFDhMVG0o0vKXmWZWJLZWhsO2rFWBiHwh4MjCQW5ZcujI0HXeS?=
 =?us-ascii?Q?31n5epe9/PKkOmxFcBifgFqvMM/fC5StMH/ajdP9qa60dBiRMn44m6oThUb/?=
 =?us-ascii?Q?3ZOHzMnz6QO10UaK7JVOic4NkUHJkOhW7MMfqHK391184+bMZkdUuWg1zVBi?=
 =?us-ascii?Q?eRotOLNkKecJBEtRhLWMvdAaFNhNZ0OACzw5Cyj4t9EblS/7jL0I33uTjS+J?=
 =?us-ascii?Q?R3P/qKgPkyCAlMG66sWIhqygEqTST3/bi0sKI/tnLjJIAl5Lz21J3aW9JmqN?=
 =?us-ascii?Q?096z16ka4CpIe1yPVNkHl4ShL1i8bqpPHFdxq/1ydXLf43iDS3qvHbNAgDzN?=
 =?us-ascii?Q?BuT0EfshUaCLubUxp4tYrfZZe/N7ABtP5FSgZN/etZd98/trTWo8NkkEvLTr?=
 =?us-ascii?Q?aSBmU0FtSPj7HlJWugjdp96Lfh2e8A/lGwSGgyXBMla8idgtSouuSvVXZ3Mt?=
 =?us-ascii?Q?nchC8yoUnv5efNzb8QEHdifku45Xm1Vy08LHdU+3n+1mNMdlObDIPsorzATp?=
 =?us-ascii?Q?eMBZCrpMsln5Td1O7JA46iDXqaYj41x1vCO4y5DoJszBVUmjvWQzgF0hpB1s?=
 =?us-ascii?Q?q/V80L5vOCO37FP3QNwTnq/hQGEpPXUcRPu0sEXwJwmb9N9SSR3CeDHULdtK?=
 =?us-ascii?Q?cJS4DWRnJupRHcQVDIEEiLatTnmvxItx+v+6WUNM8va4PwHNn0qzHHgNKNxt?=
 =?us-ascii?Q?8eyO+qhjhxpjkYS6Yk/x/ibn5flXJ+A1o+I93SB2yztGPbqNpDxeBXEbks4P?=
 =?us-ascii?Q?SqFLOncckEMxNzFK7fgxLcFs0nnEFgsb3n/KBsJG2hJ4cOJ5Kwx0D4qbWtNl?=
 =?us-ascii?Q?cTmkwPYQ6cG10ISmOIeMogXnfVA1kf5GOM8aAipWTKeTEtPV5QtjLBZFdPpF?=
 =?us-ascii?Q?BAm9T8PKRR5xBaonoNqWyuGuHZpPvhiwfDC/OLpCUfpTN2IJ+GIHSJ4CLm2Z?=
 =?us-ascii?Q?Tw+bCvcYheFFSLuQ1oySNYY7gx3WxzJxfbsJqXqotiQ9i0sHf71U+Gcaj0Co?=
 =?us-ascii?Q?cXxFXXIfrlCy4iWHCs43+4brkuZT1Od1ur5qo2Ge+EIG2fHVo64H8bahEXiz?=
 =?us-ascii?Q?Kad141OnEH4AOWzv7a1dF1jItb5ns3MysQjrna0EKC1NkH2nagG9cDoEyTVF?=
 =?us-ascii?Q?6pJ7FERk3+F+MMGTQHZoR2BJZpOtFsTvyCRYvF4WBzN9GpfiMvr2QXhhaVsH?=
 =?us-ascii?Q?HKWs6sUT2B83scEX3oxL5W0K5/n41wssGfkPntA4MOZvXamvoORUbWOrg1QN?=
 =?us-ascii?Q?4Wk7ovx8U2QEtl6PD3X+hDR4S5L2CJHysBHbe1z99lpFnc+Y9lTJmY3LvMrg?=
 =?us-ascii?Q?mtOU38e1ktmbibuLfc6EMRZo56rTIlKP5O/YW7Si9TSvfEAwyhxh6hk/GlfG?=
 =?us-ascii?Q?ZZZerzP75xM5WF6IvxVX1GSTCOKDSGEmV4lAFcL5XHaniHv+dI/TileyLo8N?=
 =?us-ascii?Q?r9+cZKIylReZaOPPrSXRzrQJZ7iRHDc=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c05b9c60-6099-46d1-433c-08da12060fa1
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 04:30:47.2676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: By9iOKT810MXoQx1RKi8MCr8J9PVH94HK79I58GfRnVBo6nLOHPsQD0OkRby9wEZOX6PCkpCW/o82tJp+eajDlT9JlZOAknbFvmFmYeM5ns=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4342
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10301 signatures=695566
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 adultscore=0 mlxscore=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203300020
X-Proofpoint-ORIG-GUID: tJ2-XsliukWJyHY0Wg0-2ojFKwiWbQfH
X-Proofpoint-GUID: tJ2-XsliukWJyHY0Wg0-2ojFKwiWbQfH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2022 at 05:49:48PM +0200, Fabio M. De Francesco wrote:
> In sd_probe(), if device_add_disk() fails it simply calls put_device()
> and jumps to the "out" label but the device is never deleted from system.
> This leads to a memory leak as reported by Syzbot.[1]
> 
> Fix this bug by calling device_del() soon before put_device() when 
> device_add_disk() fails.
> 
> [1] [syzbot] memory leak in blk_mq_init_tags
> https://lore.kernel.org/lkml/000000000000c341cc05db38c1b0@google.com/
> 
> Reported-by: syzbot+f08c77040fa163a75a46@syzkaller.appspotmail.com
> Suggested-by: Dan Carpenter <dan.carpenter@oracle.com>
> Fixes: 2a7a891f4c40 ("scsi: sd: Add error handling support for add_disk()")
> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Thanks!

regards,
dan carpenter

