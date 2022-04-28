Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CDF513B50
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 20:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350879AbiD1SUf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 14:20:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242119AbiD1SUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 14:20:32 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2064.outbound.protection.outlook.com [40.107.22.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E32D5676A;
        Thu, 28 Apr 2022 11:17:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PNsFLc1TF20lqJ5VwkT/m/zLQ2JhyeNLqWKAVdDdaorhpcvV8IAcBBgl8HdoSBl9feTpIiuEjRVhgrTOAy7b8TyJXQ3DOGy58LHr6eciIRZQJ+o7chEwOlrPsonmE+wpahuSMwOK9j5bzitxr5WjEFpplrQpS7qnR8hVPa1/3KDlCZjDmVyZkMC0hTz4Ib/9Ze5fxT56QMmLnWefj22/YOe0rWry30Votyr9nYj52MC+xT9ktP/+/uxKWdj2Uo42tH+gVPv7RbOnJh0mXz0mNzjtw5Xv4ZMbvNMkTk8yMIQ6f4AFELUouhkzO4HsE/bGXpqR0s/tzEktSGbwRsTHxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FS95gPAqjyt4XnA7kDTfu380VyfZNlv5oh9OBBTB+U4=;
 b=JmLCy/aGw6iml3r4XEAM1rxBm20UPfCLyxLln3V0A8r7FMRSIr4GkopK93mPCo5vNkTiRME50WZTzgTuGlLccvGB5hdlU0z/mVCpYbSrzSrPhOmSWdjcEusN14bAk0bdXFVDKqrrCtC+aJCCk93KRxiyaGI9nIgG9w0IfYz5Ce28SDI9+W54P1Ztrpl5aUbzk+B/YO/DVqQRd2/ODpPOIas+3sj7MncuXt08ahgLt0iE6GxJ4y3dQGcMDzTSlfxiRvjjjzf8wF6or8fq9+BUBqDeyJa6VazAOxux/NB+gAJYNVdsbWUoYTpU+s9rlS3MZsYiCXst6DziGdmxFkycmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=seco.com; dmarc=pass action=none header.from=seco.com;
 dkim=pass header.d=seco.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=seco.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FS95gPAqjyt4XnA7kDTfu380VyfZNlv5oh9OBBTB+U4=;
 b=lNB6zf8AyXf7k9iwWE8DClGi/EzRZ2l4XH5ncRzQf7IoLFNPgN8d9N2yuDXUTrR8DRlhywCUTuk/wa/8TbkbOdcFDr97zK7KOYxpM8UCk94hk4DUOu/xKerEW4YJqfn3x3wiBXgSEnX4H18pBFC0OXBKduWIWeRtKBYlVkcZi2ZrhBsBh2OQ319AE96YQmICyMVlcCXgjZWEYL7IYkbZpIJmkmWko4+xj3w83bvH/QViZU8xjBPG74DPMvz5oIOWZX5dbpfoxsriz8ALrgHlRvnmzScOo7XwFumuSYZ0ScWtLcy2vGcBAJVDgvF+xo2XBNCPAyYYBGdDH6DW7wx5sA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=seco.com;
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com (2603:10a6:10:7d::22)
 by AS8PR03MB6775.eurprd03.prod.outlook.com (2603:10a6:20b:29d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.14; Thu, 28 Apr
 2022 18:17:13 +0000
Received: from DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::a9d3:8abd:3f5e:a0c]) by DB7PR03MB4972.eurprd03.prod.outlook.com
 ([fe80::a9d3:8abd:3f5e:a0c%5]) with mapi id 15.20.5206.013; Thu, 28 Apr 2022
 18:17:13 +0000
From:   Sean Anderson <sean.anderson@seco.com>
To:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Cc:     Li Yang <leoyang.li@nxp.com>, linux-kernel@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Walle <michael@walle.cc>, Andrew Lunn <andrew@lunn.ch>,
        Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH v3 0/9] nvmem: sfp: binding updates and additions
Date:   Thu, 28 Apr 2022 14:16:54 -0400
Message-Id: <20220428181703.2194171-1-sean.anderson@seco.com>
X-Mailer: git-send-email 2.35.1.1320.gc452695387.dirty
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1PR13CA0117.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::32) To DB7PR03MB4972.eurprd03.prod.outlook.com
 (2603:10a6:10:7d::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2939103-0e71-4d6c-746d-08da294351b3
X-MS-TrafficTypeDiagnostic: AS8PR03MB6775:EE_
X-Microsoft-Antispam-PRVS: <AS8PR03MB6775ADBFABF0176860DBC0FF96FD9@AS8PR03MB6775.eurprd03.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sqi0ciE7r8i/c8Po1ScqpfsH/8Q59IT3JT430Juv/ErBrd7ulztEZNCcFT1Ae8UAV5kEr6lTLZqAl0G4EWAiF6nivowu8BxkYc8orW0Sbky/stopkQAPxq0nJ719wPz39tJ6JTqdKM+WeTShGxwVLLiH6MVM6SO6nqqBrsVmZI70de4OhF8J8cxpZE7qmD3whW3QHulC5DZuuO1SgtF04JeYQ3mCwVbJO04lI6D3ZKFC0WyBKVDGj4sSrV3i8Ldfsq6SGx1sQ8sZWH3uKVKl2XjMEPh5fBqMxCERt+Aktq1mce3TLpQ4qsZ38e4oTAl0IrLgn8wkD0e13IDdUVo7FZlfRZHV6Y40Kk+H9nG7TZC8E5AmFRo5lsHvTm9z22VR9ceJQOdMX+vz9/X3VuSHIMWex7wBnjOKfiQZrbZCccsEXaM25DXugU1USJIuwJpaa/1ch3m/PuuqheQNENWoniNtdRCdZkUsNEhrq2YQRNzzrzwUSACvUWHNf28tiW611kC6ImxqZROh47GT0y1iDj073kbI5hmXZX0i6Jc6Ui7g9r42xkKCBxAP8CowP+wfYWm/ze+HiHfgyukUVKGv6bTXKV4Mm+ze8X0oOe7BSsDVTfSfCeXvtD+24Bzxw34Pcecxla2sE01fNOl52nDWONbZnskbRPzf8tLA/5ixKUaUABw0E4c3vZpBSOuI3MEI32wlIniMER0CKNuQVVsgI5j7tUVHEMgPAcxII1RIbvTSOnQ9ETv+m7EfkCq9Xg5P8NQe18lswemJ2S4XpQIe3n5RmnIYU22UC8/4UtVzcMg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB7PR03MB4972.eurprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(966005)(5660300002)(8936002)(6486002)(86362001)(6666004)(2906002)(44832011)(1076003)(38350700002)(15650500001)(508600001)(7416002)(83380400001)(38100700002)(316002)(66946007)(186003)(66476007)(8676002)(66556008)(4326008)(36756003)(6506007)(54906003)(2616005)(107886003)(6512007)(26005)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?n8RLPheHIpNbk9AzTLaCJlh7jdTV5RFFfqWTkuFlPAVI6u3F9HgNQYkhARem?=
 =?us-ascii?Q?udiKSobrm73P57gf/c32fhRygqJyPpslKMnbKAoIerns05JZ3ofhUMxs+oUw?=
 =?us-ascii?Q?NFqqCa/tszFx9QkeCptZQqwpkMmGeT3dl5Y3qO0Qlwex5gl1rWRlTrxoal6y?=
 =?us-ascii?Q?nGomRAZBA/mgrq8IWqRckgENTmlel6nIHONo42APlCRlEiVSw6Mkr1gocQyr?=
 =?us-ascii?Q?vvMm8VmCK6JUGDLI9/MlbYv2qzjE9DEZ720o0N0gvVp7vi41B+V31GV6QFGq?=
 =?us-ascii?Q?MjIFpiy6XP0zf75ShbPi0DoEvWfouvfzWGjPZUfJopHnAqLO2ntqnimnAizO?=
 =?us-ascii?Q?pjARL/3FyxbSUGd717fZyqgjgaIi7qF1oxA75QBv/qwsNuULUIRXNh0eEdFv?=
 =?us-ascii?Q?wEr3QvxkXwpN13qiELPLYfrClKRSL0S/Qw+aWQN1QyhKIW7vpo5aK1je6280?=
 =?us-ascii?Q?JwSDU/Ys8FgdwANPo7kCNLTvU++gxSv2EyAsPOU5d0zR/dIqaERqBKLLw5R2?=
 =?us-ascii?Q?15M0VycpBLtYheX2PhWZv37QJGjz+Dcup6YbXiG5HCc1HRKgw54ie8rRy+AO?=
 =?us-ascii?Q?XCpITr0GUJ092upnWfH9pe1SHoHHnTE6KJT8gH6BQ5h9BRw5YoxESFwd09MO?=
 =?us-ascii?Q?d+VWYrcQv9znCqip8j+jdy0Ykb/QOMwOU+W1hgUAUA99QozfXEbbyt/+e1SR?=
 =?us-ascii?Q?f3SQKsgwJrIimfjXiclj0jrsFX0nOId56w9PC0BpeAnpwU64dntNnQN36Hhz?=
 =?us-ascii?Q?WtV21A4FP+2E8jFYLYLtIfZcwTpQ7gBo5enCu0dGzJQvuS27+dFPgxZ62HSE?=
 =?us-ascii?Q?LaJhP+JFqPMXJg1GUrKi1SvY3Eg/qfdqoantQ1Sf4gYBWFUYuxsEOExjy3BA?=
 =?us-ascii?Q?Ps+Jgf9MJVrpjGGc/F54nTWoY36UmYx1cFJe9nnC7BmlQWy/wBRKCTmboD05?=
 =?us-ascii?Q?Fmps8f/atTL8S2j9lLiPm2ijoEJxgS/CyOb70dBx9ih8aXDiuDe4RLiNUj9s?=
 =?us-ascii?Q?vYfBeWQeOI44pMmoKU2jl4TaOJZUTSusH3rDIaGTTL7AfjO1zQcn9wWGp1e0?=
 =?us-ascii?Q?i5OaFwcJOeKPahQ/XWG55SS97WrCwLh4BH5L5PhwhI8fgLidmnCY/DFgtLtr?=
 =?us-ascii?Q?O65A3UqYpAQZvulRejrfevkFU9OBhpwr4zaKIXD6dVuvdLRXBh07WXyqU7/P?=
 =?us-ascii?Q?6shyN34KzdaJOut1OYrlr0p5WsyFN7eaFuJsNlCQuqeDNwJKrK7AgOmGkbVE?=
 =?us-ascii?Q?hiFekLFpO/vCf6jmDU/3+wUwabOm3YM4srr0o40juNAV5zxmfjJJ4fZicRU8?=
 =?us-ascii?Q?yv5Nh6qy2Fc5cHq9HePlr79qOmpjzJvaI7dj17JbI0MG5WgZmUTDgeQLSBBg?=
 =?us-ascii?Q?w+DxueAS7Dg5nqbVASnb/pGauk4ZNtytwHTgSZ6pcgfb9gQMbfJMQ+9FwvtN?=
 =?us-ascii?Q?9T1jn1ndsIdqfmHWeOZzIKTzv+npy4Og5U7KL4RyL1C0SFXPPhtppO+zCi37?=
 =?us-ascii?Q?pyEQcRUaANEYxb85ELmGDIWm48u+DL0HjQp3LR318oL0Y7imAHobhQjosbSd?=
 =?us-ascii?Q?MXjxCATIiazainnlS6y1CIo979BUilHGSudGIXiIxl5p5+2ylnDHVjHE5YO/?=
 =?us-ascii?Q?masZio+ioQCSfqfeUbBcy2CpZVuzuCvxynxh8dGCXoRXL7YRP7kJb3yGyIzc?=
 =?us-ascii?Q?hYkZpFCpVCmem7FNrg2nZlKKV3DqcVnIVK0/7l8yJBmfJ00Y7ji0qpKuORUk?=
 =?us-ascii?Q?O0UG+EB2TCCxKJ60vMEbkHLL7Af+f04=3D?=
X-OriginatorOrg: seco.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2939103-0e71-4d6c-746d-08da294351b3
X-MS-Exchange-CrossTenant-AuthSource: DB7PR03MB4972.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2022 18:17:13.7859
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bebe97c3-6438-442e-ade3-ff17aa50e733
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ua4j2u7I/G1/n+t+9v2gZs3utoX2KTAtKoTTMRPGpZIczDP/2oiMeJbQNQrYjKFn1ogd40bk5W7bfB2d+M8DYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR03MB6775
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds several properties to the Layerscape Security Fuse Processor
(SFP) necessary for writing. Although the Linux driver does not use
these bindings, I plan to use them in U-Boot [1]. It also adds a new
compatibles for Trust Architecture (TA) 2.1 devices. In addition, it
also adds an SFP binding for all TA 2.1 and 3.0 devices.

I would like to get this series merged for 5.18. As noted in patch 2,
making the clock property mandatory is not an ABI break, but if this is
not applied then it would become an ABI break. The absolute minimum
patches to apply for this would be patches 2 and 5. The rest (including
the regmap changes) could be deferred if necessary.

[1] https://lore.kernel.org/u-boot/7c8e206a-cd40-2a77-6282-7f4bead2b13a@seco.com/T/#m591f8425b6f096ab3d54e6f7bd258e41cfa4c43b

Changes in v3:
- Update commit message to note that this binding has not yet been
  present in a relase, so it is OK to make otherwise breaking changes.

Changes in v2:
- Mention "regulator" in the description for ta-prog-sfp-supply
- Convert sfp driver to use regmap
- Fix various typos in commit messages

Sean Anderson (9):
  dt-bindings: nvmem: sfp: Fix typo
  dt-bindings: nvmem: sfp: Add clock properties
  dt-bindings: nvmem: sfp: Add TA_PROG_SFP supply
  dt-bindings: nvmem: sfp: Add compatible binding for TA 2.1 SFPs
  arm64: dts: ls1028a: Update SFP binding to include clock
  ARM: dts: layerscape: Add SFP binding for TA 2.1 devices
  ARM: dts: Add SFP binding for TA 3.0 devices
  nvmem: sfp: Use regmap
  nvmem: sfp: Add support for TA 2.1 devices

 .../bindings/nvmem/fsl,layerscape-sfp.yaml    | 30 ++++++++++++++--
 arch/arm/boot/dts/ls1021a.dtsi                |  7 ++++
 .../arm64/boot/dts/freescale/fsl-ls1012a.dtsi |  8 +++++
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi |  5 ++-
 .../arm64/boot/dts/freescale/fsl-ls1043a.dtsi |  8 +++++
 .../arm64/boot/dts/freescale/fsl-ls1046a.dtsi |  8 +++++
 .../arm64/boot/dts/freescale/fsl-ls1088a.dtsi |  8 +++++
 .../arm64/boot/dts/freescale/fsl-ls208xa.dtsi |  8 +++++
 .../arm64/boot/dts/freescale/fsl-lx2160a.dtsi |  8 +++++
 drivers/nvmem/Kconfig                         |  1 +
 drivers/nvmem/layerscape-sfp.c                | 36 ++++++++++++++-----
 11 files changed, 115 insertions(+), 12 deletions(-)

-- 
2.35.1.1320.gc452695387.dirty

