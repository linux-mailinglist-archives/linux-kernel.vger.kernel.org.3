Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B9E7595CB5
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 15:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234282AbiHPNDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 09:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235388AbiHPNDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 09:03:25 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00065.outbound.protection.outlook.com [40.107.0.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A47FB6012;
        Tue, 16 Aug 2022 06:01:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cN/gUOFMmldMuLaBlQm4hNMzfmDgV7FeYrLM9j0BJCdo/PAOibfRx3o1srHvr63rXGJvOmy7vXBo2fqKywNbv4fZcvo1swLP2YFrbrGHEuY0djd0cJIUdBEuVooD4mCxfvoO6pXW08C8O3gWwT9s+bpQ97+Ah6YII7cd3Y01UFjqN+nhuotfYycirGOhU0dPuS3IQUf31OYYos8jqVpg7qNNvH0pUKQZ7wvSnHrz65hHSS606NZsvGnt3i4tsODhD+QXQn+6sE5vYP5rsYeHr9AGhuPM4m4J9HxKecqBQLWqzWINsuTmL3zs9ZjI7Ub97senNGZKQizitpm1OVOnYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ATTftqaQMifXvi3UoDXMF0R+Q23Je2dXrI9VD2p60iI=;
 b=UCikbZ2DSZ+QWteM0PPcilxjhbi0ChRWdUXFFuV8orHV0ftry+LajDrApAH8QZC+65kO1Kpt+QKu4Kagtiip7GZ5iq6qt74CW0XswEX5+QsPT8Nzi0aFTWj6UTN4exlLgYah0phTuVYKGAkZan8TeOd3xeQD/rBdQpk45KZgTOD0bZkZIilHtIz1g3IpFTRdyq8QLgNNBqacpfEPiELp38V53VRbmzpySjKJQ8jlY+TThsEz41HuaOztbLwyDUEtwQLqSYC6e5D+LR2iKCm5cC0K0IGpjtEXnZTKVLwIidIhpB6KqftfZ/yoV3T7GclZdMptLQ0+ra3O05p4H0rVuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ATTftqaQMifXvi3UoDXMF0R+Q23Je2dXrI9VD2p60iI=;
 b=av5aAuX4Jy4lALc3+A6UYGUvC+hdRUEfr0n7TZHCGhpTp2hRx2O/palZMFuB3V1ScQ1cL8yWfYX0Yl1kFHufPS/3hOkSBtfzwRWSRcmStMKD/46G+HDXIiqjILF2E+KJfLouJX5dUn03sfrzFWB+qnCTBoSJDYTXbT2TcbYnD8I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR0402MB3869.eurprd04.prod.outlook.com (2603:10a6:803:1f::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.28; Tue, 16 Aug
 2022 13:01:50 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5525.011; Tue, 16 Aug 2022
 13:01:50 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] clk: imx: support protected-clocks
Date:   Tue, 16 Aug 2022 21:03:27 +0800
Message-Id: <20220816130327.2987710-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:3:18::31) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 60f171d4-524c-4b64-07f6-08da7f877bb8
X-MS-TrafficTypeDiagnostic: VI1PR0402MB3869:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kL8nKesiwAhaKror9Q9WrjOdHmUtGgL7U3atbSYL9cCmwroRBFi3FRPcdYWzsG+YDbM6fn1ZWTKATWX8Jk7uKgnUmnpwFdwOXFZcqCueFuke+agrE+Fz8+0jTVd2TQpRpIn2aAEiwtcXcB1aOmiupOtEL4JLjL+4nGS1MTCbjSzuofw0hun0akYlB0xkrhI260/LyBw3voK0kXhYOI++mkXHBmAUzj/c4iTi9f+9Z8d6nKP/brEfwesGpJ5xCG0Qvd/hn4iDb3Qh6Pn7yl+B+SlieglCW/6/tWFk2JdyaMHFbja047tKJCFWD/+1yqtN8PWdauq9cvBATuRb+lRgm0i65EYcPq++k8t02iyiwO3gaxieQYPuMimacRK2gilEHhoO6aBuVRLq11+1xRapxFwkwHONOUatVoS5mR4gQX+rny0k8pG5eSsigxbfDzSTzesQbRRGtDLu09/X18UO7O5Kd5Td34H9L+huLKTxEb3JvclrX1H29M799QZkiOX1kqTfpT1Ff4SfXCanL0+N68OqIrmcndoT+64rHbpXwfHwGmieDJKx8W96dTSOtHzQeftkRqAxXVB9bwLNyT3EpECKL0AEZ3lwfDDbmahgys85rof7kfrZ4uD1cNwEa+tNo2GgbpHyiy1ewPjZHpgWS8FF+Ja9zBv9dnEj9fSSnRNAFwuzdtcm+YoGaA9O4GJmmWutGCNXLHkWDS0XwuZoxeWRdPimqziAoSlhU2bozGQ6EoAXhXZT+CfSTYvljGVjliohbxEASG/vc0xKKdCdOKdWX4i3F/cupxTGE01EWuVG/SuMU84rn9syieklIY6V
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(26005)(6512007)(52116002)(6506007)(6666004)(41300700001)(2906002)(1076003)(316002)(186003)(83380400001)(2616005)(7416002)(5660300002)(8936002)(38350700002)(478600001)(86362001)(38100700002)(8676002)(4326008)(6486002)(66946007)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cFc/O5DdHVaJjTbYNJrY4ufh8BLpVloQoQhLeVTkTKVr95UfQCPon1Tv2Pxq?=
 =?us-ascii?Q?5LGsG3ykUeFf1ouUjad6ZR/LKmqLurUhsjq6rg550xNJ2G/Rz5Hv7guRKedE?=
 =?us-ascii?Q?RTLM2eVJ2e3DBx1qHVjg4CLSEnYMD41URN7xiqgYHqzulutrTmhBBrIyQ2Gy?=
 =?us-ascii?Q?oW2gnVrRlPutjwT1kNvPR52apjVVv+sEhXU1cRwtvpAaS9Z6SAo+gA9ASqQF?=
 =?us-ascii?Q?Ff1tws1zUqH6lSAM9lCwHC0ZIQ6YfUSZQXDFFI7SX00F7mrqlMhNLqKWjs+U?=
 =?us-ascii?Q?7s+FYri7Dkdxdk4U2v0J5FCyCqrLlr2BZ+TeGsuZ/9wHyZbBbxvnxYNatncX?=
 =?us-ascii?Q?nerTuwx/5WndKJq1ecwBR7KCO0VThUdQ9fYos5Oe0v3HrLH/KLV5honwJ+Pz?=
 =?us-ascii?Q?jP9EAT8l+ixO0JtD2VaAXwRD3opbyOX486j/WIciekdhH3cW6BbC42AalOnt?=
 =?us-ascii?Q?lsbM+jIlHaXLiXcLtZKzPdugPdaQF2rEB9/ceNXk5qgAD5bqC34ULaATd7c1?=
 =?us-ascii?Q?I5CjydZpyvPJDjhn+kGJxXcRJEBR6kaCUVi7BA6oO6fqQ1PPPomibc0nQgOo?=
 =?us-ascii?Q?G/ccPRTjwilvKjeLBTZlteQu/oND6MEgajJQ8NZa7khxt+GDcKmjeZj05/+R?=
 =?us-ascii?Q?UbF+yz0RjWsJIB7yySc37GG8qD72MD7vxGGGMFoh60nT9zaTVhAjO6RrGSbZ?=
 =?us-ascii?Q?akT6T2AvTQry5rkpZSvUgIYeSrL6qSnSyx5TfDo2n3J4jklQLLNKkdDNXcFw?=
 =?us-ascii?Q?2upGy+pjCp2jI9PAlrdLHy+4NQfAZwwQzEvCWwtg0dQjWVSBYLcU8to9oKgf?=
 =?us-ascii?Q?H+HZqSfTv+SuwfyRb90PtlfSCWHY4X4V/UCEHY+RvIAMFPbfx7ziXBeWqELw?=
 =?us-ascii?Q?nWMXGoLJbuYAfa++Qu8M4Xu5KdvXnQvZMv+xNb9xAkRcNgiYLACcRWw1LicS?=
 =?us-ascii?Q?vHUu0UOri1L21yZs/rwzfDrrQWX4BYR9/NH5pW59qynBTt/uqsIeeKWpoxPE?=
 =?us-ascii?Q?eJjOawtH15d01jZhov+2c/v0H7NJCoyKykN/sQUs9ZSKp//KPRCrSPJYl/xU?=
 =?us-ascii?Q?idRG5Ai62r5wfFdsQWhBwVAENDKjLYic/6xLzC7w16LfWRF8F+gmNGrtg6rv?=
 =?us-ascii?Q?BsLG6NniRUVvTYj6zoViKxxLXSxco53GQKzsx5zoGiWjhvR5If2dezAMyLtp?=
 =?us-ascii?Q?6UZpxVjlpZsA6oHWUZcyFtfg7pn0ErCsfjcej1LYHT2GsU5GpsYoR+igg5Tj?=
 =?us-ascii?Q?d8JOcd00Xln2UJZzYjU8oYTDpsdTvyU0iixfh8dIhHOFi6gXTLVa8NZjgZ6/?=
 =?us-ascii?Q?MF/BzQw7GXT6wOXqXmyKw52i7px0ZHu1A32iUYsGJUF5X3R6ADMQ+kIHvltI?=
 =?us-ascii?Q?UMZEqTYvaSoBsJFQnOWUQCEnGscyxdUVV7Mrai1ZTobAisYmvhwq9d7Ww5Q6?=
 =?us-ascii?Q?594rxAQBsnW4WfAWvkiVqs0O/4vrJkevVtgkYm8aZj/jW2w65K5zkTs5Zhyk?=
 =?us-ascii?Q?VPYDbcXdMko/owmKIMRwzAs9myU3eYzvADjrIr/6DRqg9DmmgNlaZFjwy0vl?=
 =?us-ascii?Q?FC9oF7vkPHboKOsfJfnZMLy5HKr5rCt00PlvfIK/?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60f171d4-524c-4b64-07f6-08da7f877bb8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2022 13:01:50.0879
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S98UoKp/t2qUL9rg1MwD6e+gSTpnnqoZ0GoK9h28qarujHZl8VfgIgPDm9fhJ472V5g/vung2hNosvGLO/vTsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0402MB3869
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

For the clocks listed in protected-clocks, enable them to avoid
Linux disable them. This will benifit root Linux and inmate cell run
on top of Jailhouse hypervisor, and benifit the other case(
A53 Linux run together with M7 RTOS).

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Per Sascha, use common protected-clocks property.
 Drop patch 1 in V1

 drivers/clk/imx/clk-imx8mm.c |  2 ++
 drivers/clk/imx/clk-imx8mn.c |  2 ++
 drivers/clk/imx/clk-imx8mp.c |  2 ++
 drivers/clk/imx/clk-imx8mq.c |  2 ++
 drivers/clk/imx/clk.c        | 21 +++++++++++++++++++++
 drivers/clk/imx/clk.h        |  2 ++
 6 files changed, 31 insertions(+)

diff --git a/drivers/clk/imx/clk-imx8mm.c b/drivers/clk/imx/clk-imx8mm.c
index b6d275855b36..24ddb1620bce 100644
--- a/drivers/clk/imx/clk-imx8mm.c
+++ b/drivers/clk/imx/clk-imx8mm.c
@@ -611,6 +611,8 @@ static int imx8mm_clocks_probe(struct platform_device *pdev)
 
 	imx_register_uart_clocks(4);
 
+	imx_clk_protect(dev, hws);
+
 	return 0;
 
 unregister_hws:
diff --git a/drivers/clk/imx/clk-imx8mn.c b/drivers/clk/imx/clk-imx8mn.c
index d37c45b676ab..57c486317d28 100644
--- a/drivers/clk/imx/clk-imx8mn.c
+++ b/drivers/clk/imx/clk-imx8mn.c
@@ -604,6 +604,8 @@ static int imx8mn_clocks_probe(struct platform_device *pdev)
 
 	imx_register_uart_clocks(4);
 
+	imx_clk_protect(dev, hws);
+
 	return 0;
 
 unregister_hws:
diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index e89db568f5a8..13015973a696 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -713,6 +713,8 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 
 	imx_register_uart_clocks(4);
 
+	imx_clk_protect(dev, hws);
+
 	return 0;
 }
 
diff --git a/drivers/clk/imx/clk-imx8mq.c b/drivers/clk/imx/clk-imx8mq.c
index 882dcad4817d..2868e2390667 100644
--- a/drivers/clk/imx/clk-imx8mq.c
+++ b/drivers/clk/imx/clk-imx8mq.c
@@ -603,6 +603,8 @@ static int imx8mq_clocks_probe(struct platform_device *pdev)
 
 	imx_register_uart_clocks(4);
 
+	imx_clk_protect(dev, hws);
+
 	return 0;
 
 unregister_hws:
diff --git a/drivers/clk/imx/clk.c b/drivers/clk/imx/clk.c
index 5582f18dd632..bacba1728fab 100644
--- a/drivers/clk/imx/clk.c
+++ b/drivers/clk/imx/clk.c
@@ -2,6 +2,7 @@
 #include <linux/bits.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
@@ -214,4 +215,24 @@ static int __init imx_clk_disable_uart(void)
 late_initcall_sync(imx_clk_disable_uart);
 #endif
 
+int imx_clk_protect(struct device *dev, struct clk_hw * const clks[])
+{
+	struct device_node *np = dev->of_node;
+	struct property *prop;
+	const __be32 *p;
+	u32 i;
+	int ret;
+
+	of_property_for_each_u32(np, "protected-clocks", prop, p, i) {
+		ret = clk_prepare_enable(clks[i]->clk);
+		if (ret) {
+			dev_err(dev, "failed to enable %s\n", clk_hw_get_name(clks[i]));
+			return ret;
+		}
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(imx_clk_protect);
+
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/clk/imx/clk.h b/drivers/clk/imx/clk.h
index 5061a06468df..0b9a236e8da8 100644
--- a/drivers/clk/imx/clk.h
+++ b/drivers/clk/imx/clk.h
@@ -22,6 +22,8 @@ void imx_mmdc_mask_handshake(void __iomem *ccm_base, unsigned int chn);
 void imx_unregister_clocks(struct clk *clks[], unsigned int count);
 void imx_unregister_hw_clocks(struct clk_hw *hws[], unsigned int count);
 
+int imx_clk_protect(struct device *dev, struct clk_hw * const clks[]);
+
 extern void imx_cscmr1_fixup(u32 *val);
 
 enum imx_pllv1_type {
-- 
2.37.1

