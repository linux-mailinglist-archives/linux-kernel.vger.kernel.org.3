Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0BE5A0B95
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238193AbiHYId2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237676AbiHYIdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:33:17 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50075.outbound.protection.outlook.com [40.107.5.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCB0BA6ADD;
        Thu, 25 Aug 2022 01:33:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PWqL2UUFmVUy4YeqygiwNPbOv8D9MZVwLms7fOkYj44wKC5NpC8BVij4GR99pIK4PYWoKgsE4yTOsCFsv4/W3CBR+L/6l44P9Q0QlcDxt1CE8kKqIplwuq8aIgneMOLzpXgN5SoJyuCUP5pBhHu8nGgUAmCo2LeyOnLhgkpxErn8pmiTaWzvc7j1+8sNAWwbQyVPwZStWeAU9QnpjqcOtJsfRcnJN8zSii95xAJMMHiCRfCndZdPyLA/xyrS6icklT+6084ix9v/HPozp4yKWTTxhGM91g6qM44K6kp/j9wK01DmK6ny58Q7g/3K7Gpkj/cWVGFrx+TL7Cjsofq96w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aNViKVwCmN0GscD9sjksbn3UEavjiC29upJaUxT2dZc=;
 b=LXjfdjMiZpuQXDo+B31DgkImVQXZ52brWM8co2Pjwp5FjmxQJTokEjGmsF1fi1M4uo8fBGyu80A5NKTmuVV7bsj940gz5XySdlp46/iMHuEQQkCwfqukd/gQfrk1MfYthlQXLXB9cGPC3xGEjqbAyjx0ayu0QJGnKk9yftE17aFgVyk7n+Z5WF8Z9XXaKEiLa0M5eacEChhXR40L0H6GiqK12kB8I4WXG9bFTeg0k7kTSUg45TcFfyTNm1O+2P4EV+4fOi71ZZbOMfVu3O2+BngjWK8BhFZnTB0Be6DXdMFcEz3W4Y13gbTm3XXAa9q8Gb8CdTqyv/LqwZ4Upxwc2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aNViKVwCmN0GscD9sjksbn3UEavjiC29upJaUxT2dZc=;
 b=JSO8SKrtRDSA92POQD6ABhtKlj6FoW1rn8fCEdYRzsQUSAnfnSwG4vJ+ADV+uG2BeWCMxADgRaBxVadya9IqriO6pTaDi2Ly9ok0bga2EkgdNeQ8xuPheOOC8c9aitcc8A0DFdFA4Axj5K3627jtAWX/i1mI3pT3QUqjnwiyQDQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM6PR04MB4901.eurprd04.prod.outlook.com (2603:10a6:20b:1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 08:33:05 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c%3]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 08:33:05 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     m.felsch@pengutronix.de, linux@roeck-us.net,
        wim@linux-watchdog.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/7] watchdog: imx7ulp_wdt: Fix RCS timeout issue
Date:   Thu, 25 Aug 2022 16:32:53 +0800
Message-Id: <20220825083256.14565-5-alice.guo@oss.nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220825083256.14565-1-alice.guo@oss.nxp.com>
References: <20220825083256.14565-1-alice.guo@oss.nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0225.apcprd06.prod.outlook.com
 (2603:1096:4:68::33) To AM6PR04MB6053.eurprd04.prod.outlook.com
 (2603:10a6:20b:b9::10)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb8f8ef6-98eb-423b-444c-08da86746e8d
X-MS-TrafficTypeDiagnostic: AM6PR04MB4901:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: afIdRbdJblhX+p/hKtVOwEprWwtW77o/ULRoh6OlUSvvi1xH5UHsEJ1tOTZlJDc/SXmM92M/7pteC2I8U3Swv/SBsYDRWa9/HtfVE9IbZiRUOwlSxh8YHfcjXYAuc40nu6KK3H7uSw2DBHXhCUunIrZOuR03xUg+Y2aBUwEQkheWn3abUHeCSFkEnzix9ToaRenneWzG+rk0brJ4AsYRC4bNew5WgKVbzRDo81XGWqVbX7p4RAGV20dKsEccVlboT4RG2d7Vq4H/ZsVo/G7mV58FrO2G7/ehjswm9q4WmbMZ/qcUsiZ9sl6XwOlYXLNOniP3/LuMnJnJaNbwBhJdE5LotWNVXtFp7d5BIIFo9RNMYKrvad7mau4esIqekQQcUwVNoRRA85rCzvy5fxIb8Vih3GX9kij/ERcvYs/KCzX3buokj4Vma/s2u5NV+LY3TdlGVDheSzcY0mCJPm8wIiQUsQSaSyB9S/i1eSVBdnrtKzmw0kN8vysQyHdynaz8B0JFYEF+9NWlkTp04nbWegkfmNAzwzfswC47iX/LAXOSJ7h6Y594ZiaMVNAigzc4SZC3QqobdK+QOgqbA8Z+dA3CfNNiOzr8S/yhaVB7i2/VMsIjrI94QmsokqjbH5Ov8fyedMRZSeWAaPj6IZSz5CSb1qiLfzF78hIhUijHvrUy9CTCJLcJ+kOM2WTGSeus6fXjk6WJyOXGG5VmpJYi3NKax6kZfoJlF6/ZMYDLDDMUVgOxwFkUExH5SqYa3OOEOSwM59P5gzQ6231bnToRKg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(8936002)(5660300002)(7416002)(38100700002)(38350700002)(4326008)(66946007)(66556008)(66476007)(478600001)(8676002)(6486002)(6666004)(41300700001)(316002)(2616005)(186003)(1076003)(26005)(6512007)(83380400001)(2906002)(52116002)(6506007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YChAzppbXlAaUiqb5caKW7RPjjWA6Z0kPr+MqbpdnFw2IwsIqe8kQNSNvuRC?=
 =?us-ascii?Q?pafGaCY5jP5p7MHVWsRe6XJKxLFDxKVq43Dn803FHFTpjvFEvABMTR7C/rdt?=
 =?us-ascii?Q?RaZ9b465ZuuTU4U/KOvIb+EEbyygJ3K5x26L6kUPoLxLhznZ1CK9wbcAdHYm?=
 =?us-ascii?Q?wrkIzNQwETPgumkMRKut+/M9e+atVsrt6h9NZlShn7qX3v7WG8FNZ0La/hnz?=
 =?us-ascii?Q?VrSlAE23TwpePBdqsDGB6uVRn2YyC3ZWxLxNgkmjqhTzYCr9jwH7TwuVJyA2?=
 =?us-ascii?Q?R6K2ly2hEh9rGGX/qESvjkWGfxUcejoqN3PZYMP1p4TzFSA5WR7/kDZVHvKm?=
 =?us-ascii?Q?h76Sh3T61EbjRvJp1+zmEnvxRrBTUfaT1Dkj2mje7CFCk7hnf6PJPVbYafaR?=
 =?us-ascii?Q?XvUYs5js2JSXTzIcMpKrjWLHIxD3w3TKyJ+VNDGW0N7/gOvgq8HF2gLbapHQ?=
 =?us-ascii?Q?Eh9pnfbC41IQjwV/v9c7YXA1JEm/sCJaXZU9adP6f2YyNVjMnvPNd17jASvo?=
 =?us-ascii?Q?ZThJT1tlOrVZlAZeYSEZqIksTMFt2DiqyA7N1JlmYTrYPpqqxTVkZrpK6pf1?=
 =?us-ascii?Q?6sVVK3kj0aQqq0dYoEqeLAOrU2y30J1iGrDwmMNTyExkHfAzGDRXxK0nPoHZ?=
 =?us-ascii?Q?npF4H5TVlYH0LbKEYHXlobi2ZABq8I7HUZHxTXoN9CmN4E1hy/uyTIge38t5?=
 =?us-ascii?Q?H7nkYcqfxgKAXLAFuCabZ2QBk7TLNayAKcvvGNw5Yz1NyMOeBYH4hgNGldx4?=
 =?us-ascii?Q?d9HHWCpp6dxX1aqdMzXNGafqksRa9NHHDNobLguMuYOhDST4CyDMyRD75jpq?=
 =?us-ascii?Q?54YNDMP+82UH2ms+OnNoHlwVznY4c14kHbzLb9W3n+tvUaWKYVE1ucSSqXry?=
 =?us-ascii?Q?9TXFGdB9O4JWkSh1uLuVsdqnyPrEE7aM4qV63UKpYoUb4wywENk+fuSYwEQZ?=
 =?us-ascii?Q?mTYfhVOB4N3RZ5f75b2sFKlPhpxHVrZmdeyxjWw0mcHiW1Wy24prhU8llcKL?=
 =?us-ascii?Q?nAGCcHCRwtoT1jqWVxzR5SnfpthEEzrWl+JOiZox21hK6V/Onvc/wzcU4Wwh?=
 =?us-ascii?Q?pUF6K+qrUAuRWo7YYl3o544PdXFTl/YTVIjoKtFkM5m3UiwDKr9Cpn2m4/Kc?=
 =?us-ascii?Q?EM84K5WK3z8+9OebYoUYwPpBvm4BFUPYRS5bTpXhfORx45TZ/a+4iXvGbo+J?=
 =?us-ascii?Q?qACWhcjXjm2Fyi6qgp9dT6iP8vtITo6xNWbpiAimYOFw2S7dcXh2XOKSvvGL?=
 =?us-ascii?Q?fFSGllpVzjWoHSQPBcusqqhJB7CBzgox8gQCigdAlI1rxwZ/iUUruQvuxcoM?=
 =?us-ascii?Q?5orhE9xbfd9FhGk3XpyFOGueTlE+2pXy5sy9OIORMGNLNl8LGdaSEUznc02b?=
 =?us-ascii?Q?MclYIeOQ6sAKsOtdUzHfvs95C0I+Bp4xfiNYJMxNvltvDhFjly7spJm2znmf?=
 =?us-ascii?Q?H2Frjr54ewPsTSzdeCMWV+ABSD4l9LMKA2wFzr/RZyUA/s759N3638HjjPee?=
 =?us-ascii?Q?OxZni/vth4so4cV2qZeT8tSDzDXn/P+sET5920HNV4sMdTd71lgEpqir7dFK?=
 =?us-ascii?Q?Q1CflMLtnvKLjXCBJzx2Cw1n+Sp0MdDichYt1qFs?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fb8f8ef6-98eb-423b-444c-08da86746e8d
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 08:33:05.7301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k8X+4xV/p5H69zoNh213N56H21o8oXl6VejZI/52TpwuU/yiFczDf5/gzENA1+5ukKu9sFchhAhZNtA5fqD5Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4901
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Li <ye.li@nxp.com>

According to measure on i.MX7ULP and i.MX8ULP, the RCS done needs
about 3400us and 6700us respectively. So current 20us timeout is
not enough. When reconfiguring is on-going, unlock and configure CS
will lead to unknown result.

Increase the wait timeout value to 10ms and check the return value
of RCS wait to fix the issue

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Acked-by: Jason Liu <jason.hui.liu@nxp.com>
---

Changes for v2:
 - none

 drivers/watchdog/imx7ulp_wdt.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/watchdog/imx7ulp_wdt.c b/drivers/watchdog/imx7ulp_wdt.c
index a0f6b8cea78f..12715c248688 100644
--- a/drivers/watchdog/imx7ulp_wdt.c
+++ b/drivers/watchdog/imx7ulp_wdt.c
@@ -39,7 +39,7 @@
 #define DEFAULT_TIMEOUT	60
 #define MAX_TIMEOUT	128
 #define WDOG_CLOCK_RATE	1000
-#define WDOG_WAIT_TIMEOUT	20
+#define WDOG_WAIT_TIMEOUT	10000
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0000);
@@ -80,7 +80,7 @@ static int imx7ulp_wdt_enable(struct watchdog_device *wdog, bool enable)
 		writel(val | WDOG_CS_EN, wdt->base + WDOG_CS);
 	else
 		writel(val & ~WDOG_CS_EN, wdt->base + WDOG_CS);
-	imx7ulp_wdt_wait(wdt->base, WDOG_CS_RCS);
+	ret = imx7ulp_wdt_wait(wdt->base, WDOG_CS_RCS);
 
 enable_out:
 	local_irq_enable();
@@ -127,7 +127,9 @@ static int imx7ulp_wdt_set_timeout(struct watchdog_device *wdog,
 	if (ret)
 		goto timeout_out;
 	writel(val, wdt->base + WDOG_TOVAL);
-	imx7ulp_wdt_wait(wdt->base, WDOG_CS_RCS);
+	ret = imx7ulp_wdt_wait(wdt->base, WDOG_CS_RCS);
+	if (ret)
+		goto timeout_out;
 
 	wdog->timeout = timeout;
 
-- 
2.17.1

