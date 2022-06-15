Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07ED154C6B2
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 13:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347191AbiFOLAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 07:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348970AbiFOK74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 06:59:56 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70047.outbound.protection.outlook.com [40.107.7.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9333522CC;
        Wed, 15 Jun 2022 03:59:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Q/Z3HizlbV2PHrSZhT+jxPfIoIe1FUbH1Bp7Yx2RWEU0r77nOQY6JTSbrdxNg1kj/3t1MuIalv+ZstgAevTiEBxBp10I7TNeiRi5/Zhd/Rv05Gi2wToKpzCbf7mEYmhMc8RfF1FVyYye64RKZwK5Yfbrb2AmQemTYQAq7NJinVBtv47GU4A8nvnFywmecmDHNMflHqAvNRsddfKzWd+CDq60ynbKqF11yr8FlfEF7n4PA4OfgOPFyxEMOfYa+zk1ti2QiRW3LoLmcds4CFT+6lczORkRsnuIxaB4qoSl1GbZ5dfulHOYnH9vxwHRuYqlMykEBFWX6xb/ocS+72gg1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZE7YioHRJF6eFJ12Mk1AUEPZI+vunJq7+rrUJcTTdS8=;
 b=aZV426YToU67smK6MSZZ8rq1upKVxvNwqTWWre9maGLw4/Xnh1KgmDCr4Gcy7kDYGbgkMniXzC7tS0P8Rt7GXpnu0WSu5ZkHRzuMyiurCui5RlqyxxFey4iYsykqArbWy4Xy3PePOTsZG2uMcwL5GFXBEsePoPuvwvLzPyDOJq119wfvuTftcYPWXd4ujRxXpGBzbIvW8ffcZokls5balHGzdxsn3g3pC9tX08O0BjPu2Mj0gC9L2lJktYwpNu2MGLIzKA9lNC34VGuxGuxeYM3vCqnokc/zk27NqPv/Swq/gUN+Ob1xzVMxgEuEZL3mX7e1wR9q8SwvmrTNIzLrJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZE7YioHRJF6eFJ12Mk1AUEPZI+vunJq7+rrUJcTTdS8=;
 b=U1I40lbK2/prdFc4uajqrCNnlsRxJVrL9VxX6FhlE7s/v2fHu0ivUHUodvdJZCHzevX8oGl+vJ2vX7UGbmQue0iSVKEDu3KpZ0C9nz6KOFiyIb9LEwzHXBBFBe/aVcFE4rCVNBgx2bGgynhsvB836Y6GX78CgJ2X7FSUx0pPFXY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by DB3PR0402MB3948.eurprd04.prod.outlook.com (2603:10a6:8:d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.17; Wed, 15 Jun
 2022 10:59:52 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619%5]) with mapi id 15.20.5332.022; Wed, 15 Jun 2022
 10:59:52 +0000
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
Subject: [PATCH v4 12/14] arm64: dts: freescale: imx8qxp: Add fallback compatible for clock controller
Date:   Wed, 15 Jun 2022 13:58:32 +0300
Message-Id: <20220615105834.743045-13-viorel.suman@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: bd78fc32-c4f5-4f94-c685-08da4ebe2c6c
X-MS-TrafficTypeDiagnostic: DB3PR0402MB3948:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <DB3PR0402MB39488D8891AFD452F9C5C2FB92AD9@DB3PR0402MB3948.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 25x4n8k+oE3hasI9aNu0LH6ratVq0EXq57CixWp3eyGT939b6EEO5BamedJ0CgZUK+uB3tssHV2/zam845tqOXcTP2n5X9iJJ/KF/hg3MR9diyNJjBqdEQuo/WAyH0De4yb9QIM2GBrfFdhKwEEc498FqfHw99QfVnkPdP/FPIKvbsAwhSLRbWWXad5eachRFNSJelMcL/x67UaiC5u1tthYKdCsOeI8lygUHpOENq1EfQ60waCzjyPKmbmycsROK0fB80AUnRzflLwrDQ0qcyBX5OsMupouzYAV9JrQmgEKSC9djIKkbrIKmfyO/w8D+DvWqpE4ZlZHLz2gNZu6UvSpg7aHB0I7stZyXK5L/qS5n0lAgstPyFltsyy7llrmuNUHEyDeNDYQguhHEOl0bKgMRg9xwDtAkHMcf/4gB3uSEur8A/2AZ9egXYULYmlDRFo27iYhl4M52Uf7FzcKo7p/FiKSFlEY8Om04vx3CFO2uBLiZC8gBgNqiOqj8d8CU57eeeAT7TCC15t9LqzMiNE8b67vqGIF1hNl2Pkaqa9SfDMyZacS7weFz59tTCSkPi4Pco9V4kGBekRx8ZSebBB8YAVScjZE4wazGCGYkKlwYegvaZmgQpBgmZoJsiUr2kJkHQPepysEgAecrJ8hAcpO1ZzJGrnNvwWAFpbwQwxU1r2BUYqotIxvdwavQprDJHPqYS3GyIUErWFXXzvCnTQjsYjx7RF0OPmvZ9z1kodEnKfAG2Varxv9XJC18VjV
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(26005)(52116002)(6512007)(44832011)(7416002)(2616005)(4326008)(6486002)(6666004)(508600001)(186003)(83380400001)(4744005)(1076003)(8676002)(6506007)(7406005)(2906002)(38100700002)(38350700002)(66476007)(316002)(66556008)(86362001)(36756003)(66946007)(921005)(8936002)(110136005)(5660300002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?QRpzBCM87zJq4SGvkRIWPO1TC6PWpDu7Z5GXdcm3bnMKe7T4al5ko9OeUK?=
 =?iso-8859-1?Q?S4aqnIZJu6xidUjLbSIfNfkYwqv9ONHbKL8RoRPUpBxL3ju52hOn4dhgig?=
 =?iso-8859-1?Q?whp2KDOmFmTrLhSW7yYZmBrgFw5k/Vl7kKlZCu9IczHPbO0ICOS49zFCH/?=
 =?iso-8859-1?Q?bcrcBQOY3eJoeiVCVBn2jy9Vqs7XjyZM1PyxwEjYQhZFaRbdDuGodBF1ub?=
 =?iso-8859-1?Q?e8vPQHtp2RSVxRSXiQDRq7qLikyx/LD74eC5Myg1mdn94RmnPP9a3VAjQ/?=
 =?iso-8859-1?Q?kdnM8RAia4U2xkfxPGf5fu2yplCj3t9saV2d/yITy3yE1sO1WEzdFBSuBA?=
 =?iso-8859-1?Q?t0//zD209MoH1tbZTqbV3cCU5LfPE2eGQMDoKUzbq5Qju6Q44LZHriS3MH?=
 =?iso-8859-1?Q?clMVWZaHp2M97KOPiurLMq67pxqZ/9wJD28rUT6NpFPmCJIlDqF3iy6E+N?=
 =?iso-8859-1?Q?i/xlDmrjxw+kMeF0ZDQ1CHW+xMeaJc9poCUOZuebEgv6Cnr38zeUR3qPeu?=
 =?iso-8859-1?Q?3QXM+I4WZ4V3F73ipyy3w7f9PiJTHnMICM1OnEWabx0Qts7lvOjPQ/YTyc?=
 =?iso-8859-1?Q?dq6dEgJ8Z4B8ZYZ7wmpyPwqUAeP1HWYV38NBTtSfDVMTZGYPlN8u2W27sY?=
 =?iso-8859-1?Q?b/SrUyt+6AdpWSE4ZRk2UkW1S5dkKZlLgz99aRL5duQzqcuM/vBCSUQNDT?=
 =?iso-8859-1?Q?7sYSL52n1gnM2Hu4W7e2nv0eCuZ9T1wSuE1rz8Jfc/RzHyrceyjT6+lQjN?=
 =?iso-8859-1?Q?3BkK1hmkxHx1EEbvjUyIGB+1PwZx4UheEGoU4T7FW2ENTHegYp8oQIMi4o?=
 =?iso-8859-1?Q?sGGhkJcrQ3dnI8CT03SH+REgSryUroc35LhPwzBcmYrNDtP3w4Mhqr6yp6?=
 =?iso-8859-1?Q?05yuin2d58kdbY83XFHJKjpgeWtxVEQIOXqgYBw7DVWLEEBLFA/snHqecD?=
 =?iso-8859-1?Q?7jxg3/jcAjoNKRQSooIQnuH/2YkSu+m+9vIPMgMyN9NZCaF240lxQmck4z?=
 =?iso-8859-1?Q?VBUNlUgeK4n2AYw9UrI8/R5lL4BMT45KwY5blXVtAtiq9Xe04QXcC/QzQa?=
 =?iso-8859-1?Q?pwIlvVYVmLrCXxvZQmYkgTwYz7u4tG9ayGgNncLyYwdi1tvbtHZf2+KdL2?=
 =?iso-8859-1?Q?wMvVbLEkKtRCKcbwbwUp2MqmOD9wBzufdjYjdteTPoON7+RYknlteSsGmb?=
 =?iso-8859-1?Q?rx+lElUlqyYQiKaGrVnFCjZPUkLoIu0dWLnA6V0zsHpKFYOd1ZwzQCaWKR?=
 =?iso-8859-1?Q?W1G25sp/GOIgGSMnO0k6DBthymZqyKRX+T/OVavg2QFDD7WxWYVBNrVhd0?=
 =?iso-8859-1?Q?5+IpBBYc5T3a05ihoYdM830itTklOFQx1kfYL//sMft13k1wn5/mjkhbUg?=
 =?iso-8859-1?Q?uZGXwG4UVF3Ix6mHALdYY5pAjsRqhfeYYhv5BCyZjhXPP6h6V5IrIPtIUu?=
 =?iso-8859-1?Q?XQH0g9F84YYkhDrkEbrZdq6xZ0+B/dahlo9mQ28vPpp/VL8RNo/NGwVOLq?=
 =?iso-8859-1?Q?KjAxJjiHE4w4ejmrIhFpfb9SKZA/cPL8EHIRy/mcWHOHtq7txZ9h3BqVTx?=
 =?iso-8859-1?Q?xACPsJl6QdLWas6T0Uo8+JtPkVoAGtC7/SSd13/6DtB1nSXwTLDElFWsu7?=
 =?iso-8859-1?Q?UqtYEICB8dUBK1JzFqpBqDCKdl/RaQWpU9maMVLqCgPLWSnbb8HKa0cYDj?=
 =?iso-8859-1?Q?PK0Bys7UHKYVYyybHxkyzDdWzip2K76waF3yENoHfKv1Hf5VG4IC3i2WGA?=
 =?iso-8859-1?Q?40z+LVtIjq1HggEF/tbtLM+P6tegdh4N2eRvjSoQI4BmADt/t+lu40sEnb?=
 =?iso-8859-1?Q?jMbCDet69w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd78fc32-c4f5-4f94-c685-08da4ebe2c6c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2022 10:59:52.4612
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TquGocOtWFg49rZaB3vkzYGeh6HLTW+/WIfAm5awv6jcE8DC48IM0d483a2j3nqgfilYZ7EI3T6IVskXlbhYaQ==
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

Both i.MX8QM and i.MX8DXL use the fallback fsl,scu-clk compatible.
They rely on the same driver generic part as the i.MX8QXP, so
lets add it to i.MX8QXP too, for consitency.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
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

