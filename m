Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A1484A73FB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 15:57:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345227AbiBBOzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 09:55:32 -0500
Received: from mail-dm6nam10on2046.outbound.protection.outlook.com ([40.107.93.46]:1824
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1345232AbiBBOzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 09:55:23 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nXiYCE50mvhRrWhe9rdiYAOh7TGZE0/bxCp1biuAPGU6+Y7DGjMxvWalrNomhNGKJMqkyirksbw4uXwJ3BPRD0t+WDrKF+WQXPwHnYE095fTdlXI60XPqPuK8CFAGowlGM6t2U3ODefYCGbHCI2PtMcpaDagjIPcWH9/Xj/cCyOjdgQsuIYhm69C1yGVPlDiUaZnM81QqfhZ+eRYJzdHsddRQtpouteph4Ul2VcBSxtg8KnffPz0MwLVIa025IxT1YluGLc+AFPIVXFO+DBcxY7rg3XoylkmXnysA4l+th1+0ejBRCZIHwuOU9Ch/Gw/GWOQvc4RIBKWvqlYCzAVFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jdi1qOGQ0uOEyB48pKO1cMRIR/zUePY+diorfhX6cCM=;
 b=kjZsRv9CRXAe4QM/cRM9GyjKJZ6sT+U7RVp2uT1OwrcinyTyNFwXa9H63gzmOzXW481U85kb6y0oJDXYWXdSlBS72kghrbLscakhT7HzBFbpvd7Jy10HDJer1pXDK8NMCO7BdueNaENXx9x+fHac7h97W9wDPWZjQm0FFiRXtmG3vRjgxKWrQPvZPB/AipI06l/Qwbd/q3hZ874lN+5w4WEhmJreGKu8/jzyWkgr614ms5FzPkuFvvBjD2xfSpJd4ayCmiMR/A1gN/wHsfwKWGY/1/D8KA21DDc7bvf+QoIEQ7ZLakTM3EUb6UAppCFamwc0uQYoU+plRU8Lt3t8Mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jdi1qOGQ0uOEyB48pKO1cMRIR/zUePY+diorfhX6cCM=;
 b=BObGz8tv9ZWQBFY//HstzP4tY9DRgqF/YnIzINtHd4vI5eMb5VmfrO2n4IXNDGHWg2mH0FZMR3irFwLzam9CdmPFHAqSvLX1todXdIAFw7Xv/1m+e3KeFCsVqvT9ebJ2h0U1l5s9CFfuUZ+1jxZ/VSMz9NDsH/TFJiSeJ/p/rFo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BY3PR05MB8081.namprd05.prod.outlook.com (2603:10b6:a03:366::15)
 by BN6PR05MB2803.namprd05.prod.outlook.com (2603:10b6:404:2c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.5; Wed, 2 Feb
 2022 14:55:15 +0000
Received: from BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::304c:2b94:4f26:a581]) by BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::304c:2b94:4f26:a581%3]) with mapi id 15.20.4951.012; Wed, 2 Feb 2022
 14:55:15 +0000
From:   Jorgen Hansen <jhansen@vmware.com>
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     gregkh@linuxfoundation.org, pv-drivers@vmware.com,
        Jorgen Hansen <jhansen@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>
Subject: [PATCH 5/8] VMCI: dma dg: register dummy IRQ handlers for DMA datagrams
Date:   Wed,  2 Feb 2022 06:49:07 -0800
Message-Id: <20220202144910.10349-6-jhansen@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: 6652c30e-a7d1-4b14-409f-08d9e65c04f7
X-MS-TrafficTypeDiagnostic: BN6PR05MB2803:EE_
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <BN6PR05MB2803123014DF17B92055D08FDA279@BN6PR05MB2803.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lQ6pq0c7LPamsH4kVYm2qLveXnsCKx+kicQUsXLF06ec+KdATr//RddBuuU4R/2d951U91LIfFkfIJfwBd0Kx+AyMU0xnjPfwHnlWoXnoaRI5Dx8MkvwVrdAI9hbNFQZCqN/yN5OpWhs4CTJtrmGnGg0+XisAamowdj+eKmL6y1nqrVuH+7OSDEMMG8lU/rAwwqbYm4rotZZS6JHZiSFc8njDdM8OgUUo8iM6M4At7Whse1jhibkaO0ud3lmkcA99x20RpBXNGTqNloDjYBgJCfIDPsynxfduZny5QQB6bqQhGSropyb8wJNjvsV1s/ygoJMX43g5vkWUeKtIOHIsLjHd+9KhOKUy0a8olsjRhjIo4uuCwfkrNLLp9gT/+Y+MozslH9nDrpha/5PypsiKorXstB3wECgpm49xOTZmsgQmPvX69LlIAMIdi0RPJbWY8FS3K+25MZjV094euJ2RhEhhyN/I36rrH26+x6M341afslA00SkcPnGhO44+gA/Yb52tE2lAz1J9mGad9ElCsrqWlHyKTaBH8UUNi5gloLLvKxpqgfzSq78WIBghZ4PChYuGhrtwOvGFidi/1UptG4xreWwS5H4Qtd6m32GqIVqJssLrIJY8BHLKoSdr+8TN80DhpPtuxpfkApAqJ0FpLNVpL7uifkZjCI1TOi1r5yRkRD90We9X1AvmUMCeZKlTLUW6uTldxPoQvkopINUQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8081.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(52116002)(316002)(6512007)(38100700002)(38350700002)(5660300002)(2616005)(8676002)(8936002)(54906003)(4326008)(66476007)(66556008)(66946007)(83380400001)(107886003)(508600001)(6486002)(86362001)(1076003)(36756003)(186003)(6506007)(26005)(2906002)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kCbQywdPTA1BogjlE2LJK6t+wqqEQzADfk6h9lbpoclIjX7pVAJyKJqAJ+RO?=
 =?us-ascii?Q?7wnrPqlXh/ZeIiDPz/Ie7KBcNRjKWgTKdCshORvRKsO4V6huS8NU8uhhmWxI?=
 =?us-ascii?Q?7T9NsUapt78VKNTQYzCDKrvAFdmmgpqT5TF6TE/wGMFalOOXNQSoNutJUtAi?=
 =?us-ascii?Q?UirmEK7oYNjuPTdnf/RDx8INqQ16oRz8IvbRuuIo/ubt1N0bUFJAUviGMVNt?=
 =?us-ascii?Q?zF8QlDnAoiUyHf2am7kuZcLt0qtPwMqm7tUjlYi0Nda+dSLhssxQctfw9iOX?=
 =?us-ascii?Q?lv7AKbSrWHM88S+5LUva97jQHRp+lLkCAXo/KuTRXpO4J1FnIsy1aEe6T2SF?=
 =?us-ascii?Q?IYoJ7vkGEgJvNUtNeC5MgDhFKO9CxTXAh0d33KT8IeTf+sOcYLAhJIl3kwcn?=
 =?us-ascii?Q?cY3sVRFC0xCLHvzwYNtqRTYeCofLczjgEE/c+C49h621xvAypkk6Ufp2j6Gz?=
 =?us-ascii?Q?CBhJay6nhLJNFI+0BYY3nHZ0EzCb1Wbeo60HUu3OWiTfsSA+HfzMc1apCAcj?=
 =?us-ascii?Q?OWFqFKTxnKMkEPeRANxykOGrmZ68CcJbQ4lkIgf5s/kS/1/0thGAHjNuKK17?=
 =?us-ascii?Q?PH/Ab0Y/BQOxZWc8aDVhU/oNRNJsAJtM7kxktlYkxJrXJ3mOm/N28QyiucKP?=
 =?us-ascii?Q?NvLMxL3Vt8BF62sS2xVaul+WMO/W2VuxiRYpcr2HAES3UpL+4saNNkX1vEki?=
 =?us-ascii?Q?6oUw1qp+CW3ex/+OZzMPrvOFRMJxofGCYAfGtQCupWE2+rYSPrSzuO6a5uSH?=
 =?us-ascii?Q?dq6TduIQr/8AhQjc+Egqs4IU5g33YPzPEOwpE+6H1DTiR89ZstdILQ4Bl/IP?=
 =?us-ascii?Q?P/DmI2RZy+0P76sX1xaSLMKDAyKShXYhzV7J71tnkExYC2vmIJtWWQO7kXps?=
 =?us-ascii?Q?L6I525vna/9HDw7bNiwXypEyc6Jho3O2HyXPXkaJQSeqMliqiv5Uz4tz8xrm?=
 =?us-ascii?Q?uZbcpZJ6ajyfP29/DcGM3C5fjUJPP9mmFoGazLyZ2j4Kwlh5mUJcQ0mc2QPH?=
 =?us-ascii?Q?3m7gaqBqfXNda7xBDZ7SnEP3kbii+ponSK5/fQKUFULN2uuw5y4lutd2zmz2?=
 =?us-ascii?Q?b6afvYRN2INaUnUOxiYu/GBVcbNzwcj1JDLVSWFFH3Fq3EUJyCEPz8ELIXxR?=
 =?us-ascii?Q?w1reJK11kfJDdyOoRBFkGPzFyltng5gSWpMmrLJ+T/38BZ8wnTk/sxxGqmTe?=
 =?us-ascii?Q?UPsYIPJe8e7ozYjrMw7SKf5X3afaEmxGUloQRmDD7oQHagxRABEovNC8TkDM?=
 =?us-ascii?Q?N0fLPPoHLKTsr02mO3tSG4bn6C09GEpEDDSeEB2R9lH1+4EF6jM/Xmq4Jett?=
 =?us-ascii?Q?w3Ho/fOOQYkylHmHMPJV2GhTZjxMT5qPoAWz/TMTUP84vhNAbyp5Jr+8rL+8?=
 =?us-ascii?Q?HsuCaW0fFI8BwZn9KB1tAHwCglEQH6aC5oEoJJ9IFghPWGGBznSceI6hnUID?=
 =?us-ascii?Q?Tu56twHnRrJZjF9hVwzE/mbB/C+tW1MyQ0dZEytCPUqLmFfadmUz83gp1Wj5?=
 =?us-ascii?Q?AxNqQWWLBEyaj6+RRdgcCgCS8sAPVhotXywVhBVnQln2qlUf4OtBHTkgv6Ia?=
 =?us-ascii?Q?r2xA5XJEQWklYRP/TiyGD5kE7MFHKqfMsbqbMP2tKOFs+6I7J1m0XwPzXV/w?=
 =?us-ascii?Q?Z/EAh9n5MwFc/WT7K6Cgo6E=3D?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6652c30e-a7d1-4b14-409f-08d9e65c04f7
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8081.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2022 14:55:14.6678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RWuGsUn0yDgJVhTg5QRhfrw85anyoNVY9QNBeh/yTxDsSQu+VbLUf7nX9MdH4KaeDbptl2B9Pft45MblIn9BGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR05MB2803
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
index ec76661bde7e..1903fe8e7c68 100644
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
 	char *mmio_base = NULL;
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

