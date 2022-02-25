Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63BE44C3FE3
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 09:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238444AbiBYIQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 03:16:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238419AbiBYIQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:16:30 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150055.outbound.protection.outlook.com [40.107.15.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69B1F1D67EB;
        Fri, 25 Feb 2022 00:15:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e3lxwKfF7cWmSwbrkLuXE9HsGoUneG9ziFqwLg2KEp3uH291Y7wWdOTcMaobi5VOHHpiIgqN3a1NXpA/UNA8lTxvOB9Tj7A/qRUKjGI3Vs9RznR6L8EEChGjZZqQVBezoBZ9UAO6h5JiLjTJxKDlwcVkG2wSbzHChoJZMvBDeGrzV625S5ccvhNmBnU9PxCXFzv2VxqJd3nol5MF0PwNx7OxH4Dh0sOR1on2q7tQvDiRfTp1MBseT22fO2aAn557Subk2iTXRZgLrQf7W5b+VrC3kve83fRko/lHalmD3gs/3XzRggM5dQRfF8lf5dT6XNk+OFDJdbWP8TZP7f0c7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s2nxqHjlGUNuNTkrT0KVbBJUPLzNKddNU4j82dVpuCE=;
 b=i2zgj8CI2gZ70lXcaMLOiJyrCSRLt9rp/8ER5RKLRzDAtZ7LTnkQcvZB65tocNrhQ1zuWLZlMsJBOJGku2x8o7QiHQXTHXeCNubZCZWTD/xHQpqWTDMa4hWGfb6Qkf0sAkAkRgjtvcuW9Ahx+hCUHOTIzaiZODkgGwqvnNuZRdspr0XjaEKiDj0BQNu9tJQFUIew62fykdZNPKlXbURGYHBFXf0tCti4bkHATV0ba4z3MQwBf20FwB09HoMJLILlySuMNqplLIPSwkB+Iuhno+oyfPx5SiDQBbYJ0Baum+SNrogdNuMPQbk2AkysL7Ox4/YnSba4K4VskrfnNog1AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s2nxqHjlGUNuNTkrT0KVbBJUPLzNKddNU4j82dVpuCE=;
 b=NJhRDzJOdb4wcD4HCi+1iiC/HbmltTn65rtnrai/EdVrlpLpAj47ohNK5NaHrPXjPvniVBH7KVbAYjaXtGLpzuXilfNqmLWsy3o0m6P3xFcwqZCX0VRqR3fufwb11i1dwgmvXAHerh2ZHc7Ij1jy2v6kuWPqyNT5h3kTNeKGoOE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB5419.eurprd04.prod.outlook.com (2603:10a6:10:88::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 25 Feb
 2022 08:15:55 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Fri, 25 Feb 2022
 08:15:55 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 3/3] clk: imx8mp: remove SYS PLL 1/2 clock gates
Date:   Fri, 25 Feb 2022 16:17:33 +0800
Message-Id: <20220225081733.2294166-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220225081733.2294166-1-peng.fan@oss.nxp.com>
References: <20220225081733.2294166-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0039.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c6::8)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 700979ff-0525-4dcc-2887-08d9f8370b89
X-MS-TrafficTypeDiagnostic: DB7PR04MB5419:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB54196746520CA1BF6AAABD52C93E9@DB7PR04MB5419.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ihUYVUTJjdCl46HtvCRIkJjTT+kXVw4MWTrnML/JqFce9qHIsXp0V+agJko9eldmDSbF7uQleFhC7hA+bye9fNZ7KhTOGb6gN5vrbX0O3MndQTB4VFgRJuTfMIYDhYtizAjrei8hjeySLhMwTmZI2b6iF9kYTezt9Z72xN2JiqI+pfczNjdN423Z+Dv7eft1KEAMYkmcpLH+IUUljYkdsrvWCj3KP4ZEPaOQBOnp5iwB+FCQy+/Cn/YZBlSBRvpPEFb+WTRfdBAXEPozjnPE3nMeeVpL9j47KgyyDmM319WnGn6D36bs121LMpfzn1RrWBzbQEjkIm2RCux4n3kk4p9c9EwvJG8Lt5Z7b7KMmtocEugZ4gxsm3htT3MQ702Z0YcwDOs7PRZFBaIIBNSDisbwJOyZEKDFQH1OWtZa/wpfjBUICoWae5m9H81QxsPLdM4GUSv0fEkZ4YDv6LVLbtSN/43WApoFHx2YEYUoRyREGWwIlggLK1SnsqkALPa1dWrTN40SWWlTyBJ36TJEw2mFwGBuf3yyBNj5o6O+x6WXfmPdD8zc3S2amXsmFuTXuXT8pD9zmjbXkrKC3IOFOYBYHWNkFO6I6MEf4scY+QwiAs5qHCDVwggFL5XUFWgwPeIAAPbhs4apy4Lt+hxhnNd3kQ7N/E7oeVxOCPPuagLAc5sYI7x4agSvhMehapi5ofOGnWs+eyY+dRcZe87Cllu+xoPN3OoA37IvpCHF+w0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(1076003)(6666004)(7416002)(26005)(83380400001)(5660300002)(186003)(8676002)(6486002)(4326008)(66946007)(66556008)(66476007)(38100700002)(38350700002)(508600001)(2616005)(316002)(6512007)(2906002)(8936002)(6506007)(52116002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?67WEaPzNN5KLn1uRU2AANFdCzPPfOQTyh0IebQCUepJKRziRmmRcqWBHOUcS?=
 =?us-ascii?Q?qrvc8XiYiML9MS64UXzSnrFxRpfO51etFDSVOUtMbs5vBMygvrd0zu2mZdxA?=
 =?us-ascii?Q?d+bDHYPZpeVTUBr5DYjR3BGOpyRQw2OJ+xAcprZkIbluO3iULsNySNfTdJdd?=
 =?us-ascii?Q?O0VzyF7g95oO7kxcMwP8BtCm/Nb/dnJqwLDa0KyWAGkuySYVsaSHKaRbdNWn?=
 =?us-ascii?Q?fxoObH2WdgTt+zcLc+2glnWqGKejL7mXoxy1Ee0xD3TpLts2fQGJa4weKO38?=
 =?us-ascii?Q?MIQb+nma4xH2/g/+3hTIQEe9j/N9/ekTmO7aEywRtaFEDTbh3BM15p3LGRq/?=
 =?us-ascii?Q?Ewy3g4cM8jExCJ5XYzo2UKkTFJRzfKN48PCROd78j1Igx+f7zS0c66TeXB/M?=
 =?us-ascii?Q?RV3OMSZBgXohjM1aJtFrE5MhBdtRhQ/pTqVcItizjBhBXdgytSgLJz2aCe67?=
 =?us-ascii?Q?9xJrS0rOK5EKJAwyGWyKdm9tMEiN7bNh2KfnElTuH+NQIouH+lLKiULEFpZX?=
 =?us-ascii?Q?TOoIfVMrfdXWRyd95uGhvHqrx6OgU7k48acp9TeUA1KeDI+YULxNjkv+zhvG?=
 =?us-ascii?Q?CwfJqpFY0+BKjOdygw6VpG20hfaSgMmOcADP3noKzWhDBhc2OtnGVsA+fXxI?=
 =?us-ascii?Q?ctRkunerJImz70SeMTadRoP+v24hxHJeLSX7wJX9y3DtNBBvakSz+onkWb1D?=
 =?us-ascii?Q?5W+YafKtBukfr1ZBQEUmyW9L/PgGhn9uWu+ZwnThR9Dwb3Lc5ndlIquUUPP0?=
 =?us-ascii?Q?nKyGg4SEHy3R3fgMzUZssVmdjZ5tAkHRO3JBSwwcMUTR5wmIUIFiefRLm8zo?=
 =?us-ascii?Q?VRZil2qm5SOQiNFqhJW9rHgZPPkXqPAUzsy477CXFbO1CfcpkAfqgstgU1Lf?=
 =?us-ascii?Q?U67DamEYKXoTfuztvClvputQoAo1Qjv+G76ZeYCZVXnAYuxqSvTLo/7btnTp?=
 =?us-ascii?Q?9qnJk7F9LRFcPCJDgCyTupD0Jl+258OCERo/FL9ToxGsDmr/xn/OZDegWs5a?=
 =?us-ascii?Q?AIy/PHW2TTlXnt4/q2/XkAgZNx78IYG0lJb8Ps8icpOm2p4mIi59N7gqYMmQ?=
 =?us-ascii?Q?geNE0aVCjaazTZ9KtvXVdPLxyApUsJZmK7BhSDfmr2KWfqEXnHOl120zP43a?=
 =?us-ascii?Q?oUT77suppbD98siTOili8RziVTXMG6+mBMd1w4OG/PSMgbJCkig9AmJISky/?=
 =?us-ascii?Q?MqKRSBWLGwGAqCmVSbc0leItr+RNAnVU8pNeCE9+xnR3GJo9t5rbYRmVAsv1?=
 =?us-ascii?Q?XT2Enpi3TGlesUdmwkimVZbJ4Ck60mMk7ic64DnFQtiydvmm2izCVUFmMytv?=
 =?us-ascii?Q?kuT25qIJapzL4tLXbMVay/Mo5Yh5GVdQV7UpyG9Qrj8StXcuQC8SB/A4iHPJ?=
 =?us-ascii?Q?8d2K00rIrEK9KUTzCjO7vYll2SAcPIwjijC6+dwYOiZbzU4MEeBVleYK+j0v?=
 =?us-ascii?Q?EXH2fT/zt+sbiJHzUiibgBQUxg+2hyiTtT9L+hjS6O5HpAuoe+21MGsgDqg3?=
 =?us-ascii?Q?vGM3EdzPiJ1vWey+3kA/YsTz71bbVD9+tjPTT/Sc4EM/Vdrf1N+sJYf7ybhY?=
 =?us-ascii?Q?2T4uSmXXsCgW2LPUPEjOJ36cctfDCyDY+ze7RO0SRnrsOa7X07E8GrrRIOqR?=
 =?us-ascii?Q?WnIDAUKojl4lyuyn/s0QxPs=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 700979ff-0525-4dcc-2887-08d9f8370b89
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 08:15:55.1782
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nBTa6RyVN8nz7ZqHUPfgad1kYUlsEwLIJm7WC0B6/UPek9lJtaC3Whcij9RAmUv2pblkcJp8CiO7HxW9O+n/sQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5419
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Remove the PLL 1/2 gates as it make AMP clock management harder without
obvious benifit.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 drivers/clk/imx/clk-imx8mp.c | 48 ++++++++++++------------------------
 1 file changed, 16 insertions(+), 32 deletions(-)

diff --git a/drivers/clk/imx/clk-imx8mp.c b/drivers/clk/imx/clk-imx8mp.c
index f23b92906d3b..18f5b7c3ca9d 100644
--- a/drivers/clk/imx/clk-imx8mp.c
+++ b/drivers/clk/imx/clk-imx8mp.c
@@ -480,44 +480,28 @@ static int imx8mp_clocks_probe(struct platform_device *pdev)
 	hws[IMX8MP_ARM_PLL_OUT] = imx_clk_hw_gate("arm_pll_out", "arm_pll_bypass", anatop_base + 0x84, 11);
 	hws[IMX8MP_SYS_PLL3_OUT] = imx_clk_hw_gate("sys_pll3_out", "sys_pll3_bypass", anatop_base + 0x114, 11);
 
-	hws[IMX8MP_SYS_PLL1_40M_CG] = imx_clk_hw_gate("sys_pll1_40m_cg", "sys_pll1_bypass", anatop_base + 0x94, 27);
-	hws[IMX8MP_SYS_PLL1_80M_CG] = imx_clk_hw_gate("sys_pll1_80m_cg", "sys_pll1_bypass", anatop_base + 0x94, 25);
-	hws[IMX8MP_SYS_PLL1_100M_CG] = imx_clk_hw_gate("sys_pll1_100m_cg", "sys_pll1_bypass", anatop_base + 0x94, 23);
-	hws[IMX8MP_SYS_PLL1_133M_CG] = imx_clk_hw_gate("sys_pll1_133m_cg", "sys_pll1_bypass", anatop_base + 0x94, 21);
-	hws[IMX8MP_SYS_PLL1_160M_CG] = imx_clk_hw_gate("sys_pll1_160m_cg", "sys_pll1_bypass", anatop_base + 0x94, 19);
-	hws[IMX8MP_SYS_PLL1_200M_CG] = imx_clk_hw_gate("sys_pll1_200m_cg", "sys_pll1_bypass", anatop_base + 0x94, 17);
-	hws[IMX8MP_SYS_PLL1_266M_CG] = imx_clk_hw_gate("sys_pll1_266m_cg", "sys_pll1_bypass", anatop_base + 0x94, 15);
-	hws[IMX8MP_SYS_PLL1_400M_CG] = imx_clk_hw_gate("sys_pll1_400m_cg", "sys_pll1_bypass", anatop_base + 0x94, 13);
 	hws[IMX8MP_SYS_PLL1_OUT] = imx_clk_hw_gate("sys_pll1_out", "sys_pll1_bypass", anatop_base + 0x94, 11);
 
-	hws[IMX8MP_SYS_PLL1_40M] = imx_clk_hw_fixed_factor("sys_pll1_40m", "sys_pll1_40m_cg", 1, 20);
-	hws[IMX8MP_SYS_PLL1_80M] = imx_clk_hw_fixed_factor("sys_pll1_80m", "sys_pll1_80m_cg", 1, 10);
-	hws[IMX8MP_SYS_PLL1_100M] = imx_clk_hw_fixed_factor("sys_pll1_100m", "sys_pll1_100m_cg", 1, 8);
-	hws[IMX8MP_SYS_PLL1_133M] = imx_clk_hw_fixed_factor("sys_pll1_133m", "sys_pll1_133m_cg", 1, 6);
-	hws[IMX8MP_SYS_PLL1_160M] = imx_clk_hw_fixed_factor("sys_pll1_160m", "sys_pll1_160m_cg", 1, 5);
-	hws[IMX8MP_SYS_PLL1_200M] = imx_clk_hw_fixed_factor("sys_pll1_200m", "sys_pll1_200m_cg", 1, 4);
-	hws[IMX8MP_SYS_PLL1_266M] = imx_clk_hw_fixed_factor("sys_pll1_266m", "sys_pll1_266m_cg", 1, 3);
-	hws[IMX8MP_SYS_PLL1_400M] = imx_clk_hw_fixed_factor("sys_pll1_400m", "sys_pll1_400m_cg", 1, 2);
+	hws[IMX8MP_SYS_PLL1_40M] = imx_clk_hw_fixed_factor("sys_pll1_40m", "sys_pll1_out", 1, 20);
+	hws[IMX8MP_SYS_PLL1_80M] = imx_clk_hw_fixed_factor("sys_pll1_80m", "sys_pll1_out", 1, 10);
+	hws[IMX8MP_SYS_PLL1_100M] = imx_clk_hw_fixed_factor("sys_pll1_100m", "sys_pll1_out", 1, 8);
+	hws[IMX8MP_SYS_PLL1_133M] = imx_clk_hw_fixed_factor("sys_pll1_133m", "sys_pll1_out", 1, 6);
+	hws[IMX8MP_SYS_PLL1_160M] = imx_clk_hw_fixed_factor("sys_pll1_160m", "sys_pll1_out", 1, 5);
+	hws[IMX8MP_SYS_PLL1_200M] = imx_clk_hw_fixed_factor("sys_pll1_200m", "sys_pll1_out", 1, 4);
+	hws[IMX8MP_SYS_PLL1_266M] = imx_clk_hw_fixed_factor("sys_pll1_266m", "sys_pll1_out", 1, 3);
+	hws[IMX8MP_SYS_PLL1_400M] = imx_clk_hw_fixed_factor("sys_pll1_400m", "sys_pll1_out", 1, 2);
 	hws[IMX8MP_SYS_PLL1_800M] = imx_clk_hw_fixed_factor("sys_pll1_800m", "sys_pll1_out", 1, 1);
 
-	hws[IMX8MP_SYS_PLL2_50M_CG] = imx_clk_hw_gate("sys_pll2_50m_cg", "sys_pll2_bypass", anatop_base + 0x104, 27);
-	hws[IMX8MP_SYS_PLL2_100M_CG] = imx_clk_hw_gate("sys_pll2_100m_cg", "sys_pll2_bypass", anatop_base + 0x104, 25);
-	hws[IMX8MP_SYS_PLL2_125M_CG] = imx_clk_hw_gate("sys_pll2_125m_cg", "sys_pll2_bypass", anatop_base + 0x104, 23);
-	hws[IMX8MP_SYS_PLL2_166M_CG] = imx_clk_hw_gate("sys_pll2_166m_cg", "sys_pll2_bypass", anatop_base + 0x104, 21);
-	hws[IMX8MP_SYS_PLL2_200M_CG] = imx_clk_hw_gate("sys_pll2_200m_cg", "sys_pll2_bypass", anatop_base + 0x104, 19);
-	hws[IMX8MP_SYS_PLL2_250M_CG] = imx_clk_hw_gate("sys_pll2_250m_cg", "sys_pll2_bypass", anatop_base + 0x104, 17);
-	hws[IMX8MP_SYS_PLL2_333M_CG] = imx_clk_hw_gate("sys_pll2_333m_cg", "sys_pll2_bypass", anatop_base + 0x104, 15);
-	hws[IMX8MP_SYS_PLL2_500M_CG] = imx_clk_hw_gate("sys_pll2_500m_cg", "sys_pll2_bypass", anatop_base + 0x104, 13);
 	hws[IMX8MP_SYS_PLL2_OUT] = imx_clk_hw_gate("sys_pll2_out", "sys_pll2_bypass", anatop_base + 0x104, 11);
 
-	hws[IMX8MP_SYS_PLL2_50M] = imx_clk_hw_fixed_factor("sys_pll2_50m", "sys_pll2_50m_cg", 1, 20);
-	hws[IMX8MP_SYS_PLL2_100M] = imx_clk_hw_fixed_factor("sys_pll2_100m", "sys_pll2_100m_cg", 1, 10);
-	hws[IMX8MP_SYS_PLL2_125M] = imx_clk_hw_fixed_factor("sys_pll2_125m", "sys_pll2_125m_cg", 1, 8);
-	hws[IMX8MP_SYS_PLL2_166M] = imx_clk_hw_fixed_factor("sys_pll2_166m", "sys_pll2_166m_cg", 1, 6);
-	hws[IMX8MP_SYS_PLL2_200M] = imx_clk_hw_fixed_factor("sys_pll2_200m", "sys_pll2_200m_cg", 1, 5);
-	hws[IMX8MP_SYS_PLL2_250M] = imx_clk_hw_fixed_factor("sys_pll2_250m", "sys_pll2_250m_cg", 1, 4);
-	hws[IMX8MP_SYS_PLL2_333M] = imx_clk_hw_fixed_factor("sys_pll2_333m", "sys_pll2_333m_cg", 1, 3);
-	hws[IMX8MP_SYS_PLL2_500M] = imx_clk_hw_fixed_factor("sys_pll2_500m", "sys_pll2_500m_cg", 1, 2);
+	hws[IMX8MP_SYS_PLL2_50M] = imx_clk_hw_fixed_factor("sys_pll2_50m", "sys_pll2_out", 1, 20);
+	hws[IMX8MP_SYS_PLL2_100M] = imx_clk_hw_fixed_factor("sys_pll2_100m", "sys_pll2_out", 1, 10);
+	hws[IMX8MP_SYS_PLL2_125M] = imx_clk_hw_fixed_factor("sys_pll2_125m", "sys_pll2_out", 1, 8);
+	hws[IMX8MP_SYS_PLL2_166M] = imx_clk_hw_fixed_factor("sys_pll2_166m", "sys_pll2_out", 1, 6);
+	hws[IMX8MP_SYS_PLL2_200M] = imx_clk_hw_fixed_factor("sys_pll2_200m", "sys_pll2_out", 1, 5);
+	hws[IMX8MP_SYS_PLL2_250M] = imx_clk_hw_fixed_factor("sys_pll2_250m", "sys_pll2_out", 1, 4);
+	hws[IMX8MP_SYS_PLL2_333M] = imx_clk_hw_fixed_factor("sys_pll2_333m", "sys_pll2_out", 1, 3);
+	hws[IMX8MP_SYS_PLL2_500M] = imx_clk_hw_fixed_factor("sys_pll2_500m", "sys_pll2_out", 1, 2);
 	hws[IMX8MP_SYS_PLL2_1000M] = imx_clk_hw_fixed_factor("sys_pll2_1000m", "sys_pll2_out", 1, 1);
 
 	hws[IMX8MP_CLK_A53_DIV] = imx8m_clk_hw_composite_core("arm_a53_div", imx8mp_a53_sels, ccm_base + 0x8000);
-- 
2.25.1

