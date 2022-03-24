Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDEFB4E60D5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 10:06:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349101AbiCXJFw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 05:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242531AbiCXJFv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 05:05:51 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8519D072;
        Thu, 24 Mar 2022 02:04:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h7LNVLR/BXMeER8dymfdddVXpLR64NqL1Rl4iaxgx0YQhOLl42E/jdP+uJnM7zGc7elLy+/WHearR87z8gjUJ9POW7qeBykZ411mGPnkoC8ieReYT6R9kjUuk0dMDpKMVoaIamL6tNmUTISZvKY4uRVWVWUgMGOt2rjywaZllqmye3T1Gb9ga+3vTwOGZ/p3JURpuYg0ra1Ax9hPwlAN8cY7SVBqCNFa2FypqDC0rIF7Yrd7cXBfvUekEmoNCZN3faZGjVItL8sylSWAyqS7EQynVAba8PknK/H1jowSl4i93eFLU/Ny+EUUhi4qe8oggfIACT86Z1q6YpSlxTRJsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SfjNmDwryouSBRBxGUZg+jEjZF6DxcuKkyfy7yqXY+4=;
 b=IeRRAb12c9lAeUv/QVNOJrAT3tNUBQ69evhDRihJ7xM1vE74mx9JfuHlen6lhzeg+H/XP6LTUqn2QVlHsb4821umxrIAXtznpAtWzVmsGfc+jTt6d911fRAzAejqA3YQc63w4VXjO0IsOxgrnwwrjId2vTgmyxBDdkl71xg0Mx6yirc1Oia6ityq8o+KQj2h9fjJZB4PBCWvoiWWrrS2j2ZzDEuRU/9XHYBdoBm9yzLYJyyv/08OTwKuuwEQgxqRpY4ih3q+LtoM7Vtze2h7VCfpJTi2C7KA6FvuuVXUQaig6MQ+X/SaWoHHqmun9lzStFf5Gc/Mx2+Bb0ravy8b1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 12.22.5.234) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SfjNmDwryouSBRBxGUZg+jEjZF6DxcuKkyfy7yqXY+4=;
 b=PBrxGqOpaNZT7g1nZHGrJRonvpYO8gGkgdDsbmVyNMGortLzLvGHgNyqrQx/KMS+ANQk9uRwijM/TO0gIzWAPZdlb2+Ld6FokaevcszpCTZqhMUKWeHc82i0r9BnoDJAEzSoQ07GXGtYGBUPWQNqtdFbf2fEutX5G4XhCtjnYya1lPqGpWhimscmdQNz6Ag1b0xg3ipem/1ubcEZCyEmM82juI3Hub3eit/NRTvlgwAStoCuTAEACXhDmzk8AjPJHXegxqPwcWad5NGRIh8ZYV5qgmzTuAS+HwInLBL7UQwB3RTEsKg2wXVr/ySpnqphocKxme/v1EyhCaA+qTSYrg==
Received: from DM6PR02CA0147.namprd02.prod.outlook.com (2603:10b6:5:332::14)
 by PH0PR12MB5402.namprd12.prod.outlook.com (2603:10b6:510:ef::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Thu, 24 Mar
 2022 09:04:17 +0000
Received: from DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:332:cafe::93) by DM6PR02CA0147.outlook.office365.com
 (2603:10b6:5:332::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17 via Frontend
 Transport; Thu, 24 Mar 2022 09:04:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 12.22.5.234)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 12.22.5.234 as permitted sender) receiver=protection.outlook.com;
 client-ip=12.22.5.234; helo=mail.nvidia.com;
Received: from mail.nvidia.com (12.22.5.234) by
 DM6NAM11FT011.mail.protection.outlook.com (10.13.172.108) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.5102.17 via Frontend Transport; Thu, 24 Mar 2022 09:04:17 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by DRHQMAIL101.nvidia.com
 (10.27.9.10) with Microsoft SMTP Server (TLS) id 15.0.1497.32; Thu, 24 Mar
 2022 09:04:17 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.22; Thu, 24 Mar
 2022 02:04:16 -0700
Received: from kkartik-desktop.nvidia.com (10.127.8.12) by mail.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server id 15.2.986.22 via Frontend
 Transport; Thu, 24 Mar 2022 02:04:13 -0700
From:   Kartik <kkartik@nvidia.com>
To:     <kkartik@nvidia.com>, <ldewangan@nvidia.com>,
        <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>
Subject: [PATCH] serial: tegra: Correct error handling sequence
Date:   Thu, 24 Mar 2022 14:34:04 +0530
Message-ID: <1648112644-16950-1-git-send-email-kkartik@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d8df0955-e2c5-4a94-020b-08da0d7546ea
X-MS-TrafficTypeDiagnostic: PH0PR12MB5402:EE_
X-Microsoft-Antispam-PRVS: <PH0PR12MB540239AFED02B7FE95C3C0DACD199@PH0PR12MB5402.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mUmYpnoy2dPGdG4afOIU8QAcNNjUBi3Z9IeqQKoWnL8EFZHnh6B2b/orV3K6wne4+WSADhcGPyUY8/RTxcDtL0UNauVFAVso8h0fpT58VFQ7Tt+uuWSO+5ueMd7Qa0VlvXMGWQUW/OT7yUMYR4lQkga1r+V/GCV5qcGisRcDfk42jDNG/myRc6SDpfY1iakRQBvNlVLHkMYr9PELasDsjY37NWWDvtj0zAsrwOM70I0ERSqe9xHXfx4OsCnqqzYraIOr0YyqsFap+1YiYfAdYi7acmMO9duZYF+mJMbMWTnCAkxRIbeXAVNGfV4j3Qi5nJ5e4dnGAoaUMv9rvO2Gfw7fRa2kAKXn+k/SXmhWmI5Hw5qMP1+U+Sa5uHv+nIUJ2mXbcIkNYBl0zkW1wGdUGK7ImaYIwb1gZnApWq/CJKbCkxEt3sbZcZq6fKHyaxTZoEe4+NMjxjVeQkQKNlDtw2ckYjK1ahHB0m7Zz37F9AHG0YIAktwq3Id5BVDlSyh19YKmZ3iv5qpaDKjJnOYLh1kAelgnU36S17cHbdCJctYga0x1uaswuRqQjDBBMaaHK8YR02Fa6UgJwpiEuf6SpgnqEfUgaNt5a4B32c/J9g9g0OyFnM0mk0kuCTTOGfNJMRwh5wSLCltuYmNZeF/UcpKebfj6NRUfW8zPt63Q7FRKbsFjde6BR2jZilg6bemihg65bTArHJFM7n0cYRUOfA==
X-Forefront-Antispam-Report: CIP:12.22.5.234;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:mail.nvidia.com;PTR:InfoNoRecords;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(46966006)(40470700004)(47076005)(36860700001)(82310400004)(86362001)(40460700003)(110136005)(316002)(81166007)(356005)(5660300002)(8676002)(2906002)(70206006)(70586007)(36756003)(508600001)(336012)(186003)(26005)(2616005)(426003)(83380400001)(8936002)(7696005)(6666004)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2022 09:04:17.7016
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8df0955-e2c5-4a94-020b-08da0d7546ea
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[12.22.5.234];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT011.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5402
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kartik <kkartik@nvidia.com>

In the current error handling sequence the driver checks for break
error at the end.

By handling the break error first, we can avoid a situation where the
driver keeps processing the errors which can be caused by an unhandled
break error.

Signed-off-by: kartik <kkartik@nvidia.com>
---
 drivers/tty/serial/serial-tegra.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/tty/serial/serial-tegra.c b/drivers/tty/serial/serial-tegra.c
index b6223fa..ba78a02 100644
--- a/drivers/tty/serial/serial-tegra.c
+++ b/drivers/tty/serial/serial-tegra.c
@@ -440,7 +440,19 @@ static char tegra_uart_decode_rx_error(struct tegra_uart_port *tup,
 	char flag = TTY_NORMAL;
 
 	if (unlikely(lsr & TEGRA_UART_LSR_ANY)) {
-		if (lsr & UART_LSR_OE) {
+		if (lsr & UART_LSR_BI) {
+			/*
+			 * Break error
+			 * If FIFO read error without any data, reset Rx FIFO
+			 */
+			if (!(lsr & UART_LSR_DR) && (lsr & UART_LSR_FIFOE))
+				tegra_uart_fifo_reset(tup, UART_FCR_CLEAR_RCVR);
+			if (tup->uport.ignore_status_mask & UART_LSR_BI)
+				return TTY_BREAK;
+			flag = TTY_BREAK;
+			tup->uport.icount.brk++;
+			dev_dbg(tup->uport.dev, "Got Break\n");
+		} else if (lsr & UART_LSR_OE) {
 			/* Overrrun error */
 			flag = TTY_OVERRUN;
 			tup->uport.icount.overrun++;
@@ -454,18 +466,6 @@ static char tegra_uart_decode_rx_error(struct tegra_uart_port *tup,
 			flag = TTY_FRAME;
 			tup->uport.icount.frame++;
 			dev_dbg(tup->uport.dev, "Got frame errors\n");
-		} else if (lsr & UART_LSR_BI) {
-			/*
-			 * Break error
-			 * If FIFO read error without any data, reset Rx FIFO
-			 */
-			if (!(lsr & UART_LSR_DR) && (lsr & UART_LSR_FIFOE))
-				tegra_uart_fifo_reset(tup, UART_FCR_CLEAR_RCVR);
-			if (tup->uport.ignore_status_mask & UART_LSR_BI)
-				return TTY_BREAK;
-			flag = TTY_BREAK;
-			tup->uport.icount.brk++;
-			dev_dbg(tup->uport.dev, "Got Break\n");
 		}
 		uart_insert_char(&tup->uport, lsr, UART_LSR_OE, 0, flag);
 	}
-- 
2.7.4

