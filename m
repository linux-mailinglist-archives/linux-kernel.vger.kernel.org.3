Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038CD54E7E8
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:45:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378246AbiFPQpS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377354AbiFPQov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:44:51 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30049.outbound.protection.outlook.com [40.107.3.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00142A720;
        Thu, 16 Jun 2022 09:44:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VNUsBedIEfQvyY7RrQF43FTL9eKWOw6wf5o+/tf2FPkwZ4QGN6azSK7muieySK6vZFuzeQvtUM6UvmB0hrtryZghdHTtTGc6KmXwQoiqHbjq+KXzsuokOaixIYGmn1DQoG96NCZbDjdjGTULHSt/QhNkjgEGu2CW4T5A9uDexcJjHePThOO1lzWWvMWSbYli/7TylYcHd6tEQqGccyL96KjfvXq0shEwbpk/zUKysx9j70qvynPDz9/jv7w22UCyCG4i6T1CalK67MStY8B5J0Z++mtcxArpHeL987wMp9GfGl+raexS/dXxw+F/R3HChtfiJFFzV/t488LPdFKGsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1niilcU5pZ61WEQitlz402CWBVA4Rpo7+fJe0O8HB1U=;
 b=RvNQG/OtOwUkOhs7CcekUPu/iSrwOeIRsjv5CjJcCjHZz6Nqru8NG0DYjG1iPR+kj3o3pVzr+xho7hE5sPdJIKvR47q5JF2weboHMWHjnCt+XchDeF66D/Z//pp5Mpxyvj/Vtq1OdTZyb5zRJXbvmL4iJyNspBcNm6NTMcvPu69KGflaJ5u8boR7oJaPuCKRP77/D9Gi5nFGJVuOkxQL8JFCfUmvlrqhBs3QC8DHGYwLrcQpabG9oVLRtOnYpNy1zQ+1X0JD8GBvlxb0B2xNloRTv//n6hXBQo25ncnap5XThRP9jG4B/V46b8R7r09rgiL3lLjpzDDLfrpr+KRq2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1niilcU5pZ61WEQitlz402CWBVA4Rpo7+fJe0O8HB1U=;
 b=XnUxz3LkIAhHsTXdUqzj5f55gCdfmoC+hPPvZ/qzW+pzfZxFrhwEB43saI25dOzp72Zk+VsmmGVtyfEoq70ESyiPYIt2x0IpV6vJqO6ubpt/PVE48qPHSmlgzfWrJFNl03ks6aYSVYcKqmxxyB0bU9cmZkGmU49OjS57csP1Yww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by HE1PR0401MB2649.eurprd04.prod.outlook.com (2603:10a6:3:85::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Thu, 16 Jun
 2022 16:44:20 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619%5]) with mapi id 15.20.5353.015; Thu, 16 Jun 2022
 16:44:20 +0000
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
        Abel Vesa <abelvesa@kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Liu Ying <victor.liu@nxp.com>,
        Ming Qian <ming.qian@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-input@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v5 12/14] arm64: dts: freescale: imx8qxp: Add fallback compatible for clock controller
Date:   Thu, 16 Jun 2022 19:43:01 +0300
Message-Id: <20220616164303.790379-13-viorel.suman@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220616164303.790379-1-viorel.suman@nxp.com>
References: <20220616164303.790379-1-viorel.suman@nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM0PR04CA0029.eurprd04.prod.outlook.com
 (2603:10a6:208:122::42) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9c1fc029-83a0-4f97-29cf-08da4fb775b0
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2649:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <HE1PR0401MB2649D3A5494DD54288BB3C6D92AC9@HE1PR0401MB2649.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: K3e6CBgOpLH5I4OWrNrxxbtGPjA6hhIfuCDZwBBRNIX3WQcuvBl65pYiVj8ZWeUlTqCECrF1tqx4sMRWtjKRBAPIoC/Ky1q9hAAaZKFEPLTJzQkBGiC+nzgBc0Eebam4fspZrNryS5+/x+uLnxyeS53KOBkp6uqcUeeX09tLG6XMtLOoCZ9wlEJXs9vvJtvVkakZDz7c/zmtUwGKBejBMWb2IMzKYWs3llh1gOJGhewvN6iFfgFfYZkrvk4E4xyPHI4hoey16HbWg32u8d0pOXFtqsKkXm0mGfC+8FRF17RTn9pfV8+TpboeUBPF70SmDIWy/qmJI5siirXE4RwZvQXQAYbxnozU38qU4yEJm8IPVegpwh7hQe7Svl1HQ5fW4Vpeygwwy8HnhUP3FN7tVyQ3ERqku0feoD0iLLYPpwAvujlZznuUKCW+WuQJmFhO+2clZphJUEJv6vtxerkcEl3iQgVIpPKHspGZLatlJIGufx9LQV7z01ZsPm79QT6rSuY3onNRznqOtFoyXBZjvyKfuUNEORPeS2wMNg1ADXLi3zpmBPlewsZ7lmWkI9KrCVV9CNyvAuhf7N1datWZs9Ki2lkhmkTE1z7Jg5rY8fL1qksTgsb/0m0oVLf07p9/yGaH2BKaMSyJIujtonBN/w62Ntnu59mi/kMNz+v2n+sK5tT87al0ROLLqNWGz7NRVoo5BejLb7DtqR7SYIxmOnTbW6NxRmpsI87t4+Uzi7lBU1f1suZHpDoVX3gtH5zk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(1076003)(86362001)(186003)(38100700002)(6666004)(4744005)(5660300002)(2616005)(26005)(7416002)(6512007)(66556008)(7406005)(2906002)(83380400001)(66946007)(38350700002)(316002)(110136005)(52116002)(6506007)(8676002)(508600001)(44832011)(4326008)(36756003)(6486002)(66476007)(8936002)(921005)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?70w6syxRKuUILNGEFKmzcpwjfa7Mr0GPWu+Ah+63D7VhnX66KfhfqttOqV?=
 =?iso-8859-1?Q?OvDLmGdO893e7ZNQyCo5rxSDDigzacB8+0WgoHON23UF40dTJTnkrHQytC?=
 =?iso-8859-1?Q?Ey/z7kqVs2OUwfLlVyQwK8+eCL152QuMGtcFmjZ8cC7Q3AxhBmO+VE17o4?=
 =?iso-8859-1?Q?7UyMGtUkhptj9EdbX3v4IBzfj2Rzl1IHKWJiCZjyUZz79Q3k3Fr10qTgVq?=
 =?iso-8859-1?Q?BI4pyxtmrFkGCcLVvcKiNwX2cIktGORyrjaP8jIWI4SdrB93+hym/AWZtS?=
 =?iso-8859-1?Q?05d+IYe4O85M35I85Tyvmi+Ky9Wlo+4r8m8L78EaXQcnjy5fP1p0WPVV5o?=
 =?iso-8859-1?Q?5rpTSsV8p7KVcNSXrfW2ccNeaoS3tQsM84vmnFQrMccRqCRmQelN7GGHYL?=
 =?iso-8859-1?Q?DvVn+RLbJ0lFPd+ZL/ytMOsc16Kx2YI9Ruo5RG1NwO30ue9B3d+keSTlDy?=
 =?iso-8859-1?Q?dZ9oA9FZ7CdNxsVTfgLd7rc0OO4sBvBP4sBwaUflpUyNrgTAbBsUDlCuM6?=
 =?iso-8859-1?Q?pEwNLxjDGSptWci3/XNFYfhOXPXtEp90gP1jK59S+9rQR5bFSiOgq9XFSU?=
 =?iso-8859-1?Q?fekWibcoHXhvR1D1Jq8WO11p7k53Cs7fpCQvaNGs5lpJzeTVgSX04rspH+?=
 =?iso-8859-1?Q?nLduN5E+TTPaxSO8UX1+NE7Q17otAqUkM7bWOak6IlyPqwg+Kb/tY11l1O?=
 =?iso-8859-1?Q?zs9ApGDxAechO1kM7h/O+wAmyi6Q65N7JMVnWcE4JYLyF7glu8cQJsXExe?=
 =?iso-8859-1?Q?SVj5ATfccIyUCuCcq8uYgdVOkuY7z08qVK/6kcVaT/aggl073EiDQ3dat4?=
 =?iso-8859-1?Q?HHSKn7UxMkdlR5w4eMuGo07VbDjv+y21kyRqb81IIWYcKb+rJh7BcDSVsS?=
 =?iso-8859-1?Q?ZO3et1YQgW4+Mk2YPZ3ppdiRmYXpDtzOVhp7QJ+lSJ3IL0wcBAERKPf2kl?=
 =?iso-8859-1?Q?OH5CC4abi2YHbSzixOOWjJduU6desZgBXeAj+iTZ4dUV9dv9JVy1O60WDG?=
 =?iso-8859-1?Q?pWd++5U/bHaxQ/AEAOzOC1GBzH71vJS/Br5AKf+YAMuOnOpd0BXYaOYgbt?=
 =?iso-8859-1?Q?xSocNT8NthXKr5GuEIcUGtMoigNIhvewFbmHOUmlB4j6KAKH7rreRMOw81?=
 =?iso-8859-1?Q?FPFROCTDRoDWQ4eVAbZsqCgQEgKzwQJcMnmk3XLleLR0s0iY4Zqnibaf2b?=
 =?iso-8859-1?Q?gN86ppQP0fqeRdWLjnu0OYgcBh038soML+3EPqBxU1IUHGYAfyLyC7lSOK?=
 =?iso-8859-1?Q?56kp5dU2FJcZGJGdJ0EdHh4DoOA6wLNWicOnl1rB2kfEp2Mz+s7m5Swy2U?=
 =?iso-8859-1?Q?3EawjHNBG2RHMoeFsYkIMoz2FjfEVTmAvh1fXkm0a0oh7jzaCi3Yg9m214?=
 =?iso-8859-1?Q?KtwjlDL+qhLGs7UYCQEBc3OYvU4cOf3feb2slnmoWV5I7VGJKff4m3JIMn?=
 =?iso-8859-1?Q?QxCoL9h5wf3o/ntlvO4eyT+9jGs990HGHSrzG+jsKPKXAdpTK1Gs9a5Hsj?=
 =?iso-8859-1?Q?v9EKpDkCnzIVApL+FoB51c8yto6rH89VDXIQQmDBxCGqlmapmqjTXjDeLQ?=
 =?iso-8859-1?Q?UiCf/iR8wLx10iagcEBYEfmwFTtm5LMQzSpg/Pw7PaQVBUTVXzQZ/1EB5K?=
 =?iso-8859-1?Q?gTZ836vmbpUOfvMQHXEeYCrFG+TsHC6cD7PW0bQYr53DZFhml7wz5Vt2by?=
 =?iso-8859-1?Q?iLQEXPQD6u+O8gbJ1+jx7ubatplpnfFwxoy4erLyg0zfd4FXKrgkeOFgq1?=
 =?iso-8859-1?Q?KNDmWl8jG/EGNbDf331KlR7fdoHmCXxrbB1W6p5DbLxGoQG0Ws8dWrKAts?=
 =?iso-8859-1?Q?wLP1WehApQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c1fc029-83a0-4f97-29cf-08da4fb775b0
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 16:44:20.0153
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Oh70m9nXkaoaDMPDJxoAiRZtnV8XvF20Z3Q6aR6lrA0RRV0FZP40ZZOxOey8wlMQrd55DFJB7GBCkpc+eEtclg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0401MB2649
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

Both i.MX8QM and i.MX8DXL use the fallback fsl,scu-clk compatible.
They rely on the same driver generic part as the i.MX8QXP, so
lets add it to i.MX8QXP too, for consitency.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 542bc47509ca..f9c3090c632e 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -216,7 +216,7 @@ pd: power-controller {
 		};
 
 		clk: clock-controller {
-			compatible = "fsl,imx8qxp-clk";
+			compatible = "fsl,imx8qxp-clk", "fsl,scu-clk";
 			#clock-cells = <2>;
 			clocks = <&xtal32k &xtal24m>;
 			clock-names = "xtal_32KHz", "xtal_24Mhz";
-- 
2.25.1

