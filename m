Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707AE5AEF51
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234030AbiIFPrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbiIFPrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:47:09 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2057.outbound.protection.outlook.com [40.107.22.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE0B5C7BA6;
        Tue,  6 Sep 2022 07:57:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ckPtqePB11/x/Pruhucg9gujc45MFxhWMDDmZ3Naz+7nrZiiQmGV3U1hhMdzsR2PJhDFkD12m6tGMPUXLGNOjk6nxfRFaruvuPXxk5CZbI2iyTFW6w+R1YHzlURdBxoXhFBeUQOWhLiewKpIhJ9Y4mtJj+cleosYgUPeIMFEY4pnTygYSpo4yGla7ypYNLUSaOCptrl2QjWnVRnOlqNg+4HiRGTFEcxVCxN61+S05U9x+6NMOkBbMX2K5nk4cH9hNPBBHwZs10t3+o0XjfQ2bFjobubNRw/C7RRvMOlW4bBh3fUOWe0YO32x/SkTuS0eZuq4OUKww0U5XESSTbyraw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6PZ7i2t2MIKTwxEybY05L44KbQTChqNFvulgZvvzr5k=;
 b=NJGorLDnfT/dwPDkaUqDkeEcpVMU5V0B9d+deZebNP3YLq4TGm7H6YgX1ajMBeYx3Jeq3SkqhYCYTzXT31d9VGPqN2NDkiT4WTPXZjXQFaY323WXOjilKLCNNN0QzJYHEz8sZ//aTf8UxAntcmDNyykhChHUauKeZ1x0TDzmD5/G6N7cCzR0HdBJD+Lxj2sf4u7GwhGR7PwWeFMOb1MQYU0OZ99wRXFoIj7CvuPnV6BlgMI8RDDYX3teDW2+0MhcegJhPhcWWXW51gp1AoYE2Iv+TYEKOeA7UwuIsIKfyad5hoQhTX8z7GR71CgROdvMJk0BRHKYOrSc/hjAK5obpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6PZ7i2t2MIKTwxEybY05L44KbQTChqNFvulgZvvzr5k=;
 b=Y6NgA1e6IkV5e+7dWVkPoX+vrZedZQ0osAgCM/zcTieq3iwkffmlsOhLMdF7VOoyf1kG3r/MxBHk6HWZSZ7al/fZxoBbg/9oPGaXgl5hJspU92Z/mc4SlqgQZ+ClX1kSK28gIK35aZDpsf/9+7lZrjwqJUuDVyh3rH3d44Y3QAc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DB6PR0401MB2343.eurprd04.prod.outlook.com (2603:10a6:4:4a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Tue, 6 Sep
 2022 14:57:16 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b152:60ce:3622:7962]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b152:60ce:3622:7962%4]) with mapi id 15.20.5566.021; Tue, 6 Sep 2022
 14:57:16 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Marek Vasut <marex@denx.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>, Ming Qian <ming.qian@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev
Subject: [PATCH RESEND v7 3/5] arm64: dts: imx8: add a node label to ddr-pmu
Date:   Tue,  6 Sep 2022 09:55:26 -0500
Message-Id: <20220906145528.40079-4-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220906145528.40079-1-shenwei.wang@nxp.com>
References: <20220906145528.40079-1-shenwei.wang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0055.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::32) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 80992176-b4b2-4930-991b-08da90181686
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2343:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XNQe91lfGsIB3vcWXVDT3rnRO56pamqYLU06WrOORIky41rvOqvJpymEvPUknXcal3eSeS9NXjjIqz2wk18lo7S8Z/4Qn72cHa+9ypdqoFiPZJn1l5XELchkSfFZvac2Hu3cz6SiTMtFPgMApQzc/igGi1AmupLxad8XrKZUNcWnlcURCzDo/xQOTkjKwdEN5k/PqmEFTFq3eTP7Dw9+fp8MYSJphB8uPLzuOFLKhzlEBuMCGn53rfAEIEuBqeuFJVZGZtYxN4e9tTxR8cJfTQDsBEwfBJ179K7GZP+FP39JNvPAQtmUqW1NGoC+/q5d/Z30pXhNOpWg+T5FihyGLq9+sKkvHIfklEPNq9hhKyII0OKGnBtmvmiqHgkNIbpQfe/lmQJHiw0AEJGiW1GWSxbnv1GNgPdfZeYKV4KitV6BMhITp9+y/x8biTKMJg7VBgBl5bAacC7Z0NR5SjOvSp38pHX6799tKCA+wv6bx5qbs5r0qNoOn/FEQkSONSo9g+PvfdbgcOXYlIgP9pOd26oHcO2j5lOWzPUU29MTfVNq8Cen098DHjWRnv3UGPj/BLvDuTShO69+bHehd7cKJwSTLV94mAN1GhpJBuze9nnlNghIui/iCpkWeYc7ZgiY6/5NMuDj9sfosdTKQlgb3UxSuOsj+lJ08xNkG3gjuRs6u26PV1/2IzafKWFjNdRfyqM6z5MHA5IHr//ZeWM+pMOGXFrgJVpY/brLAV39usp6qssDVNYqFopK0LZp/6W0ge3rEsaUFqg6nrZ++iRmEQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(186003)(1076003)(2616005)(41300700001)(5660300002)(8936002)(83380400001)(316002)(54906003)(478600001)(55236004)(26005)(52116002)(66946007)(6512007)(44832011)(8676002)(38350700002)(86362001)(2906002)(6506007)(66556008)(6486002)(110136005)(4744005)(66476007)(7416002)(38100700002)(6666004)(4326008)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7ps7ukZorSkasH6P1jdgo2akQbSLoSCm4VmSPQlPW7Qwn3avYzF4qDBEcL4r?=
 =?us-ascii?Q?n7GFoQ9PEjxVItJgHMod7SnhtPPfw/wbkT5HooppeIVVgz/o4yaZuezTGrtz?=
 =?us-ascii?Q?FDTEJhanuKm//lN7P8J/oPfvF3V+0NG1TF5rnc8l7rLi92vYpuB2J9XaQynH?=
 =?us-ascii?Q?b8CYOt4c7ySJ/yEIURoLn8IaMiyvZFbJ8nEGR+V8W0Kx7uzCZPmd24+Pz7o2?=
 =?us-ascii?Q?SopcP2rH4YxnA0A/vj9Um2SQiDVFOCgXJU1Gtdbj16xufoMxrQQlphNqV+ci?=
 =?us-ascii?Q?GrLoDKu7fk29G1KdJFafm7jDlKfCMsw2dGb4R6ccbWnwVCHvp2DaLJqrdlIH?=
 =?us-ascii?Q?JcPkuKHmrnIGuWhm2BgZHL1CapnuMz5rLcPSL0xLPOUksFREhFejhWE1Py13?=
 =?us-ascii?Q?YOomA1aPOzRifjT0LdKicDmZ4aqMAO6RTo357woLowTfNoHwMsquJY7PmX5F?=
 =?us-ascii?Q?4tj/hprg554yxd5n/G08uQ81Jmi7JAMTSWNLnpkV9/VXr3jufFGNWg+HxNc3?=
 =?us-ascii?Q?iLGdyAg5RTz2Ik+sAfY7V7Y0oeiooyWDwEADE65Hm6taG+/MSBNuArMRqYvN?=
 =?us-ascii?Q?3/kSTwh6tDb2N2EfVGvMQedEbb8CxvHDLe+0aQv3sX4+uiV37KjqSNd/u1R8?=
 =?us-ascii?Q?ImUwDUIH54dYTMdWmkUxHhJ6WJxAqqwa0N3KHD3tcVor3bUwSU3ckGmVWHi0?=
 =?us-ascii?Q?ssf4/cp0iBhQPKfwJqbDSdMT3ZNkAt04iOs2okmQUtcVPp7Mg+G2YZbMSLmW?=
 =?us-ascii?Q?P0Kk14AqfIztgLDqY1A/DC6xzfAMyzdaBO7xkD3dQRjXuKYtRrYgTEiir4ju?=
 =?us-ascii?Q?DnYpbdV2+yskIHZDczTE9do5qnKEGvP2xJBAbGwSkc6ChcTI+vqB2ZgmAwAw?=
 =?us-ascii?Q?bgdufm2fjfTXF4tOMzkuR1vrTc3rot4mMzWP46PaE4IB6xK7F/yfC4NciaBL?=
 =?us-ascii?Q?Qmb/tvdtkaeeGNY5GMszA3L0NEKtf+4rfXQELnAklU+S5mF/trzcls/jnZ0c?=
 =?us-ascii?Q?e+5wn3iH9/gnJaEhYmXyS0uCjHwDR9+4YDJif8QvujB4eR9cc+FzjiPOiHlQ?=
 =?us-ascii?Q?yRWMOsTENCJixI6YIraXQnnqx3onuGLhWge4ZNy/4LfY0E+fZrZGUQA6hVbR?=
 =?us-ascii?Q?JQKw4i47400grH3Pe59OG4IZycarivXs77+qZax8xig5Fa7yPgVUUKAWsCn5?=
 =?us-ascii?Q?TfKi/LDuQXP65qlA7TTMi0nGW7H5nf6U5fgd2q1gm+04Mls0jNFHQ8rgxfb/?=
 =?us-ascii?Q?6i9kwZDYS5wcW1WixMW9GoTYF/BKw1Bz7LtWmAGCffBRZomzVP+bg82hvM5g?=
 =?us-ascii?Q?TDgb+kuV+8m3YCJKM4XPxT/xHnsnb9QejTbS6gWRC+QuUYg1oo0iBeYPceT3?=
 =?us-ascii?Q?9N90EdSAk6ME3/wur6UH4H8/ED2wyr4me39X3tkNzDlqiAb1tGp2qRktE5gR?=
 =?us-ascii?Q?VGJdQtQXTYKfQQCwt7GqsgzlbMHYh/2hJ5CvnIdWi5qRAYnFsOHeNbfhhQXF?=
 =?us-ascii?Q?CSJzNDTK/cSP2j+Cv4wPrxsE7VHVDEq0mrpj5MuIuGzZxF4ModVPlojJY/DR?=
 =?us-ascii?Q?DtL0cV4aKM4mFuGafDJEoiBVHAOiaB+HY8336FKh?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80992176-b4b2-4930-991b-08da90181686
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 14:57:16.1474
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mJW9N2eRWH5jqicsoAVk2Oh+BLbMK2hwczDFuPBNDealc1YVNJwsKwots9+R7MhfdMHzKgF7bZ11978alUwzKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2343
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ddr-pmu on i.mx8dxl has a different interrupt number.
Add a node label to ddr-pmu so that it could be referred
and changed in i.mx8dxl dts.

Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi b/arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi
index 8b5cad4e2700..7d5183c6c5be 100644
--- a/arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8-ss-ddr.dtsi
@@ -10,7 +10,7 @@ ddr_subsys: bus@5c000000 {
 	#size-cells = <1>;
 	ranges = <0x5c000000 0x0 0x5c000000 0x1000000>;
 
-	ddr-pmu@5c020000 {
+	ddr_pmu0: ddr-pmu@5c020000 {
 		compatible = "fsl,imx8-ddr-pmu";
 		reg = <0x5c020000 0x10000>;
 		interrupts = <GIC_SPI 131 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.25.1

