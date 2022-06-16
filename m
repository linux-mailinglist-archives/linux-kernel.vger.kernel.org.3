Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF2D54E7F9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378195AbiFPQp2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:45:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378151AbiFPQpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:45:05 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30043.outbound.protection.outlook.com [40.107.3.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D3B31DD4;
        Thu, 16 Jun 2022 09:44:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Rzm9X8rqf1OOHiuNGaAt5HQSati66Epm0Nsi8MxhxMGH7//Sy10SBt+Hm9Gu7zyx0P4fZ0/xNGqqeVyFB7/us5dGnxWyQXViV2zdQvieThRl7mpfcOqUXRdGcF0Pb8ehrpTZqjhKl/rWwYXDll9XfZSYXamEmqBJ9l5T6WB5/wzNf80VljyCOoR2PmY8SpmuI4ncXG23TT+XFVFF+IjL2qWoSUy9zJ+nTtOOMXjqHrDHGdcTwtZblf/RXFS1ztELaj9fJDNTEsdGUxrkaaGnVBIHJy2AQtUSejLfDJDGIDyhw8f/M2Yq/YqpvtBgodmBKYpcpG9fAN/1uZWWHjvqsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1zrSUoeYfA85nnDGnCyS0YsESQ2iNulAKwh70Eex5M=;
 b=HJZlCoZUQJDCX15p2j9a1oaHdO41OLIu8ozXboOowh1ArgSQYM+ISSJi1kBznbmVLrXcSEtgsN764/p1sHpcqp65u6uH8cnkfz2wCBX7r5bniQjACzjtsdUJ/LVg9wqY+EJTmz519iLPvauCrlFGmSK06PaCnKkVOwKFf4nHJq6VZoxCX8ncmKXC5cnR6LKwuAEbJSWTwlMhGn6gbVx8URrsNc78oGUsNx/rLxyfIIJsP/rTm4vqkzVMQbxJfYhwHz0Qj/HMoVARjpnGRIdQ42Q8WNOk2zmR/5qmNlsWkrBSr7n8n2t6nFMUIiGfKKJQ9H5KIJsq3GgMkhMQS6PcTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1zrSUoeYfA85nnDGnCyS0YsESQ2iNulAKwh70Eex5M=;
 b=IHc3IJzYMBwf8cSZ4V/KG2A4rdWCauHGp8LeWKP9SlQ4W22droHM0yhUhVVhttX3J+bqwDiFuoC6MunGyExRGgb1nBhvY/KgtnWtPy1RYiPQv/+2S8MM5oA+aWZaXIBN4sn8f4WgnEaR1mU0T3kpRI/7xJLHde6FgoVDHOtkbo8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by HE1PR0401MB2649.eurprd04.prod.outlook.com (2603:10a6:3:85::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Thu, 16 Jun
 2022 16:44:25 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619%5]) with mapi id 15.20.5353.015; Thu, 16 Jun 2022
 16:44:25 +0000
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
Subject: [PATCH v5 14/14] dt-bindings: arm: freescale: Remove fsl,scu txt file
Date:   Thu, 16 Jun 2022 19:43:03 +0300
Message-Id: <20220616164303.790379-15-viorel.suman@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 888bb24f-4d55-4d9e-caba-08da4fb7790c
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2649:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <HE1PR0401MB264923551C5E05D876EB14EB92AC9@HE1PR0401MB2649.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1kxgVuzas62xbjkreEJ07URwP5O6mFP5p249Es3JcWxf5mbhrSNeAMHy4Ff74/WMzkLMNTlFBExVa4zQo99dCjxW7HD6BOX41sAJoH7GUFvXt1MECS21fJMGZ84NjZlKhJJmUYZ4FnCW89IyceDmoUOFWJi8s4LFIR+PP49gaWUZlIxH+2GrqVFA1ZGKMw1UbLqOkuhrf3crOjBzywhGCcWC0EHnnGwDX8BSv+MDRRBNXavnyyHcH/YdzCdRun3farJQQM89XC2K/CULvowHspHLumCux3nfx1YHUZCwDjPezcKaexawinWWibEatktvuwnaZd9hHFVCzwe/ky8q8A3mwi5kZ+Wh+P4OtJEZBK/ThhJtlcEDqVSBBWvhpDaKV9UyC3px734cKLnnUVc0D/5+kjiUrZg1yTCegaGeVLdFGP/gaYmsLW4BAGs4TOv+VAoXelaZdPXz+7ah9jCPCDtleSd7gij6zqa5qE2EPZkinTlH8eM/Hzjz5Zxt+RqOaUociDRWs3qQfep7rg0nlj+cGQDC1UxWrU3ygqPGdKtGz0S9sZaQfdva9ft0fDxLF36yr9M3fAN32513h9r91nBLvBaTd7GuEd6c5ZBd1hUObbGQwENJwSgqU/FiZraEnicWMHuS0fL2+zjKR3QVeyYld4HYPacn4NipjQPAB3bbTozNBXWdMnxPtrbwWPlcwdWISnz910G6wuJjDW4RAp9+kDhRKypIH7eH68mznTk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(1076003)(86362001)(186003)(38100700002)(6666004)(5660300002)(2616005)(26005)(7416002)(6512007)(66556008)(7406005)(2906002)(83380400001)(66946007)(38350700002)(316002)(110136005)(52116002)(6506007)(8676002)(508600001)(44832011)(4326008)(36756003)(6486002)(66476007)(8936002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?qO+LXGHYB9HNip0pmepr3ctosD+k6emdPwGu/DAoQZC8VEPj4a2OUhhGBm?=
 =?iso-8859-1?Q?LI2C+XWogBBQYLweyONfpmXbBg3otE5FRcX+kZFUF0smUdv3N5cRKhKoJ5?=
 =?iso-8859-1?Q?V3ZmBXJxTRAss0NVUI934n11gNl9eS/cXsAIWup1nJ5irifMkbBhegAiCr?=
 =?iso-8859-1?Q?uAA84XUdOj1xaRkENAr/bESnZ0C196ZZnRj3OHEHBIodNSQum52lSZZ79+?=
 =?iso-8859-1?Q?+CeAFQHcjrWh/sXVI1PpCAwIxdT+FpsVrj0XIJfU6n+N+MFLdQlnwK25zA?=
 =?iso-8859-1?Q?KHcQGLhIrxGK5jQfcqABS2MHWnlslodW+xeuS8hc/uF+M6k7cdQYkjLQcR?=
 =?iso-8859-1?Q?khVCKciE4cyf51u3SAZBiQUoUzqDxr61Om9PRXB2gOk5yJ9caO0/RTdWeY?=
 =?iso-8859-1?Q?i//lhqeED7dgx6nmjbbBC1BxP4JYx78OKwc3gOHXqB66QNvIaSNqpVVnDS?=
 =?iso-8859-1?Q?kZ1YGKUtnJyCl9vZI+X+VTsLs4arD6v4cgFZqAqqBs2esmnvCAvx63hc3E?=
 =?iso-8859-1?Q?bBjAxCyDO6IPRYB+46MS0+wz7GAUpOUs5uCh3LQYDgvJOG8Vu7VSnDcyM2?=
 =?iso-8859-1?Q?4Wp5jQdk+NTQxt0hfkj4c17gnjTQPYOCiJ7SgapNiSDRIekvrjryzCYPkF?=
 =?iso-8859-1?Q?qhfB/oRyPkiW9v5Rf9B8j7AEAFr61p6lUfFpRbjQc4J7hoEak/KJU0UevS?=
 =?iso-8859-1?Q?nZ55Ky/xHwhGqJhhA+uVfB7TpaMbI910TADtuC3tFJWG726zQ0ov1GyzcM?=
 =?iso-8859-1?Q?SxqtkIhroWeXEo3HQ8ByKPfNsO49yTALflUfKL11MeS+1K1DaxoOmDo1GC?=
 =?iso-8859-1?Q?4VGNtJlqQTz2KGmYv29+bMdxEXX7wY/Me3cXTx9kjvCdc4ktkG/TjeleJu?=
 =?iso-8859-1?Q?gjiML51Gn+XzOprbIaxmUNZVBPPjPRX+o174z9uMw28AGKEYBxY+5ciWI3?=
 =?iso-8859-1?Q?/mOtju5H9FoVKZHmdDBO3lQunhblwnB5x7yosx6G9fcrQsSpgDFGfYs2Zs?=
 =?iso-8859-1?Q?p3h2f17xSGRBJuJo1Oxh4/ZDsL1I9yhO05nXNCCPsFS7Nrryqdy1be1cLE?=
 =?iso-8859-1?Q?0MjsgvV+2ptXADCY7z+Tsx6ItDUToTl819tLpZixh88UWAlmPPS2aC/rY7?=
 =?iso-8859-1?Q?3+NQgayelF0Iuf+mMMa8uqh2MbOBKuL+XffQhi/umjAcdqOtbtLS3DeqY9?=
 =?iso-8859-1?Q?Bd0zY4PSrtkCwO6jGc6fJkT5EIS+PPLrUi80oxQy/G2o2XB/8V5gJlZLiM?=
 =?iso-8859-1?Q?i7Rue2LND6Fd8voIHTkhzybANceFIOkkxUoTIjaiXBjSQvPX2cXewlr/1j?=
 =?iso-8859-1?Q?NRn97csPzcm2TyqUL5MoYXsHGrBGBE+VimwzQdHqKvsKJUZeQBkvIlVxLE?=
 =?iso-8859-1?Q?Ln/ymVBLsyzpMdGXaJOr/wxQvarVcyn6WR6t5kEgBPFGVRZJ+BfGgbNzzv?=
 =?iso-8859-1?Q?utaM5nG7VGFljdnHlLXStZ1bWI+xGCGwnDduL8a/tQ88UaFRkZlJh6FWkC?=
 =?iso-8859-1?Q?MTtv/xCmfS5EkAthMR4gbQZySQuZU/TVAIdKI8WxYcZfxvfULKgcM+kvTm?=
 =?iso-8859-1?Q?GOqpwZo4kITQIRe7qk2cli1Tx5hWfHNt8nlaYLHXdgASXctmz0T/GLgdbt?=
 =?iso-8859-1?Q?SyriI1vgHLILviTG9ufhED4ByWxfQ5POIn9eNVIBuBhYQLcWVvzKq+E3cD?=
 =?iso-8859-1?Q?cDinVAmBME0P7jDQKDLuvIXq+TqiJfUwyUmLhXSj8UgwbpKNWo7+WeNXT+?=
 =?iso-8859-1?Q?OPEu8GVDJJl7CH/g227wOD7uUVK6EyM4WaoKX6p/Nzhqn6jl3kKE5TsGDx?=
 =?iso-8859-1?Q?4TvrC5k0ww=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 888bb24f-4d55-4d9e-caba-08da4fb7790c
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 16:44:25.6868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PjAnA87rzardbae5tVXgygEeKQVi2GUMHOulejTYRn3KFr1t1aHX5UEZF+F+Iajc59KHauzaQdreACZtD1L/Qw==
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

Now that all the child nodes have been properly documented in the
yaml files, within their proper subystems, we can drop the fsl,scu.txt.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 .../bindings/arm/freescale/fsl,scu.txt        | 271 ------------------
 1 file changed, 271 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
deleted file mode 100644
index a87ec15e28d2..000000000000
--- a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
+++ /dev/null
@@ -1,271 +0,0 @@
-NXP i.MX System Controller Firmware (SCFW)
---------------------------------------------------------------------
-
-The System Controller Firmware (SCFW) is a low-level system function
-which runs on a dedicated Cortex-M core to provide power, clock, and
-resource management. It exists on some i.MX8 processors. e.g. i.MX8QM
-(QM, QP), and i.MX8QX (QXP, DX).
-
-The AP communicates with the SC using a multi-ported MU module found
-in the LSIO subsystem. The current definition of this MU module provides
-5 remote AP connections to the SC to support up to 5 execution environments
-(TZ, HV, standard Linux, etc.). The SC side of this MU module interfaces
-with the LSIO DSC IP bus. The SC firmware will communicate with this MU
-using the MSI bus.
-
-System Controller Device Node:
-============================================================
-
-The scu node with the following properties shall be under the /firmware/ node.
-
-Required properties:
--------------------
-- compatible:	should be "fsl,imx-scu".
-- mbox-names:	should include "tx0", "tx1", "tx2", "tx3",
-			       "rx0", "rx1", "rx2", "rx3";
-		include "gip3" if want to support general MU interrupt.
-- mboxes:	List of phandle of 4 MU channels for tx, 4 MU channels for
-		rx, and 1 optional MU channel for general interrupt.
-		All MU channels must be in the same MU instance.
-		Cross instances are not allowed. The MU instance can only
-		be one of LSIO MU0~M4 for imx8qxp and imx8qm. Users need
-		to make sure use the one which is not conflict with other
-		execution environments. e.g. ATF.
-		Note:
-		Channel 0 must be "tx0" or "rx0".
-		Channel 1 must be "tx1" or "rx1".
-		Channel 2 must be "tx2" or "rx2".
-		Channel 3 must be "tx3" or "rx3".
-		General interrupt rx channel must be "gip3".
-		e.g.
-		mboxes = <&lsio_mu1 0 0
-			  &lsio_mu1 0 1
-			  &lsio_mu1 0 2
-			  &lsio_mu1 0 3
-			  &lsio_mu1 1 0
-			  &lsio_mu1 1 1
-			  &lsio_mu1 1 2
-			  &lsio_mu1 1 3
-			  &lsio_mu1 3 3>;
-		See Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
-		for detailed mailbox binding.
-
-Note: Each mu which supports general interrupt should have an alias correctly
-numbered in "aliases" node.
-e.g.
-aliases {
-	mu1 = &lsio_mu1;
-};
-
-i.MX SCU Client Device Node:
-============================================================
-
-Client nodes are maintained as children of the relevant IMX-SCU device node.
-
-Power domain bindings based on SCU Message Protocol
-------------------------------------------------------------
-
-This binding for the SCU power domain providers uses the generic power
-domain binding[2].
-
-Required properties:
-- compatible:		Should be one of:
-			  "fsl,imx8qm-scu-pd",
-			  "fsl,imx8qxp-scu-pd"
-			followed by "fsl,scu-pd"
-
-- #power-domain-cells:	Must be 1. Contains the Resource ID used by
-			SCU commands.
-			See detailed Resource ID list from:
-			include/dt-bindings/firmware/imx/rsrc.h
-
-Clock bindings based on SCU Message Protocol
-------------------------------------------------------------
-
-This binding uses the common clock binding[1].
-
-Required properties:
-- compatible:		Should be one of:
-			  "fsl,imx8dxl-clk"
-			  "fsl,imx8qm-clk"
-			  "fsl,imx8qxp-clk"
-			followed by "fsl,scu-clk"
-- #clock-cells:		Should be 2.
-			Contains the Resource and Clock ID value.
-- clocks:		List of clock specifiers, must contain an entry for
-			each required entry in clock-names
-- clock-names:		Should include entries "xtal_32KHz", "xtal_24MHz"
-
-The clock consumer should specify the desired clock by having the clock
-ID in its "clocks" phandle cell.
-
-See the full list of clock IDs from:
-include/dt-bindings/clock/imx8qxp-clock.h
-
-Pinctrl bindings based on SCU Message Protocol
-------------------------------------------------------------
-
-This binding uses the i.MX common pinctrl binding[3].
-
-Required properties:
-- compatible:		Should be one of:
-			"fsl,imx8qm-iomuxc",
-			"fsl,imx8qxp-iomuxc",
-			"fsl,imx8dxl-iomuxc".
-
-Required properties for Pinctrl sub nodes:
-- fsl,pins:		Each entry consists of 3 integers which represents
-			the mux and config setting for one pin. The first 2
-			integers <pin_id mux_mode> are specified using a
-			PIN_FUNC_ID macro, which can be found in
-			<dt-bindings/pinctrl/pads-imx8qm.h>,
-			<dt-bindings/pinctrl/pads-imx8qxp.h>,
-			<dt-bindings/pinctrl/pads-imx8dxl.h>.
-			The last integer CONFIG is the pad setting value like
-			pull-up on this pin.
-
-			Please refer to i.MX8QXP Reference Manual for detailed
-			CONFIG settings.
-
-[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
-[2] Documentation/devicetree/bindings/power/power-domain.yaml
-[3] Documentation/devicetree/bindings/pinctrl/fsl,imx-pinctrl.txt
-
-RTC bindings based on SCU Message Protocol
-------------------------------------------------------------
-
-Required properties:
-- compatible: should be "fsl,imx8qxp-sc-rtc";
-
-OCOTP bindings based on SCU Message Protocol
-------------------------------------------------------------
-Required properties:
-- compatible:		Should be one of:
-			"fsl,imx8qm-scu-ocotp",
-			"fsl,imx8qxp-scu-ocotp".
-- #address-cells:	Must be 1. Contains byte index
-- #size-cells:		Must be 1. Contains byte length
-
-Optional Child nodes:
-
-- Data cells of ocotp:
-  Detailed bindings are described in bindings/nvmem/nvmem.txt
-
-Watchdog bindings based on SCU Message Protocol
-------------------------------------------------------------
-
-Required properties:
-- compatible: should be:
-              "fsl,imx8qxp-sc-wdt"
-              followed by "fsl,imx-sc-wdt";
-Optional properties:
-- timeout-sec: contains the watchdog timeout in seconds.
-
-SCU key bindings based on SCU Message Protocol
-------------------------------------------------------------
-
-Required properties:
-- compatible: should be:
-              "fsl,imx8qxp-sc-key"
-              followed by "fsl,imx-sc-key";
-- linux,keycodes: See Documentation/devicetree/bindings/input/input.yaml
-
-Thermal bindings based on SCU Message Protocol
-------------------------------------------------------------
-
-Required properties:
-- compatible:			Should be :
-				  "fsl,imx8qxp-sc-thermal"
-				followed by "fsl,imx-sc-thermal";
-
-- #thermal-sensor-cells:	See Documentation/devicetree/bindings/thermal/thermal-sensor.yaml
-				for a description.
-
-Example (imx8qxp):
--------------
-aliases {
-	mu1 = &lsio_mu1;
-};
-
-lsio_mu1: mailbox@5d1c0000 {
-	...
-	#mbox-cells = <2>;
-};
-
-firmware {
-	scu {
-		compatible = "fsl,imx-scu";
-		mbox-names = "tx0", "tx1", "tx2", "tx3",
-			     "rx0", "rx1", "rx2", "rx3",
-			     "gip3";
-		mboxes = <&lsio_mu1 0 0
-			  &lsio_mu1 0 1
-			  &lsio_mu1 0 2
-			  &lsio_mu1 0 3
-			  &lsio_mu1 1 0
-			  &lsio_mu1 1 1
-			  &lsio_mu1 1 2
-			  &lsio_mu1 1 3
-			  &lsio_mu1 3 3>;
-
-		clk: clk {
-			compatible = "fsl,imx8qxp-clk", "fsl,scu-clk";
-			#clock-cells = <2>;
-		};
-
-		iomuxc {
-			compatible = "fsl,imx8qxp-iomuxc";
-
-			pinctrl_lpuart0: lpuart0grp {
-				fsl,pins = <
-					SC_P_UART0_RX_ADMA_UART0_RX	0x06000020
-					SC_P_UART0_TX_ADMA_UART0_TX	0x06000020
-				>;
-			};
-			...
-		};
-
-		ocotp: imx8qx-ocotp {
-			compatible = "fsl,imx8qxp-scu-ocotp";
-			#address-cells = <1>;
-			#size-cells = <1>;
-
-			fec_mac0: mac@2c4 {
-				reg = <0x2c4 8>;
-			};
-		};
-
-		pd: imx8qx-pd {
-			compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
-			#power-domain-cells = <1>;
-		};
-
-		rtc: rtc {
-			compatible = "fsl,imx8qxp-sc-rtc";
-		};
-
-		scu_key: scu-key {
-			compatible = "fsl,imx8qxp-sc-key", "fsl,imx-sc-key";
-			linux,keycodes = <KEY_POWER>;
-		};
-
-		watchdog {
-			compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
-			timeout-sec = <60>;
-		};
-
-		tsens: thermal-sensor {
-			compatible = "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
-			#thermal-sensor-cells = <1>;
-		};
-	};
-};
-
-serial@5a060000 {
-	...
-	pinctrl-names = "default";
-	pinctrl-0 = <&pinctrl_lpuart0>;
-	clocks = <&uart0_clk IMX_SC_R_UART_0 IMX_SC_PM_CLK_PER>;
-	clock-names = "ipg";
-	power-domains = <&pd IMX_SC_R_UART_0>;
-};
-- 
2.25.1

