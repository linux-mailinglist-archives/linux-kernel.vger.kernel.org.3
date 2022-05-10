Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B20C52159E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 14:39:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241869AbiEJMnL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 08:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbiEJMnJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 08:43:09 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80054.outbound.protection.outlook.com [40.107.8.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B0F201339;
        Tue, 10 May 2022 05:39:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuI8L0YCiWRYzkxyT62muxhFTRXf7xmRgRoVVW05ZFw5K4p1N7/yLcCFe9ZJ31LJQydM5oFj/q7NpHHhZ2f8EMrNOXuFdht6tm1uvoSrgee0BECz1gG7QB465KdnbJc2NXbbm2gQFxCOFVclp5+ddN7q550Fo8Zk4qPqGZ2sGex8puyVceilG2/uVCFk1ftGDHAhebxjQJFA29NImTc/QyVoTpkIhh5ifLIncW25ianAMYNaJPaknH3Gwj0h/TRxNUpJKhRbyBuL0isQlNCDL5nd4r34XijOaYAKSOD3bYCIuj/xIZJYoos73GZlSE3HrcuH5QhKYIlv+1GU3NGq/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dr3UZycArmsj5X0VvocsQIpenC9GJJddG0C8+Cw86gk=;
 b=lnZeop2c57ZzeVhz9FMtwUftAmIFW89Y5qqshpMJZXJL6S0ikCPYsqMcYMckJFx0Y0+nqMl/WlrMOwWrPcWExfnwocIBX/38kLf7XidF1D6u9yjj4v+FTAsH8DXZ4/utposV3TeAC0sO0pjsA3pCwsrrdlXGhh+e96+6AbbbEDVSoYjjdfkb9GLihmBpM4E6FiCl14g8tYba2EaeHq8DciXjsp+JO7rKHHcjBZwim1l7ldZ8icxAoCIddMDKV92Se6bkMqZxjTL7ERLznBEEUk6NdySAILz4RD3otpcIpcUwtBdqwuL6lGJihvyDI2G0QUhxra0sU/IG034J3YHKng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dr3UZycArmsj5X0VvocsQIpenC9GJJddG0C8+Cw86gk=;
 b=W04vntCNPYzayIALLFmOxxCzi+Fvpa3tSOewjrCiQINxI7brl3p6AB3qUmZQrZhWjdsfBiR4AahjubHWPmMiYYKK8CycJxbNQ1rMS1tZ6dvz79jqRYhz45olxaGTZRuk5u5ZDNS1lzEtv+4nCkw4L/3kStdtUF3YPKpvQqX23MA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com (2603:10a6:102:2ab::21)
 by AM9PR04MB8937.eurprd04.prod.outlook.com (2603:10a6:20b:408::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Tue, 10 May
 2022 12:39:09 +0000
Received: from PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::c9b8:325d:8250:4fed]) by PA4PR04MB9416.eurprd04.prod.outlook.com
 ([fe80::c9b8:325d:8250:4fed%4]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 12:39:09 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V6 0/4] arm64: add i.MX93 support
Date:   Tue, 10 May 2022 20:40:46 +0800
Message-Id: <20220510124050.398891-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0029.apcprd02.prod.outlook.com
 (2603:1096:3:18::17) To PA4PR04MB9416.eurprd04.prod.outlook.com
 (2603:10a6:102:2ab::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2fc6add8-2dc7-4019-bf17-08da328213f6
X-MS-TrafficTypeDiagnostic: AM9PR04MB8937:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM9PR04MB893722754EC0F582F63A44DEC9C99@AM9PR04MB8937.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /MCviZ9OTSNxajVwLjVIjcan25Z+tNfDzfGrlK9t08kBvrY/SlPcXllXi/tSw0RGP7TJlKDRbd3Ab26NW5oOCPLKoXrcjXlalytZLMSLOTBJinFqUNQ5VMzPqckxGPvXfa5lfjodxVwprwJ1+WBoRwFTCYU6wyd8HiDyfbvw77smqvSFHlpC5VxtMBzBvRWALAnqZRk1PMCu/aCIqodQpaugswh71cyiQM+lZDpp+gg2nC1uwNWxr5FyhwAkzHweFBEp+/650mrkWPevXGn4JiQ3BX/piIR8pnmY2pEnH3IkfAk9OIP40t2bD9iRKPyhzAzhWwBjVst7HjCv5vKHBk7R2b0PDVgrFdFSg9f4rDeMME98kiVNXuUL6Mh8/No1vEWLqyedvVV5MBTtRG7OFDFCjHDeSIxJVHmNRdjm+Uo9m/gTF/XcctSsWozMkl1rRKnjx9rINfQx64kRKE2tmqHz8VPgsYAq+q6Jy4CVNzJhWiJTp2IvmmB9zYwRWD6JLQVs0lKl+CITvT/Io927SedeF2bxexTjP5YAOTnN64B2k6Fx3TSuh6HCIEHkR1ws9tq21G0tjDtMcgIOY2/OCYhcPz0AXbs22mUtNWqRvl7WHrfoIUD5e23tpXGm18tGscj9UQ2EH0Wta+cCsBVOR5yIeNKPwXVHrrv3Ju5Gm3k2hf+BndEbliFOKyyZ6pnDQ005pliQUWKw2wEfWqnLUw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9416.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(8936002)(2906002)(38100700002)(38350700002)(5660300002)(6506007)(1076003)(4326008)(83380400001)(186003)(508600001)(66556008)(66946007)(2616005)(8676002)(66476007)(316002)(52116002)(6512007)(26005)(86362001)(6666004)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7BBCUNeb8/jndcTSuQnXsDo+zNkMUC5tPI6t3N28a/0anamPVLeOCigyTTr4?=
 =?us-ascii?Q?sE1V5TVqgbZsYfwdaJAzI5/FL4E0us+yAGyPv9H2JyxBJxUq7DAPwXkguPDl?=
 =?us-ascii?Q?UImFgbaAs46uANC+EXkqXc0E3xB6EbcNhK8gCEKn8dwc5bP304WmVvt/05L8?=
 =?us-ascii?Q?HfxoQKgsi3+mOvzbgBFen82Ta+So8Ng6MilHeTTx4AQhhBW9G2wscmTLdmv3?=
 =?us-ascii?Q?9aGjhHFThu9z2LZI6IdDZ2XUmaq3QA/Xs6AVNzd8ommc7tKM95I3UzzC3ssd?=
 =?us-ascii?Q?Z8/IbAlmMbaU9A0w6Tk96BvRhKgXfkcb5SmOgXJH4s7+MJ8iwGyfbI0P3eXX?=
 =?us-ascii?Q?onk9Zk6v8yVVu1HZXdbSk5MQ5hCXvIa/MAQGeG6wJjpocIBwdIj7hXCK7lyC?=
 =?us-ascii?Q?pZlWtdX50B84PwoESF7zDmZtT5oE5w4fkA0MrSfEBng1jYagEhMAsJO8sl2B?=
 =?us-ascii?Q?RNklGtIDG28wY0z2dSSEnpRnIT0k2/vD864/WvW9nLEUlVjJ2KhTCPKgETuU?=
 =?us-ascii?Q?sW6IG9o4ARNNstiYPZ7NMtFH5jngZIV75edxjlxpNCsvOQQr8ION6OxBZiBV?=
 =?us-ascii?Q?2WJjWifwTAlVc+6Ev4ya3kLwJUUBWs26R2W7MOBvzFY87TOaikVtuTrfuSnN?=
 =?us-ascii?Q?lJQu9GWWlhoTWzrE8IxeplGEzB2hgVCGbSdMVU/85EoT/1ixQrh9/Hs3PK1+?=
 =?us-ascii?Q?cKz0sTtcvND2GL+koHxXwsy1Z8VY0fvv8rapZGskjPYRw8/YtVd1bg43MQfE?=
 =?us-ascii?Q?TuEYwrbo40MfFp6HcaK55W3QzzRJnsq+90vgX7vj2o6JRFS8bHCr1FRAE4rH?=
 =?us-ascii?Q?3jK8Ui+rbA+V6hXgPC4xOZm/ylHsZMke5+S50s8Yg46Jmfrdvb2irF2ZnoZh?=
 =?us-ascii?Q?xE/0srG9COs+eN5Y0oLnuTKqFf/ZgzLaCsD68irEIWBBU7VMFPWzAnIosHgQ?=
 =?us-ascii?Q?gMpS98EUPHKSmmSEtA28E2c5jqhti7h1UFe8dFhSYo+nMdd6lPTQzi7YZd/Z?=
 =?us-ascii?Q?9WQz8JTPgHqsX4HKD2iRqUZQ7XmcCb77UqFQy97YnOh5xqcyNMdZ9UAkmHqp?=
 =?us-ascii?Q?iQaDm7upbzTNVEhnhd8USOKdJi8qAmO3BnR7G6CgH8+phFEgpnp+1yMfmO1m?=
 =?us-ascii?Q?IlOtk371AtU7yQ44dXVx6KtptihiXBCuuwHxXYlcGk1+Z40kuaFeCHlBomtI?=
 =?us-ascii?Q?N7vS9OhQ/vwBt15fu2lX3/HWEzKVO/dBagCIEEAi8vXyAL5izFDh07NC1tEG?=
 =?us-ascii?Q?yMVZNPah4+kSIftRWR2AJMUWmKpsZdA1NSklR3lrjxS/SKsS2YDFMYUuYxHk?=
 =?us-ascii?Q?maqhyTI4LUYWUod1KdAdEzpPMJCk5BiYPIuA9rDriqo97Zb0TmZpmZpLurLm?=
 =?us-ascii?Q?2Eyh6YAg7JHlflfTxlIGidv6AoAuas+3QenaPzHbekI6sXuI6limYjf8wXK5?=
 =?us-ascii?Q?ezzE6izPc56UKAstbWZgE5k/3qIQX2h/44ha7uXBo4opytdIth3cKTyCY5xs?=
 =?us-ascii?Q?oPEwhRkZqlgGZbOpRmDC6vJlZjZV2+SicbVRECrH0QG5jLpAxmPaulhyIpRM?=
 =?us-ascii?Q?W87GE0WJHSPh+i0bB2sV+5Bagm08C2y5tw2zIeY52UzDFDrVMr5ukMjglKu9?=
 =?us-ascii?Q?5RxbiuBk4ieR7/0mJQNPl24ovmuTOeitgRW7ae1NuATaYnuaMOrjgQlb8Co/?=
 =?us-ascii?Q?SClM2gDbBuNsWWw9EvPBkEaOkya0ueOUIlXcPT7NIRG2DX3Od+H+2/G21Map?=
 =?us-ascii?Q?4MS0cxHTGw=3D=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc6add8-2dc7-4019-bf17-08da328213f6
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB9416.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 12:39:09.0608
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O/S6wrNTaQwlY0o07wJjW3y6zAj/g//vm9tniwOvGTrj7PpaBwcKDs/ojJMN8i9QNPH8KnAnIzkZWoDapQXJlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8937
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

Sorry for sending several versions in short time, just wanna to catch 5.19

V6:
 Per Fabio's comments, drop unused uart2/uart5 pinmux

V5:
 Add R-b from Aisheng
 drop iomuxc status from board dts

V4:
 Add A-b
 In patch 1 to move imx93 behind imx8ulp
 Drop a whitespace in patch 2

V3:
 Add a new patch patch 1 for board binding doc
 Add A-b from Rob
 Fix dtb warnings.

V2:
 Update License

Add i.MX93 dtsi and 11x11 evk board support

The required bindings and drivers has already been in tree.
There arem checkpatch error for the pin header files as other i.MX pin
pin header files.


Peng Fan (4):
  dt-bindings: arm: fsl: add imx93 11x11 evk board
  arm64: dts: freescale: Add i.MX93 dtsi support
  arm64: dts: freescale: add i.MX93 11x11 EVK basic support
  arm64: defconfig: enable i.MX93 clk & pinctrl

 .../devicetree/bindings/arm/fsl.yaml          |   6 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../boot/dts/freescale/imx93-11x11-evk.dts    | 114 ++++
 arch/arm64/boot/dts/freescale/imx93-pinfunc.h | 623 ++++++++++++++++++
 arch/arm64/boot/dts/freescale/imx93.dtsi      | 334 ++++++++++
 arch/arm64/configs/defconfig                  |   2 +
 6 files changed, 1080 insertions(+)
 create mode 100644 arch/arm64/boot/dts/freescale/imx93-11x11-evk.dts
 create mode 100755 arch/arm64/boot/dts/freescale/imx93-pinfunc.h
 create mode 100644 arch/arm64/boot/dts/freescale/imx93.dtsi

-- 
2.25.1

