Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B15AD48A9ED
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 09:52:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349068AbiAKIwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 03:52:46 -0500
Received: from mail-eopbgr70052.outbound.protection.outlook.com ([40.107.7.52]:51888
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236391AbiAKIwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 03:52:45 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TzVKl7BeDyn7Oh8pkinbnc/3/B1Nmec+3pgz+/2Ll+WRr0xrbaWHtKqXvP2+T6u+T5eXyQ/j1jpvHPKDhziGyYu2e/WkYcarjuA/VIMHeCknWhNoZ2DDswy6wRwl60hzu311JZOC3v5YPTG+wWB+Dr717hEbv26s22rcgKsN8RLVyhKqJHztgORu0aoAdAYYoVM+ddtMQKMvTVUC5CtK+wOeZ0AQFopJseNXP+6mR+mhLNtPmdFxwzoqIoQ8LYQCiuVMVk2+sIMN6syA7IEWgNupLqWA/F8fejgJvVfpvwXLBjccWsNortnv2yxheFCbeRQ+5LDrnyyI/fI2d+HkMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3r6f7VvDqJShCKadP8ZnX0jOYgxe0UFJy37YJImdMws=;
 b=B5PhJsALjitWDDfS5m5jjRw8Jw1TA1uYMvmTv0AM+KJGtMbHUIOzYj9aRApJzWhO8oP1L5bRWCpIwF1ksROyIHthiSuNjtHFrjYTKA3Q3cVdrhj5YOl6TBOiKJYqERmWPvoCKGg9HEXmeNI/zBkmQ1oV6gbU2eD1o4/NT3dw0tblFdOc9wie9y4pn1BX6z8A8bP06G7XFc0t/hBcJa+h+arf6GX5SAC9EXRJKYx+vdZe57nTc0/IMBQ1xHE4k0vZ3wNHFtz7dDGHCUTnsTz1d/I5gWkI3wrvkM/icbeTj3uCPfAvylE12gNCNmwcynfcIEybWJ57ErFBFA/YafQBag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3r6f7VvDqJShCKadP8ZnX0jOYgxe0UFJy37YJImdMws=;
 b=d6zqrwwPujbTY0mNtZaTjCaVIe+RLTp/EaefpNcZ7BAiVDssjEpadG6CwRrokAgaq9U1AngXUdPTOVIbFHDmkJRbiPljVgsyoNiEN7mFCOVWG3rLT3N3/ZKeIVU8J1zbGVKNxJCRq8tnw5oO4ELbcS+A3MdNpWJhcCKm3UvwEDw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM6PR04MB4469.eurprd04.prod.outlook.com (2603:10a6:20b:22::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.10; Tue, 11 Jan
 2022 08:52:42 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::903a:e49c:dd60:75f7]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::903a:e49c:dd60:75f7%8]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 08:52:42 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V3] tty: serial: fsl_lpuart: count tty buffer overruns
Date:   Tue, 11 Jan 2022 16:51:30 +0800
Message-Id: <20220111085130.5817-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0039.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::16) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: db2b1b68-4bde-449d-3539-08d9d4dfbacc
X-MS-TrafficTypeDiagnostic: AM6PR04MB4469:EE_
X-Microsoft-Antispam-PRVS: <AM6PR04MB4469F82DFD3EE90369BBA35D92519@AM6PR04MB4469.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FKRCo/8g6bO25s7H3eKiHTcXhGkd3hdG+k0y96n6E0E6A49L4AVkcj3z287YjY/Rk+/IqGXmmnoub31WzCf+fz64jbY7ODp9YefM2JCgUxSSBDwTTZfvnLqgZHxvVirnahzLdHGYnQgRvnv40/FFnkjZ6TUkEWPN5GTIOSiIPtJqssgEP/2AcENSmaNWPYhVzs82YPLQS1ltGu/tJBbipI4xWDLOoTZ5s7Ouq2PXpfmmWYN6Psjocmcvm0M7LSpcCCLxVnBN00yYZO4Sn/FyFI5pIDERvBA4PxUyy0WpFD+7ZldVMTArT8njY7Xt7umhIFNBmay5as+ZEZohJmuDFtC1oYIVX6abzTlMiya7vJT/Vui121btjwEY22v5ttcoBGE98SiEgbBNBMXOT3QokB9gP7Wrq5x+sPek4gR/DQqXyqMXHZe0PqVaN3UREa9H1uUqCmIY89f+eD2FfY0cDBly/gsoPUq+rtSaF0kyrRjzYkBbUKqZDjnn2D+Dq4eUaACFlos7QWGx7fVKLYse9GS6Ilun0ZISLtShpmHMwjifOphgGz2QbQXMidqzCMIrPPWOZEpy1UAZLqYd5JGxskyrtUZBRKC/KwmcWwr3W1wZrkat/9XF+RnF7Ro24GUyq3WpmjUPjpwNRQ+4Z0/Osemx2XD4cuidIza5ot3zjRQYP36vigA1whXPIVS1qrLocbC6/uh683LAiMNGDwe7UQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6506007)(38350700002)(52116002)(316002)(38100700002)(8936002)(86362001)(8676002)(6666004)(66476007)(6486002)(66556008)(83380400001)(2616005)(44832011)(36756003)(1076003)(5660300002)(508600001)(4326008)(6512007)(66946007)(2906002)(26005)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TirNMCpAdT0pjz5mfR/zN1OJMrnAOxZqjWBji1DAXh2j2C7tlnIV/thbyEln?=
 =?us-ascii?Q?SqNgn14bvX9XPFcJbp3AAS/CLTGahIESoh5jt3UUtJGzl3Qu3a+AW8I+Av6x?=
 =?us-ascii?Q?VH+piJr27xEo7qKLM4WXSYnEPq+lIlHJPHbSHO6/m6FldMtWx/6ND3i8NVqM?=
 =?us-ascii?Q?sTD+38sGd9wQYvT1R2Yes2M2xanh/qpIEHTiLQpB1Ot1G/5QkuiPqTTXnvM0?=
 =?us-ascii?Q?4G5UXLpcHuTs2QcsLeDWlB0X4yJuHHoR1Vhxz/OF3Z3UDVDV/1he4wOr1pQH?=
 =?us-ascii?Q?Ogxl1jrPVBVUnnXrpzM7fHneuLlWZoR9VIK/r+dvaibTYzX+pqmO7pDLzD5h?=
 =?us-ascii?Q?9lKYgm+Sj8NObkFcqif9Wnrp/Jtz4/zkGBE7nyciOcuFsm076XKPbyj1a/PY?=
 =?us-ascii?Q?c8Kg73IfgNnC1K6UJBFqYsegBpkkdZfevyhb9yiZSAge/dDPQfvaO7+b9RQ2?=
 =?us-ascii?Q?Ducs9ewjqm6kS3mxyhkuAOdqcn2WOCKOqcGibWZDrfT6kyWGVH8+DMqNSu4G?=
 =?us-ascii?Q?yu7aJJA6IW42cINtIbCo/LklbW4e/NltCU+tNADXynmHXsMj8DkbGc7TSzU0?=
 =?us-ascii?Q?bGgbWL+HsarXe/axQ5+m7N6eScHkMm3BNHigVArYTKBqPWCqnkWrwxL20qw5?=
 =?us-ascii?Q?lOHVsT0pf/Ijc9SgFhC6127oC7QXFbNvOtVbPJ2V+Dg+mQWAxzhWEJKbVI3A?=
 =?us-ascii?Q?GMwJJyULVycigEOOjwwJltL8EjEuSEDkLZhEIGq3BoVYo0JQPyZzBb5G0T3c?=
 =?us-ascii?Q?+Ns+Hq+4+6gwlmY66gFPtZacBPwuNzZkYT1O3ASLEOoUEiz6U5far+VQmCu9?=
 =?us-ascii?Q?hs1cLvZ0p5tVJsc0lj3nvADl8isWWPJzGYwCB5WGjp+P2WJu5UzW9al9VGi6?=
 =?us-ascii?Q?eWvhjMyT8qUWCoRipAY7DTQc0Fnjx36k+S2X5M/Dcx/STPH9+JARuRytatp0?=
 =?us-ascii?Q?CPZQH4MPjayTd8DqJ4jzOwPYdgJlctHZOT7jmdSgf3NfteEF1crg+RxKUrAn?=
 =?us-ascii?Q?dUaNelNMiPpqOLdvVTxJYWctShQkppyaBk5msqn1TXCo5ypPjYHRkyoVkStQ?=
 =?us-ascii?Q?sTOPX6l0J6gt3ue+RKvDA8wxSk5neBbwIeKhcNjOR+NFS7seN59C3GjZuUnh?=
 =?us-ascii?Q?SQ4qGxXj6IZeLPu3JGe0oSqnKNj6FMT4YDX/EVx/Q6R4H8iY8zxCRCmCzjKo?=
 =?us-ascii?Q?KzlUL9w8B8QvO+sGiBf+Y9hUy4EqTdAnT+LQN8F5EkLjnY2Px6EfFbXLmLkB?=
 =?us-ascii?Q?j1a3Tvy9Umw170+MB1RU9tAQAw+ZzSrc/fkxt8+j+PuugekFZoWDeAFsa+PR?=
 =?us-ascii?Q?WqHG8u7ro67Pb/CqmyUfCkwt4I3M22q9lEWDKTE2ANR6GBA/eKq8OxYQGtHV?=
 =?us-ascii?Q?k+MhZOVKIgahaGWq4cRzFCTC6AA2hcf7QukECG+gniQv/Ew1Zb36iZNItSv0?=
 =?us-ascii?Q?sLHUVQxYXg57yqi4rWO73AkkRY3HK0jKdV31TKRSTnnOXrEKaWsfZ+BWXgVb?=
 =?us-ascii?Q?H2HHav7kToN7VGr7MAtpLlsCliYYcEMYEGtG3ZYGTR/EirD9PyJKk+onidOY?=
 =?us-ascii?Q?QYsswHjLGCe4Y3YnN9ZC19YHCHTDYL90zrm6ZrYOuIbRcDPytTJy/xxGyzAt?=
 =?us-ascii?Q?KJ4/juwfk/Ea1idXeeQobMs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db2b1b68-4bde-449d-3539-08d9d4dfbacc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 08:52:42.8403
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F+MGgt/IPwJyDOMRZqJlCg3M5YKRJ6/CqgLiYLc5ow73B+7XDJTL9HAOHakClpFmjs8zEPKgnSCwYyKvSGqUCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB4469
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added support for counting the tty buffer overruns in fsl_lpuart driver
like other uart drivers.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
changes in V3

1. Remove the initialization for copied as it is not necessary.
---
 drivers/tty/serial/fsl_lpuart.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index ce3e26144689..7d90c5a530ee 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -931,7 +931,8 @@ static void lpuart_rxint(struct lpuart_port *sport)
 			sport->port.sysrq = 0;
 		}
 
-		tty_insert_flip_char(port, rx, flg);
+		if (tty_insert_flip_char(port, rx, flg) == 0)
+			sport->port.icount.buf_overrun++;
 	}
 
 out:
@@ -1024,7 +1025,8 @@ static void lpuart32_rxint(struct lpuart_port *sport)
 				flg = TTY_OVERRUN;
 		}
 
-		tty_insert_flip_char(port, rx, flg);
+		if (tty_insert_flip_char(port, rx, flg) == 0)
+			sport->port.icount.buf_overrun++;
 	}
 
 out:
@@ -1116,7 +1118,7 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
 	struct dma_chan *chan = sport->dma_rx_chan;
 	struct circ_buf *ring = &sport->rx_ring;
 	unsigned long flags;
-	int count = 0;
+	int count = 0, copied;
 
 	if (lpuart_is_32(sport)) {
 		unsigned long sr = lpuart32_read(&sport->port, UARTSTAT);
@@ -1218,20 +1220,24 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
 	if (ring->head < ring->tail) {
 		count = sport->rx_sgl.length - ring->tail;
 
-		tty_insert_flip_string(port, ring->buf + ring->tail, count);
+		copied = tty_insert_flip_string(port, ring->buf + ring->tail, count);
+		if (copied != count)
+			sport->port.icount.buf_overrun++;
 		ring->tail = 0;
-		sport->port.icount.rx += count;
+		sport->port.icount.rx += copied;
 	}
 
 	/* Finally we read data from tail to head */
 	if (ring->tail < ring->head) {
 		count = ring->head - ring->tail;
-		tty_insert_flip_string(port, ring->buf + ring->tail, count);
+		copied = tty_insert_flip_string(port, ring->buf + ring->tail, count);
+		if (copied != count)
+			sport->port.icount.buf_overrun++;
 		/* Wrap ring->head if needed */
 		if (ring->head >= sport->rx_sgl.length)
 			ring->head = 0;
 		ring->tail = ring->head;
-		sport->port.icount.rx += count;
+		sport->port.icount.rx += copied;
 	}
 
 exit:
-- 
2.17.1

