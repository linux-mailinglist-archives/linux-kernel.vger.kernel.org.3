Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7014B478EC4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237724AbhLQO7y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 09:59:54 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:62918 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237716AbhLQO7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 09:59:53 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BHETXCc016436;
        Fri, 17 Dec 2021 14:59:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=ySHtHzBWShLcc8rWgOgYABZnTDgsKb2YRWuJR9iYYHg=;
 b=eZ9+Sr+WZuHnmruphoVeDwJhjN3sAKoJinCU5aJTu/42dQOriGX4OkIxwqf0S83IE4h7
 z2pdcM/dGAAmOoJLkEEtmz8i/gx/RY2vDQYXvslHriowPVvgPcPq4lGHm2cuJAZdEayJ
 YzBcHt9W8IB/svlIZ219ka7otqnb/K1XJjtGlGwvpeUq3qoS/GtmJ4RZADRARZu+Djfe
 dzmWULi02p2mRb+r5qMJi9tULXWnE0ymj1iVKA2uTG4KaRxT9YaxOhL7E0rvEqwbM+LE
 jOxgAfYA2/EJ7gqkHzURspwy/beNMkfCJlP66sEbTHznUHZ3YQl4dv/lXU3ylys4Z3B8 gQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cyknrntr2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 14:59:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BHEujMN143764;
        Fri, 17 Dec 2021 14:59:32 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
        by userp3030.oracle.com with ESMTP id 3cvh43w02d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 14:59:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSEYssB/w0858G+PznT5vvc5eaJOdgqHopQ2tuUgf0FPVNTE4p2qkTGnBPvVvYlYeker/KTtb3YW36WHbPbzGgdKy3XVdASGog0eDtwfUt4beIfut1fm7r5WGYEI7wal076Y+stHjGTwV6pw+gLpPdRpGs4XRFbJDnBfmYOI1sZucfBSaIhMzb38pDV7adXElHH9Gt6VVNBAke/rKB9jE0GY9/hFjupYJuSC4trJyio2652OLrD/FdciOe7dp3wU1/0hCI0lODWTeAmaWiAhM/KC975eCMJozSyYgnxv7fRPmPMtSevjQCNniPLbEhVcAsFybHE4hTLb0Q9+52Qd3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ySHtHzBWShLcc8rWgOgYABZnTDgsKb2YRWuJR9iYYHg=;
 b=EeykePjoHR7offXGj5F0bOmodYmefO3oAgqdsyThOVEo4AGoe2TIy6ziLWbgS9zx5bytzFjYgeC7fvizzjpkvunDD8NPxzfigO7Bvyb1G83tMBG/m5yteq4vhC7yAW2mr7xZFSd58ltyVmDJBz2acmzO6iv1w5kX08FhvECWovQZ4jAi1ypaUsjKYRVSfmjNHNDkPPyQCS99ct2kAUFFAlDfUAKxqk5jY72WWKf6nQ/yZ6FB/cC7jV/KMhClBd5QQFxXaL29dUkHUKY2mMBPhaL1xYeVdDT6ecU+ht929KN52zBdwdV04UfzHe6vCFEiVctLVh+ItSFLPcN4Wo09kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ySHtHzBWShLcc8rWgOgYABZnTDgsKb2YRWuJR9iYYHg=;
 b=gonjEjVFwzLQ8mb3oah0C0aCYT7NXIWPHPlOMEtIwdvF1ICIBb+LFaxFeDpKPLUSAA/RlcOKHkBjaL/dPDYa9D1U4aA62DEEEIcOyF51CE/YLeRAerSDfR7lJpYRd7wwfM07vY5lJ+5OXvHmLYkF8hZrp8WZEc8haJ2sRdC8tf8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1424.namprd10.prod.outlook.com
 (2603:10b6:300:21::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Fri, 17 Dec
 2021 14:59:30 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4801.017; Fri, 17 Dec 2021
 14:59:29 +0000
Date:   Fri, 17 Dec 2021 17:59:08 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Will Deacon <will@kernel.org>,
        Bhaskara Budiredla <bbudiredla@marvell.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] drivers: perf: marvell_cn10k: fix an IS_ERR() vs NULL check
Message-ID: <20211217145907.GA16611@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0061.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:21::12) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 52b70b6f-735a-4e00-c2a3-08d9c16dd3b3
X-MS-TrafficTypeDiagnostic: MWHPR10MB1424:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1424148624B108ACD81FC16B8E789@MWHPR10MB1424.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3044;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7gHzzdL/y8H+1jTTheRq4U8KlKjhpmfUCmijosqaAsEVfjDYFj96QNhhDQWkAk8TShPSGENtvXK8BT4477FbNP4X15mWyGUdauJcRG/E9uuaicW4Tm2Brt/4LRev5kRbl3pvXYi4le5lCVbO7sO43N47KZhQDWcTQ61xF+kG8aUvTwcgmfYiY2DkJIUvj/qnh0v+b48ZuMwi1VOMCxS6Zp8hqFjlkA6RlYAvQncVfOMzbhvMs7fCjvXAI0YGgJNQy966+8/bVnAbzt19cc83qEHlmnIndHJ3rvkGHbQwhY7BkFjcShwBRi9vSLBNk9goXjLTru4/Mp2ZduXFnbaSadcauyqXmBwWDIBwi1D6cz0Y7JVxJnWF+QhsFUFJe2O3MBnR7KrF0cwxsmGvJ2anv54Cr9ro/pmVaXQ+UyWmKKontG3d14U+DbHm0u7LShvSS3Fv21AZ/M8l0Xw0jn6WTQ611W3gLE6y1eHa2s9iXgJZK0nZ6SqKHKxJ7zFm/RAPhPFrQgSQ31lBRHdIGtu3i+vRQpJnWrTokdSuPHO4FxQS9bB4Sfy1sFOBYSqK+5GubVbWI5xbkd9ndnodvZl0c3GMmvjsvH5YaN/mDIb8oLP4uArVOm3wvHK6Gc49KPNSnjWoNY5BCT5fb3pMK4AfVJErDIMOGum9mjtCoxfTM7j4dultMB5GSGu/ZKUOufnE2C1Bfr9UlOSt4D+xbkC4Wg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(66946007)(508600001)(38350700002)(8936002)(44832011)(38100700002)(316002)(86362001)(110136005)(6486002)(52116002)(33716001)(33656002)(83380400001)(2906002)(26005)(5660300002)(9686003)(186003)(8676002)(1076003)(6666004)(6512007)(66556008)(66476007)(6506007)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Hp4MFplJxNumqYkby1crXvr+iSD9aGn9Yb2mwsdUJHVCj2wWCa2nxTyHRm0n?=
 =?us-ascii?Q?nYUdiF+26qr+0F2iSNGy20viNcZ93EMvbskveCrLW/f3aDKFNF8e7eWbsrel?=
 =?us-ascii?Q?vPVMRRgb7Cla79k3nwv28x01ZjmD/LpAyn8zMPOl2J8EwTnNiNvmVSJgatUD?=
 =?us-ascii?Q?qKt7mPZOAy1ei356L3AE3ag5W6dRPw88Q/99irhXMnaJ51X2Nt/wDelwE6Bs?=
 =?us-ascii?Q?no3LvjwhBBDV3hAdjgGVCD3Ftuls0pYwi8wTPD/6g0gcGnc5q/HkYMcWjzIW?=
 =?us-ascii?Q?j9t99UDzQUOqfxi/xqESAUFmUProkYAGw/edSXvljpaA7yqdi6TYbjn2vH7M?=
 =?us-ascii?Q?0D8HF35ZleX4bZp/G9AUgN/iOYTNL2t7/0D+y8aaQKEhO2V/W3IRN2vJpirJ?=
 =?us-ascii?Q?2yFPL/2bLJLghbHArq8x7b217SViDFFU89BqJyCPz1dd+QIGKg2NPSoqCY+c?=
 =?us-ascii?Q?aiydI2XoEVWman8OxftUBMfKKisJchFkDpXgeDHad+bzjGOxlBwPaTvWMnVK?=
 =?us-ascii?Q?vm228EozW14WGt/3iuf7Ri9SW/SmaVutzpQ493Ks1QF95nb9ua6qJZeQwxcU?=
 =?us-ascii?Q?NBCyd7+5z+gEsMVV0ABf7C6c1dwcaCfR7VuptJEZDaL75i/DTYq9TLxeqFBk?=
 =?us-ascii?Q?gWX+GEdZUDbcQAb60lyliRRIbe4ep2E6h8Ofivv6smXhCgIaOcTTrCeuTfUA?=
 =?us-ascii?Q?22YH+GCvuMPhiuAAb3/rRA5cHi2NlTKVwfkUvBJZH5BJ+t8i65zyVrAr/91V?=
 =?us-ascii?Q?RbOhSUt9W5LY8lXq821MuDZDpojPjBvLtyrAJggpzjxvPyClj6Io7cfIeGam?=
 =?us-ascii?Q?6WNtZi28tXvkVd9N86HrkHuRuaK46DB9RMidMKMYu4meWyJKNhk0rofNSXxC?=
 =?us-ascii?Q?HdjA2CvAlJWOGlUbTvcQpe8NGVu7nDPw3cM5EGQLAsNBIaedtgCyvb/CiRlf?=
 =?us-ascii?Q?zo4PKw2iKvn8FuoAjoMknawFWmaWci1OLp4TyLoNKQRrtcDOH6PYyU1VE1r3?=
 =?us-ascii?Q?1Hr61fhWnC3Sc0v/XqZ5DVZnxfSGcC4hFE69v63xuWi71O6TMmILViiH4tsT?=
 =?us-ascii?Q?D/qVLYr0so3BmoVJ7oYbKJH5KGAhK3SQcwckjgqEWyFlgJciVlB2f4tSJq5+?=
 =?us-ascii?Q?VWqT/E6PpZBzWlobv3OyQhlutX0JCh3OQtHZrlUzzJmpy8joCa1CH8friA15?=
 =?us-ascii?Q?EI4DVEGbhW9EpbDZMaV7a+Rhl6953uK3FjqIp8ZyzTidPeeayN+ipYbMp/+6?=
 =?us-ascii?Q?lWX5knkBEw9CO9duo9QUbfZ/XO5uY0FJWXuPrYOS/gmAIn8Do+rEbzyGuQ7I?=
 =?us-ascii?Q?bs57bjx3gCSvCEUMH9d8SmAWQbO1Rbhis6CWxiEC8ZCBKviZBtFQYG0w9rYo?=
 =?us-ascii?Q?c+g3hxq8bmWi19qKci+hno7zUEYKXffUOBAZY7nvrRYNXTFbjTXUYzBfbqfk?=
 =?us-ascii?Q?uHxAuFPJK3t/G84zKUagMcDsTLzbwP1aEan73Q+VDPd/gnUI4Hmk2hfpckSF?=
 =?us-ascii?Q?lvDLXbXyjZR/XomvyFvOshx7Pscg3H/tOb3Iqv2mS7oJYQJ/627Qxjc1ZF/W?=
 =?us-ascii?Q?J9uE330x1nXF8C59paP/upGgNLB5Lz3sU4r0aqiWRh/l7XVpcieKAoxEOcrD?=
 =?us-ascii?Q?oQ8E7ImH7IqCvqAKhD4hnnWl8Wi4UUBv39PKz4/o5D3Iu63WaOIPrTMptGOg?=
 =?us-ascii?Q?XPtmYtAwvDNfgBGBCmgKsRTz7nM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52b70b6f-735a-4e00-c2a3-08d9c16dd3b3
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 14:59:29.8214
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MIBSgmaDCHQEESZQdNLI4nFrlmxUlaTpsQWiZU5Bz1f6zi5Bl4daAqz3p/f2Z109+2a3dHMekqeGnI5bJFYzeFxPhbgVhCqopx3AfzJ18gY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1424
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10200 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112170087
X-Proofpoint-ORIG-GUID: YRxWigmEP9bSe5iTyDPSRG2OATZ1uIuz
X-Proofpoint-GUID: YRxWigmEP9bSe5iTyDPSRG2OATZ1uIuz
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The devm_ioremap() function does not return error pointers.  It returns
NULL.

Fixes: 036a7584bede ("drivers: perf: Add LLC-TAD perf counter support")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
When you're adding a new driver please use the correct prefix for the
first commit:

 Bad: subsystem: Add new driver for Fancy New Hardware
Good: subsystem/new_hdwr: Add new driver for Fancy New Hardware

Otherwise it's impossible to guess which prefix you prefer.

 drivers/perf/marvell_cn10k_tad_pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/perf/marvell_cn10k_tad_pmu.c b/drivers/perf/marvell_cn10k_tad_pmu.c
index 250dd4c52d70..7f4d292658e3 100644
--- a/drivers/perf/marvell_cn10k_tad_pmu.c
+++ b/drivers/perf/marvell_cn10k_tad_pmu.c
@@ -312,7 +312,7 @@ static int tad_pmu_probe(struct platform_device *pdev)
 		regions[i].base = devm_ioremap(&pdev->dev,
 					       res->start,
 					       tad_pmu_page_size);
-		if (IS_ERR(regions[i].base)) {
+		if (!regions[i].base) {
 			dev_err(&pdev->dev, "TAD%d ioremap fail\n", i);
 			return -ENOMEM;
 		}
-- 
2.20.1

