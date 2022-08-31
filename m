Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B320D5A7809
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbiHaHtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiHaHsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:48:38 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2075.outbound.protection.outlook.com [40.107.20.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4FCC2E95;
        Wed, 31 Aug 2022 00:48:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dsia/N+adQUQ29eryRFRQd1j4LmcRTanEAjjCHseX139fezWaS99F2GQtfRGvDR8v6dRCk4CZV/sML+eC6kXT9/qfXZy9IIF0L4qXfdWxjK7wQGsSYUX6B9gtQ02h9fLMulV+3YFFD7G7xy+Z09nrSWlbt2XCrwh81DgCmtKhHRXFCXGn9PEebyDH21PI5I9DyEGsbPiqcyIoiC2sHSfsNa8SO36VRQP/sF4ELP1L8OdzMXF7+l/BJKsXunwwJkQMJcTGdD7jDa5AZ1OxWTqc3E90r+xYm8AMqKddi9mJ3bW9x4owYW5mlc0WoRZ/30zukun0HqTgr+8iTiCWxGuZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8OubfWbUuNpJVynbWNmE4fImUxV7pdGQhem0qikWI9E=;
 b=Kg+LDP6Q7n40QO6yeVcwM008q6Wbeq4SgUkPpxlNNjZJWxdecnP5BDVaGSAqajGGsJNeKzpqRqEyhrjWy++/6iqzbZd4wpeJYJA3qVTWuXi1yX5beSVhUwBDy/iIiC/SPhWj957nOHGZR7d6+3bL23EWQDcHodTlRqah9m9vs8hJP2uwQ66vh7rWz1ZYzapw+VLvjdem+51rNzsPIKGOUw2filxeNb6cMFrDH0PVKE0CCCipK8iFh+rw0Q2LOsT47R6LvJmTYtoaw/5L1XRzrLWiqnYFX3xPquSyrzx9bIDbj437wYGShRVrO/rAQZJbnWpvjrYUu8d0itHIo2etXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8OubfWbUuNpJVynbWNmE4fImUxV7pdGQhem0qikWI9E=;
 b=T126w8qoqQ5UIu/BOaWgY1BqynowOAydclXiVp/QSWt5I0PHOawfFiv7UpuM8KxwCzEGZ9Ei1f3z9fguVpq/eWAWq90Vy6WMyyVXOd1p8Nok2H3CGwopiPW79DHuPbC/DgD+2ZH/3Oa2VtI3v+H7Fu0glbBXC4HaDEkOgItuMeo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA4PR04MB9247.eurprd04.prod.outlook.com (2603:10a6:102:2a2::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Wed, 31 Aug
 2022 07:48:22 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::2d22:3315:6f9b:82c7%5]) with mapi id 15.20.5588.010; Wed, 31 Aug 2022
 07:48:22 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Ye Li <ye.li@nxp.com>
Subject: [PATCH V2 6/8] arm64: dts: imx93: add a55 pmu
Date:   Wed, 31 Aug 2022 15:49:21 +0800
Message-Id: <20220831074923.3085937-7-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220831074923.3085937-1-peng.fan@oss.nxp.com>
References: <20220831074923.3085937-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0188.apcprd04.prod.outlook.com
 (2603:1096:4:14::26) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c03df258-32fc-4f11-2776-08da8b252d5e
X-MS-TrafficTypeDiagnostic: PA4PR04MB9247:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 236bLsTHVfEqIBr0rbD/Vh4rty+U0rkcWf0pyQxEptdFeNINX9ZpFwOSP7BPYeV5MSdQ4u8vXmPQrbvijqzf2DrXfnXeEEvLDrA9S2Jiuq2zZY+tqtZXoc7FKVuV+lrkj9cCR1BAtkQyVylPZM0wlLn1G0KCDbxfGP3ndjYdCtv2s20eQBELAkmraighwreBTQt52Fyu1xve+TFDVU+TTbYWueqW7mjBDe1tMU690ubpRVB9SPY01BBdNJ0qvcfYif8HulV29w1yHeS3tVAkelWostB5zyK4ThgCT0ROWNcOXX948aOYSIv9nSOJqP2ec9aZzZJeIAV75RhVWTe3j8RcoZpTuUF66oVHuxy85+Xnv9yrAZnS6dt2XHQ1IiPnWMVpCnLWdIbsckhuQkClwhp51Xc7ioVAe/Y16K4e6kxJDSI5SEnBU08Ft1RIByN90dGTdXY92GTu02nEs/ZWAy/0YTjLl1cRBBKn2Umc/iLiwf7X4CdOuetUIp57z7buEITitlKFpLP0/3mfo4jx64YMODg5giHG+SJXojVkfACHD3YNBaBIntUT91yk76IJxI7hdHwEyTYcbcx1n+ISt19JEwZwgG3IQPxRnZO/7cIaJ+Jl2xoPObVf5zE6ZYup53hY2fEZSZWx5oRU4v7T5a6xXvmXKrSp+5iDMECiqu17nrpnwzDNNgxaFIyv0lkxeyan0/P1ACGlj3joRcguz9tRci1HHY13/TAIcDO+IlPqD4znF5fT8++UsTm/bBt9d2Z2k3sFakOXW0p3wJfS4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(39860400002)(376002)(136003)(346002)(66556008)(66946007)(86362001)(38350700002)(41300700001)(8936002)(66476007)(38100700002)(4326008)(8676002)(6486002)(478600001)(5660300002)(54906003)(83380400001)(186003)(316002)(2616005)(1076003)(4744005)(6506007)(52116002)(6512007)(26005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kYaM5BUv9cX23U0jynERc6Qft+ZHQllwonbZo4gvW7c4Sxeyd2IAzvg7h8T9?=
 =?us-ascii?Q?k1fzYtONKjWtHVw9VUGukyLdh9DTHTh6596/rY0YxTZTXIRKP3New280FefV?=
 =?us-ascii?Q?5twGvBTpkfq4JtneHmZbPwBRXIooThsWpqVJGxAI9yeb9yTf/39BYh8VCcbZ?=
 =?us-ascii?Q?csnmajJ5j9jLRGeCEv+dizgxlJvZ6yDzT2TTe2z49NsHV6KqOudqqEt7N7Ox?=
 =?us-ascii?Q?cs8NgsKz4h61JO2wdPO2ES7Sy246eymwl7aid65fSfOLXIAokGmii5kIBD5t?=
 =?us-ascii?Q?VzLB2cAa2LyRu9SWqT/fKAeHgVUf0kF1GxFOhIpCwQuS4irCpxp1bojQj7mS?=
 =?us-ascii?Q?KLoKbyoLHEFe8+O84/hJKBlUahJUkAQ6Ancn0URh1vyAU0s8odueL3HBCd7F?=
 =?us-ascii?Q?HVTlKEDLg5rJoWXPozD+ZJ+XfSNPdK2Z/hGtZK+G2ce5tpdpkIWv1d08wv1X?=
 =?us-ascii?Q?B/biEx615S470UNIB3NWhiT8rswHB2LIPXdqAnbiRo+zBiBHabDMDH8cQs42?=
 =?us-ascii?Q?mgiYnbH3JStVBwfYq70v7Xhvi4K8UraFKb2DrsD3rGSgWDxQ8nkZfnOqgLF4?=
 =?us-ascii?Q?UZYqlnoQxLJ3oZ9y8D0fBHewY4J3oI5P0Owro2//p8ltsmH1WJamU1jZLixw?=
 =?us-ascii?Q?dCQ7QhsYX+qn0uhXbQp/Rjhl8rrr/OPq5dzjo8veTnVD2ta5xJBTQe+ccUXl?=
 =?us-ascii?Q?gfSz0E8Zxy13+ZcrxaiNunh9mCY6vxHHb70N/ITRqm9YSU0kkjsq5SBEDrwr?=
 =?us-ascii?Q?MfWuz3bDd8TtUj/sNuG/cm8h/XInjup2SwBAKTFiRHN9AmNr8yafY8mIe6DJ?=
 =?us-ascii?Q?LlF/YEmo5muI6nSKUpTgYZJ3Tk+h8zxxREKOBkjhc0xKJI+yQ9IOzN2tnCpp?=
 =?us-ascii?Q?VIDeWRve9d9xbteuSdzFxpsu1n8KmtvwQRLSSQcyBCAwYtWJbPrHnW/lKe5+?=
 =?us-ascii?Q?gjM2C7L+m2RLvwpplwm++CXQvul42hHTTp4Tm9yBid6iKnfDEIYB0+aH32yJ?=
 =?us-ascii?Q?otptb8+WYmYTa2sbrl9YXdNa0WlY+c17HL+Ok/0IMp7cpMfiYL/WWv2sNQql?=
 =?us-ascii?Q?Fz0fKCSChOem0uiBTa3k0RIzhMerFGTnyu6i6+gEFuPKPZVQNNJ4bbT+nbw9?=
 =?us-ascii?Q?mxMElvyCyA7nUhlSX244QYDZJAnqLPQiPSmpLrYPY6vXlE2x97OFRwd99i1A?=
 =?us-ascii?Q?DWtdMzXSJ3H9vJ9tatV8KNMrcvGOBBiHF8EXqFyFVed7mBls6h7UTX7nMkNo?=
 =?us-ascii?Q?UJccw+mbXVvkDMrBr2SLgo+8XbcaLYkTLOCb9ir+mwdCv0GRyZuSdcO3E90K?=
 =?us-ascii?Q?bmS8tauvwVIM22I5VwbtAi2qlAALJge17nE3hC82phuTgTQsbPSsYQj6sO0E?=
 =?us-ascii?Q?/OTlb4jwOqbaTr1IY67+aqSA0CEEE1GtOaQuIjO8JmZJC6iHHzzoNx5mM1is?=
 =?us-ascii?Q?ZH6xGoiODjp52kyFEETQyQVVq7z2cl2b5V1bAZdWroyXzifbRKc2/uNfmJzV?=
 =?us-ascii?Q?EQ0IUzkbR7t/NGu39DKsv0tiQOZ+91QrqbjCSpuNsoEgEFB5ZyT3ceBaK03U?=
 =?us-ascii?Q?Bb5plvkuHl6CeddPWs0GfJfE8HKdwrmxrfeDs0YG?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c03df258-32fc-4f11-2776-08da8b252d5e
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2022 07:48:22.3780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 40ARnZCNTHX9Rk+kZZtuGi22X8fv+5EE08luKGD7WtZxd/FjK9mdg4H3k65XQfPw+cZQzhbDY5Wh0LlnxviDlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9247
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Add A55 PMU node for perf usage

Reviewed-by: Ye Li <ye.li@nxp.com>
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx93.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
index 47f98c634365..f007314d8f1e 100644
--- a/arch/arm64/boot/dts/freescale/imx93.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
@@ -72,6 +72,11 @@ clk_ext1: clock-ext1 {
 		clock-output-names = "clk_ext1";
 	};
 
+	pmu {
+		compatible = "arm,cortex-a55-pmu";
+		interrupts = <GIC_PPI 7 (GIC_CPU_MASK_SIMPLE(2) | IRQ_TYPE_LEVEL_HIGH)>;
+	};
+
 	psci {
 		compatible = "arm,psci-1.0";
 		method = "smc";
-- 
2.37.1

