Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4FC54A24B
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 00:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235725AbiFMWy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 18:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiFMWy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 18:54:57 -0400
Received: from EUR02-AM5-obe.outbound.protection.outlook.com (mail-eopbgr00099.outbound.protection.outlook.com [40.107.0.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7609322536;
        Mon, 13 Jun 2022 15:54:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MN8pq3V3J8BG6SyTZ+1iwJXC0LpzsbxoEaRjT5aaylvcqU00l6uKq/MU2vhRG8/OCWfjVAfhfc6GfE+Q/I6XHJ1jlyvDApLz/kQJ7SYgoc9Q8KfV3jF8txDFM5xlaxeFe/QlTh0cq1cF/U3KaxSnrAzGHCjF0WmP5VAGC3FmfRSEzqFb1UlFFNzNFhXb4ciUg7fSSOk59I4gQDLg4UcE5+ThsstwcrlQTQ7G0mHhl1WD1Q+vEuLgzVYeejFcfEZwIZt9SZX2OUZfD1Aj2JlXY8AqmNssI7EFTzOEWvEnfbhtvDwUtdGpyDf994QMLkgtLPpF/WexHrdF3O91sY3/MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r9KEn1uUEcU4d9QSZ3D3D9crTJX02RE5fOeoMhVvovA=;
 b=BCxLg9G7qnREVyFbHZwcJC8Z8qivFdpfUKR4wTrolN49LMaPhi2v+X8oBqqUqOkunLZuYUhYjPbLf2wXX5RUhnRYW9il0plFSqNzp0kmeTsPJNU3wJN9PTzgGau1kRF8Qxmb9x9wduyHkGNW7wusOGUTfVj7iqPODd0B+siAhraUyyqcYmlpSbo6LMuNOl3mQnP3dPR5Pqe4Xy1xmAsjypopxiL3b0EdmSVrr+bfLNwAtCJHloQ3MgmnrDUPDnuswdONSIV7Vy5yadS1gmYWuOEqlsrtT5YjqZ28RGknycLtBQIHJD7EbxmMVPtOw+VmWT0D102/z8eSP13EA2Qrxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r9KEn1uUEcU4d9QSZ3D3D9crTJX02RE5fOeoMhVvovA=;
 b=I8y0jSBkywUqnija36908+AbsrDqUb8KXjUsVRx8tPzOcXd3rkZKq85iCn8KfQUSgRnweigRI2MdovF8CdGgxBGfySOo6jmmatgQ6yP1uaeIYL1nbj/tIgX0+fZLXV/DsXUa/DMmfQEq6PfutVtcDCOZWCTwKI3AFRE7lz+HteA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by DU0P190MB1801.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:349::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.20; Mon, 13 Jun
 2022 22:54:50 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2c45:bc33:2584:959a]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2c45:bc33:2584:959a%7]) with mapi id 15.20.5332.017; Mon, 13 Jun 2022
 22:54:50 +0000
From:   Vadym Kochan <vadym.kochan@plvision.eu>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Konstantin Porotchkin <kostap@marvell.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Andrew Lunn <andrew@lunn.ch>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v9 0/3] arm64: mvebu: Support for Marvell 98DX2530 (and variants)
Date:   Tue, 14 Jun 2022 01:53:21 +0300
Message-Id: <20220613225338.393-1-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: BE0P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::21) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a5c04945-d44d-4dd8-1c62-08da4d8fb873
X-MS-TrafficTypeDiagnostic: DU0P190MB1801:EE_
X-Microsoft-Antispam-PRVS: <DU0P190MB180175107D9F167BE996B7A795AB9@DU0P190MB1801.EURP190.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3cUwS4Zh8WqoyFTiWb5qFWSEQ0oMXWlfZDvBDzvB5q34EBYVaqBn6VnEyz6Uh478ExGTjmkFEfGJbwdwlptl7chgi8T7l3irgvFonlRw7gdF210GL9ji6YQnl0F+wR0DEhlI5IAr+ozB6GVL7u/kT3Eee0w9aazrUx8qDgi6e8DbdKJvM5OzZ9k0qlIdqZ/Y3tKr9QWsxqgI7d0Q1McA3QuTkj3g4lUmlOeQp7Z/zs77L2q1JwURCPRV5nET9osYJBaulQxSMm+5rGf/1UuP70opfTxekd5Lr5hxqASkNlmdgSeSO6uLlp2xkae6Vx6J0tOlieBqxyjZ+Q4kuE1XvINBCP4rc4pcgJEtZy5FZIKpbRmURXWPYa3LDkCnSPh4cw3vxGM2wh1yqXGF8xklklx00LeLG6VNYBE4G4hwn+P3OQj3NhmcoI9yxZ7gMP3xl1B8uQQagrzJoyP/UZh+r3rDSimZt4sQMavsqZgE6Kpq+sHkjVChxK4/mfPIpFguHYbpUWLNmapctDozgv20O1nMQYI3j/x3aewN1hBB+RJlAyxPPxy5eNGnJLmf6F+y2htQBIpGiG+/uB2U9O8WrYgM/6NqtHPoSmxnUEPktuw9+g0hmGRWQxMys6vY+4ECE5R3GZfGjEPoFKxijBiIwSEKMgJGCKi9DObPJFrQugvTwvdbgEO3pAXq5XC8hJJUaU4pCVa+wAkguA2EAO0XLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(39830400003)(396003)(366004)(316002)(7416002)(5660300002)(66476007)(19627235002)(8676002)(66946007)(66556008)(8936002)(44832011)(508600001)(86362001)(6486002)(38100700002)(6506007)(38350700002)(6666004)(26005)(6512007)(52116002)(2616005)(2906002)(110136005)(83380400001)(36756003)(41300700001)(1076003)(186003)(921005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3IiAPBH4Te4EhdyUZL0n5s9pnGBonysnj8uIMwqDsAo35NQ9lXTU4rWG79jJ?=
 =?us-ascii?Q?98A6W+6MPmalEMgvbNUZFkwyKkeOuYRsHVNQpHaB6BtNK45MrWsF7fxn9qm6?=
 =?us-ascii?Q?M4z6U77/EDq52oL6DKVeD8jCAFfPNhy084h3FOZeh4HZQDBHhRfzJpfQXRJV?=
 =?us-ascii?Q?7F1vqWT6aOk1f8nvNfL44Eilnym4XwULcJh2LAjyXMudl7vbNtN5Es5D3Z2q?=
 =?us-ascii?Q?hpvmAHLzcCk94FklT8VBNIkzXRtYBF6HVYTLNl9X0a/R/e0JWmg/32GPFplJ?=
 =?us-ascii?Q?yagemlEKQ84mkg9G+U5FFCGtjfYzmvzH2wOR0Rw0Pb48bKd+OknxNv27O4sH?=
 =?us-ascii?Q?YCu6gePTnM8OAFh0jgaQFFnZQbzCmtuGtQlmtClZbJ1lwjlY9hIuake8gNOI?=
 =?us-ascii?Q?tsxlNSkU5ctkoaJ1nsP3KLVKnMy+n9qlwhQqJJa05IlO2GcomNTxaKizQfXK?=
 =?us-ascii?Q?btO7X7MouOv4LgwUnpJ/6SrSLGGExDX+hTHdULak4oo6j55E8CFWqaDIQ2Of?=
 =?us-ascii?Q?f5E88Kw2Ttnlfp811PlySV3RC1b71ZhKdQIeeUzxJ3wLpQIizip2mri9nIdx?=
 =?us-ascii?Q?b1Sp+8vTM+1e78Wwt+v1b8svoiYMHydhV5AkaXaKu8DSNsT2lNGkVV1M0HTa?=
 =?us-ascii?Q?DqmDBoS6TnUzt16pgKRes7zbfh+VSlLSEyMSeal6PGP7uSf/UcOf8NDF5OxE?=
 =?us-ascii?Q?ERTzhoeXqgJfnu1Wh+Z4h8N+dBI/iJdMKc3Wbu8/RaFyZIk96ABjon2pPler?=
 =?us-ascii?Q?+lz1pMomh7Sy1D0B+J7uANElaKB39OWkP5B/DNWqE4CXEuX7J9uDivypzU62?=
 =?us-ascii?Q?L0gLIYzRMYOSq4n64NyX6l8I4GtaDfgtnNvwmU95TMbw1ebJwkUr+zZzzg3Y?=
 =?us-ascii?Q?9RNkTDEQVIe/oDJsN1W/vXEGdXtTH6OY9wsoAg8QKMR2sDW7q0ku9gVcQgIG?=
 =?us-ascii?Q?lZNfrrkteIHM9mWv+4dZkVSsuzthcoFkAwq9O4kbaaeHpIwS6xaURG+Btp4+?=
 =?us-ascii?Q?QPU0QJcc/kYxDnmCVLWTio9dxwCyCRLoDp5dI1d34UwIyqXigjmOaIJrlxmv?=
 =?us-ascii?Q?gw8uz05bn/R+PE6u0lufdHiJMwYmSgtECHt71CepC9Ee26f/QpTi1GzsRr26?=
 =?us-ascii?Q?E1xtlv0Tj5u1h8n5pd8/76AYSVrfTldq6GX/CZZ6egWGkCFwrDyJebAvujb2?=
 =?us-ascii?Q?qC/KzjtY3fRgnysuClhpOJDVMIY2f0edF28lLMla4Nt016zkh35ByNf/FkhA?=
 =?us-ascii?Q?CbzTg8gsx3CA2hXH6Kk/VvQ5uW710V2CJdHsFhk3nrabax9Ue9Lnzbi4glZg?=
 =?us-ascii?Q?bvXYDj0Pe90XpFeEh4qWGckj8+hy6pIShWa7Sxheih7QCejv+PNs5GKqKoHw?=
 =?us-ascii?Q?1rpootzvgimiHORDph1aHJpUxHRIKhXHYZCqWvLIj7XhjwgkjoxZ828CCyIC?=
 =?us-ascii?Q?8Dyc4Vg5tTOfz1JIvSGBDqRSJzZVg/jpxAOoVqpb4Zc1kvgE9By6JERH/tbR?=
 =?us-ascii?Q?CGTCHXPpvfZ11rdeBFMshL6xMX9MsZKBwuVPygcrrxMbRPo9aoPFhXNF6ZNp?=
 =?us-ascii?Q?O9rRM56I7xDhV9rpTMtZQqwZuBMmU9GSdd7kA5SgvjMoQ8QlNcGtPHEGinAN?=
 =?us-ascii?Q?sc9rV1FerM9Di2S8gYFrtjG2YPTTi3bE7JTdLtGOWMxZEwZ+pCRnYumjKnv9?=
 =?us-ascii?Q?2q1K6L124pSRESsOUbLczA2ildA9VfuTPv2vnvllq0VZXddLfQSs4g5eVuPW?=
 =?us-ascii?Q?UPuRlb6waKWbXhGIoj5EypevqyJ4Fcs=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c04945-d44d-4dd8-1c62-08da4d8fb873
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 22:54:49.9060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QinTFAzrqBShwTqjCgJ0HvvarrxDqUOhrKsfVSVuG0xbCHtS3MohnQdWpBJl+Txrn11aiIUDvJuNpdg/92BUdS5PpZHWUo681hPC2pB3KuI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0P190MB1801
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

 .../bindings/arm/marvell/ac5-98dx25xx.yaml    |  32 ++
 arch/arm64/Kconfig.platforms                  |   2 +
 arch/arm64/boot/dts/marvell/Makefile          |   1 +
 arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi | 291 ++++++++++++++++++
 .../boot/dts/marvell/ac5-98dx35xx-rd.dts      | 101 ++++++
 arch/arm64/boot/dts/marvell/ac5-98dx35xx.dtsi |  13 +
 6 files changed, 440 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/marvell/ac5-98dx25xx.yaml
 create mode 100644 arch/arm64/boot/dts/marvell/ac5-98dx25xx.dtsi
 create mode 100644 arch/arm64/boot/dts/marvell/ac5-98dx35xx-rd.dts
 create mode 100644 arch/arm64/boot/dts/marvell/ac5-98dx35xx.dtsi

-- 
2.17.1

