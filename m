Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 163744A8511
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 14:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240681AbiBCNSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 08:18:38 -0500
Received: from mail-bn1nam07on2061.outbound.protection.outlook.com ([40.107.212.61]:24580
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350750AbiBCNSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:18:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Oc3mWvPnPBEiRJXwzrQ3kDBOBqw4bbm4iRdoPldYyHHMMW1i61ohKkH1GAf1y9BYjtaIHsdrjtabgyxhWeIsdfIXspyp8uqz4xEraota7ktzvULpdVXnmJ4dhzHQSYGXw2ohGzLFVWFswGwoxWur+86HkKC/livI8PW5iTE+RaF8QS/OjvoC1jp+3GMVRS1kSfeF7P+zEN15G8jK7zjNsS2Agt43p28vNvjoEqILY5P8MfeSvYq92qbuTykTdoTiK4+AC+3dESUpg5nG7I/tZ5UGk0WLBYY49OicesovyJ5nj5RNXcCIx7Mh7EFd+Re0l6X+fN5gR+pYPgf0W08UNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l4JBGf6X90A55/xzGIGCmoZWgEYQdX7TmRGB45StAIc=;
 b=IdVDZPiqZ6O0J/pqVZsOxQRKtNLI7vq4AtCfcOZgGgaY9nmnOSW4irMs2KipjzpwsFzIp2KTx0MIi3bpbVl31h3FGVcU6YPjUXxfqFoVBwOCWljMb4e+1E0fVxuy3xruVKLasomw/bnUo7WxulRqM9pQDK1do86YIwui+N5igC/iO9dVxPNEON+6hKFWAYsxAipMCxrbgHeEo0BEny8zDmA8+9FXeiNB1yTQyUnmorFWXOtjW//fkmGUOO0V1ZvCuT51sM65ynYjycXtbGa1BGUZSfSDMwfgnYJIv9s1PGPXBJCtmXgARPLFnA14s98MQpgXgWgS9W3LiAbX/9la5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l4JBGf6X90A55/xzGIGCmoZWgEYQdX7TmRGB45StAIc=;
 b=FhA1d0T1DXP43jMuxRjLI5cHA09TxwQkBqczmkGEI6+JiC0sqE+pOW1M8wrmjG4GrUoC1/2JUnaua/+DrV3EUUD6Nvg7uw89LdF4qZSxsqlkz20F8oiwbrSXmtvCzhF3AC6gxGTy6ymu5V4/XUAUgjYIMfumFCP94tNeyxVRVBI=
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
Subject: [PATCH v2 7/8] VMCI: dma dg: add support for DMA datagrams sends
Date:   Thu,  3 Feb 2022 05:12:36 -0800
Message-Id: <20220203131237.3380-8-jhansen@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: 34e4edb8-9050-414d-daa4-08d9e717a3a9
X-MS-TrafficTypeDiagnostic: MN2PR05MB7150:EE_
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <MN2PR05MB71501F656DB7090C1424F901DA289@MN2PR05MB7150.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QAjL9fTgOKROW3ME4pe8GY8pTZ6Eh9mMXuPWwX8HU2bELOy+wHI1r7Rv5ugeDQGh24Uyq76ECB9LtSVodKWfGxsBR6LFyHA37mE/C/1EfjG/sJnjaNFGCaDx+obPoVEqB/RzoZHGcWfApzJZuy/rDCZ5I1qr7OpMKEgXRmJLQp/aPTYquKuIQkmM6GHmI1DIGvPDSOxuv7Xm4cOzHbnAuBZAsYD6fIZtJAuBChcisbmL4HV3I5hbud0VbTlmB4x6Cmg+Ptew14crDkqvZwZJqR4GlBd2HMlWIppFzTFva7jDkbcBU+h8nGHb4qJQlCWJ5aUEb20vebxaJXiSMyKXtIDtYaOWP44BsCbFEOIUvFq6AhOVlZiUnVpu5nrzxIb9qd+ElqtUV8tWaCN+LfqQSTd8Dh+GGJGlj23bLm0XPB/7clLUQCsyHKKDmpFVrkusi9uwX7CNsCGRbZGP3Z2PIY22hxhSg2vpN369cQICLBGoX17lbYnF8e3u7ngLMCUiPDN/8u40MeoQ3is/Wdru+Ajbaw3BXev7PY6jNmm7gT3Frcb6eSEw9y9zHTgmRH6903ObT9nA8lwi4aK7YSWtf/IpfQPcTHLz+H3DSmVa3CZ6LySE4jEv6meW+sYUWXic6LhQFmu5tG4HkOXgX6CHvE8E3/6U9dv0PUXHG+gCFULHIohNr/4+tQx2Bt/DDs+/1o3b1RETVidnTMekkeftrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8081.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(8936002)(66556008)(8676002)(66476007)(5660300002)(4326008)(38350700002)(2616005)(52116002)(66946007)(36756003)(38100700002)(186003)(6506007)(26005)(2906002)(1076003)(83380400001)(107886003)(316002)(6666004)(54906003)(86362001)(6512007)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pYcdKsqnPOHc12vmvh1LaHIuMM81aPT96DhL5jPtddl6ov4tCNnG+0AHK7Hx?=
 =?us-ascii?Q?nSZbA/NIlLwfXuc9xDkbrxbx48uQ7XfqEKPSn2ELqnuZJP3zsZ1sWPs5wU6E?=
 =?us-ascii?Q?u1Rb7JBqT6qXR38ILSMCHFj/yuc2UgUvYfWw7RtAzMXODfsqcC8kUV/xyP5g?=
 =?us-ascii?Q?HQ2W1aB5v53a+bsoim4rWMViyQKFnqWd21++hhZKn9j+IgCY0rdFXh7InZWf?=
 =?us-ascii?Q?BHKe5RwS0jrJHGrA831ktd8tbODBkIs8i5d7A729UK9O9EUt6PqWrY+60/A0?=
 =?us-ascii?Q?MzCi+cp9tXovLYPmZU7jbKcb3yatiQRAoj+BLD4VGG/LznnHalZFJI3ALkrv?=
 =?us-ascii?Q?ZX+CdN8xe2Niz8LOaKW3kgK0djK8/53spLP5iH72V3w+FXjvyAiZKqQ30EIa?=
 =?us-ascii?Q?D5CgWorwt5PanAq4Y37jsGYbeAPn88Idk90x5YLG64o18d5R6AOtvkoJFdL/?=
 =?us-ascii?Q?YWjMGSLz+T9gfrEQE16XCAu6z4CqZyFc7KIbT0E2L1xY6qjrs+82cr/5J3h7?=
 =?us-ascii?Q?741BS6ZKG6yOLgMwFW8tarB+VhltnB2rZUaYhOKn6sFgXau/wuLJsXOpmQvG?=
 =?us-ascii?Q?XgJbFyjirUG5/urvfxNUk0B1vA4BTXpvk3v/x8mwuwhFuPcuuYFJyN3o9Rkk?=
 =?us-ascii?Q?bN5wBd4cchdpJLU9ioOZZ1LjR4y8tdV+i1N2pPPqh1U8RnFS7HWLWoyk8vag?=
 =?us-ascii?Q?guwsfX6z51vEkVsTYm50aXFfh5zIGRB/U3w5GpmAxdr0prTnn84dLQBpY1Au?=
 =?us-ascii?Q?De5GQ0skDmCV0iBM7HvcKtgUWGjzO9NPC047xNpVj2OhxgKDmvlIRHJy0F13?=
 =?us-ascii?Q?7wdfKXxA9k13c0t2c1IzhtStSnzT3V/YYXZICACrmffZjq36GbnPGR2hT8Uw?=
 =?us-ascii?Q?yHEx3y2/zh3GNZRKPlpJh6h0wqcPzz2aKYhMpz5se1PI9LZv/ex8NTRExccA?=
 =?us-ascii?Q?Zq2OXNz0iQHsWQhbjGfQ9yQ/6mvj5L62pYhO1jVtG8rBYE0RiBjptrW6RwnH?=
 =?us-ascii?Q?h69wOzZiN2iy25hVop1J/emUiY9cfgL2GKqthGHccjvo+sEirIyswVG9ykOX?=
 =?us-ascii?Q?HzeZfB9UhN8OQQB3GtRv9kZwJcQK6lhxteoe0a/lipdzgos+lOdypY6Md2/Q?=
 =?us-ascii?Q?NU7MUjy4J7Ri+AyuNh+GJKOLn2nU8SO3udvBF5G1yDxADa1k84eHFre9gjJl?=
 =?us-ascii?Q?sGMg1mEgnfepSvB9CnA6u55x+HvB3KE2UwvHbmaBVfl7gqFVZ5otOMWlUjef?=
 =?us-ascii?Q?ltHUrOdbDuFbe/BHWXGGJ8+NGRb7hwZH0cPsWJ+uCoTZFWGshPAuJZjBPMQZ?=
 =?us-ascii?Q?E+1pvchJXfrloePvffEWIZUkAAeG7fYcKnaiYzH3tb65chLBJ5US2QlthRfP?=
 =?us-ascii?Q?N55UjVXiltg7+U8ekrWoKXmrM8gxnzyVFUSSYLnqIEH9hp7GLV5EyH01VQKV?=
 =?us-ascii?Q?2UZviwBua5/AlJbCXLZxDKedii1GpAlGUPCUIGq8kkoO/FErpnSFbz1VQ9ux?=
 =?us-ascii?Q?Lkkk9NliUNsVv1W0OMwwg6qshwA8nRYbpF13G/5w0kZd2sKm9vKj1Q/s/opp?=
 =?us-ascii?Q?LPp5+wQPcahOVcPFMPlxZBmxRRx8TwsCyb7aQr0gI/L8TTx+/bReCIbPxZcg?=
 =?us-ascii?Q?Y9Fjm0+anITUqhl4trkZKZs=3D?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e4edb8-9050-414d-daa4-08d9e717a3a9
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8081.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 13:18:16.8529
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S5ZoJfRlUXR404TWQf/HkmLjL53OkMnFKGAPXBfY1cl9AAR8h8BO93Njj335ord7pMVEvDumo7w0XTf4Mpa/nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB7150
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
 drivers/misc/vmw_vmci/vmci_guest.c | 45 ++++++++++++++++++++++++++++--
 include/linux/vmw_vmci_defs.h      | 34 ++++++++++++++++++++++
 2 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index c207ca2ca42e..ae2fd9c791d0 100644
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
@@ -114,6 +115,47 @@ static void vmci_write_reg(struct vmci_guest_device *dev, u32 val, u32 reg)
 		iowrite32(val, dev->iobase + reg);
 }
 
+static int vmci_write_data(struct vmci_guest_device *dev,
+			   struct vmci_datagram *dg)
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
@@ -139,8 +181,7 @@ int vmci_send_datagram(struct vmci_datagram *dg)
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

