Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13165567770
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 21:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233487AbiGETLM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 15:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233374AbiGETLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 15:11:02 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2109.outbound.protection.outlook.com [40.107.20.109])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5365F21246;
        Tue,  5 Jul 2022 12:11:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EIXN67xhAUMv3fFu0oXr7G3p0WwxfmP1AI9ZDGG8BRN6fbbMDxiOHCgMtzb/f3ffipoD3rwBmXAHVNR5jkayBoGVgzhlA2Q4H5raQNz2pUmjxrtrB8RuZbChq3qgKFS/LMhT5BUPghDfaDh5YpkC1Dxs2zFsnbj2r4PtTm55Z4l1rmmZri2sMKLdJIsT2Q0GQBr/Dttkw7Mz9zZ1QOjLDTjFXsikibsMYQs73oEAHPo/tRt2aFdDilHBH6XttuxncV5v/ZLxVD3Ymfq29FlWu3OsWkldOfgSZla8hM/1PQ/tGUd9ksxtR4/iWCPOyZSvF8nzpv/rq2A/U3j6ajxlJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=53us7Ord7QFEIvcl4q4obcxAQWUHHOL4jaGqC7hlQT4=;
 b=T4YCATf6BuNGCT3CbsK2LjxIVhk90Yd5NWPrde+xW3hNGgPFVtPh4pu958QDPpUQNAk7g0jt5tlQMcpeQ4ErYlo41ij25OG24Fo7RgedfO0HKkmhUwu6zjAlP8wdAcLBXiOVCu6IixcN+YY6gNOL8X4BOOGGdZuByYJT1DMCRZHpDAkFwV1FLmMYE2ohqIBb4xxcgzIZN/rEoH252wSkB5XrRIDDDP6LEZapOIsrlT1OQmHfnr4OY4sfGLo2isdaBR/Y76/6ZHb0MwG2uK30SiXM8DHZby2rk1cTk81fiMWiwwaeMsp+ZWXR8FAqwcMblrsBT1nLrIVyNvp4McqH4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=53us7Ord7QFEIvcl4q4obcxAQWUHHOL4jaGqC7hlQT4=;
 b=CXZlQfeK95VtavSvuxSCmxOnE7ri07fNu9PamYGTwyKf9i34zg7T68npzAA3xKk1DlYmGAZbRSCcHSVktF3WMTzI0GTWGaV1rzirAzwPDqcegqAsD4k2CU/RiLBsWYxM+BVOyjVTZ/3gZulA4niSnbDnKaf47HQzHaXjbP2jDwc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by AM9P190MB1426.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:3e4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Tue, 5 Jul
 2022 19:10:58 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2c45:bc33:2584:959a]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2c45:bc33:2584:959a%7]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 19:10:58 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Konstantin Porotchkin <kostap@marvell.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Robert Marko <robert.marko@sartura.hr>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Elad Nachman <enachman@marvell.com>
Subject: [PATCH v10 2/3] arm64: dts: marvell: Add Armada 98DX2530 SoC and RD-AC5X board
Date:   Tue,  5 Jul 2022 22:09:20 +0300
Message-Id: <20220705190934.6168-3-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220705190934.6168-1-vadym.kochan@plvision.eu>
References: <20220705190934.6168-1-vadym.kochan@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0047.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::15) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3e9a7ea-9cd9-4aa8-ac57-08da5eba179d
X-MS-TrafficTypeDiagnostic: AM9P190MB1426:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7xJgKfmLU+N8ySeHK6nukw1/ZrtTttoeIhpbah0YUhnNPSA0Om5butwa1DpYOxbhCDNoWlDfd++CfXgc57XO1opbVmsOlueyqtImQUguwnBfRRW5vokRdpMPZSnviLgEpxdyepUNHtUfMyVxkp+tKdlhzGnnofVVmsbnlA/Eo1l+YUw7mR1lgDpwDztyTEYcajEI9gcAMVtId7JlKrI0qeT6oSMA8zn13NpGhx5ToZgrHvBr8ajer5ysTmJZTJq6LJDYDL1bS4jQjiKRschlZxhV2GRiL1i1MkDDeWsUGDcUoVOJP6UH3fUBpxq9oA3bJlvc5te5kyhNH6rFN7By7hWAv0u+1ACI8IW71ATYBz/3mkxk0CpPwPyKoo78U6/+T169Yc1HNUYHA8rexj9MQMLeYjh6+TrshRdRpE70FDZjfS6QOFdcMg1yYKA4QU61AbdY7sihQceTGzQ1qgX5iLwdTYqKhlOPFuIK2fz25Y3iH2LCdmHwwz+ontgj8vu4H6VSa9gzQ/CtU7aU5OyB9IFIjYUl7gR1x6wO+/N42veFQNWoHGP1/n4vy6KYjXfh3kDC1qMQHT7xqpUvJcfXJBWQeFbO0AH2LPYqPY4mQhv+0MnAhjoGWHcnZP0f9589AH2JHn+VVSr9F5MUmH/8FTaZ8uzwz1TMtyapYmLPo+rfE9XSh8Yo/BlwPPyJHhti7S6+bQ8epj9NCip890I9Adj+Wl5F0JFkEm9vpPJfVfa0XtjsxwSpRSRPrnAm+MbImtbKw1QjrLh8Q29Re/r608Bypuswp6IrO3974RzHDgclrw4fFUsdgBSz+QD9zmVDIP9UVymRrP1F83kzfxUV2LaPQTYgx1Ai/mMSfygrhOkl7arkT6DIRivlbeP/3W4m
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39830400003)(376002)(346002)(136003)(366004)(396003)(110136005)(6512007)(316002)(26005)(41300700001)(6666004)(6506007)(52116002)(478600001)(6486002)(66556008)(66476007)(66946007)(2906002)(44832011)(4326008)(30864003)(8676002)(5660300002)(38100700002)(38350700002)(86362001)(36756003)(921005)(186003)(1076003)(2616005)(83380400001)(8936002)(7416002)(414714003)(473944003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zZZTymIS5CCnCDPby2nfioMXBTbOiORXckbxkkP4D8LUTm5OYlR0C3bfWvyV?=
 =?us-ascii?Q?K9peNL1XoyKKcNg3XcbaoDKAYVD8L08Nc9V6UGUFL46jSdY/kznCtHMbCy3w?=
 =?us-ascii?Q?Ulmd77e5+aZrDwilMVdx7EGYIQ301hlEEuq5RcdTemiKppVwoXNFliZNPWgg?=
 =?us-ascii?Q?Ms5LS3TXxHKjr1HPsBF1l2lgLsmER2KMwjHGh6K6keH4IxbeDNrpXaVoxM3b?=
 =?us-ascii?Q?p6QRBC1kx0Pc31KSpHGfJYJE8tKNn6v7KpN2JE9Y+BNhIJWGrmSopSkyEPtm?=
 =?us-ascii?Q?43qDboLhlbMRpKYbqhgxn0kebO8iGQddc69JW88lbdPygZl/MySPGZn/GEH2?=
 =?us-ascii?Q?Cy5nxcUPaZuxQQVeCTYaXWXoQeSBPDBtCCT3ksLQWjHf3xoVauLWvua8cGTM?=
 =?us-ascii?Q?UM58FlciaEkN77aU9dM4urXfFy0P/A2K5IwFIfwQD3cdZO4FdNzwamHqUwFZ?=
 =?us-ascii?Q?PrmHnf8ptMf4cTiFt+VyuTMTMEyrcQ0cjHkRSbrbBFLanG8gV9T8/7nkeNTS?=
 =?us-ascii?Q?PdHc7ORlZTmLrxVvOKSwJ+fZYs2DOQK/+028nWZiV0Gwau9i97si0lQavnM5?=
 =?us-ascii?Q?AQZ9LzXn1MJ0WhVLmSwM5TumU2f+32lPmSMv6oF+w+HBYwdPycJzPhl/29th?=
 =?us-ascii?Q?B1oBXYpx6NBRQGRBaNi/nL7RKyvozmzyP1tTVMxbjpXh6VM3SHkFdaj2EoNO?=
 =?us-ascii?Q?ZuEQxVRZasJnFZ/GXgNuEiTCoq5KwDjq+HuK5jE8eXrlDcHBY79xyfx7h+WU?=
 =?us-ascii?Q?cB/9g+LnhBO8S0Gq4A8NWeFAJtY6r3b5vdkCWlnPi87xxGbZIbUaz7PpO2FG?=
 =?us-ascii?Q?GJCIPLcDzuGx4nj2d7cokdgeF3opi4eOA35biMTTn6jAkSsSrkeVPfZyzIq8?=
 =?us-ascii?Q?oosdH41jdM1ekIhnYqNBvxIrnC626w5jmAF1cM9DreoUFLYGbGiqzrMyv1bI?=
 =?us-ascii?Q?l95okS6XS6+uUPgsQgYB8q6meOGIrAyKkc1nT3ESOPdDoOQ9wTj6lTF8jGJn?=
 =?us-ascii?Q?ZPJLAAphVSbmXJGDVh7N/nqID4I4zHvTtdv20eyRnE52poeLoNpW80y0kXaG?=
 =?us-ascii?Q?LDARhVylt9+ibtgpTYhRpzl3r8z/xrfhu3e47WnYEo0FwWhD592+VdMtXi0j?=
 =?us-ascii?Q?q+MpsbNnn+FzspOONQoeMP1om1WbtnF8aiU32DsIoucZ8MFZBsvwhf/nqGIJ?=
 =?us-ascii?Q?QMj6weINfg5hD0AwMjZSwbFN5oF7y0kkDreHFoqhQxtIduLajtYcqhgx6NQA?=
 =?us-ascii?Q?wWz8axVbmcwZ6nWmOsTdyrlq+13MnLzGZtobaEaO7AYxLGzYhG4tTZ3cUWU3?=
 =?us-ascii?Q?oEC1kBF1aHPWtuI1ys0GkpRy7bhCK1LgZeJUVZF6Bft+lmh54Gi7BQIGqEAO?=
 =?us-ascii?Q?LQqavy91Do/lathIo3oiv4uN59pPJMAcb3hm5UO4qn3fRcXclPtmv+LRtk/p?=
 =?us-ascii?Q?UvePNL7YXx1SZ+WPgm/ZStOb9mn6yNQgPDRsd5dEkhTRlZM2rrNBIvXrzPzY?=
 =?us-ascii?Q?jn9DwRSDFbEihx48aXUPzCnRGqRwn7+Jw18Y9caIfGuiM3ImiTsV0yTJHguo?=
 =?us-ascii?Q?8WSl6zsfX/rqYgqE9QXXf08iM+xJX08BSretzPjv+TwNpwQq4o8JEP2rPFAc?=
 =?us-ascii?Q?JA=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: e3e9a7ea-9cd9-4aa8-ac57-08da5eba179d
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 19:10:58.1046
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a8iR8DVk2ZUJEeSlz9eEK98Q1PpN5vdEq4ilnUFUT8gvZX9EVJvLZCoK1xz3xCP6axDjm54mXXCVu3N0fxfyJcxqUEAjccdj1Y7taJJhBHo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9P190MB1426
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
    
    Changes in v10:
         1) Use different cnm clock for AC5 and AC5X DTSIs

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
 arch/arm64/boot/dts/marvell/ac5-98dx35xx.dtsi |  17 +
 4 files changed, 410 insertions(+)
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
index 000000000000..d4f6feca35f9
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
+		cnm_clock: cnm-clock {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <328000000>;
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
index 000000000000..2ab72f854bea
--- /dev/null
+++ b/arch/arm64/boot/dts/marvell/ac5-98dx35xx.dtsi
@@ -0,0 +1,17 @@
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
+
+&cnm_clock {
+	clock-frequency = <325000000>;
+};
-- 
2.17.1

