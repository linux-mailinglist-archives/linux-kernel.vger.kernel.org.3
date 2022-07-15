Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC905759BF
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 05:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241240AbiGODB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 23:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241190AbiGODBX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 23:01:23 -0400
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-eopbgr80084.outbound.protection.outlook.com [40.107.8.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE3B48C8D;
        Thu, 14 Jul 2022 20:01:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cV0XiJe2WDZsP3mfktQ6FkW9e2MyIQemfEtr7PNFCd8mLRBFhVNDQbg4ljd2p2FVP9SYBbmSFJAgLXhuXzyiNZX3RR4zzYtZojPLSZB/x9KT72H7xaibOjDzTt9Cx+T0x8hSwWYhKdP5yrhgftLX/JIZtzYIwq6jlTqGEqu3x/eHp5ph5bCT2kquecOjlVOsqr2CdCi4lvZnnc6cyXVn0hUXtrE5a+nWCJ+wpM02lptxf7JQIl0PjHB8MQwXiZAW+b1CU1HCgo0XU8KLXu6Tn1GJwN87cRzL9H0Cm0RxRmllYIwK2hhY4e/4zr9Vmw+l3UAWEUSrwRmw8DWcYd5J3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DEkzpSnvvSrT0u6PI1/8TnPGzwge9riiOLKhwoODTkI=;
 b=iVoPo5XTaEGZoQ7y9q0F8Y2Ux21k5xjVEn75Fzxxk8vq/VnrhQiITlVahvlWjm74zIeIUq1FTJtmMaFCVfNav8VD+IH6+SmkGXhoJn/GpE9Fsp4djDl5TrBn0pzMj4r2ujEHrn2N9IwVOovz7M/BTyUN2NjQz4WIEoQE+MIAKKmVzB95+GQEQc5dSkjsN/1QL2pVnZ9KG+KdtiNLG7HmO9UeKEJx2Au+V283m+Bo991jhUltKThF1yv18iCFgNRJkXGz2A9UKblFQ5vSe364ASenW/66RM1y10GlPT/zPL70jU6z9EvVy+UdhjXzyAaG6azi+nlhoNAmdClBkFg7dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DEkzpSnvvSrT0u6PI1/8TnPGzwge9riiOLKhwoODTkI=;
 b=EEv7T5mwiFDkFu9qsAMYjAkf6bn7NgBXT09qQgNOc4digXFhivNPQRTdr94ky+MOJJGqO5bNVboKp8y4pfTcdPgW2o76TgdZEUZn4NdYQeZFhwu0JGHj+W8G0OMgcQp/e+Q2L68Mypr12vz8fGpfadRakXIBsxt+N4mrDjqWYrQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by VE1PR04MB6477.eurprd04.prod.outlook.com (2603:10a6:803:11e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 15 Jul
 2022 03:01:19 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3cec:d61:3836:2826]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::3cec:d61:3836:2826%5]) with mapi id 15.20.5438.017; Fri, 15 Jul 2022
 03:01:19 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org, michael@walle.cc
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH 1/2] tty: serial: fsl_lpuart: correct the count of break characters
Date:   Fri, 15 Jul 2022 10:59:43 +0800
Message-Id: <20220715025944.11076-2-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220715025944.11076-1-sherry.sun@nxp.com>
References: <20220715025944.11076-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0163.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::19) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b9588dc2-19e2-4311-b24d-08da660e4a7b
X-MS-TrafficTypeDiagnostic: VE1PR04MB6477:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fxx37VtK+pabZiBSZl3kly0bl7iagNrj0Epg1tpgfKCvAQ0YYO+TTPggg9SoxADJ6Us+7RkTcnEf23F3pwD3m+dO2XwAOOYU+7bKfFbWhFZ+KGlzGssUkuOljk3sCwve3suxSLIocvvqC9d9F/5GjaIVld0MwgLSW4sY7cttYhTu3xVaiH5wJZ3sdHouMkP/jr1pieyNdOMKNOGLow9YuC6Mm0jPQQDWl+6FRrfTvxcQxjuviz8OJkfMoH3tiQwKLa0ooxDXbsVF3iI5F2E58RY+BaBkroIwcXUf+OJoAeM4qmfLaCYQZnNORYPLICVXJ1OM3/xl68bo+ENG5V9cd1ePUhquVY0l9Lgo2RnPvx/xM7inbfy19QGIfqsneU9TQGgjtjWnKoxuz5xVUoRX1vgKGhnTNKilS6FRy+uuz4hrjlSFfcNZMtSxdz7Uy76t8Bfu+73MeSIVJtgo0Kjk8QBbv+Ssx7/WDf33QsjzJnwsrsU519hm39mO1vU0gbGqkOQ1CHDYKFuyK6mnAaEgc5EwkVwwOB777KtJpA7Q38zIuoG/vqahRdhmvPCNE4XxBLuZK8M/ZE0gggNEAu2Ezj/E9mdfVFmoOy7FbOem9mpEpREZ3NI4qNzxYcZYoe19l7+fPK9FXQWFdjdqc3ckJpch+KHFw4LZgeyG4qvQvLJLG7VmOkfsTbbKTBUIANX5cYrFvUjTbHTJJJHVx7FwaaY7oeE0FLYI6lU6ooazZKtcBbex/XZfs/j5/MW/QzUL0z8L4Gz2quSlE1ECgH2yonUlRJ5XQffJrDhJq0DofWocvKmz4SoDhCxLMEm4bxlA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(8676002)(66946007)(66556008)(4326008)(26005)(5660300002)(38100700002)(83380400001)(1076003)(38350700002)(2906002)(2616005)(41300700001)(66476007)(6666004)(186003)(316002)(36756003)(52116002)(44832011)(6512007)(478600001)(8936002)(6486002)(86362001)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cXQSnROJlA/59WM95nOpbh6fKBa1pVk/s2C9/Is4BjZbXy0s4RGJ9CtMspDj?=
 =?us-ascii?Q?2qjG+mvnmoJoYNIH1B8WmLzwus33DzXwPz++bIFiC0tSvp8EiFq8OVvdLuFx?=
 =?us-ascii?Q?+OCSmwrY21biNu9pb6vabU4BkOpwde+YOsKN4YYpb0M17MjIc30tPJhP9Q/C?=
 =?us-ascii?Q?orpen434hWa7Ove3j7rynuvjdRbsWW7cTiGE4y1A5cms4qpC6ujGfrcvhat5?=
 =?us-ascii?Q?trXKmbizO0iHx/NlApR6BIICcQMHS5LXZkldN43kklfoIdZbgP4+7VPHTODy?=
 =?us-ascii?Q?zRNHW0NZeAOgMClyiZJGoj8b6CMcv5mTq+7tn7o2Wolb4w9wt965+ohYNr4L?=
 =?us-ascii?Q?P3t7H21bBg1PTNdHRdtA99yE0vdoz4Sa3eUBvUboHXD5wOitw0Mr9MHZ/4mN?=
 =?us-ascii?Q?h8WGA+XYJf27z9DFdT/Ue9J8T2mWkTjSrysn+C93GREsdrDEkwG9+pZFRG3A?=
 =?us-ascii?Q?OJAtkUbZ5nGxfHgorg06hmbNB6PTAZ84cYddFS7caRQdqHHV7sMUTU3dyrgK?=
 =?us-ascii?Q?ZzZT1va4k5tE6F/D9gDaQrO+RWmC4jT+JS+a9+MOOrFFc5edm6rRs6JGQReZ?=
 =?us-ascii?Q?CDiSyC8+NOAilEm1MJCZafArWbEVBShruSRdvUEqXHJK7+sqC27ap3ngwJM+?=
 =?us-ascii?Q?7Lj/j2aTGipURJf7fq+HOr44bXKgH3tQ21pmlJXqPjkOO/HXt8B3+3FGszQg?=
 =?us-ascii?Q?+Z9Bja6/RygRRXEPFtNEs2Pd4mYMI7yBh83w5TYywphJE75SHEAelQBitfwe?=
 =?us-ascii?Q?YNpek3S8uRtXwre9dqYyiYcc6rJj1GoLC40//tumgx/k42tWmh6Wv9i0G1h+?=
 =?us-ascii?Q?3b/q94KVu6T0SMrHt5UgkWyCXoTv4K8ItJ9XwfxUN8f53nSn+yrrXw5e5Ca7?=
 =?us-ascii?Q?RxLioYIFaeOeM/Poj2BroJvWjmSwrbxNEQR4c6a1w9y7+3we0k7uTmAYUfi+?=
 =?us-ascii?Q?WZ3RA6WBZTmUeCJ5oS5pzouqIK3cEPmZ7poGfqblZzGKqy61FBmJf5xuaWll?=
 =?us-ascii?Q?+gGEVa5vjiICorfFoF48VUct3CRHWBH67n+ZjA/sbCV9oGOwMR77vFt4Dnnt?=
 =?us-ascii?Q?B8Te0cr6Wz/zWtRcSn3RS+or7tY3+zVcXzHh0x8nKdlJj0AuPXL3cUK34h4g?=
 =?us-ascii?Q?VPeYOU9EgvNLinFfVnZWjagdv1AldnZmYcs2OFukYOFGVWYnqR/83g3Ub8VN?=
 =?us-ascii?Q?zQXVix7SfKM+CKbRi+C2GX0GtcX8+wytojbDTIiufw3LB9pZGbOd0Y4OG619?=
 =?us-ascii?Q?ctPAXzhyj0JvbcDS7cwRFrWCcpnrkD37pP5pvHBGG6BfiaA3vaU41/hnnbNB?=
 =?us-ascii?Q?lTGPhuuL9cfJkg82auvycT09BylMWwe4yz92lhN4/ZhCGVHFUJ87YlJdLvDr?=
 =?us-ascii?Q?WW8DrrJdsX6JHGsyiw8WzoBZMjdseTAPEgkgMShBd5oXyyIKbIijP34/sdd/?=
 =?us-ascii?Q?w9Mneud0ZOcmsu9+s0p2xHFm5+pVokebQZwf8IuRffeldLcMd+DmF+sEFrHR?=
 =?us-ascii?Q?M7mvbLGC6nuVx0V/1m1JS5FA++isqC5rXQqOw0W4WFNp6HwCS1N43MPzh2Yn?=
 =?us-ascii?Q?AWGVdex1wFcqMuASeigF6gJoahfThprirSMQ0tl9?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9588dc2-19e2-4311-b24d-08da660e4a7b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 03:01:19.3104
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JcpQ904NRd3RAKqVKRSolkg+j/deWB5lpG9WcGx/y93K05bQRFr+UhHR9LjnLmF3uDIdy+FivZW/Gh8a032B7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR04MB6477
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The LPUART can't distinguish between a break signal and a framing error,
so need to count the break characters if there is a framing error and
received data is zero instead of the parity error.

Fixes: 5541a9bacfe5 ("serial: fsl_lpuart: handle break and make sysrq work")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index fc7d235a1e27..b6365566a460 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -990,12 +990,12 @@ static void lpuart32_rxint(struct lpuart_port *sport)
 
 		if (sr & (UARTSTAT_PE | UARTSTAT_OR | UARTSTAT_FE)) {
 			if (sr & UARTSTAT_PE) {
+				sport->port.icount.parity++;
+			} else if (sr & UARTSTAT_FE) {
 				if (is_break)
 					sport->port.icount.brk++;
 				else
-					sport->port.icount.parity++;
-			} else if (sr & UARTSTAT_FE) {
-				sport->port.icount.frame++;
+					sport->port.icount.frame++;
 			}
 
 			if (sr & UARTSTAT_OR)
@@ -1010,12 +1010,12 @@ static void lpuart32_rxint(struct lpuart_port *sport)
 			sr &= sport->port.read_status_mask;
 
 			if (sr & UARTSTAT_PE) {
+				flg = TTY_PARITY;
+			} else if (sr & UARTSTAT_FE) {
 				if (is_break)
 					flg = TTY_BREAK;
 				else
-					flg = TTY_PARITY;
-			} else if (sr & UARTSTAT_FE) {
-				flg = TTY_FRAME;
+					flg = TTY_FRAME;
 			}
 
 			if (sr & UARTSTAT_OR)
-- 
2.17.1

