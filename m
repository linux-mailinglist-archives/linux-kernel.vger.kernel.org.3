Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B40D3595386
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231687AbiHPHN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231905AbiHPHNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:13:07 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2058.outbound.protection.outlook.com [40.107.21.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40ED2DDB12;
        Mon, 15 Aug 2022 21:44:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L6eGOF1zjYqZ214/4C1IyGu+IooE93DEJi7xpFNOSq8WIFm3rA7o9XTN70kJipRDDD+CYOH9C5KnN/jHzRvtD5Mix/WTfyj8Byro1hVv38RWysgjRTeRKh/OGEJZ52hPAXrCUYmuHFzVkP5lbKAsIM51Ix9ByvGV+eeHqxaKB8vu7aLP2I81faTRy5vSs9r3ipLPOLVRKwtrmYX/X2B+famQt8cQ+L2XBBGkGAoG+1+0pzU1Aakr3N1CbHBE4qGDNlcxG9QnDcUtiSyhc5ZKaXY5+fr3lFJNlZoJwyM4jUx9fJWtfRmp3oyODyxX/L3b6nMEpAYHgyWumOz8GUZ3Lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlppLxbhiH8pVXvKxsN2ggIsR551PtIcTNJtuK9QHfY=;
 b=lQuqifUjNOz8tK1OlDOyzLPNfDhF8/xCAlK09AcZhiPGZu/l4hq98fPDjRPxl//eLsqCyUonmnRd67b1OHbKXN7w9FN0SQ/yk6L72YCdkPq7lY5DhNO2cB6yFFXLqZfvg2GZFKDVOB7y619nrm/jlDvUQLanm3zle8RVjV5Eiop7inE+IjUaCYoZVSvfFI1GuaUMQ0Zix4BuAX+BXLOE34PyLPSPL9NoekTNE/hGcf/gDNbVIHe6keyEsYf7B027mWku4sXFVgn7rEKXBSPRtbd74Lnx6BJHH+a0c+tzUlx7yddjvQuIfCm9ncDe+a37wKsD1Anhau5zOs4eZmqScg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlppLxbhiH8pVXvKxsN2ggIsR551PtIcTNJtuK9QHfY=;
 b=NrjNnLVXNickkHCMxLj02hRsJ8+vdU1PrX1lbRGaOUoTG0NOzod973h6xygkECPXDxkIRQp0zJx4oQwlrc4BLKW2ViNbkFlgX+ifVDjV9oEKs2dJ7vaF1tzdk3Im7hOuKQAXK7fc95UWLt1uE0CEASC2E96dwjSEs5C32erVJ3U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by DB8PR04MB7036.eurprd04.prod.outlook.com (2603:10a6:10:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Tue, 16 Aug
 2022 04:38:14 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c%3]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 04:38:14 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/7] watchdog: imx7ulp: Move suspend/resume to noirq phase
Date:   Tue, 16 Aug 2022 12:36:37 +0800
Message-Id: <20220816043643.26569-2-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220816043643.26569-1-alice.guo@oss.nxp.com>
References: <20220816043643.26569-1-alice.guo@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:3:17::27) To AM6PR04MB6053.eurprd04.prod.outlook.com
 (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 060638eb-64a0-4d85-569e-08da7f4121a8
X-MS-TrafficTypeDiagnostic: DB8PR04MB7036:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fb893SoLYlWqVRnRN8qq5YLpySOKk3AliVgRpdy7jZBE2Gw6+fYwK0hfKs/huVHzIEnatdxxcWvrsJ4erwpUEEIQK4lYAhQheUTbbxlqSYgQC/3xPpEKA8etbScAhYhYSXM9nLZfU9k3ne1FBXkUFn5OvWNx0u/nbt2/In3sUfbKADrJpyYexpLazF4F1w41gnW3F49PqW2qQIbQIhYyihKWclUENl+IMjnWE0tGes21xdzg+GsVd/v0ywlGgLlafoPkS+0xzz9VMSBHj30pPJ7BRZqT9ExdNXlid4QeH4xvmhff0zIrCAwd1XAkfM6fzW7hgkVxMZ719f5H+1rF3ZaPXpyd/98ytmXBAod0/pil8ALd+ejMRwvcbkcJxqrbcZMUv7cTynGxOGjk+LoY+y7adL+kUbDJLXXH9ux1FYh38Kd0D3VWOwkRhwRIXibsNUzI4Mb7IOmL53qH37pnPZVT45vvN4fCQFLcmydzkMLwASuqGHPvNancygO43cAt8PusQHAd7Vn1gkWZfXTHY7oxK782okhbQeqBC/NYbgPLm8byucXffmzQu2z6aoCzggl8n38+qwnlW5jAcYqkaI+UW40oY364CoR4CYXO+3ooXSlxYI3GPuTLBMeqfBAe7EmsK2bj6JIzklHpxPTjjBIUs/7RVDcDGGZIbPR+ISM5CSoU17WzOniWmCsmCb7GN5A7k1dTo9T52JY8cG7f/Kl9IYZUpaMeIB4qEwBnXEi/fbmOvwSmiqBqwNaE/2lZ7w+ftz9aBiHDl/fcniOoeiCaZiFpzls9dTRfuC/Gxu0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(83380400001)(38350700002)(86362001)(38100700002)(4326008)(8676002)(66556008)(66946007)(66476007)(316002)(2906002)(8936002)(5660300002)(6512007)(6506007)(26005)(15650500001)(1076003)(41300700001)(2616005)(186003)(52116002)(6666004)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CfTlZil2wQp3LYEjvWxF9x4rKPQwb4Q+lUMV6oVBfZ9TlEaAQsoWlImjEZeG?=
 =?us-ascii?Q?OIzHnt85AYwNXYoa8hYryGRujGHt3XhemwozGofn+4BgvZa1z5dHFGXMyun7?=
 =?us-ascii?Q?ZGwAs5kKREWwv7wbSsMVzpbLUH4cw2CesaLtdmf+RIoeTNdOTFpu6ZzNyzGG?=
 =?us-ascii?Q?3MOe46Am4fCKYHDE+sRTXHFt6wJWNDnKQHjQaPQ8iMR/irYOBgc4eGsx0RfR?=
 =?us-ascii?Q?XTBzM4PkbVaNZu9gL+XdOSBCEhI/n8/sr7VU+k8+BsrwTqTu+fBK5Fqa+F/k?=
 =?us-ascii?Q?loYSQmVjnbf3Kee+2qE+0RJcYmVuyJM97ubCVLoRlt2F3ytSM3EmM6y9t80R?=
 =?us-ascii?Q?AQ4caeeOARMRSIztK2pNfJyVpOtKlASRyQXJtTftkmJ263WQVVQCe9xyKRuS?=
 =?us-ascii?Q?uEfGsF/baUiK15Y2Y+nN5ij7XSgJs3QXC2mTlF5TjMnZ/s0ntpH7Hqxbna4c?=
 =?us-ascii?Q?U6HDPBmutvuCJ6YetxtApX6pCF7ZH5W+EwXLSMTyafo+i1TcnlPIvOURVzxx?=
 =?us-ascii?Q?axgFeT/Q93SO/YRslsUgnC0pZMaU3NI+NF2RuivFqCNNemFMoGcwpW5Re9Jw?=
 =?us-ascii?Q?TxVn6dhMPkxXI5MtglCoLDpIJBzfMaVQZQ1wiQFIAby5qYVGbJg+14usDD6V?=
 =?us-ascii?Q?2JUemyeihHDh82kO/e9YHdvCINgEayQpx2DDT0GpKRkwdFWBvmoLCqKIzJd3?=
 =?us-ascii?Q?ExtWP4r+Ak9JOMTahCgj++kZysPpnASX1IKnmDqlI/yBVwLuXmKw4uBFv8yf?=
 =?us-ascii?Q?KjHdC1LumF6xzlCeBvS5FEfCqFmPEM5LAus6gyGc/R6tM1dczHMicRpa0FDi?=
 =?us-ascii?Q?rxwWlrvbZoPb1Gd54YT0+xfKBTZ2Zssc+PJnLszP/X6cdo+VU40m2/HU2q6R?=
 =?us-ascii?Q?rNEOcfxMq9qvQr33U2cbcaIW9VmqMWnwb46c7i4VUtyh6TS0ehizhPXhVOfH?=
 =?us-ascii?Q?iSs0CVfWCQJrDs+sDaBiIXSnJrNw2pzk1zgS9XEcfvYqOC/MmWt/ATWhWljX?=
 =?us-ascii?Q?tBgn6ir72HyGiRhaEQJoY8aMlQtiMvDEmg/HLVtSCvu21FusqWFXoj1qlYT9?=
 =?us-ascii?Q?JwehrR00chPvIkSBZPUsjgaN0jzlK6byJKkZ7WPXu63Cwnc6VO5EwsFTP9EA?=
 =?us-ascii?Q?k+zopS0gx4w/U62PAT6sF6Owghn1xdzLNoVdYQDJfX4qaux5nBIvpH89+Bla?=
 =?us-ascii?Q?u9rpAIY2zml4GicgiasyV3DtxMrVMmmHVl9NFis/WiGFGfBXIVbnQp40OGCt?=
 =?us-ascii?Q?OrEYNKdHhHinfh3z+d2t7ddBjNDr95lcKgOGBUHb4vxWeeuREeUFHREmMXBg?=
 =?us-ascii?Q?7zmr7io2HwrrQZTPsVxTxvLUVsWCptUPnb67H8q/KE/3qhkQAuUeVrLI8UBm?=
 =?us-ascii?Q?cv9HBH4ilUAokmNPCjusTYZ/MtwwQhMFcW/F7Bjg/gGITEWaXqkLffLl6LpK?=
 =?us-ascii?Q?v8zzgLfQTY6Hcl5UCcQf22TcPM2zp9tbVtc0DJFAQFfCAkbifS6EVrn6Zipd?=
 =?us-ascii?Q?ZJYPW+CFxdN/v/DPutuAyRWH5vkLTkn/Vpq9WL83PDFFEPVEP4sMYuL4/zEw?=
 =?us-ascii?Q?n89ODCGzGrZTz6Et5Tnt2jtXZXxZuRkVP4snZyCc?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 060638eb-64a0-4d85-569e-08da7f4121a8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 04:38:14.2815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jdx49KZ5w0THbQ7ePeX8/EJtORTCe5VGQdUKUgov3Kia0xCqsHTe8uOFbs1Pjh7slRkXWUXQR+tKbM+85jveng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7036
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

The i.MX7ULP's watchdog is enabled by default when out of reset, so the
resume callback which is to disable watchdog should be called earlier
to avoid unexpected timeout, move suspend/resume callback to noirq phase.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Tested-by: Peter Chen <peter.chen@nxp.com>
Tested-by: Li Jun <jun.li@nxp.com>
---
 drivers/watchdog/imx7ulp_wdt.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/watchdog/imx7ulp_wdt.c b/drivers/watchdog/imx7ulp_wdt.c
index 922b60374295..014f497ea0dc 100644
--- a/drivers/watchdog/imx7ulp_wdt.c
+++ b/drivers/watchdog/imx7ulp_wdt.c
@@ -255,7 +255,7 @@ static int imx7ulp_wdt_probe(struct platform_device *pdev)
 	return devm_watchdog_register_device(dev, wdog);
 }
 
-static int __maybe_unused imx7ulp_wdt_suspend(struct device *dev)
+static int __maybe_unused imx7ulp_wdt_suspend_noirq(struct device *dev)
 {
 	struct imx7ulp_wdt_device *imx7ulp_wdt = dev_get_drvdata(dev);
 
@@ -267,7 +267,7 @@ static int __maybe_unused imx7ulp_wdt_suspend(struct device *dev)
 	return 0;
 }
 
-static int __maybe_unused imx7ulp_wdt_resume(struct device *dev)
+static int __maybe_unused imx7ulp_wdt_resume_noirq(struct device *dev)
 {
 	struct imx7ulp_wdt_device *imx7ulp_wdt = dev_get_drvdata(dev);
 	u32 timeout = imx7ulp_wdt->wdd.timeout * WDOG_CLOCK_RATE;
@@ -286,8 +286,10 @@ static int __maybe_unused imx7ulp_wdt_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(imx7ulp_wdt_pm_ops, imx7ulp_wdt_suspend,
-			 imx7ulp_wdt_resume);
+static const struct dev_pm_ops imx7ulp_wdt_pm_ops = {
+	SET_NOIRQ_SYSTEM_SLEEP_PM_OPS(imx7ulp_wdt_suspend_noirq,
+				      imx7ulp_wdt_resume_noirq)
+};
 
 static const struct of_device_id imx7ulp_wdt_dt_ids[] = {
 	{ .compatible = "fsl,imx7ulp-wdt", },
-- 
2.17.1

