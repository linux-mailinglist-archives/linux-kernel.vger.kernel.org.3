Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DDF85542B6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 08:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352045AbiFVGOC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 02:14:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350942AbiFVGNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 02:13:39 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80073.outbound.protection.outlook.com [40.107.8.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466DE2F8;
        Tue, 21 Jun 2022 23:13:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lfdaT6/H/Y0C9vcZl2BFFY/4b96JVkFa6Wpw17qrTU94TyA0oaa4Dp5BVQRi+bOK7YkA4MD/Lpx3bs5OLmHiuIfcJNlBJaE29GLCVBDGD2zRfeeA8BobfU3eFfOOHscjRdMKcWYWYQOIUOF1z6rluUjfl4c83inVmbiCnjuze2bVoi9I4nzr2eELjMgn97aKOln+XCnbYImpaRKpr2yLaRI85ULmCOnVhkwGzRZr1/vTr3vjk3qjzvUQD1vMIDDAqueIcMUviEdWodnwKRAPSpJVuoTtgUWwlGjNYzy4Ket+GPWVMsRFtLwJz0rAaiKvXsbWM7mXuzUPQLJW8+vCtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ucFXXwmcpDHfwaeoUC8DVE7OhAGs31zBwrtlmwOgdrY=;
 b=lbMLAo7+5sc0Ot9gLREUjJH/2NmRWFwC3KFEaQMNtvDJbwY+elqYmPgzMQj5zUGsxUyn3lUSchKvu6NXHfLL0E8fL3ZPLObBRlTdg39SLla0sT2CGFsHWj4U+0Lnmu4Z21siE7z+NF47XtKFNWFEsrrO8nyZSa1gaKdeXb2DZ0tGyfsTEHttQ0voQIF0qttqVPVYJUkj1oQbm10680ptJAekFtCmkbAhRQ6lqBRD3aXtRc5LfIfrQ/fn+YYg33E8eQ9kVcD2hk2FttR87La2kxxEzEnBvAJTK0CCCl2mZc0JZ7nqUOFKGXPNL2qWUefdh4oswWkHPkQyTEJw7urHdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ucFXXwmcpDHfwaeoUC8DVE7OhAGs31zBwrtlmwOgdrY=;
 b=jtfc7YwR8+DMe/o0ZxrjZU3lTHoO4OlkFniTq6uwqA0YvV2gE9ZeJKtncLBW9XtYNYOsNNbrSsLy0TKYCoFh4Sl6Hwbwi6t9uOw6JTMQl/aWnUQ7jNoyEWgU+Q24j0zldMlh0Z+bmoPKpEf6mOZKQ1C2TQwq2GVpgmdxCqI09Ho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB5623.eurprd04.prod.outlook.com (2603:10a6:20b:a9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.22; Wed, 22 Jun
 2022 06:13:35 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::71af:d414:52be:d531%6]) with mapi id 15.20.5353.022; Wed, 22 Jun 2022
 06:13:34 +0000
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
Subject: [PATCH 11/14] arm64: dts: imx8mp-phyboard-pollux-rdk: correct uart pad settings
Date:   Wed, 22 Jun 2022 14:14:07 +0800
Message-Id: <20220622061410.853301-12-peng.fan@oss.nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: d31e0b35-9f3f-4bca-fd8f-08da5416569d
X-MS-TrafficTypeDiagnostic: AM6PR04MB5623:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <AM6PR04MB5623C132A158130901325AAEC9B29@AM6PR04MB5623.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8iqoPCXyE8ZbyRsi3wPs+3JgqCtaiAd+XDnS3C5/qf4MoNyycevOMyo3U9AaifxRNm7kTkVqutMkN7Tt8WIKfJM2RBvs/uNonyanDobsRcJqw8FS3hb27Wl7BDbMwZBUb1owkOx/Hiad7opoMhs3LtCA76ODGgJyQlKBcb2S64wnyDo+CdK6xlzfnevKg4l76dXgzrBchzWC04wSWgEJwWjtR808KLbsAnola8XHT5xrl/TN8kFsIBvOSXC1e+Ets//OxFnN4Zs4iwOXH+0TuMiwhAwFGQSbg9o1BNoB3XP9PH/kK8y+JswL/wHVTDdFbxa7zI1xBWUOShr2V9/q/VTVbPUi3kTnKaqN/Fu+Kcf1B0qOO/VHsSI94VuQBmh+3UfDG4YdqkBKQmhC7GFtHA43GZKYmNAbWh7WLQUMw1insRSZRJGRJdAXSS4uhMH3YUfk2470+HKsth0s6NdcJYW2Zir8LCqgsv9ErycDtEVQZcxOR8ZdjDI4SJmtukmXZ+aHjDmA9ecG4HZLD9pZcUv6cIjAS0V/atp6UZjJpwhqSmhF9yz2sicVl2eXEf3Ixp3UBoTKOqq8ob+OwpDkibC1k9To8soFgDbBNfBUrqL8FZq330stMEDbSDbpJ/vUSZHrwAxCpYADrKda+DwDqVxXIVe7WqYvfHfeHmhP9M+KECuXV8bTr3ZNsf4ctZJAqTGXgjMGAqXbMlLM0wb5fnNjuR+Wa3FTDdDuqvdUGe17tIQBXdvnYGWuqgAhFwm33dz90x7BtrakMqFMUVrwDLuyvbhd0/ufsMHKK66MXsxgOaWCY806kiuOpRyJ/tDa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(346002)(136003)(376002)(6512007)(66946007)(4326008)(6666004)(66556008)(8676002)(86362001)(316002)(6506007)(52116002)(66476007)(26005)(6486002)(478600001)(1076003)(38100700002)(2616005)(8936002)(41300700001)(38350700002)(186003)(5660300002)(2906002)(83380400001)(7416002)(4744005)(32563001)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JztJ3nLl5kgaF7hKjmANOjb7NOJNpetwW6OqTEVDXqeKJxziAXFUw1tbx17c?=
 =?us-ascii?Q?qVaUEdjbxfsgZm57Ct+/q+78KXIj6bAQTJUmyuoMvaoGfRHfuDcL25eqgBEg?=
 =?us-ascii?Q?Zl3GXRUiOfGqZw9Zzg8GLlS/jiGIqMUITFKMfrBGhH9L73I+X0QXlTm4b6nk?=
 =?us-ascii?Q?EiiuCBq1bfH033xoYsydQOfkbThdFoNqzu+yB7YZsAw8uFXyLJYDZhTRFKle?=
 =?us-ascii?Q?mlshC71L4VZec613mIgKU0Et2h1NlZbfF2aFoYY1Dzq9xHyIFZOyXbjRiH45?=
 =?us-ascii?Q?bOzeyGlFeHLZHcN276ewISoDwFnZjh54fPEGsedgEbGLpQ1TV8JEStAcgTu5?=
 =?us-ascii?Q?eRExC0vAvEx4bykQ9peN7xXIij3vikTC7PrOrVzc2vLemhTehKDYJRvk4fMD?=
 =?us-ascii?Q?oabiP0AIPFA93Zw4REqTDWhPeNndi4A9uQatUDLhFZa4ksi/0Nvj2FLKmpta?=
 =?us-ascii?Q?79CD6Ss0TXMb1Rpu3kp7CjRtUo/IRCkgoO4HT9NuLFzOxmq+OFwrdu5ngNZJ?=
 =?us-ascii?Q?dc0p6KnhvrFqxCLva3bCl3m5+KbfL+vKI6IRads5ONDil9SkpEi5DjAh5nck?=
 =?us-ascii?Q?XIWbo87pVXubajy4NQ8HI9nScELMEvVahRBu06tmz7WceMEHhNZ3e/gBSfSh?=
 =?us-ascii?Q?MVq976rXpI215rAuDWvfKiX6KZawpCbA5558wmc0jlHL+HJxn3SOhmY9Swku?=
 =?us-ascii?Q?a5ProVMfqKlek29Mi+fDpX88D4/6xED9SkmX/vFSPXyVU2oFr2PR98gkcMO2?=
 =?us-ascii?Q?M7vJ8LqCmjB7KVkIYnmv1r8J3bELqyAZ3UEMd/l0G7BJ915CiTM5kDiQeetl?=
 =?us-ascii?Q?CEhseyVVgy72CHaIk6pWR0PFfCHle8LQe0eQKloltg+nNPcoxVUw9+HfbN3h?=
 =?us-ascii?Q?anAlmVTkByERjPPC+c71x13g2Sprvm19HKNQJmwVxxleF77VC9g3aOuvzB3b?=
 =?us-ascii?Q?IMS3tFWfDkTowCHFehYcTFLsGyH4lEc6xgxpb3AHiZq7YOTKG09GYH4RDWNS?=
 =?us-ascii?Q?QD7it2LvHLyD5CEy7AuNn+vlj1Lu65Uxi0davTmbEnElazfeQaDD+GM8VPGq?=
 =?us-ascii?Q?ZBb0lO1tE5wwvNvAix4lp+XvgsBXQgPQjA24HM1IJgjBOTWYA7Aca+AUSfdx?=
 =?us-ascii?Q?3uW+mf+PtemGIvBQtSBw+7Xzpsb1NEBaWCfiYgf3DZoWUqOVzznUir0vKk5F?=
 =?us-ascii?Q?OnUrxbGS+CxyIcQsA6eMt2tKm5bo8C5pHxDtOfZJxAbcecGsnX2Ma+Imc5Bm?=
 =?us-ascii?Q?KvPsvM85HvV07LOdPzXFQ8Yl7RJRc3Ovv4O3wV5ohCHlX/81ixtP4kF0PF44?=
 =?us-ascii?Q?rFbj1xigX4hP26bYbU5aMuR7hFOxUAtkmOz6y/xndu2duqXgKeeLdZmpdNTj?=
 =?us-ascii?Q?N8WxO8JKwmLFZtHFs3Pr7VjRKUJgTF5Z/Ua4FgpFWI+Xu5n8BzuEs1AG4fYL?=
 =?us-ascii?Q?We0X7Rog2Nttove5NkqYT+gjm7gbu2MgHcV8dgSqbxAKXWvOjsmVj5uzAlWn?=
 =?us-ascii?Q?sRGX3/FiAQpKjp9yQis2LjUHzE6zFzg7ZNH3uAvVSntvdQy7GV45xD7GXtn4?=
 =?us-ascii?Q?r821FPXcngQ273GVYbixpEPx64RQAnRyalDUy7cW+VOpUO9ns5Z3MfY1yUSh?=
 =?us-ascii?Q?kd9JH6fzbjo/Z70pw3Y3e+UjRkGfyIdc4D98hsyeyF0cpgZaxbWEg0jgsNr1?=
 =?us-ascii?Q?Tc5lhJZ7EyQf8wqSt3Cn2aLHTjg4V4oT657oNOj/lnij1oRSYxaR01TNrud1?=
 =?us-ascii?Q?aYaPTnjSZA=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d31e0b35-9f3f-4bca-fd8f-08da5416569d
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2022 06:13:34.8679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RZedEuuK8erPre0lWIbxAe3DHcAg8b+0jjBlTOQTHeBE+0qyuRuZpqBzA+nYKdImcLWybBayzQ+zFmV15oDpw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5623
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

BIT3 and BIT0 are reserved bits, should not touch.

Fixes: 846f752866bd ("arm64: dts: imx8mp-phyboard-pollux-rdk: Change debug UART")
Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
index 984a6b9ded8d..e34076954897 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mp-phyboard-pollux-rdk.dts
@@ -156,8 +156,8 @@ MX8MP_IOMUXC_SD2_RESET_B__GPIO2_IO19	0x41
 
 	pinctrl_uart1: uart1grp {
 		fsl,pins = <
-			MX8MP_IOMUXC_UART1_RXD__UART1_DCE_RX	0x49
-			MX8MP_IOMUXC_UART1_TXD__UART1_DCE_TX	0x49
+			MX8MP_IOMUXC_UART1_RXD__UART1_DCE_RX	0x40
+			MX8MP_IOMUXC_UART1_TXD__UART1_DCE_TX	0x40
 		>;
 	};
 
-- 
2.25.1

