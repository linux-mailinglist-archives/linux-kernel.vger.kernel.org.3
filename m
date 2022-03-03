Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB6A54CC920
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 23:36:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236946AbiCCWhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 17:37:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231475AbiCCWgz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 17:36:55 -0500
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2082.outbound.protection.outlook.com [40.107.22.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A40144F53;
        Thu,  3 Mar 2022 14:36:06 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVt5GMonRJACsBtP1rMFomvsCiGlJEOXk+EmVIIgzwVGucl+n+rXP7jibXsspOUHd7NWtmmGV+4eG3xL3fi2Bcn/LwC6ZsTfxcbw02ZENx2EoVrDlkyIzN/u2qjRCfZTOBQhQTC6t0VteLEGVho/TClXNpBfbipX9n+IkVgoP9AaCMJm7/00Q5SqSxLTeVXvVaWP0Bs8E4JnF9RB6mRpxfo3Pjnla8J23zjidgwma+TYBkT+Cdmh730THl/j6n+uZvhsN/Bdr9YIXg16P7vCHrl2fWj3Xmr8fd5ICL/KTjNjNTLabNCk7fVyzaiXxoNPH5OzqN6I3q9VCdgXpQu0ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5K6zQeSq3sQcrKCaApSUoICBfsJi/RsiIe4H2tEgccw=;
 b=PXxwt8I7O2v44xK2cFcR0y0eG0hcQM4LMoUJFPIN6Krk5zvTpLJPDmCzVWGJ0YOCpA+alyMQ9S5st/j+xSQ6xmvXTpKtpSAE113CExaOfIenS1LVoUKOzm4Frg/8N7nPZo5hTFjuopMLRi8PmbW1OVMu2hOBSvdk5Vt8KXHdQMGFI0pE6vCOaNMK+g/e3APc3tPEI5AVV2qaSzhofnCNQq6ReHPUlAusOOp3y6oBCTxNiyizjl9wnlopKw5dRh4QhKKymqWy9UlLs8lsxtelHZ31hE5RpfS9OyB/zujGn+8cI7GIGoQLZb34BIwnSWS7CA+7sFZG763PFzd+Fa4j3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5K6zQeSq3sQcrKCaApSUoICBfsJi/RsiIe4H2tEgccw=;
 b=QL86BDLq4TteqUSP0O37KrDKS2CzfH+/EtzTHdekQalKZ7DnpnprL3d6nciNaBsMtsmRz9WY/n22vBN0oPFeqM5CFANdazjdGJBFsVc09rwXy89Sw5FjtkvVhBz6qM+AI1lOHwWvDooxvpRkvJFDC7DIwtPw3GdvMvBWTDjMYkLYnzxAKTZy+q1XZuvpG+SgRT7yIiWX6alRKpfoXhB6nvRlcmJFWNhAJje+BJMqVqbbj/tvHkRe4JPhzjoArkaXOHe7XhTIbXrpFdDZwB+tYUqPfZ+WrnquJH1zsaUF988dyirOXX1KJzJ+POmUS45TXbiJNqBl8Gf4VFUBXBZ8uw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by AM6PR03MB3878.eurprd03.prod.outlook.com (2603:10a6:20b:22::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 22:36:04 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::9130:93ae:6e27:e9a]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::9130:93ae:6e27:e9a%4]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 22:36:04 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Mubin Usman Sayyed <MUBINUSM@xilinx.com>,
        linux-arm-kernel@lists.infradead.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, michal.simek@xilinx.com,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v14 1/2] dt-bindings: pwm: Add Xilinx AXI Timer
Date:   Thu,  3 Mar 2022 17:35:42 -0500
Message-Id: <20220303223544.2810594-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR04CA0009.namprd04.prod.outlook.com
 (2603:10b6:208:d4::22) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7be3fb09-097e-4132-b764-08d9fd66337e
X-MS-TrafficTypeDiagnostic: AM6PR03MB3878:EE_
X-Microsoft-Antispam-PRVS: <AM6PR03MB38784C33006F76442C71ACC596049@AM6PR03MB3878.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cXUhF6E0AePhv9m2pHw4KPRwTrir4ldIeqtiyLHL7R+qN0Hi1DnfHAAIrrwZ/YK7lmiRGqT748SQLjNY+bCgxAcWjE3n426r8Y253a0cpeyJjZQLoi5VeHe/fFUAwq567ixlj+QUuZg+rwjdjhhK/8NlyWbs4RALzU6hQRQX9pmqvIGRFe1Ipmk1xTer2ezJeGxNTq2uTbGmRfpm6IVUIrzAHPK5s2hyMISR2Ud60Hww3nQY0aoNYvegM2iaurx7ni0eMDGAXVIB/jST/05OGxUzzItxhrgyT08J9AuwZij0OhRJkkWBIIcC6GtODOOrLs3XcO6ZCN1PpaCusHnMfzzG0Y50NVDJdfGtrkDeO8AGNlhsR1JBD+WGV0XK9IqBDj0qNtUmWSZctlII07q9/16QQ50vrYNOFIE9PAxFNqtMnz43sFH5+I1sFi6FOfx2Cw/R3gENpZ0tbKcA5O+hLsBZJEUeUOwgY/j0ZXlrsHMuqOZhPcbn5JLr5kS/reyoepAh216tiZYd0wjFyr/P0SEQrJGLD0+SRDtUywpdHeVrWKnJAGSvOUTndyobZUf9NqihtC0ygaNbXtzkUNkof8A9TFfy1YgbxrTEbAnfofGfk4XSgVgNF/STcgo0zvCMDkfJTCzHYkY3BeUCT8NIy0ruloJla2Fct/ZkvKAlEgOGS0jF5V1Vv6foTw5LXwtp/tDbs8uxtIEQx8hQqDtU1f7H8rfckG6GDnEZwfLBTphoXYxvLxn3Er7Vy1+nZSzgh27TTzU51RCHCqAEz99YgvKxekKH9D1ft9SvpCA+AYs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(6512007)(26005)(2906002)(1076003)(52116002)(6666004)(83380400001)(36756003)(4326008)(5660300002)(44832011)(8936002)(7416002)(8676002)(38100700002)(66946007)(86362001)(2616005)(66476007)(66556008)(38350700002)(508600001)(54906003)(966005)(6486002)(6916009)(316002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NQE5Tj9ccIk2ACdPNwzg+ll3G769c5YnOTEtulGoI3Zd6sEurm9YEvQEHU+L?=
 =?us-ascii?Q?OpMlzqFb/DNCi5OFVYZtoNeaFyawiy7Auv4OKXLi2UhkKIXGbDcf9A+Z0fRi?=
 =?us-ascii?Q?cTYvqHC8hjF1/xnYlqt1ea3YHYgrig8VRGLXUnZmi0UzdVu0bGwYmRKt7nlW?=
 =?us-ascii?Q?AcfENXRU2nl298RChaMmHkRDmkuzgIOAsn0LcBj9awENgxWFlaBgSWt9b6ws?=
 =?us-ascii?Q?HeA6zq2FtuL1KndKyt/7y2CShZfV7N22UlHchcf4ceTwW2bE0Hg+TCPVhMNw?=
 =?us-ascii?Q?s84ulFM4XHJODvMTiE/iqpQ8KQ+6+dmCPDptGsYJg445+gW1WS4ruCFcyC6l?=
 =?us-ascii?Q?w+xeq1r5l5MyI7o1vIts5sP4BkxzMQD92p2tsD9m9miMjdjmLIpAEYFC4iXm?=
 =?us-ascii?Q?KzlUiT3XNnGOCOctjG0UjbEZ23u2BiqeJOPWNaHeSPxmQyjH+R85Vm+8JwLM?=
 =?us-ascii?Q?V0DD6t5o3LONdPO74Mnb+7YYIGqq6eOAC0c5Ns3vj2kLg9EIXJCRov39i27S?=
 =?us-ascii?Q?v4/7bB3WOUaX+A+hQ93JqQ9vdJuyQD/EjwhXt9FCI//zbnkcdJkBo4G7ZuGx?=
 =?us-ascii?Q?zV/ZsqyAhhCP/otYHbe9iyoKiMyTcfwcKzWwnfGX7vQRZDRs+hqhSzkux+4H?=
 =?us-ascii?Q?xKfClicfTzsTDkq8hplS6R6l5vmp00qEU0W6658SO3gEDqg8K8L0Cp5PSaMC?=
 =?us-ascii?Q?RGyGRjpMA6dU6N1lvm7HjPvrTXW23zIc+veOa93aNLGxnu5mbQA71x0IkKCv?=
 =?us-ascii?Q?lbyPJp4tgmgwTYpQWv2fduIRHcuYkDmt2XUClJHX4KXsG6uqr1JVT3rJ4pPK?=
 =?us-ascii?Q?Q+pMhws3lQeOLVznsf1llnnfA+PcjBWDWKmZcj3pkm6Wb3miBVSFnKJASzCP?=
 =?us-ascii?Q?2aFUdojjjwl4wrglOpgtXuyjseMuYJu1HnftYE9p9VvQmhFBlmAjcmeLLT4n?=
 =?us-ascii?Q?WrMyIsN6wJTKg6vjTGDtMipqOtvZOor0M/p7qOkJeLlMY18qIJ191h5n28Up?=
 =?us-ascii?Q?HP74HsEpFX0OIb2J+npnH9QOzpW74wpOp+sjbHBN/647CfzmncheM3AKzbx2?=
 =?us-ascii?Q?QFSPAiiUIdK7JIw/rOjsw0pFDxTFtypMhksWj1FtlzCP2x6BbtTx5B1tuIPZ?=
 =?us-ascii?Q?z/YVO62r2muopzH14W0ILfL5kIVypJAH7lxdPJSL/F7KVQSWVFjmTH+5B4o5?=
 =?us-ascii?Q?tJLTVlWxBORCVXR5fdpvd3HKUOxUk6rEFFQlnOPamG2glRoT/BTABQHgwS9W?=
 =?us-ascii?Q?p5G81GLa49WJbSCBLlJkjf196Zour58VEyJmzClpZIqsQrf3AGKBgeY7G00I?=
 =?us-ascii?Q?ROSJ89e29c6Os+B68Dyq5ErEn5dfCRWhPCi9meEJZboKpzYhCuQmOuOQmUnG?=
 =?us-ascii?Q?Y39SjzRr9uF66Ok1giL0wGkiUEqyURbKpfGpK+xgEQfbxmVyqKdh+UHje+l2?=
 =?us-ascii?Q?kg54ZswRcVGx/Y0abXn8lN9fjbnO6OKYUCAH4sS2PkaSu0C52kOBFnq4EpuY?=
 =?us-ascii?Q?ND2GXyRM8rMY5+AMrZa+/ezg7f78RRKW8TH+771oVAXQlKwqKWRDCXQcAM4T?=
 =?us-ascii?Q?AtHPVZ40+HulUc5CPJb3GGmrNOKcAceqYuei8PhlClGj/VV3sQ0ZbYf9wf3g?=
 =?us-ascii?Q?1ycGOhlGyqtRANm2/gExJTw=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7be3fb09-097e-4132-b764-08d9fd66337e
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 22:36:04.3007
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FbehmPZB4B5lBToBu0Vevwli2Tw9IQ0a687RFEh6mfKU0SiFnJulzBGeSQZPwbMOf4wjvHk0U/AIjbSTyz01sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR03MB3878
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a binding for the Xilinx LogiCORE IP AXI Timer. This device is a
"soft" block, so it has some parameters which would not be configurable in
most hardware. This binding is usually automatically generated by Xilinx's
tools, so the names and values of some properties should be kept as they
are, if possible. In addition, this binding is already in the kernel at
arch/microblaze/boot/dts/system.dts, and in user software such as QEMU.

The existing driver uses the clock-frequency property, or alternatively the
/cpus/timebase-frequency property as its frequency input. Because these
properties are deprecated, they have not been included with this schema.
All new bindings should use the clocks/clock-names properties to specify
the parent clock.

Because we need to init timer devices so early in boot, we determine if we
should use the PWM driver or the clocksource/clockevent driver by the
presence/absence, respectively, of #pwm-cells. Because both counters are
used by the PWM, there is no need for a separate property specifying which
counters are to be used for the PWM.

Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---

(no changes since v8)

Changes in v8:
- Set additionalProperties: false

Changes in v7:
- Add #pwm-cells to properties
- Document why additionalProperties is true

Changes in v6:
- Enumerate possible counter widths
- Fix incorrect schema id

Changes in v5:
- Add example for timer binding
- Fix indentation lint
- Move schema into the timer directory
- Remove xlnx,axi-timer-2.0 compatible string
- Update commit message to reflect revisions

Changes in v4:
- Make some properties optional for clocksource drivers
- Predicate PWM driver on the presence of #pwm-cells
- Remove references to generate polarity so this can get merged

Changes in v3:
- Add an example with non-deprecated properties only.
- Add xlnx,pwm and xlnx,gen?-active-low properties.
- Make newer replacement properties mutually-exclusive with what they
  replace
- Mark all boolean-as-int properties as deprecated

Changes in v2:
- Use 32-bit addresses for example binding

 .../bindings/timer/xlnx,xps-timer.yaml        | 92 +++++++++++++++++++
 1 file changed, 92 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml b/Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml
new file mode 100644
index 000000000000..dd168d41d2e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/xlnx,xps-timer.yaml
@@ -0,0 +1,92 @@
+# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/xlnx,xps-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Xilinx LogiCORE IP AXI Timer Device Tree Binding
+
+maintainers:
+  - Sean Anderson <sean.anderson@seco.com>
+
+properties:
+  compatible:
+    contains:
+      const: xlnx,xps-timer-1.00.a
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: s_axi_aclk
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  '#pwm-cells': true
+
+  xlnx,count-width:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [8, 16, 32]
+    default: 32
+    description:
+      The width of the counter(s), in bits.
+
+  xlnx,one-timer-only:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [ 0, 1 ]
+    description:
+      Whether only one timer is present in this block.
+
+required:
+  - compatible
+  - reg
+  - xlnx,one-timer-only
+
+allOf:
+  - if:
+      required:
+        - '#pwm-cells'
+    then:
+      allOf:
+        - required:
+            - clocks
+        - properties:
+            xlnx,one-timer-only:
+              const: 0
+    else:
+      required:
+        - interrupts
+  - if:
+      required:
+        - clocks
+    then:
+      required:
+        - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    timer@800e0000 {
+        clock-names = "s_axi_aclk";
+        clocks = <&zynqmp_clk 71>;
+        compatible = "xlnx,xps-timer-1.00.a";
+        reg = <0x800e0000 0x10000>;
+        interrupts = <0 39 2>;
+        xlnx,count-width = <16>;
+        xlnx,one-timer-only = <0x0>;
+    };
+
+    timer@800f0000 {
+        #pwm-cells = <0>;
+        clock-names = "s_axi_aclk";
+        clocks = <&zynqmp_clk 71>;
+        compatible = "xlnx,xps-timer-1.00.a";
+        reg = <0x800e0000 0x10000>;
+        xlnx,count-width = <32>;
+        xlnx,one-timer-only = <0x0>;
+    };
-- 
2.25.1

