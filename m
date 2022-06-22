Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913BE5542DA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349809AbiFVGMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242604AbiFVGMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:12:48 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80041.outbound.protection.outlook.com [40.107.8.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B60C24F0D;
        Tue, 21 Jun 2022 23:12:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VuxJjvOxaG8AooorqgHbEhx0SheIIRrG4NSnQYLyFSYBcyqeAbM2UPoJde4NzuU21oZnRL2V4Iy7XOiASUTrizIl1UByjHcDSibAtol2HzCJjOZY5iH1pvmsNDfkzaWH2upShJDdUyb6eggAXZgGnEM5UyL6SBcRu+27H5hwpXP/7sn5hB3l97uOe4EWj0Za5L4Yhacop5k1b9nL9T4eKsUyKKlL8UevUGOmJLgsTRfuvmzEuXnQiNIaK4rfy4wK2lRBYi9qAdHnJlEoUVJxrO8/hAG4IuUHe9oIPni6pPcoy/Stfp8iQwwnCw/jLWxZfI25k1DVAk3bmfFBLlhc/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=75fQFIFzjpLJ04KqrBvLoIcO734geh4Q4OqPWdQP1uM=;
 b=ijl4T8LmiCmYBrxD/WRlrRB0AAvwauPmWjqOF/3jQbFGhq9FXpu8WJ3PokTOECIXt5ZqELWueoc3qCPMwEFndSVtXhu4yS0KoKMTa6HhAblqzXtfMRCoqSAhKWuzkXiwfAKfTcs6rj6TF28WjXYn/ctGNmmlYdzAqrGBQmKIoP2uyp4Cukp6Dz9PyFrBdSfYXdWtvFtQdV4x/Q5gbcntcz+OcEMveup09dDP9Rdv23emb90RdgHcVJOkvBN00QaBFGLN5lhcY9ldC8pSN2DMH6dZsKuRINJlFhpWxp2F4JCPNSpBaqhxlqnnScHWf7IFYQ6mloO9USgdfO0XTbqOHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=75fQFIFzjpLJ04KqrBvLoIcO734geh4Q4OqPWdQP1uM=;
 b=N6Ob1Xv8Quk/B7hkwcRjWZrmS6yFrkToa8Kgf9HHzfpGVO9Y3ZcaBG/NL767gm4vr/9Ccqm6vIxF0nfMGD9hM5jhkrp6vCZ+mljGyF4zoIT1FU8hRIhGHQ/2YREQquWm0+2JRMccnJxzx2vyDcftUss3KNPVsvIbMb3QJMGKxEM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0402MB2796.eurprd04.prod.outlook.com (2603:10a6:3:e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Wed, 22 Jun
 2022 06:12:44 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531%6]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 06:12:43 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     festevam@gmail.com, linux-imx@nxp.com, hvilleneuve@dimonoff.com,
        l.stach@pengutronix.de, abbaraju.manojsai@amarulasolutions.com,
        jagan@amarulasolutions.com, matteo.lisi@engicam.com,
        tharvey@gateworks.com, t.remmet@phytec.de,
        u.kleine-koenig@pengutronix.de, t.remmet@phytec.deh,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sherry Sun <sherry.sun@nxp.com>,
        Haibo Chen <haibo.chen@nxp.com>, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 02/14] arm64: dts: imx8mp-evk: correct the uart2 pinctl value
Date:   Wed, 22 Jun 2022 14:13:58 +0800
Message-Id: <20220622061410.853301-3-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220622061410.853301-1-peng.fan@oss.nxp.com>
References: <20220622061410.853301-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0007.apcprd04.prod.outlook.com
 (2603:1096:4:197::19) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5c840551-ce92-49b8-4998-08da54163835
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2796:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <HE1PR0402MB2796E46B22EC17A8D0C39336C9B29@HE1PR0402MB2796.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uJEas4mmMGDHvdc1kSWERpgLsn4kG77gHevsUhIXx5ijrL8wBqHxb8xXfiVbiPHGgZCZ0bDkqPKSi2/FZdh3nmSF5EqYOK4VwxfC9oG0tDf9FF0hfUWv9+a5mucwYI2OUCs/iT1p00xFQzrjh3O6pKrlMPlhnDWcpN0UI5QJiGy/fIiY88r2Xq0dvOFKczBNfheMGeS7D6cTxD4vm1kB1fvA30Jn6RnX9q24DEmJXUWhWDfB+eg2FI60o5PqPJsFEr6Ej0rsCEWUt4NRKr/G01YrtLuMLJGLqA/4FJcDbc4HBLgkC1eKPBM766DG+kAoV/BhxWs5qK8xBHqgNIRxwXVIzHdT4rjKIviBErKKsiYRKs+y5PHh5MUlpD7UDFzYsDu22zl62Q8oejN3TxX2K9LtdDnK5BoLmHLgUHEf52lqfd38RLYfz9vXXZDazPYPG8X7xG90/4kST8wQmaH2qu4ilQdhSjCbNyyLQbQIx+jAJf032fnQAMiheGT1nBGmkgDpwUQPa/Pl6rzhQg2480HkNGE9xjTk7bH4t5RU9a0S09cTbFWolnucIA0PjKtQCw0Z1QczJqKmymJrX798NDhmB9kFYs5iuG2QzQzNg34KpYOOhmuBHQUq+TbRgAvY4R+7L4z6o/1bG+CGnn/HqNqeWRqrNDp84qYmEvJUAQ3HFFqdols28zWcdsv8UohREUgsYjP4tEz7XVl65+4CM2QdiaIOnXD52mKON2yMZvhTJqTGyKhW1wkEAhPI9VdLx4HSTMsmAOcvfm69TAPVdYqZQJzeHAI1Q8vhTb6LGos=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(8676002)(478600001)(4326008)(54906003)(8936002)(66476007)(186003)(316002)(66556008)(1076003)(66946007)(83380400001)(2616005)(6486002)(5660300002)(41300700001)(6512007)(38350700002)(6506007)(86362001)(26005)(7416002)(52116002)(2906002)(38100700002)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rk8zGI9SNUGxS9YjCIcfnza7mxVZauc5FCX2XYecb7Vg8IXLE8rqlzLRmzL5?=
 =?us-ascii?Q?8KJvncyVB02PWeY8wst06N2GSv0ThOhvsI50bWxHhkJeLxPnVxPEBdeVpNOo?=
 =?us-ascii?Q?AqSzNCaCV4N6rGzs/taUks68pCy2G9cNaC9kMjEDoyA6OWhGf0mDz6xkrDMS?=
 =?us-ascii?Q?fo3VvRzYGAL9Xb9pep1DGP1hk4eQqN6vIc+d+36nlZgm8ULGzIIl8Kbp6U4n?=
 =?us-ascii?Q?UKb9Vc+yC7B5b0Upmgq0QHCrDUx/cGBJobyx+laDl5nezn0OmGApLVs32vLC?=
 =?us-ascii?Q?V++EPViMua5n/MNFP7fNykYbp4/XBZ47xDKwsac6HC/Z12WZRmYKaObBwCDC?=
 =?us-ascii?Q?+gDrxB3bQq4ocmnzLKQGfy5CiYhAeDb5tWPdfCcHKn8CSYZnHC8T+JeoIfvw?=
 =?us-ascii?Q?I+fTh0VCRChlCTzGVegywI2DHcrgtq2G01dsVwuD4Dcu3ZnR6Z9uu8bJcyfY?=
 =?us-ascii?Q?O9aWaf7j2gh4pShPnq2EqsNelQlqO5jzrKGDN661OZmM5W+V98X7fGPil6Wf?=
 =?us-ascii?Q?hnaAGkYjZAbnPoOA9iIiLG5YQlTlXtR3UrZM3HyGbspY1l2Yn8eZXgclZkjs?=
 =?us-ascii?Q?FoId6YFoYvZcukdcrf4/eRWwOhL1q3fZFqfaxq1o7X0hl+ui4tgx3zmDjN0X?=
 =?us-ascii?Q?5k3IjTJNFPrMAzwCm29uOuYV799NZ7J0jFopUacRS9Bwp7hziyOv1VULRVG1?=
 =?us-ascii?Q?g97VyE5BY++wsl/GKf+/EPtndxuIQu2FMCglqnYBqMqHTKb90lwDkDZZ8p7t?=
 =?us-ascii?Q?6ypacchfKqbqHwphKgLYBrG5ZFHqJLJVdx2/L6hAEyQkfSRVPRG4HMIo4Bf6?=
 =?us-ascii?Q?T82wrie092uHLnRTyefEC51LqkMcGrhETxsw97sPmAMyqW+YQm51G4db8uhk?=
 =?us-ascii?Q?Ke38d5N7m/6AYQgogOaGXHbbGPgv4i/2yL8e9mocO6QsYRLSoP4IKcnuZXQf?=
 =?us-ascii?Q?WGWYjg5Bv0I2clBpjUS6gkFu4vOdH+sGeN9HnQMSbEex/V54AkPMQfSoZwoL?=
 =?us-ascii?Q?DnaXmfa2SU0pZcCZaC4cw6FmvH/a+6l4REw1g728wZMYkmg4R8g1QzvLwL4j?=
 =?us-ascii?Q?pZ04pKFj/U4yjJEnQJJ1W26Wp/Qp0+Not3afm0lelThhH/B9QiMULVjwn5hq?=
 =?us-ascii?Q?Ulwho6/qpqJZDX0tg2ybImd3Cu0X6iFBDEkVvapeGT2GfE3dMUwGLb19AcfN?=
 =?us-ascii?Q?YryYMsrrauw0xyalscxnzrlfwgyi4fmgTgoLb3iH/SDxGwcfisY51puLlq6c?=
 =?us-ascii?Q?fZLk4n/zYAHfN6cJZYug3WJmPl6u8RtOVauB+60hV3HENnIrfezQ/DWRIVw8?=
 =?us-ascii?Q?dAVDcVIw0GNF6cW2cGdLYXRVh2Vi5Gps/A7nj6w0+GNiRjv+PIKuxTAP2upX?=
 =?us-ascii?Q?UB2vNrO9gaIWwe8+ZES2ofMM+AzrUxhpOGkDrVm/xVXYJ0oin3z5nOubE97y?=
 =?us-ascii?Q?SBiC1VYfScfkcGxXptOQjPTC1EwA0z/2QMKZdFAb1sh7FwlZwGhG1nZRWVIO?=
 =?us-ascii?Q?h1q/kp3sL40V2QmC7IIkOPoYmMHz1rMMnNL8ee97whcG2mFHZrOZluZ4wKQW?=
 =?us-ascii?Q?mtNxO0KIB2PTZqBJDVilxlHa8zUzTDDQ23twdj/bVbo3tHu58U7jhWqRgXBt?=
 =?us-ascii?Q?y1hUneVGJYQVDqLP6+zhORh9hrNJOrX+Ec6J2SipkIwK5yBVsRokQXqUo0R7?=
 =?us-ascii?Q?agfmURLP3BxJ0Z3i1ANDvLKoDLDgSoKtLqRz67YcS6fWXqEU9MP/heq8NdRc?=
 =?us-ascii?Q?ysCwcZFx0w=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c840551-ce92-49b8-4998-08da54163835
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 06:12:43.8657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FwoPiMqtKOANI5rd8eo83pZicD1RXAzDvG1gcKFyTHaUoaCtszlQuu63t9Ip0GLfh1ZTWiHzKKYDT76Br2LXKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2796
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sherry Sun <sherry.sun@nxp.com>

According to the IOMUXC_SW_PAD_CTL_PAD_UART2_RXD/TXD register define in
imx8mp RM, bit0 and bit3 are reserved, and the uart2 rx/tx pin should
enable the pull up, so need to set bit8 to 1. The original pinctl value
0x49 is incorrect and needs to be changed to 0x140, same as uart1 and
uart3.

Fixes: 9e847693c6f3 ("arm64: dts: freescale: Add i.MX8MP EVK board support")
Reviewed-by: Haibo Chen <haibo.chen@nxp.com>
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index 703b03a7b90b..b2f6c1dc8104 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -522,8 +522,8 @@ MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x40
 
 	pinctrl_uart2: uart2grp {
 		fsl,pins = <
-			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX	0x49
-			MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX	0x49
+			MX8MP_IOMUXC_UART2_RXD__UART2_DCE_RX	0x140
+			MX8MP_IOMUXC_UART2_TXD__UART2_DCE_TX	0x140
 		>;
 	};
 
-- 
2.25.1

