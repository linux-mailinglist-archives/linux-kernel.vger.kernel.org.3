Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1D249E44E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 15:11:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242254AbiA0OLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 09:11:54 -0500
Received: from mail-eopbgr60063.outbound.protection.outlook.com ([40.107.6.63]:13446
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S240327AbiA0OLx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 09:11:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iP224rJ1iKo5uebGur37zbgjPFXqTtat01jwhe5pt1wUh6c1ETpx9rFCRLHD/BtljDGOnfkNQFnLa1rRrIQH5Dp16LpdrOEr5tXKWcReKC7buGRXrxp5zKE56Vtd82oE77TGpBJDNPTzmfR2aki+zp7GfO5dxuRwE6KfnCNGZGusnaBKEvqTy9zODttKcMZmOajEa+zxULYT9AnHzjMeNzDaEAT7eqtToHD0yFqthTU3r/cm1CpuVvoTVPRfBB0FyReVq3/HlWEnebyuDrpcN8861lF34IooTCGJ/XuskGTBdK7sg2+Wm63L1/XDSoc/a0CbjEF8IQE6LTPS3ZYcdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WyR3Oyi57e7oEqMudDoWB9C0T2fNYhrAtyBxvI7Yu70=;
 b=Hc/kJlIaTjuS1b+ZMN0UFTpPPCKW5tM0IECilkpK12qG/6T8VJiutM5Zor2D51g189/BKllTmxNuaQGQbSY2Edfg9KZ4EoaDUNdmhAnXw4zUGx/ERTAEpZzUUS2VQIjcTYINJCEKQiDoAZFvaTne+klk2spMBp41VHQI+K8uDx1BqkCP9N9QDWzqp1kkg4hTD1Pl2z7ChElFbCZRrAj4zS9jhB5MoeAMeYBnitWu+SoD/TIIJ6dQl68B+nV9leSQjxksMYYj7juYxr7rwHJXxUsjh0tR1dAMdRzlOsWEv+YaenHAGmn/8ZjLpmL7Ytasr7O4ajXmoTD8OlzPWGSL8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WyR3Oyi57e7oEqMudDoWB9C0T2fNYhrAtyBxvI7Yu70=;
 b=rnJmIfAc+9ChoO2VnbzaN5eX8hiKQGU7SWhFQgIpBO+g7vuaSUdroizv2aqUCr8/PtVFrziJTfPPSgaSFvHhWDnLk+f8dSc1qN4oZrRm+wCaTj/zxQpwb8q3HTxD09FoJF9LISJhrs63eylGcbt+fLfF3EbsPFmfIsMH6VQsdVg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by AM6PR04MB4615.eurprd04.prod.outlook.com (2603:10a6:20b:24::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.17; Thu, 27 Jan
 2022 14:11:48 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::f853:4e9a:7ab6:dbf7%6]) with mapi id 15.20.4930.015; Thu, 27 Jan 2022
 14:11:48 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Mike Turquette <mturquette@baylibre.com>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Peng Fan <peng.fan@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Frank Li <frank.li@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-clk@vger.kernel.org, David Wolfe <david.wolfe@nxp.com>
Subject: [PATCH 2/2] clk: imx: Remove audio_mclk_root_clk
Date:   Thu, 27 Jan 2022 16:10:52 +0200
Message-Id: <20220127141052.1900174-2-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220127141052.1900174-1-abel.vesa@nxp.com>
References: <20220127141052.1900174-1-abel.vesa@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR08CA0178.eurprd08.prod.outlook.com
 (2603:10a6:800:d1::32) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be5d8fff-160e-4216-a76c-08d9e19ef40c
X-MS-TrafficTypeDiagnostic: AM6PR04MB4615:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB4615F194FBA985ED3BF31696F6219@AM6PR04MB4615.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b0Gq+NJ89bCNosec7kxlvc1okre9tBdFdY1xlLgrcvA3SnA2STZxFkzslpkTjmGIxqvtRsKCuCE9zdcWsz1nOGySx0U/JJNox39DrP80eiV6rCTXzWwcMsj8ZeYaps73hUEgNFQh74f30GGQl1/njhzNakPHvMp8VsDtg4aiQbqYnUXxNBcMaas9ut+93JBGDqW6iXKPxD/LZSA38/Ks82kBmg95I31ck6q/ENRB3V90NAA60XFOLI23tnVU6DJ6TFU9BK9h+yP7KkSy2Aqz9l2dgezzTEUe4bygfYQL/dBtPgpszIBkWYRTac8U5iEXArCXgRBG98Xk2GU5+ov6OJW3ejAJVRs9Cbr3/VmmQZadNnfF1ZkzLA5bgY7Ui0oa6GyCJjgBWv65Hb006TAz+OIBuWFwuf8WVPMXVBAYdhSoSWz/DVXoidANB50ZwEl5RgHti8iYIFvfzmVyBVl098DrqBFMIXvhoPy0PpywAcueWjIYVXKAsHNTBJEtgZ6lzaR0Or4HrpwwCOv++Ksx6uiPaUweSgq8uGhsT3A8MXuOvPawTWNvV+GOLUfHGnnVQed+PTzYyG6+QuRnbx5w99Rm3gCl+HBVB6ChOo8sVG6qIpJRLIYlMr3T3SktX43fZRSrerQyfL4mXEcIhQd32ywCtCXTLtaKIjyRYjHRNbktnPAJMitMLf/EGdS/jC6t0kDFF7g5xkeSCeVobLHT3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(7416002)(66556008)(36756003)(316002)(54906003)(2616005)(6512007)(38350700002)(38100700002)(508600001)(5660300002)(83380400001)(1076003)(6506007)(52116002)(66946007)(6486002)(44832011)(186003)(2906002)(6666004)(26005)(8676002)(86362001)(8936002)(66476007)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?S42fQWyQ2FrH2tX9r6LbM50yVLcLuj3gpuFSvjrxF3srgtKqbuwmMw4j7bpB?=
 =?us-ascii?Q?ZySiDdIb/bi0P67EtBQF8gymWn0uTcx91kKkN2QLnAyB00B1ZSRFSrH3w08p?=
 =?us-ascii?Q?l+QgDK7ywlpgyABk7Xj8uG1I1HJd+9r16i/MtZmXnw41rEsojqwhqoMUu+ZE?=
 =?us-ascii?Q?u9utLuWp/853itXUYmChxS9IwrKDQkIQSm0elFvVWVN6+wT8um8QdXgM0PUW?=
 =?us-ascii?Q?RkXTaAz/x1KXtBi2Mk/X+dE8w6MyCLqrypq55QKj0LCp9W9cPK6uMhNjQt4l?=
 =?us-ascii?Q?5WIQk1o+nH++fkKMJG1Asb1Kosxao5UJQy41EfFicJMX6H+jJCZXlQoLKRuz?=
 =?us-ascii?Q?gDyx5eKBAvSjFnxA5BPyjscPtNoBZig1OZry8GPNCpZzPpophN2bB5Itzt44?=
 =?us-ascii?Q?TRLsS4eET2QwD7hMAabA/SViEUhlnutYehFLhy3+kzUpf6udQYHveR9gULnC?=
 =?us-ascii?Q?JXDZBi1tNQTETgzQgWVBOy9zG6LVliQiU5O1JLB0JJKKB2gt/NIqL9vxjoln?=
 =?us-ascii?Q?jHRAPnk6Tj/vynQqF1aGUgCAwIDSb+MTF8r4V2zlNxN3Gxj37iuPsKGnJkD8?=
 =?us-ascii?Q?ZiIwIcZw8ZEapDZxMDKXuRWaH23Mt0CyibPKm7/Q7wsv36+GbrB1neQA8jpG?=
 =?us-ascii?Q?5uM7xfhR00/XaAMYP/Qd2NlKp9GpDL9kZJJMMEGXlegKkghGaI9QhM87Nzkk?=
 =?us-ascii?Q?hA5mPlrWAZ69isb/mmbwaw8V7T5Z4VkaYA/fpH6VplrGnW8cIp7ohb1cMDg5?=
 =?us-ascii?Q?q7/rpHLXaowRSSQU5VIbuS5WGjuAkwi0Qhqom+qcA9GiAiDMUXXL29GAeVvy?=
 =?us-ascii?Q?wK3XOJKIaTIJmHO4oTkO7sFMgX7PGIx8A6jMjPDcgUpAxjiB+OJJuL+fs/Mo?=
 =?us-ascii?Q?lCbD2awXU9IB6SXRc9VTvLdafN9PkeJwoY9G5oqYvgb5LaLPGMwIklnLLRAr?=
 =?us-ascii?Q?/h4yW4EQ5HWGdtOywmB86hbp71k1sdbHjE6XyxFKwI2PEA7Al9LXe/9Ky0mD?=
 =?us-ascii?Q?gJK3sxI2jEkCUCyXfuskiI84vaEsDh4ofoiiy4YqQs8fYdxvEsMCmzmSjCci?=
 =?us-ascii?Q?susodhLlYJ33Huc+QGPFeER90Z0tg+Ehplppny15Xy31GV4tB9sZlDVJ3Xf4?=
 =?us-ascii?Q?R6e8GchC5UTOci1vqLBxSJ9/6lWnnvq8sZy82BygL/xsnXTp5A/r5LrHaDYE?=
 =?us-ascii?Q?p1dphqIqy80buLa0cbQH5Rk+j1ROvJ4+rwLVHDRO5xRhVPv4DzCjDcJ22B0O?=
 =?us-ascii?Q?n1SzUlrGmUxGo6wXpunnoII9uchNbi5KyA6+8250/qo4m/g6F0PF4YEbOGTj?=
 =?us-ascii?Q?lu8BBfC9s5K37v4zIUL8o1XKHNQNpDYjgkmiexZgI3JiBC4koMbDWMpM6wrY?=
 =?us-ascii?Q?o0Tao2S1u6MDEcpiI2xmCUa8M9Tp1nRxKn+sKsELB/iHuSsdnufwZpVdoQm5?=
 =?us-ascii?Q?Q0lCMZhPkKa7sNqW/8noO8MUu8OkeqkGadPUReKpvq9MJvoKEe91S3h8OrXQ?=
 =?us-ascii?Q?gJNSHpjuGQ0hKm1kie8GoBb+fTuaJElQXcMpTLEMy3RNWWae9N7/q57gVGiT?=
 =?us-ascii?Q?kM1JG7N/DnqudbB/tofdoqfYgdc3ylOd0zeUYNibQugs8dZ6BRvAM/9wjQVN?=
 =?us-ascii?Q?5Q2ED7T3qvIZ9v+rXm4CGU0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be5d8fff-160e-4216-a76c-08d9e19ef40c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 14:11:46.8469
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QK+BKp8vJbw5r0YlHuEGCGcjr2DEBVNtwbLQmKu4bAzIVdk1y+hltx5Wil6OgFlamGPdxKwJUDJcYWJtzqTsFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4615
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The audio_mclk_root_clk was added as a gate with the CCGR121 (0x4790),
but according to the reference manual, there is no such gate. The
CCGR121 belongs to ECSPI2 and it is not shared.

Fixes: 8f6d8094b215b57 ("ARM: imx: add imx7d clk tree support")
Reported-by: David Wolfe <david.wolfe@nxp.com>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 drivers/clk/imx/clk-imx7d.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx7d.c b/drivers/clk/imx/clk-imx7d.c
index c4e0f1c07192..3f6fd7ef2a68 100644
--- a/drivers/clk/imx/clk-imx7d.c
+++ b/drivers/clk/imx/clk-imx7d.c
@@ -849,7 +849,6 @@ static void __init imx7d_clocks_init(struct device_node *ccm_node)
 	hws[IMX7D_WDOG4_ROOT_CLK] = imx_clk_hw_gate4("wdog4_root_clk", "wdog_post_div", base + 0x49f0, 0);
 	hws[IMX7D_KPP_ROOT_CLK] = imx_clk_hw_gate4("kpp_root_clk", "ipg_root_clk", base + 0x4aa0, 0);
 	hws[IMX7D_CSI_MCLK_ROOT_CLK] = imx_clk_hw_gate4("csi_mclk_root_clk", "csi_mclk_post_div", base + 0x4490, 0);
-	hws[IMX7D_AUDIO_MCLK_ROOT_CLK] = imx_clk_hw_gate4("audio_mclk_root_clk", "audio_mclk_post_div", base + 0x4790, 0);
 	hws[IMX7D_WRCLK_ROOT_CLK] = imx_clk_hw_gate4("wrclk_root_clk", "wrclk_post_div", base + 0x47a0, 0);
 	hws[IMX7D_USB_CTRL_CLK] = imx_clk_hw_gate4("usb_ctrl_clk", "ahb_root_clk", base + 0x4680, 0);
 	hws[IMX7D_USB_PHY1_CLK] = imx_clk_hw_gate4("usb_phy1_clk", "pll_usb1_main_clk", base + 0x46a0, 0);
-- 
2.31.1

