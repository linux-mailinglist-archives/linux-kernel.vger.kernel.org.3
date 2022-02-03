Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72A74A8505
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 14:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350755AbiBCNSY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 08:18:24 -0500
Received: from mail-bn1nam07on2040.outbound.protection.outlook.com ([40.107.212.40]:28852
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S242379AbiBCNSR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:18:17 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dmrkge+e59HzyErIOREGnZI0INchgNI4jFzSFu6kAyGHOfUu3dSGhTfirIobVmvUrr4JdC0Fs8FyRBm6fv/ie7ptSJRVhK7l3TUhzcLgEWIzIB1v0uAKQrOuqkAbKAvBzKTHLcDVdj8uR3WWXeUOl2U3K3l7WC2L1k+pEhzaLu7ZpIb1DdRmjVNROmMN/uTOXnj9GrDD/TbLGDR0Judb/jKos9VNDAUsFU+E6aIuPyj3SK7ie0Khbzc6Y2SDgBiDKT5X6O1OPoauPFpMT2NRSbYV0y2x/gGljMuKdR9YqiTHQ2YbYKYAQWD0xgEnU23zGjxWYK8jo16BgJcA9rqepQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5vA+vR49W1cEcT+aGNL8VOwqHNoPUPmCWlQeXyt/2Bw=;
 b=QayjDPBitKtw20Uo05+T/iUE9c5VGSbeaUPpjxqfgBKXT6qJic9sQNzObwqz7rAfuLOF7m1V3x8/3p4ZyOfAUcs74xXrzTcYQd9Vn12n9Vh53QAoixGX0b6mGMT40cxLePBhWKXwB9KNjwclIDScXK2MRKCXrfq01pWNRHW2THTcNU4LOm27C7F5qZ+jtzQDikULUblf0nDF7VX+HiLLP8NSiLpNGwHAAjm/NyYKXp6sWTRA3hHyiYwkM87Ntm+WF17oCH9zpjhv7OeWd79pZSjN+XjhUD94MTcawtnoGeSsEqbAHPmlFpd/u2DeKV5B9Tl4ZnWZLEN11k66bKCSng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5vA+vR49W1cEcT+aGNL8VOwqHNoPUPmCWlQeXyt/2Bw=;
 b=xU+Zmkogs0NLZkFUYekjCSslXfGsQwOrR8IG5ozKKO6uEra8TTayYqeiacFmIO2TRsQyx6cACkqx91Gepfz3r4LEih5ei3dAlVxEWPJBy9yfpRc8Z0E9Ir3buJKGzQGpkM8veY40a0GL3cLT9yBlTSdbiBxiOie1VclsVERnJAY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BY3PR05MB8081.namprd05.prod.outlook.com (2603:10b6:a03:366::15)
 by MN2PR05MB7150.namprd05.prod.outlook.com (2603:10b6:208:18b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.5; Thu, 3 Feb
 2022 13:18:15 +0000
Received: from BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::304c:2b94:4f26:a581]) by BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::304c:2b94:4f26:a581%3]) with mapi id 15.20.4951.012; Thu, 3 Feb 2022
 13:18:15 +0000
From:   Jorgen Hansen <jhansen@vmware.com>
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     gregkh@linuxfoundation.org, pv-drivers@vmware.com,
        Jorgen Hansen <jhansen@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>
Subject: [PATCH v2 2/8] VMCI: dma dg: add MMIO access to registers
Date:   Thu,  3 Feb 2022 05:12:31 -0800
Message-Id: <20220203131237.3380-3-jhansen@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: a5e4beb6-fd6c-4fe2-92d3-08d9e717a28b
X-MS-TrafficTypeDiagnostic: MN2PR05MB7150:EE_
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <MN2PR05MB71502102514489AB8BFE5FDCDA289@MN2PR05MB7150.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1P+B9Cup7XItfptBM+NnLMLNA+Lp/GRHRF9NrWI4y7Hgmc3S20JEuidgV/vHRrTUspA+b38m2Ha/RNQ9X3pJ776KlfBnfziCjCePXyxviSMIYyuTZ42m548g/RGBJyceYa7JWewgeUxSIMFxXRiJZxufBbuQOiaEyuEfCsqGgsfClm+mvf1XEHCy27yambp1ckOGHBoRm6sAWLB8jWP4whqwIhYGtnWkt3AsZEOtzCRKTs9LlHjejksGXScnDvhPuZVGafOqZ19zi+vx8DhYb84IQabBQ7buaeXnZD0hFxxGVvnacscxNRlM8Qp3XamdYB5WDJvFREcMRuvLwshKngA0RwXt4bv1BaymYuOmzo/1ckSOg7z8/wEVusaLK781r/wv34rLy6XCvuWj8zJfKyLnkd9T+rhQAiZxgWFomuDi2yQ6Sg8TsKhE+lL0Jlk1lRf2ymvHqlcA7m8KqmPVFfRhpGFvtPfTt2Eh5ON87Cm4qj1BFiaXKV1Su/GKWHLLKy3DGsQJCPCVII//GovkpB0Vzo24sEm4Z9dodUEo0svjmXOSw/7ICUWREj/hrqpfGVGKeu08sdaRszipk9jnFJGvA8GuFDn+oPp0rCXY2p28zDbda+ZIO10SKcPAuTOEsyl+36RMQhVI+0r+phpxA5c1L6BWrfjjlm8mBcSlgKvubOAzSTNLXcruhz8zok9jr68q9dg5W6YHy0T9S4w9Iw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8081.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(8936002)(66556008)(8676002)(66476007)(5660300002)(4326008)(38350700002)(2616005)(52116002)(66946007)(36756003)(38100700002)(186003)(6506007)(26005)(2906002)(1076003)(83380400001)(107886003)(316002)(6666004)(54906003)(86362001)(6512007)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6YGhdF9+oB/y9CDwDl3Bkd5XuPVX3DqZofASVB6LpJoj6smtq+P/YDGND/5k?=
 =?us-ascii?Q?FXGXpohL+sUFGfVg7UV70aAYFYtRidHYpr1ZcoqLhCEOZ04B1Pka66GJ7MA5?=
 =?us-ascii?Q?8bVst0vgCZHp3qZGZ1LXu7FhSbLJT2JzoZRhgU+Cy4H105+2FxckXxgEjWmD?=
 =?us-ascii?Q?6YC6NOALB+jx/WVg6ZP7Ei+WoAq33g5eAVUegFU+1w2ymk13jVkCSyvXQdxl?=
 =?us-ascii?Q?DgXtN92wiTvTNqHJCEws9hVT6iZHRJaXhbI/hWOB9PzzkyjAYxPAyiwRiLww?=
 =?us-ascii?Q?HGCemnOSUfG2nzij5V4rtCMokfnF//gJEP+Ry/gGRCn+4N5BxruI+uQMEpaj?=
 =?us-ascii?Q?V2ve5rJguwYYed56l85LrUkUjdzs3wR4oA5zb/2SYeb+wNIKo0pj3cVkHolM?=
 =?us-ascii?Q?aQ7srCK7br8/p37qIN4nBz1uGZnQ7nQlHOSnG+Rky7BNBSrnSAF6AfcdTWPS?=
 =?us-ascii?Q?6tJhuxg1bKsJ4c5wqXhr+/R/LXkNxWAaqHg3sJCtTGarlEclViWyEL/EY4J0?=
 =?us-ascii?Q?Fpx8SdPAX4wAIShCrOo9EZRz4r36XS4cVxfo+qMOXMcguU8cB2WUQ4sOflBT?=
 =?us-ascii?Q?Rj7Ah40vhoxr12GRv7yAbvfHKVNGGPyuSC7A6Pp9JcyVqpULR5KPkJKcVsLZ?=
 =?us-ascii?Q?ppqQqTWwnIxI5x8CBOkABpv7JLg7qbUc3jqKmVNstKEHsiA0cFxbT2UbQeQ9?=
 =?us-ascii?Q?YhaCMkF5coziq1i998GYGrVneAwH9c5+0u6Kyp5P2jnNyMCoY3VTl3fTEXZf?=
 =?us-ascii?Q?JvB2ylMYzjaE1SG7uUB5oNHjAF1ofL0A3xPZRCcod3cWZsaXuY4NuyoYWe1U?=
 =?us-ascii?Q?IWiSffjrKXhLwg7Ye/8Tc0Br4BnmqaXlV7h8J1+nS4HHVP9hgmnJHlOcIHkr?=
 =?us-ascii?Q?CiHN636N89zyeqfAzw//iGdBMWqrrUsmMOVvGlHBWnWDBsSXeyvtuyiaOsrx?=
 =?us-ascii?Q?SgA2NN6MRQYCKpqrkPyxdYNzDYL2rfxCoGZrRd9POnNJa1ao+AQEv06wzSDZ?=
 =?us-ascii?Q?KAtMH7cwbV1tc6Kh79+BhAMLg1590RHlSuq+7Km0ZQcSh2cYd8hOTg7e3Z3l?=
 =?us-ascii?Q?Y7mm35eET3y0UhTHo5joqFuaeHBlCtvw8mjx0C4LR+H5HdW+CBxy8DlLPgvb?=
 =?us-ascii?Q?hzvChzaCr+1uLF0HhQRimbuTQl+xgFOBdSXzh8KCWeN/dSZO0nvlmCz7pvaE?=
 =?us-ascii?Q?BaAmX21eQWWChZpaF5dVkh97b2UfAth9MvRF0vLXfx8CARi4pz9CUPxT0g6X?=
 =?us-ascii?Q?tzQx4K/pdZgslecx+n6TfFZ0mLh02lIWR8RTHHlSgf+yO6KxP590ahliKMBO?=
 =?us-ascii?Q?/myupN+Pasxi7HMOgBE92gsVcBp6Pnw8rMM5Qshbk0IwShEiThG5L/SLx8VI?=
 =?us-ascii?Q?rql17BAnvJyfD+DkeeNjCFXhi8FqnghqgPt0qTkcWaaulJ+3+hdlApGfWHv/?=
 =?us-ascii?Q?DeprGMDnnfvRVG5ntCCJNGrDRCXd+icHzE9NTyAtBXQEwjJGUA4nVma4LM5Q?=
 =?us-ascii?Q?FE1AtuN2xIUd3XBPWj9nmFjc2TvwCPgMspp3MgZsA4EiEK3Eoa04RjGwe1IC?=
 =?us-ascii?Q?CoOtZ4+iJOE0kdN8W2MW5XQufVdkHH/qUCW9XHyLVbup8asZBBTaIFfcGfgm?=
 =?us-ascii?Q?d8zvJX9WyUt0In/WNR5HU8E=3D?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a5e4beb6-fd6c-4fe2-92d3-08d9e717a28b
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8081.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 13:18:14.9143
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VYjH9zE8uKzaaCcbt2lHLd3OeruLSmbxQ2HR/J+euBBjoI7320iCBQJbq9KJ5ZnV4NvYQaHOoEngvXP1KpdeNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB7150
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Detect the support for MMIO access through examination of the length
of the region requested in BAR1. If it is 256KB, the VMCI device
supports MMIO access to registers.

If MMIO access is supported, map the area of the region used for
MMIO access (64KB size at offset 128KB).

Add wrapper functions for accessing 32 bit register accesses through
either MMIO or IO ports based on device configuration.

Sending and receiving datagrams through iowrite8_rep/ioread8_rep is
left unchanged for now, and will be addressed in a later change.

Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
---
 drivers/misc/vmw_vmci/vmci_guest.c | 68 ++++++++++++++++++++++--------
 include/linux/vmw_vmci_defs.h      | 12 ++++++
 2 files changed, 62 insertions(+), 18 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index 1018dc77269d..38ee7ed32ab9 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -45,6 +45,7 @@ static u32 vm_context_id = VMCI_INVALID_ID;
 struct vmci_guest_device {
 	struct device *dev;	/* PCI device we are attached to */
 	void __iomem *iobase;
+	void __iomem *mmio_base;
 
 	bool exclusive_vectors;
 
@@ -89,6 +90,21 @@ u32 vmci_get_vm_context_id(void)
 	return vm_context_id;
 }
 
+static unsigned int vmci_read_reg(struct vmci_guest_device *dev, u32 reg)
+{
+	if (dev->mmio_base != NULL)
+		return readl(dev->mmio_base + reg);
+	return ioread32(dev->iobase + reg);
+}
+
+static void vmci_write_reg(struct vmci_guest_device *dev, u32 val, u32 reg)
+{
+	if (dev->mmio_base != NULL)
+		writel(val, dev->mmio_base + reg);
+	else
+		iowrite32(val, dev->iobase + reg);
+}
+
 /*
  * VM to hypervisor call mechanism. We use the standard VMware naming
  * convention since shared code is calling this function as well.
@@ -116,7 +132,7 @@ int vmci_send_datagram(struct vmci_datagram *dg)
 	if (vmci_dev_g) {
 		iowrite8_rep(vmci_dev_g->iobase + VMCI_DATA_OUT_ADDR,
 			     dg, VMCI_DG_SIZE(dg));
-		result = ioread32(vmci_dev_g->iobase + VMCI_RESULT_LOW_ADDR);
+		result = vmci_read_reg(vmci_dev_g, VMCI_RESULT_LOW_ADDR);
 	} else {
 		result = VMCI_ERROR_UNAVAILABLE;
 	}
@@ -384,7 +400,7 @@ static irqreturn_t vmci_interrupt(int irq, void *_dev)
 		unsigned int icr;
 
 		/* Acknowledge interrupt and determine what needs doing. */
-		icr = ioread32(dev->iobase + VMCI_ICR_ADDR);
+		icr = vmci_read_reg(dev, VMCI_ICR_ADDR);
 		if (icr == 0 || icr == ~0)
 			return IRQ_NONE;
 
@@ -429,7 +445,8 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 				   const struct pci_device_id *id)
 {
 	struct vmci_guest_device *vmci_dev;
-	void __iomem *iobase;
+	void __iomem *iobase = NULL;
+	void __iomem *mmio_base = NULL;
 	unsigned int capabilities;
 	unsigned int caps_in_use;
 	unsigned long cmd;
@@ -445,16 +462,32 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 		return error;
 	}
 
-	error = pcim_iomap_regions(pdev, 1 << 0, KBUILD_MODNAME);
-	if (error) {
-		dev_err(&pdev->dev, "Failed to reserve/map IO regions\n");
-		return error;
+	/*
+	 * The VMCI device with mmio access to registers requests 256KB
+	 * for BAR1. If present, driver will use new VMCI device
+	 * functionality for register access and datagram send/recv.
+	 */
+
+	if (pci_resource_len(pdev, 1) == VMCI_WITH_MMIO_ACCESS_BAR_SIZE) {
+		dev_info(&pdev->dev, "MMIO register access is available\n");
+		mmio_base = pci_iomap_range(pdev, 1, VMCI_MMIO_ACCESS_OFFSET,
+					    VMCI_MMIO_ACCESS_SIZE);
+		/* If the map fails, we fall back to IOIO access. */
+		if (!mmio_base)
+			dev_warn(&pdev->dev, "Failed to map MMIO register access\n");
 	}
 
-	iobase = pcim_iomap_table(pdev)[0];
+	if (!mmio_base) {
+		error = pcim_iomap_regions(pdev, BIT(0), KBUILD_MODNAME);
+		if (error) {
+			dev_err(&pdev->dev, "Failed to reserve/map IO regions\n");
+			return error;
+		}
+		iobase = pcim_iomap_table(pdev)[0];
+	}
 
-	dev_info(&pdev->dev, "Found VMCI PCI device at %#lx, irq %u\n",
-		 (unsigned long)iobase, pdev->irq);
+	dev_info(&pdev->dev, "Found VMCI PCI device at %#lx, %#lx, irq %u\n",
+		 (unsigned long)iobase, (unsigned long)mmio_base, pdev->irq);
 
 	vmci_dev = devm_kzalloc(&pdev->dev, sizeof(*vmci_dev), GFP_KERNEL);
 	if (!vmci_dev) {
@@ -466,6 +499,7 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 	vmci_dev->dev = &pdev->dev;
 	vmci_dev->exclusive_vectors = false;
 	vmci_dev->iobase = iobase;
+	vmci_dev->mmio_base = mmio_base;
 
 	tasklet_init(&vmci_dev->datagram_tasklet,
 		     vmci_dispatch_dgs, (unsigned long)vmci_dev);
@@ -490,7 +524,7 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 	 *
 	 * Right now, we need datagrams. There are no fallbacks.
 	 */
-	capabilities = ioread32(vmci_dev->iobase + VMCI_CAPS_ADDR);
+	capabilities = vmci_read_reg(vmci_dev, VMCI_CAPS_ADDR);
 	if (!(capabilities & VMCI_CAPS_DATAGRAM)) {
 		dev_err(&pdev->dev, "Device does not support datagrams\n");
 		error = -ENXIO;
@@ -534,7 +568,7 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 	dev_info(&pdev->dev, "Using capabilities 0x%x\n", caps_in_use);
 
 	/* Let the host know which capabilities we intend to use. */
-	iowrite32(caps_in_use, vmci_dev->iobase + VMCI_CAPS_ADDR);
+	vmci_write_reg(vmci_dev, caps_in_use, VMCI_CAPS_ADDR);
 
 	/* Set up global device so that we can start sending datagrams */
 	spin_lock_irq(&vmci_dev_spinlock);
@@ -630,11 +664,10 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 	cmd = VMCI_IMR_DATAGRAM;
 	if (caps_in_use & VMCI_CAPS_NOTIFICATIONS)
 		cmd |= VMCI_IMR_NOTIFICATION;
-	iowrite32(cmd, vmci_dev->iobase + VMCI_IMR_ADDR);
+	vmci_write_reg(vmci_dev, cmd, VMCI_IMR_ADDR);
 
 	/* Enable interrupts. */
-	iowrite32(VMCI_CONTROL_INT_ENABLE,
-		  vmci_dev->iobase + VMCI_CONTROL_ADDR);
+	vmci_write_reg(vmci_dev, VMCI_CONTROL_INT_ENABLE, VMCI_CONTROL_ADDR);
 
 	pci_set_drvdata(pdev, vmci_dev);
 
@@ -657,8 +690,7 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 
 err_remove_bitmap:
 	if (vmci_dev->notification_bitmap) {
-		iowrite32(VMCI_CONTROL_RESET,
-			  vmci_dev->iobase + VMCI_CONTROL_ADDR);
+		vmci_write_reg(vmci_dev, VMCI_CONTROL_RESET, VMCI_CONTROL_ADDR);
 		dma_free_coherent(&pdev->dev, PAGE_SIZE,
 				  vmci_dev->notification_bitmap,
 				  vmci_dev->notification_base);
@@ -700,7 +732,7 @@ static void vmci_guest_remove_device(struct pci_dev *pdev)
 	spin_unlock_irq(&vmci_dev_spinlock);
 
 	dev_dbg(&pdev->dev, "Resetting vmci device\n");
-	iowrite32(VMCI_CONTROL_RESET, vmci_dev->iobase + VMCI_CONTROL_ADDR);
+	vmci_write_reg(vmci_dev, VMCI_CONTROL_RESET, VMCI_CONTROL_ADDR);
 
 	/*
 	 * Free IRQ and then disable MSI/MSI-X as appropriate.  For
diff --git a/include/linux/vmw_vmci_defs.h b/include/linux/vmw_vmci_defs.h
index 9911ecfc18ba..8fc00e2685cf 100644
--- a/include/linux/vmw_vmci_defs.h
+++ b/include/linux/vmw_vmci_defs.h
@@ -82,6 +82,18 @@ enum {
  */
 #define VMCI_MAX_PINNED_QP_MEMORY ((size_t)(32 * 1024))
 
+/*
+ * The version of the VMCI device that supports MMIO access to registers
+ * requests 256KB for BAR1 whereas the version of VMCI that supports
+ * MSI/MSI-X only requests 8KB. The layout of the larger 256KB region is:
+ * - the first 128KB are used for MSI/MSI-X.
+ * - the following 64KB are used for MMIO register access.
+ * - the remaining 64KB are unused.
+ */
+#define VMCI_WITH_MMIO_ACCESS_BAR_SIZE ((size_t)(256 * 1024))
+#define VMCI_MMIO_ACCESS_OFFSET        ((size_t)(128 * 1024))
+#define VMCI_MMIO_ACCESS_SIZE          ((size_t)(64 * 1024))
+
 /*
  * We have a fixed set of resource IDs available in the VMX.
  * This allows us to have a very simple implementation since we statically
-- 
2.25.1

