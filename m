Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9B4E4AB8E9
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 11:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245307AbiBGKiw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 05:38:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239688AbiBGKdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 05:33:39 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2073.outbound.protection.outlook.com [40.107.236.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF040C043181
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 02:33:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kRawHoyHosdauFM+XavCqv7EA2JBQ3Zf3yXFGvzaWXi1hW6Rigk5SM/UZTT7akXGkO/bn7STrICGdynIYOQIyV41xZhRq3P3+Eoex3oJdRDsARf1tAIaXxoU0jshEhlK+WMqeTA2uM9veSM3av54elCKqJpQjb35qe4ktlVb/3yaMG1XWAOVhfdIKv8ZaSNDyYOUtXb4M4Kyf/6KNpNx7iRRu2Ec0imPS1qRi2qJlNZhkJuAXlfEb7RCmmAruCyxO8tnUjPsNv0SvC195oYTglrjOtQzOL2/Qk405GttdHzq8d62Cbj7hT70AaMVfxPR3XHCYxuWLMRpfo44Xer7GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SWWgiyEXtvHywOVrwYpmsnRT/ZkYYqMmG599OgRjx1E=;
 b=jrjAw5wyTP/mYxIXZ5IV24jRi6frI2v7xsdGbz4xSTY1tTGOVF16Ebc6dEk/DE7ADJWze5OF4UxKmgo+jFLLqUtsFsC9ddDvUhslFrikaZL2nnxJyEIZzpbsQ36/xu3Z7NNasTapz3NnZLzHd+adn6i2t/jL4ls/2jZ5dmhdgxPmvmW7ngeeMO3/833uxiaPyBFUzW8JRUWAS6BqDFCXOujWLMbE1ydx6iRR+ra8swB0JdCs+8tsktfbx/ijpaOsg05MQ0jpTF9cJ6Dj6G8Zzt6G6vDR4rSVFP6RNJ08cJiwyutn0egO/Z84awRdU8gJiO4JR/YsqzTxkiT26s0oBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWWgiyEXtvHywOVrwYpmsnRT/ZkYYqMmG599OgRjx1E=;
 b=na0u8kfWP37BB6NmGA856m9n+KaUxKmn+rC8+wuHyogITBGD5xMLt0T78+5tqTsKNkSUelGpoEU5KCTtUur43Hux7FoUlcohZ4uFs92piJyezreHB9mzFMWsx5OPNhqENK8/QUvvNAn3oEHpYdJOvyv7jXcM11rCUydP6lNga4k=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BY3PR05MB8081.namprd05.prod.outlook.com (2603:10b6:a03:366::15)
 by DM5PR0501MB3686.namprd05.prod.outlook.com (2603:10b6:4:7d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.10; Mon, 7 Feb
 2022 10:33:35 +0000
Received: from BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::283c:d671:e4e5:31f8]) by BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::283c:d671:e4e5:31f8%7]) with mapi id 15.20.4975.010; Mon, 7 Feb 2022
 10:33:35 +0000
From:   Jorgen Hansen <jhansen@vmware.com>
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     gregkh@linuxfoundation.org, pv-drivers@vmware.com,
        Jorgen Hansen <jhansen@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>
Subject: [PATCH v3 5/8] VMCI: dma dg: register dummy IRQ handlers for DMA datagrams
Date:   Mon,  7 Feb 2022 02:27:22 -0800
Message-Id: <20220207102725.2742-6-jhansen@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: b1e3cadd-77ea-4723-09d0-08d9ea254ad8
X-MS-TrafficTypeDiagnostic: DM5PR0501MB3686:EE_
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <DM5PR0501MB3686878FCA952805AB3AC496DA2C9@DM5PR0501MB3686.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GurQh5v6nj8r1IFTyWJmsyqhV/URooM0aTqH8+7mvVOIN5xkmowB7izqvNpHCEkkQvOt2flH4ocHlNW9oYYfNlIeCNkVVCGECbCXuevFg0NG0L5DZncHF/XW0dwZuZKfWK4RNCG7K0K+shw1xjlgor6KJnZ7vUEtHjXr6G6HcQeYmx7qWHJuP7rAV+edmx41/Vj0y5Zzrc0ky8q0yKvWX6ASldFhinb2DUkj6hhrum88wfDauiTvFWQXLlaUh+7N4VzM2N7Gp+MIGUEUvOwEAzKC9WB305/8NT2GLXQHxd2g+McwUl5ge8d3IHCOappPxAjtGADIVrwxdNmMeicYGNrX9I7NzCV56AAjrNnfuHFzqMlcvOhqZaqHakrkuVa5UATMdqw8SzfwIO7/C25nRpNWsyzhBuN3qDpbA6oTnyiSz53BhQhP3ZltqSkKj3dcSWvFaXm05kZ7ALwQ+AKIIrXcxfGl2FVhrDtT5iAsAhasmD8tWLi6C11Ab7GtGbvP+HPmLYdIQ8wtx9H7iU0Ejtf5AfaNW799ITakD7TYtyt6XXU/QNe+KL+JQwxiUHoEqjju9RjNXDYKmS4Cl3seeXlzbb3IhzkAKinLLTCe3j3eWJlgwh1RMKUXsBEiuVZzt38Dyq5ZbeiZkoXGPEUlb3NEdzfuk1D+1wrgQHxRqNpjxHRp2l+G5edVhQ9XAHUBQJ52tg8YVh/j/yC0vSit1vyUgAH6dLJPv26cfF1tSe9BU1zgRflxVhy+Gc0BKUBA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8081.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38350700002)(508600001)(6486002)(38100700002)(107886003)(52116002)(1076003)(8936002)(6512007)(36756003)(186003)(316002)(5660300002)(54906003)(6506007)(2616005)(2906002)(26005)(66556008)(66476007)(8676002)(4326008)(83380400001)(66946007)(6666004)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sZ1Qy+amkcDouloXLKI/cz5i7ppnaSb8wcz+A14/u7f98/sDR9zcl0P7ga9F?=
 =?us-ascii?Q?XM6KgZQTCA4SSu6FZfqiG+foIJTwrDSHRIk9s4FIPtbsj5th2OHkRYVgBbzd?=
 =?us-ascii?Q?1KakDxw96cH56AhR5zNIG2f0dIbYbCcsEgAoy7mXLtsX6xEi7hMwmDzDl3um?=
 =?us-ascii?Q?noz6Ju091Y97PEMWHPMtT4YUT0aRc1D7RLUPdQ2p4YHZNkhRAFcA/fAZaP8L?=
 =?us-ascii?Q?P+s05dVRBFn2VA65OVdMjvYXhyxs/z35iT1g4Tv7Bhj+tlHYqO8gnsdl4aSJ?=
 =?us-ascii?Q?IWz6+K6TIo1z0UTIyjNxNL/h0iV7faDNPEJWEx7iAQY5g82cnXxGVLKWaODQ?=
 =?us-ascii?Q?hRyjErNpm59pcBdMDQFU5boYRvswUIEl4758NO2GdhrOp4XURcIQxx4lhzo/?=
 =?us-ascii?Q?R0nLRSDvIoeOpAigYEaMlYYuUKKUPkA9oF10Et2olN7tnZmiYlNd11vlXvrQ?=
 =?us-ascii?Q?4SH2wwV2awHTKHqb2zTNTOIQTvKGSPm9HG+jlWstogKpkCovSwOZBUzXbsBG?=
 =?us-ascii?Q?dY5XuSPc/jRpzI6iznV9NzZNWdFCaUM5umQf/laohBhNKg24czB/xQ2XhFoi?=
 =?us-ascii?Q?5uC6EaKDh1R9lp3WkecQAaco7ph40bocYDuBBGBfzmuzu7Zg0hDq6dw+SHAF?=
 =?us-ascii?Q?0tdg6FfUAU1Q55W7bj2/hr9CSRsuvT83H4z9ApikiSb73CxaVo8kcZsJ7eFE?=
 =?us-ascii?Q?+PRGxB1KzhiRFgL3aQ4lHsfKfUkybinuqVQ9f9wqgEoB8qVA5ZSthLy1+J5A?=
 =?us-ascii?Q?5uFdkDmiUV3t2Q1BgHaxIfTnKkva38q95geQkRVp3ZhpdtKxxTlhpj2noT/S?=
 =?us-ascii?Q?zIZoQZmoOqo2825B/QCgBsfUbH38O5ge7DxcoDAJwM2D++knaXUA84VN6kMS?=
 =?us-ascii?Q?j6pv/xtgIXCyinKQPsL3gZa9DXW0PqmpTy3uRCoV3ciEpuVtpJ3mT5M4r7CG?=
 =?us-ascii?Q?j9rypsYecoCp3Hi8k2P17ngAdhw6Q5lO4qTql8mA/jZ2YI4gJcQ7aGYfSV3V?=
 =?us-ascii?Q?qLFX72p/xYBeYTjOFhH/w5IGf21LZig+ml7fFB6dIn1IUJuZXhiB5v0VQ0Xr?=
 =?us-ascii?Q?jPXRDerf3nHod04Zi3gf3PqtnLw4sNZhYDmsvdsL88d9SEYtd5Oc6uh6i7Ts?=
 =?us-ascii?Q?RSEhkAt6CZTIIFYWf7jJjTzC3eT3tNqtfQFNGfSpNW/Gw1hg+dspeNb09yAM?=
 =?us-ascii?Q?BSLZyVVn/9/qEhamoRyIj0BaGtZF0PEO9sJypt7DG3knivaYygJn0JJXIF4f?=
 =?us-ascii?Q?Q9Vts2JoGFddev3x9pSs+MZ7DxBK5OE0Scm+gYDmQ8uB0bEHoSTdkFYPvKxj?=
 =?us-ascii?Q?v8Pk0mOrRY4hGyJvXp8wYS24P8d++m7Z6mgXPF7BSlTQvbZ/W/MO6JXeHQIX?=
 =?us-ascii?Q?v5aZOd2Vtngo1d6fEyd7hDRaKCWuf825pVtiWUUPMigBJ9D8MCzGvdJCdOHu?=
 =?us-ascii?Q?pD+eQ/hWMa8zALxsM5pZYo6F3gl5x6Y7+YN75WNHUDNsB+x6lL0b8M0LwECm?=
 =?us-ascii?Q?2YdKbxUc+XQUb5UiXUDL3nIqLurhRAdMQIdFnccb9s9ik+Fhym8z0HWerJPr?=
 =?us-ascii?Q?UW/6PiIL++IkweRU+jJVvoH2/mmreCown/3/bavf3vOo4x+85puVXr9x+V2Y?=
 =?us-ascii?Q?2NWOGJoAFevWmjmnA/hgr14=3D?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1e3cadd-77ea-4723-09d0-08d9ea254ad8
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8081.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 10:33:34.3903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CSPch3EXIzVg0CK1yD7ah9qYMzoAZovRbjK7Gr3vN3iJWh1qYRQIt8c+n6MVw2GkIRawWY3Jyl1fwhRyK21grA==
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

Register dummy interrupt handlers for DMA datagrams in preparation for
DMA datagram receive operations.

Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
---
 drivers/misc/vmw_vmci/vmci_guest.c | 42 +++++++++++++++++++++++++++---
 include/linux/vmw_vmci_defs.h      | 14 ++++++++--
 2 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index ced187e7ac08..acef19c562b3 100644
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
@@ -627,8 +641,12 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
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
@@ -666,6 +684,17 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
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
@@ -676,6 +705,8 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 	cmd = VMCI_IMR_DATAGRAM;
 	if (caps_in_use & VMCI_CAPS_NOTIFICATIONS)
 		cmd |= VMCI_IMR_NOTIFICATION;
+	if (caps_in_use & VMCI_CAPS_DMA_DATAGRAM)
+		cmd |= VMCI_IMR_DMA_DATAGRAM;
 	vmci_write_reg(vmci_dev, cmd, VMCI_IMR_ADDR);
 
 	/* Enable interrupts. */
@@ -686,6 +717,8 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 	vmci_call_vsock_callback(false);
 	return 0;
 
+err_free_bm_irq:
+	free_irq(pci_irq_vector(pdev, 1), vmci_dev);
 err_free_irq:
 	free_irq(pci_irq_vector(pdev, 0), vmci_dev);
 	tasklet_kill(&vmci_dev->datagram_tasklet);
@@ -751,8 +784,11 @@ static void vmci_guest_remove_device(struct pci_dev *pdev)
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

