Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AB6D4AB8E8
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351004AbiBGKjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240553AbiBGKdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 05:33:42 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A81C043188
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 02:33:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j7WCzkpac7Nn7BkzF26B3fv28OG0sETsrYRw54tjrCpLYi3IpaQbftqdVti5M9SWmPp66HaMPbwUJC36hTQpIsScgOCIWd66ZVpELBaCW5iJvOO5+2+46fbjB7fTHpgwaUXC1uco3C9oH/V+pbef3kUQZdupfVDJleuNWGX/ocuI/+5EfwEUrae7Vs8hc/G6H6lhd8vPXWzZFbfeHsbSnNRWjN/762rMsxGa4e79QJ55FLN7WR/tWcXahmqOkdAPDq0bp/ncYaLdKsFwCnT1skYk8sr48r9latcb2JyZA6jH41I1GCt2Y3brYw7qP0lRIlRsHGSOvaFsjbG2QjKKUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=meEPJskUZkr7KbVe80MxtwxPWV5SCRouHzmvO/WHX+c=;
 b=aIXCYvacUBvDENPp9jKk3SEBxFa/v2zSfeLnkKg5AioF7r/SkRKMggzlpNUJW/FuBBs3mPMVJMWoSi8yUk1Nkn9m+fFlb9GroXEeQVcAaa4wD08psin8e2pwRUmgCV0cFBEEqwoC4+ruIxLTeAGaWkt3MV357/B9+vNivPwVhQg4sYo609138hTBoFbMkEzFySlKPnqJT5saA/DIulCUtFyhLsvQMsHktuqHZGIt79tFOmqHn9/vgMB0q1Y05sAWBawaEkdtcsjdKZenjZus1kn3j10Jw8SW3PvYtd5QkNWm8XkDkIO/VRHHmSA9njZVZ2KabJSJ0Zckzp/gzoyXcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=meEPJskUZkr7KbVe80MxtwxPWV5SCRouHzmvO/WHX+c=;
 b=vO1+xJbfydcq1ahUu0tbKvtM3Et/b7qEqxjGMYx3KW/zzVzDm/a0UYrRPLjaVAWKwgCxPYKgsMiUG1rUyEnDorMxnY/I5OLB9GmBk/dY25SvLby15Y2YJi6RKsTt8ClAgGS6njCTSecZKyWmehRwyVDwgb9tnR9/vgJah58VoiA=
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
Subject: [PATCH v3 8/8] VMCI: dma dg: add support for DMA datagrams receive
Date:   Mon,  7 Feb 2022 02:27:25 -0800
Message-Id: <20220207102725.2742-9-jhansen@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3e6ff06f-db30-4dd8-ff8d-08d9ea254ba9
X-MS-TrafficTypeDiagnostic: DM5PR0501MB3686:EE_
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <DM5PR0501MB368617A3517803DE825F1900DA2C9@DM5PR0501MB3686.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1122;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sRIkjWlWy6iugkhK72DLfGMjaog1qHBBWgEsb8s8yoMkCY70S1p+bTXr07qwDnUKjcZAVyjoOF+H1bhkQbFdhJOfufRGoCwwcEXDrKaimts3NYM0EKTKITF0FVdQK3lr1j8xs5+ITMo1PP2uDcnAzURNsm7zvu9Osy947sAtzNH7Hbh+j9Ff04fOhgiYZg8klYc/vhpye8W3iQ3WcZ56fIsBb3ifJbMvbkg7XZ+6wTScUcCMwarG8O8AAW/2UTROmB8EAyYBgwAegx8xIoOziOARWDHPSx5oG/BIOscLFcFjnQS67fnXodLy7tZjW94sYF/lQitmBiLdw8xBDpC13vvl+NcXMItC6hdnFMsCZ1E0fNprcFBG/CY5DrbYD58OoTAKxzGjrtSeKVOa9C6EVjkumEwpBhm5M03B7bdkfD7uu23NDe0jtPLr1wcG5jqU5VNAefb4aJ9d1McgGgUY/CyNEZR6d8Q0PzhWi/PH5gtl9jkPb+3/ssDu5pNNTwissJNBVd+WE3jHKuP38ylLyK4duA54pDHwhCPg6ZCPcQuJtq4SFvRoafaixVGOjQ4LRTRQXmnvEqjFbR1/kmmA46gwKChuSNvDbne2Vou63ojsv+paH/tK6yofV0V6VN/FgTznEEE6b7LIXrvtmAV2OzS5F0Cl3EkW+qPkM0n+M+AaavSeTNYiMfX6+TpNIbjWAu8rZ0Cat7xUPPc8PU211Y2Fk7dF+2L4yu9AykmL2+S+HcXbNr08HBCcIQVhBsJ3
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8081.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(508600001)(6486002)(38100700002)(107886003)(52116002)(1076003)(8936002)(6512007)(36756003)(186003)(316002)(5660300002)(54906003)(6506007)(2616005)(2906002)(26005)(66556008)(66476007)(8676002)(4326008)(83380400001)(66946007)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?As+psYlgQU2jFOiIYJY4j93gJ3w8r8YC2ypy815qlDY+9fvlRPdOjhwtQE2g?=
 =?us-ascii?Q?RFcVAX7XL7eBkB1+y2k089IShQfZToVLU5IEK0wrldTKOeegDbD0SfGFL+4N?=
 =?us-ascii?Q?ETYo0aH3kVFFYDuY9eGb+6rFoW1i7gwUqXz0+cKI8xbYxb1+yxtkcfTsG8dV?=
 =?us-ascii?Q?WzsPWWFEUZyqLbptL8jkY+EzIfnf4BIlLfGCvBTsSDGl4R6Ymx1UA76wQXHg?=
 =?us-ascii?Q?ropXNOaedK9b7mHKiY6OdhevsyXlccnRg5NCI31laj4VG7V+rCz2QrUGqFig?=
 =?us-ascii?Q?KE8blBpfgUpArrMztyyyhPmM/zlAtEoJTHqTUL64aBTjf3jeKnondIDBXhaM?=
 =?us-ascii?Q?5vf7L1akzcbj125xu4MDtsU84fdol5JaqnhpOlTFvyoGfGtrbxpyQLx8weNm?=
 =?us-ascii?Q?o6lh9OLLbhhOMBmgVKSpOEdS9WWL+NFhp30zoWDPaUhWFo+Igyy7aw825XVf?=
 =?us-ascii?Q?oh8DuGQXzK/s4PH+G/hrU+Yj6rsL+1ybk2hlxMGwSi8TREoqeZIV6KdszAmf?=
 =?us-ascii?Q?W0kHo3t34AFWZgASI83NnlC/X0eaeNBMTGvXdZXc9dlwJQXhEQwGz2z6oYdG?=
 =?us-ascii?Q?C5hVXv2/pFKv5YIb942MCqOdIAq35dVAe5XAvJF7Zb7fcHO3bAhXZNe3qlT5?=
 =?us-ascii?Q?el6uEE2jZuPZsBWrhceMdzlY1yOPGr2VPiwkXHh8ypwsOfZQRKJBFeHD21YD?=
 =?us-ascii?Q?Y/plT++ykRz8rW+M23FFzftYzTFmwwA9mm1JOXvGPHfEwEkGGYwOIWnC4oHQ?=
 =?us-ascii?Q?DepsrTZht3BzhpYeW3Vpp/CMZi3npGbH110b3cNaE6nQiGpkaFWsyI/pDjq/?=
 =?us-ascii?Q?JMmNEHiMCZo3BRBynOlqqR16bOeXw0fsdvJp/ChaGLV5mXwAQBT6S7Y1NJMR?=
 =?us-ascii?Q?K2KZe2K62ut5lFM9g/9P3klbUuWuGUiufuvHTVY6rrTWm0Cub4vwqppkmucl?=
 =?us-ascii?Q?FGIMWZZ3Y9eEzYsvFKzuD3yTnaXSdEr8n1G6MKkoG70vxHSYME4pdObsMamB?=
 =?us-ascii?Q?pGXkbE8ob0dw6gBdSzoMHRRO9CM72NeG8qilG9+35DQUQBvzSykceyVBSc5z?=
 =?us-ascii?Q?POfyiD8jE8jtkN6p8rkcRgi9tukm0K2wDJKwINEaT3msD5zOQDdh+NLTTdLV?=
 =?us-ascii?Q?bZK6B7FBpGF3m275aGl9nw254d2KqnPEK1NAkv/nO56XLcxiJFAjMqU8PD8/?=
 =?us-ascii?Q?ncPcXI9dmlW+6wU/AoRz1aUU/7JWAqtjRXogmX3nNGEE0fBhdv5Tvp0PKpPd?=
 =?us-ascii?Q?KYfdqndw8aHsPrE/ZwzMsZh1+v9yh7Lxmn2u+16yLkECjpKTz/0HnYSnDtZ+?=
 =?us-ascii?Q?Wca1Lle/z8rThdf2/BdW9Q2o0IqdfW1rffBRgqP4CV2Es9YtQSv4sqpm1oD1?=
 =?us-ascii?Q?EAccV7FqLwOLcX3hIaStWP+UE3DD+KaoYF4NY+p+TgEQwIrNVtmpaQ3Jql0p?=
 =?us-ascii?Q?jTK+AiFTRNqzN5943KzqGlbg4E7brq4j/8UiP6mK12sf93rBx/PR0FE5IXKj?=
 =?us-ascii?Q?fDLaK4efu55TK62HmQyVQbc+n4fVqJ4j76L++gvaM+hq3GEnKtB6eDn0o99A?=
 =?us-ascii?Q?94iBzZZaaB5h2gz0moOvoodCzDhroQ2WaHB4yBYtbGHrkutP3L/J8+dyEdOW?=
 =?us-ascii?Q?jqbrIJ/MJe3QcD03yfjIvaQ=3D?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e6ff06f-db30-4dd8-ff8d-08d9ea254ba9
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8081.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 10:33:35.6725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TYWWwfwS8c2odnSNDsV6E6uRiDMqKfK1R0LOBj1CkmhUDMITZ3jJUMZHPVgbmUETi/Qc1Vsh5jtRmUDHZ4bo/w==
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
index bf524217914e..aa61a687b3e2 100644
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
 
@@ -584,6 +638,7 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 		     vmci_dispatch_dgs, (unsigned long)vmci_dev);
 	tasklet_init(&vmci_dev->bm_tasklet,
 		     vmci_process_bitmap, (unsigned long)vmci_dev);
+	init_waitqueue_head(&vmci_dev->inout_wq);
 
 	if (mmio_base != NULL) {
 		vmci_dev->tx_buffer = dma_alloc_coherent(&pdev->dev, VMCI_DMA_DG_BUFFER_SIZE,
-- 
2.25.1

