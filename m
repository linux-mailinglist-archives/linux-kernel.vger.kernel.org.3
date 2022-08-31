Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBD85A7FB1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 16:13:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232095AbiHaON1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 10:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiHaONC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 10:13:02 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50075.outbound.protection.outlook.com [40.107.5.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C6FD7CD4;
        Wed, 31 Aug 2022 07:13:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BD9D8CeEGKvnEr91jFssQ+qFwKOS2KqhDCZhFpnnh8VgIQdoEtSx6HuxaWArRl2QEHf5ZVH7UWukSVU7ZlrUeZ5UPhgxhJlzrgBTs7Dq4dgZ2kgHSpdq6Ak/WY0BMzt/61kypnVf6Nx7pJdzn+/DpNCEUj/bg3EkTqquLbtl2BmAUOBWOOy874xuPKC3ZlL0gtiWYc8ZLn7xYWVVT/GIv1zfjW2Qx5OcKpvlsxxFZM0FmA2ESunMacLAugpfR/nlldzjie9FSdOlb24c85j495FmEdageIwWNqsO6cbNGc0ZqDdFooW2B1lakctjnu6gc/fC/sJjZBjo5gNzAtIvFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EJgHxlx+oINKviLPDODGZJLIoFlVYSAARQA1N4UuQaw=;
 b=H+M+hItWv7g3rxBe+cg+C3/Y1gFZPqY0LYdsNHSVSgUufG3l82gtaRxtbq+IZNu8DiwvzNrlJULLrpWjnlusUgoEWKLVuLr5Yt/mr//1Lc952gpKsENH0HIdeEE9FjVOHMBl1br/37UCe6J64jF1d5qLWDUfj8PKWlUPW+DGB4U3J+OqC3m1of8Wwp8SYf+Gsh0H/hujXxJMpIQiwAGaEINDFm428Q+/kY32Lf3BXxWxHalFLlGQ9KukP7w0b2zwH8V08qaMuEIpv0Dp2PQH5dDTQeNnGMwE9dQimNB9cVBVXfQdlb4IDfrvSDvPFR44++ztzpruPm3QzKfoMTR5sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EJgHxlx+oINKviLPDODGZJLIoFlVYSAARQA1N4UuQaw=;
 b=bTBOoQzM2uIk80ALDWHeawtqgslQPAmMKhWE/kRTn5CmiHQv+oxBiquEmIQ6G9Owhv25isxxv1Km4UIKVYvmVxLHS7zUCMUvR0J0WqzmCXdXIVQqrRIJsmdHsstXzuu9e+bwiwUdsfa2VhBfaACZcGRpK79zea3ODx3GdQ2K9P4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PR3PR04MB7355.eurprd04.prod.outlook.com (2603:10a6:102:8f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Wed, 31 Aug
 2022 14:12:58 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 14:12:58 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>,
        Jacky Bai <ping.bai@nxp.com>
Subject: [PATCH V3 4/8] arm64: dts: imx93: add s4 mu node
Date:   Wed, 31 Aug 2022 22:14:14 +0800
Message-Id: <20220831141418.38532-5-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220831141418.38532-1-peng.fan@oss.nxp.com>
References: <20220831141418.38532-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0010.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::22)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e0312f74-3154-42bc-cee6-08da8b5ae7dd
X-MS-TrafficTypeDiagnostic: PR3PR04MB7355:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AP/WJVak68GGOg/Ih0wLWnBg73yGJS3mprTIGIVuJzCmeQrZevDfdaVTRf/7e40j59D269xblNSd81aVBgngZ8vYB5wrqkHguHtKSCmkIeWAk2ZLYXERtB/dW/aw07+aahmDJ9/y1uOAYxog1wT92m4GyNrpDmDkoEPLR2D6ONFZNkylWBuayeYdDt+XAIP6S4/wyvoaf/Z7tlXHa3E5NdSOCB8AzMlRUL/yjEAyGAWOYEFFjTb9QfM9D4uineLdxLNC7MJML37YFZ24HRu3VwSG7j/MUZmZmB8VBv2d7tL3sdt8s7YR/YkMQzrbaxblgf4vGLjSpC3kbnAlwdrhjHSkC0MiBB82N/Z0OatRKlE7rjw1Mj8pKnMomiCbyYTr4N+liGNnqJ6xje0KVE/UaStgVH5wZHq1ZYlW69DkCDVgrBN9sW+FWYAW9mp4PyYQ5JIWiFnQM72nk55ASh9d+ev4IxJVpJLUsGvFm8b+UIkdtovhmpmGsn9JzAXvR1OUSgX2Ew0TuUDbgwaKxemjmuU/A2ncBqciJ/OouPSZJqIZS2+S2vzMQd5HA1Qa/yRSjgxYw42y9scxXZUVYrrekuZiJjS9dw5iou5rdpsXj5lYHGvXjtFDBCfIGUXdTw4PhjM1iQTOqyXJIf1uWxlIUieMf09ePJTEK5LhzC3WMlxzWrdexq5XzxL3kXygL5H2z54qsYdj4tpy/SmLQDMXj9elajGw1Sgk0a0QwCg67+awrlTvIZDYvZ2Itjj3DeuE3Zf5UYqKuPVEA9HshRGnlw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(366004)(376002)(346002)(396003)(8676002)(4744005)(4326008)(66476007)(66556008)(186003)(1076003)(2616005)(5660300002)(6506007)(52116002)(316002)(41300700001)(38100700002)(66946007)(26005)(6512007)(6666004)(86362001)(6486002)(478600001)(2906002)(54906003)(38350700002)(8936002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?X3eWV9zoh7NnPXojDTnynnmZ/IC6wBl4WQ9vdLrhzIF7TVImNf1JnD/JZvNn?=
 =?us-ascii?Q?BCBxCznmMRIE4y+/qV8vfIkgEVMGKrNyMm68xIYdXbTYN6nvLsaEQFEG5Rxa?=
 =?us-ascii?Q?KW6amE8vcFF/PHnF1xDAKhYGLLM+mQe98zo2Z6+SHoDHDNUux0O1bj7VmpPl?=
 =?us-ascii?Q?72ZuVhjjIiW/9JWI7J1H5H1LTnbe5yX+FOhzwUfJ6/hA3nKbR3zuV/6/l7Qr?=
 =?us-ascii?Q?+b7Q16aFY18oMkd0RMrxcyb5KZkoH83xRlxkPMgAhWftX9S1nPnlPQ+EUhaH?=
 =?us-ascii?Q?rVMIlS/cFK8fAM1w33bXkDu8l4x5jcp5kIwECyroi3b6C8p2a2RPrCrQi8Sz?=
 =?us-ascii?Q?xJkJyU6ituMl3J2OCkOkcVFECs/v7BOeQFPeBYyR+xR6w5y2feuJVtwTfm/0?=
 =?us-ascii?Q?1Uh/V9U0iWTw9juRMGKfYRWxKKcmX+ZNvHpB2HEJtz2iFBUfWY/uEGmmD9Hm?=
 =?us-ascii?Q?/KN5HLZGfHKQW5asaEAqc4g1Z8nPhk5ECB6vdwqfbYgWF8h2dMmE+4c2fo4e?=
 =?us-ascii?Q?LuvjWpkexJqpEiiF67LiCHUKz9QV7QqyAV0s/sBGlUfYnWXN52EgZyKULQjm?=
 =?us-ascii?Q?HNpcsDGrIHIebhmWcw55oI4HJ6IHo6lXG5vtz4ZIrIZESS07yCO//G7VGGTN?=
 =?us-ascii?Q?4PYKKtRAgkc5w0KBeEy99cYx77pLNNhquSSYfBdLPAbt2p2Ggvf0mSB0fvTy?=
 =?us-ascii?Q?1nb9qNJ5ORiMkl1Eay8a9FdNIMFIdTArWpHHe4R//am5TyIirxTEo/2VAMCk?=
 =?us-ascii?Q?SYi0eFWHZ+vQZN/Hd0LZhPzmDylJlvS+FiLHmQ+X9nw5t6WXmskGti4mM+j3?=
 =?us-ascii?Q?OYNAs/Cfkgv3QQMfrebgFXtxR/XCMtrNYuPFu36g9XwdJ6w5Qzr+SieDFfs8?=
 =?us-ascii?Q?gg1K9kRu1gJ+NdSv+p1aoVtTKOwPYuQutR3JaFn18j2NC7sJSE4MXHP5O1ut?=
 =?us-ascii?Q?qAGABHrkUr7c1K14FqJZ2mXXJbx5/leG0pdla4Pg9VOF7/jdZVl2OQtbXNiw?=
 =?us-ascii?Q?Y7SQL+dcg0gmVAtsb+9NOpFt5WQPuyx/I4FmmGkeItPU8O6UA/0NM754eWU6?=
 =?us-ascii?Q?swkA3TzaJVJ4p4zPxbEgdMhywzWe4lB2mFvXThzbX2z1BR8ytLzXY9qaEX6K?=
 =?us-ascii?Q?4qVvcv4z2YsHxQkX1n+WFpDJPpwCHw6hESI7C4s3fJ00+SSUi9EQdKG79hBB?=
 =?us-ascii?Q?Hu3Eynfpr+MzJkv1Ct3FYDK7ie9qmjBIFUShwLsytauAp88kM+mUfhgynpQc?=
 =?us-ascii?Q?yD2NGns7KZ8xb9nHXYVjYHtYA2SkfLYZA+D4wV8nRuTi6vfe3goumub5FeUc?=
 =?us-ascii?Q?21fw1JF717754C4VbGVF0cTasYZy0v2K2l3/x58gaaYKU89vzrhzSyYcMsVd?=
 =?us-ascii?Q?DyizkN/Vr621kDnBlStQB9gRc63nHLYsa7sQMJt9tmpQ/J9HuJ+73eZEaXxv?=
 =?us-ascii?Q?6qtKiYv9Bxlp9XjAMU65PJ6rDDkPtwfPZFsExrpq6vlyao4Zv4i+uqN5xrRj?=
 =?us-ascii?Q?9XJM8uFkhNABPeprpuey4dPjgg4vZglep9yc28rR5KeDuB6MVVMOYOz+dzrs?=
 =?us-ascii?Q?nnn9gFhc8SdXgVmBg0Rm59oXoTvHqUkBbzjlqy++?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0312f74-3154-42bc-cee6-08da8b5ae7dd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 14:12:58.3031
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T87uL5AZJgmaVyKRHypgFz5GeNTA34xHft6lC2NdYcLWvZxxpHcL7k3s3XFKCRJATmmD88GrnqB1YfmkXCLKWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7355
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

Reviewed-by: Ye Li <ye.li@nxp.com>
Reviewed-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 26d5ce4a5f2c..dd76472ced46 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -342,5 +342,15 @@ gpio1: gpio@47400080 {
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
+			status = "okay";
+		};
 	};
 };
-- 
2.37.1

