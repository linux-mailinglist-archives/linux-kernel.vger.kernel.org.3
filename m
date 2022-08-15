Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63B5D592774
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 03:29:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232122AbiHOB3Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 21:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232766AbiHOB3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 21:29:20 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70040.outbound.protection.outlook.com [40.107.7.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E37012AA5;
        Sun, 14 Aug 2022 18:29:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZBuNZbS5XfMHwdiItC69cJHRYuOsQ4A4xeuimj0lhAo4Zkmxm3P75Y6iv7igFsp3x1e17J373aS0DGtDphlP8EwFYFoKUshNNQwgS0gBQ8+qFV2UeFaAhdkCa7HgSVgKEpE3ih+YVgNHKVIBoJ5WFPTj78iopwh2nXJnC4NeU62ts3ZEEm1Jui8sFpXgOOtglRZtAVbnA8cjG3BUyZmkUaFPHfHHQE4eCCL2lXAd4rCpqUORFrggq51zCoE4AINL3SJFnCxKgSncUotTltJ8lVFjaOFk3y7Egwaz0dc2hdzkIEnhQlEd6Bg8AWE4WXK+9HgX62YZskiN6EhNZcWA9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRSjwNOkdoH08WewzLJlRZtpTSYIRVOCr+azRXIlGPk=;
 b=iaP9VmnImMjI76Gmo5vcFOB5U3xTl2uwWRVkYzocK3J+ZG8ly/pHFHZtcHx4BGutUEt0QjQ4py7V7+ZywWPJNBzlSPYHGhpmGmEtWfxt6SlX/kfudNXmZmUkthlARvQmSQDT3Rs2Q7gGJLsYlM8suWMDLHSFvwCLUMH4hM0ZyxrgEKHO6e5adIzXM1SC0/3fo6PtBniRW+sxFzSOkAasJuVz1E7xcVubtvt0M9er2N5XO2fpQrPAMQKtZP+ss5G3g9goDRKzQXqcDjJzuD+pp6Zo6y5Eq1OICugiIMj0rgljb00cDcWkH0bnPPhBem9Zc1AvdfSXZDffsM0MAxJzRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRSjwNOkdoH08WewzLJlRZtpTSYIRVOCr+azRXIlGPk=;
 b=i/4cH2NyHOTr/VVJXNWGO1ciOFKJJ/HGXQLzG8Vcxim7KeneeLAWIRFvlkfFTxzi0zbt5O+RSNPwAOjd8OYPuDHEWTRP2zp/ZwvuEkcUSxEkgFayUItdEYvGpkyuqZS+biZuTF/H3WSNKeMIJA3ZjG8xRd42zI4YiPkPyINTGD4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR0402MB3734.eurprd04.prod.outlook.com (2603:10a6:209:1b::30) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 15 Aug
 2022 01:29:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 01:29:16 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, abelvesa@kernel.org,
        abel.vesa@linaro.org, mturquette@baylibre.com, sboyd@kernel.org
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, kernel test robot <lkp@intel.com>
Subject: [PATCH V2 2/8] clk: imx93: guard imx93_clk_of_match with CONFIG_OF
Date:   Mon, 15 Aug 2022 09:30:33 +0800
Message-Id: <20220815013039.474970-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220815013039.474970-1-peng.fan@oss.nxp.com>
References: <20220815013039.474970-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0112.apcprd02.prod.outlook.com
 (2603:1096:4:92::28) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40fc3300-5407-4057-206b-08da7e5d9143
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3734:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HEezYY4Dpku0ELh4QeJj2DkvxyShcYpMMwekx/vddIOuZGLvbZYD3BTWB7TGlNOmO09dlr1hgcPttwgqHnHtWx4K5hZkNuHqVTgkMOk0siIZcMCMyqNESYWnTWKeou0Hwt5UkJU95Ljiyp9N2+Z8Ty1XGNZ6FsIGn/xkRzE4Tv68iifHLo2jPisewFjmhhRmX+Lkn9x7uA1ly2x5wxOiZRvsA5eO9Xs+tlmq0/pfsL3wRcehISTw+zabi7xaMWvDEwPwK+sOR/mYrI6GVdpWPwYpmAysAzytacbuCpX7Y6h5URGXX1YzyniDPN7jLopOdKqasGjYONN8KLbcD5XSvXfxbJM1I0caosoEiQUOw99AEByJFPyoXXnUk10/sE9v8tv2m5D9kOg6qnktJ1Fp7HvHpYZLeVtYljjnFYG6JeKqnL7d4hWU1xAYDRv7h7HIZRY2Z0rSYwl+GTEV31qo61IP7rrneFHqmR4Ie92QWmKyx2527xA/71Nw/7pBULdYLJRtn0Oqk+KWA//wvhTVX9rYOXbe1OzdgRSVdiHdZrBbMeNJSSX5yBTW8p+HOQ8Urz22DoDAuBqFIz1+aNumZgRetqcUix4uEVlM69LKvOLdr8k02E/DfXGBF0VHlF54vzhb1GxD1K/YA4SLjsmwXNIohPKjOFPZtMJMJlGmbCBp5XwnLr+GwHD94TrHdOepAplF/agy/nXTsr/bs4VIL8WJPynvmXIeXVqPhLefvHp4Q8UwPrSkiE8TfepsRhDwaY2OovgJZrgSiSsBaup2fN/Zur2yrePc7Ho2UjsQZ/swxLDQRKUcJZ/gxKR8k4Oo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(39860400002)(396003)(346002)(136003)(38350700002)(86362001)(52116002)(186003)(2616005)(26005)(83380400001)(6506007)(6512007)(1076003)(6666004)(6486002)(54906003)(41300700001)(478600001)(316002)(8936002)(5660300002)(7416002)(8676002)(66946007)(38100700002)(66556008)(66476007)(4326008)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vh6vK+k80vewd907cSjqWe/ZROo7N+F02qgJXPQU0ChTRkbYUy2o807jSYdw?=
 =?us-ascii?Q?iCVNsk8jQxIf4sY8xycO+T95Qxp2o0NihGG/Fv1UZSE0ALcLXeyikmzsU7Vz?=
 =?us-ascii?Q?gtHM4K46vOuqEPhOQ4bHm5rho4Lwqi2ePeHMtwKy2LTFQ0fhEwdZEAKTm05A?=
 =?us-ascii?Q?Rvp6vuUPirwzILtB0iNOB7SIgZIpp6va7RzaNnxvG7VKikgAQ1G1frPNZRR9?=
 =?us-ascii?Q?01XhplRIMaub+l8pRNUUbbpsIuMK1VubCc0f/qABrwMqgF0b2hVHu/kb4Euh?=
 =?us-ascii?Q?ZYgve56FMoKypDDiOW6cJe1Y+5dMAZTNMb4tf1zQOfLCQHIlHqQT+BCziXNJ?=
 =?us-ascii?Q?UIKsvZtscS0YEP2gYNAG2QGzcPUtaiNAOptUaKdA9p8fx6wrDdtQpFqpDNrz?=
 =?us-ascii?Q?3/nMQsBUNANxRXSEcVuHOGCFTIC9QAeUJPi57Z4Hprt6prpHsbQSFKtt8npd?=
 =?us-ascii?Q?XDmvSON/ShYNFN1Jsy2aGhkr5f6Z5qWrwbTOfYYTv+9DDTIuv94M3ZAL4T5e?=
 =?us-ascii?Q?jhRsxhbdJz9x+q1CUkdf5GQh+EJsaMCJm4TQtXSnOPyZbzOJnr7cLY8HndkJ?=
 =?us-ascii?Q?o/4OIQFX9XpodeTOpeqiXbTiDMODrKVvRP4Aeb4L++kRrlMMHkM9RjRmw+kR?=
 =?us-ascii?Q?dIDfoWBwrlvJHp+v7r1KO7/BdZqTC92xsl9HRJKbDi2z2R0VWucsyGMM1xlT?=
 =?us-ascii?Q?sb4l643EbIjxM0ak9VxhrHZBr6oAxjmL4Me+lmdJpxYJ/UDtUwTvyNcLBMn/?=
 =?us-ascii?Q?P6zQ5JYwq0NchRSmMap/z0qIagOXoAGTawzkianyXV3hHUSz8azpi5OHM6NU?=
 =?us-ascii?Q?o17BpkprWgFj/gWvQw8IPyJ6wpq7AApODkD5mybfy1wEyFfrZKILeYRTTJqV?=
 =?us-ascii?Q?4TyRoWwzoPpiDmDmOuLiIc8kE0CTYW3fyysA3RCGyOb42WnCjxQwdqwqcBJs?=
 =?us-ascii?Q?+a4OOe/NxfqoXQCTHsiesiJm8RV/CL3ZvwBz8O6NKV7O6q9hO3zYQFt6KFlF?=
 =?us-ascii?Q?UANTYS/wc+DfkSb+gySCMSPjkPqXg/y+B+s+g6hav681t5zq+lHdBxZ7YSZ4?=
 =?us-ascii?Q?VDxYhbdKiGLMNWnqCG+ge9bb6KdxUpHy/+f/XnHvsL/RIrx7uX1BPDwRZDJT?=
 =?us-ascii?Q?wnQi+wWRZu896JxMDvnd1DvopNvd9x1jJS2clIIPqUpl35OHEZA83jS+Fp5c?=
 =?us-ascii?Q?GZzVeC2eOycwXHzhVoj562qHSYxcrScXeBMTJLZW+2ZBWPzNu0aRzvFxAmV5?=
 =?us-ascii?Q?Nm7DbTiIlr5YWbHyEDQp3+lUtFZtSf8qZQhDkjUax/vi+D+C/qv09YgBvV4y?=
 =?us-ascii?Q?sFbDDuCyjmxqTgBvSHfTcDhG2DUYH+Wa1l2vgMPJ9Zn2hb7guEAcEH6xT/JH?=
 =?us-ascii?Q?UfzyymbC/P5UEhiFDlxoa3EYTodlrZafbHgxE+eI6mhZ5OVx+mMQ59OnQajG?=
 =?us-ascii?Q?c+1DcezZnA8DohGj47vKQcr1Ytc99ZKPPkz+/uhhLvvpRpZ7TtlZrgfpYz1e?=
 =?us-ascii?Q?0lf+jZWKX4dpwoRMmksu7boBXgyARbHLOpmEyStJAHQRh0K9BdvMVmVj2kSd?=
 =?us-ascii?Q?Qbpey3gJdKzdnTowOdrDC4utWzyi5nxEyOjK70id?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40fc3300-5407-4057-206b-08da7e5d9143
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 01:29:16.3481
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4i6WXQd1divae9KqCgUDIw5A6KqL+UXwp+rYpgaaSkoRePkQW3zPYo4YvPa82yV8TutxqOkD29k9n4zAYZw/8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3734
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

There is build warning when CONFIG_OF is not selected.
>> drivers/clk/imx/clk-imx93.c:324:34: warning: 'imx93_clk_of_match'
>> defined but not used [-Wunused-const-variable=]
     324 | static const struct of_device_id imx93_clk_of_match[] = {
         |                                  ^~~~~~~~~~~~~~~~~~

Use CONFIG_OF to guard imx93_clk_of_match to avoid build warning.

Fixes: 24defbe194b6 ("clk: imx: add i.MX93 clk")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx93.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clk/imx/clk-imx93.c b/drivers/clk/imx/clk-imx93.c
index f5c9fa40491c..5099048b7916 100644
--- a/drivers/clk/imx/clk-imx93.c
+++ b/drivers/clk/imx/clk-imx93.c
@@ -321,11 +321,13 @@ static int imx93_clocks_probe(struct platform_device *pdev)
 	return ret;
 }
 
+#ifdef CONFIG_OF
 static const struct of_device_id imx93_clk_of_match[] = {
 	{ .compatible = "fsl,imx93-ccm" },
 	{ /* Sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, imx93_clk_of_match);
+#endif
 
 static struct platform_driver imx93_clk_driver = {
 	.probe = imx93_clocks_probe,
-- 
2.37.1

