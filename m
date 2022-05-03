Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184EF518453
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 14:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbiECMcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 08:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235320AbiECMcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 08:32:09 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80043.outbound.protection.outlook.com [40.107.8.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FFC837BE8;
        Tue,  3 May 2022 05:28:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nMvULydn2w7hUak41hPaYec/U6RPiUFiO/ePGMzR5P33fvowkk28KWrA5VdYBYL+TdHAs84K19eG7jw0sBpy43vRz+hGsPFgCmap8XoxUxZal3lE+5+CgoXiyqB5LMXMDoSUNqc5mZduF4Od89PJSwnmoCoVRfDxocWr8+YC+0rwnFGjJLmHQh3GLXlVbrY+orMwx0gOxE9xYPtuZAbvpL/x8oXCMlDKir/AlxLkSSEmkDOyWGai9iPim+msnGTsq2dPEbo1cQWt8bUkAMEuU2v5wrp/PQBvXr8CLHYTKpDFCvUOj1OjqJ9grv6dZMFcUiJV2Dh+2obxa6mSuAJHuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HD8Nqa2gdfJ31E/Lkv7DCfapQWbLsGCGqdLcpcuwXx4=;
 b=DsS47XSu3GxfXfnwtlOsapqWrv2tiAIes70vaI2f5LNfFiyVjJBQwBb4Xwc/rNdPoeYzuUvsCsTWwignZw5eL/j+6PNNk8EoImfB0tZJyySkGS7SF8NYaMp3lfNOfx4Ugj35p3NmY9na8jEP37nfIW1AG7ds6IOjz9V90t+qqd/yUGDnt5LwbMyiwyKOb4+dZi3Cf0IOnKqCL+l4xKy1W+7r+erTaCyRylDDL2F2bPoFlcMlymPwA+NSI+D/1Bv/HyZuVM9yN5oCuVD+IGe1CGb7vzfwjfi4kDfZx0AQvqbF8S5xf1kPidQab1OeAEbS7E9MkYegnOSpWALWEM0YLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HD8Nqa2gdfJ31E/Lkv7DCfapQWbLsGCGqdLcpcuwXx4=;
 b=RdQVdsqUYKCT3GJjs6Gu9W9srutTEPqxzRdcBPRckrAbiNMG+l8gsRI0HcdhZ7OBZGLCQ8ziIYnsShwtH+L0crN0pEjknuVvnXWdiaxyl3n6XmlRw8hkGmujNFKnhHWNzptC2GnZMNxX2NngLM2VhKijJBF5RT3VrosEUUGR6WI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by VI1PR0401MB2528.eurprd04.prod.outlook.com (2603:10a6:800:56::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.24; Tue, 3 May
 2022 12:28:34 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::fc66:662f:2a82:1420%5]) with mapi id 15.20.5206.014; Tue, 3 May 2022
 12:28:34 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2 3/3] arm64: defconfig: enable i.MX93 clk & pinctrl
Date:   Tue,  3 May 2022 20:29:51 +0800
Message-Id: <20220503122951.4147636-4-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220503122951.4147636-1-peng.fan@oss.nxp.com>
References: <20220503122951.4147636-1-peng.fan@oss.nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0209.apcprd06.prod.outlook.com
 (2603:1096:4:68::17) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a6ac736b-fa73-4a5c-18e0-08da2d007084
X-MS-TrafficTypeDiagnostic: VI1PR0401MB2528:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <VI1PR0401MB2528181D3763E962BA420537C9C09@VI1PR0401MB2528.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EoH4ocZ7qA8H5TsV4ayRkYEQhusfuZOXiQR7VuBVvsMvoo5lkmj0odb4uXTTlZnHHa+zsy+MgN+GaO3LMoTaCP9TrXaSbFaAU0z5KbBHonD42hf0mpwgYoB/K8EIubnWSBZ2vxCMZTJ0ayLYUCe+SCEAqTUxGg5QE4j/ZZAzmP1OOilUuto0CFT5KiwSJ1mdO1GeRNwTJ3u9jevZnqWgU5HwtFEt7zKdeaSO8FHDKeJfdHxQ/gAUl0E71u8mmDzH0XSF0jnjrM9M56pikADsoGxrK2oMFvno1EyMsT9Npnwjj6aqNLMo+X1KgCgVu9MR5J9KE25W8/xc6ccjRyLfOoPs+l6VRgpGaHRT2wStGo9gHB9dlbWXV/FcFHWRCme1XXb8Xdgu4yFzxRAgcbbYNgTy/oGt1q43ITL2+3rVOjNybkQtyG0aF9qR9Vrqra1w0BXa7u1+tZaVPC5U+Q2Y6OwdVUujOHFv+wZv+VUN/vF7d42ijw3e/0vpQTaRmY0s9Z9ntpQfNeGgRIs4jpniRZp8T3u6zf6+OIT+jR5/qIKZQ0qrdnq/lz0HyJn+tqKxM4/6xVbhayvG3yIbZ4ceAEtP3diSAY5hc5ZgXdqQcNpRMfUNmZPqDOMCUQVI3mliFcA9944MX7EQHfrzZ/Lg2OAM12WYJTnreT+lrNcBvwOok+BerqiF1sRvnzBNcVNsTFlD6jD0AsKFhXou1t//qg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6506007)(6666004)(38100700002)(38350700002)(8936002)(52116002)(6512007)(26005)(6486002)(508600001)(316002)(2616005)(8676002)(4326008)(66476007)(66556008)(186003)(1076003)(86362001)(66946007)(2906002)(4744005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?h2Hfvk8e8FA+QVII08ZRSzKCsd2OKR8s3B6WY+Sb6gXJfi1qDX43RC61qGAV?=
 =?us-ascii?Q?6AoTcCpKHoOF5fknBc/uyCbsBwIh9hO76laTx3hzu2n4rcbno9/vL5IEDSxB?=
 =?us-ascii?Q?lSRed8KB6M8uL7ctb+OstieE+4u6QeMqGZJsLr9kYXi0zdIairmtUx4j5izp?=
 =?us-ascii?Q?C8/MRbOavPQTlJ1cyeW1gzhHQfPV+t64ZbR6UmHEnWmFxavOaXvCRVPCNT07?=
 =?us-ascii?Q?yJTNBcfEEjHwX5kGEzgqrVoaNiYPYPEvFtCXpil7+ZdqxyPfnsgbBw2xk7Ck?=
 =?us-ascii?Q?PNCrGYc8Og59OYyGcdaFjngq2E1vDsA1TAT2tSCn3Y60S31mn/2tHCqk5fHT?=
 =?us-ascii?Q?a+5GAexozJ6mM9ant6ouHIUtSv9JI5aL6mPUJGYE7A6+MWXuismCzoOcdIdV?=
 =?us-ascii?Q?KgTv5gLTDzR1oOGgC0P2efqgXIioasz+J5ARQ5G5Zj26nLBBjik9NZPGw/J7?=
 =?us-ascii?Q?TNHBZd93ftzNxP2taXiT5n5BCgE/yl1T9y4ts+EyWlHRlZ76oFMm3/YwZoWl?=
 =?us-ascii?Q?FlpCWAl1WV76zpPht5Ywe00Hk342PtLP9IZKFk7a/b/0JVVILwKOh9kvu7Uv?=
 =?us-ascii?Q?2U19gPhZOdN8XgKWnxufU+yZbmsL5yyD4eVNhctxmWiModZ+9DMtcB/vFVdZ?=
 =?us-ascii?Q?jBjb8Om/c6A/QA/CNK8RLkZKV3oYgpiYyRub9tbiIlRapi2JXF/nhwJ8g3Bz?=
 =?us-ascii?Q?3qFYUCnArJL9KPOZOnyf0RHAX+J6nb9BrhXoawFJjvjXDsKL1+wUF0gDMfY1?=
 =?us-ascii?Q?B1cmMvaAxaIaX9PPYyCRcFy98Q3sjSRXJzUEdYaDQT5O9FQ0ixl/Kvc2GBWr?=
 =?us-ascii?Q?5KQWeDZo/SFk+Pma9cxCUU7jKDpFEJqGjVPssmxH6FnkQuddhWsYqLy9CQP1?=
 =?us-ascii?Q?h4O+hYpiHvIrefvEpNoBWisCp5oHwpDkVP0JSl2HeJXETmRud4cTo37xkItr?=
 =?us-ascii?Q?QK/FVb8E6XdA2kiV/A8IZnlZI/rq1d9UdoDFqziuFw+an/dHb1brxJZ42t9e?=
 =?us-ascii?Q?4b3qfvFPvT4SmXDTBj/tNlCaOsBQMHZtJ+Jj0SyXznxv7+OUc/pagaJhgeF2?=
 =?us-ascii?Q?m2mUTpF3q9pRe1HPD49TFTCXr3I+SlYU96QUONS9+KdCD3A2CmoDqtElILtF?=
 =?us-ascii?Q?7EOPei4s0fLozKnG0aCjM31YUqsNubHP5OQTwQJuPf6KJDVhhywFFw36DgAn?=
 =?us-ascii?Q?GWmMX49Gq1QJV1rn2wUSZ5miXbxogzMU6If4OtUdwJ/U/0jN2VVsAVGdK8+A?=
 =?us-ascii?Q?HWkdfdlaa8YwPu3s60idm4UYj/pfOjw0SnqKrmj6Ukkdyxe83eQY74MHgk5I?=
 =?us-ascii?Q?d4ByBI453ciyA+pyG68MPiY4rqarcrwwTipvTfh1clmsjm26pXafaubxPyKi?=
 =?us-ascii?Q?DwbIPJMh2noH+UWX4ghCU6HSiT90GtLXEp552TuttRJANx6TEBxCBbS68HvE?=
 =?us-ascii?Q?4Kpk+kKf+qqwMT1ukLNCN+Iw+GliMJ23R6uJUPCctUIXY5vEu9y/nd7IdPKD?=
 =?us-ascii?Q?3rP0j6KIXCa7yfYZmgli9adKA2cmNZpHHSRZLYDhh0oCONsFtvG7V5Hjn+R3?=
 =?us-ascii?Q?VsElXmcGAv9Em/LPHhI4EREdap+o7TM9ENIKctR6yILCBUSHXmPQxD/IUjhU?=
 =?us-ascii?Q?MrHBD83Y7es6R6PuD9NwgBGYqyjJNr9+2uiFFz3Bli5pqSCRcPlizxelFtQ7?=
 =?us-ascii?Q?03hJWtWoLx9Cay1P4fhzzIktEM+ObVXIrEP30/E+JC0dTuqyroCT2jve6yOC?=
 =?us-ascii?Q?wAGJxCeGvg=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6ac736b-fa73-4a5c-18e0-08da2d007084
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 May 2022 12:28:34.0425
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6kDk9gWR01WBXWvxDX8R9+ugV6OaqcvsaPJ3nW6HDmoAab5Kl6ZA/v0qN7UVrkNJHWxXwSn6m7SFHXSgXfgV4A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0401MB2528
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Enable i.MX93 clk and pinctrl driver for booting the system

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index c79bb743926d..849e997a365e 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -526,6 +526,7 @@ CONFIG_PINCTRL_IMX8QM=y
 CONFIG_PINCTRL_IMX8QXP=y
 CONFIG_PINCTRL_IMX8DXL=y
 CONFIG_PINCTRL_IMX8ULP=y
+CONFIG_PINCTRL_IMX93=y
 CONFIG_PINCTRL_MSM=y
 CONFIG_PINCTRL_IPQ8074=y
 CONFIG_PINCTRL_IPQ6018=y
@@ -1025,6 +1026,7 @@ CONFIG_CLK_IMX8MP=y
 CONFIG_CLK_IMX8MQ=y
 CONFIG_CLK_IMX8QXP=y
 CONFIG_CLK_IMX8ULP=y
+CONFIG_CLK_IMX93=y
 CONFIG_TI_SCI_CLK=y
 CONFIG_COMMON_CLK_QCOM=y
 CONFIG_QCOM_A53PLL=y
-- 
2.25.1

