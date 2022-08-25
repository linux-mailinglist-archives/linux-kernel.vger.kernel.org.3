Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AF25A0B8B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 10:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236828AbiHYIcz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 04:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234992AbiHYIcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 04:32:52 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2E45A5C5B;
        Thu, 25 Aug 2022 01:32:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBFIBcQnw5i93inwyHBQ5bNCVBk6dHincKhnsWqHDXriTBU0+YwowXFAqVIt8mE16/ybndWYvprXq8WcaG/sTRHsn5bKoI1JcuxBHkTxV73ItYitw+WBodZUDXmLee7JVOj3onbvB2I8RM15Z4J4wnJT/fbnQb3lcGFaSVS4eHN1n7O3L+fd3e/I8286kXm2jaS1OdgxyodO9yuzSifek/196fzo6+wfM6TrwfoKDkMKscEN6DHd0t2PDo+xYwKuNpP31ZC23Z9zNwaB18EZwZkJuogQH+9dZZMUoXRUa8CFT22PmMJUUT1swgVmjSq/KzeVUC1YWBt84WLJr2Ezfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=akDfNw95eqR6I7DNNZM4xG36aZqW3v9+dobNicjVgrY=;
 b=KkUjBepvq6mCEI9Pp6rBnvWHqITzQtAdR0fHfOJhfAXMFhZNCwf3Bk+JMOyH35z7xqEDJttgcobjRH5nNghQyT9MU3tUv2s7MAJXju30IYdssqH2xEBUxBhmBRdJZrLM+s/Cyug9VhOwy9Un/kMOf5R3WDOMuq60sdraDDiPUTL4nEWrIHviZ5aOB+J4sRoswr4Vx5gpJGk0WR259/mGG2TBgl4vyolR+3Cr2rK4Zut8RQjDs58W4J2aJeXR9ZbypSdjQYBYBeuUJXTehxnrAgA+sRDATKkZtPRAnU1WZWRa4iHAkYGcEogdVaHcZjiRPrPHf7etXQTtMvVfTCZbJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=akDfNw95eqR6I7DNNZM4xG36aZqW3v9+dobNicjVgrY=;
 b=brWQ0AAUA5KglOIkgMNFoZEavCbPz29CWaVDGoF3FXGyDCyf07CyZKs8X5DYVmeZgf6I9nJ48g4OBcKa35AFLIhzBzdBKmfUFK7dwU9zc78rADFmB4zBIS7ojnUT0ajROhuwA3Gni3RbGwcL3AjUtnmYmIVJvHvSrT8u9zot0g4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com (2603:10a6:20b:b9::10)
 by AM6PR04MB4901.eurprd04.prod.outlook.com (2603:10a6:20b:1::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.15; Thu, 25 Aug
 2022 08:32:47 +0000
Received: from AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c]) by AM6PR04MB6053.eurprd04.prod.outlook.com
 ([fe80::6cd5:f11c:4e5c:d79c%3]) with mapi id 15.20.5566.015; Thu, 25 Aug 2022
 08:32:46 +0000
From:   "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
To:     m.felsch@pengutronix.de, linux@roeck-us.net,
        wim@linux-watchdog.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] watchdog: imx7ulp: Move suspend/resume to noirq phase
Date:   Thu, 25 Aug 2022 16:32:50 +0800
Message-Id: <20220825083256.14565-2-alice.guo@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 73514314-bcec-4f8f-c402-08da8674634f
X-MS-TrafficTypeDiagnostic: AM6PR04MB4901:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5o8J4sxZ85P8ZX0u818vmdlQaP3hnW7gmeRj7bX/gFGYifDd6o1FfCpVPWhcR1ZkvBC58GpmqW+2UAwQrL3Nxq+AQkTs4ywkiadaD7xbgjxCZFZZnwmBTzKfPdZQivXFnX7qqz0WDYQdzC8QDhHMDArFkK8ZMtyQkrxxqYJmZ/aYcvWQmlht17OqHWp5NM9qgYNEyB3hWj/wEQndwDpUVr0XtHRR5WJ8vSH+JtsGiyL35siO585fKb4teUMJEARkVCBS8CyIw38Ma6mrKgboxf2EQHvhYNSc78upJWalE7baGhlW/mRs2/YFo98Mr7GchXWE/Kia/wFOrHcKMMyRvCR4OFhkXqeXuYaImJj6SZr73PpEdaEsrnZYwMtak9wEPvL6ix9dJo9lHonZicblZsgjB8G+rrRND9XnqER7VNnRTQ0VobzBi+cvn+YsF8PzpE4JKRReqIBpt5OhNQTVlANZBMzYZOEP1Onq+niqakmTxwTOOy4dJRE33Ux31uN8C+nj+JkdcQvCHWxiUwZTvYlcAvtEEE6+1+bzDGS6afxyLWDbDSkcvsbfAQGpxn9ojv262z1PCcRj+YPP4Ju5EHcyN3Fj4DpPOWpSUTQxlk8IXU0zFFxHFWDBpYujweeguASWD34jHe+03NYwRSi1o0W8fpnaijz4ng1SwCpUUIYCJK73C2XJEZO4UEPPL3WafK01X7wFhU3r/DfUN7ZKBY3OTu5BPpcCF99axKF4ds5vbtbWItOwBZdkxKELJ+SVC2IBVvk5GUvvpeLy05Fdxg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB6053.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(136003)(346002)(39860400002)(396003)(8936002)(5660300002)(7416002)(38100700002)(38350700002)(4326008)(66946007)(66556008)(66476007)(478600001)(8676002)(6486002)(15650500001)(6666004)(41300700001)(316002)(2616005)(186003)(1076003)(26005)(6512007)(83380400001)(2906002)(52116002)(6506007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vi9Z9aBGi4H5VqHYYP6lESGTsjfUcGRbdh90iwQlod1Fwoq+vXlE68wgYoHr?=
 =?us-ascii?Q?jy0oNoXE6L1BwpMaTUqXjHope6v3+9husWQt6BdZ5PQOqvRV0wbhosWSgVtG?=
 =?us-ascii?Q?VTmG5AhkuYzewkn9GBAHHp5llTFb0ZOz7VAHbG04ituojKieMkIV8wla09zT?=
 =?us-ascii?Q?SflylcKxpj5g5FZW7Lmh8GNndyWxxfEj9+IeUHqTa8BF9BPLDnABr3wt9Bkt?=
 =?us-ascii?Q?m5sWRUsXKzzEXef8h4ud3wjnfF4IeyCnZLzvLPU5VaCTs3Y3QhoPcjfrWhFO?=
 =?us-ascii?Q?DMUqeb1ASPLKlXDumxRUBOxP3+kgDkvCWpyg883Qva+h2TErNzBHvZnpFqKe?=
 =?us-ascii?Q?jRmQGuiL6vaSECbBn87j53mtcaLzxkdirJTe9FksGeX/HHSDMinsVUViV4D/?=
 =?us-ascii?Q?iTRF0JYOXh5z2C5j0Zcub0lzsiRSqJccmMv2oYeiDXZkO0tsarZbmYy3dIjz?=
 =?us-ascii?Q?rI9+ZhNQm3f2Lg9eQWAbPuCRbjkDzdpt88Dp2ofSKGZ1+l/v9/5cRQauAPXN?=
 =?us-ascii?Q?DeF/UDQbSlFxNOWAz9GI0rRR73ZHYp44M3EHobme6KFhjw5WW9v0UAIygjSn?=
 =?us-ascii?Q?sTS01buBG8nHREVjnJ/aqUSoa5fSlMBBktYKGCrY/jLj5MgSKN7W4o4rV9F3?=
 =?us-ascii?Q?W4KgqJZdhgAG2yZtxGO3aFNIqrK4K659eCx2II3RjCbtWE2sAARx5nVAnflv?=
 =?us-ascii?Q?+pzeXR/DCSRpt0tFrF/0004TEjTVZ8CN9LEly8ADU5ZhxezQt+5GK9jyHndM?=
 =?us-ascii?Q?cluxUSCSOIGwkxkR9BcHqojm8qKQpd+jYEg+0bLoOsUHvBySOHMQHP8fyBbt?=
 =?us-ascii?Q?0ExTe9LmqoYebVwMCOLDgf+dldkSj9wjO64adBgPKaGUsYEgF5X8uKVA9par?=
 =?us-ascii?Q?IDGiBe/yF6+0G/ncsrfruCEQ7xPZcCQUi/11gxkX6zPsw5yswp0UwtjTjlND?=
 =?us-ascii?Q?9cB3+yniyTsOp/FfARfhvs9y6pqq++4WCI5yrTFeP/Dn1PwkP+G5hwcoM0RB?=
 =?us-ascii?Q?GFxwIOXGoPYGjHdrIJAUzECSEWPzXP29qFza7U2fHaNZseqnsmSwOXJmFZdS?=
 =?us-ascii?Q?FHCUTxAMlQox2nwcMNiyrETZOM7WEPk6KkDpKtoI/gQvF32vw6qbMMxyaT94?=
 =?us-ascii?Q?jRP/NM5ln5xcqAR0DUb0BEiLRmtSUBuXCRoFOZApP4mmE2DVPQ+sqR45SjJr?=
 =?us-ascii?Q?8GM24G3L4FjP668LCeReuzRO3u0AmEB0QkL650vREFI6Qg0itWwsS/L6U9Or?=
 =?us-ascii?Q?d1ln5Wqug50qvyJ+mBNw1L1+KnPqWXCRwUsGfhTl24SBjaofyPmDNtYkeOAk?=
 =?us-ascii?Q?OYjbrMxUpbkmpn42zCvSf9OPIhQmWsGClKBZJOXCmrhBu9UUk6aSoScZEz8Y?=
 =?us-ascii?Q?U7JCq9h8tO/CCRRwA5YAIevbK9wyuv1nNIP7+YuOEYUEuyXTnsDbI4VvV96j?=
 =?us-ascii?Q?IVp6wpSaJQM83V4yPs5K9svwhXIsPn5T4aB05qg6icb0jaNwsDHAHB7F7SAI?=
 =?us-ascii?Q?ZRxTsTuxyaBKOAhWQzeSKrn54wnqmJJQh99+b/ikgenevGeXOPqZZ4hLZx87?=
 =?us-ascii?Q?jrBd+20LntPyD2roo+6/9XkYAt2tzrUHrzlHfC50?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73514314-bcec-4f8f-c402-08da8674634f
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB6053.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2022 08:32:46.8721
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UChGg1OrstGaTE6N/clgO13xWFLg0BbXIi7X+KlHW0X6KyXwbfzKYMgdhhwbTyFHiZnPaPj4u5gSJNo1QrgdFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4901
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

Changes for v2:
 - none

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

