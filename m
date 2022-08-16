Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B025953BE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 09:27:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbiHPH1i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 03:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiHPH1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 03:27:08 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2062b.outbound.protection.outlook.com [IPv6:2a01:111:f400:7d00::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB61387F34;
        Mon, 15 Aug 2022 21:39:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jGjgCK1ZFT+2uUDKSD5/tLD7nta24qBBWD4+gV23gFUJ4X2QNYwZL3mYP3JFNiuguAS7wDFqg57uWh4Y3dPrTg0SQnkDVnQyB1v5q6I8nIu1isMEj54YhIbGPY81kWve0PTYqLUj0TwFGee9WcCE8RLUmXAsUSzhDBs/ZgHeScdilVkOoXTrB50p8FbXZcCGYsjCeF6GB91i2LpsuNWLG/OaS7VDgtg2d4DJTuTNxrFWxpRWeTPvXG/aGBvGIx6cMANMFYKvtdPtcTI3aq8uLvWYo3/LjWnRfUjYGVVkROfRCPV8HEpqq5q6FfhEp+9HWRdYr5sY7qyh3MZMSpLhkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IPe6kcN/NBW8g1cXcvCKdKblR9rCHhvtA00RdleoZhc=;
 b=P4+lVhuU9xjKu6zmb5InURSjeY9ove2irSoTdJFRBP7ei1j2dHoTFuVW8UBfskExxLbfedjo1i3Fyywzup77aCjG1cxKIaGd7I4DiMtIKvDC4seTw9MYuxlgj6pnV93WOlAkDZIEuYwkKZeGjCQfbL9DowFx30e9VRPdwJHWO5+5AuDOfMDNS3tQGxUTeNH3deIBlhiSIQmM8Z4xZsIkSIqwNX0qx5ln7dvLuJmgJZdtiCijxB2zTWYHz3QRN4N6DAU2EV5xtncHf/39z+zwpGMtDmPoyKT5S6+BMOswyO9FQ95kMZvUcPTYAZsHPWCpPjf3KH3GQTK6TGhZWH9Qew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IPe6kcN/NBW8g1cXcvCKdKblR9rCHhvtA00RdleoZhc=;
 b=fBNxTLs17/pMah3+KnETEEzYm+DcDpDhIEyxHbP8ks1lRKu6TcErHGudN+C0l1YQNmgxJkUoLVqlRV1JN6lYT9jKbtOWrOFcULsBCD2vyeEHVto1UYJUwaYZVSD+bqANfBvnfHPtjJXN5YpDQYXG4ZAsb/drReJ/VKQt8/vocdM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by DB8PR04MB7036.eurprd04.prod.outlook.com (2603:10a6:10:12f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Tue, 16 Aug
 2022 04:38:32 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c%3]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 04:38:32 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     wim@linux-watchdog.org, linux@roeck-us.net, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 5/7] watchdog: imx7ulp_wdt: Handle wdog reconfigure failure
Date:   Tue, 16 Aug 2022 12:36:41 +0800
Message-Id: <20220816043643.26569-6-alice.guo@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 49ecbad4-de7e-4d81-5407-08da7f412c7f
X-MS-TrafficTypeDiagnostic: DB8PR04MB7036:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hK02G+206QfsbnUmnWJD/+8j2ZunoQLSUBKjNTAxiCflSz3GnAAfcBgCyMpB1m1pHho8/l4WTrq71gV2bE3wl5/IVTvw4YbhvWZYKfoqFQbSqI6MvLGTvH7m4Ag60IM8/0cIX2w/UR0jFasy8aD26J8XwsSMPnsd4YWkrz61wFxKxLmdrWtDwn5TNgDqNdz19BJxa8UimmpDPJ6fXkia5tk6ZSwzhOgBZOtP9N1SgebbpCdxVbxBRrVpAY7qerNLWO1we/Bc+tC6ah22uXK+UEvtmlb/2Bz+Djl/Z0PUEM7hbBlJ8TzaVGUPUjTZi6XN0YXp11zLoR9uIl4msEMPULBmAS5b0tzmiDYajseHJyvPrsG7KghTdpDwbO6l0YxL6whwgI5iOkq+pyvop8L39DNAeYQfO9w8Dbb5+ul0baBRGcwQGcwLUpxR4o1oFM1pGdOGcYFJeZQEBTpaYzzoMDkBc0ltTDcwhOFgOoksqaDsmABraRkdLpTmuN6EAI9KVF+1TV888008jo3t3OM0lgRzYIbJ0lOOG0sDRLML7DBKEb25Acai1f4Z6zxmZ227MlgwWtQN+53OeO7sdhzp1rWpYt5Acpg1fF+mbDxnIPOfs4goyDRFGnbk9hc6eyYcwBiR8xxIvq2+zBXGEkTWAGZXNxCkgsIzgcYFM0fmDHYgshk3W/DMBCrxlUxj5wuoMqdbYA5mDGQ1LAzosykZbFvyK/kuYqfZHOWvUKCPkcdxohBmoTnilGXboJooTO3rhIr5LbMD9449eBqe8ivKrfEfxxDGRQ7ey7pguy7pcHw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(396003)(39860400002)(376002)(136003)(83380400001)(38350700002)(86362001)(38100700002)(4326008)(8676002)(66556008)(66946007)(66476007)(316002)(2906002)(8936002)(5660300002)(6512007)(6506007)(26005)(1076003)(41300700001)(2616005)(186003)(52116002)(6666004)(6486002)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rq1uxz80MThjU7Pn2Dn1c99DK2vbt8GCloRI9DJRpcFDNuBGfFGp0WOKr1as?=
 =?us-ascii?Q?HHWRz89ysa8NxluZAvSGunyd5eMPDTRzKq9xpzLeIJ4FsPVZUUwR8tBmYnr4?=
 =?us-ascii?Q?uxlv9tjVf2Q7k09iLWtJV4R2LvVbz1oNt3bv5rUame+EJx0Idp0oXdhqwpp0?=
 =?us-ascii?Q?FAs3Y0h2A0+gM/rP/U4vCt4ib62ikHxRBXB1s8zvT5x9ccB5iRv6B+0A0IZV?=
 =?us-ascii?Q?UpUXcErc0yLAq6yL4ZRUVQnqfa6zQd06r8cRrNA3TWxvV30q4kGvMzZEWQ3u?=
 =?us-ascii?Q?4lVeDNDpEastPoNE39Ux16MIQYjq6j7WxnCnPoK8jwvbYTSGQwHejE48uAjn?=
 =?us-ascii?Q?qaqaZUZVJMskRUGqorYNzT/jucIHUd5HpFXqjQ9z/WczsXc+t1CPLzMBcma8?=
 =?us-ascii?Q?rB3/2ipqmKL9S3Xd/r59PfjIe3boQAZCIp5QvYiJ5HCHlHt4WxnvvOvglDNh?=
 =?us-ascii?Q?dcgD+0Y9XUCktc8+Qe2/K661dC4ODHBtvXoogm3Ti6J0pJ1I7U+FPiQT/hNt?=
 =?us-ascii?Q?Pcy5i1dat/87Ei2r6ko+kctPJOzQY68J/UDI35pSJDf4HIRL8jiTyRz9eZvq?=
 =?us-ascii?Q?eMLmDC+IUX1iJkfF2uFovzae2/4IxiTHZwrHKJZhKIclaJ4qz0tB/2fWBYCL?=
 =?us-ascii?Q?BwABQYYX1w1tbF4RLxe278aCpnQUDzReKP+1RsFnMGpw2cYXcEuQ9n1GIMhN?=
 =?us-ascii?Q?6dU/0gR5z5y9M7ykjGMn40Ezb/O6isWvSXHNTQg/eKXjCGQLoNU+rMdtbDPz?=
 =?us-ascii?Q?aaeqxgKBcIXP/AywASpskgtndRkRqC1v+98ujPFyxHtu2FymeOZHu9DlZ3JC?=
 =?us-ascii?Q?w81hUYXILNVCr/qHu6cZrs5w6FKi6FAwrRSeKyhc2fkiDmLNu0XcTPJdX83x?=
 =?us-ascii?Q?m5rIe4Nq69vzkKZ4BrJy9YkqAXf/GwhYtJEQoNsTyUwsT79pOtuoFTaqgGAo?=
 =?us-ascii?Q?2YR3mSMqkY9EU4XNP1RrCymd4iNhKNRu5z7hMoL75VPfcIADxzrOnRTHlArm?=
 =?us-ascii?Q?SIViLczDHPaIcJlHsj+x5X9TgXIw1y9sYCq12pSaN5fYu92d3FwMxK/5OTrK?=
 =?us-ascii?Q?BofsFiEu7cJOzS3ZoeldcsqOv4/WJiIdDiqKWXyKVkm0P3/AVa7V93Ic+/Cv?=
 =?us-ascii?Q?ttxytT2o/Zy3YJxPhV5G5EubiQ7KaCzYcsPChiXEaIWxWDPl58dpESfErIsl?=
 =?us-ascii?Q?MS4Ojcc1V+w4gShzOwltC3dKZvJtNkCiP27eg5zWAzCBFfcL5kIYL6ueolDN?=
 =?us-ascii?Q?C/h8SBf8jTok6BQxM63CYpbRw9+CHc/346XXjoiW8MHCCfIVz02q5LxptXHe?=
 =?us-ascii?Q?oIEwTQ91GmzH1poNhyrGDFzLo+/HIcSnujlv2Ra13rYwJeFnnbXo5xCoLhux?=
 =?us-ascii?Q?jgjgjtrU1ww5NQGDHMJKp1RjBxdqweht/+Bz0tQM2nHh6hl7vLM4uYOIrBNQ?=
 =?us-ascii?Q?mIXf1BsXtlbkhRy2t3DZRsJgqTpwcisKfTFPvIy28XRwDkQNPbnzRU3JCKsS?=
 =?us-ascii?Q?hIjRrMHcj/sjXemjxyJhtii7Cq4dSEjPCZWGMraDemwD0ZwILSrdxpv0RxQO?=
 =?us-ascii?Q?1TEt2diWV4pIRF8veu8PBg51xVxIaaXDm0Oqe5d9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49ecbad4-de7e-4d81-5407-08da7f412c7f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 04:38:32.5146
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vfv7IAmDlf/IRjAq/1A43SaleJE61HxKpAiZdZvN51ZzexVNm/TFmVlmQyZAdz1KdC4hceMYcX+miXyCdku8yQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7036
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ye Li <ye.li@nxp.com>

Current driver may meet reconfigure failure caused by below reasons:

1. The wdog on iMX7ULP has different behavior after RCS valid. It needs
   to wait more than 2.5 wdog clock for clock sync before next
   reconfiguration, while imx8ulp wdog does not need such delay.

2. After unlock, there is 128 bus clock window opened for reconfiguration,
   but on iMX8ULP, the HW can't guarantee the latency. So it is possible
   the window is closed before the writing arrives to wdog.

3. If the PRES is enabled, the RCS valid time becomes x256 to the time
   of PRES disabled. It is about 1715ms on iMX8ULP. So We have to increase
   the RCS timeout and can't wait it in IRQ disabled.

The patch updates the driver to handle failures

1. Using different wait for unlock and RCS. Unlock valid time is very short
   and only related to bus clock. It must be in IRQ disabled to avoid
   being interrupted in 128 clock window. But for RCS time, it is longer
   and ok for IRQ enabled.

2. Add retry for any reconfigure failure with default 5 times.

3. Add "fsl,imx8ulp-wdt" compatile string for iMX8ULP and afterwards
   platform which don't need more 2.5 wdog clock after RCS valid.
   For imx7ulp, add post delay of 2.5 clock after RCS valid.

Signed-off-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Alice Guo <alice.guo@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
---
 drivers/watchdog/imx7ulp_wdt.c | 163 ++++++++++++++++++++++++++-------
 1 file changed, 129 insertions(+), 34 deletions(-)

diff --git a/drivers/watchdog/imx7ulp_wdt.c b/drivers/watchdog/imx7ulp_wdt.c
index 12715c248688..51eaaf24bd8f 100644
--- a/drivers/watchdog/imx7ulp_wdt.c
+++ b/drivers/watchdog/imx7ulp_wdt.c
@@ -14,7 +14,9 @@
 #include <linux/watchdog.h>
 
 #define WDOG_CS			0x0
+#define WDOG_CS_FLG		BIT(14)
 #define WDOG_CS_CMD32EN		BIT(13)
+#define WDOG_CS_PRES		BIT(12)
 #define WDOG_CS_ULK		BIT(11)
 #define WDOG_CS_RCS		BIT(10)
 #define LPO_CLK			0x1
@@ -39,7 +41,11 @@
 #define DEFAULT_TIMEOUT	60
 #define MAX_TIMEOUT	128
 #define WDOG_CLOCK_RATE	1000
-#define WDOG_WAIT_TIMEOUT	10000
+#define WDOG_ULK_WAIT_TIMEOUT	1000
+#define WDOG_RCS_WAIT_TIMEOUT	10000
+#define WDOG_RCS_POST_WAIT 3000
+
+#define RETRY_MAX 5
 
 static bool nowayout = WATCHDOG_NOWAYOUT;
 module_param(nowayout, bool, 0000);
@@ -50,40 +56,82 @@ struct imx7ulp_wdt_device {
 	struct watchdog_device wdd;
 	void __iomem *base;
 	struct clk *clk;
+	bool post_rcs_wait;
 };
 
-static int imx7ulp_wdt_wait(void __iomem *base, u32 mask)
+static int imx7ulp_wdt_wait_ulk(void __iomem *base)
 {
 	u32 val = readl(base + WDOG_CS);
 
-	if (!(val & mask) && readl_poll_timeout_atomic(base + WDOG_CS, val,
-						       val & mask, 0,
-						       WDOG_WAIT_TIMEOUT))
+	if (!(val & WDOG_CS_ULK) &&
+	    readl_poll_timeout_atomic(base + WDOG_CS, val,
+				      val & WDOG_CS_ULK, 0,
+				      WDOG_ULK_WAIT_TIMEOUT))
 		return -ETIMEDOUT;
 
 	return 0;
 }
 
-static int imx7ulp_wdt_enable(struct watchdog_device *wdog, bool enable)
+static int imx7ulp_wdt_wait_rcs(struct imx7ulp_wdt_device *wdt)
 {
-	struct imx7ulp_wdt_device *wdt = watchdog_get_drvdata(wdog);
+	int ret = 0;
+	u32 val = readl(wdt->base + WDOG_CS);
+	u64 timeout = (val & WDOG_CS_PRES) ?
+		WDOG_RCS_WAIT_TIMEOUT * 256 : WDOG_RCS_WAIT_TIMEOUT;
+	unsigned long wait_min = (val & WDOG_CS_PRES) ?
+		WDOG_RCS_POST_WAIT * 256 : WDOG_RCS_POST_WAIT;
 
+	if (!(val & WDOG_CS_RCS) &&
+	    readl_poll_timeout(wdt->base + WDOG_CS, val, val & WDOG_CS_RCS, 0,
+			       timeout))
+		ret = -ETIMEDOUT;
+
+	/* Wait 2.5 clocks after RCS done */
+	if (wdt->post_rcs_wait)
+		usleep_range(wait_min, wait_min + 2000);
+
+	return ret;
+}
+
+static int _imx7ulp_wdt_enable(struct imx7ulp_wdt_device *wdt, bool enable)
+{
 	u32 val = readl(wdt->base + WDOG_CS);
 	int ret;
 
 	local_irq_disable();
 	writel(UNLOCK, wdt->base + WDOG_CNT);
-	ret = imx7ulp_wdt_wait(wdt->base, WDOG_CS_ULK);
+	ret = imx7ulp_wdt_wait_ulk(wdt->base);
 	if (ret)
 		goto enable_out;
 	if (enable)
 		writel(val | WDOG_CS_EN, wdt->base + WDOG_CS);
 	else
 		writel(val & ~WDOG_CS_EN, wdt->base + WDOG_CS);
-	ret = imx7ulp_wdt_wait(wdt->base, WDOG_CS_RCS);
+
+	local_irq_enable();
+	ret = imx7ulp_wdt_wait_rcs(wdt);
+
+	return ret;
 
 enable_out:
 	local_irq_enable();
+	return ret;
+}
+
+static int imx7ulp_wdt_enable(struct watchdog_device *wdog, bool enable)
+{
+	struct imx7ulp_wdt_device *wdt = watchdog_get_drvdata(wdog);
+	int ret;
+	u32 val;
+	u32 loop = RETRY_MAX;
+
+	do {
+		ret = _imx7ulp_wdt_enable(wdt, enable);
+		val = readl(wdt->base + WDOG_CS);
+	} while (--loop > 0 && ((!!(val & WDOG_CS_EN)) != enable || ret));
+
+	if (loop == 0)
+		return -EBUSY;
 
 	return ret;
 }
@@ -114,28 +162,44 @@ static int imx7ulp_wdt_stop(struct watchdog_device *wdog)
 	return imx7ulp_wdt_enable(wdog, false);
 }
 
-static int imx7ulp_wdt_set_timeout(struct watchdog_device *wdog,
-				   unsigned int timeout)
+static int _imx7ulp_wdt_set_timeout(struct imx7ulp_wdt_device *wdt,
+				   unsigned int toval)
 {
-	struct imx7ulp_wdt_device *wdt = watchdog_get_drvdata(wdog);
-	u32 val = WDOG_CLOCK_RATE * timeout;
 	int ret;
 
 	local_irq_disable();
 	writel(UNLOCK, wdt->base + WDOG_CNT);
-	ret = imx7ulp_wdt_wait(wdt->base, WDOG_CS_ULK);
+	ret = imx7ulp_wdt_wait_ulk(wdt->base);
 	if (ret)
 		goto timeout_out;
-	writel(val, wdt->base + WDOG_TOVAL);
-	ret = imx7ulp_wdt_wait(wdt->base, WDOG_CS_RCS);
-	if (ret)
-		goto timeout_out;
-
-	wdog->timeout = timeout;
+	writel(toval, wdt->base + WDOG_TOVAL);
+	local_irq_enable();
+	ret = imx7ulp_wdt_wait_rcs(wdt);
+	return ret;
 
 timeout_out:
 	local_irq_enable();
+	return ret;
+}
 
+static int imx7ulp_wdt_set_timeout(struct watchdog_device *wdog,
+				   unsigned int timeout)
+{
+	struct imx7ulp_wdt_device *wdt = watchdog_get_drvdata(wdog);
+	u32 toval = WDOG_CLOCK_RATE * timeout;
+	u32 val;
+	int ret;
+	u32 loop = RETRY_MAX;
+
+	do {
+		ret = _imx7ulp_wdt_set_timeout(wdt, toval);
+		val = readl(wdt->base + WDOG_TOVAL);
+	} while (--loop > 0 && (val != toval || ret));
+
+	if (loop == 0)
+		return -EBUSY;
+
+	wdog->timeout = timeout;
 	return ret;
 }
 
@@ -175,38 +239,59 @@ static const struct watchdog_info imx7ulp_wdt_info = {
 		    WDIOF_MAGICCLOSE,
 };
 
-static int imx7ulp_wdt_init(void __iomem *base, unsigned int timeout)
+static int _imx7ulp_wdt_init(struct imx7ulp_wdt_device *wdt, unsigned int timeout, unsigned int cs)
 {
 	u32 val;
 	int ret;
 
 	local_irq_disable();
 
-	val = readl(base + WDOG_CS);
+	val = readl(wdt->base + WDOG_CS);
 	if (val & WDOG_CS_CMD32EN) {
-		writel(UNLOCK, base + WDOG_CNT);
+		writel(UNLOCK, wdt->base + WDOG_CNT);
 	} else {
 		mb();
 		/* unlock the wdog for reconfiguration */
-		writel_relaxed(UNLOCK_SEQ0, base + WDOG_CNT);
-		writel_relaxed(UNLOCK_SEQ1, base + WDOG_CNT);
+		writel_relaxed(UNLOCK_SEQ0, wdt->base + WDOG_CNT);
+		writel_relaxed(UNLOCK_SEQ1, wdt->base + WDOG_CNT);
 		mb();
 	}
 
-	ret = imx7ulp_wdt_wait(base, WDOG_CS_ULK);
+	ret = imx7ulp_wdt_wait_ulk(wdt->base);
 	if (ret)
 		goto init_out;
 
 	/* set an initial timeout value in TOVAL */
-	writel(timeout, base + WDOG_TOVAL);
-	/* enable 32bit command sequence and reconfigure */
-	val = WDOG_CS_CMD32EN | WDOG_CS_CLK | WDOG_CS_UPDATE |
-	      WDOG_CS_WAIT | WDOG_CS_STOP;
-	writel(val, base + WDOG_CS);
-	imx7ulp_wdt_wait(base, WDOG_CS_RCS);
+	writel(timeout, wdt->base + WDOG_TOVAL);
+	writel(cs, wdt->base + WDOG_CS);
+	local_irq_enable();
+	ret = imx7ulp_wdt_wait_rcs(wdt);
+
+	return ret;
 
 init_out:
 	local_irq_enable();
+	return ret;
+}
+
+static int imx7ulp_wdt_init(struct imx7ulp_wdt_device *wdt, unsigned int timeout)
+{
+	/* enable 32bit command sequence and reconfigure */
+	u32 val = WDOG_CS_CMD32EN | WDOG_CS_CLK | WDOG_CS_UPDATE |
+		  WDOG_CS_WAIT | WDOG_CS_STOP;
+	u32 cs, toval;
+	int ret;
+	u32 loop = RETRY_MAX;
+
+	do {
+		ret = _imx7ulp_wdt_init(wdt, timeout, val);
+		toval = readl(wdt->base + WDOG_TOVAL);
+		cs = readl(wdt->base + WDOG_CS);
+		cs &= ~(WDOG_CS_FLG | WDOG_CS_ULK | WDOG_CS_RCS);
+	} while (--loop > 0 && (cs != val || toval != timeout || ret));
+
+	if (loop == 0)
+		return -EBUSY;
 
 	return ret;
 }
@@ -239,6 +324,15 @@ static int imx7ulp_wdt_probe(struct platform_device *pdev)
 		return PTR_ERR(imx7ulp_wdt->clk);
 	}
 
+	imx7ulp_wdt->post_rcs_wait = true;
+	if (of_device_is_compatible(dev->of_node,
+				    "fsl,imx8ulp-wdt")) {
+		dev_info(dev, "imx8ulp wdt probe\n");
+		imx7ulp_wdt->post_rcs_wait = false;
+	} else {
+		dev_info(dev, "imx7ulp wdt probe\n");
+	}
+
 	ret = clk_prepare_enable(imx7ulp_wdt->clk);
 	if (ret)
 		return ret;
@@ -259,7 +353,7 @@ static int imx7ulp_wdt_probe(struct platform_device *pdev)
 	watchdog_stop_on_reboot(wdog);
 	watchdog_stop_on_unregister(wdog);
 	watchdog_set_drvdata(wdog, imx7ulp_wdt);
-	ret = imx7ulp_wdt_init(imx7ulp_wdt->base, wdog->timeout * WDOG_CLOCK_RATE);
+	ret = imx7ulp_wdt_init(imx7ulp_wdt, wdog->timeout * WDOG_CLOCK_RATE);
 	if (ret)
 		return ret;
 
@@ -289,7 +383,7 @@ static int __maybe_unused imx7ulp_wdt_resume_noirq(struct device *dev)
 		return ret;
 
 	if (imx7ulp_wdt_is_enabled(imx7ulp_wdt->base))
-		imx7ulp_wdt_init(imx7ulp_wdt->base, timeout);
+		imx7ulp_wdt_init(imx7ulp_wdt, timeout);
 
 	if (watchdog_active(&imx7ulp_wdt->wdd))
 		imx7ulp_wdt_start(&imx7ulp_wdt->wdd);
@@ -303,6 +397,7 @@ static const struct dev_pm_ops imx7ulp_wdt_pm_ops = {
 };
 
 static const struct of_device_id imx7ulp_wdt_dt_ids[] = {
+	{ .compatible = "fsl,imx8ulp-wdt", },
 	{ .compatible = "fsl,imx7ulp-wdt", },
 	{ /* sentinel */ }
 };
-- 
2.17.1

