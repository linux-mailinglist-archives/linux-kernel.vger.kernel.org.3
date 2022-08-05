Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA3F58AC7B
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 16:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237972AbiHEOp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 10:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236039AbiHEOp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 10:45:57 -0400
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-eopbgr150042.outbound.protection.outlook.com [40.107.15.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA46F1EAD2;
        Fri,  5 Aug 2022 07:45:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gMuirTFnN3PQkCSXQmBm9JLtRozMKKmWzwBvuwwqM3KHZixxMldBFMejDSpjIr4tIJOrhqKz+DFJwxIDb/uHh8N5tUQtIyJx297K/PQ/TW10faGseAQ9t7d7xxg9yaOIdXZI/MnnJeUkBEI2FnrDkY+sGzAiMXG/WtF0Lv4Vzy9E1nhgkfKrFC399oIwTnQ1XEecjUikRw6tcH+DfVYzfHTlkP7ShQJM0mX80Qmrn+fNPU+BXAPXNnaRmFtq65Wu6blfyHEPI/eLL7ze6oURR5kRfl4F60QcFkIBI9QhigpxsWV9svA45OTVYnmRY4/Z9nwyQ4UnF94D4dpypr/GTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZhZHEWuLj4w67vr6qVBJ6rYh34VVsTLBrCummv0aZ70=;
 b=erzs+eOTv+LkxFYsh+XtTWszhpgpUR2X9SBDBcWZQccA8HTw7ub0mrgT/x+WgzRshkEuaMRk0EUr4S8E/mT/HF6nCtVXp6Pg2SrLyKNw72cjD1Cxh8RbG7LH7Pi9J8hIOCuR7nZAQHcN17dhz1K8jWn4xldyZ9RD/jTOd6JyLYt9QF5+GZ4mcCjLEgfk78V96dr1yt/yV3ic1WMGDTo5A73aRCuwYrXYvjXFWg8tpv7EbkYPy4ub5X19zj9gqDEYThG/siRgebHZ9ZWT70t/O0LCuLMvYMxrzh+S5dOz1bZ09gQocJThBVVeP1isIf7VmaBe8uFMFmyEbE7uiQDC+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZhZHEWuLj4w67vr6qVBJ6rYh34VVsTLBrCummv0aZ70=;
 b=W9ys/97OY2d0kep9goWqr815CQpdUST/8xDA6gzT5jwDtg1vUTTZDIG2Bx6Z4doffd+RLXsfXEVNO29ctftBdSLjdHg6bEQPdeunHofVy1OeIJ6atkME1pnGHWmSidDWBbZrGDSTkdcPVtHqKvBV6utlkjk/uH9nxZt/XxCnUcY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com (2603:10a6:20b:3e8::23)
 by DB8PR04MB6811.eurprd04.prod.outlook.com (2603:10a6:10:fa::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 5 Aug
 2022 14:45:53 +0000
Received: from AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca]) by AM9PR04MB8274.eurprd04.prod.outlook.com
 ([fe80::747c:397f:a003:dbca%5]) with mapi id 15.20.5504.015; Fri, 5 Aug 2022
 14:45:53 +0000
From:   Shenwei Wang <shenwei.wang@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com, Shenwei Wang <shenwei.wang@nxp.com>,
        Nicolas Diaz <nicolas.diaz@nxp.com>
Subject: [PATCH v2 1/1] serial: fsl_lpuart: RS485 RTS polariy is inverse
Date:   Fri,  5 Aug 2022 09:45:29 -0500
Message-Id: <20220805144529.604856-1-shenwei.wang@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR19CA0008.namprd19.prod.outlook.com
 (2603:10b6:208:178::21) To AM9PR04MB8274.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e8::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3d39de2-27e8-4cf5-62d9-08da76f13285
X-MS-TrafficTypeDiagnostic: DB8PR04MB6811:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rDed16pkzEBuUos951cFMQGfxaq1W4lUEE3Wj1sq1s7DK2VfMhkS293SxUoeFx3+YFq9Ohg1WmUscCTyl/e2IHxBr0PzF2XDJES88Mx8kxBJEyGWc1hMYBJO4ePHEX3NnOlH+BQVRDi1i7llQlg3PYJwnaTv8kWsTMOXgD8l9J0GwSnwQhliR7Eyx3l3yYAtdh4wlyg0rqxc3niMqm9lFsfvs6pRvTjHMz4M+XAC9bb02Cuh0uhry8Jja7ymvon3pfqQ5N2Y3cT7YxMXMK5tVY1+kHrk93Ma9Aj1fKJjtON6gAFMvhjYIEwNxLeh0chKid/g7jyVQFLYzn9va7EQjAgeRNZFzA+IP2uFI4h9ub1V8dauVP6hHIEw8L2loEa74MQuh04q/dRVCBaCq8eXtobQ0TP+0hiezqzTLS7ZBI9MfvwAxPxn6FwNsBhvfpxeQJUsSauU8vw4FeMBNIjKFAnC/gevzFdwLfRcNEBVmv5eKWbo0yVigJVkQcECIK9qOoYylkqJ1ey3K36WuZGR/1qtH9IC3zcAT7hOZlE9HbU0i0Mk0NZCGTt1+4QMjo1ZETiSWftkMciaQ7effXcosGuwViQMwvoBKIe1kmC3J0+nRLWKukY6MzdB84eb5WpT/pfvAZWcNBmb+LPK/qs+rvGlXUhJQ727P9n0XpESQ4xqlJ1Dd+j3saALZnuJmTBx6Ba/QZYAhMYzH68D0nz/Fz+lQLV8iKfS9j5WbtGohlTpUF4fhR7W9WKKrMOTWLdiH5Q4sJj+HNXmibTyNNELlFdBx96Hruwhq4uZ0JakWabdXgSdPj4GIcJ4ceCLMa+R
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8274.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(366004)(396003)(136003)(376002)(2616005)(44832011)(38100700002)(38350700002)(6486002)(86362001)(478600001)(8676002)(26005)(5660300002)(66556008)(6512007)(66476007)(4326008)(66946007)(1076003)(8936002)(186003)(83380400001)(316002)(36756003)(2906002)(6666004)(55236004)(54906003)(52116002)(6506007)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qx/iWtlWVyLE3li/lssuB5TqF+dLKh0NjmIqByrURHrWgOlVJagrIWuFYlL9?=
 =?us-ascii?Q?j9xyS1aUp41N3VAdj91JelfvS2HGPFOzsFNWlg/a8OO8I8LB4sP+CFC+qmZi?=
 =?us-ascii?Q?f0TYdAE1dnjwZHNIurkSzBZpOkJQCG19RkCXwNoUlD0i44/bieeLPDfS4hgg?=
 =?us-ascii?Q?Fkf4+sprkTIY/aRpZoTGCjqR2gcXqdyZUT5CFiyZ02bMYJRARBqF8xjzVNfa?=
 =?us-ascii?Q?wftlVLi2+rdFXFYYDfhaTKcXdo+Z/4nP/2DLQt1+ysXswVpqXcopVPwR6SzP?=
 =?us-ascii?Q?ThYStitBp9skEX7VAHqIjmy6FCF20ohWKmvCdsvT+aRgv14Gho8wJBt56hoi?=
 =?us-ascii?Q?6++2eM5RhQ/A1KznS3DqphmIxQnmGyRLezaPzzY37EMqbFBbzGve+TGCQE48?=
 =?us-ascii?Q?XfnXLoNt82WP/VlmZoHnjP8hYhCTfZR9R9fWUeswU03coeAWpJs3mpYeM08m?=
 =?us-ascii?Q?981E40TDUTMho5OVDV73z1x0vwsuZjMf3EFdIGsN/Q3OIj2xmVD3QxBOYe+9?=
 =?us-ascii?Q?GVRY9HZclg4ntnStas0nd4AFvK0DjB46tIa2k442k3SPdXCpTZCIp6+k5TVx?=
 =?us-ascii?Q?l3lybAPalKlaORgmP/JWujULeAJzxdTGYxbr1YJT9y/nw7aRzV60MQ7ShfPx?=
 =?us-ascii?Q?Rn4nOFOdeH+ETGZ8lmaUJ2o1uoiFdMPX34yuAnYVXcmVg4IzsxeMjmVj74QW?=
 =?us-ascii?Q?WumaStgZFgW225TVhEhIPWmX5ITZda01jQs4/8t0YS+Rp/1iT5mLX0s+cB0R?=
 =?us-ascii?Q?JRnDgjRL97fl63jn8fHQaOiGC/TZYywa6BkK/R4iM/UvBFW1l+njAevqs0dX?=
 =?us-ascii?Q?qlFFoLgJ0CE45aT74FBXK0wYlOq0Bi20wnvw1J567mustR7UEqQwp1Rax6RI?=
 =?us-ascii?Q?ZTfw8WT8u6C6bpH5pFbFKXkPz47Z9tmcsqETvF0rwieGLOj06BaWAEW9Zvj+?=
 =?us-ascii?Q?zyGfH23D64jdPE95YfxJc0demMqb6yRfICdmptIK+yjzwkVolM3AYTe1W1sg?=
 =?us-ascii?Q?PGwXJXMIP83XRkWLngdjMwPhTCL3XIkORopwP3RJg/RAx1fz6YNk3fqASIIh?=
 =?us-ascii?Q?VLToJscNzNUHtNUXr61tp2qYa5FKf2WuX+HW6e5EODe/4NuDcRtc2steWYU4?=
 =?us-ascii?Q?jBvTvYSMbXQS2/yK+qR0wUHy+fmHB4JJiPCkoyq8HzPa+3t61+Uem5SgRyD1?=
 =?us-ascii?Q?GyTtFPfL9sG4R+oAANBoWvylL7PnO+eYYZPINVcBFzywVES1yMJ965fExyfT?=
 =?us-ascii?Q?MRxmboy1vwQwEX1UP86MES9I6ZkzzLkgH2LZxqbS2Lf07Rv/uP/q+A9cqBo/?=
 =?us-ascii?Q?yNRhHUN+a0cdcNvq+Hn7/+9QH6mfNrQ7/woMkUV7Z7Pyzy60V98dHgWQAX0z?=
 =?us-ascii?Q?dwCNyP+m+yU/z0rmBjF+OUtJEr5KgB430alMVajw/vB4Q1JIOg4zDpUbgG7M?=
 =?us-ascii?Q?5zraYGxvS+35IZ3aGv3JfIYAWheMGAuT4TMV3wsaOoWixRpGXQ1H1p0JCoJe?=
 =?us-ascii?Q?scPOIwYStu8EauYoH+CadzNpzOmKABPT3orTY7nB0MSfrQJdAqhS4ChvVfCt?=
 =?us-ascii?Q?hGcBBB8TOtLaGSuB8uVQJ6kzJP/cma+HEDrmXbKjhbdX2qpPGKCye0RIq++m?=
 =?us-ascii?Q?Gg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3d39de2-27e8-4cf5-62d9-08da76f13285
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8274.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2022 14:45:53.5020
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pGXCj8y96XGIHE7z3pOoGJ4QCVC4p0PBeWqBdjxN7yR+53gmHCA7HRhre9WLoTB8c6v8DwcOkCQcxzhgnv/nhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6811
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The setting of RS485 RTS polarity is inverse in the current driver.

When the property of 'rs485-rts-active-low' is enabled in the dts node,
the RTS signal should be LOW during sending. Otherwise, if there is no
such a property, the RTS should be HIGH during sending.

Fixes: 03895cf41d18 ("tty: serial: fsl_lpuart: Add support for RS-485")

Signed-off-by: Nicolas Diaz <nicolas.diaz@nxp.com>
Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>

---
changes in v2:
- add the fix tag

 drivers/tty/serial/fsl_lpuart.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index afa0f941c862..abc3a3674bc3 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -1394,9 +1394,9 @@ static int lpuart_config_rs485(struct uart_port *port, struct ktermios *termios,
 		 * Note: UART is assumed to be active high.
 		 */
 		if (rs485->flags & SER_RS485_RTS_ON_SEND)
-			modem &= ~UARTMODEM_TXRTSPOL;
-		else if (rs485->flags & SER_RS485_RTS_AFTER_SEND)
 			modem |= UARTMODEM_TXRTSPOL;
+		else if (rs485->flags & SER_RS485_RTS_AFTER_SEND)
+			modem &= ~UARTMODEM_TXRTSPOL;
 	}

 	writeb(modem, sport->port.membase + UARTMODEM);
--
2.25.1

