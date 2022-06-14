Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23CA754AB8E
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 10:18:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234057AbiFNIQn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 04:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231989AbiFNIQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 04:16:41 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70101.outbound.protection.outlook.com [40.107.7.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86183F8B1;
        Tue, 14 Jun 2022 01:16:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FS7QwWLzfEbNWCkCU1iVmigMVYbIhHR1kAo1Ow70AmH87cXvxt8aYzpQVaOu3ua6AfJwbzj/Zu+pIIgblWqIJ8xP+DIhnk5fbPrVYEV3Gi9mchAQHJrQNHO1hU1xP3gHWHxKB9/Nl01ZKKCv81HqDL7kwROMyqj7hmvWK5lyAvTNz7IHRtZ0ujXPU3GHOX3A0VwQsjJKJy0EfDR1K9cXld3hNRnFHMy1MY7tQMJcITPm5EAHA4QlkEifCyJLe6if/2DFK0IMOP9amVDndHE08rLL0vAvlc5r63QUdroE3uTn+JCnV6wmvWpf6gQWtd5loCvHYJR+U27XH+1oNaF5Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HHAeW8QVknK1Ok3LpnXzd73XIk1dyA7juxqMhJgyfNI=;
 b=Se9nM1iZvIeKmjzSMW1Id8JFl7JnK1tW1RciVY2ozETWRXvTO3MWatU3oaii6rjqILJf8jtBaC7egMUNOqBqZCCbLuyMTdAlzRTHLWnuVER0kxklCjrQD66QIJEqiHoJB/5QgztUnkdRRqqDvVLCF88YplLxB4vpw/Qm1A5Mr5HngJ/NIar5OTOtjmB3nTiVJFY2nQESa9yZzhWGqcf2BdfKMEv7KaD9JiB+WkRfk5hpoKKvJGb80J8nS4la3c8tVvtg6zvaHE+CpvPikhyqbKda47EFyuvhhvNKLQicIgxmTJwZWEhpatIdMpztNNVHS1NW6GKdKmmGVHBhOkzAng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HHAeW8QVknK1Ok3LpnXzd73XIk1dyA7juxqMhJgyfNI=;
 b=gXWthSX9bGcmYJOKGncEGR2RtlQBYGEvhv1uD3z8w6OC40oWap6lJzP/vFugeloC6YzPRnNzKIY92ckZhGo6RbJ6w/HDfaWDyRRQEVWzwZjZGizU/a+yl7zuoOuzbGepAhGXxZFvBHEA0EXlZmAIK8cOwfbnnjYJD68g2cwBi3w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by PAXP190MB1693.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:1cd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Tue, 14 Jun
 2022 08:16:36 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2c45:bc33:2584:959a]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2c45:bc33:2584:959a%7]) with mapi id 15.20.5332.017; Tue, 14 Jun 2022
 08:16:35 +0000
Date:   Tue, 14 Jun 2022 11:16:33 +0300
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Konstantin Porotchkin <kostap@marvell.com>,
        Robert Marko <robert.marko@sartura.hr>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v9 2/3] arm64: dts: marvell: Add Armada 98DX2530 SoC and
 RD-AC5X board
Message-ID: <20220614081633.GA14160@plvision.eu>
References: <20220613225338.393-1-vadym.kochan@plvision.eu>
 <20220613225338.393-3-vadym.kochan@plvision.eu>
 <4670aab9-b7fa-f2c7-567a-12ca24535b0c@alliedtelesis.co.nz>
 <37d7b4f1-fd39-dc05-374a-764070c56cc6@alliedtelesis.co.nz>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <37d7b4f1-fd39-dc05-374a-764070c56cc6@alliedtelesis.co.nz>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: BE0P281CA0027.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::14) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 99954d9e-3764-4e9a-ad61-08da4dde32c0
X-MS-TrafficTypeDiagnostic: PAXP190MB1693:EE_
X-Microsoft-Antispam-PRVS: <PAXP190MB1693DD69F11DEA42C665420895AA9@PAXP190MB1693.EURP190.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U7wOaqJL8ZX8WSY2x+8Rn48iESiag/jPSad1E0tlgsChHHbNYK9zu6KJi/sBfW/Objp4vmwxZwsky6cWlzqRvPpr/jbsXUwpZa9ICfxwkfZQBEu4hYblTWQgX/khkuFlpL6kXCpO6wxmWdT6MlANFzLzKOE25RXdjfoucsv+ffKbIseJB8D1mR5wbXd693u9AMX+myFQKtCRJflmkx7gZHC7mdjlJIsKmzt5kyw3eyV2XcQ9+FEi5FX2qZaVMkFrsu4pikOLSOjNCbK+2DbBk15Z0w/ugO/XK460qz1I52by9U9mH+waIdYouWfnBpfteGaPvNiwG4vqsYtN3EK4SbiSMH/93r8mX2BxlplDh3am+B/tK2Wn3B5WYlFu60kVdzgCllRLc3wZghUCfKcphuYLIjsC9z4+k6az3OYzpMi1o0tXserJHPbsa9N6tDUZm8JLUymH/ORBT0IKLO8BpEiEuTovJRtqvlG46bTSm8KQzq9F4hUNrnM/I2QqoDFDcQk8mUH8L2bpBfwsug/yNUTGIuyLWXeHbEDqJ1TpPKKxbfbiecBvzWnbvxS3mklm5XB++4Bt+wz22Y2hDDqe6VuFPEgJRc/0C29Zlqm/UgCgogUpK1JtmV1kIuz05EW4o1mr5pOK771Lw65P4qX0MznYDaKMSdU6Rc+8Kc6Q1goJAnSFUDOov+J4/ykMM/CEPc51CM8Fun575MyQKGfv2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(136003)(39830400003)(396003)(366004)(2906002)(44832011)(5660300002)(33656002)(36756003)(7416002)(6506007)(86362001)(38100700002)(54906003)(6512007)(53546011)(26005)(6916009)(2616005)(316002)(186003)(52116002)(38350700002)(6486002)(66556008)(66476007)(41300700001)(508600001)(4326008)(8936002)(1076003)(8676002)(66946007)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?zywKrFYZ3hrPwjc8KBYCxPs4/0WVTaG+m7ocJuTcHbyOgwngcncCzfx25q?=
 =?iso-8859-1?Q?IuY2Jm2WBFWKMkybN0y9hR7aQUrgJrYtuK0KMIom7T+qSTgm5doe5q1k0t?=
 =?iso-8859-1?Q?HGHGZxhLby31+wKDvz6qoV/nmo3WFSTrT4U1LK3WxgOZr1+UVtUx2oJwjk?=
 =?iso-8859-1?Q?YW/oszrSZvGXiWbNtr4AIMOsbIA/W1YSlXvTHpWFox2WKU0hQ5kIcjCBhj?=
 =?iso-8859-1?Q?/Vzlfm3WkxBZ9csUJQ188VRrqxCkqMl6jyhX+8B8mNSQtb6XF8YHMsPrLk?=
 =?iso-8859-1?Q?CGy4jnqOdtOJMifdNMo41vahfwFxB5i02+sBObmWYRPdMNQRc1eL+u0qIs?=
 =?iso-8859-1?Q?DTzoa3LVGGlrOei7uFd3f4lTp1NP1nek9yiPRRPeCmCBJSjcW+3vymtn6G?=
 =?iso-8859-1?Q?MXGoAxw7//FZ06WDDOsNKQEzhjZ5FsmXiuQQ/UMkDHBsBRX8590TZJ1J4L?=
 =?iso-8859-1?Q?hSyeaUU32e4TIy3yISmLOLX7foa4cXhQt4fv7VIAhMX+lRUnCVjSWhlPji?=
 =?iso-8859-1?Q?WvfSY4L+fduXyPGRJmWemhVTj13K+ReopyM2+cwYXk/caPOcyn3ZC947wH?=
 =?iso-8859-1?Q?NmBIxczWs7Rblsnikyh4/jPVI1eErQ3ceYZENOq2isxjcFNarSDFAFRRdS?=
 =?iso-8859-1?Q?91oafnXRb/MVM5EK+rTwlmBcIw+Eqrem9ppsO6vkNMELB5SHNboWNGbW+W?=
 =?iso-8859-1?Q?WsQQCpeEKt4iA7e0u1dHfcaLVs4eDGS9rBpgLxFjFT6HIykmLCtk/yka52?=
 =?iso-8859-1?Q?OF2G9+w+tbX/nBWd/TI/SNgV1FxJ3GC9sA+Dx4+OAs8NYGBdCRov9GlHLX?=
 =?iso-8859-1?Q?tmjeIzFsnVNGu5xaMcNiq900LMR4wFopN8HtiOCHSxsHS48f3sg4eQuHEh?=
 =?iso-8859-1?Q?VslOCdLKaFcZc8U/+OnbW4zGftclCtZccOi07GAkf3WxGwK7BkjWRmtMjf?=
 =?iso-8859-1?Q?AnNNTk5I51m70T9JqSCRovV98OLhQLxBlJgt3NCE5yOxp3GJCZTf/4/XfM?=
 =?iso-8859-1?Q?Tnee2MKR+bW/pZ2u4CuoFaWdEcl0WeKO1C+AN6Swas4ngeoEoSDYwusV6K?=
 =?iso-8859-1?Q?pXB//VQNmY+8EFywI8jtuaq0pd/mWtNCAJwta3CN/MhRaDicljNJT72uJE?=
 =?iso-8859-1?Q?Bz2sQqtASOi11Rn3bC1npS6DMWbMqJ3CJIOZmmpbVYMB6cmxPMaEGUN9qa?=
 =?iso-8859-1?Q?7iGji5BFvSGDrvwLwLm2Pz55ccujmqRXHXEsq1w1MLOFc5IaF7vZHSfPd/?=
 =?iso-8859-1?Q?Pb1F4UQ9cGq4nx5T9k6tp/j4vclbw9BXljj5beJDqTx4a9kduOWI8YLJAA?=
 =?iso-8859-1?Q?QynNblb0+MJ1rCuSxqPwPUDMAWH1NYu3a7MQAElVVjv/POElFklYEoxl7u?=
 =?iso-8859-1?Q?It1uP0PWVwK/1zEJI9cLIntJEk92xrvdA8Yjaai1tHfJaKPiIrzP/Bh8VQ?=
 =?iso-8859-1?Q?Va6XXuis1hhB8desvMofep2QZJLqw6HzcylHM7k7qg5hBJCMe5Gkl7dXtp?=
 =?iso-8859-1?Q?Nf3DZa630o50HU0CH9n83qnlDphoeMYJBaE/JBCdUJ4pTbqjzWOTF8y16s?=
 =?iso-8859-1?Q?Q01iTatJQD0GTqf/nQcuoQ2vpNx99AAul0b50X9o7hz36nF+Gxd7PyjY7v?=
 =?iso-8859-1?Q?lCpOaZdWMMtA3QmEAe4u/M0napdTlt9Qrz74MbN8zqhsY2dMJj30MmrVg2?=
 =?iso-8859-1?Q?u+1cbnEz5LykD1Tr9zzprke+nkUuf557g0eCuAHAARQyiH3076b9jCGlif?=
 =?iso-8859-1?Q?/z1P7hE8B8e3E0ThIE/2ebn35kHL4b47hNcQr+2cVnP5IN+5k9t5ZW+ccr?=
 =?iso-8859-1?Q?YdBiub/QKXA8UqMEeFyWJ78cCchDnR8=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 99954d9e-3764-4e9a-ad61-08da4dde32c0
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jun 2022 08:16:35.7006
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gnLfff3T2ZJwC14lAWmAkOxw0yFMP1F0ef/104/KR0JZtnKLhVZ7I3mICwY4osxqPRGcvV98qkDzUxdninlOXLj6ucRI8EYFHodJvdeG7u4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP190MB1693
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chris,

On Tue, Jun 14, 2022 at 05:26:39AM +0000, Chris Packham wrote:
> 
> On 14/06/22 17:11, Chris Packham wrote:
> >
> > On 14/06/22 10:53, Vadym Kochan wrote:
> >> From: Chris Packham <chris.packham@alliedtelesis.co.nz>
> >>
> >> The 98DX2530 SoC is the Control and Management CPU integrated into
> >> the Marvell 98DX25xx and 98DX35xx series of switch chip (internally
> >> referred to as AlleyCat5 and AlleyCat5X).
> >>
> >> These files have been taken from the Marvell SDK and lightly cleaned
> >> up with the License and copyright retained.
> >>
> >> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> >> Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
> >> ---
> >>
> >> Notes:
> >>      The Marvell SDK has a number of new compatible strings. I've 
> >> brought
> >>      through some of the drivers or where possible used an in-tree
> >>      alternative (e.g. there is SDK code for a ac5-gpio but two 
> >> instances of
> >>      the existing marvell,orion-gpio seems to cover what is needed if 
> >> you use
> >>      an appropriate binding). I expect that there will a new series of
> >>      patches when I get some different hardware (or additions to this 
> >> series
> >>      depending on if/when it lands).
> >>           Changes in v9 (proposed by Marvell):
> >>        It was discussed with Chris that Marvell will add some changes:
> >>
> >>           1) Rename "armada-" prefix in dts(i) file names to ac5, 
> >> because
> >>              Armada has not much common with AC5 SoC.
> >>
> >>           2) Add clock fixes:
> >>              - rename core_clock to cnm_clock
> >>              - remove axi_clock
> >>              - change cnm_clock to 325MHZ
> >>              - use cnm_clock for the UART
> >>
> >>      Changes in v8:
> >>      - Remove unnecessary clock-frequency property on armv8-timer
> >>      - Remove unnecessary redistributor-stride property on gic
> >>      - Add GIC_SPI interrupts for gpios
> >>      Changes in v7:
> >>      - Add missing compatible on usb1
> >>      - Add "rd-ac5x" compatible for board
> >>      - Move aliases to board dts
> >>      - Move board specific usb info to board dts
> >>      - Consolidate usb1 board settings and remove unnecessary compatible
> >>      - Add Allied Telesis copyright
> >>      - Rename files after mailng-list discussion
> >>      Changes in v6:
> >>      - Move CPU nodes above the SoC (Krzysztof)
> >>      - Minor formatting clean ups (Krzysztof)
> >>      - Run through `make dtbs_check`
> >>      - Move gic nodes inside SoC
> >>      - Group clocks under a clock node
> >>      Changes in v5:
> >>      - add #{address,size}-cells property to i2c nodes
> >>      - make i2c nodes disabled in the SoC and enable them in the board
> >>      - add interrupt controller attributes to gpio nodes
> >>      - Move fixed-clock nodes up a level and remove unnecessary @0
> >>      Changes in v4:
> >>      - use 'phy-handle' instead of 'phy'
> >>      - move status="okay" on usb nodes to board dts
> >>      - Add review from Andrew
> >>      Changes in v3:
> >>      - Move memory node to board
> >>      - Use single digit reg value for phy address
> >>      - Remove MMC node (driver needs work)
> >>      - Remove syscon & simple-mfd for pinctrl
> >>      Changes in v2:
> >>      - Make pinctrl a child node of a syscon node
> >>      - Use marvell,armada-8k-gpio instead of orion-gpio
> >>      - Remove nand peripheral. The Marvell SDK does have some changes 
> >> for the
> >>        ac5-nand-controller but I currently lack hardware with NAND 
> >> fitted so
> >>        I can't test it right now. I've therefore chosen to omit the 
> >> node and
> >>        not attempted to bring in the driver or binding.
> >>      - Remove pcie peripheral. Again there are changes in the SDK and 
> >> I have
> >>        no way of testing them.
> >>      - Remove prestera node.
> >>      - Remove "marvell,ac5-ehci" compatible from USB node as
> >>        "marvell,orion-ehci" is sufficient
> >>      - Remove watchdog node. There is a buggy driver for the ac5 
> >> watchdog in
> >>        the SDK but it needs some work so I've dropped the node for now.
> >>
> >>   arch/arm64/boot/dts/marvell/Makefile          |   1 +
> >>   arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi | 291 ++++++++++++++++++
> >>   .../boot/dts/marvell/ac5-98dx35xx-rd.dts      | 101 ++++++
> >>   arch/arm64/boot/dts/marvell/ac5-98dx35xx.dtsi |  13 +
> >>   4 files changed, 406 insertions(+)
> >>   create mode 100644 arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
> >>   create mode 100644 arch/arm64/boot/dts/marvell/ac5-98dx35xx-rd.dts
> >>   create mode 100644 arch/arm64/boot/dts/marvell/ac5-98dx35xx.dtsi
> >>

[snip]

> >> +
> >> +            uart0: serial@12000 {
> >> +                compatible = "snps,dw-apb-uart";
> >> +                reg = <0x12000 0x100>;
> >> +                reg-shift = <2>;
> >> +                interrupts = <GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
> >> +                reg-io-width = <1>;
> >> +                clocks = <&cnm_clock>;
> >
> > With this change I see some garbled output when the "Serial: AMBA 
> > PL011 UART" driver starts.
> >
> > It could be that my bootloader has the same wrong clock value as the 
> > earlier iteration of this device tree.
> Fixing u-boot doesn't help but there are also references to 328000000 in 
> mv-ddr and ATF so I'll look to see if updating them fixes the issue 
> tomorrow.
> >

Interesting, because Marvell suggested to use cnm_clock with 328MHz for AC5, and 325MHz
for AC5X.

[snip]

> >> +
> >> +    clocks {
> >> +        cnm_clock: core-clock {
> >> +            compatible = "fixed-clock";
> >> +            #clock-cells = <0>;
> >> +            clock-frequency = <325000000>;
> >> +        };
> >> +
> >> +        spi_clock: spi-clock {
> >> +            compatible = "fixed-clock";
> >> +            #clock-cells = <0>;
> >> +            clock-frequency = <200000000>;
> >> +        };
> >> +    };
> >> +};

[snip]

Regards,
