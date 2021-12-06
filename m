Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811B5468EA4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 02:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231531AbhLFBsb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 20:48:31 -0500
Received: from mail-eopbgr1300105.outbound.protection.outlook.com ([40.107.130.105]:18150
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230273AbhLFBsa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 20:48:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GOI78wMe3fuzA0jd6e04XLed1dlBnndiLJG+/6YBzY8fOz659rNskWzkNSWiHvbLiC1UUsngPGxa/szTlogXd6Y/b4PFPIBGEjhoWJ7Icn675OEot3XlQE/gXRIEkwUCu+dOmcg/e/Us27Gube7HSgawwxDbe/7yh9tTxegwEhLCCR/AwmL+QmxlrSn/XyNzcMe82C4F8XjCeh3hri3oOEsLQwNRwG4LZYRm5GeiRmTLXDcSq/OfVYv+eT2+Eo98aFQCQxBCwISfUjEWcvMX0Rv/tmChxs+vMACFRbQv9LucKLV38rF2AIrmPcsDw/LKbYCX01TshYNhUNpqlCHmMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k5XGYmp75cGggXd1SrrBmuy1PFWsuQhJAYzHoXgVgsc=;
 b=Lpafz8CZURtCw82/wNAEOCYSrNEPuitFrbaqTHoBE54eF+p0wYKVG1Ni0eU7I3elFrGamyzrcPNhqS44RjPy1ZSSVHLMSKbo+rAHQwtoYZHGVLXJsZP+2p8LrNk9OPsK/toR3xmsPijJeAHBO06ne5GoDj0xi9Pr4CQZ1YTHEVmPImvlSCXnAvYTOMDPiKyBFFBBTQIm0D4Pg8jGOShPGTiveoQkTFSyZT+NADTbgABLrKpWVl0lLvqRNltN4c0uinUUhFXRXVQVtEaDf6+Yeg1+l5Y3nF3B1a9mpAwbFUc33OkwNszpf/R662de8z5OUkD/5SY/HOjS7q9BbA4fUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k5XGYmp75cGggXd1SrrBmuy1PFWsuQhJAYzHoXgVgsc=;
 b=ApcD26QT3O+orBsrQQgwXQDdZOQKuMDQHfEL7kZLbc4LqqqAt1MMy/Szcvcm+KTovICwcsL8IswoN2FfTgKZD696lD36tgUcXbScWo3UdJFk0WiaJX6XNaFWl0KUJFmH9b/V9QmU9p0ci+yf1xgM2TAjOA/VXppx1UbWR/veZNc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from PSAPR06MB4021.apcprd06.prod.outlook.com (2603:1096:301:37::11)
 by PS1PR0601MB1849.apcprd06.prod.outlook.com (2603:1096:803:6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.21; Mon, 6 Dec
 2021 01:45:00 +0000
Received: from PSAPR06MB4021.apcprd06.prod.outlook.com
 ([fe80::ad23:f8da:4661:7fe7]) by PSAPR06MB4021.apcprd06.prod.outlook.com
 ([fe80::ad23:f8da:4661:7fe7%7]) with mapi id 15.20.4755.021; Mon, 6 Dec 2021
 01:45:00 +0000
From:   Bernard Zhao <bernard@vivo.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Bernard Zhao <bernard@vivo.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] sound/core: remove useless NULL check before kfree
Date:   Sun,  5 Dec 2021 17:40:46 -0800
Message-Id: <20211206014135.320720-1-bernard@vivo.com>
X-Mailer: git-send-email 2.33.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HKAPR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:203:d0::21) To PSAPR06MB4021.apcprd06.prod.outlook.com
 (2603:1096:301:37::11)
MIME-Version: 1.0
Received: from ubuntu.localdomain (203.90.234.87) by HKAPR04CA0011.apcprd04.prod.outlook.com (2603:1096:203:d0::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.14 via Frontend Transport; Mon, 6 Dec 2021 01:44:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1c87c6b4-0e4f-4906-27a9-08d9b85a03aa
X-MS-TrafficTypeDiagnostic: PS1PR0601MB1849:
X-Microsoft-Antispam-PRVS: <PS1PR0601MB184936A5B95634DE952EFDE7DF6D9@PS1PR0601MB1849.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:126;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mPx9LCiIPkBH97mj4orCSTZfJ25qV7yYZCvKbSm1JZLVwrExvca6GsAiJxpOS6PeJRH0ETjr3xxzZnvVdd2s+O1gNArbvTM6eL86SD559/kWJ7KTmxchg3IM/HHJ92nws57dnDZfElwN+9d7ViDgT1Qjiy4SLO/Ij9v69G9l5zWnaWnQ62X8Oak8mQbmy9XLS3dIxE8dkY7kdonkD6up2/sCni/ToDWG8POPI3P5MuFm3gFr3JJxEchepEUB0A825Ip+8Ktw+wMBoPgbIOTFX3E+XkgZ+wY6q9eYPnv/HhTxk9+Oio+nGPB0JHx5hRmySlNWa2q+m9j9vfcL5uAHY7PysLs6bMxNEdX2IQWQPmlBqWcScdRoAgDU+SeCrDTyZZN2a7wmHYHGnOx0haQB/hszxPmQ13g5qsaFC1YjOfhCL+hMfChe2+S9YuzY6YfQEXQxZh7i+n1wrZsdwtH1MOkc3yTSoURzhnO1jsNiBtwbaI4OYdV7t+NCYY5jRWd0mVmeLz/k5tDg7Rx1+pIfSaEKtbycWCAXZA7n8KZyhhf+bsZyWUC1xNIy9liybVzZ58W9veBXUJOfu9VoeHBCeDXC6jfTatDTiV8BdS3FLHSXi4X7d4zDaThu9yQ2qU8Hfm32nLNq+xm6Eou/T533ZTBPEo/WuK5e8xi3F6FRwvLEhjsLvF4Ix3/IVjgESWFn/vQBzBwOhuMKstbtOjaycQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PSAPR06MB4021.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(316002)(508600001)(6666004)(186003)(8676002)(4744005)(86362001)(26005)(8936002)(110136005)(83380400001)(956004)(6486002)(6512007)(38100700002)(1076003)(2906002)(2616005)(5660300002)(52116002)(36756003)(66476007)(38350700002)(66556008)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HUeYNYkYiBdgD2q/YBPk6URuaT/ln3M17hkHYwMPwMWnpUKlsZk/SqzGvdXT?=
 =?us-ascii?Q?FBAMvI2MUJPcPRZgd0H2avrskc0HnBEdLDjv5LiMUZaBAv5WPP5QfVW2x+X1?=
 =?us-ascii?Q?sBvnNZNNA9aGiORYtalJkBJIjqpeAvOHD4wb5eWu1+LhcklIYEzE/v0ss+P1?=
 =?us-ascii?Q?semloYbLZG+wbwNErBZOtPQuRzThmxxSM4kT4YcQ2LrKRYK94G2KdyMjUYkX?=
 =?us-ascii?Q?X1DodT6LMcPUwH/45Z5Gktd4tEjDdEwA37QY0gvpoLj0T0TyMEBTVuozgaAn?=
 =?us-ascii?Q?zgjxpt5TN3YjXGgZzIFP12OENowvXPrgNkSuMqb6V8QA9LUrNVP7M73lSBqV?=
 =?us-ascii?Q?Xcr7ygt7cJ0TRTpQo8erG4BKpdtQ8j+zlLkbcBRXVqeYQYVZbL8R7HLSbVUY?=
 =?us-ascii?Q?ZDEF58DHi4oC8pYw9XYxuxpyDRPXzPM3mM+UDX/iAVa0BMHA14eAaji3Rj1K?=
 =?us-ascii?Q?vjy1FD8vuX65WS8tYAoi9y13dLfnX2yLlsUVY+E7tH1zcHWldXfKdFHdu2Yi?=
 =?us-ascii?Q?PgdtuQ8UKMd8B+UcB0qI+wNMPqXlaTQo9WaUXb88HB7RV21bsl/WRJfjBGNp?=
 =?us-ascii?Q?qAv4JLvMA8Cir2KXo5DLRmWxaSQpXWgHx1j7hSH+T/vfSC/buZ8brRjzNuIH?=
 =?us-ascii?Q?jMtHjiyQl1C1LNoYtqhKUnYWbBhb0faaOyjzJhUOtCvTeF+XzIl5ELxHdTko?=
 =?us-ascii?Q?5g5EwhiYZcHZOGqM8ZNwa4EGC+TG8q7DBROnRZ3e6+lkKZrdGimAzOR7Y7MC?=
 =?us-ascii?Q?kYpJUnLjhoYbQtYcls7a/a4LyQ4f61lWVw/2xPmp2zK3e/DcdKMO6LqBgwYy?=
 =?us-ascii?Q?hzA3bDT/uUqY6yB4eYQ7LD4SEq3BoHOlNbMtUFzeG9ovgAoCNdFiVa4Mfjx0?=
 =?us-ascii?Q?ymnUSUhL8wXaNYfe2bbcgl6SBv4Q4f/iroxSrsmVyTGV6vCkrXZEXlKc26LF?=
 =?us-ascii?Q?6/rzl4E5fgJ85HhSNRDw6Zm5PoOy787/pxoFZ8GBxeaajuUL3Rl3USv4OZBS?=
 =?us-ascii?Q?RNl39ATUC96qFY2O4VE6+FcdWczM8l4GofSu/ejA5Mfp9iuEPT8kjEsMHrTB?=
 =?us-ascii?Q?+aSqrLnBn6JDBtRkEwhfHtl14WUw47J1yVMiSkrvDOP6JnfBfYWaNhryh1ji?=
 =?us-ascii?Q?NNOawkldoDSqOG/OOfaFQocTmnVIpSLmdYXXj8TMLX6xNIzSCVFue26+TodC?=
 =?us-ascii?Q?JRxKyqP2lL6DuLvuO2ZtKB2MS/Be2WDLTO7WDHjzofVoDbxJJ0EcBe1aczYu?=
 =?us-ascii?Q?SqxXeQpL0z5v9Grqg65ZfMhL5/dEsU3FSeANEHA7vGCSNHdWD3d+NEDjtCpI?=
 =?us-ascii?Q?U0XfCzVDGbrL7fv45Uen7ADoYM0AsLUrQnv4OM+jXjIrRRVFA5c21XyTP1Sr?=
 =?us-ascii?Q?GGHIZCvw/WTaVHvy00ZihhFokXikkUgvYODB72+zJWXgRPRIeyOeSaXvbEN9?=
 =?us-ascii?Q?q0QT585ZlbG69ajUD1/l3TeANB25pQmtoWQez2u4MMX0yH19F9Ye1+gefy+D?=
 =?us-ascii?Q?zD9yYl1YAj9OjhPGBpz++Irf9uvssrZsWwf5ozYW/8rMr33wm49eoMSrymRH?=
 =?us-ascii?Q?ZlZizouXtSOR2vWOpfGTKuZWKw2VHXyg5nA+3uHiE4mpZAslJPqjNi88ym3L?=
 =?us-ascii?Q?bNBPKi1WBJBOHN5PivPGPvI=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c87c6b4-0e4f-4906-27a9-08d9b85a03aa
X-MS-Exchange-CrossTenant-AuthSource: PSAPR06MB4021.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2021 01:45:00.1123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RRSX5AQzLhbqkAOUavXAMIzTsBXNVw+o7+g3iPKiIFkDGrXbhWD9zbmq5BLBrOyRdrvM+Qxu7Xo3pG2cvtjO+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PR0601MB1849
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tis patch try to remove useless NULL check before kfree

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 sound/core/info_oss.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/sound/core/info_oss.c b/sound/core/info_oss.c
index 1ba887c7954e..ebc714b2f46b 100644
--- a/sound/core/info_oss.c
+++ b/sound/core/info_oss.c
@@ -32,10 +32,8 @@ int snd_oss_info_register(int dev, int num, char *string)
 	mutex_lock(&strings);
 	if (string == NULL) {
 		x = snd_sndstat_strings[num][dev];
-		if (x) {
-			kfree(x);
-			x = NULL;
-		}
+		kfree(x);
+		x = NULL;
 	} else {
 		x = kstrdup(string, GFP_KERNEL);
 		if (x == NULL) {
-- 
2.33.1

