Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBFB59278A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 03:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbiHOBdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 21:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiHOBc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 21:32:59 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60076.outbound.protection.outlook.com [40.107.6.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CC8C5E;
        Sun, 14 Aug 2022 18:32:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RQ4JJxMLxLeLj3DQA71ysddWg9Jwh0pfgXOYORjGdhWsKRDocJM5vBOWeyK2epEV2V7t9HAIgTrBJK5xS5GIklsy+J/y3oKyk/Za9D0WkCxhpnqMnMlqdQq3KOoQoaBTaPSP/HMfI+T7+faYhGTBK+IMt2PP5DYNIUd7r7P5YUXmZhUTUPZMz4bZP/7I7g0aS3pwTNUzvm5xevafDHbdMmaIGC8HHz17apzblgJueknV0UD+WK4lrRKIM31b2dOadGyT5tJo28FQmCSOB1QmDU3uTJXD3UzVspT9BI4SXiP347l4HjYhz3mTWxZNm5+Ca6Cm55FmwecGr9VAkNcNqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BMyJjit3ZAhRL6mHCbkVI/XdL8zcD02H8mkD8YM4v2A=;
 b=Bj8XaKYtt0a1ix4tbaRFmjco3wtCU/9PAkJd6jZ0Y9LDPW/XATgCHNzRBZ5dnE7+ueE5EM5vUcTH8+GX4GPJbOAlh7LM+o9Fgx1dFF1i0bqdWDQzmgwsvdXulSuOXTtFLwlyzPSBAZj8+IPhJHyKq73Ja9fs4MAOBZeckn3CSPWrfe8lKgRxyB7P4x0R8bEBmLSlLbDgr/9th4G6t6H/0Z78gta/jAIo/yhnG/LAYtLLvYe+zjXV3AULGuYOu+v7ceKD3RU8MzfVOUcIqfRvCKzmBDNKGBbl1p/XMURcAzcxgnxHT9RitDLBK/V3utLvjd8beE8GKOazzIiwtR+DwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BMyJjit3ZAhRL6mHCbkVI/XdL8zcD02H8mkD8YM4v2A=;
 b=BhaJI7Vk3HfruXyeyADlvK4irgkpVSXJ/9Qyj+7mqO4kX3kWUphNcp89QSJQcBvDgmb6KOP7eYp+5EL7LQ1GuWXdvnIyDS67hFdbcxvwcqQ9Bn2OAq/UdjHXxKrnStmgdkHVZdV8N5NTpaWcDlzfJkzjwIoGQrjtJM41MzG7cv0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0402MB2923.eurprd04.prod.outlook.com (2603:10a6:3:da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.11; Mon, 15 Aug
 2022 01:32:53 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::3c6c:b7e6:a93d:d442%4]) with mapi id 15.20.5525.011; Mon, 15 Aug 2022
 01:32:52 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH V2] clk: imx8mp: tune the order of enet_qos_root_clk
Date:   Mon, 15 Aug 2022 09:34:28 +0800
Message-Id: <20220815013428.476015-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0195.apcprd06.prod.outlook.com (2603:1096:4:1::27)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59e3e8c0-af92-472b-db33-08da7e5e1238
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2923:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FjVnBRxRLAoV4VLAUXmY+E4O/f8dEK64e4dLHIx2kZ90XgLkJHWYO4GXp/DzRGEZsFaqcylg2v8guF/ZuAafBI7wlBsaL/S1dcGDv16ErCFpvP56tc3buLRxaGjQDoBmPuWEoyCbbgXkw/OU4shJAp65P9bFjObKlM4hagpUDE4wglvPAlZrhQroshaGBxn6WAPFFncODITbZvmTfj5zLnF/TRUjwJv3HYZYPvXHKijG2+ClQWEht/XAOz52rRZB0ye6wA7bR+IDbKk3JwCsvlJmMnj8+HWeV/w4C1Jeqrtvjrr42LwOh1+3WLXA4VqUenWbK6H8ej+I/KttzqikSecwS8Jlx1IxcKx+X4wptqMlZpD3v2xrqDkKkD1wrqk3ll3yeesGrwRhLnkLxKQ2goasEgCjVGPpV/cOIs0cIlXZ0WqJXifjPihiLt7K9wWkuWRQAMRJ8lUAZXcmGSjIlfZIuo1twJjs5PFIOC/X6GyZ0PKvH0d/ZnBSA+LaSJ1gl6BPWz5wA6URVvigGL/bXZRXIUOZUNJjU8ho14JcuInGI6dG9OoIfzGx5FtZy/rXwfKIsKuD1DvJ7BV8IPl3QFvu/77bukX8kd3dhmlOBjSfAQjB9++gqNVN2wcOKKJgkMO5lQv/xb6xb7ojgkaDt0nS1Tux5FftHJCSQW+C/U20dNvLp6G4yOOD4fI6QEWtgX/zAy7vwsIGc6xoARl6Phhpttg3wJVWkcceZuKYeqlL/XMNRAjDFLPCnI+XEj8Bb++WCqYeeb08gGUdWmqjMPnW+GAxMqxWP0PTXiwhTRzMoot7lwQ3IDCplnl+iWdswNxgHduDe5l0lIl4jybFzQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(396003)(346002)(136003)(39860400002)(6506007)(7416002)(52116002)(316002)(54906003)(6666004)(2616005)(83380400001)(1076003)(6512007)(26005)(186003)(41300700001)(478600001)(8676002)(2906002)(4326008)(86362001)(6486002)(66946007)(8936002)(66476007)(5660300002)(38100700002)(38350700002)(66556008)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NPd8gHimy6JyoELADb+CXqcVk64nfPMQGygGwvkr1zDqzAVtikknJmorelfV?=
 =?us-ascii?Q?lr3iVZDLrUgR/eDUORDV1/68mPCmz6JBY/EvPVtF7+kQcHSLC0fQawGZF5YB?=
 =?us-ascii?Q?cj/wvZCFCqYTrq84KtZpuiBgBGphGnUpDmNiEnHqF7mTNv30C7PJSzlVVTBj?=
 =?us-ascii?Q?wxCtPwixiACOs2BZAqdLfXD757yREkeYl9qNJKVLhryOi/nZbBHw2WkuUfrE?=
 =?us-ascii?Q?fgMUYf2mzaZuwrXBdWTHa1o8u0BuljBhsHWFdpyh/M3ISywnvmBsJfsXEa+H?=
 =?us-ascii?Q?rUaqB4Frcy2DdAg9vWi365yN2AEfMCTgJLbVeGloEIptQeMEslYJcBU+yx9L?=
 =?us-ascii?Q?56lzQv2+6TYxE7mCDRbFF3ymCoQOxhdn2OlU4gY4dR9txewUuN5So7LYD2Uw?=
 =?us-ascii?Q?RbUmSU5DzSR3iEJvugzKkACgLiL72HXe8zCXFPDl0udK4KoHoGpSMZC/H9Ag?=
 =?us-ascii?Q?vQcO9Vzkb1+APEfYvHbRb8iiCUVbf3dE6T6ZShKSjhELeLm2tghgvZco+VV4?=
 =?us-ascii?Q?bAwt7+VmqwqrYZJrBN6bZdfX/GJZNhyR/mukSJczazWoxGGVRma+fWlZGAdo?=
 =?us-ascii?Q?MNTCNyaDTe8+sv9JGUBmQ8eQIO+6AMuvrSSaccq6y2A5FiXF75BSv6ayFW5m?=
 =?us-ascii?Q?6rPf898nZtRzGo1hFwtTrK8hltkMVmNiVP6DDyafqtTRwE27jvZbJ6SW3/oD?=
 =?us-ascii?Q?y61n4+t4prBT4sWvQ7+RyPNVFfa9e519hcvq5U921NW7Rm7baCGwNXASZmbA?=
 =?us-ascii?Q?OW3jj4pCZOh+grmvkDh6WtMqUQzyJcFn8pOiohzPyA1E+uy9nmwVydZae51h?=
 =?us-ascii?Q?69XWp1ujHa+teX8NAerWTeP4r1oXfQUK8g1h7sRUY+4a5W6CN0csVq+efKh1?=
 =?us-ascii?Q?TNGoUGDBmZQ76WYAOdcVS/peY+DrWRxfJH0T2fTkM7pLCJM1HD0FHkM7B9QK?=
 =?us-ascii?Q?6f9wAfx+tJY4v424huGJqje+VDnp5gF8VZUJuq5zpbIDh8B3AHRRap/Spwzu?=
 =?us-ascii?Q?1R6o0aCDF4SBMoKYL/F+ihnpKHdmmNoDE9TIKJRf2nzjk3kvbYJBgnQOVGgM?=
 =?us-ascii?Q?brhhIso3zzAgdDJ4EUhOWpWQlsOvDcf9NQzoOZ+f9ohHmuvwgNl7HZraYZuL?=
 =?us-ascii?Q?YfiQbizDHmyj7vSrN10KjriiaEmzyw2731usVhytZf5xXy9B1cUpNbEacvb2?=
 =?us-ascii?Q?cQlMeSKNo3EYT/mTEfl4T1V0uM5zyBQAZ5FDZOVMXj10+JFsts4rpA3qJlLq?=
 =?us-ascii?Q?0fuRF6lg2M0ljYf15Z6JD8RXefHGPI6W/4PQr32KlhcGHJ9gDyL5axmvbZ7M?=
 =?us-ascii?Q?ARZNzWRQivV3TdkmHh/ocpP0Yt1TxVYgVXdiA6Vcd8rv79RjWaxUxq4qqh8G?=
 =?us-ascii?Q?invEBb2V6dJapOyC3hksSwrecEGZV8kTp3PipUzk5SIoiV0Bi5TXEChXc0qx?=
 =?us-ascii?Q?cHgm/l+J4EwjcULCEtB5S+qsX5lfwnPEmV6oEREXa6AVWbWOveyRQoqifwKP?=
 =?us-ascii?Q?rIVkJGm0ItgBbUktlvrTtoa6pn3WdOGkmOjz/YcA3fvr58IvXqeWPAOvTKix?=
 =?us-ascii?Q?K30JJndFWdJqlAA6tO46fXIXhlMh2RdYL1bba7H3?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 59e3e8c0-af92-472b-db33-08da7e5e1238
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2022 01:32:52.5806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t6YBF9ANhU25REQGRp+nUXLrgkcRNVSx6eNiDW8VC7doiC9100LlBexEcIgSsQZs3TvEpPRlifDD3T/kKdrK+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2923
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

The enet_qos_root_clk takes sim_enet_root_clk as parent. When
registering enet_qos_root_clk, it will be put into clk orphan list,
because sim_enet_root_clk is not ready.

When sim_enet_root_clk is ready, clk_core_reparent_orphans_nolock will
set enet_qos_root_clk parent to sim_enet_root_clk.

Because CLK_OPS_PARENT_ENABLE is set, sim_enet_root_clk will be
enabled and disabled during the enet_qos_root_clk reparent phase.

All the above are correct. But with M7 booted early and using
enet, M7 enet feature will be broken, because clk driver probe phase
disable the needed clks, in case M7 firmware not configure
sim_enet_root_clk.

And tune the order would also save cpu cycles.

Reviewed-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Use Abel's new address

V1:
 Patch got reviewed in NXP internal.

 drivers/clk/imx/clk-imx8mp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index e89db568f5a8..652ae58c2735 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -665,8 +665,8 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_CLK_CAN1_ROOT] = imx_clk_hw_gate2("can1_root_clk", "can1", ccm_base + 0x4350, 0);
 	hws[IMX8MP_CLK_CAN2_ROOT] = imx_clk_hw_gate2("can2_root_clk", "can2", ccm_base + 0x4360, 0);
 	hws[IMX8MP_CLK_SDMA1_ROOT] = imx_clk_hw_gate4("sdma1_root_clk", "ipg_root", ccm_base + 0x43a0, 0);
-	hws[IMX8MP_CLK_ENET_QOS_ROOT] = imx_clk_hw_gate4("enet_qos_root_clk", "sim_enet_root_clk", ccm_base + 0x43b0, 0);
 	hws[IMX8MP_CLK_SIM_ENET_ROOT] = imx_clk_hw_gate4("sim_enet_root_clk", "enet_axi", ccm_base + 0x4400, 0);
+	hws[IMX8MP_CLK_ENET_QOS_ROOT] = imx_clk_hw_gate4("enet_qos_root_clk", "sim_enet_root_clk", ccm_base + 0x43b0, 0);
 	hws[IMX8MP_CLK_GPU2D_ROOT] = imx_clk_hw_gate4("gpu2d_root_clk", "gpu2d_core", ccm_base + 0x4450, 0);
 	hws[IMX8MP_CLK_GPU3D_ROOT] = imx_clk_hw_gate4("gpu3d_root_clk", "gpu3d_core", ccm_base + 0x4460, 0);
 	hws[IMX8MP_CLK_UART1_ROOT] = imx_clk_hw_gate4("uart1_root_clk", "uart1", ccm_base + 0x4490, 0);
-- 
2.37.1

