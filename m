Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1008759F307
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 07:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbiHXFRM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 01:17:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiHXFRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 01:17:10 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB297B296;
        Tue, 23 Aug 2022 22:17:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D+zOScKM+2XM9E0JfbtLBqi4QCXsWD+ek/gojGtn/e9dVX9gE/eLths5tJ8PzjygPTDf+Qjk7IryJ4Leox79XwNhHcAQXokGhp4wwgkHauJlSUHMVGLE5I27tiO2mN3IZL38y4hUmckKHQB3lXeAnWplECwfShDyRJ1oLFJqfCvlIIxOVR0kWCy/3EpsJmARWZaDjbrVWnTsn3c0fAO9pTnm76jlKDPWSmUT637xHnqRzn21av5yoN+6duvJayk/FNuwFizVAYwh3Gp4+flRclZxyB6a6ue2kD+V+sI9uh8qMhp6RwymAMs/Jo/9x4Be5FPUdcJ9nrcw23zQR3RMKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D2IYhy9T2UFhlySoCYYy1o7Jn+nnj0zRuxwFc3o/A8M=;
 b=ZHoD4FnR8RqN9xRtI+2YhBmaZHOb+FqlOP9sMbP1o60I0cl5OWaumDUUHGHZkvWBgGEjJOZXTx5u4C7Hz0QFuUH2d5Cgy2jT3aHdFjbk0P+QL1RRWeeJ+StEfC6qYALowZAaS5QTlvlbVFtMzB95qbEJDI/RxvnnLJmoob0jGjg6DiAY6EGR64ZFhHhoAuTE6C6lAk2Ibgs3cQGrjG/X2dz6mPjogJEGIm8+bNt++2pF0Tx+nFB7dX+bpoJ0d1jiuFBNnt5Lbs4uMIh/kicjM8J6Fv6KEzN444VwScSaRr0xRvAs4NMgUbACsylI+16m94CPtg3dSIs6mHOgY98wZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D2IYhy9T2UFhlySoCYYy1o7Jn+nnj0zRuxwFc3o/A8M=;
 b=Hge27uy73ASFpJjE251QOdNpaZEEl5Bw25iDETe984Mcv8HDuJqpV3/xjs5t4OljnA1qCWXkAJrqdw7cOTX8KB4w/XN8Oi9/Y3u/pNUe6c2gl8aqxmXH8oGmqrokXSOpbVD0RECD1L6LAgcv4nW7inmfTTF7Zq1HBHeFSGy4qdY=
Received: from DS7PR03CA0224.namprd03.prod.outlook.com (2603:10b6:5:3ba::19)
 by DM6PR12MB2890.namprd12.prod.outlook.com (2603:10b6:5:15e::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.22; Wed, 24 Aug
 2022 05:17:02 +0000
Received: from DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
 (2603:10b6:5:3ba:cafe::e5) by DS7PR03CA0224.outlook.office365.com
 (2603:10b6:5:3ba::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.18 via Frontend
 Transport; Wed, 24 Aug 2022 05:17:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DM6NAM11FT093.mail.protection.outlook.com (10.13.172.235) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.5566.15 via Frontend Transport; Wed, 24 Aug 2022 05:17:02 +0000
Received: from SATLEXMB07.amd.com (10.181.41.45) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Wed, 24 Aug
 2022 00:17:01 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB07.amd.com
 (10.181.41.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.28; Tue, 23 Aug
 2022 22:17:01 -0700
Received: from xhdnavam40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.28 via Frontend
 Transport; Wed, 24 Aug 2022 00:16:56 -0500
From:   Piyush Mehta <piyush.mehta@amd.com>
To:     <balbi@kernel.org>, <gregkh@linuxfoundation.org>,
        <michal.simek@xilinx.com>, <michal.simek@amd.com>,
        <shubhrajyoti.datta@xilinx.com>, <lee.jones@linaro.org>,
        <christophe.jaillet@wanadoo.fr>, <szymon.heidrich@gmail.com>,
        <jakobkoschel@gmail.com>, <linux-usb@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <git@amd.com>, <siva.durga.prasad.paladugu@amd.com>,
        Piyush Mehta <piyush.mehta@amd.com>
Subject: [PATCH] usb: gadget: udc-xilinx: replace memcpy with memcpy_toio
Date:   Wed, 24 Aug 2022 10:46:36 +0530
Message-ID: <20220824051636.1109962-1-piyush.mehta@amd.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1405337b-4a45-4cdd-5539-08da858fe0e6
X-MS-TrafficTypeDiagnostic: DM6PR12MB2890:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hqKcvXnwRXOsovtTFP9J67HAsYSjIfkSTARHPFFQx1WywRyIAO8Y26rou2E8nLiqkul8PnsUl8sUPhQ7xBNkyUYBXXwi3rriOpzXLdJesIfD8hodWp+xsHg6P9bb096SaZw2g6oNF57JOfZ33/LGJJNBy0fzuVKkY3nwXVvQS4ILB4qKzKmcL38o2f04wVZDC0Fjxnh+zjxu6SdgGnKMtqRkg4t1hhkn7LnFreXrf6hS05w8cm11vIK3kxaNHdxnZXKDKKc3pbdf3EZ7Hfsn/BPp+++3p7k4Co68oHf837ECGXfsU+EROB0guc5x3VkwmVFYVKlZ4/EJggTD/bJFuri0tdpcb/Qn+WbqrCWTERM1PGqhUjYVRkSijGimmHwSfKyVZ4ORdQZ/D/3OjKwQXKhq+mWo6olWZAtJHxuADSQJ4al+9BNV42w57qQMihsb7798nyRkzOi+Q36/P2eG7kL2tWIAWnHi+kii/imvNA2BwAP6bzom4CC6giPILNHKkfbd774pTHJSb5GjF2XLlEPck4ibo+O9rygDgWCZapB1AkDKcGjv07eP6YRfcXr5hfUWhEWthxBvnMSHEqToxAT/cvD/lWITRRcRLmx7l7/JlnTHanjwf2CTYK/FRhVW/WrCYOESCUntlGKz9Y7sPyZcpgY8CesKHaJREzADw6ZE9V+22H49kO5eugcUTkSJO4UbiNG532gkBVPNDeuvG955DYgau8GKWzfVjR2VdGBwK9P3yt4pkHIgdPQl3OQtKItXHjAGl6rjhyR/FfNhV5zVhmXpfqK5TUNKmAy0g9cMHYwhWLRh+HdfjRAA5Zt9UKN7LurtqueuuMSlD0kCZBiP3ZosgpwV8LYnD/8vkEluXgNH5BEntmMoQ79mQUxs
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(376002)(396003)(36840700001)(40470700004)(46966006)(82310400005)(6666004)(478600001)(316002)(110136005)(8936002)(26005)(44832011)(5660300002)(45080400002)(2906002)(186003)(2616005)(426003)(336012)(86362001)(1076003)(54906003)(41300700001)(47076005)(356005)(40460700003)(921005)(40480700001)(83380400001)(8676002)(82740400003)(4326008)(70586007)(36756003)(81166007)(70206006)(36860700001)(36900700001)(83996005)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2022 05:17:02.5261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1405337b-4a45-4cdd-5539-08da858fe0e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM11FT093.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB2890
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For ARM processor, unaligned access to device memory is not allowed.
Method memcpy does not take care of alignment.

USB detection failure with the unaligned address of memory access, with
below kernel crash. To fix the unaligned address the kernel panic issue,
replace memcpy with memcpy_toio method.

Kernel crash:
Unable to handle kernel paging request at virtual address ffff80000c05008a
Mem abort info:
  ESR = 0x96000061
  EC = 0x25: DABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x21: alignment fault
Data abort info:
  ISV = 0, ISS = 0x00000061
  CM = 0, WnR = 1
swapper pgtable: 4k pages, 48-bit VAs, pgdp=000000000143b000
[ffff80000c05008a] pgd=100000087ffff003, p4d=100000087ffff003,
pud=100000087fffe003, pmd=1000000800bcc003, pte=00680000a0010713
Internal error: Oops: 96000061 [#1] SMP
Modules linked in:
CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.15.19-xilinx-v2022.1 #1
Hardware name: ZynqMP ZCU102 Rev1.0 (DT)
pstate: 200000c5 (nzCv daIF -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __memcpy+0x30/0x260
lr : __xudc_ep0_queue+0xf0/0x110
sp : ffff800008003d00
x29: ffff800008003d00 x28: ffff800009474e80 x27: 00000000000000a0
x26: 0000000000000100 x25: 0000000000000012 x24: ffff000800bc8080
x23: 0000000000000001 x22: 0000000000000012 x21: ffff000800bc8080
x20: 0000000000000012 x19: ffff000800bc8080 x18: 0000000000000000
x17: ffff800876482000 x16: ffff800008004000 x15: 0000000000004000
x14: 00001f09785d0400 x13: 0103020101005567 x12: 0781400000000200
x11: 00000000c5672a10 x10: 00000000000008d0 x9 : ffff800009463cf0
x8 : ffff8000094757b0 x7 : 0201010055670781 x6 : 4000000002000112
x5 : ffff80000c05009a x4 : ffff000800a15012 x3 : ffff00080362ad80
x2 : 0000000000000012 x1 : ffff000800a15000 x0 : ffff80000c050088
Call trace:
 __memcpy+0x30/0x260
 xudc_ep0_queue+0x3c/0x60
 usb_ep_queue+0x38/0x44
 composite_ep0_queue.constprop.0+0x2c/0xc0
 composite_setup+0x8d0/0x185c
 configfs_composite_setup+0x74/0xb0
 xudc_irq+0x570/0xa40
 __handle_irq_event_percpu+0x58/0x170
 handle_irq_event+0x60/0x120
 handle_fasteoi_irq+0xc0/0x220
 handle_domain_irq+0x60/0x90
 gic_handle_irq+0x74/0xa0
 call_on_irq_stack+0x2c/0x60
 do_interrupt_handler+0x54/0x60
 el1_interrupt+0x30/0x50
 el1h_64_irq_handler+0x18/0x24
 el1h_64_irq+0x78/0x7c
 arch_cpu_idle+0x18/0x2c
 do_idle+0xdc/0x15c
 cpu_startup_entry+0x28/0x60
 rest_init+0xc8/0xe0
 arch_call_rest_init+0x10/0x1c
 start_kernel+0x694/0x6d4
 __primary_switched+0xa4/0xac

Signed-off-by: Piyush Mehta <piyush.mehta@amd.com>
---
 drivers/usb/gadget/udc/udc-xilinx.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/udc/udc-xilinx.c b/drivers/usb/gadget/udc/udc-xilinx.c
index 4827e3cd3834..054b69dc2f0c 100644
--- a/drivers/usb/gadget/udc/udc-xilinx.c
+++ b/drivers/usb/gadget/udc/udc-xilinx.c
@@ -499,11 +499,11 @@ static int xudc_eptxrx(struct xusb_ep *ep, struct xusb_req *req,
 		/* Get the Buffer address and copy the transmit data.*/
 		eprambase = (u32 __force *)(udc->addr + ep->rambase);
 		if (ep->is_in) {
-			memcpy(eprambase, bufferptr, bytestosend);
+			memcpy_toio(eprambase, bufferptr, bytestosend);
 			udc->write_fn(udc->addr, ep->offset +
 				      XUSB_EP_BUF0COUNT_OFFSET, bufferlen);
 		} else {
-			memcpy(bufferptr, eprambase, bytestosend);
+			memcpy_toio(bufferptr, eprambase, bytestosend);
 		}
 		/*
 		 * Enable the buffer for transmission.
@@ -517,11 +517,11 @@ static int xudc_eptxrx(struct xusb_ep *ep, struct xusb_req *req,
 		eprambase = (u32 __force *)(udc->addr + ep->rambase +
 			     ep->ep_usb.maxpacket);
 		if (ep->is_in) {
-			memcpy(eprambase, bufferptr, bytestosend);
+			memcpy_toio(eprambase, bufferptr, bytestosend);
 			udc->write_fn(udc->addr, ep->offset +
 				      XUSB_EP_BUF1COUNT_OFFSET, bufferlen);
 		} else {
-			memcpy(bufferptr, eprambase, bytestosend);
+			memcpy_toio(bufferptr, eprambase, bytestosend);
 		}
 		/*
 		 * Enable the buffer for transmission.
@@ -1023,7 +1023,7 @@ static int __xudc_ep0_queue(struct xusb_ep *ep0, struct xusb_req *req)
 			   udc->addr);
 		length = req->usb_req.actual = min_t(u32, length,
 						     EP0_MAX_PACKET);
-		memcpy(corebuf, req->usb_req.buf, length);
+		memcpy_toio(corebuf, req->usb_req.buf, length);
 		udc->write_fn(udc->addr, XUSB_EP_BUF0COUNT_OFFSET, length);
 		udc->write_fn(udc->addr, XUSB_BUFFREADY_OFFSET, 1);
 	} else {
@@ -1752,7 +1752,7 @@ static void xudc_handle_setup(struct xusb_udc *udc)
 
 	/* Load up the chapter 9 command buffer.*/
 	ep0rambase = (u32 __force *) (udc->addr + XUSB_SETUP_PKT_ADDR_OFFSET);
-	memcpy(&setup, ep0rambase, 8);
+	memcpy_toio(&setup, ep0rambase, 8);
 
 	udc->setup = setup;
 	udc->setup.wValue = cpu_to_le16(setup.wValue);
@@ -1839,7 +1839,7 @@ static void xudc_ep0_out(struct xusb_udc *udc)
 			     (ep0->rambase << 2));
 		buffer = req->usb_req.buf + req->usb_req.actual;
 		req->usb_req.actual = req->usb_req.actual + bytes_to_rx;
-		memcpy(buffer, ep0rambase, bytes_to_rx);
+		memcpy_toio(buffer, ep0rambase, bytes_to_rx);
 
 		if (req->usb_req.length == req->usb_req.actual) {
 			/* Data transfer completed get ready for Status stage */
@@ -1915,7 +1915,7 @@ static void xudc_ep0_in(struct xusb_udc *udc)
 				     (ep0->rambase << 2));
 			buffer = req->usb_req.buf + req->usb_req.actual;
 			req->usb_req.actual = req->usb_req.actual + length;
-			memcpy(ep0rambase, buffer, length);
+			memcpy_toio(ep0rambase, buffer, length);
 		}
 		udc->write_fn(udc->addr, XUSB_EP_BUF0COUNT_OFFSET, count);
 		udc->write_fn(udc->addr, XUSB_BUFFREADY_OFFSET, 1);
-- 
2.25.1

