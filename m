Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232AE48A94C
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 09:23:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348893AbiAKIXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 03:23:49 -0500
Received: from mail-vi1eur05on2045.outbound.protection.outlook.com ([40.107.21.45]:19041
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231130AbiAKIXs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 03:23:48 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T1SdWSav/dZgfsPiW6/mxpyjyqgmO0Gq+AF0VdGwL12bKowDE1N7FHPlOnP8co8BbEIoMJKZ0PmKm6H2vUPGnwMKKvY6M5akGNta70Xtiyw0g3bY2b5zpFiK7I7qDfCckOVWH6SjZM9N9AuA37h2MEzHTk/HQ9VjZBVFfyaJndWyxZKWZWVYnUe43f5nzjDeEHsOMW+9kuIHQMVx9+8VslmLHh6qCF3I99lLijuU1fkeG/Sbjvh/T8wRzn9OIYIN+xIfZxdSBT9WlEqvlMeN9T863qWMBVsfO+2LcNsjQjNxEoE65ae9f12Py/oQlVpkM0c2WyP4hjwSQ9xasG7lHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R+njCComLV6g52kKg0T5eUYoOxWclggl1iUJvACNAQQ=;
 b=YU6JxQTepU5p5QPMe2KxaTEcBSNPuA6ncVVuVzFVxZ+HQYbtq4HIbIrKU7higlcWC9rhoQ3dgM8NYRWNBmiqDj3lnCPfZ0kVvWr7DS4iefMWTT5P84fincAPvmzycymDYFKBVu0TARghzA/UXNnhPG8EzCJaGvZQkMVCBbSADBPnaDcHz/F9nKwIlxVvTF9PvqoYJ8bBNGTCdl3mg3RrwgPIF1LRNJcsH1fpcJsSezIlKupPtgaF3RBBl1slNaCBqvswbE1fzwI1HUy2aXYTf/uebHRkOY5VtVgL6/jL2z/VQdARCu/bWdf9FERJ0ym8hKZmu+qSsj+QGOBru2l05Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R+njCComLV6g52kKg0T5eUYoOxWclggl1iUJvACNAQQ=;
 b=Eews6qM7yu5Yo+an9tqbVzVosk6Lu1ivVvvjGK/SZoo8rmV9VwsZMqsNWhzGz4xXTdATpTvg5YSNklgbcntox7igl7QaY4bh9ModxJDAjyCyiWKSRzrIBESYuhYKNQmbyLR8vZ4bcCaBFC81e3crVi76AK++s7auY/8M6d/ivAw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM5PR0401MB2515.eurprd04.prod.outlook.com (2603:10a6:203:36::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 08:23:45 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::903a:e49c:dd60:75f7]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::903a:e49c:dd60:75f7%8]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 08:23:45 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH V2] tty: serial: fsl_lpuart: count tty buffer overruns
Date:   Tue, 11 Jan 2022 16:22:29 +0800
Message-Id: <20220111082229.5117-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0088.apcprd02.prod.outlook.com
 (2603:1096:4:90::28) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9d3f71cd-c505-4fdf-0173-08d9d4dbaf53
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2515:EE_
X-Microsoft-Antispam-PRVS: <AM5PR0401MB25150CA41A26BE91B9AB012F92519@AM5PR0401MB2515.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NOJ5hVu4fUZ3aIG5ULiTA8CkOUJO1ogC5Hzv+LjnRG+HFEzt5+z0+QTJJkrDI1YK+Og2ZXZ+C2bBaQ1GBKvNuTNn5BrhXVTLNqYcdwfX3y7tW9OM4jPzJyoAEgM08wg6b4aB+q7WopcyjHAM09USBwC5S82vDCUR2pN0QhEvYMfiaQKnAJyBoNU5+bbM5rJrE0W2mZUIkcm09m65LfGy7krsB70u3EsZV3e6Qx5JBwAAYdoM+wSY+AsoBbfQ5x2zX7GQBnzKKivdexYyrxzl7wmx6aYfGNTGvhfYx7suE1HGdskOGuOU4sdwvY8i7VxKGFZ92cTr39d9eUkig6CTKsw9mq84mpxYqIWQqBRgGZxf1u+dqcJahBtu3QmNdo0QZciADWSXdzeI393E5mn1R3jlhIl087hfxSW6tOsBzAh6PYu4PWHfyCXNoJ5bFlu+gR8Cd/5mcXZPPfPOC9A0N4B4QUkm9l7DS/eG1EyBpi3VA546Z0tEWtT4pkyTrj5J/ILk6hYx9tx1Q59Ha5rUcHLB5Ex9N9fRbaHqIIqMyx6kCBT0EUBzsXvzMx/08sH9jU2AtI1qhzrjKNiUiSIYSGDxkcHpOwtSoI8qLo7FxNxNyKsHIzJBSpi/Uegodeh0/e1+rXl25dWCXk25ZM3VOBjVV2xtyBr2RqNFt4a/p064ZiSb8EU6q1B93zexD5y5wwDt1CnvffkMQWYfS5+akw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(6512007)(6666004)(86362001)(38100700002)(38350700002)(36756003)(2906002)(6486002)(4326008)(44832011)(26005)(66946007)(508600001)(5660300002)(66476007)(66556008)(2616005)(52116002)(316002)(8676002)(83380400001)(186003)(8936002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MmTO4n6TLXsr6NeofHC5KlGhJMaKOp2cfWcjGfQc1o+ZJkgj8pHCu7AVL2XQ?=
 =?us-ascii?Q?3IlfHXXuRtRfPdJRHXdRji5oTZahxIMy6z73fCzR5IwzAhvkbpEzweAGpFzX?=
 =?us-ascii?Q?CVHiIms6dARI+qwlO6CLSikL1JfDTJ4VwZxZPsDrstAoUtS5ohBZpQr156Sp?=
 =?us-ascii?Q?JMVHEMeZjpS/FH9kg0PU5UE5ueyWZZhB65c8wyJyPPXacfrpnDcJa1P+rBnV?=
 =?us-ascii?Q?aJ+mb0Hftb/hsJZCZKjByJZZNCiSjOLQwQO+ewsWbFMMKLaotRmgR7LYdXW2?=
 =?us-ascii?Q?AbWZc7mSoP13EbGDv+oJAG7lN5J2P/xO0Ghl03tBOhPQG+UWaFelptLXGJ1r?=
 =?us-ascii?Q?XVco67OQz8oCGUJxMA9yftNCk44XrPC6sf0biavxSRLc1yjAXLTBOmCeZ3WZ?=
 =?us-ascii?Q?qWcwuhCjYZbR/aYrjtWU9h6K9647MeZ5K/QDs5NxS27h1dPl0af2hzpD2riI?=
 =?us-ascii?Q?ZGlk/R+dLmmuSMUoz8egLGIWnkPWir0jmvZrSm1Wd279oWmilF9Sp2eFZJN5?=
 =?us-ascii?Q?Wuu3/8urYsPPvHAVYOMj+3nGKboUHg4WUXLzvYoYpaqBj7Rj9OQeChjpCxMn?=
 =?us-ascii?Q?wKYSYxfLiKejGjDZlgnA0k/ctHF3YanwdY+8aYOm+03DrfVQ0MEXaVnmXBSC?=
 =?us-ascii?Q?Ma6iBoWfYBLQbPNxy49Jgn9DX28kHFwl5j/ckvoElABprTVs91RrJe6N0ymu?=
 =?us-ascii?Q?be5mnUt5aQeiJu+WS67eKXvJCAItLuG/NTlrFCzunID/MbgFT3pYPVZHSiiK?=
 =?us-ascii?Q?avx1NQ7MAuBCNW7g29t30X437c2GwFFVxSm8hjVesEMmdNTaVbVm/Oupv94l?=
 =?us-ascii?Q?xT9VOtJcIBQ+EgINcYO4GcVtjYOf/dyBbso1Z7wQVuBGnS1nPIODQOfdzhwf?=
 =?us-ascii?Q?hC+aWioBvYgFDv2QyHcjzdSueWwI10QZEzCkO7iqiy7H7JsDVsS2yxDaEpR0?=
 =?us-ascii?Q?VpjZMWF1kXUK7gkXv3Jk+dPr0J7SPR8BSxQtoileS/T61s4HQwIS36bYeljm?=
 =?us-ascii?Q?9rvJ/XGHIoymxt+d+gYuGAVoLTI91tcdrjANTxGXj7gPd2zMOEpq3jEdkEx7?=
 =?us-ascii?Q?hrijrOufBFpT0VQul+HmH9c4yKXzW1+BzPDxvjwK/SyvioX82nMNtiQnhLfZ?=
 =?us-ascii?Q?m2urd144cgj4WaAJOlEYr8iu4Nx8SAqPdnc7VOruI/gn5H8eGX2XVIBZttoe?=
 =?us-ascii?Q?VaBDxKW5J44h1rH9srGGnS5oWi0Z7dVwr5nIOS+u8+F4rJQsl48fFTwvBjQb?=
 =?us-ascii?Q?Ny9Ii5N6X29BBgvgeIUrVuX6hHGCC2nh+RVIZPAui6Xk1E6u8CZvh8hEwNuB?=
 =?us-ascii?Q?0tN6cWeFVZAKYN4y6Trj03O1lkdGVV2RROG2bJURc5LZIFO6Ys9lY3zWMwVK?=
 =?us-ascii?Q?jRqZJBA1LvCyzccoCyKgfoNtNt1oAMx6DyO5rcum4KLAseCg1fADFvFfwrx8?=
 =?us-ascii?Q?Y8hlHQaJ9xxmL2Goyjh3DJwV67DNx2bHcG7brThhQxow++Jd0tVkHsTrlKQQ?=
 =?us-ascii?Q?7zpYAHotMe7axifdwYd2FtZdvfI1lnhA+s/8ATq/V7pxuPxUkjpTRWZnRDUr?=
 =?us-ascii?Q?GxZYdbZl1ZBJnepiynHWACx8veDIdMAqNuAVlFReUwynRI/SfrbAXnV4hZGb?=
 =?us-ascii?Q?2WAp9GvPoN/eK11BHiDcTko=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d3f71cd-c505-4fdf-0173-08d9d4dbaf53
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 08:23:45.5733
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kIjJKx1XG+ozejvh4HFpVcvb8YKo8UhTXsHP5cheH0oAFYiZkZmJDjORq1m7StcDCcE6iIph0ZfWIYjwnYe8rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2515
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added support for counting the tty buffer overruns in fsl_lpuart driver
like other uart drivers.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>

---
changes in V2
1. Change the copied type to int to avoid implicit conversion, as the
tty_insert_flip_string return type is int.
---
 drivers/tty/serial/fsl_lpuart.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index ce3e26144689..82a1a2817750 100644
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
+	int count = 0, copied = 0;
 
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

