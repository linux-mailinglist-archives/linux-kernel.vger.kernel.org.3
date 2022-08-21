Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6593F59B318
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 12:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbiHUKQj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 06:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiHUKQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 06:16:36 -0400
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-eopbgr70048.outbound.protection.outlook.com [40.107.7.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1946F120B0;
        Sun, 21 Aug 2022 03:16:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hj3SYMmsdCTTvfVbkeQRhr1iuvTa1ml0MUhxMGksroSUeceuWS4ai2VGT4Wl8S+M1s0anZWzd5sFM/MPEaLyIXWJm6kV+NYo4f/I5vAlazuI6urLlRBH6pBV0/zPZWXg+i0+k15H1BdtGLWUfv+sidvM8prR5bpKiO1UNRIuBclSNSx6ADZD/e80wL7M79pirYJuz30CuuMBTR/FD5cMAG9kR0aioqIvpZn329UoNkgtUFiqvh/OUpaopuEZ4cihuaeDAYCIiU5uGTWQuHCEtggIU/J6MLuETgRW0xbgjoN1DvXM16AIeMV8CS/qgU/cGZchWPzwZM8UnVAZ4Avkqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sh8V9SfX8ZnIH1WS76ORFoVHS+aWdB7VGEaN+jy6mXA=;
 b=UCfhGEyJ00h6WI3yU0V9+YSBiaVLBIfEYu+GfQhecs8kjGTksZpaD5zWdzTqblWBlFTsHEpIcaZDJUtcDNudcm7BuZqAdMQFtwUIQMoUjOooBunjQpQx4Vdi2MRQZz1QvfAeKdwFnCV41EQ7rjzSd1ZtMubnFWumnqkY5nIWKUlhZWKhJEAAhTV1BBhO/yqd2azG9tuxzDWCTXh4TG+YW0J3Qyv37l3T3VdLte6qnMDipTb+ipHQ8r8IjB5zThUWU5g4ZHPdHS96ck4vKfeUPckl4FM7+Z8PzM2XWDD94BrO7uNVf/VsGI/oUxFlo+HJJ6SacZf03Eg3eqY04WcYuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sh8V9SfX8ZnIH1WS76ORFoVHS+aWdB7VGEaN+jy6mXA=;
 b=k+wUDfkUcOdEs+gbz0D4Fnh3IiVq4aWIcIef0LLqFTrfgfIqrHpowocfNjiHNE4hC5Sev7NJsKvoP4IfjA6TwHjsbGNOMwIAhgfnQVb7vmYxn2NSe4qlQPPPm63HVVZFFhmvb6VOvt4vkOsrz4FZ+AUyV6uaO91fdsMJRZwd3H4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB8411.eurprd04.prod.outlook.com (2603:10a6:10:24c::9)
 by AM9PR04MB7554.eurprd04.prod.outlook.com (2603:10a6:20b:2da::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Sun, 21 Aug
 2022 10:16:32 +0000
Received: from DB9PR04MB8411.eurprd04.prod.outlook.com
 ([fe80::582a:9810:a2d2:94f4]) by DB9PR04MB8411.eurprd04.prod.outlook.com
 ([fe80::582a:9810:a2d2:94f4%5]) with mapi id 15.20.5546.021; Sun, 21 Aug 2022
 10:16:32 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V3] tty: serial: lpuart: disable flow control while waiting for the transmit engine to complete
Date:   Sun, 21 Aug 2022 18:15:27 +0800
Message-Id: <20220821101527.10066-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0010.APCP153.PROD.OUTLOOK.COM (2603:1096::20) To
 DB9PR04MB8411.eurprd04.prod.outlook.com (2603:10a6:10:24c::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f79e3e56-c976-4044-2b1f-08da835e3802
X-MS-TrafficTypeDiagnostic: AM9PR04MB7554:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mlY+BnUAPzh04rYmYGtcbiRpPYrwFvSZDgQhLzOFH6Glh/w/YpMWmaH5M7odJttAB3ettwR7UBEFQxSSOcTjJDqmQei7Wbwm42Cfo/os/kj0DJKS/98SS/32b9d9MknNCs5NIQdutu8ITcdWRHv6/RAka2a5K7xqil0rmyiKmTMGR7DPLeqGvbnZMln9uQYYBY4HzDNEeeF2fOqefKBOaY8/4TwFx2o6Z7jFm0uEkMjfwWgDQCWo6fOvJpTMveGlKSigRgXVve3I6mbUGcIg3ArayAXap1wjqTtfIVyFwZ6dps9oFriWSlyLgHvnzQFDmoZLUKSqc6VsLpm/yGywYJsUnrEt4grm8Xz2m9Mob/XgVFvSeEaX9ZyJfrG2LIZQG6f8HH703WK4TjxFHfpl3BxwlNXeLUJfCO/UxSqz12crkl4G5Q6dnt3FQ+3VpL+St/smGIy3AVT7hxteBnZ0UqJIQ/+wMrGdvBikM4gQbdmaQ7HIcr/H78jIjg+Lm1CacR1nWWRMhzkgle4Hv/AOxN6kcbcv25sPPqTxayJboXEx1I7jN7o1oWgdqzs98zz0pi5WI6EsOF+nu32lCXfsHOqJhknhsOCJEOAxfKEdWoiZgeCWvn3kIDoWXDX4hhvKx1GWz+hyUlRBaZz8kMqHUqcI/42hz1BoFvGawjU3WZLbLKNIAiwt9TxaBxoBFyjuKdCCQi8sbP0JXiJ3gqM+GZvHzz0Qp+t4OU7tfMEQPZy0cUOp/TUjwRr5oTBIhP3d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB8411.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(366004)(136003)(396003)(346002)(38100700002)(38350700002)(6486002)(478600001)(186003)(83380400001)(2906002)(44832011)(36756003)(5660300002)(41300700001)(8936002)(1076003)(86362001)(4326008)(66556008)(8676002)(66476007)(66946007)(6666004)(2616005)(6506007)(52116002)(6512007)(316002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D8/0GYsszQ0ToOTC74izl0QuLkXP4ymCvE3VxTKP/jVVyBIhW7Cyf9aqCUPa?=
 =?us-ascii?Q?CWugtFO1/r17XBUizCKXxhtFVb7XlsNjEOevY9dMPIqb+wE0RCNOCA2dtAxT?=
 =?us-ascii?Q?5hYmZROhSX5evikobDpWTgOlwHzlhcKUuCV2JdaY4bN2/gqjXoveMPhja+lb?=
 =?us-ascii?Q?mm+Phu7d5APgiJ8C7hNvmgW4WI4y7yoYIRm1Us3jTyRIjAQVgDXlX+ZMqL3K?=
 =?us-ascii?Q?NDZ9zVi7ec3+gtRUdKBbjzjDN7CraJxZwoxJHsSS8AIn/rJUz4uHdKcvkAt5?=
 =?us-ascii?Q?vb+2JobrRKsCObk1Hyk8sWwksZkw5oKgCCsCs5VBdWEIzfoopZTh9l4wGg5t?=
 =?us-ascii?Q?CtCH5S8zaxG53KaAyCt3yrzkWMB63CQFBmeOh1IipOsULNGlraASwUyLm7aS?=
 =?us-ascii?Q?2ROiC9ppCinhWDNoHvEa4HuoZom+CqOoIytK+l/5kduskDq+dlwfp+ZGmob2?=
 =?us-ascii?Q?8n9103lvc2RkMq8Vd/Z+71Ri0mUa8KD2ME87rW+NRVTkwMX1g8Sb5dzEVVNt?=
 =?us-ascii?Q?ujrS916VmgRZXb6BV5M8fRelOtMXWBh2Ns7tWOu+8sdxdSyHmUbjZdk5xRhz?=
 =?us-ascii?Q?noc/2e+vMLONkmoW2CsKb1cjJ/MGyeJo9NejBTKOi7CuZf38qtC7bQp0jhZT?=
 =?us-ascii?Q?seo9+g6fKch2EWf+jRZoJctWLiWjrzoCeK3i0Z1wLynjPHhbOHLGPKb8Wv6r?=
 =?us-ascii?Q?ss+sVQLL4bNUH1m4e3/ThYXJ0VBbjjOs2E4pT4Y9L06A6uedx6RFp7AmMMNU?=
 =?us-ascii?Q?n3VnWPO9Jv8hlU2UNg6afJMUCFYuOJthsz0dego1ZDlFZnEXjLlHEUZ/t0EY?=
 =?us-ascii?Q?tF2C3qIJW6ZFAdZRQFt3lC3OGiDKOG32zI1MbL5veY73EKatACkD1yLFpI/B?=
 =?us-ascii?Q?8sDXI7r6eSgN9LWKl7g5UhiJcXW1qQDg1d84JrGecrjKWfCdLrh0e8PPjPR2?=
 =?us-ascii?Q?KoSpdiOTKpIekHfwQZGBwoa51a6wkPMdwIvtDznRQiKLWM8080fQ37oS6PYI?=
 =?us-ascii?Q?lA/MyFx9DhtehtWezz8oJYim4dh2NnFVyO2ux0WQlwAAa6WZFrYHAI7u2HuT?=
 =?us-ascii?Q?8tATq+EshMSOeH0UnTe/vCm0yyJFTGEbsRyHVtzcw+k01IYmX2mvhshTnPZy?=
 =?us-ascii?Q?NVHhKxM4r8aioKaVx0yv6zDzmI5o/x53sw3yQvhll8gL85OH9oHs4DZcXZQV?=
 =?us-ascii?Q?2T3ecsUYz0Du9S6x/NfFPrLUkOJNvd2r1iK5erI4ysIwRzGQtjkOUM/HXb6W?=
 =?us-ascii?Q?Ypmvf/9zh/pyBhvKYeATkc1vdINhZe9pNpWAEqfduwJKbablIG9ZXZ2I6Rb/?=
 =?us-ascii?Q?EZepBOxBpmRajSUJYNCPhjVIVSm1c1SW17CLkdzKJIDHFMFBNfpzQtDCcH1b?=
 =?us-ascii?Q?8vBBkFRti4WKncEPJjlWUqPmuIsK5VuVIhFREadI/bBfoc1naqjtPUpMj2Rg?=
 =?us-ascii?Q?nE1PT0gpYNXR4jsgg1wvupLeWKiRQwSu9BtUErrbCXv5CdaAjIvpKNZ2r5Nh?=
 =?us-ascii?Q?Ck5HQBBFlbmlA4vIdtoyyTHGy5RaYYTz0BSxggf47MzGq/cA6KHa4B/vtodT?=
 =?us-ascii?Q?9RXqjgZSdHORIR51/cNs1DtpMPENKRn4cqJ1CXjR?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f79e3e56-c976-4044-2b1f-08da835e3802
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB8411.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2022 10:16:31.9301
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TjF3kI/oeyuSr32YCJhAW2D21SnHYFI2hM/XzYUgkidBtDB025TL0JPJq9Q29m4ihncBdKgACF5hVNtGThc1Jg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7554
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the user initializes the uart port, and waits for the transmit
engine to complete in lpuart32_set_termios(), if the UART TX fifo has
dirty data and the UARTMODIR enable the flow control, the TX fifo may
never be empty. So here we should disable the flow control first to make
sure the transmit engin can complete.

Fixes: 380c966c093e ("tty: serial: fsl_lpuart: add 32-bit register interface support")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
Changes in V3:
1. Add the Fixes tag.

Changes in V2:
1. Rephrase the commit log as suggested by Jiri.
---
 drivers/tty/serial/fsl_lpuart.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index f6c33cd228c8..fb2ad5d0d368 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -2191,6 +2191,7 @@ lpuart32_set_termios(struct uart_port *port, struct ktermios *termios,
 	uart_update_timeout(port, termios->c_cflag, baud);
 
 	/* wait transmit engin complete */
+	lpuart32_write(&sport->port, 0, UARTMODIR);
 	lpuart32_wait_bit_set(&sport->port, UARTSTAT, UARTSTAT_TC);
 
 	/* disable transmit and receive */
-- 
2.17.1

