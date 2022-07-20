Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD2857B395
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 11:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236908AbiGTJPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 05:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbiGTJPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 05:15:48 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2070.outbound.protection.outlook.com [40.107.20.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D96F248C5;
        Wed, 20 Jul 2022 02:15:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLGB8ULKWjoJjlPlyoj1GvXJ9NA/kyOxmBvS0HHtI0sePDn+V/YbYW9edAsw9YeTxMGUSR2ELDfV/WlgJJaLUYGNcAp4rcPnaw3AyfJ49Cur4xbNLMez3+QVfE+oPsE3ghif/MUclYEj6IOscSQFhKs8BsMPoFOM1b0KViZBwnqBrZUeCwVxyzBkvuaJt6vmRuxold8Oqa2q8FB+5c7fbGxEIr9QQnffL/FxhbyAFg9pHEzbPbXHyIEdYh78ST+2QndIracsKxCVrWeRQJ8+Oc72GLRneRVBxEuB3JIOzo0NbrKSgu+iJucNSEuNTKez5h9nqLvIw3bT8FPap3fcQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8DF1s5WrwmrwwUmlEp6RwKEYGF2Sy/Vka4kl+zTXRc=;
 b=mB+uvh3VvESIoQOKlyDV03r3kf7Ujwj9/YBqPFNj075OQNTeaFvhuTpgXy/6moJiSO+WDZw7LTeXyC6xXLTsMVYN95JjJLyz18aiYqd+Ff5CSrSzQ+klj0H1wylVsrT5yp7ZrbSZa1gx8L1hDJkyEShEpv0ZFBR09CLfXxpgoxjKCgR65GzpggfVuglJV+cFL9yKqrPTKiuOOYOPF2FlXLFETU+qphw65BUCg+H4hO4TdhDPzTS6EUJt17gbnZjNcPdTcfnzRHCXbjyvY661aXZohlmpZsebE2FcN7GBxypGcqMHrEgiL2g8dRKDk6xqdS+J8ZlXyiLU2VsbMUaVFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8DF1s5WrwmrwwUmlEp6RwKEYGF2Sy/Vka4kl+zTXRc=;
 b=2mgkAhLzozI9D47bJlTuuU/yTrcximJpbBbbEIhxSQt3hLS7jWwA6kG538/sjp5yWLbpMgWn8GPUhjAB50XjpHorkUGbSVSUTB9MVOh6wVOVbejZHUBuHXfEN0Gfjp3WHzjfuVKgtXjJxnmAMvy597Gezn2z7qyIl6ccHvRo9ag=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22) by VI1PR08MB3934.eurprd08.prod.outlook.com
 (2603:10a6:803:df::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Wed, 20 Jul
 2022 09:15:43 +0000
Received: from AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::dcaa:905c:ff8:1f5b]) by AM4PR0802MB2131.eurprd08.prod.outlook.com
 ([fe80::dcaa:905c:ff8:1f5b%9]) with mapi id 15.20.5458.018; Wed, 20 Jul 2022
 09:15:43 +0000
From:   Michael Riesch <michael.riesch@wolfvision.net>
To:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Peter Geis <pgwipeout@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Liang Chen <cl@rock-chips.com>
Subject: [PATCH 0/3] Add support for the RK356x variant of the Inno CSI DPHY
Date:   Wed, 20 Jul 2022 11:15:24 +0200
Message-Id: <20220720091527.1270365-1-michael.riesch@wolfvision.net>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ZR0P278CA0129.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:40::8) To AM4PR0802MB2131.eurprd08.prod.outlook.com
 (2603:10a6:200:5c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cda34942-328d-4f94-56f8-08da6a306c41
X-MS-TrafficTypeDiagnostic: VI1PR08MB3934:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yVaM0Uliu9kiVYz/BFIQokil/XCmB/E68rxTXbkvhCKouuI2POQzVYLVQdfziNZtRGXsaj7YuFeKH75a/d2aHS1jhVo/zdji+yWKz9Q4ZVnyT/bHbDCVHKjswpPAgDrq+Ft7cq9syAJJM+ajAt8keIzdKmi+pySp9nhe2tIAGMlv7B0rEKb7JRlDwvrqFxz44KPI9QFFALste+a9ICLUsvW4zzovV3rsikK+AuYTCD0acwEnIxiJwzzDnQIH2fhjqDtoTGYJvxjN24nqoFTAGIGvhU9+j8bus0QivwTcRJyuRof81jfWWwnaJvPKat4K1hfwhfTxTDCmZt3GJLb9imTXJD0vBzTFS5A7H45V4SQtF2Q4PHAeSHKdeyLSBC67KRva0nZseSQ+T722valin3spUd7EeHbqRp7Jw42oU1/vMx577XKeqGFc8ig0HTkdZABS1SIRSGRkHpMZU2jVEjU/LQiGLQXVqEER0din2iYfWWzflUrsE49iVyHYFN8Wc4X1BThUgdOb5jA78rZReVig+gi6p7h9uAVP5RUeeUuz8g6+LRMff0Umn76Vs03Ct5cEyAJJJ/a07FXJa2yIBV7wwFVtUpBu1bqB+wKSIRM52V3Cf/Ddon57mn8UBUJdSSehXD5dSh1++GDoz+ds5qrxzI/a0Zv+PykZY4jNDkG9a/nhNL65HqqUNqpkJRuBX6UDEG1g+JoedjPl24DSknJf6mAU2xnr4p1kRZ6Bgwg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM4PR0802MB2131.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39840400004)(396003)(376002)(366004)(136003)(38100700002)(52116002)(41300700001)(6506007)(6666004)(8936002)(7416002)(5660300002)(6486002)(2616005)(478600001)(1076003)(66476007)(8676002)(66946007)(66556008)(6512007)(54906003)(316002)(4326008)(2906002)(186003)(44832011)(36756003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nMFryQfNESHQbCUJrYU7UrsldKACyNN126q57MORakXkbGO9vNM5ktLG5Tm+?=
 =?us-ascii?Q?cslfY/ujOLlya6d9hQWN5viW7dovgrse/zkKGN8rCh2GvwLmg3oCws+fCTHP?=
 =?us-ascii?Q?VgTFcFEZbkgjH0sNDJzBVtgh2dkDbZjpV36kQgWzeBLSYKsMVFENwJgmQwhJ?=
 =?us-ascii?Q?fQMgw8PlIv19r8kboolgUVkgix2/2Kg/Ero4AdhlUEfgLeiRemzXfxWnoXM/?=
 =?us-ascii?Q?3QW01EOuITpnExxq6yHIXC2vQ4TuF4AJ5bWfY9q3wfZ3VdW97hh7blVynO36?=
 =?us-ascii?Q?yaxoTyGstWpKTxbD26Ys+Jotd1jGKD/JzrHb2RnXk9UHHyWyxejHIpFFtwPw?=
 =?us-ascii?Q?41YUdnKJh625gHJoeM3pw0dLoadqipIFz+vg/mQizr0ot0m/XnD66O8qZjKz?=
 =?us-ascii?Q?Qn+3IFxgT1pLJp/FcxIlIgGcIZFSN/e7oSDGoE3Of1JEA1vg/kjrpCyXNJuW?=
 =?us-ascii?Q?NpU6Qewpzn7DjCW6BJTQEMd89Br2fKUpYHJ8gMLDWGhQCn4c9Wo+P9jyqWWc?=
 =?us-ascii?Q?9/KL7J4wfMDIymfZRa6bIQOq1X6Ro61+bpxgdpUSGXEuWSFYme9BeEy7Cdgf?=
 =?us-ascii?Q?vpWNaEB1dNyBRFm2uAln13Wuj3Hpg2zLMw/dZchh04sbjDSqqP6rzdhNfJ3o?=
 =?us-ascii?Q?azds1LKAvLgE+umU6MJZ6Vzp6GBQPgr0WNf1NJKc8Dj6R9e2UNmGwb6lqN7J?=
 =?us-ascii?Q?cLjG092aRxHWW8ke4S0UCYl/nx/9WThpMf0OjAL6fi2KxjMd2bNWYSCRs2FL?=
 =?us-ascii?Q?gUgDy4NpaJe0UrmVXpX7aGSKsE7hlK5gxxBaLy9NptRIPbKGBmk+4oBNxH4f?=
 =?us-ascii?Q?ST8I63OkKOXPMqwja/cPVv/nf6rx1scs5bhDAdr+itZwKisbN2jFe315A/BU?=
 =?us-ascii?Q?2YRlEnFlNEanSWRMvNCizg/oaTYMMejiu7909qbhYhVV3FK2nkNASAV5pOF+?=
 =?us-ascii?Q?JVXEm54ehlXIa7v7tot9+yxWN47NBGUheIve0kfc4j2a9ZFuWsC/qrddEOnp?=
 =?us-ascii?Q?IqpkJDQlxh5C4KU+aSc7YxoAo3Mk4o1jXg0klqA7m4GF+m2Vmgq6oIRmfF06?=
 =?us-ascii?Q?aK3YTmt5geAh+7k8B2KkPhv9FoNmWkBZCPtqCk1AxSfy4iroNdk6VD+5imKX?=
 =?us-ascii?Q?NwazZNtiap5Wkj1artmzVP6l/qtJKIX6AfREkanuflQxfyoDCWzvQHBYAicc?=
 =?us-ascii?Q?IFZKDj9kpFJeneBS5ZZGItjTl/7U4GrEkoIqTcXmpW6x3a40JmdOUMyFxgMR?=
 =?us-ascii?Q?M4u5ZwPHeemGtRs4DqudXZrCNIFXuNWNnY82p6oFn94cQujVFXgV4acLzk8J?=
 =?us-ascii?Q?0Aj9JwAxwiROOkEmHCGWv7Ld1CoKa9jmaWlHv6tez7z9usXLMYe7L02879U3?=
 =?us-ascii?Q?7H4vvsCfzOyxkdkPwf20oA7xuHt08lSoT+8/LRbM2r8cJi+o2IQp3tn4g3yq?=
 =?us-ascii?Q?qKUA4MNy6ITvESTomG1ly5qOqvth1N1dZobIBlZ7cIcwFFT9b2O0h3ZhDj+g?=
 =?us-ascii?Q?0QF41jMVqNWMBdLNMSY6ytfWxL3Nppj6SCq5oQTDKkMB8YcasYzEfxfUo1Ws?=
 =?us-ascii?Q?vk/ddFybZPp1jLD31c/O77X27R1hOGhqfZKk5SbJKZqgB7tIjxPMS5rifQC/?=
 =?us-ascii?Q?iGzZsPxkDcWUHSVvpHDEw3wc4N4StGf8kdpXCTjYPgQgTwerBM5N8tEFKiop?=
 =?us-ascii?Q?nzcEPA=3D=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: cda34942-328d-4f94-56f8-08da6a306c41
X-MS-Exchange-CrossTenant-AuthSource: AM4PR0802MB2131.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2022 09:15:43.5417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9oWSi7BjVjsWzd4Q0aC8BpWYL30cESSawuc4PSZHiGWSoliZbJokXZVR/jpEEKm/dXf00DOI6Uczk8oDKv9xE8lg8WPaOIbHLVMm304LWtc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB3934
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

This series adds support for the variant of the Innosilicon MIPI CSI DPHY that
can be found in Rockchip RK356x SoCs.

Please note that only the basic operating mode is supported, in which all four
CSI lanes are controlled by the Rockchip ISP. Split lane operation (e.g., two
lanes to ISP and two lanes to VICAP) is not supported.

This has been tested on a Radxa ROCK3 Model A board together with an IMX219
camera sensor and a patched version of the rkisp1 driver (with support for the
RK356x variant V2.1 added in a very crude way).

Looking forward to your comments!

Best regards,
Michael

Michael Riesch (3):
  dt-bindings: phy: add compatible for rk356x to rockchip-inno-csi-dphy
  phy: rockchip: add support for the rk356x variant to
    rockchip-inno-csidphy
  arm64: dts: rockchip: add csi dphy node to rk356x

 .../bindings/phy/rockchip-inno-csi-dphy.yaml  |  1 +
 arch/arm64/boot/dts/rockchip/rk356x.dtsi      | 12 ++++++++++
 .../phy/rockchip/phy-rockchip-inno-csidphy.c  | 24 +++++++++++++++++++
 3 files changed, 37 insertions(+)

-- 
2.30.2

