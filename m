Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 017E354C714
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352048AbiFOLDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347485AbiFOK77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:59:59 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2049.outbound.protection.outlook.com [40.107.20.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FE2522CC;
        Wed, 15 Jun 2022 03:59:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iJuXVtQRW2KfoxTs0/0IfqIeNGcJK5eGLjXDbPt0Kog1hSAkyaYuf8CeXL429+mJZQiCeJwnfyMPscmgBjKTpu18aCNqB+6jkRv56ijjA7MpBTuHS6V91iHHJgoPTn7D0AORSAEX+ZLopJqap47dz3xHSiDiYChwgjV/tONt/8tScUdTjwcfWoqnCvTACtmt1fFcbdeon2S1G5KrAuuPmE2mbMKiezn35oEzPVSh4NyqYNMpOIbSu4ArX8GoypZA6UooOIqIdunm+rqKuAj85ooYohKP214qWgYfQVmCeSMM+M5LVJfIwfXXe22UxaXt+YxG1q0bufJ96qip8SEB1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mLfSzyatd1BHAeyoN50I+nOxuz5mkUzx+dVmn4Kl1Vg=;
 b=eP7Ul664lJhL8uoMZ9XDP9CmNp1DjIMU/PFScm3m7b/uYxAY/ntKoGd8YX1L5aY0k5zTI5yLgv/18XZakeKBba36h0N2RP3gNFUK4gm8bUJqQMvFSXad+TYiQlGvgiQJ0dxdZoQi8diNYp26GWRbINTwBmBZ1VJMcLH2P95v8mdXftHYvkVqoh5oc5bdYBIpq9M3WDa7GGfba9Dlwoxc+brpFaBVAN7WF5heyIbYRBeGRnV6VSWW+WcETd3VkLH7hEQdxwYGgaNEVrUU39agydIlOmzypNVS4YnHbf8Awtuny4kDebDaCH6vwr88WTt2iWhkUOM7g+TXNmmUTDkZ3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mLfSzyatd1BHAeyoN50I+nOxuz5mkUzx+dVmn4Kl1Vg=;
 b=RS99Cv5oZZLgWnEMUd2wTS7QGp34Agr6g2D4z8I8DRRKhwy3FD+8lCHd6mH2OfnEL3w9tqcRxTUI6m87x2eu8R3/6JZLskziXPT3G1U1ytUYow10S/jJsuRxKmjgi2JPip8qXKAPORs/t6rpRkuNjqbRJ8z5kLWgjKYmqpPHYSE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DB3PR0402MB3948.eurprd04.prod.outlook.com (2603:10a6:8:d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Wed, 15 Jun
 2022 10:59:55 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619%5]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 10:59:55 +0000
From:   Viorel Suman <viorel.suman@nxp.com>
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
        Abel Vesa <abel.vesa@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Liu Ying <victor.liu@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Peng Fan <peng.fan@nxp.com>, Shijie Qin <shijie.qin@nxp.com>,
        Ming Qian <ming.qian@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     LnxNXP@nxp.com
Subject: [PATCH v4 13/14] arm64: dts: freescale: imx8qxp: Fix the keys node name
Date:   Wed, 15 Jun 2022 13:58:33 +0300
Message-Id: <20220615105834.743045-14-viorel.suman@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615105834.743045-1-viorel.suman@nxp.com>
References: <20220615105834.743045-1-viorel.suman@nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR02CA0159.eurprd02.prod.outlook.com
 (2603:10a6:20b:28d::26) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: df13b330-e5dc-4993-6d26-08da4ebe2e42
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3948:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <DB3PR0402MB39485124B6D01F344E8BA41D92AD9@DB3PR0402MB3948.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MtDI38hrUwy3g2v0agqu6I9cfkZ3TcRxqxtNoX7V5ecWyzep8eom181qChjPyL4+XvYgpVC0URYV8xbkFVoKB413OAGZ5wCirI3YBS9Ulg867sYqR6i+LJhoLQNv8SgWfJ7vC1tvpFUtziMYp2nE22JbJ7wAz7pYHGFCxDOUDiy1tFk0KLUXBm3xmwvJZgYW9ujj507N+g+4kcNUK911RbzpvEVXPUrTkF8eFZYe64pg1/xAlUnX/XPi6ReQT4FoSM/+rzDFDWbiIuEW6mywGo4l7I1+pMxoVJBoCKojspHIoQn7hWMlDFZAApO5xEludaOxYDSKxOeNZGJ6e3ilqM004l4Wrgxx0OVi5L8SezzaftyLqpXrfdEdHlJAJQ0Mf+vopB3Y/WYHV5NbCXdxNP3TFtzDNRsDZ0nrH6osQ/+bvd3aQ4qRc4kSpvRDENqId50b1IbHTWrLsnhgZMJRmAle0TvsgWL9d5D9piJyfpSvzRyhRwopzJMKTBfzKJ/76ZgwevK7yxmEz/f19Fl3I2fAHxscJebMGhYOHZVF+ZVoyRIMs9Z+sdOfSfignDOTZuoGOawSLveLTGBfoNl+QDDd7wwAaJUUnmOG9JUebP101+oKq7huQGh3bYHrZLUNK/T8M1QnfpteSgsrCNDHZHYY2gkcO0iTxikW6tezQH+kmsWgFuk0cXDhk+SMVTw0OvGsBTk9bPhBaWT9nq80ss8O2wwEmbScaEqK94q+ikyduJsAsSH4yG4CtBswaBAC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(26005)(52116002)(6512007)(44832011)(7416002)(2616005)(4326008)(6486002)(6666004)(508600001)(186003)(83380400001)(4744005)(1076003)(8676002)(6506007)(7406005)(2906002)(38100700002)(38350700002)(66476007)(316002)(66556008)(86362001)(36756003)(66946007)(921005)(8936002)(110136005)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?CeTkiifWPTHBxk3bpwiqF0zVhjF8QTV0TknUFlL6ZZh6z+T20KKwFmT4Qn?=
 =?iso-8859-1?Q?+U7gI94NrbGyEPZ4dVInH6ac6sPX6LYyjRf2OF1DA086qfca2IHT2ocm9u?=
 =?iso-8859-1?Q?s4PGhyh5TA+FJqugFzSK65b9xh7VvpQjsvU8i1vTbrzLzf2yVUuZJ+vPuT?=
 =?iso-8859-1?Q?jNY18Ew8r0SdilO7bgOxoZAzI6etF05/qWXQgwiMqWhO8ym7YoX9N+r5Gw?=
 =?iso-8859-1?Q?U2DnOBeDOJlMXnpKZ0VS8MurLVj6PZXZv0ZMw9TNcWKRF8zRFS3ckQUaat?=
 =?iso-8859-1?Q?82Qqr+VAqSfaYVzLESvwOeM9JayriV+cL/iIa80iz38tcvg/ZYJfNBUvFC?=
 =?iso-8859-1?Q?WQdo0Pfw1C1xKEVfWf063XaVazu9L9TWq2z2CAY+WSQCG0z5M9pfeT9RW2?=
 =?iso-8859-1?Q?zRLYW2Kl1UuqGJcupGYAScxjs0uewCkecfXkI3OuBhjJ3TF3yJM/f5Ukdc?=
 =?iso-8859-1?Q?26Uh+cgHtAFFBqbHc/0YtO5Rkm+XcuRHqpX02xEbr9Y11rfe9B2bLVtR80?=
 =?iso-8859-1?Q?BLdr6BXNjWUdO/59P8sAvdphS5MVQiSGHVo1jMYLDW3/rwTyAI5v+eskhN?=
 =?iso-8859-1?Q?43ox+hX5FZo1mutCeZeiZzwYn1JlB7B6OME1yE43h+/Q/xSY/pVv/wOk0T?=
 =?iso-8859-1?Q?6Nvfx+7r0FmTz+iL5ZQyNAxlmVa4ugo4D3duOX9KDp68vWEhlLDrBLbM3o?=
 =?iso-8859-1?Q?AamrvVyNnoqR9JMWNIfk4rdfrCSqYyubDE+fi484JYrAryK3MR+ZzdPICQ?=
 =?iso-8859-1?Q?UOuUoHAZBynt57hkT9XI/chblh1OHqrFLO2QPrPpMyL55TMdb2n8XVRstE?=
 =?iso-8859-1?Q?RprKCYK5AWL7TA89k+ffxj/5M4f3DIT4dnZtMaTk3vwMZmg0CjLC1rJQ5m?=
 =?iso-8859-1?Q?mjQTKIBmPQOIPEI1b417dsZqWnuo5bnKhyb+xX4GtEnL5PElx2wMV4eoKj?=
 =?iso-8859-1?Q?b4yGQj4Nr8JMPPhKPkPduTAxmDDCY/AMgU9T1i03oUZR2exxc+kNy9r0R4?=
 =?iso-8859-1?Q?gdUTjKdQD+tobRpDMg1b9ozoAuFMJ5ES+qffiJ4/OoGFpHhnL9JhPSUm0i?=
 =?iso-8859-1?Q?uw82IL9++ak2MD+LTokehiCVjRx0NUGg/5570VZiuewzQoNFpSi2zAQbCS?=
 =?iso-8859-1?Q?I8mmTRUaHGiUfHYt8L1/sRHmgs7fOuYxQMTDx2nb6+v2mECcjzMS11/9GR?=
 =?iso-8859-1?Q?UkI8RAvpZCJxRNoHeMwqgIUNpQH1M8Jq9p1XI7MFGDw615nJJpfyxjA9mS?=
 =?iso-8859-1?Q?9+/UX/+z/CNI52g+0lrFFOfwVSGTxr39EBi77mPgDEEVLuxKAO8eYoK9i8?=
 =?iso-8859-1?Q?SZ/bB4vGKeBw2kjjo7G7lDRPYJRM0uo6rZrmn4jzTmvZzmGA/E+dzFqEjC?=
 =?iso-8859-1?Q?8rus0Im4vj7VoNnvMZ1OdzlC7NAROg/dwy7+OUWwQ/hU3xsZ4l516t7FwV?=
 =?iso-8859-1?Q?u1fZDHNaSWEAhp8fY0C/bBAfwjJjLxXSIP01sbFfIZzji91Arv9L8aoaTh?=
 =?iso-8859-1?Q?NwpTtzV3PUh8hyqk/TH1wdXns8roe3bC6pzMqTvppOGsDRfW6AHuAKyxZC?=
 =?iso-8859-1?Q?LwnrmlnMViIShJZ2nqP1L9f4YzqlXzlhiTRn6c1cKn/2ECzirnCCe4h3zl?=
 =?iso-8859-1?Q?DEtWzrn2b+tMJyX3elioSrNiXcsoGzywo+hcFyjmtEE/RQgv+GzAleSq0X?=
 =?iso-8859-1?Q?ZRnDxEIQx2TCdpuvHU5eIZ+F+gdGQ2/2o7YURQ9hunjLBW9rjynEfN2PJ+?=
 =?iso-8859-1?Q?EgIN/w5t+ncAW1Kvyd5BKG10XA/gk9XpV914+9FLAYE3zbyhMl0SrvUjaw?=
 =?iso-8859-1?Q?vPsOT0b5/g=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df13b330-e5dc-4993-6d26-08da4ebe2e42
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 10:59:55.6485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: woURh0BKX8EeGhXonYEpn83N5cQqCzXTUzg6Y3vA0vAXYoZRFW4wi0fRtC1WGSLwntEzJIEpN9IVUuWdQ1416g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0402MB3948
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abel Vesa <abel.vesa@nxp.com>

The proper name is 'keys', not 'scu-keys'.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index f9c3090c632e..1ef736815969 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -232,7 +232,7 @@ ocotp: imx8qx-ocotp {
 			#size-cells = <1>;
 		};
 
-		scu_key: scu-key {
+		scu_key: keys {
 			compatible = "fsl,imx8qxp-sc-key", "fsl,imx-sc-key";
 			linux,keycodes = <KEY_POWER>;
 			status = "disabled";
-- 
2.25.1

