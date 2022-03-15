Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B65FA4D9620
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345873AbiCOI0f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345868AbiCOI0d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:26:33 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80080.outbound.protection.outlook.com [40.107.8.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DDAB4BFD7;
        Tue, 15 Mar 2022 01:25:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kq2KWcrQL0AVuggfAC/e6lJ7u9KZx64Oo3WKl6Y56Y4NPNHkwFqbd1sEqt6IPDzpGrXkrJldEv2vaEvOgnS4M2heC45Uj13VLGxkw0796Y5eTxLDUrlSQG7dLy9KX9usyLbISB1IdfQ949jG/JoVLaQH35DNzUBtdrSgGp08GAA/0CPbcKPNE325a1KDLeyMFiHLbEA2KSkQW5K8RVCWVf3iatgMCwdGkgfj9BIa3ZOo/wjKHAYqRu99IQ8QHwdkiFoqG6Pi08Lx2TRiKL4Dk/6jjcjZzR/sXjsli7JNzMk8M3sTmxPSlxJ7b2LshB34qNvAxLSTXJiZ08liV2U9og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xDaabOdDLjBSWo5VfOoWg89DqX1V9Tvx1cW5BCQLVhw=;
 b=f1tZODWV6FDK6mN4ua3rOLh1Vw17sXtSD3xTEMz216TjRh729KP4NuFUzv0HEVfdG7FlZEAvtKNrgPBwG51i9J8D787jEdIZBijVb2eOkw3msSuCzoJ2h9M9qWdxQUtTIuqbfYVtlucqUfWCCSGblR0H92hw4GPMXCFnolXHrkGJ7WX7MF9olisyOZ9ttMZpaU6ooow0OmpT6tUS64MMUKz42uQzz5oqw26VbWc/47jXCZ1y2ztEqAzkmx7CCVp/Bjsy0siaAA42s+hQwBLwTdkDa/7IU2H1GgD2cGa5uq9ZNPDxIXzanVNc2zv7N6sFjTGODWunNGWPrVrkkx7Qmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xDaabOdDLjBSWo5VfOoWg89DqX1V9Tvx1cW5BCQLVhw=;
 b=kekG2gw16E0La8RhctD56aK5QwuUXYxzCyl48dFgFLBnF6TyFBu7t0UufxRbZXAPCCW+LWv5BcbwMggZPCXtDy+ljj7F3uC7IkNX/vAHW3EyKs/oF2aO5I/HXUsxq4xE/WF8qQVlsSiYDRcB/gsi5qIv5ftYePleJkS0bOQ9gfY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB5632.eurprd04.prod.outlook.com (2603:10a6:803:e5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.29; Tue, 15 Mar
 2022 08:25:19 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::786c:4be5:dd16:f773]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::786c:4be5:dd16:f773%3]) with mapi id 15.20.5081.014; Tue, 15 Mar 2022
 08:25:19 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Abel Vesa <abel.vesa@nxp.com>,
        Mike Turquette <mturquette@baylibre.com>,
        Peng Fan <peng.fan@nxp.com>, Stephen Boyd <sboyd@kernel.org>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] clk: imx: Select MXC_CLK for i.MX93 clock driver
Date:   Tue, 15 Mar 2022 10:24:46 +0200
Message-Id: <20220315082446.3120850-1-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0701CA0071.eurprd07.prod.outlook.com
 (2603:10a6:800:5f::33) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f8eb722f-b39f-4515-1502-08da065d5723
X-MS-TrafficTypeDiagnostic: VI1PR04MB5632:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB5632DDDEA1ECDD3210997FE4F6109@VI1PR04MB5632.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e9F4xSkqfqsOy+jJe4ZsvUHXhZqIlnpjQuxX4uxT/r8eGeLE//V73owAiutZB60GwvwaQApz+0lkeeEJNzxUG//zacJtp+KpmQ9M8AUSklP5qOi0OfQ8ctjmBMIieu/bNvgBTKwV1W5GfmbEwB57MI3N1ex1v9MJDP+e/Ls/FIxTLQAoXyQI2oXeRKRxsrg5QrVc+n23et7LeMYmwQ9G/hlmAXYrAoCn1nOSDnZfvBnXJLksSiSNpBYQgwI7DiKXCvp5WKbLk2cIO+KDL9nzCdGO0OdPIWVlv7F2WLsyv1Ia8keUWWHxCS+OqzAiFq0AxyGSLhPy5a263s80iY5ZkPBsoC/9go9VLLBiM17iXXN8hq5FXYVSgBJaRc4IRT/6QFBQbLsgNMOa9f9JPb3wboYQF9UzKB6aCgCNjAgbEoRJ8r+L0/1dteQCYSEV9Ci80x58l1goO/p/8ivxHYTuYhaGhk22fL8nvcpMj1+O/ljD1DGgfYQpTdSh8v41Uv50wWWfxdNSiHG1s+uoRuwM2A7YmzN5/dDX4u+aYYGvhagHd/vhzKaRCyF3MsRuZI8QJoHm2ng0iiSPKFAF3w6bmHR8wHJ9xgBQ9T764kAtKCutIFmmF6oepbmVnTAcgINzhs6fJ583DAmjiEmGI+yFCIFB9xJP+LqYrLWsZ1J6x/uVZxRPiNUOoy33ZBKoB9cEuRLkC9i+pkPNEDZ6XNl6uw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52116002)(110136005)(54906003)(6512007)(6666004)(6506007)(36756003)(498600001)(6486002)(2616005)(8936002)(2906002)(186003)(26005)(5660300002)(66556008)(38100700002)(38350700002)(8676002)(4326008)(66476007)(66946007)(83380400001)(44832011)(4744005)(1076003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7V+kwe+NqKqOzAmx35AhU+SGVjnV8nqf1rVi/U6bWY390u0+rhuTqWLTmcWY?=
 =?us-ascii?Q?9Q88rXNxD7S7wo6BsX1dfsNVr939fSZKBtGNv0PCOAwICSYqiB9vAgdG/U1X?=
 =?us-ascii?Q?CMhBqtUBsls4ALOn3EcKsisv84kVtQEQ9ZnnRkKY+kkFWB8QfeMSYmlEdgDn?=
 =?us-ascii?Q?M1MKju6E0LLbyGY0+8JVE3nxbewjuV1QtIGokYUcTxwyvxZFCNt5M/YMOv66?=
 =?us-ascii?Q?xUZ+j4vtHFQav5wuFrGF/SfvVto3RHCZjw+ZBwDjSXf2GoQEgKjeaa4aPVXi?=
 =?us-ascii?Q?FxpZNsDVnd7C7l7KKmA/XNGUZZo2PLeiMRbHyt0SFR8O1r/FyMkCZUTV3Ix5?=
 =?us-ascii?Q?kyG/AFL0edonbPHoDbweTRe6j5TTEK8Z0gVgMRkXEfdh9oQWGZe4vpG/yaAc?=
 =?us-ascii?Q?P3Ka0/9LO+yjgBkYmk2KoZdNhjf7YZdtwqJ76iR1jX/EAFS48An/GsHp/moJ?=
 =?us-ascii?Q?RsyZBnDCEpUir7LG0Xh309bvuDqsKSYYn+k576kD9y17yD0IsOrr6wDfCqY+?=
 =?us-ascii?Q?/wMPFRDCyLLbk12FmGTCYgD2t+mBU4jGZwhLAXsre8KnOgk+Qh+tTu4n6A1V?=
 =?us-ascii?Q?X//cbsZmGGW/DOCoT/hzIIFGocCgMONI3xGmygrlvXojl6WpTfYAAk/6MKNP?=
 =?us-ascii?Q?IE5eYsDyRG0iwZMOJTM3lu6YuSGP6+InEeq94ogen8bQusutjMSr2F+EJper?=
 =?us-ascii?Q?gJi1BiHKI2IFdBZBhG5uLpFxtjTNwAmkhBsArfm+El7Bq3MCyZ2F6aBdG19m?=
 =?us-ascii?Q?oCPj+6MBBEi/5eo6w5MtFZjc0mXAX1QMpYbjMKDMzGk2WU3uWFwvNz1WX/gv?=
 =?us-ascii?Q?7fzdfZvRNouPw7B39dLODxQVxHjLnw+loPMsVwfwe3zSiEWdTXViEieh9jCj?=
 =?us-ascii?Q?8uSSLAhDICHThFNUIs2LqUurxc1bbaeXlHz5iHqaX1hakkbn7xvD3nxLhbnA?=
 =?us-ascii?Q?0AgurFc0bbAsJZH2tWlrLgX1qUvl5JzJLCQRh23sWfYg83TcZ4Tk6NPDhOmF?=
 =?us-ascii?Q?gHQkGUob7AjPI8IT1PaNACIFcFV5xCHmizVgb+Bz/oWMYnAjB/BxV/MqjWU6?=
 =?us-ascii?Q?lzR0w1ZaO7HHoyEH8R2y72bkMKOoHfCGQ5eiQWEql1MIWCFEj33r4x3GmtJp?=
 =?us-ascii?Q?lEjYavz3r7ZLD7McNU4os4IfF85weeHLplGxBQjTB0PBhYOyHMWOW9lKOAxP?=
 =?us-ascii?Q?eztad7YyfRXo5+mvAMegTiPtn/pv38Os3ZZph/GUItP7KVgDW5y/3Q/Yn30U?=
 =?us-ascii?Q?jZ+Ed8EmSPJPiZF+Dtb4ocewAN25dQpflmmgKyX3cO+6Crr42JEYPug13sf7?=
 =?us-ascii?Q?SV9GHvdErAIhKHkgD1L85YC//2+MOpbnZbseFbAMZhTmGl19bPAA7ExeyDC8?=
 =?us-ascii?Q?nxDyR63IwK1QS1/MmxjasIq47fT0QHHiCnbOhT9x7JRy1qRJPh863LharRES?=
 =?us-ascii?Q?3/m9q+arerdRM74v0LY+pN1xwbI9yh90?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8eb722f-b39f-4515-1502-08da065d5723
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2022 08:25:19.1863
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hqW5tK/jUdVKO3JHAP23vGqhMbRfOLsqmonFjaqWl9g7/NUkm3RrIrTl18k2zFYSCgh0Ph+8/nrYWe3MPO5fug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5632
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Most of the i.MX clock generic API is built by selecting MXC_CLK.
Without it, the i.MX93 clock driver will fail to build:

aarch64-linux-gnu-ld: drivers/clk/imx/clk-imx93.o:
in function `imx93_clocks_probe': clk-imx93.c:(.text+0xa8):
undefined reference to `imx_obtain_fixed_clk_hw'

So fix this by selecting MXC_CLK for the CLK_IMX93.

Fixes: 24defbe194b6 ("clk: imx: add i.MX93 clk")
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/clk/imx/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/imx/Kconfig b/drivers/clk/imx/Kconfig
index cc464a42d646..25785ec9c276 100644
--- a/drivers/clk/imx/Kconfig
+++ b/drivers/clk/imx/Kconfig
@@ -109,6 +109,7 @@ config CLK_IMX8ULP
 config CLK_IMX93
 	tristate "IMX93 CCM Clock Driver"
 	depends on ARCH_MXC || COMPILE_TEST
+	select MXC_CLK
 	help
 	    Build the driver for i.MX93 CCM Clock Driver
 
-- 
2.34.1

