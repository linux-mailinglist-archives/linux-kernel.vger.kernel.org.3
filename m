Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 158844A9E89
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 19:01:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377320AbiBDSBk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 13:01:40 -0500
Received: from mail-eopbgr10086.outbound.protection.outlook.com ([40.107.1.86]:52481
        "EHLO EUR02-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230487AbiBDSBi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 13:01:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MiIEYgB2auWSCQ3WV4fqWmPDfp0kfWCh8nKuub8SykuMZzl5vjo7QOQ+8QJX0J6HoUfpmiBu6qbcunG5XkT1d0ccekimRXWZ1w1BWilAlLhXvggw3hi0Uwn6Bxb8XRr+4bhN0mSWFgbVGNtaqHHgNqpFAUmREKjz0BxQGjMtMGXz3UKf7uOEuMyT/Bby8s1xhGeQOwakd1M8jzcvELcHVC2J1CvrjNaNaNPlW6xbThE4VzI8j6lbpY5SrmTVL7zfAQAPoK2suYY6Z8DYnaDQqz7FVCpNJquUuAwP/KzUnkvX/BvFjCU+bZgdiSCvpPfroZIUOToo2JCYxK9YoJ7DNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5K6zQeSq3sQcrKCaApSUoICBfsJi/RsiIe4H2tEgccw=;
 b=VWM1gKLSVGkJU/oAkXyiSozt9xpnndYf40ztTCKvToezYrH+0obDrMLztYxL0H2ePIALsnkJU6WxewtpQSPm3g6JYJkGH2Jww+dliRaq1cvL+OZQQOSCBAmv7qJb6kptksJmLr5GTCZTqCWQyx4/Y15oIPbu/BiPHPw88fIo25RZ0+2KjiAMDSPkMJMewX+sEJ12SmwCESx8Nuk1iJIVqRvaIyLJDADDI8HNZtEcHYN2FH0qA3Azr3Qxjf97unnraqOIoghoQ/N1wSDC64eMc6SDEvd6u7s/wp3OpeLLcFBp1NL9vYkO6Ntns1Fas/uunTRn9uBu9G0LJanTiDwxhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5K6zQeSq3sQcrKCaApSUoICBfsJi/RsiIe4H2tEgccw=;
 b=cPTz0mdwsc3GHmhWPyjYwIBJt9ZAyfWVxCR+RqivJnX2hNrDxDY3IpcaIZWnfeavG8x8cx1kZmu74MccxZoAOL+eH+PmJaWHH7PfcHYF3qc7TXLmiyEyKWsgm5EqDEvQLV/HBrF6E0JbDNn0pkViDRRTY1F/XGx4kccbBzBSYf5F9zAfCK7Pc3YY/aNe5mZmB09gqTGFUX5Teo/tFZhnDrjlsU5un5j0Ng+M0vEdH17Ihq0f0uqqqIkAplGbeM4BzCY6dJRw5+vSQIjCRjWNUS3EFtI/TeybAA9sDFv6owKq8KKx9ZRDeAdeJj5phB+3gcdgu3Sun6ZbgRsVVynQaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by AM0PR03MB5764.eurprd03.prod.outlook.com (2603:10a6:208:173::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.14; Fri, 4 Feb
 2022 18:01:36 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::ed45:f086:5e82:fccd]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::ed45:f086:5e82:fccd%4]) with mapi id 15.20.4951.016; Fri, 4 Feb 2022
 18:01:35 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Mubin Usman Sayyed <MUBINUSM@xilinx.com>,
        linux-kernel@vger.kernel.org, michal.simek@xilinx.com,
        Lee Jones <lee.jones@linaro.org>,
        Sean Anderson <sean.anderson@seco.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v13 1/2] dt-bindings: pwm: Add Xilinx AXI Timer
Date:   Fri,  4 Feb 2022 13:01:05 -0500
Message-Id: <20220204180106.154000-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0433.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::18) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 204f03f5-401d-45c2-bb28-08d9e808626a
X-MS-TrafficTypeDiagnostic: AM0PR03MB5764:EE_
X-Microsoft-Antispam-PRVS: <AM0PR03MB57646A4CC1595F19967EB3C496299@AM0PR03MB5764.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QVaKYXqNF8BlhuoxhelPRVNeOhmBCJAuWeYFEiFdwY9O9idLWZ99+WYcXMcTnE08vHYkMdSSjLJ8D487qUJRBw3Xi6vJ0iSMvQNUERI70imGZX1V6fLkLVGjEpkRgikSfGOI5ZqOePeznZ5qHQ0CGGGqibOe8jDBZXGj4hY3jEV7vbS9V/i/YaRK8Pb6rDinupshaJ+9oxC5uYWThxKxpAituu7WK6HrEt5RDVniS++D75c9tm6Xz2iW5TUZOiWnwNfQfJEjz5mecAthd63O/C6sOIdAf3UQ0syQVtFXA5eOcj10UsY79DFfUxsTP0zRG9AQyXj51OPzKQBoU7fOQxPPbesX03XHO4Oni6Yq+AarQZUr5a+Rgd9RGJVl3SmK6dblKSxAhG+o0+c3/nGMi+/QrWZKT88ePukubWZO+STRVvz8eBg/nkBmcvIZ9TLsIoeQcorqHCMj63t5TzPDc3stCE0pbqFLoNnbXMmLIsm7lZ6XqW91mjVllWlTdVLukkDyuNuKJYrB211tu8N5VSluHYwjNkAWc83Z8FJgIAOJXR2pKtPj4aRHnLd98FebHI11lY2xu3i7viW4DqWiK5eNJU3XCkFl1aMMGLl7YWX/SwvA87+jTmxEsjRoBTFUiM+BKRv2whnbb8yXWOjHMA0dpm0QYKskjPaP6U37Y4+TXKeATP1YAGdVhYf1WiK/ExbnCuS+K3M1bdC0wfOSCmaXS3mh0yPF1KZhbn61Ky2P+j6wqRrCj7aJe0wtUa4Qzn0yqaS0GNm5zJkHnH8dctpGRiwIq0wGNwJ+LNo7c48=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(83380400001)(52116002)(66556008)(6506007)(38100700002)(66476007)(86362001)(36756003)(8936002)(4326008)(6666004)(316002)(38350700002)(8676002)(66946007)(7416002)(5660300002)(2616005)(2906002)(26005)(1076003)(186003)(54906003)(6486002)(44832011)(6916009)(966005)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bvGgz7csUoYVBKYsg9ZFprzfwHetVmclmF/Gj+YXXXnLhTr49t0QCprZKhL1?=
 =?us-ascii?Q?8P5VLb3bA7MHvB1KwEueI4WX5TrZtTHwySJYT7X2m8LOvSrzBygNcwVxNvaC?=
 =?us-ascii?Q?Cy9noTo/Lb6uuIzFKn12oRz9Db4kl8QnhKsf5wxZknq2cRHbJOijvTwBLPZo?=
 =?us-ascii?Q?w1biRZk4yk9uvjiunopxHchI7WyDWLPjiX5TuXtiHT+LyuGdCYr7pSbLfjWL?=
 =?us-ascii?Q?THBSi5ZvZCW8NpZ7oZl2jWZbrL7ZPxse9qdZa3Ehf1aIfVc+eIS852DKoAFr?=
 =?us-ascii?Q?CpOwztlRw/cXh98HG2+MQQ8iyLnHB/bsEWzsaZKsm8LC8L+dK1nb1YJHELJL?=
 =?us-ascii?Q?JJJHlWsDgVVuvNogq+8Kxy5rMzWRFUeQbhUCYFDOXRMVTINHuQlpNeD8aDr9?=
 =?us-ascii?Q?+DZDEoTDyUT7xMdRnQpRoaCZoEN+tuECowVb7viU/4u6xhiO8JD23i1yRCoS?=
 =?us-ascii?Q?qYyr3jaW9kcjNdEw3z9HtBEH/i7kI9kMjDEOFjIC5o6SuJ4B1JU0mnOeZ9V0?=
 =?us-ascii?Q?C5Ih0FvNTj6/tTK0wXD/FVkp0Qaml32HEhF+yh9RnY+Tti6v9FS7UZdcHgxc?=
 =?us-ascii?Q?+hkri0xArIfbEA09v/9wKJxtsy+4PFGAJiug3CkDLczaQukuoXNJ/FFDmM5Z?=
 =?us-ascii?Q?f7wglKvo9wgCAPCxQgF7R6uFMeB/8p+HXQnVxaCv6dsE4JgecaXm0iyXHyl+?=
 =?us-ascii?Q?g07+arjQqcHGHBf8RADl0IJq1RrazJbOcG6T/FRezr5hAt8LxFeJ6MT4btQ+?=
 =?us-ascii?Q?iQxOkF9bZTHaIAfcssGyzU/PU9X42CLteWl0Lp6EdJmpGcZE1j0134MgGsKJ?=
 =?us-ascii?Q?zERcCCUFEgPra/nB5rvO21gKx0beRtEM+lOgcVRdcczGynUpbXnihqnN8b/W?=
 =?us-ascii?Q?W5nF79ExLDUG+nTE3elB/ZjNhMOUwZgy+XISN6JisNuTmmy8Fs2kmSdMd2Xs?=
 =?us-ascii?Q?3lEzYHy661EwawKyHfFqtOFzINFcqzfBLgy/T47LSeG6lmPyS9++iLOuR3fY?=
 =?us-ascii?Q?KqwRO0Tp70DMHlWdTpX8imT0hoEjudrvMQpSTJbmOzzEdj86QhLOED/con3Y?=
 =?us-ascii?Q?Zm+ywsGkcg9E3xyyXwIfDe09gNuI40zL/3Er6QVPV4pzuwk/GpPmgPnSJ35g?=
 =?us-ascii?Q?4rdGxp09R9i68T4qTmSfFEYd6mI4yAGXXB2hJ1eTS7nyMGUU4trxi4NRDOQr?=
 =?us-ascii?Q?G84oB82Ni4/8iUuhcPMJUpZlQbWS2HPOivh5MCKCsCEKD2Daizlaqy1WHHrM?=
 =?us-ascii?Q?72kz5u+GaCIxYK7puL5JlqpmgkSfYML0qGsjICDJ99Fd0uAtLqi0N7DvHKRI?=
 =?us-ascii?Q?vtK9gtWgywZjo0JO+O16n3JaxrkwgobKule5Hx/H8VOyMYptxXh4Z+/4jUiv?=
 =?us-ascii?Q?Kuv8Ivp0rqDoKKyR+fkpBX3yUDbpeUYu4ifJMOhQWvr+i8qhWvioJ0RhAsSZ?=
 =?us-ascii?Q?/uzGesFQxm0ikbaUNivwGajW9sDhDg9GCUOu3ZhzT6X7xdOJBXQv8whafP6Q?=
 =?us-ascii?Q?QM2rNIqCB2aXyxMEtJmFikjXbuDL1kNgfqeUy/whI0k0t8+ENOONCjkVnr/Z?=
 =?us-ascii?Q?SQGAGjznTQvU8ho40CvlDeePf8lp21BvjcTi7ApEavlggyrzbGbJMz5u4in+?=
 =?us-ascii?Q?fkJpE+Zd30IxDkvTeH4k17Y=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 204f03f5-401d-45c2-bb28-08d9e808626a
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2022 18:01:35.9117
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z5VBL5wduK4IkP+SCvDTXizBOhJI9xQw0sXjCvIlHyp136fHdBGkQz0YLGtGyIBMMcy1Khk5tkMRmFR4Wmywqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR03MB5764
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

