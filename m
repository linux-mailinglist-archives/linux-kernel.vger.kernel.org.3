Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3811457ED33
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 11:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237365AbiGWJmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 05:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237340AbiGWJmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 05:42:22 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60070.outbound.protection.outlook.com [40.107.6.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A03231DE4;
        Sat, 23 Jul 2022 02:42:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oecnJrCX+aoIrbSpMR2JC1/FYxBcoVh2oEIaBSlC30N9R2E80saTL9oRFdvFXI5QE9ieLQb9xmbEQQfnp7nP29JNQ33G0l+rD3jJi3yX/HfJUzpFHxMdwOy+7OxDEnGjBrO3SRSiKO7ILoADZGSub60aAWXqaXCIVU38yR3VxnMlEoSmdY013u7Zj426Li9Rk/Zg3e/n9qhBqLA9Sc0F/aqJ3Nibld/AjgmOCRDjoeZLN0OQFHEysAy92TsE7DROPzvikA2sqOkWakqL9gylduVf2gkJfOS4BPJIy6QxR7fOU3Q2WPjaiaCm/OynnGa0nv9ut9HfhbLpAJJs8jlZJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UBYTK5b4TRlTYrGmr7ehM0GoUbS8S2V2GXT/k9o2byQ=;
 b=KSVrZxytdpmEOVLo0htW2Uv3F+C4nJom/CT/6Vy8tejkZu+etq39WUK1LOWZy3p/eSB/GfB9sNzN4BmadszYORaejPxPRMZ8WaUNIxjj+qaoorg18hnyuRjn3jhGldl5reSKurIMv6WBapK3uSIrgTAQ28UrJWywH/q5HYVtjo8ktfah2GiJRYQcrAQYkS/AsvsEis5VJgkSU8C1XCTX8BpJntwOupKzdZOcrIpVHXESIRBiD11ohMP/GTcDJDaHee4JfWMhfnKrh475WspKcLE6AGKFSlBe6UNxpnDfvwcYeflVaqfA1lZMmJf8XMSEoSjmngC0GaVz1cdpT60YPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UBYTK5b4TRlTYrGmr7ehM0GoUbS8S2V2GXT/k9o2byQ=;
 b=mAXQ7I8utz29rXO1J41bRut+ZdaG56z1jgEALPoUls2Y3yWyH41p+cDlaWYVxCykVaBdyDR0Wj0ZUbcnX6rWSTssLUooqHiDF03iUGQbW6PoQIzLLAa08tzuW+blzNYpTh+oBBTCPWjJ6C4CPZqneZRG8pV9w9f1qBxe5OlSwDI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR0402MB3685.eurprd04.prod.outlook.com (2603:10a6:209:23::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.23; Sat, 23 Jul
 2022 09:42:16 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c0c2:ede7:3b85:1597%3]) with mapi id 15.20.5458.019; Sat, 23 Jul 2022
 09:42:16 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, aisheng.dong@nxp.com,
        festevam@gmail.com, ping.bai@nxp.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 5/9] dt-bindings: pinctrl: imx8ulp: use minItems for fsl,pins
Date:   Sat, 23 Jul 2022 17:43:31 +0800
Message-Id: <20220723094335.3577048-6-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220723094335.3577048-1-peng.fan@oss.nxp.com>
References: <20220723094335.3577048-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0004.apcprd02.prod.outlook.com
 (2603:1096:4:194::14) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9af33b62-4dfe-45e9-a55a-08da6c8fa0f7
X-MS-TrafficTypeDiagnostic: AM6PR0402MB3685:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: x18wODiCxLaxV1+VGWZs+g+k4+WUQvK5BLbQnMtqZkhyxZVpVqgawdlZiz59XftVYSbtI7/5WPlwJs9Os8E3TecLHz7n+1fJ5LFLdB+edUpUiV6alBAknpfK47dVnKzTi6YY0Mi6ziqYxEIYB24oISDSveDxJBmFKafT6gCKp/1jxwwBDeXYJKTzSgSMq/ntwl+/+WiKnJwkNKn2cLBw94ALgp+2O0s90izos6yEatnBPnZtUrprJfe2EObzU7JYlNh33PAd8PSuTQvQZd2UJ/1X7Na/dXacv1Ntf+bT23NLn6hP+iP1gnyjyQzaEEVpgfqoHC2cR8BJTww0d4uhiJUdnOfeREeqAv6K2X/SiO6QnSxPP4vxOJphvbWAaOnB5IehCMGT8Qu2qs3KZ6AH/EqqYiczoIVumDzl+cAJxlUWcMOkAsidFIeS/RGPeZPQ41rUQQyBqrp18d1iZhmORZrKkK5YAq6K4vJTwf9k+wnTzHkN23Lj8KGpzBlEx7VF3MeE2egeJhRooSUyEA2ihWM/kpnWb2QwqV25YsdXY5Ck5IumA6zYO3kB8Xtwk6TPxzXeUXYdT3M2Dj6VkYMdWBgeI2S1YoOKg0gkdA7dJJGeMWnpihklmqBOtlVsck3G3zrffRvxcFMCHQFzEkv8+MD3HMNOKao6/vS96iZIqo/9WmI3hlOAIsADg7+Rn+IPVjMVkgj+Uti8gP9+ssob+zQXvr7Gm/vAgNMUIXCskOIB9vc906ZcInTcJLuGOQrLhCvaMZ8RGutXEZF/cgY3rt26FJVaT37y6gDJIlwhFnhmbJzHL2B79cDEBR1Jl8vh4x0Mvw6dWl2lovLC0arQQA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(39860400002)(366004)(346002)(376002)(316002)(5660300002)(66476007)(4326008)(8936002)(6506007)(7416002)(6512007)(186003)(2906002)(66946007)(66556008)(8676002)(86362001)(52116002)(4744005)(38100700002)(38350700002)(478600001)(6666004)(1076003)(6486002)(26005)(41300700001)(2616005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HmH7vt3pJ8BaLuPu1eWthXZQHtlEbC/RqzQQ9UrNFddJaoQllz9gw43nfDw3?=
 =?us-ascii?Q?DXvqYYFO+/vhy6pMO6MFi4wW0IXXfl4pIrl9OPIPD8LC0WcripjbtATDihz3?=
 =?us-ascii?Q?XDF1dHL9GFiAOjUDL5uItNoZBLy6flQCHlCfxvvx0J0iD8vKJIX2PEyApH6B?=
 =?us-ascii?Q?jE2oRFxJRAR8JhBr51Bd+ED5e+V09v+hZmKT0L2hwX26CoP9HK7JfVRR1Jcd?=
 =?us-ascii?Q?h0F/+T4KEsU/wiSXzqR90+5KA17N86UQNbq86cUin7hzOF8z1MueAOY7aVvh?=
 =?us-ascii?Q?vNS0nejb40Di+FunIO1YbO0WlBFDrqXsBIvKLpSM0jq2IuKCnQXOqd+/KA3j?=
 =?us-ascii?Q?mVLC88QX8IM+7sm6UqiOdf6Nmc90cCfgt5hrB5z5ltKAFXS8RmDZI5OJVzr1?=
 =?us-ascii?Q?czjU/GlOPbnybLIM/dv6SkkWO37Rup4pRLAEgmQALNKBIDMgZlnpqTamr1K2?=
 =?us-ascii?Q?sszPI6pVRsz9UgN1/cnZG4eVXgtuU6Z/jPrnMSxWTb0QEi46tOckXwDtHSQQ?=
 =?us-ascii?Q?TTayqbT7MRdmBW67o2GUa+/dL8Apt135GcMX2NQfzHB/h7ZCyCDgoL/vYKzE?=
 =?us-ascii?Q?xCwSrzPnEOQY6cCt6OwLsq6H1xQoMFuRuoEoSLZgyfiQYU3GZj3vqg4Ey9pF?=
 =?us-ascii?Q?7bF2gpyKb23DT4SZ6ZabcYPGwusomWmWFefOCbhNZjPm6/4uI2WgWVsA8b97?=
 =?us-ascii?Q?JsxMSco60ImHi9vHw7AXrIyZXI6O53EZu90DTe1exb/9wneskddBVouKVPbp?=
 =?us-ascii?Q?bNGBtDr1zxvHqccKyjm/+2dZmp4d54215SB5BRjHrilORTc5Uzdr1RxghSY0?=
 =?us-ascii?Q?qxU9xAxvhhcjxuqwHoWUfiVQb1kGRXnjcZmJ7OQBmV5p92bM++oRPtUYuG63?=
 =?us-ascii?Q?mdL0kzbHCy01/wYfL5AT1VU0Li154wvXVhQ/RSOpyxWZSK/rzZaVOg+MDo3n?=
 =?us-ascii?Q?v4bzuejyYg0LV4v2uSGg6oODDedLV4krnIs5TNU37NGDQzgmzDq7d6cxykkG?=
 =?us-ascii?Q?EX+2ckRMeNwThFSqNTYQeSNsp3nmqg2IV2GMBZqD90Grwkshlulq/N3TbrC7?=
 =?us-ascii?Q?dJMtvjJ+/ji/bN6WqGP1AY7Lkrk94f0avsAyMaYy9vllPE/hvxwbi9Miy7V3?=
 =?us-ascii?Q?oVIT67n6vqeCz2HsEyaee32M++pPxbcSoH++u5r6ZwwZEjyu1yU5MiCoBPNa?=
 =?us-ascii?Q?1uwVDWevcwyHwj3LyORMKg/GTTifh/FQQmVScNR+gvTCAj2lYjeIwYbq1I1T?=
 =?us-ascii?Q?P+QbSzExQtUk+96Dte/vxR+IdsFGifa2KqVBmZm48ZRcHaVIeoTL6INJRLF8?=
 =?us-ascii?Q?0a1KucLJY+Gb8JRfxIZMUCG5B6IWCIFdi/q6i5nfxCm9CcUwmXtemYYZRFR4?=
 =?us-ascii?Q?lieYRrerWYK0xTclijXGPM8z/ZMuBaM7zwkh0LUr+qWN0GQ6c0SInM3nqkRR?=
 =?us-ascii?Q?FdN4qcjSGyubUQHkTxr3iJnsONy3x9GNykDOkBKDuVxX4B08qojCSreiYFPr?=
 =?us-ascii?Q?MsjP+R3b1wuqwui8HgKCQeTspGunqdoUVktnJVfE559jMT5wajFuFBRfhLZd?=
 =?us-ascii?Q?hjyeT2eloPvNArFEss9ROkJqi981P+uXiGtFMM2C?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9af33b62-4dfe-45e9-a55a-08da6c8fa0f7
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2022 09:42:16.6177
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mxjf80olgEGhdMubHr+lym3A4t7A+zvVTHq7UoW9MqwlGDB/BpJhquJ9nU9JxinxRV9yKelhDDOvUCp7P3bEEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR0402MB3685
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Use minItems for fsl,pins

Fixes: 41af189bb38b ("dt-bindings: pinctrl: imx8ulp: Add pinctrl binding")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 .../devicetree/bindings/pinctrl/fsl,imx8ulp-pinctrl.yaml         | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/fsl,imx8ulp-pinctrl.yaml b/Documentation/devicetree/bindings/pinctrl/fsl,imx8ulp-pinctrl.yaml
index 693398d88223..8667481ffe2e 100644
--- a/Documentation/devicetree/bindings/pinctrl/fsl,imx8ulp-pinctrl.yaml
+++ b/Documentation/devicetree/bindings/pinctrl/fsl,imx8ulp-pinctrl.yaml
@@ -50,6 +50,7 @@ patternProperties:
                 "input_val" indicates the select input value to be applied.
             - description: |
                 "pad_setting" indicates the pad configuration value to be applied.
+          minItems: 1
 
     required:
       - fsl,pins
-- 
2.25.1

