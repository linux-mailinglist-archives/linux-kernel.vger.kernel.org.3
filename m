Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1590246EA20
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 15:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238777AbhLIOlB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 09:41:01 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:53416 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238757AbhLIOkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 09:40:55 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B9DtlOc021513;
        Thu, 9 Dec 2021 14:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=363PYJCGj/Sj/FAyE0BTvZKXkn1Cdfx6wStFInVe6Js=;
 b=sK0T3WRN0TiMpAD8kxUQZIuZ1e7cnAoS+bb0sUwvJQI4bo4UnUTaJe6Tem0VL2YwR9bA
 FK1w9KDDHMdgkx0TLpueEtu3OSCIJslwUw6Ai0H4mL+qe/htrWKEf7aGjoWXrq0JHPEI
 HC+HMUltUpUwIcj5PPZMRWfHd6lxSwv5EfXA2tfU66AyhlTXYJ7IP5PZKXZXw6ASbPCv
 Oo68GZ+LXPv1/1AAJWPs6MfjSaUPpXC1WYtNDA/vJLAOOgT/mokDji+rbAaiYIPEHjls
 Bd3D53gMJBK8wm1BR3NLir4ZBjqOXMyxDwcrLK+8B9hBMTtOJqW2RYI3kSdzN6D9g3xw Cw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ctup536pf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Dec 2021 14:35:18 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B9EADri001477;
        Thu, 9 Dec 2021 14:35:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
        by aserp3020.oracle.com with ESMTP id 3cr057w71y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Dec 2021 14:35:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LgD9OE3v8UijEhkFKf13OspdGZUs3sI7b4lDsUpzhUinTr0jHypFW9H9KrYudi5deKSUfCRwBb/A5R7KdAL35mj0VUwWSzmbJMrW62G56QnXtAHm58uUkmwAQoilAr0L4v884cSUxHq+7w4rAiIIj3crfzv+qt49C1tOh1GxwxzXXD3OXfe6fAg+91UI7hEB2jbUicwCARKpSKksg21Ya3rDFhOecz+2ArqK35nFp2bX12Tx1t+eJDD+5dpUMAYQPC6NHcImv1zQSm3LF2gYKacYIDqEQdluukZo9XKb8OGW5DIYFWSOKOJRkdapg+ts6SzEymxC0zalbm57ZtR6SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=363PYJCGj/Sj/FAyE0BTvZKXkn1Cdfx6wStFInVe6Js=;
 b=Iw/xz7f/VQB8mGTxu2zhvHN73F1dAFFV3i1jWRrq9JKp8fsOyh4EOorWdpLDjc7kyGh4d/hUvyPz0Vh3Qqf9SkjiP3zU1BDuQpLKVYJInP9MRsS1LVBXn51U4Acpvc+S7GxsEihpZEwjahuS/UOSh4SzxDIniurhGcX8Fa+pLdbrgYMpqV0vz0IWIq4SmS+FmpGfVnWf4Mdx7yToZoiFmiuGOh5f7fTP1nc6yI2xhtbhUjzLloYZFU7cMwy+pVfZNOLdYHjgvYpAB8MOGYUaXREgDf5t7V+Y2Oqd+Dgcqg2+plxgNOZyvHOa/QC+VlX1LC59jvwmOTpECJSRNV3dyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=363PYJCGj/Sj/FAyE0BTvZKXkn1Cdfx6wStFInVe6Js=;
 b=HgXX3Zd1jLm8X+9tRBhRQevUSSwJG1VqdHZzXXYtbIPTBAqFtigkux/0I5wGKTnp/8EVv/NJz94FhMr+CAy7PNxYZsur2bUpEK4Zb591VNeCIWlBF1nDBcnkGjrrp7txfWPd5VxVJp7gACFGyi2r9KZLN4/ChwHdZ4CDEzcjCTU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2397.namprd10.prod.outlook.com
 (2603:10b6:301:32::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.13; Thu, 9 Dec
 2021 14:35:15 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4755.024; Thu, 9 Dec 2021
 14:35:15 +0000
Date:   Thu, 9 Dec 2021 17:35:01 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Benson Leung <bleung@chromium.org>,
        Bill Richardson <wfrichar@chromium.org>
Cc:     Guenter Roeck <groeck@chromium.org>,
        Javier Martinez Canillas <javier@osg.samsung.com>,
        Olof Johansson <olof@lixom.net>,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH] platform/chrome: cros_ec: fix read overflow in
 cros_ec_lpc_readmem()
Message-ID: <20211209143501.GA3041@kili>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: LNXP123CA0016.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:d2::28) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kili (2a02:6900:8208:1848::11d1) by LNXP123CA0016.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:d2::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend Transport; Thu, 9 Dec 2021 14:35:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ff7d65e-012d-4874-46ad-08d9bb211d53
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2397:EE_
X-Microsoft-Antispam-PRVS: <MWHPR1001MB2397D98C135AF26947DBBE868E709@MWHPR1001MB2397.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4941;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B1mclBiNNqFKP8msWJpqT+pfYb/s+0mVbDZQJLnUO9jY4asQHVFjcXRz/oJUf3lkRT/dMS3WjKGoUggR2sjaE5L8xIwe3Svd5gDwos55ACwfwasnZDUU8L/tSPg1uoxa2+5/pxJT1+NezGx0ACBxwXiFSKLfBMUcjcZwyHkDE68daLcz+DoxOHJfUhl6VlomfelQyJ4DAv73daSdq90wK47KdtRQtO2BDe7F2/0WhOCffCx2xt//kXfJcnUciIbJzpS3+akqrPa7+wEAl3l7hxbt1qmY2l+C2WZaFegLQeifT8Pf9ak55ffD9D2dx8KJ0GFbxu2czveC93Pj8RAtZ/rPnk0ZURnZe36MjUKyWFR4CMdV4p9j6ljaUB60Idw0mS+b3d0F5hCGbN+RPjqLvYuYgoYtuq+xBpxoHn7zMOOJ3fzCS0NR5tQuqAdpZanzztCHOIoJnwjMaA/g6ozTXJI+3GQXS3Q3/V8i0slsTMtFl4Wt1SeCZrZQ9gV7iMjxUcn5io2MAh5W4EAEDa46KFNHhTNXmIDJRYVYa69aNBMyHaWSVe4vUVwzFNnQVOCCsBgDKuUz2L4Gf8WKwW+D+wVoAeqOT43CNBIsPPhzDxsLOI5XISOwxBn55M4rFCSP7wyyHLMj5+03QZSgtRC9jg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(6496006)(38100700002)(9686003)(508600001)(55016003)(8936002)(33656002)(44832011)(66946007)(9576002)(66476007)(4326008)(66556008)(186003)(54906003)(8676002)(83380400001)(52116002)(86362001)(2906002)(316002)(1076003)(110136005)(5660300002)(4744005)(33716001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gYSRau7h3Vcpqp8S6sNaLB2pjibkI/lzqnZ0oqmWc57gy3QI6kYJdARJxIqp?=
 =?us-ascii?Q?JzDcGwvsv1Q3xV61SuWsa6yLF18U+PQHEIlkf9Kj2TJhqEuHNFL5dJIhl7c7?=
 =?us-ascii?Q?OyGSaTFc0tZMQEMNqJZI83GmIp8IK+MQe6mgDw9UeiV/JfdH8u/0kiKk7DSA?=
 =?us-ascii?Q?whbh9/txPKw92QLHETuTFPGTxeGC3ZccqiEnp8Ud2hOpCrz/7KNPrw9oG8/S?=
 =?us-ascii?Q?8CY6eps/4jhVCJVm4sZVzsNXKN6mRZoh3rIEpvx4pW2idNGIQejQlTvRz9Dr?=
 =?us-ascii?Q?Q3lzdohh/1fBquajbKL4bWwUCGbzGhU44Az2Nep8p9SOl/kr40A2jmkQsl4z?=
 =?us-ascii?Q?6f9SYEQLuBDnA5GTfuGL6PnK0CtXGckK7274ZCcyveKZOv5dIauNPc2Z/EtU?=
 =?us-ascii?Q?vu6VG+Isqbj24JibwMVUnSQg3gE65JpW2PvZt7KFGj5mpDp02LvjZyrRME/m?=
 =?us-ascii?Q?rl3ryJ6aBPYkB+q4BnC95zYsb4lty4Md6n84E+Kp5yqowRdR6uPFOWih4w3k?=
 =?us-ascii?Q?I5YgeOmg1tMuW1btyUW5klGkMauTgvzSnJVnL/Hkr9Ym8pgtCZ+vVffOJHs0?=
 =?us-ascii?Q?NOcQsYdY4KNUmpj9oL7uxELGo3M+QD1S9CyoFuo+NkQ0QjEYKs7MXVmxzqwQ?=
 =?us-ascii?Q?9l8fdk2e6ycGpdhC7q5Id05X0yOdB6PL7PtXzCDWeTXkbRBobxFIFHA0Oi90?=
 =?us-ascii?Q?nCLZQe6oljroO63RxsKTdS7TFBC9VliZEju4BMTVXoWBXwCA1pF36HiMm/ys?=
 =?us-ascii?Q?ntL2+Gk5dTAS9FkS5dEN+COobY9vTsOLqz5BleHoKEoCSroyljoS7nDBhqES?=
 =?us-ascii?Q?SVy8CXMAkEDAoBIA/rX4UTCG+4X/9WPdVdkYjrIez9NEycwC5TXy0hles7bd?=
 =?us-ascii?Q?RLek2JSFCRmDKoKZtKCcZQjxcn2LMezp+gIkU/05LrcAHvVHKtcXF6wWaO2A?=
 =?us-ascii?Q?0B3ep4fYOURsIQ6lr/fvRwkqTJlzbhEYhJS0MP0G83jn4ucEF92mXVZyAd5R?=
 =?us-ascii?Q?XoCpoUiqQMPPa6icFQYLCtGy/bUXHLJNvglvmJCYtvyPrJcfYaERE1PD3mu8?=
 =?us-ascii?Q?Qc/I3c3asHRR0gH6uDlXuXVVn7kis9q9SRTboJID2x8TAsirmc7rs+EPzor5?=
 =?us-ascii?Q?wSIYCbE60XGwMKab/nRFUlgjU0y/+yJGUW62zr7KCmfDqblCfFKGyKdOxvjU?=
 =?us-ascii?Q?yDWWhLE5zBQQK+9Ik3dQKsk2XxKnRTujiloSgB0GMQN9ETrIDI+cRn8nUiNV?=
 =?us-ascii?Q?gt7F5qMAw/04nReqPr+E6TVuFh8ppeCFyfbYyIdrWykr0Z811zArtSnOII+R?=
 =?us-ascii?Q?Or6I8O4oiPwa2O7DWQWg0HFs+bRenjx6DbX3ZiH9pnkIowUSBuOmVstsAZdR?=
 =?us-ascii?Q?ymbWS7Mhgj0cMWVMRe+lYdCIMusx4HJiMoKfk7tSbqumYfuaWGjshbqDdTr0?=
 =?us-ascii?Q?4QReQIk89GG9ngfpgDa08gBcElLEUAU+7IcLx8ND6+GsInRQb9yiaGf0JQoS?=
 =?us-ascii?Q?saJGLFDYCS4Q4lXFeC0O4RVKfg5Buohqdp/mBk9kZTUwIj+XuWsMPpcTrkHt?=
 =?us-ascii?Q?/wo8An0YAOiQw97M2DRnQK1aq9d+POuQ5eNTJG2HcCmnqltzw0lOFOWfiYSp?=
 =?us-ascii?Q?MN7M1ER+WhELWQtAqNDeSCdEFYa7kr1+Q6SNOobE1ol6CGszNKwR540vIJ1R?=
 =?us-ascii?Q?f+rSiQPgnPpWFS99t9wF1Y4E/Ym7eCwsY7GMG71sD3NeGjc+?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ff7d65e-012d-4874-46ad-08d9bb211d53
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 14:35:15.1736
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QNjhPHj02Hpw/aBKdV/JIUWDN/Bwr3mdPvwTiEH86Vfy8zIxRZ79L7NzyblscWo5emP0UdIYK7qamtAWaxxIG8LDo5RlP51udm4Z+mBGskA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2397
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10192 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112090078
X-Proofpoint-GUID: LGZleoGPwEFZE1EsY_gVBM7ySZNLoTo4
X-Proofpoint-ORIG-GUID: LGZleoGPwEFZE1EsY_gVBM7ySZNLoTo4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If bytes is larger than EC_MEMMAP_SIZE (255) then "EC_MEMMAP_SIZE -
bytes" is a very high unsigned value and basically offset is
accepted.  The second problem is that it uses >= instead of > so this
means that we are not able to read the very last byte.

Fixes: ec2f33ab582b ("platform/chrome: Add cros_ec_lpc driver for x86 devices")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
 drivers/platform/chrome/cros_ec_lpc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/chrome/cros_ec_lpc.c b/drivers/platform/chrome/cros_ec_lpc.c
index d6306d2a096f..7e1d175def9f 100644
--- a/drivers/platform/chrome/cros_ec_lpc.c
+++ b/drivers/platform/chrome/cros_ec_lpc.c
@@ -290,7 +290,8 @@ static int cros_ec_lpc_readmem(struct cros_ec_device *ec, unsigned int offset,
 	char *s = dest;
 	int cnt = 0;
 
-	if (offset >= EC_MEMMAP_SIZE - bytes)
+	if (offset > EC_MEMMAP_SIZE ||
+	    bytes > EC_MEMMAP_SIZE - offset)
 		return -EINVAL;
 
 	/* fixed length */
-- 
2.20.1

