Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDCB565B6B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235203AbiGDQSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbiGDQSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:18:09 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-eopbgr60047.outbound.protection.outlook.com [40.107.6.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D1412A85;
        Mon,  4 Jul 2022 09:17:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QdCIemXZd9npjRSfqjNb/P+j5cM2JO05EmUhX37avt37dILXJUQGx1iyjT4/gd4c6y98hY9MUDMxdMuRJEOJT7eZs3aA5u+QGGRfy/mWG/fyg1ba3n3OOqe9oDSXhKgXf+xmz3AejSBxwo5pJ1N+VoEHKyyMQCNzRJR8PBHKadxZf+dIbkUQzM2IXhYcgBkz25gKK+Uyc/amp3Bs3Rjt0kg2dt52gJlsy8oB7eq87uyirvD+LWkKInBrSJCwo6Okrb8vdBJqxF61tjFd0SD9VU9O/CZ4JjAJvzzDtkPgOBvwj4gnS0d+MPa+Yq3vjhSJl6TH4Idiks55H0SwT8fEDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wF0myKg5biA3f129IvIlKhluAN1OE2hhYKWZe/ORp6I=;
 b=R7mDCGfEePDl6cIg18yKKD57GB/yChI5DpaIzXaRHo9P2JawmHrEfvW2qfscigbyl+ZxGKkj1IC/sNrgQ3STy+tp6La9d5ZzQC8JxMO96mT/j5ioSwBxavKqdsN6KHakIB29Yan2aR6svp2w5yErPjuQw7bE9rLCiVxYwsuoNZwM6Ewkzn39r8+hqyXjlI2/nASjg4E9fUX5i0axnX7KqIALyA5RQFIjxrCXQSdhXYyFDXqPcnAsqHT+9eG/tq5bsrIL+ix6UEJS+9HtanRENEhQ+ruhySxPCMqbdKeQFQSrSaw0olz9ocr4SvBxfZcdVhlWhkN5s1FJR9D9IBueNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wF0myKg5biA3f129IvIlKhluAN1OE2hhYKWZe/ORp6I=;
 b=Il0OBexTekRshwt6Db5GBFHZA7VmR9bFV19mBdutuvGxX5S5frvz7Bn0rVa8pd6HW+abSAGzVaiHL7AgN2G8zeWWyAODNqaNKVyN0JYD+Sp2QuqkP1p7rRDUAWtByt9wvW5sgJmmjqSr5/asEi7ziTV6n9jOoiEwtVnbQ4Pf2Po=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AS8PR04MB8213.eurprd04.prod.outlook.com (2603:10a6:20b:3f3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.20; Mon, 4 Jul
 2022 16:16:56 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5395.020; Mon, 4 Jul 2022
 16:16:56 +0000
From:   "Viorel Suman (OSS)" <viorel.suman@oss.nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Liu Ying <victor.liu@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Ming Qian <ming.qian@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Viorel Suman <viorel.suman@oss.nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v7 12/15] arm64: dts: freescale: imx8qxp: Add fallback compatible for clock controller
Date:   Mon,  4 Jul 2022 19:15:38 +0300
Message-Id: <20220704161541.943696-13-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220704161541.943696-1-viorel.suman@oss.nxp.com>
References: <20220704161541.943696-1-viorel.suman@oss.nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR07CA0008.eurprd07.prod.outlook.com
 (2603:10a6:208:ac::21) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5142f93-5ccb-43ec-b21e-08da5dd89d0c
X-MS-TrafficTypeDiagnostic: AS8PR04MB8213:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PyIIPrM7ewPLdNx+dYG/ZowjlL8uzErr6bowufYdWfZGg8rOrJK2J5p13009CAgDBz4NCg6grUikiQcC6oAMgzBMU2/1ihdt75It55dympAPZXIPI/V/ghaBkDMQvuAVid2MK3NF4aROYyPUkPpCnfFICVz/3kIZp9yH3gZ90BHlN1Ja8pSxeUEsQHvK1XbrDPNVYadJNxWhUyXmndJlod3wc1AMHNh12c6QLmREW41ZK+LXnqkN0NS51L/cgDwSIqAgapSxZYEEMABhm+A3oH1wkU8ak74dGb/bfnVM/DJrbKB3aqWw1n7UOVWylGNXm9bzuMFOj1XRK+CliF+6xjqvG+mr+ahRg73dc10YU8IlWTYZcCazod+GKoWV9dQquXNC4KCoT696IlhVjPN2QSsO2sSvLFxayDuk1jbA898qwL8da/dpNUr6Wd1hJfMcWzj7z2Tpa6IrKPATV95+Ki85QaUgSaIfy/28AKy791fpHFL1PxGdjmjefYQG/44JDDsP2XOSl9A7lpqRwLQFVqhDWY91LDvkmPnw0iLaQnE8F65Lbq446KyXfKE+6Up90C7+oYwIZvP5F44GewV+KMxP0BdmhRYR8uVt4zrAgm5nfjC7yJehbzWcxM9/z9Fx3Vfdubm+hVg9kF32ilpTW16KOWafCQdJ3Ua6LJ/AoMb3wiMmJAfouYzk2w2bNMsl3xJH/3YVHdk9Slk/9JlL1zPO39W5Cns3vA8nXsk3UJMzx2MoPrUHGW3YwmS93z8kQTXkwp+aLxW2L9ToLFDfFxjZ+wzwoyh8vGydtMbbtPWQVjN9uZyVjIeS+vM6PRiK8hhmeetup6XHRqrm0YiW4c3zEjIbIOXeZgthXI+Z790=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(136003)(39860400002)(346002)(376002)(186003)(26005)(52116002)(2906002)(6506007)(6666004)(6512007)(1076003)(2616005)(41300700001)(86362001)(38350700002)(83380400001)(38100700002)(921005)(5660300002)(4326008)(316002)(8676002)(110136005)(4744005)(66556008)(7416002)(7406005)(66946007)(54906003)(8936002)(66476007)(6486002)(478600001)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?28DmLxN5gStsFhqEgHvmtaD2AYI0qXODcJ/x6H7HHeAToHU2OMZq1op7Lo?=
 =?iso-8859-1?Q?+nIGDBNqwY5zQUL887ML+ziaJlYNHniswWjaT3D2WXu9ajTtTPQN9L0W/n?=
 =?iso-8859-1?Q?x1EmLxP7wNdR2s/gcT87XQGBfbk98tLGrv613cSLBJrygOPZE+Uc7+1Qev?=
 =?iso-8859-1?Q?oI1kK9gr3ZcsrPOiKVz13Osnvem3I0dfLN+VfnAogR1zLMYd8/kId/RT8r?=
 =?iso-8859-1?Q?6i/A/QP6xWqyBn7ZMQbO+bGzkyIjnkfEHs60TzSESujT+erLUnapP0OoHO?=
 =?iso-8859-1?Q?kG5gQVtnqrviECbKedHAbqKUy17tQ5GYYUzofhbARl4U+xI5gVZlukZM96?=
 =?iso-8859-1?Q?nBiTS+EdOdm2VT7vMUfvs5oWExnvuJ1sDIrbgTI8W/rv0amJpa3UZEBIY9?=
 =?iso-8859-1?Q?u2nrrX1Cmjji+jbgqD+H8PPKR393dzImMtKMnzaFUgGYImAIu7lrg1UxkY?=
 =?iso-8859-1?Q?H0Lid3F4rCxTMEX0TpF4x9vZ3T1Z3i4KOFJKZI0i9XloHwufy+T3d21U4+?=
 =?iso-8859-1?Q?8TqTqJB5u2W+HYM5QqNzo/kOPnhC3fpjjfdq18d3RrAZvb1fA/I2DBjeG+?=
 =?iso-8859-1?Q?59tVZHK1AB3MqEkUnWwwbfI1d8msXz9pQ4CN9pErlt5Vz+7lmR90J+g4XH?=
 =?iso-8859-1?Q?ywD1wTSXJZVHUQ2a67bu8XqWrxVfgcSHZ0+W1jhgqXU3aNSyqy3TmFaz7t?=
 =?iso-8859-1?Q?cVjh7JW4446TguPRbwyWg1Ww+McHXAsY3ZEO97ja7JCK6wI24UQJPpQsE9?=
 =?iso-8859-1?Q?LoKspAd3lYc2BOyhBS/pkGuX4hISi+E62S/71t3ZuPVRXDXcb0qWvqVGf1?=
 =?iso-8859-1?Q?+htGyrhP8IRcua45KUegkmfVWhKZdJdXjmeWZzS9ELw5rZTWGXjvgvrMh3?=
 =?iso-8859-1?Q?jaEaresOmehpiT2FqFU+4dqpgvSCYVSnkCF3WGbqHF9hQTcnCIUXI7PwFt?=
 =?iso-8859-1?Q?jYoWCLaQPYldKL24LAs0zYN9ifKI4Ie7N6dkZAxOJsbUlJz1VhPm7jZCnM?=
 =?iso-8859-1?Q?idvVaEccybQqS5tn2FguZtkaXMtHaBpwtffr6V+HdF+8lIMFGkcAFk7uvL?=
 =?iso-8859-1?Q?9nUppBesmkmdEbifV+TociGppCs5Y0p/9XtkwkHsBiXBuK8+eaY6/f2m18?=
 =?iso-8859-1?Q?WVXZ1X3PZ6v1NFIPjdaX+EDoTsPmDF8WsEBStJkz7QPgUquWJHXByA6yXZ?=
 =?iso-8859-1?Q?U6CcKdUMUQ0RA5RLQeH5RM9ApXwsuvBPiQ5h0c/J21rXb0grt2PS9XTt3L?=
 =?iso-8859-1?Q?AgnjxKxD2nAwWptk1iA2Gu62TiRGrTH0tmFVOeQ5J3GlX6zWqWmZYil4I8?=
 =?iso-8859-1?Q?WfD4Gc2jc0LAlceutEA/7P4Nz7AQqLhwRizQb9qo75UNoSed8xWkgW1Qc3?=
 =?iso-8859-1?Q?IPwVrwEQaVFnDrcgD01iVCx7N9ysi7ig0t1L5PAgO0zKQUhhOpR0QfPblX?=
 =?iso-8859-1?Q?38Ff8wb1VBy+VdWP65i2Ndushr4cW/OP4k7guyHhyhZkEUT7zhIc9bDlAu?=
 =?iso-8859-1?Q?Gu7g1ISZq0/5gFyRm8LMhaRaXweVAQEy0G6hztiifR5+de9FODygoeZBWx?=
 =?iso-8859-1?Q?ciTikU0GHbo+qsbjGGNxk7D90383Vq6OZKAwFdOdb59lV2a9QNL8kSVvDL?=
 =?iso-8859-1?Q?1l/bvIQGlF4cuEdKFUg4kAhp2JafJHyi7T?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5142f93-5ccb-43ec-b21e-08da5dd89d0c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2022 16:16:55.8957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +sDM5HB8knnqpYpeaPadgGLxXVfpI6D2lH825qo5eUOcjaSB+k19FHWOksj4xP7FLwjF7KaPk1WNm8jkSDUtnw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8213
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Vesa <abel.vesa@nxp.com>

Both i.MX8QM and i.MX8DXL use the fallback fsl,scu-clk compatible.
They rely on the same driver generic part as the i.MX8QXP, so
lets add it to i.MX8QXP too, for consitency.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 4f8cd7339112..d0f56e4dee77 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -216,7 +216,7 @@ pd: power-controller {
 		};
 
 		clk: clock-controller {
-			compatible = "fsl,imx8qxp-clk";
+			compatible = "fsl,imx8qxp-clk", "fsl,scu-clk";
 			#clock-cells = <2>;
 		};
 
-- 
2.25.1

