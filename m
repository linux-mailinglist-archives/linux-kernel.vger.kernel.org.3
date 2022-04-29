Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3685143BD
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355478AbiD2ISD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239059AbiD2IRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:17:55 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764ACC12F2;
        Fri, 29 Apr 2022 01:14:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=awntGVtucMdHkBKHQzVtmjCJAPJv743iN43cQVwWn+uki/5CSW75vTE2xVkzm8fczNnLeCaPyJ6Mth3lT4w3yHIbw4sjhrnVmo0p2KHbFjs4ZAvbLSNgXgtGD1O7BytEjyXxRx+TDpHAtkkZyz2qlfGMzwD8SuIKc/z1TjdZvL4Gg4n6Sob6b+l12AleFmwsGnjze3uVYQwsVacuSHVkbJjJPkO+k161PJ4nrF7pJsNvFL8Mt4/IiBTaj1xM1GzrAvwe6jAQNAo26I+nKMP9v93G4vNgWQzO99toQaITFupIlzT3JnZo+ECl/wczAjn1awS52gNaxuFPHMwex7rBuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VRcFkUezuEC4bQO7oaUQEFHFjhfH8x9QOrJR7mq/2SM=;
 b=CoujQXMa5BkR4iPPuMUHxhrIADMF+B5Q2uDD93dcmyCzu48gJmeppyeQNVbWpjst40taCwYh2t2oeFqCUky64OIOnBi+vcVTg6MAuVhJyGZ17NTMkxLHrwef0wUcGTQyAxul1t5785n1eWTUxYLoTQ7c6Vbh6ruwAt8FyKPSg77J1n0XKLNEd12x9k5qd99b3pGuxwuG9Y85YxsFplnsgEVhOUU8/9sNbZLwUu0RWeHSzpYv2DkumgUrz1oPGeX1uM5DGgu2mXAa9Kbnq1Wv7eNgh5bCLsYsfnayHLbMQ/lXEYpnQ1NttKz7p0Qg3VuaSbLbG7DpEAZjZLNjf5X6CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VRcFkUezuEC4bQO7oaUQEFHFjhfH8x9QOrJR7mq/2SM=;
 b=AgdQ3wZgf8L8X8qLSC1u6eCVZ5rxKmksY5ymn8UDAuLQ6aB5M8TafKQ+1OKzm33SbiQaMN3jd8lLIybKIQu+9sLNEUp9BPA68s04wkYi5VDdu0XJYpJ9ZGU7FGtANu9pqzIs9rbxkLAd2NJk5FvZ3wIPCSC7311DuBm0CERyekQ=
Received: from DS7PR05CA0092.namprd05.prod.outlook.com (2603:10b6:8:56::10) by
 BN6PR02MB2820.namprd02.prod.outlook.com (2603:10b6:404:fa::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.15; Fri, 29 Apr 2022 08:14:37 +0000
Received: from DM3NAM02FT030.eop-nam02.prod.protection.outlook.com
 (2603:10b6:8:56:cafe::7d) by DS7PR05CA0092.outlook.office365.com
 (2603:10b6:8:56::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.6 via Frontend
 Transport; Fri, 29 Apr 2022 08:14:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT030.mail.protection.outlook.com (10.13.4.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 08:14:36 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 29 Apr 2022 01:14:35 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 29 Apr 2022 01:14:35 -0700
Envelope-to: git@xilinx.com,
 linux-serial@vger.kernel.org,
 jirislaby@kernel.org,
 gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.39] (port=57162 helo=xhdsgoud40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1nkLlr-0002va-8O; Fri, 29 Apr 2022 01:14:35 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-serial@vger.kernel.org>
CC:     <michal.simek@xilinx.com>, <jirislaby@kernel.org>,
        <gregkh@linuxfoundation.org>, <git@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 3/7] tty: xilinx_uartps: Add check for runtime_get_sync calls
Date:   Fri, 29 Apr 2022 13:44:18 +0530
Message-ID: <20220429081422.3630070-4-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429081422.3630070-1-shubhrajyoti.datta@xilinx.com>
References: <20220429081422.3630070-1-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d66cefd8-777f-402d-5057-08da29b84d04
X-MS-TrafficTypeDiagnostic: BN6PR02MB2820:EE_
X-Microsoft-Antispam-PRVS: <BN6PR02MB28202816CD19CD3BC36D61A3AAFC9@BN6PR02MB2820.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j3AK1gWLoWQVtOVGmEqLzEUTs9BrwwsKaWgalwcZ2cYu9IRWVVHTlq1Ru+tCfv1aMRWi5AZluLl5UF2yWL0d5IT+YC1k0qbUDSfuYEq9FzHmLoGPjImuGFlMak62Srhuv7SIA0cDIS6SWzP4lQYt6BwLavwQjddRC8EVRkl0s0re+KMGLX49fufqMVVbNsJ2JzJm9KC0BkUfVvA8NyLQpJcnZuKkd0vIVrwMPtVnPBOYvU1uHkKozPur+fd0JqZeIvJABOhKwZ4CP6OE7pg/pYMsSJOh7i2LR54tl4I42FtximF6tvKNrtKOFaMTiTemoahnur5Lo9u6Im86z7dVEmSB7g78cg5/RHuRvN8TPwUIWBvNZl7pyg0yX7Vkc/ECgu7Nex9O/7tucCAx5fzvr6v29TDd4+X15gwUHYtf0kYMSkhCI2L7RQoVvco+rvuMDkPY3eROJ7uidldrTxFwFxraGGVtSGr+VE1c7eZ8/pGSBjqaq0j+iRMZV30IRlSaK2+SD6aO2likJJ9Gfv4HRtrlUchGU8tGVBas1A38iupSWSOpheCpv3Y6WWhNIE22Vut+6qTzWnZq58F7LJUmXyfJsCjU0Abb75j5oG2IxpSYB1ipvGRRz9ESehBDNVufAIv25hWbN5qmTj82Q+w+8EwDlvdUVmuNgk6OVqovg2NBElieA1tY9vdCtRl3cUkyXQ+3AomjWG7k2bNV8cL0yw==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(4744005)(44832011)(54906003)(6916009)(5660300002)(9786002)(36756003)(2906002)(8936002)(356005)(508600001)(316002)(40460700003)(8676002)(70206006)(70586007)(4326008)(7636003)(6666004)(82310400005)(7696005)(83380400001)(36860700001)(26005)(186003)(2616005)(107886003)(1076003)(336012)(47076005)(426003)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 08:14:36.8258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d66cefd8-777f-402d-5057-08da29b84d04
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT030.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2820
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a check for the return value of runtime get_sync calls.

Addresses-Coverity: Event check_return.
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 8f15fe24a0eb..868f4e587263 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1100,13 +1100,17 @@ static void cdns_uart_poll_put_char(struct uart_port *port, unsigned char c)
 static void cdns_uart_pm(struct uart_port *port, unsigned int state,
 		   unsigned int oldstate)
 {
+	int ret;
+
 	switch (state) {
 	case UART_PM_STATE_OFF:
 		pm_runtime_mark_last_busy(port->dev);
 		pm_runtime_put_autosuspend(port->dev);
 		break;
 	default:
-		pm_runtime_get_sync(port->dev);
+		ret = pm_runtime_get_sync(port->dev);
+		if (ret < 0)
+			dev_err(port->dev, "Failed to enable clocks\n");
 		break;
 	}
 }
-- 
2.25.1

