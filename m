Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A01C567783
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 21:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233519AbiGETLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 15:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233419AbiGETLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 15:11:17 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2137.outbound.protection.outlook.com [40.107.20.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3477F21837;
        Tue,  5 Jul 2022 12:11:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gmCrWbQhAytw8fnpH4/+r9gW+/yc0BUf6ZG5oYd2o2Ojs13IPcVcfCPkvvch7JOOB44jkvcaM12WyQVG/3U55mZncYu0feOSL20NzTeRtDGNxGHru8bp7oAYgntqOqyi91P1vVqqglHaaL2nnqDWN9+dR+887vUxvJx73LV4e0o4tqcvBmLb4yqqiSQWG0dEyX0tFlCOP4CKtvCC137RmMw4+Ir/X4YSPC9DbwlIIVt7x2zcCZ37ZWzfgZAeDOSnR4KqJ+wLkmb9J+nmzukQNmwoDZUYE4wGv1JgCaZZ2eSiulY05BkEk7NahTZqkQN7MzAbERsAp+O/R8g+J4/uMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hdxcWzV2LD8xinyS6D1Jg1HW0saruc5Q2YSziomMdfI=;
 b=PF/oH7DYJTOlwHVLWzAweF6O58WG3vZIKMIB6lFXVv/X4ePzOnOl0xwaRu1dgfNogGVGjMiC+cAAIySiM42tYDS2zRLXLYPDxkY3NgRfw/RBSG1bE/qkhM1hSO+zkGnzGnmr9Qybon2ot0bRD6vHFERcrj+Uz7j5Eo2+u7SlUkW0zKOFER1/TZOQKBdRkswWn6MOmk5UYEK0cC5SqiIigbPd2UsicmKY33Czjc4/NDjoik+7zlQMhaYvJ2qbGhUoMytq8VvujahJ12Rsg34BiMY8GWcmUWC+RKLHDkUHT5Wo9VYlBswn7oX8JFfgd4L5NjncLBcCOGWJRCnTnchsrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=plvision.eu; dmarc=pass action=none header.from=plvision.eu;
 dkim=pass header.d=plvision.eu; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=plvision.eu;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hdxcWzV2LD8xinyS6D1Jg1HW0saruc5Q2YSziomMdfI=;
 b=kGcpFneQbUd7ZmrRbL1LEfEq1zg6SmJ+C76Fdn514q8X4tXM4nvOA9H2wIESf6f5oDHeftfyhvR3vUKBLfoP838CgC3TxN65lCEysofzvH2K3k/oXkgz0WRSMK9sZDrmUl6VdbwQNoXR4Zue1C9tEECAQlBlos+8PIr52DDlInc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=plvision.eu;
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM (2603:10a6:802:38::26)
 by AM9P190MB1426.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:3e4::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Tue, 5 Jul
 2022 19:11:13 +0000
Received: from VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2c45:bc33:2584:959a]) by VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 ([fe80::2c45:bc33:2584:959a%7]) with mapi id 15.20.5395.021; Tue, 5 Jul 2022
 19:11:13 +0000
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
Subject: [PATCH v10 3/3] arm64: marvell: enable the 98DX2530 pinctrl driver
Date:   Tue,  5 Jul 2022 22:09:21 +0300
Message-Id: <20220705190934.6168-4-vadym.kochan@plvision.eu>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220705190934.6168-1-vadym.kochan@plvision.eu>
References: <20220705190934.6168-1-vadym.kochan@plvision.eu>
Content-Type: text/plain
X-ClientProxiedBy: GV3P280CA0047.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::15) To VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:802:38::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b3aad52b-63f1-42d4-b427-08da5eba20af
X-MS-TrafficTypeDiagnostic: AM9P190MB1426:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BYACqq8dm8V+xFWJaSYoIZmgwTxwodIUzBuyYEAs52aCLvDG77c9qNVw8Yk+se4yQhi4enF+6BBR4FJoOOU1TRypQFbyF+rxaGTJPVkYKtg7XYJgAr0taxs1XeCf6OrKJB85IeYjauD0DF8jP+VZe7qbfxPfN8wiYKWeRoFOC3AId7H81WhWvePhR3ONjRNVN+D3E53vejzO4PXQYoPxmSVMXxp/TJ2b7k5g8mPEiKA8mmSZ+dSaTiZiZNT6aQRp1RhnZVW6p5OwwXRW+O+pzTr6f62zZGScmOSiLJ0uA6aAGQaDNkN5BOALXV6cIRvLiXvHwCnJDLDpFhrgn2TzJyQaDTFn78zPmAG6A7twzuBs0ElDnUHSnYhzoDrqbluJ2Pkug760uGxf/AXjibOGRvml5qMRBgoZtW3Ure+pJ/e2ZJBOKlPxSgHCeyjmMVLJaOHAJdHGrA8EghV5h1hedIv9vRhjtOps2kfxOLCraKJbqCI5CZ+6FX48unXeegrUeQwK2iD8LNvquGObYpoRDd8uNB4l8Y4Iz285GUHTfwK0NDDAprG3U19/Wgfsv2M0ZK8dNRcTf6pwrtlYhYccE2fvLJnScr00u/vgG2zomFxSVS0k/RybQ7MrfU7pipYlXzbYURMhlesUvzIvrDa/ffvLyONAhpAdmNB+k9H015EgcWQQJ0NF9DHXIX9BwZ9WWlwU5HgIA/C7efgyDJwr8mQcliYrFS/PQ7ZpCt0qZUjf3CWqm9gKee5r0rwIiiEwkuQdxaflGnpVIH7fFutK34TDZj0IlZ5PpNRk9o2rPg7EkoqvBZ1gxb++X6zVvkRUUUAbAnz3Fj6PvkEWRhezFg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P190MB0317.EURP190.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39840400004)(376002)(346002)(136003)(366004)(396003)(110136005)(6512007)(316002)(26005)(41300700001)(6666004)(6506007)(52116002)(478600001)(6486002)(66556008)(66476007)(66946007)(2906002)(44832011)(4326008)(8676002)(5660300002)(38100700002)(38350700002)(86362001)(36756003)(921005)(186003)(1076003)(2616005)(8936002)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8d4sxZgIG/S4PhhX3GnclhkAMlF1pJDpVfM3Eu/BF4SMYL4VkbZ3sULT00HM?=
 =?us-ascii?Q?dl8n/hhLGyQVeYtDM7g50w711eprcjePrKQYgPcPIl1OZ2dn+Si0Ah7aDZvR?=
 =?us-ascii?Q?VgND22BFeOh4EE3rZKK7Z7f1g66Eh/A00KECVU7yLJvCE4ZKOroSZ+vgvygy?=
 =?us-ascii?Q?MgjrP1OtWgpZnCpRDuGfbpXGAE51052LOP804xn2Xtbo2f/YQb3GpzqR2Sra?=
 =?us-ascii?Q?vlVzWves1E1jMjNmlGXpwjwMbuoJJmky075yWKCJNQi44BRy81DPFOgvVerr?=
 =?us-ascii?Q?JGI49BrJmc6/ESw5cFMxXUNB2iGrWmq58eMUjlQOeIO36enAS9aHHkjk7fBX?=
 =?us-ascii?Q?fayMm8+WYv3CMDqVzxVKDN7ns9JpIhtWTQertO63Fvc4o9oKg2tLSR+HEvko?=
 =?us-ascii?Q?FY7QnXNJd6ymE5/KzzYlLw8Po8I9579euuqZfpatA+1ppYO0H9r/sMs87DTd?=
 =?us-ascii?Q?CYWUfUyxn4zxMAXwRNXKhDYfESECiIZkESEvM/LMsTkuiSXocmt8FO3dxJ31?=
 =?us-ascii?Q?EW/SmG33msGMlJmYrpkFbN675x4+XLZcXbybZBQTg7v8QbJvVNUrrfaaARbu?=
 =?us-ascii?Q?FVK3ObwciCEoKbM59zMEb9Hj0tC4uDHHwBpMOUxzVp+kWAxhacKwJLljr1pH?=
 =?us-ascii?Q?OCQFGb2Ig12trVKeOvjUkgE5ASWvZcHb3mlg+QC9Jk7tlTbaceGQS8ObtL0s?=
 =?us-ascii?Q?VLPPlgkWW01zq7u6f2rAMWhVk/GMj6FRZQvmx82/J3hX2DikIEakgkdr3JZn?=
 =?us-ascii?Q?2eb8q43e9Mjl/iT/78jUSWkygRj1So+PXuHST7nQ4mn/JSEU5ek+lc91rJwr?=
 =?us-ascii?Q?6W54H4/f09h4vVxTcf2NMLSwa7EDDxrc32N6xy+rneNxlIYrWJs/A7kHSRRf?=
 =?us-ascii?Q?rgNPp4IwgJQ1uAdhHu6AeYfWgDpvEhfUgsxXk58le9AQJ5HD6d0QgqITponW?=
 =?us-ascii?Q?XT18GhjNIqYsZ0dcqADblBpZuJgxVAK55O6aRXdDO/2yK+Kz95ffmuFk0glf?=
 =?us-ascii?Q?kWbgzhTsoPEeADz9iEX4SVdQu3YpNf+SlvIYebdvuniuU6/yyheROb5FLdKX?=
 =?us-ascii?Q?J97lRJ7SP5aBI0SLsFRa6Ve7JNoSsy0vK96H42kzv2cdH3VrGVnvspfARVWm?=
 =?us-ascii?Q?tEWwcPhFLHwrRBB95MtcOaWzbD8uC/OZem1aEyp8Rk2EVjyahYhwpUJ4vUc/?=
 =?us-ascii?Q?3xShVgiELW3eQcJui/Pnwf7USA+EnTnOBB72kc2tMMnBNoqEzjhOQHACcWI5?=
 =?us-ascii?Q?OpW6KLZrs9zDMS+De/EgHmM2Nw4x+rLOCP+rx7YtOAQYgeyKWzuxv/AVKSKy?=
 =?us-ascii?Q?xRNYH+WWUrinGhR0TjhUIwC0SnieKr2+jobKQmg/V240eca9MPk8/+wX4OwV?=
 =?us-ascii?Q?7sE6/eZAg+xJbcugg8VopuM09btv1tu1FcgTpGNtcILe9idiYGhXGt/psMlf?=
 =?us-ascii?Q?0mXCVszLVLG0/W9cCSe0rdiGKHUNoQMzvYV2f0+QZqLyM8ZTTGVBqE0Uwdmd?=
 =?us-ascii?Q?hgXd4rL0qjzddgcErT+NWJCVFV+kH6TRuCq8bytcEh39TwRCZpqMkgyIIGDC?=
 =?us-ascii?Q?uAJdC+RDoSZDJLrMygcRFlE8GaGkcxE6XBArD/K7bI2+F1DQ3ZYg0X329O7G?=
 =?us-ascii?Q?dA=3D=3D?=
X-OriginatorOrg: plvision.eu
X-MS-Exchange-CrossTenant-Network-Message-Id: b3aad52b-63f1-42d4-b427-08da5eba20af
X-MS-Exchange-CrossTenant-AuthSource: VI1P190MB0317.EURP190.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2022 19:11:13.3222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 03707b74-30f3-46b6-a0e0-ff0a7438c9c4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4PprVWOha2tjh0J9z2PTJOiyUZtjCPkhrf94kW5HTHKk4SAkkqUzm9sNObEvGfTsKprNax6sNA/G58+CXnip1nY0sWBJB59bHabCrzmBDN8=
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

This commit makes sure the drivers for the 98DX2530 pin controller is
enabled.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Vadym Kochan <vadym.kochan@plvision.eu>
---

Notes:
    Changes in v10:
    - None
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

