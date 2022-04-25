Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B938B50DE82
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 13:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236697AbiDYLM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 07:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236148AbiDYLMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 07:12:50 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80047.outbound.protection.outlook.com [40.107.8.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2433F12A94;
        Mon, 25 Apr 2022 04:09:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jxqu/y+JtVWhCC8VGQEoo5yulx/v6jOgj3UPKCn0LpuARndF87SEln7VqkZGbysbNnUoIEuCX61kpOQI40rZQKfeVb0IbTxJRk88m8Pi6BYDPKRjQygUHXHZgl+bHvgUs7jFBb3G9F5XTfnCNYOb/AWyewiC4oq518Ah8DESPGMgFiCea4SyK3ZV2tXO4DCX+Gw+86oXhI6+EBq7IxjbOTC1PVSHn8NFIF0Ajo69zIYg+UxV/KSO70yP/WfwZezmklCAVz39vxIeX1W6UcicLCUEwDRmesWW8myoWQlt5PB/G0uYTRW25Z017Kjdcgqi2GEHDFLJ7n9mJ01Mg0N7ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNaEw3/wM/VGlP+NS/fxbLYjPap8AV43fK0ysU/FKRU=;
 b=dbLbb3XaZ5Qmk8nZalsrTV6/IkXwOVVXZZCukiMoUGcm4hDxxIWnijvTwSV+lPW28PGxZMayCYR5lzRnSHuxgQXD/zD/VlRQefFU7vwPHJOCk5s/wPew2Gr/N8yUgTTlnThD4mVuIERh7mzoi4X8q/oC7aHEPMGpsAV3xzn0QhRvcOso8/C9HscLxru1subXKGJXIXGpueKru6oAdi6hvmplNqI3He5B7gyLQqtRyurfbh8QZNRnHkgglcnw6UC6QPrP3BNBg6QUwHPXBPeFssi+rIAHMQrCMUnOQJ4/X7WjdebqD9rZgTSSqjSP97HAEtpz7d/nh6nsJ9+2ry4F4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNaEw3/wM/VGlP+NS/fxbLYjPap8AV43fK0ysU/FKRU=;
 b=ZBWqT9VIiS/gwyfOJgbMzl95Z0LQn3Bnw8UV/q7AOmA9bxSaAL1tM915zVCrvSXzlJutPA0ltU9HiPUmlMJj0sbASbI8GwLKORPBjqvs8k1BvNR8Ha4TPTmOhnO/zpjTYKL7XeEcLl8hK9rWbvF3lp3OoO5rNMyYx6mSKSxDXVA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB4827.eurprd04.prod.outlook.com (2603:10a6:10:16::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.21; Mon, 25 Apr
 2022 11:09:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::389f:e6eb:a7a2:61b6%8]) with mapi id 15.20.5186.021; Mon, 25 Apr 2022
 11:09:44 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     linus.walleij@linaro.org, brgl@bgdev.pl
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] gpio: drop the SOC_VF610 dependency for GPIO_VF610
Date:   Mon, 25 Apr 2022 19:11:35 +0800
Message-Id: <20220425111135.1632047-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0057.apcprd02.prod.outlook.com
 (2603:1096:4:54::21) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1d22a7fc-a35d-4ef7-f5b7-08da26ac1a14
X-MS-TrafficTypeDiagnostic: DB7PR04MB4827:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB4827F70DB1F460A1C2AE79EBC9F89@DB7PR04MB4827.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qu1u8P72+TByNuYeMYkGixUbBKlBTeBEbFiKban/FzZ0F+pyjyankwV+WZcEEJadRT8TilXBqZ8DVbnQmxfojbXMaJoZ3Q+nHND/aRuKZEZsabB9Eu6SY5BzZcsHO6x5gWGesVl3EH1gnH9DpZ1ntENLrtFSDni6NCK+2yRTL813vJvt9u5qhmpS5D7eQqOg8oLhT4VUdGaF1vqU6oymmB3Bx5XEnltiTkArCPk079u0wbNlqGkOipXNsKeNN2XJdUw6NRbCLPpOK1j8ivtAOB+HPi+EcahHqfiyX6NWMfzsMQP4wqePsYjj4dBDERJNT7mFR/X2R7fIwBOsHYf69TaXZ28i35sS1jjgi5FxqdYiWhUOdLmhz0Bqn78bYf1hc0I/8B3YJKsN+EofAR9uzHsBnBRWlf2dB2DoK8xsSusTtzuJWzlKeINwb9bGWr45GxoX2PZfDkzBCmO2A6i4Qe/x9jJXWLBWfjhrDjUv8B2YheybDWpS2FAAyBueMhPczkYpzJGMPjJk7iw60Rzx9Ejvd/7o/TWQw95mdwHHXOnx8mG6rc5UtAWj4UwSV4QOxKYGrGyVxofdf71wY5LqoBPsHLpOsiJkWkQdWbDYo09YITnNBTalCxFzuIdUt/3SPXqjeJCvGaZ1Sl3ZzadBS//ierMq4FP/31Bq42m8XYkqrQktPeOHyXBAZm8lrfIYfTSJbf9ORk2IwoYGJKyM9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(6666004)(86362001)(6512007)(6506007)(26005)(2616005)(186003)(1076003)(4744005)(8936002)(4326008)(66476007)(66556008)(8676002)(38100700002)(52116002)(38350700002)(5660300002)(2906002)(66946007)(6486002)(508600001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IrpgWmjaeMfhePJRghpvbDqqZuULkJX9YtJhi7kxAZLKWbHC06/3AmImj7/V?=
 =?us-ascii?Q?xdOeG4XMKwsUK9JLdpyocve5FioLwgfQxZLX3YBNzA/gLdDo1va7mNsqZ/T+?=
 =?us-ascii?Q?26zHkHV+vKbavf+aWKkqXQQktJqwZfrCp0FOZJ+/WLVItBIu+7lCI7AAuWlo?=
 =?us-ascii?Q?mDrTxBjOLsO16mbWIgA5lx6RZ+rhm7IMH3G3hCJBGAsx/wEuSU0xLSVMTZ57?=
 =?us-ascii?Q?j1X5pgK17wB2S98nhHL/PzOWHY2jadFzfcEcQ0hIcXRV3jgJ0yd9L3SlhtYu?=
 =?us-ascii?Q?qCX0BtrfyoFzF6Zb2glgHPpgp/mdHBSqK9uuGEu8mSECvzlySrn8PG0wNI3C?=
 =?us-ascii?Q?/81tkJNcpWyZ2ugEmzz7zyCb1kmISB5s8vLuJnROe0iQh+yvDgAMd0gXhiJj?=
 =?us-ascii?Q?zozSBWiX+z6f8DkKXI2B3sTQx09NrCKgd+nl9u7JemAsvoxgAyYrR/wu0c7c?=
 =?us-ascii?Q?wY/KbYgV4zxZ3OUsvh1Fw1AhG9rwvqf8oSu97SaHHbT+hUYUG60IIEpcPzSf?=
 =?us-ascii?Q?+m/BTFADh9DAqGCSJQdBh9CTW6RzqlU8UIRep31g1pCaObpcLf50cfMTKCD3?=
 =?us-ascii?Q?4rdmFRpCmrRe4j1q8uRLjOn4VC2BGgfLoHDTBwk4w8vdY3+g2IKa9u9m2H/s?=
 =?us-ascii?Q?tMEGNqd+aL9eTwwADAh9oxwp5/vecpX0PAA/e7SnCRYNLIxLwKzSSY+9clBW?=
 =?us-ascii?Q?pL0/JLPCA7jZOGg4aMG9iI/37Ec8h9RFXOTG/BmfEFPbYXc8y5jB9+57htRy?=
 =?us-ascii?Q?0JwC5tvsQ+FfEypnMieQuLhCAFmvPdCxSSEXkEr6Wujf8p2p1JJDiKH0xXmb?=
 =?us-ascii?Q?0oEDWRvU4cF7THAVllLyn6b3PSgrdkdGx8vyEaICzgqcMg8KjQqUEZilfdC1?=
 =?us-ascii?Q?s7X8xrAwEOkdIrKas60p5ZBRZxX+Liw3026Y4tk8bqoZTfh65yNqG+kYEXdo?=
 =?us-ascii?Q?J1Ay55hvgoj1wO/wPOffrYvQm/jVefbysr6+m/GWqrZwivUzOiYktiY9PEYn?=
 =?us-ascii?Q?5V8t+ooMTd9UvSIVmdfrZCtcnXHdgNhTaNm+wwH4cfa8cHfnCWcHCu64gQCK?=
 =?us-ascii?Q?Z6G5AOYEDIJxEWUd40fI9MzP41pL6P11o1HAy6PnAvVHVEhxzySpJYpX1I0R?=
 =?us-ascii?Q?TmpEL71QSlHTHZqNdJKr7rIM+wCCQEjlay9FvtqevbMZgWKhWfeMfl4l04T2?=
 =?us-ascii?Q?Aw+p4S0vEmsCCuOPvTmukm23JicdEut01m4dCTpKbw5LKR6OvGKB0tHMO+em?=
 =?us-ascii?Q?cxMB8E+IqcJMnwEaur9BDpuHnc4Xtih4X5xXS5opM7vRhFkpG8PzbneTD34e?=
 =?us-ascii?Q?5JtadRZeI7gCP17iYwE8IdQfbPZPcI5J/Zj6sTxo5/OzhUrYhdJS8e6U/JnQ?=
 =?us-ascii?Q?0L0FbPdfTeTSfGdmGtJ/CegkcigILZPFGggmao64nT8Ttff2rQ7m7+y0z/hA?=
 =?us-ascii?Q?TbYzJ0SrUI88PJrBvnoqqyh5//M9urQ8vjNR4Y7vW4dApAZi0CXT8TMnpVr1?=
 =?us-ascii?Q?2AC/xZe8x87VeOWB7kEs8zyJL+EvcXNxGKnrxm7U2Nzl8CvKVG8NVtsMD1dv?=
 =?us-ascii?Q?I4IUtIB2RWlolKESRGcgn2uNQsWRNAzLFP2tzY247FUXUegc5iWRHXePLUvD?=
 =?us-ascii?Q?kdLZuAqPhBdv0olhpZlaRSyzs7FAdpMX+C/LsPHxUIkaUR/Qy6UzsCxHMrzz?=
 =?us-ascii?Q?lM/gkCZxf6oPcA3DBaxIBbtX/je6IZrv6SpZEx0K0Z4pv4VAw2eoUkg6p8Dz?=
 =?us-ascii?Q?32TX4zpoTQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d22a7fc-a35d-4ef7-f5b7-08da26ac1a14
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2022 11:09:44.3452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E5dbdi3w40VifP9bLZco1xBWP/Bkmm3aRfdwMLvWCXgaFDOP7q8y8z6QicUYKLlihApHlULRZZl6FpbWDfvmvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB4827
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

i.MX7ULP, i.MX8 and i.MX9 use this driver, so drop
the SOC_VF610 dependcy to make the driver could be built
for i.MX platform.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/gpio/Kconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index 82a3bda6e047..9f2a076da6af 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -681,10 +681,10 @@ config GPIO_UNIPHIER
 
 config GPIO_VF610
 	def_bool y
-	depends on ARCH_MXC && SOC_VF610
+	depends on ARCH_MXC
 	select GPIOLIB_IRQCHIP
 	help
-	  Say yes here to support Vybrid vf610 GPIOs.
+	  Say yes here to support i.MX or Vybrid vf610 GPIOs.
 
 config GPIO_VISCONTI
 	tristate "Toshiba Visconti GPIO support"
-- 
2.25.1

