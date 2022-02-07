Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038734AB8E3
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351860AbiBGKj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:39:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239997AbiBGKdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 05:33:41 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CFFFC043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 02:33:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NZKuFe1BF5PFtEeOghkkb/ZLFG1URcj9ANRs/Z8OmrcDoJYXJNgAYxgBcijgZew8skJremrBMKj1iv6w8bZbeQ4CkYUS5xpji695pgWAcr5iPTbVvisNzF1JaBPSOW5F5LbRvODnssJpgN5FsfYg41HJGKmiYL0mctl+zRrva40ZFKyD4dCgXT+Fv8PoKP76NK9rQrimKwnbJa9rymQbABvVaH9rCK/2rCnGjENjllRnJ4Ltj4cNK0+7wx+eCJfGqO+vG/ZvW0+ziichVIeah8bfqX7AjZpfKz47/Yl8Ag79XlXGKqAVmRPw/nYDOM6G0ckkILhzaGm5uiXk0zQMpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTPR4PJQUxJAlRnnK9reLeuWKUeOxXldnZbtGZ7GoEs=;
 b=NpEwnTwUc27SiBJTuqkoJKMOEjFOpF2OXPCs0hagOHVrEZUke0Tq5am8t7rEH4lWS6lInCUjEBVSP5BBV6B7RT1FAonqLNBcl73e4qtOPT1yjnBVCTJbeGBlDRwbnYDEdvTHdhiUY1UMQvJJVil4bBpdl6G/NxHH1G579cmEpYFcyWqcuZLfaIEL1PwoSQAwHIMuOqmy3iNH62DjiFKLrL25lIckHcXglEpe8lrHQHBtLSDY7HNv+8iS/M51RsmYPfI2go1fYPg2Yt+ltX5aPw8t7SM+mrm3WRWkHDIornptucVqp94+gPSWSIp2JWvmpOId1gznP56ATRPGYpD8fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTPR4PJQUxJAlRnnK9reLeuWKUeOxXldnZbtGZ7GoEs=;
 b=17pnKg+0X/9rg9O1MwQawj/VlEDGmJS3SVouQ6WyvNS2Pro5JebYxaOhAzRKPeMC25vQEJobtWM1JnXXGEpeDZVfnFQu4vEXMIaZjbkZtlTZ9f6hqEjzNQrvgXK5lFy0tiHDKRtksQd49PXHR927HPoluDBfi/16ycYytjhwIDk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BY3PR05MB8081.namprd05.prod.outlook.com (2603:10b6:a03:366::15)
 by DM5PR0501MB3686.namprd05.prod.outlook.com (2603:10b6:4:7d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.10; Mon, 7 Feb
 2022 10:33:36 +0000
Received: from BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::283c:d671:e4e5:31f8]) by BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::283c:d671:e4e5:31f8%7]) with mapi id 15.20.4975.010; Mon, 7 Feb 2022
 10:33:36 +0000
From:   Jorgen Hansen <jhansen@vmware.com>
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     gregkh@linuxfoundation.org, pv-drivers@vmware.com,
        Jorgen Hansen <jhansen@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>
Subject: [PATCH v3 7/8] VMCI: dma dg: add support for DMA datagrams sends
Date:   Mon,  7 Feb 2022 02:27:24 -0800
Message-Id: <20220207102725.2742-8-jhansen@vmware.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220207102725.2742-1-jhansen@vmware.com>
References: <20220207102725.2742-1-jhansen@vmware.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR11CA0062.namprd11.prod.outlook.com
 (2603:10b6:a03:80::39) To BY3PR05MB8081.namprd05.prod.outlook.com
 (2603:10b6:a03:366::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7bd9af0b-8e43-4941-4b94-08d9ea254b62
X-MS-TrafficTypeDiagnostic: DM5PR0501MB3686:EE_
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <DM5PR0501MB368696AF0377B34F78B19514DA2C9@DM5PR0501MB3686.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RAo+oDRqm8OlQxKK0vpnnHmv68avvfpPGhqvgm4FNW1xF2jh+4GHjburVSpt8WgH23QSgfc/ydMYFnLj/3ION2wENuvbjBdV25KDo7TczP2U6A2iRXyJXY739bx1b8e0Zk9Js+MYExxCyrkMFXDg1ZK+IZnX5nk/cjSY1MYl9FbbanAw+npFaRhuhMwQZ9MZv3TWi+9HbM1IFpkN5O0c8x5Rd8Felg4rsJH4LdWZxjxDvwgHVc/9uWTCugycIh6DFtfxYP5+/YhimIjkqWaxYbkIkUQujbCS1Z3X03Mz38zTjxtrqXytlDFfjc0ROhtS+fm4raYmraj/IEvFd8PkvXJR8WjfzDFNJeepYSKs5u5BCu2lSHKaQTcBi1ra1hd8KyxVBiWzTHFiluC/AXR4vUbPUl1r2sRkCBB/5RDARLF9GRfjcbEhMHEErFrBvZ9sQMdhgHznQQOHldl3hBUXdMMpd1erPt8oRk5EPelEgp3yEJMkp1Yv0NnKI1aGiLS2K69QOH55uz3vaGTU7dNcEwvFPIkd83czZUORydItprVBcYJAD5dFkV4bm64B5cD3re+mr4wG096Gus55KqTVKFi8Lx/z5GK3S9uUfkCVK3lWRnLhu0cxv6gey0mqJYD49oSiSWBoBWQFu3/0gfkHs8Ywo9yooY/4AoWGOz8IMs4qXnLkGRXPCwO6l6/+0soauZUWWvzYLokN+o/CgRgYCsRnTbETgfbrvG8D5CNABwfu+ZsZploo5lRKzBn5ppaB
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8081.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(508600001)(6486002)(38100700002)(107886003)(52116002)(1076003)(8936002)(6512007)(36756003)(186003)(316002)(5660300002)(54906003)(6506007)(2616005)(2906002)(26005)(66556008)(66476007)(8676002)(4326008)(83380400001)(66946007)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LNcZoZ6xAAu9E+HKgTv3+qmSeI45zOOrhOoor64vK+BuX7c8wCJbotzcfYFy?=
 =?us-ascii?Q?v6BXF2fF67uZXQUKoNsQe9PcbOGyrAIsKsJG5+dYBSCHeENAHGwmn7vOE8fL?=
 =?us-ascii?Q?p+2xxseVAWxUpMAWr8YkIcuB7zkWzUG7Wfr9vsQyRXo0DXftSlLY1FsVrxj+?=
 =?us-ascii?Q?KOUvLnQZyPIsMsrgQq4yvhLH4kqh6uk6ahGFXUzW2VT71vM4+WKo+dl44/dd?=
 =?us-ascii?Q?RMgiQ6l1txdgbCBWnor+a0/lDrrWgJ8tsgXkRho36UWC33p4YRD/wQbdNNmL?=
 =?us-ascii?Q?/MalABoimxYhAXeC3SLCblu1LdxnQXCHofZvbFIca//tXfUXwScYFIOAjj7C?=
 =?us-ascii?Q?KO3uZaWU2p6XOPMGMVTLM8aTmHbJ9M8suPEx/Y7fQxPKYR5OuJwewr7ZvIb2?=
 =?us-ascii?Q?lsLNqdzdaa5eouK9KiAuLXgGwqt7mkpfWVXtFKhQ5VWmUiGovlY1sLHRXMSj?=
 =?us-ascii?Q?HHCzQXvEvG9xbjxFRdCnguNIZEy5SCeXcMnsJPnshosSI74ikqfsnu6BJnwq?=
 =?us-ascii?Q?roXB2RMrryYccZIu7KCveEYWgSrsxDCukNAh8LG6JdMkpj7Kx7iOLGGofQ0x?=
 =?us-ascii?Q?pECzJ/WEcN6DH4K686RkEf582IXdJrKr57XeULdk/NIFZh6XhJCXSpTiGO0F?=
 =?us-ascii?Q?43JrMqv9wx/9FxRF+vmqhE+5hnokjvnozGVzTLZAlPv9DIV3MDq3m/PygBxP?=
 =?us-ascii?Q?AQWHwMoEU4F4XmxN5V8W2CHXJy9G7Mc2G7In0aOND9oVUxm7Bv51+O2vZx0a?=
 =?us-ascii?Q?Q2rJ6tNzlRL07581YIl/AdZAONT6cZYxEXhmljSl6HsM0sR+LoihftBhngYz?=
 =?us-ascii?Q?0G4xWppqwMbujKBAwYfpsVScl99QYrx9cTO6aNogYo5cBeC/Ca1gTrQRoffg?=
 =?us-ascii?Q?23YsSgxlJVuGvXZz4WsSTUYjx8pRosnbASJKKIJbAv2MqlS8OFbDCvQJzwaP?=
 =?us-ascii?Q?SV95wcNuK+tWneE2nkQUtLL7whfID3QhGwP/qhavMi9mWbDd+1ZAfEkSV1WB?=
 =?us-ascii?Q?qgUGxiwsaAl6tSypNEPRArxL09AKFZszSBp2jAH1t4sJDsEo6zdDFfS/lrkx?=
 =?us-ascii?Q?uhNIcwXBPuEJyylUm/yfva0MXUF464aulBqVg3pgTlpjtWIFt8JCpDUC7AOd?=
 =?us-ascii?Q?eaBIjh4qiQiyR6hDKjxK3F8hzTwofhsqhuSLWPMJp55MYRz8Cx52/rdIJqPu?=
 =?us-ascii?Q?M0Ag3w87o3sCTS8OP6n+vv5kjEfQ+E9TB5HLH3Ph+aRexq6foQEkJVUy6P47?=
 =?us-ascii?Q?OFlkXOFx4hyDg2PPMffdGUyVJR36PrvFzcEJme0xQU65yYOoqFr9tBV1XY0E?=
 =?us-ascii?Q?RGApXpqxbCf0P9ElWsybPm0S+vPHZS8Kr+GwQ5/xMaTU/dfMI/F0JQToQTp5?=
 =?us-ascii?Q?pZsHjG75tBE4Cxdov5wuSPf3anInEsSwLe3t8rNOED3aLhbpmnTZ6ioo8+Ma?=
 =?us-ascii?Q?FemAuVxymmYkv0exQJVIwBuEfGFeFQzmUVUAPKLBfo7A2L/6wMfDjsgKut/Z?=
 =?us-ascii?Q?zi1/kgtMFJcBc9vpjubQ1F9a0Tt1M3ow4UrAK+kJCctTxF5kQjBjPWpTCxT4?=
 =?us-ascii?Q?GfJoiqWjj23M5AgTkNpOt7Bg+S2+pslY1bvy3KKSaZ7SkGC5b3lboVQPwdlG?=
 =?us-ascii?Q?GbivzufXeAL6czDBtdjpXhw=3D?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7bd9af0b-8e43-4941-4b94-08d9ea254b62
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8081.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 10:33:35.2039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e0uskUUx3V4M3YYJucKcSqQYV4nNR2BAV//lkdHpwtvq2Ef5N2niDdDvfSJXmup/CYEDeNR0rEROpIqFJALT5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0501MB3686
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
index 36eade15ba87..bf524217914e 100644
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

