Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1EB544C84
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 14:49:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243769AbiFIMtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 08:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243764AbiFIMte (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 08:49:34 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30055.outbound.protection.outlook.com [40.107.3.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66CFE344E4;
        Thu,  9 Jun 2022 05:49:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rm/YYN1uktpEwq4Moem7tKiWXhayUlfghxiBW1HBkWAcyHDIZmmQPivk5LN6cO6Y33ZsYGcRF4/WHB2T3SEnt7uvCO8WKKTlbtd1o18SnzOxAFnf8YYJHjBfCFbo9kYmEaxBDB96vqJ8VZkiydne1ON2hXXzDAVdT9BHFo4pw/u7RRsq3Qp3Ikl8BR0hzhjG1YVjrEreV7iVHb3178Y6k3r665ovo/aWUa9N9nxvUjqAn/Thad8QWPzrhvdfqr8XNIMcmFsOUW2yLpyJaUgKe74ac1u9wp+Bvcol9BmYpgl/YYuUkm+7uR+oRGlui5UZfkncZwDAWLbQN3FU/vqoEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nvyBBWq/TULyYaW+qtbnBmvmh9ed2b54mEXSIqHerqY=;
 b=Mb2y9lMRD8BTqOwKUfaANs+s+O6G3J1tLnnNxzo/thqYacrdhHI7QRtj6raAjCjCL7BlHW28Ja7DHs628aCKpJovaVQUixNCHBgmSg+1I1F9G8eSSe30PXSSiLdZ2XaFrtw03oG3NaSIzmZnlu5xCmwTKGv7K5R2LP7poATJHe6pxsugjfiDgKfBFZBYMMiwZezJgBtTwOaJThScGAHk5uLQbR+Dwf/fxbjWyamc4rgV5Ig9wrim14wsqV/1cgbEM2aiUsXVSbxn8Bd03qdGAK1fmVRsILC15/y+QQ1RvfFET3z94PoScmE19/uwOKISQ87fOtimFmhFT3ES7R/jzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nvyBBWq/TULyYaW+qtbnBmvmh9ed2b54mEXSIqHerqY=;
 b=dZtReCKj2XF/HO1qvQFHFZkbFh3jIUxQh/MyV/lXrGOUUUYviPdBBJSaACn4ErzRX4PPosAogsoI6KDLC4jc97E8OZx52CxVB7LTRgh1QZIDpSj3JOXs4AnghRFp7Mne4st4Lv+abc/l5Dv9LciDg732xmnd8kYXZmZ9qvsc4qo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM7PR04MB6952.eurprd04.prod.outlook.com (2603:10a6:20b:107::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.13; Thu, 9 Jun
 2022 12:49:30 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%8]) with mapi id 15.20.5332.012; Thu, 9 Jun 2022
 12:49:30 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de
Cc:     aisheng.dong@nxp.com, l.stach@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 3/7] clk: export of_clk_bulk_get_all
Date:   Thu,  9 Jun 2022 20:50:56 +0800
Message-Id: <20220609125100.3496633-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220609125100.3496633-1-peng.fan@oss.nxp.com>
References: <20220609125100.3496633-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR06CA0014.apcprd06.prod.outlook.com
 (2603:1096:4:186::11) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fc1441ec-1569-42ac-7f65-08da4a167ea0
X-MS-TrafficTypeDiagnostic: AM7PR04MB6952:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM7PR04MB695212BCF93B22ED47329FCBC9A79@AM7PR04MB6952.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: aCtJm9c7P2CMt4d+BCzRtF6N3HPbcBnavVQw17AAoYbxJySpPuQRxWO4FunhTu7+tX2y6kPv0XNB5KQ/MF/7njdYnrJ8qAIjiGdcyNaqmJUmn3EoEPiMjpnQePxWFJvAZMNfl49sjrTvoWfdro7qmIx1YVmoLTObb79y3I6ePhayrtal+ormuxQp7xJkLi4pBpY22HRImTZqaHHWLrxyQ8hTWT6UP2OA7w2hGbWMP4Djvaj2XjOHZfyEhvTxWeshCENexoH6l7vXWPMTYQY/pnm1N49aoJdvLusuEkxqr4divhoDP0uMqV+bxRoUewreD2d4rAXAsUqy2kyJelPdxMDmdDrv/g83yNrC5/ELK+7WlUmD30eqBuhgO+rEO7acodvj95Rjd3oL008NQO4Cfzmo2Q71nHHLt2NrQdsXqnNX0XB9r9cfyKRTVcPjGNFaT/A3UcIPK6nSLY3p0YXS0lnBq+4C9GwxxnFJDr/JFoinW+rZYQN3/JjZrOEC5o8rvJipv8/m1sOg8qbnZuu6YHjvQXXXmTMKz/ixfDJ2YM+mPt1ABM0cF5xxL3DIUqtN1BgtMW5bvEzCrWErl+6jSbFpepZ3B4JmqD9GeG7qyvyNhftegDORV5QhZj4YcAL2UgYyUDi5MgCjNiBT78dBjhk+SR+XB/hT2x6r8KZ/QJWmDQSxDaCAXcAgn6BAKzFobqdm8k/MU5rOtyGVIl5YGQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(6512007)(66556008)(8676002)(2906002)(4326008)(66476007)(26005)(6666004)(6506007)(38100700002)(52116002)(38350700002)(86362001)(316002)(8936002)(2616005)(508600001)(7416002)(1076003)(83380400001)(6486002)(186003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sg2paQOGMvk4lYC8upfmHyvJ5KTNpw27bS94ZMncAU/hXvhRBW/W1PlHcVhU?=
 =?us-ascii?Q?jPoJbnHs8QtEBRxjfSQqBbvkZWGdE/27oD3tkcnbwoqlSgHdxVzPFPToYkjC?=
 =?us-ascii?Q?5cX4LQe+NSBcWB9eqXOGtzi2dBU6wevyQsmDuni25lTf4zflwAa6RfJschLc?=
 =?us-ascii?Q?JKr8NV3VkMbPvgyTZOB/86/9O4i8/ooP0VM/knhNNLzfi2pS4K7J4eMac7en?=
 =?us-ascii?Q?ZCdCTjzkZe89nsUQjPHJTFkfWpykra9jidWLDs1aGs3hiu9HVh5p8BVmbVVr?=
 =?us-ascii?Q?HQdIDqlT7xjZ2mQe4D6ZQ1W8pysdVALhKEok8RAd/W7tNOOI/62NqlIvWYbC?=
 =?us-ascii?Q?TQFVteUN2KGe8SKx9tjsW03JcYwcbVB3TOPopUOtk8jrUWUodjhw4OQSDsuS?=
 =?us-ascii?Q?tbIsBdGd+LtXAn1FDiu6Ay0OgsBp3pjLZgBmh/DJv7/dfNXbrsKipJ0rk+Db?=
 =?us-ascii?Q?56bNzT7VioMvvboGg/6VA/6xQ5ig+5rVniJLKFS8eARTR5Wj61nBL9w8pj7B?=
 =?us-ascii?Q?yv2ys1t244RizE1xPYOdaiulELYS6uDiI5WMAgrntSPwHqjloIeGXSsjsc3q?=
 =?us-ascii?Q?CDJRNnPo9tZCiUnz8yPDto5MiW4xYAClNES5hrv2cd/Qqe9avMdkKaazHqm9?=
 =?us-ascii?Q?m/4/N0SAydK+7K5EJS0cQDzRBee0m9EszN5MiIp+4vy73LdKgnGtiNZJPael?=
 =?us-ascii?Q?DeQisLdKnBLdue1zJMiT4oPXXViOzF2O9DVeIsdlpzb5+gINtbgYyfzht8CU?=
 =?us-ascii?Q?jmSkoNDngj23z8sEFSbfq677LjXFP5NG06V/U0lG4Z0ZNtRLGpNq/+pldY5E?=
 =?us-ascii?Q?FG2C9i1mkSq4OKgt1ZydTfr2ASBVJ9JjKqJpki+/Yd1nUqeX/CQMJlCLGrgU?=
 =?us-ascii?Q?ibiOLf2GV11zagXF35sNiz+W7OgNZxju4OagXDJ8V2J5QPA9G2jW6c9ypWtN?=
 =?us-ascii?Q?Pssn0pERJhaxBbucFjYdWNob2pfdDS+BeTCWq8DLs2CSDSYs8efLR7wIKaIV?=
 =?us-ascii?Q?dc6vyvUUlXo2bKae8jBYLxIFsnDyOa981/rvljaWEUP+0qaFEHUZ2lsJAFsW?=
 =?us-ascii?Q?QMNHa4b4z9cbMOHEl+9GBYw9HwMY2ZxBABptR0K25708wbsBNv63nxReFMwj?=
 =?us-ascii?Q?GRi9PXD7f80QlBBeWHhGnpXGtpspfrYd88FAE/PA8+9FG06tbHjzJW1D0QUJ?=
 =?us-ascii?Q?LOfNAlU3PCst9AG85A/+4mCStBt2Vk6OtL/Nim2OKSu0X9HqxoAPUgbHV6jZ?=
 =?us-ascii?Q?UQqTSsvLBjZqSJb1PZXLNEdyzl2Y3lq52WOIHlTHzUJPVTm9Ngo0WYs1qkOW?=
 =?us-ascii?Q?2iwTYuMe4BDRdrqovHt/Sb27bxgIP9ldrww9OqeSEQHiQg9Wx6Tt8qZlseNy?=
 =?us-ascii?Q?rQL0cV51EsI4MWPDwa+ZokUr2PtFbOy1CBwhxaYjTDhku225tgcVjU5wxm4F?=
 =?us-ascii?Q?80INk/JrryFaTDwHu+6sKL4DSryUuhKxu361ateakwALld849fhybkcr485N?=
 =?us-ascii?Q?DPc/6BxYZVM/zBioiITnJYxfnavAJhQJktzbDEcNiOXfWK2s9lShQVCm9KZ9?=
 =?us-ascii?Q?jqHLhEptNM/n8wGv2fN5mgbbaPTRnHqjuGLUqeyr76IDofx5DPwVCjRD5+EN?=
 =?us-ascii?Q?5fwNMa/4tC0+3Sj9QvGWjJEpjWwF54A35uBbDcATqkHcwp6ktqliuWoLRHob?=
 =?us-ascii?Q?PTdU56PHo56rxdTgfcCM6J3zGApVyx23890Ij+3/hTn7tjj0uXv0ueVBAg3i?=
 =?us-ascii?Q?wVHdawhgUg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc1441ec-1569-42ac-7f65-08da4a167ea0
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 12:49:30.3342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KSQGI4M129GSoBBLMmcpPJBZ0mRNscrtLzmsCltHicISFmsOLIIinx++JLsBLdYQYkYAgJT7eiwhzSAkOyKdcQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6952
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Export of_clk_bulk_get_all, so drivers could use this API.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/clk-bulk.c | 3 ++-
 include/linux/clk.h    | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk-bulk.c b/drivers/clk/clk-bulk.c
index e9e16425c739..470155856b02 100644
--- a/drivers/clk/clk-bulk.c
+++ b/drivers/clk/clk-bulk.c
@@ -43,7 +43,7 @@ static int __must_check of_clk_bulk_get(struct device_node *np, int num_clks,
 	return ret;
 }
 
-static int __must_check of_clk_bulk_get_all(struct device_node *np,
+int __must_check of_clk_bulk_get_all(struct device_node *np,
 					    struct clk_bulk_data **clks)
 {
 	struct clk_bulk_data *clk_bulk;
@@ -68,6 +68,7 @@ static int __must_check of_clk_bulk_get_all(struct device_node *np,
 
 	return num_clks;
 }
+EXPORT_SYMBOL_GPL(of_clk_bulk_get_all);
 
 void clk_bulk_put(int num_clks, struct clk_bulk_data *clks)
 {
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 39faa54efe88..ca74f4e83d25 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -372,6 +372,8 @@ int __must_check clk_bulk_get(struct device *dev, int num_clks,
 int __must_check clk_bulk_get_all(struct device *dev,
 				  struct clk_bulk_data **clks);
 
+int __must_check of_clk_bulk_get_all(struct device_node *np,
+				     struct clk_bulk_data **clks);
 /**
  * clk_bulk_get_optional - lookup and obtain a number of references to clock producer
  * @dev: device for clock "consumer"
-- 
2.25.1

