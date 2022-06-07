Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F9253FCD7
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 13:04:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242536AbiFGLES (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 07:04:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242822AbiFGLAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 07:00:52 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150078.outbound.protection.outlook.com [40.107.15.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 542B5F70;
        Tue,  7 Jun 2022 04:00:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwDuuhnHHIJJmcx52zVpop4zJCTmunfbyFfd76zPY9c2hZDgx+AmfkFjvUmSdX/z69DyzdRzC27Os3bWL4zh8ezPZYXwYmWRFEzTNB/YvOxM5SUCk+lAMKVdOC+GVxzN+NXabUpfanj0b4qN0zT/2OHO7HekCOnFtVbYjzeh72MtayO8ArnRLZ+E4HUFXDgyP0jv+xCT5VfKddiUZgaSQsTr/Jt1KkyGITcdQavXzs4mMViN/d8k+fAzSRFtB8m4Stt6LFS79TunRPA1SK9JYRnbN7/1ffYq4hsz1cNvqVjmpKPQNPWdwAA2b9gFIZij6O7ctf0yXGAWco3jRArfFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m2N0yoK/Sp49UR6z5WXw8VRlg0QJKodALPx++//BL/k=;
 b=GS2BWc9togLwSrkvemWJf+G3dEfdO6osE8fKeJlmwSP5uEoPqWZJabwvdrqhDw0pOXkng/iPI139jF0ztFjRZWXuyj/2vRxnJbShY+LadkFq+4it+xtWfYW8br6igKsy7tLSX/44SnLKwnsZZGypWOKGd79qwQbAzb6w6lGtTIdnYYE/NbU9tCCJVXw3e7JaM963lk2oIFoo8/mcdEt0DOgQZSujC7gjkcjugZV4Ap7qaKSP1C7N6qYf45q3B07kahUV7WLqbi9dZGlB/zoUUq4om4oej+JJVuS0t6E3i3s3jvL4wHfkATIAvtHzNE831Y9IvOCpssUpf27c8yQPtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m2N0yoK/Sp49UR6z5WXw8VRlg0QJKodALPx++//BL/k=;
 b=Oebq0Dbn/7sj6glQ7gRBjzoavbe3ArUx5fin61o8qIG0krvcJsw5HNg45uR9/uzwl3LacwrDTz433akMQbVxlHJy7otkGCW1s1Fq1RB5P/JAF00p+oTrkF1dp16d2LZL1Nah5z5Am6afZkiLwN2b2GAX8gtfkQ6dM1m64pNjPqo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com (2603:10a6:803:6a::30)
 by VI1PR04MB3008.eurprd04.prod.outlook.com (2603:10a6:802:f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.19; Tue, 7 Jun
 2022 11:00:09 +0000
Received: from VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1]) by VI1PR04MB4688.eurprd04.prod.outlook.com
 ([fe80::a541:25cd:666f:11b1%5]) with mapi id 15.20.5314.019; Tue, 7 Jun 2022
 11:00:09 +0000
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 01/10] dt-bindings: arm: freescale: Switch fsl,scu to yaml
Date:   Tue,  7 Jun 2022 13:59:42 +0300
Message-Id: <20220607105951.1821519-2-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.34.3
In-Reply-To: <20220607105951.1821519-1-abel.vesa@nxp.com>
References: <20220607105951.1821519-1-abel.vesa@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM5PR0602CA0007.eurprd06.prod.outlook.com
 (2603:10a6:203:a3::17) To VI1PR04MB4688.eurprd04.prod.outlook.com
 (2603:10a6:803:6a::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d58c3720-0bf5-4702-3f1c-08da4874e362
X-MS-TrafficTypeDiagnostic: VI1PR04MB3008:EE_
X-Microsoft-Antispam-PRVS: <VI1PR04MB3008DB5A4D2C4D50775511C9F6A59@VI1PR04MB3008.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BtfdGW/zUTvRqM4BLU4fVH9G0ztPVwcrqHtTTyaXpsJOwnaMqIxAznR8feJZVtBiSOJEpnFobXy647SN+uhYXU/3Y2qIwnT4N0lsg69s4+GD4JtiM1HTvsYQ36WjF78EedPcatmx8xgTV92OIytK07Ei2WUkHplRPTxB6S+DniSW1BpXjq5Wh/nMGvr0Spi6pzD7RmGNMaNfXVcNTaDFHSv2qEZZpeUimfN2nw/HDR8QcHLe4HXZSc6oE5DsxMSmqIhLXW87ygbRR/dTykh44aQwQ+jwuUQj231SF787kJbU4DMh5RC/T1vxYjwUC+j9ohFyIIL361Mi1HKmVf0APmLfQSbVO59SEfNtSke5+KmB5WIXA5kqrxPC9G5B5AZu6SU7U6yToHm5+gtaYGzSGZNh8qNFEwd9j3eLc0zWdzjqKTtZ5ysdRzCtdfxpPfNJRqF8HYA/TPMPNu8zmSFmaJUeO8uNLQ/dvEqs+OEvX6VB7Mh73PafoQ4mleNH2h5utct2tz5nc6BbiIABBzQi3/ubkdILiZc3YrZTj21dW9FxVY7PPKuLndO22mOmzDBLZUOD+2tflHYDPc0RwE2lfKCIqB1jhB2dYU79XZwp4eimYwWj2KyepBCgKi4Dthf5fyKhew1VlTkr+e9CH3PoiLP+ZIejaiPfWViJ+oNZFXsNC772i5R9Lqa/NWANMyNCeWXfEg3AJEF/SKFatoQxPXhfvllrEdP9jGsoLg7fSFPy2o3fhzgKOfZzt+vJTt1VMp7+4aGFxAdGa1aX7XFQQmbaqtwsEIrEUxNbROw2wqfkPKeo7DfHlk6VqLlkBC9tkH61Aniugo9qhD6Ugmw75Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4688.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(66946007)(6506007)(36756003)(38350700002)(38100700002)(6666004)(966005)(52116002)(6486002)(86362001)(4326008)(66476007)(8676002)(2616005)(8936002)(186003)(5660300002)(2906002)(44832011)(508600001)(66556008)(1076003)(83380400001)(316002)(54906003)(110136005)(6512007)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1ighFcOfbVjVZFfXdlFNgiCScosxsOsf2qbF0QGAzQjD2snaeWdDOtJ+SBd/?=
 =?us-ascii?Q?wjYaTN2r0Kf/W/xHv/J1AhtddU89TJ87stBNtIkn9hmmIqkRU/H1rC/hZ8uW?=
 =?us-ascii?Q?5hzcmkD3pDPuOkHqVvifMtgQRYF/7fzuWiudl01uRqr2a4F4dY8RShOuM1sY?=
 =?us-ascii?Q?hdL/9CjrftLHWKuoFkINABGup88SglMTdk6JoOH+HwT3E0A5pk+DzVcajWFy?=
 =?us-ascii?Q?XY/j4QDiGBW6d0hOcVaFOentQyWxPPwsBAm4gEBIUd+ooMeVxJtXiJx2Y6c1?=
 =?us-ascii?Q?eumH9ek+KnN6xQKLyYug9YaSGYJGvV9yhu28UnDDgBeo6TQbLIEuoQZ1VEOn?=
 =?us-ascii?Q?quxWZKoWJSjggaAjCuy+hrllC/iKFXWJZ13BKjyMxGAgWtkBSzEUPdrrXS5a?=
 =?us-ascii?Q?oVB+0T/jE1TQynfinG9mEXZ9X0MvKWjqCPFqbcG9/BWke3Z+hBs/f0xrSeIP?=
 =?us-ascii?Q?4bUEqLastfPN3Gufxs/tbiOtRLYncZ5P7h13jWwgqiCmjDv0VcmHauGfhieP?=
 =?us-ascii?Q?z7Y6Cm+YzbPBbpEYUtCk6qQSzNS5P3hd/D/h5cp/5+O6WqC2zhf0GBIUv1ln?=
 =?us-ascii?Q?kVv9Mgy1Bqxb1TRhJtYLwugVXqNLc3FBU1eWBRyQ7wyoXovmnyMz6unRDQpc?=
 =?us-ascii?Q?pmAP9rbQ793k+01R948nfIbLWoAt3MV8zay7PrwaZUBkFfTEdvN/Tf/bVKSB?=
 =?us-ascii?Q?/iegrHeO8+ZG8ev7VvzNDC9laRdur+jfO5hxtkmICc/YdRggt+m3C7BoFD2T?=
 =?us-ascii?Q?jFRMpgFNiF5dxPX2hB4LV6JZqcHVBYAkE3dMNaglVExlkM2ng5WaM5n3WSwL?=
 =?us-ascii?Q?ybf9GjSiX39l5l5zoi1tT51OETsaqut3P9Ya1/eJQLesUJthVTxx8AkSbJbG?=
 =?us-ascii?Q?6XqDES1hSLUPsIA0RJ9KHyYPg8pfwiDfXm7NOJA5wuHzUISKGpOl8jOaVLq3?=
 =?us-ascii?Q?dX5dwtS8sO+x9n+AJbUHCxwAY/NfBpAmhRJyyzJv9T/VM3Z8uVsAYfHawYAD?=
 =?us-ascii?Q?AXELgZ+0HLJ/owiLVEtUUDsyXuBw2A2xIonjIuAtSX0UitIOkiaVv/RHiYC4?=
 =?us-ascii?Q?CrwuHsCj5C90lqISikkqBkKwusE5MEK4OC/VpwqGlQAX8+Mr8JNYg5pcb3wO?=
 =?us-ascii?Q?2h1DphmOc66OpqwbcA5ig61bV0Yl/DMFiotPNPx1piBYJjklRi+AzW/SjtkI?=
 =?us-ascii?Q?Q1xiEy7qd/Vv6SpAuJWJ8txe4NRgA06M3s8v9ZZufhkwU1tWR1M/rsiiDNZE?=
 =?us-ascii?Q?zuJ9AN1yWusP3flpe328tKzoHuFm2cM62V/2yx5mhfp/TZxHEzm1JhKH20LF?=
 =?us-ascii?Q?pHsq8lyHzZsz5wyPxb3Rf8bRTGQyhjS75XOQLpZPT3ohW3g978BnZkg3TV/e?=
 =?us-ascii?Q?obym2A41PYrXUtJI+f1FbmhtYCMe4XVkePQpEc3JDRDhHRqZUXqMF46ihD6V?=
 =?us-ascii?Q?UEawCQBF/44Lhl4UWMlitsQUfxtlVugjqBhSt8Fu0oi1yOV+eSuUJRBSWQjB?=
 =?us-ascii?Q?enN0rjdGZxl+QbtbYS7siRVKhrAy/ar/aZAhN9VXh/6pQbaaXvx7pDuLyFQ1?=
 =?us-ascii?Q?BJYKPa4Gfz36NGgrG2Tvqyjy0X8ftmoQEcQMNjZT7jcruiMsOdpz6TPnUMkV?=
 =?us-ascii?Q?S1eOwKK68gT+sZw0RJx62bOPu0TvfNkihG3RlEflUUxZPeY6KJ3x2nNcwWNh?=
 =?us-ascii?Q?1uyFPNR7FC7Rso4h6czpQtNnCu1EbMxejc5pGnWvsr9gw5pnit2QX3JI9GlO?=
 =?us-ascii?Q?Xj8uXSuapw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d58c3720-0bf5-4702-3f1c-08da4874e362
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4688.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2022 11:00:09.7275
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +gpeTKMpIAKzGT7ma+a/iu+zyTeOfwRbPaqodV/ak5gTBut+Ykax4MV4RsJJrNMj1EFK+W6fV4JL9pLMeBfCBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB3008
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch actually addds the fsl,scu.yaml which is only for the
main SCU node. The child nodes schemas will be split in different
yaml files. The old txt file will be removed only after all the
child nodes have been properly switch to yaml.

Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---
 .../bindings/arm/freescale/fsl,scu.yaml       | 185 ++++++++++++++++++
 1 file changed, 185 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/freescale/fsl,scu.yaml

diff --git a/Documentation/devicetree/bindings/arm/freescale/fsl,scu.yaml b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.yaml
new file mode 100644
index 000000000000..56728cfaa2e4
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/freescale/fsl,scu.yaml
@@ -0,0 +1,185 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/freescale/fsl,scu.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX System Controller Firmware (SCFW)
+
+maintainers:
+  - Shawn Guo <shawnguo@kernel.org>
+
+
+description: System Controller Device Node
+  The System Controller Firmware (SCFW) is a low-level system function
+  which runs on a dedicated Cortex-M core to provide power, clock, and
+  resource management. It exists on some i.MX8 processors. e.g. i.MX8QM
+  (QM, QP), and i.MX8QX (QXP, DX).
+  The AP communicates with the SC using a multi-ported MU module found
+  in the LSIO subsystem. The current definition of this MU module provides
+  5 remote AP connections to the SC to support up to 5 execution environments
+  (TZ, HV, standard Linux, etc.). The SC side of this MU module interfaces
+  with the LSIO DSC IP bus. The SC firmware will communicate with this MU
+  using the MSI bus.
+  Each mu which supports general interrupt should have an alias correctly
+  numbered in "aliases" node.
+  e.g.
+  aliases {
+         mu1 = &lsio_mu1;
+  };
+
+properties:
+  $nodename:
+    const: 'scu'
+  compatible:
+    const: fsl,imx-scu
+  clock-controller:
+    description: |
+      Clock controller node that provides the clocks controlled by the SCU
+  imx8qx-pd:
+    description: |
+      Power domains controller node that provides the power domains
+      controlled by the SCU
+  imx8qx-ocotp:
+    description: |
+      OCOTP controller node provided by the SCU
+  iomuxc:
+    description: |
+      IOMUX controller provided by the SCU
+  pinctrl:
+    description: |
+      Pin controller provided by the SCU
+  scu-key:
+    description: |
+      Keys provided by the SCU
+  thermal-sensor:
+    description: |
+      Thermal sensor provided by the SCU
+  rtc:
+    description: |
+      RTC controller provided by the SCU
+  watchdog:
+    description: |
+      Watchdog controller provided by the SCU
+  mbox-names:
+    description:
+      include "gip3" if want to support general MU interrupt.
+    minItems: 1
+    maxItems: 10
+  mboxes:
+    description: |
+      List of phandle of 4 MU channels for tx, 4 MU channels for
+      rx, and 1 optional MU channel for general interrupt.
+      All MU channels must be in the same MU instance.
+      Cross instances are not allowed. The MU instance can only
+      be one of LSIO MU0~M4 for imx8qxp and imx8qm. Users need
+      to make sure use the one which is not conflict with other
+      execution environments. e.g. ATF.
+      Note:
+      Channel 0 must be "tx0" or "rx0".
+      Channel 1 must be "tx1" or "rx1".
+      Channel 2 must be "tx2" or "rx2".
+      Channel 3 must be "tx3" or "rx3".
+      General interrupt rx channel must be "gip3".
+      e.g.
+      mboxes = <&lsio_mu1 0 0
+              &lsio_mu1 0 1
+              &lsio_mu1 0 2
+              &lsio_mu1 0 3
+              &lsio_mu1 1 0
+              &lsio_mu1 1 1
+              &lsio_mu1 1 2
+              &lsio_mu1 1 3
+              &lsio_mu1 3 3>;
+      See Documentation/devicetree/bindings/mailbox/fsl,mu.yaml
+      for detailed mailbox binding.
+    minItems: 1
+    maxItems: 10
+
+additionalProperties: false
+
+required:
+  - compatible
+  - mbox-names
+  - mboxes
+
+examples:
+  - |
+    #include <dt-bindings/firmware/imx/rsrc.h>
+    #include <dt-bindings/input/input.h>
+    #include <dt-bindings/pinctrl/pads-imx8qxp.h>
+
+    aliases {
+           mu1 = &lsio_mu1;
+    };
+    lsio_mu1: mailbox@5d1c0000 {
+           reg = <0x5d1c0000 0x10000>;
+           #mbox-cells = <2>;
+    };
+    firmware {
+           scu {
+                   compatible = "fsl,imx-scu";
+                   mbox-names = "tx0", "tx1", "tx2", "tx3",
+                                "rx0", "rx1", "rx2", "rx3",
+                                "gip3";
+                   mboxes = <&lsio_mu1 0 0
+                            &lsio_mu1 0 1
+                            &lsio_mu1 0 2
+                            &lsio_mu1 0 3
+                            &lsio_mu1 1 0
+                            &lsio_mu1 1 1
+                            &lsio_mu1 1 2
+                            &lsio_mu1 1 3
+                            &lsio_mu1 3 3>;
+                   clock-controller {
+                            compatible = "fsl,imx8qxp-clk", "fsl,scu-clk";
+                            #clock-cells = <2>;
+                   };
+                   iomuxc {
+                            compatible = "fsl,imx8qxp-iomuxc";
+
+                            pinctrl_lpuart0: lpuart0grp {
+                                   fsl,pins = <
+                                           IMX8QXP_UART0_RX_ADMA_UART0_RX   0x06000020
+                                           IMX8QXP_UART0_TX_ADMA_UART0_TX   0x06000020
+                                   >;
+                            };
+                   };
+                   imx8qx-ocotp {
+                            compatible = "fsl,imx8qxp-scu-ocotp";
+                            #address-cells = <1>;
+                            #size-cells = <1>;
+
+                            fec_mac0: mac@2c4 {
+                                   reg = <0x2c4 6>;
+                            };
+                   };
+                   pd: imx8qx-pd {
+                            compatible = "fsl,imx8qxp-scu-pd", "fsl,scu-pd";
+                            #power-domain-cells = <1>;
+                   };
+                   rtc {
+                            compatible = "fsl,imx8qxp-sc-rtc";
+                   };
+                   scu-key {
+                            compatible = "fsl,imx8qxp-sc-key", "fsl,imx-sc-key";
+                            linux,keycodes = <KEY_POWER>;
+                   };
+                   watchdog {
+                            compatible = "fsl,imx8qxp-sc-wdt", "fsl,imx-sc-wdt";
+                            timeout-sec = <60>;
+                   };
+                   thermal-sensor {
+                            compatible = "fsl,imx8qxp-sc-thermal", "fsl,imx-sc-thermal";
+                            #thermal-sensor-cells = <1>;
+                   };
+            };
+    };
+    serial@5a060000 {
+            reg = <0x5a060000 0x1000>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&pinctrl_lpuart0>;
+            clocks = <&uart0_clk IMX_SC_R_UART_0 IMX_SC_PM_CLK_PER>;
+            clock-names = "ipg";
+            power-domains = <&pd IMX_SC_R_UART_0>;
+    };
-- 
2.34.3

