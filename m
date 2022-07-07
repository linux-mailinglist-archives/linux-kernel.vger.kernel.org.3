Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F00056A27D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 14:53:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbiGGMvs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 08:51:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235621AbiGGMv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 08:51:26 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2084.outbound.protection.outlook.com [40.107.21.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7179C2C123;
        Thu,  7 Jul 2022 05:51:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X0gRGbV/y9tckZ+WTo7AJZuxpN4263jiSeWq/cq+gLq0A3BhrGF8K1Ns5hRv5E0hmj+1PU8CAAKet26UxK+Rk3Dzrv/enM5P+wlRQ6zUa0pGR3Gcu2dGA3UWyA/2S8Kn3Tzj3HUDrMa5dYe6cLC2zWNrP/fiYPtyhQ0BBLo5wIN+sDsSiS0CTTt4fcASNch3QVqgxagQeOlEOOIpPZXiSpskqdfU3wywJLVvM4rvKI0yrZevHsnwh2b0z9s68ham4eACGDKBfvrLsg3iqwDXJW2T7Ua1CUrRhg39OIh0HIuVx7+4phgO2ttf8p6VcpAu0Quc8AtqxxZYfkRfv2ieDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z975GfFeLaXwZjVEq1de9w2k7fbWofhdKzN2yvGNXGk=;
 b=fxzj5IQyGXP8kE+b5+nZxcixVpV2rVplpd1iQBdVm6A2teRe96wKZp6KwLT9eT+gT5JTIJrn8Cm3UHXiIAVOLgC/oTjAO93DbEWM+TabagnnVuEquGzApRAGe+ckUOpf4nI+4xZiT0WJoElfqzk5iy9qL4734a68kmpFZAlhm9SfDxXg50MaP4rGh7FrPaVbj9HSWNFj0pN/gavSFxm0csHhpc/+4wXw1glxfhxezsg4QZxuD0ayllgZvHrcuPDjn7oG8EIo2CN5TYLnPd8qY6WXWnSstr9i7SQxj6P5yQkoK55/mKORpUrYgwGvavfacd2/CzwQqQ6GtIFN937oOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z975GfFeLaXwZjVEq1de9w2k7fbWofhdKzN2yvGNXGk=;
 b=DqLRaviLCfAXNHi8rEkVA3YUc6Y53EelWr3kucP+Holnev7WACy0zfKRkxunVNmjobFPBjKlmqH2J2Uj806sH8RSth61EfYwbqRa9S0vjeJW+JWmh5Bu2RS/+Zv8XpOQ8CWL4JOC5WCn8iIgqDq9bZ8/JY18Mq9Uq7bBmhLJ8z0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by AM0PR04MB6418.eurprd04.prod.outlook.com (2603:10a6:208:169::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.16; Thu, 7 Jul
 2022 12:51:22 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::6546:3ee1:5e6c:278f%5]) with mapi id 15.20.5417.016; Thu, 7 Jul 2022
 12:51:22 +0000
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
        Oliver Graute <oliver.graute@kococonnector.com>,
        Peng Fan <peng.fan@nxp.com>, Liu Ying <victor.liu@nxp.com>,
        Shijie Qin <shijie.qin@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        Mirela Rabulea <mirela.rabulea@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Viorel Suman <viorel.suman@oss.nxp.com>
Subject: [PATCH v8 10/15] arm64: dts: freescale: imx8qxp: Remove unnecessary clock related entries
Date:   Thu,  7 Jul 2022 15:50:17 +0300
Message-Id: <20220707125022.1156498-11-viorel.suman@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707125022.1156498-1-viorel.suman@oss.nxp.com>
References: <20220707125022.1156498-1-viorel.suman@oss.nxp.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: AM9P192CA0026.EURP192.PROD.OUTLOOK.COM
 (2603:10a6:20b:21d::31) To VI1PR04MB5005.eurprd04.prod.outlook.com
 (2603:10a6:803:57::30)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3c7f3f7f-8005-4efd-0175-08da6017651b
X-MS-TrafficTypeDiagnostic: AM0PR04MB6418:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xVNRyfVELurR9iz3bLtVoJ+adb21lFyCsujIm7g5r+DQxW5lFtJ4QExmf+5aYOnsorhQh+7+bfmp9QgatDbo0bDch+burEaMeu3A6hCva3lXxR8li1mQzQ2atC3a0RBB7SMQ2CCnPil+tz5lLbW4C9f5fecDAw3Hbp3vveKC4DDE/9urv81EFYXzSG4hMI8QgVCa17GPa/uc9R9ysRcnzplElYs9p1BrAbt/ygfbMVl/6bt7TbJkWnD23E8Ft6sI1UpZO/RnqWjaBOlQXUbijRe9HRINYi96fBVBJoWm/LPk86UCzV0t50wyrSfMfahslkugir7br7Z8jjgwuXxhTCYxUrmglX2HD0Bk0tPu+yetDg2CG2UbwUF5tpk1QXuFL42MKzQi6c48DOZGptEAgvNhM2gVaWSy/DCxoyuOoYF9AHwH5eieelUVA7adEI9xP/w5nJnIs6OiDNmf5im/o2BXXTBOs2ntar5HTgZPfxw5aJhapXbi4S99VNHPICPUqaLV3nBq7qmPmfu8s2YiDIMpURGcEowiVtD0uadvbLSlgkPahJZ940Xv5AjiADDF7BwXspg0OoLeD6tfh0jFP2sZaKBjPWa6+mLFDFj1kpzwbMbbn69mF0f4NqOFxWmKjJIJsbdWl4KKnbhsGfh+nWEr6n0i5Eo+d6fY8feKPXKOpywmG2vLOKPsNgI5no9K5OGcsPJ2rhVPEODGQ/tyDdCNF62TmFw/aIjt1EM7IcrfcZa4at9y6zROZSM2llGqrUBWzqSiICqLa6SVE28Rbj1Y/nmhKep0ZcIexCvsNa3+Nc6VthIAOYugMah+sNd7B5daR4y12YJcuNKxN/6vQAcziJ8weczL3ht3Un99zys=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(376002)(346002)(39860400002)(366004)(6666004)(86362001)(4744005)(5660300002)(38350700002)(6486002)(316002)(38100700002)(2906002)(41300700001)(7416002)(478600001)(921005)(7406005)(66946007)(66476007)(6512007)(66556008)(8676002)(4326008)(8936002)(186003)(52116002)(83380400001)(26005)(110136005)(2616005)(6506007)(1076003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?HipCWr0qEgdTRCjgWpKwPqssHABb9TfZM5sDIe2M+OMDoBPGtC//w9toyg?=
 =?iso-8859-1?Q?kLNwxrawHJ0CFXNy+lQMR/AZj1xXPhZlS+jr96gqLPxvH8qTIJWQ/byZDN?=
 =?iso-8859-1?Q?uW6ELcVjCmPhQOC1mmV+YW8gvTkWDP2ppHDRnTcRnAcd8SB3yST5o44cxT?=
 =?iso-8859-1?Q?Uby6+hNNcIguGAhh4fJXuzm5F+t/zdUlP9Lg2gj02h+GeHnJ6EJJCssLU6?=
 =?iso-8859-1?Q?nEmMYGSeiTa0XHVf9giM7RHIZKR8gYYtbqlvYtpzJUoeqEIq2jvE0NRYpN?=
 =?iso-8859-1?Q?Lb6i8H32QAaEMD25EnRMOYAAbF4fOD0acwtOcq738lpbKeUuax4nphhHKj?=
 =?iso-8859-1?Q?hU6dtHcuwQ6epX1uTL2+XITN66qOFozfr2LST0ULSQk8Hlb9vI5SeBS3Rk?=
 =?iso-8859-1?Q?D0sPgR6j1k+pHN85OrWfCLTe1cybkPQMchMM7AFilmfatFDSwMEHLK6AL0?=
 =?iso-8859-1?Q?t2TzU0FM1Z4CBGFLe34p30KW7LK4z+olY39UsINmPFVsh3J3mJ0U470t89?=
 =?iso-8859-1?Q?PwxWHC7z2nraHv8hEP7nEYepFzMIdvI+pht4n1N37cVh6P0Wu1SFFln+/s?=
 =?iso-8859-1?Q?J0GzaH2hEEnU+Y+BrBb3MywIfO43hMEGgNYqWRQixkZC3NUEe4j8dZrg/p?=
 =?iso-8859-1?Q?DNC9n1FvYQ7geKFxXUqYOhKX4NOyIqdiYPcWJ8nFGc86Sp9LPC6NSiyrMQ?=
 =?iso-8859-1?Q?ZIxiWlb1cQ3GcHDYCLvEjMGB/l4aYajJbjsH7/F87vbOYz6immye8WHbeb?=
 =?iso-8859-1?Q?WgoHjiAtnno2JP3TJm4P7gQqvuq2hStMLxrWdnf635jhAWuMiVGh5tIRx0?=
 =?iso-8859-1?Q?cMoLjowIuk5nYPPG1VkAeNmd0xdg5JjaXdxAmOtC2I+naqjV5HWDCCREZ0?=
 =?iso-8859-1?Q?OQztk3MD6juAHI96AFZE2VJSTTcEeuhBtAWsdd/8eBOe4ZEOHiFP5a447d?=
 =?iso-8859-1?Q?3L1rohWz9rvFJjZdvWdi8so0ZSMKBWRWS7l20WzWvMtsqZijWGqOVp0Ewz?=
 =?iso-8859-1?Q?qK0Uoxa3WBkNYU3pjTzVEvfjdgx2FkmHoopj5K28J2DXVnqCD9GbH8A63Y?=
 =?iso-8859-1?Q?gBLWA0rCu6Pc8QJ5tzVebCXzYAFGAxE2nJf7w2KNzuiti8Avf3GDTd75rX?=
 =?iso-8859-1?Q?rrSpXqfbuQHy3Bs6ZmUsSTr2CpuHhhr5WyzeFaGTOuxQucFwcSHcl4/NAl?=
 =?iso-8859-1?Q?JI2ByrfbczzmDkPRvj3zw3tLsmn2EapIRMF+4UCzbpO/W4je21YkQapvGK?=
 =?iso-8859-1?Q?Gw5kURJBjZayKlMvcUK2xydQfWunlr3MasNGr0G7uPt3a7XoP02by7bf2i?=
 =?iso-8859-1?Q?tpMgw7Z+MB38ZyyC4E6FU/N82U8POEWoRH6TXjMZHmuITNqviyE8JjgZVk?=
 =?iso-8859-1?Q?rzJd19RsUVxH50UwQSJGbPEomlGfshqXKL3vwYIfSwY+TRNCrACNSRaMiW?=
 =?iso-8859-1?Q?/irtl7sriQX89NA/HatpEUPhd3d0ZSw4yKvof8UZLDFAXLDLJeAtem4h83?=
 =?iso-8859-1?Q?HJvBr74ZyqS2fJmvxHIZH6U5Dn0xIog7pEM/hmVgOTA4WgWrXVfJLOQQhL?=
 =?iso-8859-1?Q?uZdkPIx4/9o0H5B1wxGLgfzrJmH8YbmBfF/FXx2HtroFmbQdNhiGZ9jeH9?=
 =?iso-8859-1?Q?XhssMh35fvfCFrWcc6voi5h1v3fm3kjbTB?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c7f3f7f-8005-4efd-0175-08da6017651b
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2022 12:51:22.5316
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JsBPRCe03LNSLQVLR2AOIGM6wGVKrg4B/RofiaIDWGAAKe+rv/1FAU93gtuK0SEuXf8YWTJN98nu7qVB6UFXGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6418
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Viorel Suman <viorel.suman@nxp.com>

XTAL clocks are not exposed by SCU to OS via OS<->SCU communication protocol,
so remove unnecessary entries.

Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 arch/arm64/boot/dts/freescale/imx8qxp.dtsi | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
index 483996a1f2d5..878c2aa663f1 100644
--- a/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8qxp.dtsi
@@ -218,8 +218,6 @@ pd: imx8qx-pd {
 		clk: clock-controller {
 			compatible = "fsl,imx8qxp-clk";
 			#clock-cells = <2>;
-			clocks = <&xtal32k &xtal24m>;
-			clock-names = "xtal_32KHz", "xtal_24Mhz";
 		};
 
 		iomuxc: pinctrl {
-- 
2.25.1

