Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15250562622
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 00:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbiF3Wcq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 18:32:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbiF3Wcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 18:32:36 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10048.outbound.protection.outlook.com [40.107.1.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA68057219;
        Thu, 30 Jun 2022 15:32:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AbEYAX0L00LMoyeaEQPdn60HCgFkZNoou5kfCbfQmFrJQgJxh7kYQYityAGC+RumQFPwWNE3IeJBJeJZCbSUkn48lrjd+iIioe38HMdw3lql7dHIn+Q8ePZ3qy/06aPq6lus6OceLjEwlVbfyB/8CuIKMNTSWPw+si2HEcSOKWNhwtIjBD/l2DstljVaeuLhza71/Filq5JTHA40xNnagv+BSKnPADW5jb2Ggnl0ktJoCxjDAoiEdP+Ckcki+p1Ktqn75rP5kc14nWiwOz8eKZ1HhoPfY34TFKCVTDbEeJq5tocoZyj+If8xSyrOJspCvqL0owQVRS0dtGSj7s9LBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Ks8km+V1jdE+q1V3TUK9tgETPUCIRUK8dIpeXC3Ne4=;
 b=ZUYdwaEZUrY+yZBW0dM9KiUQpmt2J0sbV6jNnzbi3FPlB+evBnMINB2gz4mIyizdSuJ5CitG+rtE6Uzu0TwCCrNooN2ZeOdEzd4pQG1vvVH3X2bODLh6lHlW28tcL7PaT74bYeXdDgb2nS+UO5EC3u/2lB0nluUppChNR6CEehbZLY/AzOGs10HMgBPyiOxmavRzvzQp7acyYqtbSxJiqyOKOinifM+iUyMqsCkv2ee62H7fzDpT0iCbpC/sSJhyjDrWD09xSMAt2vA5n7mzfW/h/2CT3I8z8ZiLi5kGucYyc/iJS6omKK4L/EUZD4IsNtvc276YKQ9C7WmoYs1bSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Ks8km+V1jdE+q1V3TUK9tgETPUCIRUK8dIpeXC3Ne4=;
 b=QR376tZmKYv2MOT3exu13NYrtfdMp1crX7zLitKAPLE6GDne69thPGEGzj2KjEDfpvnKkO4KJfT8Ddg80OozMUrTwWigy4KT07RTOEUiRMHcM0JMzPdGKRB+mVAntF/1oPcqgP29KHXd3dDKAKenxCbC9Y8n7CcCj85HgyU+AewYoqQCqOmvexUGfCF67dyzhjJS8jvUD6sLHdpP4VRAXfUZMATi86fZK4ri+j0mj7v/jhIleOUo4faUr91N7jZfzR1/TbA5AwTdog1/GPatdq2WXrd5nbXDkMFmQQnHbUfh74S77iHvQRn7prDvWu7rT3apN6yerKR8dQKZrvJEmg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by DB8PR03MB5884.eurprd03.prod.outlook.com (2603:10a6:10:e3::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5373.18; Thu, 30 Jun
 2022 22:32:33 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::757e:b75f:3449:45b1]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::757e:b75f:3449:45b1%6]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 22:32:33 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Li Yang <leoyang.li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Walle <michael@walle.cc>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v4 4/4] arm64: dts: Add SFP binding for TA 3.0 devices
Date:   Thu, 30 Jun 2022 18:32:07 -0400
Message-Id: <20220630223207.1687329-5-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20220630223207.1687329-1-sean.anderson@seco.com>
References: <20220630223207.1687329-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0014.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::24) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 871ee98f-5be9-46fd-4c41-08da5ae86cee
X-MS-TrafficTypeDiagnostic: DB8PR03MB5884:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fca50pUWX10dSrRxOaPdZ3cvLQT8DFKThf6tU3AOE9uQ9JuCXzXIGAyK00JqKoj7HDH7zNP2wGvZOP6hSePH82JZuSquXmdLgXjyndzOTxEQgA0VIieeBtsPlqXYnd0cTppiZye5NPI1utKfKrHUt/wZ/QItdQqSERvzRoFfva0800CUDWYqmkzvhBWHiAcnOo7NPgjYYSyKefOUNOYCiMrb+cYWiM7qw9iFfLDUbvQzl70Y5v28bCwxj8gU9t9A5DB7LkvQll/asL2vofOCmxvwm8FBOohBCwVaMad+HmIG4wYQ9+w3Q1ulLupeUqr4kSD/+8QP5F46mSx+BfIF7aygalAUSlfjqzzf95Iu+ew1BSCvhelk0OJoi7H/XisiTONI1oTr3QittxhnyNAQoiEVlzmES2yjVD66kyol4OmeZPg2hyOqs4+HWG6dm2R5yRwrEPrl6dHDfCjz6DS61AenRd16Z4CmcFwLm3qEbskIXotXNlewDTMEew51z/wuuug5qlme8tOIz8alPxpDeGxj2cpc3w6YW/9RsMkC1sXKohKuohhombhc1EsiOeOuRVAzubE85Smx3UAedweKOaZDG1cdSODsvfOEzZEBT8ZCijfaPyuL84fYLbKnTWRI3npyZV51e9+YEWD/YgXNExfR07c7u9L1sGOF62V70LcQxZBBHMUBpkEWpcB1T6lUGTI+E8YpCzKSNQITMlRJ6sFjEf61xAg17/93QZIxJV8FcBaKkn/1B7aIxfGTeXPVNk8QIdDHlXpQnqA4J4JfhhhkNl8pxm/8bc17KOT/lR8gDTORlPkRPuFIaQpJt0dN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39850400004)(136003)(366004)(376002)(396003)(346002)(107886003)(38100700002)(66476007)(52116002)(316002)(86362001)(1076003)(8676002)(6666004)(4326008)(6506007)(26005)(5660300002)(6486002)(38350700002)(66556008)(44832011)(478600001)(66946007)(2616005)(2906002)(41300700001)(36756003)(54906003)(8936002)(186003)(83380400001)(6512007)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rZM56c24JJcqVW4z2QeBq6vTsmT5aKz6CnphaOrvShSHkQQVSovePhoNdTo2?=
 =?us-ascii?Q?1j/UhuJk/vLg6SKBRXLBefRERyZN72pFilhWXzfKj/ilzwQn+bif2dt8tz39?=
 =?us-ascii?Q?7XpB2CzHSm5YrTJfn0drb87ngAYMCQneSquxQQAM3YAx4HGJ8G8aQcDjcRy7?=
 =?us-ascii?Q?OOduDiP4sPytXPVnD+8ILlvK6QnBTW/SVq8ySMHiEnAVV3rGN6SH4mc+1vjd?=
 =?us-ascii?Q?lcY0SSOZg6urEwuGDoQw8NhGtbkjedHKzLYV5SUywtRkhK6ZL4/sx1vPq2S6?=
 =?us-ascii?Q?uEpu4XlYIMYL1/stS0G0ANC8JKGCke1gfzxfLk6Kdz2nNEiDqhWb/eVO6Vta?=
 =?us-ascii?Q?zVNCcmh9JQqZMcWLKQIoWXpFQ5bXsbB1juvU9XHapX59VBoV0btkGJJ8j2Ja?=
 =?us-ascii?Q?EFt1o4jRkWtOvayEXJx9ApHqa6/2HTogemKCSPr8LiZsS7VbYptshXtFtbxV?=
 =?us-ascii?Q?Nj8b/evZ7c+qtmvjhvpOtGIePqqzXnEsKx0A++Zyu+DOe/bSKirrc8Piz5gf?=
 =?us-ascii?Q?R+1mS9H6BydI+jB51MS+AkE3xwakQiOMeopdE1Rd92s5miziMx2x34D7066m?=
 =?us-ascii?Q?l74+KioN63fUVYVf9WO9OY2Ws8qpu587Je4mSSbCdmZS7cgNhhbV6Q9080gh?=
 =?us-ascii?Q?2R7HHQzHPaN5bg2Is8SsWSknjHxZCFtIQEk033qycW+FNqKm/FqqpmRWiUaE?=
 =?us-ascii?Q?gTWExQQtQWoKoa97Y6PWnAGB8UjY6hrtmYb/S1HqHLcZdxAzebHYR2zy70ux?=
 =?us-ascii?Q?402VspgjunThO1Ybm6MWo1B+C40fzUt0kp5xDa9DALGTdEACiLfzcxZxQFKz?=
 =?us-ascii?Q?HGLWknU3LkDhXGQBBYGyl2Fv3885BOOGbS2jKJMMKx0Ut0wW0sFhH8EKfX1I?=
 =?us-ascii?Q?YcqhYX7jiDKv4cC1FIN+ijkDd6BTJZEwjp6nfU6VdHAbZOxNqk9GP/mZb9TM?=
 =?us-ascii?Q?AZxOvi7hesWPzMfREFyKkwdrRIQZjJ+ttbi1BqZqsZLP2jhaum92f7xiNiRg?=
 =?us-ascii?Q?zQbQTQx8vFlxZfuBy00qHmyoAdixAoqhCbkLwfACnWOXOSksBwTqkf9WALay?=
 =?us-ascii?Q?+ZCk8VJizJpEbL2Eur1sjwFMiSf9AwqsRIP22ziJCLOj4IfPJqAg1aI8p2b3?=
 =?us-ascii?Q?L9TNzBrSBOASAjKPe93mpF+M55WoTils1rdNdE8mJidhQ1HTmTwA3xr20b5o?=
 =?us-ascii?Q?ercRrPxn/OZDERyeNU6p1KeHFDaynnsQFzycMmK7H3ZNpwvE34Vckd7StNP1?=
 =?us-ascii?Q?byDiIZIbCU2VGn5fpkPl3J3PUnMsYOByo1A35DXo9MUKlZbbN+7SYR3FLuQG?=
 =?us-ascii?Q?h+dXwSi6HepNCUCjG2i4XaUI0Rx2CYNaGvyRHnkZhgix2bLorhiR4moVSZ21?=
 =?us-ascii?Q?Tr3VElJ56Aug35BAis867+UEy98LOlWNDbqMg5IRLcX0ZHxif6uAJtk3OxMp?=
 =?us-ascii?Q?Kk5A1XILV8fkhic+/c04PJKL+8Diad2H687VIe6npHPkYDU+Qmi6uWZH/GhN?=
 =?us-ascii?Q?Oa2osN7981tDuY7sgrcvGqG5xYPf6BZu3cBZEt6Ue7jYgbmoNrqYvqOa83MN?=
 =?us-ascii?Q?w6DUaPsRb1CQjgLfMKths9YKYivQOdQbCNLImlMM8MuDHucMMGPl9KToS/qD?=
 =?us-ascii?Q?GA=3D=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 871ee98f-5be9-46fd-4c41-08da5ae86cee
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2022 22:32:33.3909
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jGUIbzNyWUonp9xBqGn2rr3zxg622Cuy47EQHSIXcvkzZhYeB32YrssT1r04i+bjpyGeZPN2MBI+JO1QhRjDlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR03MB5884
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds an SFP binding for Trust Architecture 3.0 devices.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
---

Changes in v4:
- Use arm64 prefix instead of ARM

 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 8 ++++++++
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 8 ++++++++
 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 8 ++++++++
 3 files changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index f476b7d8b056..32cf04fb4dd2 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -269,6 +269,14 @@ extirq: interrupt-controller@14 {
 			};
 		};
 
+		sfp: efuse@1e80000 {
+			compatible = "fsl,ls1028a-sfp";
+			reg = <0x0 0x1e80000 0x0 0x10000>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
+			clock-names = "sfp";
+		};
+
 		tmu: tmu@1f80000 {
 			compatible = "fsl,qoriq-tmu";
 			reg = <0x0 0x1f80000 0x0 0x10000>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 4ba1e0499dfd..127acd285c58 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -278,6 +278,14 @@ dcfg: dcfg@1e00000 {
 			little-endian;
 		};
 
+		sfp: efuse@1e80000 {
+			compatible = "fsl,ls1028a-sfp";
+			reg = <0x0 0x1e80000 0x0 0x10000>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
+			clock-names = "sfp";
+		};
+
 		isc: syscon@1f70000 {
 			compatible = "fsl,ls2080a-isc", "syscon";
 			reg = <0x0 0x1f70000 0x0 0x10000>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index 47ea854720ce..ac993cda6dc2 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -671,6 +671,14 @@ dcfg: syscon@1e00000 {
 			little-endian;
 		};
 
+		sfp: efuse@1e80000 {
+			compatible = "fsl,ls1028a-sfp";
+			reg = <0x0 0x1e80000 0x0 0x10000>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
+			clock-names = "sfp";
+		};
+
 		isc: syscon@1f70000 {
 			compatible = "fsl,lx2160a-isc", "syscon";
 			reg = <0x0 0x1f70000 0x0 0x10000>;
-- 
2.35.1.1320.gc452695387.dirty

