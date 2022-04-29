Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384125143D4
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355523AbiD2ISa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355511AbiD2ISR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:18:17 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2089.outbound.protection.outlook.com [40.107.237.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 348D7C1C93;
        Fri, 29 Apr 2022 01:14:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ixxGVJg7yC9xr85fXtNEHDUplI9e3n0uRk9PTFnToKo42j1+GknT2dlJ3JqrkZ2ASWNG4Uv551ZjQgYmMD2xX1RwY6k8VggIB/ia96U1HfnMqnRK7r9ofruuPz8GAVp3Rwrh+UpPlwioyOBd4VB+UzeyLkFziGSUWMXfrneRZmBFPTYSkAGvq7QpyO+QRlsQ89fZFZGFUpExFjqqWLzQ4cv2UUuY3IdQvTIeabitmfTmPMAyni6dIr9U96TY2pcQOf0Ge6kRo3PGy0ZJubv7AKiHp/xpsxoQKpBVWbX/8g+lbeJQMtksjTnl6nIUZfoDzUT6/LLxMacRQVQpoKAtKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0JR+Ld875QtK7uCHk/VvJELmf4Jh3QYwyk3H6BEAxg=;
 b=eK9Z8V1KsMUx/Yw2GaEX8auedKc8Fb20dPTtdI85Bdb83cwii/jnBABcUn2bl9Kmk1TCRS++49uKbzkghM1n2qpz6lTVKKUpF35VDbrejvcKj6TB997wApKNia7aJJFOauTX/9iApvzW0fxp6RVbMKGdbDx82+YTuSx4wVbHzseeWoWfYBRDtz9LAhrlfdLBjQwlPUVRe5c08ZsSWLrrJXP77KMsgzrp9Zy1uz/wzfl6NjkqKDrUwiLUKZmrPtW9m9OJ4Cu9M8FOVkByBT5EUO6X+IRGhEWt0FYVeyZDB3yhWQVDb4qWoQCL/jxXSJXeXUPPSyeD81KUb32glE2Q9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0JR+Ld875QtK7uCHk/VvJELmf4Jh3QYwyk3H6BEAxg=;
 b=g+nshG7BjJfPItRlthZDjb4BpMnpkMeYHxyvEHjhUQvHmO2J2dReQnkIGRxtwnH9LgCly39l55/Lpw8tyav301j7JR8quOwodxg3RKuqThXrGVN/f5Spb3gikj/ZGe+ishDB2KHGgFQlbvz8Ut9QqfOZImOszIjv6L6KvSjMinI=
Received: from DM6PR06CA0045.namprd06.prod.outlook.com (2603:10b6:5:54::22) by
 DM6PR02MB6587.namprd02.prod.outlook.com (2603:10b6:5:220::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5186.14; Fri, 29 Apr 2022 08:14:49 +0000
Received: from DM3NAM02FT028.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:54:cafe::c5) by DM6PR06CA0045.outlook.office365.com
 (2603:10b6:5:54::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Fri, 29 Apr 2022 08:14:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT028.mail.protection.outlook.com (10.13.4.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 08:14:49 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 29 Apr 2022 01:14:46 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 29 Apr 2022 01:14:46 -0700
Envelope-to: git@xilinx.com,
 linux-serial@vger.kernel.org,
 jirislaby@kernel.org,
 gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.39] (port=57162 helo=xhdsgoud40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1nkLm2-0002va-9f; Fri, 29 Apr 2022 01:14:46 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-serial@vger.kernel.org>
CC:     <michal.simek@xilinx.com>, <jirislaby@kernel.org>,
        <gregkh@linuxfoundation.org>, <git@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 7/7] serial: uartps: Prevent writes when the controller is disabled
Date:   Fri, 29 Apr 2022 13:44:22 +0530
Message-ID: <20220429081422.3630070-8-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429081422.3630070-1-shubhrajyoti.datta@xilinx.com>
References: <20220429081422.3630070-1-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b7fbfb7d-a8f9-4a53-5638-08da29b8546c
X-MS-TrafficTypeDiagnostic: DM6PR02MB6587:EE_
X-Microsoft-Antispam-PRVS: <DM6PR02MB65873CB235EB3D6070F9D550AAFC9@DM6PR02MB6587.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FA4kICjiykfk0aX870u6q2sE+WGXc7GRfg6khnkKH+TVoMMe52ElFKb5ln1ilIPzZHUFIC3pFLF0PRNS5jyiQcLMssTswMmeSDZOHCwbDcIH8TUa57wZPigz3RarVLeXEz+5yaUzBIhIW8RJpzSA53txiINBAroBnx96+v34eZSOj61fG7B/W70+IWwjhnu0OmG11QtrFD6ui7RytqWqZP10ntkiHXwXgE9ivFW5mfAtWpEmPneQYY7MhJsF8VFtL/OnBTjjCxgDd2MxKSOt9Y4oQx13gc9OR+PFgynI6NEE46CoCKaA7Gz4yPlzk+LLQSD5gFzi3Yr1dpJhrbX/fys1UOy6/wyUqNFA3Ytlx/Fz3uh/Yf1JZcf0ETIfTEE96Gv+QArkBKqRQT77BE8YOs2g2UL6513ICzRMAmhVSoVwZQCmFCuFYej6V0zWAtLJDdYPf4vtBKWRzyXj3zCwMS2Oa9UjqOvsqAG1DuwAHDdWf6zTgEmwH/n07MpAZih8YO/63U5aMSmtrrwGmP/sHS9ldNTL8WbqiP+BbD+QwL8kZYx8OxlG3S0+1BTzSaxafo440/pmigPXN9UiklrA8uF0F6b1+kigFF5QKtCVaYRARCzhsT7bdwutyPaWJgvYg3811Fpgu4rXwRWaC1w4Szv5FM7e+Je3HwRwBTDQFZGsMlmTboi9uVR2A17lkNdtmRtq2q8PciOW2l93Uj2c6Q==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(54906003)(82310400005)(6916009)(36860700001)(336012)(83380400001)(316002)(26005)(186003)(7636003)(36756003)(47076005)(426003)(44832011)(1076003)(40460700003)(508600001)(107886003)(8676002)(70206006)(2616005)(6666004)(2906002)(5660300002)(4744005)(4326008)(7696005)(9786002)(8936002)(356005)(70586007)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 08:14:49.2516
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b7fbfb7d-a8f9-4a53-5638-08da29b8546c
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT028.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6587
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prevent writing to the fifo if the controller is disabled.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 81ba69c57716..f629c4ca940f 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1150,6 +1150,13 @@ static struct uart_driver cdns_uart_uart_driver;
  */
 static void cdns_uart_console_putchar(struct uart_port *port, unsigned char ch)
 {
+	unsigned int ctrl_reg;
+
+	ctrl_reg = readl(port->membase + CDNS_UART_CR);
+	while (ctrl_reg & CDNS_UART_CR_TX_DIS) {
+		ctrl_reg = readl(port->membase + CDNS_UART_CR);
+		cpu_relax();
+	}
 	while (readl(port->membase + CDNS_UART_SR) & CDNS_UART_SR_TXFULL)
 		cpu_relax();
 	writel(ch, port->membase + CDNS_UART_FIFO);
-- 
2.25.1

