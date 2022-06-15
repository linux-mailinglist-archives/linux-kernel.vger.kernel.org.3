Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8680A54C6FC
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354319AbiFOLCl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:02:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346649AbiFOK7w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:59:52 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2079.outbound.protection.outlook.com [40.107.20.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B487A522F5;
        Wed, 15 Jun 2022 03:59:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDrui5z1yTek9UBCMq60Xj9TFr45wmqTH8ZzctPmHf/JNga6yeqIsGPNm/SN6x/cgkxYOvad0/Uw8Mpv8zRyaE71e3d2T5tuhzNtb724hAi2FcwJo3/VMMCn8vup1AYVZwKpzELqS6gCwFr2BV8r//VOshJMTW9e6EUxhtiriCM7S55kMS48C4kkE8XhmwfIYIo1oDypKalUqDkaxLzlCiDi1CXpHN5pMs6BmqmHYOTqDu2yEZzu+nGT6PBT55SLY9DofII9Gm6z1ZeHprwdAv5HTrvdMh12pkAPxhFbsnvAy6tJG5P4aCVfdQaT02Lb4MY6b9zAWqVImkBxQsrrWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HcajCSh71JLMVZTcpLZs3IelNiqQoKqwZoCv+uOqa/c=;
 b=aKTo6nrTjwKzx+HIYwAVH51ShP9ImFE4UfAl8zU+hIeIBbiFBEyS6GYO+2mJ9vXcz50aMkpwxFhJJ3ZYs0wckDuPpKWzOLs4hgDZpHqvIiiGahAv+RjrRJiwM+G5idn0C07V6X16TcCKu9ClW9TmfAxGf/GshNeIFovCTflSobCCDTZ5c0WePOZLjQNGFTbxJHuEC4k52icyUrJ2EingQP8Sg7xAluyfR76hy1jJplyqdL2NJISyFlP6K+tQ8sxfRKEBvBCW08mp1EV98o2xWussqiVsf74+RF/dakDMJoUondYe+mRUFP8sWu+82EcDmpenD3LDlXvN5wu7wLa5Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HcajCSh71JLMVZTcpLZs3IelNiqQoKqwZoCv+uOqa/c=;
 b=idvWOE2j3A994Zyij9Nozt+dMjpn+pVHKYUQkweyL380uqbuDtv9q2RCcSdDJoeiddcvbS6+Rbqmk+Z8/OZu5Hjq+RynuDsDdQsrEGb2m7gdm3AzHrnBaeBkUFSEpC2QRis/Q4Is/jtH7YYHao2OfEzBtQTTYJX9wc2EEjiPmls=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DB3PR0402MB3948.eurprd04.prod.outlook.com (2603:10a6:8:d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Wed, 15 Jun
 2022 10:59:49 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619%5]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 10:59:49 +0000
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
Subject: [PATCH v4 11/14] arm64: dts: freescale: imx8: Fix power controller name
Date:   Wed, 15 Jun 2022 13:58:31 +0300
Message-Id: <20220615105834.743045-12-viorel.suman@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 720d01b2-5749-467d-d210-08da4ebe2a88
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3948:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <DB3PR0402MB3948669970B1D2B62B95CC9092AD9@DB3PR0402MB3948.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BHLjukEPq55toTHn/7OuVaY6jwpDyYeTOoCH5xiFt0d5or8apNmW+Q4Wqa5EgTX1JrwgX+SmQUrYDGXjJPD/fR4BgFHXE3v35qBSxsTqpBCMhl3phWCE3buTTpP1JEteJkXDjXcjpZReCJP21fqud5REgBN8UaUeuB1Y5i93J/d0/+WpC35N0hbYGCU5C/xENXWXgcy1vo4xCuZ39ADNvPmAdXWPx1UxOKbSxFexyCLPzhfH8s8riw8bDpeEC18etx1y3g/wAvisCnE1PSc808JuzhsSfnhGVhT5G6oT5ycj86/qQ4YHM9TD7MqNJEZ4K1iE9hsTZWTxYHDneEIU11R4m2S3VOtF2BFZRioClQtjUZMJLlLduxfiLpgTrPOx0z5ILeqBBQhtpvjd5BH74SCmPus9DoZHeyR5TCCvM+BvtltNtCnF+m4HPPw85cQqL/NJALYaMjjUmBJ+UKAlSjnChQZTqV/7N+j2wMDKIwcUQGUUPygm9vwqtG3YKEPdCO79Hf45dp7GKiHcWqZAarFRW/fYFC+tQLoA+vPr7QO6wrycXouiJhz4XPShABbNHmVS09ZxhzB9igPPkBfBURuPv785sfAC8somIJccHbm69KLwmUfiuaNY28JjknMlTvibAMinPnIlVaZrCyZwcci7HEbbM4P/cE25XgszHGlh4k22+tYi7yl7E5Hjf5BpwBQ/S78oRikzszxHtfaNkJ5Rrj3oDr7knDbUIRUXut4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(26005)(52116002)(6512007)(44832011)(7416002)(2616005)(4326008)(6486002)(6666004)(508600001)(186003)(83380400001)(1076003)(8676002)(6506007)(7406005)(2906002)(38100700002)(38350700002)(66476007)(316002)(66556008)(86362001)(36756003)(66946007)(921005)(8936002)(110136005)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?Det32uIAxpbbiF+2FrUuIPmpx8ceW4eUWemgeC6y9Y1VrUw3WzVJame8bm?=
 =?iso-8859-1?Q?VTbv3She+5bLZF2DjwoolUAluKCPwp5gpp7uNfeAjXMrXNjTj70mWoJk/4?=
 =?iso-8859-1?Q?SJG5uNEOBMasijj+jYK2wTqM8rpEIggCTjsD+mgcn3eRBT7zrl4yGMSUKt?=
 =?iso-8859-1?Q?UgqBXlT3ky3nP8FQnAur0jw0nvfjYh5H5UwxCpcyusW6MTOnNlwLBRzl9l?=
 =?iso-8859-1?Q?qCNyOiXLrtOhhxubR6TRhDlztCJvKBXL3Xa//QZpjvcgWh2Ml07GOeq3hS?=
 =?iso-8859-1?Q?Ei/CVaReRiIV2Q8FV2PxnEFq5L//uyr+5B2obI2c+Tl/PcH9lbqx9e/Phf?=
 =?iso-8859-1?Q?IJgERuuXEDWMZo+HaD7LmZF3vyJmd31Jac6SMEiw81Xa40mFyCan+Ga6Ok?=
 =?iso-8859-1?Q?SRuBGgi7LrVPhwa8jP2DHZPcVOH3CbhRUBH2erocCFG0AAZCzN0oxJ3ibE?=
 =?iso-8859-1?Q?ASFMZ70fASNWG0K/DS4kj7cUd9kBsUVA9BgYPz9CWYHQG9rYNhu2+WZREo?=
 =?iso-8859-1?Q?JBtZgIt86MCjqvLa4gTmon3urZKcafRxeZt/rXws3zIJJjH7Jh5seWQvUY?=
 =?iso-8859-1?Q?P2KDlDmpNUDBhduL4DI//Ds8uuh7dEv+CQTNWYfGwWI4vIe/OrPKEhcrhs?=
 =?iso-8859-1?Q?EuVOboQal83QrbtQU3hXbE0GdQki92/D6M6Mvl1KdbkWTqps90yFznBJdM?=
 =?iso-8859-1?Q?OXrBBe+vq1lDSEULXwODxN3G9QIYt+IUddmsCaH3EtSW+D3kIALtgobMuA?=
 =?iso-8859-1?Q?VQ3jWbT6hieJ41tXr4rfCyLVLLaKtWczzOzMiB2ChFkl+t9trl2k7dGGqs?=
 =?iso-8859-1?Q?Cq0ZrghAIJ8NVebTmwb823KcN/DPF5jvth39ej0ZpyEvCWvRXxkvsOD15A?=
 =?iso-8859-1?Q?xg4lof/YNNahROvqvbqzrjGEz7LQI5ZnJR4YK9RRgBQC3mBESwe8sFDsKW?=
 =?iso-8859-1?Q?echex/Z2Nhqm1FC7EvqFafiUFNBnYYD3sYTpCy/rp90Q0+kIjf5Su2i07C?=
 =?iso-8859-1?Q?aJyxUmEQolWzAWyf/KsBrvYnS+MRmUSio3N+SxrYv3ia/w/Bxd3cFTKyoF?=
 =?iso-8859-1?Q?Bzz2UOweUFAxZPtWiScG29oLr5O/sb8E0wZpJwBXGC7oFswI+Pl3HLbHIR?=
 =?iso-8859-1?Q?G3oICFCEEQwx27XQuVHd2ypKayLBF+oFet7On6+rLd9nw6a5yxCDsIgPtb?=
 =?iso-8859-1?Q?78XOcEUiGiwL5GP9l3GguIO02IW8BERylb2PHbgJRIMyfgfya9SFxW84Oa?=
 =?iso-8859-1?Q?woZd4RR927ZFxZDNxZ4GE1TXjtIHi+FHC2ZdyrHLYSbEL6aEUZbrQUks7d?=
 =?iso-8859-1?Q?EZfbkj3jQuDqh5YlRtXEleU+beEpOatAdg6ssx4GAPSK9aYVPcp5cJAQTU?=
 =?iso-8859-1?Q?9Q6aNcUfvJAMEQKSHTBK3TMlnXvbxTSa9WQN8DQo5HgyOwvIMYhwknl730?=
 =?iso-8859-1?Q?7kHXT0kHgteo0OGexMPgvwWy1MRCwYvxEB8gD44LNgNIc/gDnpp+zs1mT5?=
 =?iso-8859-1?Q?p6gyvyJL34hRfqlRYdBl5Nnq1eQp5spfzUXaCMXu0L1XiT/+WZ3fk+JuQY?=
 =?iso-8859-1?Q?6obgQhDtxdG+Qhg9Wx8f96OurMHvRwRxx4Y1vGyT0PGSUzht3w02b/5BiO?=
 =?iso-8859-1?Q?p+RdEqzsBvtKUTSC9bneXJNl66qQzFTxfs6H2XAQhXyQ+As2ZwmY/BKLoh?=
 =?iso-8859-1?Q?GyX/QUQj5TnlTQDP83ZiovwhYEfXCudroRF2V2nD+q/LiiyzQqXkIbBjF3?=
 =?iso-8859-1?Q?NCKlW8j/xF8FohQB690+moCAHAa14unJD9axJp4nY91MuImjRT2wE01eqo?=
 =?iso-8859-1?Q?rEIsR60KKQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 720d01b2-5749-467d-d210-08da4ebe2a88
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 10:59:49.2271
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4s07YZRSNtW6rSNEAlo6csbluOgUGGWEhi1lbux4f8aefBj5kxbv0O6mGaWmPMM62XMCxgavS2f0Aq5C7nP+zw==
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

The proper name is power-controller, not imx8qx-pd.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qm.dtsi  | 2 +-
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qm.dtsi b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
index 4f767012f1f5..5ad1c9a5933c 100644
--- a/arch/arm64/boot/dts/freescale/imx8qm.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qm.dtsi
@@ -190,7 +190,7 @@ scu {
 			  &lsio_mu1 1 0
 			  &lsio_mu1 3 3>;
 
-		pd: imx8qx-pd {
+		pd: power-controller {
 			compatible = "fsl,imx8qm-scu-pd", "fsl,scu-pd";
 			#power-domain-cells = <1>;
 		};
diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 483996a1f2d5..542bc47509ca 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -210,7 +210,7 @@ scu {
 			  &lsio_mu1 1 0
 			  &lsio_mu1 3 3>;
 
-		pd: imx8qx-pd {
+		pd: power-controller {
 			compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
 			#power-domain-cells = <1>;
 		};
-- 
2.25.1

