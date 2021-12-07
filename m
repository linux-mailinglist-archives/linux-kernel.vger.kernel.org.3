Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66F3046BBEB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 13:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232474AbhLGNAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 08:00:04 -0500
Received: from mail-psaapc01on2096.outbound.protection.outlook.com ([40.107.255.96]:10272
        "EHLO APC01-PSA-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232134AbhLGNAA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 08:00:00 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KMHqUecE9DiOcjZ1oTOwONuxgLnQ+Z93Z1/gSB8Q539vPdgaNE6+5DQwzIVavViav6tzgT089VlljfS79dXNcGYp0l33n8vohkZi6cC2k/rOQjDats/kaLe5s7iEYsErRrOfoo2nNbU3E2/dt8l7ynED30ckkpWYG5Lj7DPAEkArWmP6YZQvHTu6+kAX/eHUo/fkaUF53FU9Apu9chA5KU8zYrvy8e4K6auX917qc9LOOLsCodaB3MPPQFxjCK4qLWVANwpT/S3BBmMkCtaUNECHPo1QOWjuMeu3naTUhZK2FfYJ7fiYR8la08m5sX9sppB4ZyFydBkL44fFKLXtTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5gLfZ87Xx1i/UhQQ7Cjpr7hMQJEC7D8jRlcHPOW7Jdo=;
 b=KqHdhJtxt8TpEXPMPHZD0YzmejN1WHfiwi+/hzvSUPdOHJQBBvgEo88HH+r0wowO61GY2LPH1MYDqMv14CoumFKbISLnsbn17grCe8SCxxhySKYlpYML8lFzdnJHrpYct9Bmd6oChhvnpS+seS57Hpwx0T5FED/xr+7s2MWKcUOoi+qcA1QC5Scnq1+lah8omCPlRR4ruwVL+GhDoqhvGCGBFY0ycq2kqskc0K7QFwUyP+IPhJn8xVYPQSOCD+o2EUb3wlnaFvWvcZepk3OBj0Is4te/ctH6XqX3LsEmBvMCFE1PpuEJv4ZOGXvygpYRPkQUfKywApAAljiK8GfenQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo0.onmicrosoft.com;
 s=selector2-vivo0-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5gLfZ87Xx1i/UhQQ7Cjpr7hMQJEC7D8jRlcHPOW7Jdo=;
 b=f8aFeK5s1D3umme2mitgUrEb/PiQIXdvuBfOfx8OqR5fJNYiCXsM5J1YDYG5TfyDaBgO0nVP32VEOFN9vdDUb0sdVS2W/9iZ/J8KaAwhuIa1NL5cJhKV689dvaRoz7G6ZNYVbTkqRst3LYz1fAzpHbmp3aUlcZ9AT5iNKH+n0w4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com (2603:1096:100:37::17)
 by SL2PR06MB3035.apcprd06.prod.outlook.com (2603:1096:100:33::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.28; Tue, 7 Dec
 2021 12:56:27 +0000
Received: from SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396]) by SL2PR06MB3082.apcprd06.prod.outlook.com
 ([fe80::a0cf:a0e2:ee48:a396%4]) with mapi id 15.20.4755.021; Tue, 7 Dec 2021
 12:56:27 +0000
From:   Qing Wang <wangqing@vivo.com>
To:     JC Kuo <jckuo@nvidia.com>, Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-phy@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Wang Qing <wangqing@vivo.com>
Subject: [PATCH] phy: tegra: add missing put_device() call in tegra210_xusb_padctl_probe()
Date:   Tue,  7 Dec 2021 04:56:15 -0800
Message-Id: <1638881776-3308-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: HK2PR0302CA0001.apcprd03.prod.outlook.com
 (2603:1096:202::11) To SL2PR06MB3082.apcprd06.prod.outlook.com
 (2603:1096:100:37::17)
MIME-Version: 1.0
Received: from ubuntu.localdomain (218.213.202.189) by HK2PR0302CA0001.apcprd03.prod.outlook.com (2603:1096:202::11) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 7 Dec 2021 12:56:25 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 15077235-3c6b-4f85-4454-08d9b980fb0e
X-MS-TrafficTypeDiagnostic: SL2PR06MB3035:EE_
X-Microsoft-Antispam-PRVS: <SL2PR06MB3035295ABA6344460699818DBD6E9@SL2PR06MB3035.apcprd06.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uy4bvR2G64gqui3tOtkAuyrSBN68cFic+K3hEqUjEII5DQDLbuB9T/qe2ZuKgjqB7WKfWxbIESYe6h4YDuU4aP/gH7hkbCqieVpZnDaTIcdEvo8CvHvnq9ZF4uNmGd2zp16cDsVt4InwjzNzUGVKCjPB9m2R1e12GMj0WGhX7smYfkNyQAoubh9/iLXVKpjlu6BjLvS7UVuANOWyQLvlOBGVr2VQBvt5CmUmReZh/bviFbLgxcql/DXTYpBWL2w1LiZ2+hGa65R13rNie0NgxafAZwOcdC3XzMvfM+m2w/Uux7GDe5Urb2DjQU3tzagAS4BSa7UXtstV6bOvX342RSxCxmQYP7yVUSuvBYJlN7hsRrGm7X7kTKxV4Z5SK7tKHSklaAHUuEUNDJiZfSqO35Vi+YrPWS9HPTRJxbDoie/lzm95V41YYFf9sk0c8rbeUCCsLUlmkLnTZJySrcJhGOjHpsoZtbk4025RslEimaJr9jV9uvfc732Q9N8jGCXErFtlF2fcsHjcvz7nO6vFAlqkAEU0kTZ6H7bHocXmsqwca/fGUhBAscY3b2We+yQ+6jxIedLO9Ip1yvbBW7VFOE+iG+Tlo3n5hzAHiYc9tpUrgI89QfDcxcbiNSepP3oDzuuYSAhmPjhTlwKM8niHZPushG3xjjqabTkBLKd82G+Xbg9onnXcQJsBGDq7bRriIs5x5rsSRHaRXY7srz6jaA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SL2PR06MB3082.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(8676002)(66556008)(4744005)(2616005)(107886003)(316002)(956004)(66946007)(26005)(110136005)(6512007)(2906002)(6486002)(38350700002)(66476007)(36756003)(508600001)(8936002)(52116002)(4326008)(5660300002)(83380400001)(86362001)(38100700002)(6666004)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kEMQlqy2bkSpiRGbLIFsuIWfClBlJ+ehMyBApaJbqjqrxFvRgcmraQPDP54k?=
 =?us-ascii?Q?mI+68n2pF+Sp8R72Y9Xycz//1qLXGq9miB3e7J/DgLMLj9+kOiO/Hfo7zgku?=
 =?us-ascii?Q?qXXAUpiEcgpLLiStLY+lUxp2qeHZEBCzIS6BzYYnIzAs2ntsuuUMATMcSYt1?=
 =?us-ascii?Q?DyQgafzX5JHYS5PYhrckjDYbQiAFM1muz1i4XhKakcvLi5IhneeTsslKU5sJ?=
 =?us-ascii?Q?PfSx8hDD+YPVzLASyIe4ZLioHWcGNF3ZKqBgBybKQUySGt5hgD0MoR4KguhT?=
 =?us-ascii?Q?vTnP5I3Qu4lEdWX5Tu3o8wFZNEw+wEcm3lhzGsDUF1fLVB7y7Hzz8tJ9sHiQ?=
 =?us-ascii?Q?t3pOT8yiFhE6U0N0DvACubLysnjPYQkYvWB51Xw5xWWImPTqK1Ae5NECixqS?=
 =?us-ascii?Q?dX6IW7h3uK/bSQAmPSrQhp7AqM+4jWchcEW5gDvHxMG3hUhCD2YvWsAQ7Y9a?=
 =?us-ascii?Q?0u2MbBKAdiYyvjnVn44+yPtvZ4EEuhFWdxVU0UkEcJgSq3ht/gc21Ab8SzQI?=
 =?us-ascii?Q?v7ewm3Oge3FfzTZlBNcUFhwL/49S6HeEHyQFdachN95liYHQZFk+zQhYkGxt?=
 =?us-ascii?Q?JK8k8WZbIvpfmhGLVpXlMi0mRWnbSGGMwG6SCFK5OaGlAxyeN8gNmOW5hx8B?=
 =?us-ascii?Q?knaJOkzkbK4FTZWvHNANGkHpkhp6a5bBvyROE9lF6RqhJV5lh7i+bxPFfJsp?=
 =?us-ascii?Q?jYWIVvnVcHG78GfmEhXke3czWA855OkpIQaEoS5i4EM2yYcPNR9k+lXukZzf?=
 =?us-ascii?Q?v+o7FLt4Eu9NrL5OqxS67W8tBlcpc+46mRYHMDxM7QACtLDGqGGKbuoWDNDG?=
 =?us-ascii?Q?Xin387QzDoxaPlTbpl+KS3JbuKGG6YPafZEiG9/mK4L/mh47p/htUVqwXaQp?=
 =?us-ascii?Q?MAxMX8CxgxclWe/5tKePFpAqJzTR7uwlzf1SweA3e3YueCM3IaibTLoqT8LH?=
 =?us-ascii?Q?yPaAfGMBAA6kkXuLVXtGU40Jj07zLGSkNWHI2SBX3enP9ny//4AoDsKVCSAE?=
 =?us-ascii?Q?GaZokWNGJIkNVzfNgZeXYLqgvCQOcA0mytvhYH+J/AAIdbVyW9CsuVOwBaqF?=
 =?us-ascii?Q?Op6z89pEz1ASNh+H7r/OXmGrv6v2TsWoNwGQ/xN69AU2tbx2D20TWcTE7eX9?=
 =?us-ascii?Q?qmBTnYXFJB011Yemu5IH8NzzujjpeTzaktUuCWeY0lOBYD6Ogi+A60hBey6V?=
 =?us-ascii?Q?+pGsoxAgDUAuyOnNfzAirKR1TSmRyTbsBqQyJbbpllBzQOdKO5r8SskdfeDU?=
 =?us-ascii?Q?8bQpv7Cn/oroNhCU4XdZ7if9zGZYIJHElANjyZ9dLSgD9J4tPEuVB7zd7YOs?=
 =?us-ascii?Q?fTPYjsSbA9rU28PHLQEJmIos0NWFHl3s5+wrwy9QI0E2slHSL57Wu/jeTXJX?=
 =?us-ascii?Q?6S3hIn8s0Y91IhdRHZnz0CpPjcLg9GqHj0DAYX4/MJXJTmGESr/gc/BYA3BZ?=
 =?us-ascii?Q?Q9EuCzJs4rfvA4H/MdiAeaRCQMDYkNfK9oI2ofXic9PgnVgAscjpF/BVrpoW?=
 =?us-ascii?Q?uzUWP2CsdXEnZEB1eYoefDLpv44zngTmsIfPIiCNC7assDcUt3SJIdL2TgAI?=
 =?us-ascii?Q?gmCzymh/OviLR7Slpw/moNJLXqm6n1w90/dF0GmRe2lrHgbKmyq0BRtuEcFm?=
 =?us-ascii?Q?BRxpqLT1s/gJzr8lHT0YCX8=3D?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 15077235-3c6b-4f85-4454-08d9b980fb0e
X-MS-Exchange-CrossTenant-AuthSource: SL2PR06MB3082.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2021 12:56:27.0366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WxSkqal0u9Gbi7KX5xYVh9MRAasQm6w2TieeJFfMH/LUtkOXjxY2INK55FCRsWg1DrxXTSIuHvOIURdGmzNWzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR06MB3035
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wang Qing <wangqing@vivo.com>

of_find_device_by_node() takes a reference to the embedded struct device 
which needs to be dropped when error return.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 drivers/phy/tegra/xusb-tegra210.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/tegra/xusb-tegra210.c b/drivers/phy/tegra/xusb-tegra210.c
index eedfc7c..05a0800
--- a/drivers/phy/tegra/xusb-tegra210.c
+++ b/drivers/phy/tegra/xusb-tegra210.c
@@ -3170,8 +3170,10 @@ tegra210_xusb_padctl_probe(struct device *dev,
 		goto out;
 	}
 
-	if (!platform_get_drvdata(pdev))
+	if (!platform_get_drvdata(pdev)) {
+		put_device(&pdev->dev);
 		return ERR_PTR(-EPROBE_DEFER);
+	}
 
 	padctl->regmap = dev_get_regmap(&pdev->dev, "usb_sleepwalk");
 	if (!padctl->regmap)
-- 
2.7.4

