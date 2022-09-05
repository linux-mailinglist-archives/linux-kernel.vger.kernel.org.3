Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25E35ACA34
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 08:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236618AbiIEF7b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 01:59:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236610AbiIEF6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 01:58:43 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2066.outbound.protection.outlook.com [40.107.20.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED39E33E18;
        Sun,  4 Sep 2022 22:58:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nxTNgaPJXvRCvX5cOxOp2OMj5AP1imsQQ0jVvjxSRnr0Xc8RT13cqgz9zP0nXQoLV/lp5F81VJfkjrW7lBW8P/Xj0xxk0PU6q+YuMGT4bpiVLGtIl/sVn9Nbn1um0Pjxu64DjSkQ0ZeUBKEdwoBU6esprX9MNBcjlupW4ajt8qrX44LVjJxh5f0kI7QPKind2yQze+wZd3piacWkz/YQS7yZ9fvQ8FWwq3pzLuv7eWkF54ulNVx+poSaTHz8Wt0ctLaLU2WfUr9/qBg119alsviIM+GVEQ8lnheg+sW2GabEbZIJtuaKXf8UgoSFboram1tQKCNzgxO7jZ4acByJ/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h3Un4dUVd5kEZmrGm3+73axRJ4LPgJu8ax1jR+UyOmI=;
 b=D1P5m335iuIlVQJJeAEvGMU6zK9lntBty95h42uuGkkdXpVU2YsCBpFHM4yMlLHWAOlGs+xaYmtWdNphIIev1u9Y+KWp3R5WNmD+BdxGwxLhjSU6JtSFboMMvu+cSmlcVV1oCLIE4QfD5oMXht6krs+ug8WFCT2Gc1gbesc4s4cy+OCpMFbEkNtVQ5KPtqYJVRe10a4k1yo1OxQV0wmAjGe+6nYc7NwNgFI7stM6vEMd/JaFq3OWw50nxIeqthZM6OalHA8GttsMtm5VWxTBpMy09UnPAapqAPQk7X/Wa3df7WI3TO4qhy72VCzDgU2vqjsnEYmDg5weCgZOsueu4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h3Un4dUVd5kEZmrGm3+73axRJ4LPgJu8ax1jR+UyOmI=;
 b=LJAgZT/as1vo8i8JAU0ZVaaPtuXlfLX1hpO4ZsVHQLvn/X/QHUM6LRwWbrSG0N30xFWTKYpyTZrnLsTY8jMTlHOXctAUCFMvqWD8mzmavGnqTz0IosuyYCRptEyC/HY8Lzjy/bHoXd73ZLY8mQfGnRg5RPLeW1+AZCYzmrC8dFE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM9PR04MB8276.eurprd04.prod.outlook.com (2603:10a6:20b:3e7::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Mon, 5 Sep
 2022 05:57:57 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.017; Mon, 5 Sep 2022
 05:57:57 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 4/8] arm64: dts: imx93: add s4 mu node
Date:   Mon,  5 Sep 2022 13:59:11 +0800
Message-Id: <20220905055915.3878000-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220905055915.3878000-1-peng.fan@oss.nxp.com>
References: <20220905055915.3878000-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0004.APCP153.PROD.OUTLOOK.COM (2603:1096::14) To
 DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 40f52ea1-993c-443f-5355-08da8f03950b
X-MS-TrafficTypeDiagnostic: AM9PR04MB8276:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KslbIF4EmX/h2Y1GSnmpLZqF+RG8rp6HErsvObz0o3yz2IueNIYjMS7huNH/wWQgOCyqnYLMyhZhElIPS/BonIj+L+46+OUBHEFvGIZi8CUwbcjRhITBgqteCaGbP/9G7WE3zSEXWbUnMjRnAu4K4/Dt8+X0OMvogB8K4j7bRXxt/0O+gm9IH5aTiJ5t7ERq4JG0HM87sPdtWmGtDX5ilJ/uVV2skeP1A3R7QkBIKpAowyIMbVqIlG0vUfFsg/VybeoAp2R9IFxyzgiofaMTGnv22S6Ewy11rc1YHRgRuTCGNtJRgg1C8/+49T+jzDYE9E0dsX+dtOWhm5NQSHwxH3fAzIwnw+wVEHcrqZX/5LuW/Nwfkh7B/ajJbxg4aMFF1OPpJg027zXxLYxXn+IQnpkMKli07SeXVK+yLQhWR9yAh6wtbCQ9TD53i6iB85TL2Wq13jkKzMLJa7+Xg4Mi11IekLkTUGfcochfGppqnjbLHit0INjV20J+u4P1AX68lZmEs29ZqSMQBoULlVQe2dDxjSUrFcJ2NfZ0qD0JkZdD2yjiZX11ef4HQ75ai9vKVAFTes5X9eZZ9Tx14pVuWFx4MAxKgxAJ5Dd1ZFvxANe7sGaX2Xz7+cDP0yBVcYWjQtTqvLHjR1IlOPKkWyaLKKcT9LynImRsKNZK1J8wXw16uY75x3v2uHKVEqAdwP0/NVcv38r00VlbSV09+EkxBvi4j5EwUFvavx165QXPBXOb+/ENR+DKQMG5OXL6c/f9uU8IHxRZcm5PuT9sU6Qd9g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(366004)(136003)(346002)(396003)(376002)(38100700002)(38350700002)(478600001)(6486002)(316002)(86362001)(41300700001)(52116002)(6666004)(6506007)(26005)(1076003)(2616005)(2906002)(4326008)(66946007)(66556008)(66476007)(8676002)(186003)(8936002)(4744005)(5660300002)(6512007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4JtD9s3KmanK3qIXLU+7gB+xfIfFol/47W1AId9gn1Z+WP5Yb2RrqjIPQ9nI?=
 =?us-ascii?Q?82CJzViUKzcxH0qR9anl/doKo0NiZ5unOc5lKmbgNgnspTQGcXqBMI5ziht9?=
 =?us-ascii?Q?964t8fVASXTKxbC0x7pikDh2g61Z6HQ7lWrfwCF/Cag4AX8XWpdME/jmOqXZ?=
 =?us-ascii?Q?EoaoWw50MAzyMJNa1jY6cfZZflOyWpqv4aEIwUI+DKE4M6m0a9jisCpY1rQf?=
 =?us-ascii?Q?tb/lVxNJ0/b6LcebgZephYYGKzNP1ZZ7uO/n+pAV6CD3a8AELYH2eHnZ8jo5?=
 =?us-ascii?Q?9fGKTQ/hB+yX71FINqvEzT5a9sHRPJfMXkGn9u5hDn4ip1r7rYP0OsgCtwig?=
 =?us-ascii?Q?fG8lbzw+jgvgTxVrfP4+nJD/7+e/FpAbr87NRSwCy7rZKff0P7/ehh3DonvO?=
 =?us-ascii?Q?OnjNTrRGQxqrf1uYks6e75H7dCOmAQiI9WT/vvsajZ2nn6tQ11qF8GYqAF3P?=
 =?us-ascii?Q?PeAnm6OwZpkHn7wVlNaZbxgt9D3i7bIc2wFHDcE/bBjNbd27rkpSFcAfu4fb?=
 =?us-ascii?Q?9kEL6Q4C2V/wAcJN5gQFHDG+8QaQ/1v5yb3q+Y3x4IvXwLy36j5smH9uJFnX?=
 =?us-ascii?Q?FHT1RMQKT4w1sV3LZErWaGWOtBICF6gqP5fPkDFtnUOMmd19kcPFoL0K9jOn?=
 =?us-ascii?Q?Zzvm3OfdzcHzce8Xay2n0q0UBmH/RHQ0Jo2+F7DvM9/qPDkWV3+3EeiiWF5N?=
 =?us-ascii?Q?cQAUeWzpiXdYvdOwvSXmFJSdml5SCXylETCk6mSzlTr1Vaf0DcaDsnzfu2Br?=
 =?us-ascii?Q?bTF0BKdy17nawzcQ3xW8U4UH7IKUBtsRcVJBR9N1mIcl4dEapRxiYscI0yAq?=
 =?us-ascii?Q?b+mouisBQV0kw+5Dj7FBUgTgAOUQUQjrqCkgfhYtr/YgX08YImhong7btjLI?=
 =?us-ascii?Q?8TTXjmxgkvmd+pWIIxC1yA433D7gnBpOpz4vBCn9DxdI3EWKHcvR+pzFhLuf?=
 =?us-ascii?Q?tTRX5CjjMM+62PwZ/8vFogzWgprau5Sf52RF8aX7DUYDGYaxKho4k7FXh3oI?=
 =?us-ascii?Q?bZH5z0cqUwUtmMwp54LKZvaIeXcRVfu/AcYjSisvYmhb/Gjfwo1wfB2Mxxi+?=
 =?us-ascii?Q?9yrkURZmHu6BHTSStOZYk5DfuEzQKq8mRiLq3Iv+SuKkSqhF5kI3FziA1l7Q?=
 =?us-ascii?Q?ONgC75ufbQVCV/fvEgGZPhJHheiEY/MTtPxkmOgyan2pE8OFu1OxHIXvvoBE?=
 =?us-ascii?Q?f+ofT5/Yaa9cb2KiKJvHPbqpnX+B+N7G4zCdu9f9zn7PdymVRxT6DNGYwsjO?=
 =?us-ascii?Q?DqS648hEPMCJ5kgHT9cE/gITBujUEDfWV4jlScWrjqmPaMRarJmprwHzQ87e?=
 =?us-ascii?Q?6zWTdT5N3q51yn1igvoPl42fK2+jFBNcTojQwtAxrOAVCx4NGiFngzG2l8sa?=
 =?us-ascii?Q?gjgtw7F3DJCLEB4WT1nk26oEkcED/15slEBFgbBLgxAD6ynkhSI3PAyATMt2?=
 =?us-ascii?Q?IXBx2EtnKtVMAi8nh4qEdGtG8wSWgrFV80UJ0fhjiyXkptTqOAHh3BJ4V4Ll?=
 =?us-ascii?Q?biJXBvtquhqxFlIPReSkgzO2zjoUA1IR+FzAT1xhZAofz6VC6ictq6MuZRxi?=
 =?us-ascii?Q?EsBFkLRYp6T27lm9A1+PBmLv4XHlby6PQIkadBVv?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40f52ea1-993c-443f-5355-08da8f03950b
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2022 05:57:57.7692
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B/HMzFQEuAtqhhbWjU8U14QiDaEczzbdlJkKdUlGsss6jX74rIMORnRv4llYdioNug/RHiNIDUuheK/xS+G6Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8276
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add s4 mu node for sentinel communication

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 26d5ce4a5f2c..bb9e96ffb70a 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -342,5 +342,14 @@ gpio1: gpio@47400080 {
 			clock-names = "gpio", "port";
 			gpio-ranges = <&iomuxc 0 0 32>;
 		};
+
+		s4muap: mailbox@47520000 {
+			compatible = "fsl,imx93-mu-s4";
+			reg = <0x47520000 0x10000>;
+			interrupts = <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "txirq", "rxirq";
+			#mbox-cells = <2>;
+		};
 	};
 };
-- 
2.37.1

