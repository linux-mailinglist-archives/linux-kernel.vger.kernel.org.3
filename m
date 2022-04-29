Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34EAF5143DC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355507AbiD2ISP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355472AbiD2ISB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:18:01 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam08on2063.outbound.protection.outlook.com [40.107.102.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D48C0E56;
        Fri, 29 Apr 2022 01:14:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bougtOl+wDe5FB0ZZjeAxu2Asn/Edzz6lBdVMR96h4zU6JtaTT3ct3TDjUY4Y9EYVfH5mvM18WzoZgjM1bgm3CIFyOieLDrozFU/ioFao4cH6qN7ysHjaVicpe499eFgWjt5CAMfHStiBuMTbRT5Cn+96mLrCEvV6oLPVj/9K7/ACtnjV8OnGbQSAC8TcW/iP3WcDc+DcnaMsvZ2vs4vgyvVbEQDURaGuoCerMpY4BWNF1oPTepfcxKb1waizOQGIEvEzFiAmEJEHi9D657p05/qfpaJbdCv7Q/Idj4DnTOTtwa0FvDebgk3Wr9bMg/6q0I93/9O6Ke/J53mwYYLTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XNwHL25V79loRQlwOxLQEBNZTDVduKE5XoVza4jmxc8=;
 b=MlEi/+txmRYlTB6UmMRtMCDnVfUzLzAIt0q1iWcnhrHHnAkTOHgIQllKqP7EB9G8lklLRPoDq+KpwFqVnZswTDudqG5d+V/8Taj3DO6mqKCZkDLAoHcUys73YwFwRH6fUvDayPppEbz0nkpP2iQWG4NYmI4snVjOzrzh4J3xy6NRy50lKNOxnC6wYWP6SI+x4LGDZUGIM2tKbZYVTCmywH8lk/ANVQKxbGHXlegi3luhEA/Cq1/WHDkTe0XWJZPPeDT8bsQ9sRoHJdwEQtj3vUKeIMf6YvcGlPZEZk0PTWyrokWxgIDmzA/5s2RMevHalczg6cTIwUol3OYdFe80dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XNwHL25V79loRQlwOxLQEBNZTDVduKE5XoVza4jmxc8=;
 b=GB07mMTUzonJQJZelAAGRBoMkyp9wLWyYxqreLz7fDzQo7WO1/4v5Wd1y+Eic7mWDKNOA8jp3pYG7+oZVMPCTM0vEMcI1MWhIvgsBALrBiZTeWOErzhatj6MDCKZFLU3Xzi5C7TOTU8UR606Yoq6ss5dsbX/5sIvN/SK71f/alA=
Received: from DM6PR07CA0077.namprd07.prod.outlook.com (2603:10b6:5:337::10)
 by BY5PR02MB6115.namprd02.prod.outlook.com (2603:10b6:a03:1b2::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 08:14:40 +0000
Received: from DM3NAM02FT051.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::c1) by DM6PR07CA0077.outlook.office365.com
 (2603:10b6:5:337::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14 via Frontend
 Transport; Fri, 29 Apr 2022 08:14:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT051.mail.protection.outlook.com (10.13.4.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 08:14:40 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 29 Apr 2022 01:14:38 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 29 Apr 2022 01:14:38 -0700
Envelope-to: git@xilinx.com,
 linux-serial@vger.kernel.org,
 jirislaby@kernel.org,
 gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.39] (port=57162 helo=xhdsgoud40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1nkLlu-0002va-3h; Fri, 29 Apr 2022 01:14:38 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-serial@vger.kernel.org>
CC:     <michal.simek@xilinx.com>, <jirislaby@kernel.org>,
        <gregkh@linuxfoundation.org>, <git@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 4/7] tty: xilinx_uartps: Check clk_enable return value
Date:   Fri, 29 Apr 2022 13:44:19 +0530
Message-ID: <20220429081422.3630070-5-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429081422.3630070-1-shubhrajyoti.datta@xilinx.com>
References: <20220429081422.3630070-1-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3ea99b49-20c2-4d2c-d40d-08da29b84f20
X-MS-TrafficTypeDiagnostic: BY5PR02MB6115:EE_
X-Microsoft-Antispam-PRVS: <BY5PR02MB611579A385F87FA5AF9DE48BAAFC9@BY5PR02MB6115.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1okMVk85lnN6QjOA4pfro5+z45i4LlZyDaseeiYU8462+j78DoU/3ku0sPbszdf5esDKrLGH+lutGqmMC2tsAC1ovPd2eTM3Ov6qA/NQAJKY+XwUvos84/JsexRkPjIL/aDvVR9jtZaGphudICecSUgpv9qMPW1SgbqzUkczD18ICitOhWUoXS8hMmS44qt5tVH9rZ02tBqYn4DU2FMeeDtr+BHUZV5wYPpr2DTVVc06qdATStnZfOkHpkEMjRtfWeCseBydohxcv8iXos+hSfvvdi23MucpWD00K9nmd1bgRP3iYYXOsbf7sySMnQElsgEtyMR34Ju/syNSm6908UOe3HKpmlp8nwf28Cg1Mcz/sDsy9btMTqz4GdmeCXZHfgGyB+BtHc0cpQOw6TzO2Ndog9Mz3SDsXD3BtDRJ7jNUGGv5vWGIDpCOBro6prjFeSUEfI5YCMojLPzDXam1cD63ow2xYfJ2UJItj+uUzN9DqXR347RpnmxwM9S7QIuSLt/Joe6lBzci1Z837AnMhjMhy57i2BRneLuhGAEFttIOAihs56gDV8L5wtsDizSGDOSPZKzFxqPXaYpjaeE+gIGSReh5d5+dEQhUUb78Ihy6Eoe98PNr68vbE9fOagrudNjoMlm99D3sX5xkhiWZij7EQJYNxhLBo6EVA8Yl8USijvJRIpu3uqirXaVPvqxKH5jKmodJoyX1PTdHa5XCWQ==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(46966006)(36840700001)(40470700004)(508600001)(336012)(54906003)(316002)(82310400005)(8676002)(7636003)(2616005)(9786002)(47076005)(6916009)(426003)(107886003)(186003)(1076003)(70586007)(70206006)(4326008)(83380400001)(36756003)(40460700003)(44832011)(26005)(356005)(4744005)(2906002)(36860700001)(8936002)(7696005)(6666004)(5660300002)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 08:14:40.3838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea99b49-20c2-4d2c-d40d-08da29b84f20
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT051.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR02MB6115
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Check for the clock enable return value.

Addresses-Coverity: Event check_return.
Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 868f4e587263..bf0415f0a194 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -1347,12 +1347,18 @@ static int cdns_uart_resume(struct device *device)
 	unsigned long flags;
 	u32 ctrl_reg;
 	int may_wake;
+	int ret;
 
 	may_wake = device_may_wakeup(device);
 
 	if (console_suspend_enabled && uart_console(port) && !may_wake) {
-		clk_enable(cdns_uart->pclk);
-		clk_enable(cdns_uart->uartclk);
+		ret = clk_enable(cdns_uart->pclk);
+		if (ret)
+			return ret;
+
+		ret = clk_enable(cdns_uart->uartclk);
+		if (ret)
+			return ret;
 
 		spin_lock_irqsave(&port->lock, flags);
 
-- 
2.25.1

