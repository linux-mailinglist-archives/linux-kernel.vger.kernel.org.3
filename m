Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0984A73E2
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:56:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345267AbiBBOzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:55:47 -0500
Received: from mail-dm6nam10on2046.outbound.protection.outlook.com ([40.107.93.46]:1824
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S236194AbiBBOzd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:55:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OMly48gGeldpRksmD+bRHh771cU7tmz+5dU2+ZuPkHXwjpMcnVpuKHtsVzMiN1zIrKFV3O8pHKiDxYx1nsuYY3u08zbgS92yGWjXnWDPTXeiXYCeNFVL04XJbe0Uxl7zyjI5tryDX95Wnws1JedEvKFc7rwPSMeoFjhRSdTDi2Hf475nq5xzk6UHH88/j+cvwt1XPinu25NK1mmrEP2LHZhLb1mnK0b4rnoAzXK5plydzd5nr2QITYmBHDGG8NepjEKtc9qeMWRzhDGQBAMXOwAsdF+Dj2JyQAarZ9kcGTJsHLyYm4LWnyicSwQRaDGJBcxqJ7l9v0nK1CqGZd+vfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z2RhfzEpMTgZKIc0vHH8nb4wFzha+nweFgIh+MZtkro=;
 b=mYMyFUUve6HEaSz6eLA7gxO+XaJ/867wu3RngqP5qUTmTsnnjaGHWfYyc6p2DHhWkX74/wbHP4ETf/TI506nZ5y27lVCPM6pqmaD4QTnRGy6Xws6lvmqScCqNCp823HvcZwTh93D/+eshxumePvzKhd+0b2KMqJfAwHm6CvIXkvEOG72WhudcfMvBOkUEyBJgtthpJU5wX7XYBB+AuU0num2LQ4WhRzHsK0VBGepyUkuMj6ZFEBq12Ql9OlfjHO52jQRo+jTiNCr7STrb+hscm9wnI4DlxXQFas/6Sp0LJVEJb58iAVz0ZMSVGtdRoXEaWIHgnxfg2ijYjEjdf5ayQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2RhfzEpMTgZKIc0vHH8nb4wFzha+nweFgIh+MZtkro=;
 b=F/2AYnRD1jggMKY+smzXd71sdSNwrAAhZuMFbWErPNN/ODlpbAZ6drXHIN1eoCNe7itUupeQn4iCMHrb8t36kcbZAoSUN0RwR7a4O0LYrwjSvRxPB+sbotiYVKWnqHh2pQgIEsR5WJzVcQVtiypR1dQv/zSSfJL+moPKA9iIlnQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BY3PR05MB8081.namprd05.prod.outlook.com (2603:10b6:a03:366::15)
 by BN6PR05MB2803.namprd05.prod.outlook.com (2603:10b6:404:2c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.5; Wed, 2 Feb
 2022 14:55:17 +0000
Received: from BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::304c:2b94:4f26:a581]) by BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::304c:2b94:4f26:a581%3]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 14:55:17 +0000
From:   Jorgen Hansen <jhansen@vmware.com>
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     gregkh@linuxfoundation.org, pv-drivers@vmware.com,
        Jorgen Hansen <jhansen@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>
Subject: [PATCH 8/8] VMCI: dma dg: add support for DMA datagrams receive
Date:   Wed,  2 Feb 2022 06:49:10 -0800
Message-Id: <20220202144910.10349-9-jhansen@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220202144910.10349-1-jhansen@vmware.com>
References: <20220202144910.10349-1-jhansen@vmware.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0362.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::7) To BY3PR05MB8081.namprd05.prod.outlook.com
 (2603:10b6:a03:366::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03f0cfe9-d7ab-4837-eabf-08d9e65c05a9
X-MS-TrafficTypeDiagnostic: BN6PR05MB2803:EE_
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <BN6PR05MB28031D770A553E8CBBE4F4DDDA279@BN6PR05MB2803.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1unI0x8DMwvqX4xLs2sRYSFiymShWKMDNx6HZ0vqT6wPVRTXDm2cI9XziD7yaKkVjvLln+MoECEtw73srmTCuid7ns0KlpHkuBnToOwItbTBJjR+6zd1ZpVcrmb2YHVUsvpPNgtugnsLKqZO/nYK8CyVJmeC8JbwdIVBD9TI5swery76vgWxPsHvJ0vR/Uc1lVuOJ0KdDIRT/7+nyVvM3/M37T2d5lCovLu8vivOTRYKHDVLyCuJeZqSOnf03bNF5w83DL4vFQG0sgwn3VxYoWXFHOy9yZ74y+I+c4muTtACHD5qJf7sYrLoQVKyxBc4Wg+5WGlBAKIcKDogI5KCnkPR1LsMTLOGsKmFdzddAqVs//qT1T8QjtKHB07unXKfBQcnaHQJZArK+S96mTyQlsQy7bigJ76PtMLeFy25bTCpfM0/Q7INPSeSGY1q26EUHTVVOUgTf/U4JnH+87qUwnzklYfcpCX3JZmsI1JnUm9ztbQAuaEOSZUYxkgvax4jZAD1TVeJ8WSJBSaJ4vGue0L2sZLsOj2C93S2XE9LdZchxLlV5wNIeQowRs5d3tKeoRCpTs3HN7ukJEZajTbBGwiC5XoOjoNT87TUARH7YhzZot2PEU6hFmIOG45Z5JkAypb6meFrOTKMHm4IK5etsPusK4m7Qd1bwEnQoQGEcXTz2w32iaz12AvTdJOi2jSjCOioXT59J3ydqbY7m1uXWw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8081.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52116002)(316002)(6512007)(38100700002)(38350700002)(5660300002)(2616005)(8676002)(8936002)(54906003)(4326008)(66476007)(66556008)(66946007)(83380400001)(107886003)(508600001)(6486002)(86362001)(1076003)(36756003)(186003)(6506007)(26005)(2906002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?42JnyS7MLB4ahNxhIGc+iMtupQc2E7sbmhTzmNm/MhLySNmXzLPxHuH6h9BF?=
 =?us-ascii?Q?8cgfxl8k3ijq7F3f0Trr46syPFsbgDs8N5aipnEcH4+Y5MnrZInYsh7CFCy2?=
 =?us-ascii?Q?o7JR15gFj29Z9tZi0vpHIuCNRAlCitP0LfDvMKKPnl2dp1+93cO7/DMUnKrh?=
 =?us-ascii?Q?rpiDRafdLtgbnaqg4JwnbvwVvi9y/w4vOzZ5bj/ATV402tc6Vh4RtxJr166+?=
 =?us-ascii?Q?ISzCDUpzUYB/xwViyV3LSy7Xe8NPGcl7oD2G58Q4kCnRPV2WhvBCXVFSgxzA?=
 =?us-ascii?Q?GmZVpRUi1XM3oIKOuVlnSZ3+PC8B7U54aO1e9SmZ9Yllj1zvKoQLxh4blWBN?=
 =?us-ascii?Q?FxdxQGOpEFJNN2XbchbTXYBheOkGQJYfGyS8AcZUOiWoemGMyvRqBgyR223K?=
 =?us-ascii?Q?2vWkXdZgLF70j5do5EVUoL30pu3pvY20bF7v1xiQTF2lOvcrk1NR6Tv9hdMB?=
 =?us-ascii?Q?kpobnq/eU7WsyfuchPtKVVtfW76D9F360DGv5tAHC63si7I4kFy8somVt4KF?=
 =?us-ascii?Q?DHSkQvVCjGEkDFRzef+7XxuXeDaPLnnl+snQxDr3HHKyINBtX7OQOezRMet9?=
 =?us-ascii?Q?pbrVIqqKRMrVkKfgpcUjQ+H28r8xM7ScRFDkSWe1ZhoVVzEv0afzQBk/8eUq?=
 =?us-ascii?Q?EP4oUH4FIuqEyX/P0By/j/2ZJSWXEpaDMuU/irQsON5XaQKayMjHSJAxHspm?=
 =?us-ascii?Q?53VFVyEols8NGPlB/gbrFe9yMphjJFgWuQRQ0IxKoyF9d9aS3nt62xW7jZc1?=
 =?us-ascii?Q?5Wt1kv5IHRA+ydakOEpVc3e5EolOSeQ7YEyCpiuHSlZneIGisTgkoBUTs5kb?=
 =?us-ascii?Q?BzeHzZrjXdZnV4XAczuFsQUvYJvgQLjrKlY8WPjkCcTg6rW7+sab3ZbZbFdP?=
 =?us-ascii?Q?3dFi4LJpTBScfdt/6ao1RDa7SWTNJhaVtpqPMZmOvfvRlIOmFzEsU8lrm5IF?=
 =?us-ascii?Q?aLcSqzqMWufEjTfQ4wscFNAiuTzVSLgQVvaq+6ATa5UkndBofYtzbLqRALXM?=
 =?us-ascii?Q?nbFDicEybs2TTeFALGnN3SwSKqZ2qR8+bm3KrYXf/dnz2l9PtLg55JyAMEh0?=
 =?us-ascii?Q?YB+e5aRO25fz89C+yuZRqVWzYAM7Aw8JaO7kGKaR7izfxtmGhfRvaBUBEjEo?=
 =?us-ascii?Q?PKjZZZke2m1u7kNjDuKv7wwnKC1uJZQNNe/Y1ZoucwYBiij2U/Gs6g+Qnne1?=
 =?us-ascii?Q?RDGjym8ox24DsmrdJ9giqVk65h/Xjy5htY8PRlh8kBDJajZ5SThN39LJlFxG?=
 =?us-ascii?Q?L7aJ6tcudlCceVV4En2yRQB9AlkXGSAr8nj4mxCByDlN0uEJM/0yTcsfw1sH?=
 =?us-ascii?Q?WO/v3FOvdKcikh7fmrevmudIeH5ACVPY+fiKNQspswu9vqj78NJDh2BqUvBf?=
 =?us-ascii?Q?ZfDSLCgZDya7CCnlWhDhfQvGcRB4eJJLAq5MWNabwnXv+Yl6IGe7XUJahQg/?=
 =?us-ascii?Q?Y7Hs+9VqcXk0CL485s0zAB6/LoNIEoE2OBiaTkLsi479nS30CYC/hYNVpJdy?=
 =?us-ascii?Q?X1Vgx1rwpvKMM1igKUrnKTbtcy2TyFUttZyaensRvs3D0LWI5vs6+iRDVhGf?=
 =?us-ascii?Q?h6OAx8Jm6/p5hhXaBIeBP9Ihkzc5ANu2N96fDVD9VQNUXGRkhMJ/oKeDHm12?=
 =?us-ascii?Q?Yw+mumCOJgmdknoZcUcikTo=3D?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f0cfe9-d7ab-4837-eabf-08d9e65c05a9
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8081.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 14:55:15.9161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Fq280KUsipfhCdeQoTwxZ0DVVPhcVvpWMp+hu61pDY893U8mtX2E3lQcfvCqDZq242gAYXG6JJ02hl7rIYHl1g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR05MB2803
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the DMA based receive operation instead of the ioread8_rep
based datagram receive when DMA datagrams are supported.

In the receive operation, configure the header to point to the
page aligned VMCI_MAX_DG_SIZE part of the receive buffer
using s/g configuration for the header. This ensures that the
existing dispatch routine can be used with little modification.
Initiate the receive by writing the lower 32 bit of the buffer
to the VMCI_DATA_IN_LOW_ADDR register, and wait for the busy
flag to be changed by the device using a wait queue.

The existing dispatch routine for received  datagrams is reused
for the DMA datagrams with a few modifications:
- the receive buffer is always the maximum size for DMA datagrams
  (IO ports would try with a shorter buffer first to reduce
  overhead of the ioread8_rep operation).
- for DMA datagrams, datagrams are provided contiguous in the
  buffer as opposed to IO port datagrams, where they can start
  on any page boundary

Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
---
 drivers/misc/vmw_vmci/vmci_guest.c | 103 ++++++++++++++++++++++-------
 1 file changed, 79 insertions(+), 24 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index ca73a1913404..2bcfa292772d 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -58,6 +58,7 @@ struct vmci_guest_device {
 
 	struct tasklet_struct datagram_tasklet;
 	struct tasklet_struct bm_tasklet;
+	struct wait_queue_head inout_wq;
 
 	void *data_buffer;
 	dma_addr_t data_buffer_base;
@@ -115,6 +116,36 @@ void vmci_write_reg(struct vmci_guest_device *dev, u32 val, u32 reg)
 		iowrite32(val, dev->iobase + reg);
 }
 
+static void vmci_read_data(struct vmci_guest_device *vmci_dev,
+			   void *dest, size_t size)
+{
+	if (vmci_dev->mmio_base == NULL)
+		ioread8_rep(vmci_dev->iobase + VMCI_DATA_IN_ADDR,
+			    dest, size);
+	else {
+		/*
+		 * For DMA datagrams, the data_buffer will contain the header on the
+		 * first page, followed by the incoming datagram(s) on the following
+		 * pages. The header uses an S/G element immediately following the
+		 * header on the first page to point to the data area.
+		 */
+		struct vmci_data_in_out_header *buffer_header = vmci_dev->data_buffer;
+		struct vmci_sg_elem *sg_array = (struct vmci_sg_elem *)(buffer_header + 1);
+		size_t buffer_offset = dest - vmci_dev->data_buffer;
+
+		buffer_header->opcode = 1;
+		buffer_header->size = 1;
+		buffer_header->busy = 0;
+		sg_array[0].addr = vmci_dev->data_buffer_base + buffer_offset;
+		sg_array[0].size = size;
+
+		vmci_write_reg(vmci_dev, lower_32_bits(vmci_dev->data_buffer_base),
+			       VMCI_DATA_IN_LOW_ADDR);
+
+		wait_event(vmci_dev->inout_wq, buffer_header->busy == 1);
+	}
+}
+
 int vmci_write_data(struct vmci_guest_device *dev, struct vmci_datagram *dg)
 {
 	int result;
@@ -260,15 +291,17 @@ static int vmci_check_host_caps(struct pci_dev *pdev)
 }
 
 /*
- * Reads datagrams from the data in port and dispatches them. We
- * always start reading datagrams into only the first page of the
- * datagram buffer. If the datagrams don't fit into one page, we
- * use the maximum datagram buffer size for the remainder of the
- * invocation. This is a simple heuristic for not penalizing
- * small datagrams.
+ * Reads datagrams from the device and dispatches them. For IO port
+ * based access to the device, we always start reading datagrams into
+ * only the first page of the datagram buffer. If the datagrams don't
+ * fit into one page, we use the maximum datagram buffer size for the
+ * remainder of the invocation. This is a simple heuristic for not
+ * penalizing small datagrams. For DMA-based datagrams, we always
+ * use the maximum datagram buffer size, since there is no performance
+ * penalty for doing so.
  *
  * This function assumes that it has exclusive access to the data
- * in port for the duration of the call.
+ * in register(s) for the duration of the call.
  */
 static void vmci_dispatch_dgs(unsigned long data)
 {
@@ -276,23 +309,41 @@ static void vmci_dispatch_dgs(unsigned long data)
 	u8 *dg_in_buffer = vmci_dev->data_buffer;
 	struct vmci_datagram *dg;
 	size_t dg_in_buffer_size = VMCI_MAX_DG_SIZE;
-	size_t current_dg_in_buffer_size = PAGE_SIZE;
+	size_t current_dg_in_buffer_size;
 	size_t remaining_bytes;
+	bool is_io_port = vmci_dev->mmio_base == NULL;
 
 	BUILD_BUG_ON(VMCI_MAX_DG_SIZE < PAGE_SIZE);
 
-	ioread8_rep(vmci_dev->iobase + VMCI_DATA_IN_ADDR,
-		    vmci_dev->data_buffer, current_dg_in_buffer_size);
+	if (!is_io_port) {
+		/* For mmio, the first page is used for the header. */
+		dg_in_buffer += PAGE_SIZE;
+
+		/*
+		 * For DMA-based datagram operations, there is no performance
+		 * penalty for reading the maximum buffer size.
+		 */
+		current_dg_in_buffer_size = VMCI_MAX_DG_SIZE;
+	} else {
+		current_dg_in_buffer_size = PAGE_SIZE;
+	}
+	vmci_read_data(vmci_dev, dg_in_buffer, current_dg_in_buffer_size);
 	dg = (struct vmci_datagram *)dg_in_buffer;
 	remaining_bytes = current_dg_in_buffer_size;
 
+	/*
+	 * Read through the buffer until an invalid datagram header is
+	 * encountered. The exit condition for datagrams read through
+	 * VMCI_DATA_IN_ADDR is a bit more complicated, since a datagram
+	 * can start on any page boundary in the buffer.
+	 */
 	while (dg->dst.resource != VMCI_INVALID_ID ||
-	       remaining_bytes > PAGE_SIZE) {
+	       (is_io_port && remaining_bytes > PAGE_SIZE)) {
 		unsigned dg_in_size;
 
 		/*
-		 * When the input buffer spans multiple pages, a datagram can
-		 * start on any page boundary in the buffer.
+		 * If using VMCI_DATA_IN_ADDR, skip to the next page
+		 * as a datagram can start on any page boundary.
 		 */
 		if (dg->dst.resource == VMCI_INVALID_ID) {
 			dg = (struct vmci_datagram *)roundup(
@@ -342,11 +393,10 @@ static void vmci_dispatch_dgs(unsigned long data)
 					current_dg_in_buffer_size =
 					    dg_in_buffer_size;
 
-				ioread8_rep(vmci_dev->iobase +
-						VMCI_DATA_IN_ADDR,
-					vmci_dev->data_buffer +
+				vmci_read_data(vmci_dev,
+					       dg_in_buffer +
 						remaining_bytes,
-					current_dg_in_buffer_size -
+					       current_dg_in_buffer_size -
 						remaining_bytes);
 			}
 
@@ -384,10 +434,8 @@ static void vmci_dispatch_dgs(unsigned long data)
 				current_dg_in_buffer_size = dg_in_buffer_size;
 
 			for (;;) {
-				ioread8_rep(vmci_dev->iobase +
-						VMCI_DATA_IN_ADDR,
-					vmci_dev->data_buffer,
-					current_dg_in_buffer_size);
+				vmci_read_data(vmci_dev, dg_in_buffer,
+					       current_dg_in_buffer_size);
 				if (bytes_to_skip <= current_dg_in_buffer_size)
 					break;
 
@@ -404,8 +452,7 @@ static void vmci_dispatch_dgs(unsigned long data)
 		if (remaining_bytes < VMCI_DG_HEADERSIZE) {
 			/* Get the next batch of datagrams. */
 
-			ioread8_rep(vmci_dev->iobase + VMCI_DATA_IN_ADDR,
-				    vmci_dev->data_buffer,
+			vmci_read_data(vmci_dev, dg_in_buffer,
 				    current_dg_in_buffer_size);
 			dg = (struct vmci_datagram *)dg_in_buffer;
 			remaining_bytes = current_dg_in_buffer_size;
@@ -463,8 +510,11 @@ static irqreturn_t vmci_interrupt(int irq, void *_dev)
 			icr &= ~VMCI_ICR_NOTIFICATION;
 		}
 
-		if (icr & VMCI_ICR_DMA_DATAGRAM)
+
+		if (icr & VMCI_ICR_DMA_DATAGRAM) {
+			wake_up_all(&dev->inout_wq);
 			icr &= ~VMCI_ICR_DMA_DATAGRAM;
+		}
 
 		if (icr != 0)
 			dev_warn(dev->dev,
@@ -497,6 +547,10 @@ static irqreturn_t vmci_interrupt_bm(int irq, void *_dev)
  */
 static irqreturn_t vmci_interrupt_dma_datagram(int irq, void *_dev)
 {
+	struct vmci_guest_device *dev = _dev;
+
+	wake_up_all(&dev->inout_wq);
+
 	return IRQ_HANDLED;
 }
 
@@ -586,6 +640,7 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 		     vmci_dispatch_dgs, (unsigned long)vmci_dev);
 	tasklet_init(&vmci_dev->bm_tasklet,
 		     vmci_process_bitmap, (unsigned long)vmci_dev);
+	init_waitqueue_head(&vmci_dev->inout_wq);
 
 	if (mmio_base != NULL) {
 		vmci_dev->tx_buffer = dma_alloc_coherent(&pdev->dev, VMCI_DMA_DG_BUFFER_SIZE,
-- 
2.25.1

