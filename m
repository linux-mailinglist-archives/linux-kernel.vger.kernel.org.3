Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD084A73EA
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:56:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345253AbiBBOzn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:55:43 -0500
Received: from mail-dm6nam10on2046.outbound.protection.outlook.com ([40.107.93.46]:1824
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242489AbiBBOzc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:55:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=N0Ygbf7dbxJspinRb/C2RYmVl596LjIr7sXelBpZ4qcAH3i4Hx5DK1JmJ/2GDh/vb9O7yTA/8W7RrpI/lusluIvBeAkPituv18jWre+hYwJQ7Me6lR++X3RpuyhSp43BTtclthTGJ2PkKgYgoS8sJOQRpKiuVvwvsDCzA0gYSgk9EoDvpfj5J/s361OcnK2nBUdjaJhYLRefaThMOGOvLXvKmYY6rLGnKWWf744PfirMaC3UX6Ks237dYXQMVMWeDPOY2SS7juv7SxHHGWSMhz4L6U/34E8EFy/E5sZINnFtMIfUZUIATMAPaZHIocrkH0gRwcBZn/P26ZqoJ+46iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vJvZ4QzMdhb/lLZaDpx8KRU3rPrTwODkLDDkeLD39D0=;
 b=NH3M+di1T4ZL6I0c2qEul5cHzAZr3aUIBgeBLFyeeeRpNvKFBqkh8bpdhHG+WzHGY3PbdHUQBDsRFZxUySupQG4LZvSKxD54pjkL95t3syUkGU92LjSp13AJeHR2d7kQiKUClsVruROu5hLxW2kXoQ3rv0CVAhgTl//2kyVlah756+Icw4Ww8VGxDDer8O3gVB+i3JLvsWhNV1pAd4MVfHr6fesyLP+oTAxm3mgNULE+lHorgYPV+6h+BhuwhlF10VZ6R1uLk0xdEVvfp/3idn0xC2LX1gKKQg4ZWfMB13/hcsOJZqcQzEHfBNsOG5h8jYH6Rra85Oz+bpNUjzz6Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vJvZ4QzMdhb/lLZaDpx8KRU3rPrTwODkLDDkeLD39D0=;
 b=OidWfKWLGdVkeHWUU6LkBIR+94an3i9b7BsBddlowzNMxAntvAvdjGUhwrq06g6LRsohmm5fzTnqpC9QAmXiGHr7ozJsooayOvaYciTTl3elupsgxTkL6qsW0YDfSwzCPp9vuQfAW+/1Eg2G9/ioJ1jfqKuuFsJRaM+lXPKjXvE=
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
Subject: [PATCH 7/8] VMCI: dma dg: add support for DMA datagrams sends
Date:   Wed,  2 Feb 2022 06:49:09 -0800
Message-Id: <20220202144910.10349-8-jhansen@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: dfc32ec5-e64a-4300-e6be-08d9e65c0572
X-MS-TrafficTypeDiagnostic: BN6PR05MB2803:EE_
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <BN6PR05MB2803D189B773913E2D694BC5DA279@BN6PR05MB2803.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Fyc8UxgGdr131qMTIB5RFt6cQGsGfG1XX8MeIRFsgY4e8pfILD6i0LNnEHe+cvCYZmYIqBjZ5OyK9bTe2sKUhG1leYUAgBOpeskIj2Is+6T8xJdvdRpx0NT8XL+KiFONZUXByR83xoiYZ88hYjs8NTITv/rkVI2Gs+qlCty5AMs5qsQIK5UDLnvrrnzGhB/PxqckJxeNID7GNXRlSs9tIc0JaWyPXw/A8vgvVlVP78xJu4tiRqsx8OOVRDguEB4/4m+M/LfAvURRYSeJRQZRen0fTHQ8In1nqubLLulK8tUm1o+TC0d1WbXwMfZ/UqrUubRt8fhEQvrHOOeHSWhY0B+rTdlHezfvZGF55mehLAsSnuX6huA6dx9TUouT2wOTNxcG5Kfh1i0Lkd2tMyG3oPl4dNhZ/PIKK7E8X9Z6Vx0qHvq6QPa6TJ8YanLdlDSCUPXPHC7AJzfhIlQaTSHsBpXQ93rM/0/QjqAPiJQtT1J2egKWNQsjn5//LcexqkAxrcMJ/VcWsXhHyol0+04KcgD2IYS+Y4WgQjAV6e7g5G6dmfgC8II5UKf+u0iWqaSelvoSLUhIYtDmDdBUANQNriUBQ25tVMsi+bFN0QWnrdr+OYBrtTCZ0LbHWm5oKn/D0pll1BA1af/DtchCP+HWmWOriQ1FfPbKwmHl7jgf4NxJ7ddS9XLE88FQKOOeIP+YTF6g7NVEJUo5rC+Squ1bMA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8081.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52116002)(316002)(6512007)(38100700002)(38350700002)(5660300002)(2616005)(8676002)(8936002)(54906003)(4326008)(66476007)(66556008)(66946007)(83380400001)(107886003)(508600001)(6486002)(86362001)(1076003)(36756003)(186003)(6506007)(26005)(2906002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j0wh3MsHjDXKim2tdQ2Sl/G1Tp9GS9ewMZTGDup9vWgGRm3L7Pk8bd953NVA?=
 =?us-ascii?Q?hmDjHV6McQlb27aH3ShYf+oLb7AFENx6pwtCoO0NhsVerOoAoHsD9qTvAvUh?=
 =?us-ascii?Q?D94z9R6RN6dG9qsO/CT2bS89D/fLptNtw7quQNhcAcaEBJT78GJ0hJP9bsp8?=
 =?us-ascii?Q?YE23ixXXoKSj7+jEOG+5MjEQNFqFVpfxHaZZ2mD/lb5T3X5yxmcX6Uq4Pifi?=
 =?us-ascii?Q?luap/kWTOl0WXv8zvPWyY6Cp/bHlPNO8IvOnsgDTGDRAbXyItToG93Np56Y0?=
 =?us-ascii?Q?Ridgr+j6GN9/QuA4RQqCAnCxyFImp+jlNJHYzi7wSjhvOsYqqft/iy3SH3VH?=
 =?us-ascii?Q?nnLz4EybU4PRLQiYtoPBMkWu2q3vJBQVEgDFzs1fRB+649xy1zbt/MpJvVGH?=
 =?us-ascii?Q?Gra7ykAdWRPCvhGtCqoupXvCybIzEf1JRFlijcQC/+8WLH9gGnUatCeYNpTm?=
 =?us-ascii?Q?PouFqyxItC2ViVIVteXS+SxhKux8odo0uHb9mQh8ALcnoq+XfVfoqIzcH8BX?=
 =?us-ascii?Q?d1z3HsvVgY8WmVlUo8FNn187ySMkSGnMu+dNcv4iw/D1KPdxbPUrizC8xEhi?=
 =?us-ascii?Q?OkDKJjcLuapkW/gN2BSCcbWouwrrLgD3dO5GgtAbrY2AETc/HVtHF9amuvPM?=
 =?us-ascii?Q?l8x5cassU8Wtxcl+F/gL5bVZrxhOwQ8wWHOGCmC7WsJ7ZX1gaJfcwL1yrUNP?=
 =?us-ascii?Q?mr1lyzYS4j6Ii1Rr8v8FvZ4PaMYFeqRrHwayH4dpaKJd4Z7XxnSOYeIzq6nF?=
 =?us-ascii?Q?t3mKXoPOxUY6Gya57OnyYxn1X4Vl+8VlplRKjd1Rqg5UORoQjwEfhgRw9NE7?=
 =?us-ascii?Q?07uuAd4dicv6Yybkm9uu3afXJZKJ27JUfiz7VF4cNJ4QE5kEKAWWj9B3B/9+?=
 =?us-ascii?Q?aLDZQkcr2cvrngDp2a7THuo8VKQBqY0m3Pp/Wzj8f65hROl7AZYMZwe5iYhz?=
 =?us-ascii?Q?vsE1tikGx26aRyR3PlsOdR0Qaya65R2Fd3ASG7GXX+c7cZUwyeus4ufwe5Bo?=
 =?us-ascii?Q?EnQH7mX2pTRCchKxbnkpdLzTgIpzl5OTDTXLN3kVykV0C2cRe3A15D6OziC1?=
 =?us-ascii?Q?WMdctuekgefFJ3Sb1ZThwEIz58K8HalyI5iGxu8iw4pP7IXqUlqAvv0hw4qN?=
 =?us-ascii?Q?6Qo1ZTUCwmFlyg6a1GAEVRbcNARXp2b54y/xogOoKcHvn1AZnVSpqJ7lNUlP?=
 =?us-ascii?Q?yoXFhYU1SUfq4Vju8HnQ7Vyk0k2deW7nVKQaotRzUA6fxIe0y+QVetTyTm3y?=
 =?us-ascii?Q?ErxdapI8Jq3RSahIGndjyYuAnXJwS2arszlB1+z7gtgR8DR5HWzna4p+xeMD?=
 =?us-ascii?Q?bo7abuKGhErRCtxyUJerPQ/rjZXindqDTpvIr1f6Ul1xuh2sgNGTrShIYOFZ?=
 =?us-ascii?Q?aSHbgjs+vJVN7sRTXfpGECcYWl5dcumQtCCtjh4JvVxILbxWwXCsizkqDnVO?=
 =?us-ascii?Q?28RQH56Gj6ZUtPRmAaezO2Tsl7ET/dIWaO861Rd+Guyja9xwLF4PZbBv8ucP?=
 =?us-ascii?Q?MmaPtnEcw057X4FYQtnpsU4GJfY5FripVLmzASYGVDHYgro1txzfx1kh4YdX?=
 =?us-ascii?Q?nGOZZ0K+f4l53/N4v/uXbiREFWImxZq6pl7CViNmb3iXGMRoUBakwgaQI/0J?=
 =?us-ascii?Q?F7t6+sfaq713zzo5OM6vyW0=3D?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfc32ec5-e64a-4300-e6be-08d9e65c0572
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8081.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 14:55:15.4943
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: woJqPWgh14EqXIG7tz1eESOUeT3NmIxpbvZgUmkb0fIHG4VLBOan/lpWkYT4QRFAs+nuz9WUlmY+5ROCeLriTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR05MB2803
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use DMA based send operation from the transmit buffer instead of the
iowrite8_rep based datagram send when DMA datagrams are supported.

The outgoing datagram is sent as inline data in the VMCI transmit
buffer. Once the header has been configured, the send is initiated
by writing the lower 32 bit of the buffer base address to the
VMCI_DATA_OUT_LOW_ADDR register. Only then will the device process
the header and the datagram itself. Following that, the driver busy
waits (it isn't possible to sleep on the send path) for the header
busy flag to change - indicating that the send is complete.

Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
---
 drivers/misc/vmw_vmci/vmci_guest.c | 44 ++++++++++++++++++++++++++++--
 include/linux/vmw_vmci_defs.h      | 34 +++++++++++++++++++++++
 2 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index d0acb686b464..ca73a1913404 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -13,6 +13,7 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/module.h>
+#include <linux/processor.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/init.h>
@@ -114,6 +115,46 @@ void vmci_write_reg(struct vmci_guest_device *dev, u32 val, u32 reg)
 		iowrite32(val, dev->iobase + reg);
 }
 
+int vmci_write_data(struct vmci_guest_device *dev, struct vmci_datagram *dg)
+{
+	int result;
+
+	if (dev->mmio_base != NULL) {
+		struct vmci_data_in_out_header *buffer_header = dev->tx_buffer;
+		u8 *dg_out_buffer = (u8 *)(buffer_header + 1);
+
+		if (VMCI_DG_SIZE(dg) > VMCI_MAX_DG_SIZE)
+			return VMCI_ERROR_INVALID_ARGS;
+
+		/*
+		 * Initialize send buffer with outgoing datagram
+		 * and set up header for inline data. Device will
+		 * not access buffer asynchronously - only after
+		 * the write to VMCI_DATA_OUT_LOW_ADDR.
+		 */
+		memcpy(dg_out_buffer, dg, VMCI_DG_SIZE(dg));
+		buffer_header->opcode = 0;
+		buffer_header->size = VMCI_DG_SIZE(dg);
+		buffer_header->busy = 1;
+
+		vmci_write_reg(dev, lower_32_bits(dev->tx_buffer_base),
+			       VMCI_DATA_OUT_LOW_ADDR);
+
+		/* Caller holds a spinlock, so cannot block. */
+		spin_until_cond(buffer_header->busy == 0);
+
+		result = vmci_read_reg(vmci_dev_g, VMCI_RESULT_LOW_ADDR);
+		if (result == VMCI_SUCCESS)
+			result = (int)buffer_header->result;
+	} else {
+		iowrite8_rep(dev->iobase + VMCI_DATA_OUT_ADDR,
+			     dg, VMCI_DG_SIZE(dg));
+		result = vmci_read_reg(vmci_dev_g, VMCI_RESULT_LOW_ADDR);
+	}
+
+	return result;
+}
+
 /*
  * VM to hypervisor call mechanism. We use the standard VMware naming
  * convention since shared code is calling this function as well.
@@ -139,8 +180,7 @@ int vmci_send_datagram(struct vmci_datagram *dg)
 	spin_lock_irqsave(&vmci_dev_spinlock, flags);
 
 	if (vmci_dev_g) {
-		iowrite8_rep(vmci_dev_g->iobase + VMCI_DATA_OUT_ADDR,
-			     dg, VMCI_DG_SIZE(dg));
+		vmci_write_data(vmci_dev_g, dg);
 		result = vmci_read_reg(vmci_dev_g, VMCI_RESULT_LOW_ADDR);
 	} else {
 		result = VMCI_ERROR_UNAVAILABLE;
diff --git a/include/linux/vmw_vmci_defs.h b/include/linux/vmw_vmci_defs.h
index 8bc37d8244a8..6fb663b36f72 100644
--- a/include/linux/vmw_vmci_defs.h
+++ b/include/linux/vmw_vmci_defs.h
@@ -110,6 +110,40 @@ enum {
 #define VMCI_MMIO_ACCESS_OFFSET        ((size_t)(128 * 1024))
 #define VMCI_MMIO_ACCESS_SIZE          ((size_t)(64 * 1024))
 
+/*
+ * For VMCI devices supporting the VMCI_CAPS_DMA_DATAGRAM capability, the
+ * sending and receiving of datagrams can be performed using DMA to/from
+ * a driver allocated buffer.
+ * Sending and receiving will be handled as follows:
+ * - when sending datagrams, the driver initializes the buffer where the
+ *   data part will refer to the outgoing VMCI datagram, sets the busy flag
+ *   to 1 and writes the address of the buffer to VMCI_DATA_OUT_HIGH_ADDR
+ *   and VMCI_DATA_OUT_LOW_ADDR. Writing to VMCI_DATA_OUT_LOW_ADDR triggers
+ *   the device processing of the buffer. When the device has processed the
+ *   buffer, it will write the result value to the buffer and then clear the
+ *   busy flag.
+ * - when receiving datagrams, the driver initializes the buffer where the
+ *   data part will describe the receive buffer, clears the busy flag and
+ *   writes the address of the buffer to VMCI_DATA_IN_HIGH_ADDR and
+ *   VMCI_DATA_IN_LOW_ADDR. Writing to VMCI_DATA_IN_LOW_ADDR triggers the
+ *   device processing of the buffer. The device will copy as many available
+ *   datagrams into the buffer as possible, and then sets the busy flag.
+ *   When the busy flag is set, the driver will process the datagrams in the
+ *   buffer.
+ */
+struct vmci_data_in_out_header {
+	uint32_t busy;
+	uint32_t opcode;
+	uint32_t size;
+	uint32_t rsvd;
+	uint64_t result;
+};
+
+struct vmci_sg_elem {
+	uint64_t addr;
+	uint64_t size;
+};
+
 /*
  * We have a fixed set of resource IDs available in the VMX.
  * This allows us to have a very simple implementation since we statically
-- 
2.25.1

