Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B430D57F8EE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 07:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbiGYFCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 01:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiGYFCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 01:02:47 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2066.outbound.protection.outlook.com [40.107.21.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F92EB87B;
        Sun, 24 Jul 2022 22:02:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkRvDCfpW3/+zrdeGx9XYAKBqlfMeNrC4FWMK0vtNdScEh/qTEGQGo1ZzBcW9fgaLRFc97RK35U6DeF+dwu4vdTlto+M8tciOlMEGlvbbU1c5vryLbsc0y5yO7XMF/u2Zz3N3IdbidIKJ9rO8cmirVee9wgmCTqdtdOn6benOMkvRIYO+onbWR4AVnzt7ikRMYW6M7KMXN1L3zOCc/Pp8avnNZLU1UX6wmb5+kiZ3FiKaKgWtOmQZ6VvPpjMTCqwoGaG6+QNS1oyWB5HE55fgUPwmJ0g0Tq+TmGcpg5mqXzpWKXuWuKVoyP/zOWRCXXfJ2SNNtWaRrmuIqlUUxFP2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V7iwT3Qvduzu5ySyyEt+LzY3ltcfpQkjxSSGpxAX4Sc=;
 b=T2YU5N4e5t5lHSCP4gHkQizOqJi8/H72gI/2Y+fvHc0STSbIaOXLT0dYF012eMzY1HdTWYY6scDDElpxr6XLb0cz83+J6mPSdiGsV2jvlOj6hs3EAYnd/tOC0Aor7YolpNzd/iiTXmoPTVoambNOXXZt9wtpDe8Ae33goX0yU46DyzcgyPAF3kWTqfmC1U0Da477Lxh4UwFFq2B6EZ4sdbVKT7BmGhToSdQbSdYHwQQHHHfdbJcxQqRvAjON/daNFNLIN1E0Ye42NM8vPxnoSKv3wgQQXOiaaAaUwMVWbHq9VOfhEAE+BahAwhs/TSxAMiIHGMgUV4NFGwjVDTdfbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V7iwT3Qvduzu5ySyyEt+LzY3ltcfpQkjxSSGpxAX4Sc=;
 b=Rf8EhoojlQl4T8xR41kco8sw+8pi/c5LZh8plnlBGDqaTSxHJYneJWjHjO5fwfaZ3cENnXwWZYJ/LqKWzd02qvc3I17YwTY0xv4Vy3eDVbnc0qlAEZ2LC3e0EorzpUYmMBJFaMQOKeJOgo2NlWN0DIob6piuWU36qhhRQpDKRxU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by DB7PR04MB5499.eurprd04.prod.outlook.com (2603:10a6:10:8b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.25; Mon, 25 Jul
 2022 05:02:43 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::4c81:58fd:464d:3160]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::4c81:58fd:464d:3160%8]) with mapi id 15.20.5458.024; Mon, 25 Jul 2022
 05:02:43 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org, michael@walle.cc
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V2] tty: serial: fsl_lpuart: correct the count of break characters
Date:   Mon, 25 Jul 2022 13:01:15 +0800
Message-Id: <20220725050115.12396-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0202.apcprd06.prod.outlook.com (2603:1096:4:1::34)
 To AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 73977573-a2aa-486e-e5c8-08da6dfae865
X-MS-TrafficTypeDiagnostic: DB7PR04MB5499:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: i4FwzwpBWfMW2O3Dqd+ma9gaiRAUjB4hGjAVgy5FUSGXJVq3nP9sEcIlW23yqSXbjQj9FaxUSkxk+cXT8fA3M3CLjo8j/Vu+xQs/kTMtdMC7u9AhEr5raI+epmJjWoeUX7oBy3Xz16e0vnFMYIWOE/+26ALfRcmbACNhqE7YXtoQjvLEzrO/HvZ2NuV0ik/idCT5I/cmSQ7N2iCf7JSdOxk1mHAz0/PvnQYBrdBg442GyvbWpql/qHhQ3oM18csndg6p0rti/PeYfXUtHiMYMtsPYwhdDx5rjqTsj8rDdOeyqTnqDZMx8qHFpyknPPPr/oqWmqHzp+ZxnLaPjxb6OvG+9EglIk2Kew21/QlQP1yIj3Ma8lbD/3FenjQgqc1yMKRvB2aeftSq1Md3nJrAGwMSY/lf8ieR8fLAJTRmWrJmN8KEZ/gQjeAwYGVQMLGSTbqTg+lVdveLDbSBac4XLz86/jyqsrwcyAcRU1prt1yU1SNiCCECWJ4hnn3eLIMZgorjBpPgjSfS6ycfrl5GbMoYjg5LRiGIKJysxtaqWW5ZrSIPPMRhP6bPV9SCqyYx2pDtfbhpkKPnjstenq+vJn+M/Pv4WgB1qjW+iKt3+6PjeK2KV7rw1FLQoPoakRK0Hy82k80mmtQag5tWKDn2eILiqcyKB/KoEa83IjeFMB27zxLMnkyWSHZWbedL/F5EYBs07dZSFtCYoqw5aeAFnYIQVvIsyBmyaQxQfA/c1e52m0iD6e25cxxznxT41ajI68iM99b2zy+ypRPAMhCPhTsD1QioWOrpLB3n2wykbzAtkt3KUEkcNWrxEUsW9XXF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(366004)(346002)(376002)(136003)(1076003)(6666004)(2616005)(38350700002)(186003)(83380400001)(4326008)(38100700002)(66556008)(36756003)(2906002)(66946007)(316002)(478600001)(6486002)(8936002)(6506007)(44832011)(5660300002)(6512007)(86362001)(66476007)(26005)(8676002)(52116002)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AKc+DoBxIJp3hYR1r3aUCuotXQvVAjCuIBaoqGJdqzrWJGdcuT1eq76eKogN?=
 =?us-ascii?Q?o33Bl63WesBW5tdlhaXwviG91ESlO+t9YWBh7c3zmikNMXbjEKg4P/+HtEyc?=
 =?us-ascii?Q?vaGduyk0e2QmGHXge03v1N0jwkNwwvRaYNlk38mJSdbKqn8r0gON3AfCd4kR?=
 =?us-ascii?Q?IbL6g3BY4SXk9AUBeGBOWaILiyC33u8lE/4h+IJvnqNZtCliXoEYpzdQskMC?=
 =?us-ascii?Q?OusVv6b8ZRXi90UdQUZn3+f6ehcqShzFIQI0tzcvMYuNKIX6OUiWmUMxyHHe?=
 =?us-ascii?Q?LRD3ZWW2ImGVSZqo3RiVD3jv+ZUsctMChFihfhj2R47MkP9qmViG138RAqJh?=
 =?us-ascii?Q?1pW62LcXVdZImKqR2AzU/9loIIAN0nL5NGJk9uq0SDypxNPIEdn+nL2NWNSa?=
 =?us-ascii?Q?CUbQ/eM1Uul7mPshTF84dxH/uyYynVOlnvbz3/B3dpv9iGdeaFilK1jkWRqn?=
 =?us-ascii?Q?eYeubfoD7QlvvYhHwk8CzFyVlvJOTRfWZVflr0ZX88B4WX4+4EyIW4PYdYwj?=
 =?us-ascii?Q?g0eAEH9XNqBM84p1b9CgVwAsPZeZ6RfbuboqNKUQP3wuglsTCE8ZeAhm8ybp?=
 =?us-ascii?Q?NdMnhkot8AJbAWt9XDAU2P4REv5lFolXlFKKTSsFmDpNYh+e/4c0agvSVdW5?=
 =?us-ascii?Q?mxCaHL6gwDVGLGlz4HALTGzpAVMt4Zc899BwtGN2X3jry+XtWKoeyfnoyY2b?=
 =?us-ascii?Q?zmyxxyxoIOzG9e9UVi0nzEROs5pfXPHAr4hYDtGpRADS2CFVoLP7Ro4GdbRX?=
 =?us-ascii?Q?OaKenLctjeoGRdhRHHEozGDcKgok7JCOauN5BgfMdBSaswonmzIbX27t2q0f?=
 =?us-ascii?Q?17Z1K8DtmYufVkf1rKV4JTR91cbytnQZanfZEHHwxk58aPhoAwWzg/PHNdN2?=
 =?us-ascii?Q?4PJtPEUjSSZIsRbuvhpm6b55UMG+FJmINRB5FX+OAJleM+p64lSKAdxFQLoS?=
 =?us-ascii?Q?9BtITiGEQcKeG7yNWwzL2/Ec3RYEKsulsH06DCEUNwlCO85v3q52rM53dzQb?=
 =?us-ascii?Q?WJu+V9RnnhypMkGpUgUZ+M115zm3/IIJnU+14z5MloDU0sbp91C6bRdK3KFH?=
 =?us-ascii?Q?zgZh1pGNwZfW4ntGt93033BuDkaBOvCQu3QGabSbH1RA4CK2H7HLhFiVJkRp?=
 =?us-ascii?Q?Pn+XSMbyfhTJ8wb37HoD15fYUV4n2Lm2zw2nVUd9s12pr7Ws4GlXI7zzUF3b?=
 =?us-ascii?Q?ivmFU59V36l3+WceVzGvr+Tru/ssKpVDfCcEcT6tBq07GwSdbZ+RaMyuCv+/?=
 =?us-ascii?Q?UJhyGjVXytd3mPzXZXov891dApJJVYYIFwpC/zrrHacOxuZLb2atfV5ud3uU?=
 =?us-ascii?Q?on7AfnLL61xUQLlRXSEssPp3HCRqVYX6AsVObI9BZ7AYRjtQ+G+f/+SYPEzT?=
 =?us-ascii?Q?trm5tijxyuPqI+Tspva/uUiOiRKKxVHU/O56XpeWrFmICzOGxHtVwmp29M9D?=
 =?us-ascii?Q?FBaN2d2Ow3l5gUzRtKuLwFEgSIXurdbXvZaBLxEItdCeq4VMv/tV0DQoHNkS?=
 =?us-ascii?Q?J4U00YQEea7VrxvvBHtNlh4ym1FJcH9VN7CkmbNCoVz2sIR7TkJxLHyCMFCj?=
 =?us-ascii?Q?nbtHLvdvK2T03m7s1PdMSca6nZ/RDJc6ymdJNdEL?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73977573-a2aa-486e-e5c8-08da6dfae865
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2022 05:02:43.6933
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lsKDSZ9IIvF6R2JzcrDCucO50XSSYrhXvgpvPpWv2wFwN2jraYf7aBY1rF55ZuldiZAfeQt/1mQzA6oFRBY9CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB7PR04MB5499
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
Reviewed-by: Michael Walle <michael@walle.cc>
---
Changes in V2:
1. Take this fix patch out of the previous patch set separately.
2. Add the Reviewed-by tag.
---
 drivers/tty/serial/fsl_lpuart.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 1c3c6844fa36..8a4aae7dbd99 100644
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

