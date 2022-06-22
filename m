Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD3EA5542AA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350076AbiFVGNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349563AbiFVGMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:12:54 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80048.outbound.protection.outlook.com [40.107.8.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D3CB07;
        Tue, 21 Jun 2022 23:12:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JgxBvUn4ySpowcZzeNjJoJfaFKeoyfcXys4uW5UNJwOBufIFpq1UN3UBwRvJpF35oViE6wN6pMM3eaeXnGRwMi/yN88a9DKG4Y2/6Xiw9xY1UQp7ROQH7CXHt9IDjaKKh+MWr7uhtljAK8FmUPz2BbN+cfIpMnZ7DqsgRGcCy+zs8MJuJgQo5tCVr9hHd8oJp6ZLk0m/qIivyyasWNs6b6wS8ik/U9ei9tyBsmqQ4FOr8AcgSrm4GsKQOCN7NY2/qQNTt8DB9ZEDVjs7+w4X5F6WJvWH7JaECBlZu6uIDXc74X79LWC3gBDoWUEerNxM6nCNJBJKSqC81C6tjScQ5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBItxTJ4bCt/zXiLEJHkSZHKd3Q3quIkbpmdysUlQVk=;
 b=c/gB1FnM47+ocR/GcjQdSeUxezWoQ8XHA6L9sRYEkxkiOKp/wPYuC5xlgcBk40yQVRYQjBEgF1iswE/8w0N4Nifu9MQY587VJ/Cqz///9mVi4Ex4B0EO+0xZk56cyHf74bpsrHFCFNffXRMEgpChQV5EfjZq81q31CeXTin7Z0C+0CYM5KPgwPTlOgBljvunMPQEMXa9Mo11omGHgzHUVEJdrcJyOprx5WNY/83TTKzdfzUjoWsjlHUjKdPyk7zkn20MYGOSvvvk9pUr12GsQLSzSlpN9qmCd6+Fz0C6EjmJzW51PXMz4T3uhJgXQi3ukgiYXr0hHFDTDLVu7YQIRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBItxTJ4bCt/zXiLEJHkSZHKd3Q3quIkbpmdysUlQVk=;
 b=Byxh6iMZczmGz7E7M3tbY/K5AZWzDGI1NkxLOwhMaO6Ajj5IeA3LfQVTLYJVfdVI6dOKgqLsBzMAP3erKVj7n/q729mf/+5t/8763yERzj8no7QPnmR06jeSmzGLcR5ZPBHZbBjx5Sc/3uZkBn34Frb1SgxW8YsyRYEsPGQwe5c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by HE1PR0402MB2796.eurprd04.prod.outlook.com (2603:10a6:3:e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Wed, 22 Jun
 2022 06:12:49 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531%6]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 06:12:49 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     festevam@gmail.com, linux-imx@nxp.com, hvilleneuve@dimonoff.com,
        l.stach@pengutronix.de, abbaraju.manojsai@amarulasolutions.com,
        jagan@amarulasolutions.com, matteo.lisi@engicam.com,
        tharvey@gateworks.com, t.remmet@phytec.de,
        u.kleine-koenig@pengutronix.de, t.remmet@phytec.deh,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH 03/14] arm64: dts: imx8mp-evk: correct gpio-led pad settings
Date:   Wed, 22 Jun 2022 14:13:59 +0800
Message-Id: <20220622061410.853301-4-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 1891d451-38fd-462c-5ef9-08da54163baa
X-MS-TrafficTypeDiagnostic: HE1PR0402MB2796:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <HE1PR0402MB279664F168707257676AB04FC9B29@HE1PR0402MB2796.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4t31ydFUgAgcnTE8DeMrn4EdX3KRMszlaTYu9TItMqPRhWdyPCwrUO5vXgx5FZiBJ7K0mtE35qSs0OUvrsdaA5mmYkeKgGAKGRkC4n47y0G3FQP0+YBUjk5yMHDsnZ/uh2kfrzFOD7KzpzAIOEJigO6wSP/wXgSVStMESvgcFx1OTK30jlglZRNfj9TSOPI16Q7o7ijcdKZ2uljT9TYG0RK4CyPqcIKQa/6DS6+mf499jLN+fMhni7W0t7yDlW7gBty/hscYaWYVhnGK75RGJgVrXE8p2sTk7wcthn0fT0ZvMG3UdfwvxE0+1HOPNHROuFFpFzPWDB6bAlbs6+eWumI7PZHH6XOKQsWsxBS8s0F1LXUOQM252dKQKgpf5bJw5WBkcJoxu/VZqxLAwlw1/cXglw0T1acn15Zte8vwIQsk6yZ/mZMsJAt/0Z4Pmnw+oHH0DnNRbtRjR5VNLqn13+uOT+BM8gXg/sLPAOFc7JbLoIpW9CGP1blcnIO+i2TjEynyZrlSzWyrgQLN+XdX/1hdbb+4pPSujyDuhEmT5enh5Yo6ZpbWadOTRKiQpNIH9Gt3+TAfR0cMUylTcGGHmxmSkwOJnmg4WTv8wzMjfnWWZM7k8vreGKGT0FuYp0jlhfut3qmMPXuvzMgw2Yc6/6c3BTN6WvXdMmF8hXXIQPG6A4jhNUl+AhvKPUnpKYVNEYipbS/RzG+l1xNffYnDgxEe5G34PBCVWIYLsHrDAqv8l5A/2H9UrvTkRYWavxMtBRXtWJf5OocZlQVaF/GoGF9fZgMwV3mT6F0zrAyTS0Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(366004)(39860400002)(376002)(396003)(8676002)(478600001)(4326008)(8936002)(66476007)(186003)(316002)(66556008)(1076003)(66946007)(83380400001)(2616005)(6486002)(5660300002)(41300700001)(6512007)(38350700002)(6506007)(86362001)(26005)(7416002)(4744005)(52116002)(2906002)(38100700002)(6666004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IodELZ9adCT3tfvLsqxYCjpgUnhDDMiIPkHntKJ0ULS0S8xWFtOtwO+8qDdf?=
 =?us-ascii?Q?ejW//IwLaMLLqjhzWoFbCzRPiMOyc2lhJUhu1/JfjS4/Ma+w3LpxuVX1CHUm?=
 =?us-ascii?Q?CZZW9b83Sl8BhKzbl3Z/wpSBK3J86ImbSEaht4WPpBra+M5tu0CiI4kgzMJD?=
 =?us-ascii?Q?A+n1rEG6PiQyBEW4aHItNgdn6Ca1iujqbz4IPplL647/wfmcc4PB/Ei3HyCn?=
 =?us-ascii?Q?0CeEPYH4ha/TlF2t9D3F6uZ5DyK/kOvJE78gCNJ5DtEcSTDSUAVhS8JSSo/5?=
 =?us-ascii?Q?/5osbvpkSo0U3cF9bhiveh6ZfwK1WD0z8v+Szr9cvcDvrf9121i0nib78+O9?=
 =?us-ascii?Q?J4cp+jEMS+Ci00FRUuLzUnSjseBlT7J9HYcS58lKh0ZX4yjLF/f7MP8lXUwD?=
 =?us-ascii?Q?pj7zW7UAib2tW/CpcCFMYonRiBtsp6lC/ygKoSCQFo/wFiqYLipTIJS2m+ud?=
 =?us-ascii?Q?FO7UoCwRO+2CL4QYu+omY9Kiat8QFyqeZ5DFeUHQKpwQWVBh02KIAYREYwBP?=
 =?us-ascii?Q?uGLpqCTpN/lPPcYEoNS5RJNxqEsF/hhMZ/ZWBMKw6WdpgNYmFzEkHzp9Rm37?=
 =?us-ascii?Q?AN6Ewj/6k79Ysdiwiit21gdWgk2sXbNhnuaHQm/PGLVqOnjsZK/j9mhFGLfU?=
 =?us-ascii?Q?4cJJ3HpJNRiCG5QOJEJ8naUFC6JbQB6VOqqiFdoODbYFqYUSKeqzylcSwJrz?=
 =?us-ascii?Q?/fg/gxPMJd021GlskKqE3RF2Oro+EmUJa75xAsk/UC2lnGT3pXN1Sp4JdDzV?=
 =?us-ascii?Q?z2KRFH/A4rjFEIeqcdbA9X4VmrUvQm0qnd0P0Afo8pLDVwpYZooizh2bAuH3?=
 =?us-ascii?Q?wM8WnG58QQa1vgP4D6UOOup8aBJ9F9IEW65BBbo2xnzxeDAU7OjfabYZVR3C?=
 =?us-ascii?Q?ohhOiAmU+6pC3NIDMiv6lhpsqckE8toz/e/XdLngKWtaxl2y8IM8+SFGeulj?=
 =?us-ascii?Q?/FdMuGoaMzN1VyvmXjTPLF15fFjoWyG95Jq5b6x8lpLDAhhSXzMuNJwMgQzk?=
 =?us-ascii?Q?Dwp3wi6HYa+D1IL56J4pdeBCoern9kd6Y+I+CqQhNWnCESrg1WuH9/1Cr8OL?=
 =?us-ascii?Q?50jk2NDXWeX4imcqQou1DwCpUN3bCICcw58PEDPWv/T0lg+a08nVZ2fE9mNF?=
 =?us-ascii?Q?kZj7Q0oV0sBoiHWc7hzoyVUrxYVtPe0lv5KrcRhOBsAb0BSTqXXMWx7pd8Ta?=
 =?us-ascii?Q?LcJN4Kkfw6W5DP0SC4NCJBXAXD08ZQBGgREr10Ld7wRbq2K6+JO81ayFb7hv?=
 =?us-ascii?Q?cVy4oSSiLRwkovzEZTaM1k+deWPWdPBjVoiC+zUjxJBC5sFQsfNRZRX0YTqt?=
 =?us-ascii?Q?TYzU9Eadg59k279y/0KhbpvhAc00eUaoJzpxseqwEXPVyD98A6M47RnqJIJ3?=
 =?us-ascii?Q?kNYtM149KrbunKmpjzDsFS5Phe7V0PbxyVrKtjzNEVWj0er4nauTNRW5X8le?=
 =?us-ascii?Q?KV2UybpYhqI7zXnQD+m3OxjtnLkdvpq/6AWIVfwWyDlZ5PDxKwgxNjiqs0J6?=
 =?us-ascii?Q?q4SlISYtKStBCtkfVLIw7CLFYIzgu/NXNXq6SUbPmiVbUCxzeTJxdjW1dzJz?=
 =?us-ascii?Q?zv5Ckdwe4EnP+e6tafSJKADDoxEVAinSd2rPzfSz0VcS3IeSlM3RAKs/rQix?=
 =?us-ascii?Q?uxHHSYMhhYc6GcP+Sy/8IZ8SvQD4Bop41cEFp3JX9E0MUjKu7sat1kfS8scY?=
 =?us-ascii?Q?Otj2r3WZqyk/9ojjOWWplj5p/XoZsRhUbb32xFm0FvPHRDpm2hVg4NfS8ekC?=
 =?us-ascii?Q?+tuIuVRtYg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1891d451-38fd-462c-5ef9-08da54163baa
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 06:12:49.6518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ctqCWLTeglIrsVBVFuH7XBcAmKQTqqiqjw6RZhpvMKiCmbXpQ/i5cjgK1vk6r+DrSngM0oA2XJAN5n6n3okBoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0402MB2796
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

0x19 is not a valid setting. According to RM bit layout,
BIT3 and BIT0 are reserved.
  8  7   6   5   4   3  2 1  0
 PE HYS PUE ODE FSEL X  DSE  X

Correct setting with PE PUE set, DSE set to 0.

Fixes: 50d336b12f34 ("arm64: dts: imx8mp-evk: Add GPIO LED support")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-evk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
index b2f6c1dc8104..0e94e10a38fe 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-evk.dts
@@ -477,7 +477,7 @@ MX8MP_IOMUXC_SAI2_MCLK__GPIO4_IO27      0x154   /* CAN2_STBY */
 
 	pinctrl_gpio_led: gpioledgrp {
 		fsl,pins = <
-			MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16	0x19
+			MX8MP_IOMUXC_NAND_READY_B__GPIO3_IO16	0x140
 		>;
 	};
 
-- 
2.25.1

