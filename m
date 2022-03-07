Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDE44D00DF
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:14:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243057AbiCGOPp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:15:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233116AbiCGOPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:15:42 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8D770CDF;
        Mon,  7 Mar 2022 06:14:48 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 227C3JR1010119;
        Mon, 7 Mar 2022 14:14:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=cQjdDi3VvJBy//1cJuVIPBeQXnFCLpq8tDbhGqa/zIc=;
 b=ws56svxy2S7zS0sdl0+jdRv6Uci++ZMchRU81/1Qmn/U0ZPHrBhQ+Pnb+4vFlp8Dd3UP
 8xdDdxjUC7F1vcP8ayCgtfYSztoDU3qLNpIrPzoYHoIicH7DyXuKSOKo3s3Vo7lzuIjv
 AnmE1sfXaLHGpGs1bsDtl0dHz7Ew3AYNiKG0tf32uIhKJTQ/L+UVNpUgpYp8QDNQSyje
 nZMnkqkai/EEXcmDX2/g2cZYoVsW1lVyetVEVGb1Xk/G2mU5+rT/yqXBYWuZmZybrfh5
 TNbuJETXd3mhors5uBcD4DkI4Mx+nxa6N6u0JMOjRHiwhIypMBbuh2dkdwc1dUJwSzjJ tw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekx9cbvh9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Mar 2022 14:14:38 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 227EC8uK008936;
        Mon, 7 Mar 2022 14:14:37 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by userp3020.oracle.com with ESMTP id 3em1aj1dt7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Mar 2022 14:14:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJGpBuHQiEHNYHnuNENo8ZfoiPjYbTRRVc05XFFUM5JbUBJ8GYFL1HLqXzgqg9K0vAKuMTDs+q3JBghRT+eO3Oq+gc6pxhLAxGBrfc0LbYySZzaSMLn403JiYzD9ZsgD2ta1mTEWW+8Gr8l/4xsLmrW+1FvMCvWou6+vV9F12jRzapsN8VsvMyAj6r5GiIr47Pi4yUYTHiiXImK4qyZwHwl6jBu5h+U59/zgsIUZYgEReew+sj00Aiv8NjcxbDAx79ugbiziWuqz1XYwjfNOHnraTtavjzBCn7Bz4rhBzwEWUyElmT9AdMLYggx8EprB073MqggN8AQvHFB06CbWOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cQjdDi3VvJBy//1cJuVIPBeQXnFCLpq8tDbhGqa/zIc=;
 b=RirVq/WYDQkgiIk0Eu5ymtOTUgTD3hOLVWn1MSwU5uyhzj3zcEMPwoIZhiOWeTBeDVlJI5mkh4P7yQNarlrD/Cat4xl90gb8ZkQRnxA4eyAOPgBvbU9JJ1fjbh73T4aXbdXLNBtyb5fi8A+7g8cAEz38MmolqV4KXUm+43C6PhxESOZISPFeAoTv0+1FHGjeiH86joGZP5O1z+XXgAaZj4rO1qNvi+4tg/rz+cgHsMr2D0UH4NMJX4exz8BXIcHWxdulydlE/dk40P3qZQodA/hbuxnNK2WYk2rWjDhP2aQe53XOPp5doCaqgvfrCRxNX1i8mSYg4Yh9djklBhdb6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cQjdDi3VvJBy//1cJuVIPBeQXnFCLpq8tDbhGqa/zIc=;
 b=LY394R2qOyUjxygoFcOW0dXt/qz86JCmGncA/kHHehI2jVFN20QssNnTK0SCHmK41NpzFNFA6g0sb7aPScgddhXuqrDKY/lcdYJ6tmqwvSAxJgUNYRk0DFrMQ7enAnxHr0u3M2Sggef+DA4DWTb12u3fYsxLTvfzDzNZWVGs6PQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH0PR10MB5162.namprd10.prod.outlook.com
 (2603:10b6:610:de::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Mon, 7 Mar
 2022 14:14:35 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5038.026; Mon, 7 Mar 2022
 14:14:35 +0000
Date:   Mon, 7 Mar 2022 17:14:21 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Arnd Bergmann <arnd@arndb.de>, Ricky WU <ricky_wu@realtek.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] misc: rtsx: fix indenting in rts5228_extra_init_hw()
Message-ID: <20220307141421.GC18867@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0080.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:22::13) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d70715ef-2bdf-47a5-588a-08da0044ce7c
X-MS-TrafficTypeDiagnostic: CH0PR10MB5162:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB5162E0EB79EAED63293644398E089@CH0PR10MB5162.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wJRlwa4T7SWtDM4gr8dugCrp//P2/Wkozl7/2CaU7TNAcSWaz0qmx3rn86qmCWTDkV43IJyIN4qBNKPdEA5hEm0E3Ks9jxK7dlw1GHtOSvjqR3Z1a9IDRK4lLZtJ8YoFSw/lYF1VXQD2/BlPJpkT0RPoHFhMlfw/DfRRwPLnJdJLFPbZ1A3EaqZ1Ta09C6githm6h977Km2URxUSJmDCNwEQhaAhOslmmgbRkkzojyeDR5z44kbO3CicD3+SduKYtSBqmVeRtSH84/tPLmVuGacydUgdfViswp/NjG7/T0ApBHTWVx2FO1E1Vrp84MFXWiXV86tsaIwedYVhWen768FBlUYK2k4yIjL99u6a8jv680P1B9wEjXogzWyDrSXfbjmH7r/YYxGJACxds0gDkdgMi+mnin5sDzFM7vjBqjaQPVetyciWT1D3fDVstCZ8tXV5GsQBjDnchRuYzoN3Jwk/KRZNk0cdIE8a0W1MqGoGNuNHLzVelDwffLwFoMHHa21RScWGMb8EkbiPnlWezPOXKjU5c2hYAVMDvzfFZOKPAr1Tc4owk/IraG+c1BIJMo+Sib+oYTcfSdHEhv8FTnrQpIf/uhFIx329NJ7N9WXDv4RwKDe5hPk2ISwoBI6E1zBYw5o4ZQKdzhPYMXOlftWK1aeEob4vKUMKfNHLLHbc9x/ebqsFlHIt5tR/CnS/cvAn8rIUrVm35UsGlQ5fgA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(186003)(38350700002)(316002)(110136005)(38100700002)(33656002)(6666004)(6512007)(6506007)(9686003)(52116002)(83380400001)(54906003)(8936002)(1076003)(508600001)(6486002)(33716001)(86362001)(44832011)(66556008)(66476007)(5660300002)(66946007)(8676002)(4326008)(26005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xLTcP/zs8csNjnb+ZBEIxRax6aPns9ErWkqJXxY8higRKkoHguj01nAYvDO9?=
 =?us-ascii?Q?MoespUH7qsohEAW0LNEfvHOLs1iozlvy2cYseiwO/VjbRWnqaqz/T5N7UGtD?=
 =?us-ascii?Q?VqUgk3vt41KnbHnYWxisugxCnPe83gfby7R7pSK7Fj9hC6UPS7Zi6Chg/Snr?=
 =?us-ascii?Q?znyupILl/DcgZFXSN8yNAQTsqxasK6D9vGgs4jkPkehR3EdI95EIOH4SVV8L?=
 =?us-ascii?Q?kqBqbbUredoqwHRuZ+wnUU5df2veVDeDDq9FO6f+6QRrds50G5Ynia0FrtNB?=
 =?us-ascii?Q?gnXMVN2QtS82rn9yLEJD7bYNpTaHh+U10T8NTALqV24BYCPnBmhOfRLt7EAC?=
 =?us-ascii?Q?t5zGYRj59f0pbrEsTkiHkcSzLsXGjMLN0UDE+uACO7vRuTieeH9TymHKH8dx?=
 =?us-ascii?Q?1VL+nV4bVUOBXHinif6jAFYvhJry7mI+kprGtXG5/gZqkIalOiaBw2mA68M1?=
 =?us-ascii?Q?ZN3xBuAOTeqeTbcOCAejJJ7xAAZgxrI0zqtoIFd6fAXA0fsd0wtaON1XAZvj?=
 =?us-ascii?Q?8iIob+hK//rXrMVOgfUS3kA01lpLvVA3U5KISOdFBattBtvjFca0bJ0Y/cex?=
 =?us-ascii?Q?LkMmibZo91KfQTxnKfDEImMmyqY+p2Cs3y0XW2pb89l48l78+3CZnoXJ6RvC?=
 =?us-ascii?Q?0Xxso4UBThWTTDtDkS8NvNwc5OZSo68+1uW5Tion0bGEhUXWmJZQ9pboB50M?=
 =?us-ascii?Q?aykCuM4vCYEegxfy/EZ+mdUHJ+7rIFokc93Mwwn1hCwSYTUQrrU4swFzYBji?=
 =?us-ascii?Q?i4N7GUFlvml8uXqRvh7QsCjyp/9h9GIphO42gb7hBMtxDKjkAHMo3NOywPKX?=
 =?us-ascii?Q?EC/Bv2x6v7W5e86poS5TMHFZRbwejAt4tlxBOL+/hUdBzGe+5n0pGCvEc9XE?=
 =?us-ascii?Q?P8+lhYdyR66IEzywZOIAWG8jS8oditxL+sqvYCoG3KkimM3vIkYjpcTK/YpN?=
 =?us-ascii?Q?bTHAga+fre+81wMKRPNzxwvBMhGMrclO1SMN6c+s7OXUZe2DH9JjPunP9wjO?=
 =?us-ascii?Q?XoqXHlFhB0yWYax0WpY1cAOcO2kAoi5Wh94PFT8WnC0wdQPVyxmQ6jgCnutb?=
 =?us-ascii?Q?3wX8C0JWA+BNPTFxTzKI//yu6SQtWcbbMOc5Evv8/h9tYEZxLL34vyst3lzj?=
 =?us-ascii?Q?o3OULa2rB14dKQnXNGH/Uqq/xtxqWCpqVdg4w1ey+og2Nlb7f0ruuPNWtWxS?=
 =?us-ascii?Q?Wy6XknROBif992DwTjoPIiD0jVp5+JqK6HsiSwIxrRijz7wbXoUSNwkZmxgL?=
 =?us-ascii?Q?b1c781cD+w8quRTxfKETzt9WeLDPzQ6meoLkOUd1nuHs1HnI/Vt7jkXfumiL?=
 =?us-ascii?Q?rUTmCBNM9vMrEiEj8Cic/scXMVjVz2DPFfJKz5hagTIk9blrUSmyaXi9Zu9w?=
 =?us-ascii?Q?yqQ41velmAo8fjAjONutnqxlo4jv1+/duaorZ8aezFtnDGHlzTuhmDIK/kOA?=
 =?us-ascii?Q?hy18G8ZRMzfA0o5FkgyqWt1f8fv8QRrJcArD+IBagFP+yBMYgR3shUH0ux0e?=
 =?us-ascii?Q?RMxU6bRQAfd59PE/1R3KLXF2yoiOwDOyXXVkfs+Mzj1fKhHqW9NkH6taQ7OX?=
 =?us-ascii?Q?UzeL0O171D9fMsbXD4tlNhxLPd2AB02TQgOT8fbm7/wSSlha9u6ejqT8C8Ad?=
 =?us-ascii?Q?/rvkRFYlhSI1uLWu9S7/gOYnlwudARXsR77LHnzbsmIp9hB4m5P8UU1/9Tbl?=
 =?us-ascii?Q?Zb2gew=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d70715ef-2bdf-47a5-588a-08da0044ce7c
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2022 14:14:35.1815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rT5rniNzYga660NG4VeqW7tOfOyd3W6aS6CB+hgtlHzHhQMRONbtFRE7ARcyzzwsAXd2lEPVrSwyQBXkb9TRKKTeG+b2ipPCBtVtXWyBkK0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5162
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10278 signatures=690470
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203070083
X-Proofpoint-ORIG-GUID: 9jO2-qF4Bq5pOzbAXRXI_a1eAAuZ9NYO
X-Proofpoint-GUID: 9jO2-qF4Bq5pOzbAXRXI_a1eAAuZ9NYO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code should be indented one more tab.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Introduced in commit 86f4c65fd500 ("misc: rtsx: rts522a rts5228 rts5261
support Runtime PM").  No Fixes tag because it's not a bug.

 drivers/misc/cardreader/rts5228.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/misc/cardreader/rts5228.c b/drivers/misc/cardreader/rts5228.c
index af581f4f74d1..ec97854e1f70 100644
--- a/drivers/misc/cardreader/rts5228.c
+++ b/drivers/misc/cardreader/rts5228.c
@@ -491,9 +491,9 @@ static int rts5228_extra_init_hw(struct rtsx_pcr *pcr)
 
 	if (pcr->rtd3_en) {
 		rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, 0x01, 0x01);
-	rtsx_pci_write_register(pcr, RTS5228_REG_PME_FORCE_CTL,
-				FORCE_PM_CONTROL | FORCE_PM_VALUE,
-				FORCE_PM_CONTROL | FORCE_PM_VALUE);
+		rtsx_pci_write_register(pcr, RTS5228_REG_PME_FORCE_CTL,
+					FORCE_PM_CONTROL | FORCE_PM_VALUE,
+					FORCE_PM_CONTROL | FORCE_PM_VALUE);
 	} else {
 		rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, 0x01, 0x00);
 		rtsx_pci_write_register(pcr, RTS5228_REG_PME_FORCE_CTL,
-- 
2.20.1

