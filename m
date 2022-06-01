Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9396C53A10D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 11:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351376AbiFAJpx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 05:45:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351395AbiFAJot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 05:44:49 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2053.outbound.protection.outlook.com [40.107.22.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4655D19E;
        Wed,  1 Jun 2022 02:44:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FPtmMpzaja7djBPXD39VWElqIz0CBkuyuQl4bfBl0VGs+DUnasXfhl5jpncdeO27sYLeIe8OqqBCo8Q8F+9O+mRQiwNVQVGHmOnX4u8DTpPd0pdhDguM53FMmpUOsjBsQOEoV2UXVf8zkmzGh/BizUgjcyQhokaloCrM2tl9T/ER7zK79qs9uypkufzlHISxPs+u8Cnezh/CqBmEMZ96mdQtHtucjHZbKvRz8ytHc1g6R2Y+/bO3prJLSxO5nVW8Y4+Dtm6RsEfWXeCBm//YUT+xrm7N3gl3SanOA6z2scPP9VJhle1OJ3o6L/vYYhdLoOEJUsPK4ePLyzOS10oJpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=int3Q9ffVbbYadDl18niA48u4k4B1VUGpTO394TGJ+g=;
 b=GerXyB1D08vUtm1COnsLOgMVJdHOoGgx8WMipbTR0bCtQkLCB+rEgWhg9JhfeWoEoCRjxqqQ2us0E/eyicpJHxWb/7ZSVqTb04mnddSDJ1NfQWIhoDKaK3B78YvMHxQevGGoGjbPu3EK9RNizFHz485Pvi+0x7uysYdZEpAapiEwcGlrajjML0BC0fp7BZObGiR+eerS5g45cb4E2k5n55ypzb1cCwLoysGlkuo4vHFeTnVVP4MeIMv07+NRJ+Z/ThEK5PcKWCq4IRWG7VjO8hpDwwc83una0+ZMnR7rpkEHQZkKhjEcwPD7Ds7uFRShTKsqP/7+IY5Cw3jBWbfmjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=int3Q9ffVbbYadDl18niA48u4k4B1VUGpTO394TGJ+g=;
 b=R7/PoaJC+asxkzLeLQPYVe7+7VKapgEf3pMscnK6YZ/cwQq7pXR72n3lycBFPgL6O6wmmRFnczg79tcC8491bDR3XP/uBUpxzieTDLquV9NGY7yrYDIeGK4/3vb4mvzoHJ/53GYgEysBZcYtHkyTEfpJvtwa4FgjkjknsvBVZ0g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB7PR04MB3993.eurprd04.prod.outlook.com (2603:10a6:5:1a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.19; Wed, 1 Jun
 2022 09:44:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::a892:e4a9:4769:13a5%9]) with mapi id 15.20.5293.019; Wed, 1 Jun 2022
 09:44:44 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     djakov@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        festevam@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, abel.vesa@nxp.com,
        abailon@baylibre.com, l.stach@pengutronix.de,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, Markus.Niebel@ew.tq-group.com,
        aford173@gmail.com
Cc:     kernel@pengutronix.de, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 8/8] arm64: dts: imx8mp: add interconnect for hsio blk ctrl
Date:   Wed,  1 Jun 2022 17:45:37 +0800
Message-Id: <20220601094537.3390127-9-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220601094537.3390127-1-peng.fan@oss.nxp.com>
References: <20220601094537.3390127-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0185.apcprd06.prod.outlook.com (2603:1096:4:1::17)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dfd6f216-66a5-48a8-3a00-08da43b35b68
X-MS-TrafficTypeDiagnostic: DB7PR04MB3993:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <DB7PR04MB3993E82A8B3411EF1AAAED5FC9DF9@DB7PR04MB3993.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YnQLEEa+YcmOrT38iTRqw9EIKitV9PvBwwzf7JVn6ZDIYG/6W0R6/NeH4NO8X3GXXy3A0dH/G16+ZF6hm08HXFw8lGlnUGJ83rHksJwlVp8+p6lXwS09izoKJo3nJejiQ4gGxIsbsH0/o8mhleMJgvcl8LqJXfQjr/nhRTXZPVKs2L0QhPKUa2Q8vWbCx/+N8Hq7b0XyyeV8pP60fMo9HipePEm3yhJ/UMtbPO9oH4DgpBap2aNQwDJmS42pTnZqWzYPFRhl8mxMOJFsx+jdNU2mjugNZmgJSiIgly+TW1pCnxgSYXg4zJPYenENhXaiSkx8k09XGHucDpFo+W8x23Cs6C7sNKndtG9XeXpZFbmo9Be5QN2SZHNN6nV6DEUqKrhfL3fkEcQSB31Dd4m7aBxrsVR9gh4kCvOwrWG9JmqO3+POd2qO0ORqGz6TAdVyxSQCx/pWfPogKSQUwjegWlW6qSnV39iQq3ZU0i5ShgNIp5PGd42M43yaaQGC/Rmmx5JN2FSkSXcjlJ9BTnYCHgNQBtRD2TPZylosb+tvpine89H1YJyL0/LsGqEe+5NqztkkgXW6wx3TZsgJBBoIRh8Pu8T3ZemlvvrSBhCtCj3lUpYjuXEE7L+0qRfiWeo4FmHiQN84Qc5/rytou9lVWUwTtn5MQB2VDK/16Imkk4wdZ0wtFRHRu6E2rBQ2sfcS/WpLW3dsR8vb2bCtqP1fOsJTM7kBO2i24Dd+dGSXfC1n0Mn4wkm6DR121v2hIftG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(6486002)(8936002)(921005)(316002)(38350700002)(6666004)(86362001)(66556008)(66946007)(66476007)(2906002)(8676002)(4326008)(38100700002)(5660300002)(26005)(52116002)(1076003)(6512007)(4744005)(7416002)(6506007)(2616005)(186003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kHBUhGOhv5P/1UaCmPXKMMGj+LaklzN6PHRIXdKn8W6hNz0JYYnWPBQDeQwL?=
 =?us-ascii?Q?/t36Z6C33EKbNe/mahwb5YHq0wLLZR5csd1Z9zJW7DoQsYeHFV6ymxnMUorA?=
 =?us-ascii?Q?sVHXnzVmoH+Lm+AxRTPHgJUF7WaxdeyJFcsdbn473aOFSPgh+LJWPiofxqZI?=
 =?us-ascii?Q?3/iO1vlkMr+skY+ZxOTolp2q7pz6bgGpXlWgMrRpsavdZ/vQJwCsNxY3OBx/?=
 =?us-ascii?Q?Ga+45eR5Ed+wWzaZIlxyqZFc+FgPT5aKjd9jvuzGXuWz9v9EsvTrMR04yj7w?=
 =?us-ascii?Q?kNwBOnnApEZEvTqsLRfed8uowZyVKweq2soMUSJTNbxybPaovePGWWgJBOOW?=
 =?us-ascii?Q?h9rgmd4R7e6AHjlaN/M+Aq5zpcytS2gYj673Z2GPQnash+bNC85G/35Upork?=
 =?us-ascii?Q?PyDZIMkLDGtdHPnA3W2ZNlu5q54bmcgbbq6YEaNz3h8GUpukfzYlEYtO7Iv2?=
 =?us-ascii?Q?SdkcYoIIRBc87nRyKpTF7Lk2yd5G6e7ns9teL1hijL+XEtuGAEtB/G5ZKNSI?=
 =?us-ascii?Q?WonsvITdTIrtq423Wajtr6uHUKCPlmy2bpXNjpyq6K/fjTDH/+TwrAmChR8o?=
 =?us-ascii?Q?zjYqR9fV32TFjvGZS+33FPyD6Azx5W1he7kmQjcyTSvPVZZsyQQ1E3SafNrd?=
 =?us-ascii?Q?2HYXmexWlDyskY3yqD3IM9SfB2Cv6uVTBttVPZZZC0G6TWdifqJqCGzP5jbo?=
 =?us-ascii?Q?xZGPW+KzJqpliNw5dh2w3v1+3vRG4FE/2r7+wlVX/DD4pbzaC4NDRUoEEEuh?=
 =?us-ascii?Q?Z/yI3UtSIOfOlYCWBFHKcfqwxPNp4UNFbj1IZTJ/ZhIuedqEmACLSHaEO10L?=
 =?us-ascii?Q?R9RH/ccdkeFO01L0uVE2nV/2QTmHpKtPeZKf2cpci4UTih4IKNm89MASjEqJ?=
 =?us-ascii?Q?xlrfc9MDiEuxFW2/BKXMW+h2JWPPVKeIELe+aFniiydn2hPrG2vGnxMI1PA5?=
 =?us-ascii?Q?C9Ytl2q/+N0muLgmSsmssA5VgHPYr7huYn4YYnW23knAPqpoBt8+k+79h9Nm?=
 =?us-ascii?Q?XmrOqoSCJsbubV15viCAh8owV3DI05OJHeuQRgX4uTHk43MUenlE3i1VnqNK?=
 =?us-ascii?Q?tUIUwzdlrMJMeVJwP6Xh06/4VRVh3e2GeKdhaixzme8ztZ/QLnWGSB0phEUB?=
 =?us-ascii?Q?xjsCuw/4uKHcLaSRw2zZKZgiqTlYIdMn82yjA+zGmAG2DlrJklVJuttMnj0A?=
 =?us-ascii?Q?JnSdTiMhIayP3uJ0+SDABrO7IOjzK9aW/nHtcSy2bIs4RK9MvdUuGiSC7Q/C?=
 =?us-ascii?Q?rscuh2LlhVPro6Rk66yBjk0nPCJV6Vge6Lmx2ihrK2FLxK5O8l7jTUyw+SOc?=
 =?us-ascii?Q?pKNbaXYBckKkz6i2aMihjGnsa/odnPsGebSn8a1nmN7y+YR1AFlfAner2Ldc?=
 =?us-ascii?Q?uTIZZeXq+8Q70FYJNtPpuqY8Ekyy4vl4UVETzUMPYkmXMEwddsF8S+pQ11eA?=
 =?us-ascii?Q?iKO5lveIAUXz6caWlpDn+MB9NWdS6RP7/q7tMivtABUHsQW5X9eLYmh6zkyW?=
 =?us-ascii?Q?6scOenOrurk4n94tO8mz7TtJmeg9lX8Eve/zRcHL/vwSkvvnZetSAkT5nKgN?=
 =?us-ascii?Q?tNpECOAH8vi/6AMNMr0Jc9dg1H7ug1QtMUUZJV1vyRUXt9cZW9y8pHX8CIaL?=
 =?us-ascii?Q?lgPS9k7opGJZvKlhAN0svVDyn3Hhc0+c8tiAwrnW+mNxhaDlEtvdjoN4tx3k?=
 =?us-ascii?Q?hGq89ZgbwUZwzqkb8ZUdvSEABthgzbav0WraRFeDpATivECBqthFr8ijbGFH?=
 =?us-ascii?Q?tL1TlXeVaA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfd6f216-66a5-48a8-3a00-08da43b35b68
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jun 2022 09:44:44.2172
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JknvmtZGabufEpPZJc1eUbPnmifSgZvLy4BOpzFDguNPg8u6//7NfzF9Gs4P8UHjAgl2Rf0Ut/4zZFsqmwikJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB3993
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add interconnect property for hsio blk ctrl

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 53813f6766f6..95a666050906 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -1108,6 +1108,11 @@ hsio_blk_ctrl: blk-ctrl@32f10000 {
 						<&pgc_hsiomix>, <&pgc_pcie_phy>;
 				power-domain-names = "bus", "usb", "usb-phy1",
 						     "usb-phy2", "pcie", "pcie-phy";
+				interconnects = <&noc IMX8MP_ICM_NOC_PCIE &noc IMX8MP_ICN_HSIO>,
+						<&noc IMX8MP_ICM_USB1 &noc IMX8MP_ICN_HSIO>,
+						<&noc IMX8MP_ICM_USB2 &noc IMX8MP_ICN_HSIO>,
+						<&noc IMX8MP_ICM_PCIE &noc IMX8MP_ICN_HSIO>;
+				interconnect-names = "noc-pcie", "usb1", "usb2", "pcie";
 				#power-domain-cells = <1>;
 			};
 		};
-- 
2.25.1

