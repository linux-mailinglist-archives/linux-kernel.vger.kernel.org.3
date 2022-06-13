Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BEFA54A250
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 00:55:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240416AbiFMWze (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 18:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241771AbiFMWzb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 18:55:31 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-eopbgr130138.outbound.protection.outlook.com [40.107.13.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B304313A4;
        Mon, 13 Jun 2022 15:55:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jy4hJ5gFEvCY0EBrAd5EHaW8Gdr4LD7uIAbwcv2eU5RBd0P830CEiaW4jjUcBjd95SBy09zTMsVSU2VsGwENB8xqrq7+Va2Qk+UBYJiU2vy39Sl6XQEGM40C2oMcmXt9mvSTH/0mjbzhzZXWBBQOTPnpQyZFGNiCD60629rO5/A1Hu6UuVs26r8psSdu2roxc7alqnkFprrIXhm2S6Xe+hnrWp3qz3EJhU0/8Zd1sRTQdpu07C1uQXuCfqvKKtLwz+VHXSRwn2g6viWahfM+FWJYkp55HuzSfte0bXUKlqbOu70drRM5RkieKjYyHDOufYOaXVFT7zRzWcltR1ZIJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+F/u53EOSZoP5ia6cmC5IbPLJg8m2fJjQu7Zcs/l3+c=;
 b=K3jAr7dR7pUgjMaLNeYjlG2AUFkY+1GcpJIxXPB3ekytqrSgJTULuSa0gZVhbFeaROQsoGQY+3GKgcPvCLwnuJvNFE0xW6VdSOr8QDHa+iUXpf6SptxFFsTLZR95Jq1348o+hKuXzTCFOhP97GAG+H3MuKBSiSEN3WMNBFkGu/IwmbyYQzGQuIG4J902Eg5ZuGxTF9NiViWs6yCt5Ak81evTxV+5krGVaYjdtoQkorLz5cu9h8vj0YugA+5c6m4OVx9gUN5AXNzZ+exdkklqKUz3CYXoc0+RcNd5omUQ7CzhzTFgaQJpGIwwkoBo786JI4fL4A0Wfw6IC78JJiPzwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+F/u53EOSZoP5ia6cmC5IbPLJg8m2fJjQu7Zcs/l3+c=;
 b=VyYIfCpBSTSIsdZ9zwTb4QXJjBq5Px25xYpFSqG0BYHXHvYw/Ni4cgEwrsABIUu5OCJhNswDmZu0bYSIJt+4G0Fiw6waOB9TGLR8qrcDMGn6N5Bxh6YRbGoxxCfeETjc35Nn4yNcw4jiu4hRGLD/XaGewL0PHGZkl7Vn7gIUkpM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by AM9P190MB1539.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:3ed::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Mon, 13 Jun
 2022 22:55:23 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2c45:bc33:2584:959a]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2c45:bc33:2584:959a%7]) with mapi id 15.20.5332.017; Mon, 13 Jun 2022
 22:55:23 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Konstantin Porotchkin <kostap@marvell.com>,
        Robert Marko <robert.marko@sartura.hr>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v9 2/3] arm64: dts: marvell: Add Armada 98DX2530 SoC and RD-AC5X board
Date:   Tue, 14 Jun 2022 01:53:23 +0300
Message-Id: <20220613225338.393-3-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220613225338.393-1-vadym.kochan@plvision.eu>
References: <20220613225338.393-1-vadym.kochan@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: BE0P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::21) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 65688cc6-626e-40e0-fd70-08da4d8fcc35
X-MS-TrafficTypeDiagnostic: AM9P190MB1539:EE_
X-Microsoft-Antispam-PRVS: <AM9P190MB1539FB92A11A82349357E38995AB9@AM9P190MB1539.EURP190.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TiqTDQTEoeuCxPKhNqdbnydC5eRBmd2fl/+JSrHgk9WX+jr3Hi4PYSolPlIxGtTyKj78Dae+3HsWSwEF3cN+9pLgo20Mry+DDIpzPt0CS0uMhL+8C9lv4WzdsIZ7fEEYMtjMWwa0u/xaZyll+HUzkNsitapzsKQEDG0nHA5BFdEzM8HeFqJ2REhFLHq6McUU4Yzpz0GuMLEG2wxwQs+YRYe08YKx1zonOJSIH773dyALfSg6UQwsA6b+qZlCP8Iqgp2ML2Z6gawmDWO5m03lOrQaT3lTChbZ9WPG4IQbGQ44sXpSae716RoHMk7+k7fEaAcjTiW2nM+o1rGJUG+4KaFxCsfqJeEle5d5ycSuAuq7CXjJ+fFSPJ1RTfNT4LkwsbCYaNYmNzAA8VEA4Mit8V7mg5ui+sqHIohGMBf2C/nbeyTCcBR446gmWEELHEx8a6LWMLuaUwVuHNZ2wm343SLwipVBQp7Dnf+OtvnEQ1PFw2KpIuyZhsbYDCXnDCamn1YVNs/Y2TtZxnhzhNcKv3+WlUseJ8o7FeYM5J7gFDlxMqRLi0ljnJ9WOGQkNrDrfIcMC/DiXTWnHuFi1qEjT8bZUODztNkMwaE6YZrZ6TfYGdgBFKDaM+xCxjCj34SxD0l1VB7r8ip9nh970s3qjTmlOhj48rHvrdZxS/AjhblpApcprOJ/L97w4f2E/rX+NckmUl9CDQyaKKdQUVtVy1aOIhVKlvHzDkwi/estp58tiZTmtMk2pgx2s4ignVTfqkW+3IqSjsxDU3UoL7cdhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(136003)(39830400003)(346002)(366004)(52116002)(86362001)(6512007)(26005)(6506007)(921005)(38100700002)(186003)(41300700001)(1076003)(2616005)(83380400001)(5660300002)(38350700002)(7416002)(316002)(110136005)(30864003)(44832011)(8936002)(66946007)(66476007)(66556008)(8676002)(6486002)(508600001)(36756003)(2906002)(414714003)(473944003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6wsXvNAHaxUwAA9/ah5NZ6Ngd69zVdkXrPpqnAQJKO0F6GVN6tXmzK/b0yum?=
 =?us-ascii?Q?cGlkcAFQ/FdxU+xXzSd7TIiNjg7s8AVW29WHkbKNCDwCop9MDiK9aHQIxAYP?=
 =?us-ascii?Q?+jZzI00HC3M1pGNm4kMljJdcRxKw3PCuUi9TvrVnHsQIZwZCHYKQAEFWyopi?=
 =?us-ascii?Q?fnO6O16DHMgq/OocIUBl9jgmuJGW/McUVWnB2EPhrrvfim37sr+VYCPIuzMg?=
 =?us-ascii?Q?UwGpBI1KF3KExRVUq+omOyh9U3625rPAU1v5EhjlJh7A83URPX/JZnxUHcva?=
 =?us-ascii?Q?A/ERTBPvoi7MOomfrSOBEd7k0kDkDY43KHM4Q8HE2M7psJBRF955DcC4n9H6?=
 =?us-ascii?Q?hw0dzBWlBIcf6cLwV2Xpv7pRqk2Jkh0BaqtTleM3S1zpCM/C+kyr3Q2FTVsu?=
 =?us-ascii?Q?tkZJ2y3GYYze20uWjsOv+2m2Fd4FBs2sz03etS3L0axXxVbO4W5KB81GMhRf?=
 =?us-ascii?Q?s8MBNKtEk2UpA/negQ0oftOOzqAuo340xDc7FWAxRpgE4WxJpPP4Cu+tlOke?=
 =?us-ascii?Q?pSVGqPjliQgdcJELV7kmL+XgLH5TPwNoCqn0dKFFrXgcOHsiJiaFteqJo67z?=
 =?us-ascii?Q?XFcwjGBDtDj5C94lLHr8n91PeGJ3pgtKmttk22T44056r1wUH93X2qI5Q+HT?=
 =?us-ascii?Q?ukR/arp9zXL+t1PJPapOektZCrFmezwI6gOByAmkJ5PgwHs2VFlDQqfm0AEj?=
 =?us-ascii?Q?w57efYGabHF4OspCcMZVOjBKRkhyr6BQZEvC+2KeC6oBIff4+UdwhlFlNC1M?=
 =?us-ascii?Q?5n4+LWIOltph8rfjIZWQChO2IiXR5UP5QOD1aZc+VmqN0DVqR4wtJ1hGQHyv?=
 =?us-ascii?Q?e+Nuulo5KSWb2Jl7ZfJxGjpb+LwPwj3sN5X5dRnJkNAWKUhMMeobiG4OJ3Cx?=
 =?us-ascii?Q?/d0xBNZAV3/VUBuWi01a69XqWGt1x9zGzYe2rz9pNWAQ0NK8JjXhZHRahOil?=
 =?us-ascii?Q?HPhq6Y2QVz02XXYMA3aIm8eGAYSgy3IQRPMnCtQFuIveRjAZPeAeXWCGtLD/?=
 =?us-ascii?Q?/UtaKgWwksyl3anR9OuoGQ1Ah9h/Ewq9g3EVCJahnSdeORvNGWlhiPTaNDSw?=
 =?us-ascii?Q?oA/UITR/FXjEduBsKy3PBGRZFu9gSm3YmUcgkiX9VZZkO/Ij2+jIHgv9X4R5?=
 =?us-ascii?Q?WhziKwbQpxAgF716P1QQch6RLutqSz4MLcgzWEiQfL5/Bg8zKj6CeG6lhjZu?=
 =?us-ascii?Q?VOUS0D9/KGwcuYaVUtD+S8EtY1JevW6/KUgn367v9nXK81NapZGCcshhhkyV?=
 =?us-ascii?Q?hiJ7nMY8Sy8yZX0HOogAb/yEwpX/hutD0ar1iX2MJUPTrObfcq1KOPug019O?=
 =?us-ascii?Q?uqoMDIEa2u7skWDYbM6nsXnD2scychuXIYtDFMfvB6B2z2ANhly6ZVpUVB2e?=
 =?us-ascii?Q?lsFavwq4zaae+tqqhhY+DLkrE1V3naCmdLmVsIq3kcsYscM6UDv9okry8x4n?=
 =?us-ascii?Q?R8juOY0k6wfDa5gYUQ8xoR/WS0JVRGGL/+Afx1HipPOc0TCoM8xfHZklGJ6X?=
 =?us-ascii?Q?c1qJIL/hb2IJHNQCxVDRMnh/iXRqSN7rMXI6cWLfL3CrlNFEe8mH1U9UT482?=
 =?us-ascii?Q?kWMvBTQn9olODS7ym7G82kJiieg+zT+4LP8R9Ao1MqUwPghOZ9mhMlF0pdey?=
 =?us-ascii?Q?Xha/TygUOfuOC9k6woDMS0DJJ1Vo14DCGb9xPY0yx2sSwrfsVdJRosOjcJIc?=
 =?us-ascii?Q?1/CbUcR28rbRbQiZjmDFNQaTl35h5S9HUL7HP0dVpOxekzs9IRgQUqv2GcFp?=
 =?us-ascii?Q?WG6wceTbzSEn6xz7CQLW5yXSCmmiMQ8=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 65688cc6-626e-40e0-fd70-08da4d8fcc35
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 22:55:23.0442
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PmC254YNfnZ+DJ+xPdc2Qv4MVMjAyBJFDN4crWEckwD3ePC7j1UwDw9HaqP3uwLyZNyncQ7R2VOdzFrv3WToYjWr05KRIiMVVvXNOSam8bU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P190MB1539
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Chris Packham <chris.packham@alliedtelesis.co.nz>

The 98DX2530 SoC is the Control and Management CPU integrated into
the Marvell 98DX25xx and 98DX35xx series of switch chip (internally
referred to as AlleyCat5 and AlleyCat5X).

These files have been taken from the Marvell SDK and lightly cleaned
up with the License and copyright retained.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---

Notes:
    The Marvell SDK has a number of new compatible strings. I've brought
    through some of the drivers or where possible used an in-tree
    alternative (e.g. there is SDK code for a ac5-gpio but two instances of
    the existing marvell,orion-gpio seems to cover what is needed if you use
    an appropriate binding). I expect that there will a new series of
    patches when I get some different hardware (or additions to this series
    depending on if/when it lands).
    
    Changes in v9 (proposed by Marvell):
      It was discussed with Chris that Marvell will add some changes:

         1) Rename "armada-" prefix in dts(i) file names to ac5, because
            Armada has not much common with AC5 SoC.

         2) Add clock fixes:
            - rename core_clock to cnm_clock
            - remove axi_clock
            - change cnm_clock to 325MHZ
            - use cnm_clock for the UART

    Changes in v8:
    - Remove unnecessary clock-frequency property on armv8-timer
    - Remove unnecessary redistributor-stride property on gic
    - Add GIC_SPI interrupts for gpios
    Changes in v7:
    - Add missing compatible on usb1
    - Add "rd-ac5x" compatible for board
    - Move aliases to board dts
    - Move board specific usb info to board dts
    - Consolidate usb1 board settings and remove unnecessary compatible
    - Add Allied Telesis copyright
    - Rename files after mailng-list discussion
    Changes in v6:
    - Move CPU nodes above the SoC (Krzysztof)
    - Minor formatting clean ups (Krzysztof)
    - Run through `make dtbs_check`
    - Move gic nodes inside SoC
    - Group clocks under a clock node
    Changes in v5:
    - add #{address,size}-cells property to i2c nodes
    - make i2c nodes disabled in the SoC and enable them in the board
    - add interrupt controller attributes to gpio nodes
    - Move fixed-clock nodes up a level and remove unnecessary @0
    Changes in v4:
    - use 'phy-handle' instead of 'phy'
    - move status="okay" on usb nodes to board dts
    - Add review from Andrew
    Changes in v3:
    - Move memory node to board
    - Use single digit reg value for phy address
    - Remove MMC node (driver needs work)
    - Remove syscon & simple-mfd for pinctrl
    Changes in v2:
    - Make pinctrl a child node of a syscon node
    - Use marvell,armada-8k-gpio instead of orion-gpio
    - Remove nand peripheral. The Marvell SDK does have some changes for the
      ac5-nand-controller but I currently lack hardware with NAND fitted so
      I can't test it right now. I've therefore chosen to omit the node and
      not attempted to bring in the driver or binding.
    - Remove pcie peripheral. Again there are changes in the SDK and I have
      no way of testing them.
    - Remove prestera node.
    - Remove "marvell,ac5-ehci" compatible from USB node as
      "marvell,orion-ehci" is sufficient
    - Remove watchdog node. There is a buggy driver for the ac5 watchdog in
      the SDK but it needs some work so I've dropped the node for now.

 arch/arm64/boot/dts/marvell/Makefile          |   1 +
 arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi | 291 ++++++++++++++++++
 .../boot/dts/marvell/ac5-98dx35xx-rd.dts      | 101 ++++++
 arch/arm64/boot/dts/marvell/ac5-98dx35xx.dtsi |  13 +
 4 files changed, 406 insertions(+)
 create mode 100644 arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/ac5-98dx35xx-rd.dts
 create mode 100644 arch/arm64/boot/dts/marvell/ac5-98dx35xx.dtsi

diff --git a/arch/arm64/boot/dts/marvell/Makefile b/arch/arm64/boot/dts/marvell/Makefile
index 1c794cdcb8e6..b6d493e34dc5 100644
--- a/arch/arm64/boot/dts/marvell/Makefile
+++ b/arch/arm64/boot/dts/marvell/Makefile
@@ -24,3 +24,4 @@ dtb-$(CONFIG_ARCH_MVEBU) += cn9132-db.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9132-db-B.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9130-crb-A.dtb
 dtb-$(CONFIG_ARCH_MVEBU) += cn9130-crb-B.dtb
+dtb-$(CONFIG_ARCH_MVEBU) += ac5-98dx35xx-rd.dtb
diff --git a/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi b/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
new file mode 100644
index 000000000000..cf0b4a7de323
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
@@ -0,0 +1,291 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree For AC5.
+ *
+ * Copyright (C) 2021 Marvell
+ * Copyright (C) 2022 Allied Telesis Labs
+ */
+
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+/ {
+	model = "Marvell AC5 SoC";
+	compatible = "marvell,ac5";
+	interrupt-parent = <&gic>;
+	#address-cells = <2>;
+	#size-cells = <2>;
+
+	cpus {
+		#address-cells = <2>;
+		#size-cells = <0>;
+
+		cpu-map {
+			cluster0 {
+				core0 {
+					cpu = <&cpu0>;
+				};
+				core1 {
+					cpu = <&cpu1>;
+				};
+			};
+		};
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x0>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+		};
+
+		cpu1: cpu@1 {
+			device_type = "cpu";
+			compatible = "arm,armv8";
+			reg = <0x0 0x100>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+		};
+
+		l2: l2-cache {
+			compatible = "cache";
+		};
+	};
+
+	psci {
+		compatible = "arm,psci-0.2";
+		method = "smc";
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 8 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_HIGH>,
+			     <GIC_PPI 7 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	pmu {
+		compatible = "arm,armv8-pmuv3";
+		interrupts = <GIC_PPI 12 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+		dma-ranges;
+
+		internal-regs@7f000000 {
+			#address-cells = <1>;
+			#size-cells = <1>;
+			compatible = "simple-bus";
+			/* 16M internal register @ 0x7f00_0000 */
+			ranges = <0x0 0x0 0x7f000000 0x1000000>;
+			dma-coherent;
+
+			uart0: serial@12000 {
+				compatible = "snps,dw-apb-uart";
+				reg = <0x12000 0x100>;
+				reg-shift = <2>;
+				interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+				reg-io-width = <1>;
+				clocks = <&cnm_clock>;
+				status = "okay";
+			};
+
+			mdio: mdio@22004 {
+				#address-cells = <1>;
+				#size-cells = <0>;
+				compatible = "marvell,orion-mdio";
+				reg = <0x22004 0x4>;
+				clocks = <&cnm_clock>;
+			};
+
+			i2c0: i2c@11000{
+				compatible = "marvell,mv78230-i2c";
+				reg = <0x11000 0x20>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				clocks = <&cnm_clock>;
+				clock-names = "core";
+				interrupts = <GIC_SPI 87 IRQ_TYPE_LEVEL_HIGH>;
+				clock-frequency=<100000>;
+
+				pinctrl-names = "default", "gpio";
+				pinctrl-0 = <&i2c0_pins>;
+				pinctrl-1 = <&i2c0_gpio>;
+				scl_gpio = <&gpio0 26 GPIO_ACTIVE_HIGH>;
+				sda_gpio = <&gpio0 27 GPIO_ACTIVE_HIGH>;
+				status = "disabled";
+			};
+
+			i2c1: i2c@11100{
+				compatible = "marvell,mv78230-i2c";
+				reg = <0x11100 0x20>;
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				clocks = <&cnm_clock>;
+				clock-names = "core";
+				interrupts = <GIC_SPI 88 IRQ_TYPE_LEVEL_HIGH>;
+				clock-frequency=<100000>;
+
+				pinctrl-names = "default", "gpio";
+				pinctrl-0 = <&i2c1_pins>;
+				pinctrl-1 = <&i2c1_gpio>;
+				scl_gpio = <&gpio0 20 GPIO_ACTIVE_HIGH>;
+				sda_gpio = <&gpio0 21 GPIO_ACTIVE_HIGH>;
+				status = "disabled";
+			};
+
+			gpio0: gpio@18100 {
+				compatible = "marvell,orion-gpio";
+				reg = <0x18100 0x40>;
+				ngpios = <32>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&pinctrl0 0 0 32>;
+				marvell,pwm-offset = <0x1f0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 76 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			gpio1: gpio@18140 {
+				reg = <0x18140 0x40>;
+				compatible = "marvell,orion-gpio";
+				ngpios = <14>;
+				gpio-controller;
+				#gpio-cells = <2>;
+				gpio-ranges = <&pinctrl0 0 32 14>;
+				marvell,pwm-offset = <0x1f0>;
+				interrupt-controller;
+				#interrupt-cells = <2>;
+				interrupts = <GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
+					     <GIC_SPI 80 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
+		/*
+		 * Dedicated section for devices behind 32bit controllers so we
+		 * can configure specific DMA mapping for them
+		 */
+		behind-32bit-controller@7f000000 {
+			compatible = "simple-bus";
+			#address-cells = <0x2>;
+			#size-cells = <0x2>;
+			ranges = <0x0 0x0 0x0 0x7f000000 0x0 0x1000000>;
+			/* Host phy ram starts at 0x200M */
+			dma-ranges = <0x0 0x0 0x2 0x0 0x1 0x0>;
+			dma-coherent;
+
+			eth0: ethernet@20000 {
+				compatible = "marvell,armada-ac5-neta";
+				reg = <0x0 0x20000 0x0 0x4000>;
+				interrupts = <GIC_SPI 45 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&cnm_clock>;
+				phy-mode = "sgmii";
+				status = "disabled";
+			};
+
+			eth1: ethernet@24000 {
+				compatible = "marvell,armada-ac5-neta";
+				reg = <0x0 0x24000 0x0 0x4000>;
+				interrupts = <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>;
+				clocks = <&cnm_clock>;
+				phy-mode = "sgmii";
+				status = "disabled";
+			};
+
+			usb0: usb@80000 {
+				compatible = "marvell,orion-ehci";
+				reg = <0x0 0x80000 0x0 0x500>;
+				interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+
+			usb1: usb@a0000 {
+				compatible = "marvell,orion-ehci";
+				reg = <0x0 0xa0000 0x0 0x500>;
+				interrupts = <GIC_SPI 69 IRQ_TYPE_LEVEL_HIGH>;
+				status = "disabled";
+			};
+		};
+
+		pinctrl0: pinctrl@80020100 {
+			compatible = "marvell,ac5-pinctrl";
+			reg = <0 0x80020100 0 0x20>;
+
+			i2c0_pins: i2c0-pins {
+				marvell,pins = "mpp26", "mpp27";
+				marvell,function = "i2c0";
+			};
+
+			i2c0_gpio: i2c0-gpio-pins {
+				marvell,pins = "mpp26", "mpp27";
+				marvell,function = "gpio";
+			};
+
+			i2c1_pins: i2c1-pins {
+				marvell,pins = "mpp20", "mpp21";
+				marvell,function = "i2c1";
+			};
+
+			i2c1_gpio: i2c1-gpio-pins {
+				marvell,pins = "mpp20", "mpp21";
+				marvell,function = "i2c1";
+			};
+		};
+
+		spi0: spi@805a0000 {
+			compatible = "marvell,armada-3700-spi";
+			reg = <0x0 0x805a0000 0x0 0x50>;
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			clocks = <&spi_clock>;
+			interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+			num-cs = <1>;
+			status = "disabled";
+		};
+
+		spi1: spi@805a8000 {
+			compatible = "marvell,armada-3700-spi";
+			reg = <0x0 0x805a8000 0x0 0x50>;
+			#address-cells = <0x1>;
+			#size-cells = <0x0>;
+			clocks = <&spi_clock>;
+			interrupts = <GIC_SPI 91 IRQ_TYPE_LEVEL_HIGH>;
+			num-cs = <1>;
+			status = "disabled";
+		};
+
+		gic: interrupt-controller@80600000 {
+			compatible = "arm,gic-v3";
+			#interrupt-cells = <3>;
+			interrupt-controller;
+			reg = <0x0 0x80600000 0x0 0x10000>, /* GICD */
+			      <0x0 0x80660000 0x0 0x40000>; /* GICR */
+			interrupts = <GIC_PPI 6 IRQ_TYPE_LEVEL_HIGH>;
+		};
+	};
+
+	clocks {
+		cnm_clock: core-clock {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <325000000>;
+		};
+
+		spi_clock: spi-clock {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <200000000>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/marvell/ac5-98dx35xx-rd.dts b/arch/arm64/boot/dts/marvell/ac5-98dx35xx-rd.dts
new file mode 100644
index 000000000000..f0ebdb84eec9
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/ac5-98dx35xx-rd.dts
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree For RD-AC5X.
+ *
+ * Copyright (C) 2021 Marvell
+ * Copyright (C) 2022 Allied Telesis Labs
+ */
+/*
+ * Device Tree file for Marvell Alleycat 5X development board
+ * This board file supports the B configuration of the board
+ */
+
+/dts-v1/;
+
+#include "ac5-98dx35xx.dtsi"
+
+/ {
+	model = "Marvell RD-AC5X Board";
+	compatible = "marvell,rd-ac5x", "marvell,ac5x", "marvell,ac5";
+
+	aliases {
+		serial0 = &uart0;
+		spiflash0 = &spiflash0;
+		gpio0 = &gpio0;
+		gpio1 = &gpio1;
+		ethernet0 = &eth0;
+		ethernet1 = &eth1;
+	};
+
+	memory@0 {
+		device_type = "memory";
+		reg = <0x2 0x00000000 0x0 0x40000000>;
+	};
+
+	usb1phy: usb-phy {
+		compatible = "usb-nop-xceiv";
+		#phy-cells = <0>;
+	};
+};
+
+&mdio {
+	phy0: ethernet-phy@0 {
+		reg = <0>;
+	};
+};
+
+&i2c0 {
+	status = "okay";
+};
+
+&i2c1 {
+	status = "okay";
+};
+
+&eth0 {
+	status = "okay";
+	phy-handle = <&phy0>;
+};
+
+/* USB0 is a host USB */
+&usb0 {
+	status = "okay";
+};
+
+/* USB1 is a peripheral USB */
+&usb1 {
+	status = "okay";
+	phys = <&usb1phy>;
+	phy-names = "usb-phy";
+	dr_mode = "peripheral";
+};
+
+&spi0 {
+	status = "okay";
+
+	spiflash0: flash@0 {
+		compatible = "jedec,spi-nor";
+		spi-max-frequency = <50000000>;
+		spi-tx-bus-width = <1>; /* 1-single, 2-dual, 4-quad */
+		spi-rx-bus-width = <1>; /* 1-single, 2-dual, 4-quad */
+		reg = <0>;
+
+		#address-cells = <1>;
+		#size-cells = <1>;
+
+		partition@0 {
+			label = "spi_flash_part0";
+			reg = <0x0 0x800000>;
+		};
+
+		parition@1 {
+			label = "spi_flash_part1";
+			reg = <0x800000 0x700000>;
+		};
+
+		parition@2 {
+			label = "spi_flash_part2";
+			reg = <0xF00000 0x100000>;
+		};
+	};
+};
diff --git a/arch/arm64/boot/dts/marvell/ac5-98dx35xx.dtsi b/arch/arm64/boot/dts/marvell/ac5-98dx35xx.dtsi
new file mode 100644
index 000000000000..50d464d9d2f4
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/ac5-98dx35xx.dtsi
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * Device Tree For AC5X.
+ *
+ * Copyright (C) 2022 Allied Telesis Labs
+ */
+
+#include "ac5-98dx25xx.dtsi"
+
+/ {
+	model = "Marvell AC5X SoC";
+	compatible = "marvell,ac5x", "marvell,ac5";
+};
-- 
2.17.1

