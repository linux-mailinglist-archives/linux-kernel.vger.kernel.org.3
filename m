Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF265143BF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355470AbiD2ISJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355459AbiD2IRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:17:55 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2079.outbound.protection.outlook.com [40.107.93.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03F63C12E9;
        Fri, 29 Apr 2022 01:14:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L8/Q6sFGg+Rx1ZM6KCE/3Ydrfr1blzJPeQnYwQIkUAjMgRml66oN1g3p4tjywiN4GDNVBbcZGMQKbwlkpYpQl3igsoIclDqu9H7DKRRun+u7M2B2Vsypo+8LTlGTHVbfOwlqK2aj4Ej319c8ao1CdOfRkmyq98rh2DGqpwmbUXAIUPKNwHdY/LWA6Np3oNFbLHDBOJ+H1w8dyXILhpTPHK7nFmjYqUBCjd66daeFt4OYhz2jUw67fi/EHrC18h3reYUiRnSJeY7q8Tgd7GrS5gsraQHnxvo/9HpTNQf0hCYJv9vVr07+NjFaj9+qlPk7Tggs1i14j+UNEfEAV7BN8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JwGj3OjMZPH4S1gPm8Fc+/KCvCdYA2jII1Zhg5OjxEA=;
 b=iyNZO8K84X+g+p7OGDyEsfAcXu4c5hrlNoaHk79mameIpVhtlgqFz87NslRBCxssGE9XlZtEk+JeSf47Ektc58MtipXr3yMwDdUQM2E5QgaDy+kpIoSjoSd9KE4WR434hs7mnkFe+2mX4+jMK/2aVFp+YoO2Uqo2APX/uWi8hWU0g3P71rguzwzhJTJMbDLCCf0YSDOx3gPHL1GH6lYh6HAP67OyN9gZXnVLi8fuPUdyQXYr7r4j4hxaN3me2TUTh9VSYE78cLT5RkHAr/okbZX7xPd9/Ls1KA1Ucw9DsXgKKwlgjPl7045tGdwbs+YQf4n/XFHfg+I76FUiAWmVJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JwGj3OjMZPH4S1gPm8Fc+/KCvCdYA2jII1Zhg5OjxEA=;
 b=K27AaHR0vFH277wfTVIk6H8pgJwCTDRdqB3GOUUBby+NM9XEa4Sc4E7fsTma8+OgsIrYD1mVAyKJ8k5cWSLVOrnR1J9ENXc7icyJpKkoyf/Puaio+WJaDc1JIoMYIgwNhf9mvWdEgv0kb1aBJp6GQw5Zw8r9Oje0WKW+QoQ+dIQ=
Received: from SN7PR04CA0103.namprd04.prod.outlook.com (2603:10b6:806:122::18)
 by SA0PR02MB7322.namprd02.prod.outlook.com (2603:10b6:806:e8::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 29 Apr
 2022 08:14:34 +0000
Received: from SN1NAM02FT0064.eop-nam02.prod.protection.outlook.com
 (2603:10b6:806:122:cafe::33) by SN7PR04CA0103.outlook.office365.com
 (2603:10b6:806:122::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13 via Frontend
 Transport; Fri, 29 Apr 2022 08:14:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 SN1NAM02FT0064.mail.protection.outlook.com (10.97.4.66) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 08:14:34 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 29 Apr 2022 01:14:33 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 29 Apr 2022 01:14:33 -0700
Envelope-to: git@xilinx.com,
 linux-serial@vger.kernel.org,
 jirislaby@kernel.org,
 gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.39] (port=57162 helo=xhdsgoud40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1nkLlo-0002va-Ht; Fri, 29 Apr 2022 01:14:32 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-serial@vger.kernel.org>
CC:     <michal.simek@xilinx.com>, <jirislaby@kernel.org>,
        <gregkh@linuxfoundation.org>, <git@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 2/7] tty: xilinx_uartps: Check the clk_enable return value
Date:   Fri, 29 Apr 2022 13:44:17 +0530
Message-ID: <20220429081422.3630070-3-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429081422.3630070-1-shubhrajyoti.datta@xilinx.com>
References: <20220429081422.3630070-1-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c377b3f3-44eb-4d2e-5e27-08da29b84b95
X-MS-TrafficTypeDiagnostic: SA0PR02MB7322:EE_
X-Microsoft-Antispam-PRVS: <SA0PR02MB732265D4AD633D583D1B1892AAFC9@SA0PR02MB7322.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lSJDj4UDPFJre8IBfjl4tlxPZXQVHxEUk/Uav6Lz9rQsnpojDBzfpNwXJ4GtmZKzW2VoYaXuhtgaPodZBt1RPvYisAPaLti+5p9vwb6jVZ0TLWhkErQWGqnGBK23BJLvEwOBY5VxUZOFlaigIShtCw+/UeWszY5tohpX7I8JtARj066LazTBjF2tIdjraUtSy5cv8nr2w4XUmYIVWwPHpLzsRDG7UFhkhZ3V5udQCubJiGQsrBKmKZlCfOskaGEDp58w75Pd/4PFFzDX592YztA+f2UMlHdCX5oQo1DMZ0hKnyoQ0Bxybr5vRfl5tY42HUtj6NUIQrLOu2QZRVz8xohz6SlwjMbv+pPmcDu/+AEfmiGyH7MP+1vkaeY5tNFc3J5hgV4dRWBVh8qZzbtztUXZwUvphDxJNVlt7ec+mWRILl6RLfblKkpffU8If2qiOwoECVRr/Lt0P31tsDpLrwsoulZpMij4d0UyN7IYbauSfOmSrso2yncdkTFH+pqQwcB2XWZsI4Br1TYuTr5bjrKRJHEMCeKOIQqkXdIh2AnV9JlGcy+ykp0YgcxCNxd1k98WUB9Kf5JmFvY/+uGqTmENWgVZEYYBQoOTXW7ml+9jItbHwhdlvjORQvfFjPgNW/xawR/HhFCUFRrNVHLxdgkWJYyMakotVkvionYSZtiyQuxFbq63QKKSOJiZEqqjRrC+V932YRAhJrd7cfL7Fg==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70586007)(4326008)(8676002)(70206006)(44832011)(40460700003)(2616005)(7636003)(26005)(186003)(82310400005)(5660300002)(83380400001)(356005)(2906002)(8936002)(107886003)(7696005)(54906003)(36860700001)(316002)(36756003)(47076005)(1076003)(4744005)(6666004)(6916009)(9786002)(508600001)(426003)(336012)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 08:14:34.4366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c377b3f3-44eb-4d2e-5e27-08da29b84b95
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1NAM02FT0064.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR02MB7322
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check the clk_enable return value.

Addresses-Coverity: Event check_return.
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index fa82f88844a1..8f15fe24a0eb 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1397,9 +1397,17 @@ static int __maybe_unused cdns_runtime_resume(struct device *dev)
 {
 	struct uart_port *port = dev_get_drvdata(dev);
 	struct cdns_uart *cdns_uart = port->private_data;
+	int ret;
+
+	ret = clk_enable(cdns_uart->pclk);
+	if (ret)
+		return ret;
 
-	clk_enable(cdns_uart->pclk);
-	clk_enable(cdns_uart->uartclk);
+	ret = clk_enable(cdns_uart->uartclk);
+	if (ret) {
+		clk_disable(cdns_uart->pclk);
+		return ret;
+	}
 	return 0;
 };
 
-- 
2.25.1

