Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 475BD544F44
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbiFIOfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:35:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244046AbiFIOfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:35:09 -0400
Received: from EUR02-HE1-obe.outbound.protection.outlook.com (mail-eopbgr10051.outbound.protection.outlook.com [40.107.1.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5847320C16;
        Thu,  9 Jun 2022 07:35:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UUiVymaVL+QzMvrtSpnV8zQ8NmRrYTKWslPyoIFiiwMIByMgX2OvlsL1yJ9D2PqKACUG0twKgFsfUjRXl6lAw44Q3uMM9e4Du2fsgmVLqplJgQ4O+sO5zobQ0ey2BrQJn4Sn/Vk91B+1fgE0sI3QKpPvR6tsiEPvHhmkeWluJOyCJ7gs1jgD1JYqgBvYH2La0OooYgICfp6gep3DMQjvORa+aRSesqc92vo/Jhh+SnvOx9zVtsByGrbjgvE++yKzOBWvv96oJtBlUhCdmcLCq0BfzkDjT2utC/AgXq8tfHQ173U64K+JZOcgxvVV2/VD43mMUwAn6LYuLZRDsfDX8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pHDrkds/A+nBiHt6mOqHRuyguWyTimE9pQLhcf0mdHs=;
 b=ms6UyGIitnteKvuTNQtkuW21qN4jD/C9t9+CWLwpB69PTnoCPVaqAukOWheSnAPluG9bCrky/8TNC+bU4ONcty+/h/64HsiEI5E0gl3KkMD/0mTHgTajzhko1Hb9ec75jiA8jpznWDVZ2mBB/zbKCHVepa8vUcsUSlBvQHSnCZLdT6DWo+oO5GoRBYeculLMp1q5wy4bB1nlyXthF7wu769D4i2PRzaUj9vWoETTin4Q3euO+rPlXG1Cr0qeX0S29Up86PYeevCt0FuWcP870fea+3RMhp1Gi9AT8Qi2kLyee2Fw9ypACwsly/wT5J8XamRfhSZ4QOyPL8/LltZ91w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pHDrkds/A+nBiHt6mOqHRuyguWyTimE9pQLhcf0mdHs=;
 b=n4DUBHWvPxudadcjRSLxYNJTRzSDILMlcWVe4R+gP6HNTVc7b5qaC49wv1HGSsH1QIvedh3xPGDrvFjnM639srChVQfacFly+TcXPl10ZcDu+H/pn4dg4OIj8LNtsU98uSGx3KX53zWGPhMq4k15xwEBlT2cWICOn/LPDhCkLss=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB5885.eurprd04.prod.outlook.com (2603:10a6:803:e1::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Thu, 9 Jun
 2022 14:34:47 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5332.013; Thu, 9 Jun 2022
 14:34:47 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Guenter Roeck <linux@roeck-us.net>,
        Stefan Agner <stefan@agner.ch>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v3 00/10] dt-bindings: arm: freescale: Switch fsl,scu from txt to yaml
Date:   Thu,  9 Jun 2022 17:34:13 +0300
Message-Id: <20220609143423.2839186-1-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.34.3
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR07CA0042.eurprd07.prod.outlook.com
 (2603:10a6:20b:46b::29) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ea7c6e42-12cb-4a27-8638-08da4a2533ee
X-MS-TrafficTypeDiagnostic: VI1PR04MB5885:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB5885AB87BABC92701329331DF6A79@VI1PR04MB5885.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k6VEfJt0LlUYvTBFYP1LlcDOmOW6wpYsIKwaIYw5rqx7DSagATcdFhQmVCXFx7t5PVPltC1ku/ou1do2dNjfOxqa2g6yrGHTNS1ZmLcHLxdnqkvdx3k6Ns2u5CZGoVrC/FHYL8nr1Z9hCNkY4qUvDhUfbsxFaTy0SssHDgWTyMP6a/JLcpeezqlgpuD7mfWEFqLdaU2aujGLE58X7TBfzL6sa2aJeMaO0nmXTEGaNtiPmd5fyAvEeVMivw8FdD8oKEsQyrLkdMGAEkCUuHdzbvzKhfUr+l49eaMqhYY55UFNmnQor8xJFbvFTv1Fb+Ro/vlLyz3AW0JkEbn/fqp1PbB6O7mzBFrCu3RgLZcf+N52GF69rwqWrKUbY4naZ9RF7ca2WBAIvDlnuTobKNFMg/4K/PL+WmVaXNl5YFQbiw0UAdHSRDRMovIhlbdPBEkPU8smC1oPWwvlPL09Y2FVYoVpe2RpdvpCmOB/G3o6/a36iE9SNHekhyYaWMCMcBlMsbbU7ozXpPKt0uV8D/C27q9pZz/AEpwWcJnsqOy4iT9dWeRA3e2bYuh9cECGICqXuVGlilZcSpr2mGHpV2Ud0RhuF4jxUPCHiQdOPxm0DNSC7kHgyHiDyrNxVXK8C4ps6a1J4k5deboFrs7W4Q3K4ZieLpcPXt+jJttqn1+JEQNAKcoU0rcPbV1zUhDxnKt0qybE8G9WESmn2YiZeTpTFf1kyrZNgwtQ18ODHYspRBNwtw7kuxnZmYLXx0feePPUIaTnHW8zWKyCQqjsKXqd0DAlHpInikInduHmJYf/ImdHkqjGsi4stRQ9TrzkzvVk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(316002)(36756003)(54906003)(110136005)(6506007)(6486002)(508600001)(2906002)(966005)(7416002)(38100700002)(5660300002)(6666004)(86362001)(44832011)(8936002)(8676002)(83380400001)(2616005)(186003)(52116002)(38350700002)(921005)(1076003)(66556008)(26005)(6512007)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Tx1e3K0qw5ORhuh1HcWcx1UiTiHwjX8daDQEAbsb8EBQufE5L4FK7RQagwU8?=
 =?us-ascii?Q?MRD1ZWVXC46Ah7B3NsBo8oWGwvZ7C9MCzDJzIziFrhPSNP4KuW54h+M9NwO3?=
 =?us-ascii?Q?LftuIayD0VIIUsmCQe8rzQjEO3Y/CyUkjwJzfDO2H2YhmBCmdeBWMV+eHzb+?=
 =?us-ascii?Q?d/lnraTeOS2MCb9RwgPW8pRmeT6dxqS64IquyIqJXESRv3l/0aRTpGIcZp1l?=
 =?us-ascii?Q?iWFAJoBgaCzbvkMZr8D5YMY+mbwoeQOXxOEQnJrG6LxpZ6GXx7TIqOTAHXdf?=
 =?us-ascii?Q?5zUDRpN5zFV0BqQgNNWMyinQ/QWhy3NT7qTP4GmlRXXgVq4lC36ZrRErBRrj?=
 =?us-ascii?Q?Wb5GFNVg12DgUyUsQ4Q6sTeJXc5zTYwO/HuZifDfX368jC4A35mFFTXn5MRV?=
 =?us-ascii?Q?9AZMoflKp8FiT3nM3Fc8CO+Pd7fI+7phNLouZkXfpNzT5FWWkioMTkgskssT?=
 =?us-ascii?Q?xUp6YNI9l8tUsLFhH0o9uy0TFJIxjAk5kAVhEGcHLStO70BVk4I5tzN74bxu?=
 =?us-ascii?Q?Tt4hlsKi5fg+WjbOG/w8KBiMZCnKD6jg7buVlfKvYnteCiG1OXHJOAP9bfjJ?=
 =?us-ascii?Q?OFt3mpFPz1HVeFqL1QmzyOwqybLh1Ck/9Ze68nbRH3lrNRBotQw7nfHO8y+5?=
 =?us-ascii?Q?49PJUjgvqJ+dF+l/d4siQqNfnht0gDQBtUao7jqBs9iIuMyLULXNN5+ofZvm?=
 =?us-ascii?Q?6+Mvy8fyw/pjsVJoTpUNuJlBiymLk5mljUbRSllo+W+IYA66/sJbUj+bMuGl?=
 =?us-ascii?Q?LPVo2tzYhVqIs/Vnt7IknoAuakv2J1hAkiI4Y/XbeDNvEosSbf8gwiN6+Yyn?=
 =?us-ascii?Q?KaRuT3TrM/MkMI6gViLXpUo2iA5LVUQwqYBeE0bMTybMnMS6oSjK0BoTJ4dm?=
 =?us-ascii?Q?6a77AgXbmkQ+5ZI+sci1HGbzrkG1jfv4rOvIpgYpCaM/bMu8olQ5S7GvDpXw?=
 =?us-ascii?Q?1EGDKtQbcAl6uwpzCWbrtQW4c3C0nANfX9+gLFwtG7bf1oe8xb8BvU9JLsgg?=
 =?us-ascii?Q?KwUxCiYRtUniRrh/5g0r96GxlFWnYE5ISd/BwRHlfXuJTq9+z5bmPA3YOh6B?=
 =?us-ascii?Q?OxWgtHF1cjUbnZ4rOoluChef+nLwYajFmR7AudgS+rmSRSoygDtGk2h++rro?=
 =?us-ascii?Q?lL0zV48n1ZEXWKZ01/KxADLjxwveimspMczKnC7t8q9fJb88krC2Kmf/FFTp?=
 =?us-ascii?Q?q1qYzSw6aUhOd7WQdeXtUTlseFjBa+btEy9Pc1xl8sbOzse5yga+mAR4jT9U?=
 =?us-ascii?Q?XzW6DKC9EoJHhBPnIxnOHxrwhCyhbJdtFDoz9WPjzZK9BWPbjnoS01Bhbnn/?=
 =?us-ascii?Q?dFY7BkS28U/dAYQJP/lJoN1ZJq2F+hdkTmFPcJ2fcY0T+fcOA5eW2m/ZVivz?=
 =?us-ascii?Q?6KeeJyVs9fuhUr08eHYN4ydgVqpx079Lcy83OeU4zBHjMjk3w2QlFbAnmQPl?=
 =?us-ascii?Q?ytpFXB4bWAv34fiidHfJgoOEKcnmnWky28zCwaCfHbcMPUzigQjtQJV+k0rj?=
 =?us-ascii?Q?woV+feRX0Z48R6EMtRx6x4xQtXwpqvbR2xIhYlqgICcBoO9snu4S0Gyele/d?=
 =?us-ascii?Q?0koVXMVnyg4x8WxQyGqYLmVVn/Nc469YXTI3pGxWGLQ3Ot33D37wG0poEJ3G?=
 =?us-ascii?Q?T/lYYk5z5q6WVJUcR+SRN4/Dz9JcY8VFsue6h0NS6mOAU7BsJcMnfFOAwtGL?=
 =?us-ascii?Q?+8aK7IsjkhPXEjzIfLOx0jxn1IHdxZsb2UViyXBE/RL81l4CgY28Ms21viij?=
 =?us-ascii?Q?aGbNk8eN2w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea7c6e42-12cb-4a27-8638-08da4a2533ee
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 14:34:47.4049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MWg1OFVygtC0oQicU2VcRx3Q0dmA30RsuyECLR8Wti90Q3Jy5oe0zgWB25kjxfWzkp/lDAblycDiLn3luL+eyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5885
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the v2:
https://lore.kernel.org/lkml/20220608164928.2706697-1-abel.vesa@nxp.com/

Changes since v2:
 * replaced all the maintainers with Aisheng Dong (from NXP)

Abel Vesa (10):
  dt-bindings: firmware: Add fsl,scu yaml file
  dt-bindings: clk: imx: Add fsl,scu-clk yaml file
  dt-bindings: pinctrl: imx: Add fsl,scu-iomux yaml file
  dt-bindings: input: Add fsl,scu-key yaml file
  dt-bindings: nvmem: Add fsl,scu-ocotp yaml file
  dt-bindings: power: Add fsl,scu-pd yaml file
  dt-bindings: rtc: Add fsl,scu-rtc yaml file
  dt-bindings: thermal: Add fsl,scu-thermal yaml file
  dt-bindings: watchdog: Add fsl,scu-wdt yaml file
  dt-bindings: arm: freescale: Remove fsl,scu txt file

 .../bindings/arm/freescale/fsl,scu.txt        | 271 ------------------
 .../bindings/clock/fsl,scu-clk.yaml           |  52 ++++
 .../devicetree/bindings/firmware/fsl,scu.yaml | 162 +++++++++++
 .../bindings/input/fsl,scu-key.yaml           |  30 ++
 .../bindings/nvmem/fsl,scu-ocotp.yaml         |  37 +++
 .../bindings/pinctrl/fsl,scu-pinctrl.yaml     |  32 +++
 .../devicetree/bindings/power/fsl,scu-pd.yaml |  34 +++
 .../devicetree/bindings/rtc/fsl,scu-rtc.yaml  |  22 ++
 .../bindings/thermal/fsl,scu-thermal.yaml     |  32 +++
 .../bindings/watchdog/fsl,scu-wdt.yaml        |  29 ++
 10 files changed, 430 insertions(+), 271 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,scu-clk.yaml
 create mode 100644 Documentation/devicetree/bindings/firmware/fsl,scu.yaml
 create mode 100644 Documentation/devicetree/bindings/input/fsl,scu-key.yaml
 create mode 100644 Documentation/devicetree/bindings/nvmem/fsl,scu-ocotp.yaml
 create mode 100644 Documentation/devicetree/bindings/pinctrl/fsl,scu-pinctrl.yaml
 create mode 100644 Documentation/devicetree/bindings/power/fsl,scu-pd.yaml
 create mode 100644 Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml
 create mode 100644 Documentation/devicetree/bindings/thermal/fsl,scu-thermal.yaml
 create mode 100644 Documentation/devicetree/bindings/watchdog/fsl,scu-wdt.yaml

--
2.34.3

