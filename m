Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC284E2535
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 12:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346388AbiCUL00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 07:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238787AbiCUL0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 07:26:23 -0400
Received: from EUR03-VE1-obe.outbound.protection.outlook.com (mail-eopbgr50049.outbound.protection.outlook.com [40.107.5.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69CA62D1C8;
        Mon, 21 Mar 2022 04:24:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hn0XP0UhfcgNMbb5nGVYD4vxzVr9fCMgDqtRWeIRZ6HiARG02wNdMhzT8+VCssMnVCdsSqNU35uQeN3OR+apSUzhvJ4l2ceC9AyoDyK+PYNMeXLpojK7r2b9Zf+x10UsgQmwsHSLzKQNJhVUzle6r+HvxzNfbCpzJKavd0coHKM3sONKNLdGTGR7SXvflNQPJ1geEPdFtaHwflZs9LDGQ+0Z8kzo7bAikUrEu7Mqm/hz7QjTXv0//nfosclaC8h/Ocv9zvxl71b5JFXqcTCfZYxa888do48h8BJRuAyVt0S1NEviPdGljK5BjqsJ3HXZBLijHRRcxAz46+24yFQ5ig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MsDCulQpcD9m/DjdIMrWLb4wVyFFnpMan6I3dPox3VE=;
 b=NcCeyJBKKJgk9KGwy4JkZsn/palIjWA95Wif7KUmupynnXSb+pknOxuYkxdpHiXwaikKFHoArSi3I6MX8SmN5s3zXeP4Cedcx2YJiIxvQgTMp2cmDq/JsYqWBdmMPhneEZjsKfJAqzKrcULWCAsNrtSPBR3STj49zJhFA6e3wbRp5HY8SX7lJNv8wDY7kuc50SkyZZQjmzhEe5cX1a/D10bzuO8LLOjnX/GtyjBJj4JZ6XkGFAPzPLsKYM+gFi7IJeZ/09Lp2Bj4fJRRWnFMs0lyhhu5XEOqrxssxtg5n9bSGfppIQR7DcLZDBbCO38esVyIt2MKbGBF2FuRjEjDTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsDCulQpcD9m/DjdIMrWLb4wVyFFnpMan6I3dPox3VE=;
 b=LrF4lwrsSlRf1ngbjabLlqtjzgu5rTO/7vemow2YYZNgU8l7hxeyU39PTIEEDsGUyTHUMRB6Wmtyp5UbxivvZQbkWRq4lgKV+HHOdfhhIkMnlCENE5+VzstEAeQVTKOq1MT+Ydfo7C0F9hIs9tJLamOTJcCSlPcBNny4zpIhV4c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com (2603:10a6:20b:3f8::7)
 by AS8PR04MB8514.eurprd04.prod.outlook.com (2603:10a6:20b:341::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5081.22; Mon, 21 Mar
 2022 11:24:56 +0000
Received: from AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::6972:1f59:5d1c:e557]) by AS8PR04MB8404.eurprd04.prod.outlook.com
 ([fe80::6972:1f59:5d1c:e557%5]) with mapi id 15.20.5081.022; Mon, 21 Mar 2022
 11:24:56 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        vabhav.sharma@nxp.com
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-imx@nxp.com
Subject: [PATCH] tty: serial: fsl_lpuart: fix potential bug when using both of_alias_get_id and ida_simple_get
Date:   Mon, 21 Mar 2022 19:22:11 +0800
Message-Id: <20220321112211.8895-1-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0043.apcprd01.prod.exchangelabs.com
 (2603:1096:4:193::12) To AS8PR04MB8404.eurprd04.prod.outlook.com
 (2603:10a6:20b:3f8::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5f5c4db7-29fc-465a-d8dd-08da0b2d6d2d
X-MS-TrafficTypeDiagnostic: AS8PR04MB8514:EE_
X-Microsoft-Antispam-PRVS: <AS8PR04MB8514E51279F0984FE0B2EFF492169@AS8PR04MB8514.eurprd04.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EpDwiyD2wnvNpBrCk0eK6V3HiEo16lu5jk/TXeXDqwluFEcWLEt/uTNBmmm/O16xgZKPJUABTjoJJ9m2GyEgVX7grpIhzXisfPBYwvIO+CgI9VShb5odwY1T8XjbCgEfyo7L8jk9MAmD6V/AS5u6M+7FLtMbCOwNnhTH0CIoe0Aj/bhi2QBNbsfk2uom3puY3r9ZjOYdAPVr22/vXzvgzYbsvBfelOBaJFtpmZnt5uqUBMnrTkBUSN8tqmJap/j1WVnOvcBrvSL3zFYBLztLBSYchlErzQMNJktZS+1hYWu7voanUxHbFUi0aIR0yX6NhRxOQPicy+0OJGWf/zLMHezJzHfmp+BlYbmZJOsblXc6dZjRjDVUEXYqicNlsgOFkIYQKD1WpsXXI4YAEhDkKGyi2j9nvV0XQBZeOD8wRUXLk/Obr/SzsMzOb98VQKbKPIcprtHKhDp0Jm5qlAtI8+Ytws6j3XD7Zs/KxNo5t3VqhT0WarD5M0ea8kj7cGAybEhu+/tp3YhrIxDenpSp8Kd48i5bf3eGYwWi0Z7l+c9dqI6bQSxvrZKvxZoulU/pRlDIP0YLoroK72A8krKZRJXftNzC/PU02ORZRNQf8w1vfI5r8BRERmlTutDwg600H+ag6IDqN4Dq3F27okPdJ5qjBIt/YUOzsISDLvLRs8ARVii08r4P9Bc2h6okZMeo0hv7k4ZNvQqQj/aqwxZkqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8404.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(186003)(26005)(44832011)(83380400001)(52116002)(316002)(6506007)(6636002)(5660300002)(38350700002)(6512007)(2906002)(36756003)(66946007)(2616005)(4326008)(8676002)(66476007)(66556008)(38100700002)(6666004)(8936002)(508600001)(1076003)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WD4H9/whvbA304O0M9lUAJ6m9CEibETWvJGPdWSAIoDkVmXQyjg6OJkIDvAH?=
 =?us-ascii?Q?Xz7Z3q+cJ3C5tkfFJ7F1IoAxsksyxPNmDs+yw6vu2uyvZlCGyXWSnM+p5n/4?=
 =?us-ascii?Q?HNaztMu7selc8/YF5YL+bUmQAsfk5jpeLugRJeqFdlyLWDQdA944/VHEFT8O?=
 =?us-ascii?Q?g84nkFJ+N1Ud9DluJsPK9IvWGpjcCmnLXCkbYMw25CMqJXfoJt3FfrgUUvDB?=
 =?us-ascii?Q?UW9+nQf1lyj7TqrX/OS272YAjg6ca0Z4V9yD/W8nNnjbeS8M5ApcR3oA6MYX?=
 =?us-ascii?Q?gImzBrHG10qGCTnhiqRsGrKJrYJHlgHXMI3q24/B0gWByLk7tozrB59PXWy7?=
 =?us-ascii?Q?O/V8SWZf2K2Ieg1Pd+nYQrY39HfuVH78HLV3+oygvvMrg9wprnR6BK/XD2/s?=
 =?us-ascii?Q?dPbhCWh47lq7bn5eAgEfoJr7158aKxAlMJyKP7FY6FK86bVQvElYNaLETCls?=
 =?us-ascii?Q?rQIaqVoROs9rNBOwumsH2wpGskDoABPpdqqkkvxKVCw2y0En5o5EmE/A/nTH?=
 =?us-ascii?Q?KK01kWQq5AoSJtZBoTFnc1wsjV4KbCvM4rVOMEfxrnA2N6ygv36UHQMapjdF?=
 =?us-ascii?Q?m91eBXKKnescdjEM7QNi1j2ZKGcXO5o1MVJCafOR7EOCeTY38+SuMBCVcnWs?=
 =?us-ascii?Q?jI6xTjMNBDo1ZuQcVMHJmrrkoijGQU7/xWBX50npfx2fyy8O3MhIcP4kUsHg?=
 =?us-ascii?Q?9dWpZrYN7yQJ59fAliOgow8HblbjHRizCpfXVMm8s/AQWsLMMMlNN6pugN03?=
 =?us-ascii?Q?Zk7KOgRwNlb1IZy83pFDgFA+lQ1y61yd56imNWJIZE706H16dlhFKf6nItI/?=
 =?us-ascii?Q?VKcKRBxOBtqe5Kv1ICD0R3gRUFNae7U6KXx2lm2Njk+vXyl+58r3JRs3MMCX?=
 =?us-ascii?Q?0Z8oTecSsVnpIv0ZHUWKmDFW7zFbELC6LtIYtwf7JzQcKkeQfeM90HvP82TB?=
 =?us-ascii?Q?TC6JH/bS2KbdJ3Z4NEikaDFxz/OthO3W02dy1hZxqr6JXEuhvjiMAPiunbDk?=
 =?us-ascii?Q?WCIn30uakBRJ69lXAdwrAfdLDcpWCaL6bXBt5OJisr2vWLDdR53+jVIhp8ga?=
 =?us-ascii?Q?U91hlNdHVh2xQqPFWAHVtO1XZLnxBkPLaeeXQcyaeyl+9RfgypZ0hO4t5PG3?=
 =?us-ascii?Q?AAXVovmKdxGzf8LY32j3Evs500QzmF5lXtQ3a0ohSkqjC026V5wkyW8yPGsR?=
 =?us-ascii?Q?32o6vFMnaY9r3teZ4Ogmt7Ioc98nG7VBbrljU/SAc2KWXugsQ7sRPaIxxgMk?=
 =?us-ascii?Q?bVgGFKpmwh9WhLZwDDKheBgtyOhcuvmxaKDlx77zCYfCZ67Qu4m7vSyTEiUm?=
 =?us-ascii?Q?u92NYV6FkMQXkx+120c+vluTnltdX8oXqeUL4I6HRihtaNQ1moJ+7uu83w77?=
 =?us-ascii?Q?rOvN9lduV1Cg86bUPGqcB0eA1Ig4B8zVIt7lT70wBJ8fcqlQeVlIfhr09VFF?=
 =?us-ascii?Q?Jaim4rG7XKW0NZJ8NFrjhwxqwRA6zTRJ?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f5c4db7-29fc-465a-d8dd-08da0b2d6d2d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8404.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Mar 2022 11:24:56.1689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kXmxxXNPbd4R4zeZbbhCnhAEcL+QMxQRHqeVdBH6sgczG+n2KDr2mFYR7FVwHClgtAIvUuHy3I/LgHuCZkSoiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8514
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now fsl_lpuart driver use both of_alias_get_id() and ida_simple_get() in
.probe(), which has the potential bug. For example, when remove the
lpuart7 alias in dts, of_alias_get_id() will return error, then call
ida_simple_get() to allocate the id 0 for lpuart7, this may confilct
with the lpuart4 which has alias 0.

    aliases {
	...
        serial0 = &lpuart4;
        serial1 = &lpuart5;
        serial2 = &lpuart6;
        serial3 = &lpuart7;
    }

So remove the ida_simple_get() in .probe(), return an error directly
when calling of_alias_get_id() fails, which is consistent with other
uart drivers behavior.

Fixes: 3bc3206e1c0f ("serial: fsl_lpuart: Remove the alias node dependence")
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/tty/serial/fsl_lpuart.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/tty/serial/fsl_lpuart.c b/drivers/tty/serial/fsl_lpuart.c
index 452a015825ba..40465d23d7ad 100644
--- a/drivers/tty/serial/fsl_lpuart.c
+++ b/drivers/tty/serial/fsl_lpuart.c
@@ -239,8 +239,6 @@
 /* IMX lpuart has four extra unused regs located at the beginning */
 #define IMX_REG_OFF	0x10
 
-static DEFINE_IDA(fsl_lpuart_ida);
-
 enum lpuart_type {
 	VF610_LPUART,
 	LS1021A_LPUART,
@@ -276,7 +274,6 @@ struct lpuart_port {
 	int			rx_dma_rng_buf_len;
 	unsigned int		dma_tx_nents;
 	wait_queue_head_t	dma_wait;
-	bool			id_allocated;
 };
 
 struct lpuart_soc_data {
@@ -2716,23 +2713,18 @@ static int lpuart_probe(struct platform_device *pdev)
 
 	ret = of_alias_get_id(np, "serial");
 	if (ret < 0) {
-		ret = ida_simple_get(&fsl_lpuart_ida, 0, UART_NR, GFP_KERNEL);
-		if (ret < 0) {
-			dev_err(&pdev->dev, "port line is full, add device failed\n");
-			return ret;
-		}
-		sport->id_allocated = true;
+		dev_err(&pdev->dev, "failed to get alias id, errno %d\n", ret);
+		return ret;
 	}
 	if (ret >= ARRAY_SIZE(lpuart_ports)) {
 		dev_err(&pdev->dev, "serial%d out of range\n", ret);
-		ret = -EINVAL;
-		goto failed_out_of_range;
+		return -EINVAL;
 	}
 	sport->port.line = ret;
 
 	ret = lpuart_enable_clks(sport);
 	if (ret)
-		goto failed_clock_enable;
+		return ret;
 	sport->port.uartclk = lpuart_get_baud_clk_rate(sport);
 
 	lpuart_ports[sport->port.line] = sport;
@@ -2781,10 +2773,6 @@ static int lpuart_probe(struct platform_device *pdev)
 failed_attach_port:
 failed_irq_request:
 	lpuart_disable_clks(sport);
-failed_clock_enable:
-failed_out_of_range:
-	if (sport->id_allocated)
-		ida_simple_remove(&fsl_lpuart_ida, sport->port.line);
 	return ret;
 }
 
@@ -2794,9 +2782,6 @@ static int lpuart_remove(struct platform_device *pdev)
 
 	uart_remove_one_port(&lpuart_reg, &sport->port);
 
-	if (sport->id_allocated)
-		ida_simple_remove(&fsl_lpuart_ida, sport->port.line);
-
 	lpuart_disable_clks(sport);
 
 	if (sport->dma_tx_chan)
@@ -2926,7 +2911,6 @@ static int __init lpuart_serial_init(void)
 
 static void __exit lpuart_serial_exit(void)
 {
-	ida_destroy(&fsl_lpuart_ida);
 	platform_driver_unregister(&lpuart_driver);
 	uart_unregister_driver(&lpuart_reg);
 }
-- 
2.17.1

