Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B33214A8513
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 14:18:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350748AbiBCNSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 08:18:44 -0500
Received: from mail-bn1nam07on2061.outbound.protection.outlook.com ([40.107.212.61]:24580
        "EHLO NAM02-BN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1350752AbiBCNSY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 08:18:24 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gstoB7+jDGPz9/GA0zhfoRIxsF1gAE4Lec6ptYnAuTQHwV5gqhIorskxxg8hcaIKDoMPsQVi5rrZMT30Y7e5B/gyynd2q3xyUe1GjZbV+e0QSEzE2cQjYmzRX2zJ+hVTeSl9YnEAjLmTyyhoS3+6YkuqBfqE2Y5Jgnd3BHCOKbc80zKbfxMzPTqy+uAHYmDtapvSSD1JEfQPc/kr3swHA104DygB2Hr27FKvsqOTZ8TREYA44ZkblAlKiQ3+jFA9ZY1bySpvj6MFcPW4drT/GwVggpaihMknEPDGb0xDyfRtUOqTzz+qMqajgyR1uAR/3jrQQkM7lo0rAClkM96V9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqaNNrLFEItfAG9TaMhVmhko7hLU/217VuUIGzjMkh4=;
 b=JpCCWW9x95TNiUHtZ20L9H0nsB3YLJkS1PAyNvHPzgnoKORQy04adYcv+RSHDjKpZQ2DAQmGpBoOwX8yh7ZjyefZnPos2Vy+CohuuWpqcj/bdgF7gsKmFudi/AUb4WxGYVwJO+9Hqd31lyJ9M6rrYU+/sy7m/lyHRlFrO+ZCKbZoerxfXe5x+YUrraGYcmVa+ZgatIcGlKkkJboX63Ugo9NvMQZxY9sMIKgGgAHqQqjvJ3LgrtU7LNv4gVMpVjaCLG5rFf9Pu2h2lHH+5OH4nMwVOJBZWvJG9AiIskFqTlJM/QuUjHPSgRkKp6/Ucv1i9ZwxXsnmSPvZuD0Ak5uiUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqaNNrLFEItfAG9TaMhVmhko7hLU/217VuUIGzjMkh4=;
 b=BeZ/EVBtL8yYhu2x9hzW2jWY8zAdqpWmWVN4HhdAcztYKVxencLM2d3DBe2XXWpX/WZmXbEUfhtiCKP8G7U41+ISvuRey+FaT2NnO02Ud/xGy+Mk7l2BzXOvkayMQM9O7+958xMKFqfP7lCFJtYGRagbqkQgYl1GNRb116enS4o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from BY3PR05MB8081.namprd05.prod.outlook.com (2603:10b6:a03:366::15)
 by MN2PR05MB7150.namprd05.prod.outlook.com (2603:10b6:208:18b::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.5; Thu, 3 Feb
 2022 13:18:18 +0000
Received: from BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::304c:2b94:4f26:a581]) by BY3PR05MB8081.namprd05.prod.outlook.com
 ([fe80::304c:2b94:4f26:a581%3]) with mapi id 15.20.4951.012; Thu, 3 Feb 2022
 13:18:18 +0000
From:   Jorgen Hansen <jhansen@vmware.com>
To:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Cc:     gregkh@linuxfoundation.org, pv-drivers@vmware.com,
        Jorgen Hansen <jhansen@vmware.com>,
        Vishnu Dasa <vdasa@vmware.com>
Subject: [PATCH v2 6/8] VMCI: dma dg: allocate send and receive buffers for DMA datagrams
Date:   Thu,  3 Feb 2022 05:12:35 -0800
Message-Id: <20220203131237.3380-7-jhansen@vmware.com>
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
X-MS-Office365-Filtering-Correlation-Id: a3b2594c-ae57-40f4-6967-08d9e717a375
X-MS-TrafficTypeDiagnostic: MN2PR05MB7150:EE_
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-AtpMessageProperties: SA|SL
X-Microsoft-Antispam-PRVS: <MN2PR05MB7150993A0749261B74DAF0BFDA289@MN2PR05MB7150.namprd05.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rbpInloZBwK040l/54yo9SQr0F5j+CPsY8q5w+q/QN532kyu6tBSV+wxB9LaS9zbmPvAwx9TpCKGh7qmPmqiRwo8xFUh3lTAI4DpwU38Rss3rlVQqlypIvL4UBlN8ZnvdSCEFSDDkgR6Mnu4f5HXhFKBM20WPGyCq6CtjfcrXYrZGexOdkYeak7GH/SQjuKQm+aPTuvQ76AAVdJ3uL84xQlDaD7cH+PgXhZV8Ub+/5rC7ErhR9DVYV3i04TVsQFrwJSH4g51ZywCU/MCJ/LPAMFweQI2+KCxtbmZ/pQWQ3wLwQmWsAUANUQYyvIXGsuV6irAejdDwasYBwnUuEiQtKyk+/80tERoDFYyoaIkJBhOGqECrPnbFBtwMARWUdGAFEFIqIN1Jw5YvE2aAfRizmP83NUs0lkthxpknrDHqjTL8b1kkXILoml3CjKh552jxDXtiMwYulyPARvXgYOJTuXba+LdEbbd16IeNmvUmDcLHJs4LKc0qQv587KbvcZj6oBSlFpfYV2N018VChrlFxrvSYsA6i80JSNfajYhtYRKZt/0r53nqIqjsT1ikAuY69Fzp7mIVjLRF53lvS+SILARmB2f68ap6Sy+QlgxFmhMIs5N6FzKeOVwbd0I0OcJ8I2XWI2O/74lePLbMcw1GAbVmWPuMqk4DtYB1q3czBVqdRjl2SGag3psenwCX7YJT154n3DamxQTVQRgLlAN6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY3PR05MB8081.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(8936002)(66556008)(8676002)(66476007)(5660300002)(4326008)(38350700002)(2616005)(52116002)(66946007)(36756003)(38100700002)(186003)(6506007)(26005)(2906002)(1076003)(83380400001)(107886003)(316002)(6666004)(54906003)(86362001)(6512007)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bA7hjOjBSfPBINrscZ5LxevtCfUd2wfaXSWoF26TV5uiqgKtlYKJem5ha+6V?=
 =?us-ascii?Q?n7u9hk0tFAjjGf582K2BS/EymP0/npQrij51OcDveeUXTHgghEU5tf+W27Ww?=
 =?us-ascii?Q?aEv5mKg/KUivlAE38A64Gqu5XPiDwHKKLWELer/noExfVqghnTLqbYsu+DNY?=
 =?us-ascii?Q?/jb85OmyMUbT55ocnj/t3n1RdLiVSf6V0nwqezAxgS3b0BDBzpuGJQsnoETu?=
 =?us-ascii?Q?uR7KTx8TjRH9NvOyXa+QxsKeFnZDBXd6ruqMx8/OiLv4JsyeNDa7+O6e/1v9?=
 =?us-ascii?Q?OHWTUIoELtzB/nhA4Niywf3MqDilCHharMnTBRFmdAmFh6hV6WcxxeFmxbrr?=
 =?us-ascii?Q?U35B4x+nEwpTP8AHHROlZyMUt3sNc3xCQOSCtoZxu+BTj1+TpnMEeG5gRuvS?=
 =?us-ascii?Q?7r+NrIL+H/GfeJcbnX7te0Ddaf/7+2y2gTDZklDDWII2xfcSdj0UmO7M5ZK/?=
 =?us-ascii?Q?KJEwqySaJV/qjM1PpqTbzO+Rqg2DGlc6cpt4MiP0SzdZ0mEVdb5JqoKj3laM?=
 =?us-ascii?Q?POKlflRN7fZvehe3Xvi9pOhHozZDY59U5tPeLbFhnbkaBMMw+cMC6qX4faTV?=
 =?us-ascii?Q?PQeN+5lOx+4zOaEB9C+ykrozTDfsIY0VrcfDx877ImGtXcF7zrGvrUvy6zpH?=
 =?us-ascii?Q?qNOJdXlX7SDDFTF5lXXNsx+EWZfbiy5sr7zfRg6a7UU+ZBkB2+cpaP00+YTq?=
 =?us-ascii?Q?naOeEFhdiBhGG2HsWC4oIU5qJVAbGVtRE30sjW85Wa4ERc+NAT8hitosBDml?=
 =?us-ascii?Q?lsLE/EKaio6p8LwfwhvdEFLi66a1uQ/Aqb9LY9F/08BZu+MtC1zzyClxL6xa?=
 =?us-ascii?Q?z9oAf8x1UfGcDYHbpFCv+dLpaQ0GPz2sxa2oTCHmAUGBx27x9jPgfAwDB1cV?=
 =?us-ascii?Q?3ir6qAxlvG6KDBkOtGUNlVnqy0FNQJZc2cYWvYbzDkHiGR90ClJKqKpZvSfI?=
 =?us-ascii?Q?i4rQqtWyKJhD3eeu1sLYYMJVDtkMHEYRfgikrFsrrhHuLfdcvpQQiqsE5j5b?=
 =?us-ascii?Q?IF5vq71AMfeb1oj6205zPjv5AKZBN22on2Ti9JI0TNVZmq9MOp8nDNakSAKV?=
 =?us-ascii?Q?4AGxEbq9zdfsIk5cmtwr1CjrT2x+SR2h/zBuNrB6P/3SS1Vjz9B9BGjwXJUW?=
 =?us-ascii?Q?XPmLeYOt1LO2i10KE7DpU7xVaWv59TcKHvd8fYHZ9V76i2Wt7q9JINx8IH+i?=
 =?us-ascii?Q?zr9j4/RVI7pNOFIjPsO+iBtr4VN98yDggyYk+8Xojk33ul00mCPtfw0QFWF/?=
 =?us-ascii?Q?c9jhx0Ch/cYmKoMFS4HbS0AgbV65Tu0nJeVXqWKYXbUYBd+g+JBiYTB2DCRY?=
 =?us-ascii?Q?tyJ9NbdV++sETQ5YKTQz2LIjGIa9mqGyTZHgN0nj+wQqXco0RNw5MgBjHXag?=
 =?us-ascii?Q?fRyo0UF5eTAf0lNP7Qy5snNh7/rdcudUrqrQJq5JqI4lwN1K1gFpKFOSKHWk?=
 =?us-ascii?Q?KAkK5yafeookBHKDYy6hbOLr65iwapHwkI8TcPp8uwMWMh/31AbVr5MglNq6?=
 =?us-ascii?Q?ACP5hHR46spiXd4ynzkyxpOI+5z/yVQ5wSqYrB3SVYT96tfngtcrcvOFtnik?=
 =?us-ascii?Q?8yl+L72kboXRSOX7qGfE2k/tcHb+GR6Kr4YnPMgC+VBCD94PDujgAjiKHwLA?=
 =?us-ascii?Q?rAH4DjhHzTffEULtJblompk=3D?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3b2594c-ae57-40f4-6967-08d9e717a375
X-MS-Exchange-CrossTenant-AuthSource: BY3PR05MB8081.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2022 13:18:16.4467
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z4Ni7WW5dcO4/GssJghYl1S1rgxDUtFgqxxLOxF6oObpxz0K1I+n253llO/FpGVYu/v9xAG3lua6CNSbrkiAjA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR05MB7150
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If DMA datagrams are used, allocate send and receive buffers
in coherent DMA memory.

This is done in preparation for the send and receive datagram
operations, where the buffers are used for the exchange of data
between driver and device.

Reviewed-by: Vishnu Dasa <vdasa@vmware.com>
Signed-off-by: Jorgen Hansen <jhansen@vmware.com>
---
 drivers/misc/vmw_vmci/vmci_guest.c | 66 ++++++++++++++++++++++++++----
 include/linux/vmw_vmci_defs.h      |  4 ++
 2 files changed, 63 insertions(+), 7 deletions(-)

diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
index 0920fbc6b64f..c207ca2ca42e 100644
--- a/drivers/misc/vmw_vmci/vmci_guest.c
+++ b/drivers/misc/vmw_vmci/vmci_guest.c
@@ -31,6 +31,12 @@
 
 #define VMCI_UTIL_NUM_RESOURCES 1
 
+/*
+ * Datagram buffers for DMA send/receive must accommodate at least
+ * a maximum sized datagram and the header.
+ */
+#define VMCI_DMA_DG_BUFFER_SIZE (VMCI_MAX_DG_SIZE + PAGE_SIZE)
+
 static bool vmci_disable_msi;
 module_param_named(disable_msi, vmci_disable_msi, bool, 0);
 MODULE_PARM_DESC(disable_msi, "Disable MSI use in driver - (default=0)");
@@ -53,6 +59,9 @@ struct vmci_guest_device {
 	struct tasklet_struct bm_tasklet;
 
 	void *data_buffer;
+	dma_addr_t data_buffer_base;
+	void *tx_buffer;
+	dma_addr_t tx_buffer_base;
 	void *notification_bitmap;
 	dma_addr_t notification_base;
 };
@@ -451,6 +460,24 @@ static irqreturn_t vmci_interrupt_dma_datagram(int irq, void *_dev)
 	return IRQ_HANDLED;
 }
 
+static void vmci_free_dg_buffers(struct vmci_guest_device *vmci_dev)
+{
+	if (vmci_dev->mmio_base != NULL) {
+		if (vmci_dev->tx_buffer != NULL)
+			dma_free_coherent(vmci_dev->dev,
+					  VMCI_DMA_DG_BUFFER_SIZE,
+					  vmci_dev->tx_buffer,
+					  vmci_dev->tx_buffer_base);
+		if (vmci_dev->data_buffer != NULL)
+			dma_free_coherent(vmci_dev->dev,
+					  VMCI_DMA_DG_BUFFER_SIZE,
+					  vmci_dev->data_buffer,
+					  vmci_dev->data_buffer_base);
+	} else {
+		vfree(vmci_dev->data_buffer);
+	}
+}
+
 /*
  * Most of the initialization at module load time is done here.
  */
@@ -520,11 +547,27 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 	tasklet_init(&vmci_dev->bm_tasklet,
 		     vmci_process_bitmap, (unsigned long)vmci_dev);
 
-	vmci_dev->data_buffer = vmalloc(VMCI_MAX_DG_SIZE);
+	if (mmio_base != NULL) {
+		vmci_dev->tx_buffer = dma_alloc_coherent(&pdev->dev, VMCI_DMA_DG_BUFFER_SIZE,
+							 &vmci_dev->tx_buffer_base,
+							 GFP_KERNEL);
+		if (!vmci_dev->tx_buffer) {
+			dev_err(&pdev->dev,
+				"Can't allocate memory for datagram tx buffer\n");
+			return -ENOMEM;
+		}
+
+		vmci_dev->data_buffer = dma_alloc_coherent(&pdev->dev, VMCI_DMA_DG_BUFFER_SIZE,
+							   &vmci_dev->data_buffer_base,
+							   GFP_KERNEL);
+	} else {
+		vmci_dev->data_buffer = vmalloc(VMCI_MAX_DG_SIZE);
+	}
 	if (!vmci_dev->data_buffer) {
 		dev_err(&pdev->dev,
 			"Can't allocate memory for datagram buffer\n");
-		return -ENOMEM;
+		error = -ENOMEM;
+		goto err_free_data_buffers;
 	}
 
 	pci_set_master(pdev);	/* To enable queue_pair functionality. */
@@ -542,7 +585,7 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 	if (!(capabilities & VMCI_CAPS_DATAGRAM)) {
 		dev_err(&pdev->dev, "Device does not support datagrams\n");
 		error = -ENXIO;
-		goto err_free_data_buffer;
+		goto err_free_data_buffers;
 	}
 	caps_in_use = VMCI_CAPS_DATAGRAM;
 
@@ -586,7 +629,7 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 			dev_err(&pdev->dev,
 				"Missing capability: VMCI_CAPS_DMA_DATAGRAM\n");
 			error = -ENXIO;
-			goto err_free_data_buffer;
+			goto err_free_data_buffers;
 		}
 	}
 
@@ -602,6 +645,12 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 		vmci_write_reg(vmci_dev, PAGE_SHIFT, VMCI_GUEST_PAGE_SHIFT);
 		page_shift = vmci_read_reg(vmci_dev, VMCI_GUEST_PAGE_SHIFT);
 		dev_info(&pdev->dev, "Using page shift %d\n", page_shift);
+
+		/* Configure the high order parts of the data in/out buffers. */
+		vmci_write_reg(vmci_dev, upper_32_bits(vmci_dev->data_buffer_base),
+			       VMCI_DATA_IN_HIGH_ADDR);
+		vmci_write_reg(vmci_dev, upper_32_bits(vmci_dev->tx_buffer_base),
+			       VMCI_DATA_OUT_HIGH_ADDR);
 	}
 
 	/* Set up global device so that we can start sending datagrams */
@@ -755,8 +804,8 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
 	vmci_dev_g = NULL;
 	spin_unlock_irq(&vmci_dev_spinlock);
 
-err_free_data_buffer:
-	vfree(vmci_dev->data_buffer);
+err_free_data_buffers:
+	vmci_free_dg_buffers(vmci_dev);
 
 	/* The rest are managed resources and will be freed by PCI core */
 	return error;
@@ -814,7 +863,10 @@ static void vmci_guest_remove_device(struct pci_dev *pdev)
 				  vmci_dev->notification_base);
 	}
 
-	vfree(vmci_dev->data_buffer);
+	vmci_free_dg_buffers(vmci_dev);
+
+	if (vmci_dev->mmio_base != NULL)
+		pci_iounmap(pdev, vmci_dev->mmio_base);
 
 	/* The rest are managed resources and will be freed by PCI core */
 }
diff --git a/include/linux/vmw_vmci_defs.h b/include/linux/vmw_vmci_defs.h
index 2b70c024dacb..8bc37d8244a8 100644
--- a/include/linux/vmw_vmci_defs.h
+++ b/include/linux/vmw_vmci_defs.h
@@ -21,6 +21,10 @@
 #define VMCI_CAPS_ADDR          0x18
 #define VMCI_RESULT_LOW_ADDR    0x1c
 #define VMCI_RESULT_HIGH_ADDR   0x20
+#define VMCI_DATA_OUT_LOW_ADDR  0x24
+#define VMCI_DATA_OUT_HIGH_ADDR 0x28
+#define VMCI_DATA_IN_LOW_ADDR   0x2c
+#define VMCI_DATA_IN_HIGH_ADDR  0x30
 #define VMCI_GUEST_PAGE_SHIFT   0x34
 
 /* Max number of devices. */
-- 
2.25.1

