Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37AFC5219D2
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 15:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244916AbiEJNvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 09:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243494AbiEJNeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 09:34:31 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2065.outbound.protection.outlook.com [40.107.93.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4492167C6;
        Tue, 10 May 2022 06:24:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WAw4CvoAwo1ow7e70E7//snOvR0Bh9/YHaaIkbZz0Pf0SfbHOAanWF0EWg8s+Xw/hk82nXizfDUbY5qT3U9a7t6v/WrJ5soqTR70NkgFWqFXzcl/2NBMdZvCDYFBXVwOaOyTM62MiNLXEUItcV3OE1UNkSME9MFm2R3a2XnSyiAfYn/P86V7bzWr+IdQLISJ1jJWgszghheD9ACmuHcLcuvPbTWlgRmd8FrCzpY+tAFvmz6hAGPUOMzjKQ7jOp9umQ5bU/T1AcyNBrYLMqB2U83rG6hs+CbqIkyqZ7gjXzeoZFQKQD3aeaHa2X1OsJiRBMte3/DHN+OoygwIUUK7XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SbPp/G0z9eckZCBY7k+NTTa5p8w0ttTFmEIj6pZG17s=;
 b=EnhlzWSzCKxgZA6dFJgXBJfZQi+8P8LNhxND8AcMVF+eu2uZDIge4YbGm/FBZ6qBDbUNm6+8A5M1QbaGE6L09pSbEf2UMQDMNkm96J84RPnwWKOdjm+IQ6g0WO62WQu/pkOj0PrTy2E4HJ3CtmI5K2SkboEeVzW9jdq5fJW5vLgRiQlLOo7abmJQslCrkpT2EmgrkMbd5hc0g6sfSVV2DFxOxmPIpXdzUjKOD68hekpGMI9fkGHwWOVOeqSlSA6a03Q/TnjYOMDz8pi2twHtH/VwjvOv+b4qWjZLYYgNYQ66nCP8O3WoHYZb18ILkVYRqMbTEbnc8HhzBMN8BIDV9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 149.199.62.198) smtp.rcpttodomain=rowland.harvard.edu
 smtp.mailfrom=xilinx.com; dmarc=pass (p=none sp=none pct=100) action=none
 header.from=xilinx.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SbPp/G0z9eckZCBY7k+NTTa5p8w0ttTFmEIj6pZG17s=;
 b=TOOprcRtyPzNT1CfhV6hCQKXh7GHneDof0gex7D9U3UDcJTL3yH9Xw7GIyzNId+ClBVttFnyd9HT+xHJpXw8yQgb6IR1bRGuacdzGpNSjMpgPOvlPRN/Io7mGSVmbUiKyxP0LVERo50VqvPLfE0k+5SFqGda5ggGuu+KCTsWWMQ=
Received: from DS7PR03CA0346.namprd03.prod.outlook.com (2603:10b6:8:55::9) by
 SN4PR0201MB3581.namprd02.prod.outlook.com (2603:10b6:803:4b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Tue, 10 May
 2022 13:24:27 +0000
Received: from DM3NAM02FT057.eop-nam02.prod.protection.outlook.com
 (2603:10b6:8:55:cafe::7e) by DS7PR03CA0346.outlook.office365.com
 (2603:10b6:8:55::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21 via Frontend
 Transport; Tue, 10 May 2022 13:24:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 149.199.62.198)
 smtp.mailfrom=xilinx.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=xilinx.com;
Received-SPF: Pass (protection.outlook.com: domain of xilinx.com designates
 149.199.62.198 as permitted sender) receiver=protection.outlook.com;
 client-ip=149.199.62.198; helo=xsj-pvapexch01.xlnx.xilinx.com;
Received: from xsj-pvapexch01.xlnx.xilinx.com (149.199.62.198) by
 DM3NAM02FT057.mail.protection.outlook.com (10.13.5.64) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5227.15 via Frontend Transport; Tue, 10 May 2022 13:24:27 +0000
Received: from xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) by
 xsj-pvapexch01.xlnx.xilinx.com (172.19.86.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 10 May 2022 06:24:26 -0700
Received: from smtp.xilinx.com (172.19.127.95) by
 xsj-pvapexch02.xlnx.xilinx.com (172.19.86.41) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 10 May 2022 06:24:26 -0700
Envelope-to: git@xilinx.com,
 stern@rowland.harvard.edu,
 gregkh@linuxfoundation.org,
 linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
Received: from [10.140.6.18] (port=52642 helo=xhdlakshmis40.xilinx.com)
        by smtp.xilinx.com with esmtp (Exim 4.90)
        (envelope-from <piyush.mehta@xilinx.com>)
        id 1noPqj-0003Ws-H8; Tue, 10 May 2022 06:24:25 -0700
From:   Piyush Mehta <piyush.mehta@xilinx.com>
To:     <stern@rowland.harvard.edu>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-usb@vger.kernel.org>, <git@xilinx.com>,
        <sivadur@xilinx.com>, Piyush Mehta <piyush.mehta@xilinx.com>
Subject: [PATCH] usb: host: ehci-xilinx: Fix quoted string split across lines
Date:   Tue, 10 May 2022 18:52:52 +0530
Message-ID: <20220510132252.26001-1-piyush.mehta@xilinx.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 18ba1155-f05e-4c7d-7331-08da32886832
X-MS-TrafficTypeDiagnostic: SN4PR0201MB3581:EE_
X-Microsoft-Antispam-PRVS: <SN4PR0201MB3581A3E3EE16175B7CEC20E4D4C99@SN4PR0201MB3581.namprd02.prod.outlook.com>
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0WYcNUgNskVNPOVphpDGIF9x5lsyZnu7d6WIeqWLJ0klCu9iPzOXDIYbMTCIrZqgvynpmeWd+4YAnVScm9bJdKE3tlMqhJzmLjaUr6PxKofC0/trjbk9qAqDG4S9urppECIYUW2Tzx1FgnDmb1bs2tRI07TmRAY9B5n71SiX0RycSwnMhnb1UklLOWjwqX1YMtOLuRagj0fFU99hAli6MjZ8ge/CYrUxsiXXriHQ16fs+j1OtONXzCtzYT39vAtOUrB0jOxyC7G+2cd9RvzL5P1gEVnBa+FaX7vSt2w3hxhXAWq8IaQ6sce9RQyquRPvTPfllScrt/fGqrweBpZkO9ozuImRK3OgnGxIoArAMPJlmy9Uj6nAA417uPjas/5t/jZabr4YhcXeKnharOqTO4LHtiDIth2dB1KoyrEMNUXecxOmVPACLKGnx2DmSjN2ydGZZsVG101R3Tl71dbIjoZgdBr+m8KYegGICY4iR5rkFQWXFX826/wtDQKcPgtCJgkOFuKLLLtq4SZyRk3WAlYQwpnMIMsyCG0llxuN45SQX0YNnpdCL2Qha7MN8VN77yRrdOoUnMdSdeUF6P366h2h8ZrkEQCuTrcsQGYv7AFHCTqxqOoLW7Tz5l14XhRP4ZqJFcbsAAeHSbaiYMrp06LDNdIHAP6X+Ds11/1WEvfWCZ9mIYeLKHUptjp2taZGC41S+Ov7vK+5xuNfYRuNyMNKlALYn9l5VkVQN4CUfvc=
X-Forefront-Antispam-Report: CIP:149.199.62.198;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:xsj-pvapexch01.xlnx.xilinx.com;PTR:unknown-62-198.xilinx.com;CAT:NONE;SFS:(13230001)(4636009)(36840700001)(40470700004)(46966006)(70586007)(4326008)(83380400001)(107886003)(8676002)(70206006)(40460700003)(5660300002)(26005)(44832011)(2906002)(356005)(2616005)(508600001)(36860700001)(9786002)(6666004)(8936002)(186003)(110136005)(47076005)(36756003)(54906003)(336012)(7696005)(82310400005)(426003)(7636003)(1076003)(316002)(102446001)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 13:24:27.0486
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18ba1155-f05e-4c7d-7331-08da32886832
X-MS-Exchange-CrossTenant-Id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=657af505-d5df-48d0-8300-c31994686c5c;Ip=[149.199.62.198];Helo=[xsj-pvapexch01.xlnx.xilinx.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3NAM02FT057.eop-nam02.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0201MB3581
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch resolves checkpatch warnings for xilinx EHCI driver.

Addressed warnings:

WARNING: quoted string split across lines
50: FILE: drivers/usb/host/ehci-xilinx-of.c:50:
+			"The USB host controller does not support full speed "
+			"nor low speed devices\n");

WARNING: quoted string split across lines
53: FILE: drivers/usb/host/ehci-xilinx-of.c:53:
+			"You can reconfigure the host controller to have "
+			"full speed support\n");

Signed-off-by: Piyush Mehta <piyush.mehta@xilinx.com>
---
 drivers/usb/host/ehci-xilinx-of.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/host/ehci-xilinx-of.c b/drivers/usb/host/ehci-xilinx-of.c
index 67a6ee8..13386c9 100644
--- a/drivers/usb/host/ehci-xilinx-of.c
+++ b/drivers/usb/host/ehci-xilinx-of.c
@@ -46,11 +46,9 @@ static int ehci_xilinx_port_handed_over(struct usb_hcd *hcd, int portnum)
 		dev_warn(hcd->self.controller,
 			"Maybe your device is not a high speed device?\n");
 		dev_warn(hcd->self.controller,
-			"The USB host controller does not support full speed "
-			"nor low speed devices\n");
+			"The USB host controller does not support full speed nor low speed devices\n");
 		dev_warn(hcd->self.controller,
-			"You can reconfigure the host controller to have "
-			"full speed support\n");
+			"You can reconfigure the host controller to have full speed support\n");
 	}
 
 	return 0;
-- 
2.7.4

