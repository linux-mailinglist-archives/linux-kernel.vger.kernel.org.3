Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8D748A7A1
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jan 2022 07:12:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347879AbiAKGMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 01:12:42 -0500
Received: from mail-eopbgr150054.outbound.protection.outlook.com ([40.107.15.54]:19678
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232314AbiAKGMi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 01:12:38 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=daBXWSh3aZ5vo8oAtzSMFoapJbstSJAaRjZbm390bTq/LnS+KhL4XeZ0jPsvs8kKP9qXZS2CVNr3jta5pNZNThlfXF2jjK12ueahowc2ukg2dtCvW0F40Y2I28YyCDpWhpTkPRL9eV4SQJm7UpsKXQXW44yLgSbuVschibA1ocJ1bVmfzJJt1GJjuc1p8LIWfgkampxDhEiidPQ/18xfeRSQ2jimgP8VoOxMiVyCyBS1G4Ln9EfXAWPFkNmbQGSaokjbezDwHsJai+GJg2zFBczTECoY7dkhCl1K06C8IaTghHeAJkdlg2/POvdGTi6Usep7Cfq5/iAmo7bNjbRPRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D+wDqjKBYAjoNSfdde5lAgq1LC6XW/oEeKbMjYzTB6A=;
 b=TZdaJvjYaEIbscqLrjTb/yiWvdYKM5v9bhUiD0mn5OYnkGarhmCBjrJF6XdhawZaV8Oz+/JE40xj9XoVjhROeqNGUtfmwu+6q0dbnG9iMVfqlIWviETnlEO0yScw3dm50mkHysOii9OXFmdt1NPZBkLTHQ2RPFBg2caU/7MA16qGOgT+7d9wIo390gBAGGb6Fuyn53ylrTMC1uhAu6tBSjmYyDKJ1eDxciF23v89EPW5KxGS7xFOavlOj5mOGkfi57QvZy/IgsgvYEIz90dugugOSBNfsiSNAftPsjyaTbrFLMkty/KpFHn/Ec6OsTweXJxwC2u/iauyShaflY5MtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D+wDqjKBYAjoNSfdde5lAgq1LC6XW/oEeKbMjYzTB6A=;
 b=HG4U43LcHSULkAM8BdZB8fJqrEAtZTgAiurrr0DAF/RxYb+Cg/+gVM7OjCIHAWuyfuIuUqZKY2ArcfzeysbbvVpCMI7z5IGN+ox7wEKQS3KNAuYrBW5ZbJ/XC7Sl2/dvvl4ZoBu9gfV05LXsu3MTC0WdEoMx05ikzcbSPWiV0hc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AM5PR0401MB2515.eurprd04.prod.outlook.com (2603:10a6:203:36::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.9; Tue, 11 Jan
 2022 06:12:36 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::903a:e49c:dd60:75f7]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::903a:e49c:dd60:75f7%8]) with mapi id 15.20.4867.012; Tue, 11 Jan 2022
 06:12:36 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH] tty: serial: fsl_lpuart: count tty buffer overruns
Date:   Tue, 11 Jan 2022 14:10:36 +0800
Message-Id: <20220111061036.12638-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0128.apcprd04.prod.outlook.com
 (2603:1096:3:16::12) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 845eb96d-6bcb-4046-305d-08d9d4c95cec
X-MS-TrafficTypeDiagnostic: AM5PR0401MB2515:EE_
X-Microsoft-Antispam-PRVS: <AM5PR0401MB251525843D98E434CAFE4A5692519@AM5PR0401MB2515.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3173;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pGQSR3JIsYGRBy/a5pfGM52DpS1NdVUVd4N8r4POqpsyXNyxmqDnyLLlLd8idMsb13AzLwJH9u18G6eDkXwx+xtKTkK3QlDzXcdYcTpAnkbI6ZrXDz+tBtokBo9NnlGrVds4x9sjk5CVxIM/WzovflQKIQ0ZclTva8YhA/HOF+qwqxRhI0lXh9DVqVR1zIa0nIco//LK4+t5rScpfogaC64oqamddrEu8jXnG3qWzvODRQIz7S4zMVHOoUM8Ajl6npsOf9JK08g2DMTL3WuYDSsTC3t6ri3aKhAO9RGRAHoSPaoBmgStWPHDZqCcaU3OItlVPBBTBs1qJ+da3PDYW8Q2qI6l6Z1G7TBJ2qXWPel+7FolQjnTtGOuG87h9aW5OUtgBy4VUcOeLN6Xb9o6lyms6n5BXvY8OMhTM+bGsmo94m0Uw83MDzfaytW0YDGB0vlz+Q39Xx3fIv8wQUMhE8bp3c9FQ+dn3ZTZIAJrWn+LD8Iar8VWd4wtKDdHi3XqhH+WqLERxbeEn0r/khmWbIKHYVUvYJUKyjfQ5t7uacp9LbHLKmgqyJvR2FVGQi6TlzxzWggiRvsd/BLoxr3fQ7tZgwrk4INL4VtRTjPSbWk0UghEA77pu0vowIf5X8mzb5ykXTM3Vg+MMVdfnRtt9N/z4xxdkD6gALhrbaeiqUMTPISa616x6tykTVlkWfodk2+wxDTLpD3NL3KcDAxKig==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(6512007)(86362001)(38100700002)(38350700002)(2906002)(36756003)(6486002)(4326008)(44832011)(26005)(8676002)(66946007)(508600001)(5660300002)(66556008)(66476007)(2616005)(52116002)(316002)(83380400001)(186003)(8936002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6TaeXF7I7CMK5CxQNmTDFBDb/h8BkzBTC2a963SPfynE4P47nU/sMyUGJp44?=
 =?us-ascii?Q?6tkJMuUwwsV5tRQ/BOt8CRo+pMjMuqfE953++ikyH2txX1Bd43WOhQwKf8N4?=
 =?us-ascii?Q?Wipj/KYHsUbRj7ATTsnY1cbhJJ2AZrf8FaxESkUoC76kan0r+wD53e84g9Fe?=
 =?us-ascii?Q?ajahNfI1K0WSgP0zYLNxbbaclrBXPD8pfkYgEysHWizCJuX81EljsX+NpZHF?=
 =?us-ascii?Q?2rQyq0xnK4rNri+R5eB/i+Oa6KhCvX7OWSKpi8Zrsc1mr3GKoT2l4waOclXO?=
 =?us-ascii?Q?mNsWV+veTvW3bW2aIAdEMwMVOr+eoXdUapm/1y+9zoOQaZrOjFQKLsjbKNA2?=
 =?us-ascii?Q?8zi11VDSIssBuYGWGeaUniH2LUZ3jkNsdl0F6pdQpNLXbGGpcYAKQeXP3Xj4?=
 =?us-ascii?Q?X7mFR/QYNe/lC3/fs47M1kAFXtrPlyhKznmN8gJkO4jRIFwq4MRgKibPvEi2?=
 =?us-ascii?Q?qJKMk/Avwyq47X6emkV1w3Baa6uAOkfJ/xOD28rpsddFtxQ6d/XUhBr6BDlX?=
 =?us-ascii?Q?XCgqKri7ncX1Uh5kj74tyCFf0P9Pq9Osm6kkmYO6GOqUG8MhCgyssDcudoEs?=
 =?us-ascii?Q?M3tsiPWZOej3kigqWo53QKBt+e41K3Bjps8IdIGj7zczZ8PDkKoGDThxge96?=
 =?us-ascii?Q?bvjlOTUau+34hkIDz5xL+677DpkRGLRmLkcuKme6aL3wOmsBhGUthANB6hVF?=
 =?us-ascii?Q?D5hitnNZaMGZOk+fGPLRypPk44x7lZP1SPdG6iiyoMtnBvvpebFoPJ/sON8M?=
 =?us-ascii?Q?ruvbdqkPbrim4p7l57uMr3CgkT0DZND+qS0/Iqf/G85W9Hjr7sLVolqamcBu?=
 =?us-ascii?Q?lFPgSTtaN+aFQoujQ8eyNHHT/oeWfXbEUswPhXBjtJ7pQJUL8DgorvfXiklg?=
 =?us-ascii?Q?WMKcHhxVxZ4p9T7sqflkYu6wWMn1L3LUEmBMz5IvvMQuQq9OJ8D0dwFtXDnv?=
 =?us-ascii?Q?t05ZsjUKV71QN3Zg+e4MXryb7nSwSQROkdNrG0ye+tdng32HoY5c1cn+Vr4P?=
 =?us-ascii?Q?+xw1Uh8AMk2J39XbWpHozrlZUKPTm/2M+o89KfXf8kWtXL6UsVf7J0rAmHWb?=
 =?us-ascii?Q?96za69HQc7tn8IDUmYTUSIPJXFXcu+ywumGzhau2/VanvUfryBEAL0o937Rv?=
 =?us-ascii?Q?xFzZGzj+22XLG4XaFIS+XeqYeDj3nETfyuSPtqFTxwq4V/VO3hOLe9W0S6Zj?=
 =?us-ascii?Q?FaFikEFq1oUneaG+fzTaJFs+6Un70yswe4HoQtSGdA72EkYy/hN5Lqwz+ta6?=
 =?us-ascii?Q?nG/nwGfRXU/kGler599OebrfJbAenWMHiOjfKVWIluc/W7zgT7w2bROOWqoj?=
 =?us-ascii?Q?hpj1ZfOZ1q0/gesZXeYpNrtRl8DHG88qKYiKMzLO8yQ1T1FYcs2bur7C8rgk?=
 =?us-ascii?Q?CDkJf5+9hGcYp7oFSxpHXhEF1jNCbbTbCfJq6DOsrFXJHtjIehgJmOKLgI8s?=
 =?us-ascii?Q?VVkPPCRXD076ecgzi6d9pSXlS7peWTLuIeBmp/8tYnpGgTSTxys3dZ6B3ypm?=
 =?us-ascii?Q?pIvYBQ1eIrGvZv1jT+ncH/EafZmUyQ5n4WD5zSFSwB7SA2c9cSBkXSfgWYn7?=
 =?us-ascii?Q?RC9xCVaGP9f6Vbg4XphKn9mO0s3LUFOL+HTQJYg7kvQQEIVo5vzVJ5P5UPFQ?=
 =?us-ascii?Q?iYLX3lFTwbrYRnBZPrF4rzg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 845eb96d-6bcb-4046-305d-08d9d4c95cec
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2022 06:12:36.3695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VT66KjY8DfHI+XvbO5uBHwWGmdGzwg6cwL1mwelCeVOhupRBWmV6FbJSPA03D0gzakLNqiTQhEHl5oVrg7TonA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0401MB2515
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added support for counting the tty buffer overruns in fsl_lpuart driver
like other uart drivers.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index ce3e26144689..1e6f924d8507 100644
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
@@ -1117,6 +1119,7 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
 	struct circ_buf *ring = &sport->rx_ring;
 	unsigned long flags;
 	int count = 0;
+	unsigned int copied = 0;
 
 	if (lpuart_is_32(sport)) {
 		unsigned long sr = lpuart32_read(&sport->port, UARTSTAT);
@@ -1218,20 +1221,24 @@ static void lpuart_copy_rx_to_tty(struct lpuart_port *sport)
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

