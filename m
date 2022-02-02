Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 444BC4A73FD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345226AbiBBOzX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:55:23 -0500
Received: from mail-dm6nam10on2046.outbound.protection.outlook.com ([40.107.93.46]:1824
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1345150AbiBBOzQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:55:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=km9CP1adBnizmkxh25JW82mqdnOrMvzKEBe1Fg7I3qnSzHyzxc0/7qLqYCOENkAdcba3oC0MVz/DbK6up5PgLN6sEwOKLraD++Lc0VInco2E7MSWN/U2Hgq4cnd5YdPehe84jiZEPyWyy9G66I3Qlg/G94tevnQu31TkQP5sM8c3+sVpNPVSPf0CW0hkgwuUZDNeMwc9BxEPt9JPVQvbq/6pPcfCIII02fhQ8ijSXzPJyl6d01/feJxvHDiGwyQJz72hN8gRh399ulkBfaivzCuBytVfyyUEu6bT1hN3Vs1JKuoHKVQ6e8obu3MdF78rnsU/pS6NkL8Ellm/xEGsEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+sedFvPxqGpdatNuOyPjS+rlwYqO3ENEQQp7+supXQ=;
 b=G5+Eq61eh5TAY4bPfqRDkpirDjMgym4ppgC8QWyxhGF45xHnauv52DTZB0v/K7gODroIOpxcIgcRZoDYk9LWv6P+FhQ6ZWLZ9wcuerlFRofLc2g2ldJ47ZqIaXEZOulve4sx7ZCg+TZJbuNYhW+ICFSZ8nCakXMhwy1ZE4PXdavthE2tCfcnG3ZVUTZowyt+7eBBUJ/5vISyyBt4vkpEz32Z8G7xCLG3RWXqdQ+aeSx3ORb90DuvQE12Iiqs7xBIuUf0C3er7BQmeSPAhqoG4GBlUAr9nN8u1D4Ue/UiD0LkLNSBxdbOTeV45eRwPuJPBMOQIW122NmmNTwPjZHQTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+sedFvPxqGpdatNuOyPjS+rlwYqO3ENEQQp7+supXQ=;
 b=pcDxBGb58dSnNA/17ZlOQ1RKWQ5s/bY0UKZRA+EC24e/MFj77qipjvxhb9+0gj/VMZViX25Iyu+57ibd/mFsBzUOItniNfS3psM7wqfkJ6Fg3aXSWDHi/g2xwg93dPbBQgdK+4Jy5h2n/U73m69//ylv6kgTMRZK5L3MzLs3WrM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BY3PR05MB8081.namprd05.prod.outlook.com (2603:10b6:a03:366::15)
 by BN6PR05MB2803.namprd05.prod.outlook.com (2603:10b6:404:2c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.5; Wed, 2 Feb
 2022 14:55:13 +0000
Received: from BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::304c:2b94:4f26:a581]) by BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::304c:2b94:4f26:a581%3]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 14:55:13 +0000
From:   Jorgen Hansen <jhansen@vmware.com>
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     gregkh@linuxfoundation.org, pv-drivers@vmware.com,
        Jorgen Hansen <jhansen@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>
Subject: [PATCH 2/8] VMCI: dma dg: add MMIO access to registers
Date:   Wed,  2 Feb 2022 06:49:04 -0800
Message-Id: <20220202144910.10349-3-jhansen@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: 51ee98d1-cb47-416a-ac21-08d9e65c0422
X-MS-TrafficTypeDiagnostic: BN6PR05MB2803:EE_
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <BN6PR05MB28038EA779CDD20579C3C4E2DA279@BN6PR05MB2803.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5MFwMxqqUAoV7p9zGfLR7GtlAtX70hlm9ojNvZ6Qt1vDAmQtJIQE1BACe5heedELL30xVfpLWA+pcl1jiQ+4wOB2q0gOsKhS4HIIIgxXhXa73GC6PsIXH+h8/Sn/phQudfzLxAHxdayhxkm+IeqXEjv9aWoMcYA9mjGkcHGFNF9QtM0HrAXNlyuape56FmTZcgmgxvNmSBLEAbRRgBa+tVeoEogtLLvL6kJ+NDiMuoGOdEqDRzdsM/D9LeJFuGMA2HiKJHAp22zq8XeZI/CdX+Chln2yS1sJCaoOsUDivRwFf4Zfu6bGoB+swNzk4X0XM56/EGhoMU4KvKihIstfx2BuebnQFoNOc9JBIgxAqYt4kJbVxaVFCKxM/JUecuO9M99rSl7rkiXg5owiUMw5VXKQo8hSLYfFowp4RKz9OKQnEeWMBpBBITyVpm55y/jrprmaKfewpyd/gGWVQ0c9OqAKDSR3Weyz9CZwdcG4Yhos2YbGMgewC0WXH6ztEH8Wupy7Wr+iYrUhKkIaZJPxDBWKNuZlkjzFnd/Ah4SQf5lh2bY7sLiXJCZVIzxwESOjVogEDtEzZMH3JbJZhgm99JSczTlzqnKTWitVo04YMfCq2uE6esrcXZBGwuihcYuBhrMma/V/ZSgJQaCTQoIKjD+0nEBtR4cEfvi929fXkBPU+pg4G72LJ5018xHeSYmt+XOe2BuPbF7eyADPNcRHZA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8081.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52116002)(316002)(6512007)(38100700002)(38350700002)(5660300002)(2616005)(8676002)(8936002)(54906003)(4326008)(66476007)(66556008)(66946007)(83380400001)(107886003)(508600001)(6486002)(86362001)(1076003)(36756003)(186003)(6506007)(26005)(2906002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KxsYlEDxHry5NXivSrJ1nUnlMSYSvglzxtEeGPtq6BhBNYm4n1fhu8kE2fKI?=
 =?us-ascii?Q?FU1TrBsu1181v/AIN9xSV7+4Qj6NfWqB0JJRzVhcGx6tbtWGSxkkYvUi3Hzo?=
 =?us-ascii?Q?bSN18QqsLEKRTmjhWSI/C7fJ4nOKM4E7y+ufOHyPF1lNGNbyKTc5SumMI/9/?=
 =?us-ascii?Q?r3yvplQtnprSUFXx+8EUnXHlS4AQau2PqlUqMpzSuv2Uk4twv3zKrjCGXYy+?=
 =?us-ascii?Q?yp3BWdkdDgPOHjeFRAhqK8waGum2xM79ekzukwBDQBDtAYvGjWTpvh/jOHXY?=
 =?us-ascii?Q?bSVuzy310282yQXjGfAE7Wd4tZ0OkpyDaxjaXvfnEsRXFqBsUfkZ9E/nMWsp?=
 =?us-ascii?Q?dZpnm5hMpgrMgmKJFWdix3P7drufLtkQZi/w4Fughc6aKKQL2guVl8tFjheQ?=
 =?us-ascii?Q?UGRSiG3WbNwJ7nZh6NMOQl3kdcA3wIx3COBLD3MC3I/pE6jKszGLuzaV99oA?=
 =?us-ascii?Q?qA0fvBrehltj6GEd2kvF8oyJAMCmcxgAO2o2g00YHyqhoYHZkLQedfC9QzzD?=
 =?us-ascii?Q?Ai6nrfR3opecMZcw5RNgdM0D2HJvvouraPUagJjl8+KJGdv4KuH67Yscy0ed?=
 =?us-ascii?Q?yQIOKUSyrEtvyF19mokb4tJaXtBfgOf6qIHV0+Wu4iM4DER/1PNOCrHKyPWQ?=
 =?us-ascii?Q?xT6BKpOH6lfhkdp0+IVXnibC2q42aQXWFRw1qlgpl+q90BICaC/ylAtNKjzh?=
 =?us-ascii?Q?7rVmo31eHBjoIK0M4bTLteS+r//sVH3rThKRu3t1snMdJy+4tge4z4U/yGg+?=
 =?us-ascii?Q?vHQN9zNrzOvFVJn3ZocB4+4FWXpU6QfLkmZdKq+38rUaP4vZ0sSxAhhC0mD9?=
 =?us-ascii?Q?CAvsxfO2iCjn5jKOvU/S8wZ7dxR4jGZs/Gm5+YGl86xhe//G1E4lNt+dSMNk?=
 =?us-ascii?Q?1cPAKmubxDaB3FU0+zR/Noap4gH4LFPjstXl+3/TCUUH6WmhNtd8tQY6wABv?=
 =?us-ascii?Q?JBcyJgowJcH+Hzydr9SrczB4zwDkN7Rl1iaIO7et0zlBMfP0lHgZbNktIQS4?=
 =?us-ascii?Q?Vbpg8/2Byl+sqkipZRPYx4omHo0LjHi0M7LcmwNFQV8jJe4X/LzuwTQgea21?=
 =?us-ascii?Q?v6ybV7dXJHaSJxPRNBTXSjeMW86PcQXqqPiIh4vKV954uCVGk9Bk08BDMBuN?=
 =?us-ascii?Q?aeiMWcz4140DhyLlZy+5dSZ0/h91HEp8lzRJgmLt8tsytkR0t+xc7XL62f9g?=
 =?us-ascii?Q?oKT77G4XlWyFXxu5Pzf0w2tyRpu0i4lzFItACjigWvHlxfiWrIp/N8UNKfN0?=
 =?us-ascii?Q?XxY9wQpv969DIsUxwEb9aczNpRTaEvxBIDpYGvXpp2Rl6TJA4MDHxIOtU1JR?=
 =?us-ascii?Q?o450THQWrrnJQqr+5nGxJc6oZEVWQpDabJe3mDoFpU00rWcI0+aosRAlBEMY?=
 =?us-ascii?Q?Le07CNtznQV1l+844ZAO1KmfSfB7raNb7i2iu7gvWmtxUw9R75TnTTLBa6S1?=
 =?us-ascii?Q?UM2pSxZwltRtiVJvu5ACl5oejtub9DGXOcKvMj+r02W1gGzeAqfZkFssG/5u?=
 =?us-ascii?Q?u2iIupraPvWwTmD9KQ7AQdZJ7b3uUj6eXeBtkCs97gXd/sciZCzUPKz7BdvM?=
 =?us-ascii?Q?s6LKbNVD4gU2ZfT4sXzKefY7nYAS9nGtVzO3pBjH5nY88lGsg+7BP/EXo6x2?=
 =?us-ascii?Q?jzRlYaO2uNcZJdJdyJJeVEU=3D?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51ee98d1-cb47-416a-ac21-08d9e65c0422
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8081.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 14:55:13.3693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgRso9RJybxQg/9buN7C69SWP2R68rFS8d0oO8TJc9tRgJEhXp0LAxNeBNlHuigb0JqLePIWPsgdyx4JfWalwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR05MB2803
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
index 1018dc77269d..d00430e5aba3 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -45,6 +45,7 @@ static u32 vm_context_id = VMCI_INVALID_ID;
 struct vmci_guest_device {
 	struct device *dev;	/* PCI device we are attached to */
 	void __iomem *iobase;
+	char *mmio_base;
 
 	bool exclusive_vectors;
 
@@ -89,6 +90,21 @@ u32 vmci_get_vm_context_id(void)
 	return vm_context_id;
 }
 
+unsigned int vmci_read_reg(struct vmci_guest_device *dev, u32 reg)
+{
+	if (dev->mmio_base != NULL)
+		return readl(dev->mmio_base + reg);
+	return ioread32(dev->iobase + reg);
+}
+
+void vmci_write_reg(struct vmci_guest_device *dev, u32 val, u32 reg)
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
+	char *mmio_base = NULL;
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

