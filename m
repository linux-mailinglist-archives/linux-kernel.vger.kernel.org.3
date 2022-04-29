Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E1BE5143EC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 10:17:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355540AbiD2ISU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 04:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355493AbiD2ISO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 04:18:14 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2061.outbound.protection.outlook.com [40.107.223.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB836C12FA;
        Fri, 29 Apr 2022 01:14:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXxQ57hpEA0Cv6/9QljVs3qQbHQ9Qg60vSMPOmuozjM4VTIAAnGKN7LvCZ0rNrVepxtd+Dl+7kLi3HHQzuR+9NjaC4DssUOg6N9VZDOaIo/vnQdZV4xUD8uIB2mvHExnIMZyoueB82/fHq6aS36+TyHd4SNFL4AqKRapnYDM11swJvkmRz2KSv/hY6F97HLshL4AXK6hBuwbEvQhYcjsx2IVjBYEVFRD0tOdbwpdPi/uaXmy3013wH0hF+4J85WVnE4V6ogbnI9P7mguXUrIS0Dp655tfT4SiYQMhRIgi8bLOc/jTiUun+YIH/s7aQYKbEFJZ/M8nG/aCqdOEf9bfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ALpDvbk+lwlvTNbAlgghVYW+35HeBUF2Gv9Zh3WfU+Q=;
 b=OKLQTPsugKIawrcLXC7su1O/9IDD4q23TmWeaOmWYbegLDd+JTezhX+MEhsPHSiRjSBMa44XWTV69bhrMqQNj4Eq0ePP/7veOPJbSSaJ0Q9PIVlAtIcMNZP9gJy2CyvfEfTuW/X9tFv4ZJ5qbatNF7E/RJvn2I44uHSIB+EM8Lw8B3gwM9+Ki1f3VpDbvWvGwh4AICN3XT8A1yIVtL1YaucECDiZlmPRRMp8vC7bByeY2/wDEQLoWoaG4eNJkRLNKWrzPdPXA4AlIi/Z0tiBRf4TN2kDofWvAUmDwu79+8MpuZZNR6+bGXmIjmbmK8YCtC3dHd44Megx20X55zyh2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=xilinx.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=xilinx.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ALpDvbk+lwlvTNbAlgghVYW+35HeBUF2Gv9Zh3WfU+Q=;
 b=ZTY49dX8F7rsILprR/bZ2jj3/fTQHKfWqQtsjGMlVof2sSezMKR1TTp7ezXUH0BoBj5aPKGQXXmV4UolCM0Z6COgdhFTMYrSwZVOq48UbhD2HH8ky/zDXt1o0zArqcE2yC3cR2omEKUgyC2h2fBE+oRJ8dqbN910HVcVDf8obks=
Received: from DM6PR07CA0089.namprd07.prod.outlook.com (2603:10b6:5:337::22)
 by PH0PR02MB8859.namprd02.prod.outlook.com (2603:10b6:510:df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.23; Fri, 29 Apr
 2022 08:14:45 +0000
Received: from DM3NAM02FT059.eop-nam02.prod.protection.outlook.com
 (2603:10b6:5:337:cafe::8) by DM6PR07CA0089.outlook.office365.com
 (2603:10b6:5:337::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.15 via Frontend
 Transport; Fri, 29 Apr 2022 08:14:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch02.xlnx.xilinx.com;
Received: from xsj-pvapexch02.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT059.mail.protection.outlook.com (10.13.4.97) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5206.12 via Frontend Transport; Fri, 29 Apr 2022 08:14:44 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Fri, 29 Apr 2022 01:14:44 -0700
Received: from smtp.xilinx.com (172.19.127.96) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Fri, 29 Apr 2022 01:14:44 -0700
Envelope-to: git@xilinx.com,
 linux-serial@vger.kernel.org,
 jirislaby@kernel.org,
 gregkh@linuxfoundation.org,
 linux-kernel@vger.kernel.org
Received: from [10.140.6.39] (port=57162 helo=xhdsgoud40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <shubhrajyoti.datta@xilinx.com>)
        id 1nkLlz-0002va-If; Fri, 29 Apr 2022 01:14:44 -0700
From:   Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
To:     <linux-serial@vger.kernel.org>
CC:     <michal.simek@xilinx.com>, <jirislaby@kernel.org>,
        <gregkh@linuxfoundation.org>, <git@xilinx.com>,
        <linux-kernel@vger.kernel.org>,
        Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
Subject: [PATCH 6/7] serial: uartps: Fix the ignore_status
Date:   Fri, 29 Apr 2022 13:44:21 +0530
Message-ID: <20220429081422.3630070-7-shubhrajyoti.datta@xilinx.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429081422.3630070-1-shubhrajyoti.datta@xilinx.com>
References: <20220429081422.3630070-1-shubhrajyoti.datta@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5b5e8425-caea-4a74-b414-08da29b851d5
X-MS-TrafficTypeDiagnostic: PH0PR02MB8859:EE_
X-Microsoft-Antispam-PRVS: <PH0PR02MB8859CDB6AA31BA66D3F3CE31AAFC9@PH0PR02MB8859.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gJifvjVU9I64qGovgnNNvmpXI/eAukGOklhM73RoW71X90SD4x+TkTZKnBBXGxYyGhbYY2Nadrlf1N/jvJXVWHUzDZ6V/k5n91RVQ3vKACHtulswTmol1BLMxnjCJwaiYZ5qpAr3r0ROmTQ39EzVdpx5PoYV248JhGd6H8WNMiFEvjTckE3Au9Ic4zYU7dr7Jc/Sw2dSoQq6VfGFwjOSjyXny8ZaxgScXXwrfd6/q0/mYo2ecet9wO8uD0H/mIzGEy3bhKVz6G2HmgZ+ID+oZ7R8rNDdAvtu/vS0myz0CTSmSkHZ7+qeyJBOm00TdIRJHHwhlZg4PNsErUlgAqG8d/1q9Dz61hEBYtBbtR8kw/sx1EdQSC9dmanU/6l9z4INaoD/hK9C2X3MZBJiB0kaG6FSPyMKLAm84lVqp4Qf4Df57ncQfi7Q6IVEF43oNNYfVWIN9KhhTdT3wDKmm47Avz9k8KlnIElZqtMBOPzyG37/V5ib94mmEilTMwyClvxDl3UhLQQj+zzGKzRJ375edho1UvlKzeqsEZkeOXxFSxCGvZ2R0zC4h0wtZ1cxBrzVHuLe/xOp/0qw3DvDGa6T5WKRdzsa3GzzuUELDK4oK6plm3gNaieIfD15aGjCE07QwBEvts9Y2vK+cLWBQ1Zpxwvo95IZJrj7DdcyRNR71aLuEIgABMBZTrb2bo1RAmTP0ytCxeZQLKbGSzTvzu2uqA==
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch02.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(40470700004)(36840700001)(46966006)(426003)(1076003)(26005)(6666004)(70586007)(336012)(7696005)(82310400005)(47076005)(316002)(107886003)(186003)(70206006)(40460700003)(44832011)(8676002)(356005)(5660300002)(4326008)(2616005)(508600001)(83380400001)(7636003)(54906003)(2906002)(6916009)(36756003)(8936002)(9786002)(36860700001)(102446001);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 08:14:44.9246
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b5e8425-caea-4a74-b414-08da29b851d5
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch02.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT059.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB8859
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the ignore_status is not considered in the isr.
Also the ignore_status is not updated in the set_termios.

Signed-off-by: Shubhrajyoti Datta <shubhrajyoti.datta@xilinx.com>
---
 drivers/tty/serial/xilinx_uartps.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/tty/serial/xilinx_uartps.c b/drivers/tty/serial/xilinx_uartps.c
index 289d70914956..81ba69c57716 100644
--- a/drivers/tty/serial/xilinx_uartps.c
+++ b/drivers/tty/serial/xilinx_uartps.c
@@ -375,6 +375,8 @@ static irqreturn_t cdns_uart_isr(int irq, void *dev_id)
 		isrstatus &= ~CDNS_UART_IXR_TXEMPTY;
 	}
 
+	isrstatus &= port->read_status_mask;
+	isrstatus &= ~port->ignore_status_mask;
 	/*
 	 * Skip RX processing if RX is disabled as RXEMPTY will never be set
 	 * as read bytes will not be removed from the FIFO.
@@ -1583,6 +1585,8 @@ static int cdns_uart_probe(struct platform_device *pdev)
 	port->dev = &pdev->dev;
 	port->uartclk = clk_get_rate(cdns_uart_data->uartclk);
 	port->private_data = cdns_uart_data;
+	port->read_status_mask = CDNS_UART_IXR_TXEMPTY | CDNS_UART_IXR_RXTRIG |
+			CDNS_UART_IXR_OVERRUN | CDNS_UART_IXR_TOUT;
 	cdns_uart_data->port = port;
 	platform_set_drvdata(pdev, port);
 
-- 
2.25.1

