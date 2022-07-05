Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 964A656776D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 21:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbiGETKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 15:10:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233363AbiGETKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 15:10:34 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2102.outbound.protection.outlook.com [40.107.20.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D165A2124A;
        Tue,  5 Jul 2022 12:10:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAO3/Kpbc1776bDTIdPBdf4ajPtStEjUJSqCGobY2oZ72nWe45lcZFwyVyLO/7A6AsU3QvrDNiIHVvJFxqMPEi18XyaZjdItVgpGBayJQ6H+4dL+93sQfgdZ+n6PVN/3CHl/wHN/kmZMJUk7aJMG84QGoN735ML0ErX1wxx2J5v1vzadMQUxoWyyO/vg9Aj+f1QfAHsZjh9ghvVaN6sBv0FfOccdelf5df9EVnK53ZXnDxjaFpQu94c7BASPfkwwFHUrFWMp8afHILqxaVgVhC4NTPPVYunz6atz4vGWoTZ+dgwRNH+XmlI3rrtTQX4ZEZwh2OwMKv6LGjKqBn9SJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fghr44sIkFcJZXx28lqYPENin7u/uTT/qSb17afZ1Sw=;
 b=X4+ZjgH2KrImYJAG9vpHkvrTWPd/KHYr1cvxX5QaUEuEby6jYmYfK1gRkBMomAOjK2ck0hXQ3WQ9ikN1tlWFlM0PbUomXWNgKOcvO/KjvFdPMKheNF/+dAGZMuV93s+911T+ybkN2LfgN0+IGieu0fLNOhwLRGr1EN8nSRj3b9GNRpMg/wH282sGY41ZS9kiE2rlttb7JHuOdlk3pTDh5VnJ1HgUd/QxGS0D2mdZwvYE9WBKLUZiJirZWPKXqc06EnrCCe61Y13UEGfsHpfegAhACKj/5U7FYI2E6YCvWDWiLSMov8TaW/x7ijO6FXEDj0Hde50Xvt0EYcJzk8frHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fghr44sIkFcJZXx28lqYPENin7u/uTT/qSb17afZ1Sw=;
 b=lcCLkymnXcrOT0AwgZedlDS2Pe7NKB38PLtHSecpWdnGuj6NhVmu0Himj3tCnK6xnW7DxgIoPAnwDfhgmCHh0p7uwo1J0z4Wbj38QGJpyENdapeS7UR4jueQK23ICT21THqIcXNSniorNYrrL+5NY99RGDtkUY94zYrjN/DJDcg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by AM9P190MB1426.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:3e4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Tue, 5 Jul
 2022 19:10:28 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2c45:bc33:2584:959a]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2c45:bc33:2584:959a%7]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 19:10:27 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Konstantin Porotchkin <kostap@marvell.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Robert Marko <robert.marko@sartura.hr>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Elad Nachman <enachman@marvell.com>
Subject: [PATCH v10 0/3] arm64: mvebu: Support for Marvell 98DX2530 (and variants)
Date:   Tue,  5 Jul 2022 22:09:18 +0300
Message-Id: <20220705190934.6168-1-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0047.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::15) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: bc9f922a-34b6-415b-25fc-08da5eba0583
X-MS-TrafficTypeDiagnostic: AM9P190MB1426:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fSNVqmrpvI+Pkb+5s+CNF72UlbS9AjzX02UUgWmtQPkUOqbrRi5zWJ0KY82iLfCJY5DrEvvCCQOlcQ1az8qA8atM18+uZXovqlX58ZNgjSVQlhQfy+fh8HBHANHFi/tWLUnCAnisibQSvxbns+qfkj/umiqgFZTkUt5nuh53L6NpWGbrQLms+/0h/8Pqllk7GV7DilHrbrIF3W8QlYa+HdzckgY01VfrfTu2+RAg4kaqs/PLIegLMpTejROrgwcPtCuwpzExDSjydaQKw1yYw0+GktRY4lXL3u+F8axguF8lwijkgXs902dxbNQHbH8gP9AjZWww9JSdInANXUk9VdsKruJ7UAMmTWTzjh+utYQLjm0h573nNhm2xXVAdBF7+o8/PgSkmMgH7Vn5EEiKcb0ARSSSXaxFyT+MSl2E0XXgptOGgAnKqQC6c+7/7xbooL+VI+CI9osOiOVhY+d+89flUkfCoJDQB9qpLqFVVBAMQb+jpjEgJKgmihuRvhPvl1in/Fg9c18eSK+EJrfwXmeqCyUSg187VzeU175ApRHnYuMSFDZgMrSvWW2I1xFwzM1EwHUCDipyEy8wOELpZgMp99a7DD+UdvvivYSpK9QUJtO1/qTX0qZp/NWgjGt8MUyMX7newNwwjN+Rx4B193mnPCXwsxCpD2oFrptGeU7wjmqMWtc9GOlPhArdkm383QvxpfUxf6qVUA2a2jjLtHzbZxrRMQie0lJ4aS/Eunh90MA47+ukzP3PwNKQiXfyZ1TLIOTroNe4AInr60NFNiOa//cPslnLD/1VyyC5okcoH6u68ETQtpDfTu58CBDgmE4C4iX36zK7FzRWRB7oSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39830400003)(376002)(346002)(136003)(366004)(396003)(110136005)(6512007)(19627235002)(316002)(26005)(41300700001)(6666004)(6506007)(52116002)(478600001)(6486002)(66556008)(66476007)(66946007)(2906002)(44832011)(4326008)(8676002)(5660300002)(38100700002)(38350700002)(86362001)(36756003)(921005)(186003)(1076003)(2616005)(83380400001)(8936002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cuakL0muTGALkFM43VAuiExuqM3CogjSx0JWF2wHEgdWMUQQ+iFhfFbcFrbU?=
 =?us-ascii?Q?rvSyQFL5gOzz1Ypu9DnkPN4wMUZh3lDYWaKS3BwojwE8OeeVk9gNE/6wgcuo?=
 =?us-ascii?Q?O9XKU8jpruYMddaRl/Pt0kZx7T0U6PTACXfNsJHynY/NDy6GzseGCsV9Al+o?=
 =?us-ascii?Q?0tXtDx1W6aupUY/ASnqHhTJtwlJ3gO7A1S05MjRE+ZUBSb3qjahyY5xscp1/?=
 =?us-ascii?Q?UXbEo4sokqJFjQtK/woBYpRP9J+H45VPRLnBRka2j4280XwX+5uduJXZXrYX?=
 =?us-ascii?Q?1UWSH1/4U9NwSUY0m5QGC773r8/1FDaH+vHB9HvR/oY1dEUA0ILsjVWt40Ar?=
 =?us-ascii?Q?3CRUb8448QHtftMTqTchBHtqMyPqA/U0Z3IK28sp+NJ8Z2f12KIEIugDxDSW?=
 =?us-ascii?Q?e5xL6K7RRCz2W+Kv29Br49i7e0ZZW1fLgmsQWZ7mqTN3TC4KAoXasgx7zZ8I?=
 =?us-ascii?Q?qxr2sJrY6G0X0Hn7PL2tfWElASs0pITHt18oCiyk5UXnGbpQU0OArNQOfvfL?=
 =?us-ascii?Q?6TiW79gtmehuRDBk2KbEoEFRtk+I8XYxTu0qFKH6MHmyFAtVu3i76YyXLcF7?=
 =?us-ascii?Q?U/YQw4Ucm/mCYaZQ0SSsKZC4cFy21Mh1AsQ8B3sm9Fkrr/jOVV6RIO1XJdOY?=
 =?us-ascii?Q?MscLItyhmVRwDsH3Tv5LqwHRDirLr50l9P1bSihtt1h77aAYjZGueq4lQB4u?=
 =?us-ascii?Q?EhqWpiN0JQgdAqCz2Nuu861xq5iIMU/x20dp8ioVlIhf5FyG+WIqItp2hNz2?=
 =?us-ascii?Q?KitrwbpSWpjU+ydLJACfZyRvlLtDnSuUfw+y2TfoIxAygULcvBZmuPgWpzS0?=
 =?us-ascii?Q?2mh1qAGxDrD/PIXevEVxcHOUCQCLVdedA9Uo86K5vVmro8IlaTBMHocTBHMG?=
 =?us-ascii?Q?N89p0RQDZK5yzEneZCkBGQndtOAWr14RC2liXLR1NQ08rGF1YFduG/P6Df0O?=
 =?us-ascii?Q?/E2qhPkyeUwNXLsOSt0Nl34BGAvVYG/Ldb+y6JP5vZRCQp1E5HmStfMYNw2Q?=
 =?us-ascii?Q?f8wjNStq8xj2CUJAW5arWv5T53ciKukEk/6rM5sSz8tUvh5BrG4tQOBJti9/?=
 =?us-ascii?Q?25MGNbjbrG70G7lO93TUt8jNAZgMb/0XGq3XRS3R/Sd0fa/txNrOe0EMr6vO?=
 =?us-ascii?Q?jjEI4bevuMgQ7nfAJjj2MsEqAj1yOwgdnqp7KPgeEkh5HDCnoQcFA7sm4aL+?=
 =?us-ascii?Q?IB/xc9TyCICmxrnZB7l27C+B8xRdrt2/sNWfVxT9Yp1OC1KKdI3evOjghCPM?=
 =?us-ascii?Q?HNT3ixZlABZ0GSFZKi9WshKAonlzIXPt9dHlp71CycCDr6QF6YgZioRConZ5?=
 =?us-ascii?Q?REu6kziyebQ7jiscsbYR0MZHagfLUKilzZVdCqBpr7IBfaLXu6Hzp0yErUZA?=
 =?us-ascii?Q?bcGCyLos2+rgSQx4zAXbA3jASIsNBldyahGYzUBrqcsn6Cr4qHe+BDaUhvOC?=
 =?us-ascii?Q?vcFbEHOnLV3ZuaLz/EN4XhThdTzIN9A+kOpCJGdDy7pTKzMGwo3l9uGtQktX?=
 =?us-ascii?Q?DwSS9GOTP3m7N9BTIUpYoj7RVkxWHnKu292WEZVFgB0m8Zy3KK7BDL8DT0ZF?=
 =?us-ascii?Q?V8AVBi730qnyS43Kc8oPbR9uk4YjQ08I9WhkaKNNU2Ub0A7kHAVAwc0FjKTY?=
 =?us-ascii?Q?8w=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: bc9f922a-34b6-415b-25fc-08da5eba0583
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 19:10:27.7005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OOVwbBoLuuWqZQItQrZeBwQdcNg5YFL02Dh+uyborB00zQZF9ngri8juLTI8jB2bY0BZxgZYHPXkXAlJXHjw0VZTzf1lfatOfCYgT+OfQE8=
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

This series adds support for the Marvell 98DX2530 SoC which is the Control and
Management CPU integrated into the AlleyCat5/AlleyCat5X series of Marvell
switches.

The CPU core is an ARM Cortex-A55 with neon, simd and crypto extensions.

This is fairly similar to the Armada-3700 SoC so most of the required
peripherals are already supported. This series adds a devicetree and pinctrl
driver for the SoC and the RD-AC5X-32G16HVG6HLG reference board.

The pinctrl changes from v4 have been picked up and are in linux-next so I
haven't included them in this round. That leaves just the dts files and a minor
Kconfig update for arm64.

Changes:

v10:
      1) Use different cnm clock for AC5 and AC5X DTSIs

      2) Rename device-tree yaml binding to match the $id

v9 (proposed by Marvell):
   It was discussed with Chris that Marvell will add some changes:
      1) Rename "armada-" prefix in dts(i) file names to ac5, because
         Armada has not much common with AC5 SoC.

      2) Add clock fixes:
         a) rename core_clock to cnm_clock

         b) remove axi_clock

         c) change cnm_clock to 325MHZ

         d) use cnm_clock for the UART

Chris Packham (3):
  dt-bindings: marvell: Document the AC5/AC5X compatibles
  arm64: dts: marvell: Add Armada 98DX2530 SoC and RD-AC5X board
  arm64: marvell: enable the 98DX2530 pinctrl driver

 .../bindings/arm/marvell/marvell,ac5.yaml     |  32 ++
 arch/arm64/Kconfig.platforms                  |   2 +
 arch/arm64/boot/dts/marvell/Makefile          |   1 +
 arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi | 291 ++++++++++++++++++
 .../boot/dts/marvell/ac5-98dx35xx-rd.dts      | 101 ++++++
 arch/arm64/boot/dts/marvell/ac5-98dx35xx.dtsi |  17 +
 6 files changed, 444 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/marvell,ac5.yaml
 create mode 100644 arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/ac5-98dx35xx-rd.dts
 create mode 100644 arch/arm64/boot/dts/marvell/ac5-98dx35xx.dtsi

-- 
2.17.1

