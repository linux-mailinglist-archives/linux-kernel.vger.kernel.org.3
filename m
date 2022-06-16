Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E9C454E7DE
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 18:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378153AbiFPQpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 12:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377331AbiFPQoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 12:44:13 -0400
Received: from EUR03-AM5-obe.outbound.protection.outlook.com (mail-eopbgr30040.outbound.protection.outlook.com [40.107.3.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3BF28990;
        Thu, 16 Jun 2022 09:44:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fj4Ja6xivTc2bP5G9Bf7ObbjmyF/iR3OQi0K9yi4LD3NKtpYGDxVQEsbpumMriKfwNrZppEubh827+0oFp8p1eYE/gUJ3+/jV4DOFNXP0baQ66AayOZIsHo+EFKAtomK6T1jyTTiuGCBB5lW0uW8QPIgXabursJA5SEEY3ZEfeNA007vJe04xdRiqQmQ0p06Im/LF5p8b00JFWse1kRx2Bs5oNKur3MPoZLulw0KXPmDo11MsFxiyItGkwy+N8SmuwG9LpsZ09R1YOqqtEN4gvPjrdH5EOU8ld7fOGFwD6wpjgTXQZT1z1OcxNKOSZbjxXRrX8ZTatMUsf38vXSE1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l5x/1RxaPX0UIG8HgVPFH956p0wIEXaxlqmAU5EfXBI=;
 b=XuyOyKr+vIXspKXw1ly3XqLS+lCrvaNxIY0tvZ4ImnAzzcJGBSyYqRmxnKzT176maCSXn9DOKqCfjeADsfR+cm2l5R+GadZO2/AS5n5tFBkscFmYt7CohutvFVAxrHevnthxyUJjaaQ879Pei1v8NMzwvDOtosKJx3xK83xCnbnJlmVFfYGNO3ENTJ/Vuq/0tP4GOneC8dvRIEWEom1UsD3kJCiRuyqs6usu8nIEGziRkWWuTuBqVJYWBCSnLqUbzbJuHRl98zw/J1dNjYP8ITom7FkywgUEvkH6puisjgmEUpfHZU1t5XR1ndvjIS9NBfwSJQZ6Aicw5jHIENED2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l5x/1RxaPX0UIG8HgVPFH956p0wIEXaxlqmAU5EfXBI=;
 b=SMNxWcslsp466GX9fTjICIWNBqT7/5M2oQrvwCV05Wt5xwoHsPI4/7S1D7UlfrS2Yy51Xh+JI0SapEgPNmoupc2Uf1eg5vVe0PLihCuuZQ+kw83ch9ivfbluRldA+/zEJCy6+YG0gcm5ToqVLoLPBy9WqjrO652XBVNA6xcswo0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com (2603:10a6:803:57::30)
 by HE1PR0401MB2649.eurprd04.prod.outlook.com (2603:10a6:3:85::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Thu, 16 Jun
 2022 16:44:05 +0000
Received: from VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619]) by VI1PR04MB5005.eurprd04.prod.outlook.com
 ([fe80::7505:2581:368f:5619%5]) with mapi id 15.20.5353.015; Thu, 16 Jun 2022
 16:44:05 +0000
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
Subject: [PATCH v5 07/14] dt-bindings: rtc: Add fsl,scu-rtc yaml file
Date:   Thu, 16 Jun 2022 19:42:56 +0300
Message-Id: <20220616164303.790379-8-viorel.suman@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 658ae421-b4c9-4f75-df07-08da4fb76d1e
X-MS-TrafficTypeDiagnostic: HE1PR0401MB2649:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-Microsoft-Antispam-PRVS: <HE1PR0401MB264900D0E8433013D3E6A0B092AC9@HE1PR0401MB2649.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: H5JZctDP1zb2F73fF1ClJkBGHUAzDHer6Yb6DQNPii3tamL/RWO4VeBm1QcLh1Xkk+g/d8fcl2TtOe/33xaOdge8PHLSoufKjrTBATpwse09hAO5nmImGN109EOh2KiVNxe7Xy9F4t2ceuNHiHS2tFS2PLhMDLxAA99IxmnLLRQVh+PdTQjjnnGbwofFXJwFnKigSqxmjQMJv0dwO8SMgljA8l7IoKzxgvZ2AWl5LaPRvzkfqe6c8Q6mMC1jNspfx32vMGf8EZJzsddmzxZpe90x1aZFCJ2FJ9Ubl4TIWdl1EgZjNaxC3MHjLXs8Yxw8X+ZqdnWZ/yMe84R3B2EOGaT1rMk3SsgQXM5ebk/tdd50e/r9Yyple5NHFPrxB7ekr1NV3DZSURiN09VNTO33WjUWYKxegcsuiGy7zv5ELBbW80Vq30FoAmna6QvNU1YrGdnARf/7YOHmnASaAK+2GfXg+6bYNf96mfBetA9Hu9Bv9jTcYNEFJNfZ6P7klig99Yuk5plA4DmcZCmE2wNzANbHdAnr13Mc2jEO+wY13Qsefg1YUnUkK2cNib5IVd2cCajWCP9NZn6yt5Fk5J2kdv57eXntWQY0kUnGNCNp4kUDYA6cTOfssfsBXumcD/Sq36A99bXSqKSqj20rM5FKYfN5Um2msJ17ulnwCy3EaAz94U2IKsNrREEl1asV+GmcTvu7v8IfGamycZXBcWm8In4X0Kut1aPEDw+cuV6pDQvC1u9KTbXcdobSUJaHNhkyMYFs26kGGyPUVuopymGoLMloi+VOdWgmlowBxkkEC46tTUkTZSVJbRTB11XeYTRQV8JxCpYZubnQquY7e0VfKLVA7dFxPa4XkROKNljoECA=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5005.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(1076003)(86362001)(186003)(38100700002)(6666004)(5660300002)(2616005)(26005)(7416002)(6512007)(66556008)(7406005)(2906002)(83380400001)(66946007)(38350700002)(316002)(110136005)(52116002)(6506007)(8676002)(508600001)(44832011)(4326008)(966005)(36756003)(6486002)(66476007)(8936002)(921005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?5vXGTWz6uDqHFqByQnfBsessK8Uw5yVOUHtKUIcFATSoC4iwOeJFtFAR5J?=
 =?iso-8859-1?Q?ksI4l9qWFq0RFJGkleb8Qhd8HByWkAIqUIgQr+RVqab5QCZqXSa3xnECN5?=
 =?iso-8859-1?Q?OT8BxgUusXloVVAzvhOwl46WhW1B5+eoGApjxxaQ7zLX2zUTJf631p4wLS?=
 =?iso-8859-1?Q?Ygza8UcWZDMx5dfkNSBwVphNXHVycFvCp6BNieaNgX6QbwUEhfzB9Lrqqk?=
 =?iso-8859-1?Q?4Qh+mgC5rKmeSXCjgJUoECooBB2VOEYF9ztR/oAvphHrQrQx5KZx1cbo8A?=
 =?iso-8859-1?Q?OLq/tQXFxs6fC1DeQ6R9Vd4uQ21HIWsZWnnMruyH270SCQ4evi0ta3kN5k?=
 =?iso-8859-1?Q?ua9Hb1xoqdgylCGg+2fiW3YGFWEHjHDAza4Rp592L1R8ehGAyIl93WoWEp?=
 =?iso-8859-1?Q?blTf5NUY8tCZn+Lf9w+1x39OGyWjm2UMSokzSi9FtLegv523HpJh7Qj6H9?=
 =?iso-8859-1?Q?gX62IL5Aa/XnuKCL/XrQj1Q3FNG4ujbEekvIb7rPkb9A3aLiDK3DUUxKO4?=
 =?iso-8859-1?Q?fUgGJyQDsQzOPdzmpcrg+jvd+rvwQ5B185B5i2pw697sxURaXiE4LJNLPE?=
 =?iso-8859-1?Q?TKkwCDhmSl6QJCJNnELKCMQr6j0i53LW8BqIegx1zP+a0Wg5RTeg/K33vs?=
 =?iso-8859-1?Q?UhmdMIGkW7Ie3G9lT6ztbd818uOfuYqk7ORh5h8cRIFB1BZqh/QtDRrX/R?=
 =?iso-8859-1?Q?i7RvzAGcnURERztaftmxXa0XmEnRrBOefvMp6djUaifDyL75zn8TtKASkq?=
 =?iso-8859-1?Q?yyzbDzFYECwyjsXpSFQnyigg6iCRiIlK/dsTrC7w1/rsTA7N3zvo1WlE5a?=
 =?iso-8859-1?Q?Jax9Lk2/jzF3HZSXFxBhg1W3pQJrBBqhutV0Dwleuo1JzrbjsCQfXpGBGC?=
 =?iso-8859-1?Q?1P9ypTsIEU9WXCaYdCrXJLLdvq4lSjwNpfznUGJa8EBc+1xnvuxfU1Ppxv?=
 =?iso-8859-1?Q?tlRcP6xZFhxnW6RQKqi9tJjf2PUr57+Cw8uc+AEUnlqyJhR9Bo8pLhNksd?=
 =?iso-8859-1?Q?hJiHVdvkAhzqvC3xshP2BFHyEkW9krhB4wby8QZkzFHxPJB/TR+YaaF+/j?=
 =?iso-8859-1?Q?djiZc4/qvYD/QtWxyI1J3Ye1mTjSlrq0sE35hV4p43npdz7WBWHKSKgUug?=
 =?iso-8859-1?Q?9gzC+tmAXHKd/uQs84qiqQqkLXiLJcHfvypuginOQLVimpw1/9U5oMROUn?=
 =?iso-8859-1?Q?6ydUGtbchnS1+lQdPJmCy99KWjzG1hNh88uiKWhJWANVOFAE7z3gqFRRuP?=
 =?iso-8859-1?Q?iUMFyffJkgZR9RdS/Suv8gR88wlLew8QgzudADPZSCATSf0cPpgjWhfz4C?=
 =?iso-8859-1?Q?rd6atP/OJJ9AwhclQYvX4ZC3LCZz6fcFJWWGIJbg208lXWh+vqpjlppcEq?=
 =?iso-8859-1?Q?o+sd1G7H00BPF/bzVtqwmfMWQZqWWYuYha9Uw6ouvrCKucphX8Ao/nNIO6?=
 =?iso-8859-1?Q?8CiEq5RLwuVsjJh9jHyB+rfAvN6qa+POdkP6nOs58RM4IIcSHIDEguq4OW?=
 =?iso-8859-1?Q?tWKCpcayoi1PyiRyf8LZ2Ep2DUZByI5lsOZnmNVSBlnB/It6P740lDlX3z?=
 =?iso-8859-1?Q?c/5DNTKDyI7MIm5Nc0MUFxmYS2a0rqZRI0g4swdFr5GkkF/lBmPLx+IqZY?=
 =?iso-8859-1?Q?ILkXjio0i4OUNnucI9x55L3m7b1wk8iBxIG0Pkzn2UdHA9mvhTQCbBHqQh?=
 =?iso-8859-1?Q?+oN4A3kiM1CQ7EmCQfCovaR4sW95nUAnHSI2UWBCxdK0VRl0EIQ6aSZo8b?=
 =?iso-8859-1?Q?gOdfQIb1uIokg4UTZhJqQ83lN1dvBDWFfJDxwGDPz12St+9lGtU8/cBiiu?=
 =?iso-8859-1?Q?lWvzzKyQDA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 658ae421-b4c9-4f75-df07-08da4fb76d1e
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5005.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2022 16:44:05.6258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CbngsLH+oUTscdjUbV1kjYkyFTUFQ9vroBzfxHUViSSnfKG6E8wyY41h96lGLb0+4x5sTiGuXSMIILkIFPWzRQ==
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

In order to replace the fsl,scu txt file from bindings/arm/freescale,
we need to split it between the right subsystems. This patch documents
separately the 'rtc' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
Signed-off-by: Viorel Suman <viorel.suman@nxp.com>
---
 .../devicetree/bindings/rtc/fsl,scu-rtc.yaml  | 28 +++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml

diff --git a/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml b/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml
new file mode 100644
index 000000000000..a2594fdd486f
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/fsl,scu-rtc.yaml
@@ -0,0 +1,28 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/fsl,scu-rtc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - RTC bindings based on SCU Message Protocol
+
+maintainers:
+  - Dong Aisheng <aisheng.dong@nxp.com>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+
+properties:
+  compatible:
+    const: fsl,imx8qxp-sc-rtc
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    rtc {
+             compatible = "fsl,imx8qxp-sc-rtc";
+    };
-- 
2.25.1

