Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0CB75AED9D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242098AbiIFOcK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:32:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242099AbiIFObv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:31:51 -0400
Received: from EUR03-AM7-obe.outbound.protection.outlook.com (mail-am7eur03on20627.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaf::627])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 071F07E01A;
        Tue,  6 Sep 2022 06:57:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRISwKFMccnaqS8fmqMITylY4xmpjjzUlk9YyMTMZhUYDYILWF0r4ibESIXgob1njz5DBmOjUYIxKb0+mqSGGQI+n6nzoiAwGJAzaN+QK+FjODl8vLOdGUsjEcoid2N42iMUExCM4P6+Y6otVG+kBpAFIcwz748RkDcJJ1eb3vq9U6Tbkeh2z+WUGlvwNogNHu+0Wf05Yt5PjedIVeP4vvBPHbmHTweHlrKhpMUeTuFDsKktNgnjC8ZKmsCAXAUXKc1BRhPg2WA/pF7U8O6Tyz+eumQBmDvITaA6lW256CPYJA8nZWiQi/YO//JW/+1eum2holJ72S5/GGesoWE6Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lYCa7SHNyGn4GbtZwrqGqgHMYR3oX3xBRFhglSM2w/I=;
 b=Zpri0x7N8tDIexKNMEKZecbJq6LdUKYD+sZhFHUGpQbMuHkm3wPSGizNE2EyptqzkjmxZbZ3lv6mYoVDj/1prAQIsRF8Z6okb1bM+xFIdpMkG/NHGOYT7mBEoDIkyT8F92Cm2i8/Iqdk3AKyYgyDPTVbNjX4ifRdJBr2VMarbpNj7MdCVBRwLjuvMo2lDxw36xOgONStnT8UgvWYGzeME1ShWrLyfv8vWgr3HqC4SChgbDd7zZzqqi1dRdKpGr8A1lZPg3RImJLZdixP4XqVdxI54rp14v41thm1aXvfaaINrI8exY0v9mZUot+i1Xw4LogKI03IjYuwa/0w1FWVCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lYCa7SHNyGn4GbtZwrqGqgHMYR3oX3xBRFhglSM2w/I=;
 b=gWFjOhMsE5t+O+aVazXHSnLL5UHwzYDLfDuS3/N9jtJ6tKOm28rQ5A9yLKdUVF7/EyoxEtQkKRx98JmzM+y5hmy8taBhrfrRd6hQqhV9xHOHtHHIUAEOalSYow29bWrtvo3g2/m92vQA0fzdKYuTpG4guUE3AjRUTaszR3MaRtg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by PAXPR04MB8749.eurprd04.prod.outlook.com (2603:10a6:102:21f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Tue, 6 Sep
 2022 13:53:53 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b152:60ce:3622:7962]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b152:60ce:3622:7962%4]) with mapi id 15.20.5566.021; Tue, 6 Sep 2022
 13:53:53 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Denys Drozdov <denys.drozdov@toradex.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Marek Vasut <marex@denx.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        Peng Fan <peng.fan@nxp.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>, Ming Qian <ming.qian@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        imx@lists.linux.dev
Subject: [PATCH v7 0/5] add imx8dxl evk support
Date:   Tue,  6 Sep 2022 08:53:37 -0500
Message-Id: <20220906135345.38345-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0089.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::30) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee238af5-b946-4114-2b82-08da900f3bb5
X-MS-TrafficTypeDiagnostic: PAXPR04MB8749:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2zF0YhMsvmctrSZ6kwDCFG0YTkbNdwlXLJxvRZTGoMEcTUl+wLPIXCey/WGMFaM9+QB6/I/ijrRqQ64D1D7LGFpUkI3fS4mp+62NZV/WLL5/mWRTInviu+PsBV02y/pdFAVgSsJfqYl9HqKGNXD/DG7aeRfwArKpDfwOhopbcAwhvOveIskAsWMvbFyqqmEN644rbTuJjZLr/E/1vqYv7pkdLSOsnfw3ymKaoRotzXDK+M1FScxsSFWBH/jN8xu6qw0ccG+i0vO0t45WHzNfwu+wNuWZmwfwc88Fpz+/j7/beZCwXL0ldzR/Y3OR5PxrmFUVKLilS09tDZFBh5Z2lRQLOkOClvqcsyukWRRrrnZkuBK4QnC1rI36I5Ncz0HqNX98bnw0JD5WcoaWp+CqLkyK1Qds60IDSo5UB2gBGJTmMj0MQQGDO4hcT37AimvqPBddvO1APguyn3FiTl4WUr5fP8fGYltfP5NuTbMZD2c2jLcrTzPMUglklhBc7SmtrlGVqTxoNDeMNEmypJisMBlGAJnldZonhEszKiG5eJDzAY1WWDpVWlm10BZ7GG5X87iAArF0irtCxx4G0IT2EHv3KYfV2HuWX5HpWkCqItUVRBKO1fx9wTkKLbaUPMiVkaqBwI1abVtYZqO+5T049C0oHswCXjI/xN2Oidgc7n3ig7XYFaQJsEHyiBdSuO2wkLLTq0o0GeQ9ZSosWS7Uhe2wbuSKt4L3m373IfiZFqXF9F38jq4k+YhcMe/T0L7LnIAruccmo+F2Ks4fSJuUAw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(8676002)(86362001)(36756003)(66556008)(66946007)(66476007)(4326008)(38350700002)(38100700002)(6486002)(6512007)(478600001)(6506007)(52116002)(41300700001)(83380400001)(6666004)(26005)(55236004)(1076003)(186003)(316002)(54906003)(110136005)(2906002)(2616005)(7416002)(5660300002)(44832011)(8936002)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7VDk9jDMwCb40QrqoKgZcqqdZA5qX+vvNMLiXFO69mb6Qn15a6/FbBZb9/yL?=
 =?us-ascii?Q?e4G+YqW3kaAE64yLnVnxMLMsElDcf0kax58Fw0rZ1UXyC5G9wmKTT3UBUh+V?=
 =?us-ascii?Q?rRXIQ1S/LGlWwnlAo0rpVTF/022sI9USkSox17kAvIfHd9xbScC9iANLiyVo?=
 =?us-ascii?Q?2d+8Vz0i6ZTzvG/3vIy2+BKHeGznr7tIyJNPWRTMdjtihTSXDZCsOusDJWU/?=
 =?us-ascii?Q?Cp0xHrwLCAsoYYchVsozuRTmjZ9ph1wWsYLQ2dJKRuOcWdP8z8+znAuuHUEw?=
 =?us-ascii?Q?nP62MbzzeVS0c1a/rgkatWSA8wyRBoU+/tBBqC6FK8q3G1X96JVrtWaKv97+?=
 =?us-ascii?Q?AnuRLg1MFH9kpEmiTq214aLbtow4ZT1kktXd0QFVaucOndUFO40w2RO5jqDm?=
 =?us-ascii?Q?HjFqqMP16Ib0tEKagAXfTTjRcQtQGvy3IHlYybEklJAh6BtmgpxjMcArNZkQ?=
 =?us-ascii?Q?AiGRY4Gdqcq9V94r36PLG2REOmw7CW0tn8l7TV/fwv7qOI1abEtE77GlZ+y8?=
 =?us-ascii?Q?44twihrjtZbCGPWtDcs+1dgjklwHo8hHYdEqWmF8XbpjITU5QT8mIOaKgbyk?=
 =?us-ascii?Q?kAAKTM/20Rtf5PnOomXP57oDE1qIAC4cyznztQ58xCQhUcELtSz1mF3GBB13?=
 =?us-ascii?Q?YOcjKVHpPBsZAmWvd4R+Z/3ceeQJ8DRrin79wPU6v29NHYsQEPvAbgQAgdF4?=
 =?us-ascii?Q?Ii+tKYDPQ3bwFz5PA+XfgsS1mlI8ucG0ckd27zHHATBw8stWxyDMI/p1Nu6n?=
 =?us-ascii?Q?XEsLnzbevWFpU10VhyQagD3Tr8N1tLN1i4hQ4ASAqWjC/wce1x/IsPQpzBUt?=
 =?us-ascii?Q?PSSGknregcoxWlvEM59Khkll8RLWNZxwssP68ptWJsTQdOliwjDEXfxRJcrb?=
 =?us-ascii?Q?F7KPi0Aa2/ruBghZtRBMqqMJebQVKlv/Ffn79lm4DIm/DL8szSw+uGj90bgt?=
 =?us-ascii?Q?suXDuZDMYcOI1vHA5eyu3UFjwQrZzyFlShd1C+dOhUirnr0kFvi6W95WpKWm?=
 =?us-ascii?Q?WKEWHpRBQerL+SjpqJUzYmlR6AykOSDrA2Xlpsx/I8fHFTw8FbrpxTfmGKM6?=
 =?us-ascii?Q?TSwWsmFW+WwxNV1GpyIl15HfmVBY7WMp0Sw0H7ucHoSnF0Vt8wzabn/Mp5yp?=
 =?us-ascii?Q?fPwoLz54n0ZQjySdX8Vf+j+3kqUtmvKjDxk8WAMZWudZ8KK9uzS6nRVW5VbF?=
 =?us-ascii?Q?D1CtLFaBJusp/S86v7kYIXenNEUBQIw+XpFI1HEuh+ps4MXev1vlcCp7xkti?=
 =?us-ascii?Q?GiJX135yUqyUmDArRBYmiWikhPuhMt/vmNraavs/6VUiYiU67h26NuCo/Wxi?=
 =?us-ascii?Q?AhLxk4XFm08fAD8U6xrBW8Otn5QGkXxg3Bgzn5Sd+lBSNBpjOta7Pk5S6Z9y?=
 =?us-ascii?Q?i64zMqjv+rj9d+lQOAuPgFrRzgjnVb8k+SarQ4vDdrLwi1TrvXijGij0n05l?=
 =?us-ascii?Q?MP/CZxlbIj5n3MAjuHH008W+xywbncvNvdfW4JVerW7sSj2/VmnQXCMU/K7r?=
 =?us-ascii?Q?JVZz2ztevbr1U59Gv4s2vduIegCGIwvbXx4CnYbKoQCcPcMFX6S7+lTWqMyj?=
 =?us-ascii?Q?hxqQ5KzrU42iduCEDg6NDtWftRCfEdjrT+edIAUM?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee238af5-b946-4114-2b82-08da900f3bb5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 13:53:53.0890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y7ty/jv40rYZ0dV/gigL/3g6mhZ5Jgru5uSp1WHJ7druvCa113d3FeAq3KCjQXG2ZAHq0wINx29NFkIu95LU3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8749
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX8DXL is a device targeting the automotive and industrial market
segments. The chip is designed to achieve both high performance and
low power consumption. It has a dual (2x) Cortex-A35 processor.

The series of patches is to add the imx8dxl soc and its evk board
support.

changes in V7:
  - move the fec1 reset gpio into its phy node

changes in V6:
  - The V6 changes mainly respond to the comments from Shawn
  - Separate the V5 patch into SoC and Board commits
  - Remove the unnecessary properties of "max-frequency"
    in usdhc2 node
  - Remove the unnecessary properties of "clk_csr" in eqos node
  - Fix several coding style problems

changes in V5:
  - change the "scu" node name to "system-controller"
  - fix the typo in the comments for imx8dxl evk board

changes in V4:
  - move i2c/mmc/serial aliases from soc to board
  - correct the node names to follow the generic names recommendation
  - remove some unused nodes in the evk board dts

changes in V3:
  - re-order the commit sequence according to Krzysztof's feedback
  - correct the syntax and styple problems pointed by Krzysztof
    (Thank you for the detailed review, Krzysztof!)
  - remove the unused nodes in imx8dxl-evk.dts
  - dt_binding_check passed

Changes in V2:
  - removed the edma2 device node because the edma v3 driver hasn't been
    upstreamed yet.
  - removed the imx8dxl_cm4 alias to fix the compile error.
  - removed the extra blank lines at EOF.
  - dt_binding_check passed.

Shenwei Wang (5):
  dt-bindings: firmware: add missing resource IDs for imx8dxl
  dt-bindings: arm: imx: update fsl.yaml for imx8dxl
  arm64: dts: imx8: add a node label to ddr-pmu
  arm64: dts: freescale: add i.MX8DXL SoC support
  arm64: dts: freescale: add support for i.MX8DXL EVK board

 .../devicetree/bindings/arm/fsl.yaml          |   6 +
 arch/arm64/boot/dts/freescale/Makefile        |   1 +
 .../arm64/boot/dts/freescale/imx8-ss-ddr.dtsi |   2 +-
 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts | 426 ++++++++++++++++++
 .../boot/dts/freescale/imx8dxl-ss-adma.dtsi   |  52 +++
 .../boot/dts/freescale/imx8dxl-ss-conn.dtsi   | 142 ++++++
 .../boot/dts/freescale/imx8dxl-ss-ddr.dtsi    |   9 +
 .../boot/dts/freescale/imx8dxl-ss-lsio.dtsi   |  74 +++
 arch/arm64/boot/dts/freescale/imx8dxl.dtsi    | 238 ++++++++++
 include/dt-bindings/firmware/imx/rsrc.h       |   7 +
 10 files changed, 956 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl-evk.dts
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl-ss-adma.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl-ss-conn.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl-ss-ddr.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl-ss-lsio.dtsi
 create mode 100644 arch/arm64/boot/dts/freescale/imx8dxl.dtsi

--
2.25.1

