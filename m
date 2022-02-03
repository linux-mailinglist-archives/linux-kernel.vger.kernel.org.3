Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64CD14A8512
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 14:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350836AbiBCNSl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 08:18:41 -0500
Received: from mail-bn1nam07on2061.outbound.protection.outlook.com ([40.107.212.61]:24580
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S233262AbiBCNSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:18:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TvnjLjTYSXdxjZ7T79DE1s3J8WZmTqvUV9eNq6qHj4VJy4VU2pE/T+DokxNJZ002jz1CuzNPufcT3ePLfZLZj4XzPl3pR/bMdAkc4bKJVestlOWjhZzqvX6bHE0GCwnMo80v2P6BqcpOaVNOhom+SWOdxyeJf85CaMYN/WQmFi6U/r8Z/vUXjBRkp0zBeHicRPSO4XWJ5PRA/+j0TBAtxi9vwjQHiUaijZCvP91ENA2JDehF6PqDMOVmc/MNE0dirgJ8PN6RITFfeRX2f3QsI/CUjoeEd0K2LzeKIky8H8fSVSYP/3PLxoVOGgYNOZZ+3PCn73raqK1Z7wr5vogFig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gemElUsktnUufpQKsBcN7nZVn/A24GXRFBpw5bzhNk0=;
 b=gWABlXkYb39AFn3mFFcxLAplqmOWkTQawfjEfZ9X/Jsd5EyCiWOv3vb4xPqi2v/DOsL6+oFrUqAUhg9CLHKEkval79S1JR8hW0FgI/qQ3Ug+Qq8/02LYADUcWnnCSCG71vLnBRwMreBpwCcUzB7ie0KktELx1jUDu+rsL8za3w1Z4ut2bVBZr0tVJdKCyFtWkIFEPX0YnzPKOglY4gOr9oqG9+RZEcKw1kgk4iBGD1F9LepFHX46XwaCWwe/DANg73RBtI3R6Bno12GsEz/vTZlznQYaufzwpVqAJbHnmLXp760TRdZJluuCW8j2HP3WsUQaBPZDbSzWpZnjQv2sVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gemElUsktnUufpQKsBcN7nZVn/A24GXRFBpw5bzhNk0=;
 b=Ib8bTr7rSOwdIyoyFzesqK+NK31ZnxVhTHQCDi9+PuK+P2VmrrHwR9VJzWMWxqmIcIMPOqCSO6jcwtGaByl8z3/SnlJCKv9uLhBrYGBPXCkl3Gssp8owE82zxHRm1a16LCaUwpJqN3ADCJeDyDMqfHmP2cLc+1hB/AkFnnH/mkE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BY3PR05MB8081.namprd05.prod.outlook.com (2603:10b6:a03:366::15)
 by MN2PR05MB7150.namprd05.prod.outlook.com (2603:10b6:208:18b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.5; Thu, 3 Feb
 2022 13:18:19 +0000
Received: from BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::304c:2b94:4f26:a581]) by BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::304c:2b94:4f26:a581%3]) with mapi id 15.20.4951.012; Thu, 3 Feb 2022
 13:18:19 +0000
From:   Jorgen Hansen <jhansen@vmware.com>
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     gregkh@linuxfoundation.org, pv-drivers@vmware.com,
        Jorgen Hansen <jhansen@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>
Subject: [PATCH v2 8/8] VMCI: dma dg: add support for DMA datagrams receive
Date:   Thu,  3 Feb 2022 05:12:37 -0800
Message-Id: <20220203131237.3380-9-jhansen@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220203131237.3380-1-jhansen@vmware.com>
References: <20220203131237.3380-1-jhansen@vmware.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0068.namprd07.prod.outlook.com
 (2603:10b6:a03:60::45) To BY3PR05MB8081.namprd05.prod.outlook.com
 (2603:10b6:a03:366::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ad2f2b8-1c1a-40a5-992b-08d9e717a3ec
X-MS-TrafficTypeDiagnostic: MN2PR05MB7150:EE_
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <MN2PR05MB7150143A965BAAD567A71B0CDA289@MN2PR05MB7150.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: adFuSJEUNQaKCUC3wI6qPg9sNDQXifntyzIyFupQvjr62KrdMXObt6mQdNiW1jQNcqiM9Fs0+JcwFLCSYmaFuP2iA+KPo82r58B4OowS3fliS/BF1V2jpIchWh/bUekxiM2+iE4yCz/Br0Kw8soCJlwlQ/HWPa+MQUyOL86AfSYn52BDvPIKaW4FZNzDIkwSa+mEvtA/DxASHtt+d0Df5O4v1JU2C0DbkS9YFngB7iLl6ojmfAGgWbYTq7fnrGQPySOD+NQeUvNdBfzfHiDBS4j6dcKdcQvTEttE0P30Gf++646P2TVAlimbGerBU1m5iqPBAegxR2IUnyjr8k9yYy1rvOZ/qiGrM8S7mFrecYhJJE+t+8a4sHyYqbkzQewNEQbFhcBTW8pDUJ0ZGlHVvilFcsCUvctf9EULLrkaDgYIO0jDyeEoEfV3UdQoDMBQKvcf1b9f6Hl2m2SYyB3Inij01oXfI/DRug8BSRxVqREUs3x7dyTX4Fs1Z5LzgyuS857HmSB+WLcE1QRKReBmta/zzXYmIKxhQgjbbfZqSNweR3RtZaDEKhrfMbXdtYkxQY/1V/TaWvgSCyJdQjNCeO9Xl1UaKTXERd04uLheWJHAviQ4hYTpe3Bn6QLmqCTaNXp+4CbTc9EuRAsp1bxGs3kkuvq03MzXCk/4FpjvoUJU7XL+7/Tva0i/ZJkXE4nXs2MmNzAgnwv40Kv78gja8A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8081.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(8936002)(66556008)(8676002)(66476007)(5660300002)(4326008)(38350700002)(2616005)(52116002)(66946007)(36756003)(38100700002)(186003)(6506007)(26005)(2906002)(1076003)(83380400001)(107886003)(316002)(6666004)(54906003)(86362001)(6512007)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Xeus3A/BENUDsSEqUkUSJF8++KtbUvRI7ScWurXFCapRwtpRRIa5oMFcuVum?=
 =?us-ascii?Q?Lqz8Qu23tqXg68WFtszbgesA/ryEJ4f8Hzb3SI1J4ek/yqIEi0vtfZqCeRYZ?=
 =?us-ascii?Q?ioDo/zb5U/692qkSuBKPs75jA0wY4GKeK1w5/zfAdLKYFHSh331/glQYme1C?=
 =?us-ascii?Q?+py6xWPKbINm9dAJK5rLJEhbcZpBFvjYIuYGaaS45e8wpheJNqb40HBICYNR?=
 =?us-ascii?Q?lMUEjhlPl1HlV/gQdWqwcEC+Y1Lemg76PUByauCTapYHdlMLRmnh0qiDueC5?=
 =?us-ascii?Q?wuuKeK6JcB0JeQ/O6gjL2u4sIDVBZ6SkbV6LWB9YbsONHGozBK/ceA3bePS/?=
 =?us-ascii?Q?uptQGzJIefSNcS6pq7DFmhC8frdt+rWPHFty5uyV9lR56zkmw/dRR5A7YRzw?=
 =?us-ascii?Q?6x7Gv3g4pmvyI5cFSqXW/PbQucfAAduHKt1FoU+VCn+8NDDvQ+kj2F9DhAji?=
 =?us-ascii?Q?Zxit4SSHFK1isXA0MRv08w9w1nA072H5W8eYpQ9Syd3EDpH/7I4vj+EWH59a?=
 =?us-ascii?Q?j3f1tXLSYDghJOCeKAWMD9s27wB5ITDysbtM5tQHCPqUqW1ha7MOGU5JUrXn?=
 =?us-ascii?Q?/lOGBhAGrRa5UK7htmbbwvx0TPVx/DZ/lXgVJVnDIFTHigMQfPdaieXxC/NP?=
 =?us-ascii?Q?UFPYxXO7VRpToKqJTcmsz5+FENLXp1wxoBMkbQEcd2nZUEDXhNxiIbaWiwku?=
 =?us-ascii?Q?zgAILWTR9j3PlCcbEkh4pvvAtDkuMw1TDQTSoa4aAGEHR6ocHU+wAJRyggs9?=
 =?us-ascii?Q?n+f1gcAfNOc+kPbjysOGBOINBmzWtyRDkOGig8vIAzHK2d85PYypgXlec/PN?=
 =?us-ascii?Q?rkakjswXMnNRCbrCoRTS9gsLGmEVoHYgm7A64ufS2g80UxeLOZXUNXz6+YNc?=
 =?us-ascii?Q?2for6F+BV+ZI/TNyREGpvx7owMgcMmZmt7jpH856SKFnbO0cJyLhL5p5PCF8?=
 =?us-ascii?Q?l/Q4r3l7mg4ayrcBUXO5ZgO5Eqqm15k/au9SUwEpnBi9+2lx92VWhlIWqfN7?=
 =?us-ascii?Q?Qp9hCSeFbPGCWR9k2rPg6sceGp1cn12BomRI+FoKqAeT9M/gAagaCKFDLrhE?=
 =?us-ascii?Q?Qqg9Hd7Aip9H6Uy7IOh64AZf0EFFdUSVD9J8p+w9BN7sfkrnJg7VfDCIlKKi?=
 =?us-ascii?Q?1RdRmMPOR5nQ+7oRJyA1yehtmI1UtWpxnZFvbEwGCiRmHfgAnvv+zGXgpx57?=
 =?us-ascii?Q?a7o4M6zrVUbydI/AjcRLY/CagfoXOrJbRUzXO/B24c29fg4ysmEdoMqhjU2V?=
 =?us-ascii?Q?JrZrX+/hzisjlIBaXrBVbQ6naGcPXsHejZIRwHth8Y5NLbMDy5ls2+MIWYO4?=
 =?us-ascii?Q?PcZh8hDXXFdcWPrq4MNB0EuWum61O9mAq2PXYksGcod/KAyeufg+pCgGt4Jo?=
 =?us-ascii?Q?54sP2PlxeMEqARBoyCmdnDnv1g93KKEAELFPR1iO/fSWDgrxOAldovnFwRUC?=
 =?us-ascii?Q?qJUlpqnGQs8tTl93NWXkFGtu1ZCJHrNTwKS5N5aA7WIRlPoJIRjkFfbgQDOr?=
 =?us-ascii?Q?1ASZfiUqzO7iODh/8hVR5w2wXazcoq2UTeKKcaxkpkgL0QRR2Tx46+oRojz4?=
 =?us-ascii?Q?IBDmzsIbfQIY/tWveblFxXZtPtEFHgGo7VHGUn7CwXMp5tcW/sDib/uKOwMP?=
 =?us-ascii?Q?qEFM1+dZvcgzbAwmPVKRgho=3D?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ad2f2b8-1c1a-40a5-992b-08d9e717a3ec
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8081.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 13:18:17.2278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l8JIjQtEppBviiU++BebbK8mwr7OLvI7aXn61TwtIDP5fUtqkI8+gMTz4+4DnIjr9kVsoPD4JsjmQXO7EgcU2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB7150
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
index ae2fd9c791d0..67fac1b8f262 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -58,6 +58,7 @@ struct vmci_guest_device {
 
 	struct tasklet_struct datagram_tasklet;
 	struct tasklet_struct bm_tasklet;
+	struct wait_queue_head inout_wq;
 
 	void *data_buffer;
 	dma_addr_t data_buffer_base;
@@ -115,6 +116,36 @@ static void vmci_write_reg(struct vmci_guest_device *dev, u32 val, u32 reg)
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
 static int vmci_write_data(struct vmci_guest_device *dev,
 			   struct vmci_datagram *dg)
 {
@@ -261,15 +292,17 @@ static int vmci_check_host_caps(struct pci_dev *pdev)
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
@@ -277,23 +310,41 @@ static void vmci_dispatch_dgs(unsigned long data)
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
@@ -343,11 +394,10 @@ static void vmci_dispatch_dgs(unsigned long data)
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
 
@@ -385,10 +435,8 @@ static void vmci_dispatch_dgs(unsigned long data)
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
 
@@ -405,8 +453,7 @@ static void vmci_dispatch_dgs(unsigned long data)
 		if (remaining_bytes < VMCI_DG_HEADERSIZE) {
 			/* Get the next batch of datagrams. */
 
-			ioread8_rep(vmci_dev->iobase + VMCI_DATA_IN_ADDR,
-				    vmci_dev->data_buffer,
+			vmci_read_data(vmci_dev, dg_in_buffer,
 				    current_dg_in_buffer_size);
 			dg = (struct vmci_datagram *)dg_in_buffer;
 			remaining_bytes = current_dg_in_buffer_size;
@@ -464,8 +511,11 @@ static irqreturn_t vmci_interrupt(int irq, void *_dev)
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
@@ -498,6 +548,10 @@ static irqreturn_t vmci_interrupt_bm(int irq, void *_dev)
  */
 static irqreturn_t vmci_interrupt_dma_datagram(int irq, void *_dev)
 {
+	struct vmci_guest_device *dev = _dev;
+
+	wake_up_all(&dev->inout_wq);
+
 	return IRQ_HANDLED;
 }
 
@@ -587,6 +641,7 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 		     vmci_dispatch_dgs, (unsigned long)vmci_dev);
 	tasklet_init(&vmci_dev->bm_tasklet,
 		     vmci_process_bitmap, (unsigned long)vmci_dev);
+	init_waitqueue_head(&vmci_dev->inout_wq);
 
 	if (mmio_base != NULL) {
 		vmci_dev->tx_buffer = dma_alloc_coherent(&pdev->dev, VMCI_DMA_DG_BUFFER_SIZE,
-- 
2.25.1

