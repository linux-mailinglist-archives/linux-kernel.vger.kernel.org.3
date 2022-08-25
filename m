Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65B885A0B97
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:33:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbiHYIdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:33:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237536AbiHYIdV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:33:21 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50075.outbound.protection.outlook.com [40.107.5.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73225A6C31;
        Thu, 25 Aug 2022 01:33:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MwzXQifn1P/UVU4S2uN2dYIVDF+XuG36M5WZTKBjsJz6n4NuDu0CMf7xSk7nNJ4l267YFPxfSL5J99iiGQz40K57Js7yhLPSyUYQxkHPd+IyyNSi6rk7HfSU2oFEDsvEsqO2SwxyYM5oZI6BfVrFQ+Aj9O/gISBucjHwQv4wBwlzrHMdzOxD6Qolz7sAISofG0RYEwMU8gZ/BlFW0biHVBq3Zb/dQBVUm+KB2KgEUnwvsYUZhSyPqx8WV2+kAZ/zzHwFursjjngyF1JJ8Vq2l1hfWYpGEdswabuOn8Me6aQSi8k/Io6Pg6OR/CgS3lmjg45yURdYWVIwlUg1j8AXnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n0uOd5QLwvAv+7rlEDID8F33L0kD21kSZdZ77C3Otb0=;
 b=SZpZPNe9Nq8Ocp4Qn4WoS7QSYKqU2OPGHlYUaRaDVk6ci02EOMkztpgM1F3fffCEHaLvNxDWwqKibKC76QTEF3ca5N95H6zI4co6qF+aGoCmOoBZ8NlBTusJvx/UHaRnrHv09T8VUJGgpjheAYeMuhzzW98CPIkrkyMjBcdqincYumA8g9e6Rt9FT1c/VMQgCc+fXNJ53zOHAcYeAajteIz+ZSRx5OpsSHAZRpzcSXjeDs3PUzxCUXEsXx3LWOCJNNJBbkMzHgNsnbUgl6VrWadqig/xMjwDF8TA3DZok+U/DD5wFQ5SlM4lMIItQiPk/v+CWvGda+dsBAeh8UEw1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n0uOd5QLwvAv+7rlEDID8F33L0kD21kSZdZ77C3Otb0=;
 b=aqtAn1ynH0jCo4QX6qkXSYZB5htD9Gnmm3FlGu87E7z9Oy4E9z3cw3DsKQAIwcvk35zLPWfMSZPPD5bPTZG55fMpgEU5IUc+K3qOZzC351k6ppoGUkymDWqGwzOCKagSNZ6gDOnKgkHOzLkskIk4QFv+TCJJLAfxSDs447EYJ3c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM6PR04MB4901.eurprd04.prod.outlook.com (2603:10a6:20b:1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 08:33:10 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c%3]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 08:33:10 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     m.felsch@pengutronix.de, linux@roeck-us.net,
        wim@linux-watchdog.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/7] watchdog: imx7ulp_wdt: Handle wdog reconfigure failure
Date:   Thu, 25 Aug 2022 16:32:54 +0800
Message-Id: <20220825083256.14565-6-alice.guo@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c7b2431a-70e3-4d1f-018d-08da86747162
X-MS-TrafficTypeDiagnostic: AM6PR04MB4901:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SqSQaxrz3pv8PDWliHQp9oCCm9qfdO7hA8aB1CYhy8xKQOsDffa0df/KVERW6g8u1meyw4eRZhCpJgzkIDH2n7rYPl12qa1R91KYMVWlqJSyN1eGVvm2TyTbocY6WNsbQUECp1L5zUw81t2s9PALzq9BW8DRvEdBCphMjYg20pU5ffk7aB7sNaL4hjLf7Gkga8j+g47Xist18jNkv1kAK4q4VG5iUzXbR4Un8/s53p2H2yEmkwyF5vE+Lxarpl8PKaMTtA5himv9hCMW5YCg4MDGhpqExiZYpHKv3OZDM1adw6SHu1nv0dxGzvAfhyD0YkbBOHSYjnZbJRVfXBhkeM/Z3oC2TLcuxp+4cV/uxlyW6a7hbSQekuW2uJx/0MiVMMazFpFUdtRg+U4ra5sRzH6DGsNokxoCRTgWvjTrC35lNfnqWDgt76b7BOR5ztCjRfQHIGslbaISo85TvIwZD+Um2yXszm0MgY2NK4h9p4r4r2MdtXd295njsJSSVs+qhsINe56xN7/9JdDSLuwnBsHzCaVLWE3u4LaN2G3ZZ03aMrBIftHQ0+1GoAq8LvMvZ/58BKwwQbUHHDKwp1fZ1tKtX8EMck0YeMVUuO0uyClM3+AmKX7ArR/h4PyTrLDsm1kaxd1D4B1VSPgDB4SMl7homwTmaR/yTC1HKVCmFqYpI4poCvkvkCds3l4vAZGAOZ3I3IoPqjQUN5xDXYvPwWNWJbygpyDn8SVoANmTE+axwM2yk56Hj6u+koaJdFz6k+VkFkk9q2trWZLVhxe/ZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(8936002)(5660300002)(7416002)(38100700002)(38350700002)(4326008)(66946007)(66556008)(66476007)(478600001)(8676002)(6486002)(6666004)(41300700001)(316002)(2616005)(186003)(1076003)(26005)(6512007)(83380400001)(2906002)(52116002)(6506007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C00TmKNhPNNXp3KHmfT8WKCcXQcQ3JiJQBzpwGdx70lLHurB9n1PMs12tUph?=
 =?us-ascii?Q?0K5H/mLu8ozcmqsYLO/q7V83YoIvTLhWiPTQFu62GHzHnGcc+ll+wOffUKeW?=
 =?us-ascii?Q?sGUdsNSC4PWC82a3xn5puBTNcO2l2fI7gojwliW7jplTCTvA38W7xPHSGUA8?=
 =?us-ascii?Q?zKGnLi1DrjfzMl3UCAhvUYc3QCzG4fTnnbGXxnTXg92ejrWGdhyrwEr4vL18?=
 =?us-ascii?Q?r5GvAlYbGYhGO6uFiXTYd6LqbB49AtXH1EjQRI8dysDQOeh9dKhzLIOrCmsi?=
 =?us-ascii?Q?ryFBkFyW2OUwPQc7DF9BHINekkQf2g9kfuuKcUlIGalXvofczC+1Erm32DnO?=
 =?us-ascii?Q?p4HPaE/8lFV8GL64VjEV2Q912ZN5IrqiTtkduOjA8PUd8SibJdEOSUS62dzK?=
 =?us-ascii?Q?jvB8KC10HQwV40V5HF/1zC2aNTacsCyOM6wQuXyxpBKtHtO7Aq2ArWRZ7WrI?=
 =?us-ascii?Q?HfmpkQzg0saSvsTmSndFpsr8p0vQestjXErofY9kz1ndohqwb7aDfsi4Rh5L?=
 =?us-ascii?Q?eQIKbT1qZUSZU3m0caBeotHHGe7BdcmfCAa+5kmc52gzax3ca52A7TBDfdKN?=
 =?us-ascii?Q?2g3SIlBhH/qbCoiVqXy536Is7bKIwR5pXWhtNKfJzP8//1r+NlVeVMFClNyD?=
 =?us-ascii?Q?Oo2gob/wdY/SmEc2wio4wvAL02MIE7Ga4ynIsvctOO9acuFzBUm6dG471frS?=
 =?us-ascii?Q?5Aj4csWfRB/VYKI2V4t7BqCQlOZTGvV/U+Dc3ODRGiLCbGvOqQHdSnpoYMAt?=
 =?us-ascii?Q?4zUrrHx8zFjZLYSlHFSa15JS2nPUEJ5b3xyyKVDgu7llFd7tcc8NAZuT4s9q?=
 =?us-ascii?Q?a0YmuJ/3iJL4G61l4GwY9jW/lmAYdCgDKUx3/HgnzbqRgjS/7O1FUmNHUILo?=
 =?us-ascii?Q?PhMQqjOVDEjak1ef39DhRmi05ExKQbCfNL+Yw2YFU8ylhfo+2+KXL4wNgdLX?=
 =?us-ascii?Q?HiuhTFHsFPLPeAyQ+NW7HIPdue7+u+15P3wqWzW68LnunjXCING3caawtNtL?=
 =?us-ascii?Q?lLHGa/xsFcLtjOqiPJMn8F7CnMXbvZEQqjtXKiuG14De3fFKjuZ8lGXv8esy?=
 =?us-ascii?Q?1KjSez3sjIfnhqeSMQGjYGdjWvulOjEB0wpWpgPR+c/48b96RrprDe0hgXij?=
 =?us-ascii?Q?0oMtLckCLN6ytxvwMJUyO/s79RkBkt/4ZOX+Y7QnXEIrZw/A5k1SOx18ikxv?=
 =?us-ascii?Q?jJQIdgVNUwkLxKMgmvgFmKmCIDd8MLoKK/LlEfCc45H4WwTrtgGl5wKu5tiM?=
 =?us-ascii?Q?j9nBLLGgobq3clKUo0voDEHDoB5EfhlBs33I3cjnxdLInMGdBa4ff+W6dm1v?=
 =?us-ascii?Q?B2IpbrCa6lkGrV9zzcPm/quRonj7AurnecLikPZXBx6IPwuPsmZXli6z/l9w?=
 =?us-ascii?Q?j+GURPvPtmpc6x29YJyDWYlcScoFuJoEkbXVIRTvsjd1DA0eFMAkuMKDlDtg?=
 =?us-ascii?Q?MGPryFOA7agjLwyi0qLTEE0xcsJ++m8dDlrIa9sw39g6Mbhoj+Etyu7Pc/DH?=
 =?us-ascii?Q?aw/qbe1iaXGMT+Uo2ogTHSqTsTsFzMAjJ4lJttB4Et4MNI/PLGabySLfg9J5?=
 =?us-ascii?Q?NpLCKa1/NipnAvqYSvlxHmu226qYf4rvn0wxopMM?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c7b2431a-70e3-4d1f-018d-08da86747162
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 08:33:10.5735
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qSjiKSfxbAkr8dKyLQa5v8S4wd0Zph99VkCWXQATncI9+cMUkAjFkIm05uhuheBiFH5CULSMfeDlZHjfg9X2tw==
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

Changes for v2:
 - the wait timeout value of the RCS is 10ms, so use the sleep_us of
   readl_poll_timeout in imx7ulp_wdt_wait_rcs to avoid a 10ms hot wait

 drivers/watchdog/imx7ulp_wdt.c | 163 ++++++++++++++++++++++++++-------
 1 file changed, 129 insertions(+), 34 deletions(-)

diff --git a/drivers/watchdog/imx7ulp_wdt.c b/drivers/watchdog/imx7ulp_wdt.c
index 12715c248688..0cafa86fff7f 100644
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
+	    readl_poll_timeout(wdt->base + WDOG_CS, val, val & WDOG_CS_RCS, 100,
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

