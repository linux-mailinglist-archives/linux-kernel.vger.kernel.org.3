Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBEC5587798
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 09:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233975AbiHBHMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 03:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235760AbiHBHMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 03:12:14 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130055.outbound.protection.outlook.com [40.107.13.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1D1491F8;
        Tue,  2 Aug 2022 00:12:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FvLS0KldQDfyBzwAcb/M1PKOd52AXXk8HskmvEAmOl3LKjws5iCdJnqCN0RkSOemS7dWAlxgDvlSo0cDCioNz9BcyP/3c1RaH9p9LJncliLAzpr8QLfdsWiVUoQR7iLOYjZMAtpZk+P8LyQypztm2uZceR0ggKeTXii8B1Mp9kx+IGufTbSaDyDkNHM7l9VXLCXYEoC9lTXsaSrLQiw/5uG+GtNrOOF0D9sW5gP+r21RL73wRDPBIbeVI/9GLWc/RQShJnZi79FE0G7PVhPXV0wBCp/siw/TjSDR6QGIS8opEMF80UfFw5tDES7hi1eVP2Csj7LYIcJgFzemDQu7iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3ms6NgdvbI5Hv+GUeldBoDjchzQ1P/GSj3+SydPlgRI=;
 b=m/AY6LB+d3hR1D5oI12G08rmu6+9zs7VycyWjLMn6TkHjEEcICfvbERokMSKCOXKn7Zlv7UOpuYYI75gKVX405QFs6n3f+x1x312vTeF+jh4jNoFtb8L10iNi0vuHAlcy0NANmgBYFohiI97AkXv20Twf6zN+XsnFr2xU4ZE7DicB6zxmuy6eYPdm+s/QZfcUchhsCXhlzzo9bCJgQQCfynWaca4AiTv+uE6rNDy8w4mZ+J4AN01C1JFoLZ+HXb59RL6ikLvT36JBNZN/UAgd5Z1Xb6axtVnDSePvXsAwWrtY9JU65cv0X9zEBPA49Kiy7//VdGwo4Zt6g6R5PMQ3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3ms6NgdvbI5Hv+GUeldBoDjchzQ1P/GSj3+SydPlgRI=;
 b=WBYXDxl10w04aASiQUceLY9ykOoYrQPDQfzP1i2nc83bsO0pAqjSx8V3weMU8w9lB6gt69zBDOtfdw+3o9mkB1D7n3zSXXPYlrzGztfiQnzXwzwqZWn44J18EgJCipojqEV7+9EVcgV8ODCX5Q+EoNwA2xHQz2R7WjL5L5/MQsQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com (2603:10a6:20b:113::22)
 by VE1PR04MB6429.eurprd04.prod.outlook.com (2603:10a6:803:11a::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.16; Tue, 2 Aug
 2022 07:12:04 +0000
Received: from AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b]) by AM7PR04MB7046.eurprd04.prod.outlook.com
 ([fe80::2549:869e:d80b:3a1b%7]) with mapi id 15.20.5482.016; Tue, 2 Aug 2022
 07:12:04 +0000
From:   Liu Ying <victor.liu@nxp.com>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, saravanak@google.com,
        gregkh@linuxfoundation.org, geert+renesas@glider.be
Subject: [PATCH 3/3] dt-bindings: bus: Add Freescale i.MX8qxp pixel link MSI bus binding
Date:   Tue,  2 Aug 2022 15:13:10 +0800
Message-Id: <20220802071310.2650864-4-victor.liu@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220802071310.2650864-1-victor.liu@nxp.com>
References: <20220802071310.2650864-1-victor.liu@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:3:18::28) To AM7PR04MB7046.eurprd04.prod.outlook.com
 (2603:10a6:20b:113::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3b7a24b-38e2-4328-ad3f-08da74564d7f
X-MS-TrafficTypeDiagnostic: VE1PR04MB6429:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: okdz90Wm7G7rLAKOfe/XmLm6zE41PxSPDnpZGNHJO//FD0KeJFjjoqZYXUHdQjVAjN1H3NNMc6/4lscOQpfldxOSNwy8M3HfaX2g8IS/NVyTr4CDcEyO1DR4h21mY6v8JqojFuUeanU8MAByog/MY/F+UuW81Ujs9fKkhtfu/yW9TtxLvnq5VuQTl+j5RetHvAxpKi0yDkv2BJ9U/V0gEswQ44SU7A+DMQGSrc7ni38iGmVRGJVBff+f3u2GYYpxbqNRqZeHn8NSf3cztgxXt3bKw9kcH6G7bc5fMKLXk/ptdNoffOIZoEGMQ7GbtdxvCwT6cm9eNp7T7II8/BVbYj+JD9jWTSIHItyLnl8v154niVof9k9LJRUslzC5tZxJSXqsHZEWF7tfqqAv729dLdocIC/gq7Ptrb8UtgNJbId6oF/S+5XqFY8BLCb5Jom4JhYXBfIRy7Wk+ox8TFIr6D9Ujs1OqwEn6ZEc6vzBigjJfC60c9Zg1cgPwb9VssA/ucmwZnCnH+7Z+dhLQ4/NotA256l55/7KXodi81iqifRjDGFb/coVx/Z56nCrDlz2j+Fn0wj1i2OgVxAcg7WTEEre97paWzndIdgEQCBZMN5BaQLnZvDdP6pwWrkfKvhD+sEVJ/nFmuzHKr00ECCQC3j9ObP0FmlDjcKto1lUUs4AdZrzPNLFn1A7pM27NsHDwYYTcds8K2Ot0HaqKhb4MBxdqV1XWUybpRC6g3IiNbInVXpq3epD3CvtKcYOqkZeW5DX9/jCL7FEfd8vzOhXaBZWJhouNydIsGYlDjSb693sOXuf1bP+QmfS2qltjP0tGKXfHjoyqdpT6MepwkSph3rKPulY20GEgjOoz4i0SJY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7046.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(136003)(346002)(396003)(39860400002)(376002)(83380400001)(1076003)(2616005)(186003)(8936002)(4326008)(36756003)(2906002)(8676002)(5660300002)(7416002)(66476007)(66946007)(66556008)(316002)(86362001)(478600001)(6506007)(41300700001)(6512007)(52116002)(6666004)(26005)(38350700002)(38100700002)(966005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l+F3/BnhQenHoxlGGFrMWmCJVmmysEzH8tstsjBrgQnResBfvPEqp24/vQSV?=
 =?us-ascii?Q?okwXZLCtGI1B86UKLuu6NaiA9z6WqgLCmwqynU3+LFNtOJwg3lDXEANsvTNd?=
 =?us-ascii?Q?miUOosV2iLX9+xKlz/zI92B7/raRBisjFVwXA4BBPS72v5Jgt1Vonw/TVN8Z?=
 =?us-ascii?Q?xjApA2hHxSfXD0p156D7q1ZyQhN1RmCr62+6K5BeEOYTQgkiRlidcLnvExGu?=
 =?us-ascii?Q?vYo4ru5Je8mO0xkeXX9LVkix4DqrPwJsvq0xk3LBTl3Wj5O77YyLBR5i3REY?=
 =?us-ascii?Q?hiDl5/OTnFIbZWRK74tcxoKKHBdbj7VvXOKtSTcPsAZA/4T8ipOp1gTYkDKv?=
 =?us-ascii?Q?SOrBbwC+XjsQKYRoE9d8CBzqxLP9vuY2L90w2VwIHJoRhTy+he8+5aOQeTtE?=
 =?us-ascii?Q?ZanvXj01+8WWan1VdoQK3+EDcFMg2ZGAfESYhhj+IX2GTSph5IM1CVkU4AY4?=
 =?us-ascii?Q?ZNl42y45kglg4JExuOWAP/tyJapOY8JehRBzq4xtxLbIwCF4vFGFMLSGwWnU?=
 =?us-ascii?Q?aIDeami0PVQv8v9QDIeHdK4v9SaFW7t6910strUAwSS3/sMHGh2eYLvfSSbm?=
 =?us-ascii?Q?2XoE2uIsC+G1rD0VCNH7e0ofiD/HavMS+sHdBK5OAdslLYQ4rGKMb466zTWO?=
 =?us-ascii?Q?2poOpxr2SkeEATcD6X4WTHNjuzaVEtFu8IXyQn8aSymd2Z297g0NeaGgCeC7?=
 =?us-ascii?Q?GdvdnYL+ZF9SShuzIMaYHQPWf3JOf941wP/9zBi9pgVhE4J1nHHWwMDVVqgU?=
 =?us-ascii?Q?ZiFNJs8Q6j2KRvSNd7j5RUNYVqcyhgwhnp6DR842cgtsXZNdVzpqBsmoP/8Y?=
 =?us-ascii?Q?piw6yT8+6QGfbuH+G2QyBgSGLYMtVu4JPI6KXtnOi02ckhzEJzh404zf7Q0h?=
 =?us-ascii?Q?SuMfOZOuX9+VRL7L09+cZJUrLbW6xzCViQ004tVdGoG0465BmCwU9GSh+efm?=
 =?us-ascii?Q?/65qGz0q2IqeL7jNEe+Cn+qM5+ybwgdA1mc8KghAz/a6aLDnT3PKCevokubq?=
 =?us-ascii?Q?vrrXMnmHVM7RDGalIMLXNyHpoMMnm0i42M8jdROLDrTRM1ZYXB+NvZ7WLisd?=
 =?us-ascii?Q?0cvt7T0W3izEmIpuHKlWRMBn08P8cvmup5VC6Pj5ariUTLJq2ethQbOcD+F9?=
 =?us-ascii?Q?6FKh61OLwwpn19RzRlzOnuoFMc187UEHqJ0wk0w3hXdBQqvLMclEv4L/e5cY?=
 =?us-ascii?Q?m2AtJwb70Mvr+BmzkT2lWn/RJWwPSQbWexoVvXFQR6jh9dTDWbe6y9H9t+Lv?=
 =?us-ascii?Q?kz62XGYTEW/l359K8aTw73/4rs/v4vgXnnvPC6DOAOF+QTOIYxeXNVWPzm//?=
 =?us-ascii?Q?oyh57QX6U44sLWPD5gj+NlokGWlrDERWdMOgKwnYT7w3K9+aDtICi2ozd548?=
 =?us-ascii?Q?zVL7IFu+0apro4RVV5KD/1pPkaqla/940YuLIMKrzhR0nM3GF14A34Qv8n11?=
 =?us-ascii?Q?2XnPTCuLz4+R8MO/kuTX3zBhoGz3XOd8M2AkPJTmLheWJdyIJ6MeWIDRUKB2?=
 =?us-ascii?Q?tmNbtqt7i2Y7V0CqKGnYAia1y+46If7aVigo0NoHsMcvKWn78WmFQ9jiXySr?=
 =?us-ascii?Q?nsNy2L5JLSe6cCqIyNNSC4TU5ujS0qxX6BhCkN9z?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b7a24b-38e2-4328-ad3f-08da74564d7f
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7046.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Aug 2022 07:12:04.4131
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4htUVKorwC9t7JlvjAN5jpDNdRDzLQ2uM6r1eKjrtlf6UTdaJpKTJsS2wNZAs6Om+7sc/sByXJvBQyHjK9srLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6429
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Freescale i.MX8qxp pixel link MSI bus is a simple memory-mapped bus.
It is used to access peripherals in i.MX8qm/qxp imaging, LVDS, MIPI
DSI and HDMI TX subsystems, like I2C controller, PWM controller,
MIPI DSI controller and Control and Status Registers (CSR) module.

Reference simple-pm-bus bindings and add Freescale i.MX8qxp pixel
link MSI bus specific bindings.

Signed-off-by: Liu Ying <victor.liu@nxp.com>
---
 .../bus/fsl,imx8qxp-pixel-link-msi-bus.yaml   | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml

diff --git a/Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml b/Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml
new file mode 100644
index 000000000000..24f50535f5c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/fsl,imx8qxp-pixel-link-msi-bus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MX8qxp Pixel Link Medium Speed Interconnect (MSI) Bus
+
+maintainers:
+  - Liu Ying <victor.liu@nxp.com>
+
+description: |
+  i.MX8qxp pixel link MSI bus is used to control settings of PHYs, I/Os
+  sitting together with the PHYs.  It is not the same as the MSI bus coming
+  from i.MX8 System Controller Unit (SCU) which is used to control power,
+  clock and reset through the i.MX8 Distributed Slave System Controller (DSC).
+
+  i.MX8qxp pixel link MSI bus is a simple memory-mapped bus. Two input clocks,
+  that is, MSI clock and AHB clock, need to be enabled so that peripherals
+  connected to the bus can be accessed. Also, the bus is part of a power
+  domain. The power domain needs to be enabled before the peripherals can
+  be accessed.
+
+  Peripherals in i.MX8qm/qxp imaging, LVDS, MIPI DSI and HDMI TX subsystems,
+  like I2C controller, PWM controller, MIPI DSI controller and Control and
+  Status Registers (CSR) module, are accessed through the bus.
+
+  The i.MX System Controller Firmware (SCFW) owns and uses the i.MX8qm/qxp
+  pixel link MSI bus controller and does not allow SCFW user to control it.
+  So, the controller's registers cannot be accessed by SCFW user. Hence,
+  the interrupts generated by the controller don't make any sense from SCFW
+  user's point of view.
+
+allOf:
+  - $ref: simple-pm-bus.yaml#
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - fsl,imx8qxp-display-pixel-link-msi-bus
+          - fsl,imx8qm-display-pixel-link-msi-bus
+      - {} # simple-pm-bus, but not listed here to avoid false select
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: master gated clock from system
+      - description: AHB clock
+
+  clock-names:
+    items:
+      - const: msi
+      - const: ahb
+
+required:
+  - clocks
+  - clock-names
+  - power-domains
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8-lpcg.h>
+    #include <dt-bindings/firmware/imx/rsrc.h>
+    bus@56200000 {
+        compatible = "fsl,imx8qxp-display-pixel-link-msi-bus", "simple-pm-bus";
+        #address-cells = <1>;
+        #size-cells = <1>;
+        reg = <0x56200000 0x20000>;
+        interrupt-parent = <&dc0_irqsteer>;
+        interrupts = <320>;
+        ranges;
+        clocks = <&dc0_disp_ctrl_link_mst0_lpcg IMX_LPCG_CLK_4>,
+                 <&dc0_disp_ctrl_link_mst0_lpcg IMX_LPCG_CLK_4>;
+        clock-names = "msi", "ahb";
+        power-domains = <&pd IMX_SC_R_DC_0>;
+    };
-- 
2.25.1

