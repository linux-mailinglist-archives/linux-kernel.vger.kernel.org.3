Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9EB5ADD74
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 04:39:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236575AbiIFCjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 22:39:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbiIFCjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 22:39:16 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70049.outbound.protection.outlook.com [40.107.7.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC6C642CB;
        Mon,  5 Sep 2022 19:39:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBVkL33pxW50kegpV0W9RxA/Edd8/JsbeP/WrAapYxvKxu+gcUIUdEgHhbIClzrCeY2gBB5B0EdNkMx/dVooflZISjbGRrX9LpjgKtBpdYS5wTkjRN2bXX9lRIPXygVXdQ/+AzzOoJ84MqwnjqCtksFWA3G7Xq1fgaDGuzDb5iMpZjW86qJVvR8k3+sYjbnqiVNcIoLRZdGUFjvLlrSKPXaAdBlX60CZy/EP/gE6TDgx7OCTBWCvaFouGpUaxzntFa3KTcD1TtqAkM1ggAne89kk/zls4deNyfJVtjUyKFhbOv2htIQHZtRjE5F6KjHTLwUj9sBFEjzPtW/xRW039A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K+Zcbk8+o6X3W+PDqKMww5Lj8roKSdzHxaPQmM3Hktg=;
 b=JZh+l/Xh12r3Iowb7oCb6/M5aB4c4Uq/E+XhPBO95gI1Q1tGtt2yOvNhpe/XI9DQpYlHVr3x4vLBfCD2RUpombwn38YTPPeGGcELDgPgRRYkClDRGCMkgNtPaq9BzQM7BAsd03+h/aYTnYs5ZHM7tbEHKw5o0ekLHaQaDjekrLrtN6RA+Dwavo4iorfdx88XUP6nl+wiJ2kKd9y8OCpCm6QKaG4iFUzNxBtjYIsp1c+PKomPM6pT2wQhnbumQtV7BRmj5lKlAxFD+zIeKnjO0vHbU2613nROLHprh5n5E69bUcINmpfQph/nKIbxfVMdoLDL+3hwSEDIIb47sTyI2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K+Zcbk8+o6X3W+PDqKMww5Lj8roKSdzHxaPQmM3Hktg=;
 b=bTrqFz9iJFIHybz3CJucV8z6dXqVXAyyeTwTBkdcSpAV+vKtiZhX624ZvQmo19W9cgppcnfO2TIjim+JJwulRkHwHXXTK2aJh/TpuNxXWkfBGdQMnOj1o2nxnbEpo8Iz0p8y7tW/+LwlwEqRH2G8gLrd1o6Bl22NwFL7h0RPCxg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR04MB5185.eurprd04.prod.outlook.com (2603:10a6:208:bf::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Tue, 6 Sep
 2022 02:39:11 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.017; Tue, 6 Sep 2022
 02:39:11 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] clk: imx: clk-gate-93: fix build error with x86_64 allmodconfig
Date:   Tue,  6 Sep 2022 10:40:47 +0800
Message-Id: <20220906024047.1840977-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::16) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fdd6cc7c-5875-4924-9613-08da8fb0fad1
X-MS-TrafficTypeDiagnostic: AM0PR04MB5185:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2YYP2uTrFc4BIhr9aZy79UYkFbgKfoutIQ3W37Pd7eTmLdUz/jQwoINDA4shsxJF66QkVDZ3N49UMBSM+lXmnBKr/kJ9M2L7q6svUmzshcPkQm4xSEffnnobVTH23Ifh+01sX4xXlYjOUB26UXhTj3c+1cwOyhSFkLvPCCQx+jmNtsoOZMbT0vw3a1z9DMGyedWAMTuP1YtQxQY3D6fEQDwJyKf1okV9i0Kjh72x+RlC7dYtHbx5Hi0AUjnLV1dDtenkkb5l6O6Br5zSmoXO28ZAt1QTVZ2mNZUPNimz/wwtzLA3MENDLUp/zywQROMKlLWy7yA0KBddRWna+aVMg42J8NXoPEMW9caiDb7FaIHc74ynR+CH5vMcb0jiaINBxXTUAe4KGSmd8c5rtVKatf/zc3nASzPRMEfKxWTa04I0R7eMoYjC20lI/9czrmCRKOc+gZ7q7fI0716DKTt4tHcw4Z8OgcQWTWpig0D2MB/IJJPhkxHG7kVNhK94hRPogxQpTNWSsEU0y8WM+eNRYxYAjVb4PBw0O7yBWdGN4vMQfAFxlcMhCWhbnBt6nXlew8vkmmSszjU/OyQu6v3UqUYUmxbTpIkFAuJkIh+TGcEVUEKtURgn6IuPuI8EasEU8E6Kmld0oaVCcMH+2qphPWG5QK1xuJDjyYhAkVp4krEbfjcyjDGYf3H5p/KLxy//f8cFZK4i6uZhxWaG3EMyZ2au2wyTv3SpiFFkre5JAPcdAAvT15vTP89yUfrweJbaTcH5w47ttgc3JUb5DoqHIQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(346002)(366004)(136003)(376002)(39860400002)(2906002)(316002)(186003)(1076003)(5660300002)(8936002)(66556008)(66946007)(8676002)(4326008)(66476007)(7416002)(86362001)(6486002)(41300700001)(52116002)(6666004)(478600001)(6512007)(6506007)(26005)(38350700002)(38100700002)(83380400001)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fieT0GIbYIrp4bLNMnTaEbQfk/ccO8u8F84oqP2moTPjLcvPhPyYMX3auhXN?=
 =?us-ascii?Q?0US55BpVksA3klM96wKbMAkhEUNtX+6APxEQ4Zz/PJ09RMjjbWv0TLMWsz6U?=
 =?us-ascii?Q?BwAMpTg1elXrSN21NZPxl9qjPYgX2wv6iODUzBhMgc8wDwSnahStwRWyCIXz?=
 =?us-ascii?Q?hFEOqz5S9hOEg8NjsqKQH6Qp58eJ72cum9Y1vJjTFSh65fni8HVWtZI6lZbM?=
 =?us-ascii?Q?1KwUIGYFqIV50cOuhXblqB+ZqUTPXaHW5h2nXLIPOwzgf2EuOu6kJmIYTu14?=
 =?us-ascii?Q?9dcHW0jyQZ8m8in3bce+TO+8XBKE/sRiUyfyNl9LOoxVFsNCpViy/v69z2ZO?=
 =?us-ascii?Q?35J6ChbBlpHhhjET6aSi1UiUSmtKHYvz48wWKaqAkIN60gD+VoaD7GXlXtU7?=
 =?us-ascii?Q?sghOW5UrJD3drCebyMCiCpwC2NWGs+aE32OWvgRsyp5+wPexQk1UdyRcF0Jj?=
 =?us-ascii?Q?g25ZSyadcmvEsuYCmZAAX/2AD8TynV9gRG7cUqb2EkA1EUPwLDiMajpqu4O2?=
 =?us-ascii?Q?kit4Cm0LgkfIMqwZsvJbqvIlzObMfqYkmjBXtjNCs4f7cQdpM5vtexzuaTrf?=
 =?us-ascii?Q?kL8Uao9b/eQi6mMAldRY+0C3KYUVUTSpSy3D+nlNF5yUwlIRbijrgO7rYvm8?=
 =?us-ascii?Q?N4SU+TVEs9OFUV6+3lmaLCMxGKLZKjWCugBFGHL2zkQjqTw3XZ0BkWbLtn14?=
 =?us-ascii?Q?XILF3djx0Whp3FNY2JEJyiwEgAogGC6tpivr766KaqYUqVCiiv+uVODDtlYX?=
 =?us-ascii?Q?xj7Y2Psko1R3I5dcoFkoATS4fYCw/RqKQ5b7N1dj/NhOB4KmNVihWInrF33v?=
 =?us-ascii?Q?4BI53LLSC5vv5zCBu5H5K1daKtakRoP3WW8ysSofV+S4SJ59oaAfp6n+9Vox?=
 =?us-ascii?Q?JL331Az79VlwzugDdyJrlRl6yoh+0tUoXSFWGQiKH9U5gpLRQ1hSvy14A0B2?=
 =?us-ascii?Q?QDnggAM+R/IlOa8YTp7K+/cQ/rxI+WtX2sWk8at7RUYp+xNW3p4kaf8f8DUW?=
 =?us-ascii?Q?oB2Ure8l+Ix1xXJU8hL7TdY8IW6kBK4Q+JFXdBlrwJLOTLsmhfPGaykhd0o9?=
 =?us-ascii?Q?HdEBMvPFfBgCfbmOsLYlFOMoRAxLMWzDfWg7z0lOFG7gwhJ6qNZwY2MKDh4Q?=
 =?us-ascii?Q?BoM4og/9Dyr/NZphASwm53SBaXCUFQ0de93h8SiExqnr7fTuINi0y/B8QwkE?=
 =?us-ascii?Q?Xl3BD473sttxqU54K6mY5fHcr7USnzZq1rrY3p3tGDeIGkpCSbhx6YHZh8vQ?=
 =?us-ascii?Q?QJBrfx0+kBMzgQSnOSVmENQjwILmIDxjXr0eC03lD4NtlU6hBDUjbVrf3m+p?=
 =?us-ascii?Q?LRuriWrxyCtwnpDdi38LH2Wsb/49QTb+MlAmLFHaTG4UTWvU5dv3lom0scsH?=
 =?us-ascii?Q?gIJTnkGg4Bq2W43kUDMadkni4lilk5hbh0c0kor56R73IbUsZnGkNvSQQ7Bb?=
 =?us-ascii?Q?76fseKibXfIWELX+WNyA5GgTpBmtIQt7cK9pVPAIi8ruvZDcPYvJSEGNknOb?=
 =?us-ascii?Q?rh/FKGS+rKOBgTGpjnUU7lXURq7qaoA2yNyF8BNWVByV+PheQuA2vOhVf4CF?=
 =?us-ascii?Q?/WdZdBUrE+urGbr1mlBEcaaGS5YsF9EhF3hw9kH0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdd6cc7c-5875-4924-9613-08da8fb0fad1
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 02:39:11.5307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eeuMAvRPNNAwkYQWqrcFL/6RDYNgzfV0lnRn6z2HGxs2SeXbsd/R0d6t+51PNfxvJuTprOsVJoejJw6eyj3rAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5185
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

When building with x86_64 allmodconfig:
ERROR: modpost: missing MODULE_LICENSE() in drivers/clk/imx/clk-gate-93.o

Fix it with 'mxc-clk-objs += clk-gate-93.o'

Fixes: 4e9331d4e2e0 ("clk: imx: add i.MX93 clk gate")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index 89fe72327788..e8aacb0ee6ac 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -12,6 +12,7 @@ mxc-clk-objs += clk-fixup-div.o
 mxc-clk-objs += clk-fixup-mux.o
 mxc-clk-objs += clk-frac-pll.o
 mxc-clk-objs += clk-gate2.o
+mxc-clk-objs += clk-gate-93.o
 mxc-clk-objs += clk-gate-exclusive.o
 mxc-clk-objs += clk-pfd.o
 mxc-clk-objs += clk-pfdv2.o
@@ -28,7 +29,7 @@ obj-$(CONFIG_CLK_IMX8MN) += clk-imx8mn.o
 obj-$(CONFIG_CLK_IMX8MP) += clk-imx8mp.o
 obj-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o
 
-obj-$(CONFIG_CLK_IMX93) += clk-imx93.o clk-gate-93.o
+obj-$(CONFIG_CLK_IMX93) += clk-imx93.o
 
 obj-$(CONFIG_MXC_CLK_SCU) += clk-imx-scu.o clk-imx-lpcg-scu.o
 clk-imx-scu-$(CONFIG_CLK_IMX8QXP) += clk-scu.o clk-imx8qxp.o \
-- 
2.37.1

