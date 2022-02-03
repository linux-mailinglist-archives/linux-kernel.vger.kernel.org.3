Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 906644A850E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 14:18:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350771AbiBCNSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 08:18:35 -0500
Received: from mail-bn1nam07on2040.outbound.protection.outlook.com ([40.107.212.40]:28852
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350748AbiBCNSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:18:21 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hi8gwPLo5rx4TSRI9TXMyiuT+osBi7DvmRGZTk2xUR2uyzDI8m+O9N2+pPuEHQnKaZJ5PWbxpnBC92ujbf1bRGhrCqvrmiKzLaC6HiuhixOEs68NBzhYpA6EM0R/e3oAwBXx2lDXu6+ZO9akPDcw3bQ36TvJ3XDSVqDvOU5n12xx//WOV6zHAphdSMei9f84DCpw32M9NSihXL9LJUklbpomq3XSEglUNfHBWjZodFU6ewQP/QZXosq7zGXQnAxPNAXOv55C64nMYFESqe+fMoV45zwV6wLL8yScwWS6A38MlwN4DZ+4tmj/CtUobT/tWIyvrh4YkHYsUC2x4HWErg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZiSdQpSEJC8cC1fGnA5mNEAQlXuUXvoH1ZLKOZJ4Xc=;
 b=Z+moV+FNqnxbqw0o2TueFGw+R1qdStIKAqcIRkrPtSyHapxKZIOW8JyR9Y24RsaAMuVZwi2xSCR70CHj4YdF6Laj9I1iitkeIgKzdwypRqsxDtcDVNzB5j/t7vI1WUkuqBxQj1Rc2jjrSvAfugPrWVQpu+Eg5HBg3xGk27OJp85yEw9QALQ9kkVCB/8T47kGF2Gm/l+F1vu2HoSGzmN6yT/QHNWal/jKB5YMWUIxbJDBdOIi9GlSVA8tiFX2gAUFwOtLT3z+7Lx5kKEEAMUnk3GUJJHV+VT9uqHVdYnax1Ihc44PXa36HW+3ZeUlN1XmFfTixhbA7n0Sn3xY0NU7Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mZiSdQpSEJC8cC1fGnA5mNEAQlXuUXvoH1ZLKOZJ4Xc=;
 b=E3NSpr4zY7dCIoUQYOO36pTlvdMOsak1ZqciNM7EXbTAJyzTwT3R8KmlYypxYQWHvzVi4qAtpyPDTJ7v5ZuZJjlyytGq1tYSC6YzQ9eowp61/uYi7AE/OMYMszmqThFGRCPIAn3XlOexUtao52IzJ+axzGfWbmr2XDjs4ZV+Ffw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BY3PR05MB8081.namprd05.prod.outlook.com (2603:10b6:a03:366::15)
 by MN2PR05MB7150.namprd05.prod.outlook.com (2603:10b6:208:18b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.5; Thu, 3 Feb
 2022 13:18:17 +0000
Received: from BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::304c:2b94:4f26:a581]) by BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::304c:2b94:4f26:a581%3]) with mapi id 15.20.4951.012; Thu, 3 Feb 2022
 13:18:17 +0000
From:   Jorgen Hansen <jhansen@vmware.com>
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     gregkh@linuxfoundation.org, pv-drivers@vmware.com,
        Jorgen Hansen <jhansen@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>
Subject: [PATCH v2 5/8] VMCI: dma dg: register dummy IRQ handlers for DMA datagrams
Date:   Thu,  3 Feb 2022 05:12:34 -0800
Message-Id: <20220203131237.3380-6-jhansen@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9018bd1c-9c35-4182-bcad-08d9e717a340
X-MS-TrafficTypeDiagnostic: MN2PR05MB7150:EE_
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <MN2PR05MB715076D4E28822D979D4DDC9DA289@MN2PR05MB7150.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s7Gy5Eafszws2OHW8QnbYOB4HKnbY7iUQAydR+pOloiLFbWZF1J3YDxHJmZYMMYKB1nhvMbjqEzNaw5kYhTCBRqJHCiE48Do+Br5p3djN5UGaVDrTrEIrWWt1aTBNmTizHil73p8QW+y124JrUozepUunaJnD16MgoC6dI9OQRU2RJqssETDkFW3mXiAXGLpgbC+leQfX8dhUJ+xL7vizNx346TJ58enA7hl3gYLYGomB8m5tFJ3Kl0RutljijkmjunDS7UdNjC3h8D37kDy+iDpj0IaLt+wY6kLS62oCjjnyGONLvQp7u6hKnPePo7D9TLIr/zr5aVt6UESxQpeAifd6HIEXxVawPa/rdQgNoKl6YLJS+cbiOhbEzdpX1eXEwXUOXo3Yk+c7hps2brd7kSNlU2ovBbZyo67NgLuRZZ1s5AZMJpGXdAfMRerMDVcrgz0RV86BKwIV0bpwPnw5yHBf97tYDTMwZyttCPa/n7V23fLSbRUOko32eX424FTNhMrVMaKZ5wFMGbb9IVBEAX1Y52R5sMlKB+V3hEWbWPYlUct2DRkzPK2H+gjcwGnCkQxtY5caB2ggGuMD4rp4FsB3ixlmC5X/KCQ02xBFw0SSMoSNYMMPUejoR+oScz3he71yyXC+TnB3iG8fqjqPqFFrqHHjKVKANH7a6pto6P3g/2lo5bMpft6G2xcOL6pgyXtOZrxDBwNW7JTIQ/vtA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8081.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(8936002)(66556008)(8676002)(66476007)(5660300002)(4326008)(38350700002)(2616005)(52116002)(66946007)(36756003)(38100700002)(186003)(6506007)(26005)(2906002)(1076003)(83380400001)(107886003)(316002)(6666004)(54906003)(86362001)(6512007)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FQBz43bmKOsRc8tIDbJYm9gz20B9rNpaafXitwu7ze/jos9fiCeV20jJYGRS?=
 =?us-ascii?Q?WvNfFHBPcLmH2zPN2KcmX7IPbxv7Nn7Q0btdoL4m4ng9iZLht9kUwO/aOlHn?=
 =?us-ascii?Q?kzOLxZ0/QVk++vUHs7AEmGqdhVaBsUsQh1cfHfargHrwM4mZm43yxuWXQUfr?=
 =?us-ascii?Q?pjXCVgZ8R304rii2oNic5K/aFb3iN4Yv8GGASLK+DVZAIJNnQNS6d8s91Sb/?=
 =?us-ascii?Q?f9aMDybObNZ4to9QAeTZbMnC9r634DjFXutGivf/iiw+cRa/vDKb2RDOiQC8?=
 =?us-ascii?Q?+Jj/wlARr70aGi49PY2r22SoqFTbxmUSDNzZjMvR8O02apkMs9qbLZ7+duPW?=
 =?us-ascii?Q?SVrGcHUOb/nS5G64nGtP62m9hy8MiJG0mzXbZAgmESF7xs7LwRgjuTP/hqUU?=
 =?us-ascii?Q?mJg44nuFJ0Bqwrb7ymN5UDY8C2sMHafoyGcDRI4UPH3BfCqRPgijOFMZTc1P?=
 =?us-ascii?Q?5EsC9mPVp7gVfRXzgc+bLHSC3+5lwjl7pcI4cDUPOfaeAV7zRlg6Pj/yOwqN?=
 =?us-ascii?Q?ylfajhYmhD/fI4LmCLKgPnqI6k0ku+h7d5r5JyPPQto0pe6i74rpRISokDQO?=
 =?us-ascii?Q?2aPka1U/CA3iTtJF4IEW9/DoAnAG+XJR/rNEfbR7HMWY9vEiXqqoL1A+0RAd?=
 =?us-ascii?Q?wPPgVMSnpON5uGMHPCcbIecOvtbF629Ruz8Bt2huPYryJvWWQDFKFMUhgY/g?=
 =?us-ascii?Q?14jXA3sLsUELKHDpZB/J0ERXSFEFtxIE3k8Eo3UwWnE8FjIdSEAUsrnSs1Fj?=
 =?us-ascii?Q?kj+uyLAdN5YJ/bk9+WxD+y5Lq1XL8xMzFvY0mYTrnFU2odLsO+TgWMPAIyrq?=
 =?us-ascii?Q?EWKmDRP/PH8pk20tPRswR38QdaYr+AG9nXts5zoDHezYlPC6f7WBsxNuOUmr?=
 =?us-ascii?Q?BMpPlHR7M8aceww/9ONo5bp31pOVcb1WXetp8KLQyhQ1g5OCsLrTvVJGnGdJ?=
 =?us-ascii?Q?I0ttpKNZg0GhKWOGWA91/NtMb8lOwYoCK0ju+0sd44A495yDbqCZRiSVmoBC?=
 =?us-ascii?Q?a9bIlVLhDv4aLCMHPa8KPaw4MRYgoBI9aHgqsWRgtsRxcI0vcSCIVCTiI1M9?=
 =?us-ascii?Q?HwKP9zgYs1fruujcf14hmDeS14ydXHNCBBcVCTfnDhoojq4nSSvRAo/Mgecw?=
 =?us-ascii?Q?Rq3H4Zxt5Lsb/LaUBgs1xwpTm2mhgmkZEf3S44yNwSGolBpwxQ7Mz+r8LU85?=
 =?us-ascii?Q?hfYCh/+ysHbVfbnLG1ucTth+KjDoLnttsRh0IUHdkANc2UZrt9F47Lulx8zx?=
 =?us-ascii?Q?FkVpcYv5CZcqmyE1FuMS0D8YpjdZvFc7oWHTOTmEPEU3s+tmihgbwU86utdG?=
 =?us-ascii?Q?beZo2b9WUxUnOx5Nwb3IaG3lw3K942Vmft+WKb98UYb6+Czqtp6vBVmNiiFW?=
 =?us-ascii?Q?7zgKy8+TA/g+xtrfa0tb2XBwFwQaeL0uVHrptVURV+FFJcL4BYlLKkfN5XNt?=
 =?us-ascii?Q?O3LfNzqY/T1j5eweLVA+h/6X6ttbPg7FtfwOh3fvD8xCxDrTUAqt9DRklgDO?=
 =?us-ascii?Q?+R/i+j1DrdC/FMasYkadmcH6Dwnc4e5Xc3yiZGHFWkMcxR5eVIDDiDtDNoMU?=
 =?us-ascii?Q?FMTt1bvDWSUZyDN8eag4CZeiVrYOUUgy5mal+lA3U1IeZC6nW+7Wa+fqzHiq?=
 =?us-ascii?Q?uuywJGE1cC61BsFYoUKu4wE=3D?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9018bd1c-9c35-4182-bcad-08d9e717a340
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8081.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 13:18:16.1187
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sbau1JxWsQ8i2ZQIE8buAVZ7MEUpFLinT1Qi/h2mJ/ZEB6sLDXgHcrgsoac6JJo1S5lN5mcNBKeEgrAPLxKD0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB7150
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Register dummy interrupt handlers for DMA datagrams in preparation for
DMA datagram receive operations.

Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
---
 drivers/misc/vmw_vmci/vmci_guest.c | 42 +++++++++++++++++++++++++++---
 include/linux/vmw_vmci_defs.h      | 14 ++++++++--
 2 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index 808680dc0820..0920fbc6b64f 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -414,6 +414,9 @@ static irqreturn_t vmci_interrupt(int irq, void *_dev)
 			icr &= ~VMCI_ICR_NOTIFICATION;
 		}
 
+		if (icr & VMCI_ICR_DMA_DATAGRAM)
+			icr &= ~VMCI_ICR_DMA_DATAGRAM;
+
 		if (icr != 0)
 			dev_warn(dev->dev,
 				 "Ignoring unknown interrupt cause (%d)\n",
@@ -438,6 +441,16 @@ static irqreturn_t vmci_interrupt_bm(int irq, void *_dev)
 	return IRQ_HANDLED;
 }
 
+/*
+ * Interrupt handler for MSI-X interrupt vector VMCI_INTR_DMA_DATAGRAM,
+ * which is for the completion of a DMA datagram send or receive operation.
+ * Will only get called if we are using MSI-X with exclusive vectors.
+ */
+static irqreturn_t vmci_interrupt_dma_datagram(int irq, void *_dev)
+{
+	return IRQ_HANDLED;
+}
+
 /*
  * Most of the initialization at module load time is done here.
  */
@@ -447,6 +460,7 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 	struct vmci_guest_device *vmci_dev;
 	void __iomem *iobase = NULL;
 	void __iomem *mmio_base = NULL;
+	unsigned int num_irq_vectors;
 	unsigned int capabilities;
 	unsigned int caps_in_use;
 	unsigned long cmd;
@@ -635,8 +649,12 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 	 * Enable interrupts.  Try MSI-X first, then MSI, and then fallback on
 	 * legacy interrupts.
 	 */
-	error = pci_alloc_irq_vectors(pdev, VMCI_MAX_INTRS, VMCI_MAX_INTRS,
-			PCI_IRQ_MSIX);
+	if (vmci_dev->mmio_base != NULL)
+		num_irq_vectors = VMCI_MAX_INTRS;
+	else
+		num_irq_vectors = VMCI_MAX_INTRS_NOTIFICATION;
+	error = pci_alloc_irq_vectors(pdev, num_irq_vectors, num_irq_vectors,
+				      PCI_IRQ_MSIX);
 	if (error < 0) {
 		error = pci_alloc_irq_vectors(pdev, 1, 1,
 				PCI_IRQ_MSIX | PCI_IRQ_MSI | PCI_IRQ_LEGACY);
@@ -674,6 +692,17 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 				pci_irq_vector(pdev, 1), error);
 			goto err_free_irq;
 		}
+		if (caps_in_use & VMCI_CAPS_DMA_DATAGRAM) {
+			error = request_irq(pci_irq_vector(pdev, 2),
+					    vmci_interrupt_dma_datagram,
+					    0, KBUILD_MODNAME, vmci_dev);
+			if (error) {
+				dev_err(&pdev->dev,
+					"Failed to allocate irq %u: %d\n",
+					pci_irq_vector(pdev, 2), error);
+				goto err_free_bm_irq;
+			}
+		}
 	}
 
 	dev_dbg(&pdev->dev, "Registered device\n");
@@ -684,6 +713,8 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 	cmd = VMCI_IMR_DATAGRAM;
 	if (caps_in_use & VMCI_CAPS_NOTIFICATIONS)
 		cmd |= VMCI_IMR_NOTIFICATION;
+	if (caps_in_use & VMCI_CAPS_DMA_DATAGRAM)
+		cmd |= VMCI_IMR_DMA_DATAGRAM;
 	vmci_write_reg(vmci_dev, cmd, VMCI_IMR_ADDR);
 
 	/* Enable interrupts. */
@@ -694,6 +725,8 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 	vmci_call_vsock_callback(false);
 	return 0;
 
+err_free_bm_irq:
+	free_irq(pci_irq_vector(pdev, 1), vmci_dev);
 err_free_irq:
 	free_irq(pci_irq_vector(pdev, 0), vmci_dev);
 	tasklet_kill(&vmci_dev->datagram_tasklet);
@@ -759,8 +792,11 @@ static void vmci_guest_remove_device(struct pci_dev *pdev)
 	 * MSI-X, we might have multiple vectors, each with their own
 	 * IRQ, which we must free too.
 	 */
-	if (vmci_dev->exclusive_vectors)
+	if (vmci_dev->exclusive_vectors) {
 		free_irq(pci_irq_vector(pdev, 1), vmci_dev);
+		if (vmci_dev->mmio_base != NULL)
+			free_irq(pci_irq_vector(pdev, 2), vmci_dev);
+	}
 	free_irq(pci_irq_vector(pdev, 0), vmci_dev);
 	pci_free_irq_vectors(pdev);
 
diff --git a/include/linux/vmw_vmci_defs.h b/include/linux/vmw_vmci_defs.h
index 4167779469fd..2b70c024dacb 100644
--- a/include/linux/vmw_vmci_defs.h
+++ b/include/linux/vmw_vmci_defs.h
@@ -45,13 +45,22 @@
 /* Interrupt Cause register bits. */
 #define VMCI_ICR_DATAGRAM      BIT(0)
 #define VMCI_ICR_NOTIFICATION  BIT(1)
+#define VMCI_ICR_DMA_DATAGRAM  BIT(2)
 
 /* Interrupt Mask register bits. */
 #define VMCI_IMR_DATAGRAM      BIT(0)
 #define VMCI_IMR_NOTIFICATION  BIT(1)
+#define VMCI_IMR_DMA_DATAGRAM  BIT(2)
 
-/* Maximum MSI/MSI-X interrupt vectors in the device. */
-#define VMCI_MAX_INTRS 2
+/*
+ * Maximum MSI/MSI-X interrupt vectors in the device.
+ * If VMCI_CAPS_DMA_DATAGRAM is supported by the device,
+ * VMCI_MAX_INTRS_DMA_DATAGRAM vectors are available,
+ * otherwise only VMCI_MAX_INTRS_NOTIFICATION.
+ */
+#define VMCI_MAX_INTRS_NOTIFICATION 2
+#define VMCI_MAX_INTRS_DMA_DATAGRAM 3
+#define VMCI_MAX_INTRS              VMCI_MAX_INTRS_DMA_DATAGRAM
 
 /*
  * Supported interrupt vectors.  There is one for each ICR value above,
@@ -60,6 +69,7 @@
 enum {
 	VMCI_INTR_DATAGRAM = 0,
 	VMCI_INTR_NOTIFICATION = 1,
+	VMCI_INTR_DMA_DATAGRAM = 2,
 };
 
 /*
-- 
2.25.1

