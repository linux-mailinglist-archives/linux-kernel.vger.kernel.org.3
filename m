Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 236F054A254
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 00:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235897AbiFMWz4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 18:55:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbiFMWzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 18:55:47 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2133.outbound.protection.outlook.com [40.107.20.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03D323150D;
        Mon, 13 Jun 2022 15:55:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V4L/Yk+XLEXFWaAyEskshtcIkphpTZmYCeNjjRr/FBwScrKryU5/Xi30R8ncL4q7rOJWzAwZV/WbkvEKT9qqZyKvOJ6H0vCcFmm3cbGlk5iRd3wVmWUE+RzXNlVO3ONUMpFcW0anrrsgBve5+qPGUmDEwb46hUcja09m9EdoIJ41ztv5OCnN9d59B4mBuHsc6jlKlOF3EyzFk1RY0hl6tiGEYg0qwCUYAO5VspvTiDTwTNWGpmg2SUaQ1f7iQxx3/3Clp1N1+t6T0SztoxoG87STT9vqYe02vQzgSpStsYpQEltHwuqvUxASS64c+WU4eyqlHxMMPk7sm++TSERQBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tp7d/F55p4rcoVThy76G8xu7FRvIJIiMUMzcL0B739A=;
 b=g3LUHVM9d/28U0NWTjAi3ad/MJYjaOFxVWtCTOaVtNCfQm5C84B5WrCIFbB6aPdTtEQ7QkR+tVar/SXCiOqMF0rdm3JUQsH773wN9f1oJB6P9mdyAHksmTYYYE4XOluGC54YKpM3K1bGpmKZLUl4rm+65I1OuL0tGhpEQxTQDne50ZMg8SHT9uBZgVk+crYLlaXlepNsPJSUN813EL025tTpU+Siw2oc3h76KwVQwlvFdHj26wIlnwAz/y33YE7Wqd/hHr9CGrNyLMn+ccy+Yw6pHt9hscT3bfSOo3lQ461BWDVHEnGkvU7A21USxMThN8hHTwKzT6eL8u723Nw2yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tp7d/F55p4rcoVThy76G8xu7FRvIJIiMUMzcL0B739A=;
 b=u8ftiQ9UjcA50aRZTqZgQfHNRCqfiNN8Bl7isLiEOA9kf76RRSceRXLWo3+Pm5t/xUOHLdv+nh+ZYuy2frlxnFSBWf2PE6qTG+o7VcNBKRyp8oxbBplJBx4RKYkWGcaFk3HEWsQ2Esq3FT0TW+Kt4cjJjlO/KN8prcXP1+jWkRk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by DB6P190MB0568.EURP190.PROD.OUTLOOK.COM (2603:10a6:6:31::24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5332.13; Mon, 13 Jun 2022 22:55:40 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2c45:bc33:2584:959a]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2c45:bc33:2584:959a%7]) with mapi id 15.20.5332.017; Mon, 13 Jun 2022
 22:55:40 +0000
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
Subject: [PATCH v9 3/3] arm64: marvell: enable the 98DX2530 pinctrl driver
Date:   Tue, 14 Jun 2022 01:53:24 +0300
Message-Id: <20220613225338.393-4-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220613225338.393-1-vadym.kochan@plvision.eu>
References: <20220613225338.393-1-vadym.kochan@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: BE0P281CA0034.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:14::21) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 09356605-1d84-4dba-f34a-08da4d8fd65e
X-MS-TrafficTypeDiagnostic: DB6P190MB0568:EE_
X-Microsoft-Antispam-PRVS: <DB6P190MB0568AC7A59E6C8C6C644155F95AB9@DB6P190MB0568.EURP190.PROD.OUTLOOK.COM>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GhFpLymRMxShCW2emX6698DpOkNi2bOdqHZ+J4raFXrpaKs1UW+sO/GKhJ7I3T4zz/tx4TNyA8e0BGiBkf2lI0TopN6USu6A8ksewcCUn1Jwrut/lVClt2pyIUdWPqhEc8YOR+lH4LkIpjchpJjpcRWqJDDxnKGzUHi6mSoSJQc8gaZqfoaht7Nf8oCo+qKEKqVrSE9LCokCziP+mhunQPPiZ6/0bOOTx4EYQTztA7HLskTMS5mE+oNldQ77rJdi8bIOKyNTLceBFI0cxZ2Kh1Nch9paSvGMypjdZws3tsdLabAmTrJVE4M472i/jN42vbJD1UBePnc90vrfgsxEbSn+XD49WHq8EWuLeYGK3XGH4JomecMin2M2H9fYte0W0wb0S8krNt4mKJpHGkxpwhGw/Bl4XRwitIG0AdBlxCzJAf0xJbNy8cNxbNN/JBnpzXIVmykn49Gl/H/ZXoX9XLkVviQhPc9VxivkZLxDrnb1GTDKYA2mmcMrdlOP3TpxozK9fGnXVVB/+U3vRLXnP1NlR8Im/DIUkEAaamBTFFINCI5NTjzq+EQvTNWMZdzB+aJhiqMiG+JmmzNPMoD9b4xmB5yeXHAmlxTGVs4cm+5oeALG7niC1Lw+xze3TlXcna5Egy/7akNljV4Pm+p1zNFApV1XhYnpcETAhTTtkHQRiQvgAdJpH35q0Pppz8VY4N1A5+Zuc4C1J/AWHl2HenmMMTglSRbKGiR5iLZ/lVQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(39830400003)(396003)(136003)(7416002)(36756003)(316002)(66946007)(41300700001)(8676002)(5660300002)(44832011)(66476007)(6486002)(8936002)(86362001)(508600001)(66556008)(110136005)(38350700002)(38100700002)(6506007)(52116002)(6666004)(2906002)(26005)(921005)(6512007)(2616005)(186003)(1076003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?M3lMg6j5ZobrHC7Z8PnMZW5e3+6GsiQBvfyA49MJ1gSS8lJgd2lfGQU6VyH6?=
 =?us-ascii?Q?4iSCm8MAd06fBCgD4DBWw27a29U8aPDKkQqR1UO2yV9iYqOh6CKnohk3YyAo?=
 =?us-ascii?Q?W5efkHzdsgedXvyhRhjcHs/6LMpXlfPTd3W68kKf3+gI+4xUBlqbpNChFQ/X?=
 =?us-ascii?Q?lXMf8wr4U0W1goVrdvgIFa0CAefGaGKyeX2YOfNpI0OlXw2n2CwqEQntBtNo?=
 =?us-ascii?Q?KtX1jNI3WsWAbJ4TUpYvujnWhxUXaRCb3giL3T7GvaFQsFc/YwKrNuo14J14?=
 =?us-ascii?Q?9q7Cvt3OFvGDeJAdqY9AjyFW7b5j+jcY5wZzsZ4r0qZIzk9URTThBUZNAHSd?=
 =?us-ascii?Q?Ee4CP3ZWUhC/+DMVu5LHblqtzOVjVPVksn3VLqZ5Dgn1sqkqtoBwjQCoCccf?=
 =?us-ascii?Q?xYslomMsXMQm8TvVciIEhavm+V/qg48EG2wDevRxCodaqITejaaB8XfwdFeQ?=
 =?us-ascii?Q?jA4KXMHfpIZqkWTjqvB79xSFJ0UZ4c+0kr8t53nK2p0wWmWhhlJ1gPyqo5P8?=
 =?us-ascii?Q?IAeFIgK7lYm/6nrxRVxmI/kqPP406ulqH5cBlcj2x/wfZvJX0UMEF+AgEZli?=
 =?us-ascii?Q?EaoLmKf4wTEDcCxG5O8/FgyGxrAGUA/U8lEdcJa6CCF8EKEMTPiM+2mb2HmI?=
 =?us-ascii?Q?tzOwyD3Ilj22NZamrrtb2OeDpAQTNxWbgH2nPplFAFLuNEx+QSa2N/js7brV?=
 =?us-ascii?Q?PzhZyyPyci8+GXKSkuZDJAF+cydCq5BcabGEA8ZL4gN1CdsyHf1aKcys1QDJ?=
 =?us-ascii?Q?frEBrYPlIyAFsRDIOXuZXNMpnBLq7o0oj6Uze7RRK76mFuX6zf12+zdwDPMl?=
 =?us-ascii?Q?SQGiOYG2PQbFsI3CCeyczPPGWbpzvWXM6CvQQyr/fqUbuHSWSxjypuqYnp/r?=
 =?us-ascii?Q?inuER11SboQy3SxiHLP+rukvmftxtio/xtn+xMSrhdu5hv8yLOv/iUkZM/He?=
 =?us-ascii?Q?Bi9vQRmJwwlyLFRtM42QNARQY52U4gfV2RIPoNZt7U9y9CQHN/IcMVOKSZei?=
 =?us-ascii?Q?CKjVSmByJE5P9mPmFLaNRHuCcdLa4/sGTIftuvxHxTBp5yzLsyXRn4+fZ/t5?=
 =?us-ascii?Q?18sqxdymd8qduxaCuqg8yGUFpgPyU0XoCpzeDxWbhhGw05EtxlZyF/EFrm3Q?=
 =?us-ascii?Q?F9TzHQ11RSsyjJ0D9jLq7mX3mNLRh6/BDr/1QHwwftKy2HG9mbWmdwWiVgaO?=
 =?us-ascii?Q?8vsJavu8Pj2ESrukA2Lymts1iD6tvvkdAngMv1+Zo8hurhQOPH98jwbFToRc?=
 =?us-ascii?Q?V8TA8shWrJn18/iAGJzQM+axsfkxMkIqB0ZYxQuhBHZDQe3fkHtiwsjlRVI9?=
 =?us-ascii?Q?OnPwOxdHmHbr6aHssoB1sI3TAlmyYpNVpfQgWJPbyXoxdswd/zIU5XTLEpfx?=
 =?us-ascii?Q?h6Lyqqe+nP4Xiid4dgWMnltEqG1r6hmrKoxEj/1dZEEzvVQPHZL1KlNvl78f?=
 =?us-ascii?Q?sCMgq5wIIf68LAc0RpoVz4ciNMkrB+H2zV8YxVIz1f3LPv6B/4z8iTk5HeuF?=
 =?us-ascii?Q?RM/abw1R0ZJhzoy4FY4DPasft4rDRNYjDwkmtSX3ej+RQR7lcgUBzEw7TuwA?=
 =?us-ascii?Q?QyeRjvwstp8MgpsGCU2Ti/p0xB2oOy+wJ3VRUFmDwm7CVc7DGl946dRoorwQ?=
 =?us-ascii?Q?eiqvu2gQDnEDBt5P6qfgZxxYs0B8YFvk6WgW8k1A4P1EjPr0aiR7JgCK59dI?=
 =?us-ascii?Q?rN+nmorPZrMFAjDFGG5+Mk51q0vWGAVzesRCamjNhHbhrJGOwbaM13xs5O/r?=
 =?us-ascii?Q?RL/ZuBXSWTX0i9B32TdhBTnw/pKdCks=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: 09356605-1d84-4dba-f34a-08da4d8fd65e
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2022 22:55:40.0586
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YXXkTux+7XssoPdDk+mB9DpK+ZBnQYCpeRPQ94uVPhdmcq/llSCCUxT1LpI+2haRuVpTdoG9Ar1oXqF7fsTTMBiXLKBa10qRMXmdxqR10og=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB6P190MB0568
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

This commit makes sure the drivers for the 98DX2530 pin controller is
enabled.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---

Notes:
    Changes in v9:
    - None
    Changes in v8:
    - None
    Changes in v7:
    - None
    Changes in v6:
    - None
    Changes in v5:
    - None
    Changes in v4:
    - None
    Changes in v3:
    - Add review from Andrew
    Changes in v2:
    - None

 arch/arm64/Kconfig.platforms | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 4e6d635a1731..8d96928a36ff 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -182,11 +182,13 @@ config ARCH_MVEBU
 	select PINCTRL_ARMADA_37XX
 	select PINCTRL_ARMADA_AP806
 	select PINCTRL_ARMADA_CP110
+	select PINCTRL_AC5
 	help
 	  This enables support for Marvell EBU familly, including:
 	   - Armada 3700 SoC Family
 	   - Armada 7K SoC Family
 	   - Armada 8K SoC Family
+	   - 98DX2530 SoC Family
 
 config ARCH_MXC
 	bool "ARMv8 based NXP i.MX SoC family"
-- 
2.17.1

