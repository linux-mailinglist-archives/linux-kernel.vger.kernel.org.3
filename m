Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD79513B59
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350941AbiD1SUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350908AbiD1SUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:20:40 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2044.outbound.protection.outlook.com [40.107.22.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD4E166218;
        Thu, 28 Apr 2022 11:17:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbSbi9MzJo5kjrikQGJzQoNk7wbEabA54js8MbOzurjj+lC/nTfWrKA1dI/dbhs5ev2/7ZxIRiinD0CRnXfO5ooptY8X5uiHlAOBFeMS75tTiwpeUY7p09YAhe2BtcwTZlRkJ6UBm5bwlyPBEJYWtlZX7cXxKezL4eCkn22pVTgIAlsG/3LjpNJPBcIBmIdFUinelGPNcSSwScYNx9c84AopcLk3m5/qoUaA1AWJaxUkII0Fg1Fq/g7NGqg/gez3H4NU8U9sbl40ijFoKVzV4yZ1tXNnV/5bcDim2ZOQe7OtPUKPcktJhHXIxpRHJbqL3edgr4lLZnO4QzXZ9/Fg1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r6QWTy9eNygOcLXSbn6gs8ZS/yqJFVfvBodX5K7njAU=;
 b=CuckntK8gBiMRzGycdWfN0yOg9nHatdekrgAiM0wyXCqqy3pm97kGByhRmQwCiIMUu6P50Juijpo73jBMw4PQydE9iIQ7nVFYz+YDjR0JA3QvZg+Thr123Z02Kfw9V+hA+r0uD2eKgrTCv5YyFhRI6B/lNkTSRVI8IRJoNz2nbwID0SvvQhrequzRTGnKcrRloolenAlBx47uRsU2KQhTw8lNccgP/XMTzxVIvdcqAOIR77XTrq0c83vWVYMnIvcnguAaMpPTJj0NoFfC2CAyN+WtG+kcDcc3kaz9jkGVrWmB3BGunqIrja0ucWopJNj7NjxZpEpCxO/SfHKUwPFpQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r6QWTy9eNygOcLXSbn6gs8ZS/yqJFVfvBodX5K7njAU=;
 b=yP5lOCKTwT3xe/XeEpvcdO+toBdBirieF4LD4uB4zajMy2Ff//AMe1h0SZkix9WP/0JiyLM+D73qXUehMYlJwkLpsFyd7y5nGaEhf8WiYLtCfraJ/Pp6bO8QmScuZRBiQjI5CxLkWyGk3V+uOA4DfLm1/5g98x+6k83OxUVZ4M6VknRGR9jwV5smed6kLX0Wsy6VVVoPyhzl2o3uLgVVrytNK63EGPZ70IGAG9lOtDumRRN+fkMiA5tOgIxOo5gHYNGLXDfQWVnOpFM68RAnNUP7bQH3phpt1VCEldB3kEV2pLhU+lo93iyBAPeJ8WxH7HJp4B1i+saJRY57diXCtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by AS8PR03MB6775.eurprd03.prod.outlook.com (2603:10a6:20b:29d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Thu, 28 Apr
 2022 18:17:23 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::a9d3:8abd:3f5e:a0c]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::a9d3:8abd:3f5e:a0c%5]) with mapi id 15.20.5206.013; Thu, 28 Apr 2022
 18:17:22 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Walle <michael@walle.cc>, Andrew Lunn <andrew@lunn.ch>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 5/9] arm64: dts: ls1028a: Update SFP binding to include clock
Date:   Thu, 28 Apr 2022 14:16:59 -0400
Message-Id: <20220428181703.2194171-6-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
In-Reply-To: <20220428181703.2194171-1-sean.anderson@seco.com>
References: <20220428181703.2194171-1-sean.anderson@seco.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0117.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::32) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 48802c9f-485c-486c-a72c-08da29435710
X-MS-TrafficTypeDiagnostic: AS8PR03MB6775:EE_
X-Microsoft-Antispam-PRVS: <AS8PR03MB6775425FE3B49046FB5756A196FD9@AS8PR03MB6775.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sNQ05/ElC1oQvQ6BrKmg+22LWN/4/d8+KNEANmbYHMh3OyKhEI3de/oC7SlDrh4aEkgpOfJXYEzuKE86YZkUceqbrly9uCYKIkTxp+o4Y6XepFufUcpNIy5MbgsXLOQoRFZspSLGxiNLAubd6q/wfxAU2BrqgZRXRbPQ1wBKqoAVJx6Ljko9+epW4dPkTs+nJTZlIKpSN35EvnkBC7dAIWchIv1qHWH3YCnEm05HrLF8j4GYjFiEMRzX/muP3y2e4RJxrHDQnEl4gsIUcCfF2t4QaRA9YXCtyw3VL3m6KdSiGmLhiHAZd1m0Sq+vJI2BXfH5G9ayhUWH79k8YJx0XJNUi9MKly7nCdmAiLOVCx3lHe9+tEofWsT1aXxnlqHNi2wknQaICrHJCLi4Ve4dzMHtm124SPKUkk4o4Hy5tcORl3/Y6HoB7o6gb9dzxigoEzzLVt7aCVLS9qRjXvaF+pqTorym9Q/h3JflbG04aDWUBcN7F5V+QFM0MUEN/pd7GsL0OiDYX8G1uWX4XE3e+XoOm8zg5f8UetDtmuUHiziaaiJqGwX3aKAV8ThWaiYISYUr0EHVY2YeUx4wHPm6zk/7RIxZVUFiQe5Se4Z6iTUaP4OaiDSfuBpdAwCdbYYryaPyD5JMu+h/Dhw9C2bZQuQ3hfZ4bjBpCxLB46Ko/yL/VV4Ld9pPMDwBpUdpIiBfU7SUYOYWxIqPCTD9oXIKwA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(8936002)(6486002)(86362001)(6666004)(2906002)(44832011)(4744005)(1076003)(38350700002)(508600001)(7416002)(83380400001)(38100700002)(316002)(66946007)(186003)(66476007)(8676002)(66556008)(4326008)(36756003)(6506007)(54906003)(2616005)(107886003)(6512007)(26005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q5PwqCmED1krxHjX2NqtYdUzLAJM8fh3Sb711ow1kACBbuHcwtdK6Q/gcang?=
 =?us-ascii?Q?nsu1yFjgRIHFeTIZ/3rUAxfHW5MAs4n8hvtH9FFLjoHhYlo1cBu0AFm4aMqy?=
 =?us-ascii?Q?FZiuuxnYcf4xqjie39hP+e2jDfFbDHFUE0EJJc3hmXxk5rq9qNtejXjToJed?=
 =?us-ascii?Q?BVRyp2BJ4s7+UFAoAYnO1REvszIzBn1Zy8lP6y7NAhP3pR6Sxb2M6XVMazsW?=
 =?us-ascii?Q?bvXp1OSUL9YYZqJuW97ix/t9Xn265D9FqWfJ+7cDPoiyLQUbtI8hgUqm/eUi?=
 =?us-ascii?Q?qCPFQa0vsDGsnuVrvZ66Bekuf7/xd6lqkv8p2X3BN27YKROca0xmrH4m5gwh?=
 =?us-ascii?Q?bnukw2vAP90tfTEah4I3sDSDpap66Oknwfdn5HOjm9ng0TU2oHvmq1yyJqWt?=
 =?us-ascii?Q?7e2KUANtda+2FYuBtPM3qQGDpxfTBqe6P80wZTA78qvQGroEyE4p3Vu2gVtf?=
 =?us-ascii?Q?ePG0SwcFBo3Y4s/jMPnQ0378+GbzAxRBNVEpighB7KZPdIEPAfi3NNTDaTtZ?=
 =?us-ascii?Q?BnyoiO6B6B+UQT09sCQH+zzG8eq/01z+0iV6+xiztbiVgRbo0DteTTllVKHA?=
 =?us-ascii?Q?B/S9lKz+DuCs66Lp2cXHeIGR+tV3NYKG+8o8z8F0aK2ZcZiWJ5gEq0qiAPPY?=
 =?us-ascii?Q?Wc9tqYOWJUcKBTKD+hlDqu3ztyrLSHJ/u4s7GEbDmTmHgDqk5Zww2YBjEkKk?=
 =?us-ascii?Q?YwJAixweZizSWdX4INsgOSfzKUwvI2BtYf6TI64xRr0TZFd5HnOXhYBD9o9N?=
 =?us-ascii?Q?eZ2Z6MrlzEbzhnZAc7ppd8DhJwgvp6y5kJSeaR2cJmME+TXt6iBgOQMK0Ulq?=
 =?us-ascii?Q?zMVnGj+oGt72KwYXkT6iIBXKQ5Szo82neOdWEVP0TzGHWii9yS890UNvqaJO?=
 =?us-ascii?Q?ag7yToFxnBeK4b+DhF971CqxVZJu+6avW3gACDBwoifZYeuW3piCaNaxq9gG?=
 =?us-ascii?Q?guZ60Ka5yU1VO5TbOwjW3u2FgHF3XYZq986huBn+XY/6D+vfZf7gVOfisw7Q?=
 =?us-ascii?Q?8cpzXebYqfMaIQ9GYDAvG/RsqqrPaGuv42MPQaQKJ3poM9hfQQT9kDHAeGuT?=
 =?us-ascii?Q?uKv7w+Z5C98mQfNJNOv3U8Cx4Cyw3ziNW1jyUwI/a03BQeze51DaImvjuMkP?=
 =?us-ascii?Q?5vVm9IQoPSe4rcsuxVx0X6Fsav7X/NZ/Kpd9Kw0ROiWkRvD1P6n0cHAAL1+l?=
 =?us-ascii?Q?4JN1GAe0tyGNrjAJ4ZjEUWKqjKKuaGiA840CEM/GIdFPlGHzZdLegTsucZV5?=
 =?us-ascii?Q?JrbczQwa7OXlAO1eoGyRtY+SAf7GGzXzWdMIQ9VdjBENE3M45YqYeJWf6fSE?=
 =?us-ascii?Q?FXpick79lV7y6N8Z29quic8rSJZqTWQCcn91da9IkB+RXPAVMFGCNgz0bxD3?=
 =?us-ascii?Q?2AIe3q9hr1ksoZzWzjfWfd5I7fk39L7MSV7Y7+YGP92ySVGttJXQvXhyMdsu?=
 =?us-ascii?Q?rZhFg0Jj1HUrbK8DJWD209k2y++BG3jUt1PXll6EBQNx6gjwFQXpR9Ikq6fp?=
 =?us-ascii?Q?B9fPBph2A77qxDtX7dHvA/NG7SzOIaDjiVYbm1Zp18I0c4YyVeo8fX0b8QSf?=
 =?us-ascii?Q?CbMTGRrLBKP86FN9iVwpbq2mEoR2oDSNBBrfk5taGcjBxv/G+P0dPC3A5SeV?=
 =?us-ascii?Q?3plXK2kWdEqdMlryE5ZhwEJQWLrtr80Lz5IQUGlVD2NFqgM5VIN1gkGGU5z/?=
 =?us-ascii?Q?iThDw+bK+/gZ8bFunusGP/hSivMVsMZ275Ceac49wAvkDo8xw1uOZirUrFNG?=
 =?us-ascii?Q?NiBGRwysSVGLGH457ZOvFIYDwYVMu1A=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48802c9f-485c-486c-a72c-08da29435710
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 18:17:22.8946
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6UzOjfQjt8ycrY1PWcbFb5M3XrxWi56FpvsNQS9mTEFsVpIUpkyA/zCTREwIUEew+GKUe+zLImyCaB0BAzYZ2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6775
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clocks property is now mandatory. Add it.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Reviewed-by: Michael Walle <michael@walle.cc>
---

(no changes since v1)

 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 088271d49139..59b289b52a28 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -224,9 +224,12 @@ rst: syscon@1e60000 {
 			little-endian;
 		};
 
-		efuse@1e80000 {
+		sfp: efuse@1e80000 {
 			compatible = "fsl,ls1028a-sfp";
 			reg = <0x0 0x1e80000 0x0 0x10000>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(4)>;
+			clock-names = "sfp";
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-- 
2.35.1.1320.gc452695387.dirty

