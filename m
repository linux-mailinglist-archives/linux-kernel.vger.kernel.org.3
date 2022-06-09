Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D86544F59
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344031AbiFIOgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240000AbiFIOfx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:35:53 -0400
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-eopbgr140079.outbound.protection.outlook.com [40.107.14.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91C00323892;
        Thu,  9 Jun 2022 07:35:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XMIE5aHgZ6BCxHVgfnRPcFDVCVqtTNFdUg6S99f6MII0X3sjjXmY0rgRiB5AkRV6ef1sT7MIi+hdZTr+UuNvniy99FFQm5RQYavEDgxezoMk2PYYCno+UI8AHWYGJltUkKDMcuBYKNKOMnHSFD/RC1zkOi9tugD8mfAvh6SJlZyB0DWf5fPya+sFAwmz9JAnReHFXXS3BvkKQwmH2Bec1osMNIG66pTwYwSJC7McJSQCCavlMcnsWHYEXT5FK/LfIkKO2t8xicdbYEISjHc4/Mhsx3Wq5+23dB1TP4+COy0F24mwDTI/wvltbegNJlGz7RRPp5BX1Uzu5OIjhi87IA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EISMnqpVMaNBpylyKKYPyk2+WsJKQUdVndBFvV7ijGU=;
 b=LafRK27fN7xoin9TPUase8ETImzkmmo729uQBe8iZNclDOq74a6zvJomUSjHYGC0osfJocLtJbA+eHBUAnC8WHQXHBXltyGyz5I0mTGnmSq+9+G0B7TGNJufQXwgP+hXUV23WvIZznUHZtEPeQFPpSY33nsRpeiA7BRqY3uYZ2GwHKs76I9jX/U6eTs7BJXFne4/pkJbjCK8wyGMurnUu0JoNUx1GtJK2rMZYKZbpJJOx/x6mwD/80l58yRphRBEEEx/zE6L7IqaU3K33HjqJEtlbV9kXmB8qP+5z1z10D87GkpDzh8duTHZzvJu1uA7Svn4iCcL+nfnnRsPBLrgVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EISMnqpVMaNBpylyKKYPyk2+WsJKQUdVndBFvV7ijGU=;
 b=TRDcPKyfveZSD6gWCppFYQQYfvP33iTP2ZvoLAEHBragEFt6eNrt/wagKZhrnl0zVnlu8z23S8HAqyZ3HcU8Kx2YbGH4qGIFOnLFWhiwuE5j2t61MSWQDQXJzNC1kgyFSscHFHWTBqHk9ai/uGwspHXbPo5ejxYDjMX/1dVwXak=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB5885.eurprd04.prod.outlook.com (2603:10a6:803:e1::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Thu, 9 Jun
 2022 14:35:27 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5332.013; Thu, 9 Jun 2022
 14:35:27 +0000
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
Subject: [PATCH v3 08/10] dt-bindings: thermal: Add fsl,scu-thermal yaml file
Date:   Thu,  9 Jun 2022 17:34:21 +0300
Message-Id: <20220609143423.2839186-9-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220609143423.2839186-1-abel.vesa@nxp.com>
References: <20220609143423.2839186-1-abel.vesa@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS9PR07CA0042.eurprd07.prod.outlook.com
 (2603:10a6:20b:46b::29) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1cbc3d82-217b-40d1-219f-08da4a253d7a
X-MS-TrafficTypeDiagnostic: VI1PR04MB5885:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB58859FD2EDE96859D85F284AF6A79@VI1PR04MB5885.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 02ufzGn7LgJHTyVdNCTBFaKjOvZcgF+K1r8eYtOUUX4FaDBislWrfpaiuwz1W7oRXcu0zo3j46tgr/bIbTnfLUyjD0D8xoT2oV/u1JpQsP5cH3JlsQle5XUl+4+h9u/ytN6+RFtWGn3xLNBblpIad5TX6J48sh/g8zDu8jL8/NtsMtHbS84WYLqsw2D61bvve8BohX2wJkf82N34xdKzLEN3pX+odsJoJUhaMfa7pwCGMzyS2VJsAbqVoDSTLRXy9s76mmTDqAqLEJKhIHng3usqn08ty8LJ+IReA1La/n4cvZ4KfNw/m2uoPO8xKqJvgi3FZ9eFhWOuBhZynLTlRN2mUs8+cEDYl0cSirzr8K6cD/wTBSp8hyqIaThjT+gHwBIA0ILHJfkwzNorbs5CF0AApa0cMjU/EvNEAuwCt4mlSJyUJh8daCwpQxXWx6HFHRGkWJcj6dor8tIQ5oDgIj2IpBGSBzEftv/OWkuQjDF85jUYmEwmZihDWBFEMqdOtt4w7728klL4au3iOZjN4jeFJv03+Edkd5xmI8H54huPz2VI7y/sh9JQZskIb00Qb6SVfxkYBII0HhyJsRH4NUqL9RAl90lZOJlF/jWXUbN5BtGj9TINUzSlRRDZ6c6Kc3o0VUBowHNO+22EICBOzmkQOqyaWU+EvKJ2HepdGSAR3jVe5Gvy3KVbb4O6Msz1f+KMKRz9q7I3bbZ3okwVxmAp9YcoV0gc7ttm8JxtQmJDfIr7K7PeQ1iuQ7g84R/Qm3CahNE7HELOLp0pSPYi5bztOPxDDv6yXOY/LBM237jvmGNIH0aRcBDb11Ye/Wdw1YkGA6C2l1KiSaGISqU8gSLk/TMUfKkJoAPItV+IVwU=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(316002)(36756003)(54906003)(110136005)(6506007)(6486002)(508600001)(2906002)(966005)(7416002)(38100700002)(5660300002)(6666004)(86362001)(44832011)(8936002)(8676002)(83380400001)(2616005)(186003)(52116002)(38350700002)(921005)(1076003)(66556008)(26005)(6512007)(66476007)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?vSvoPaDsHNKvpf1LjwIaPh+ziyZo0OgPqriibqX4UjiIBF8acSzjaLF0bVHK?=
 =?us-ascii?Q?E3+ocvDXj6SlOr6LfyvQDRrRqw/agKwdpw4uvxoEbsVKWTFu1FqDoWYlRpeQ?=
 =?us-ascii?Q?Huv9j+vHbeoL4iyiWKGjx1O6CS3l9p9zl2OwBJiy8d3k+ArSO2RIW0FEgnd7?=
 =?us-ascii?Q?1ZLT7Uyk5Gfr+WdzxXHQIy1GiwgMrqa4ASKbQB2v98HQ0kT/hG5BlA0+FyFo?=
 =?us-ascii?Q?Ypf7QjTmIk3//g75tJWFIsGwej03cVgYDmrgNPgMy+633hGPYG7wPLc+097m?=
 =?us-ascii?Q?dcyZxwtWaClKUgSeDMOMajfMdF2pyQrn0scSetHlKsnV3vpw8jhFgJux62ua?=
 =?us-ascii?Q?A05Q3s0cl/xbFOotaQTNDpZsnPoiMGTffdkffonXS7mCXh2GZYBTBP/xfa/Q?=
 =?us-ascii?Q?nl+KmYRN9T6Q6HqGTIkUUsoZVNV5VkqEeEuAktFkg+6FVKIEnavJ3YOkkQN0?=
 =?us-ascii?Q?Njl/h08kns0fzdipQiHMcH/3dklLbvDb//iiT4jXwZ+cTKXuyOKokuBbrF7H?=
 =?us-ascii?Q?NrnkRBVMwNPkQ5+OVoqE1yi0Y90RpKzlouQvJFDqGm3bNK5dH/RF5wNQZCBG?=
 =?us-ascii?Q?kRGgw7BfaTzm5oy9cDtP2XzFADfLyRYMRqyI2+2btdZ9wudJ86uduX6p/h7P?=
 =?us-ascii?Q?uN+zf8YUJ+CsFuT2pG9v8FcmB2nrowC5Fxg7AmAX1k+AtpywJ+XKZSHMclxk?=
 =?us-ascii?Q?36f4tVqnRSKYmy1r93EbqM1dG0+wcP05Mxj+xcODpy2gpOeqGx8lksS/z2RR?=
 =?us-ascii?Q?XYzIqheKjBx5Y6wFkAsGjY+fwmLW/6IV7+ghFLmU8DP0IUnIPKaUeFldsXNz?=
 =?us-ascii?Q?4eOC7i5LRPl4fJfVZWDuC4GKLZrKtBOlKEU7PyVh9j7hcj/goLUVN989meaL?=
 =?us-ascii?Q?IRG9iujx2f4O29ynHSvc1nDaII/rczKWyzOB2AorNiSzwaH7B63c1irFen1B?=
 =?us-ascii?Q?/Fk3WLsYATR/kpdbo0J4h5mGQtX4oopk0ihQI4kaaD1jlBUnHiH6hFzt566v?=
 =?us-ascii?Q?GDTJx6HzulF0TDwGUexOoq9bmTo53xUFeyA42b8wdk4pZ7yVpx4tYV2pIgx6?=
 =?us-ascii?Q?vx6TdzMDpUE6Xw4zDGv2ZNk6cRn4t0ReOQ978tZt7r6W7G0u/O3VoaGtXFj6?=
 =?us-ascii?Q?ndb3Yy1yPornw8RlT0xZb/NtTNPciHTIWqYc/71uhmKlLb/bY4JcCvr+gmpc?=
 =?us-ascii?Q?0eFK4RyqngYYkF4/iGUJmGunoj5XyJQqxuv/78VuB4UCYakKv6vWS0n12J3z?=
 =?us-ascii?Q?4pmbIx0+rOp7DW0websmzxzpIKttRcfl0LL049pusDaytfPTf8RNQpzDb3hV?=
 =?us-ascii?Q?0VqXA3wFGVfSRHSPHXi/NhC0KoivnyhXN+8LPCeAKBZvcub4K+y37DE/1ICD?=
 =?us-ascii?Q?XE7yQSgKL62ukJD+GM4gj2N/Qn0n5fWf73Ez1JOAjz0d3uYFNRMlCSeQRUER?=
 =?us-ascii?Q?TXHbqP0eBhEifqSW2HmdNa9S0ok3hwEblodTVPo4sbra0sZEw+AsO01ZmVHl?=
 =?us-ascii?Q?f9YcPU9sU+imBt10FO4WT1gjGX+X2sRnFp2GixW6bKIln+qZhDF+jNTOxTJp?=
 =?us-ascii?Q?MzTTCvgsPsPXg9Gi+j1XFeGImWR6xO+t6lEtElhR/D3yTor17HtyUKjfLR1l?=
 =?us-ascii?Q?gcksRbOOcM5VRZHCfwpGsPULEQy/JLXPxpwn6yuaAyqSewgGSAi/2TtWHUcC?=
 =?us-ascii?Q?k/YkJNglnWWSQZpsd0C9oMucwhngJ8eF5kmLHjEetEiesyASLegTyKAUgzxu?=
 =?us-ascii?Q?pBDiHVn/Cw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cbc3d82-217b-40d1-219f-08da4a253d7a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2022 14:35:03.4349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iw8tOPT1h3+wD107lgaY0yLipnncryMklxRLzltsG/oa6p2PY/FbSOFDrkz35bwecvroaUcHvFsuyO/ULR+vsQ==
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

In order to replace the fsl,scu txt file from bindings/arm/freescale,
we need to split it between the right subsystems. This patch documents
separately the 'thermal' child node of the SCU main node.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 .../bindings/thermal/fsl,scu-thermal.yaml     | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/thermal/fsl,scu-thermal.yaml

diff --git a/Documentation/devicetree/bindings/thermal/fsl,scu-thermal.yaml b/Documentation/devicetree/bindings/thermal/fsl,scu-thermal.yaml
new file mode 100644
index 000000000000..4e9a5209ae2a
--- /dev/null
+++ b/Documentation/devicetree/bindings/thermal/fsl,scu-thermal.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/thermal/fsl,scu-thermal.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: i.MX SCU Client Device Node - Thermal bindings based on SCU Message Protocol
+
+maintainers:
+  - Dong Aisheng <aisheng.dong@nxp.com>
+
+description: i.MX SCU Client Device Node
+  Client nodes are maintained as children of the relevant IMX-SCU device node.
+
+allOf:
+  - $ref: /schemas/thermal/thermal-sensor.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: fsl,imx8qxp-sc-thermal
+          - const: fsl,imx-sc-thermal
+
+  '#thermal-sensor-cells':
+    const: 1
+
+required:
+  - compatible
+  - '#thermal-sensor-cells'
+
+additionalProperties: false
-- 
2.34.3

