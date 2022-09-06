Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D32AD5AEF3E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 17:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232342AbiIFPq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 11:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbiIFPqe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 11:46:34 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2049.outbound.protection.outlook.com [40.107.22.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 093C7A6C1B;
        Tue,  6 Sep 2022 07:56:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ikvXC4L5p7ffLb/3N6yrnQLOq6kjOoyM1Dalemkw0r6nB/rWQmeLirl8gOsUAL2CwHukSGdkLd66M7bw5NWLJhoyayFZMjkdx4vDf1Uo1hPdrjen9tSQZS5HH+Q+mfiZsM42wh5mLEkOWg0fPigvtWXBiyPkfCdARPsI8OOl5ZaOpKlmlj9f23KmEuvNpiRAzLWIYb0PwqDNrQho5erUbzOkIB/ty8vhZgrytZwrt2XCmDd0hg2NwTE+HU+PrgaAny0Hpy0h+5mB4JbujlVjvmZH/atAWyjOFjXenUAaoYm8in4L0pPT937FFWuQVprwRAxvj1yocJaIOlrFZCvXOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/BbSir7CYZOdlxfoUG3n0uFeBM2N1mPiCwJyr02go5Q=;
 b=fcs9R8KaFLEhDQTikxZ+Y7ZTgRXtz5BqsbEAQkRrEF4TccxeX5KL83In47p0xHMm2i7l+HR0Xtxg+u+ZrnWsiWcVIvtKIKN8LuyQQgG7+qMXOpyTPovUdY0yClPMnvNi00HuxiFK1xl5ZRSiMQO2MS2/O3DoekWXBHeCXxthJvGqUkMgkOvs+u8hjUBI5yQkOGaWALe7lfKh2SeGyHi0UrnMtwrIj8cg+jC5JIpGSjXIovcfM+RiEG3ARf8pSIyi+E/Lsgy/5xTwniWSmO568soU2ElQQ/PJveVpS3NKQC5JM7EvrbeI4W6bKC1WbK9hqbEs3k87ELXXQIloHQASGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/BbSir7CYZOdlxfoUG3n0uFeBM2N1mPiCwJyr02go5Q=;
 b=k5h/3H1kSQpvTDbeudhQPI8Hg0TxOm+ScBIAI+f790Suiwex9BmA6F9DoXb0m8HKW6AQuaryXVS1uOstpUWqJ+CAwmV7eVlbyiK7eCQY9/27HLVl/MOgboiXb7jUPeqC+fpP6VyP7y6oU0FKeDlmZBCNhSM8uvg39zPZ+5rdG98=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by DB6PR0401MB2343.eurprd04.prod.outlook.com (2603:10a6:4:4a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.17; Tue, 6 Sep
 2022 14:56:45 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b152:60ce:3622:7962]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::b152:60ce:3622:7962%4]) with mapi id 15.20.5566.021; Tue, 6 Sep 2022
 14:56:44 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Marek Vasut <marex@denx.de>,
        Max Krummenacher <max.krummenacher@toradex.com>,
        Matthias Schiffer <matthias.schiffer@tq-group.com>,
        Denys Drozdov <denys.drozdov@toradex.com>,
        Tim Harvey <tharvey@gateworks.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Alex Marginean <alexandru.marginean@nxp.com>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Viorel Suman <viorel.suman@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>, Ming Qian <ming.qian@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Li Yang <leoyang.li@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        imx@lists.linux.dev
Subject: [PATCH RESEND v7 0/5] add imx8dxl evk support
Date:   Tue,  6 Sep 2022 09:55:23 -0500
Message-Id: <20220906145528.40079-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0102.namprd05.prod.outlook.com
 (2603:10b6:a03:334::17) To PAXPR04MB9185.eurprd04.prod.outlook.com
 (2603:10a6:102:231::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b83bce8e-799b-445e-56d8-08da901803da
X-MS-TrafficTypeDiagnostic: DB6PR0401MB2343:EE_
X-LD-Processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: m6MddRNjhMqhtsGw1FYgf0nmHwTyUxus6V5/3x12KWheiyS4EPFUUMeHXOqw2VoZG+v3TKnrdxtOfge7pr5svKtlsFMvU1m5ozT+ox5VY6og/VidchOLfz0Tpwkj4CPQDkI0Se5ut1rF3EPg4VmsAa9tkugqsTcMsX8YbmCGWS22+Ht0PE9440osqMNM1DW8zHlwm7q1iTmZ9IDJ4lpCGZE7vGZRSlFYIp7R/eK6uv5EMn2w5LTJ5ttsAszhs+XJ0sU/MRMHhny5k6WlsnV0q6IcWr8qzlYpG9XBdNRhgP7a6xJcrr2TgNnUCiLX3VWX57Pa1hgFW3oTZWG2K2LN7XTGMNvQy1aBNaETqxzO9G8XTDreACfgZyQebrMlA1L+rQmg9N89dfH832v5PGAk4wERIENZ37fBlcDOu1HCYAKEAt71enZAjMk+fdU6dDJIEuPfLmw7OZ3qzxEC+dUMC1yuZRdSZXw/gqAEBR4jHkLjv6pTe5d1RCxhRwZ4UEluGDjJQVsnp2RQnO8GmK41UF0CEwr5QhRnkKm4k2mWGnH8sG1JzevpzAX7FtDKDbMmoIf6akVYDLug+roz93mO+/A2HX28mE/OPO6pDJWqcj/nKG4jWRUa56t+6771p4PxXABQYlPNb/PyXQqkWknhoScTDv9gC0d6XVlj1i/1Av9dxwCBiz05ifR+ski4pE+As5R4LXXVMMx8ydUPC9b+9f7H5FTxGesSdfIBmfulYs4ZNfROfZp0wPU/A+FGEDilZBPMGZ2ROYxNI7yvXxI/YtURS/hwNlA1eGPwzHauBcs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(136003)(376002)(346002)(186003)(1076003)(2616005)(41300700001)(5660300002)(8936002)(83380400001)(316002)(54906003)(478600001)(55236004)(26005)(52116002)(66946007)(6512007)(44832011)(8676002)(38350700002)(86362001)(2906002)(6506007)(66556008)(6486002)(110136005)(66476007)(7416002)(38100700002)(6666004)(4326008)(36756003)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UQlLXBpZKs9eZbbTJGzwCjKCvuX0KnRSe9geSk9QKfQPjuDMlvNXYe+V5zB/?=
 =?us-ascii?Q?A0odgYdjE+5ChHN5cZNqGzyTZrbNyg49IIU+B3iurm9hVN70n1CX/uKdZ9vQ?=
 =?us-ascii?Q?NaGJ8LUH0WXFRe88wWILgUGezJY7tT3cMl7WwtOtOpxepBODIVbBfDA/jgtp?=
 =?us-ascii?Q?gyua9TxwnvP3Bf/+5wueIn5CfKV9U6Qxfu8ZXpx7LSnzelFTHAvyBdStZL3h?=
 =?us-ascii?Q?ibJvjpIEmWaoJAwzancOGRonozbc+IRH2fL7GUm64mU7/Mt0cLj0HaUUl/Ug?=
 =?us-ascii?Q?D8rkebrkmuuanXR31hfmupXikmJBrjJVXAby0gvsr3FRpT8IwYX46D2P3pFa?=
 =?us-ascii?Q?p08WgIEXBH3A9gL8weHBjQT+jDn5Rnc9CoFVNew9kfUTUNFhb0InSwUs2R9/?=
 =?us-ascii?Q?I3R8mYzWULoATF+2ocX3WMeEa5x8ETnVZLj+iPedDfUjHdAkPAOYSDj0sRtJ?=
 =?us-ascii?Q?Lle8YR76o1fWvTE9PkVVgXzCutr/pUE1vA4PJ50kIAr0Ws0JOviu04Vc6Kee?=
 =?us-ascii?Q?IOXVogFlJxbECLEUUZkl0rkCRKIdxTOBiktt95dn1g8AsIMBfLRp8oGIAo8d?=
 =?us-ascii?Q?TvvYq+bIQ0tvQiMywVZZMTO8LdBgczuWJqCTibIoDjwV0SDZvPc7VNSKEvWn?=
 =?us-ascii?Q?lceSHkxGqv5+cs5woz5iq8vRRGLZB4lfSLZEvkcr2xZ0ta7r5TN7IC+tHp8w?=
 =?us-ascii?Q?Mldm5ggO0/6WS2bOr3vc29wbjzNV8F7spaDt8T+Y/W05dWXBz8vdLTQcUolz?=
 =?us-ascii?Q?nZw73dGqWfsNdtuqh+SYS/P6qZt146T/4HxsQ5iaEsvkZi0kcYrFax6gCrdv?=
 =?us-ascii?Q?6AuCRArKg1RWHRRTbKGSsLWRvrEb8gYp1ikG7j2+WOUUXEp2rtxzB3UschTH?=
 =?us-ascii?Q?nqHKnrVL+59soRTU7xtWyTkhkdsiAUdEkZB6vLE3mucQE2HHJmzraFms7tT3?=
 =?us-ascii?Q?9BhANy+uDxUe+6adSs07cRJMz4bixCXVSOhkTJYOHZ31pnjU7oRmr5+FRRXb?=
 =?us-ascii?Q?YaXQT5pBrgtIUNolB2C38XUW6RgEltkxnGjPAn8GVI9yuUVY722DD+E8Z7uX?=
 =?us-ascii?Q?pIhoKT8EXOxnbJWjPNtCHUWfQZZ767pchH4RS7kx2xUmuMIeQdJcMUIIBVSu?=
 =?us-ascii?Q?t3jAFPUe6RXc0qr/y69IJpD+6emXAscLidpMWVbCEu9qbN8JHQsJcDdbEcgQ?=
 =?us-ascii?Q?YNwbI/Oj54LXBW2A0/ZA12O9T2bL1mc3Sx8tz6aOZPd7ePV1OQvxNXkWowzb?=
 =?us-ascii?Q?S/e7/ZjTH3kfvfvvCcU39q8PIBzM638Itl0M/pOwKeUT9OScUmjnPH5mrw2o?=
 =?us-ascii?Q?p2Eq7/BylgF/LcfDgSzlhziRUJ9rQld3Rg0W0zhkuiXhbVzZQXwyRJJznOdV?=
 =?us-ascii?Q?j44azd+Loqwv0JD4yGmkqiABdcAaqbfSAUtvGiLqohb5XBEtrbP/LuSRFC+T?=
 =?us-ascii?Q?Pcc9jCT/pN85glzFkVWOv+PU/HIQF2k1ryXMC8JoRAN8bZ1SD7S/msnwYQHw?=
 =?us-ascii?Q?YyHfodhUckN5pIdeaMmTXxClQ6Nk3P420nsc1kzSW65uB9jiY7PruirzfP+W?=
 =?us-ascii?Q?LCxWlvx6EYuzoIjc61uvDpzjiq8YIFeYzRYat+6hMz/bROGdRecWtwVVSSrR?=
 =?us-ascii?Q?9Q=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b83bce8e-799b-445e-56d8-08da901803da
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2022 14:56:44.7726
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AdBbFoXemW3Wyh1sO7zSZX+r4ajNkSnXV2uG8I1AnairxUHlc4mnYAi8wBikBN/WHDdAxuGOvSpWVZLTkT719w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6PR0401MB2343
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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

RESEND because the previous series of patches were disordered.

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

