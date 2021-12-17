Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11710479787
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 00:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231268AbhLQXab (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 18:30:31 -0500
Received: from mail-eopbgr40084.outbound.protection.outlook.com ([40.107.4.84]:38368
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229911AbhLQXaa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 18:30:30 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSLiHHqEs2tUOhjoteCjG/S6upwWEb+kS76KCOQyorOS4aVnu9xgy3sH54LDNikYbim1CEOH56BxlIZZmCku0/fJrI/hZhY1rNMM5QeLVwsF6Cy4Jlo8yVwFOCOgV3cK07tnZspKX4m5uya8RnchDYrHnFm2hcxpKpixeXh1VsiaPnGJrkpDhK3gfzXEsjj1SqBQPdrsgOEQZF7ujtwBsC8B/4fDBMG/Xt+3YS2hSvUq89A11OzD7O4aEoGKb6uguEQ5YYr+Wq6xE+DTW9jNst5JX0luFzhQrqybDCk6k2nH82oOnGG241STbDjXwolbhr0iDQbIFj0sOOS68415cQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5K6zQeSq3sQcrKCaApSUoICBfsJi/RsiIe4H2tEgccw=;
 b=QNExOxXhJ3DvYaE8OiRfMPgnU2IEcdZ/eETLVA+PgT8mFcUDkQTqi+l2G8GpkTF6XzoQ5gJUVIPVaRhpBYX4RxrKv70UcQQPBj1FNaeEjEkNWDYc3ZlCBHj3yHMzY60AxwxYN7JWTkDEENEtpYjqGFuvtD+1d/4UBYQAtlUXcSvoaP/mCflaDQL+Xxa99CRIfosndpg/FBLV3OR8iAWzc9IFcXASh7Ix5dKMl8Ln/+3cjdqBmyzz+1+6bYDAgQP2cRoaogvFCP8Uo6Dis/hUb4yqBzVHp8o3p9RK9075mtt4IdUAp7yCQDVZV3qsedFI7RGbAzPfbeAA5LB4hJGCxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=secospa.onmicrosoft.com; s=selector2-secospa-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5K6zQeSq3sQcrKCaApSUoICBfsJi/RsiIe4H2tEgccw=;
 b=yRJrQQYIa944xWojB4TID6Sv9pM6w/anIBi1jkNs9Cj6sHX0bw29ZryCUqrQ3obHiwcBaRcRrD22KpuySaVxC6IIYRSrmW5zyEbgr3AyOqdwkm+mRayYQn7W/xgkHrDkPpX67bymf640mV0GLL4CEdsI6q1Wt5EKaSnIrkDjum0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com (2603:10a6:10:19::27)
 by DBBPR03MB5142.eurprd03.prod.outlook.com (2603:10a6:10:df::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Fri, 17 Dec
 2021 23:30:27 +0000
Received: from DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::9093:a60b:46b7:32ee]) by DB7PR03MB4523.eurprd03.prod.outlook.com
 ([fe80::9093:a60b:46b7:32ee%4]) with mapi id 15.20.4778.019; Fri, 17 Dec 2021
 23:30:27 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Cc:     michal.simek@xilinx.com, Mubin Usman Sayyed <MUBINUSM@xilinx.com>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alvaro Gamez <alvaro.gamez@hazent.com>,
        Lee Jones <lee.jones@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Sean Anderson <sean.anderson@seco.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v12 1/2] dt-bindings: pwm: Add Xilinx AXI Timer
Date:   Fri, 17 Dec 2021 18:30:14 -0500
Message-Id: <20211217233015.67664-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL0PR0102CA0039.prod.exchangelabs.com
 (2603:10b6:208:25::16) To DB7PR03MB4523.eurprd03.prod.outlook.com
 (2603:10a6:10:19::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58794715-2a7f-4211-666d-08d9c1b534c6
X-MS-TrafficTypeDiagnostic: DBBPR03MB5142:EE_
X-Microsoft-Antispam-PRVS: <DBBPR03MB5142D0E737565E8E726D7FFB96789@DBBPR03MB5142.eurprd03.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WdGgUoFH63UyzjBylLwxc6T3LG9t+dxoeEufTSuiVZ9zSZw3+0HKjn9WirGUONqkmKNzgDlPOOBGNuabdcDfKTBNo9ijdiLav0ZlIa8xVkQ52BgMsbkrKRlMEqf0XYV81UM3y1Lfcqqco6jFu16LQ+J2WKw+3qKwIhq3s0uXkpMApTR0hWEAYfdu1etQH2YOdT31lR9Rw5D5XOSjJrQXvkpkijAYXH7mnAWyzm3f49PsQGqLW/krCP8fZuQFG7NbR4ycQLB5ulqy3+0lVKefbhWJxcrlEZrmy2RAOKXRUNeP1AyTRKE++V4rTce+G2ZsHVsrWvzakeuT8UMAyIUoSIkDba/59GafLKWkEeQ7S4vOYl89c0CLI27t+09BvooAAWR64zBelKMBfhLGGbBwNhvoY+/oIaQqE2WZ91h97tny1fkwjVGqoFt9GorRc7fUuEhsWIhFkaKjOMMSGRjnE0nFiAwVOAd0aJoRypAnPknQ2qoURdlLxjOJerTzsqhoPMkeLQgE6tlCEWdgd/EU3MvCDXj+QMmrsGzp14GNeJZ0Cv7Wx4IX8qlt7ulr+rGAiN6x8tO+WmJ8eE/PXxHfUewjyNAuYtlwBEl8eJqrV6uEYSKLDSDUPmftxw7RyX88WnzQxA2wGKwD4nQSfZSKURC8OPPl9ULhskVFAIdksbFUSa3+HzNOZZOqIbSuXvZQ802OybrRlKS396K4eccezdVfI5Mxv2oPuvyTM7Ap4BZJ5stcF9R1SpjbHJkZa2+MFHiErw2P0XoXFVdisHYb9ROYRNdodzK7f5Yf/Ad9yfg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4523.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(8936002)(6666004)(52116002)(83380400001)(316002)(6506007)(66556008)(6916009)(2616005)(2906002)(86362001)(508600001)(66476007)(7416002)(186003)(4326008)(966005)(5660300002)(1076003)(66946007)(26005)(36756003)(6486002)(6512007)(38100700002)(8676002)(54906003)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?owg2ufVdVd0YXD7El+6RqSCJdVfozQ7rpWEFuzD0LYVMxAyxiAHbbnPgDmu5?=
 =?us-ascii?Q?l61530Om2FkugmcnzwJHyJS64brtP/z3NPiWXS9bd9xWg/oL29KWDzyOYBH8?=
 =?us-ascii?Q?EamXHOsAF2EZn1k2Idzh/fz6GB0PuS/ecyN4VgeuLTodO+3WYdOoMKzfiVe8?=
 =?us-ascii?Q?E/pcpB3LboiyddfZQMVBPfEX1APqNXUEy437Pf20dwRt56odDmwbqxZmQm4Y?=
 =?us-ascii?Q?CQ7Ei9FZYGqQUSd2AsbQKC3hoFIoMAJvzrf8RwjJnIWcYtTqnKrEy53xXWDT?=
 =?us-ascii?Q?73YhCyqMaStP1Fjsif7w8Co17YPR1ULRNthWoxSqMKjeXlSbQ9lIHsImX55f?=
 =?us-ascii?Q?yUapHPt3gGHTpmlp0rvssiRf2NeDDX1CA4onZ3MKUkUfjkPDvo6Mk930c0ph?=
 =?us-ascii?Q?rTh9ivv2nHq557AxoKbcH4eeZWNrBBa5M8Qi09bhhqwe/tPt/zmJetENlcR9?=
 =?us-ascii?Q?s379MlqGEKztQmxQOR/OCQk21VrIS9uDj2dno3cevSmxYc/PG6oJPaQxG2B5?=
 =?us-ascii?Q?XQIYProjvhkLclpCUXwVhW8No/nIWbY2GxtW6GkGFwDj5j6lmlt0zXoLgyxj?=
 =?us-ascii?Q?LDJWJiROWvoF3hE4lJO4vOYO8UKJJs1LJRsH0S+pdNhP9rvF7KsOGuAxg0gF?=
 =?us-ascii?Q?CCukDYjhEaiFgOVMdqIO4UK4XHHVohLu1xozLtv2Jkt5OlpQjTKuwgphj1EF?=
 =?us-ascii?Q?82gyJs5XCuS34ZIjVJBWzg3jIVgfv4yMPQxHtttBCIYrCHYyBHS7HdCkG458?=
 =?us-ascii?Q?6c0HNV6C2B20MNvJ745oU5ydGVnt/bzKT3X8dyfdt/1k7EAa7YEwrnAjKaGQ?=
 =?us-ascii?Q?q4RXK8eP9d6has1iwppfU9BHEwmaWEoZpHdf35to0UGLDY0tmMVsfiVPx3Vo?=
 =?us-ascii?Q?TSqSUZMttWJ2bNiAFj15WgURAQPouc6Irri8pHlC4N3ELPB1U0qlDIQekrez?=
 =?us-ascii?Q?XhKPXW76eTTrF1B1RnV2RQ/kfl9uFqxwwnT9WqlFbGmsYp13A2QFiPruvkwI?=
 =?us-ascii?Q?grFDd8ThVlOLHHJFFRS47VwmlFLFr+qMjXITgWanM6irfPRRW9tFHoD0aQC6?=
 =?us-ascii?Q?k9yAobQrYQTR1hROqtVsCpVvENO8evOuRRSooa1MwWBjJextNX4ca2GtIEAi?=
 =?us-ascii?Q?rD7sVDz4QOkPq/B0Txo5Tos7M8LCprDBTxgVIKlg/p/Q2PT3GgQsI0j1TS9E?=
 =?us-ascii?Q?2L6/fNG/HbsPJMUAArTACPpr6WVWC3hSdTvvQwT3KUTLqmRe5r0q6jClbTiq?=
 =?us-ascii?Q?j3EfNaJY6nmoBJ1W/BH5lCyHvffr5EfM/o6SG+43NYn6YEfG1kY39vzoUj3n?=
 =?us-ascii?Q?+6bL77tFNVHB/RIZJEhY4yzd2yq59mpifizR6/NBeWMFbyRy8BYU6WH8bQg8?=
 =?us-ascii?Q?HSPG3L/Ht9usrTnvwwqXatTndsRe+utBwEJ37U+9W5bY5nbxT8eNTGBl/x6l?=
 =?us-ascii?Q?fpcuV7zqr99zwU9ZXXkt0udO+U9FsDAZWhnEyik3uRInPjS4nMnk33nROu2J?=
 =?us-ascii?Q?m2JscIv4K15ICCDBIEW9RxWZlNK30+MT8/4X8FpxA1QcZmJ4bE+mCjzUxnG/?=
 =?us-ascii?Q?1Z6YFYwoAn2hsgmyNcdVaq64K6cyhf39ZtCGrYsco6sbK9v7RrmyV6MDPFxq?=
 =?us-ascii?Q?eNDOdwNN4iNTgoPbdBsNVnQ=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58794715-2a7f-4211-666d-08d9c1b534c6
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4523.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 23:30:26.9414
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Bhktn11fEv9xq2mp+nPUuYUodzsFXOpUfHOTIrDLJEdzhuF1RAWbTl1D9obYiWdn9jNj/FIzu+WSLvnX13qZiA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR03MB5142
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

