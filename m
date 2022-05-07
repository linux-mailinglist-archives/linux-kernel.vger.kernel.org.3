Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4519451E703
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 14:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244749AbiEGM4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 08:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233617AbiEGM4c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 08:56:32 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50049.outbound.protection.outlook.com [40.107.5.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527053EBAD;
        Sat,  7 May 2022 05:52:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhNqhhIys0ewYEeoG7cJgW/8x1MGpQt5XiCCZvsRICP6n7MpgYLlkI05zlw0ph3KyXy90OjQ1HbWptbTwnDRNJ9Q2/AaZYZNKlAYcpDdfQjETbuMsntoNp+H60Up5OUQjK4nlKiNWkXcpSDNlCrA3MeEEAVBXW2UVSQsMrGEMrsFlPRQMczynETSav3+OmWkQPVzj+D+/yXYqku4djHSVeW9jK1/uAhTzcZa4BWmtme0M/MR4SqMEeVMGJnHPtV+NqAUeQmJc9bsQkZb0L5BCnfnqX52H9rLIK3BQngII00XydRm6Jz35OqME+FMg2duMn1SMGtA4M1FSEP8zNrWLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47ewSZpg42CvQ1WG3fRSGrPBaHPZV1vufpNxODwkCtc=;
 b=h1EV57HKyKiKvcZcWhLsC9nSEufx+lOsw1cKNBDxMLbtB4uWdM3fmdhClmcBFFMGWilnTHOdJHsAFSdVFUiolt6yc1AZyQmuRpAOrFLCqo9sRuMgc/kGXfkfOrjPh0gCr94afqVjrxhNvtBiUyGUqHYHzfOAjQU3EZFTAkiQY40g8tmAau1RdZiIfLZv+L6rPawQYVEecBnfG5QpL8Y3u79bOqoYvjEPV/08VPB87LHwVEXV0b1qnPlcKZ8uqDb9r4FaP8y+VIWymi7wahFnxHUzu4j6drXzJGxX0GotZMy2wDOjPjCYYMdj8cwbEBTBgnXEITvKryYMVjMYOs+iJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47ewSZpg42CvQ1WG3fRSGrPBaHPZV1vufpNxODwkCtc=;
 b=j1LvUTwuZiVv4LZlBRZKJnxFqEDQ9+yzpsbr4Tqoi4PLFCAUN9kTEqc+bzqdc5WpLyNJODJXhf73H8zADs/hZQ0JXf116secj9wPquTiQHtDJQOOfDQYfjM9/Dm06lloCO4bs9f5p+++g8oW/3YFLW0abZqpa0xEBEKLYHuXgbc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM0PR0402MB3923.eurprd04.prod.outlook.com (2603:10a6:208:e::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.27; Sat, 7 May
 2022 12:52:42 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420%6]) with mapi id 15.20.5227.018; Sat, 7 May 2022
 12:52:42 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     abel.vesa@nxp.com, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH] clk: imx8mp: fix usb_root_clk parent
Date:   Sat,  7 May 2022 20:54:30 +0800
Message-Id: <20220507125430.793287-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0007.apcprd02.prod.outlook.com
 (2603:1096:4:194::23) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 72bd0aba-3d2b-4d3a-f164-08da30287954
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3923:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM0PR0402MB3923F8535D1666482249E9FFC9C49@AM0PR0402MB3923.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CFXbK9o9MwV5bhoyKxx+Uzz9GjAcAvqW1DBnPWoWTBd7WwWqNx2Zhd9sE90qQMn0wBstBcVoYMx0rnPZI6NuR0ZNoxM0Xt40UklTvRC50MEUiMViBHn2hsyggrosqt7vDW7iRLGaj4MQPOdNr1GyHMnUVKVQq/jt9fBBrZ+4MGFgjhXYSRz5fL9iSIQzEIw1Px5Cs0hKPLvDTDPWR9rBpwPwtyRDGryI6MEZi+5tYvyGN9p1I1nCsVdjGkw2Pq4aaaEpGr/bxfKLu97Bu2f2X1xALX3U1UznT1STHRAMhTuSC3EM+Th4Gv2ZL947opGcb2HjBF/5XZhpNx2rWwL6x+fYHXOTdOGcRAJF6Qj65LJwAgHQy2FF5RfWv4o5sGQ1VQjoX5IDvjyQj2OGEGAFHWuUje4DHWCngcLfEOPC3wDvm64o9mZwnybVU0B17MDddtl4oaVAv8Y0Rd/0k7iwK/tZUZ79CEUvHBzbaV1c6zHKhBH0A44ST34V3jG7iac/yuWXz76qEPp13+FVUaCoqlMD0H80DSYqqy6CvINhDnQY4VhdMJsKJfB9O2BLVree3q8SmBmms13IPDGWJWA1pNMy21rgS5Ru6gsTLLYeK2RLjXz32fVeAq08EIyXq13D9bhmtJfCZvqb+3lJtUxZEpuKnSZJSwUWbbf6z8DotsDKSIEGE/KJX9F+e2nIGnZ8sFYZdikIQVdF/RRY94yfKUcZDbitmVrX+kFhZBSHHhg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(38350700002)(508600001)(38100700002)(6506007)(1076003)(6666004)(6486002)(2906002)(316002)(186003)(2616005)(6512007)(86362001)(83380400001)(5660300002)(52116002)(66476007)(26005)(4326008)(66946007)(66556008)(8676002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?q92ciS9kjYzWOB607JVXLmJYH54bQBqhkvw30e5fTSK70/IqboBZGz8qgdgk?=
 =?us-ascii?Q?oeSs7Icu0B/ecYLWB26mxiibXO6Y5TPV/As4AnS+tNkIKcNviBW67EyEoJUX?=
 =?us-ascii?Q?RIpQXAU4QfPalNlM0GR7NZgYAbE+Y94+Yky8ZZvhfXREqsfs0L8UziPJh8QO?=
 =?us-ascii?Q?QM9Yd6PJn9Sot+mDBhLxt07WDCyw4ZDgxmBvnMO7QJWPgCaq0ynTXJzjtJdY?=
 =?us-ascii?Q?fq/FUIwWVJzDUPx7d/zmPUpFuWpCq6dVXw8sO+g9Jxgk0xFJJjHjgTbzILIC?=
 =?us-ascii?Q?HiukOHcRbLV90XzRWmLiPSp6FyQYC0ARxK9EckG67F1cMZCHd0s9BXjztMAp?=
 =?us-ascii?Q?O2iuMZRcCetWQwHWzB3JZH9UR5Hq2ulDrmRxRnInnKbqEKLYUfv07T0jfFUt?=
 =?us-ascii?Q?2TMEwlKq1SmnkJNWde1s+oSqb6mxmOl35UcS9ex4geHei9xZ1DlMcbDt+XmF?=
 =?us-ascii?Q?MISl3P5LQP+ILeDTnYjDLM/qKerSv12a3Hi6lEf7pDQaCT9PqL+VXW4+Sitf?=
 =?us-ascii?Q?UYrIEIypgF0sF7dwWuzv1gcJcrxJgu0awNtyrpTUyQrBvXz9hRYya3aamoGH?=
 =?us-ascii?Q?OXCrNAhlssD3KERc1z+tD1wy/L+75d5HTgkLGYAwLZEk+wFsDizZD83g+58y?=
 =?us-ascii?Q?0QSUu6R292haA7mPANXkT7rDACgr5CWdJhofHEmOK7JMmSWCjlRVNsS1672T?=
 =?us-ascii?Q?Y2pp9iAveUgCNcC3RMGN4zWUftDZMYR79bqBNl/n6FjsfDvi4fPfssZo7WpV?=
 =?us-ascii?Q?w6ZBw0zS0bJ6bd/SOjvb2cOnIljY7iPNnBakqSe+BdTTXMhGfu2NbkJl+mfd?=
 =?us-ascii?Q?Fs/gElfd2NCRQzjJysUIOE4j6gRj2cI4iZ4rqrDRLKAsxoDKNhlPCw1Ev4IG?=
 =?us-ascii?Q?cKOurfDcJirojmRujixuo9AvBq8gJ1MzlkCy9hjvRWdZ31CdzCSsa9ufT55J?=
 =?us-ascii?Q?3LtYfhCfRAaEE2vY2+rVUKlG+xaLagixqkSXjbYt9+afjNVd/9tpE04U5O89?=
 =?us-ascii?Q?YjkACINWAIH18j6ddUYWp4TT3nyTnBPpAFgq4zMWZIIn2IYtBdvf+VKdf2ww?=
 =?us-ascii?Q?yOeOU4rT7jLCa+6HxuHmc0CtRkt1HxcUX6dnHAWMG7amwI70H2y43MOiFdnA?=
 =?us-ascii?Q?BHJQfrdyQhR05dj5RMqFOp5tUJhyUt3diHo0enOF7IDfWA84/deMjQ0eMNql?=
 =?us-ascii?Q?5hspkCCxCrWHC7K9WGdDclrX49VOodxXdYejbUSvNut1gtvkacXMt7ZzX9nq?=
 =?us-ascii?Q?mKeqIn8pYLN07SRTgUNuhAsVRwTm8e09CZL6ncNk0oRjy3opSWxAYgu4RQls?=
 =?us-ascii?Q?Hn3JlkNpYhu5Nfbs8JGmQQxMor4l8t0uxB4EUcsHChdQLYuvDtRisb7TuqrZ?=
 =?us-ascii?Q?yFSP/F2jONDuD+dB5TFMHcB60/k7bGY4uBguebv69W8vwzZfodfIlbM4dlPU?=
 =?us-ascii?Q?w25JRnPYBbugVP08IRFUJDVwcy2fWw1eMYHwQjuVq+JTqiBXRwteGDNIediu?=
 =?us-ascii?Q?q2y8frkfohy4nnvpDf6kGBQ0kH2e5zPX0ktqbwxWHnIxeuQBSMD9aVxuBAhK?=
 =?us-ascii?Q?5mvTb2vAdxk3ctjPyqx6V7/o/TmzBsQNBaJNvP6Dxdd0K961cj5Zzf4BeSMs?=
 =?us-ascii?Q?GXac6PsJ6QcqMsNxCjUqsVh/cmBzZCTGtxuFrDCqyBhYD5oWNq3JDVqu7aGT?=
 =?us-ascii?Q?ADlQYRTH/n4iKI+tHzFxehxZNALZoHku3ejhpeWeMajbk6IrdsdMQLEDsNS5?=
 =?us-ascii?Q?NiA4ynIYnQ=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72bd0aba-3d2b-4d3a-f164-08da30287954
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2022 12:52:42.0499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QVjrcapJqpJ3Zsy6GURnL7+RSIFiu9a+sl09mCaKzYVlDhQ0ALe8EEMNu7lD4TPhcBf9zqgPQNPGAT5NUO0j+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR0402MB3923
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

According to reference mannual CCGR77(usb) sources from hsio_axi, fix
it.

Fixes: 9c140d9926761 ("clk: imx: Add support for i.MX8MP clock driver")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index ba058fbccecc..e89db568f5a8 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -673,7 +673,7 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_CLK_UART2_ROOT] = imx_clk_hw_gate4("uart2_root_clk", "uart2", ccm_base + 0x44a0, 0);
 	hws[IMX8MP_CLK_UART3_ROOT] = imx_clk_hw_gate4("uart3_root_clk", "uart3", ccm_base + 0x44b0, 0);
 	hws[IMX8MP_CLK_UART4_ROOT] = imx_clk_hw_gate4("uart4_root_clk", "uart4", ccm_base + 0x44c0, 0);
-	hws[IMX8MP_CLK_USB_ROOT] = imx_clk_hw_gate4("usb_root_clk", "osc_32k", ccm_base + 0x44d0, 0);
+	hws[IMX8MP_CLK_USB_ROOT] = imx_clk_hw_gate4("usb_root_clk", "hsio_axi", ccm_base + 0x44d0, 0);
 	hws[IMX8MP_CLK_USB_PHY_ROOT] = imx_clk_hw_gate4("usb_phy_root_clk", "usb_phy_ref", ccm_base + 0x44f0, 0);
 	hws[IMX8MP_CLK_USDHC1_ROOT] = imx_clk_hw_gate4("usdhc1_root_clk", "usdhc1", ccm_base + 0x4510, 0);
 	hws[IMX8MP_CLK_USDHC2_ROOT] = imx_clk_hw_gate4("usdhc2_root_clk", "usdhc2", ccm_base + 0x4520, 0);
-- 
2.25.1

