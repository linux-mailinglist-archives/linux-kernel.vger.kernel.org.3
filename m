Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49D794C25DD
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 09:23:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiBXIVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 03:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiBXIVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 03:21:41 -0500
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2055.outbound.protection.outlook.com [40.107.21.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C7A269AB8;
        Thu, 24 Feb 2022 00:21:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UgJBBzG1oYdePe7Kg/N4wsRjDo9PQW9Edh4+0sLbTKMzCk+MqlEru/kJVSXc2nZQEzpFD+T1eUJ2+UmxdODbVPQ7O+WD39M3dsRC5+bpokX+yaXaWINBqdg2mUFXO6TeQWWB1/fv/Ew1VYcEFCJC8nxdOjJ7iuXDGKY4VULMvzahvS5U7NwfNJDajCl6xl9BEtph0hZfeUiNyn2F8mjVVeESgBWkRxRf8zm/trCHht6OBhkxLMhCmjC7gMn8xQCo538otWXjGbY7ycN777XzrlaCF8zjDXb+lgfS8VomkCibL2DRzodqMvUYqi0Mg/UEjain5gWR6Lvw/9/FvGSBbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AR5nVJlXEwq1cE7N3W6P5bcrlaImfpe70JlnyuJXBiM=;
 b=KiBHKuE2tfjd9uQeT2hV+BdfGtdMw1YKh4RcKHocff7OCYrqI+0w6rj+/SgHdDWNz4fE2v5shYdrKsRViE3GH5pLpzYO1YPyAKeAhUWQTDpwkUTI7WYornPd+cz3h9N/4W4rZr0ucrLVUC4rZvZQJddBtsNyiLlsvDnpB7fHmk2jhXPWKOzxcsL+CxIumR1E3Xm8WVTGXJZNgeQaFOeGwkB/6V3EATX/7t54RbyPsVL3kzz//p+mjbA19To3U83gJl+3KnH440qsebftkkH54YxWPYoULVKkEsrT+HNsLFgbdvz189j8lQOzqi6aXyzNVVjTUUxnCvB3jZJ36NyH4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AR5nVJlXEwq1cE7N3W6P5bcrlaImfpe70JlnyuJXBiM=;
 b=ZmjoqurmvEKfw06UnDlzAmwTMPF/R0meyfP/4grV3VA9Mn09pyHqMeAxbxtLfz9QhewLibMUA5GN+JkH1UZ+VKPTPTgmwnX13xH2I4C6iTc3B6ed2fSSaOhYG3BmLUDH3zzH9kXBbNGFH2Zlc1SHw80Rjbguu840nON3wPbbCnI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM6PR04MB6423.eurprd04.prod.outlook.com (2603:10a6:20b:f4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.24; Thu, 24 Feb
 2022 08:21:08 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::552c:ed46:26dc:77cc%4]) with mapi id 15.20.4995.018; Thu, 24 Feb 2022
 08:21:08 +0000
From:   "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To:     sboyd@kernel.org, robh+dt@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, abel.vesa@nxp.com
Cc:     kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V4 0/5] mx: add i.MX93 clk bindings and driver
Date:   Thu, 24 Feb 2022 16:22:46 +0800
Message-Id: <20220224082251.1397754-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0147.apcprd06.prod.outlook.com
 (2603:1096:1:1f::25) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4ee7cbb3-b370-46b3-c932-08d9f76e9b54
X-MS-TrafficTypeDiagnostic: AM6PR04MB6423:EE_
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-Microsoft-Antispam-PRVS: <AM6PR04MB6423F27518F3E2D060B2932BC93D9@AM6PR04MB6423.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yaDk+wMGZxMxm/BvFs50uZdpM6iZ4t9IM21tsJqamqF/ud/fTXi9AUrsRiDiwLW9kbayTxs5YBAqXCGOPQ+912QOhO4d5Vx8gFgbMMhC3GBx+e2MIp2/evcyeupcVNLoGSJqUqLW5pSfU5AtO7LvNrQhDFqPZVzAvQOVS/UJsTmHxrIaWmzsTSQlM4ckLlawRSfObe3/hs/nMrk/fCt1CU9J/llkIX7tvvuS1MDmkmjFKyroETHGoLU8aleiB9jSV+K5lXjO4fCe7FXCVzBK0W7Zgr0cVcs9QRERtcqx6qgqOlJ79N/jY4Jlvx4y0Ej/yeUqJ3fv7njzMD160t8G8lPrXUb37gKxsXk3yN0JLM54gB4MMxgDJLMtwG8IASYTfZ1ahfsA5tKUoRAmeBhnLB1lM+5gZZAtUNGFO9Rn0IINpcLxzDl1rE2+g+amSN9O7v+jHgGprilEiqEEOKXLC38h9FtmUIFw7mE9Hl1gKxcEFyECnhoDYQlW66LFrv4GdVEt5DuATnE6VPaZnDcaqe6Rv4vMRpOmg+tySHuCdpY9CfWn6cKfGVmbiqbTsVU7KIi2XlxN+5vDFzZAhLO55hlgSR+60mt+GumDqDviFhtb7f8KgW/XZrMqMRS5a0kVD70RPCVsMOEx+vnXTIZBIulZCf3AXNu9xg1UEh90i2x9NLLSpOQMIgt/Oj+TFjfQ0S3CTZ4tCNdTTYQfVlQP6w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(316002)(1076003)(6486002)(186003)(5660300002)(508600001)(6666004)(4326008)(26005)(6512007)(8676002)(7416002)(6506007)(52116002)(8936002)(66476007)(38350700002)(38100700002)(2616005)(86362001)(2906002)(66556008)(66946007)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gS3OtQZ3wAb65qdEyM7omC/J6OVh/3iOxt3kxJaSVeQiRmfvFsLyMFFWLNxH?=
 =?us-ascii?Q?b50QT4rls2ncwQQ2S4UUDzRem+fBM9JdGV9gQ+fU0JaaV3FFHh8BludtsnxC?=
 =?us-ascii?Q?egalRQh7HjaMrkw7x6vPfnkHM7kvQjY3JnBjrDzWvbSWoEUl8zH7KAIFHY6b?=
 =?us-ascii?Q?zpvV2OvrG73FwRTfb85sMMLQGbljGSYP88mLt7jmStYtfpXDWZQOs6AdmOcY?=
 =?us-ascii?Q?hHB9+3YMiCakO7SF6yIl3O54YinuSrIn0WC7Qyj88Psr/vFz/6JjZZI7mcDZ?=
 =?us-ascii?Q?/fAvkJxx88v1/RRZ0r4783f6rO0NcmeJz4clGTKVEbHQO9/wc25acyTbYgi3?=
 =?us-ascii?Q?0DqbR2t6SXVMYs8r7ZHf70zDKmSqRFqVf4zdB68KfqKeKEmSCq2tYRGrAJiC?=
 =?us-ascii?Q?J511VWEhFJBZGaiCW94cKD53XUBoYsdgaJz39XWyrgWvWsGcPCiZFd0fUm3J?=
 =?us-ascii?Q?q164jZan3bEcYz7tvulq54jxFzmzUnn2BEOT4B7332sJnW4XNwfgiEKKgV+K?=
 =?us-ascii?Q?w/xqihR9SDZASoaAbRyOIYo638NniZdvHaQqbzOTDvxdrOJVg0kbDyU+p4pR?=
 =?us-ascii?Q?8P87sPt2iiMnUr5++P0gyRpFMJIHLDp7Vk3MdziMD/YuK3e5QBvpREkXudo7?=
 =?us-ascii?Q?lUIniGU5mkFb8cd3ZbClBdnEqzIHTThbU7BwMhy18+aUTFDXqHJlq0TwXQfV?=
 =?us-ascii?Q?1e/uOSwrH2GqVT89aXBdctQa5UDJNAwxxC4wABCPZG6HR3r7RGRIM+95qITr?=
 =?us-ascii?Q?UQVuE7WYF2550x+T3j5c6rGsumRRQ1jh3/56bK68e5bQUPa508JYa2PbdFkZ?=
 =?us-ascii?Q?m0i2belnSpPS3QsDi5Xx2zpMVOolCMNIcfRuPbRequHyo0M4pH3N+Hv6/t16?=
 =?us-ascii?Q?hkGpm151Vtqeon08v6e46e9flLz9AW04Z1QajExvL3+G2JIAo7gwrT/ItpfK?=
 =?us-ascii?Q?42/eJmfI8nESmA+61+sOnJaXY1bdEPTlsZBbJ8wfkA7oyA6tM0ITKVDRprf3?=
 =?us-ascii?Q?an0QceX8AKI1sebUlqURF6X0+nPdflVEt3PWGQm9QtKupKC5yzYH8h1lRCJi?=
 =?us-ascii?Q?QeR1FZo3noPfPnfPB6E7WiqOLndO2GnybHeh9rVQtMmJYR/QRS8jIdQIEdQG?=
 =?us-ascii?Q?mV9YCiH4CkujaBGbP8yGYjJ0pbsB5uSlaIVA/AN1Xs2ycuHVvYiAfMQVvi2i?=
 =?us-ascii?Q?UdwhjDtfGcKX9SqG5WI7wAEKWTCJNbwwdQfYoZDR9MQ4Ui8t4ei/Anky1VUI?=
 =?us-ascii?Q?ijo7VnXT4EveR2GOC/jvCarFoVFQwzbnll1/yAVyhCzoVh7o5n8kiltcrmQh?=
 =?us-ascii?Q?V6VU+A8tT5udqEcdmWlT7GC4Sm2fz53qps1SrUEXzfMHOyE3mFa11etoj9CG?=
 =?us-ascii?Q?JYViKH107tjt+tIvxanc201enIhSlTJ8cR8eYTqOWc0/nWeXgk/cwtKDX3f+?=
 =?us-ascii?Q?Vz6AFiXJpfwxUsYfAleLfS7hvwLrPwS+q6e3xdXE+4AtlytlWAmFSkpP3TrN?=
 =?us-ascii?Q?CsfArbhdxqcKpAWIWjtaWeKVhcPVrns8x1RtHNrBJrfNBW+gAE6RVy5AHDGH?=
 =?us-ascii?Q?20d0zsp9nL+lBSlxazU4GQSr7eqdOmD9XrRBAOI94mvEaADvMkGzHXtlx1is?=
 =?us-ascii?Q?jUjEovH0YM/jEyA57IgEn8I=3D?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ee7cbb3-b370-46b3-c932-08d9f76e9b54
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2022 08:21:08.0675
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3VfcQ21GRRL1nhd2frO7JC7pX38DVwBpikWjroigiStzSdRaW6CHab9EDY1UJ46BeddB21LW0PCA+d98yl6cPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB6423
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peng Fan <peng.fan@nxp.com>

V4:
 Add Abel's R-b and Krzysztof's A-b
 Address Krzysztof's comments
 Address Sascha's comments in patch 4/5
 Typo fix

V3:
 Drop an error included header file in 5/5

V2:
 Split yaml binding and clock header
 apply to Abel's tree

Add i.MX93 clk bindings and clk.


Peng Fan (5):
  dt-bindings: clock: Add imx93 clock support
  dt-bindings: clock: add i.MX93 clock definition
  clk: imx: add i.MX93 composite clk
  clk: imx: support fracn gppll
  clk: imx: add i.MX93 clk

 .../bindings/clock/imx93-clock.yaml           |  62 ++++
 drivers/clk/imx/Kconfig                       |   6 +
 drivers/clk/imx/Makefile                      |   4 +
 drivers/clk/imx/clk-composite-93.c            |  93 +++++
 drivers/clk/imx/clk-fracn-gppll.c             | 326 +++++++++++++++++
 drivers/clk/imx/clk-imx93.c                   | 338 ++++++++++++++++++
 drivers/clk/imx/clk.h                         |  30 ++
 include/dt-bindings/clock/imx93-clock.h       | 201 +++++++++++
 8 files changed, 1060 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imx93-clock.yaml
 create mode 100644 drivers/clk/imx/clk-composite-93.c
 create mode 100644 drivers/clk/imx/clk-fracn-gppll.c
 create mode 100644 drivers/clk/imx/clk-imx93.c
 create mode 100644 include/dt-bindings/clock/imx93-clock.h

-- 
2.25.1

