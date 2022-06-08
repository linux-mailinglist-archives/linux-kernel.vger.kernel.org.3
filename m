Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00EE8543970
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:51:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343537AbiFHQuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245758AbiFHQt6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:49:58 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50053.outbound.protection.outlook.com [40.107.5.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488B5AB0C4;
        Wed,  8 Jun 2022 09:49:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=diV3nzN37U2UohDdVp1yd/EMvzblHZvBwgUnMI1zkUuW8FQKRN/s4U1wy0UNymu1njn+4HCiEERIzxLwRshMBz2CZoDCiNzUOyJ3ig6vBonItXLEv1Y4Ll8AOZL3xuJn2i2JyWcJ9++qjVsEpdSY9KLaNJB2PYQLiQ6ddzU99PeHfk0vdkKma2Mhx3Vy+y8Us4AICePi7PKKxQlPyqE+w4BeRtb0wYhXLAjTo/WlwC46RC72Shnegx4KptrFsrqFpM3WoLEfi9mjUYa9xiy1+j9eRqTK5+irQmGSKmW6Vccp9Ph+zXyDtWZeSsT0rTpRmYD7Kw+z5F8rkdZqJVOw2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/jjg3K5v0WSE2J8m/Y3v2eR7oDfTSjmHxe8VzKrK6OE=;
 b=Xuqt2YA9jTyIcdaVnXKEJ1LTtF6eipkk6eGwGGXJyGTmiNUCnNlqIx/NK1YEuJLKhO75fqRfDmPo2Q6/xUsrswNhmNIC2IrbhbGqRmlgfqVUWIN8sWTvk6JZcdQfnT6MpMjyGW6wJ8wUiLvYlh0Ox0o7dkOVwm6RSkMmIf/fSQHFDQSuMpcMcafs4+VdrDY0IT2VOFTvuwqcl/sdF9co1Pvoj4NOw5zS39i9YCIq35AF5jrZhkrO2ER5zNNaxChTLMJBTTv+Le7DhdGbx38X8WymwOjgjj3HvvWD3E78S7ziyMc1KUA04r3Ff356Me8JQ4wCoqwghZpPxEYiS+nF4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/jjg3K5v0WSE2J8m/Y3v2eR7oDfTSjmHxe8VzKrK6OE=;
 b=mFnYjvUkKMJKckDOQlkDrWol3RDTnioGVWGADUxv2gKJ7u2bm4LIrsPtFSlUkzX1GQb+ijmhIYuLxG+W4TMCG2l2w5jHj9Tk+NSp8mkxrXLSUTzn9TRxJw6hd0uT5nKKZI89UoCtfyYlyi2f8e4aylSYe6oFKopGUuLVfg0/Hmk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by DBAPR04MB7431.eurprd04.prod.outlook.com (2603:10a6:10:1a1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Wed, 8 Jun
 2022 16:49:53 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5314.019; Wed, 8 Jun 2022
 16:49:53 +0000
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
        Guenter Roeck <linux@roeck-us.net>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk@vger.kernel.org, linux-input@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-rtc@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH v2 06/10] dt-bindings: power: Add fsl,scu-pd yaml file
Date:   Wed,  8 Jun 2022 19:49:24 +0300
Message-Id: <20220608164928.2706697-7-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220608164928.2706697-1-abel.vesa@nxp.com>
References: <20220608164928.2706697-1-abel.vesa@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0701CA0052.eurprd07.prod.outlook.com
 (2603:10a6:203:2::14) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f256072d-3128-4c06-85dd-08da496ee913
X-MS-TrafficTypeDiagnostic: DBAPR04MB7431:EE_
X-Microsoft-Antispam-PRVS: <DBAPR04MB743133D3899DEDD1D6BFFE49F6A49@DBAPR04MB7431.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NnZhSa0vJuyx8X0DLBt3+ajCL4QDiH+UjAtDvNxp//xlKlE203JoobqVgxEov5HxBbckYUmI13wQEJxkJEubCdNgpnxSiVTr0ntGgsvLqRSwOHLbDc0aTUUvXmB+X896KoOEMkhyh/3LVo7s7U9maMMV5lpoY+6lgFzxzQgg/IJG1xpBaatMPBm1ZAyttjp1LnV1F+y7o6+J4tDWdTjMahQjh3h1UOvHi3u1xxAsF/JW2/CoMwttU0fZTVJaPdRmkcMv3OJzK/f4rFSjjxzMecjGY9WN5Wu997M/kwcF3ZsHKWtBdpFlB0WYCf0uiiOJrlCErUXCW0DlqVJU5pmtp/um/2pl0Z5lgHAgCA8agFgNlRtyU6cD2uZoLUnllBOLlNQ7+wXbPHQvfgwc/rfa+2LUVDRyUb4F3AOfBvBUkObZh0/EpsREUskQT52L5Pmc3Ff7FflOGiOKlAOoAAcnE6enZSh9OrprywLEa5omsPo/sKhWWdMH4RMqZwZg0BBe+4Y/4pf4174aPrlMAJMXX3My781ENYXOG5oIRyF6T8zyKzj/OfzkYi4hD1x26FLSmxJQZoivWQ8F0mg4+/Rwl1ZhJSHQ13Npc2/LFTrD3MngjZaQAJ/GpR9/TzDqpkvqxUsx/lg1Uxu444F/xeuKyP7EMYacmmqyOFNwckPiuUB5+ICXE+uPGrXz36KLgA+nXiXUP6vEdi89CjdAoMxS5BrgE755LvVFlrQ56TZfUcOSZRxZWjfOoNlQuEn0mLOysSUiBA5tY1rR1xpcIdfzQXLzQ0LLguaroZi6rnNAJiVjOlqZRaiAdY3l4sMSnA4lsyKLazGjfg0YIQhuZu1TiA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(6506007)(83380400001)(66556008)(52116002)(38350700002)(44832011)(4326008)(110136005)(1076003)(508600001)(8676002)(86362001)(6486002)(966005)(186003)(2616005)(6666004)(66476007)(38100700002)(2906002)(8936002)(7416002)(54906003)(26005)(921005)(6512007)(316002)(5660300002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uRj4K11561KP4nyjts0BHDAiiREaCtQ8sdUiBf7UKMB0zAPVF8qwqN7L5l1/?=
 =?us-ascii?Q?TX12JW4vMKh+cZ6hoPxVZJjAUQljcYMUVmclmi/Xwlf++hNEkFWmxsMb1M0C?=
 =?us-ascii?Q?VY/hm4RVXfkdRLPwgMf0oNcMjY2Vr361N78I0RB6lbhPlHeibVcePJLErp5g?=
 =?us-ascii?Q?/33bl2hjDRlBDaP3oRXDsL8Ii5MBdEUH+Qm7TKzipoPKYQ3GyZahjb6lyl7/?=
 =?us-ascii?Q?MdJPS8Rd5zCpxTrpAVsmZ2fbrtJ4iJaoSTAPRBNnsZ3PvNtH6PLmK/M8eZ0i?=
 =?us-ascii?Q?X67pshlsBoT/HdEcJ0faJeuJqWdGzJ42V/LfDgW19AFq8wdCvfNsbTJNJJAy?=
 =?us-ascii?Q?N5VP/DESpl/l5MHZNJ8uvK/ce1qhAuPpIYkStRsced3E6ouuaLqESWG+2v8l?=
 =?us-ascii?Q?YoaE4eWlYn4JRu36Mfs4afWWsUkxhsP75iZo/LnbD8emvChD2QBRYWgntIHS?=
 =?us-ascii?Q?FBih4yx+Xw3DDf8qaze8AdZU+8Cd1YtL1HQsqBdjuMEjZO/ALhjvatcd01c4?=
 =?us-ascii?Q?RKbg2nmAZy4PF4Wwq+ivkW1SyIRwa0ETwr/kreuYZoCf5ucJZssRyoFF73BH?=
 =?us-ascii?Q?36Ryqg+7MksZr+Oz0/UECOPnob3/FaeJ4zAgrouHAd0g/4oZyOXrCBpwFnZp?=
 =?us-ascii?Q?VEDDr+czdx3ElG+nlBFw/NGv9CQZcMnitL+W2WUHsiDamZbiAxF8jdbGuQ2C?=
 =?us-ascii?Q?6r7uiNi+jHZCaxZRHlVYbbKd8BkqsnwpMeX+qTpYgbWbIgyHQ4y6sc3CTUeP?=
 =?us-ascii?Q?CzIJRY/L41IbfS1ZrjF21NxTrYef0NDm8E6nZWuJq7u+TbU+FQyfxfPQxO9/?=
 =?us-ascii?Q?/sAfSHQABe2jyhNPSKbpX/+5Fce+1zn2lNzR3h5fLpFYsC2DrDbG0HNAb+xu?=
 =?us-ascii?Q?GG4vu5kpKQvutsb6ROL5AeRl6pA08G4KXAv5NnnMtjEgHL4mTj4JNKCr7IHP?=
 =?us-ascii?Q?IPWqxNTqWqJz7SoSwUAlb75AI4XvILGiO47A6sWPdio42swvhakwz1XhWBKM?=
 =?us-ascii?Q?DjNVR4/0lUvJ0Kdn0Nj/h1sz//tt0XNM5U+jFAqzBfbiWgR4mjjRElqZtjH4?=
 =?us-ascii?Q?Bg9pbgNA34FQOAOz5P4fz5iFNzGbOMln0G7A/mvMEHWeurNuREzv9ZQOfNYy?=
 =?us-ascii?Q?9DE4RUSF15CtMMzKti8OjV72l0a6QVA00I60q+G+Ukc6y3uzE4bzpjFiCGNt?=
 =?us-ascii?Q?gmL1Wx4Lkaw7sHnNpc0ViH1HteMKKEbLLe183SBPaKO0Z8JDJtGIBMgyTgqY?=
 =?us-ascii?Q?BYxAOv3lADLi0LEP1AUV364id4L9NE1963uaPpu/cN5GuJLplNlEaPXK2XqL?=
 =?us-ascii?Q?/YOPz+bc+Vjb+4w1gIGgEOr3G4TJouTUN0YV4CZYn+70kjAsVYU709M6m4Ll?=
 =?us-ascii?Q?nbeXJ2mDWz6SXiqg8uo2+GmdczAMkEeYyDBLIDh3QC4ORZXwDivXN3STk43B?=
 =?us-ascii?Q?k7knCmiykAAwVzb0mcKtRjsSD0Pll0dQsQL4sP1p1dDC46qJ+WlEgbdxz4lJ?=
 =?us-ascii?Q?mJEYSeLHX6xIYFrWJKXQlOlzAv9ZLch4dXzInmkPVZemXcjyq8PuwOOkITAZ?=
 =?us-ascii?Q?BCZch14xATIB2ZIDmJkskBTDEfWY4bUsHayqNSn/iawjCApKZEzGIySQwBI5?=
 =?us-ascii?Q?M3/nK59GipFKrZQ9NmHS/XT2RHX/Lh8uaZsu9kUkHPvNJ4DOxPfKztPL8TXL?=
 =?us-ascii?Q?f8Tdewo4qfKJsAZrPqpOERig9L1cd2rd/FBV6nDW+8TQuN1b2XBN1qsKhQx4?=
 =?us-ascii?Q?Lx1MuFv5Nw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f256072d-3128-4c06-85dd-08da496ee913
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2022 16:49:53.4134
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rm+w1jwr/bI6QRawDkCbtq0XPbRSBRZPewpOAJUU4QKU8qxkdmcRarBry7VYJxhBBB9hFjp3viyRfXl8F0XRMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7431
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to replace the fsl,scu txt file from bindings/arm/freescale,
we need to split it between the right subsystems. This patch documents
separately the 'power controller' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 .../devicetree/bindings/power/fsl,scu-pd.yaml | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/fsl,scu-pd.yaml

diff --git a/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml b/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml
new file mode 100644
index 000000000000..aa3685cd15b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/fsl,scu-pd.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/fsl,scu-pd.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - Power domain bindings based on SCU Message Protocol
+
+maintainers:
+  - Rafael J. Wysocki <rafael@kernel.org>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+  Power domain bindings based on SCU Message Protocol
+
+allOf:
+  - $ref: /schemas/power/power-domain.yaml
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,imx8qm-scu-pd
+          - fsl,imx8qxp-scu-pd
+      - const: fsl,scu-pd
+
+  '#power-domain-cells':
+    const: 1
+
+required:
+  - compatible
+  - '#power-domain-cells'
+
+additionalProperties: false
-- 
2.34.3

