Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07E7346F4AD
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 21:08:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbhLIUMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 15:12:21 -0500
Received: from mail-vi1eur05on2077.outbound.protection.outlook.com ([40.107.21.77]:8288
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229478AbhLIUMU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 15:12:20 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LxTLDOIzDti24fwDclSCPG+tXaIQlVHFspQbbVliNUzCWdO8Ad533o/uQb4ec3YsQkdcdPMOOJX5awklyO52g+tftfUw6/lJqCU72vPF2/mAFUF5MYT3hhgE9wwvrlnBrRy/4km87A/Zb63+OCstjvY/0XMYkOHKDsn2MW01+DmaXv/d1W9/qlBl4Ktqi2R+y7z5tMDmtYZ+A46iAhGazVWwa8KmFnAmjbS6D8ceqCH3ACCnGI4Gf5+OhYa/yn2XVypyzMYXYkNFeLIWKaiFBGxxJgTeCWIJdloUNNZzbpWeaIaev4j4UYjLJPUtvy1dUrr7qETMrFAVqbIGhOodZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wcmW8bc0o7RrKT3x2sUKhwOOzDeKqN+eHJMjx+UoGEM=;
 b=OMwbCeRurSFFTJNpr9UE2IXO6k2ypAD6qskqW9adpwDUV19bdGuvNwbjB17ZjjlUK+UrtcbyTnZRkLy1TLNml3/LuN03e+EIK8N/m0YgOQpXWgSQOjPTOWqdDXVQU7pXdMiNAzcW6a5RJPhfbZOtq+ifJvZoYmsW3ieIELyPkR5oD5qxO/nFgOPC57UwM1QB5cipjFMU7zd/Uc0lOrslgA6+N/HdvmH6b1ZOYS9AR/36rh0k7bP5/+H88FLib9ayrtSVvFOqqFV15uo531WS2zxAR4ilqmz0B4aq6czJ8U4ct6YugrmT5kc84sxSqO6canFrpnLS2M+kWqbJPlZPww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wcmW8bc0o7RrKT3x2sUKhwOOzDeKqN+eHJMjx+UoGEM=;
 b=kk1DmRtAs0o+kTTV4oItlOz3DrwfHyIS8Jkn8MIkTXLXDEl5eJiSzeDrZt3hwJG4cNLCnn1H6x3wP+j5q3KkiLVZBhxEXzxPM7oKWIMnFeJPh7IGoEVbDJ3qgrw6/yQNrE1oITnvFBN3nqggS2ki9eaOTymLzlSzG1PjS7LY5UU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com (2603:10a6:803:61::28)
 by VI1PR04MB5310.eurprd04.prod.outlook.com (2603:10a6:803:57::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Thu, 9 Dec
 2021 20:08:43 +0000
Received: from VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::3de6:806c:e71:2a2f]) by VI1PR04MB5151.eurprd04.prod.outlook.com
 ([fe80::3de6:806c:e71:2a2f%5]) with mapi id 15.20.4755.025; Thu, 9 Dec 2021
 20:08:43 +0000
From:   Daniel Baluta <daniel.baluta@oss.nxp.com>
To:     broonie@kernel.org
Cc:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Paul Olaru <paul.olaru@oss.nxp.com>
Subject: [PATCH v2] ASoC: SOF: Remove pm_runtime_put_autosuspend() for SOF OF device
Date:   Thu,  9 Dec 2021 22:08:30 +0200
Message-Id: <20211209200830.145005-1-daniel.baluta@oss.nxp.com>
X-Mailer: git-send-email 2.27.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0602CA0002.eurprd06.prod.outlook.com
 (2603:10a6:800:bc::12) To VI1PR04MB5151.eurprd04.prod.outlook.com
 (2603:10a6:803:61::28)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (5.12.254.68) by VI1PR0602CA0002.eurprd06.prod.outlook.com (2603:10a6:800:bc::12) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Thu, 9 Dec 2021 20:08:43 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 12faf0f9-d8f2-4617-0bfd-08d9bb4fb34a
X-MS-TrafficTypeDiagnostic: VI1PR04MB5310:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB5310BE8FE6FBFFB1801C24E0B8709@VI1PR04MB5310.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1002;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JQ308z28QIuLfimPWhEh3vyO6DSC9tWCXnbWKVpYlP38b79Ep4DT8KCGoBjHwYTmzFN9XFVku++3F/mtUnbN72pX0n6G74ElX25RMLID2QjApU9npfONDYJ8elBqkqOvZ/jPg0fJ8zg8dwGgvLrRHVulB18By2ngHDkFIxcRehvv0Djt6cSscLFJAfpKWdHx8M2pRXUyKTnzA5WH6FyOVqQwefyMFTwGzma7cMyD546NIj8Z+jNKkCaGl4gwr5V9hr+wv3/UY23gbLhTUDHmR9YaNqZwROO9ZN1u05ii7ivDG/DXyWTP8i0G/xomRRBklby9883Y02GiBZ0aVhGzsyI7oolQwDJUzqhxJoQQ6sCFexbyvwZ/pvdQCqHgJ4IVjnuFUpGaG+hEljt6xqp+XI9QLydTigX/Bf4ciCvNqD+3Vr11vXKhO8CpznY8vEZhVLqWyZ/ctjLYaergmKxXQI2ofTcauMvcYMrGKb+nEXd3mlaDitpBo8gogCTadfzLAINdhZQzrsC25inXJgD1rA6SBU2bBcbrOn87Pvd9T2f7swMrTySuWnl/8jN00y3YqmSZ21ZME7VuhkkG4EUhdkLuwGciYGlV306+3ponmuEUKaRFZsidAmNdHo1s5JaJI4BF5Uj8V96zbxQTFl4fRu2iKiFCOSqyEXnWD0W+Ad3hXSB4vWN6L79iDb98xbZ6CNxzmTgANuQ0ltEfM8oHjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5151.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(508600001)(4326008)(2616005)(2906002)(66556008)(316002)(83380400001)(38100700002)(956004)(66946007)(38350700002)(1076003)(6666004)(6506007)(44832011)(54906003)(8936002)(26005)(8676002)(5660300002)(6512007)(6916009)(52116002)(186003)(66476007)(86362001)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?guXzyyY5rDdb6xPk7/4ru85LS8/jjkm2k9NMbWveFafF+gb+y3dSVAfIe81e?=
 =?us-ascii?Q?rRNtOko7uk0Ly/bqPODy65cqIpXoNFIHiOUWS43W/JKcamMXlMQ3R9Wvu7af?=
 =?us-ascii?Q?HOm0BxJHwiBqFpE3ZdS724R+aYp3bdMxG0ZJodKEYWZah13mEgcGHcMPiLP3?=
 =?us-ascii?Q?sE760SK6mQrzIK6u9/uaWOdd44cUM7JWC1rE+wH1rgLrVRAMfNVpT5URScKa?=
 =?us-ascii?Q?EFv0V4+xxj6ypK01d4k7mKCMei6EyIFg8FvgqlRCYitlwFDhDSOXjGfu4PFY?=
 =?us-ascii?Q?ilqVoM7uD8OakD9u8+Gsb83xEkwVTXgskM11WSOJFxDC5p+1YN3meEcCVwDA?=
 =?us-ascii?Q?HWEg7nrk3uPMJNxGYF6advgBZh8ifn2AyD44e9v7ocP1K++uNlJ3cggoj4iQ?=
 =?us-ascii?Q?MuEZx0igkRqFKaPPSHAQCp/A3sySV6KIhteo1xL12WHPdYuVE6XbhDveKIi8?=
 =?us-ascii?Q?mMJ9I+eBQIYFvEqqfglOuQEmldKF26hS21L9buyxwjlZJrCtARX3wGqOhaQk?=
 =?us-ascii?Q?tPXXe3gx3BXlNghvuxSUV4LM6+W4wRr6lut99swgo697MolBlNH0Dm94i6lG?=
 =?us-ascii?Q?9d5F642JUXqEog89zWAJgVHapNunBCXmilKjec3WtIoY1X8BAVAnGdek/LWM?=
 =?us-ascii?Q?xcFuchH2u96lU5M6Yxfcm8e/nS755vI67uEl6ZTRBns3QfROfu2sDV/wbjdO?=
 =?us-ascii?Q?eJvBogFjR3+HDACWMI/WbAZHixjgvabHw/PJdgrzSsUY97u8jImIhUYZfof2?=
 =?us-ascii?Q?tk0CmnOptLyypSXeoorrSGc2pm8V2nuLkr37dpBFHdcJFNa5Khibqky/qChH?=
 =?us-ascii?Q?wXel658NWJssshAQSvLXIyj1X/D5xekApGrvioap4zokvU+9a9cQ2rBm2hut?=
 =?us-ascii?Q?ts6GgtqlqHL+uqQL2SVAEKiw/6lSVXQ4LF984HVG2ddV9oykYTPBf66eC2Vw?=
 =?us-ascii?Q?Q8QoEGwQ+7TAM4mblMNm09IXjLfX7cUE84/0jkWY6wGFqSTi5LZsV06sRb8x?=
 =?us-ascii?Q?YtlO9AwydtY6IwplbF+T/0a36pZVA+Jk4P345jTgB6H/pb5BsUNvlanutnvq?=
 =?us-ascii?Q?3yzH2d5INWx3JZTyZlXLip/MbqAqZHDMvV+Ag8wDlHzNOkT/PKqX/wdxuiHi?=
 =?us-ascii?Q?JlW6A6Vd218PuyGYDBSn+lJP+5kMKmci9MPZMXSYEGik07EDUYIEEzBiLINm?=
 =?us-ascii?Q?KAT/ylPhW8vStMHmX+lri3/lmU/SjfY6ZDwtEyWyD68iI1S/OFkHIfJSzGir?=
 =?us-ascii?Q?p7dJWWNxvD0bhU/n5vgft/LjrbmkEXz32ioHSwvPqNZnlYsUyAst/FxixwbA?=
 =?us-ascii?Q?B0K4SbpnmrBoPYPgS7hzj0FWJSVZjquTz1wb380fVdssN1EQyp+sRPt9wWE9?=
 =?us-ascii?Q?CiM9H80idm/9OniEj1dGc1nWZLRRa1X9xNkIzooeAwsQi1XpVUk9oSwESbfv?=
 =?us-ascii?Q?5RVXKNsRxhUNwbxvNx2v25ejN7jwkkFdTANs+LZV46lAsERBHVPQ/gY/TCkM?=
 =?us-ascii?Q?7wmnaYQaFKBxBvkPDJYyGlN/XEgZlLu0Z8DqeHEXRhIR8uwZJxQSg3iPPhAU?=
 =?us-ascii?Q?fjizRgDGvyL4lXQ8VzbwCy8/FS4JDLawFXjphugCtMg2fURAp6bbtG4awlXQ?=
 =?us-ascii?Q?QL71sYZ65GUV6hJcReleJ5Q=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 12faf0f9-d8f2-4617-0bfd-08d9bb4fb34a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5151.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2021 20:08:43.7039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: i3LezJlVcKkSicBnHprF0UywOLJ6Aj76WL2fNs5cdg0DgbaO39DEOI/MQwf4uIx1rh7pX3ee4QIPRJIbhjg81w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5310
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>

In SOF OF device, pm_runtime_put_autosuspend() is not
matching any pm_runtime_get_sync().

This is imbalanced for PM runtime.

Also, for consistency we call pm_runtime_mark_last_busy()
before enabling PM runtime.

1. Remove pm_runtime_put_autosuspend() in probe_complete
2. Reorder PM runtime calls int probe_complete

Signed-off-by: Allen-KH Cheng <Allen-KH.Cheng@mediatek.com>
Reviewed-by: Daniel Baluta <daniel.baluta@nxp.com>
Reviewed-by: Paul Olaru <paul.olaru@oss.nxp.com>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
---
Changes since v1:
- Added my own signed-off-by

 sound/soc/sof/sof-of-dev.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/sof/sof-of-dev.c b/sound/soc/sof/sof-of-dev.c
index 412cbb824b84..b0089698eecb 100644
--- a/sound/soc/sof/sof-of-dev.c
+++ b/sound/soc/sof/sof-of-dev.c
@@ -74,11 +74,9 @@ static void sof_of_probe_complete(struct device *dev)
 	/* allow runtime_pm */
 	pm_runtime_set_autosuspend_delay(dev, SND_SOF_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
+	pm_runtime_mark_last_busy(dev);
 	pm_runtime_set_active(dev);
 	pm_runtime_enable(dev);
-
-	pm_runtime_mark_last_busy(dev);
-	pm_runtime_put_autosuspend(dev);
 }
 
 static int sof_of_probe(struct platform_device *pdev)
-- 
2.27.0

