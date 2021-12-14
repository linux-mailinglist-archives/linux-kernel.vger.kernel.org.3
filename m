Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DECA747440F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 14:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234645AbhLNN7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 08:59:17 -0500
Received: from mail-eopbgr140083.outbound.protection.outlook.com ([40.107.14.83]:32007
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232428AbhLNN7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 08:59:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHO20G3MAXMkGnLkS/mxmGJmRY/p5Q726OEnfWf7CyCQHZOp6Z/bX/+rWe6P+PvZlYY6t4nAYjO51xdeb5PF9pt3ZuZQEwTpH47XtxPknyGOU0Cjao6fIdEUFkUDovxG4WZNhsxtDvFpwnfUekB+HxXQM//BeWFxX8j9rcofmPgOl9Myp9vP/P90xbHj+oXfMLf6zchl2hb2G+vPBC/sWRx0EGfrgV+YAH6kAH/HHHpPo8q5CVOf9wqVomzOnTTXHjLF+NTB8kNvn4U/P0aChImFnlsY1NhiYWwUSngz6EjbMuVhJT/UzBFZfDCBuuLB42H7F+X2KfXmSHmlordgHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wNCaoPeonuT+HGmzi/MvLGh6akmnfuDrhwGWAxdG95k=;
 b=bOkHUZQPk6QxdgFMD0ooZNzZagCfk7ZSwMOEEuhMS/k0G/4bxoAGZHY7u9d7dr6t+ghiUow/8mJjPrPE9lggVO1pIlRbQfLGM/OOFk40dQbh+2KJBqLVPDfk/4m8DUDLq/i1edBTpKXUcrGBajCoTGjATM7gLhLGvJ0dD46lDd3quvFjV1SLlAj5az0WFqaaVXkQawPAUd5b57BNABrQAUAlaUIUcJfDCqcAsNeiuXy9/Y2qI8wm0V/IdmuyONd8tpBAi+2nq20VBgMULJBPNZ3tWWfgB2Wve61D7gdq/mNABFaG2DagA9dw0Zy3eLK5avDx2hI7ob67E0ZTipwnow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wNCaoPeonuT+HGmzi/MvLGh6akmnfuDrhwGWAxdG95k=;
 b=BHOdBXQqKWfAXTnKwf2gMzW8F125LF/WhiSVAiWDih+0RIhfIk4raMR914+2TQrSP5kVBlDDIqf6eps6r5xIxoDy7i6vi+tRqCYorxUTXpTduI43bA5In2IQUue8SLQip/LSes4wYAe0foqo7EUal/bsiAx0ah7ZY7XsZghjlLw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com (2603:10a6:803:55::19)
 by VE1PR04MB6638.eurprd04.prod.outlook.com (2603:10a6:803:119::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Tue, 14 Dec
 2021 13:59:11 +0000
Received: from VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::c84:1f0b:cc79:9226]) by VI1PR04MB5136.eurprd04.prod.outlook.com
 ([fe80::c84:1f0b:cc79:9226%3]) with mapi id 15.20.4755.028; Tue, 14 Dec 2021
 13:59:11 +0000
From:   Vladimir Oltean <vladimir.oltean@nxp.com>
To:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Marc Zyngier <maz@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Biwen Li <biwen.li@nxp.com>,
        Zhiqiang Hou <Zhiqiang.Hou@nxp.com>,
        Kurt Kanzenbach <kurt@linutronix.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 devicetree] Revert "arm64: dts: freescale: Fix 'interrupt-map' parent address cells"
Date:   Tue, 14 Dec 2021 15:58:52 +0200
Message-Id: <20211214135852.2934670-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0023.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1c::7) To VI1PR04MB5136.eurprd04.prod.outlook.com
 (2603:10a6:803:55::19)
MIME-Version: 1.0
Received: from localhost.localdomain (188.25.173.50) by FR3P281CA0023.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:1c::7) with Microsoft SMTP Server (version=TLS1_2, cipher=) via Frontend Transport; Tue, 14 Dec 2021 13:59:10 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0cb3b7ff-a3ad-4376-dd98-08d9bf09e76a
X-MS-TrafficTypeDiagnostic: VE1PR04MB6638:EE_
X-Microsoft-Antispam-PRVS: <VE1PR04MB663855BD77110F10282ECE81E0759@VE1PR04MB6638.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1107;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jFEdCL5jeuYeLPu3lwzXqISuBotyt7W+x1JiMdS4M6xpFnq0CUFP9sRhpTdMhjLwr9zcx4nfu4CeApWyCA80Y9vbMbMFk4jK170bTVqS6ZqpUJfyhmlCznCETXeseB1AeMrbs9gU29nHfoOZeZBoWsDnbsLl/ZU3nkqYS2Oiesg/H/ZmLD9kDeE05j0qwoFi1xTT718WkWXUmHZMzGxO06sMb56O5FOffkKrrfWDsuRrSd5YpbNWyFLLiGo6nWo2hDDgj3kaOPeH/er7SzFJKHMRpqKRy/jKIOMZ9CNNaro3EPKwCnQqqdDLErdokbm5NC4A8jjrVgR8Qklsu/2WLv7fTnkkUlmSP5pReaLOyF/L3DcROBerZxoxqLDToSnfVoekObgqd5EZz7nnkVxtze0lGsEYHi6Bcocq0IREmReExmB0GLqCqX2Doy9R0o7N4mbSDVJP5O6//TRL4QM51NU/6yGUSudgPRnfe9mPaOOMhwUNpTYsAGZVPHhKKN+IIaLdDdD6clPlO1Z/5ElDkj8v5csEyf5TeHAC28lMji0nsxgpO7hbLZFMcBcfaa7SD08hFrVwfbbwoiwGIWO6aaVVeFkqxex/DmrbKmk2g4QHVU6kMSVhBufKo3nYQb25lYS11zAf/z2jFHCXhL2RI+SvO4RIHqMs4sDHwKn+kdvHV3FEREArsIX0fgPPv2A/QKDfqiNp0X3hq4BNBp4hiXtD+fS2jbPZlg9ukJoRzuKiFNew4f79ndrjhk6BYSzaluo5q2/uyW3LOJ330fK2SibeGfUtWXGjZQqd2mRT7f3/Ra9+HL4r+H/pN5eRjnUxRqtpG5uUommBx9UC6EjKGw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB5136.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(6512007)(6486002)(44832011)(52116002)(956004)(86362001)(2616005)(316002)(5660300002)(2906002)(83380400001)(54906003)(508600001)(6666004)(966005)(26005)(4326008)(36756003)(6506007)(38350700002)(38100700002)(1076003)(66946007)(66476007)(66556008)(8936002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cWWsC9M3hOlcBKbHXDJsVpHESutLaVAO6e0zw/6f7J0wj2JeVTXkd+7g1KgV?=
 =?us-ascii?Q?zm+fNeSjFS/QrrwYhtMKzeCXl/i8fnH/v8+usWH+XX14QPfWQ4kg2CKbszHa?=
 =?us-ascii?Q?U16jxZdMT0Z97fzx1gTU3WXHQYKATpze3WNo8T6scgN3XhFXW03q69cN/nJH?=
 =?us-ascii?Q?UZIqZPnzKafX4k6lJLQrSJdD7s3NvU92fg3lMUG6bkRIvw8i+WnAR7R5Lpwg?=
 =?us-ascii?Q?pQBmZ+SQuhJalsl1nn9m5aYtCfDf0BgzghHCeoSYEkIK8gyN1zsBiI7i0RmA?=
 =?us-ascii?Q?yxxp4dP386x+R9Xi7q3v4ZYxH7P9kt94MwVoaXfJKknSyV7CrPFnkPz9uqlh?=
 =?us-ascii?Q?8J7xqK7sTcZUCZPSRIEF91h+oYJpxgMfRQcr7AMSYnj8HGZML4Q6exQc9ZiR?=
 =?us-ascii?Q?e77cFDs3tMROxyjYwmj2MZOq6dL91x7fT2DdiyPfdccejyejj3ytrxIG8ZcF?=
 =?us-ascii?Q?ZCF8mGd7gT+P3V7ISItbw/XQ4Czikdd1sFQnrrMFXCMptUKcoXPWt5wj+Tzr?=
 =?us-ascii?Q?hlCDFME/qgZfWRvoA9UTbRKbby7PJZwpbRhyzQ+Ot3aJqq5GOKjpeF1YbBHO?=
 =?us-ascii?Q?WfjdNkooMhghxwkS/seJE6epOu49VhwwJtjogoeBegHw7O4tzC+NixTPJyxW?=
 =?us-ascii?Q?NXm73L9ywA0Wm0NH6APc9cI5wn3KMS8HgK//aG+j8K8eigeqAUvyUY8iRIlQ?=
 =?us-ascii?Q?OJ3jOVvw2pLysHrQC2cuOGSS6b8RJhmWbzXBun7sqyTlWusM5dW7FAudEYci?=
 =?us-ascii?Q?y0BkbXOSfY9lXstL1BY4Vm4gOecFZfZM1FoAKlqoV8VStdYiyvMSlPfnsbW+?=
 =?us-ascii?Q?RBCA8NH1nA+uLgiWQHuOJ6CH26RzH5t17q9/2cXxPXcR80egMnv3eRkQ62CO?=
 =?us-ascii?Q?a1v55US6XCiqgokNiZaawR2XfSXA2HGanvGnr5b7niQlHyVMhf1les4aZbSp?=
 =?us-ascii?Q?0jKrxzpO2EEafU6NlLwjT6QlRAMlu3Mp/O9UQ0DnizOPWwVarWBz+kREOv6v?=
 =?us-ascii?Q?ktmkUCAYLBw9bkdb9cVjuhEXoFo92ZjeLf+PvlPC6i73I2SS71KR1BcjTiho?=
 =?us-ascii?Q?0L+efciL+pEdVzIht0pAe61Y91rzn6fwbt8L88zn7/4PFgrtEAG94U1xVO3z?=
 =?us-ascii?Q?MT67qvv2JsPjTQsnnvEJf+qF9aB39OHAVJf7Q3Yb1TEGIFgHs6tONerAoYwx?=
 =?us-ascii?Q?8QBiq0BKWLz/Ck7TLZ+k3buTs1FXrW6c/tJcQqf1neS1sczOOCowWAQ5rQ0f?=
 =?us-ascii?Q?Ek6BeyBkwJTZ9lxzmYXmlnWOBx4WYmZeiThctogvTkohyAzi0c01C7T84InW?=
 =?us-ascii?Q?rgURImi+MrvJq0RQWUknK/EQIpM0JGou5SCpeullUo52D1LGKBqJzTWtcyeh?=
 =?us-ascii?Q?a4MUG9UnfgmoyfemY016WqKbqm0/m8uoTmG8rfaHCJvPxapgwrdwHxli6bu2?=
 =?us-ascii?Q?JC9CPnufCScp6yF2OfJMDe7Zy/4mAw+nwVd31okO3B3447JDEVx0+it2GWau?=
 =?us-ascii?Q?YzRfnwvXvNWpDeohMxdg1ryloDBshPrjjU6qWeQpnB1GTZlvK2jbBwLjrIpM?=
 =?us-ascii?Q?F0HfCYLT1CETwhmTuIeg7i4yOS2oJC8NginG6QQdZ4oMdaQi03PhJcZ3UiSr?=
 =?us-ascii?Q?hlRnD3h19i2cPtcbHP0Tteo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cb3b7ff-a3ad-4376-dd98-08d9bf09e76a
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB5136.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Dec 2021 13:59:10.9349
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zVSGECI8eXriFcR13FFGbsZiuhT8JyZXfqGZJ4omvrSv5V0XcfwPr9XkR9/lI65LGGNNrOjEDfLXADqUdZ3MUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6638
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 869f0ec048dc8fd88c0b2003373bd985795179fb. That
updated the expected device tree binding format for the ls-extirq
driver, without also updating the parsing code (ls_extirq_parse_map)
to the new format.

The context is that the ls-extirq driver uses the standard
"interrupt-map" OF property in a non-standard way, as suggested by
Rob Herring during review:
https://lore.kernel.org/lkml/20190927161118.GA19333@bogus/

This has turned out to be problematic, as Marc Zyngier discovered
through commit 041284181226 ("of/irq: Allow matching of an interrupt-map
local to an interrupt controller"), later fixed through commit
de4adddcbcc2 ("of/irq: Add a quirk for controllers with their own
definition of interrupt-map"). Marc's position, expressed on multiple
opportunities, is that:

(a) [ making private use of the reserved "interrupt-map" name in a
    driver ] "is wrong, by the very letter of what an interrupt-map
    means. If the interrupt map points to an interrupt controller,
    that's the target for the interrupt."
https://lore.kernel.org/lkml/87k0g8jlmg.wl-maz@kernel.org/

(b) [ updating the driver's bindings to accept a non-reserved name for
    this property, as an alternative, is ] "is totally pointless. These
    machines have been in the wild for years, and existing DTs will be
    there *forever*."
https://lore.kernel.org/lkml/87ilvrk1r0.wl-maz@kernel.org/

Considering the above, the Linux kernel has quirks in place to deal with
the ls-extirq's non-standard use of the "interrupt-map". These quirks
may be needed in other operating systems that consume this device tree,
yet this is seen as the only viable solution.

Therefore, the premise of the patch being reverted here is invalid.
It doesn't matter whether the driver, in its non-standard use of the
property, complies to the standard format or not, since this property
isn't expected to be used for interrupt translation by the core.

This change restores LS1088A, LS2088A/LS2085A and LX2160A to their
previous bindings, which allows these systems to continue to use
external interrupt lines with the correct polarity.

Fixes: 869f0ec048dc ("arm64: dts: freescale: Fix 'interrupt-map' parent address cells")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: remove the other 9 patches that rename "interrupt-map" to
        "fsl,extirq-map", at Marc's suggestion.

 .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 24 +++++++++----------
 .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 24 +++++++++----------
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 24 +++++++++----------
 3 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index f891ef6a3754..605072317243 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -241,18 +241,18 @@ extirq: interrupt-controller@14 {
 				interrupt-controller;
 				reg = <0x14 4>;
 				interrupt-map =
-					<0 0 &gic 0 0 GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
-					<1 0 &gic 0 0 GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
-					<2 0 &gic 0 0 GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
-					<3 0 &gic 0 0 GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
-					<4 0 &gic 0 0 GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
-					<5 0 &gic 0 0 GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
-					<6 0 &gic 0 0 GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
-					<7 0 &gic 0 0 GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
-					<8 0 &gic 0 0 GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
-					<9 0 &gic 0 0 GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
-					<10 0 &gic 0 0 GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
-					<11 0 &gic 0 0 GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+					<0 0 &gic GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+					<1 0 &gic GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+					<2 0 &gic GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+					<3 0 &gic GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+					<4 0 &gic GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+					<5 0 &gic GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+					<6 0 &gic GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					<7 0 &gic GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+					<8 0 &gic GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+					<9 0 &gic GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+					<10 0 &gic GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+					<11 0 &gic GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-map-mask = <0xffffffff 0x0>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 3cb9c21d2775..1282b61da8a5 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -293,18 +293,18 @@ extirq: interrupt-controller@14 {
 				interrupt-controller;
 				reg = <0x14 4>;
 				interrupt-map =
-					<0 0 &gic 0 0 GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
-					<1 0 &gic 0 0 GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
-					<2 0 &gic 0 0 GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
-					<3 0 &gic 0 0 GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
-					<4 0 &gic 0 0 GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
-					<5 0 &gic 0 0 GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
-					<6 0 &gic 0 0 GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
-					<7 0 &gic 0 0 GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
-					<8 0 &gic 0 0 GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
-					<9 0 &gic 0 0 GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
-					<10 0 &gic 0 0 GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
-					<11 0 &gic 0 0 GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+					<0 0 &gic GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+					<1 0 &gic GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+					<2 0 &gic GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+					<3 0 &gic GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+					<4 0 &gic GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+					<5 0 &gic GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+					<6 0 &gic GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					<7 0 &gic GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+					<8 0 &gic GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+					<9 0 &gic GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+					<10 0 &gic GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+					<11 0 &gic GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-map-mask = <0xffffffff 0x0>;
 			};
 		};
diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index dc8661ebd1f6..c4b1a59ba424 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -680,18 +680,18 @@ extirq: interrupt-controller@14 {
 				interrupt-controller;
 				reg = <0x14 4>;
 				interrupt-map =
-					<0 0 &gic 0 0 GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
-					<1 0 &gic 0 0 GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
-					<2 0 &gic 0 0 GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
-					<3 0 &gic 0 0 GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
-					<4 0 &gic 0 0 GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
-					<5 0 &gic 0 0 GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
-					<6 0 &gic 0 0 GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
-					<7 0 &gic 0 0 GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
-					<8 0 &gic 0 0 GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
-					<9 0 &gic 0 0 GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
-					<10 0 &gic 0 0 GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
-					<11 0 &gic 0 0 GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
+					<0 0 &gic GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>,
+					<1 0 &gic GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>,
+					<2 0 &gic GIC_SPI 2 IRQ_TYPE_LEVEL_HIGH>,
+					<3 0 &gic GIC_SPI 3 IRQ_TYPE_LEVEL_HIGH>,
+					<4 0 &gic GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>,
+					<5 0 &gic GIC_SPI 5 IRQ_TYPE_LEVEL_HIGH>,
+					<6 0 &gic GIC_SPI 6 IRQ_TYPE_LEVEL_HIGH>,
+					<7 0 &gic GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
+					<8 0 &gic GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>,
+					<9 0 &gic GIC_SPI 9 IRQ_TYPE_LEVEL_HIGH>,
+					<10 0 &gic GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>,
+					<11 0 &gic GIC_SPI 11 IRQ_TYPE_LEVEL_HIGH>;
 				interrupt-map-mask = <0xffffffff 0x0>;
 			};
 		};
-- 
2.25.1

