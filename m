Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E3745A0B93
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbiHYIdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:33:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237893AbiHYIdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:33:24 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50075.outbound.protection.outlook.com [40.107.5.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B8AA74CD;
        Thu, 25 Aug 2022 01:33:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iAzLpVlI/R6VKXWfVy6vbDm9niqzY1MC7bA+EoVm89aaO9Ua5fK9cZuDmSNUrJoSZVEtIAqSIu2JzqGjh00sK4ZOgm+QFcXJUw08GvZ9BxStDpuOWyV+wJ7zwsKoX7A2XIR0uQCiX0L57UD/vGn8WbxXVV7jcsQGD+DlP6/S4YLl5uB1/v5Vc4zYvc2Am6DuHfggjxf4MKg8uQ3XKra1YeIcyYbgKHWEncDTTzpOYFJZEOcTR5SlLNq2g/6fVJeqBEyfIV4Ik5sVzmSG1ZRieEbQ+U+70Sc+dKvdSc6SqZxfH5V8e3YoPw8K3hlCEnZFEibVp6nVjVj7BW7Z6pZ1sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eq18NP4/7hBByccpJqoOVx1AgOzC4V0xM7AvIlkxYnc=;
 b=RHmIngtYoiCLclMZ5igoUfy7RkJzzs6Aspqz8CF4nAB39pdBA53e0ms3FPu004RTHzMuXoMtFCfb2VmNoKNtZIpg1pZkuYZiSPNHiR6029VKPd9CEK4+5g+FL918vqH7bFz/D773D2Kh2C52R/PHBkXcl25sWaeFIdgHQtoTOU+NnrzTRQb3p9FNRfIhkJeV2Vxg3ifn9+CcQP/MZXfK+7IjUigM2CkIT79xJz2OdU5PZrnC697GfkEJOVorBhgHqqtZSOGG2UAhxE5+PSalYYLjWVgODUEZ+zlLQIa8GxzlQPIT477HRyDD/zcdpMLMeRGOCSoBiPbGLYWvgoVO5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eq18NP4/7hBByccpJqoOVx1AgOzC4V0xM7AvIlkxYnc=;
 b=cDSE53Qgwh77cxKtAS6VhqW0YtUfQIpnib9YJIV1uSMH3pbojnMS0YYTFJIl/WquUjD559+bIWRovSNzr/BwDbh5KEPkhOBhb/WFTpSEi3mFMeFtXoQrzwv6ayzE8+a0OwXISNWIbFtvPDMISrUxBli6FNu/LgM7dX+fpdw+p00=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM6PR04MB4901.eurprd04.prod.outlook.com (2603:10a6:20b:1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 08:33:15 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c%3]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 08:33:14 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     m.felsch@pengutronix.de, linux@roeck-us.net,
        wim@linux-watchdog.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/7] watchdog: imx7ulp_wdt: init wdog when it was active
Date:   Thu, 25 Aug 2022 16:32:55 +0800
Message-Id: <20220825083256.14565-7-alice.guo@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 37a89f51-31d6-40b9-4c10-08da86747402
X-MS-TrafficTypeDiagnostic: AM6PR04MB4901:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X2RGlD7iaU+EROplLRqNw92nFDyHAcvl6sQHsgSUrDzWtUc09D0WLGchjs2ZzCAjJIX+ok1CHihIOLXaZioZ+TIS3cWG2Sfl2b7zRCY0dKI7DIPTml/NMzT080Pdw8E4s38ZUkHcPOhEX2dWcHqRGEWEOtLr51uu+VxeIFN07Cx5QVuN0w7MT97/5Up44MGSO9j17pNooruTmKPkCwQ/Giw5u5V6mW39oMqBoSUjNveVVUCQeLfYhgKYJX5a+p0TsF/U82TI6dID0JUHNAixHlvG/cS3VJ6MZqRjo3AP1Y+n6SlN5e0Mhwbut8+zBWS+IUcpUnP7F9yNraGSXVkb7vMJ5BbjCG6YAJ3Rc77Jae7e/uUSDXvQTuv9RZzb4p2Ab1jUxutIkRjOPMl5FZ9Tnbn2hlGThO9n+HXEWxRWVFcprL5m8DLwXJxJNQ8Q0oOJq503hnwIfFVJo9c92xtHHV6IVFJh1oyOjTqHVCevED1CBeMy3XQ9WQeUTp6FEm8MjGFB1XjCrAXpzVUVzgl8YTtiQjORUYI5msaLG4geIxhHM3TiKNxv7gWWoURnmfiqh6mvRPeQzzqiUJbnwh5KmbjkvuwHtcNY+Ni2Q/kCI6FNWqxQ07B1jtjcj+AIdq1RlPFrwnGSRf2HW2qIa69O8plbR7wmln6/+CFhsSbojqMSmq7qfAod2u0ZudHhxIe2M8zItpvcWNfJr8GkMr/zHzqCx/xYggfM+MBL1U18+mXRC4JjF256xJuPppAjhdh+7f9+6JgGvcOd/FkPbLbW5A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(8936002)(5660300002)(7416002)(38100700002)(38350700002)(4326008)(66946007)(66556008)(66476007)(478600001)(8676002)(6486002)(6666004)(41300700001)(316002)(2616005)(186003)(1076003)(26005)(6512007)(83380400001)(2906002)(52116002)(6506007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?wX1keeo6Hth+l79aJ2M4iKpFoeTI9j/b5QG/D0HL/9hBn7ye6meoIsECmCI/?=
 =?us-ascii?Q?P0t4qXavyjuCnNxD+u2Z3bDIRPjsiogBWS8YiSajtHpaMRHkN34Uhw3AAcvp?=
 =?us-ascii?Q?+icXQFh1yl2UgXZZvKMsETufMT6irzT7MC68bo+kZ5fdgyBtPhFQXncLZ6P3?=
 =?us-ascii?Q?2SJBVx92hS7F5KvzJO6npNbBIV5QCzdwNY3k/UuWW2AAMUq7vYADoiTy8fe3?=
 =?us-ascii?Q?aXw7/4OeoCNCtR6qzDh1zTXWXLzXbH9NCtpPepKA7+1WvHnxqNYDt2L4Up5B?=
 =?us-ascii?Q?4AH+I6uIVwoiBDYqeVh/iGJ1Cbg/bmtUaoeGFVRrBlVPwZP7v8p3mSqmkvJj?=
 =?us-ascii?Q?FpGLBhKzM83cYtkkQ3jpbdvqMTP7X9OgwN7bhVNZw5JjLGzT3yhVVoX9LH0Z?=
 =?us-ascii?Q?d4+I1W29kNIISvzVCg/IfYGnxrP5xq9C3wP8K7kKDLSYtH02oTAB/aVbuebU?=
 =?us-ascii?Q?olW+nsZSvu7nOxZX/pH2bi2Sf3uEOkNtD17bzKju09HmDFYhtHWKlnospjMO?=
 =?us-ascii?Q?BlqypnaBnvkwg1B0YjN4YkSbwgBZCd6lZGipEOWuhnZ+Et/gB8La34jIkoQR?=
 =?us-ascii?Q?0NuDYNrYYJX/+wtes9GE44R/+pkhnyr+MP8gy9jZAb33EZcS0P37s7/cIukV?=
 =?us-ascii?Q?GTVL/R/mjlkFgTMV+eAHPxkHMw0hrqqo12SEv/WbV+9H8wMgTAt0eBewr4fs?=
 =?us-ascii?Q?MPZdMiK4MM10/K3QY5jpTlm38+bO76UNLnOyL0dqMNOcP+a1GzGw9Pk7EHV4?=
 =?us-ascii?Q?MkyGngW8zk0Sq6J8ZNylOIuaibbW7n3olk754M4GH2aNZP69Dcen2+08AAv3?=
 =?us-ascii?Q?2It8oELd8pFwmlhX9VN5EATd3cP/ObnY1rdIc3NIyl8ZF0QGJ2xFx2pFwfHZ?=
 =?us-ascii?Q?tkYcYnyanJP1M0DUdJauHnVKni1hNhtcLdeUHeUjphIAsI3zvr++4hE/mFe+?=
 =?us-ascii?Q?tFPYBwSJRp88AJPuSuQBKb80PuW54b6jRHH/l+3Lx+umoxFVufHfkVhjuLBO?=
 =?us-ascii?Q?hkCfM0obLyVS2KBYPZx/5I9ViKV2lu7GpQDKaAKsJ7BOglCqr5Mj+lqDFEb+?=
 =?us-ascii?Q?7lkdSjoGGzzoXLK0oiZ3lqeJK94BhV+nyx7yYCw4MfG6OesgMi84twm6IBgU?=
 =?us-ascii?Q?VEr7Bb00px/8yw0JsxsHIQBH/SbuHKVVrNh1qJONhQUaBccWs/Z7IFgKNElF?=
 =?us-ascii?Q?gHH4aJqFH0GoN9bOmJJ9rtYgO8hdR9p66Ps/K4eMuLqaEais3Hg/q6lyJktj?=
 =?us-ascii?Q?CTptx1+8WB+33GC0Z8rwS/wFGof/FJovum+qGCxhwgi5OM8QvlQiyLptsKRW?=
 =?us-ascii?Q?aAB4I0j9BPwWxXWYDOeDLqRlwGk4j0uaLaLna2aONsbREXCVTpCIBl0i9+Tk?=
 =?us-ascii?Q?y24bFsahDkdQk0c3xGTb9KBB+z1d1iSCE0tlaBFnOQtxtcNR9lm5gp3CUX0B?=
 =?us-ascii?Q?pHieyCm2IQL106mXyhDIrWaLiD1+sItSqswsbpyrEylP0lfsBfls+UiHoQVt?=
 =?us-ascii?Q?vVM9kRZJp+czjfMGY424xX+81uyUZqWioYY1qS0wnCoV2odE/7DSaNuNOb5F?=
 =?us-ascii?Q?75VW1jpYAafBIh3Z+gKETPqtlfT3sy3ynjF4nZUF?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37a89f51-31d6-40b9-4c10-08da86747402
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 08:33:14.8701
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: glJwEKpfhckEK+SlU4Fri9ahErzySRNrKTRll5M6nqZ7TW9OFK3a3CqH3BYT2M5uJ17946q2BnobVVX4HTmGYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4901
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jason Liu <jason.hui.liu@nxp.com>

Paired with suspend, we can only init wdog again when it was active
and ping it once to avoid the watchdog timeout after it resumed.

Signed-off-by: Jason Liu <jason.hui.liu@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Tested-by: Jacky Bai <ping.bai@nxp.com>
---

Changes for v2:
 - none

 drivers/watchdog/imx7ulp_wdt.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/watchdog/imx7ulp_wdt.c b/drivers/watchdog/imx7ulp_wdt.c
index 0cafa86fff7f..dee02c2a52c9 100644
--- a/drivers/watchdog/imx7ulp_wdt.c
+++ b/drivers/watchdog/imx7ulp_wdt.c
@@ -136,13 +136,6 @@ static int imx7ulp_wdt_enable(struct watchdog_device *wdog, bool enable)
 	return ret;
 }
 
-static bool imx7ulp_wdt_is_enabled(void __iomem *base)
-{
-	u32 val = readl(base + WDOG_CS);
-
-	return val & WDOG_CS_EN;
-}
-
 static int imx7ulp_wdt_ping(struct watchdog_device *wdog)
 {
 	struct imx7ulp_wdt_device *wdt = watchdog_get_drvdata(wdog);
@@ -382,11 +375,11 @@ static int __maybe_unused imx7ulp_wdt_resume_noirq(struct device *dev)
 	if (ret)
 		return ret;
 
-	if (imx7ulp_wdt_is_enabled(imx7ulp_wdt->base))
+	if (watchdog_active(&imx7ulp_wdt->wdd)) {
 		imx7ulp_wdt_init(imx7ulp_wdt, timeout);
-
-	if (watchdog_active(&imx7ulp_wdt->wdd))
 		imx7ulp_wdt_start(&imx7ulp_wdt->wdd);
+		imx7ulp_wdt_ping(&imx7ulp_wdt->wdd);
+	}
 
 	return 0;
 }
-- 
2.17.1

