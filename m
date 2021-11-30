Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C4A2463149
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 11:42:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbhK3Kow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 05:44:52 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41190 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235368AbhK3Koq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 05:44:46 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AU9QROM028188;
        Tue, 30 Nov 2021 10:41:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=kgnVrAiAPrOq2JZydUTmN9p3HMj24HbJqgI6JeW/M7o=;
 b=P+wJBc3qIsu5ibScLyMz3Z0568c81dUgw28r4Ai+p/gmrwZFJO1WKv9CBrOtsC8PDu6/
 DK4PxGYNvtRFmpUZThrAcWQGcyoSPdhUmy7W0JHIlSLk0Jgb+JeSBRQT6DC2n7Kty4lL
 cnsTqNHFx79go5R/l9RSuWgUYGN+n0wAC3ZYjT/vkgnDthq6LP5xzIh9yudeYqIg/dit
 M2YYarFhU88LzL6OkTu887gocBYmjpVXxwYouTe+mmMHtBef7XXGAo0BsLkBcLicg8jJ
 3uA7yBOhN0pdp7wfXRxIk2S6m6NJkVl8dD5jQBPi9kU/ccSkPfKbJi9xnvM5FfNxVOYU Og== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmu1wfuv7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 10:41:03 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1AUAVgVY190889;
        Tue, 30 Nov 2021 10:41:00 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2046.outbound.protection.outlook.com [104.47.57.46])
        by aserp3020.oracle.com with ESMTP id 3cnhvchj2w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Nov 2021 10:41:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EqreSFtUxI0CNMTonG8P4ho65ZBKxccIYRGEbDf/VxRHPqP0ktbljxqEhejj17ZYc4O9+xDpTemDQeyLRO8rL1wjtGbDF0OSxhWo3pJoyxUYlt4nMkQHK5LrCqXM7s88kzomKsLAtwyboXAr0KETkBkLD6knhwuvAxLwQhopZLQ5WGgbTDj0f3U3NzY3XQ7I2cDs27mKJHYpUzvh+x3qFjJBHLzD5vhEsPQsXEgAyLuS2oEH/Rv3y5yIKWYaJ3fCf5DQlQ71Hha90SIX9Ex5RaffF71Wd9XLha6teyMpVUOsgXnaKhM4Uq0/Ldcvs7Bj7LIRz3mxMkGvxrVOZJNdhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgnVrAiAPrOq2JZydUTmN9p3HMj24HbJqgI6JeW/M7o=;
 b=CSMiv9sT96lGs09AxdsO83zzkjS8DtIbj4N2RKICBGeqBWMszROK/ckNJGRwrUBfmqQyRiUOUEWo6zu3hbk6/8wmmgy8q1BkFQQmHC6pFnvzcdTFsYQAYFVt6slgAJHvb/HX2huzspYHESosLi9Y0f4eBmrL72KPLS6Fkzh7nAZm2X7LhsodDD+9m1gIo+RZgMAekzMv85pDanGaq1zYK38rbLblT2qMg29ouwAOLG9QYFY0NTCBgFWL2b/WjGhvi97nc4PtMQhzO+vTX08QAzTP9ymd8LfRseQEwTuhm6YSEdJR2e6Q7UErYo4QDoCTVRtEVHaghPRIkielPBR3Bw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kgnVrAiAPrOq2JZydUTmN9p3HMj24HbJqgI6JeW/M7o=;
 b=X1eEeYsARkXmej0p3gJFIM3d0Nii3B5a0WiB5XQWW5SGdrYnMKhJ149WsMmFQ3fHQ1pl9qZlESitrW3Xy+DjZpQfmjqXqXfadOwCXaxf0mk3VwIWGwe5IQuU3ILjHAIKlw3A/rjFx/XVQ6E1FqaP6OgwuFT3YiUxBq9nM/Xu90U=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1357.namprd10.prod.outlook.com
 (2603:10b6:300:21::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Tue, 30 Nov
 2021 10:40:59 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.024; Tue, 30 Nov 2021
 10:40:59 +0000
Date:   Tue, 30 Nov 2021 13:40:43 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mark Fasheh <mark@fasheh.com>,
        Wengang Wang <wen.gang.wang@oracle.com>
Cc:     Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Sunil Mushran <sunil.mushran@oracle.com>,
        ocfs2-devel@oss.oracle.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] ocfs2: fix uninitialized variable in ocfs2_dio_wr_get_block()
Message-ID: <20211130104043.GB5827@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0127.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::6) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (102.222.70.114) by ZR0P278CA0127.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:40::6) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.20 via Frontend Transport; Tue, 30 Nov 2021 10:40:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3869521e-f45b-414b-4600-08d9b3ede576
X-MS-TrafficTypeDiagnostic: MWHPR10MB1357:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1357AE97278FA10D073660AC8E679@MWHPR10MB1357.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XhdqSxv/MYui6AGZMyM9K+5BPHPsTYeI0TU+fuyL3KEs9PXkkuZkDG9anig7rCjj/WxftzhneVeqHRsoqQIf+ruwFIsoNHScG3TfLfju579txRoRClO1NsfGnqqvIVjEwp64OIcf5Yh4oHJpsSg1jFqoUtRzTs7Wy/l5nOVfoAkH5qAXAMqvIffZHlIesEw0V/FCvNWAb6DzoBIXK/dsm2vOp77ync8trflZszqHihMvk9Zv/9asiN5HaH0Wfev3rPCqss6JPCrQF/w9K4hNYd8JBujKurThW0ThVHRCa0t0jUXhFtXID/1NywWc1h0fef3Vu/VxOgC9yr9J8KutAWRuF5IWxyNtu6Bu8GbIQb9+lfgJ2wwiqKGGSflbr/bDCePIhvWvxYYR5+dWdzXsN+Owl954PBjjRCxwTo1tPj3QhSY/citbj/PXS1tyVckHqpuFxKypCvT5aKeW/ZbuEJ9V+W2shyRlLmjaVw5HNGjgXkjfOWldVCUSWx8mmAi52TUOozw6aMmMSqEmD+fcUCWUEu+Y9RgC4HmZStvhY6/pi6+rorGWyoR6YA9y1almrSxF9aR70V7ZewuYTtYRS5aFyBHeJ5QwJU3jGwgnQ3wHAdSan47620Dh1hXV7NeHKyxzjh+Bcux73AQn1bdsflgLnTu0xZ46ziczrmXfFcxfJ31g3odOlhEV5KqdHvkublQNmYY3muLGkOtQEAeEyg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2906002)(33716001)(110136005)(9576002)(316002)(66476007)(54906003)(8936002)(66946007)(44832011)(38100700002)(6666004)(83380400001)(38350700002)(956004)(9686003)(6636002)(26005)(6496006)(186003)(5660300002)(86362001)(33656002)(508600001)(1076003)(8676002)(52116002)(4326008)(66556008)(4744005)(55016003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?73Rri0gtGoA9oZ1K47iFpQLY/08ajHOlfUYeuHc2SK2agCIA7nHHcPj8o7Bh?=
 =?us-ascii?Q?PiLZ17p+FZPBUb22Q0zLwhFTGdmVfNCXCBxSJVfFRzA1STjrrGrOpsjcnIH+?=
 =?us-ascii?Q?nmJcI+29kbArY2RnZFTH4mG6lAeAYm/2NOPPXt7JB3lGRngL712gxggibJl6?=
 =?us-ascii?Q?BoqAsxbi+PK82fU4T6tVg2Dy06Y5fujM/0BksfulOOio2lgl20EufoVf3DvA?=
 =?us-ascii?Q?5eb4A1kMoTD8GhKBS/mPRrgzMo7+k87t0cyL8gu3jUki0SZCURcaAWrrdlQm?=
 =?us-ascii?Q?2iJym3FTpiBbTNChpZXpl3pF6m6JKBjNvn84haN8RnWZ/jBjISzlxC+Pjx/1?=
 =?us-ascii?Q?5fnpphbzLAZgjELA/oC15aMiFTu+el7UaMOdZkaxDgmr31epxCpQFoR5nLrG?=
 =?us-ascii?Q?OY7qE+5qoRYAK739MwbrAe8yEONR50fgLboUCXIhmWvgP3Fs31QsFW+FDyE5?=
 =?us-ascii?Q?bN7Fwsrljo5tD0kv5AwJSOLclJPvIjITPfnXmvv7qkyoqEVjhjSDaWRYNsOX?=
 =?us-ascii?Q?TEWPbJcF2Umhr9Qbl7HHW+NM2YkKlEl5Jm4QRiyTzeqLJKTnRZksCJ8QT65R?=
 =?us-ascii?Q?ADGuMv1KtezlN29rT9DK3iGB2R65Bn8db3kLwu42k1iesOfLbWzQQhX15JPP?=
 =?us-ascii?Q?CxHXhl64cRHzZZoVrwGJWV60h/+ijSqX0scg1BNhq24uvWPaVUXJU7O42l/0?=
 =?us-ascii?Q?wvjeeKJSf375C9EwU3lmFL+AG6zigSwtd74YjeiqBStwPTD+wUSYAwnBhhd3?=
 =?us-ascii?Q?0kj3fMMU0QA/N2V40eciBP9S6RVEAjX/zRnJ+WQx5gn8VZ7GFa5ao/1YQAQM?=
 =?us-ascii?Q?/CO3TnHmKLgCiIvaCGv+H3R81HAjTbPilw1e0MP1UGuSCClgm0hf7ZwUMwl0?=
 =?us-ascii?Q?jiLRJWtFK3MqMPcGp4Ly+0bvDRXzu7jNK7Aplgos7CT35YYfKfNzWklr/s47?=
 =?us-ascii?Q?7Mb3qKoLyDNkkjSHg7/sJxF0zeQ3iqsGuZRob4mh7ssELVx9ZUzbfDOM5v+I?=
 =?us-ascii?Q?3CDR51lmDXbeUcrHLTVHSk6wwt9VdepRmcCxs8UXnWgUwCMFZVS6JR34Ndd5?=
 =?us-ascii?Q?WPmirushBUTyJIjmFdQ3myvJIQw6+BFR1vdeSLPLy2RY4FP8G3r+8FVxoTvL?=
 =?us-ascii?Q?ZkdBaF9xO1LcQ3VTevSRtr1zqcDk/rvVUt4WX3i1Mo5tFve9wWhUbg5X4gHV?=
 =?us-ascii?Q?M7LnOqJItRUDH/WK1sJCODDN1OyywRrdV0DdudUsZk+amibUU/DI3yMWvnKY?=
 =?us-ascii?Q?iTi6RPlB6r/2vRVXXicpHogQJpJQ607nDfQEoxnqibSpFj+jmHZzWBCGKyzZ?=
 =?us-ascii?Q?Whn+Zgw6j9xH8eOGrQ9LZkh3maExIRHqMo1rjdgnqxTuk+Prw8YoKVX7VRvv?=
 =?us-ascii?Q?HMzLPGgRoRhYJPGDOeWhh6zU8U25wdH8Yg1HW1uQSCQ/w/T4G8FEhGA/AkdI?=
 =?us-ascii?Q?Qe7uk+XK8EYBPY+XaeqQKELO6dH3hV2ucFwnl0X0/Ps8AH3seHTgb6PTW/dU?=
 =?us-ascii?Q?PjxVLMqFH3092kJkGn7bK4l9ibiv2+sKKwByAdnsEnsSJm7pNQQ7KgYXiZKH?=
 =?us-ascii?Q?zEhXyM5iNh1kNPLYal0EGX22bLG1vvodatWFned8K1yTWh58NGw3jqF4aZlx?=
 =?us-ascii?Q?zKUEY1MHcjeSUqUUDi4A7monYvnX4ncgv9xDrukcs9tFBEzXztW8XDO3fXNH?=
 =?us-ascii?Q?F5uMsOAIfEMdZAg+15624NRfavM=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3869521e-f45b-414b-4600-08d9b3ede576
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2021 10:40:58.9369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C0lfTSrpJGzdlXASqd/vSvCzyeIShhfo2xDXoYcnn5fEOINoKclg9hxW0gqBfEpnELEEtGmvboX1CjSXTfmHMPuBINV6U5diTII3QnPg48s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1357
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10183 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 bulkscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111300060
X-Proofpoint-GUID: 4WxwEBm_42exwgwYp-y8TcPWVactkJFj
X-Proofpoint-ORIG-GUID: 4WxwEBm_42exwgwYp-y8TcPWVactkJFj
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The callers assume that "*fsdata" is set on the success path, but
that's not necessarily true on this path.

Fixes: 5cffff9e2986 ("ocfs2: Fix ocfs2_page_mkwrite()")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
Please review this one EXTRA CAREFULLY.  It's from static analysis and
the truth is I'm not 100% sure it's correct.  I'm also not sure that
it's a complete fix.

Especially, please review how this is called from ocfs2_write_begin()
to make sure that this doesn't break anything.


 fs/ocfs2/aops.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/ocfs2/aops.c b/fs/ocfs2/aops.c
index 68d11c295dd3..a74a370f16f0 100644
--- a/fs/ocfs2/aops.c
+++ b/fs/ocfs2/aops.c
@@ -1813,6 +1813,7 @@ int ocfs2_write_begin_nolock(struct address_space *mapping,
 	if (ret == -EAGAIN) {
 		BUG_ON(wc->w_target_page);
 		ret = 0;
+		*fsdata = wc;
 		goto out_quota;
 	}
 
-- 
2.20.1

